Return-Path: <linux-iio+bounces-26955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7C6CAE341
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 22:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B603304E564
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 21:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D692DD608;
	Mon,  8 Dec 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFvOCcKr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC4281341
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765228616; cv=none; b=SZmUhnKkT04Fu6tXp7sFV2onVq2gb+DNZaDMB5ioH1byQKUu7Lw9dYyynwRNzsHvCIJDv9/V5jaxYiiN9qZvnv4Po08j3oROK+XbONouXWJO9QjsPNXUpUIaIhWZOAUjyqTsPBJQB88CzgQj/BtYskA54tA+bcp6mCiyeQzZGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765228616; c=relaxed/simple;
	bh=aTp6s8SOajX1loYMMUVMEVq/+ub0M7yL7CO4E/6jnR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPwcseKmCmPMydVKYA9wEury27SX2V70Y5oo1De01Zk0xd1pYeDIJPYZXcQ0NFjyeX4T+mH4WvoZHWzHmZV1BUZQUr46PLaxTK4tyWBzHyQmqpAiGV0mRnsBdCZfBhx/rXqYrSwljuMEFbhk882D49UNQpnNubp0kcL/b4fCbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFvOCcKr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779d47be12so44386655e9.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Dec 2025 13:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765228612; x=1765833412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1QXqfDHNutyIta4OGfol2oPFrTaak/Tfgf2D3NkaM3c=;
        b=ZFvOCcKrbtGDG/qmBLKyFmvXE+8mV1IpLrZTgfGjTIdf2s62lT+90X8pmcFM8Jifm/
         LXccsJb1CGaE8PWcYqpHZtbZHyZ1Hsku+XJxagqZ1y0ItAQbQoltbPP8aSS128Fuv8Vb
         6Ar9S7wKZtbkIa8VhqJ0Rv53T8TOG82dST5XQ6QzpSQif8pytUXX9qyal6g+gRBAvWY4
         JxmTFM/cMWDWe2wQ6NRbxOzQzHQci772hdcwyqIwCRiHT+33xsXKOmUBalW+5cXCFlTF
         Vm+5XmWXIgmRJ/noDQfRTL0AyBKoosFDpYftonXfoDA7olgxkT9CbkUTy10F33rnHy2H
         gKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765228612; x=1765833412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QXqfDHNutyIta4OGfol2oPFrTaak/Tfgf2D3NkaM3c=;
        b=UixCFRb1zcbfAzWqD9kKvIKa/7yDX1cHBviQ1CTDBETPnrckJOXT/ksHEqQB2wcKrw
         g6Lu8LRjbq7ecZKUi/oDz8YmO5Y2oLTUO+TFEtP5ESxENUJ7cyKDfxxl1SnuxaGDJBKM
         1QfG5CQyQjbTPOfIDbneNSRxaNucT1IlghKU+aDXMqY/EZao26koCyoM+SQBLdOoQ2oU
         S2n7aLq+F77yPVrazPPAfRW05lFiPEE8DMMzW/htF8EKtuLyYoKiniE/wVL5NUu6Gz5r
         G2T9KOnZ+k/UGcwRdMdyUe4Dr0buYUiIL1Um7PoamhDP7MAWStIu4Brr9yhIfsrH2DN/
         GJwA==
X-Forwarded-Encrypted: i=1; AJvYcCWLekKKVuDeRBP5av6Gz4St73s+yDJykLeEUjGaExKY4sEQsyZ/brTOZ7prLuLJTu6CzgWqmrE6tEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+n1wkUbyLSl0vHZSIY8eVowfMPrwE8HovE8fda1dLOBZlTEgX
	DalkZfDXC1AoqEc9HSeR85Yp+jVSk1EWOl4eAdQY2AJFLMY/Mp9OV2pU
X-Gm-Gg: ASbGncvvgLYqlujt2kUu8S5N297+zRvtIGvexLJxIQWlS8OtrzfcL4JoNegULHGzcb3
	mA5vQ9WN7y9Q4z94Qwu4ohvQ/JaLA4FyQn2Yd9pnxfu2zxwd9A3+e+AF27qdlaWUHAwtVl33UKm
	YtIKXmxA75+oCmJeZ68B0IF3CEJBmPnfrWcyTRVvHMZ0GqwPSCN5QCGg9qPT51gvk8xNUWKSyf2
	w2bNI1LKCP5Mb0/v1lwFTo6xi7nLIG5NYjlzz78UlW8bgeEO0N4/hq9xchoSl8E5zS2V8FAax2q
	FVZBljel7YYtoJi1s6gIm6zHCeWVz9RsrHnOdRL8Ai7EhRkLgY9MsLdrRnh4j4RN/Xue4mdj3rx
	tsrOo4Q9zyaQ5jgSM/10pRs74o/AOsEFpOQ2/OfSfl0MDYFFCPeJ/NIoGZfzrdtkNiYphAtIn8Y
	bzBIcQx1F9rKQr/oNreKClzk9eiJzFLgbjrvObpDpNx4JABbvH9sKgv+GC3XQ+dyf5TDwfe3mkA
	2IImw==
X-Google-Smtp-Source: AGHT+IGCE5UzYrl8pkDkRLcq1d5zP7aR+wQ6bk6Bx1MWYRaV0fOZoJKajnRj+Uy5J+cjFXmvlWqpjA==
X-Received: by 2002:a05:600c:1c10:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-47939dfa487mr95372755e9.9.1765228612306;
        Mon, 08 Dec 2025 13:16:52 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1226:7701:cdbc:9893:8abf:1309])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d2e7110sm3983905e9.0.2025.12.08.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 13:16:52 -0800 (PST)
Date: Mon, 8 Dec 2025 22:16:35 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 3/9] iio: adc: Add support for ad4062
Message-ID: <krbiav67bscvqs6bumx5ay5tk4axeuc4z7gbn26nxgaoqrdfiz@dqzqpgcpclnz>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
 <20251205-staging-ad4062-v3-3-8761355f9c66@analog.com>
 <20251206173459.727fb3f5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206173459.727fb3f5@jic23-huawei>

On Sat, Dec 06, 2025 at 05:34:59PM +0000, Jonathan Cameron wrote:
> On Fri, 5 Dec 2025 16:12:04 +0100
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > The AD4060/AD4062 are versatile, 16-bit/12-bit, successive approximation
> > register (SAR) analog-to-digital converter (ADC) with low-power and
> > threshold monitoring modes.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Hi Jonathan,
> Hi Jorge,
> 
> I replied late to some of the earlier review discussion as I've been
> away.  Make sure you check those as well as this review as I may have
> forgotten to repeat something here.
> 
> Thanks,
> 
> Jonathan
> 
> > +#include <linux/iio/sysfs.h>
> 
> What is this here for?  It is not needed in a typical modern IIO driver.
> (One day I hope to finish getting rid of the remaining users and drop this
> header!)
> 
IIO_DEVICE_ATTR_RW for events/sampling_frequency in the events commit.
I will add only add at that commit.
> > +#include <linux/interrupt.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/math.h>
> > +#include <linux/minmax.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <linux/units.h>
> > +#include <linux/unaligned.h>
> > +#include <linux/util_macros.h>
> 
> > +static const struct iio_scan_type ad4062_scan_type_12_s[] = {
> > +	[AD4062_SCAN_TYPE_SAMPLE] = {
> > +		.sign = 's',
> > +		.realbits = 16,
> 
> Not 12?
Yes, and for burst avg mode, 14 bits.
> 
> > +		.storagebits = 32,
> Given we are doing data mangling anyway why not store in a 16 bit value.
> 
> BTW it would have been easier to spot issues with this if you'd introduced
> the scan type stuff with the use of scans in the patch that adds buffered
> support.  So please move this stuff there.
>
This can be done, just note that for ad4062 in burst avg mode the
realbits is 24 bits, so the storagebits is 32 bits only on that case
and will requires a few conditionals to handle just this case.

To not overly complicated the logic, for ad4062 I will always read
32-bits still. st->reg_addr_conv then takes:
	// IBI Fallback
	st->reg_addr_conv = st->chip->prod_id == 0x7C ? AD4062_REG_CONV_TRIGGER_32BITS :
							AD4062_REG_CONV_TRIGGER_16BITS;
	// GPO IRQ
	st->reg_addr_conv = st->chip->prod_id == 0x7C ? AD4062_REG_CONV_READ_32BITS :
							AD4062_REG_CONV_READ_16BITS;

Then, for sample size:
	const bool is_32b = st->chip->prod_id == 0x7C;
	const size_t _sizeof = is_32b ? sizeof(st->buf.be32) : sizeof(st->buf.be16);
instead of
	const bool is_32b = st->mode == AD4062_BURST_AVERAGING_MODE && st->chip->prod_id == 0x7C;
	const size_t _sizeof = is_32b ? sizeof(st->buf.be32) : sizeof(st->buf.be16);
	+ extra st->reg_addr_conv_avg that may or may not be equal to
	st->reg_addr_conv.

Note that the header section of the I3C transfer (8-bits) occurs
at 1MHz, while the reading in 12.5MHz. I wouldn't go as far as say it is
negligible, but for the part, protocol and software overhead, it
wouldn't provide ground-breaking higher effective maximum
sampling frequency.
> > +		.endianness = IIO_BE,
> > +	},
> > +	[AD4062_SCAN_TYPE_BURST_AVG] = {
> > +		.sign = 's',
> > +		.realbits = 16,
> > +		.storagebits = 32,
> > +		.endianness = IIO_BE,
> > +	},
> > +};
> 
 
> > +
> > +static const struct ad4062_chip_info ad4060_chip_info = {
> > +	.name = "ad4060",
> > +	.channels = { AD4062_CHAN(12) },
> > +	.prod_id = 0x7A,
> > +	.max_avg = AD4060_MAX_AVG,
> 
> This is a little confusing. I guess it's the maximum register value, not the
> number of samples averaged.  Perhaps rename.
This isn't doing much, I will just replace with the value and bump the
type from u8 to u16.
ad4060 max_avg:  256
ad4062 max_avg: 4096
> 
> > +};
> > +
> > +static const struct ad4062_chip_info ad4062_chip_info = {
> > +	.name = "ad4062",
> > +	.channels = { AD4062_CHAN(16) },
> > +	.prod_id = 0x7C,
> > +	.max_avg = AD4062_MAX_AVG,
> > +};
> > +
> > +static int ad4062_set_oversampling_ratio(struct ad4062_state *st, unsigned int val)
> > +{
> > +	const u32 _max = GENMASK(st->chip->max_avg, 0)  + 1;
> 
> One too many spaces before +
> 
Here just
	const u32 _max = st->chip->avg_max;
...
> > +		.data.in = &st->buf.be32,
> > +		.len = sizeof(st->buf.be32),
> > +		.rnw = true,
> > +	};
> > +
> > +	ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
> 
> Rafael did propose a cleaner way of doing this. I'm not sure if it went
> in during the merge window or not.  Take a look to see if it anything
> has been added in the PM pull request (IIRC Rafael converted all existing
> users to the new scheme in that patch set so should be easy to find.)
> 
Yep got merged.
https://github.com/torvalds/linux/commit/ef8057b07c72a817537856b98d6e7493b9404eaf
Will do
	PM_RUNTIME_ACQUIRE(&st->i3cdev->dev, pm);
	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
	if (ret)
		return ret;

> > +	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4062_set_operation_mode(st, st->mode);
> > +	if (ret)
> > +		return ret;
> > +
Best regards,
Jorge

