Return-Path: <linux-iio+bounces-21944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF158B10849
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDB11CE251A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496126A1D8;
	Thu, 24 Jul 2025 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrQfJWDG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31385266B59;
	Thu, 24 Jul 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354682; cv=none; b=jm09LFp11+abNStMCbtsSLInOYtqOd7LUsXsy9++4riwLG2ZV5/257Dibp9upP0QuoHkOcIF6nRtyPhKM6HTcxVKgDU1pLM9pLwKFhX8LfOumcMnJkuO04URQXH3kqNo5poBiwGGaK65iZYXbfWUv3vE/vGhiStq4RIYNd5tY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354682; c=relaxed/simple;
	bh=eyb17T22/TaRAcXNYH9l0wQD4z9L5inSOuklgAZjK+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miWvLxx7AJz/vaS52jZEGOjnU2s25TGNb5XGRK1r81Zde680YT/e6d805tFeAwYxJ+EWM5SniuWOqsK8LbJPdZA7JCvXilHid19pe4PbBOj/gkVyPCmWb/JJRm/anEB/3thDJuxLWGArDV2hC9CEALLTweMDGBJwCDiIMZGQ3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrQfJWDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BFEC4CEED;
	Thu, 24 Jul 2025 10:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753354681;
	bh=eyb17T22/TaRAcXNYH9l0wQD4z9L5inSOuklgAZjK+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PrQfJWDGCeoCzn0syYnArvj85+EnPkOhQkgLUzcxfVFn18vGbFYKZvzliloRWL6AC
	 MWVc4K0nanNw55zvqdNcKyfu2lyfTia5sXQba8IVYX1N9fsvZritEdYaRfwwWSmhEW
	 ceBOTmW5Pvttq8+xEYQPW4lpjOvrEORq23oX/Ox+iB6tdTNnCgLR40MLHIotLXJGSf
	 eaFCda0Lboth2drF15lDlAKrdB7pwLZu5P41lvPTaHIRqUjIsXJiP8NQEyIxPVTojJ
	 ARde9wPSsv4xdvVcUls+U6uU88p1Mb6Be4Pz2QHn3s+jK4h6f0+DiqQZ+rY2FiGtLI
	 3kUC5trAuMQOQ==
Date: Thu, 24 Jul 2025 11:57:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: fix iio_push_to_buffers_with_ts() typo
Message-ID: <20250724115755.5affb98e@jic23-huawei>
In-Reply-To: <20250722-iio-fix-iio_push_to_buffer_with_ts-typo-v1-1-6ac9efb856d3@baylibre.com>
References: <20250722-iio-fix-iio_push_to_buffer_with_ts-typo-v1-1-6ac9efb856d3@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 16:52:38 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Replace iio_push_to_buffer_with_ts() with iio_push_to_buffers_with_ts()
> in some documentation comments in iio.h. The latter is the correct name
> of the function, the former doesn't exist.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
oops.

Applied to the testing branch of iio.git.

Thanks,

J
> ---
>  include/linux/iio/iio.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index d11668f14a3e17654fcf17a4e853d4b493205019..2f5560646ee49052deaaaae1dd2b92b21c4d4fd5 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -779,7 +779,7 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
>   * them safe for use with non-coherent DMA.
>   *
>   * A number of drivers also use this on buffers that include a 64-bit timestamp
> - * that is used with iio_push_to_buffer_with_ts(). Therefore, in the case where
> + * that is used with iio_push_to_buffers_with_ts(). Therefore, in the case where
>   * DMA alignment is not sufficient for proper timestamp alignment, we align to
>   * 8 bytes instead.
>   */
> @@ -794,7 +794,7 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
>   * @name: identifier name of the buffer
>   * @count: number of elements in the buffer
>   *
> - * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts(). In
> + * Declares a buffer that is safe to use with iio_push_to_buffers_with_ts(). In
>   * addition to allocating enough space for @count elements of @type, it also
>   * allocates space for a s64 timestamp at the end of the buffer and ensures
>   * proper alignment of the timestamp.
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250722-iio-fix-iio_push_to_buffer_with_ts-typo-7bf33a1aa365
> 
> Best regards,


