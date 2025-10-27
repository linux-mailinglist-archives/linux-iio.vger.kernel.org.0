Return-Path: <linux-iio+bounces-25472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8F7C0E68A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7A675057EB
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900E30ACF1;
	Mon, 27 Oct 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmL0bIdq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4F2566DD;
	Mon, 27 Oct 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574085; cv=none; b=g5jCjcb32IGfWcxYWcCWj3cFXj86dvSpQ0KFKFSI0XLSJqiSyYHxJvOnqqSGoZLZ0/E1ywYOaX7yvOg1vgSCoHfBB6mpa57Nd9w1geDwq+Eb+tDf2WkrGNo5dapBTh7Er95tia1u4xRLA4VInryLsvjncHSXdwPOQu9UFMBcFlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574085; c=relaxed/simple;
	bh=G5enwOxx/IokudK+Rl23Z3f4vUmuTwxMyx1zaA1SnkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQQo6t1UJORHL/B+mdDVXPhe2lypWQup80fWfSrZCGT2GFOhhF0XqTJED+sXtXzRrhdidICswQV/6FUMgD2EiT/yV1lIxBKT1kaVrhAi3DiHZDGOZZN7U0XXRQIBVXiZBUP988aL8Jlh49jgRIPby9/qE5UIg6xJYdoewmh/8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmL0bIdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAB6C4CEF1;
	Mon, 27 Oct 2025 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574085;
	bh=G5enwOxx/IokudK+Rl23Z3f4vUmuTwxMyx1zaA1SnkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AmL0bIdqC7DBYq9C/TSivDw3ClX+wqW/taBwy56Vwhx/Ke6hIHkHVN0k80ijlVoFA
	 4GR7721eu8ej9qR6OEOlyvaDkJCjLSsY7NtMtJyqL2TdpIelAKlqN1KMQX8mFVtlxS
	 cWIsVIQtOARzYUrPvA1TT242Fm5pAgXWzNm7o3sK9oBZsr3fWdTVmGtb1zLMOMGlUk
	 8IWNs4TT8vXjfC5AbssU1jv2QQjdhs2kxdnPVbQv9a6q5F44tu3nn9SXvYAaAL1jCy
	 eAFuUZSRcBna9XgYzCXsoSkpAu7zBccivRewC3+73T3daec2Xb1Ij6IkAOBHEsc931
	 E2ZSz/D71CJ+g==
Date: Mon, 27 Oct 2025 14:07:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: clear reference voltage bits before
 configuring vref
Message-ID: <20251027140759.3d3149bd@jic23-huawei>
In-Reply-To: <20251021053918.3008654-1-billy_tsai@aspeedtech.com>
References: <20251021053918.3008654-1-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 13:39:18 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Ensures the reference voltage bits are cleared in the ADC engine
> control register before configuring the voltage reference. This
> avoids potential misconfigurations caused by residual bits.
> 
> Change-Id: I03c036436f376ced8a19fa5d407b7bbb377ae721
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Make sure the patch title includes the part/driver name.

iio: adc: aspeed: ..

+ the stuff Andy raised already.

Actual change looks correct to me.

> ---
>  drivers/iio/adc/aspeed_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 1d5fd5f534b8..8ab29948214a 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -415,6 +415,7 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
>  	}
>  	adc_engine_control_reg_val =
>  		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> +	adc_engine_control_reg_val &= ~ASPEED_ADC_REF_VOLTAGE;
>  
>  	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
>  	if (ret < 0 && ret != -ENODEV)


