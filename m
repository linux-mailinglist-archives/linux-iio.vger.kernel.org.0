Return-Path: <linux-iio+bounces-4124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2BA89AC01
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AFD1C20CBF
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0020D3CF58;
	Sat,  6 Apr 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKBl8Q5Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF60E2C1B9;
	Sat,  6 Apr 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712420647; cv=none; b=lgO0ryuDhxIeTzki1YCS2MQIAuhYxsBeZchJCKZcF/C+ud8kjqQOjdT34Y6aATm3t83K1B3kkTkUxhRXUmTR4pa9ozWBYDH3i0I3ydpHMCHZW1X+GQNK/D+7McB4tej3tpAMWIU+JaIAZYFF1h2k56tMg7XU5rVKqXjNalHjlz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712420647; c=relaxed/simple;
	bh=egBllPnHH+3tlWlRcA4IcWT/89vUzWQOAt22N+becyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpWFIFOohH9BWebVg8KzJ8YXUYqJwaV3OopaS7X3qb9UdQ2B81VvJ9hvhjDYclaWlwnyYUh+2usvaT9x9iyZsx5tBnLsq15S5P+3IPnkIhvWfJO7edvf/trsA4f/Olcl8UqA8sMUVY01+HIyjw0Qr18oFqhYMbYa8wwiIqYYuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKBl8Q5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4E6C433C7;
	Sat,  6 Apr 2024 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712420647;
	bh=egBllPnHH+3tlWlRcA4IcWT/89vUzWQOAt22N+becyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vKBl8Q5YTvEl97lXkiVZ6w3nXbr78W0JOUl7spdngxPP2XtCH18266YN+EZtjLN3r
	 TZOHUTLdCi3FzPyCPvhO3jToSPKVtapuqRePW5kwGNHxqt5YjI87sdhZ8T+dzuC21F
	 ZK/NT4xatfdqx9Mdive4pAy4pwkafXhBJW9mWyWqWI5z9Qpfn/2Gbo5Oi4PJr4J2Cv
	 Y62kEE0EF+E7ney94Z4pm2NG4o+G0pivDUrsjDM96kIn+/Icu5TDIWfezvytWZes4k
	 O3t0a/W4n7G1kCktVTO0SxuSY6XHyE/P6oe+HOFiPcQ6aMMBM8Rofaik1t+/uCdzM/
	 tG0pmpY2icttw==
Date: Sat, 6 Apr 2024 17:23:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Dragos Bogdan
 <dragos.bogdan@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Paul
 Cercueil <paul@crapouillou.net>, Alexandru Ardelean
 <ardeleanalex@gmail.com>
Subject: Re: [PATCH v2 03/11] iio: buffer-dma: Enable buffer write support
Message-ID: <20240406172352.6784c6e6@jic23-huawei>
In-Reply-To: <20240405-iio-backend-axi-dac-v2-3-293bab7d5552@analog.com>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
	<20240405-iio-backend-axi-dac-v2-3-293bab7d5552@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 17:00:01 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> From: Paul Cercueil <paul@crapouillou.net>
> 
> Adding write support to the buffer-dma code is easy - the write()
> function basically needs to do the exact same thing as the read()
> function: dequeue a block, read or write the data, enqueue the block
> when entirely processed.
> 
> Therefore, the iio_buffer_dma_read() and the new iio_buffer_dma_write()
> now both call a function iio_buffer_dma_io(), which will perform this
> task.
> 
> Note that we preemptively reset block->bytes_used to the buffer's size
> in iio_dma_buffer_request_update(), as in the future the
> iio_dma_buffer_enqueue() function won't reset it.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

One trivial comment on alignment that I noticed whilst reminding
myself of this patch. Otherwise looks good.


> +
> +/**
> + * iio_dma_buffer_read() - DMA buffer read callback
> + * @buffer: Buffer to read form
> + * @n: Number of bytes to read
> + * @user_buffer: Userspace buffer to copy the data to
> + *
> + * Should be used as the read callback for iio_buffer_access_ops
> + * struct for DMA buffers.
> + */
> +int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
> +	char __user *user_buffer)

Prefer aligning char with after the (

> +{
> +	return iio_dma_buffer_io(buffer, n, user_buffer, false);
> +}
>  EXPORT_SYMBOL_GPL(iio_dma_buffer_read);
>  
> +/**
> + * iio_dma_buffer_write() - DMA buffer write callback
> + * @buffer: Buffer to read form
> + * @n: Number of bytes to read
> + * @user_buffer: Userspace buffer to copy the data from
> + *
> + * Should be used as the write callback for iio_buffer_access_ops
> + * struct for DMA buffers.
> + */
> +int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
> +			 const char __user *user_buffer)
> +{
> +	return iio_dma_buffer_io(buffer, n,
> +				 (__force __user char *)user_buffer, true);
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_write);
> 


