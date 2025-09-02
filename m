Return-Path: <linux-iio+bounces-23646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7128B40660
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6194171564
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CDC2F068E;
	Tue,  2 Sep 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X8CPfwPl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFE2DECBF
	for <linux-iio@vger.kernel.org>; Tue,  2 Sep 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822333; cv=none; b=KBZp99a668iq+XsMZg3sD4sVDp59XzjefGjrIjzEv0Mvd8RE4e0fiw2SXf3fm2+PB+yyBMwMepUiCwcJxMjsqciQLiv7byaYXP1nI5Ci0uEfQgSUNCBpTbWGG9f48RgH7v3VAS4Bbw5N/Fccu3wmRtwGvHnT1iyQYzkWwHhyXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822333; c=relaxed/simple;
	bh=xgRzeXI2CD5w/fM4iCTLNx0usBOQ59YNNKel8DP+qug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j12G5jOcB7a09okSv+L0pX1x3+tfbYIRL2X526Z/uxOHw6GEJ8CXf/TeNOcmCoGaj2zsccHCyYg431sI4ljQai6+xQuOJkZONYt5cOq/phfDe53hB6mLbcbS+gSuPaeydjZt3MFKA+V4qUgd6cJPPmc60Q6x7iG1J5LtUuaczMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X8CPfwPl; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61e4c824615so921990eaf.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Sep 2025 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756822330; x=1757427130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNZKVTJfYG5mU9g/1mQ/DuNW173Ja54Z3lvAivJbbvI=;
        b=X8CPfwPl/w1H4cfcEG/iP0c2UeQrUabl68gBwbwapsQYkPgB8BCiblYAV7u9a/oS/U
         iNbEtgULIEvR5794aW0IctA+xpb8s6Mcy4gDxdzkl1fOZkyXeJOhSlluYymrm3KBkmCY
         NQCmVie1kGYTAc2P6DHl73Sk3WFtlb3MveIgiTUKVX1AmTHgF2dNjAHcJ7ekK1+xmSFS
         9ddQ3+FwgEUZZ7vk9U+C8UMzQ2fSB649rkhVBCtuV9+lZQjFjPJdfPV/1xammkqQ/vx5
         gnHg7yr8/6V5bvxAkECXo2cuodxS1a2Tkq4IdPH3oYqWZRA89H41wUvRjg3MQPxw2co5
         w3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756822330; x=1757427130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNZKVTJfYG5mU9g/1mQ/DuNW173Ja54Z3lvAivJbbvI=;
        b=XV7O9y5Uoh9tlVDgqAMzWvAYWjdiwdxZG0DOoXAzAoOyQwZSvEGxsTOYg6NHL4ZpUc
         4k0b5ny+hqNLHqoiXlOzI8xa2o9wlErBqzv/VhuVTTQ7rL2qc+qt3U1oszAbRhAHvsTE
         Fhogv1LTm34Tvg1EGN+AEWld8BSNh0xsRL31rvYh4h9jCHerGuv5TEW+D9RRyN95K8ZY
         KeVRCjaL3b71saMUaq/e3ENx9CSs9xkBJokZofPVKk9COR1jErEBw7kAzlcSrAidVIqw
         dKnrfQxgudaz3sn/+REoN3AwzhLER59+7Pca1UNN5j/qlxrieT3k1YfVbbfR5SZxHy+Q
         Uiag==
X-Gm-Message-State: AOJu0YyRXokFXDnWeaV1CWtwTEakcz8IVP78YZCJvZLd6GCbTqqj47wk
	LN/aZbgG82S0DY9Nbv7pJd3SfyUHOhaHoz93e3g7FNxLYqPoZ1j/Rnyu5WZEG7hr0yQ=
X-Gm-Gg: ASbGnct+wL1YomQrHZThuw45JPLvgfLh4u9KQpnY/fcH0dkNzRk38/sRcqemEUPHCFM
	UX0uvQ1p9M3RxRgKe+lYVlCbUMBrKJGLBkgFto8wXELamWcvlKzzxZqZSkLrnKmsxkaTCZ5wX1i
	G4JPOvNW3g/6hCNZPoMtsCE/sD0GDlrXUavG0OtXCzBd3V+0MXwx+hv30HffWuRJ2C51Nu6j/eT
	hvf6SL3D5RodiDTCLLKpZRQBWWP6i39tSkVsnfH2IaoBLF+t/iQ4z2Qvrzjb5qrkf3ugXMZjZGQ
	/iGqJNyDKJSIVibfwsXMRXWmoQIVyrrLPLNKvyoxC9r/ik1h/B1WXopm7LR/K9Pt42bZM7mPoTO
	of24+nYJp00xa/nkMECVMtFHdpuLMjv0Ki6F3sQBG4F0tCuvvk+DsGpQitHGxWlyzr3VUTdOVF0
	53qo1ZyIRifStCj9ih0Q==
X-Google-Smtp-Source: AGHT+IENGpjIQSKPQ3/J4nef7N7bdmmja3tu+Ub53CLM4ZX5k8/MduKyP43yqbZL+BkgmS4ttc1JIg==
X-Received: by 2002:a05:6820:1c9f:b0:61e:1fa9:ad86 with SMTP id 006d021491bc7-61e336f522emr6089858eaf.3.1756822330090;
        Tue, 02 Sep 2025 07:12:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b? ([2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61e31f1d616sm912783eaf.8.2025.09.02.07.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 07:12:09 -0700 (PDT)
Message-ID: <0cc072ab-dbf6-40fb-b753-13453b904974@baylibre.com>
Date: Tue, 2 Sep 2025 09:12:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] iio: adc: max14001: New driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
 <f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia@gmail.com>
 <aLb0_TKn96nGbk6l@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aLb0_TKn96nGbk6l@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 8:45 AM, Andy Shevchenko wrote:

...

>> +	ret = devm_regulator_get_enable_read_voltage(dev, "vrefin");
>> +	if (ret < 0) {
>> +		st->vref_mv = 1250000 / 1000;
> 
> (MICRO / MILLI)
> 
>> +	} else {
>> +		st->vref_mv = ret / 1000;
> 
> Ditto.
> 
>> +		ext_vrefin = 1;
>> +	}
> 
> And with deduplication refactored code:
> 
> 	ret = devm_regulator_get_enable_read_voltage(dev, "vrefin");

	if (ret < 0 && ret != -ENODEV)
		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");

Most errors should be propagated, so we should also add this.
Only -ENODEV means that the supply was omitted from the devicetree
and we should use the internal reference voltage.

> 	if (ret < 0)
> 		ret = 1250000;
> 	else
> 		ext_vrefin = 1;
> 	st->vref_mv = ret / (MICRO / MILLI);
> 
>> +	ret = devm_mutex_init(dev, &st->lock);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +			"Failed to init the mutex\n");
> 

