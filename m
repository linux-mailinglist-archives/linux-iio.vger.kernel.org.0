Return-Path: <linux-iio+bounces-14403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C02A142CA
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 21:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFDE169EBF
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA62361DE;
	Thu, 16 Jan 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFvQuXVQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE023243D;
	Thu, 16 Jan 2025 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057981; cv=none; b=o2fAZrT5QVXV2qCY/HYVwhlWzmST28oeXsRI9dbp7vVMf1ltXbC2MMGZPFvOoQD2H17NJ4G9Tw57tlgh4VUd7PhakMAgODj3x+GTkR3Jzo+34k/tqcGp/aMYGtCAdG6ZZItvX/uzTOqZ82pBsS0NjvWxOF4+RFFA5WFjqpmwfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057981; c=relaxed/simple;
	bh=GLGMKnHT3WJfJKUIeW6Onw/IFAiUQIIsoXJ7IG2GFNE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L96Lr4KY1QX08HryIutyEwX26ylg/sdqU8AeKexEbNoB7wLnRyfrDHgLR3OvM4bLvlvME8zVrDB/QJkqStXeDJTIdJPE6vZN0sENo+b8IW88Ryb1q6Q1Hma3aE9QZGwQeNVWKH1SowoUGS/k5CdGtZzeR9164b5dAymBUzsFAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFvQuXVQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so12735725e9.3;
        Thu, 16 Jan 2025 12:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737057977; x=1737662777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KA64jD3Buukkg5rIZGBFs0alua5iyaC4SBSUtwrxfak=;
        b=SFvQuXVQhG3g+oGoOcLXuVcnP5iG7boQhF3fGh1VIHYmA1t89ATKJYvfDNJw0AiNfJ
         /O/U7ys6PGdpHtuCkV/gHFnd74rT16LT8lJP34xeoQNIeuNaUvRnwGcv8UOmLDDjFxOl
         /DHluoM53PFegWQpZ7UZ4DmsojCTfMSDkYyJpE8pg0vR83RasBK/GStgFkCJvwSqWSGv
         cxU9uNKIFfCG2x2TGFd/BqYh8tPDOhaeJCsPWLcsa/avTarK9HfWKDTNz6hpO/XOERuw
         UxJSUNcAFKnnmT4ufBpE16PtSPiwCKJWLBkLFVBnG7pXywAg1Ytm03rLtLisicevv8Bc
         NEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737057977; x=1737662777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA64jD3Buukkg5rIZGBFs0alua5iyaC4SBSUtwrxfak=;
        b=BXxHoqntmlzT8ewsqa45XxeqWG6JW79UpKe7Pg5sHD8mdUf/VDOf7Ug4qtA8xndEu4
         eDvOHSHfFKDt6y8nhJFUiJl9EK0ltargOW3c8oK7NeIl3e3wx8x2tRmwk9QYygkCDEM5
         H/jqcXM1lngUqODab+d/CmaxlLQXmhpKZ9RpchplRNEoqJ+ZgWVtlq/mjv6huXNCK2s3
         ehPqfBUbbLazKNWq2bozCHrrzU4MudrJmDL6ZdCT+d3OeaO6t69mpvOyT05r9SB2R0fg
         IS6YlzcNVoIfsuz9GhiQiMFaRcWx0EkWCRCiOyPOgTOWxQwCL5CMGxHLnZlPmytiXFUy
         Soyg==
X-Forwarded-Encrypted: i=1; AJvYcCVW+lAjZcSqt6fUXchfSY8teYn6MvCFc/FHTTITg62xp3wVfOUs+Ai6jrWNZwbH0AxkWDuPiBIHsyf/CYBn@vger.kernel.org, AJvYcCVsmqNtwn/hfUieJ/yXRm5RZAX8bpCWiejtMSHWR0OVn0uJh5wk+jJ8ep5ysFif8cDhCAxjeXWFEUDJ@vger.kernel.org, AJvYcCWCcu+4jiCEG2kgYFnhPMMpKxpB/m+fDeaaCCWZnNCCingjHTbeHruJut+7B7dX/OwqEeRu0hyNUwRJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyvE9Ja3JZNNl1JKzt697uz1utmlvs49QpL1Gz2SaVahnlcVYle
	1y9Wd6ku2lMfuIdBZH0GsBLXuXAFbtkCMwBPlIu2tN2RYGpgNnm9
X-Gm-Gg: ASbGncuZVJQhK3C+02llGum554lRtguItR6rdMF/vzZP3d1caeqPMmI0y+LUJCPWcUY
	AnqUpCSornSMiDgCQgRW1mj1JgfbiGdum7KXEkVkKMzJUKp8bOCwQGU7jH2CKP9bYvdjESGSUTl
	6zy2f8x+Ne+y73FO1u0tbdwovA7QPspXC4DrCkIW+Xat3bSSNMaUp69MMG4WipLFTSGck28tsnf
	KeuVLrQ8EyBKioLvUiJyp+N77gvXpyhmrk2nYV0tdatIdiv/sQjBkblrimGTzRq7M6N7LUa2RWB
	dquzKqn1k51gzudmpnD/M+y2
X-Google-Smtp-Source: AGHT+IH/Nl8ZXLmN+OwqX2FWXpVEfDLGjeAsw6lOyJLbfz4NdXK3jc2a1GLVBxqN+XczGNpYlJqyUg==
X-Received: by 2002:a05:600c:1ca9:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-438913cb65fmr567945e9.7.1737057976341;
        Thu, 16 Jan 2025 12:06:16 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([37.161.111.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c749956fsm70283175e9.4.2025.01.16.12.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 12:06:15 -0800 (PST)
Date: Thu, 16 Jan 2025 21:05:58 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Andy Shevchenko <andy@kernel.org>, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andrej.skvortzov@gmail.com, neil.armstrong@linaro.org,
	icenowy@aosc.io, megi@xff.cz, danila@jiaxyga.com,
	javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: magnetometer: si7210: add driver for Si7210
Message-ID: <20250116200558.mr23jxpdpwyu62md@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250115201622.270130-1-apokusinski01@gmail.com>
 <20250115201622.270130-3-apokusinski01@gmail.com>
 <Z4jCz1VXVPtEDNqB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4jCz1VXVPtEDNqB@smile.fi.intel.com>

On Thu, Jan 16, 2025 at 10:26:55AM +0200, Andy Shevchenko wrote:
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

It's the second option: we have 2 arrays of 3 elements each (a0, a1, a2
and a3, a4, a5). In the datasheet the names of the values correspond
to the names I used in the driver, that is there are 6 values a0, ..., a5.

The point is that the their registers are separated by the 0xCD register.
Therefore I had to call `regmap_bulk_write()` twice in order to
write values a0 - a2 to the registers 0xCA - 0xCC and similarly the
values a3 - a5 to the regs 0xCE - 0xD0.

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
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
Kind regards,
Antoni

