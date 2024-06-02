Return-Path: <linux-iio+bounces-5650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2448D7795
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 21:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FC52815DF
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EEF6F06A;
	Sun,  2 Jun 2024 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6gZOVQC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09342135A;
	Sun,  2 Jun 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717356365; cv=none; b=gd+QPbHZvOHJjWicMpan5N/mgWlt5pHLC28Uf3D0b7AqDKjQq5ub08I3URaNUehjTVWbDn1FJ0hf0+4McN0NQEqGho6EhleXCeJf5WghY0yKsHWqKnoyob7Rt9PZ2RfvJ53aMMu3w9XQnICDGRqQoD7NF9CI6MljM6z8E7+9f3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717356365; c=relaxed/simple;
	bh=c2KchcWbJ4aVx3G4javeZeJ9ThUC2NESeYbJjSukSw8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9C/brntHB7X9/G22NisMXcSY+t1bPrDczo+tfDDIuAMQg+RivsnsuyhOwUS2emNuzn+FobqjKexvtfgUxt18ehAI0D+Xbs7DRrib5IEV3UwzgVA9NbIY0/+qAO8Jd9XCR9sr5pijKMGD5MOIg80d/9HjoHxOvD0NcVHakvTMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6gZOVQC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a63359aaacaso456182766b.1;
        Sun, 02 Jun 2024 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717356362; x=1717961162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7H0+YczZyAMmmXhqQ5bdcZLggrYp1ispkgQz/eWWoes=;
        b=b6gZOVQCoQ1o+Oe2gGSuIrl7bvufR3VOLg6Ug/gULBV6TFWR6V6OVehsVX+d8IgP36
         nI/ZzVQA6GV8CU7d4OoYTxJMnOhBMliwipmECsT4u5D6tzY8UELkVMyOxSrXM0h0o7hS
         uJzLu2EYWQm+RCAz6aTQnYrcFy6Bk9Q99Sfg1Jp0i9bTkQT0jofezwkMDuP3QZl7+fmH
         PhEZHJGHVBHkG29Sak1JdHaGR8rXDguaaJ8Ho1JLZea4w2qlizNAll7U7Eyi5zZskEe3
         3asMvPdjiTH8hHZLqr2p97QkbYFTU8MmPBpKH+d6Sj0Iotex6DztDtwplRxVJaAvSfxV
         beGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717356362; x=1717961162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H0+YczZyAMmmXhqQ5bdcZLggrYp1ispkgQz/eWWoes=;
        b=AVB2BLZRd52dJSqbDhJ66aDEDQKV4dsb2QEYrSv+72T+/tTV+yyLS2iq7CE0cWX2RH
         gOpSRuaRnU9TX+LtSNFQqWg8V9iueMJHJMx+93LNlV+Nzu3jdGetPs7GA6o8SibYh2Ou
         kfuCZ2aQ8JziaWT1UTitv8P+9zw/JNQFx/pR39gCt0soYHbovftdsbIWKWppTK/t2glV
         6hLH/8LrbTo/Bf/+WkXbwp8STq6thdACXb0ZveMegQuXyKypcw7bGFhdYRf2hWlr75m4
         7xw8QXbr/gC1LL2HsQVLiUTz5o/ltQPxVMHJXKFPW3VYnjs4UmBGDqwUpFvOpHldqu3P
         mF2w==
X-Forwarded-Encrypted: i=1; AJvYcCWE6hocYzUyxmnD1VtHkoPZt7Zs4ZQEtlHOcTKyYVD8oywxqMcDxc3hriGJzJhnZbZsdYFni0KHsi6PeVvEXWqGUwcc+omSATjOf3dNRXv+NHsvYkGWoqZNncmOw/n11t/YE/Xh5OwG
X-Gm-Message-State: AOJu0YyMCLtMEY9rZS1LFp5XvmMvbU9CU8n0ee4BOmSrnjIHvJ0f47CV
	haruuOR5AWSNG0eNrRRIMT97NQmlh1NiFP6e60s4VG7UiiizLoQV
X-Google-Smtp-Source: AGHT+IHZrh5TW/p6dZrhxCOrfJJWSAqMZUdxK0yQ4qPZqNGR56gSWunU3JRQ+YSR8Lgr/8ZFcBBB9w==
X-Received: by 2002:a17:907:9392:b0:a68:4397:a80b with SMTP id a640c23a62f3a-a684397ad04mr350394666b.72.1717356362004;
        Sun, 02 Jun 2024 12:26:02 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:add1:b1ad:7182:3e90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a69097bf6bbsm54800166b.110.2024.06.02.12.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:26:01 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 2 Jun 2024 21:25:59 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/17] iio: chemical: bme680: Remove duplicate
 register read
Message-ID: <20240602192559.GC387181@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
 <20240527183805.311501-11-vassilisamir@gmail.com>
 <20240602135036.27b0ee9a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602135036.27b0ee9a@jic23-huawei>

On Sun, Jun 02, 2024 at 01:50:36PM +0100, Jonathan Cameron wrote:
> On Mon, 27 May 2024 20:37:58 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > The LSB of the gas register was read first to check if the following
> > check was correct and then the MSB+LSB were read together. Simplify
> > this by reading together the MSB+LSB immediately.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> A few trivial things. I wrote a nice comment on dma safe buffers then
> noticed this does a custom regmap using spi_write_then_read() so despite
> not looking like it from this code, DMA safe buffers are used.
> Just thought I'd mention it for any other reviewers!
> 
> > ---
> >  drivers/iio/chemical/bme680_core.c | 21 ++++++++-------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > index 96423861c79a..681f271f9b06 100644
> > --- a/drivers/iio/chemical/bme680_core.c
> > +++ b/drivers/iio/chemical/bme680_core.c
> > @@ -748,7 +748,7 @@ static int bme680_read_gas(struct bme680_data *data,
> >  	int ret;
> >  	__be16 tmp = 0;
> >  	unsigned int check;
> > -	u16 adc_gas_res;
> > +	u16 adc_gas_res, gas_regs_val;
> >  	u8 gas_range;
> >  
> >  	/* Set heater settings */
> > @@ -771,11 +771,14 @@ static int bme680_read_gas(struct bme680_data *data,
> >  		return -EBUSY;
> >  	}
> >  
> > -	ret = regmap_read(data->regmap, BME680_REG_GAS_R_LSB, &check);
> > +	ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
> > +			       &tmp, sizeof(tmp)); 
> >  	if (ret < 0) {
> > -		dev_err(dev, "failed to read gas_r_lsb register\n");
> > +		dev_err(dev, "failed to read gas resistance\n");
> >  		return ret;
> >  	}
> > +	gas_regs_val = be16_to_cpu(tmp);
> > +	adc_gas_res = gas_regs_val >> BME680_ADC_GAS_RES_SHIFT;
> I'd rather see this as a FIELD_GET() but given this was what was originally
> here I guess I can cope with keeping it a little longer!
> 

Well, it's not a big deal, I could put it in a FIELD_GET().

> >  
> >  	/*
> >  	 * occurs if either the gas heating duration was insuffient
> > @@ -783,20 +786,12 @@ static int bme680_read_gas(struct bme680_data *data,
> >  	 * heater temperature was too high for the heater sink to
> >  	 * reach.
> >  	 */
> > -	if ((check & BME680_GAS_STAB_BIT) == 0) {
> > +	if ((gas_regs_val & BME680_GAS_STAB_BIT) == 0) {
> >  		dev_err(dev, "heater failed to reach the target temperature\n");
> >  		return -EINVAL;
> >  	}
> >  
> > -	ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
> > -			       &tmp, sizeof(tmp));
> > -	if (ret < 0) {
> > -		dev_err(dev, "failed to read gas resistance\n");
> > -		return ret;
> > -	}
> > -
> > -	gas_range = check & BME680_GAS_RANGE_MASK;
> > -	adc_gas_res = be16_to_cpu(tmp) >> BME680_ADC_GAS_RES_SHIFT;
> > +	gas_range = gas_regs_val & BME680_GAS_RANGE_MASK;
> 
> Whilst you are here, may this a FIELD_GET() so we don't have to go
> check that it includes the LSB.
> 

I could do it here as well.

Cheers,
Vasilis
> >  
> >  	*val = bme680_compensate_gas(data, adc_gas_res, gas_range);
> >  	return IIO_VAL_INT;
> 

