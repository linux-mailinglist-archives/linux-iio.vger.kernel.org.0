Return-Path: <linux-iio+bounces-18017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0693A86E3A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C093B18936E8
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269AE1FF1B5;
	Sat, 12 Apr 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzzOcBcq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4945948;
	Sat, 12 Apr 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744477251; cv=none; b=AspgQAA9FMMJHCH/9vyzvDMrBq54NLuCJaGIdOTvPF9kf/M0h4sqQ+9MVprQ3BEynTWinJv+6NBjIbNFr+UUkbepmItqzy56K5et5NOry579QpexI1Lx0ZfhmGKZCCOzH3fVfFcMF0c6t/tnMRCT6tI55UsNyUJYaT5jbr0aL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744477251; c=relaxed/simple;
	bh=ZaQ+UkXQJDIOMjTun39//hUQncwe8+v6w1BdKthMBd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkTdEv/Y4ifn6ChBj5IzCHLELmGJe2Nta/WHi7xRkJDMHlJseVNXWmo5ttz+isaqyDUxfeo8KR0RjtupiaKD1oymzHAX8VnoravoFHEZBX6QkXiFBHY9Tsuwe+wgpA4JEWCdbkR6uiH6YRPIRspoWeC40rgQUVloVCXKTQyyf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzzOcBcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0F4C4CEE3;
	Sat, 12 Apr 2025 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744477251;
	bh=ZaQ+UkXQJDIOMjTun39//hUQncwe8+v6w1BdKthMBd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NzzOcBcqM+q45RxWNeuiPe3KLJDpd6hvEAOC7tVh+ynsgYmzDRuKaFnZ3Jbt2SHjW
	 K8Z5iziznQ1ustfeF4Prgh6uFIfpTIIJ1SmMR9aaFHoRaSEZPJFgk5QqhtV9eCPtz/
	 GDni80HPui4hYWmppmgThjZcmIlB8VQ5OCW5WBUkTz7rweF7pFUCaWIgrMoWyt9he7
	 AxIE78RYEmnb36IrFPWWmei72rDd9Nbr4o9Axnlkoiw0rJtM4NRP5qGiYr+SYdbIW7
	 YGURWfHRrkmEq4LPAwmrxw8VXPgTRS+Oectjur8swH6qzeI4r3kikDhKrYZ4JAiyVy
	 v4lSHDBUm52Jw==
Date: Sat, 12 Apr 2025 18:00:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: Fix use of uninitialized
 status_pos
Message-ID: <20250412180046.62f9eab4@jic23-huawei>
In-Reply-To: <20250410170408.8585-1-purvayeshi550@gmail.com>
References: <20250410170408.8585-1-purvayeshi550@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 22:34:08 +0530
Purva Yeshi <purvayeshi550@gmail.com> wrote:

> Fix Smatch-detected issue:
> drivers/iio/adc/ad_sigma_delta.c:604 ad_sd_trigger_handler() error:
> uninitialized symbol 'status_pos'.
> 
> The variable `status_pos` was only initialized in specific switch cases
> (1, 2, 3, 4), which could leave it uninitialized if `reg_size` had an
> unexpected value.
> 
> Fix by adding a default case to the switch block to catch unexpected
> values of `reg_size`. Use `dev_err_ratelimited()` for error logging and
> `goto irq_handled` instead of returning early.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
Seems like reasonable hardening of the code. 

Applied.

Thanks,

> ---
> V1 - https://lore.kernel.org/all/20250409200151.201327-1-purvayeshi550@gmail.com/
> V2 - Moved the reg_size validation inside the switch statement using a default case,
> replaced dev_err() with dev_err_ratelimited(), and replaced return IRQ_HANDLED
> with goto irq_handled;
> 
>  drivers/iio/adc/ad_sigma_delta.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 6c37f8e21120..4c5f8d29a559 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -587,6 +587,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  		 * byte set to zero. */
>  		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
>  		break;
> +
> +	default:
> +		dev_err_ratelimited(&indio_dev->dev, "Unsupported reg_size: %u\n", reg_size);
> +		goto irq_handled;
>  	}
>  
>  	/*


