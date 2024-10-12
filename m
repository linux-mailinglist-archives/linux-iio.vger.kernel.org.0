Return-Path: <linux-iio+bounces-10512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91999B54C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCA5283711
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BD1189905;
	Sat, 12 Oct 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKoY0pfq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0FD1E481;
	Sat, 12 Oct 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742059; cv=none; b=YXDCUKRx4hrx2NkT7JVcrMmuh8DMBJG8YcZasoc+vx1Fh3MJAgDOoHfJa21aMxm+mUgtxtEMaYxlUCF+TZh/pPGh5HflCGLuTb0+kREG4LNsz0zCb+7Vlj3zSGqig8uInWQqql+988orfiAjQh3FrLDGqt61Ry/SrlOyIvO+4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742059; c=relaxed/simple;
	bh=ltuFTzzWTb1qew2dBIqX+X7BaJwPp5wJl+AbxE9dT/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3A69elwkAdLm9+wVj250XOxwLDxO1lXgVigjd3ro96gAS5ahCrPhtInCW3j3pbFM4oGNaNm4/TnjP9POfFJFDvyDeUei8g9TsrJP2oUnm4/o8dQK8MaV1WOGumla9Cg/pu//fvWyUh3roiIEZfV9a5QvVhnmn7TSJ6TYsgt2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKoY0pfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5919EC4CEC6;
	Sat, 12 Oct 2024 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742058;
	bh=ltuFTzzWTb1qew2dBIqX+X7BaJwPp5wJl+AbxE9dT/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hKoY0pfqXnps6ba9Wm5oem4oS6YfeH7THxFHBWkaacZ845cNb9O8JQYKDK+3QUZCp
	 Sx6KyE5Fejq1fWPsmf/7h7oy31KAH/8ZRoALiaxzoLo0PoNm9y8FJDMRyXy3NPxuO+
	 sg8z84VqEbDRKBsjPQA0ql0KSaVodPVjbWBMiutIQPE2IAT32TreIiffqV4LDtpzEo
	 DdsgU7GpApY0eSJYK0gl7dqoseOYYwTRB53s0Vo2iMh3kQdkUcQPdn4MedStcWPONf
	 t66+wOTJ6D4Bq9RKZC7vueuJt/p5Npmo/uA3Y0o/FTwiPpvdCfgvR3FFFLx0fcFZAS
	 BU4sisSp2fwwg==
Date: Sat, 12 Oct 2024 15:07:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dletchner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 09/10] iio: dac: ad3552r: add high-speed platform
 driver
Message-ID: <20241012150709.1278066c@jic23-huawei>
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-9-3d410944a63d@baylibre.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
	<20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-9-3d410944a63d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Oct 2024 17:43:41 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add High Speed ad3552r platform driver.
> 
> The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> through the current AXI backend, or similar alternative IIO backend.
> 
> Compared to the existing driver (ad3552r.c), that is a simple SPI
> driver, this driver is coupled with a DAC IIO backend that finally
> controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
> maximum transfer rate of 33MUPS using dma stream capabilities.
> 
> All commands involving QSPI bus read/write are delegated to the backend
> through the provided APIs for bus read/write.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/Kconfig                  |  14 +
>  drivers/iio/dac/Makefile                 |   1 +
>  drivers/iio/dac/ad3552r-hs.c             | 526 +++++++++++++++++++++++++++++++
>  drivers/iio/dac/ad3552r.h                |   7 +
>  include/linux/platform_data/ad3552r-hs.h |  18 ++
I'd missed this before.  No obvious reason to put the include in a 'global' location
when for now at least only includers re in drivers/iio/dac/

So please move it there.

Some stuff include/linux/platform_data/ is ancient things dating back to board file
days.

Other than that and things bit Nuno raised, this series looks good to me.
Please drop the first 2 patches from v6 as I've applied those now.

Jonathan


> diff --git a/include/linux/platform_data/ad3552r-hs.h b/include/linux/platform_data/ad3552r-hs.h
> new file mode 100644
> index 000000000000..4e3213a0c73b
> --- /dev/null
> +++ b/include/linux/platform_data/ad3552r-hs.h

This isn't what we'd think of as 'platform_data' normally and it is only used
in drivers/iio/dac/ so I would simply move the header to drivers/iio/dac/ad3552r-hs.h

> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2010-2024 Analog Devices Inc.

Generous on the years.  This one should probably just be new copyright given
the code is effectively new.

> + * Copyright (c) 2024 Baylibre, SAS
> + */
> +#ifndef __LINUX_PLATFORM_DATA_AD3552R_HS_H__
> +#define __LINUX_PLATFORM_DATA_AD3552R_HS_H__
> +
> +#include <linux/iio/backend.h>
For this use a forwards reference

struct iio_backend;

Nice to avoid nests of includes where we can easily do so.

> +
> +struct ad3552r_hs_platform_data {
> +	int (*bus_reg_read)(struct iio_backend *back, u32 reg, u32 *val,
> +			    size_t data_size);
> +	int (*bus_reg_write)(struct iio_backend *back, u32 reg, u32 val,
> +			     size_t data_size);
> +};
> +
> +#endif /* __LINUX_PLATFORM_DATA_AD3552R_HS_H__ */
> 


