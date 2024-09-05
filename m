Return-Path: <linux-iio+bounces-9223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2442F96E582
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 00:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83B22852BE
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A21B12C0;
	Thu,  5 Sep 2024 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HPmXOvLC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5F8F54
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573760; cv=none; b=NBL1Nek3yDD7JjTD1zfPkeOxzd9QaVEd1FuNjqp/cR8v+p/kpr149cYp2N9NZISL9sH2Nx02NFUEyjvD7u/ODsgTQhyYfMoRqIkQq9a+LYkTZFEf7IOlxy9AXvFmO0nNWxmBt1E0iMjGZ5D4NpVCkQzVYfPP8bnWjT9QIzKEyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573760; c=relaxed/simple;
	bh=o2rBd/EpvtvRavf5kZ6nfEyqO5OymZFSlbo7EP9xyUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRN9Mzz9omPWXaNUBXvwnDytHTUJi5WmgzurCQygpIUfCxPNXe1kS2Pwi1eGZ7HGNChi75As5PiRg5hXgjWosYF0mTVsRJXACOrQW4/Z19s9Mnn80wt45n9qdH0ZgjYV7iP3qxGUrq5DC4mf62sp+q+3JIFS5MzhV1YjYPZeJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HPmXOvLC; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3df121f7088so899590b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725573757; x=1726178557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgb3cunqhFoAbyTQAB3MXuEgG1+03G8js4h8CkYnu6A=;
        b=HPmXOvLCmsqT5iU6os4j3skV9kuFSNLsXrQ9NCrIOhnBfcxoV7iykTjGd8OCgSjx85
         2fOQZuwKUlP/P9X0ewPP+ViVzJhhaMd/eTO0i15C1Nrxka8d45G1HSaL4QRXT6HCcv+2
         4J6mc05h8nNd4/du17HAtA8jIwPTFLWEKXG2ATnF3ttjyFz4Y3y9bcYlIZXyW1K9lRER
         VCT28vcXVHx8sMrPlZnj0yvbUi38dPXhzCuhGsjWkZnC1Q2bNUmphJ/mko2t+XPe3U+/
         8Wk3FgK26p4d+zoDJ2hzStvthDm6g2Wq7B0ajVmV79R+/Qrq7kOoqAU8iX+auhNHPygn
         OC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573757; x=1726178557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgb3cunqhFoAbyTQAB3MXuEgG1+03G8js4h8CkYnu6A=;
        b=ugPRxU+876G4Eb745dcfg4nV/vnI9WWp0DwS0UjpGQB4lat2I1MHmPJ86UMIPEg15D
         mFJ0wz9pHG9t+KHO/Nof7D9lKLEiuCMVwzXLdM3XwEWJy80Ohmf4z5hLho2WDQveKWZd
         1k43djjx4dNy+nsucDhOaO3So7m4ruHC/Xg9P7p+0KLkKY+RbU23HNUd5ctf/xfhGPJ0
         j6MefXX1AD04+Qitp4oZufqBSmWpC1lfDUjO8YSOM5jiIRlp9bPY0VYzx5dKfgZnKA61
         YjXWruPC6Mlz1XtyduU3bj+ZJw0nFJ+u4ZdUGinamjXFcNmz7yFj8wzvE0Vj4pKT2psL
         kd1g==
X-Forwarded-Encrypted: i=1; AJvYcCXhX0aVtyopPXx8LDkKJxQk4yBe5kT2M6f3AjI6cOJrbwytz+tOZK6AS1Ii0HxUBRfSZ7OQuI1j4Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRzKE94xVcRfPZrjmroTcPo73OB20xWSlQ4N5oFL12FjiPuVe
	9pQt7ESBHy+aQnHICEjN8jru4ZI0WFKTS+Q8RcoCoOVpgbcBrmeJxCPAxZhNzXc=
X-Google-Smtp-Source: AGHT+IFrk+wEoLGsIsLaW2natHmBxXXaj09uLnikFQEhVk3SEuDA0k3CLayCro+k/BKDCJbT8bt4Ug==
X-Received: by 2002:a05:6808:f8d:b0:3db:22aa:f565 with SMTP id 5614622812f47-3e029e03237mr1104115b6e.11.1725573757358;
        Thu, 05 Sep 2024 15:02:37 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117a6591sm3427780b6e.4.2024.09.05.15.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 15:02:36 -0700 (PDT)
Message-ID: <0a7f796a-7762-4c25-85ba-27240a3cd59c@baylibre.com>
Date: Thu, 5 Sep 2024 17:02:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: add docs for
 AD7606C-{16,18} parts
To: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com
References: <20240905082404.119022-1-aardelean@baylibre.com>
 <20240905082404.119022-8-aardelean@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240905082404.119022-8-aardelean@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 3:24 AM, Alexandru Ardelean wrote:
> The driver will support the AD7606C-16 and AD7606C-18.
> This change adds the compatible strings for these devices.
> 
> The AD7606C-16,18 channels also support these (individually configurable)
> types of channels:
>  - bipolar single-ended
>  - unipolar single-ended
>  - bipolar differential
> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---

...

> @@ -170,6 +220,17 @@ allOf:
>          adi,conversion-start-gpios:
>            maxItems: 1
>  
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            enum:
> +              - adi,ad7606c-16
> +              - adi,ad7606c-18
> +    then:
> +      patternProperties:
> +        "^channel@[1-8]$": false
> +

Technically, we should also have "^channel@[1-8]$": false
if adi,sw-mode is not set (not: required: [adi,sw-mode]).

