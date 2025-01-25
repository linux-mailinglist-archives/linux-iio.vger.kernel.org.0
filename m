Return-Path: <linux-iio+bounces-14570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B42A1C327
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0AC188926D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9F5207A18;
	Sat, 25 Jan 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWxB8/TP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645D26AF6;
	Sat, 25 Jan 2025 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737808419; cv=none; b=p3jnSR2ZCcbj2egYQWlyEJMp2KMxTXl4rQNDtxTNktzFGRW5FW+mIgc6FRPRM+6+ptaGTKJsdVarUo5cmecL17ptWOP2k9qVG26pNm7rBXdhB914QwQH2kfyyW/S4HM/hGZZ3uoThHkEAzegQlAAdKI0Y1cBvM0Q4YRAt2HUkXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737808419; c=relaxed/simple;
	bh=OP8hluEFAhXU/LJIptHIMdqiIOBd9FOEfKvXKx/uRCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1phlglKioMN3N5sgoxCzGWUP083SdPdP/5wtXZJmF5OtiOroZmqPSeX6+sRThVyytHFU5Po3L3LGXb+fca5wN1QPt5hnL5hb4mZccUmqBhcSK1d/b6FTZAx9RBIHvZkGbk3XBN48RUorpHgH2qD900dE/xF10BQPWmQxqdt3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWxB8/TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09628C4CEE0;
	Sat, 25 Jan 2025 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737808418;
	bh=OP8hluEFAhXU/LJIptHIMdqiIOBd9FOEfKvXKx/uRCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KWxB8/TPi+6Mpk3Jtps62Cloq5X82z0B1H3UdSZ7DLp7CkL4l9wFw2S7X0+8K9J9D
	 fYLRhYW6MDoyuZZzlsA00gx8i4XBu8S0wDReEx1CWs77wgsk2JsDoqQ0ap0W8iyAvs
	 6m/UVpd/VjFsTdZSLzQRot6tZoAPks6HGPcv+0G7zX9kb7pdJJovvVk3vRv2+kL5uf
	 UssyQgzPm/OcQrGzd3dEB54mxIAgZAoPlxSh+b8MfqtWzFseC2VnVyPKd6kXNDUku3
	 +t9T9rX2GEdh7LWAsldrdc/wO5TUy+npRIXozIGLFL2/8ImLoRPyiN2p+VTOTs/i04
	 NLo4E+PNTBz0w==
Date: Sat, 25 Jan 2025 12:33:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 0/4] iio: light: fix scale in veml6030
Message-ID: <20250125123331.646e8cf8@jic23-huawei>
In-Reply-To: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
References: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jan 2025 18:31:57 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series follows a similar approach as recently used for the veml3235
> by using iio-gts to manage the scale as stated in the ABI. In its
> current form, the driver exposes the hardware gain instead of the
> multiplier for the raw value to obtain a value in lux.
> 
> Although this driver and the veml3235 have many similarities, there are
> two main differences in this series compared to the one used to fix the
> other driver:
> 
> - The veml6030 has fractional gains, which are not supported by the
>   iio-gts helpers. My first attempt was adding support for them, but
>   that made the whole iio-gts implementation more complex, cumbersome,
>   and the risk of affecting existing clients was not negligible.
>   Instead, a x8 factor has been used for the hardware gain to present
>   the minimum value (x0.125) as x1, keeping linearity. The scales
>   iio-gts generates are therefore right without any extra conversion,
>   and they match the values provided in the different datasheets.
> 
> - This driver included a processed value for the ambient light, maybe
>   because the scale did not follow the ABI and the conversion was not
>   direct. To avoid breaking userspace, the functionality has been kept,
>   but of course using the fixed scales. In order to ease the
>   calculations, iio_gts_get_total_gain() has been exported to avoid
>   working directly with the scale in NANO, that would require 64-bit
>   operations.
> 
> To ease the usage of the iio-gts selectors, patches to support regfields
> and caching has been included.
> 
> This issue has been present since the original implementation, and it
> affects all devices it supports.
> 
> This series has been tested with a veml7700 (same gains as veml6030) and
> a veml6035 with positive results.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Whilst we might consider a backport eventually.  This is a huge patch
to do that with.  Hence I'll take this the slow way for next merge window.

For now I've applied patches 1 and 2 in the interest of nibbling away
at what we will need to see again ;)

Jonathan

> ---
> Changes in v2:
> - Rename SEL_GAIN to indicate they are in MILLI.
> - Split first patch (regfields and chaching).
> - Use regfield structs in chip struct instead of function pointer.
> - Use total gain to derive scale, avoiding 64-bit divisions.
> - Link to v1: https://lore.kernel.org/r/20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com
> 
> ---
> Javier Carrasco (4):
>       iio: light: veml6030: extend regmap to support regfields
>       iio: light: veml6030: extend regmap to support caching
>       iio: gts-helper: export iio_gts_get_total_gain()
>       iio: light: veml6030: fix scale to conform to ABI
> 
>  drivers/iio/industrialio-gts-helper.c |   3 +-
>  drivers/iio/light/Kconfig             |   1 +
>  drivers/iio/light/veml6030.c          | 608 +++++++++++++++++-----------------
>  include/linux/iio/iio-gts-helper.h    |   1 +
>  4 files changed, 299 insertions(+), 314 deletions(-)
> ---
> base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
> change-id: 20241231-veml6030-scale-8142f387e7e6
> 
> Best regards,


