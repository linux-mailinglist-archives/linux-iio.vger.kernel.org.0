Return-Path: <linux-iio+bounces-12964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB939E0AF6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B40C2820A4
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A271DDC32;
	Mon,  2 Dec 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH+7DvtL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F981DA0EB;
	Mon,  2 Dec 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164016; cv=none; b=miS3cgJq8tLLcAr8us4rHAW7KyY1GIHPnCKlOiZLrkbycfGqT2aI2m4GNmpIwe1ODPcIPyx+fMkDtGPPeVwU3874472w1s/kbFYsXhIy21AoR7w/ncMQyp/8RXWXZCXVXVdJWZCMr/ZyLpm5W/+a7oqEIvM9zgOCi1ElniM+iRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164016; c=relaxed/simple;
	bh=1xtMUwkVsVp7J49UhE+BkhJzLQS3uNzYCblm28g1tPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSTiib2iZ4d5zolzBu9jwOof3QTbqmFOn6aP69/GNOUZJkAs6KRgKhe6k/tPxq5nS28H+rUIBpjVcHQlMcMuu/M+E3r2H/O40zZ6gdAenbHMhyUpZ3VSZsQo9NeFFezMBLhhZ7aGIVbaOUEDsf6wuYVq88OzQwC6b8ccCikPzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH+7DvtL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso42490545e9.3;
        Mon, 02 Dec 2024 10:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733164013; x=1733768813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEFfKLNJ5UdJJlChHj2idaky6JocQwCCYRbGZV4i6Zo=;
        b=mH+7DvtLDcd4GVlAbWK4Mmnm0V/boK73bqBd/E/chAFP+0CluErh3Ek5FV6FvpSkwj
         f46lqwmBlI2DIVzf6ZyTD2bA6nlO8ANsPcVDzb6Gle3lB4rxmrsqyrTZx6N7Z960qdIe
         8Zmp73FedWQA5hMpmg+t4JKVaD6qwvXaLxpZLF27sg/PC0m8e9pyfjyntmC8suGUL0Ez
         0mZLMASdujUC2sDDZjNiV6ZqU3Hqp/Mxrvi0Hdcx8ZtaTGkAgdhGujyhr6RZsSYg2Zk4
         /FYdqFM23JD1mzByyWCApTuMhwPh7ZviaR04hmCO7qwM5D9TBM01lDe0smEpOER1IU/k
         OKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164013; x=1733768813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEFfKLNJ5UdJJlChHj2idaky6JocQwCCYRbGZV4i6Zo=;
        b=MO3aGQCYO8T4gTwDCFXwpRDK/mWNvVrTZD6Y/xmUZJatlcDQ41uGvVoqc9M1o3CPJY
         xS8q8p4gooRfImLJpedvGuGNhuxCUAV7ea9uVltnY7ZZNS4TU7R+zGn24GyeSzlGIe1f
         mUX/BXKfDuYVvmkq4df5cUbCCWOlwHybbM+qaivQjAD/h99AkNUoF/W7e58Hvrqi90WX
         DTp4RTTpUHQeDfWhrrrHMPWHS01Gm6dAqbn9rePVFp92C+7OFTE++By5zijpWY4Tj2Ls
         4L8xr4JkgKL6t4KEAbJCXWQu5a8nsUSayq0Mf7Y4z1D5Ib52lwld7MrXbyrsI5WueSlp
         IhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjORGagDoWotNJEnXANnW0PnrZXZhqilKzvD9hLWdh9HEcMKWFf9PmXqyJ9X7VVYS7vLvIJriVrGZ3@vger.kernel.org, AJvYcCV0CGbsI29b3GZEjZqd1eBh/uZWp1VYqbQAq4JQiV5qu4vdWVDxjFwQjMoG4pjhBaekTlY+1TgGLISl@vger.kernel.org, AJvYcCWmZFniFhTe8SOjSY0XajUvDvkCe84kIS47qwHHuoZ6uQcQnyrJ3hL9JdMFzkyoi6RoaIyJnEH2Ue+6VMlJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcAO/I2D+RsyaIY4sCUpkVP0QIXcD9RXIGKZp7OpuLYRNLsFy
	tYzhtrD8d1oQr9A8eegWf4Vx0Qp2Uu8Vk97bqw9Xm9+2itIDiALEa8pyS96s
X-Gm-Gg: ASbGnctbRy0J2SX7aLmSg4TH4P6c1SyLxWWbgBR2+KDoPvXm7JhnjymBfCkoGaRGIfQ
	HzH5POUegs4eoMpZ8V3izmvEJ5/o6weEPWmP2TOflZcxdpP8UO8FWrkx3U6vOmBke+vrV8DY/lZ
	9MMf1aMhNX0pAmVTTrKeg18bkHJiqxVG/cU0W/4lGa8dZvcgP7elGDWyfjmlZps22IWMcxubZIx
	xGU011Q+P+TGV/ZoKcdups+45E4/CwPS/JDQ/qgQoMDPMh/duimMCU+fcpD
X-Google-Smtp-Source: AGHT+IFGIaNwFK/XCDGx4vQJSz1+7TzUMaO1rkmx294oQSZilT7UU+eubv/4Gukkre0TPtQ5DDxJkg==
X-Received: by 2002:a05:600c:3b1a:b0:434:a160:3647 with SMTP id 5b1f17b1804b1-434a9dc3eb6mr220422765e9.12.1733164012648;
        Mon, 02 Dec 2024 10:26:52 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78120dsm191685485e9.24.2024.12.02.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 10:26:52 -0800 (PST)
Date: Mon, 2 Dec 2024 19:26:50 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: chemical: bme680: add regulators
Message-ID: <Z0376uLnf8xoqSU7@vamoirid-laptop>
References: <20241128193246.24572-1-vassilisamir@gmail.com>
 <20241128193246.24572-3-vassilisamir@gmail.com>
 <20241130142648.62ead7fe@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130142648.62ead7fe@jic23-huawei>

On Sat, Nov 30, 2024 at 02:26:48PM +0000, Jonathan Cameron wrote:
> On Thu, 28 Nov 2024 20:32:45 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Add support for the regulators described in the dt-binding.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/chemical/bme680_core.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > index 9783953e64e0..186e0a6cc2d7 100644
> > --- a/drivers/iio/chemical/bme680_core.c
> > +++ b/drivers/iio/chemical/bme680_core.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/log2.h>
> >  #include <linux/module.h>
> >  #include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> > @@ -111,6 +112,10 @@ enum bme680_scan {
> >  	BME680_GAS,
> >  };
> >  
> > +static const char *const bme680_supply_names[] = { "vdd", "vddio" };
> > +
> > +#define BME680_NUM_SUPPLIES ARRAY_SIZE(bme680_supply_names)
> Trivial: What benefit do we get from this define that is used in one place?
> 

Hi Jonathan,

Thanks for the review! This here made more sense in the beginning
because I was using it in more places but now it is indeed only used in
one place. I might as well drop it.

Cheers,
Vasilis

> > +
> >  struct bme680_data {
> >  	struct regmap *regmap;
> >  	struct bme680_calib bme680;
> > @@ -1114,6 +1119,14 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
> >  	data->heater_dur = 150;  /* milliseconds */
> >  	data->preheat_curr_mA = 0;
> >  
> > +	ret = devm_regulator_bulk_get_enable(dev, BME680_NUM_SUPPLIES,
> 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(bme680_supply_names),
> 					     bme680_supply_names);
> 
> And don't worry about slightly over 80 chars line.
> 
> > +					     bme680_supply_names);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to get and enable supplies.\n");
> > +
> > +	fsleep(BME680_STARTUP_TIME_US);
> > +
> >  	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
> >  	if (ret < 0)
> >  		return dev_err_probe(dev, ret, "Failed to reset chip\n");
> 

