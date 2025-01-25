Return-Path: <linux-iio+bounces-14571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157EA1C334
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258993A74A9
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE09207E07;
	Sat, 25 Jan 2025 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjSWFxSH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B426AF6;
	Sat, 25 Jan 2025 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737808548; cv=none; b=Xa+OZ5x2gwOj/VhDyzkrmps/kmD5onSriRW20jB88sme4Zjtz5z6WgAUzgTPPWalnTbSKCYDWjvbvVzry0BuK+hGqF1pG2RXxFFKcFwd1ZRDcVC0WYQCQUXm2gcNA4rnKi40EKTe4oLk/QqoTTdZ0/T7drLnp3bFmqcWHo0AMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737808548; c=relaxed/simple;
	bh=oyTRYH01++8NqEO5U7PnhR6rSMA64jrCDiPzd3qZy2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5TCAjzbw9/RzDMam2tZWBMNgf9FXx6eu7CfInYS9Uhy1Px1Hi6waXe+JgxuokvrLJya1NnBtPhPg6htAJgV1AJWHa0q0GoplO8Se7CEMGjvKQ415wF8/AgdmRLF9GuQ7oAupfziftrDQv89t1cq+ErFVRTKBWOp3auO1zQqnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjSWFxSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72306C4CED6;
	Sat, 25 Jan 2025 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737808548;
	bh=oyTRYH01++8NqEO5U7PnhR6rSMA64jrCDiPzd3qZy2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TjSWFxSHpfZfAAqDeEGC/86AXUeR52o5+Gorjjh42sfN4nf3q8EchDu7q2W3kNFYN
	 n+EdbZ7cEtzG5k7BGHaKSmbbpwqODdSoYmB+0hrdy+HFLaoqavZ9G1GH+SaiPXqSbY
	 /rlXKZJh3XeRtLHZY6cK/IiSvwNFawtncuFOmfBEk2IzwS+Gkn78FiIRxEUwPQwhFK
	 rQ0RrnZxemb8hbPBUMnNxC5JxX5sFyoMGObCvPImoM0o+MdIFOO5AkyoxUL+Ak1Cze
	 XNCPvFzUNG16k7HSjIGJqa3KL4ncInbu2Xj+YzGOYKDMhaE4OSCV+8OD4E67HMwmLz
	 4KySvHt2PeHlQ==
Date: Sat, 25 Jan 2025 12:35:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r: clear reset status flag
Message-ID: <20250125123540.5ed9f1ed@jic23-huawei>
In-Reply-To: <20250122-wip-bl-ad3552r-clear-reset-v1-1-04c1760ca622@baylibre.com>
References: <20250122-wip-bl-ad3552r-clear-reset-v1-1-04c1760ca622@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 21:32:43 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Clear reset status flag, to keep error status register
> clean after reset (ad3552r manual, rev B table 38).
> 
> Reset error flag was left to 1, so debugging registers, the
> "Error Status Register" was dirty (0x01). It is important
> to clear this bit, so if there is any reset event over normal
> working mode, it is possible to detect it.

Oddly short wrap. for commit descriptions wrap at 75 chars.

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Sounds like a fix, so does it want a fixes tag / go in quick
of is this only visible in debug related activities?

Jonathan

> ---
>  drivers/iio/dac/ad3552r.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index e7206af53af6..7944f5c1d264 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -410,6 +410,12 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
>  		return ret;
>  	}
>  
> +	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
> +	ret = ad3552r_write_reg(dac, AD3552R_REG_ADDR_ERR_STATUS,
> +				AD3552R_MASK_RESET_STATUS);
> +	if (ret)
> +		return ret;
> +
>  	return ad3552r_update_reg_field(dac,
>  					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
>  					AD3552R_MASK_ADDR_ASCENSION,
> 
> ---
> base-commit: 07fa5fa97959422bbd663df056c9de0dec55e34f
> change-id: 20250122-wip-bl-ad3552r-clear-reset-330bdf2ff56e
> 
> Best regards,


