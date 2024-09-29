Return-Path: <linux-iio+bounces-9895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C4989716
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 21:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0964E1F21588
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 19:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7A537E9;
	Sun, 29 Sep 2024 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU65W0zu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DA41A84;
	Sun, 29 Sep 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727638280; cv=none; b=VZH0UKd9GFOPMTEtXKersQZz0PNw/D/NuYGlC/JdqbPDPoaH3otvAazXH8xNzmhXESRGPAOT2zUlKHXmY5tJvQwFElDoFB6KZSCQ/d7Dbxxj4UlSaLoVPWkI8s0QOMczkFTMUrXnuQ+We/06nYBtqhqmeduYKH+Ske/diDX8Zt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727638280; c=relaxed/simple;
	bh=wTAFUu2HR05YCznqD3LOSXMINOzSP/J0jVLhbDAFaVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEJRdoTNgVr7ecnZ7+wCjr9hyl8zWyjLUbvX0n3jaKNj84ubIJ+vbB8vBayYzLj4Oz2+RsiArSoHRP+Yp7DElwZNVaezE/fLMVZhpeNdhb+aww0ZQz1fTQaINI8IcCCo8iarM6Oat5uh35gxaGfARWHss9X+DNAfwm+LhfJoRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QU65W0zu; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a99fd0535bso322566185a.3;
        Sun, 29 Sep 2024 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727638278; x=1728243078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1isPk0/yiaThPVpTHXqwNM5xUZ8cavb3R5rhfzcYlo=;
        b=QU65W0zuUzNvrwTZm8BYmdDNk9cuA8LY/gI8gSn5vHZrmeT4MPWu9bDeJ3KINNf6Ua
         m2TLHbiW3dHD+V9+S76zH7fLxN9qmyOu54wn2d1Jh4R6WK0Mnpmwytxjlr0UdJAs2BrL
         CnQjleF33SL9CdGO1QDyNNWJD56Gxj1crxIUaZIN5hJ8L3LBsoCHd7v+p9sqEtpzfVDW
         O375FoKbdc39+XcuzBo6YeIYdJ4yWOreusWmU4gxSxnefCkt3pRM4hzpDc4SLr1kFcFq
         j1ADDRi7TNmiGgAWlXVn4Z1rSU/kaXLBQvRYOoPUwDsFMfucVefLoMXrT0NNjyh09K1z
         9UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727638278; x=1728243078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1isPk0/yiaThPVpTHXqwNM5xUZ8cavb3R5rhfzcYlo=;
        b=jNFaTHEbQ8cMhV1wvBRMynTVXNml5ufsGzBtbReOao/uZE0wVkvuqtb3gq1vtDJFil
         M5uT4nYB66gPzsbqKDvqNPtxs3H9orWPBTBxy9pQjVdNUFEqA/5CM1zwc2rnnh1XmeEp
         +N6iUnjbx1B2roHAysJjsv4E4K1yeNJgIgsLupP8xUk4BBmTcCNbjyjcUeA2SXIz6oQ6
         XVxKMw4UYInCrA1as5nvVKt4QzjfiRKNj3rPRPKInQEyPvitE2WNUNynohw9o4uDfvfS
         vcD4CGko2jSWdJR3htcCaI7bH1bgyyAvlfTd4NveJb96D60/gHaj8tzwfoYJ/F1kE52p
         Meqw==
X-Forwarded-Encrypted: i=1; AJvYcCWBdhuV0lln+SPSFCyyvkgthsn01k94RhS+RWaRD2SqUUBzNFnZt2DBseVPkJZUf4TmR/4mbEUkfSc=@vger.kernel.org, AJvYcCWSeBQGy46dVOPXgX4oe8/+jQJ70/qBlNf/ErwMWj2klnppHhnHaLnrlgv67tLaLtwvsYW4Lna4akRrfsBn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4zbu73wQP8UAZ8+Lsqn1XkWE+YCc+NOEMoNhYERwawUUSaCuA
	NbZZBJOvTePSb55D0CKMmMO5oUG0qNdT6Zj7+2/L6DLc0xNIhs59
X-Google-Smtp-Source: AGHT+IGsTEnIDy283jw9lkr/mcK/PBIK3rY6wv6YWW4CeyY5xrhPWizkTM/1vAeHXQvUdyhRVi7etQ==
X-Received: by 2002:a05:620a:1925:b0:7a9:bb80:1f56 with SMTP id af79cd13be357-7ae378476dcmr1723689785a.33.1727638277644;
        Sun, 29 Sep 2024 12:31:17 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782c533sm346399685a.97.2024.09.29.12.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 12:31:16 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:31:14 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: Add spi driver for bmi270 imu
Message-ID: <nsqdetgfr7p5klex77alaeoosgi5o5phhnri5kcn735wsn7e5o@phuellsm23nd>
References: <20240927183717.3613601-1-lanzano.alex@gmail.com>
 <20240929155437.60115014@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929155437.60115014@jic23-huawei>

Thanks for the review!

On Sun, Sep 29, 2024 at 03:54:37PM GMT, Jonathan Cameron wrote:
> On Fri, 27 Sep 2024 14:37:10 -0400
> Alex Lanzano <lanzano.alex@gmail.com> wrote:
> 
> > Implement SPI driver for the Bosch BMI270 6-axis IMU. Provide raw read
> > write access to acceleration and angle velocity measurements via the SPI
> > interface on the device.
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> 
> A few minor things inline but looks good in general.
> 
> Jonathan
> 
> > diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> > index 608b29ea58a3..8950e6234203 100644
> > --- a/drivers/iio/imu/bmi270/bmi270.h
> > +++ b/drivers/iio/imu/bmi270/bmi270.h
> > @@ -4,11 +4,13 @@
> >  #define BMI270_H_
> >  
> >  #include <linux/regmap.h>
> > +#include <linux/iio/iio.h>
> >  
> >  struct device;
> >  struct bmi270_data {
> >  	struct device *dev;
> >  	struct regmap *regmap;
> > +	__le16 sample __aligned(IIO_DMA_MINALIGN);
> 
> For the read path you are bouncing anyway, so the DMA_MINALIGN is only needed
> for anything the write direction.  Make the suggested change below and that
> will bounce as well so that you don't need this.
> 

Understood! Will remove in v2 and use spi_write_then_read

> >  };
> >  
> >  extern const struct regmap_config bmi270_regmap_config;
> > diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> > index 8e45343d6472..4decdad791d9 100644
> > --- a/drivers/iio/imu/bmi270/bmi270_core.c
> > +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> > @@ -66,16 +66,9 @@ enum bmi270_scan {
> >  	BMI270_SCAN_GYRO_Z,
> >  };
> >  
> > -const struct regmap_config bmi270_regmap_config = {
> > -	.reg_bits = 8,
> > -	.val_bits = 8,
> > -};
> > -EXPORT_SYMBOL_NS_GPL(bmi270_regmap_config, IIO_BMI270);
> > -
> >  static int bmi270_get_data(struct bmi270_data *bmi270_device,
> >  			   int chan_type, int axis, int *val)
> >  {
> > -	__le16 sample;
> >  	int reg;
> >  	int ret;
> >  
> > @@ -90,11 +83,13 @@ static int bmi270_get_data(struct bmi270_data *bmi270_device,
> >  		return -EINVAL;
> >  	}
> >  
> > -	ret = regmap_bulk_read(bmi270_device->regmap, reg, &sample, sizeof(sample));
> > +	ret = regmap_bulk_read(bmi270_device->regmap, reg,
> > +			       &bmi270_device->sample,
> > +			       sizeof(bmi270_device->sample));
> >  	if (ret)
> >  		return ret;
> >  
> > -	*val = sign_extend32(le16_to_cpu(sample), 15);
> > +	*val = sign_extend32(le16_to_cpu(bmi270_device->sample), 15);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> > index f70dee2d8a64..ce8279ae90cd 100644
> > --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> > +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> > @@ -9,12 +9,17 @@
> >  
> >  #include "bmi270.h"
> >  
> > +const struct regmap_config bmi270_i2c_regmap_config = {
> static const
> 
> (same for spi one)
> 

Will fix in v2!

> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +};
> > +
> >  static int bmi270_i2c_probe(struct i2c_client *client)
> >  {
> >  	struct regmap *regmap;
> >  	struct device *dev = &client->dev;
> >  
> > -	regmap = devm_regmap_init_i2c(client, &bmi270_regmap_config);
> > +	regmap = devm_regmap_init_i2c(client, &bmi270_i2c_regmap_config);
> >  	if (IS_ERR(regmap))
> >  		return dev_err_probe(dev, PTR_ERR(regmap),
> >  				     "Failed to init i2c regmap");
> > diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
> > new file mode 100644
> > index 000000000000..906b9b852a09
> > --- /dev/null
> > +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
> > @@ -0,0 +1,89 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/regmap.h>
> Alphabetical order preferred.
> 

Will fix in v2

> > +
> > +#include "bmi270.h"
> > +
> > +/*
> > + * The following two functions are taken from the BMI323 spi driver code.
> > + * In section 6.4 of the BMI270 data it specifies that after a read
> > + * operation the first data byte from the device is a dummy byte
> > + */
> > +static int bmi270_regmap_spi_read(void *context, const void *reg_buf,
> > +				  size_t reg_size, void *val_buf,
> > +				  size_t val_size)
> > +{
> > +	struct spi_device *spi = context;
> 
> I'd be tempted to rename the input parameter context to spi and then
> parse it directly to the spi_write_then_read()
> 

Will do! I named it context since that's what the function pointer uses

> > +
> > +	return spi_write_then_read(spi, reg_buf, reg_size, val_buf, val_size);
> > +}
> > +
> > +static int bmi270_regmap_spi_write(void *context, const void *data,
> > +				   size_t count)
> > +{
> > +	struct spi_device *spi = context;
> > +	u8 *data_buff = (u8 *)data;
> > +
> > +	/*
> > +	 * Remove the extra pad byte since its only needed for the read
> > +	 * operation
> > +	 */
> > +	data_buff[1] = data_buff[0];
> > +	return spi_write(spi, data_buff + 1, count - 1);
> That needs a DMA safe buffer (unlike write_then_read which always
> bounces).  I'd avoid that complexity by using spi_write_then_read
> here as well but set the read to 0 length and pass NULL for the buffer.
> That function is intended to be used like this as it special cases 0
> length for either write or read buffers.
> 

Understood! Will fix in v2.

> > +}
> 

