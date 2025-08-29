Return-Path: <linux-iio+bounces-23398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2822B3C307
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 21:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E845A0C97
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174C24169F;
	Fri, 29 Aug 2025 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MvyacE+V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173DF1E1DF2
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495745; cv=none; b=Qs2TQMkZpQE7HczqOJXzsHPaIMxskHnGoX9B16K17l0WczfdjyjR6MPG5rD5b88AjL3RqDAnZ0CB6qupvwq28qUhyOOpPIikaAnuvlJfxziqAkqFvetD4SbeNoii9JOFu5fPAtacy8kUs5DO8QbVwShmbOKjby+mlzEdHzo10w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495745; c=relaxed/simple;
	bh=i+INH5PIUZ5fungsOczI6sZiAKm2LRX8A3qW19oUiZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aHRsChNP+9dRSLAtNrxeQ+gqeoubOHuwcrA0na2XBgJCvLH6ejG2xFd65ZyZL5/Btf723GrucF1u0u26QQAy58GyJKcYFdwlS1Gzi4itIUYYtYkoQNWc94hSasYSf8T1jO57JQ6e8r4XWs4olujOboxglFO0zkw9K8UFR9W3U7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MvyacE+V; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-315bb486e6dso691511fac.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756495742; x=1757100542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2+wT5He58Nk4ycI9gGI+sEh59JOmnfZJky17dXY3FY=;
        b=MvyacE+VbzR/rlHHOyYqbkPUt5nGlFnChMysLkH8a3YxpttS96PxUHel1Q8eLws6eb
         m5gRpkTRonUzJ0BCBdr8CQ7ad4+JEOdVx5IJfbjGvsoJTm+10RdjMJyescrNvn3l0Ng+
         8sdEEcZN9Cxl7vYqEYvyrLL0lQTR15jyOcvBVFeEUX9pmmPdIfXlHW1hKARff++srJup
         H9qtx22ULnHgY0Travd7brxt7zPWzfBduUdBlOUMXt9TVzt6ONHc3K+Jll8xI78xubWe
         9Q5FWA5Dq44mOZa1gUueyyARb0BYM62tjay++0scQ7GqdIoeoTlbMJELN5mY7e1x2d5F
         bGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756495742; x=1757100542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2+wT5He58Nk4ycI9gGI+sEh59JOmnfZJky17dXY3FY=;
        b=qKXHyiS0rllXDL6ACyN463Hlgc9MpDUbFb6ZLJ3cGdy7X8zaiKWm3nMvbcZ1+jrm3s
         JV+3f4AfyEbzk8b5aIsKXVktxWl4aH1fHbyg9pcwG17Pa03CZPifonZd8WrG7zT7c6v3
         Qhh76w0mJrAdLJc5zLUGv1w8KYmkgVka1ypDeiEpFtTR3fkhhGBZt5ZjT5k1Pbr4v0xK
         4DCod5460EBg06O0FWttYgUP2ZvXXd4R8w+eOVAck/gmh/AmIYOXOuC/XV+j2X4GM2Yp
         ZvrvR8wTpale2icmxQddqwc2OyKrVWM1jDdx/JTvP+jq2TB90o2aFwF9K5Cmo0/A3axJ
         s5Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUHN1F5MjHQOMvYc2HMrtpECfIQYRPEavvCXjUCd7nZL295xbXDu+i89HAE6rZ5B9ExC2DycT+vwao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5gqBErRiIRomLDaJuHYBlheMKxa8IXNLO74OCYMg9gM3rLZ3
	rHXfJ4MYtfvN5SsAUh5C+DWsYizqbUUjHeCZLUWrYy/pxeqleYIRqoXePNGOvWJHKq0=
X-Gm-Gg: ASbGncsUkyDk79xzwdAjYJGYMm+7bxovY9Gb9wSUPrtuVclfSOfOoP7AjHAmV8LyOaX
	tuk1SynymeAXY6NbXLuzX1l8XEBgx4teGYr9GLiT8nfJRnGzxg+IfZ5YlM7dx3kx9O9IuyVBS7p
	fUwRyVfseddQbvID6b9Fb2xcZXE4csp6KjYmL9r1zXQhdu6eA+cx+wS9hpAPOFbfkTm7GGzWCvC
	wjU0VCeRJHLH0Smoixx9cNyj6zEfO0d+1Asg0WvNVbS/MB7Zn4eP3ZgA0z5gUWoClQDmVzF/Dc5
	LhYx3KSDw51eQpupsiMjfT9zV7K4N1jd4qfRf0HwdojmgqHhBZEGn+Hse5J7ZhArx86n4BBG7cl
	rIGSLu7kJY6iBDfBQXXTst+JQg24qmzJ6PVZ8T3QqjHd+j0E1K2nVh/eet20sFAmFZm+RGZu69U
	esUW2gwOdG8Q==
X-Google-Smtp-Source: AGHT+IFUI0HBrruEpYPUGPVj0o1naQM5URQdPGR0MpXZecuoseh/XCOIleBc4ls6rYo0uNS6K9zvvA==
X-Received: by 2002:a05:6871:4:10b0:315:b558:1584 with SMTP id 586e51a60fabf-315b5582503mr1655470fac.21.1756495742127;
        Fri, 29 Aug 2025 12:29:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afe62235sm1585849fac.23.2025.08.29.12.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:29:01 -0700 (PDT)
Message-ID: <9971205b-6e92-46f8-978d-31b074305410@baylibre.com>
Date: Fri, 29 Aug 2025 14:29:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] dt-bindings: iio: adc: add ade9000
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
 <20250829115227.47712-4-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250829115227.47712-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 6:41 AM, Antoniu Miclaus wrote:
> Add devicetree bindings support for ade9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +  clock-names:
> +    items:
> +      - const: clkin
> +
https://lore.kernel.org/linux-iio/20250820205838.GA986565-robh@kernel.org/

Rob's comment about dropping clock-names was never addressed.


