Return-Path: <linux-iio+bounces-14459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FCFA15DF8
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F783A718E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C66192590;
	Sat, 18 Jan 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2za9chk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E4E78F5F;
	Sat, 18 Jan 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737216996; cv=none; b=Yrl3xhDC0Z8jF+pvyHxzFW4FWm+znPFai9rE7ADDnXg3UVb6EEuORDwmaRHiCUDXTX98q4Mt5L+VxQCF/d9Los9o56N2KpjMq4eJe8xFVH3loKIc+K7gU88OGwgvAyMbMNIdlq/f3gK4tKJJJZsuV8TM66Kn1/u1OuZRIzbX6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737216996; c=relaxed/simple;
	bh=EBwHZ6IrRVM67JhTm9px098OBiKa0SSLNpc44aKV/ls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9oHehcg5lJ35nkBJ+eSFUC/JDDWbVo4TTS3cdA/7DjYn6dHx3FBVMiCdwQb5bU1icuW1GRw+oDLsHYK1/HCa7Md+hPNAl7an3jBDbKPv4FtQQlOHXnAOx6hXyJ0w16jEYm0Xcj/Btaq/eNFtlx2vVPcxB7YTJCpUIheQ75yvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2za9chk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42DFC4CED1;
	Sat, 18 Jan 2025 16:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737216994;
	bh=EBwHZ6IrRVM67JhTm9px098OBiKa0SSLNpc44aKV/ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2za9chkTzONqnbk8Pg9tnuv8p1EdAV4HfNtfxFcfQ+uc62ouhSQwdxHTwleH3cp0
	 o7QqvvfJME03ctwBxkM8uCMqTEY99d336V9pLOA0wPU51QR7qOnvviODOY3PDAuuuE
	 hCdjVaHZcqSWxj9TW/YOGFp2yUnLuxi/ibGMRE6iRRWmZY1NAU9ho+qFuQ4sww47VD
	 CrXcTBJ7rQNVzFOnllxNKdsR43xecpnQPM5a63NtNB9c/S0VGWE/0NMRctptFmFAV1
	 JhKVcANKp/scmIg0mHS+bioDUsczNMt2QGFafd5OkyhPJ7ycSbzteJx5a7kKB64Frq
	 NxykS+OQYWj1A==
Date: Sat, 18 Jan 2025 16:16:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Antoni Pokusinski <apokusinski01@gmail.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrej.skvortzov@gmail.com, neil.armstrong@linaro.org, icenowy@aosc.io,
 megi@xff.cz, danila@jiaxyga.com, javier.carrasco.cruz@gmail.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: magnetometer: si7210: add driver for Si7210
Message-ID: <20250118161622.6b96f998@jic23-huawei>
In-Reply-To: <Z4jCz1VXVPtEDNqB@smile.fi.intel.com>
References: <20250115201622.270130-1-apokusinski01@gmail.com>
	<20250115201622.270130-3-apokusinski01@gmail.com>
	<Z4jCz1VXVPtEDNqB@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 10:26:55 +0200
Andy Shevchenko <andy@kernel.org> wrote:

> On Wed, Jan 15, 2025 at 09:16:22PM +0100, Antoni Pokusinski wrote:
> > Silicon Labs Si7210 is an I2C Hall effect magnetic position and
> > temperature sensor. The driver supports the following functionalities:
> > * reading the temperature measurements
> > * reading the magnetic field measurements in a single-shot mode
> > * choosing the magnetic field measurement scale (20 or 200 mT)  
> 
> ...
> 
> > +obj-$(CONFIG_SI7210) 			+= si7210.o  
> 
> Looks like TAB/space mixture in the middle.
> 
> ...
> 
> > +#include <asm/byteorder.h>  
> 
> asm/* usually goes after linux/*
> 
> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/math64.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/types.h>
> > +#include <linux/units.h>  
> 
> ...
> 
> Despite a good formatting I would still add a comment with a formula in
> math-human-readable form.

The rest of the comments are the sort of thing I might tweak.
This one not so much as I'll probably get the maths wrong.

Given where we are with the cycle (too late 6.14, too early for 6.15
beyond me queuing it up in testing for autobuilders to get an early lok)
we have plenty of time so I'd prefer to pick up a v5 with this comment
added and the other minor stuff tidied up.

FWIW I took a look at the overall driver and have nothing to add
in the way of review comments!

Jonathan

> 
> > +		temp = FIELD_GET(GENMASK(14, 3), dspsig);
> > +		temp = div_s64(-383 * temp * temp, 100) + 160940 * temp - 279800000;
> > +		temp *= (1 + (data->temp_gain / 2048));
> > +		temp += (int)(MICRO / 16) * data->temp_offset;  
> 
> > +		ret = regulator_get_voltage(data->vdd);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		temp -= 222 * div_s64(ret, MILLI);  
> 
> Including this piece.
> 
> > +		*val = div_s64(temp, MILLI);  
> 
> ...
> 
> > +static int si7210_set_scale(struct si7210_data *data, unsigned int scale)
> > +{
> > +	s8 *a_otp_values;
> > +	int ret;
> > +
> > +	if (scale == 20)
> > +		a_otp_values = data->scale_20_a;
> > +	else if (scale == 200)
> > +		a_otp_values = data->scale_200_a;
> > +	else
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&data->fetch_lock);
> > +
> > +	/* Write the registers 0xCA - 0xCC */
> > +	ret = regmap_bulk_write(data->regmap, SI7210_REG_A0, a_otp_values, 3);
> > +	if (ret)
> > +		return ret;  
> 
> > +	/* Write the registers 0xCE - 0xD0 */
> > +	ret = regmap_bulk_write(data->regmap, SI7210_REG_A3, &a_otp_values[3], 3);
> > +	if (ret)
> > +		return ret;  
> 
> Just to be sure I understand the above. There are two of 24-bit values or there are
> two sets of 3 byte arrays? How does datasheet refers to them? What does common sense
> tell us here?
> 
> > +	data->curr_scale = scale;
> > +
> > +	return 0;
> > +}  
> 
> ...
> 
> Overall LGTM, there is no need for resend as I believe the three things above
> may be tweaked by Jonathan. The last one can go even if there are 2 24-bit
> values, but ideally in that case we should use those as a such and apply
> put_unaligned_be24/le24() whichever suits better.
> 


