Return-Path: <linux-iio+bounces-27609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099AD0EF41
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FC6430094B7
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51B33984D;
	Sun, 11 Jan 2026 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5QMCcJz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C8DDAB;
	Sun, 11 Jan 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768136872; cv=none; b=c4xC2K4E+5pd8/bG53HFcFBQCxlTtwi/R8mtv/FOXEO5Spx0G7X21VvtSyIX4F1DnSpVeIrHBDyD5QQdy7Whyjmc43DaN2Jc92OjWEw4fVOS9q2HX/MKqxL5GIe4gM8zHxzGoRNDOIAzheN8lR6Kcbw09cEl9zmQvLC7Jkbovgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768136872; c=relaxed/simple;
	bh=MWtxW2JpxnvULib/YwCKheBdTPKCuvNYob7+cJW60nU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFxn5vlXfjpTWDOa2Tn839Pz4SunSz4cx4zpbAt3PFwfqnDORY0D3xM0LRXKszVnpKx8nQJwt1IRntfgh0xX9vtbTfPnnF45TGbO9KApkMvhoMWyaMk/q/55Mp+3HsPrv2b20Dz9iRDrsV9nxt+w7PcBpEOUaSJ4XajgXP5b6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5QMCcJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06337C4CEF7;
	Sun, 11 Jan 2026 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768136871;
	bh=MWtxW2JpxnvULib/YwCKheBdTPKCuvNYob7+cJW60nU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S5QMCcJzQOq59ItdjmK25RW8MEMwC32eBK/ymq/ADlRkxjmZoeQKzNNbkDYXUyAz0
	 0n5ADNRrsm1exINmxa+5ifutrRQVQ0cI6KznrfMjfv5IxUFywrFfmuBGlHQUWuFeqG
	 GQPZ1ctKzwc54YITkx+e4nYXLVbAYiw0PqJLUUVtO5sjVHqA+X5p0wrZXqFOWUlRCj
	 MBpbwbK4oalYAk7uCaF72R9w57RlQTGTvzwLkp0PSZ2xPEQfW8+1Yke1A+xGa/PPBt
	 DW4RhKrzr3wB6Y9PUxInz87iB2kb2Zge7T6VJ+gJd9fnv9QelVgz8EITN/CfoMJz7v
	 NAH1f43r2r7Mg==
Date: Sun, 11 Jan 2026 13:07:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1018: Drop stale kernel-doc function
 context
Message-ID: <20260111130744.48919874@jic23-huawei>
In-Reply-To: <20260106-ads1018-comment-v1-1-315d50c2a353@gmail.com>
References: <20260106-ads1018-comment-v1-1-315d50c2a353@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Jan 2026 03:17:32 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> The driver no longer uses iio_device_claim_buffer_mode(). Drop it from
> ads1018_spi_read_exclusive() context remark.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Applied.
Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads1018.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
> index 286e06dc70b8..6246b3cab71f 100644
> --- a/drivers/iio/adc/ti-ads1018.c
> +++ b/drivers/iio/adc/ti-ads1018.c
> @@ -211,8 +211,7 @@ static u32 ads1018_calc_delay(unsigned int hz)
>   * Reads the most recent ADC conversion value, without updating the
>   * device's configuration.
>   *
> - * Context: Expects iio_device_claim_buffer_mode() is held and SPI bus
> - *	    *exclusive* use.
> + * Context: Expects SPI bus *exclusive* use.
>   *
>   * Return: 0 on success, negative errno on error.
>   */
> 
> ---
> base-commit: fb2f4eb29a258145b0336601f00509cab6e93e7c
> change-id: 20260106-ads1018-comment-48d0a82c6826
> 


