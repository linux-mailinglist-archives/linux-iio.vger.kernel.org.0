Return-Path: <linux-iio+bounces-16099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF591A4665E
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 17:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E97AB6F1
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371721CFF4;
	Wed, 26 Feb 2025 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kpIGGbbm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46C21CC4E
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586484; cv=none; b=Kr95qrbknOp6rp6MGd3LLSB00tjW39oZBMvN7eplvYqzbtIiTm618lQ3mRbIJlFw3uHcEGH/iEzLo+JH0B0bEh9T13acYYFZBCFpoXMIV+HAIV199tv61Z8YSW8Bt7Adu/Wby3Zgz9iZ7KE/MRO+wSoz+1goLyJBoNd+C9ENMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586484; c=relaxed/simple;
	bh=YUF09IcZrXY2wJ5Q8XSoqYhVJAYHJpb87FaMoFZMtBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvfBq0mSks5TQndfTEerlAgKUkclqoFQXKokYfVDzLLtOh1pp/358Fz6HQw9S3p3k9o3e/YM5lRML8rhj/sKpj9+n7SsOe5u2FNiuiCs98UKkvt4NL7LMv47ej8QalgT5fLo4PItVDDesnBWwCoyoQgug4SUvV/oKjBO77Yw6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kpIGGbbm; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7273c07149fso3308361a34.2
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 08:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740586481; x=1741191281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drFcXyyb+twCj8LLQJ+8ciOWTD1LqQ7TVcLVAV9+OvM=;
        b=kpIGGbbmw4G3yS0Lic3Y1if8x85ykN5aT90HCXwNat6XYD2OUDfKtS+izRyO9khd3P
         GsUZPhBwK8AhnLmez5PF7xNhlho1lzw8hu45rOL82+dRZEkfqbDV/tlwKJWIdaFWUe0F
         ff7tDrZTk45VD12J1vi1KJ/uyH1ueZOfq/BAsZL47m7J0eTAAObGWGmLTwwZJwrvmAWq
         BdIvdFg3SQ8+EOaW7XTWS5aYTiLd0meNfDgZ0pAdBegtUQzi7OoC0vy8sBnVDwvbAoXi
         wgSOdvUoIYndW10mM9nsyBhflVlrI9gIAg2Zd3O6bSvxqEZyqqoMa1+3Jz0zgrgrVJkm
         Zhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586481; x=1741191281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drFcXyyb+twCj8LLQJ+8ciOWTD1LqQ7TVcLVAV9+OvM=;
        b=WcyvbXXPuaLlrMwZBd/G/w4HThMgI1eAo12jriOAqrHOSWw4+6MRwH1AOK1S2tnxMs
         8uDqGnAr24WertKsSnxN2y5mpZ3iM2GVebvJSSTv+Xt28iMW4hZECUx/l0vyVYLca/By
         2hlZYswom8FYufYY4OHky9j86nQPv3rrq+XJH3ksz8MI76eHS13jhPDMmZDEElpmXWiP
         hYccvDXJ4aoKtylCsiyYa/b3zbmYHBaXCXpTHSDtyI6T5REAjqrPl8zhlTP641d2QCZ3
         nG+83GZUIB4DhiGFoqhYbOHZc3FPugOIGFFW1qNWpCcGiWk244YCvND93PzQw+B68q9b
         aVGQ==
X-Gm-Message-State: AOJu0Yz2ICiVLTioN0ErwezWnN5vnrfpkXKXAVVFjqDecEeocp06eoFc
	GMY1D32dLuCFYVP+tHUgr1nHM5BVNUM0DdG9+a7IvbfZH6+yDSE49B3311U/A4E=
X-Gm-Gg: ASbGncsRvA7gifk5n2IGxqwY3zWUDpRGPyRGuWF2zJIQORKW5An6vgVEefNrt86N+ZJ
	KMOEBGisYhwJSl30aqhxMx0+Jj5YTDpYWBRIif747NbDwHPlatcantPG2ZsaNU18n6GktZw2gAG
	FRZ96wUIDXU/OAJd5/gRiaRL65g1kFzEW+QWaqYoMrZ8XsPiTT1GVbNa6o5bynA87o0NBXoOi19
	1AKG1snYdvSaqX//MTn1NvMN/k30f8S14ungAKNjUCTPcX9D2D9bZi8tTBdbMS+Y6s4PrizjTuR
	6Q7+N+KSr421fIvULISFRgFfmMNQYJfbjLnMmUJqFvUnZKqOuXZyDyCGYCSncCc=
X-Google-Smtp-Source: AGHT+IF8NI9+1TFgCQXZV07Lfd20oHa51d15isLN6a4AtwGJl5WnwIxcHmu8nhk4CUGmWxBUTRSMEg==
X-Received: by 2002:a05:6830:6706:b0:727:f9a:8aea with SMTP id 46e09a7af769-728a50c73bamr2345843a34.4.1740586481711;
        Wed, 26 Feb 2025 08:14:41 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289ded6e56sm750702a34.8.2025.02.26.08.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 08:14:41 -0800 (PST)
Message-ID: <5ad1f95b-ef0b-4e65-9e31-a8166a8e90cd@baylibre.com>
Date: Wed, 26 Feb 2025 10:14:40 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ad7380: add adaq4381-4 support
To: Julien Stephan <jstephan@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 8:50 AM, Julien Stephan wrote:
> ADAQ4381-4 is the 14 bits version of the ADAQ4380-4. It is compatible
> with the ad7380 driver, so add its support and documentation, in driver,
> doc, and bindings.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


