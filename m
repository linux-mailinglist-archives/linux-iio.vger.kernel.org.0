Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C743F3DEE3A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhHCMwH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 08:52:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3572 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhHCMwG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 08:52:06 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GfFB83cX2z6GD14;
        Tue,  3 Aug 2021 20:51:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 3 Aug 2021 14:51:54 +0200
Received: from localhost (10.210.169.87) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 3 Aug 2021
 13:51:53 +0100
Date:   Tue, 3 Aug 2021 13:51:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Wu <david.wu@rock-chips.com>
CC:     Simon Xue <xxm@rock-chips.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-rockchip@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: rockchip_saradc: just get referenced voltage
 once at probe
Message-ID: <20210803135124.000072fe@Huawei.com>
In-Reply-To: <36f6284f-6bc9-d5a4-aac8-5db8b1ecaae1@rock-chips.com>
References: <20210802090929.37970-1-xxm@rock-chips.com>
        <20210802114222.00004f3d@Huawei.com>
        <36f6284f-6bc9-d5a4-aac8-5db8b1ecaae1@rock-chips.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.169.87]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Aug 2021 11:09:47 +0800
David Wu <david.wu@rock-chips.com> wrote:

> Hi Jonathan,
> 
> ÔÚ 2021/8/2 ÏÂÎç6:42, Jonathan Cameron Ð´µÀ:
> > On Mon, 2 Aug 2021 17:09:29 +0800
> > Simon Xue <xxm@rock-chips.com> wrote:
> >   
> >> From: David Wu <david.wu@rock-chips.com>
> >>
> >> The referenced voltage is not changed after initiation, so just only
> >> get referenced voltage once.  
> > Hi David,
> > 
> > Isn't this an external reference voltage?  If so how do you know
> > it is not changed at runtime?  It might be unlikely and not happen
> > on particular platforms, but that's not he same as saying it can never
> > happen.  Clearly it's racey anyway if that does happen, but we definitely
> > don't expect frequent voltage changes.
> >   
> 
> The current regulator is not changed and not subject to external 
> changes, this can reduce the getting voltage. Assuming that there will 
> be changes in the future, we then add the notify of the regulator, so 
> that the voltage change can be obtained.

If this patch added the notifier that would be a nice solution, but
right now it potentially introduced a regression. You have made me a little curious...
Are you seeing a significant cost to querying that regulator voltage?
If so, I'd imagine it's a lack of caching in the regulator driver or similar.
Scale readback via sysfs shouldn't be in a fast path anyway.

You can't depend on what boards today do, because someone with a board
built tomorrow may well use an old kernel which supports the voltage
changing, and then see a regression when they upgrade to the kernel
containing this patch.

Jonathan

> 
> > Jonathan
> >   
> >>
> >> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> >> Signed-off-by: David Wu <david.wu@rock-chips.com>
> >> ---
> >>   drivers/iio/adc/rockchip_saradc.c | 16 +++++++++-------
> >>   1 file changed, 9 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> >> index f3eb8d2e50dc..cd33c0b9d3eb 100644
> >> --- a/drivers/iio/adc/rockchip_saradc.c
> >> +++ b/drivers/iio/adc/rockchip_saradc.c
> >> @@ -49,6 +49,7 @@ struct rockchip_saradc {
> >>   	struct clk		*clk;
> >>   	struct completion	completion;
> >>   	struct regulator	*vref;
> >> +	int			uv_vref;
> >>   	struct reset_control	*reset;
> >>   	const struct rockchip_saradc_data *data;
> >>   	u16			last_val;
> >> @@ -105,13 +106,7 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
> >>   		mutex_unlock(&indio_dev->mlock);
> >>   		return IIO_VAL_INT;
> >>   	case IIO_CHAN_INFO_SCALE:
> >> -		ret = regulator_get_voltage(info->vref);
> >> -		if (ret < 0) {
> >> -			dev_err(&indio_dev->dev, "failed to get voltage\n");
> >> -			return ret;
> >> -		}
> >> -
> >> -		*val = ret / 1000;
> >> +		*val = info->uv_vref / 1000;
> >>   		*val2 = chan->scan_type.realbits;
> >>   		return IIO_VAL_FRACTIONAL_LOG2;
> >>   	default:
> >> @@ -410,6 +405,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
> >>   		return ret;
> >>   	}
> >>   
> >> +	info->uv_vref = regulator_get_voltage(info->vref);
> >> +	if (info->uv_vref < 0) {
> >> +		dev_err(&pdev->dev, "failed to get voltage\n");
> >> +		ret = info->uv_vref;
> >> +		return ret;
> >> +	}
> >> +
> >>   	ret = clk_prepare_enable(info->pclk);
> >>   	if (ret < 0) {
> >>   		dev_err(&pdev->dev, "failed to enable pclk\n");  
> > 
> > 
> > 
> >   
> 
> 

