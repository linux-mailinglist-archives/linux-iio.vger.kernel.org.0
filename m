Return-Path: <linux-iio+bounces-18011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065EA86D25
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046A04428E1
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24601E8326;
	Sat, 12 Apr 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="triqdc+h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55021C5D56;
	Sat, 12 Apr 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744463582; cv=none; b=omAiQVaOiKKjp3VN2b0JLETKKfDW58KVa1172eXROOkK1TaZYUFwx4tT2dPJmNS/wiiouThm7JKdWAjbPQKZyzexYkjRN3/kTowHLXiYXDPALy8+vejho/EVO/x9OxgBxajqu0QkG9f3dV1e680FrzYalJ5UOOSbH+EGx1JSBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744463582; c=relaxed/simple;
	bh=Gf57asGbiKQzqvnsdSvqw49qqbbDDX3v6+TdwuELv3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxQJlW/1I7bqSlWjC+f12tD2dUGN3x7fx/+2HUgkm3oQFHnb0142itibSBXqLhfOrcFgwkPsmFmMufjyzeH9Sy3Gacp/DOfR1zI6+ENzYujDVdCIroztA2jUUEabd1bfVUwCHHXz2qmF5nGOYYhtXkmwg+GxFl4B/iy6hzd6k9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=triqdc+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452FCC4CEE3;
	Sat, 12 Apr 2025 13:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744463582;
	bh=Gf57asGbiKQzqvnsdSvqw49qqbbDDX3v6+TdwuELv3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=triqdc+hGyW+tlH1Knfp2wE4QYnFHceymdGOQ5HWu53Z1IHJhptKD0SJMTR2dowH8
	 hjnSajZEUwIAh77wp3mduW3bs6D6WrbjYHDYb5MHwfNP3burUQXrHC62tqKf34679b
	 sMayNfEo5wCXTNIdxWBloBWZBvgH+tPXHIdgspnfEGwLO9Zp+beyOG+dBONRGNFk+9
	 t3O+JgB6eqwtO4uhxQ7z3g0Fe/0RZmZ3eDhHGlfle8p36+tzCompuDSpmUnTP9VYVJ
	 vRVudBJTcnn5uJZ4rGiJS0XPio2kbb82iEDTygf89/A3in3vAbGeayjBLtwq3OOvWM
	 s8rE9XEDOaaUA==
Date: Sat, 12 Apr 2025 14:12:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc128s052: Add lower resolution
 devices support
Message-ID: <20250412141253.6d57032e@jic23-huawei>
In-Reply-To: <20250408132120.836461-3-sbellary@baylibre.com>
References: <20250408132120.836461-1-sbellary@baylibre.com>
	<20250408132120.836461-3-sbellary@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Apr 2025 06:21:20 -0700
Sukrut Bellary <sbellary@baylibre.com> wrote:

> The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> interface. The device family responds with 12-bit data, of which the LSB
> bits are transmitted by the lower resolution devices as 0.
> The unavailable bits are 0 in LSB.
> Shift is calculated per resolution and used in scaling and
> raw data read.
> 
> Lets reuse the driver to support the family of devices with name
> ADC<bb><c>S<sss>, where
> * bb is the resolution in number of bits (8, 10, 12)
> * c is the number of channels (1, 2, 4, 8)
> * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> and 101 for 1 MSPS)
> 
> Complete datasheets are available at TI's website here:
> https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> 
> Tested only with ti-adc102s051 on BegalePlay SBC.
> https://www.beagleboard.org/boards/beagleplay
> 
> Co-developed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
> ---
> Changes in v3: 
>         - used be16_to_cpu() for the endian conversion.
>         - used config index enum while setting up the adc128_config[]
> 
> - Link to v2: 
>         https://lore.kernel.org/lkml/20231022031203.632153-1-sukrut.bellary@linux.com/
> 
> Changes in v2:
>         - Arranged of_device_id and spi_device_id in numeric order.
>         - Used enum to index into adc128_config.
>         - Reorder adc128_config in alphabetical.
>         - Include channel resolution information.
>         - Shift is calculated per resolution and used in scaling and 
>         raw data read.
> 
> - Link to v1: https://lore.kernel.org/all/20220701042919.18180-1-nm@ti.com/
> ---
>  drivers/iio/adc/ti-adc128s052.c | 149 ++++++++++++++++++++++++--------
>  1 file changed, 112 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index a456ea78462f..d4b76fd85abd 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -7,6 +7,22 @@
>   * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
>   * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
>   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> + *
> + * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> + * interface. This driver supports the whole family of devices with a name
> + * ADC<bb><c>S<sss>, where
> + * bb is the resolution in number of bits (8, 10, 12)
> + * c is the number of channels (1, 2, 4, 8)
> + * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> + * and 101 for 1 MSPS)
> + *
> + * Complete datasheets are available at TI's website here:
> + *   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> + *
> + * 8, 10, and 12 bits converters send 12-bit data with
> + * unavailable bits set to 0 in LSB.
> + * Shift is calculated per resolution and used in scaling and
> + * raw data read.
>   */
>  
>  #include <linux/err.h>
> @@ -53,7 +69,7 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>  	if (ret < 0)
>  		return ret;
>  
> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> +	return be16_to_cpu(*((__be16 *)adc->buffer));

I think we now have a convenient adc->buffer16 (probably introduced in Matti's
series.  Sorry I missed the overlap of the two series until now. These part numbers
are too long and confusing to stick in my head!

Matti took on maintaining that driver because he wanted to see any changes
that might affect the Rohm part it now supports.  If anyone wants to volunteer
from the TI side of things that would be ideal - just send a patch adding to
the new MAINTAINERS entry.

Jonathan


>  }

