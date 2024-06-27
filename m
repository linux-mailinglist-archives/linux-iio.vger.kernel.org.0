Return-Path: <linux-iio+bounces-6978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 944C791A070
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 09:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130F41F21BAE
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2B450291;
	Thu, 27 Jun 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZaTYiCh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18D33987
	for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473490; cv=none; b=hv/jMh6xiC7NO2hTsplJeoUHyVEfWLToI4hu16fOo67GF6s9RRLbIhv3AZmR0LpYN+gYWGRZ+ypaim32qM5vBS2flwYtgBVTV4IGNQ31Lxnzy4UE8hF/odACYYGP8U9jBiuUR/9mM3N4GdPamRMukDUzj8totTV19RcUjmIRSas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473490; c=relaxed/simple;
	bh=rzDzICuazei21f3h6y6SQset1nU6/h8r6N5cZwkWFFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kA80mnBMr/m/cjOOjOB0AShCpEEw8VjDuD/Y9lQibOSoE3jYUAF5s/uNJtfQV1phQnu6PPJFC6NEjvqiErFXRy/FDRpJ/uyVR4gcYdbDJ27EtXDZqPusUxNooad1fMudosWpg5eV5NAjN65Wnv8HEYStzgVyeH1ZRZNhh2122Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZaTYiCh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3674e1931b7so80012f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 00:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719473486; x=1720078286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ8JN1SVVF3bcXz3+sNuzDR+UW8SxaEFyAR+qQpt2FA=;
        b=qZaTYiChDc9o2IRLUYVWo6vizyDcu9hNgnDHGn+6FspKjkpp3aoUJn5DIgkb1BiFEO
         lCKgyHEG/2RbEP1C661yCX7kt5FP0DroY+OdXw60twyQ8p1gd31C9IDu2eoXpjN62TZB
         Q3+3jmnWmMRMxR26wmcIeMXiYErPQeyxbBaCBLX0R9smY9EsD6GFMqXVbso339SmdmoW
         XMVgZGdY+4YR2oA30V0jJQkIZx1jKIO6XczIfyUxWmjjAz/cNq0Cbm8Usrbs3kPg9H0c
         6Zv+tEMrecY9+09RNyunmCGDZbxFQR8Jh7MgOnHYVdjkWRQzMTpK9HH3jBTci1fCEg3f
         qoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719473486; x=1720078286;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZ8JN1SVVF3bcXz3+sNuzDR+UW8SxaEFyAR+qQpt2FA=;
        b=fTWy21zui1Zn/P7eO5oK4HzRHQdmdnHyBSboH/xtk99JcZe+dEAQU3GTSFt5TDOffI
         MZoDuxHlD0Ba6+91uc40Ngp1t+wbit0qZn78kE6QPpkX8ukzBQQHj7JVIoF2ZFqUmede
         BBBOx1HeIziZuay/0AksrZUGXrWE02G/3/9jmrCnGPeWykPbjRxNxbdP6KaZDVHi31AL
         rscAWEFO2MnIKdrsKZLsJUeo/TeuIzFd71SaIRrhflOCZiMSB6L4yvWa5Llx9g8jKFcr
         Wo8PycZt5V0/QTIQXPRpbG6ygENoLhmmW+VgIp8Q8pc+6y3yMiZDxvwYQziQ9fepPX6e
         N2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUhAt/JuyBNs2s0VeNNkKo8OzfttyjM8WP7jMPu+3MkBak2OzDz2mRknJF0yZ2dj5RxI0HzpeJ3lRNczTAAozk7AdB38lE1eQlx
X-Gm-Message-State: AOJu0YwYjx/wevDqU5ZGF6pCIOQQ4S17oHcAAyrnIa3e+bJ5bFp969Yf
	hufRyLKR6cBONJU6kty/SzM4doSi+KJcMxeMVIpDF1GLgzs8LNviyb73bo2LE04=
X-Google-Smtp-Source: AGHT+IG4PV2w8hS0lZaxFiusAeCEo8g7HRWBi/zyY8Mpc9tSBxVTvELrBpoSj5wPzK9TsB4WoOG2MA==
X-Received: by 2002:a05:6000:1bd1:b0:35f:20da:e1a2 with SMTP id ffacd0b85a97d-366e94d165fmr7489303f8f.30.1719473485699;
        Thu, 27 Jun 2024 00:31:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674369ed24sm940221f8f.111.2024.06.27.00.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 00:31:25 -0700 (PDT)
Message-ID: <a3813504-4b6b-4e3f-ad9d-c93841a13b52@linaro.org>
Date: Thu, 27 Jun 2024 09:31:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
To: William Breathitt Gray <wbg@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Judith Mendez <jm@ti.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 David Lechner <david@lechnology.com>
References: <20240612135538.2447938-1-jm@ti.com>
 <20240612135538.2447938-2-jm@ti.com> <ZnyZTq0rEFP_eWCw@ishi>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZnyZTq0rEFP_eWCw@ishi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/2024 00:42, William Breathitt Gray wrote:
> On Wed, Jun 12, 2024 at 08:55:31AM -0500, Judith Mendez wrote:
>> Add new compatible ti,am62-eqep for TI K3 devices. If a device
>> uses this compatible, require power-domains property.
>>
>> Since there is only one functional and interface clock for eqep,
>> clock-names is not really required, so removed from required
>> section, make it optional for ti,am3352-eqep compatible, and
>> update the example.
>>
>> The clock-name also changed for TI K3 SoCs so do not allow
>> clock-names property for the new compatible.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: David Lechner <david@lechnology.com>
>> ---
>> Changes since v4:
>> - Drop the new example from binding
>> ---
> 
> Hi Krzysztof,
> 
> Are you satisfied with the changes made for this version of the patch?

I did not check, because it already has an Ack from Conor. I am usually
not double-acking, but FWIW:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


