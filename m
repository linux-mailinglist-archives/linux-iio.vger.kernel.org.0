Return-Path: <linux-iio+bounces-21109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB8AECEB2
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8715D3B60C4
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBD422E3E9;
	Sun, 29 Jun 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2ZJ+tjc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8231C36;
	Sun, 29 Jun 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751214961; cv=none; b=lhxbF1cLhwZkGSlKYSgFhncixJ1//KIqDpHa9AclYU7cGXgA8KD3lSfQou6dTD+Bd0vSGJCSOMJ5HRR4wnzdd2FnEkqHzJ4cnm7lMzD4Ji1ssXGEmziNHVMC2arrzsr8grVeiBguo/hKzDirA/Y6+dH0cKTQ8vT5G/WllusrfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751214961; c=relaxed/simple;
	bh=yuiNoRZPXASXl+J2XAzVXODy3ECX2mwtnUjpYxyP1Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BclNaS50d8Pmi47EuweBWE0U+ENFnq6hfSee/9xYmGbPGV/RRTE/Pu9HT0wVCLwCQQ4RNsuuORkevF/iXXNNVM10DMnQYxpS2zC03QpbBIIuNbGtrhv59Q5qk3iOMnQHn3zRUzzo5sJ0dis0iIm0l6zVwJFAWRlLzUJG0qXFmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2ZJ+tjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1ECC4CEEB;
	Sun, 29 Jun 2025 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751214961;
	bh=yuiNoRZPXASXl+J2XAzVXODy3ECX2mwtnUjpYxyP1Aw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h2ZJ+tjckH7iDSGtmusOd6vlDlokg8Dssq6bSeAZvEkE3O4fDjVB/mlQjG1r39+sC
	 3P3fPnqDNnoTL79wkGelor2J3XkmGC9UNtR5c2XFdAVRGaQaVeaaodDKsLVRYevBhr
	 J/0563LCAE2zI/SmLETr6l/jx6j3KEZQox007pHediaLaPYBjxtCLc9zSGdxyS6GS6
	 vj2UrCDefORaLl5hJXwlMaJ1ns8AiNs3ce4C4wsHXR5ee1j2eEzxWz2Zh1mzogSh5w
	 RRdzOy682HbKE2WbszFUizP+llp39QTMACtw92aXA2oLTvBFYis2LridPewjpUut4t
	 kXZYQpjXfmgAw==
Date: Sun, 29 Jun 2025 17:35:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH] iio: accel: adxl345: make adxl345_events const
Message-ID: <20250629173554.612245d0@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-1-v1-1-a32d96d01c2f@baylibre.com>
References: <20250628-iio-const-data-1-v1-1-a32d96d01c2f@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 10:56:20 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct iio_event_spec adxl345_events[]. This
> is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
+CC Lothar
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 45d71940c5ac3e042265615fe95238b9d29855e2..e21ec6c15d15e7342b12226dc8fcbb091324e353 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -143,7 +143,7 @@ struct adxl345_state {
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
>  };
>  
> -static struct iio_event_spec adxl345_events[] = {
> +static const struct iio_event_spec adxl345_events[] = {
>  	{
>  		/* single tap */
>  		.type = IIO_EV_TYPE_GESTURE,
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-1-b198d00f4d1b
> 
> Best regards,


