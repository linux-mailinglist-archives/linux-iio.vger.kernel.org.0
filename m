Return-Path: <linux-iio+bounces-10803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC77D9A5027
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 19:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89919284FEC
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0818E04D;
	Sat, 19 Oct 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHYxyhHH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8A2F2F;
	Sat, 19 Oct 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729360302; cv=none; b=FlOa/b7QPUBEIqlpwMUBJs6dnCmcXi+2a9992Xby5wWGiDdp5mFEmATDcqzJOSykGT52HpgwqrJ6AjulkF9aRRW7xR5nmiqJR3VPo6L4uMuHyu/BJ2iLQKjwzoZ39MLfnE0RQQ6yK2eXtehX3GgGUYLJWBSM48unMkx3ZUO4ekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729360302; c=relaxed/simple;
	bh=xfnVYrKIt+bLmXHcpF9/4MhLrYtAlT6cYyysrPbOezc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7D9/08CwWuf4A472x9BzURBnvjTe3WXdl+/8ZCdPkI7yZpu0JRpe0zlMQ9ieguPtmwGEPlaTOFRpBUjti0LCJZtq8n0U486Rk37nDcQzXyjRfeSZrQeQQof/Sp9z+MJ1x+fi2dAeo9QgqlUAM86+IgfAa9PDMCgrekcd7BRsxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHYxyhHH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so3488355a12.2;
        Sat, 19 Oct 2024 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729360298; x=1729965098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pn3M5fUk/wJyqiD1FXrvV6fDx+AjO03mIiW4thSfDm8=;
        b=BHYxyhHHtDF4+JGn/AupYhr2liiZ04w7eD44Z+w6bionHHfvLEjy2xAUyYC6KPNDDU
         Ce1L3VFU8T3VlSIaH1GZbVL2URGXFwbgQBhF4dhAvTAFfGKrFmgKJvwyr56sjjEu/ff6
         Pqo8nVhvOVITDYyAMZ42CIZoLK/rixExCjXWcivbJyX8nbKm5abwnv+wnRYPluMJ1Bph
         ZjACcmaK1kNSAhopGhqQFwce82GQFd60YHrAH6B72HTNWGb24j9IHPXtREjJbTcwxCf/
         l1NitXg0V4za6K2sLYRW7w9tm7YJLDjZoGEKO0VZrFBiOBKtM7R+QYjxQw1ReYEsP1d2
         Nnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729360298; x=1729965098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn3M5fUk/wJyqiD1FXrvV6fDx+AjO03mIiW4thSfDm8=;
        b=cmhEJkvicYqFyjsYMTUCogTpZlwYF95UHzmHex4Uv9+XXXXS/PJ2PoBAFu33USno2A
         F+YFfbiBuWVt5V3mynJQ4tuT9dETllQyG3Aas/WgEdcgMCkWVuLwlG7U4XjLgRQDk8HS
         kMg6eVAKbKRtG0e+7kmlk37qZGWoYfImulvPh4zkI2NyItJvIQ0/iy7qioVqEeQ+a6jI
         S3p0EzTDdcFVKtRuvMa5auIFJbsUDhHsUloXO7iUSMKaNSCsp444YDAGERw451OeFRmt
         6R0OUeVttk3p17gLamdWguurG4Mu3ae38OZ/fi5Rk3+cD8M3g8CCRFkRbh0n4S0DWS1a
         nR7A==
X-Forwarded-Encrypted: i=1; AJvYcCUcGNigIx9+HTA/SrfV6C+F0+Ezylow9qIqzbDraPCwvfVwhuao10FtCxIGupdP4C7UJ82AnsQ5fLMi@vger.kernel.org, AJvYcCVyyWCys5TxtVvGxPWtQrOBmqmEwrKxi9792mTdbBmaxTtoyO2RzfdyyeEj412ShfwJFMIejSLFRWARFZ9o@vger.kernel.org, AJvYcCWA/ad2EjBmb+TlZoWJlRDJOm8I/jLDyLMd7w6NGKxgoqRNS1pa9s1ptRTfpuXw1leVXKOD+WrThrpw@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoyIMvPFzoIa90hsSBvyzSTkQBX7VfrAfbJLMSBCqnqbvOTfl
	2A3QxgEMhXekZE2CqXtFzhh2tlD1TRwKnxvexxA3lFq6AiekfAPj
X-Google-Smtp-Source: AGHT+IEhj4tFtSF00LV9YExwRUX5TyggDcTqlAX9G8b72VDgmvScDE5pBlU3AAIVKzb72C1MExAgdA==
X-Received: by 2002:a05:6402:40cf:b0:5c9:a664:99c0 with SMTP id 4fb4d7f45d1cf-5ca0af9ab0cmr4313936a12.30.1729360297989;
        Sat, 19 Oct 2024 10:51:37 -0700 (PDT)
Received: from vamoirid-laptop (mob-194-230-148-150.cgn.sunrise.net. [194.230.148.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b647sm16947a12.18.2024.10.19.10.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 10:51:36 -0700 (PDT)
Date: Sat, 19 Oct 2024 19:51:32 +0200
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] iio: chemical: bme680: Move ambient temperature
 to attributes
Message-ID: <ZxPxpD8gtikOxzOe@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-10-vassilisamir@gmail.com>
 <20241012130124.44c69521@jic23-huawei>
 <Zw17n7DB2LdgDct3@vamoirid-laptop>
 <20241019145925.5d54e7b4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019145925.5d54e7b4@jic23-huawei>

On Sat, Oct 19, 2024 at 02:59:25PM +0100, Jonathan Cameron wrote:
> On Mon, 14 Oct 2024 22:14:23 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Sat, Oct 12, 2024 at 01:01:24PM +0100, Jonathan Cameron wrote:
> > > On Thu, 10 Oct 2024 23:00:26 +0200
> > > vamoirid <vassilisamir@gmail.com> wrote:
> > >   
> > > > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > > 
> > > > Remove the ambient temperature from being a macro and implement it as
> > > > an attribute. This way, it is possible to dynamically configure the
> > > > ambient temperature of the environment to improve the accuracy of the
> > > > measurements.
> > > > 
> > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > > New ABI? Would need docs.
> > > 
> > > However, I 'think' we have a few cases where we handle this via the slightly
> > > odd interface of out_temp_processed / _raw with a label saying it's
> > > ambient temperature.
> > > 
> > > The tenuous argument is that we have heaters that actually control the
> > > temperature and the affect of either heating the thing or just happening
> > > to know the external temperature ends up being the same. Hence use
> > > an output channel for this control.
> > > 
> > > Jonathan  
> > 
> > Hi Jonathan,
> > 
> > Thanks for taking the time to review this. I saw your previous messages,
> > and I am not responding to all of them so as to not flood you with ACK
> > messages.
> > 
> > For this one though I have to ask. The last commit of this series is
> > adding support for an output current channel that controls the current
> > that is being inserted into an internal plate that is heated up in order
> > to have more precise acquisition of humidity and gas measurement. Does
> > it makes sense to add an ambient temp output channel as well?
> 
> If we need to know that temperature to calculate the meaning of the pressure
> channels then I think it does.
> 
> I am a little confused though as this device measures the temperature.
> Why isn't that the right value to use?  Is that because the heater
> is confusing things?
> 
>

Hi Jonathan,

Thank you very much for your message! So, I digged a bit more into the
device datasheet and I found out that the ambient temperature can
actually be taken directly from the measured temperature (p.22 of [1]),
I can use this one. This means, that the ambient temp can be fully
dropped since the temperature of the sensor is the information we need.
Is it ok to drop it fully since it is an ABI change? If not how should I
approach this?

Another thing that I had missed because of the way the code was written
is that actually we can (and should) use output channel for setting the
temperature of the internal heater plate. This sensor essentially has an
internal heater plate that allows it to measure the VOC. Currently if
you check the driver [2], the value of the requested temperature of the
heater is set only once in the probe function and stays all the time
like this. This doesn't allow for much flexibility. But it is something
that I will do in another series and not this one, since this one is
already quite heavy.

Cheers,
Vasilis

PS: I don't understand why Bosch designed the sensor in this way. Since
the value of the ambient temp can be either hardcoded or the actual
value of the temperature sensor, they could have had all this logic in
hardware. They could actually even implement the compensation functions
in hardware and just return RAW values to us. It's kind of the same
situation with the BME280 and BMP{1,2,3,5}80 drivers that we have.

[1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
[2]: https://elixir.bootlin.com/linux/v6.11.4/source/drivers/iio/chemical/bme680_core.c#L989
> > 
> > Cheers,
> > Vasilis
> > 
>

