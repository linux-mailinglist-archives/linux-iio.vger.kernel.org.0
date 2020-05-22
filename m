Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53BD1DE1C1
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgEVIZS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 04:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgEVIZR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 04:25:17 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE79BC061A0E;
        Fri, 22 May 2020 01:25:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v4so7699300qte.3;
        Fri, 22 May 2020 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XJsKRH19vB/cGeqHjSkLUZnV1D50ZWfC9CxNYPIMtuY=;
        b=WT1eooU+uX39YaJnVBfcBwibdNR0GBbXNZ7UxW9dkBnZ6uo3Z8NAuBoJ/KLlGMvLuk
         /FpXarQmNwRs2mMpODVT5yjKfleiByaCbuVk3bHQHdNMg32aarFM4JJOWuxE7SGS90M5
         mLeTWV7UI43lbPMp9dRYb6FAyfKbuiB3JF6/akACi71rn9RxBnBFOZlounf58CiAF5Ed
         DUgBaoMbrbtXyLWJ8iT7DYBK8W/uIoRhmZVdjeWDzgk1+GFpvpjPUCK0PfD7gUbhTarM
         S5BXV41a0kQpTGaFoLcwppp9NlZLmGVwwliK7RHGlITo9l/DBBhjj/ZquFOjf6wTOEQd
         aqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XJsKRH19vB/cGeqHjSkLUZnV1D50ZWfC9CxNYPIMtuY=;
        b=LqhrpKqIPoMJggEMEeUxtCdXDtgeXDPsC01Mv3d3xYBwYpOyC0a8Ps1xP+YcnPOywj
         zpgY6dNqtfnbioIymotSaav9+ZkYm6dtUJq5xGyz8jAkZR4Lfmlqjo1Zi1Wo+x1ybnX9
         i/1Pk/7R8zEZ80jt8Sc2RHBKHNgexkH8WT/7VuKAqM6HxQitD+ZrgtIR3NCa+Q3JYB3J
         mjDisOqZmYXiknQsU/7fCIo1LFce45BdvSmoNoh7svQgyUCXPu/6N014AUvFfY7Hfjo1
         +4dNDDpr/Ot+BoP70RPKXI86lBCKbKL6k+thizgiIFNgdwuA6icb0EpzHel+EyIDhYjC
         CK+Q==
X-Gm-Message-State: AOAM530/KU+j2SkuFznsLYmcwYC6KpR/Z/oan9iWz72a5bgsWzlSw7FY
        CaQtWdxo7pNncb6HO9RdH1I=
X-Google-Smtp-Source: ABdhPJx84n0CAJh5FKdKOS8FIWCGtW9vmaMCZgQjSSdpcVpXYn/dDcrgwzR9SW2EGFoU5Mqmc7LBmA==
X-Received: by 2002:ac8:6ece:: with SMTP id f14mr14505718qtv.135.1590135914681;
        Fri, 22 May 2020 01:25:14 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id u16sm3397752qkm.107.2020.05.22.01.25.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 01:25:14 -0700 (PDT)
Date:   Fri, 22 May 2020 10:25:10 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 3/4] iio: imu: bmi160: added regulator support
Message-ID: <20200522082510.GC19742@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-4-jonathan.albrieux@gmail.com>
 <20200519185535.00003cb7@Huawei.com>
 <20200520071751.GD3361@ict14-OptiPlex-980>
 <20200521193055.7ee7cf9c@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521193055.7ee7cf9c@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 21, 2020 at 07:30:55PM +0100, Jonathan Cameron wrote:
> On Wed, 20 May 2020 09:17:51 +0200
> Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> 
> > On Tue, May 19, 2020 at 06:55:35PM +0100, Jonathan Cameron wrote:
> > > On Tue, 19 May 2020 09:50:59 +0200
> > > Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> > >   
> > > > v2: fixed missing description  
> > > 
> > > Don't put change log here....  
> > 
> > Yep I will put it in the cover letter
> > 
> > > > 
> > > > Add vdd-supply and vddio-supply support. Without this support vdd and vddio
> > > > should be set to always-on in device tree  
> > > 
> > > Kind of the opposite.  If they are always on we don't have to provide them
> > > in the device tree.
> > >   
> > 
> > I wrote that because, testing on msm8916, without setting the regulators to
> > always on they were controlled by other components and it happened that
> > the line wasn't ready during probe causing failure to load the module.
> > 
> > I will try to reword based on your comment, thank you.
> 
> Ah. Understood.  I'd give that explicit example in the patch description.
> I'd assumed this was the normal case of they weren't being described
> at all in DT, whereas you case is more complex.
> 
> Jonathan
>

Yep, I omitted to describe the case I was in. I'll add it to next patch, thank
you,
 
> > 
> > > A few trivial things inline.
> > >   
> > > > 
> > > > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > > > ---  
> > > 
> > > Change log goes here so we don't end up keeping it in the git log.
> > >   
> > > >  drivers/iio/imu/bmi160/bmi160.h      |  2 ++
> > > >  drivers/iio/imu/bmi160/bmi160_core.c | 27 ++++++++++++++++++++++++++-
> > > >  2 files changed, 28 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> > > > index 621f5309d735..923c3b274fde 100644
> > > > --- a/drivers/iio/imu/bmi160/bmi160.h
> > > > +++ b/drivers/iio/imu/bmi160/bmi160.h
> > > > @@ -3,10 +3,12 @@
> > > >  #define BMI160_H_
> > > >  
> > > >  #include <linux/iio/iio.h>
> > > > +#include <linux/regulator/consumer.h>
> > > >  
> > > >  struct bmi160_data {
> > > >  	struct regmap *regmap;
> > > >  	struct iio_trigger *trig;
> > > > +	struct regulator_bulk_data supplies[2];
> > > >  };
> > > >  
> > > >  extern const struct regmap_config bmi160_regmap_config;
> > > > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> > > > index 6af65d6f1d28..9bbe0d8e6720 100644
> > > > --- a/drivers/iio/imu/bmi160/bmi160_core.c
> > > > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> > > > @@ -15,6 +15,7 @@
> > > >  #include <linux/delay.h>
> > > >  #include <linux/irq.h>
> > > >  #include <linux/of_irq.h>
> > > > +#include <linux/regulator/consumer.h>
> > > >  
> > > >  #include <linux/iio/iio.h>
> > > >  #include <linux/iio/triggered_buffer.h>
> > > > @@ -709,6 +710,12 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> > > >  	unsigned int val;
> > > >  	struct device *dev = regmap_get_device(data->regmap);
> > > >  
> > > > +	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > >  	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
> > > >  	if (ret)
> > > >  		return ret;
> > > > @@ -793,9 +800,17 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
> > > >  static void bmi160_chip_uninit(void *data)
> > > >  {
> > > >  	struct bmi160_data *bmi_data = data;
> > > > +	struct device *dev = regmap_get_device(bmi_data->regmap);
> > > > +	int ret;
> > > >  
> > > >  	bmi160_set_mode(bmi_data, BMI160_GYRO, false);
> > > >  	bmi160_set_mode(bmi_data, BMI160_ACCEL, false);
> > > > +
> > > > +	ret = regulator_bulk_disable(ARRAY_SIZE(bmi_data->supplies),
> > > > +				     bmi_data->supplies);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to disable regulators: %d\n", ret);
> > > > +	}  
> > > No need for brackets around a 1 line if block
> > >   
> > 
> > Thank you, I didn't noticed that :-)
> > 
> > > 	if (ret)
> > > 		dev_err(dev, "failed to disable regulators: %d\n", ret);
> > >   
> > > >  }
> > > >  
> > > >  int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> > > > @@ -815,6 +830,16 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> > > >  	dev_set_drvdata(dev, indio_dev);
> > > >  	data->regmap = regmap;
> > > >  
> > > > +	data->supplies[0].supply = "vdd";
> > > > +	data->supplies[1].supply = "vddio";
> > > > +	ret = devm_regulator_bulk_get(dev,
> > > > +				      ARRAY_SIZE(data->supplies),
> > > > +				      data->supplies);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to get regulators: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > >  	ret = bmi160_chip_init(data, use_spi);
> > > >  	if (ret)
> > > >  		return ret;
> > > > @@ -853,6 +878,6 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(bmi160_core_probe);
> > > >  
> > > > -MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
> > > > +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");  
> > > 
> > > Good fix but shouldn't be in this patch.   Put it a separate patch on it's own.
> > >   
> > 
> > Ok will separate this fix into another patch, thank you!
> > 
> > > >  MODULE_DESCRIPTION("Bosch BMI160 driver");
> > > >  MODULE_LICENSE("GPL v2");  
> > > 
> > >   
> > 
> > Best regards,
> > Jonathan Albrieux
> 

Best regards,
Jonathan Albrieux
