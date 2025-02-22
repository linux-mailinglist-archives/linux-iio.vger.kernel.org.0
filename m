Return-Path: <linux-iio+bounces-15974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10809A40A93
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 18:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE6A3B31EB
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97DB143895;
	Sat, 22 Feb 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ1fxIql"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E31DDE9;
	Sat, 22 Feb 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740244572; cv=none; b=Q3uQD2gMEaPPriH+TPivAe7wIH+6AFxFFsrm4ZczSpmLyWZnrZjp7R6/xC5y83dStCDvhMlHQ3xm9TXhNeYnFje2PP65EiIsaF5b2y0MD4qNFtT38YYmzoi4U7jmPZYde1CMMVLqHngsOsl4hO3u997kdapHQl5MWHgeHGLkvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740244572; c=relaxed/simple;
	bh=16NVBIcjXQ/0AnhxVbi9aCTvh05LomfBrrtZhDlhJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOX6qnF4X2x+BjAndVEr5kxLA8whUDI1zcMMYh2KLmP3Xa/kmwr1Q7qHP1T+KT9Bx1LTE3wJePEQYx4QErWsbqjaMYRT2rOLTkgt92PpHGTxGpD1dnFUpuORLFp/e7oHqUpQLwyEVHadq5CAxSfiZ5yuLVmHlNimx4jZaPorzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ1fxIql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A67C4CED1;
	Sat, 22 Feb 2025 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740244572;
	bh=16NVBIcjXQ/0AnhxVbi9aCTvh05LomfBrrtZhDlhJkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HZ1fxIqlUNcPT75QN7ERgw44ZL+QTJTJRnfW0x2R8itRG2mwluIN1IEug9XLu47mX
	 h2R+VS5eV3l1JGGPNjzY6jG+FYnnZ1YTz3a0lOIPf2HKRmDF1d7kwnKe+/DWe6BSpM
	 lL3E7iFvsIPjdrXKRxicAXh2LF3VcvA0NQG5ngeFPMz8443h9acecLfBQWh3Jk/haq
	 QMwLm53iw9aOI70Xh2bQvpQaVqcpJWmNut3Vpab/UGaYwWau9rpvAdvZ4MdZUhuVjs
	 +NJLOzfXZ05BwGdhSW7Zu0GlHfPMY3RqQAITHW4y52k0uY+jMLQxsbsK5AhL1sBx5z
	 lugQI7taau+6A==
Date: Sat, 22 Feb 2025 17:16:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: adi-axi-dac: add io_mode check
Message-ID: <20250222171607.3dfbe6c6@jic23-huawei>
In-Reply-To: <20250219-wip-bl-axi-dac-add-enum-check-v1-1-8de9db0b3b1b@baylibre.com>
References: <20250219-wip-bl-axi-dac-add-enum-check-v1-1-8de9db0b3b1b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 19:57:43 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add safe check to the high bound of the enum values,
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
Applied. thanks!

Jonathan
>  drivers/iio/dac/adi-axi-dac.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index 009fb987e1afd04c3dbc59a9742f7982744420c2..892d770aec69c4259de777058801c9ab33c79923 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -728,6 +728,9 @@ static int axi_dac_bus_set_io_mode(struct iio_backend *back,
>  	struct axi_dac_state *st = iio_backend_get_priv(back);
>  	int ival, ret;
>  
> +	if (mode > AD3552R_IO_MODE_QSPI)
> +		return -EINVAL;
> +
>  	guard(mutex)(&st->lock);
>  
>  	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> 
> ---
> base-commit: 4dd0ce442fa57f5274878c89223362344f28224c
> change-id: 20250219-wip-bl-axi-dac-add-enum-check-8bb617285793
> 
> Best regards,


