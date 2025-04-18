Return-Path: <linux-iio+bounces-18318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5AFA94029
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 01:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433FD44682B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BA1253B47;
	Fri, 18 Apr 2025 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xz8q+vBS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43B2080DC
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745017547; cv=none; b=cUVeZl7jLPdObAgElKJDfXbx0lXf7f2QGTY+H9T4P1w5qrhtr6CT1ILGaDbIdnSnfc+kbB9bitkye4E1SAKQtO0Ql759/QNGH70ep0hkExoNiACS925AH0aCMJYbsgm9/ENF63W6KX+gGk+wYwp+AgmmH2pJKUw90IbGtuU8Oig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745017547; c=relaxed/simple;
	bh=ymlQkqzyhQ/QPDDRJdie9S2n19N7122U3ZVfMyAGAeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuKO/vwNkCdE/kMu2HQDAPtB0vrZrlUl7g158tUx777p8KL7fsU8zmBGCgMK2J4pZSFcog1V8CGphSaBCtQqDkIP3l6bvmgYktQqAzYfIV8p2H1INqTt5aKKXLHg8qzxQeIMeJM3/jdH7FUS4MZTQ4zKNwiUX5cN2CZi19wHpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xz8q+vBS; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72bccda48cbso1503327a34.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745017544; x=1745622344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atnsX2Ib1Wv1iIZ+2HRhddbg893c8+OuKKzqJdxz9N0=;
        b=xz8q+vBSc8DJQV352aVaz44d+HH0X4CmTof4lKQMr3oyneCxhQUllSqRw4XIHxNiTt
         9XoTxFg7UEpx9rU5GQGnFlMIEHN7aQHX+XHtZ+Mk2fEmRRLOsksdh2yo+4srBIzljobP
         3oUzvJV57bJ3+S9WEhrQNZnsokuHLvJC7yYfN8HRhBqrX9i78FM647UpICbHIHWQ3Kev
         zZvlsGxnT55706A4wPeyvm2/H1amEoEoUAwr38e6iITmM1z0lZooe65DBg4p6MtF/VLT
         pu4g6J3wcHCvyPTQzcdHAQNVBIV/53TtS3Nntwx58xjh+L6HKnhVMq4ihor+Wkabbj6K
         4ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745017544; x=1745622344;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atnsX2Ib1Wv1iIZ+2HRhddbg893c8+OuKKzqJdxz9N0=;
        b=P2SXe8IdWpJi7mDSSPVmcCZoee0YuZkSZd2Y9aGtLAH7NqbqlGruxeYGLePQ4TSPJM
         f3+y1GFUnqfxnWPEfgVQQEBrHkoyPpN/0x0JSKxVGpJ2uA7YzTsm36irtCXQ5ccuqD27
         Huh4OXtz4HTiTVVY4Lu3TmxoNJaWKPaS2Q4Q/c89QlpG/Av9DOr7V4ca2+PpD0rtwiFn
         vLryrNqBaCByaW09WskQFbBc/Yu0hEEjQQRqcVfVpPmC/L7QE62wdUfU7eYlwFoGtd69
         VGtljiHEZdL+Iwz3RHrf178hlMLqMokdRk/ochEqOzEzoHu37bcF/xZe2b7APMS9zsvT
         /pYQ==
X-Gm-Message-State: AOJu0Yxpk0eJde2CiEIfx3sylKJV+yDz0tsvY2HUDLGaq3tphT2gYuzd
	liyc6YDibhTMxxBX09n6TrK1kJfSAWOVwnSTv3EZPaiFcs1cgZ7szknDLSDOKDY=
X-Gm-Gg: ASbGncvo6xE0Gz1E3I9jZIDYL6hQWq9958no/7DWkXisRHm0x+AM3Hf47UMr/lKgIxL
	JQTOevN8jBdvwKviNo6vfSDy56mEEUVXn29YGMBeNhWlIGmYHqPAHcRLCWqTdK/v6owhFDxrma0
	/wCwZraxIEC2km551DLNh9ym8fKel1t0jPj+nNkK91JyTFfADbqhFqswESw2yCG6b7dOxurL5bw
	kUmWZFS4QxuEXGS56ypxO1VNzPX8AOw2eH9JmCktEOhavb731ITns3/zYMRv5H/SP9AmvizaCs8
	3qN2bpZffK8IAEhyIkT+XLKwE1EPTdfe4Ln52b8M+4y9iGxfA111YNnNjeIv5iTwKjDjeu1QYs9
	KF6zqXWe6YeYpkFS5CX/X3cAQT0US
X-Google-Smtp-Source: AGHT+IFo3+CGCCjL/MDLKOL98VKpPnk7r+cnqZ8GYDV87Srf78OvwPE2vbzd7+9ZcA062oFaVEN0Pw==
X-Received: by 2002:a05:6830:3693:b0:72b:9316:d596 with SMTP id 46e09a7af769-730061f15a7mr2627791a34.3.1745017544135;
        Fri, 18 Apr 2025 16:05:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279? ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489c6e7sm502383a34.65.2025.04.18.16.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 16:05:43 -0700 (PDT)
Message-ID: <abe0db44-b27f-4cea-9edc-862e4096f80c@baylibre.com>
Date: Fri, 18 Apr 2025 18:05:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] iio: prefer aligned_s64 timestamp (round 1)
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andreas Klinger
 <ak@it-klinger.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 2:58 PM, David Lechner wrote:
> While reviewing the recent conversion to iio_push_to_buffers_with_ts(),
> I found it very time-consuming to check the correctness of the buffers
> passed to that function when they used an array with extra room at the
> end for a timestamp. And we still managed find a few that were wrongly
> sized or not properly aligned despite several efforts in the past to
> audit these for correctness already.
> 
> Even though these ones look to be correct, it will still be easier for
> future readers of the code if we follow the pattern of using a struct
> with the array and timestamp instead.
> 
> For example, it is much easier to see that:
> 
> struct {
> 	__be32 data[3];
> 	aligned_s64 timestamp;
> } buffer;
> 
After sending [1], I realized that some (perhaps many) of these would actually
be a better candidate for the proposed IIO_DECLARE_BUFFER_WITH_TS macro rather
that converting to the struct style as above.

Case in point: if the driver using that struct allows reading only one channel,
then the offset of the timestamp when doing iio_push_to_buffers_with_ts() would
be 8 bytes, not 16, so the struct would not always be the correct layout.

As long as the driver doesn't access the timestamp member of the struct, it
doesn't really matter, but this could be a bit misleading to anyone who might
unknowing try to use it in the future.

[1]: https://lore.kernel.org/linux-iio/20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com/

