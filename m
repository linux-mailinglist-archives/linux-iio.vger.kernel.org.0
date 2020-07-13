Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE91121D4BF
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 13:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgGMLWC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 07:22:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728714AbgGMLWC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jul 2020 07:22:02 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 4C048F8E669C5B3A3A06;
        Mon, 13 Jul 2020 12:22:00 +0100 (IST)
Received: from localhost (10.52.126.116) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 13 Jul
 2020 12:21:59 +0100
Date:   Mon, 13 Jul 2020 12:20:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "contact@artur-rojek.eu" <contact@artur-rojek.eu>,
        "ezequiel@vanguardiasur.com.ar" <ezequiel@vanguardiasur.com.ar>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "paul@crapouillou.net" <paul@crapouillou.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v8 2/6] IIO: Ingenic JZ47xx: Error check clk_enable
 calls.
Message-ID: <20200713122052.0000232e@Huawei.com>
In-Reply-To: <526dc4337ce1b5fcac94923c2b5533852a7b2739.camel@analog.com>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
        <20200709152200.10039-3-contact@artur-rojek.eu>
        <20200712130222.76bf32ed@archlinux>
        <526dc4337ce1b5fcac94923c2b5533852a7b2739.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.116]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jul 2020 05:07:44 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2020-07-12 at 13:02 +0100, Jonathan Cameron wrote:
> > On Thu,  9 Jul 2020 17:21:56 +0200
> > Artur Rojek <contact@artur-rojek.eu> wrote:
> >   
> > > Introduce error checks for the clk_enable calls used in this driver.
> > > As part of the changes, move clk_enable/clk_disable calls out of
> > > ingenic_adc_set_config and into respective logic of its callers.
> > > 
> > > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> > > Tested-by: Paul Cercueil <paul@crapouillou.net>  
> > Applied.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > > 
> > >  Changes:
> > > 
> > >  v6: new patch
> > > 
> > >  v7: no change
> > > 
> > >  v8: move `clk_disable` outside the lock
> > > 
> > >  drivers/iio/adc/ingenic-adc.c | 25 +++++++++++++++++++++----
> > >  1 file changed, 21 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-
> > > adc.c
> > > index 39c0a609fc94..c1946a9f1cca 100644
> > > --- a/drivers/iio/adc/ingenic-adc.c
> > > +++ b/drivers/iio/adc/ingenic-adc.c
> > > @@ -73,7 +73,6 @@ static void ingenic_adc_set_config(struct ingenic_adc
> > > *adc,
> > >  {
> > >  	uint32_t cfg;
> > >  
> > > -	clk_enable(adc->clk);
> > >  	mutex_lock(&adc->lock);
> > >  
> > >  	cfg = readl(adc->base + JZ_ADC_REG_CFG) & ~mask;
> > > @@ -81,7 +80,6 @@ static void ingenic_adc_set_config(struct ingenic_adc
> > > *adc,
> > >  	writel(cfg, adc->base + JZ_ADC_REG_CFG);
> > >  
> > >  	mutex_unlock(&adc->lock);
> > > -	clk_disable(adc->clk);
> > >  }
> > >  
> > >  static void ingenic_adc_enable(struct ingenic_adc *adc,
> > > @@ -124,6 +122,8 @@ static int ingenic_adc_write_raw(struct iio_dev
> > > *iio_dev,
> > >  				 long m)
> > >  {
> > >  	struct ingenic_adc *adc = iio_priv(iio_dev);
> > > +	struct device *dev = iio_dev->dev.parent;
> > > +	int ret;
> > >  
> > >  	switch (m) {
> > >  	case IIO_CHAN_INFO_SCALE:
> > > @@ -131,6 +131,14 @@ static int ingenic_adc_write_raw(struct iio_dev
> > > *iio_dev,
> > >  		case INGENIC_ADC_BATTERY:
> > >  			if (!adc->soc_data->battery_vref_mode)
> > >  				return -EINVAL;
> > > +
> > > +			ret = clk_enable(adc->clk);
> > > +			if (ret) {
> > > +				dev_err(dev, "Failed to enable clock:
> > > %d\n",
> > > +					ret);
> > > +				return ret;
> > > +			}
> > > +
> > >  			if (val > JZ_ADC_BATTERY_LOW_VREF) {
> > >  				ingenic_adc_set_config(adc,
> > >  						       JZ_ADC_REG_CFG_BAT_M
> > > D,
> > > @@ -142,6 +150,9 @@ static int ingenic_adc_write_raw(struct iio_dev
> > > *iio_dev,
> > >  						       JZ_ADC_REG_CFG_BAT_M
> > > D);
> > >  				adc->low_vref_mode = true;
> > >  			}
> > > +
> > > +			clk_disable(adc->clk);
> > > +
> > >  			return 0;
> > >  		default:
> > >  			return -EINVAL;
> > > @@ -317,6 +328,13 @@ static int ingenic_adc_read_chan_info_raw(struct
> > > ingenic_adc *adc,
> > >  					  int *val)
> > >  {
> > >  	int bit, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
> > > +	struct device *dev = iio_priv_to_dev(adc)->dev.parent;  
> 
> This uses iio_priv_to_dev(), which should be removed [if it hasn't been
> already].

Gah I missed that. 
For now best bet is probably if I drop this series from here on until we have
this tidied up in a v9.  Its my fault as I messed up and lost one patch in
the middle of Alex's series somehow, hence it is still there but broken in
the tree.

Thanks.

Jonathan

> Also, with the iio_dev_opaque struct/type, using the iio_priv_to_dev()
> helper shouldn't work, or should give undefined behavior, as the offset to
> the private data should be matched against iio_dev_opaque (and not
> iio_dev).
> 
> Looking at this code, it looks like ingenic_adc_read_chan_info_raw() can
> take an 'indio_dev' reference and obtain the private information via
> iio_priv()
> 
> Maybe [for some] there's a question as to why iio_priv_to_dev() is being
> removed.
> The answer is: because the iio_dev_opaque struct/type was introduced to
> hide some iio_dev [INTERN] fields; the main reason for hiding them [aside
> from good coding practice, and because they belong to the IIO framework] is
> to not have to review new drivers being copied/adapted from old drivers.
> 
> Naturally, the iio_priv_to_dev() could have been kept around [in a reworked
> form], but it didn't make much sense, since most users of iio_priv_to_dev()
> could access a reference to indio_dev without much/any hassle.
> 
> > > +
> > > +	ret = clk_enable(adc->clk);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to enable clock: %d\n", ret);
> > > +		return ret;
> > > +	}
> > >  
> > >  	/* We cannot sample AUX/AUX2 in parallel. */
> > >  	mutex_lock(&adc->aux_lock);
> > > @@ -325,7 +343,6 @@ static int ingenic_adc_read_chan_info_raw(struct
> > > ingenic_adc *adc,
> > >  		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, bit);
> > >  	}
> > >  
> > > -	clk_enable(adc->clk);
> > >  	ret = ingenic_adc_capture(adc, engine);
> > >  	if (ret)
> > >  		goto out;
> > > @@ -342,8 +359,8 @@ static int ingenic_adc_read_chan_info_raw(struct
> > > ingenic_adc *adc,
> > >  
> > >  	ret = IIO_VAL_INT;
> > >  out:
> > > -	clk_disable(adc->clk);
> > >  	mutex_unlock(&adc->aux_lock);
> > > +	clk_disable(adc->clk);
> > >  
> > >  	return ret;
> > >  }  


