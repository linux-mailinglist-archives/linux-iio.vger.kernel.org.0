Return-Path: <linux-iio+bounces-12497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4C9D613E
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBB41F219A4
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379E71DF738;
	Fri, 22 Nov 2024 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MS+pMZ60"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DFB1DF98D
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288573; cv=none; b=A2P6IIAbJIu5SCgFFiR+6Nsv6zrpWhkOOEdUPKEnpC1Qc52TkoLvUwcuNbtIYO5RzUWlm0LJ2Lm7bAAmsSKe5wvmLP3QtpEqwrZUVQBOTPNyQeE+w6H8XxFgAwcNEou1ZbXcWMaBUfBnaR9k7BHz2ZRm95MXmTXOm4BNo1Lh2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288573; c=relaxed/simple;
	bh=5rrwq32kEK+fI/VP1Cfd/uHvFlAf1s6u5eFPfyluEOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SG+zM+2t3xigYmhIgnlWOJxM2AXYA7/D4TPQ8KiJjvH6pilb7AT6z4LctjfKQUftX1dM3Mox+Gcvs/UMXxI1jjQHSJ+nZ02jUeeuZdQz77XiQ/bXVyLRYidxRk8z+4QsDw8ii0zcCWmQ7uiql/Z8/5m8saJdNfcUSidtNMinnGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MS+pMZ60; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d41f721047so14780786d6.1
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 07:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732288570; x=1732893370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rrwq32kEK+fI/VP1Cfd/uHvFlAf1s6u5eFPfyluEOE=;
        b=MS+pMZ602PCykqd+3Rw1A1x995CzHE9EnTKnH4rsllnmx1Ra1T8fXckEeFOzvVoIQV
         S+B0tdTCsylxzgDnEQGnnYI5Wa0jHWUooPsfbV9CcVsFjQhzD5nslxXQ4nm25fA40EmJ
         mvGe3ORan/JnWouYXVwzNYkIpJgMdLGPMegvxXHwuoKw0xPyfGFYCrxUR1qhlWsRureo
         8NzHCWRS4tNn5UA+xew5RQF1mKexAHtKKgNVSG9iEjUWCUCgkZ8zGRFhXKXslT6oUzrt
         /RZloufl3KjEoVBnZ1KyFOdg24Fqodnim4gSWCHK6EsPoXGlh+5cMzuFwjxn4WgDJIkc
         9+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288570; x=1732893370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rrwq32kEK+fI/VP1Cfd/uHvFlAf1s6u5eFPfyluEOE=;
        b=cuCAEQJqXJIjDmvxkmWChJPUzJ4+/Xf4HTjW/WHte5ewJZyNJEiUbpeShSOY5Mqw7Y
         tH9GbrPAb95Kjs44CPvPm9umUI9FsTxuyzoiKpE/57OiXA1mxnaSdduVIYYpdDiFcuYh
         iwsqn0oSjqZIN9z4OVwR8/pfwlcossw002nmpvI+o6F7rssYcHhCBnN2jKljETnKccma
         LOS+n0miV5rrGU6RFWT+SlxGJw9I3jgZkSOxhLKozEE1R9gppHVRNgFw3y/DMfJQr9k5
         BVIlkNO/SnxeIKv1mEDyUDJA4LzhDkZlRrR1XfR6VlrPjBPxip49vLNUGMgmE20ngIzH
         C4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIULd7yybLcKe2U8FWirY1id8yAYAlLKUDNiRvilHrHQ0QW4wYe/4YfhWNcOOK+v5E0MVWoOtO2pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtibX5NJxbTBUzNlA8bQUZLlz5QWB1IwRHFP7BXRwuMjF4wBpo
	xaYfW7mSaFDOCc60yqhj0R1dpLKizBmmorfVCaMFagCK1PMRUgj+LA2AhkNk+qw=
X-Gm-Gg: ASbGnct6rHDR3aXBjGmMd6JpkyuUiiT6RPpEuC1CcsKkRGQgUtxvoCmadxiJJZIwzOC
	njDLNQBQpOfjw9N6xjDY9HB/kwhK8kxbuaDLLl/0nsLTvL7zfcKgCe+o0ZHqVTcpO9xkRojFbmy
	+cUEFlQt5voqiWk795AUIAzfS263B7nttFvcf1/pWKXPMfNFJdVdDG3xUGaeEBa4LlAUVJwmRhu
	dc+zE3uz5x82Y/53k8WF6rNDkBa2jZ3q2dJRz+iHNvmfnaZuY8ugfGHWZCZREN/DyjygOZ+TY8I
	fGUiwlqaNv3LWJlWQA==
X-Google-Smtp-Source: AGHT+IFYmzB6ahOA7oyO0hzpIlhfyGNp+j0P3QoJogYyXgM/7h0/rO+wsgEgfbueMejf8XFDMB/97A==
X-Received: by 2002:a05:6214:27c1:b0:6d4:586:6292 with SMTP id 6a1803df08f44-6d450feaf50mr39784616d6.26.1732288570113;
        Fri, 22 Nov 2024 07:16:10 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a97d26sm10793136d6.42.2024.11.22.07.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:16:09 -0800 (PST)
Message-ID: <ac642b48-89fb-4f93-bc4b-30ae01773b9e@baylibre.com>
Date: Fri, 22 Nov 2024 10:16:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] iio: adc: ad_sigma_delta: Handle CS assertion as
 intended in ad_sd_read_reg_raw()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-17-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241122113322.242875-17-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-11-22 06:33, Uwe Kleine-König wrote:
> When struct ad_sigma_delta::keep_cs_asserted was introduced only
> register writing was adapted to honor this new flag. Also respect it
> when reading a register.
>
> Fixes: df1d80aee963 ("iio: ad_sigma_delta: Properly handle SPI bus locking vs CS assertion")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>

