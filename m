Return-Path: <linux-iio+bounces-23305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D8B36F5D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 18:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19FC1B2490B
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C737D30FC25;
	Tue, 26 Aug 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LpLPbOUx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107DA19D071
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224165; cv=none; b=qTcr4m2hW5HRf1VOvs+qvy2Di2hcd3cyBG8EIFhkgi4Yhz06KyqH8I/e4/dWgbwdV263yac/2lwTDkl+0LaV/y4JMeTZEKFiwh/y+hjsl1nqg987z2BfsPNbHBPVb0Rs9TCQ6Yn7Smn3lE+PNYm2Axs2a4qSU0fXvaT4XtYa6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224165; c=relaxed/simple;
	bh=3UQpnIJPKnKLpAGt26ffAbECgihu3iAliObcW5TWBeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfpiNnkjlS76BiAhLJK/vaXrxpGQnn9+LOyZpI/eXKoKc6zCgaDXftwufQ1zoOjwNF4lZGMQIa17DTWm0nrmLhUf3OmqY0hA/zv7PyHocnCNIqI8+s9XsP2Y7o/uOdlR+ipphysJ5QmuBzbDjiNJ9OiqAlbvVhDX2l1fzlzJFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LpLPbOUx; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cceb382d1so5304592fac.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 09:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756224162; x=1756828962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hKICjV+6/lxNLEk1c9nfVe+ZCE9ECioreCtxFio2KU=;
        b=LpLPbOUxmF7GImYlxTvLsuZMqiZzQBoaMv+rWsIto8V9hiQoWJowZZxoaqGGbuyoB0
         CrRDiM3WLugpla/B2rtUWSaOVmJ3oPVO1LMXE0BB3WvbY20nam7TOV4pCY3Trw81y66C
         lf7RyWf0zkthHoUCa1ZqiLEu3TUDpT8vwYzF+TmuEAHQ3mTFpcoxa92jX3o1Vdo/derL
         oEkhakGv1Taci5vrLeq7iqh19nTj/pGrJkNt9JOIxvjXRNaqM3xUwceAVR+CgurpioE2
         nbxsoda/y8Qy6NbAjEsrp1GoZYYJjDvkT90axxjjBJjv/zdbbulPV9PG/V13xpF4fTRv
         Nz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224162; x=1756828962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hKICjV+6/lxNLEk1c9nfVe+ZCE9ECioreCtxFio2KU=;
        b=quVFksExwkgQNItgFv2jfxtGzLQ36ltwirvp0DW+8hk22T20ACsTI42Y9Eg5XeSBEt
         ZT/ECB7LswgiJ6YR3HO0eJU323NCpK/RLCM/zHBPpKqPpVMsF5vDDpvTy+00nO7tv7ai
         JiETwO19mieJklnDK0xHdgc1x6Ob6eJmzfZiLk1SXqOnnp1HMeRF22KHri+Y5va2PZC0
         JItEMsjKinonldS9MCsDqhM5h5WlzjmNDaZgtYqojLgsi4nPTt+d341JJoZoSWastpvK
         TGXLZxK+X0V1Iz8CuT62sJSgvOVuyDDR82LhTxN0ZIVhOeHuKUQJp4JYdJv6WRCwUMmC
         Jw3g==
X-Gm-Message-State: AOJu0YwMN70XDKvTJcXYpnAGC4LyAhAgzIUbqSc5DlTlqe4IfTuBN7mv
	eaP7tNRyiKVwSdXt9Dk7urFlBXlotGo7Cr+SPU1ZjI0gq3m9PDyBQ9WqsoOOyV5z/EA=
X-Gm-Gg: ASbGnctRxc4jQFtj1WXbTF+Y/Gt6q5dh82GaE3FZYi3oN//YivofFroe5LLyHrFlA83
	csuPoWH8Rhd0xEHDP3fDi8K0gtldHvEH+82KaH1HVX/GdAAI5RnMsNrplxNkBF4jnXALeUfnGcR
	M6L+PEDkNf4+c+rfV/38+a1LjcaJ7yLOehQZYXMBewqXfGjazlKmaKj8AYY/5n4cCPngDfcofHq
	Yu8so+7AjBj/EkztoOt/fXwvWk+elNbqAwk+L68mv1DXpeF3zEPvbkN0CwvrVlYmcm/ggDk8AcB
	gNQq+sIkIZsH9nhqMz0B34+rUHTZVxIEIOY7C8oHSrNchXmXEzxHR7RNJJyWthrERB4PLG/8w1D
	QpGFcdUnj868MNo2XdYfhda6oSzA9d1qtUlRmnkzUSJTsiM4ASfq4MJjwcMnS2uwB+LtXvb1mvA
	s=
X-Google-Smtp-Source: AGHT+IH30+gvcYtT1WdKMDYQghSW8SLUW2fPPTOAELgVrWD2i+MlWze4f6hNHUyN3ijUu3eoWuMyWA==
X-Received: by 2002:a05:6870:ec92:b0:301:eb97:1f7f with SMTP id 586e51a60fabf-314dcc14230mr8054282fac.3.1756224161690;
        Tue, 26 Aug 2025 09:02:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e29b211sm2433761a34.21.2025.08.26.09.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:02:40 -0700 (PDT)
Message-ID: <1dcaf589-2ff2-4af1-9177-ee129b403272@baylibre.com>
Date: Tue, 26 Aug 2025 11:02:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: adc: ad7124: add clock output support
To: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
 <20250825-iio-adc-ad7124-proper-clock-support-v2-4-4dcff9db6b35@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250825-iio-adc-ad7124-proper-clock-support-v2-4-4dcff9db6b35@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 5:55 PM, David Lechner wrote:
> Add support for the AD7124's internal clock output. If the #clock-cells
> property is present, turn on the internal clock output during probe.
> 

...

> @@ -1164,6 +1168,33 @@ static int ad7124_setup(struct ad7124_state *st)
>  		}
>  
>  		clk_sel = AD7124_ADC_CONTROL_CLK_SEL_INT;
> +	} else if (!device_property_present(dev, "clocks") &&
> +		   device_property_present(dev, "clock-names")) {

Found a mistake here. This should be #clock-cells rather than
clock-names.

