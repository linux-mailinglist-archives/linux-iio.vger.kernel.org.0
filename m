Return-Path: <linux-iio+bounces-7971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E7093DF90
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF9E1F21B15
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E5E16EB44;
	Sat, 27 Jul 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB/Qg/Xu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF96F2E2;
	Sat, 27 Jul 2024 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722087793; cv=none; b=nA1uez6CMfWerO2+6OX7klOFfLIvcyrn6XZ3oz9wJsYwkslkMpUgMQzckFGqZHaRpB7dyPqSaWD6SVAtI5xf0fajxKbMMH2W+RT4OBFL3qRQSQfDl7kUpCAVK7P/Fvx5XCkEXiMkcWsXe0fk3kSmvW5/+jf0C40Ib7GIZYqbqU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722087793; c=relaxed/simple;
	bh=wFih39UP/lYrUW0VAwl6Cavvym7xv6T3EAxKzzMay2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iT+W17wsVgD1ZcjWhIDQ02MNlHS6aE66BkE/rTLW6FMPdbgyPK0PgOGjKxranG6W2hMjmrY1x995Wr1dUkq4444QW9yDjp3n3k3cdySEypAk3LW5cHGMM1DdreuN02x5ZZUHOpvx7Z+Jq6pqvftfnGx4Cav0efOjD3o3FqnoW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB/Qg/Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA8CC32781;
	Sat, 27 Jul 2024 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722087792;
	bh=wFih39UP/lYrUW0VAwl6Cavvym7xv6T3EAxKzzMay2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YB/Qg/XuKW/IusCtf09xpY4qQlWEWSfPxG3eqqPSEzpgfQQnJ+Y7zIWMwSaeb1Xx2
	 PDZKfcAPVE9wYGqcL95TlzlbnkwPY5H95eyj1PB+sEJEVsDMkX1/y1ddIvNwaoigO9
	 nBiuMbJmEUPlecuW93P4+MJCVl8OKLW+dlsjjVvqsONyFVWp+cuB7p52mCI9ja2ieu
	 rzehqztgR1wZEtSILwWzxvGASdQNuFlZ+qViU/+k98OEYYRLbeCzJ0bEgc5uUa51ps
	 N/RSMR1B4mbzBqJxICel/PmIMZhdhaiRNKaTJG0geOkTvk9MqK1glHBogu7SfY8aQD
	 xA6e7WumMzcpQ==
Date: Sat, 27 Jul 2024 14:43:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v3 7/9] iio: buffer-dmaengine: generalize requesting
 DMA channel
Message-ID: <20240727144303.4a8604cb@jic23-huawei>
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-7-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	<20240722-dlech-mainline-spi-engine-offload-2-v3-7-7420e45df69b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 16:57:14 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This patch generalizes the iio_dmaengine_buffer_setup_ext() functions
> by passing the pointer to the DMA channel as an argument rather than
> the channel name. This will allow future callers of the function to
> use other methods to get the DMA channel pointer.
> 
> This aims to keep it as easy to use as possible by stealing ownership
> of the dma_chan pointer from the caller. This way, dma_request_chan()
> can be called inline in the function call without any extra error
> handling.

That's odd enough to be a likely source of future bugs. Doesn't seem
necessary to me. Just have the extra handling in the few places it's needed.

Or add a wrapper for this case where you just provide the
channel name as was done before this patch.

> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> v3 changes:
> * This is a new patch in v3.


...

> @@ -277,22 +282,26 @@ static void __devm_iio_dmaengine_buffer_free(void *buffer)
>   * devm_iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO device
>   * @dev: Parent device for the buffer
>   * @indio_dev: IIO device to which to attach this buffer.
> - * @channel: DMA channel name, typically "rx".
> + * @chan: DMA channel.
>   * @dir: Direction of buffer (in or out)
>   *
>   * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc()
>   * and attaches it to an IIO device with iio_device_attach_buffer().
>   * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
>   * IIO device.
> + *
> + * This "steals" the @chan pointer, so the caller must not call
> + * dma_release_channel() on it. @chan is also checked for error, so callers
> + * can pass the result of dma_request_chan() directly.
>   */
>  int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
>  					struct iio_dev *indio_dev,
> -					const char *channel,
> +					struct dma_chan *chan,
>  					enum iio_buffer_direction dir)
>  {
>  	struct iio_buffer *buffer;
>  
> -	buffer = iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel, dir);
> +	buffer = iio_dmaengine_buffer_setup_ext(dev, indio_dev, chan, dir);
>  	if (IS_ERR(buffer))
>  		return PTR_ERR(buffer);
>  


