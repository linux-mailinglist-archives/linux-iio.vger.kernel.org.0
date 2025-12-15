Return-Path: <linux-iio+bounces-27090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA49FCBF243
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 18:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC736301FA41
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF49340D91;
	Mon, 15 Dec 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VK1N73iH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7EA340A7D
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816868; cv=none; b=R3gKr/gGlL2b0nc+3d2qlV0zL4TcJNTvZacKB8CqtRpcVC/senXkeydwcbRZnIzDEUQnBE4RrZH5ufD21hPOzhQPbjxT9ZzaVBh6AJML1NMv9JH0YKjjSzMTmb2+xbg+85ys+9fGMyasZQWZapkNL5FY0xXwxhKFxVLmZBJMWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816868; c=relaxed/simple;
	bh=y5bScCkMsOt0OM5pawqhWSn53Oaq6JppUmW/97i2jFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvMJD9uNzr9eV7IRPw/KCse887K3BearTW2Owg0A80pRE8GrbJcEDBbYUYCKXgX52+5JoA2GoGC2RryJ1Ow+Y92vxKPqDZkvPGQSULX3e/Puiuwj1HNV+/35k98E/Mu0YoeA+GS8y65KUW/hAQb/XjQHJa81Cka7oxYeeUfGcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VK1N73iH; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c7660192b0so2638933a34.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 08:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765816865; x=1766421665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GN2v/2ezRcsgAtgp5shQ6tWBDVdeAt0URzrgG6DIj3w=;
        b=VK1N73iHs7rdabwkiFfOBxJSl/R71C+QhVVcEqZGLN7otpzA8AcBXCGzDP4EEgsPdI
         sov+H/96LxXrZMRHUzcaoKYGALbu9kNVMNKYK3ZLG2xg1iC0fXziuWYSL1u8TL8h4pWG
         Ysywg9PFLNDdR76yPg1Yf1/opO/stM48Nlcdj2Ui7ZdiF6FTLfIlf/tA2X9LeY5BWG83
         6Wkcv1opIBTR4c6cVAUPjJ3w1+7/sXhM0rEzQs7jjSwHmuLP+N8Te88yCbCCKig3bzC4
         9G6VKv2aETwNlkDMSqXVSL8hwr1F88tCv5Mp4hgnIcE2/8Gdl3uCfXzGQuJam42zow9F
         Xnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816865; x=1766421665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN2v/2ezRcsgAtgp5shQ6tWBDVdeAt0URzrgG6DIj3w=;
        b=KBEF+GlG3IOzhoetY+n+OjfGfZoZq0obYy4CqrxZGTot/0U2R3uWIP5Cs7J6lZgB2v
         vgLAtX8Uta2Aga/Ru2HHRbEgl3GlLDrZdY2W011Dtr2G9NbFAYS7kE2RKD0u/begYGXv
         JRKsdXgQAFImmMpizsi1C+Ub8lbwctvXC0/4Rais3NNe2Ze59QdnUXeRp/jN+Ddl7enJ
         DTBX+kgBaUFvDmsmb0xayvOtzE6I8HJByIJnhXVP+kR78JemlM+gmVQjYDVYy29WsUT7
         x9HO/kEgP0b1Gcc/XjcuxsmHPwpfJVPEkJV7ISjxS7cUlADF/pklTGilhNiK6YiwYq97
         00rg==
X-Forwarded-Encrypted: i=1; AJvYcCW3ynrNvDPOvXGVplNTUiY2nLPDR7PyFWPWVdIhzhnqrqu4q9bJODRm50wf1t8do1pRuoVmlT5a8Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZzhcbwg+QE7JrnERdbrMPtFgVUOwfuAjrVESEm1qo3GWzLsw
	aOEdKK1gIKoCn10WST52kT33b/rMo6Od6bJqYOKVb4x+tP1uA4WUKRI8Zi9h857bc3s=
X-Gm-Gg: AY/fxX41kQNAIw4HSdkFC7IpkweFWm7GhfHy4pzpBLSmJjAe55LwkuUZ/1HB8Zi2wUQ
	TCQTIFxiaAXQ8ZUP05O7zW5yeKQU1VcAbSnAyjUuF+BQlGZy3xQiQGZxvMTfoRMm+0FgwzCZWpQ
	RG4tpb816E9dygIla6l8K3HFBkHwWAdnuTINKTBnv/kYbxSG/H2sGkY8zycrLcQIH+8hqPMwKdh
	07vZEmxBNKPAat+EF4laA1rhJ9O9NCRFU5yd+3vmZICTNru8dbsLM/hmlsa6KeI7Shge5DMv4al
	Y+5XKzR3ZGg9cp391mjaldkHUKsxY+C52LY5yZlVqVSw9kOW3t/o/Lm7MQXo2kQ1iicxtig3IwY
	BTwnVoUUAvfEvmo/W1/ObkJSXyJ0mTm8EeYkzAjBuZlF0CCl4wKxFwD7rQmm1tC4Bg1O8aKdrBy
	N+9iHCfIOozWbhFORgz0rA4j1HP20P37LdyWzDcws8LBqWdFj+UAs4ryH0optm
X-Google-Smtp-Source: AGHT+IETzkrhmvN6k15FVo/fxunqZCkMsRXAmBgkRp0PC7XoYu4pVDMCOLJ+872365vqu2AZhs2RHA==
X-Received: by 2002:a05:6830:349a:b0:7c9:5bef:e9b with SMTP id 46e09a7af769-7cae82c6d11mr5847375a34.3.1765816865540;
        Mon, 15 Dec 2025 08:41:05 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758? ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb345977sm9646647a34.29.2025.12.15.08.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 08:41:05 -0800 (PST)
Message-ID: <64181fc9-4795-4c5b-97de-a9482eea4bf4@baylibre.com>
Date: Mon, 15 Dec 2025 10:41:04 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: chemical: scd4x: fix reported channel endianness
To: Fiona Klute <fiona.klute@gmx.de>, Roan van Dijk <roan@protonic.nl>,
 linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20251213163226.1678707-1-fiona.klute@gmx.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251213163226.1678707-1-fiona.klute@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/25 10:32 AM, Fiona Klute wrote:
> The driver converts values read from the sensor from BE to CPU
> endianness in scd4x_read_meas(). The result is then pushed into the
> buffer in scd4x_trigger_handler(), so on LE architectures parsing the
> buffer using the reported BE type gave wrong results.
> 
> scd4x_read_raw() which provides sysfs *_raw values is not affected, it
> used the values returned by scd4x_read_meas() without further
> conversion.
> 
> Fixes: 49d22b695cbb6 ("drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor")
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


