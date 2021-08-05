Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36C23E146F
	for <lists+linux-iio@lfdr.de>; Thu,  5 Aug 2021 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbhHEMHe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 5 Aug 2021 08:07:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55882 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232222AbhHEMHe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Aug 2021 08:07:34 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mBc9S-0006hh-QB; Thu, 05 Aug 2021 14:07:06 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Wu <david.wu@rock-chips.com>
Cc:     Simon Xue <xxm@rock-chips.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rockchip_saradc: just get referenced voltage once at probe
Date:   Thu, 05 Aug 2021 14:07:05 +0200
Message-ID: <8912224.VV5PYv0bhD@diego>
In-Reply-To: <8f5385a1-701c-4446-d238-90bee1c03675@rock-chips.com>
References: <20210802090929.37970-1-xxm@rock-chips.com> <20210803135124.000072fe@Huawei.com> <8f5385a1-701c-4446-d238-90bee1c03675@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi David,

Am Donnerstag, 5. August 2021, 13:56:18 CEST schrieb David Wu:
> Hi Jonathan,
> 
> 在 2021/8/3 下午8:51, Jonathan Cameron 写道:
> > On Tue, 3 Aug 2021 11:09:47 +0800
> > David Wu <david.wu@rock-chips.com> wrote:
> > 
> >> Hi Jonathan,
> >>
> >> 在 2021/8/2 下午6:42, Jonathan Cameron 写道:
> >>> On Mon, 2 Aug 2021 17:09:29 +0800
> >>> Simon Xue <xxm@rock-chips.com> wrote:
> >>>    
> >>>> From: David Wu <david.wu@rock-chips.com>
> >>>>
> >>>> The referenced voltage is not changed after initiation, so just only
> >>>> get referenced voltage once.
> >>> Hi David,
> >>>
> >>> Isn't this an external reference voltage?  If so how do you know
> >>> it is not changed at runtime?  It might be unlikely and not happen
> >>> on particular platforms, but that's not he same as saying it can never
> >>> happen.  Clearly it's racey anyway if that does happen, but we definitely
> >>> don't expect frequent voltage changes.
> >>>    
> >>
> >> The current regulator is not changed and not subject to external
> >> changes, this can reduce the getting voltage. Assuming that there will
> >> be changes in the future, we then add the notify of the regulator, so
> >> that the voltage change can be obtained.
> > 
> > If this patch added the notifier that would be a nice solution, but
> > right now it potentially introduced a regression. You have made me a little curious...
> > Are you seeing a significant cost to querying that regulator voltage?
> > If so, I'd imagine it's a lack of caching in the regulator driver or similar.
> > Scale readback via sysfs shouldn't be in a fast path anyway.
> > 
> > You can't depend on what boards today do, because someone with a board
> > built tomorrow may well use an old kernel which supports the voltage
> > changing, and then see a regression when they upgrade to the kernel
> > containing this patch.
> > 
> 
> For all current chips, the expected voltage is a fixed voltage, and 
> don't want to change it in any process.:-)
> 
> So, if the voltage here does not change, then it can be obtained once in 
> probe(), which can save the time of each acquisition. For example, the 
> voltage of this regulator is obtained through i2c, which will increase 
> some consumption every time.

Jonathans request was to not think about "all current chips" but the
general case, and as Jonathan said, adding that regulator notifier you
already mentioned would be the nicest solution.

So I think the easiest way is to just add the voltage notifier to your patch
to make everyone happy ;-) .


Heiko

> 
> > Jonathan
> > 
> >>
> >>> Jonathan
> >>>    
> >>>>
> >>>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> >>>> Signed-off-by: David Wu <david.wu@rock-chips.com>
> >>>> ---
> >>>>    drivers/iio/adc/rockchip_saradc.c | 16 +++++++++-------
> >>>>    1 file changed, 9 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> >>>> index f3eb8d2e50dc..cd33c0b9d3eb 100644
> >>>> --- a/drivers/iio/adc/rockchip_saradc.c
> >>>> +++ b/drivers/iio/adc/rockchip_saradc.c
> >>>> @@ -49,6 +49,7 @@ struct rockchip_saradc {
> >>>>    	struct clk		*clk;
> >>>>    	struct completion	completion;
> >>>>    	struct regulator	*vref;
> >>>> +	int			uv_vref;
> >>>>    	struct reset_control	*reset;
> >>>>    	const struct rockchip_saradc_data *data;
> >>>>    	u16			last_val;
> >>>> @@ -105,13 +106,7 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
> >>>>    		mutex_unlock(&indio_dev->mlock);
> >>>>    		return IIO_VAL_INT;
> >>>>    	case IIO_CHAN_INFO_SCALE:
> >>>> -		ret = regulator_get_voltage(info->vref);
> >>>> -		if (ret < 0) {
> >>>> -			dev_err(&indio_dev->dev, "failed to get voltage\n");
> >>>> -			return ret;
> >>>> -		}
> >>>> -
> >>>> -		*val = ret / 1000;
> >>>> +		*val = info->uv_vref / 1000;
> >>>>    		*val2 = chan->scan_type.realbits;
> >>>>    		return IIO_VAL_FRACTIONAL_LOG2;
> >>>>    	default:
> >>>> @@ -410,6 +405,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
> >>>>    		return ret;
> >>>>    	}
> >>>>    
> >>>> +	info->uv_vref = regulator_get_voltage(info->vref);
> >>>> +	if (info->uv_vref < 0) {
> >>>> +		dev_err(&pdev->dev, "failed to get voltage\n");
> >>>> +		ret = info->uv_vref;
> >>>> +		return ret;
> >>>> +	}
> >>>> +
> >>>>    	ret = clk_prepare_enable(info->pclk);
> >>>>    	if (ret < 0) {
> >>>>    		dev_err(&pdev->dev, "failed to enable pclk\n");
> >>>
> >>>
> >>>
> >>>    
> >>
> >>
> > 
> > 
> > 
> > 
> 
> 
> 




