Return-Path: <linux-iio+bounces-11363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268F9B1A26
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 19:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B691F21E38
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B308D186287;
	Sat, 26 Oct 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijc6JI4z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3623A6;
	Sat, 26 Oct 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729964909; cv=none; b=ob8c3UvvD9enMBuB98GcYUuNZxpAfRn1EFFBIc+QGJD/F/lXaANDkzpIIY5JI5nL/+b59nDKp38+LQ1pdrWKQFHW5yyVGTBKdHG8ohKkR2yx3D7hLpOojwUMl97j+WeDoRGgRr78NgRBlks9VbU1m5yVtPtxQi/APIH2spsBK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729964909; c=relaxed/simple;
	bh=o9oZRErK9cr6PRplzWQmLO2V+yn8kM55lzCnsD5Fk0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTu99J/CgILcy0I34Pir4TnA/mGuZgELpcgMArIFofdGCWfJ33iqdcIzddbGYMTVDDMZ4pJcA3P4S0A/L8Zv/u0432ai82XmQSwB/s/Kif5tnimmOwFtDm7s00eue7aKKDuDSUok0HvzNrYqUSuPOdNZh5UVrL+eZaz2+oq+dVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijc6JI4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383C6C4CEC6;
	Sat, 26 Oct 2024 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729964908;
	bh=o9oZRErK9cr6PRplzWQmLO2V+yn8kM55lzCnsD5Fk0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ijc6JI4zkGVa43MOp9BBdSUvVfdlX4ZdOZZopH9vRslfri8ob6cuIzHv+5L0FY7fh
	 XuR41e24VT7Y+AZYN6J9va7Pq8Tc0IaeaPvRh2HxhzQcPIxr0Ae8a56RZc3h/GZLtq
	 Gwl4WEoW94Z/b2MBIj8BesS5dqslmfw3R4Vqgf+0zBgec48hi8S5d3tDTrtmJfs8vq
	 gI9OFQwwPRBluIeax93DkHAQw6XwCgEeIn8fIMLoqXcoiNSLbyaUzkmo/vNJATi8U0
	 uwL+ggHchdvxWEzm5hMmIt1z+UPMxpTXa3Fm4N/J1o6ZWxYS7sPb7zKq29LSgk9zSq
	 UzLFQN68osAtw==
Date: Sat, 26 Oct 2024 18:47:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>, dlechner@baylibre.com
Subject: Re: [PATCH v8 6/8] iio: dac: ad3552r: extract common code (no
 changes in behavior intended)
Message-ID: <20241026184754.009ea6f7@jic23-huawei>
In-Reply-To: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-6-74ca7dd60567@baylibre.com>
References: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
	<20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-6-74ca7dd60567@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 11:49:39 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Extracting common code, to share common code to be used later
> by the AXI driver version (ad3552r-axi.c).
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Hi Angelo,

A few trivial things but one bigger one that actually only becomes a problem
in the next patch so I'll comment on that.

> +
> +MODULE_DESCRIPTION("ad3552r common functions");
Ah. This rang alarm bells.  I'll comment in next patch but you can't link
the same file twice.


> +MODULE_LICENSE("GPL");


> @@ -1072,3 +727,4 @@ module_spi_driver(ad3552r_driver);
>  MODULE_AUTHOR("Mihail Chindris <mihail.chindris@analog.com>");
>  MODULE_DESCRIPTION("Analog Device AD3552R DAC");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_AD3552R);
> diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
> new file mode 100644
> index 000000000000..22bd9ad27c65
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r.h
> @@ -0,0 +1,226 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * AD3552R Digital <-> Analog converters common header
> + *
> + * Copyright 2021-2024 Analog Devices Inc.
> + * Author: Angelo Dureghello <adureghello@baylibre.com>
> + */
> +
> +#ifndef __DRIVERS_IIO_DAC_AD3552R_H__
> +#define __DRIVERS_IIO_DAC_AD3552R_H__
> +
> +/* Register addresses */
> +/* Primary address space */

> +#define   AD3552R_MASK_MULTI_IO_MODE			GENMASK(7, 6)
> +#define   AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE		BIT(2)
> +#define AD3552R_REG_ADDR_INTERFACE_CONFIG_C		0x10
> +#define   AD3552R_MASK_CRC_ENABLE			(GENMASK(7, 6) |\
> +							 GENMASK(1, 0))
If for whatever reason we go around again, (otherwise I might tweak anyway)
#define   AD3552R_MASK_CRC_ENABLE	\
		(GENMASK(7, 6) | GENMASK(1, 0))


> +#define   AD3552R_MASK_CH_OUTPUT_RANGE			GENMASK(7, 0)
> +#define   AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch)		((ch) ? \
> +							 GENMASK(7, 4) : \
> +							 GENMASK(3, 0))
I may tweak this whilst applying to be something like

#define   AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch)	\
		((ch) ? GENMASK(7, 4) : GENMASK(3, 0))


> +/* Useful defines */
Made me laugh.  I hope we don't ever have a comment that says "Useless defines" :)

> +#define AD3552R_MAX_CH					2
> +#define AD3552R_MASK_CH(ch)				BIT(ch)
> +#define AD3552R_MASK_ALL_CH				GENMASK(1, 0)
> +#define AD3552R_MAX_REG_SIZE				3
> +#define AD3552R_READ_BIT				BIT(7)
> +#define AD3552R_ADDR_MASK				GENMASK(6, 0)
> +#define AD3552R_MASK_DAC_12B				GENMASK(15, 4)
> +#define AD3552R_DEFAULT_CONFIG_B_VALUE			0x8
> +#define AD3552R_SCRATCH_PAD_TEST_VAL1			0x34
> +#define AD3552R_SCRATCH_PAD_TEST_VAL2			0xB2
> +#define AD3552R_GAIN_SCALE				1000
> +#define AD3552R_LDAC_PULSE_US				100

