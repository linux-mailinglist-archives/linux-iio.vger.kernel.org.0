Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D41212A52
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jul 2020 18:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGBQvI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jul 2020 12:51:08 -0400
Received: from foss.arm.com ([217.140.110.172]:43094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgGBQvH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 2 Jul 2020 12:51:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E9D11FB;
        Thu,  2 Jul 2020 09:51:07 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 772803F71E;
        Thu,  2 Jul 2020 09:51:05 -0700 (PDT)
Subject: Re: [PATCH RFT] iio: adc: xilinx-xadc: use devm_krealloc()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200702162509.11254-1-brgl@bgdev.pl>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b3456494-ce89-f981-a76e-fcb1b252a0bd@arm.com>
Date:   Thu, 2 Jul 2020 17:51:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702162509.11254-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-07-02 17:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Use the managed variant of krealloc() and shrink the code a bit.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> NOTE: this patch depends on the series adding devm_krealloc() which is
> not yet accepted.
> 
> Greg,
> 
> here's just a quick example of a second user of devm_krealloc(). This time
> we're reallocing memory allocated with devm_kmemdup(). Hopefully this is
> enough to prove this helper is useful enough to merge it.

Ooh, interesting - I also had to open-code an effective devm_krealloc() 
to subclass an devres-managed allocation in cavium_smmu_impl_init() 
(drivers/iommu/arm-smmu-impl.c), and we've got patches in-flight for 
another SMMU quirk that wants to follow the same pattern. I'd gladly 
have the extra clarity of a proper helper (and save a couple of lines) 
for those cases as well.

Robin.

> I can't test it due to lack of HW though.
> 
>   drivers/iio/adc/xilinx-xadc-core.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index d7fecab9252e..5bdbe502e983 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1094,6 +1094,7 @@ MODULE_DEVICE_TABLE(of, xadc_of_match_table);
>   static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>   	unsigned int *conf)
>   {
> +	struct device *dev = indio_dev->dev.parent;
>   	struct xadc *xadc = iio_priv(indio_dev);
>   	struct iio_chan_spec *channels, *chan;
>   	struct device_node *chan_node, *child;
> @@ -1138,7 +1139,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>   		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
>   	}
>   
> -	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
> +	channels = devm_kmemdup(dev, xadc_channels,
> +				sizeof(xadc_channels), GFP_KERNEL);
>   	if (!channels)
>   		return -ENOMEM;
>   
> @@ -1174,8 +1176,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>   	of_node_put(chan_node);
>   
>   	indio_dev->num_channels = num_channels;
> -	indio_dev->channels = krealloc(channels, sizeof(*channels) *
> -					num_channels, GFP_KERNEL);
> +	indio_dev->channels = devm_krealloc(dev, channels,
> +					    sizeof(*channels) * num_channels,
> +					    GFP_KERNEL);
>   	/* If we can't resize the channels array, just use the original */
>   	if (!indio_dev->channels)
>   		indio_dev->channels = channels;
> @@ -1229,14 +1232,14 @@ static int xadc_probe(struct platform_device *pdev)
>   
>   	ret = xadc_parse_dt(indio_dev, pdev->dev.of_node, &conf0);
>   	if (ret)
> -		goto err_device_free;
> +		return ret;
>   
>   	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
>   		ret = iio_triggered_buffer_setup(indio_dev,
>   			&iio_pollfunc_store_time, &xadc_trigger_handler,
>   			&xadc_buffer_ops);
>   		if (ret)
> -			goto err_device_free;
> +			return ret;
>   
>   		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
>   		if (IS_ERR(xadc->convst_trigger)) {
> @@ -1354,8 +1357,6 @@ static int xadc_probe(struct platform_device *pdev)
>   err_triggered_buffer_cleanup:
>   	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
>   		iio_triggered_buffer_cleanup(indio_dev);
> -err_device_free:
> -	kfree(indio_dev->channels);
>   
>   	return ret;
>   }
> @@ -1375,7 +1376,6 @@ static int xadc_remove(struct platform_device *pdev)
>   	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
>   	clk_disable_unprepare(xadc->clk);
>   	kfree(xadc->data);
> -	kfree(indio_dev->channels);
>   
>   	return 0;
>   }
> 
