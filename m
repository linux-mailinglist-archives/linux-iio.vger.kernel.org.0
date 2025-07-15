Return-Path: <linux-iio+bounces-21688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBF1B06330
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 17:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E67565CE7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4F92309B3;
	Tue, 15 Jul 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gjg2LBOX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726B1EA7D2
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594049; cv=none; b=R1msaq5wYF+/ZRWm5uMYrg3YTOmZlMMUL5u73GKm2WLQQuGbnDudtFOEICCA5wYtEVV7+5yGId4zhF8EFf5medHyOnLAt6iBCeIfS2hIQyte/CFASLaLenO4q/rz1DbL9R5lo4GiS+Gb5N+ukFazl9e0+XYfmwIQrT77rUUzLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594049; c=relaxed/simple;
	bh=KZXOlBZn/rmUm1Q4aIgSZSGz9T7kc7vaJG2a74RKDmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9EhaFWmPjYAjKHptJ7sVvTjOuyGExIjAzxlrJpdEzD2rb0G0pIpjBACwfnMc4bqevMxmDSTebPFqC2WVBOOOVz8H1bWxxA82fNxuH116U3Eswl0Mnz1bf5O0cEbtg3UKn5CrJkZN1M5bXHYopXIhd0TPk3eP9MpkGC4sLNdSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gjg2LBOX; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60be827f2b7so1480eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752594046; x=1753198846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvoEjUb/iWQIWBM9X6EO9p+HH0rv8UIyY+iGcZ9kt2g=;
        b=Gjg2LBOXDvYHYLuI4ei0Y7pHoaK34UtmcLWbz+s6EnPLA1HBD7iCz8eBFO41NOVYFG
         n46QP5FdKrxojxk1Dt4fexaZ4PZOx2zZEyGfi6e1u6RkPhgKDCUDh024hQnAjH568yCM
         FqEG+gziZOrF7vBfas9lPYELBCy6fCtBAJbL/KflU6XfOHIWRED6/1utedCfvtv869hC
         aaZambSEmCa7Ks18vSgQoV0PAPSZlWYm9tDXokjaakbZKWhB/LFeFaojyUrc7j0i2HEM
         mQbw8HJ/bQOL1664Cuia+f9q144gnE5OD5FREE53AOb/By/37uRoiIo7kV3wGIHfo+0s
         ndnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594046; x=1753198846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvoEjUb/iWQIWBM9X6EO9p+HH0rv8UIyY+iGcZ9kt2g=;
        b=XJSqNDhUwMMvH/54SnON26zoc1LA2s71zdOZaGbtD9zEFrw/eNbezs0ncHbaRfdhuO
         geXHikZxo0k/dL9GGsmOs+XMe88WTOEp0BfYaPK8pB7azlr6ttZUH2zYiGZy9/E5rbTj
         vBQLAFbMHv3QHqzVWnjN+26cI40sY3gOeJCOobXugMwgeKosmni6M98NVHva/TolbmSe
         CtF0J70DkswdBREubqkEWCVijAOpoLOCpu1sesLX0Ub+luoc/V+60lqRbf3VTg3e390k
         CXjpzP2QQhiF6YzOEJ4FYfB4I4oABLRi/RXNvVFJF8IRwZR/NnX0n4331L8wMnDF7tFP
         cZrw==
X-Forwarded-Encrypted: i=1; AJvYcCU7mb6YaY0QjYlq80Oy+meSYHPKWynchpV8upNPI7H/eBuxodvGbulAcAgpy8uz94NEupeEappfYp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAsHK2jO6YPedPmOer/l8YP6nw+Uue7bpAw2KIFaN00MEsE9v
	8QT5fwyekwcOjx0skC+KkTsjJBFtlwew4xVX4A3uASKo3ABxathP9a3xU6JYgLvKqug=
X-Gm-Gg: ASbGnctEfD2I5u6BQLx7fb+migl/76Cnfe4Oq4ILqThq04qB9jNvzn+GRg9y5NOEqCY
	SFeS+Xlk0cu3dHGaQfThD7T2+9wI9j7ByXYwal9ggcIiqdtD3m3NS/FdD3BgEQnuruF5PoYdzZj
	ujmXCNwdrcbcGuO1tHK483EGWr/wcECCK1lZp7+rlpkNpddM7M4Xr3S6KR9pU1lfXFv9s9R1MFx
	H+DaGGefWd6pGmHY4wqw+xGTLfk/xbaPMkmaMzx48z5nFm/NCnXvXKPM2egUZ7hoXALSSCmOcei
	G/nW0JFEFfYUwqf+AtEpra9Wcj0Z+ETYcLLSbSK5frr1LqqqufKIKwBiEF7r1LZyNsLlud1XRA0
	PqZoCSZHA9C8N1cKYpbD1hBYcIcZnyY+Vc17fRwuVfy1fHJfKdQl8nQ8TSUMZ7Ah7VFmMr2xiN0
	Y=
X-Google-Smtp-Source: AGHT+IFKnhFNmq0KlawFl9i9Ft4HVwBOdlLXRHqle59J+ZLR6M7llrLVhScKC1ZYnIt69xEPFqu6Tg==
X-Received: by 2002:a05:6871:3143:b0:2eb:a01a:11b1 with SMTP id 586e51a60fabf-2ff8fb90c48mr3711951fac.9.1752594046499;
        Tue, 15 Jul 2025 08:40:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1e73:344d:50e5:ce0b? ([2600:8803:e7e4:1d00:1e73:344d:50e5:ce0b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff11236266sm2668611fac.11.2025.07.15.08.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:40:46 -0700 (PDT)
Message-ID: <764c464e-a45e-4d19-b9d4-a238f1ca84c0@baylibre.com>
Date: Tue, 15 Jul 2025 10:40:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: Select IIO_BUFFER_DMAENGINE and
 SPI_OFFLOAD
To: Nathan Chancellor <nathan@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250714-iio-ad_sigma_delta-fix-kconfig-selects-v1-1-32e0d6da0423@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250714-iio-ad_sigma_delta-fix-kconfig-selects-v1-1-32e0d6da0423@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 1:30 PM, Nathan Chancellor wrote:
> CONFIG_AD_SIGMA_DELTA uses several symbols that it does not explicitly
> select. If no other enabled driver selects them, the build fails with
> either a linker failure if the driver is built in or a modpost failure
> if the driver is a module.
> 
>   ld.lld: error: undefined symbol: devm_spi_offload_rx_stream_request_dma_chan
>   ld.lld: error: undefined symbol: devm_iio_dmaengine_buffer_setup_with_handle
>   ld.lld: error: undefined symbol: devm_spi_offload_trigger_get
>   ld.lld: error: undefined symbol: devm_spi_offload_get
>   ld.lld: error: undefined symbol: spi_offload_trigger_enable
>   ld.lld: error: undefined symbol: spi_offload_trigger_disable
> 
> Select the necessary Kconfig symbols to include these functions in the
> build to clear up the errors.
> 
> Fixes: 219da3ea842a ("iio: adc: ad_sigma_delta: add SPI offload support")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Thanks for the fix.

Reviewed-by: David Lechner <dlechner@baylibre.com>


