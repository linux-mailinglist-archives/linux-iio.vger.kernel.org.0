Return-Path: <linux-iio+bounces-23076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 964A6B2EB9A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 05:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5721C80034
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 03:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB182D480A;
	Thu, 21 Aug 2025 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlbgpzV9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B572625;
	Thu, 21 Aug 2025 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745357; cv=none; b=JIjmdSiCFX3GE4xCKkDaNVUjFMzclWc9PNfEyF8fm6w0UV82bs7LOTlrl6hj6lKAGVtxLV/K4Tm1r0ZXLo02b4fwTWDcQ5KzJMGegq3XaAFMnv6up1VchyOMSBv5dwNPcMdXDHBUzsVA2tJzyTWyaoOfxaoqsg+s+VogCGo50LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745357; c=relaxed/simple;
	bh=bWMVrNOVfPMX3DncgMd1dbvhJtqrq/a1s1GPAm2XBfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQFIksUh771u3hzq5/dS3iYnL1Lne3m6th1rMU8jYsPZYcKsFGTHql/ZB5wJHe0wz/Y1sFNZPyXEAN+cUYSwPKLiwA/OcTArtF93zbg3VtkJOMnIHmR4jE5ITZUuBAy1lty0p/uVEAeRhNjt2C9Q+RyajoFFeBWD7Yvzg+Yk2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlbgpzV9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4746fd4793so418014a12.1;
        Wed, 20 Aug 2025 20:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755745354; x=1756350154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+yNnJl0nmiMyeV3J4ApUboB+WgBDUAw4zuzTjk6SvA=;
        b=UlbgpzV9uzD5CuBFGeplDEcEkDNdsy1F/hK4zix4omoLEQnByi95PXtLfwi5RVqmfM
         1HCxI+3mkeU6g66HLrhC2Qhl1NJdQit8tuo049cH0Pw4ZJpautKvNKbmysYF7jv/SS3b
         WGaYWVAP8HB9P3WoT6HSXUUK86vgXkKVAkEFMQt/LHhbKkvSOTNuT3d2CJcc2d6vLF9N
         75Tmf37AS6yT6hdJzqUPrGtfncSO3LfnucsSj7fyQktLCs+1bxRibbTxs0LWmu5Wcfqm
         JuMa73SniAUmsnbn0XnfgibKVu8odL5nxcqKKO8KFTY+d2y7Yy9wz6yW8sRcpu2DXcXZ
         94bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745354; x=1756350154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+yNnJl0nmiMyeV3J4ApUboB+WgBDUAw4zuzTjk6SvA=;
        b=u8DSm7eHaoNFRj/6umZhq85KTLwCGWBTp1NYeyUNFUV/9eBtvdCj5UpjVNekFFR6sl
         t4Y4kYVxCmOimwuDRttIbV+SW49AYTdBsF4HZ4zxmP0gBOFkJXkfyScsERsXOvoCxiYQ
         6zNTSse4xtsX+PJSQRQyed5OLvgZ9ibE2+Dw8zLMIzqfzcrDw5c4qpiDV7Rdr33NqkjN
         WhiQULca5ZZ2iZYima28uXEStRFyBwll2soLojumyWLJe6jJaGANbLBB3FGucGYv53Ft
         XnJ9l/BPtrqOHrP1jAioaY2rG8iNyBQ31y1CvFv4Ty34VcutoC1KJoZo74uL/52x6ejh
         JYXg==
X-Forwarded-Encrypted: i=1; AJvYcCU8paxaw9mjGwLbqnhh573E2jrkRHLu/5qg7KeqPRIFRj6XOiYzkPBexAZp/9ns2mvXbOOccHSNPeFW@vger.kernel.org, AJvYcCVWdETt1ybXJfeWiwQPplzwk4nMkPESTYvXrwaFrDZFe1/7aeyujK5gkGkRxhQ6YuSQ95DkdCijI3m5@vger.kernel.org, AJvYcCXajO6aQGbHiHjZ236LuyFbNNfJXOH0mzmXvhls1z8vsXcyVJCJFBv40mLtCdMo4Wdv3okcNFhGRqEkTqeD@vger.kernel.org
X-Gm-Message-State: AOJu0YxMDk/5sdRd1xmI6Y0H5eN3MSvwS7Agm3YJU+kWd0ak3lcOAARe
	7VW2uzonN9SLuAksFLvJU6/J/awJhAsp0WFvCU7ef+jw3PU6yIVsxTpl
X-Gm-Gg: ASbGncunXbTIPJEcGnWRREN/xxb8KU/GxmQ4ssSBUvvfHq9ZL3rSkzEGBq0vrvltUr3
	NhOmgGi2YcOhFaoEFHNg5x4UExeJt+stzG0FvH59N4k+LHhsDcQxCrGPD/vBVppPJ92Rbl/CLTZ
	ICOmIAoU4KUGtejHz8pamd3KKVfB+7WlCTPz54aJxOFjiGgBoqI29ilUF3rLm9IOCEWBArvSwXf
	sLwc0ApEwj/Zu5pyUn7ZRPFBtIpL/p84aMO058c6gdlFwIeavfyqfwiQRkAer+DpANi6+Ftnopg
	KES/2ed6t2fjmrpPr3F/VJEzZDqYqPjkQSlhGtKQFj2nScF4nXvV7Ijxh9/KJck5BeE/JZIvwjw
	DM7KUsYZ1Dqpb89MWR4XWlJ3gzPxMy2wG
X-Google-Smtp-Source: AGHT+IHfM2PkU1zBKQT67Gn7RDeJ+jOs085eGJGUm0+KZox6BjbABkR+OV3JkYCr0UnDrl7z+SF6nA==
X-Received: by 2002:a17:903:1a43:b0:240:3dbb:7603 with SMTP id d9443c01a7336-245fec1314amr14154145ad.19.1755745354248;
        Wed, 20 Aug 2025 20:02:34 -0700 (PDT)
Received: from dixit ([2401:4900:1c7e:c20:1722:fdbc:50da:3590])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed376f6asm40512715ad.64.2025.08.20.20.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:02:33 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:32:20 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <aKaMPMnGRyvKqTny@dixit>
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
 <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
 <aKXW5pGiN18DyIZ7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXW5pGiN18DyIZ7@smile.fi.intel.com>

On Wed, Aug 20, 2025 at 05:08:38PM +0300, Andy Shevchenko wrote:
> > --- a/drivers/iio/magnetometer/Makefile
> > +++ b/drivers/iio/magnetometer/Makefile
> > @@ -23,6 +23,8 @@ st_magn-$(CONFIG_IIO_BUFFER) += st_magn_buffer.o
> >  obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) += st_magn_i2c.o
> >  obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
> >  
> > +obj-$(CONFIG_INFINEON_TLV493D)		+= tlv493d.o
> > +
> >  obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
> >  obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
> >  obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
> 
> I haven't got the ordering rules here and in Kconfig. Can it be alphabetical?
From what I can see, the order is alphabetical based on the CONFIG option in the
Makefile and Kconfig, and I kept CONFIG_INFINEO_TLV493D after CONFIG_IIO_ST*.
Isn't it in correct order? or my understanding is incorrect?
> 
> > +static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
> > +{
> > +	u16 val;
> > +
> > +	switch (ch) {
> > +	case TLV493D_AXIS_X:
> > +		val = FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 |
> > +			FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4;
> 
> Wrong indentation, make both 'F':s to be in the same column.
To have 'F' in the same column, it will need spaces after tab (I think its not
advisable to mix spaces and tabs). With just tabs the second FIELD_GET will be
align to 'v' of val. What will be the correct indentation?
> 
> > +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s16 *y,
> > +				s16 *z, s16 *t)
> 
> Indentation issue. Please, check fully the code for such issues.
I followed the single tab after default as suggested. At which column the s16 *z should be align to?
> > +	/*
> > +	 * Poll until data is valid,
> > +	 * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TEMP should be set to 0.
> > +	 * The sampling time depends on the sensor mode. poll 3x the time of the sampling time.
> > +	 */
> > +	ret = read_poll_timeout(i2c_master_recv, err, err ||
> > +			FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_REG_TEMP]) == 0,
> 
> Please, resplit logically, i.e leave the condition on the single line.
> Also to make it shorter you can use '!' instead of ' == 0'.
Having both conditions in same line will go out of 80 char length limit, even with !.
Is it fine?
> 
> Just wondering if you have tested for negative coordinates, does it propagate
> correctly?
Yes I have validated, it reports correct negative coordinate values.
> > +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> > +				pf->timestamp);
> 
> Interestingly that you have used 100 limit and suddenly don't do it here
> and maybe elsewhere. Why inconsistent style? Please, go through the whole
> file and make sure the style is consistent in all of the aspects:
> - C style used
> - comments style (one-line and multi-line)
> - indentation
> - etc.
I tried to follow 80 limit(except few places where it was just on border or not
clear to read). I belive the standard is to use 80 limit(correct me if I referred
wrong place) and I will recheck to meet that.

Thank you for careful review,
Dixit Parmar

