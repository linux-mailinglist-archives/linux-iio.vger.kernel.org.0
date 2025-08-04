Return-Path: <linux-iio+bounces-22244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC80B19A4D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 04:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF851743CD
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 02:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6D218ACA;
	Mon,  4 Aug 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkYnQFqi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67F3FC2;
	Mon,  4 Aug 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754275982; cv=none; b=G1G5Iolis2Ke5xV9FDZ3iUESw8yFMU1xs6rbLMxzrNsiTjTwfyUEgEwaYcfHb/UwfVF/vYXXQVYlCL5gNicxCcbO6KhftKbrCh9kutzIyx/BdhdB0war5BTUc+NyfECI3A4kLTlgoCTY191OmeWHLJU/CfMKjELZtqrA9IWWmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754275982; c=relaxed/simple;
	bh=aEuAQq8kmHVQzHuWJLCQRwRrV6d0VGs7169UdkEueU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMVfm2LP59ixYaUmRdSDIsy7Q0m+Ogt3TZlPow/YZHPWWU/jrRJrqS/+86Ywbog979JDEpXd2rmHz/ygVdbP838CqO4dbfQ8GHfDE1Mrl//4AdYmrKR3MYh15zY7Dauq2iXHVy7R3mIjXXEzjAg3hCwJQWOCOpfKiB5AXe2axxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkYnQFqi; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-879d2e419b9so2324592a12.2;
        Sun, 03 Aug 2025 19:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754275980; x=1754880780; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mZz47s9vvvlz1efv4qpFIBRc3iLB3T0uEvcuKMnmRVI=;
        b=DkYnQFqio0Gci4slYgr0o2JuxniU0zwx7DjO/IjorW/UODqDoF0LFVDN0c7MJ+RiGp
         RFfNoHO625IuzCuSLs8QkCn5inXVgnRtyy/CbSZSYIytCNdLE0Pg0EFPw3g8q0xJPaWN
         xpc/t47qEMqTjwUJ9WGZcol0zsaHL/BH4VZT1xVxCtcnoIjjcGIpSlh7Y8GEuFmbePrz
         mulDjHMvXvKU9faUPCoOVGF607vtt+dHZqwkz4E46NMEdNIL5IrOXWFOavWvMDN0DqGI
         xqUacy3fiU8iI+du6iNT4o7m0iNrLgHQF/TQdC88jCpd5datujy+EqUtku8W4FJyt5CQ
         olKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754275980; x=1754880780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZz47s9vvvlz1efv4qpFIBRc3iLB3T0uEvcuKMnmRVI=;
        b=p8QnCss0Lf3cx0IYAfUHUMNVHeGdMiSipEVJAJI8H04FjhEogOeC/w376VT57SbQSP
         lnKcOkwRgrr28sfUALDRPnxJFE36qg2MVJbSy0q3mHUmcpVK0Kiox7iT5r9x1XwchXMG
         OGAKqJzLZRZUjOJpsBthaDz9sV0uGwNIY72N1tCOq5HRHUiPsW3K4kROJqBqRFEu+T3c
         2HTWUDcR2OUCxeD9EUy2EurnKt3raYLTzhg1oVS1IS56GDf7vF0nufmdVQoMxOkHab4b
         BlBoqS2xgwssN1qVD8mF8oCqRBy/mnVpXIIbTk3zLN8cbgXTh43jhHwEigjEjRklxAMW
         WuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZMMZN1VZcm7DCNQI+VPkwVcFr04x0gETlP6VjmCL5SDuX00hChZGOs8DZ3hKRyI9PA+25FC+AXOXXD5RK@vger.kernel.org, AJvYcCW6Hr6KUPAVwN+l/j4MHVncF+KAp2doVSaC5wZCAmY/YoDRBpE3+kcCUlqL7scN5USHFOa2ax7kjnN2@vger.kernel.org, AJvYcCX+Q7EzQ5Q2H2oFkPngs96pENxDGvlBIpHK94AM/IIPCc1+Vrm/zQ1uv9tb+IsX5bejvzlAQgrtuqH8@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxW03AnJMwHiFh++eV02HQpTghW4hx32pQzLdqUjUkjUahvCn
	p4k5REwMVCrjKrq0i7Uu9Qn3xKT3v0MIsdwYX4AxIgQPDdF1kU1ifvy2
X-Gm-Gg: ASbGncsGtV2h+K+R+B4jR8UAW9q8CvzjggiFO0la3/0aqHYT0Nfe/nBdGHEgLcSMkV2
	r6pNGkz8EYvnS9wWh4AtrZX6lW5BoxBLBpejUQpFduX7BkxYnOLuMaRRqf8Jt1gvSwWLKN6o0be
	j6NIIT6YaqnJc7jeVjj4PAXGKwDzg15W3LEBTbtNtLrNKM8kpsrpTMfk5Sr4yS4YPz7BWipvhcE
	28Ayky+ZkpWi5n62CkGE2jcVSCpV5o/xMBIMIl17a9tbBdAowgV+61ly2SFEDLe+zwtMEfELn3g
	EkB9ISbd1aLfa+0j0UAnY/6ZcNb+etsSr/7e1NBtDuYXrbI8mIpQG392GVKcylnLrS/B13u+ll1
	p6DdxatJjEeCbbBoF/x1e0OI=
X-Google-Smtp-Source: AGHT+IErUZB9LZrbqlLndeaGIzqieJylAmt2jKppIDuRaVuw1+aOv40WDDzK1JZNem+DDFUgbpDgaQ==
X-Received: by 2002:a17:902:f651:b0:240:22af:91c7 with SMTP id d9443c01a7336-24246f593b9mr101990785ad.14.1754275980269;
        Sun, 03 Aug 2025 19:53:00 -0700 (PDT)
Received: from dixit ([2401:4900:1c43:eb01:acfe:5fdc:edb4:dbec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a917sm97151305ad.116.2025.08.03.19.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 19:52:59 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:22:51 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magnetic Sensor
Message-ID: <aJAggwXNFsg0vA5H@dixit>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
 <CAHp75Vdc7RB8MG+jYcSxkvD2EY2weZJMnvkbgmqibYGLkcUEBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vdc7RB8MG+jYcSxkvD2EY2weZJMnvkbgmqibYGLkcUEBQ@mail.gmail.com>

On Sat, Aug 02, 2025 at 10:53:30AM +0200, Andy Shevchenko wrote:
> On Sat, Aug 2, 2025 at 8:44 AM Dixit Parmar <dixitparmar19@gmail.com> wrote:
> >
> > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> > applications includes joysticks, control elements (white goods,
> > multifunction knops), or electric meters (anti tampering) and any
> > other application that requires accurate angular measurements at
> > low power consumptions.
> >
> > The Sensor is configured over I2C, and as part of Sensor measurement
> > data it provides 3-Axis magnetic fields and temperature core measurement.
> >
> > The driver supports raw value read and buffered input via external trigger
> > to allow streaming values with the same sensing timestamp.
> >
> > While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
> 
> the sensor
> an interrupt
> an I2C
> 
> > configurations interrupt(INT) is not recommended, unless timing constraints
> > between I2C data transfers and interrupt pulses are monitored and aligned.
> >
> > The Sensor's I2C register map and mode information is described in product
> > User Manual[Link].
> 
> Replace Link here with 1...
>
> > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> > Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf
> 
> ...and add space followed by [1] here.
> 
Orginally it was with [1] only. But I thought I should use known standard tag here
so came up with link. For my understanding, what is the standard practice for this?
> ...
> 
> > Changes in v2:
> > - Drop regmap implementation in favor of using direct i2c APIs to
> >   have uniform communication APIs across the driver.
> 
> This I don't understand. I mean the motivation behind this. Usually
> direct I2C communication is used to do some initial checks and
> configuration and rarely for the actuall run-time driver
> functionality. Otherwise it means that the regmap may be used with a
> customised read and write methods.
>
On addition to what Jonathan explained, reading from sensor also is not addressable.
i.e. To read any sensor register the read op must be performed to read starting from 0
always, without specifying reg address.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

