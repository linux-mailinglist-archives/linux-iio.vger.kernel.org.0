Return-Path: <linux-iio+bounces-27181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64839CCC65C
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 16:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E5E2306CF43
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174152D24BC;
	Thu, 18 Dec 2025 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSZaBXm/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D32C21F7
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070181; cv=none; b=cdgguttl7uWW/aeLTcYqHwkSHKBcqfmW1MacF61K2NvK3CNCfwJ6V8WnOOvilBGwdINULv26G4X8EgvFUstFRxAiv+aslwomVAgpjwRGHjQYXPdC1AeAEGcDwZyg1hD2U3Fxkx/JCqzkvio+G41KjTB8JD7q59iaiWm3d4qw6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070181; c=relaxed/simple;
	bh=w0THe4Lp8brKdBJivpncKFOSxMmuG3qeA43zPqKvDqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr6EF471sH+K81KRSTLjSdN46eaIybDcF05XlGkZYEhzFzYpzMsciBwAJcJ3EKQDfbhBb5TJwN3Km7aTi12UaTUGPFM994DrhUFz0kuFjpZ75HIM7FjCQpZWRm5a1qy5K6ShQhRx5fVlOV5EI6UaX5jtc/4pcTPnWXcAyL5hqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSZaBXm/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d5c365ceso8833965ad.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 07:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766070178; x=1766674978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ+bJ8pyTlr1XYIP3IpwCQQATQ0QeMjZ+3f/m9PBBnw=;
        b=eSZaBXm/dtW9y71HkGxHAJ3SLVKQvKd2uSOXmMVGe14CjqaTnxdnNmVKhxLFcUhjZw
         8qvlGmb7XmafxRHk15pST9n0+oRSqJWre3V4TOGjczyGOsQf6JvPiH/nAcHUoAjevV+b
         8+1ggBLreNaYWTrgs4GlZ1EnAU4J5KRKFiWKatFE+QL/oAWljSjtSNPV/H+762Nc1TOa
         TyrNTGBZGwElisKFjEfYUMrbEDAN5BMUHgfoRunhOSAuxLkTVqngdU3qm9N8wMhzWEkx
         FSnVPiPMefB0BMP5dLi39M5nLav2c3DbcyqgmTdxI/LjSiVmMLC5N81UcRk4KrFz+p9K
         0VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070178; x=1766674978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZ+bJ8pyTlr1XYIP3IpwCQQATQ0QeMjZ+3f/m9PBBnw=;
        b=PWTOT36vcuuwoEOrX/RKpQSwKulgsPJBU84ThCm/YfzXkxOiYe9FoQsl0aia2LrKm8
         s7yFF5vl3CukBUu22tI4NN3b5oCm9cEbThxBwfWsr4LpnsJuAqwfVURKB5Fz8bAem9HC
         FZBLidugCRsuZHp7uDXg9C5bI1dZM7wkaLSjl8NdEngUE5VmbrkmeqfGRIYLpygG6pAl
         joyGcQmQrcGYCFYn6P57yw/vL7RJPK1Qmj/qU/us8lztqG9dymPsVMq4aOaPJbnZqmet
         linYtnroSJiTGI7u+PH+ooZz3UzPJw9xP/NJAbqW0B/SFq64jugV8DAME5WOsaMlq67B
         dhHg==
X-Forwarded-Encrypted: i=1; AJvYcCV9hCcJjncl5Hr0RjJXtPGTzuKWUCXwY4ncHp//NtCcO7zmSLeOmcmZui/LDwZhAFE15lYG9uzqlpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPwFkpDfMPIRIHfY3kicKqZY9aV2zLNyTiYT7cGwAWRqHDJA0
	mcFc8dssKEfuCQBhajBlch+yEwoC1mV9TeHZk8szGhMQ3uov5/z8n6Nq
X-Gm-Gg: AY/fxX7zas55aSNdGWlgzLxqymiKY+6P0ejOANgLAgn/+NBuRB3Ew5yWSK1CFH0v0XA
	B/AiM1Klf+zFpJ6H9H0isLSwJwcNKB6kXSN4EnoBf7h50sLPOrzQRN8lDdql1LzugIdj0rnxb7+
	QFOlnZRAW/csX5OyXobtXwhpacHX9zJtIUi7mePukleFeyEVnGrzesoe4iZCer00Ho4u4NYrucL
	mAq0jTfT82G5PrARxp8lqFzYo5gV/u1QBvayY5hyDmELzWAfAd5uFHL7clsQwtV6mxrPqAxud3d
	/8XuBw8OCUNMWtou1/Aw+Sal8w7cQAaeYPWzHQF/1/UdANyxzQd2lSpVt2Yo1B2iSHmDN9Y9v0H
	hIOA3mIHvjXJkvZKAZhHoP0+1SGiWurNP4t3MFi0L1GIJBjeoUUUh+orJ+EX/EXu142+zmLSd25
	5Kduim9HG00Mt2A6+NU4R+UO17KwYnuA==
X-Google-Smtp-Source: AGHT+IGEZgxlURlbc9BT6zUVww+KIhdG/P7myFVk8CEhf45jw4gx6KpSM7glhLqD7CAM4n2HprtcqQ==
X-Received: by 2002:a05:7022:7e0a:b0:119:fac9:cdb1 with SMTP id a92af1059eb24-11f34ac0a18mr16490521c88.20.1766070177283;
        Thu, 18 Dec 2025 07:02:57 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061fceec2sm8059249c88.13.2025.12.18.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:02:56 -0800 (PST)
Date: Thu, 18 Dec 2025 12:04:37 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 4/5] staging: iio: ad9832: convert to iio channels and
 ext_info attrs
Message-ID: <aUQYBdiYVy3sn0Nx@debian-BULLSEYE-live-builder-AMD64>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
 <20251215190806.11003-5-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215190806.11003-5-tomasborquez13@gmail.com>

Hi Tomas,

The updates look mostly good to me. A few comments inline.

On 12/15, Tomas Borquez wrote:
> Convert ad9832 from custom sysfs attributes to standard channel interface
> using a single IIO_ALTCURRENT channel with ext_info attributes, as this
> device is a current source DAC with one output, as well as removing the
> dds.h header.
> 
> Changes:
> - Add single iio_chan_spec with ext_info for frequency0/1 and phase0-3
> - Phase attributes accept radians directly, driver converts internally
> - Frequency attributes accept Hz (unchanged)
> - Cache frequency and phase values in driver state for readback
> - Remove dependency on dds.h macros
I'm not sure, was the dds stuff being used before this patch? Maybe dds.h
removal would be better as another separate clean up patch.

> - Rename symbol attributes to frequency_symbol and phase_symbol
It's nice to have a change log between patch versions. Though, it's usually
provided as part of extra patch info, not commit message.

> 
> The pincontrol_en attribute is kept temporarily with a TODO noting it
> should become a DT property during staging graduation.
> 
> NOTE: This changes the ABI from out_altvoltage0_* to out_altcurrent0_*
> with different attribute organization.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> ---

The change log is usually provided here, below the '---'.

>  drivers/staging/iio/frequency/ad9832.c | 279 +++++++++++++++++++------
>  1 file changed, 215 insertions(+), 64 deletions(-)

This patch fails to apply? I've tried getting it applied on top of current
IIO testing branch with b4 shazam, git am <individual patches>, and
git apply <patch4 on top of applied patch3>, but patch 4 fails to apply either way.
Couldn't figure out how to fix that.

> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 8d04f1b44f..454a317732 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
...
> +static const u32 ad9832_phase_addr[] = {
> +	AD9832_PHASE0H, AD9832_PHASE1H, AD9832_PHASE2H, AD9832_PHASE3H
> +};
> +
> +static ssize_t ad9832_write_phase(struct iio_dev *indio_dev,
> +				  uintptr_t private,
> +				  struct iio_chan_spec const *chan,
> +				  const char *buf, size_t len)
>  {
> +	struct ad9832_state *st = iio_priv(indio_dev);
>  	u8 phase_bytes[2];
>  	u16 phase_cmd;
> +	u32 phase_urad, phase;
> +	int val, val2, ret;
>  
> -	if (phase >= BIT(AD9832_PHASE_BITS))
> +	if (private >= ARRAY_SIZE(ad9832_phase_addr))
>  		return -EINVAL;
>  
> +	ret = iio_str_to_fixpoint(buf, 100000, &val, &val2);
Maybe I'm missing something but, why 100000 here? Should it be MICRO instead?

> +	if (ret)
> +		return ret;
> +
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	phase_urad = val * 1000000 + val2;
We can use macros to make it easier to read values that are related to metric units.
	phase_urad = val * MICRO + val2;
then
#include <linux/units.h>

...
> +static ssize_t ad9832_read_phase(struct iio_dev *indio_dev,
> +				 uintptr_t private,
> +				 struct iio_chan_spec const *chan,
> +				 char *buf)
> +{
> +	struct ad9832_state *st = iio_priv(indio_dev);
> +	u32 phase_urad;
> +
> +	if (private >= ARRAY_SIZE(ad9832_phase_addr))
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +	phase_urad = ((u64)st->phase[private] * AD9832_2PI_URAD) >> AD9832_PHASE_BITS;
> +
> +	return sysfs_emit(buf, "%u.%06u\n", phase_urad / 1000000, phase_urad % 1000000);
	return sysfs_emit(buf, "%u.%06u\n", phase_urad / MICRO, phase_urad % MICRO);
?

>  }
>  
...
> @@ -234,49 +322,110 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
>  						  st->ctrl_src);
>  		ret = spi_sync(st->spi, &st->msg);
> +		if (ret)
> +			return ret;
> +
> +		st->output_en = val;
> +		break;
> +	case AD9832_PINCTRL_EN:
> +		if (val != 1 && val != 0)
> +			return -EINVAL;
> +
> +		st->ctrl_ss &= ~AD9832_SELSRC;
> +		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
this would then be only
		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val);
so we keep consistency with previous FIELD_PREP() in ad9832_store().

> +
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
> +						 st->ctrl_ss);
> +		ret = spi_sync(st->spi, &st->msg);
> +		if (ret)
> +			return ret;
> +
> +		st->pinctrl_en = val;
>  		break;
>  	default:
>  		return -ENODEV;
>  	}
>  
> -	return ret ? ret : len;
> +	return len;
>  }
>  
...
> +#define AD9832_CHAN_FREQ(_name, _channel) {			\
> +	.name = _name,						\
> +	.write = ad9832_write_frequency,			\
> +	.read = ad9832_read_frequency,				\
> +	.private = _channel,					\
Since the DAC has only one output channel, doesn't it look somewhat misleading
to call private data _channel?
Based on data sheet naming, I'd call it _select. Maybe _fselect _psel?

> +	.shared = IIO_SEPARATE,					\
> +}
> +
> +#define AD9832_CHAN_PHASE(_name, _channel) {			\
> +	.name = _name,						\
> +	.write = ad9832_write_phase,				\
> +	.read = ad9832_read_phase,				\
> +	.private = _channel,					\
same here

> +	.shared = IIO_SEPARATE,					\
> +}
> +

Best regards,
Marcelo

