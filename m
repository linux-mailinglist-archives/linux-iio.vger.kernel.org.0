Return-Path: <linux-iio+bounces-21938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D6B107C4
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DA41CE306D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51B265CC8;
	Thu, 24 Jul 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaFjsDL3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D6265CA8;
	Thu, 24 Jul 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352795; cv=none; b=fG3KjU9KY3c5rLE7WPNul+lUFid0Pb/tsCJB7DXsJXYdJoyOEYQGRFYSkmsPGSB6P2PhmNOdwZBVWXUZKSGDDbnasdRh/CjDQ8a4FOvjrD+2U1nU9phbb/HQrMsZbA2g+65+SL4yn2hhTw6f3U4wp2gE9IS5TJMp/Kd0y4Hlzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352795; c=relaxed/simple;
	bh=LRBCAEGXv6b2SitvLniBUi4TIUWofOnD0awItm30X0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=px3+dfOZVR/ZOUtM2DJyEtlHwxHyDhGtwFhY+14eRGKE8/iJuZYlGehsxPrQ46sbirXiYiWXY9s/rmuo/VUAmYBGkQBoQ874bFKsbTkMuPjq+FjeFbYalvQbS+tKMr/CIJyiTFCHgToknD7qBJL00BILsEsGYdNba8Kf2i6eCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaFjsDL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53418C4CEF4;
	Thu, 24 Jul 2025 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753352794;
	bh=LRBCAEGXv6b2SitvLniBUi4TIUWofOnD0awItm30X0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MaFjsDL3jFUFFZPsz5DTWpV5wf4wVo13ruSZtvYQ6DIYhBiFO8uKV6bBNOIL8H4Iz
	 Kuz1Gx/EXh7v0hQ5INHv2Krr0SMaZwSiHchXmrwMRizH7Zz7EPU1LRYaxpX5f+eTnQ
	 ULb3KT69EBfq9mSF9qSKnTmjGB+RDcU7nZka2Vnuy0RXnYfnr3qxZShhlgsqemZkFN
	 pbLCnrB0zterkjKTYm74iyVtcA4lYnd+aNgExrI/2fI1B52ygFZYkUoFnNIp2ub5Dt
	 s7BbKcPVCsnCxjtd4m38fq94Fj2xLMQb+RdT8y3pAGviTrR4bGsJUjqHSHTWjKUlwf
	 pVzTA33wJpxkA==
Date: Thu, 24 Jul 2025 11:26:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: mb1232: use stack allocated scan struct
Message-ID: <20250724112628.565aac47@jic23-huawei>
In-Reply-To: <20250722-iio-proximity-mb1232-use-stack-allocated-scan-struct-v1-1-b4ef77e9ddea@baylibre.com>
References: <20250722-iio-proximity-mb1232-use-stack-allocated-scan-struct-v1-1-b4ef77e9ddea@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 17:39:17 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use a stack allocated struct for the scan data instead of using the
> driver state to store the struct. The scan data is not used outside of
> the interrupt handler function so the struct does not need to exist
> outside of that scope.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi David,

Applied to the testing branch of iio.git.

I don't suppose you fancy a follow up to take that irqnr local to probe?
If not I'll get to it at some point maybe.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/mb1232.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> index 01783486bc7df34ec3b38b1d0ad5f52e3eae6c92..34b49c54e68b0a11bac0287c65cb368c9e956da4 100644
> --- a/drivers/iio/proximity/mb1232.c
> +++ b/drivers/iio/proximity/mb1232.c
> @@ -42,11 +42,6 @@ struct mb1232_data {
>  	 */
>  	struct completion	ranging;
>  	int			irqnr;
> -	/* Ensure correct alignment of data to push to IIO buffer */
> -	struct {
> -		s16 distance;
> -		aligned_s64 ts;
> -	} scan;
>  };
>  
>  static irqreturn_t mb1232_handle_irq(int irq, void *dev_id)
> @@ -120,12 +115,16 @@ static irqreturn_t mb1232_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct mb1232_data *data = iio_priv(indio_dev);
> +	struct {
> +		s16 distance;
> +		aligned_s64 ts;
> +	} scan = { };
>  
> -	data->scan.distance = mb1232_read_distance(data);
> -	if (data->scan.distance < 0)
> +	scan.distance = mb1232_read_distance(data);
> +	if (scan.distance < 0)
>  		goto err;
>  
> -	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
>  				    pf->timestamp);
>  
>  err:
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250722-iio-proximity-mb1232-use-stack-allocated-scan-struct-e0f051595dfe
> 
> Best regards,


