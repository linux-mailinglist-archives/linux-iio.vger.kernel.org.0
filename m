Return-Path: <linux-iio+bounces-22132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7616B1525C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 19:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA33B3A4470
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3E6235BEE;
	Tue, 29 Jul 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Iod9TWnP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAAB23DE
	for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811440; cv=none; b=SW6gIE8DSi+rygC7n8mz7IlmI1jy/2B7ItKvGfS3RyvNuIFZhfZYOIpwPCZTgFfpECBPjw5WqQAQuNEto4ndQbEa0kvI5f+Q6AJIigRrHIF2ztnNR6MCsc3trgDpjuB842pxqu7HlvuMhWHx9WZjBj4eesJlBKoLft3qKilTPgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811440; c=relaxed/simple;
	bh=XeXZpJxWWXoeK7yQhNRSHDNdpU+i8r6xQmFrk6zUMLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWGnNdTy1pwlqMcylcV4RMXtWkvyHqvx2lEFtvvSnCeM2UgA2CuzYz4N5XOWsnhQp5Eo/TSWkoRrkkTSJ2GU+F0BolkmyJmNpoL1qjseHYufq+vEueJsnyhcbagu+6p+uHhsUW5gaRcb88adyvHoAraOEVINB7WOQ0JuW7qWQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Iod9TWnP; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ff8d43619cso4107694fac.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753811438; x=1754416238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2n8JJ8exSRc3hysj4/UwWy7ixDdXIHUdQ/VB5LjBZsI=;
        b=Iod9TWnPVchuisbONX2xGScwMVAwgA9oZfV12n35vnYq6+K80aNN/D10bau6ZP7N/4
         Ck3PRYX7ckCB30MHopZZz06+KAnskAR6lY+ZbyOyWuRSNm+lLCyLlytIrEVXESpwXMzZ
         yTEP/nGE+Za6awMYU4434bCl8bRcbrdzkktHLRTOItdcMe9cKUeGpUwt68X1LXbVl7me
         WK+SCoRcreWarZ1KpWB9nj4a4Q872ArXbBaJBbOGEIq0vhuHNFPRpSGaJfRGVzQCcUDB
         9ONQPFo+ymmppcUKxv8JUNJAxp85BPC4GzABwj2Ci8BipzeipF1YFAxdz9RvB4BqvbWw
         bmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753811438; x=1754416238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2n8JJ8exSRc3hysj4/UwWy7ixDdXIHUdQ/VB5LjBZsI=;
        b=GmcmYkK/Y1CDKKo6gru3UwQtQn/IMdin93h12Hokl51slZ+P4nDcNO+s2Mz4JhypYL
         0yrWZWQ5MDlBh90cEgeK3XSuLSuFP338BECljK5TD7Y1sTS4uvp8ZmqxDuikRwQEdDU/
         PsjivXB8IhydlLz+nyImc4hdIGzGK0sKGh8wqCfq9zE7OxUKXaMx5/CkPCt0oQ/YJFEe
         qEUdNRbmgHd/qhBsprYlm5m/CkcUpuzsJmfj9EJzCNdPQAlFqxjgr8UGPlLtstlEgNeh
         JGmVUo0V+62MA++0F8BADlzSlvprtNlM37c8v4G09Pz5pgoRPcYof6YvcwER7xxW5SCA
         pfxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjtq/bZtCBFNbBAsjXdQilipSVnbcOEizztNvN1LNxD3kNEy4oX9EGcQjxTiILFTUFAc0C4O4x1u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEeYV1lZNC52BA1pWHHH7ap69Ar3EqPRoUISdfknFAdSGx9uZ
	9w67weXf37cCq7UGaDob9ILyBnT9ziNQHpuhv1DjBRDvWgvlV71NFg3C9cQBMVTuBTc=
X-Gm-Gg: ASbGnctKbkXWx8dinc0P9+kA6pfpVn9g1JLVZ1CykOnw0NzlvuHP9O9hwNTtUOBSwq4
	j06Jl20Qx1s67uZ/Q53oa3Ipnm3N70U3v6p0cvSf/rbxAcTUhrrUlZf4zuR18CwOSbLuGNEMSop
	O0Aw0aRxPS/EFsgl7dnjAGN2aVo4/QSKZtK8WRuuqMUUn6M9C9An0fYnfaruDSWlbyhZh2D5tnj
	F/jlrLlzP8SaBs/B1OGQy6wKpuI984RHm0Q+FEKP7dPm38ixA1islpUysvUiwgU4DVQRaKVd6+S
	w0XxjG9oCZuxtiUiVndiBIVIZOnEXUZVVmFJM1MTmUh1I/WC1S3QFTJ+pFQLunzH241vbkH+Bu/
	T+0OD/uOsfbNpD15/pRrC16pRWBf7U36rGn+79yZF9btkaaryMsLRoPMPd2AMyDreBIurCPKwCl
	Y=
X-Google-Smtp-Source: AGHT+IEORfyWUzhjvQQEAogClLkz6j7BzGPtGEWPUrfbLfobd8wz/AC1NC8CYIw7S6Avi2UVbnp6iQ==
X-Received: by 2002:a05:6870:8287:b0:2d4:ce45:6983 with SMTP id 586e51a60fabf-30785aaae80mr168633fac.10.1753811437786;
        Tue, 29 Jul 2025 10:50:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54? ([2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3071323a99csm2408485fac.12.2025.07.29.10.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 10:50:37 -0700 (PDT)
Message-ID: <9536f598-1d49-4742-92e3-0d2603c5267e@baylibre.com>
Date: Tue, 29 Jul 2025 12:50:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
To: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
References: <20250727210639.196351-1-hansg@kernel.org>
 <20250727210639.196351-3-hansg@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250727210639.196351-3-hansg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/25 4:06 PM, Hans de Goede wrote:

...

> +static const struct iio_chan_spec dc_ti_adc_channels[] = {
> +	{
> +		.indexed = 1,
> +		.type = IIO_VOLTAGE,
> +		.channel = DC_TI_ADC_VBAT,
> +		.address = DC_TI_ADC_DATA_REG_CH(0),
> +		.datasheet_name = "CH0",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_PROCESSED),
> +	}, {
> +		.indexed = 1,
> +		.type = IIO_TEMP,
> +		.channel = DC_TI_ADC_PMICTEMP,
> +		.address = DC_TI_ADC_DATA_REG_CH(1),
> +		.datasheet_name = "CH1",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		.indexed = 1,
> +		.type = IIO_TEMP,
> +		.channel = DC_TI_ADC_BATTEMP,
> +		.address = DC_TI_ADC_DATA_REG_CH(2),
> +		.datasheet_name = "CH2",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		.indexed = 1,
> +		.type = IIO_TEMP,
> +		.channel = DC_TI_ADC_SYSTEMP0,
> +		.address = DC_TI_ADC_DATA_REG_CH(3),
> +		.datasheet_name = "CH3",
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}
> +};

Question for Jonathan: If we don't know the scale on these
temperature channels, should we implement IIO_CHAN_INFO_SCALE
and just always return an error? My understanding is that
by not implementing it, the scale is assumed to be 1, which
likely isn't correct in in this case.


