Return-Path: <linux-iio+bounces-10765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1563A9A4D0E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD51284299
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE051DF973;
	Sat, 19 Oct 2024 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFn6w1eT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B899190688;
	Sat, 19 Oct 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336681; cv=none; b=ANRB1ikKT0tGVXqVZbfLRQwJcNWSpUf0Bqw4wAZ6hUhicYG9q9qM8V1abxvuueJRtn/Si9LxFZmom4p2Z3+HZWGU340AvDlbDeXez8Cm9BjaSFI06riR67z3pnB7mmr5AE8aH5ui0G3g16hLWQ4Au3k3aIrRheQ65ceqCiPT6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336681; c=relaxed/simple;
	bh=WbfyKPookjl1TAwpYeuHIUTKpRIg/fuWJNry8BqMnuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDNo2nQCWwYi+pRmTQpRvGc78RxNz1ntncZgQinCcvpbDixnp1ZNHqUufjEfkpoemgX2wQoe1cOLCCq1RrbZevBKSHNwpvfHUkVb9QuChwS5vmOZW1D+sXFr+iKphKpuQvnuKm7e3RaFu62SeUZDKVK+qQr0y1aRtdeC/rkNLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFn6w1eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE76C4CEC5;
	Sat, 19 Oct 2024 11:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729336680;
	bh=WbfyKPookjl1TAwpYeuHIUTKpRIg/fuWJNry8BqMnuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sFn6w1eTcO8iGGNV7tetsKwGwuEQDsEmDfwKmHtE7c51uc7yU/5pLT+Dh6iIHD1a6
	 irmwt8XnkeRLm51lBI876XKB3pE98+QbAngjFDRgGel5yc93MoIKv5M138wVrH8S95
	 6dCxAKB8uPcqMHQVe+hAhuKdgGKtUChvtcL0Ug6cZP0SyvOIk/CDZYh4+49cPbyKCe
	 RDdeRUiFzVJAr5VMnjWFZ3yhxd0X59qWMdnsu4ZIf3Zxs/5DeAgzliSRo3iu7Vy+/Y
	 bCgt93cJPlUMxequbuGtcFFhBcAQTyIYT0U/7BFcLc9DM6NjK4i2HkLPKTw3rh4jfv
	 YieHh8aSspXmg==
Date: Sat, 19 Oct 2024 12:17:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad8460: fix DT compatible
Message-ID: <20241019121755.366bc2ef@jic23-huawei>
In-Reply-To: <20241018-iio-adc-ad8460-fix-dt-compatible-v1-1-058231638527@baylibre.com>
References: <20241018-iio-adc-ad8460-fix-dt-compatible-v1-1-058231638527@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 16:24:01 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix the DT compatible string in the of_device_id table to match the
> binding documentation. There should not be a space after the comma.
> 
> Fixes: a976ef24c625 ("iio: dac: support the ad8460 Waveform DAC")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
oops. Applied to the togreg branch of iio.git and pushed out as testing.
I'll probably rebase that tree to bring in some fixes other series
are dependent on sometime in the next week or so.

Jonathan

> ---
>  drivers/iio/dac/ad8460.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
> index dc8c76ba573d..6706c8112094 100644
> --- a/drivers/iio/dac/ad8460.c
> +++ b/drivers/iio/dac/ad8460.c
> @@ -924,7 +924,7 @@ static int ad8460_probe(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id ad8460_of_match[] = {
> -	{ .compatible = "adi, ad8460" },
> +	{ .compatible = "adi,ad8460" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ad8460_of_match);
> 
> ---
> base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
> change-id: 20241018-iio-adc-ad8460-fix-dt-compatible-91f5099172e4
> 
> Best regards,


