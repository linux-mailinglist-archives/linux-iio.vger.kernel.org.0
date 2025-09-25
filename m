Return-Path: <linux-iio+bounces-24436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC00BA0072
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4491BC15B2
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ED52DCBF1;
	Thu, 25 Sep 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdT56ePb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FC1397
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810747; cv=none; b=HhsPaMSBHQw6PW5kNXeaUdIZ4QIFKdwQAFi+StllMvmgUCNtyhdI9/CocQKchIR8oBAs37KxRpug1rsn3a3lQRRAYitXCDAgFRajmljSpcx4EAPwoqPPDeVKvO+2SLi5riKyb3HhhLrAcD63uXyAa8tu2lgzs1LoZzgt5rojufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810747; c=relaxed/simple;
	bh=a3eHXMsuFNWlqugS1mVxJZ5TpyBqt+o2aBCaTiA/Ha0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBWD2JMkO9eX5QI0iC8vflnLI1mgP8ayZzgA2mQO37d2m7coQZTlnqhJ2C+Twy3iDwxQ1yEE+v9IDdXvCQdIK9jdPnhEch0BU23tP8Clt4SwFtt/9eboegAoOsbXZc0V+o6+cbzVSlWkJNYaXK7MFInp7HWXr/nWPvTmKPaUOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdT56ePb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27ee41e0798so4444695ad.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758810745; x=1759415545; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNu4f91vx1JyBhQ6SCI1W3iAa/Ld0gsHPQbTIviSg64=;
        b=IdT56ePbNj2qhvnyd9ruau3B8XuTK2Xi/DR5PRwPbRL0c/8tt9c2gK2MFjep7VAAD3
         yn3TS4+CYUS3DCQktRAsV0vOm/Bthn8D2Cl61jmWtnVH7WSK2GfECxy0zyDD33MtEq79
         jYAtQ/Ivt9qtfcV1BPqSNcXeVoh5nL+dtE5uhabKSucjMPQSaacNn3mwwc4iMJ4HoPdE
         oFFTaANp/J7IuVvLy8v6X/y73VgxUFRCXPydlNBcnaRym3AvttqYFHoEw59s5NyHBFus
         BA5mNE01RwP29uLoORIya1JJaZETdwNEu9G37aYO/V5TtOUb9rc3lDoQ2bAKrlu5ldGo
         G/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810745; x=1759415545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNu4f91vx1JyBhQ6SCI1W3iAa/Ld0gsHPQbTIviSg64=;
        b=ZqEVbFW0CsN8wmqUmo5Lvb2uFu/K3vbl8xZ1okyhR4amNYrx07WcoRO/M8lAe8cGwl
         JesHlwububpLh/Vjqbb4hd+PTkTJgBstIyiiFNInlR5Yb3eFPHxQJ83pixBVmgFF3MJr
         UgOSYL+gfK5NyEmeMdPx8fVIArUlYRo5zmAtVnExJAdjbVMjNC4l4jveveVlZjc1Rxut
         nmPt2eg+LB/LNlMXWBcrORzgMPaHFLlKHfHN9zyhWmZaEKaZa4tSnrsfpVq3VQz4DKmi
         hGevukXho1R1jM93PXVWXsxcHRC1oXUwPB2F/IX7qbDFcxFHRmFcD4iWGIqO0jADEKLR
         ckvA==
X-Forwarded-Encrypted: i=1; AJvYcCXaaH5UyUB2xoPfh3MgvX/Wcx7Us61ZZRD0hugzO/nxmw5DWwuQDeBjSqBhEzzdglHsXJMhyJIvxb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwazFq9N8W1oV7ucrA8xJwmnGxOZPjKL/YzpRBxQXeufYiqEl+b
	z0XZiUm8Hk1JsBEvCU6QkDrZ9guocj+Qr9OLf8aaT6quhFBvUT7rgq4+
X-Gm-Gg: ASbGncucoD/gDFIyTWyu0S0/lu9yp35f5whYG4IAfHMEn1ectTKG4RAIBx/FcZk2H6x
	dn4yLbjSRGiOTheXh5a49gCq7NmtVUwY210bmc9ILm7QDpotgrvGI5jHNwF0jpKkRezndEU3mHw
	DpjTyTUUXmhVsgGy1Vhjyhqc3hZAYqOpw4jKbpmb469JivHnQ/o3/f2YplDwF/3LsCFEfuxUNJG
	8u8pHM02kZSyZk6QyxMfPLch5TSV39z1Z1KfawGDQtiZdfc+hLCFKCwqY/45T7vDRFReWJIJfzZ
	xvely0ea2Y3RoP+jmHUoyv/3zHUBNwjFcIS+E9LfvAvIeWjx5jVaCQD5ZXPyXmCH3LCJuH3EP7i
	/aNi8Znr1YmEopzyqcc0ydQoZNC50j4AVaTlVptzhIRMZGQ==
X-Google-Smtp-Source: AGHT+IEouWS18u5hzid+/58eqeK/Wz5H9vCOiw+suHDHfXTmYMG9kSe9BGY1UoAcE/k6e5ccR+b07w==
X-Received: by 2002:a17:902:e806:b0:267:e097:7a9c with SMTP id d9443c01a7336-27ed4a5ec6dmr34833405ad.53.1758810744759;
        Thu, 25 Sep 2025 07:32:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68a0203sm26846475ad.100.2025.09.25.07.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 07:32:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 25 Sep 2025 07:32:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marius.Cristea@microchip.com
Cc: jic23@kernel.org, dlechner@baylibre.com, linux-hwmon@vger.kernel.org,
	jdelvare@suse.com, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org,
	linux-kernel@vger.kernel.org, andy@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 0/2] Add support for Microchip EMC1812
Message-ID: <36c4794d-2116-4d3e-8ad5-ac3ec764a7a1@roeck-us.net>
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
 <20250920123340.1b1d03be@jic23-huawei>
 <a97486df-9f15-4280-8cb3-d77f4cf223df@roeck-us.net>
 <e6ab5becf5908d83857fcfd57823ffd259e6db90.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6ab5becf5908d83857fcfd57823ffd259e6db90.camel@microchip.com>

On Thu, Sep 25, 2025 at 09:09:04AM +0000, Marius.Cristea@microchip.com wrote:
> Hi Guenter,
> 
> Thank you for the feedback.
> 
> On Tue, 2025-09-23 at 19:11 -0700, Guenter Roeck wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > On 9/20/25 04:33, Jonathan Cameron wrote:
> > > On Wed, 17 Sep 2025 15:21:56 +0300
> > > Marius Cristea <marius.cristea@microchip.com> wrote:
> > > 
> > > > This is the iio driver for EMC1812/13/14/15/33 multichannel Low-
> > > > Voltage
> > > > Remote Diode Sensor Family. The chips in the family have one
> > > > internal
> > > > and different numbers of external channels, ranging from 1
> > > > (EMC1812) to
> > > > 4 channels (EMC1815).
> > > > Reading diodes in anti-parallel connection is supported by
> > > > EMC1814, EMC1815
> > > > and EMC1833.
> > > > 
> > > > Current version of driver does not support interrupts, events and
> > > > data
> > > > buffering.
> > > Hi Marius,
> > > 
> > > For a temperature monitoring device like this, the opening question
> > > is
> > > always why not HWMON?
> > > 
> > > There are various reasons we have temp sensors in IIO but mostly
> > > they are not
> > > described as being monitors and this one is.
> > > 
> > > IIO may well be the right choice for this part, but good to lay out
> > > your
> > > reasoning and +CC the hwmon list and maintainers.  There is an
> > > emc1403
> > > driver already in hwmon, so perhaps compare and contrast with that.
> > > 
> > > I've +CC Jean, Guenter and list to save sending a v2 just to do
> > > that.
> > > 
> > 
> > At first glance it looks like the series is (mostly ?) register
> > compatible
> > to the chips supported by the emc1403 driver, so it should be
> > straightforward
> > to add support for the emc180x series to that driver.
> > 
> > Guenter
> 
> Most of the register address are compatible. The EMC181X is an update 
> (a newer generation) then the EMC1403.
> 
> The biggest improvement is that the EMC18XX has a continuous block of
> registers in order to improve the temperature reading (that means some
> addresses are overlapping with the older register maps) and a new set
> of registers to  handle the "Rate Of Change" functionality.
> Also the older EMC14XX has some hardcoded configuration/features based
> on the part number.
> 
> Considering all of the above I consider that the complexity of the
> EMC1403 will increase quite a lot without any real benefit and it will
> be harder to be maintained.
> 
Ok.

> I have submitted this as the fist iteration from a longer list of
> feature that I want to add to the driver, including events and maybe
> interrupts.
> 
> If nobody has anything against, I would like to add a separate driver
> for EMC18XX into the IIO.

IMO this should be a hwmon driver.

Guenter

