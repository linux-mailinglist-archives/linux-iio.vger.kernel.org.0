Return-Path: <linux-iio+bounces-14022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A744A05FC9
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 16:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E7A188942D
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8017B1FE45C;
	Wed,  8 Jan 2025 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R8ZJzvlq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ACF1FDE1A
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349459; cv=none; b=R6Tskoje9sshaJOIC1YWm9dsFuJbAa6XL2F6hJE4quoinub+KY9E77V1QklgvMgQEzHSl0knQbxJbN6gxtD+nF9PeQF/FzOM9lvgyG96VEcD+CTHd5zbVmfXqEoT685RXaR7fotKgR3mJuoyvGRNJyJmN6SfbrxdsIk94FEj2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349459; c=relaxed/simple;
	bh=Ebeg1TL2BeajKrP6fpDxuqrt/iS+ncCHefaCK9FF0No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKY937xZeFu8OsuA9g4n9DNJrP+13L8QZ+4ll47EV/3JIDtreFRTZNfO7FOCHmGLrHmfvGET38/zy0TrWUvD0od7LLoyjN8fG0R9LHN1iDpqApUKi68hPG11vpUEeynE9myJp1TksPJtrTDgA2lMOF2njc27lp9flM7CXvapW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R8ZJzvlq; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eba583fbe8so5583675b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 07:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736349456; x=1736954256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alG1j42X6iRKjZ4baHXWov29C3FPDTojvMLiPpX80+0=;
        b=R8ZJzvlqXsnKt3Ka9F5l9TeFqxa+10QsBWZ93oc5V5ApkSMO8KL7/HCdT4kx98iTE7
         OujbcRWIdadEleoxFDLPftBEVIw5wXK9uUKoysXyCnJ7ty6GEMFaqtwmvtXRAupk5+Of
         BKYCKsMFLsTzqdr4KfEkt+CXM2Kn+vrsemmLGkPSLM+SextJtdalYLzbKOCH2quTbK/M
         mejLNysoh7rnl/orlBP3llT4JYXHAjmxfUMN+NPl9xXDyFxCyv4HppiqHoRBM5Cl/JMf
         oUmrjJPtQdb66mHoy18cGWAm21P5BJefXXbMLIuli/baqgrVxYE9JKqlJURkGpFUCAd2
         05Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736349456; x=1736954256;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alG1j42X6iRKjZ4baHXWov29C3FPDTojvMLiPpX80+0=;
        b=VIcJ7MQjy4wm9SSqMYuhzNMemJ/W2iNRgyan0x5eEnh2IYxrgy5Ubp1r0+fvETNnos
         fGAOe+nuXPil/vy1qkESp8OVtHxO3JvU5CGLi0/MNihz5pUaCQtUem4bG11lOTO3zduX
         iQ5dGM40rvZa3bT43dkP3HBYsXKsIV9VJk6Y265GfHae07usqIHgUW5/d0QNvmbcyFFV
         +sLrU+likFq0NdNETYhkCfHMSzIy2uUTRDKBb6+LWL/O+PwSTNtgv82aKHfIdcHO/3wc
         t1M6SlhfJypeMflvgamqRwjvMIR+jqNuMJUgzlp3HPJ4g176Q8ciCaQgwfhns5Yc5A3q
         bwJQ==
X-Gm-Message-State: AOJu0Yw2XuiMttl9Pn/BkkHw4aS61HdJNtP6WCkgf7UxB1gffy8m2dru
	Rgp3jL33JkyP1Tqu1lcHXy+3+QacE0LI3wXXm3jojBmaeEN6T9p0EJSPg+9OxCU=
X-Gm-Gg: ASbGnctcdd8LCudglQjFYCFD15kdnzry/mhvlW7PRvIFzU/OfkxrMwZPRVVNK3OujTL
	hRYA+0o1n/cCMPoKXlYJ/hYDQUzAwZ+81g0V6L9GSmHvhKuJ0Ht/mfFq5ptMQ9Qg89Kp5ID6lj/
	RuUsvGT66UfFYC7qDUHF99W1gtmlMJjt5sYoIKC/P8bwCvJhGGByyjYjNx3muYtPhOM5t/y/LIR
	jFDgPU4tIVvfZCQPeFVzpnrut3GdBTol2qPqu9yLsR8xXwfR81fdFeReu+ZFPdfe7O6nU5orw0v
	NZgBk5nkGy9aLbVkfw==
X-Google-Smtp-Source: AGHT+IGwVgCGjQbO/qqRqSgc1J+RRMGG/noUnXoE/RftuE6fGYBcA6ytF5/pzERHkiy1D6obDhsWMg==
X-Received: by 2002:a05:6808:1825:b0:3e6:1057:21af with SMTP id 5614622812f47-3ef2eeb424amr1616812b6e.41.1736349456457;
        Wed, 08 Jan 2025 07:17:36 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece2549542sm11552313b6e.32.2025.01.08.07.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 07:17:34 -0800 (PST)
Message-ID: <f53c6f9d-f17c-45fb-b8dd-b4eb8ef7a15a@baylibre.com>
Date: Wed, 8 Jan 2025 09:17:32 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] iio: adc: ad7380: add alert support
To: Julien Stephan <jstephan@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
 <20250108-ad7380-add-alert-support-v4-4-1751802471ba@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250108-ad7380-add-alert-support-v4-4-1751802471ba@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 6:49 AM, Julien Stephan wrote:
> The alert functionality is an out of range indicator and can be used as
> an early indicator of an out of bounds conversion result.
> 

...

> +static int ad7380_get_alert_th(struct ad7380_state *st,
> +			       enum iio_event_direction dir,
> +			       int *val)
> +{
> +	int ret, tmp;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		ret = regmap_read(st->regmap,
> +				  AD7380_REG_ADDR_ALERT_HIGH_TH,
> +				  &tmp);
> +		if (ret)
> +			return ret;
> +
> +		*val = FIELD_GET(AD7380_ALERT_HIGH_TH, tmp);
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		ret = regmap_read(st->regmap,
> +				  AD7380_REG_ADDR_ALERT_LOW_TH,
> +				  &tmp);
> +		if (ret)
> +			return ret;
> +
> +		*val = FIELD_GET(AD7380_ALERT_LOW_TH, tmp);
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;

We can just return directly in each case instead of using break (preferred
style in IIO).

> +}
> +

Reviewed-by: David Lechner <dlechner@baylibre.com>


