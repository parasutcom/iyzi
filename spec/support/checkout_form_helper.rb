module CheckoutFormHelper
  def create_item(options = {})
    {
      'id'        => options[:id] || 'BI102',
      'name'      => options[:name] || 'Game code',
      'category1' => options[:category1] || 'Game',
      'category2' => options[:category2] || 'Online Game Items',
      'itemType'  => options[:item_type] || 'VIRTUAL',
      'price'     => options[:price] || '1'
    }
  end
end
