Return-Path: <linux-iio+bounces-26389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4319C7D42B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 17:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FC1334F772
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBF5288C2B;
	Sat, 22 Nov 2025 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bi5xUGfn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276710F1
	for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830631; cv=none; b=QkLLVCMLbhOK2dUyKHksL2IEm0IRHTkmacvm/Kau3FBee/uLdsSV8DaNN+X/0CYHCpDJQJzvn218AhrxFMraHhx6Ltbn09sCfwjF82mnssbiO3cLT9+XZdwOFdNNirCbTBJdjEcvHt2BwWHn2eoaFucmmBhq0kjeILb8iw/BaUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830631; c=relaxed/simple;
	bh=KU49GyuiicIEUZngQEr/LeAOc8CyvB2hOuUp4uYqQPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=txsvMUI3NCNRFnyoKtM+S27wKYm036WCtZdjYBJKwFMQqO3dJO4ivpPia/CmxW2dLetYiv+DLWJqxFhRcT03nVt86Ic/59ytKBTfV5xnJkXHQlecUA6K5r3bWW3RSrFbK1ad7Y6Z0dylK2QMgpYF790AHHVHS/YP6l6W45QCJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bi5xUGfn; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso2013430fac.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 08:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763830627; x=1764435427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i48yrAPZ8Xqe0qNk6R5ngVE9StSi81SOfH4muZOsIJM=;
        b=bi5xUGfnwMcu8/+lN0EPTo93R398aoY1NNXbBzSkkfAZ3aq8uyUq91AIBbF49l0nqi
         vGw4AKAdCDLn9Keoj8fn4QE7qaWA5pj8DJkjSRQsYveu1OeUg22x+L2QCdxwWjIR1iwD
         lRPwJL1mZiXMNRgci2qsjqfp4lyz2JMWwOpm4rLsmmNeDPe9dXuLOsVKm4isscSMEI38
         X9JH4EsxK/KPKcjDWFaoUmvRPIY37V3kro6SWljXRDVXeTN0sLyOfDbTTFnfmcHQxtb8
         RGsxZOqJ09KZfojbIW8Gz5wxAPP6kyRJyOGRbIT/29n1x6XFPQA1uTGyRCQRVa34cWnw
         zG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763830627; x=1764435427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i48yrAPZ8Xqe0qNk6R5ngVE9StSi81SOfH4muZOsIJM=;
        b=mHjtwLkJCwBVBAJIbdqzk9Yv7dx7ZpVm2qyO83xW+CMmlo+pP270yi92Xxi4B4domw
         zbYQiuAtnL4FwCOPB+IChTo9qNVud0P0cMwzt+8tXQ2uRZ8zqeGcLOoFx1d7UtXSWrxb
         DeSSRn84M78TnLkGJGclfY5OOkk2kqo3ernYYPTAOxZ9NA9BbG35IG64bV5vAY35hQC3
         vb0/ZpTDnCc0cnZUf3rpwAIonOYfyWB04CZnx0wQNGUL2eVjxOulH8iDCPXd+xqQtt5c
         aUYGkcX1q150wi1cCQIG5rajuRzmxmR1Ynbfn4Mus+DteJWX3prFfjSUnPpVT0yJj0Lo
         cADQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYL1VaXecMN2mptHMkocXVI9R0uEJeQzzJuCNlASxHpt2m5ZE1iAp/VJ7VImd0IoeTH65T3uE3IX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytwcq9gjys26eFFHYwQqmG9NgyXt++tcIb90cz+XTCdm9hLtG2
	lUiOq6kUPBUIB5gynEb2zeXd/ylfL5Vs1iQN3+WR/J0P0eYyA0CubvZ8R8fk9wQn/wg=
X-Gm-Gg: ASbGncujXZ5jsKwqVRcox2ZyAMvb0BldHAqhp23GkeKPr1aT8H8zvBPW+cQb/iTvIPk
	qCm32bDpQiC9CPJ5tQBfdUJqCvx2UQMPrDIfG/E6HDSXlAFTYWf5NnICKUgzAxC1ssqD82w7lxD
	eyO/rtLr/pFM5W5x5h6TJBBUsN9KMVRDASXGFuqmwODqL91CvurGB6TOi3gnRrgzFTCHu+HMyy7
	V/50lC/iIm+VaKK2zN1t2C9V1bQpBi2QX6/f2ylEm6xdZBm7Z0o8bP1tw2lgkxxcVvmcecyedAp
	CMzq/4lC0OtiAsUt+DoOWmEZBpfxiDh+CwMFjhAXqYnCSk4wgqFYdnH9fCWW15E4L/9WQ4pr3kf
	ziJ9UkV6ZZ47eu+3BE2OOEPYKdxfeAYjCM/WuoReqqI20SylUaiQ6OutOha06XHdK8f/LdwFwmN
	vTdQF4MP1sBzdkVVKgGNecOGq7HLv3+SRmBmffjRyOurH03lzeHKS3nNb8fO0BL22dy+mlbiE=
X-Google-Smtp-Source: AGHT+IGQVghKnkpbLYaT3scrqN+Wey48lVkwLs2TAkvO6IKygoP39K4MsYAJ17pvkp/XW+9haZPUaw==
X-Received: by 2002:a05:6808:22a6:b0:450:bab2:4ae9 with SMTP id 5614622812f47-45112cde5f9mr2394898b6e.36.1763830627185;
        Sat, 22 Nov 2025 08:57:07 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e782:93d8:7c2f:f9df? ([2600:8803:e7e4:500:e782:93d8:7c2f:f9df])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450fffbb78fsm2522270b6e.15.2025.11.22.08.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 08:57:05 -0800 (PST)
Message-ID: <37d15b55-4483-428f-9950-46f1b0ab2a56@baylibre.com>
Date: Sat, 22 Nov 2025 10:57:05 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 0/2] iio: frequency: adf4377: add clock provider
 support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251121095933.19032-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251121095933.19032-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/25 3:59 AM, Antoniu Miclaus wrote:
> This series adds clock provider functionality to the ADF4377 frequency
> synthesizer driver to address user requests for controlling output
> frequencies from userspace.
> 
> While implemented as an IIO driver, the ADF4377 is commonly used as a
> clock source. This patch series enables it to function as either:
> - A traditional IIO device (when #clock-cells is not specified)
> - A clock provider (when #clock-cells is present in device tree)
> 
> The implementation provides standard clock framework integration with
> rate control, enable/disable support, and maintains backward
> compatibility with existing IIO configurations.
> 
> Antoniu Miclaus (2):
>   dt-bindings: iio: frequency: adf4377: add clk provider
>   iio: frequency: adf4377: add clk provider support
> 
>  .../bindings/iio/frequency/adi,adf4377.yaml   |   8 ++
>  drivers/iio/frequency/adf4377.c               | 119 +++++++++++++++++-
>  2 files changed, 125 insertions(+), 2 deletions(-)
> 

When doing a RESEND, please add a note that says why.

Also, you still didn't include the clock mailing list or maintainers,
so I don't expect this to progress since the last time.



