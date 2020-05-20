Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8301DABCF
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgETHR5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 03:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETHR4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 03:17:56 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F38C061A0E;
        Wed, 20 May 2020 00:17:56 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n22so1756648qtv.12;
        Wed, 20 May 2020 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cRb4g7uWIcJzgz/gEYbg+sLqgvX9jLQo+kvXuNT0x7A=;
        b=EuzhEGG67IF6JeidFZDv9ufHv4lfWGMUDJBZKfweGshi6UmchJylFI+pf3QjBOICUm
         OR5ozsANiLg8LfvaaCsN4lRydJnpQYueklNpTSd7aP7tRHgybPVnsJrt8J9Da/W+OlIe
         53uWEf+5fveTGfIwAexsS8eHq7gdB+l7YZK46N8jt/H59WngU3gXJckspqx9/iVAFbf8
         J+k65txZIe911xwhVA4IeeTBkG2y6Fg/YQ2gml6m0U+xFpIChU/T2GIIOwI1Fk9CHtoz
         zd8nalpt5NsSmOh6aWQ6T62EGktEpBEljl21wgCcCp/PtDhpppN5JfZGS464ZKOvgX+v
         lloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cRb4g7uWIcJzgz/gEYbg+sLqgvX9jLQo+kvXuNT0x7A=;
        b=H3KL2aF8UwSh6wAriKqty+N41fyC+m97p1TU0TSllojHz67My2Cz5lGKuG5LSy12Sz
         MGnwrwJWWrq1doWrh7aGgccENmm1U9knWDdGp/AnQeHvIssBsITnB3K2pJa/WHEalfQ0
         zpG6O2wU/aTxYjawLGlWyiaa9pwN1LPI4i2TA19pYRJB9WlR+lP3FjFLxWIr3l+Rqn6N
         SUcDc09Cm25u5t9OC7EyCME56a3qHgUvTSR8K/TExedb1V7yP8unjgaCJ18uL5kpVM9y
         +70t42DWra24tcouj+DjBsmA0JX7hB5NzIVnc93uTPZxd0di5Gjwxq6oQwEhUB8UQnep
         YIcw==
X-Gm-Message-State: AOAM533GRDr25Xr2DoYQaqmCP1SVD/ekRMsYm0AY/OgwTTEFwN1X1HZI
        5uM26/nSAa8QhvIDVsxexLw=
X-Google-Smtp-Source: ABdhPJzYO9e27+mYalRAtFoh6mzIvgPlyHTp4bcIoB7azAWQI6SEHIlPnTuzZfYQuKzyifHUoqj7zQ==
X-Received: by 2002:aed:221d:: with SMTP id n29mr3862549qtc.286.1589959075564;
        Wed, 20 May 2020 00:17:55 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id b136sm1568161qkg.86.2020.05.20.00.17.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 00:17:54 -0700 (PDT)
Date:   Wed, 20 May 2020 09:17:51 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 3/4] iio: imu: bmi160: added regulator support
Message-ID: <20200520071751.GD3361@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-4-jonathan.albrieux@gmail.com>
 <20200519185535.00003cb7@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519185535.00003cb7@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 06:55:35PM +0100, Jonathan Cameron wrote:
> On Tue, 19 May 2020 09:50:59 +0200
> Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> 
> > v2: fixed missing description
> 
> Don't put change log here....

Yep I will put it in the cover letter

> > 
> > Add vdd-supply and vddio-supply support. Without this support vdd and vddio
> > should be set to always-on in device tree
> 
> Kind of the opposite.  If they are always on we don't have to provide them
> in the device tree.
> 

I wrote that because, testing on msm8916, without setting the regulators to
always on they were controlled by other components and it happened that
the line wasn't ready during probe causing failure to load the module.

I will try to reword based on your comment, thank you.

> A few trivial things inline.
> 
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > ---
> 
> Change log goes here so we don't end up keeping it in the git log.
> 
> >  drivers/iio/imu/bmi160/bmi160.h      |  2 ++
> >  drivers/iio/imu/bmi160/bmi160_core.c | 27 ++++++++++++++++++++++++++-
> >  2 files changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> > index 621f5309d735..923c3b274fde 100644
> > --- a/drivers/iio/imu/bmi160/bmi160.h
> > +++ b/drivers/iio/imu/bmi160/bmi160.h
> > @@ -3,10 +3,12 @@
> >  #define BMI160_H_
> >  
> >  #include <linux/iio/iio.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  struct bmi160_data {
> >  	struct regmap *regmap;
> >  	struct iio_trigger *trig;
> > +	struct regulator_bulk_data supplies[2];
> >  };
> >  
> >  extern const struct regmap_config bmi160_regmap_config;
> > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> > index 6af65d6f1d28..9bbe0d8e6720 100644
> > --- a/drivers/iio/imu/bmi160/bmi160_core.c
> > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/irq.h>
> >  #include <linux/of_irq.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/triggered_buffer.h>
> > @@ -709,6 +710,12 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> >  	unsigned int val;
> >  	struct device *dev = regmap_get_device(data->regmap);
> >  
> > +	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> >  	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
> >  	if (ret)
> >  		return ret;
> > @@ -793,9 +800,17 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
> >  static void bmi160_chip_uninit(void *data)
> >  {
> >  	struct bmi160_data *bmi_data = data;
> > +	struct device *dev = regmap_get_device(bmi_data->regmap);
> > +	int ret;
> >  
> >  	bmi160_set_mode(bmi_data, BMI160_GYRO, false);
> >  	bmi160_set_mode(bmi_data, BMI160_ACCEL, false);
> > +
> > +	ret = regulator_bulk_disable(ARRAY_SIZE(bmi_data->supplies),
> > +				     bmi_data->supplies);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to disable regulators: %d\n", ret);
> > +	}
> No need for brackets around a 1 line if block
> 

Thank you, I didn't noticed that :-)

> 	if (ret)
> 		dev_err(dev, "failed to disable regulators: %d\n", ret);
> 
> >  }
> >  
> >  int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> > @@ -815,6 +830,16 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> >  	dev_set_drvdata(dev, indio_dev);
> >  	data->regmap = regmap;
> >  
> > +	data->supplies[0].supply = "vdd";
> > +	data->supplies[1].supply = "vddio";
> > +	ret = devm_regulator_bulk_get(dev,
> > +				      ARRAY_SIZE(data->supplies),
> > +				      data->supplies);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to get regulators: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> >  	ret = bmi160_chip_init(data, use_spi);
> >  	if (ret)
> >  		return ret;
> > @@ -853,6 +878,6 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> >  }
> >  EXPORT_SYMBOL_GPL(bmi160_core_probe);
> >  
> > -MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
> > +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
> 
> Good fix but shouldn't be in this patch.   Put it a separate patch on it's own.
> 

Ok will separate this fix into another patch, thank you!

> >  MODULE_DESCRIPTION("Bosch BMI160 driver");
> >  MODULE_LICENSE("GPL v2");
> 
> 

Best regards,
Jonathan Albrieux
