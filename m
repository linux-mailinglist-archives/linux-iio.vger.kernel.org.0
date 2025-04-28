Return-Path: <linux-iio+bounces-18782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD29BA9F432
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 17:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D281A83444
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 15:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626AB2797AC;
	Mon, 28 Apr 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MZw5pXdy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0C2AD0F
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853373; cv=none; b=lpUMWg6uLN/Q0SI8FY+fLeVjKRo6fgG3L0jr9VCp8Rvg9VcmyB484zjvRCMNKycTmLIYMfHCt42Y+JFB5To6jW6QPVxy5mDekDgJx12F60tQGj1GuEuFVSRDEa2gHzWQz6mXxoWtFg3neqW8Z+FQ1fWgCUc74pZkN0d9DdyS/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853373; c=relaxed/simple;
	bh=13vK4Obhj7rvHBAejWjvk3MLDIWpBAKft6VkmzOuptM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkyb+oSmSxWvgP82c17isKfno/iCBnZ5KQoExKJKAmOvG742tnOgXAzuVyH7TeW31VAZ30Fc2/6MxdULaLHEGBTz0T8YY7SaipxJv0crlYGMrjj88WKFov6miOIn8Tt5h9P6+SRwEP3mnLz28bNdjAI5eziYXoqH/4mJp+Awp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MZw5pXdy; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-401eff272b5so881023b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 08:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745853370; x=1746458170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+x5yzbFX4AN8b2XmBSA753TErdzmvFUXrJPqVYwSyhA=;
        b=MZw5pXdy9pPcm0/2T/RM5U65Is0jrDUkALlWTist4rSVX7jaghPh/qGus1PAaRYOab
         aUI3vG063etPiboRWztijfxL6xqqRbgMwvwHsjgOPORupYBKpyh+lkD0SY13uiyt1bg6
         29KOrmELm2oIDZGPNVnO953Fql0s7BcdpLwHKj9drAn+YVnOMBWGEBt6y0nLSDW4IUa8
         zcXtxB1SK5KHORAdDt18qteghuJ/Y73+WOTGvUB4LbesVwnmv0CJZ8aE/4JtjzP6eqWv
         nQur8nN7/2TBmo7jhU95FqycrSbzHWDhZckJHYsd9mRf72QaIbX/I6oS8dpSbkT/IgIG
         fKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745853370; x=1746458170;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+x5yzbFX4AN8b2XmBSA753TErdzmvFUXrJPqVYwSyhA=;
        b=ZAznss5E5I/gvSu+K388OBdPnIdBqol9JcVgzCZUuVm4NKho6jazVk3KLcU9cirTNk
         a15kZyKWoLuwPUr2L1RwISO9kyCxf1iMeaHMmR15kvsUol8rs8wPnor/VrZOBqLJ67y3
         UsKksQnPsoDgpxaJ1+44fSgNNwPBDKGfJC0MUXKNxi/QxaBLKUxQxmcrjLmWMUOS0mWT
         HoPpxZxnURQal8O6jjq0QwYom/ne7UUo2Sv5BDWSk6TfgYeTWHSrFmQyZmrCwvXnYgDu
         4H5MEqwVd2dnNPKIuB++lmBXTE3cMIiRlJ2cEhBQprV+olbn5u2NShINaeZKFgM77YCT
         Ottg==
X-Forwarded-Encrypted: i=1; AJvYcCU5exWqIPK2p1paCJ7g7ubFGR/lQV03SzdY2lIkd173OAnPvalhQ7RH8NTibo+AsuaUReR4lOrRT44=@vger.kernel.org
X-Gm-Message-State: AOJu0YztSnaBOPo5lgZqaaVM+gO6GepyT9BSpw8tZLRGCSOQI6c4mRRu
	8axfDij4GsI22krth9MQ0yhl9RJ4YV1wNgujKco+aFxzSphiq/gr+xzX/fUPOOs=
X-Gm-Gg: ASbGncuxs/uZ/vEXX/ErvQrduua2c3kUoM9Xfi+nVRJv/T7qPqNOcN8cPKIlBO4A2of
	EDt/IOsiU2BuolyXYCcf9qMTFgbqiqMpAzpXWDJAckt1OFkqXgcybzpQSTM/IN998PSY7lGSBW/
	PTewfztAVqscAphGxkP9Lti047/E4GffRSVEAt0FfEbYwqydQSTOG8zC4ibS/jT0/J2+EwDYjCv
	hHWRCHWbihQZEO7nHXvElBduOyymEfl25FCwMFSj3kyrNp9btYanuJMi8B6E8zmC4TPSjJ+g1Nb
	y4WXx448EBg+KN6WXHFB7swONu7uwBwEWSrnhyT0H5ziv+k33nnc/63lFQDlYW7fw4c0oA47GHU
	3U/63vnLlv+pVsujLnw==
X-Google-Smtp-Source: AGHT+IF7zkUXkn5KYJTxzpFih+oinj+dC7Pj6YPEzLUjDUEfcVbsAqulIGlLRI1jrQmsg+mM1Vm1sA==
X-Received: by 2002:a05:6808:158a:b0:3f8:eee4:7140 with SMTP id 5614622812f47-401fd7270b7mr6158135b6e.22.1745853369918;
        Mon, 28 Apr 2025 08:16:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9? ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec971691sm2083493b6e.39.2025.04.28.08.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 08:16:09 -0700 (PDT)
Message-ID: <b7adef4b-68ae-4a49-937b-307e116976f4@baylibre.com>
Date: Mon, 28 Apr 2025 10:16:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ti-adc128s052: Drop variable vref
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <59106e24332743a7f9eb0b13ad6a2f5595ab485a.1745823530.git.mazziesaccount@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <59106e24332743a7f9eb0b13ad6a2f5595ab485a.1745823530.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/25 2:02 AM, Matti Vaittinen wrote:
> According to Jonathan, variable reference voltages are very rare. It is
> unlikely it is needed, and supporting it makes the code a bit more
> complex.
> 
> Simplify the driver and drop the variable vref support.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

> @@ -183,17 +173,14 @@ static int adc128_probe(struct spi_device *spi)
>  	indio_dev->channels = config->channels;
>  	indio_dev->num_channels = config->num_channels;
>  
> -	adc->reg = devm_regulator_get(&spi->dev, config->refname);
> -	if (IS_ERR(adc->reg))
> -		return PTR_ERR(adc->reg);
> -
> -	ret = regulator_enable(adc->reg);
> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev,
> +							   config->refname);

Is this properly aligned to the opening "("?



