Return-Path: <linux-iio+bounces-12851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833509DF0A6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 15:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0AE281952
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AC01990C9;
	Sat, 30 Nov 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8QTCN1j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F3F4F1;
	Sat, 30 Nov 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975384; cv=none; b=PNeTeAChJJMbkWz0pnSE6KlBhZCmGZizfySMFMZaiIZCexHUxEHOWP1YCuLbtqjzkyIf9hUH9wK5RRwc//F9GdS93gBuW00XmBH4A3LykI6MOJBh490gdE2SuxJd3G3CiW2wJ/1NM4EE2BUBqFkCraKhFUlKO1n/BnzVdHnAtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975384; c=relaxed/simple;
	bh=Yj9FSiYKNG7jv65r64ZdEmQWTYcqowA7IMHEkeWLHQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meNKvaTNE6hGWGMck24Bc3HlW284AzeswX5HQhbOEFKh0aySJWEX7lS372dRZoR3yMpDo6RVDW3gqJ4TMfyGmN/1cuVYtwt7f8g7Gi3BMbpIxQsbYmYBYm7fHmNbIspfGXhhQyEHPvIWILqIn0NrSNOEA7R92hKA4+ZFzAwQSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8QTCN1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1442EC4CECC;
	Sat, 30 Nov 2024 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732975384;
	bh=Yj9FSiYKNG7jv65r64ZdEmQWTYcqowA7IMHEkeWLHQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s8QTCN1jsfUoFb1mIvxD5PPmwc1hnx2TtbesegIRGG9y7tLQyib7lV4STcbbuDPuW
	 VP9aNVybu9DGh4yCuIOBXlgfkAC6UqL5U5f/0cLKO7rAOyGlPBYeZXDuVVW9g0ixw/
	 o0lJK6dEPnBaquv62Zh64vi8XiR+4AwUAIGDte0XpRCqDGw9Kr9PqqS4Dt6DtHd/9s
	 GM3snmzJ0o8/EcbNzCsmflnV9aSZh2WkyR27GUdZT15L0NuY62IEX1K61V7EeSuZF1
	 hQaHZwnOeo7lO6PO8csP/dr0ue7TSdEdfDNuR/2mrvkuhxalkzP8MbzdhQUBf/a+rY
	 0dcSEsqO09vbQ==
Date: Sat, 30 Nov 2024 14:02:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
 jstephan@baylibre.com, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jack Andersen <jackoalan@gmail.com>
Subject: Re: [PATCH RFC 3/6] iio: adc: dln2-adc: make use of
 iio_is_soft_ts_enabled()
Message-ID: <20241130140255.70b4b68b@jic23-huawei>
In-Reply-To: <20241130002710.18615-4-vassilisamir@gmail.com>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
	<20241130002710.18615-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 01:27:07 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Use the iio_is_soft_ts_enabled() accessor to access the value of the
> scan_timestamp. This way, it can be marked as __private when there
> are no direct accessors of it.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

The original code looks to me like a micro optimization that we should
consider dropping to reduce complexity.  It is only used to zero a hole
in a structure conditionally if the timestamp is enabled.

Better I think to just drop all the ts_pad_offset etc stuff in favour of
just zeroing the whole of the data structure in dln2_adc_trigger_h()
whether or not the timestamp is enabled.

My guess is that on a reasonably performance CPU the occasional cost
of a branch miss prediction will outweigh zeroing a fairly small structure
anyway.

+CC Jack who wrote this driver.

Jonathan


> ---
>  drivers/iio/adc/dln2-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index 30328626d9be..f9cf132c41e6 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -128,7 +128,7 @@ static void dln2_adc_update_demux(struct dln2_adc *dln2)
>  		in_loc += 2;
>  	}
>  
> -	if (indio_dev->scan_timestamp) {
> +	if (iio_is_soft_ts_enabled(indio_dev)) {
>  		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
>  
>  		dln2->ts_pad_offset = out_loc;


