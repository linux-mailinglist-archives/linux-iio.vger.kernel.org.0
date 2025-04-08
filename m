Return-Path: <linux-iio+bounces-17825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866D3A80EB1
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 16:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCF7189AA4D
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014AF1F4199;
	Tue,  8 Apr 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2x91VZV8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4214F123
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123396; cv=none; b=rUgQHB4D+/ZdaI9+6k5KhOt2EYP/jrYnqRUq9EUHWPDygCUOmVL+ziYgg+mTLhHCWY7We31KZ8Bkj95NoZllcJc4ODZ73V3grjinmSVq/3rcx11dfUumaXXisjv0HjmSAwxSoHPSPJv3lC+ugPicXC7+kFltmvrL0SmegEY6A6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123396; c=relaxed/simple;
	bh=5X7WiAHhEsNxH6J2yVsjgQxTBS34hllTgevGnMaFPII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlycUawrzOPBwiBWJbYFZoEKntR1cel/OBpjBiBIGgereOSExdJQ/F/BJ3488+X1J4Qj1yJfndrDdBxwW+9KN6W34f/IbkiIRzh262hK6yFS6wrFnHl5TMqtdzwf4vSub5q+tZWTbMAaphByFAqmBfvvmiEyh5vPSjX0aPjELwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2x91VZV8; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fcef5dc742so1644778eaf.1
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744123393; x=1744728193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZX0aGXRptTCUQcorsU5tL8EzdmJ/4Dcw0VhDpZ9VkFw=;
        b=2x91VZV8Lly/cctXzyrQ9Zb8URKEcOh3hZczKan0mwYIBwc7K09W0xTihHXoH5Ss7H
         Ml4vaOEsD/eo9wBYYNdMFIjfrv/EHJbWQMufaAsIw+tN2enhc6UanttFzH77AlshTAEo
         Zfw+pjvpz5mJt6BuoS7RxnH73/6MDSpcioNGRJnYHl0zL1Q1I6wPKKnZCpiqL6ixcePM
         yAmzcmbrxN4OSLH99v9ESU+zIvVSxuKR43ATYZaMbMlHsV/wCf6IXTX9TV/Rj7WpBBsH
         7x71k1HV/t+apiPBcLms0nDe2cGMeyMBK3i6Fk2Wy/Y+EYbsLtn2xE2+9UAYq9Uur6mL
         obgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744123393; x=1744728193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX0aGXRptTCUQcorsU5tL8EzdmJ/4Dcw0VhDpZ9VkFw=;
        b=gFQnSVA4SyXxL/S2S892RECl9FdAf3EWwGDJSN52CRemufKz9t4XPaVE0z2dY84MUg
         /QBYcvD2fPhRe2qUmtowTMBzzrFytB4o1ctMnLoROpB39h1cc/YwecCizt1XHLewHOUK
         H04TN6swux7WPoEUxWEFHdKmVdzTTMmEKMwvFRnNF12KmAHQ0mHQszXS7fAscIwyRtDu
         JP38T+V6Vc4nbgzT4tq7vNh6uZuzQe9kjnxkcJOiBgOU9OPsW5OdjG1ribC6elussmW4
         7bl2i/iiwttrSnl0Xw9ui14n4jlN8+EYRI8YUtvoimfm8W41K3LQon18LfeOTJ5Qkg/J
         OqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIA+zBjD8UywvkUvFm/onlSgZiEazdbR5uRrn1xJBsBeDiPzeboVu4YrC+uf6uFJOHzij9jptxm8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbuBI1wdt0cMLFkuKDCsKDID9W9ClUMhrDYoEB3fipu0j+0w2
	YascLvy0/dYDT0ciefy/XItlAhx3bhsmST2ipeTrIKlJsp+iSOXz0B6fEVWp2KQ=
X-Gm-Gg: ASbGncvdD2ENQ/0cxZNryzVwPfUe/A1hgbzA6W9DiXxPpvNufvlHXoaCJj4hRPovhxG
	nsMjazEsZv+PnvuEtcgXG/c2X05enVKDrXpImu+Rzh1H+lHrWxxmG/6O5S8OxWVDMEKxSQUbN/o
	6090qSghz0N7hAAtG/7BS60vgKnMObUPXNSxlG+YecF9vqX0W3KubR5TM1MqEoUJ9ri3hZxtbh0
	yVSz0mG6/7+hROXpCTkeiWogvEj1ZWah6eKEg/Pj4A4Bhr1fppHkT7lb5T9HsFZnmnXLWb2Ywi9
	rG/JIUf2xzvWnLNWnLd5QRowm5769OeaGM97XfK0uO5BiMkj/TvbBBfZiNC6Zfa7ICBjanr60N1
	Sf4kYfeyyUojfHkWq
X-Google-Smtp-Source: AGHT+IHydLilQvszzuRpWvpl8zBnzCfe2oBsCFFQZFAPCcrx+PW2NEIcAFyuNBZbinDzJI3j0Elo8w==
X-Received: by 2002:a05:6808:4493:b0:3f8:7c69:561b with SMTP id 5614622812f47-4004d99ffe3mr7838878b6e.14.1744123393329;
        Tue, 08 Apr 2025 07:43:13 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40069105b97sm475279b6e.13.2025.04.08.07.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 07:43:12 -0700 (PDT)
Message-ID: <0550fb58-cff3-47fd-b5f4-cbc19113436c@baylibre.com>
Date: Tue, 8 Apr 2025 09:43:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: stm32: add oversampling support
To: Olivier MOYSAN <olivier.moysan@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250403162358.1257370-1-olivier.moysan@foss.st.com>
 <25b34e60-5392-4bfb-b994-49212dfbdb22@baylibre.com>
 <6d12b6fe-85fb-4345-bf32-02c0fbb1a27a@foss.st.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <6d12b6fe-85fb-4345-bf32-02c0fbb1a27a@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/7/25 11:07 AM, Olivier MOYSAN wrote:
> Hi David,
> 
> Thanks for reviewing,
> 
> On 4/4/25 18:15, David Lechner wrote:
>> On 4/3/25 11:23 AM, Olivier Moysan wrote:

...

>>> +#define STM32H7_OVSR_MASK        GENMASK(25, 16) /* Correspond to OSVR field in datasheet */
>>
>> nit: Comment seems obvious and can be left out.
>>
> 
> Oversampling bit name is "OSVR" in datasheet H7, while oversampling shift is "OVSS". For naming consistency, I used OVSR instead of OSVR,
> and highlighted it with a comment. As an alternative, STM32H7_OVSR could be renamed, but I would rather keep it unchanged.
> 

Ah, my eyes do not easily see the difference between OSVR and OVSR.

Makes sense to keep it so grep picks up both spellings.

