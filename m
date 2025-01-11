Return-Path: <linux-iio+bounces-14144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264EAA0A648
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 23:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD6C3A93C6
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 22:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C441B87EE;
	Sat, 11 Jan 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3ANu8ZZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81E1CFBC;
	Sat, 11 Jan 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736635577; cv=none; b=jGB/j/s5144+k5tu47LdRoLWJcNjNNVzoqjlu6AKACMfg4RRHhktSgKu5wv8rqbTxBnnce9ElhM80xaoxvf2fimyR2XjhuGfDi9rxRj9Tabr8Mws8HGzQ71rkhPOAqsgkigdTv6YkjiLSdQX1mZgvSAF5Q8c/tdo3hfz/hoicqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736635577; c=relaxed/simple;
	bh=o+w5Li6CugsY1rMtBKHT3w/3ElEQqX2buH+hTrsXbQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYORn4+c6hsMQc5ylx/+Ova0yWyJ2QUwj8JHBZ45E6DBxiqmZQJOZ8s5GF9PjnaXIjzPAgS6tuCcZxacxsHwJRUj0qZkRZNMDU9WdbTC//JY1ualzgwkWnz/++HdtMAThlLTKc99gGWe2F6Q/wKFn3F7C4ROE/zm2UBfz0REQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3ANu8ZZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so6076462a12.2;
        Sat, 11 Jan 2025 14:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736635573; x=1737240373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CWQH26Pe6Delzux6Jgpfafp+fCmhkNG341Nb6v67/w=;
        b=T3ANu8ZZtuWwzRDp7SyFCDewGcelKiGDn49X/1cY11nd/BTi1CVF6KnTkVmz98cI/8
         njrEOmlSB1JKyFXvr339U+G4By5L4+7S1wP3/OpXkhd+TRUPtNzOGPOLELZ57d3v0T/9
         2Rflr5QAHQij5D38tA5i/uC/c+OHzzIIgYc+ylPQab2VxR6avGDgVjm39CdhrWdLip3w
         TsLkgCi9iNqRVypVqXoVZY02i9YyQkODAOsinG75pBLmXFrtPYJkO29j9WDdGH5sO9qX
         wwhUub64oaqRTMXS1/QDKuDQBj63Qs2slKFrCwsHUhR8cdA13udrCfjG+uvQwK77qsYi
         ofmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736635573; x=1737240373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CWQH26Pe6Delzux6Jgpfafp+fCmhkNG341Nb6v67/w=;
        b=gfB1ruTgqox1hTW4iMUxO5scVhknJxTRbUaqlQFhuzZPyEErn98hTcIADRP54tFeB3
         BCHD4rIG2pL3h9uNWD4Mg1ApaUKlbdQdSPx9QRp4VdEh93y/0pFSS1Hmt0aHzzNVId+e
         L+aTeatgUS+9x7Hc5XTVkl+0wgi1eaeJ94fys/P7BCmKRrvnD8Sx9jHmiJYqmM9rJ7J3
         y3Hx1IF61SPR6XtkGUyVs2HYzG8RKe2q80+ni5N33zcUYPNq2E59DVLTpt3BuhNWVbTi
         1X8x9rMBP3ii5uFRKk0d/6RH+NDB3D2zEKzYQs8Cmj9sCedM3lL5Dxm8Rre685G8/0Cu
         fXew==
X-Forwarded-Encrypted: i=1; AJvYcCVRmqQKak9tvqtCpkt+iiaPDEnH/TueDt2QlTXoiTDx9x0BlRxSHf3Qe3+WiQ2zlTX2Vx/J0UYtatd7r1Sk@vger.kernel.org, AJvYcCXR34ZmLlLuJwZ2bfMBv/BiHifxhvSSh7zyA00K6ZGIo2QPXzM1L5YqTzEN/KSCQfBLPaLHhJaa7XyW@vger.kernel.org
X-Gm-Message-State: AOJu0YzwlXQW+C0S48nGIfQpxiwAdg+CctkD/nNV65e2UomApC9RNWmF
	eGkZvNB9ggEXVm6FBiACLPzQmWjMYrBtr1JuZ1PBFmQDmVc1/U6Hy152p/yC
X-Gm-Gg: ASbGncu9NiHjvzhcq2cow96X9p0TNmI2+5UQrzqrqrwZi9IX31vgWKPEjKlO+CKwaM2
	DR8DnEXi7U/abx6z+D23wRqKBibwxps7lBk67pmUfbNQyAPdouAMH+gdre0/KEZOq1lbR9s1/2I
	LgkRiOYlOiTxDES9rYM/1GQ+XfQEqd+pjLJI4GalYfCwey1IwQ8q8vIocYGI408MppVhyU7hwFM
	johTFBLGyg0FiF+MzyJ4Bdz3IQDwIvlogNCbgekLsbyetxeiFxuETRoVvWKuyfsd5Lf
X-Google-Smtp-Source: AGHT+IHurMzxNme4ab1sCrMZd1yFcHCqtF9mNKR9A2LesfnhlWpxJG93sV11qxlTe2D6Hs/QTPrmkA==
X-Received: by 2002:a17:907:2ce5:b0:aa6:7c36:3423 with SMTP id a640c23a62f3a-ab2ab675c18mr1285015866b.1.1736635572708;
        Sat, 11 Jan 2025 14:46:12 -0800 (PST)
Received: from [192.168.31.111] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90dace5sm317977766b.60.2025.01.11.14.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 14:46:12 -0800 (PST)
Message-ID: <cdbcb8eb-b3f4-4a2c-b303-0ebedbab06b7@gmail.com>
Date: Sun, 12 Jan 2025 00:46:09 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dt-bindings: iio: accel: mc3230: document mc3510c
To: nekodevelopper@gmail.com, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
 <20250111-mainlining-mc3510c-v1-4-57be503addf8@gmail.com>
Content-Language: en-US
From: Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <20250111-mainlining-mc3510c-v1-4-57be503addf8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Vasiliy,

On 1/11/25 10:11 PM, Vasiliy Doylov via B4 Relay wrote:
> From: Vasiliy Doylov <nekodevelopper@gmail.com>
>
> The MC3510C is a 3 asix digital accelerometer.
> It handled by the same driver as MC3230.
> Document it as a trivial device.
>
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
>   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index fadbd3c041c8c39faedfe62874d4eba25a0bf30e..6c34e4c0dcc6df5a4d8edc5effb80980de820db9 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -187,6 +187,8 @@ properties:
>             - maxim,max6621
>               # mCube 3-axis 8-bit digital accelerometer
>             - mcube,mc3230
> +            # mCube 3-axis 8-bit digital accelerometer
> +          - mcube,mc3510c
>               # Measurement Specialities I2C temperature and humidity sensor
>             - meas,htu21
>               # Measurement Specialities I2C pressure and temperature sensor

DT bindings changes are supposed to be on top of the series for the ease 
of picking them by DT bindings maintainers.

- Markuss


