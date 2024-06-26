Return-Path: <linux-iio+bounces-6964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5835491852A
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BC51C23101
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8418A952;
	Wed, 26 Jun 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B1fxXaxW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7518A927
	for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414160; cv=none; b=lX91v3DLcF2Nwg89S8ct1VB5W2x/+5SRJHc4X2FegJni2TpE5BkZkIl7bNtTLEzxfj6U7NlT2LGBb21wCHL/U/MX5cFzmpiegX7aRak2tufqcDWYlsOplDIP0gf7DeHFsf9E43ZRIEvaK3AjNFwaH5IuWUNgILXSeWVyyTJc69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414160; c=relaxed/simple;
	bh=h8IFNBVQDGI7KKyF3Tw0fDvAoUcjsLjpYRPmW7TNN9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnLt6Dz21bPgH/k7N9N6X/UaJ3YbA1Gj8Dla/Qg8p8Sesh3vNmLy4mMaMIE8knbXw0DU43h/k7dTdwaVQDdHFQKoW3I0IKRyk/AhYDDaAZuKqU6J1tac4TkbQJNVkMGBDk3M7IQwUFU4BZVqCWFyxwrFyUgb/Q7Eckr1DH3sHw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B1fxXaxW; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d23db75f5cso3941588b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719414156; x=1720018956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSvci1uFTlUlVEIqm3+o9jrGE5hww4lYdCugjxScLxc=;
        b=B1fxXaxWsNb0Wm3dNRZDvCsAI5tW1FgCAvHtBODF/OnrApaPUHgC6B5CfSDyxnvNR/
         TgcZzPNuzZNWRPkB9AsTsD41wbgkpkx3eslL9al6dY6X9HwrYXuxVx5WC51Db3uRQpua
         E0ON3mmJZYXfTIfseK327oaSBFZCuhqeeCDBGF19cgYjo8g1lG/bU/1fXEFSCk9uR7yh
         Ri4iuA1Ftv6Y5gjhZ1AWEUnyjnhaFmBhBSHc2+KXNNs+vMbVUV++Rnt0+7LJDU/Wkb5n
         u2ZyTBBMddt1TMJ6P5/NzoXy7MJ6dDQaQlsVLaX6zZ7Z1K3/IazW4TRsGEJvzToD4Xgk
         cw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414156; x=1720018956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSvci1uFTlUlVEIqm3+o9jrGE5hww4lYdCugjxScLxc=;
        b=RrpdxCvYf9945pBegD4/RH8l9jroxj7mjlFcWHnvNjRbHtSrtnMdF3/CZNxK1BaM0s
         Via4Az3ygKbfmzcVnA2L8qL0bvcYygo9vDYOD7Czo0SHMl0o3Dt8OM+nuprR88JOF4Vs
         wmnW10ny4qPtWC5utaI2ohbl1OcTdBnejSLq0q1BWp9jGbvfXLz9sTUNLHEDWOoL6Ule
         xLbWDC9At4/QNEOrvFSIcRvpInppYbcVonW8bSnKG3+3T9t2fLMJbPe8qxq1dnIZcEWW
         FyiNfiqxPqQbk0mWqvC3vdbOm59s9luZq7k/cGogsqpCnbpo6vjnt0G0rjjDOBZk8f5l
         iWfA==
X-Gm-Message-State: AOJu0Yz9DTAd6BZopb+ybMgIx/jzpAgQz4SjrKL+SY5dpwrMZpHs7Nus
	70zWqsnweFr96R/Wh8ij9b0QNwweDargFSvNBxbctJjJ4OxED0mq+uv8MC2KVtHtpoRfBLFU2HH
	4
X-Google-Smtp-Source: AGHT+IHxDRzysWtM8SZgzoFa8C71vGpv995NrDG06zHPXgNzqIcFAMD/hzYACvDeMs1fyi3C45I6VA==
X-Received: by 2002:a05:6808:1990:b0:3d2:1769:90e5 with SMTP id 5614622812f47-3d545a8f105mr11819156b6e.57.1719414156345;
        Wed, 26 Jun 2024 08:02:36 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5344dddb4sm2344489b6e.5.2024.06.26.08.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:02:36 -0700 (PDT)
Message-ID: <2c7b0d59-c7ce-48a4-9c29-7e18bb039ecc@baylibre.com>
Date: Wed, 26 Jun 2024 10:02:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] spi: spi-gpio: Add support for MOSI idle state
 configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <92582952136a5f289086dd009354c73dee868837.1719351923.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <92582952136a5f289086dd009354c73dee868837.1719351923.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 4:54 PM, Marcelo Schmitt wrote:
> Implement MOSI idle low and MOSI idle high to better support peripherals
> that request specific MOSI behavior.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>



