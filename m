Return-Path: <linux-iio+bounces-19035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A25CAA86C2
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8DF3B58A6
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636981A3174;
	Sun,  4 May 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs+T8n5P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF74155342;
	Sun,  4 May 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746369758; cv=none; b=NVMpjE4VqhPpg19yWMm+dNDeqHYjAfO0zve4heq4nuXwjAJydxHWvONYqWKzV0V0oOQq2BRMs2++KhIO9/eoevFeWjy+s7rcjNRPwKPWbHTGaYawsYUy+ckRneptI0k1xT/OfdVqHciOv5g2ynDAvN74y16dghvVu40QXm+QjEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746369758; c=relaxed/simple;
	bh=/u3t60eegBB+zBmrRbGWrAkhGEvvre02Rpa27QsI3f8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SftSOh/0p6Owg1EGfj5fv/QMlwURcRowXFOjOjfRVUfLlsDbwDyf3bVM9fQuqa7eBrKjPVCsSlUoFkoraEyp0RMyzTJ7+PmSA4fi1KL4vqi3EpBqccgmXBrNsu3LQhKmRlZ5+nOrswhm1F7bprIj3eQ7XKjG5Fq4efa1vbhK3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs+T8n5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA36C4CEE7;
	Sun,  4 May 2025 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746369757;
	bh=/u3t60eegBB+zBmrRbGWrAkhGEvvre02Rpa27QsI3f8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vs+T8n5Pul1oM983iEe/rBjGiIEDuAbk3kv681YVVg2jayftizXcziCSQfGzUi/PG
	 7I5NmMrY7/ka068ijKKO12SQjA+QXCD26h+S1WQs8SdYfRxODQkUxXXXstsCSCvWPQ
	 nmReoN581zHZhhVuz+QqLkQFpLhauApM0dgP1a+jtaqAxKDVWM+uinRUJGZNYZA5QS
	 RfZ9V32cvDOF9iGOG04kSXG8mqs2vdzszZj0inei71lxvsZaJqeQcXpJCTLowqVUr1
	 OSKZB2dyelLhEcKing8wzbwa2toG7T2N6m0rceEE6Hn5J/o7aNkSzOkP6Q6FarHSuE
	 hBVAM9Hv0d30w==
Date: Sun, 4 May 2025 15:42:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <aardelean@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606: fix raw read for 18-bit chips
Message-ID: <20250504154231.5a50c97b@jic23-huawei>
In-Reply-To: <20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-v1-1-06caa92d8f11@baylibre.com>
References: <20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-v1-1-06caa92d8f11@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 May 2025 10:04:30 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix 18-bit raw read for 18-bit chips by applying a mask to the value
> we receive from the SPI controller.
> 
> SPI controllers either return 1, 2 or 4 bytes per word depending on the
> bits_per_word. For 16-bit chips, there was no problem since they raw
> data fit exactly in the 2 bytes received from the SPI controller. But
> now that we have 18-bit chips and we are using bits_per_word = 18, we
> cannot assume that the extra bits in the 32-bit word are always zero.
> In fact, with the AXI SPI Engine controller, these bits are not always
> zero which caused the raw values to read 10s of 1000s of volts instead
> of the correct value. Therefore, we need to mask the value we receive
> from the SPI controller to ensure that only the 18 bits of real data
> are used.
> 
> Fixes: f3838e934dff ("iio: adc: ad7606: add support for AD7606C-{16,18} parts")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Jonathan, I based this on the fixes-togreg branch since I assume it will
> go that route, but beware that there is a trivial merge conflict with
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=3b5b55ca940733b7b533fe3137a307ceacb4fb90
> as that patch modifies an adjacent line.
Applied to the fixes-togreg branch of iio.git. Let's see if this causes
much trouble in next. Given it's just adjacent lines hopefully won't be a
problem.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 703556eb7257ea0647135c4b268a8ead93115c6f..8ed65a35b4862315431a4852453639b4e056178e 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -727,17 +727,16 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
>  		goto error_ret;
>  
>  	chan = &indio_dev->channels[ch + 1];
> -	if (chan->scan_type.sign == 'u') {
> -		if (realbits > 16)
> -			*val = st->data.buf32[ch];
> -		else
> -			*val = st->data.buf16[ch];
> -	} else {
> -		if (realbits > 16)
> -			*val = sign_extend32(st->data.buf32[ch], realbits - 1);
> -		else
> -			*val = sign_extend32(st->data.buf16[ch], realbits - 1);
> -	}
> +
> +	if (realbits > 16)
> +		*val = st->data.buf32[ch];
> +	else
> +		*val = st->data.buf16[ch];
> +
> +	*val &= GENMASK(realbits - 1, 0);
> +
> +	if (chan->scan_type.sign == 's')
> +		*val = sign_extend32(*val, realbits - 1);
>  
>  error_ret:
>  	if (!st->gpio_convst) {
> 
> ---
> base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef
> change-id: 20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-ed035c488eca
> 
> Best regards,


