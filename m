Return-Path: <linux-iio+bounces-6959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329C9184AD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A491F278C4
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27981186E2C;
	Wed, 26 Jun 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UiMYVNhQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192091862BB
	for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412973; cv=none; b=qs8+22E/UaijLH5YTJ8ezdsYodfvr6rZJJBa++iZmN++guWEznxRvMlj7f/l5VG+x/SGD06IDYbWJ3JYUvaHIdC+ZuJj5tgBxGf84ZQeG+abMdv714mvsEVilu665La1xdnpmYNzdgeNcFUgFZDkoh9Ang5PxWha5jBTNYIp3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412973; c=relaxed/simple;
	bh=K7aP/eHDt4GdGK/74zQ1CLj8aftrYuNuSeKAYMxdWTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6qwNDdGcpKJQr6ZUv8D/GG6mdBMbXjX5tMy2xcfSsAP419rpbC3Edrm1luZ/lkV/YxldIBdz2b1H6S3twdqodC7c0iE46rOvMyCCvjw3RzFW2QYq23EuVaGdegqqLa1gvgqFPPmN97ZsnL9lnPJgH85MSInKz+eh+qfQ+Uu0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UiMYVNhQ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c1a6685cd5so3278113eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719412971; x=1720017771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6xILt2X5QE+PcAs6cHxc/Zb3Y2A3nIUAiSP4m+Ryi8=;
        b=UiMYVNhQzajOc5BWpHQPZr3Q9zFr52rx34l1JfmC8cEyRwcSkC0p9V4TDsQW0Zl5CZ
         +M+4uLyFZdMJ5BgZ83XzIhjGv8WDdCUHnirUjIDYoH/MWGDjOVre90BLooxMNKODWWvB
         DkRzc09p8ZuU0SjsP3wDOn23Vq7+dixMH0D1XDABWqv26qEfX/gU0+YlZd1CGYCYSO0q
         qVQBbyqYasUPTrhsX2Ql/VSQ1Uquz4dDkNrs1DgrmlSwdf8sBvNsDxVDae1oMp3SA4WO
         kU1+vd35gfgHH3Baxcx3RBOq67Xw+bD3D33Jjn/z5TYJisukcfNNijrE0yxnr8TyK07I
         Mm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412971; x=1720017771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6xILt2X5QE+PcAs6cHxc/Zb3Y2A3nIUAiSP4m+Ryi8=;
        b=He4RHY8oHpe1sXURG3+GtBWusNrPHoy6t2F3fWxR8hp0B7Qs25QU0Ph3SoK84z6Xhu
         D5o9z+O9nXbz1MnsjVGNQ10DHc6WW3cgWtmhq+7XCcKhI55DEO/TsZHBKjwY9SQoWawH
         OufcDdBuzsppECgdyt2fNe2ZAUVZhOHDLNGwPTcjq64SrakXGwKknvHf0tFf1nin1nW7
         PvKzlHmLnPXP4sYcEwdkMFCt76b+VrDp9oL9nVt7JwTjdrIaMovk4TgMgFueF+/dPLL9
         SCa7oqLvUurm2O44+4GEkYF+RwMCtDeArqmzRmpcwEPlQcDdoeqFgiJwKwgJbkruE9Tk
         ulVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+oaD5KiIK648CjOEsm7QEHP3CJ2BF6o8/iVJV20TiLlLRdfxckpP7A3BNtHvRC64dhB79IUNXZwvTVKcNSw5YKHGRmMUSjjeZ
X-Gm-Message-State: AOJu0YwjxCXtO4g2Ur6yWOs4+0CBago/rlSXo1AW4p+bTv6VZege3/XU
	PRv66zlmeK1SklksoyIWd6B6Ln3OZn1AgwgDx/2MwZ3TE26/ft7ublp0upcuDaM=
X-Google-Smtp-Source: AGHT+IHNFQQ5Jp0CR9h0pMLQqG7aefDgqmLSddqW/x1VdakRqiSbDrAgGJC5DBOjhlouQlhPHHmtaw==
X-Received: by 2002:a4a:868d:0:b0:5bd:b695:5bf1 with SMTP id 006d021491bc7-5c1eedee62cmr10336148eaf.9.1719412971183;
        Wed, 26 Jun 2024 07:42:51 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d91e5f59sm2056578eaf.25.2024.06.26.07.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:42:50 -0700 (PDT)
Message-ID: <d2649e69-4c71-4aa9-88e2-9d3f15549e1b@baylibre.com>
Date: Wed, 26 Jun 2024 09:42:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: ad4695: Add driver for AD4695 and
 similar ADCs
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Ramona Gradinariu <ramona.gradinariu@analog.com>
References: <20240624-iio-adc-ad4695-v3-0-a22c302f06bf@baylibre.com>
 <20240624-iio-adc-ad4695-v3-2-a22c302f06bf@baylibre.com>
 <f02cac02f9404bf6dcc5a8274b51d836960871ee.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f02cac02f9404bf6dcc5a8274b51d836960871ee.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/26/24 6:47 AM, Nuno Sá wrote:
> Hi David,
> 
> minor stuff from me..
> 
> 
> ...
> 
>> +
>> +static int ad4695_write_chn_cfg(struct ad4695_state *st,
>> +				struct ad4695_channel_config *cfg)
>> +{
>> +	u32 mask = 0, val = 0;
>> +
>> +	mask |= AD4695_REG_CONFIG_IN_MODE;
>> +	val |= FIELD_PREP(AD4695_REG_CONFIG_IN_MODE, cfg->bipolar ? 1 : 0);
>> +
> 
> nit: don't need to OR the first assignments and so initializing the variables.

:+1:

> 
>> +	mask |= AD4695_REG_CONFIG_IN_PAIR;
>> +	val |= FIELD_PREP(AD4695_REG_CONFIG_IN_PAIR, cfg->pin_pairing);
>> +
>> +	mask |= AD4695_REG_CONFIG_IN_AINHIGHZ_EN;
>> +	val |= FIELD_PREP(AD4695_REG_CONFIG_IN_AINHIGHZ_EN, cfg->highz_en ? 1
>> : 0);
>> +
>> +	return regmap_update_bits(st->regmap, AD4695_REG_CONFIG_IN(cfg-
>>> channel),
>> +				  mask, val);
>> +}
>> +
>> +/**
>> + * ad4695_read_one_sample - Read a single sample using single-cycle mode
>> + * @st: The AD4695 state
>> + * @address: The address of the channel to read
>> + *
>> + * Upon return, the sample will be stored in the raw_data field of @st.
>> + *
>> + * Context: can sleep, must be called with iio_device_claim_direct held
>> + * Return: 0 on success, a negative error code on failure
>> + */
>> +static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int
>> address)
>> +{
>> +	struct spi_transfer xfer[2] = { };
>> +	int ret;
>> +
>> +	ret = ad4695_set_single_cycle_mode(st, address);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Setting the first channel to the temperature channel isn't
>> supported
>> +	 * in single-cycle mode, so we have to do an extra xfer to read the
>> +	 * temperature.
>> +	 */
>> +	if (address == AD4695_CMD_TEMP_CHAN) {
>> +		/* We aren't reading, so we can make this a short xfer. */
>> +		st->cnv_cmd2 = AD4695_CMD_TEMP_CHAN << 3;
>> +		xfer[0].bits_per_word = 8;
> 
> nit: isn't this the default?

yes (looks like leftover from testing when I was trying 16 instead of 8)

> 
>> +		xfer[0].tx_buf = &st->cnv_cmd2;
>> +		xfer[0].len = 1;
>> +		xfer[0].cs_change = 1;
>> +		xfer[0].cs_change_delay.value = AD4695_T_CONVERT_NS;
>> +		xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
>> +
>> +		/* Then read the result and exit conversion mode. */
>> +		st->cnv_cmd = AD4695_CMD_EXIT_CNV_MODE << 11;
>> +		xfer[1].bits_per_word = 16;
>> +		xfer[1].tx_buf = &st->cnv_cmd;
>> +		xfer[1].rx_buf = &st->raw_data;
>> +		xfer[1].len = 2;
>> +
>> +		return spi_sync_transfer(st->spi, xfer, 2);
>> +	}
>> +

...

>> +
>> +static int ad4695_parse_channel_cfg(struct iio_dev *indio_dev)
>> +{
>> +	struct device *dev = indio_dev->dev.parent;
>> +	struct ad4695_state *st = iio_priv(indio_dev);
> 
> Why not passing in struct ad4695_state directly?

Probably because that is how it was done in the ADI tree driver
I started with. Changing it to two parameters would be fine.

> 
> ...
> 
>>
>> +
>> +	/* Needed for debugfs since it only access registers 1 byte at a
>> time. */
>> +	ret = regmap_set_bits(st->regmap, AD4695_REG_SPI_CONFIG_C,
>> +			      AD4695_REG_SPI_CONFIG_C_MB_STRICT);
>> +	if (ret)
>> +		return ret;
>> +
> 
> Question... do we gain something but not doing the above? Because debugfs is
> optional and always doing it even when it's not present looks unnecessary. 

I haven't got to a place where we need to read or write a 2 byte register
yet, so I'm not sure. My plan is to defer worrying about it until then
and update this if necessary in a future patch when it actually makes a
difference. But for now, this is harmless because we are only reading
and writing single byte registers.

> 
> - Nuno Sá
> 


