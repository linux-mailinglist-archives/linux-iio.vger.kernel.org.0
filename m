Return-Path: <linux-iio+bounces-12255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5684B9C8BCD
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 14:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1692B283375
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 13:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B815A1FAEF0;
	Thu, 14 Nov 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hODF3/e9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D251F892A;
	Thu, 14 Nov 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590873; cv=none; b=JlLNoS4a7+YZQSjGIkAMvW3evRO05eEOM/byQMZf01HJSfCsxqJABDU5yHUfFSGP53VEoOwl7IYikUz6QC2SICVXkcTjJ3L5avVGmt1q8DiQDb3LqSmReIxeUUhDUTcSxOp4fQ+Y9pYbLMTvr7tLL+5ah3wFMKkg5jAbXCz1qIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590873; c=relaxed/simple;
	bh=ky05wBui/UUMyIppkUyYaFIS9tjMUZWuH8y0o8wOrMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hFAnlCant50XkJlqTOFrYilN5yBjv5S35jSCFBSKpH5tn31EVdy7mVg4an+4ur8E+ziOXVlU9pGNe8/aJfGqWGY0Iq+sbPt+Xw24Nx2JeNG4/0amXrMwpa2ierEVCIGjcb5/VEI3niUQqnxfFRRa4lytLxvwhYpEZoKvi8t4cB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hODF3/e9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so775718a12.1;
        Thu, 14 Nov 2024 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731590870; x=1732195670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FxK1pZMle+UL0Q3Fj0BL45qPqGkV4zQA1+MO9PYETzw=;
        b=hODF3/e9I5z23J2Uiq1kScM6XjPBkmvJG1JVTPfTljhgl9wUrVVuzx3z5EqTeAECGT
         aY1SkUwUe8FDqZuZ+6s8GDW7RmDUiKiUzaNcWVyyk+q0ANg8EK6sN9EI05m/r+8YEEme
         OYn2cHSOhfTpK0HF5+1eDQwy55C4n5eRLX6QlKhlzEvms2oseJzrOn8svVFRq6txbG/7
         seTpfTynWdN5RY/XnjvvA+obm6SmFWVMWpeVnFvhPzeIQty6Ra8sQk/Qq+0WzTPvP0n2
         6H3JT8pW8x5KfqC3qx3O321NgW9vYKHus/HqqY8PwJ6+8Ef7F/YWqPd1a6cMFTU8XGOY
         PJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731590870; x=1732195670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxK1pZMle+UL0Q3Fj0BL45qPqGkV4zQA1+MO9PYETzw=;
        b=MM+v3fSlyQt7BHt6KUU4admuwwsjzb427eEIyjmmpyrz9smGWUE2lL79Y6N8WY2t1E
         HCjoc1CWX0k0mA0xf446pRN4u5GNRHjQm3diieLD4N6WPhxVWeg8gw0XKQ2oIX+u07QO
         JjR/NAQeEqQF3YLY8erdKxkDKHhDAhp0q8xBE34hXQ/u6BS0mhm3MNj8AVUfGDpsiw86
         0LkqYf+A91zqg2kAdQ9fR/KmGCde7m1lbyQDwFu+C7ClySzef5t+ZqalgRSwjakc0yCA
         k9rS/yQp1AcEVOe5W8srE0WheYStJkpw5YkzLduO61Atj/iQmz+EG1BWW6bEQPEy4U4J
         YGOg==
X-Forwarded-Encrypted: i=1; AJvYcCUFJFnBnILh2ie2gNekYjLCGOID5kyTbPrTSxEGBO+Q7TrRWj2qEf2MlIpCK+tzSDb29WPbZhB3iaEv@vger.kernel.org, AJvYcCUsSWOmVm+ESlv3oA9criDYxnnKYhCEy1/3mgbQChlhVXIUbBiasFhXaUsVtLLndQEJr/YO7UQ2uzjNbKRG@vger.kernel.org, AJvYcCXLNc6Sx17V7HBPljQi519hrSlj8FvFJGx8fktmvbQBYL8UsiUaaPLOxDRjLsBWujG2KNBfNCRhCoYN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuw5EmCQGGXlXYGaIRswt74rV26uN5zaLCTRFlQJefpy47ayeN
	vw9WEl/vVee5lA+oh/DBobLyzwfWMJIEf1Oy3ClbmjIVat7IAKIP
X-Google-Smtp-Source: AGHT+IGHbL+BSPGMqby2mGliTRrC/BuidS4eATyHTzk4jKxlhsmO0wKuLHdVYBDD8P1ndwGH6GhpkA==
X-Received: by 2002:a05:6402:510f:b0:5ce:af48:c2cc with SMTP id 4fb4d7f45d1cf-5cf0a43fd2cmr21514266a12.27.1731590869797;
        Thu, 14 Nov 2024 05:27:49 -0800 (PST)
Received: from [10.10.40.97] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79a44a9dsm608555a12.0.2024.11.14.05.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:27:48 -0800 (PST)
Message-ID: <b56089e4-ee82-4685-9da8-69cfb6471ec0@gmail.com>
Date: Thu, 14 Nov 2024 14:27:46 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: frequency: Add ADF4382
To: Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kim Seer Paller <kimseer.paller@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114130340.7354-1-ciprian.hegbeli@analog.com>
 <20241114130340.7354-3-ciprian.hegbeli@analog.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241114130340.7354-3-ciprian.hegbeli@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2024 14:03, Ciprian Hegbeli wrote:
> The ADF4382A is a high performance, ultralow jitter, Frac-N PLL
> with integrated VCO ideally suited for LO generation for 5G applications
> or data converter clock applications. The high performance
> PLL has a figure of merit of -239 dBc/Hz, low 1/f Noise and
> high PFD frequency of 625MHz in integer mode that can achieve
> ultralow in-band noise and integrated jitter. The ADF4382A can
> generate frequencies in a fundamental octave range of 11.5 GHz to
> 21 GHz, thereby eliminating the need for sub-harmonic filters. The
> divide by 2 and 4 output dividers on the part allow frequencies to
> be generated from 5.75GHz to 10.5GHz and 2.875GHz to 5.25GHz
> respectively.
> 
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> ---
>  drivers/iio/frequency/Kconfig   |   11 +
>  drivers/iio/frequency/Makefile  |    1 +
>  drivers/iio/frequency/adf4382.c | 1825 +++++++++++++++++++++++++++++++
>  3 files changed, 1837 insertions(+)
>  create mode 100644 drivers/iio/frequency/adf4382.c

...

> +static int _adf4382_set_freq(struct adf4382_state *st)
> +{
> +	u32 frac2_word = 0;
> +	u32 mod2_word = 0;
> +	u64 pfd_freq_hz;
> +	u32 frac1_word;
> +	u8 clkout_div;
> +	u32 read_val;
> +	u8 dclk_div1;
> +	u8 int_mode;
> +	u8 en_bleed;
> +	u8 ldwin_pw;
> +	u16 n_int;
> +	u8 div1;
> +	u64 tmp;
> +	u64 vco;
> +	int ret;
> +	u8 var;
> +
> +	ret = adf4382_pfd_compute(st, &pfd_freq_hz);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "PFD frequency is out of range.\n");
> +		return ret;
> +	}
> +
> +	for (clkout_div = 0; clkout_div <= st->clkout_div_reg_val_max; clkout_div++) {
> +		tmp =  (1 << clkout_div) * st->freq;
> +		if (tmp < st->vco_min || tmp > st->vco_max)
> +			continue;
> +
> +		vco = tmp;
> +		break;
> +	}
> +

(At least) LLVM/Clang complains about vco for a good reason: you may use
it without proper initialization if the for loop does not assign any
value. I guess you meant it to be initialized to zero in the declaration.

> +	if (vco == 0) {
> +		dev_err(&st->spi->dev, "Output frequency is out of range.\n");
> +		ret = -EINVAL;
> +		return ret;
> +	}
> +

Best regards,
Javier Carrasco

