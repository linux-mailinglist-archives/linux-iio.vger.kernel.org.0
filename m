Return-Path: <linux-iio+bounces-23221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB8EB33F5D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 14:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4A320357F
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB55F24C07A;
	Mon, 25 Aug 2025 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fklSwtki"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A483393DCB;
	Mon, 25 Aug 2025 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124848; cv=none; b=XCxTLByWhoqzNKWPNmH2Nd+GDqWH5dGKwwj2LrkmT3yhyUEYJxS34Xlw9IyP0dXBWwX168VQAQIGbans2kyQLB41cAppuhFdYzSRma9Aj9EfGXydAA+M39qcWBkC3BK1/Ekx8+Q7t9TiuiNAZt7yRckt9TNIWVESAh/gisHEq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124848; c=relaxed/simple;
	bh=bB2BBjeQYcFX30BOes4Y1bCH0Q0+giwVHbW7JKqbAtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La3iEJqf4JcWHlw5WvY0K9bX+m3BGJ1Oo63ab/u7re5+dxK4Q8wMon2TIR0SOZ2SRx4LL/5MyU1LvWc4yfe2q46OdBRuBvGco57v3sXgMG3fR0AX2JAhtTnQaAN3E8srkmwAL7lpATKJ0CpHDYiu6g1xNwOWlUDJUvxYOrDfJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fklSwtki; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77057266cb8so856481b3a.0;
        Mon, 25 Aug 2025 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756124846; x=1756729646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXi7bf0DqbtoALNk3gsA/Oq6tMtY8GPJ60Snna89sM8=;
        b=fklSwtkijGcNTm+4PzIuEeQWaAzWjafL61vv0byn5zT108E8yfT8Jk/+hd7wUjxisR
         kZxC6DjgTpNCncHLOHGVSCnN2jylOEjKeOD+NGN9FfkyCBqoZG7VrURhv3xIi6UQNW41
         7s6py9rmZkuy9rQ+xmaSIfb+yPPy6EfWoov34hGJhdZglioZfb0FyjeKWo4SJKgiF90q
         tNZepG+EATKKjifM/t3c3QG7xI/3pCsO5QNEQne22679VpJnM50iTCtTuJ5HmZEABfSn
         +V389RXsj3Q4umXNasSATNeGokQv01gqf89ppZ5gQJh96rSc7YaJCzPKJ82JIj/y0vQh
         9N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756124846; x=1756729646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXi7bf0DqbtoALNk3gsA/Oq6tMtY8GPJ60Snna89sM8=;
        b=IKHRr63CyfVlzH0oWBkaprom1Sz/QkBlAIQO9rdNzAri8JoTAkgrtvzZhcJd/KGHyG
         23GHuviFx1iNwv8f22j7TEusOajLjpr3E2p+lMw5WvPdGsfXBhiBiDyPNI6Z5hlmOshj
         /jFVUOrdem6ebSyNTlppKBrMOg+lIB2eF3vOoeojx+X519hTcScSO0J3DWjsXhc+i15x
         bVURf05y0wWD9BUMtDg1CI8lFBOnvHGmeyDZozifvsQu3vT00zjr/TOm7YbeVUWw+y+B
         L3PpRs9MIfgBSN/ekpWJfFVgUcxk0c4fEY4vRIXO6AfpWrT+97M9AEAvkjlNu2rgqtpN
         NrTA==
X-Forwarded-Encrypted: i=1; AJvYcCUg7/iNqZeQpO6m5S5PVD41f6u4Ny7xgkA1949/aVxFu5UqA/pSMiQUxx/easy+EtHlAWR8dEUqJU4J@vger.kernel.org, AJvYcCUrenV+FFPpe2ENM4dI/0hPEQB46Hn1noIPNSxVypbF6szYzn0qGR/qQ/lkRMn8v3xXx/U344tOpyJJkoBz@vger.kernel.org, AJvYcCX4LdWR1lkfkX52kSpH7bLlN2mAavbEovMmjopZ3kNS5TfWn4YC6y6XZk6x8sPrcu6vhLVcMCtW/6yy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YKgHtsJNEjpPJ4NqBcdJrPjn1ERjgXXEwO7UZSHZ84NbzHTE
	M2WSFms6kObVCYsOMFIa9Sl77Ne4RhTZ1lK3UFIMCcQW8ErQww/oYxtYOv+P/ltx
X-Gm-Gg: ASbGnctLZwffeaf4P+2QOy+kw41iv8Ih8wA27Cpd/HDf612WAjbOKuA9i1A/0lr0baP
	DKhtz+5yZ6XFqyoAHeETHmZt0wJJAzVmVWESW1W1dNvkS+yl+MwX3Sa3BXPZ0NRKs3y0nG/0lOk
	tX7fesNQB0uYxHeqSgS4LL3NCrtkQ00R3hILUGAZZweMu0a7z/hpfqaF613zLzzu48jEfBOuCrq
	L5RbdefO3Trd+G7LzrhhqO3XAcOywl/3Tob6WCBwU0H4Yw/VLH6Il4ya6GKmMB9qmWmb1zAdM44
	s+XIIZQAgzwrwA6YFiNyNvMiM/143cuLZTI0wRonZMBdMsAyv40qAlQjqbqXI7GzsC8d1/Pyp+b
	p3ZHQq+e5LqsqwEg60loVwaT4Q+0weQ==
X-Google-Smtp-Source: AGHT+IGOl5xPM35uvecBghrRgaVxe6SOObYmovXPZI7OvSuX3FvhasuckJt94mKjqrPhSzLJh1+WDQ==
X-Received: by 2002:a05:6a00:398a:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-7702f9d8ebamr12968324b3a.5.1756124846108;
        Mon, 25 Aug 2025 05:27:26 -0700 (PDT)
Received: from localhost ([2804:30c:1f77:e900:8ef5:b053:b8a:9345])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-771e912e40csm1861121b3a.44.2025.08.25.05.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:27:24 -0700 (PDT)
Date: Mon, 25 Aug 2025 09:27:49 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/6] iio: adc: add ade9000 support
Message-ID: <aKxWxfbUNMFbZXvN@debian-BULLSEYE-live-builder-AMD64>
References: <20250822160157.5092-1-antoniu.miclaus@analog.com>
 <20250822160157.5092-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822160157.5092-5-antoniu.miclaus@analog.com>

Hi Antoniu,

This is still not a complete review, though, if going to re-spin, you may
consider changing a few minor things.

On 08/22, Antoniu Miclaus wrote:
> Add driver support for the ade9000. highly accurate,
> fully integrated, multiphase energy and power quality
> monitoring device.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
...
> +#define ADE9000_PHASE_B_POS_BIT		BIT(5)
> +#define ADE9000_PHASE_C_POS_BIT		BIT(6)
> +
> +#define ADE9000_MAX_PHASE_NR		3
> +#define AD9000_CHANNELS_PER_PHASE	10
> +
> +#define ADE9000_ADDR_ADJUST(addr, chan)					\
> +	(((chan) == 0 ? 0 : (chan) == 1 ? 2 : 4) << 4 | (addr))
Found it a bit hard to understand the reason why this macro is like that.
I wonder if a comment to help understand it but not sure. Also, couldn't
come up with any suggestion for an alternative. Guess this device's register
layout is just a bit unusual.

> +
...
> +static int ade9000_filter_type_get(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 val;
> +	int ret, i;
nitpicking:
unsigned int i;
?

> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_WFB_CFG, &val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_GET(ADE9000_WF_SRC_MASK, val);
> +
> +	for (i = 0; i < ARRAY_SIZE(ade9000_filter_type_values); i++) {
> +		if (ade9000_filter_type_values[i] == val)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
...
> +static const struct iio_enum ade9000_filter_type_enum = {
> +	.items = ade9000_filter_type_items,
> +	.num_items = ARRAY_SIZE(ade9000_filter_type_items),
> +	.get = ade9000_filter_type_get,
> +	.set = ade9000_filter_type_set,
> +};
> +
> +static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
> +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ade9000_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL, &ade9000_filter_type_enum),
> +	{}
nitpicking: these sentinels have been standardized to use a space between the brackets
	{ }
https://lore.kernel.org/linux-iio/20250411-iio-sentinel-normalization-v1-1-d293de3e3d93@baylibre.com/

> +};
> +
...
> +
> +#define ADE9000_VOLTAGE_CHANNEL(num) {					\
> +	.type = IIO_VOLTAGE,						\
> +	.channel = num,							\
> +	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AV_PCF, num),	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> +			      BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
duplicated IIO_CHAN_INFO_CALIBSCALE ?

> +			      BIT(IIO_CHAN_INFO_FREQUENCY),		\
> +	.event_spec = ade9000_events,					\
> +	.num_event_specs = ARRAY_SIZE(ade9000_events),			\
> +	.scan_index = num + 1,	/* interleave with current channels */	\
> +	.indexed = 1,							\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 32,						\
> +		.storagebits = 32,					\
> +		.endianness = IIO_BE,					\
> +	},								\
> +	.ext_info = ade9000_ext_info,					\
> +}
> +
...
> +		case ADE9000_ST1_SEQERR_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SEQERR_BIT >> 12,
> +							    IIO_EV_TYPE_CHANGE,
> +							    IIO_EV_DIR_NONE),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SEQERR_BIT;
> +			break;
> +		default:
> +			return IRQ_HANDLED;
> +		}
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, handled_irq);
> +	if (ret)
> +		return ret;
maybe
	if (ret)
		dev_err(&st->spi->dev, "IRQ1 write status1 fail\n");

	return IRQ_HANDLED;
?
So the IRQ always gets handled.

> +
> +	return IRQ_HANDLED;
> +}
> +

Best regards,
Marcelo

