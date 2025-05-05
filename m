Return-Path: <linux-iio+bounces-19115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BA6AA9817
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC2C7AC464
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B0253F2D;
	Mon,  5 May 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NEWP6uQd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99A26562A
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460598; cv=none; b=hx9CfTLCHPQPVFj189VqMMZ9od7gS2pEh7QNImkaElGIETPleJPGPBBjXWg7zjodI2GW4mfByqEI6APZ7CqAWTXIb6eJ40zQg6JJ+Ya60OR30E0KP+sZF8l+xzR0mOKPwZz9NqOMX+3NT/zKCEcCSdtRiT8ZaChbam8WkCt2HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460598; c=relaxed/simple;
	bh=o1w5GqbH2vUw1oosyRDQiFpEV2fgDlpribNcMFycmt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgdVQzRvLLkfOAvCCc4eXE3K+KmqvC4oecQJE2y8zUxTu8Mt57zshW2SzhvjqFtAj9f8nDaZUIRUsBSohkMXyREronrjvYyMEkMbMPUY+BuDlnok/2CZOz5vRGm6reI/gYssS7hal2cb7kJcRMqFMfO/IZRiMj2ZkOwVLxJMboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NEWP6uQd; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3feaedb4085so2707658b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746460595; x=1747065395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f52zqB4jhmTlTbA72onUhAeBKdChUe4/R3e2o3i5vGI=;
        b=NEWP6uQdikvVO37V9gm0yT99POE0NzCqLpmDQzHkuTQY67McdBVIcbInRbTKdqHXP4
         QX5/RM3//r5CtUMuUiNmzHOa7M9oMtC2NHhgCYRxe73FQFmlYTl93/EG6ssjZLMiSIsj
         jnZII0zbU63uAycfHfjnODTohypZcOEBGWwBsJubXcV+IlDLrUKcAIFwSEMnKq91RudC
         NGJdMLTuGUzjmWhR9o0bM7tMKJJr79dP8/ayyg7MMGOgwjwdoERCwqojp9Zx8vdXGH4c
         EpluXHilsf3zzIdPjLsyoDliwghUPv4SJoxCM3/x6/U344wHkz1mSMKbOPU/g4hbw7hb
         yaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746460595; x=1747065395;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f52zqB4jhmTlTbA72onUhAeBKdChUe4/R3e2o3i5vGI=;
        b=AcOl25p8MGTzVZd8shIZjen8IlhTGFYKO70CjflRYiigRVkpyMedbXTPQ+LYF2VGlv
         RYzvJnyPJPJW5iECQNw0oZNP0fbY4rOGTvf/dpR+tR6y3iyQn8xz5QEprmSa1j8XidrU
         LqJ3lbOhXlRcABWaaBU0jx06x2xZqOcRkZPjJlvoG0FFLvcPo5Gh43bvq3smWiXdG8lS
         vx72feOdKrDBmmsBmmpApPrrbbmv2w9UHTUhRYJnhYFQkn0ohi9XRwIuggJqNf0FZDkr
         xM4HGzhv+fK2eDxWg6ts2o2HvMTM214WDGKzlOnMiVoETDrH8NOTm0YEjEF0klJn8vzS
         +3JQ==
X-Gm-Message-State: AOJu0YzjPZ11774E6Z/ui9KDIsZhzzdvm6ANvINUVtEA2ryC+wyVZqI7
	8AXpFKw+5WdkWUUT4FOSQHIqj8V20jItzarewprjIVfhX5K6YNFQmOYAbkUX3Lk=
X-Gm-Gg: ASbGncv026WiaQr1/eP0Jgx4WTDj8eCYuHdsl4bqpnSVcK+PWlc/o2fHqHOQUqDYbqj
	qMShWhl6WoUPMNg6CKMvleOKabTj1ZNdG/8KzTErJHp0HC401Nbhu8ioknsmZtgi0xzNiSSV3gc
	vXXiUsUhH7CvThEJOKK+1Luqo2Xi/X1miW50+H2X/up/YBZ6QpzmNGraPGr1yjI8TpbObuPptin
	0jWE0kkMAPgjOjlOrMnFbqZL1SNoD076XzbCLDQEaNMfLPBmnp/s7gOYNBKtDn0MssdB/v8BIS0
	cN2FmCGn6a+i/6xsy40I+nfxHjR+ZmVZfYhe+asNxhfJl2QxKLh8ftiEnjESB+4Nm58o5svguxJ
	k4aC+tXFXLme6RCrorQob4LHefA==
X-Google-Smtp-Source: AGHT+IGalsB3+CjZqhUhKgX6fw5tFIDx90f4nB2VtXLZP1pPReoMIcFtM+ZlMr65WGrRjz1q0ovnQQ==
X-Received: by 2002:a05:6808:1829:b0:3f6:a1f8:ce3 with SMTP id 5614622812f47-40353659c80mr4690857b6e.14.1746460595375;
        Mon, 05 May 2025 08:56:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2151:6806:9b7:545d? ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dae726dsm1903338b6e.30.2025.05.05.08.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 08:56:33 -0700 (PDT)
Message-ID: <fce085a6-32df-41c2-b230-83c62ac6133d@baylibre.com>
Date: Mon, 5 May 2025 10:56:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] dt-bindings: trigger-source: add generic GPIO
 trigger source
To: Jonathan Cameron <jic23@kernel.org>,
 Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, andy@kernel.org,
 nuno.sa@analog.com, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com, linus.walleij@linaro.org,
 brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org, jonath4nns@gmail.com
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
 <f76579f8aa040125568c044c86761211a2e2f5ae.1745605382.git.Jonathan.Santos@analog.com>
 <20250505164401.64cd3da7@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250505164401.64cd3da7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/25 10:44 AM, Jonathan Cameron wrote:
> On Sun, 27 Apr 2025 21:12:02 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> 
>> Inspired by pwm-trigger, create a new binding for using a GPIO
>> line as a trigger source.
>>
>> Link: https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engine-offload-2-v8-3-e48a489be48c@baylibre.com/
> 
> David, given you did the pwm one, maybe give this a quick look.

LGTM.

Reviewed-by: David Lechner <dlechner@baylibre.com>

> 
> Maybe it's worth generalising to cover all trigger sources in MAINTAINERS?

Sure, I would be OK with that.

> 
> Thanks. Otherwise I obviously need a DT review before taking this and maybe the GPIO
> element suggests Linus W or Bartosz might be other good reviewers?

Linus W already replied in v5:

https://lore.kernel.org/linux-iio/cover.1744325346.git.Jonathan.Santos@analog.com/T/#mb263ff61984dae4a479632dbe33c94a66659fd42


