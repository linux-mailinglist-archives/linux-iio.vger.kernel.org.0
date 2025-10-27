Return-Path: <linux-iio+bounces-25478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 475BFC0E717
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FE174E7AEE
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D83081AC;
	Mon, 27 Oct 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHb93Idy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3010722AE65;
	Mon, 27 Oct 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575258; cv=none; b=QLAjG60ZT+P5WMJkW5pJ8kvGooPWsRjipDJIhBDUVf0OqTFO/aPkCExXUY7RFMHrrT8+8DzC9pZf1suHiM7VbhIQ1vJJ18hWLNFGuDhOypxdpVklQI62z8H1VARtm4JehwcakGAtj69qmASECR3UjuiCsPLQW1dpDtAef2+LrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575258; c=relaxed/simple;
	bh=4R1bLbSxg2okxdRhJflBL/9jaJqqjFT1tnrAXgOWaFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zq4Hrr/oN0oVuRkcXzqdl0dqh8kl+194m9Td0bIFQmsqo1yzJQaYVGJ/BTd9QqcvADEPPSKt/yl4oaiR7pQGvhS1/vvt2tN8fXjUdRpDe1eVjK/khjKKquLRHMuBdkj8gcF4wTAERu+tarX9pUIXRFL/p7nTKwEKA1Ix+KfPVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHb93Idy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0263C4CEF1;
	Mon, 27 Oct 2025 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761575257;
	bh=4R1bLbSxg2okxdRhJflBL/9jaJqqjFT1tnrAXgOWaFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qHb93Idy7dl/Q0CRmDjOoQbUs3Mx3zsNh0AE9NwCGQ1xHKudBBPqftk4Zk2MSkac4
	 bXRUnL0IsGrQtby1x5NTzTZufxg6q4tjc58qHpJACop6CDzCdIhaaZraeZk3VgoMpx
	 Y6pZHJ1KOfu28gCIJHYHlDPGDTtSneMSEl89MslFqtjTInKT2nj3EmJgW762DFvFTU
	 uVmw4XnqFG/HL3qM13oJFEKE+Yd44brcdboQ+dcOeypHUypMKFv2sOJsbv/RlUFFg2
	 79RTjoQ4BHSxffnwdoMwLdL/+TcJnlB6zwLLvh6nijkdqXQDmcrZpruO6xHri3EYdd
	 eTXsXy9Bi8DpA==
Date: Mon, 27 Oct 2025 14:27:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] iio: adc: ad7124: fix possible OOB array access
Message-ID: <20251027142732.261607cc@jic23-huawei>
In-Reply-To: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>
References: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 10:15:05 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Reorder the channel bounds check before using it to index into the
> channels array in ad7124_release_config_slot(). This prevents reading
> past the end of the array.
> 
> The value read from invalid memory was not used, so this was mostly
> harmless, but we still should not be reading out of bounds in the first
> place.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-iio/aPi6V-hcaKReSNWK@stanley.mountain/
> Fixes: 9065197e0d41 ("iio: adc: ad7124: change setup reg allocation strategy")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the togreg branch of iio.git. 
thanks,

J
> ---
>  drivers/iio/adc/ad7124.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 9d58ced7371d0af7004a81153888714e9795d4f4..ed828a82acb71342fb2eae27abfbbd86861cba53 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -586,13 +586,18 @@ static int ad7124_request_config_slot(struct ad7124_state *st, u8 channel)
>  
>  static void ad7124_release_config_slot(struct ad7124_state *st, u8 channel)
>  {
> -	unsigned int slot = st->channels[channel].cfg.cfg_slot;
> +	unsigned int slot;
>  
>  	/*
> -	 * All of these conditions can happen at probe when all channels are
> -	 * disabled. Otherwise, they should not happen normally.
> +	 * All of these early return conditions can happen at probe when all
> +	 * channels are disabled. Otherwise, they should not happen normally.
>  	 */
> -	if (channel >= st->num_channels || slot == AD7124_CFG_SLOT_UNASSIGNED ||
> +	if (channel >= st->num_channels)
> +		return;
> +
> +	slot = st->channels[channel].cfg.cfg_slot;
> +
> +	if (slot == AD7124_CFG_SLOT_UNASSIGNED ||
>  	    st->cfg_slot_use_count[slot] == 0)
>  		return;
>  
> 
> ---
> base-commit: 89cba586b8b4cde09c44b1896624720ea29f0205
> change-id: 20251022-iio-adc-ad7124-fix-possible-oob-array-access-239be24ac692
> 
> Best regards,


