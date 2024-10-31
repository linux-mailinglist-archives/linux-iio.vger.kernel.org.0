Return-Path: <linux-iio+bounces-11684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E9E9B76A1
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 09:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A486B1C20A82
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319A1553A7;
	Thu, 31 Oct 2024 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxDqicQK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC3D517
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363954; cv=none; b=IHG9wbaukWJk/dUX9t3mAy7lUqBGDI5qakjODxvHDAd3UPsUi29jXXISefvXdWE+5x9/9uW4L/MMGgoc6lMN9Cm/OEVPlPElFm9oFLuFH2QcHTQJw4S/0MgAWFVXKBJ5lt9JHTZXPAlkFH95x8j7G2B1gof78XPjsIna07Hq+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363954; c=relaxed/simple;
	bh=UlsVD/TQVZndaI39d2Ui/SFBNudIU291HqxrNdD5V9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHTPjJYlVap0RCfDZZRuMwex//Q6pYIwz9Fa+ntcYo3b8II3lacMOF0fjj3sDH1+bPbrVvAAKAsdIEB6x1reCsIbLLa0UJjNXJhMi5T2IqUP7tAJa4GwzRIG8ZlXBokLeDbhRDOGsgl2SkUyqFDIowI0zYZEVTp8c8MkUiJTx3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uxDqicQK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb3110b964so5662951fa.1
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730363951; x=1730968751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFY3qc5m2k8ZV+nDfFga6B9StcU3TvC46on2VL5WFOQ=;
        b=uxDqicQK2dIHHlw/XHlzjqI4HdZF0wiAkzKVTaeSFrsY4z3e4N7t2lVZ4wxp+sf8KI
         Zwb5nvurHo7LpMYGI/ZSNfWjtFnmWUmXQ4WlMbasbR/cOWMDXvANi1aW8+i030mYlHCd
         lOTnb7U4FHkE/KRcEJ0yEyhQmaTQxbZEmAbe3xLx2Sn/cxAWxx4qUGBkogGyrK7TwcIQ
         aCCfdinix2SMMHLksObFzzVzI9O8hh1ENvA7E4O5Vfz5dqd5IxpMdHM9oRI9HtF4vrj6
         zF+QIxY5NFAnUgxZpKg96q0L6WCsUoT5Z3j0MSBka4XM5galHQZPO4smLKDOmse8OFIE
         yQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730363951; x=1730968751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFY3qc5m2k8ZV+nDfFga6B9StcU3TvC46on2VL5WFOQ=;
        b=Jbo3qWt9yBouigGkgybNXcALNt/s1h9goTohi/ZZyElpak9UgoOvkoEXpSYdeCnH3E
         HE++EXfXehF+rJN4rzY/+vlj9nSaO+mF+TJXimUHEt20tI5YvNwyzVlLCgJYkl/ivizV
         bDe+FtkbY8WzqF2zZuteGUV4S8qikQ0EPq4vhL4vUYherV0eucUuJi2HzAVpgQFGKvrb
         zZlozxb/y835fJr11Y0nQYjDP2Xi8YropuHMy8dzwxzo3BMP/nhym0gG0VQmBGtxdYwg
         kWe3mpFmeDfJn7YSC4S+w1Fp1JChu9/QMExTgTQAScGTDaiGkmCRsgmb60Htq1p33Pyt
         wqUg==
X-Gm-Message-State: AOJu0Yx9mz1yXvksWZRwPPowo9DHjFI0m+2/9DQC8Q3nnCx2N+a6iyGe
	z2Qzsagsa9ejAnEXXZW/Yh60asP2YTtNinA8x2aMidXrbUiYETo6w6I+nBm062Q=
X-Google-Smtp-Source: AGHT+IHS8hP/f50MkKSSTe+1BKUWK35QdVYHEsQ7LVItFs6/nTYgis2VuOVrfJP3UKC/6SVOHBObHQ==
X-Received: by 2002:a05:6512:3ba3:b0:536:a564:fd48 with SMTP id 2adb3069b0e04-53b348c15a8mr10223150e87.3.1730363950559;
        Thu, 31 Oct 2024 01:39:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d698055sm17276685e9.40.2024.10.31.01.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:39:10 -0700 (PDT)
Date: Thu, 31 Oct 2024 11:39:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: light: isl29018: Replace a variant of
 iio_get_acpi_device_name_and_data()
Message-ID: <8d693972-99a5-45b4-b7f3-82338afd1c70@stanley.mountain>
References: <54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain>
 <ZyJHpaWms8Fe2x94@smile.fi.intel.com>
 <ZyM98BnZ-0yQFAHu@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyM98BnZ-0yQFAHu@smile.fi.intel.com>

On Thu, Oct 31, 2024 at 10:21:04AM +0200, Andy Shevchenko wrote:
> On Wed, Oct 30, 2024 at 04:50:14PM +0200, Andy Shevchenko wrote:
> > On Wed, Oct 30, 2024 at 12:53:57PM +0300, Dan Carpenter wrote:
> > > Hello Andy Shevchenko,
> > > 
> > > Commit 14686836fb69 ("iio: light: isl29018: Replace a variant of
> > > iio_get_acpi_device_name_and_data()") from Oct 24, 2024 (linux-next),
> > > leads to the following Smatch static checker warning:
> > > 
> > >     drivers/iio/light/isl29018.c:724 isl29018_probe() error: uninitialized symbol 'ddata'.
> > >     drivers/iio/light/ltr501.c:1514 ltr501_probe() error: uninitialized symbol 'ddata'.
> > > 
> > > drivers/iio/light/isl29018.c
> > >     701 static int isl29018_probe(struct i2c_client *client)
> > >     702 {
> > >     703         const struct i2c_device_id *id = i2c_client_get_device_id(client);
> > >     704         struct isl29018_chip *chip;
> > >     705         struct iio_dev *indio_dev;
> > >     706         const void *ddata;
> > >     707         const char *name;
> > >     708         int dev_id;
> > >     709         int err;
> > >     710 
> > >     711         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> > >     712         if (!indio_dev)
> > >     713                 return -ENOMEM;
> > >     714 
> > >     715         chip = iio_priv(indio_dev);
> > >     716 
> > >     717         i2c_set_clientdata(client, indio_dev);
> > >     718 
> > >     719         if (id) {
> > >     720                 name = id->name;
> > >     721                 dev_id = id->driver_data;
> > >     722         } else {
> > >     723                 name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
> > > --> 724                 dev_id = (intptr_t)ddata;
> > > 
> > > How do we know that iio_get_acpi_device_name_and_data() will succeed?
> > 
> > Ideally we need to file &ddata with NULL in such case, but it will be
> > equal to 0, so it only works with the chip_info in place.
> > 
> > Let me look into this once more, thanks for the good catch!
> 
> I have sent a patch series to address that (you are in Cc there), does it help?
> 

Yes.  Thanks!

regards,
dan carpenter



