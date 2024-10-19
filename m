Return-Path: <linux-iio+bounces-10804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ADD9A5032
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 19:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD51283705
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9518E762;
	Sat, 19 Oct 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu5vvNDy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA2618D649;
	Sat, 19 Oct 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729360744; cv=none; b=lpefFk0WX+Xprr4h618sdhTBCAU/rbTUWtAkgOK7tbhnIUh09FgKiNod+g8G/VJA2qCBYyF/eVCr1WwXddH8J8dC8OnlvbNclTw1o4EmU6KT4lkHgW7FBI276giLKIjAnPhWVjwwTeDKWVfxKfWe3rpctjGZaC2n0fZQ7X6KhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729360744; c=relaxed/simple;
	bh=/l+Vgm6C7VArfgr5O6wchhFLLyqRm4bKfKF/ELvC/WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsANJ4AuZhxCOx7rQ6wSMo4xlPJKCAc0sUdU2GyloJY8BkqfKse1mfZiunX4TsPIijC7mt1crZQfJxwPJL13oigewNd/Lm79+DY6GPpA0ino4gyVngI7SIKJI6sBv32RnuLXXP61hg53zLqhsKFrulJda0Y/rkbyoTn177tvrVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu5vvNDy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so2083593f8f.1;
        Sat, 19 Oct 2024 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729360741; x=1729965541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=voCoiNVrD03lyXNffSx2bhdpuOD9/h1LEWqkXlSa+/g=;
        b=lu5vvNDyVEdzPHFeUI0+14q+t5m4olaRz4vsG1aiIpGgtu322JGRNG4jLfIiRXUlxX
         csgRSxDqnd8Da8M34ih+UDKkuvEi0R7i3pzT5KFpySUiDM4MnmF32jhSgWx1n87H9cFj
         69USKeIEGwdXlZtQpjGem/XfMbA4Gq7hDpyMHYVjHuCBbOvD2YEky6P5S/qJQkepNHVr
         JSFKvc/Rtu1P2CTwK9i3McHwm26yLHYhIFweoKA9M88//H+mTOAJq9oVS5L6rHiIVq5Y
         yzoHFDQ2emq9U4Y2CYJ8haIHPmK4ZPLwmCtvxobDGGEn6+j1TpppVvs+QhY0wBle9aXS
         SWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729360741; x=1729965541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voCoiNVrD03lyXNffSx2bhdpuOD9/h1LEWqkXlSa+/g=;
        b=kBOELWSCdNyD7x86NkLoRfJR+L6YgMHuEb6IQ0c/4FqthFj7s9mYKKVWVw7cNZoNt8
         AXfGfz7iceotrpNiOUjinsBEPkgQzE4JiWHKo3xbkrf4FkB7HPCZIN4dse+QcOCrQviW
         vfGwsxE7ZK8Lk30RylseD6aF6XHGs1C/v7cHXzHHwjeTZH67tF+XeeIfZ5w0q+fwD7Pw
         zJBTUSQVWEDmlPRYsbYC9b28jCt0Thi+8IjvwRsEWycNtsq1sSV+PWkYPpfkBlZmJEF9
         +BK0Y7NKz9OcNtAHBHQsbA2yr7af2Wedkrcgvn9w989JMLsFf2BOMO8BS2DOFylB7BFf
         nPSw==
X-Forwarded-Encrypted: i=1; AJvYcCUQnTH6YxlQ3hqfBjJXZfROOe4aE9A8HNSyNamVIWr3jQg8RTi19gu4y5EU5p7lOKarc2ZFI4zu/Giz@vger.kernel.org, AJvYcCUpIHgMjdXz929icbdy9IeXhrvWBCG8OSn/BX6Vdr37WHDtT5Sts7+VA1XB1IpGak4TIGgBJsrUKhPq9JRp@vger.kernel.org, AJvYcCVAiHfmMIH2ErxqHgxSY6PptqR0KljL+miwGDx4BRx3lN9hjdXV2CACjxuf3FHQtNMFXLV8z4wuUPIs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5/DYOWV6V16FXTeF5dekD5sYi0pM7HUqnFl/mHSQkYOlbLiG
	ut2ZFspuBnrGY+JVyIbLGcniKMQ4dxWMTKxwJX76JA0kjoSiwHGC
X-Google-Smtp-Source: AGHT+IEW1+ZGn1Z0uMn5hJgj5knnXlzz1IAw6pODR8Haj3dGSEjygz3VPw6lJjoz5rO4Dz+u4ex37A==
X-Received: by 2002:adf:ecc3:0:b0:37d:45ad:8394 with SMTP id ffacd0b85a97d-37ea2164cf9mr3696571f8f.15.1729360740570;
        Sat, 19 Oct 2024 10:59:00 -0700 (PDT)
Received: from vamoirid-laptop (mob-194-230-148-150.cgn.sunrise.net. [194.230.148.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9c6b0sm40919f8f.109.2024.10.19.10.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 10:58:59 -0700 (PDT)
Date: Sat, 19 Oct 2024 19:58:56 +0200
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] iio: chemical: bme680: Move ambient temperature
 to attributes
Message-ID: <ZxPzYNP7IXkWw_Hd@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-10-vassilisamir@gmail.com>
 <20241012130124.44c69521@jic23-huawei>
 <Zw17n7DB2LdgDct3@vamoirid-laptop>
 <20241019145925.5d54e7b4@jic23-huawei>
 <ZxPxpD8gtikOxzOe@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxPxpD8gtikOxzOe@vamoirid-laptop>

On Sat, Oct 19, 2024 at 07:51:32PM +0200, Vasileios Amoiridis wrote:
> On Sat, Oct 19, 2024 at 02:59:25PM +0100, Jonathan Cameron wrote:
> > On Mon, 14 Oct 2024 22:14:23 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > 
> > > On Sat, Oct 12, 2024 at 01:01:24PM +0100, Jonathan Cameron wrote:
> > > > On Thu, 10 Oct 2024 23:00:26 +0200
> > > > vamoirid <vassilisamir@gmail.com> wrote:
> > > >   
> > > > > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > > > 
> > > > > Remove the ambient temperature from being a macro and implement it as
> > > > > an attribute. This way, it is possible to dynamically configure the
> > > > > ambient temperature of the environment to improve the accuracy of the
> > > > > measurements.
> > > > > 
> > > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > > > New ABI? Would need docs.
> > > > 
> > > > However, I 'think' we have a few cases where we handle this via the slightly
> > > > odd interface of out_temp_processed / _raw with a label saying it's
> > > > ambient temperature.
> > > > 
> > > > The tenuous argument is that we have heaters that actually control the
> > > > temperature and the affect of either heating the thing or just happening
> > > > to know the external temperature ends up being the same. Hence use
> > > > an output channel for this control.
> > > > 
> > > > Jonathan  
> > > 
> > > Hi Jonathan,
> > > 
> > > Thanks for taking the time to review this. I saw your previous messages,
> > > and I am not responding to all of them so as to not flood you with ACK
> > > messages.
> > > 
> > > For this one though I have to ask. The last commit of this series is
> > > adding support for an output current channel that controls the current
> > > that is being inserted into an internal plate that is heated up in order
> > > to have more precise acquisition of humidity and gas measurement. Does
> > > it makes sense to add an ambient temp output channel as well?
> > 
> > If we need to know that temperature to calculate the meaning of the pressure
> > channels then I think it does.
> > 
> > I am a little confused though as this device measures the temperature.
> > Why isn't that the right value to use?  Is that because the heater
> > is confusing things?
> > 
> >
> 
> Hi Jonathan,
> 
> Thank you very much for your message! So, I digged a bit more into the
> device datasheet and I found out that the ambient temperature can
> actually be taken directly from the measured temperature (p.22 of [1]),
> I can use this one. This means, that the ambient temp can be fully
> dropped since the temperature of the sensor is the information we need.
> Is it ok to drop it fully since it is an ABI change? If not how should I
> approach this?
> 

Actually in the end, no ABI change because the temperature will be
taken from the internal measurement so nothing that has to do with
userspace so there is no ABI change here, my mistake!

Vasilis

> Another thing that I had missed because of the way the code was written
> is that actually we can (and should) use output channel for setting the
> temperature of the internal heater plate. This sensor essentially has an
> internal heater plate that allows it to measure the VOC. Currently if
> you check the driver [2], the value of the requested temperature of the
> heater is set only once in the probe function and stays all the time
> like this. This doesn't allow for much flexibility. But it is something
> that I will do in another series and not this one, since this one is
> already quite heavy.
> 
> Cheers,
> Vasilis
> 
> PS: I don't understand why Bosch designed the sensor in this way. Since
> the value of the ambient temp can be either hardcoded or the actual
> value of the temperature sensor, they could have had all this logic in
> hardware. They could actually even implement the compensation functions
> in hardware and just return RAW values to us. It's kind of the same
> situation with the BME280 and BMP{1,2,3,5}80 drivers that we have.
> 
> [1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
> [2]: https://elixir.bootlin.com/linux/v6.11.4/source/drivers/iio/chemical/bme680_core.c#L989
> > > 
> > > Cheers,
> > > Vasilis
> > > 
> >

