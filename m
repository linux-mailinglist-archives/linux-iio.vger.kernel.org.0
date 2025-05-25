Return-Path: <linux-iio+bounces-19891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3438AC3500
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA66189259E
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837991F3FF4;
	Sun, 25 May 2025 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwgnODku"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8C1E871;
	Sun, 25 May 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748180854; cv=none; b=EaTJwa5+J0pKFMAkt3fMw0VUiKyqKh40iEavR0W8PJW6L/JO7h4l03WoRa5eWZBngGNKReZGczbZwi6Lw41uBxxeoQyKjuMWzfUWGO0JRgQ6eKNyoG7cLxeN5fDwRceZmFNJw/47ObKhwSDrpY4QzsNv1e3AaBjVx49oKQpkyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748180854; c=relaxed/simple;
	bh=BOGY6xdy9qpmKy+O38u6QBnUf9NQ9jgCAzokSyLGzLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHLh7SCSLeUR6qeK88vMmPv5B3lJGDQuHT4hV+SlDHd0xVA2YyAmVOssulrq23wD/xcD0cJn0rlNpkvinbWOf4ZxZ65c6rduFaDBwRQHxYSk6jNMcjET+JASRIPa9cxUS0xSYRkqmYTg9AqlvkteV+38ypBvzglRQZHHj16HWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwgnODku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8214FC4CEEA;
	Sun, 25 May 2025 13:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748180853;
	bh=BOGY6xdy9qpmKy+O38u6QBnUf9NQ9jgCAzokSyLGzLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NwgnODkuifVrnzgJ5lSq0KGin3OcqC8ThMpcBfW+qGQMCDyos1Jwj6ESX+jtyptNY
	 4sdK82IcmTpq0TBClgHK9TL2vUC3mYoigxY90m/Q2vQUCCTj1yOaK4lCVDsum3Kx5u
	 eB2ZhPbxWdOukCUcIXNrEyCIsvcEiLtiC/GOJOxhz8UuGp2moEVsb+DAoygOTTmVh0
	 ojNuesLcTpxBEsJeJqd3YF4qt6QifkzyCXK474YnsByo/OnFhLOGphka4W/dgCFuZi
	 TqEI5w+0zRiBEjP3jLjdyoDdm70ee/avxtZ2bmMjLK0Bv50dVihVUc+jPi6XcfMMii
	 9uh9Z2453j+jg==
Date: Sun, 25 May 2025 14:47:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: dac: adi-axi-dac: fix bus read
Message-ID: <20250525144725.4bc9b8ad@jic23-huawei>
In-Reply-To: <20250523-ad3552r-fix-bus-read-v3-1-310e726dd964@baylibre.com>
References: <20250523-ad3552r-fix-bus-read-v3-0-310e726dd964@baylibre.com>
	<20250523-ad3552r-fix-bus-read-v3-1-310e726dd964@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 11:00:51 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix bus read function.
> 
> Testing the driver, on a random basis, wrong reads was detected, mainly
> by a wrong DAC chip ID read at first boot.
> Before reading the expected value from the AXI regmap, need always to
> wait for busy flag to be cleared.
> 
> Fixes: e61d7178429a ("iio: dac: adi-axi-dac: extend features")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Huh. Seems I never replied to original thread, but I took this a while
back.  Looks unchanged at a quick glance so no problem.

Jonathan


> ---
>  drivers/iio/dac/adi-axi-dac.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index 8ed5ad1fa24cef649056bc5f4ca80abbf28b9323..5ee077c58d7f9730aec8a9c9dff5b84108b3a47e 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -760,6 +760,7 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
>  {
>  	struct axi_dac_state *st = iio_backend_get_priv(back);
>  	int ret;
> +	u32 ival;
>  
>  	guard(mutex)(&st->lock);
>  
> @@ -772,6 +773,13 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
>  	if (ret)
>  		return ret;
>  
> +	ret = regmap_read_poll_timeout(st->regmap,
> +				AXI_DAC_UI_STATUS_REG, ival,
> +				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
> +				10, 100 * KILO);
> +	if (ret)
> +		return ret;
> +
>  	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
>  }
>  
> 


