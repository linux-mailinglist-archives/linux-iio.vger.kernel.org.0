Return-Path: <linux-iio+bounces-7970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFF193DF88
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8651C20E20
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E4615DBD6;
	Sat, 27 Jul 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeWtmhWH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6715D5C3;
	Sat, 27 Jul 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722086821; cv=none; b=KvX8c0iXSNxydiiyYtvzW2wALqoh5qdb14FqwrrGTerwmvyFVBz1ncCbtzcVpJR7ZJY0u/p6XfvhwHWrrAIZjOgebUkxd5sdCDK8hkw5wz24SAffOitIrBaEq9hjH0bXRbhh/1iqaSA00E25Cul579Cxxv8godotXXaX6pvdLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722086821; c=relaxed/simple;
	bh=hfm/a0WJzKDzsAPXoH8vv1DrOwVXSTC9IQm/YjmsKwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fv7j6fIYUp/PWRRmcUdFEr1gNirAADV7E3ThJiWOLHSouFEO5htnVOHLQaZckWdYKxa9zBVAQ1Z1pUwUC6lEDfDhE5ovfeRQSDkpl0PGThPxFeRzhG1CRNsLPYnPy/Tq6YWhTMwYCfLOevuZIRcJc54gnuDZT21dJ8bpDeuvRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeWtmhWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A03C32781;
	Sat, 27 Jul 2024 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722086820;
	bh=hfm/a0WJzKDzsAPXoH8vv1DrOwVXSTC9IQm/YjmsKwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jeWtmhWH/yI52jgw83HNHqf/C0n95czBcPQJ8+zBY9Yp9O15lM0i8caFgPM5JKlgS
	 8m/+0ccWBODrczcueAG5AV9yttxJE93VQCVIlQyhHzwAD3pyWe1ucMWBjYrbJSC4ux
	 oG4hB2MPwpVisc60xuQN2xQFvRg6FCAeEM95kynWO0wZaPrziphdcx8r5RVWCnmpup
	 nOH8bppqn+K0AzRv8CQksd5PlO2g//ox7bsf53EGRz0hUNc2lWaRbK5Q3iPy4xFL+X
	 ysvhhCPPZfit65qm1URaof0kmiTe3xsfwobDx1vyoo3l1Syt+yX1yIKOBve/hMU/R1
	 GfPiWWyXZdiNQ==
Date: Sat, 27 Jul 2024 14:26:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v3 3/9] spi: add support for hardware triggered
 offload
Message-ID: <20240727142652.45942b5c@jic23-huawei>
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-3-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	<20240722-dlech-mainline-spi-engine-offload-2-v3-3-7420e45df69b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 16:57:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This extends the SPI framework to support hardware triggered offloading.
> This allows an arbitrary hardware trigger to be used to start a SPI
> transfer that was previously set up with spi_offload_prepare().
> 
> Since the hardware trigger can happen at any time, this means the SPI
> bus must be reserved for exclusive use as long as the hardware trigger
> is enabled. Since a hardware trigger could be enabled indefinitely,
> we can't use the existing spi_bus_lock() and spi_bus_unlock() functions,
> otherwise this could cause deadlocks. So we introduce a new flag so that
> any attempt to lock or use the bus will fail with -EBUSY as long as the
> hardware trigger is enabled.
> 
> Peripheral drivers may need to control the trigger source as well. For
> this, we introduce a new spi_offload_hw_trigger_get_clk() function that
> can be used to get a clock trigger source. This is intended for used
> by ADC drivers that will use the clock to control the sample rate.
> Additional functions to get other types of trigger sources could be
> added in the future.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> TODO: Currently, spi_bus_lock() always returns 0, so none of the callers
> check the return value. All callers will need to be updated first before
> this can be merged.

If it's going to fail sometimes, probably needs a name that indicates
that. I'm not sure spi_bus_try_lock() is appropriate though.

> 
> v3 changes:
> * renamed enable/disable functions to spi_offload_hw_trigger_*mode*_...
> * added spi_offload_hw_trigger_get_clk() function
> * fixed missing EXPORT_SYMBOL_GPL
> 
> v2 changes:
> 
> This is split out from "spi: add core support for controllers with
> offload capabilities".
> 
> Mark suggested that the standard SPI APIs should be aware that the
> hardware trigger is enabled. So I've added some locking for this. Nuno
> suggested that this might be overly strict though, and that we should
> let each individual controller driver decide what to do. For our use
> case though, I think we generally are going to have a single peripheral
> on the SPI bus, so this seems like a reasonable starting place anyway.

...

> +int spi_offload_hw_trigger_mode_enable(struct spi_device *spi, const char *id)
> +{
> +	struct spi_controller *ctlr = spi->controller;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!ctlr->offload_ops || !ctlr->offload_ops->hw_trigger_mode_enable)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&ctlr->bus_lock_mutex);
> +
> +	if (ctlr->offload_hw_trigger_mode_enabled) {
> +		mutex_unlock(&ctlr->bus_lock_mutex);
> +		return -EBUSY;
> +	}
> +
> +	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
> +	ctlr->offload_hw_trigger_mode_enabled = true;
Why do you need to take the spinlock when setting this to true, but not when
setting it to fast (in the error path below)?

> +	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
> +
> +	/* TODO: how to wait for empty message queue? */
> +
> +	mutex_lock(&ctlr->io_mutex);
> +	ret = ctlr->offload_ops->hw_trigger_mode_enable(spi, id);
> +	mutex_unlock(&ctlr->io_mutex);
> +
> +	if (ret) {
> +		ctlr->offload_hw_trigger_mode_enabled = false;
> +		mutex_unlock(&ctlr->bus_lock_mutex);
> +		return ret;
> +	}
> +
> +	mutex_unlock(&ctlr->bus_lock_mutex);
> +
> +	return 0;
> +}
> 


