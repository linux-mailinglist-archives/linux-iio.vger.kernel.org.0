Return-Path: <linux-iio+bounces-12499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EAB9D6183
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4AE2827BE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C27143722;
	Fri, 22 Nov 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JWKW2ogm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0057CBE
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290378; cv=none; b=b6C2zTBpg61rbhwd6miwsiwSPqfRtG/gp8GLFZ5+QWOK6njOwV7D7003lveV64qUYGh+sdUBL+1/sjQzsET7V0MrA6rSCGI93TWmlKcYLqo31wh2SaIWXDkZ6Pg6Pz8P3dF8XLW9pbnLAwbOf0HU5vJ1hDmNJoIfZhJqfqVXCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290378; c=relaxed/simple;
	bh=8A9KboFZlDjH+7JL2T93PiUqvpXAbf/duCGgVYuUXmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9/4ekGxDj2jtDOYQSA77oFcYOmfXubBPxWGVJevEQAvEzpexj0icsIQdoxkYHqVBmcXNwcbVAPslDF/bP6K463Te9uS6osy/gSbZRzDHKXC6bwlVh1pV7w1Tmv+IpH/6EI88jP/TKID1dmBKkkbtbhGeTwMbq01MF/wQHW9KBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JWKW2ogm; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ee1c3dbeb9so1118016eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 07:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732290374; x=1732895174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2navrkuwUUZwOHUSJByS4fe4hcXyHRaDfcbWiC/spM=;
        b=JWKW2ogmFgDUWU9PMOyPjN4Q0V8INbdgTRIo3/yrdahDjgJ5U+cxe1jrA5W4zVxgmm
         kzwDmmKtyfXUbSaVyPyKTBQ7yR0kHfgwpbU2Wn+KoMk0hBTk4DMRXIb4jaK3frkBijAc
         EGzbFDHyjaYu9r6b0LOLqRifY1oaZtduuVLJnawbHFdjoe+9J07m+ukzNHu43AocSsn7
         HALfoPmTLRH5h/aRxfN62LCXRJp/FPXFnkrl6t3Bx6fVezNfQlFi+y685AgYnyDbAXGl
         kyfX5MsrStYOjOB6NPTxq4URFE7gnQkLo51QEa6vCtyGy/AWsKT8zCO1oyePAuQLdXvn
         fHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290374; x=1732895174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2navrkuwUUZwOHUSJByS4fe4hcXyHRaDfcbWiC/spM=;
        b=ap+6XB47EsOPIVjwZv2CnrUCyx+VujYxhoYCO7R6YordXF+7fd3qoyaClitSZjC2gi
         79TnnTx5zk45i+DOE1TQPFtsufbk3o/ZNXgXidnGwGUdEtqzWLncP1z6liSyZYysH/cB
         jxRqGnS4v5iEWl9AvwcVlwSx6KAuptiHiYjKHEOL0LbPOcDUMYGXbsPNxipGNgtn4inY
         mtviVXDTmNdCmFZIStbEoc/7jhwvUaKcdXoZrQT8AVqk7ILGjTzjE6MmPH7CPkalnczU
         L0/+IOPsp3h+swVmtQJukhnWFA/fIp6umGjGDzAMliNFMIJUWgODvhriKnNoqNxApJQN
         0zlA==
X-Forwarded-Encrypted: i=1; AJvYcCWIWJAxZnmF1QA4QfrDsCnzF+4a0t+d2LD+7YB2pPqWGjo7u4KZ9a1shbtFbK8hZ76q1s02j8MgsWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQtogF/6gO3uxx5zMcU89AhAw81k1QwRYzj+1tBLCRd2HfchF
	M4CB+N5gch3NzwunCNTcE2YIzVK9NOFpqHinyI2DYSJ2GG1M6PfEWXl62KnNo7U=
X-Gm-Gg: ASbGncsLtQApIutII0v8BWOKp+Kjg63BfhEI1x3LS3lUmDckp4eInQ2BjymVCrUqhCx
	HuOLHB+Im9kvUd7/y+E3LqLP4ayeaeLEfhNfal2tizcXyDRngXhjJAfrs1a4sm/WMFHG1tuH288
	lG0GVDF4MppRCVyfXg7/yvJnfn0oN54RUMDKhShrDEK9e3M3YLGdSbC6Z+tBkADxD45DhMn0NY9
	YTb69dcgHg+6BZaqbZn1l5GiqiLTv/ccHlPoHmvz4chCXEkytU5C/mm1x+CY1FHnj7ttflI98Kw
	ykObopEAt9A=
X-Google-Smtp-Source: AGHT+IHQO+VDjXrAfCPt1zOyi9ptupBJn2BIBWMu7tResn7bM8x9VgkS1UAcVQpJvGu5LM+7F4LQNg==
X-Received: by 2002:a05:6820:8ca:b0:5d6:ab0:b9a6 with SMTP id 006d021491bc7-5f06a25b762mr2076127eaf.4.1732290372320;
        Fri, 22 Nov 2024 07:46:12 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f06984a66fsm420673eaf.27.2024.11.22.07.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:46:11 -0800 (PST)
Message-ID: <a50bc35e-779c-414e-bfa3-cf9264cd77be@baylibre.com>
Date: Fri, 22 Nov 2024 09:46:10 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] iio: adc: ad7124: Implement temperature
 measurement
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-22-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241122113322.242875-22-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/22/24 5:33 AM, Uwe Kleine-König wrote:
> If the maximal count of channels the driver supports isn't fully
> utilized, add an attribute providing the internal temperature.
> 

...

> @@ -901,6 +945,32 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
>  		chan[channel].channel2 = ain[1];
>  	}
>  
> +	if (num_channels < AD7124_MAX_CHANNELS) {
> +		st->channels[num_channels] = (struct ad7124_channel) {
> +			.nr = num_channels,
> +			.ain = AD7124_CHANNEL_AINP(AD7124_INPUT_TEMPSENSOR) |
> +				AD7124_CHANNEL_AINM(AD7124_INPUT_AVSS),
> +			.cfg = {
> +				.bipolar = true,
> +			},
> +		};
> +
> +		chan[num_channels] = (struct iio_chan_spec) {
> +			.type = IIO_TEMP,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +			.scan_type = {
> +				.sign = 'u',

The combination of .bipolar = true and .sign = 'u' looks a bit suspicions.

> +				.realbits = 24,
> +				.storagebits = 32,
> +				.endianness = IIO_BE,
> +			},
> +			.address = num_channels,
> +			.scan_index = num_channels,
> +		};
> +	};
> +
>  	return 0;
>  }
>  


