Return-Path: <linux-iio+bounces-19473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386FAB3BD5
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110FC189F2D6
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C84239E84;
	Mon, 12 May 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ox1TmMNK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA32309B3
	for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063160; cv=none; b=aqX1fU1tfBa7qh/CYtJXAeiFLYMYdNMXaljT0CkiTfRmEw9cJUbB2w9wspji5KTDqQGAl0e/lPV0G7hKckY9o6NcTUQVV3zj57dbtQM2u0KifLLEtRb3NfND4ETRwycGO25C70B/jXCJ77i/U40OR/SyVfti6nBdtx4OfoyLWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063160; c=relaxed/simple;
	bh=YLRhKQPiXdebeEoWu36rYII0+EGFuA/AZrvLs65tpPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIt8gOZSqjIQp36U1HdMbZ9d9tIRsZsHrJH4SWfREah46j98gaAex/BJ4G+ipV1kCKHWSYqBsUOUb9JRpBccYmBWdbmAvWAfyr42jSTIu1C5s+cNNjAzdr6hOdFf49bKc/CYJoWsgAa2pG9QpTv8VdLFnsbOx1Oks5Hi5kLsw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ox1TmMNK; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-404a5f4cdedso254674b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747063157; x=1747667957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uB97RORFeCN+m++iQb4oHIgwP6lqwFalZZAX+MQgG3w=;
        b=ox1TmMNKgrKcBcX3tpbmId1cWVUXHh8yZUEIFLXQhYBgniJIgCV6w++of692fHNA5R
         2dE4jD+YbstQn/sBNZ80boqZ96gZG02al23FqNwgVnoYIBSKOGA6uAo207P+dvL0KFiQ
         AYiY+LN21yNxw0nLGBQ67My5fPwnlhRsHl914YN9/VCz867SWBhc20exn5WuP/8WtFuQ
         uE6+kqTtqJU6pF5lo04l7U/d7Wy7RmO9T2SjLaATvYb9WHD8iBCyCmlyJOKQhv3S1haS
         1Oql08n8BuafKsjFe0gqC5eKNg+UJkUvM/y8bwDOF/iBN/1NtZU78eEFKuX2nOUNH5X+
         cstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747063157; x=1747667957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uB97RORFeCN+m++iQb4oHIgwP6lqwFalZZAX+MQgG3w=;
        b=g6LvjFeD/7Nl8fGOp9YChhZGdWNDCQcsdiPk9E9ETvMHmQaiBMkmC9snU5AadaTESW
         gUwfZ5ultd9z2iOJ406p5hZhT6Mvw+3lD3/ItDCGklI4xAJdT6f11reFn7K+LwwyuuV0
         iNm+5n6mypeSdZyvBhQZb020lbYQStcCT4ajjB3zXu6YZyrT6qHO7t+lvk01iTdifTqQ
         hrjevPNkzUsgfz8wcWCI90gJ/1jjJBDgY/1K12sWb7INhIlPmdT2CcfzaOgzLG7CEkY9
         mYsxk1752FfFH+TeUi9aEVafYQHB9skLBn9bRlnzUix1erHS1sWHnRJvxqYn7Fox53xS
         rqpg==
X-Forwarded-Encrypted: i=1; AJvYcCUwJ7gcUHRw/wjUUno6KjUudDUSPku05gIgOYnIBTT7o2dLNjLhFX70QwpzcEbzU797A3j6Wp3f9nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ70W+spxubvDdapBwi4tQbetq2YyyI/pWtiI3YlMqYnL2E1uC
	BkfWCOlAE/jFkeNS1cLYMz5Nt/W4G9bHI6AevztFTxtAjXZC29CMJh8srWy/bgQ=
X-Gm-Gg: ASbGncvNyceORO0TQG6E26oqtE/8qm4YKFTvmKor1o0YEEwEbE+aHaB+FUKfaPZi29T
	4zIZuKlawHVcjKUHqxt/aSmf6XvAqpWBC+hqkvwRt04SLQ9g0eGSlFxFLCyErHuuZ5IsU49NmWi
	vyfsw1mnURK436e9kj107Oq27PYF727ZC4Krh8SeZqTylokZPFFlTY8mcMS3fNDt3rB2nEsrPqq
	wIVmsOiMyW5Gg1KzQDNQRYvQGB2VtiFHlOUfuDkLcNVL9lRf6ZN6mZw8yP9Fj6W1gT/pc/GCeww
	Z4enFjmeZzJs103rwhMjFAYZs9sk6YWvlRg7t6uFStIiADa+mRr3jlx/yT9mNTtcArDhGaBL0s/
	iVoyIPTtkqKbSp07iEaLSGCPsXfj4
X-Google-Smtp-Source: AGHT+IF4wUVmJBZ3K8txZjwLLOWfdyKyYz1MbDWVE24RIYHa/SNfHkpPunaTfB6E0UsECakCsaE/HA==
X-Received: by 2002:a05:6808:1409:b0:3f6:ab0d:8dc0 with SMTP id 5614622812f47-403800d6897mr7978911b6e.24.1747063156758;
        Mon, 12 May 2025 08:19:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4038038920asm1571039b6e.34.2025.05.12.08.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:19:16 -0700 (PDT)
Message-ID: <945f9653-f5b2-479c-92c5-396f0d0e8b26@baylibre.com>
Date: Mon, 12 May 2025 10:19:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] clk: clk-axi-clkgen: fix coding style issues
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
 <20250512-dev-axi-clkgen-limits-v5-7-a86b9a368e05@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-7-a86b9a368e05@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/25 9:46 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> This is just cosmetics and so no functional changes intended.
> 
> While at it, sort header in alphabetical order.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c | 85 ++++++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 40ca03204010a15078f90935effbe58c4c3a00bf..a268d5ccf5798dd20cc1328369c2c9c45b37282a 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -6,18 +6,18 @@
>   *  Author: Lars-Peter Clausen <lars@metafoo.de>
>   */
>  
> +#include <linux/adi-axi-common.h>

Could have just added this one here in the first place. :-)

>  #include <linux/bits.h>
> -#include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> -#include <linux/slab.h>
> +#include <linux/err.h>
>  #include <linux/io.h>
> -#include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/err.h>
> -
> -#include <linux/adi-axi-common.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
>  

