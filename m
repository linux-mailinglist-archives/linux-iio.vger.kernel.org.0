Return-Path: <linux-iio+bounces-19692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E82ABC200
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 17:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24631B6395E
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897E2853F9;
	Mon, 19 May 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GAMjgOvh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D4284691
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667749; cv=none; b=GRrJnuoFEwL7NPRO/VwqvG+2540HNoTWqa0v+k9VIWJDJdwIIl1RekcjJpLxMnj6p6KQafBJZCK4mNu0slGDC2zbABRNyAH3FgUBe3QZCWLVHlGv/QjlczcTNwz81TiHq8XYNcCkmVLXWLjtxD7D68ppcqGlBc4MBdAYn1FzfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667749; c=relaxed/simple;
	bh=+waXAjHPp2/K09OP/lmIyVTinzIg/SgT5315tIPMPqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F6rxAGCjTmuWJPOxc1vQZfHRhZmz/zShKJsrwyShNi5fTE5CqgbUHUTl5IX2fYELuCm3u6CM0mpGTTdRCAdDeQ3W/r2q0TPY+mwhp4dpIpxQiN+4YA5X6Je7EWX8umCi9PoLzyJPedeA6yX23wVMW4/fuUfrMchqezPCXeuD8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GAMjgOvh; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so1888818fac.0
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747667747; x=1748272547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RvV2Or60168cJV1VNj4zxLnm+t0hyD0WIsws06poAZg=;
        b=GAMjgOvhDmyalJfnykb2zZDfgSg+iGLKaPRpXCurM7/RGYd/qn9Eq9cBjoiKKam9eM
         /IaRt65UzPPnmBCEbUuxPsLOEaj1HodqDXlO4GNrHDx3/nSg5twXSrQPWMgiKOeFZbDc
         /V2ty0fKVRVWc8eGwBB7wVPfh/num5Z5ALIvqt4a9NJuDxwZVy4g+W5zTwX0RV6LJIC3
         K9pc/c2XGE2z+5l13UNfi5SqUzGHgkf5VjQYXJOLjLeftwDwvO7QxyOtkvuksyILDLKl
         WKmeKD8K1PLx0DnzJk7Upezs7OhjQ7iw3gyvbtu3AlYDCO3Ymm4MlK9jRylVOmwefPSw
         Vpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747667747; x=1748272547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvV2Or60168cJV1VNj4zxLnm+t0hyD0WIsws06poAZg=;
        b=edwmRI8/Ak28XJ9cKHXNa1EvJxzTPbIRnPjGu7AIsRSnU0PG+PFOkMcAp9t6MD3wih
         Tv/+fMUC7oqdulUd9peZyUm4iVZIN7r701S0blh8WA7ih8GckabwbflVOQCJXhyt6g6N
         KgxvdVjBxpIL6JdeSbXgZkRR27FYC2Se3Mlxm+C2hXzkwivpci9tOXFkOOYNwUEYnvWi
         GqaJmB38I52lCMr4wPPD8/gZ7wf1wFQytTprGPTEfDQGytHoVndQ5jJLAUlSM7JLvR/7
         R4uCaMzen8zNtfWUN1keRjlhLsfH16HVJcWtTnk8QxFqHWWxjUu650rnEGsu3PL+B6n7
         2jDg==
X-Forwarded-Encrypted: i=1; AJvYcCXwDfmaOQiUOxX2Tj7bw93npX8QYxmYeJ1MptjUyIr5kjzi+SZE+xUg4o3cEEQWgJXMnXLXK3sYXFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRU5eTPSS0g3qdJn7mIh+A4HJ4I5c1koctO5YeZvKNCDt5mObk
	VZ34MWHCclbdW1nkyGsj3ETxghuyXClLNoojQoLEmKu9ZkWL4UtUy8KA1iYPn1KEOwM=
X-Gm-Gg: ASbGncv17Wfbj5qr2Q0Mne2jn0s1FLnv43JFfjd4dqunCwFTGky9MQF96fbbuqWm7PF
	trRjtYNuHkPVAyStcZ0nw5cRC4miZ87YCbIYH1AiYgpfS41Ox2EMcrlaCSdBMZoTUvIFX5hNQ70
	eG2kVUs59yZbdzRDZI9a/ZBjH2slYlgszrpiMqTst8clJVh3HBmn5heIFQDy0RLN+6rP2R5UQbc
	r7pXBDP2BzAONWCtNDbNZM/oyyrvvOCeJMgzPThagNkZJlajEt0SNSyqtptLI6vfFtT5c7YCycJ
	4cYz8K7zDwM6zvuLV6hLuuTIrv9yoFuf0ZGX49F6AJAr5iGKh98OdMv0DqRWHnE6NNC/ce/ZqEN
	dwu0HcEoGcfn1qY4/+OUMirq0dA==
X-Google-Smtp-Source: AGHT+IFzJgzYkKq/FCa8DGUlgA0CYWDxadcejzt65LMfSHnfbviuGpb3/HHpYiAlzUizIYPsBvdn/A==
X-Received: by 2002:a05:6871:5291:b0:2d5:2dfd:e11c with SMTP id 586e51a60fabf-2e3c2800e09mr7135103fac.7.1747667746597;
        Mon, 19 May 2025 08:15:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5? ([2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c0b21e70sm1776494fac.41.2025.05.19.08.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:15:45 -0700 (PDT)
Message-ID: <556bb250-d7c6-48aa-8773-26799265f782@baylibre.com>
Date: Mon, 19 May 2025 10:15:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] iio: adc: adi-axi-adc: add
 axi_adc_oversampling_ratio_set
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
 <20250519140220.81489-4-pop.ioan-daniel@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250519140220.81489-4-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/25 9:02 AM, Pop Ioan Daniel wrote:
> Add support for setting decimation rate.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---

With the bit below fixed:

Reviewed-by: David Lechner <dlechner@baylibre.com>

...
> @@ -381,7 +397,8 @@ static int axi_adc_ad485x_data_size_set(struct iio_backend *back,
>  }
>  
>  static int axi_adc_ad485x_oversampling_ratio_set(struct iio_backend *back,
> -					  unsigned int ratio)
> +						 unsigned int chan,
> +						 unsigned int ratio)

I think this change belongs in the previous patch. Most importantly because
it could cause a compile error during a git bisect, but also because that
is where it logically belongs.

>  {
>  	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
>  

