Return-Path: <linux-iio+bounces-21687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A536EB0632D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1784E630B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E94023BCEE;
	Tue, 15 Jul 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s7pKic11"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB8221F34
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593988; cv=none; b=UDIHjoQ+zH7nFR8eVzlubqN2GdzDsyIeMyJYeoMjuW1rU/OA2IJzyVqJtFU4x5KiXj2+erbhWiARsQOmScGHsCBayWIwT04Rr3Grn5GghGyCbPLrqyrz0KEtX2U2y3gEjnoFeb4P/qqgP6nnXK+qXo53Bj5p8OpCuKIIFNye7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593988; c=relaxed/simple;
	bh=7aGKHc2Np+XbNUQMrhLQMB2XWOGfrK7O14TT49QD3Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxwIx770cz+yHbEkmoHQSlcUHB1YNBiuzRY4kX1sIiDOpFoZzB9QnVx0dLC9b5XEK3f4quLGgWcgxQeORTb+dCdebeyChhwLGqHYrPRq/urSRgb76lTamPlTYOwecTwJ+zWfUVgpE+Lj6YU6zgdlaxOIFKf2Tu0V2J84FS7MMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s7pKic11; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ef461b9daeso3582067fac.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752593984; x=1753198784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHMSZXGHjG3cnxxpv+F4hCDUwtj7rcH94p6C5/rKK8o=;
        b=s7pKic11iuU3lj78C/By1W/yWNOYe1h43UMdiI6gmyghpy/yaL9aQ+38fiNtTDlNr/
         xV4SduM1RCn7zRxzdxrHLBiFtenGXExA7ikWuKlLN6D+q7dClhV/YlsrW4OVu4VkbWO7
         TXM8sfQcJIpaLwV64O+bKGk6gEHYa8amC0foHdx/4SRgxg+v0XXn1rkOS3l7obkwdsdJ
         Qhs+bXyC7R4rsL0jhtv4rOT71CxmppXZGc+RnN0QPQmMaQZ1uEchSWyetImqGDaay3Da
         PKSTaCsgzJ8oG6Q4lQrR0iKmn7uXzXtv3duSKkXHmG429oUqk17l+GCPmzMAQ342CHNX
         76Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593984; x=1753198784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHMSZXGHjG3cnxxpv+F4hCDUwtj7rcH94p6C5/rKK8o=;
        b=p0avevBnuCi5R0S6dm0+tV7hw2xomYLIm9yMcYd2l4MY//lho2PY0jj+zKyqzndLyH
         t1VZL6vc6/PHz7/SqV//rC7zUCj7NSUV1tQoddI1QDDHaYE5uOeFe+CFXLWFhn1+LCR0
         AuW/wGdGVHRrnjRs10OdwUDlO3kCtFyFbrE0V5koj6PWmSBXXKQnDgGwjd8oQJzj5gR1
         z+iCrbxxmKMuLdmxNeRJCYkPPiilGIYDAm86QZwZCalFvRnPg3KC/KY3K7xWttaFX63P
         IJncyqPPMQCkmUiKbffJuaoKkyLlkr4tMyZaIIWgVF0inL/fgjXnhzu4y6TNl3VJeqja
         eycQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpGxZbkzmUb2+g0dsQGZ3VgnmLfQtT1tOps9+3DZyNNjVftpr3NM00ieL2B8mWS2hkDY/hRUlOPwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6IWMvD41Dtz6AgwDu0vBtNubgwHKwmpsJ6hwT5ISc2nV3apMj
	uw6iinC2yDdMOSKGfKcv5+FAwTbdzeS2i4nsyizoQ/jCyAdNWVgL2JP3M06WleiZgv4=
X-Gm-Gg: ASbGncuSYKIXL1F28007YzqBGYKtCDSAk0xxyIHp3xAtl8wNvdLPYhRMP5XT03MDehc
	Ns7RVGaj5hN2UanFRKAyVeoWbpR/q00cnKZ38rYlRHWpVVROXtDHJMq/R++vsrCAPESpRvuqnuz
	2QO6g02LjpN4rJzC4vxpXRmxCrhrGRN5W+8t+VR4JVSH1zQgiUElLMCps/2h1WqpNATDglY2j9O
	XBS9ykFNaPu3Mf/mFSy7olzBgLqTT0BYmLTM8TxRGv3DCQreqD11AqNiinCVzUEJOnDtUvtbPoH
	Lslmae0g+UfTyHVv6uNElwiFXcDhvPfLkP6bCv5RIB31Jr5zHkX6Fo1utk/pmzyxMGiLCsLJlw+
	BkJKRzofjUUJIgw9LKvHwkKnSZtjFVHXo4iqi39foErjahT9T36Bw9YFjxHpG3nPewzLjaGB77F
	U=
X-Google-Smtp-Source: AGHT+IGCXpyi7JRvj87b8OJVoULAjXVkSVf5nyx+0RKOo3uFYj9IpKPJVceIqBiIv+MPARbM4Dea2Q==
X-Received: by 2002:a05:6870:9112:b0:2d5:2955:aa5c with SMTP id 586e51a60fabf-2ff2b11e58emr10650765fac.0.1752593984382;
        Tue, 15 Jul 2025 08:39:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1e73:344d:50e5:ce0b? ([2600:8803:e7e4:1d00:1e73:344d:50e5:ce0b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff11680db6sm2676553fac.25.2025.07.15.08.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:39:43 -0700 (PDT)
Message-ID: <fff304f3-1278-41f3-87e4-70036aac21d8@baylibre.com>
Date: Tue, 15 Jul 2025 10:39:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: select
 CONFIG_IIO_BUFFER_DMAENGINE
To: Arnd Bergmann <arnd@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250715064053.3484105-1-arnd@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250715064053.3484105-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 1:40 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added support for SPI offloading causes a link error
> when the dmaengine buffer helpers are unavailable:
> 
> arm-linux-gnueabi-ld: drivers/iio/adc/ad_sigma_delta.o: in function `devm_ad_sd_setup_buffer_and_trigger':
> ad_sigma_delta.c:(.text+0x6b8): undefined reference to `devm_iio_dmaengine_buffer_setup_with_handle'
> 
> Fixes: 219da3ea842a ("iio: adc: ad_sigma_delta: add SPI offload support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d43edc7b0c0f..e2649739a2da 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -23,6 +23,7 @@ config AD_SIGMA_DELTA
>  	tristate
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select IIO_BUFFER_DMAENGINE
>  
>  config AD4000
>  	tristate "Analog Devices AD4000 ADC Driver"

Thanks, but I think [1] is a more complete fix.

[1]: https://lore.kernel.org/linux-iio/20250714-iio-ad_sigma_delta-fix-kconfig-selects-v1-1-32e0d6da0423@kernel.org/

