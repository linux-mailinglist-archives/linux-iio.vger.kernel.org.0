Return-Path: <linux-iio+bounces-10968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834AB9AC1F7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 10:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E5B283664
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D3315B551;
	Wed, 23 Oct 2024 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY+PNV53"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94015886D;
	Wed, 23 Oct 2024 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672888; cv=none; b=rbZubB8lZJMFHo25tKTHocDwkQ+juOWgkMif4tkkEREhbIRaklRy297LfgTTkzMYCzqW8Ro6ry5fhMEgIWANibHKUn//10R9ysIYwDU00XYSpMHowUM/MdMa6tWAwAz/urtRpwyLp1/gKkHctchFLPadMsi9ErZb4UJZGAeRD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672888; c=relaxed/simple;
	bh=RPQq0MD5YPhrZxpE3BiwohX7MWP4yuzeoVGWtKjQWgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IPtFQsqUpdOaRZzdgdsY+TxFn1GyhhWH+5laAqf7IIqxpelUsqnQWIkIKyoOi8dRpp7n+GYiNrHyk5x1WCsWVqoMpwfqqgP49iXltbbFs44TwxZrsw3CU28NAvsh32nLQxSPxJMong3noKtbCdUj4qEuU95mYbC2r8DyZJJ14j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY+PNV53; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99ebb390a5so110299066b.1;
        Wed, 23 Oct 2024 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729672885; x=1730277685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3m+jGvhTZvFu8vnBmFkPGAav8w0MskfOqv9WrwcR8M=;
        b=XY+PNV53RtaRbBP/pYTOn52l5bO84ImcHew+jdDEud1JJI9rN/ZiPrQZk7CbHFZuiR
         5Y/MykH7NpDSyg93px7FRm9FGI5jKH32sZwenmSs9SVslselK6dLrM0yTnQwUiQ9dgJq
         hPDIT1pMbhI6EZIglrj/vxGw1wqJoJkn622JPQaxdnd7gFVTQiCbKUKtNcBK1+bwHoNP
         R015It/0t52FaNPy/pXIpPwGd40LPXDnQsX5ScHS6u3YhxmZY/S+bQ3bCxskNYHLM6+p
         Ap2eJA5Dzj9g7DFzFVR4mWza3SqSeJ6w+MN5p/DqDii3F7Jj3Ds5QuHR82BSPyNoKvUO
         nBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672885; x=1730277685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3m+jGvhTZvFu8vnBmFkPGAav8w0MskfOqv9WrwcR8M=;
        b=OULVo1txwAJzfojpgroA4QXKO9s8CILhoaRpF8s6EGTz03yy0NsN52ivM6UErdRbXs
         cRA8hF61pVaTMQB49OOkHhoAhIBCffnGje2+2TRM2dqn+PcIH1hRcYXgshqjs/DS51p7
         X+Ff7H2E/KAmXTkv5tYXpfuZOp6kzugoCscrb27CmAXD+rYXIcJq94Ippm1XGZVTZzg6
         EQiDXeLLQ2u5KE2EJisWVhIgQ+TR0lnAKKS490g1f9MXpFGrYJfRmXd9NmcCWVcshLzg
         JOqtMdqPjAos7tZBY4fVgfy7nQ5j4VOg+hgc9nCi0WCvnZun1t2wsVm8YWhe504DY1S0
         fBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNFVPw7GXWwTecWvz4ddNFpPPbuTpsN5DtTThU6rOLtEibM+O7WDu303dsRAZ0EZ6jCJUZRQdQ5Ew9HrwX@vger.kernel.org, AJvYcCXmlVJJDNHbcbIaztAX7CcV0gOfVQZqA/LKEWbS/D71vgwg3Y06ntEyWm6pFrqLZ8r7k2jckp/qvgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLDw30qckrOOzrMXnePIoBD7vKgZHomsdGqBxDUVERXTj4gn1
	w4QtKjdNn74BcjvWsMBvADq4lBEzBEz60e/2yURX2mfJ4tO7Fodk
X-Google-Smtp-Source: AGHT+IGjgTscanjqaQvjgPoy+gTYwYNqELv6t37GRN6MY4QIpWWzsLfkOJAEvyPZlFmgIbO7dJZ5pQ==
X-Received: by 2002:a17:907:3f1d:b0:a9a:170d:67b2 with SMTP id a640c23a62f3a-a9abf32535cmr172378866b.29.1729672885119;
        Wed, 23 Oct 2024 01:41:25 -0700 (PDT)
Received: from [10.10.40.97] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d62efsm439658266b.44.2024.10.23.01.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 01:41:24 -0700 (PDT)
Message-ID: <ae939f90-c23f-483b-b4bc-70891d0de167@gmail.com>
Date: Wed, 23 Oct 2024 10:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Fix build error for ltc2664
To: Jinjie Ruan <ruanjinjie@huawei.com>, jic23@kernel.org, lars@metafoo.de,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 nuno.sa@analog.com, conor.dooley@microchip.com,
 michael.hennerich@analog.com, anshulusr@gmail.com, sunke@kylinos.cn,
 kimseer.paller@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20241023082309.1002917-1-ruanjinjie@huawei.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241023082309.1002917-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2024 10:23, Jinjie Ruan wrote:
> If REGMAP_SPI is n and LTC2664 is y, the following build error occurs:
> 
> 	riscv64-unknown-linux-gnu-ld: drivers/iio/dac/ltc2664.o: in function `ltc2664_probe':
> 	ltc2664.c:(.text+0x714): undefined reference to `__devm_regmap_init_spi'
> 
> Select REGMAP_SPI for LTC2664 to fix it.
> 
> Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 and LTC2672")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/iio/dac/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 45e337c6d256..ae6d04c758d1 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -381,6 +381,7 @@ config LTC2664
>  	tristate "Analog Devices LTC2664 and LTC2672 DAC SPI driver"
>  	depends on SPI
>  	select REGMAP
> +	select REGMAP_SPI

Should you not replace REGMAP with REGMAP_SPI instead?


>  	help
>  	  Say yes here to build support for Analog Devices
>  	  LTC2664 and LTC2672 converters (DAC).


Best regards,
Javier Carrasco

