Return-Path: <linux-iio+bounces-26390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DCEC7D493
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 18:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 414D94E3764
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C1286890;
	Sat, 22 Nov 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UbByZQUj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F3221DB5
	for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763831175; cv=none; b=QfP4UPr73Jimja1GwDYNuAq6vPdIt/feMKSs1udm1FWqMvPnUo3ncNnkL+JExmQzmWIeliomAP4LgCTs++Bfee9kHQ5x7Wk5oIYKm1JI/Fq80XiWnKwK8MaPzhDya/iNQt6Lm2HgaTqLvibvOgmhWPQtgEZQYDLzY14OTB8MEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763831175; c=relaxed/simple;
	bh=BjYN9KVpj6k/cdbwYIU96egJdlwqxlFXknvKkAJzUUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zvswo+649+yoHe5ZQLYTLDVaB36VSPd7GNzxTSuqc0s7roWiNWuiL1PgFAyuHm3WB0L9tv/4Pmjfs4o8UrZXOQgaxhaB6i7IWRDq8VZiqVg2un+ORSNbrVEskzbVjLg2oeZxDtGZ9j8kAKlODLzCBnj5YNmi/hAoOFlcmLGGzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UbByZQUj; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3e7f68df436so1695183fac.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 09:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763831172; x=1764435972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiTj6DmfHFLNbN7gghkMYecVa4SkrJ/b1ayhBYh4ZlQ=;
        b=UbByZQUjuHpcVJ02u/3K0yvdJ8cJX95ZTzeMMzT+zhk86E5SnMg7kJM4qHjMIw3qTF
         eB+1X58L9eanYqj4OPLq3jiZAAx0ZMi64zothVDsgjlibh8QTNea9sAmTfXccFNRqH57
         dqzoUamKb1mIX5W9ek272LyU04QpfJZtgLhtQVxUS1l7Gx0Bnt886jZSbTjDT7NQ3s0n
         k0/9WSIo/48Oo7ErXZP+HPNuam/35ButjHQIqHvnTXcPhVKeksd7Kj23YkpSaOsr38lY
         zjv3ocC3+GKZ2f4v27HpRdHHuoyvbvyZVgIi1FzqYKR+xsITxGGvR2be+sTcqnpfI8qh
         rQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763831172; x=1764435972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiTj6DmfHFLNbN7gghkMYecVa4SkrJ/b1ayhBYh4ZlQ=;
        b=mz7dAaiBp+XYibmTpuTnS7Fhsi/VYmrArNR0iS9G/JpaHTadI+ifYyvwh3b1lV31YE
         NaQqGX/Rv0xpU63ZQ8qDRfJ9mQg+YUAleawaRdo8Lga7pmagO+xAcv9t1F0hsOldZsET
         IBvx4sCLCtK5LUoLeHMUwZ5bwm9Qu2+L8cnoo0U8NWvd2R4dIictiD9Ak1/MzZ94AYJ9
         1mX34PWjGf1haFsW1ADioDRBqaUtfIViWXi2umlgOW2kxQ65TacUti1vwJWbO57BkQYT
         a+vTnTW6y3YP50HWYmwOP/THebYE+tT+2n/6et63687fKSV8/jbedULQW4yj4f3B3119
         EDcA==
X-Gm-Message-State: AOJu0YwSNh8Jmu2D6g345S773viXAx7WZeO//FEz5tebFjUjb2yF54NT
	OJtnTNdcRLezmUkKR8WvnHEZpE6TU01VUvJh3q7l72n5iIC0Bsr2NHAOh+KS8g2kCz8=
X-Gm-Gg: ASbGnct/WkRLNSOnAH23MfUZ8OBMozG1Clrk+KD2IE5iDjM48meAA7dbnWBArmj2DQ/
	r6dO4bCM3LKZcHZWr5FR+TteFZc4jI+VrStviznTxIHVjkpKKMfCv7FygeYLa3LhcSCcMCutW72
	rjRCxqovwXhTNXSNGiGImVakVrcTsYhazzKMXMHS6L959waQn8VKRKWavQSGcSTAk4vyNbnSWLq
	kcbFT7sC6aeEy8T0s525OU6jRoLNOg8IdCYA7iS2iwYdPsQTS7H3vO+NjJDzTEaGdHzz6gk/blO
	Tnd6UhaLxKf9gOUve1WgK0vsocf1rCHjkFA9hDZ/7y9L6ZNQC9DZR2X7dBk3Znr7JsGUhw6dH5H
	zkDzCkv/guZe1QqFHRZRc+ryvRf+3KkzeyQaUA5Bf8+lRp8SlMYWKKsJUdN0n3lOq4SV9qwBf69
	efKimo5f03vJWNSi0G/1iamrc8l4cCS8oQPI6vS6NMNGcLbTpdM4nbCvSfZzQY1xtOON0OKLw=
X-Google-Smtp-Source: AGHT+IGlXuU7CV0HYerfRvfrCi3bMB4lFNt4UrO+yWjId/5UQGy4cSrVoKBT59z594zR51ZFdEKN+Q==
X-Received: by 2002:a05:6871:693:b0:3ec:7947:33ac with SMTP id 586e51a60fabf-3ecbbdc15c1mr2818580fac.16.1763831172068;
        Sat, 22 Nov 2025 09:06:12 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e782:93d8:7c2f:f9df? ([2600:8803:e7e4:500:e782:93d8:7c2f:f9df])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9c3449d0sm4179813fac.8.2025.11.22.09.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 09:06:10 -0800 (PST)
Message-ID: <4453f8a7-801b-4230-ab69-be06396f9075@baylibre.com>
Date: Sat, 22 Nov 2025 11:06:08 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
To: Daniel Lezcano <daniel.lezcano@linaro.org>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com, vkoul@kernel.org
References: <20251119223905.107065-1-daniel.lezcano@linaro.org>
 <1dcf3278-7552-4b52-91d2-e8e711f8b230@linaro.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1dcf3278-7552-4b52-91d2-e8e711f8b230@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/22/25 10:16 AM, Daniel Lezcano wrote:
> 
> Hi Johnathan,
> 
> I believe I took all comments into account.
> 
> Can this series be considered to be merged ?
> 
> Thanks
> 
>   -- Daniel
> 
FYI, things usually slow down a bit in the IIO subsystem between -rc6 and
the next -rc1. So it might take a bit longer than usual to have a look again.


