Return-Path: <linux-iio+bounces-3879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACDE890203
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 15:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61591F24009
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D95F84D31;
	Thu, 28 Mar 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwcGbyZx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF10FC11;
	Thu, 28 Mar 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636628; cv=none; b=iK1+Jkv9EGVek+Bbl2pYtnflY9P+RfRzy2sZ7uFNjvbUM5uIApEh2yG16XKvNYIY7ceqwdiIg1DXJS8+N+5BmL0h1F2RmvfBaVsyCoTwCzoWSH2kv3UmsnYsAIMYx7XO7ZvlZLf+2lXaFc9eLY2YK4HaJVnyFgHq4oup4muKyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636628; c=relaxed/simple;
	bh=5zoVivMz85j/bcpvjJ4VaqnSEkFXMxa/yb3WBm5WSYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwJIQ9VrueA0PPWa+X+FanSjj4MrlTZyJQ+twijQ5ub9MWZsSjU0w4OJUwQ+2Qtl8krelWbl2bkovUhgfa38dNDhMLpJVfFkJOPOt69TLA7pI/+O34juRAG2iM+N6yaHDL5zVjuFZeCB9od7q2ilr6aKpW004P7ftlOVNJ2LDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwcGbyZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57702C433F1;
	Thu, 28 Mar 2024 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636628;
	bh=5zoVivMz85j/bcpvjJ4VaqnSEkFXMxa/yb3WBm5WSYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QwcGbyZxuGgS7Wp0lja1CwfgNgBeUhjei85a900IkaKZjDyDXvkZeBafSbRfO6nsk
	 HfG3W0yWw7WscIXFxWUQ+g61LDCZ/xVqH/cdy0ys7mcBKARbS+bJml/GFdGNwEhiW5
	 F6nMV+cpfvlqMOOVkhyRFpdhxSNrAXyJE6++cYncOoUc+NPkIRRDCoWb5e8Kt8B/b9
	 CV4MJd5qlWMGrXYcNhQuBVspoBT3unhyA8mhEdk6XMaGlB1M93zY2pMqcbxR4+snb6
	 frywkMOYMzs1zoE/kd7FYRpOPXAz0Xj4wEXiLOiMbkYLlzos1Hi0MWMjIr98VFjFMR
	 s145ZqrFOKBnA==
Date: Thu, 28 Mar 2024 14:36:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 01/10] iio: buffer: add helper for setting direction
Message-ID: <20240328143652.068492d0@jic23-huawei>
In-Reply-To: <20240328-iio-backend-axi-dac-v1-1-afc808b3fde3@analog.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	<20240328-iio-backend-axi-dac-v1-1-afc808b3fde3@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 14:22:25 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Simple helper for setting the buffer direction when it's allocated using
> iio_dmaengine_buffer_alloc().
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
I wonder if we should align with the approach for triggered-buffers with and _ext
form of the registration function that takes a direction.  It seems odd to allocate
one then change the direction.

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 7 +++++++
>  include/linux/iio/buffer.h        | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 1d950a3e153b..4b1ca6ad86ee 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1956,6 +1956,13 @@ void iio_buffer_put(struct iio_buffer *buffer)
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_put);
>  
> +void iio_buffer_set_dir(struct iio_buffer *buffer,
> +			enum iio_buffer_direction dir)
> +{
> +	buffer->direction = dir;
> +}
> +EXPORT_SYMBOL_GPL(iio_buffer_set_dir);
> +
>  /**
>   * iio_device_attach_buffer - Attach a buffer to a IIO device
>   * @indio_dev: The device the buffer should be attached to
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 418b1307d3f2..7e70bb5adc01 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -55,4 +55,7 @@ bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>  int iio_device_attach_buffer(struct iio_dev *indio_dev,
>  			     struct iio_buffer *buffer);
>  
> +void iio_buffer_set_dir(struct iio_buffer *buffer,
> +			enum iio_buffer_direction dir);
> +
>  #endif /* _IIO_BUFFER_GENERIC_H_ */
> 


