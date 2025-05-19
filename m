Return-Path: <linux-iio+bounces-19707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DBCABC328
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 17:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5613B7D6A
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B648828642D;
	Mon, 19 May 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UamEbpn7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1ED285416
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669867; cv=none; b=odTkKLT3MR4VUzC8Rjsk4NBStQFToGnt4595I1yJDb+DcJwldfNtM0EvuvP1ZBZ6A5rEjoA7aM5GLxf6FOKdEHU1pbGnC8ELcV5KW+PWZcpxTwWRIMO/d3UwJQknMwO0y0pvOSbalufJ/8s1LeIvBMwIOXKfmyL6iFVWFyqNWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669867; c=relaxed/simple;
	bh=WtXjgHGgOeWhkZnhe3EEZ4oiWzAptq+Fxpl6tc7EjZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dse6jbbgJic2/4ILsFnWty+gSOi35hQv0Mwg0/5tNk0aOSf/xagQUrIF/sG3J++eX3qkEKNXDzCUYGOuKbRdUfowWVcHu6WyNVKTMFIzfw5QK3En1A9r6f7FXrX+kPC02KNlpBbJfIfw0sFevxHKFxC0uMoP5njh1ji5gU3snOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UamEbpn7; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3fea67e64caso3465734b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747669865; x=1748274665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4R1jjXpvGFZooNqwzquS4BoBFMZHfpqMKV80JZ1CvuA=;
        b=UamEbpn7nxELoA44WJVW+ubaZsRxztzIsnnd13E+2z4vp862uIczRd9CEos95UifYD
         B0VonvuLci4OIyZ7V6wXx9fRIypzCd8FzLG/wPPuhA6ctbNiIZHGVe2rhH0AsUcSvhcj
         hhPB1PZw21DaEekMxn/j5ccKUjuL3Yoa0CqBJKyUjtATfQUaORRTmeKru3km2f5Wr+K+
         9R8Eg+qHEtL8SRCn5e98nd7TQklxagYH52Raymc9++p7bjmoRG11u4oGBvtftDNIB+gj
         PjA74NNFbBwCEI61ejpHeeJtu+NjKyUexEH2To2wi7ca1bn5cCWl9D7kP8FtCPc9zj6k
         +hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747669865; x=1748274665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4R1jjXpvGFZooNqwzquS4BoBFMZHfpqMKV80JZ1CvuA=;
        b=S2Ds1ZadJfVuGZ2UJeGOq1Wu12gF1X3sED6vvHsOBV3jjbzSvEfyuXNp8Z7hqWSWRP
         TyfyX+y5h3ZFyzQqDQFE9ILIEpl7yVBsI/eEvGRy46KU1K0PzpOiITVG/IU6BvHBAE94
         MK+qHyaeZoMi5ePJ3nL0hzZou+iwSU+uVjcKmLXd6AvVIeTncQjH6g0mu/Squ2hEJpkR
         lvZRLwAppN3GbL51muAZWaZ4A6SKf70K4weS7qwapSzJvUAv1Fvbrb3epUYy9K6+diZY
         IbSkm+a12iAs3m8We4cdJMYS9MscqWfxDtrzDnD2zY3+a5MJ9vmAtX9rmD+XXbAbpIKC
         LdSw==
X-Forwarded-Encrypted: i=1; AJvYcCUDcVcJMuT6XPXzYh86VcEuvSt4K/lTu+XHvoqwI6GD4Tm7GcwK8K703YyYk8Nw3eBYFZYwfSyK4wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9BG5svuqo49hY35Xfigm8pN8VPw+fTbq9tXvsZiOy0vfr28rD
	IK3eM4081DSceTdZCPa3Yq3tDFXhQcw+ufZGktQmeUhk4sO7jhhH3PwHHdzzCoVc9UdVz/HKypA
	8t+YQ
X-Gm-Gg: ASbGnctQQrUeOlh1nb4KKqTuPxyeSk/xe7J9u/bWUpSfDwKbcFkitdfFHWxrgVufs/x
	at1KJwUIopudGWMqI5ymceKRfy1jc2yyNsx8YEYxcE5Si1wxDW4JOejuxHOSj01AUVyY35VTVuz
	tyNS+CSby7CkyGBjHfHD6bQlL2OVSdVCa4B7v1Je4LY4V5hxOon5tP4tYC1y0ZYYo2MVdLjiFbd
	3PKYum28tEsvwaUiF5LDAJOdScrFWdcvKFiO9KFtSsKAQlDK2/L9S76u9PJZArVcYmh1TjCX1J2
	EYrJcpa8fplE9Rj7ir3J0bvX96myyC+POPMK4Faoid3gDa4YigBQQH2qvKoU2N2iGubsy5MU3Ls
	e1ZjWM/OBK6XUyiqFIdHxswsMeA==
X-Google-Smtp-Source: AGHT+IFr8We/4x3wKFarQINBJsR1rX8wHZI8lP1EpQm+Tg4CIOj5A2c5zLtagPVbttrgQ1CNzVdJBg==
X-Received: by 2002:a05:6808:3a12:b0:402:1caf:7789 with SMTP id 5614622812f47-404d8767942mr9511245b6e.14.1747669864661;
        Mon, 19 May 2025 08:51:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5? ([2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-404d97d6129sm1404336b6e.8.2025.05.19.08.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:51:04 -0700 (PDT)
Message-ID: <9f5dcb2d-3fa9-4e39-9cf9-c5a23847224a@baylibre.com>
Date: Mon, 19 May 2025 10:51:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/10] iio: adc: ad4080: add driver support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
 <20250516082630.8236-10-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250516082630.8236-10-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/25 3:26 AM, Antoniu Miclaus wrote:
> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---


...

> +static int ad4080_properties_parse(struct ad4080_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +
> +	st->lvds_cnv_en = device_property_read_bool(dev, "adi,lvds-cnv-enable");
> +
> +	st->num_lanes = 1;
> +	device_property_read_u32(dev, "adi,num-lanes", &st->num_lanes);
> +	if (!st->num_lanes)

Error checking seems not strict enough. Allowed values are only 1 and 2.

> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid 'adi,num-lanes' value: %u",
> +				     st->num_lanes);
> +
> +	return 0;
> +}
> +


