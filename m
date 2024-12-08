Return-Path: <linux-iio+bounces-13247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F98A9E873D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD8A18855F2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9859018871F;
	Sun,  8 Dec 2024 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAWt0Fwf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4114601C;
	Sun,  8 Dec 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733681802; cv=none; b=ErWiS/INMzYGhQ3GdISda9WPPcCktmJTmSZT+w2HrDVZJPx/OYVYjT15OZ7Pc+R2XvWz+49RDMAv0GY5sAnQ1XhTfOlh9choSuuvSgRIZ+peUjq5RFw5g/kUOcvXsCXm/D7m0hjXyYH95UmSYe6B1YFcMpEfkPXyBthMzldXNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733681802; c=relaxed/simple;
	bh=3uNlemnxmO95ezY4tZWtw2xZMpHUZ7K6BtR5y/IvEVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pi4XI+vhe3DVjXyMUiS9ym5MLHot+gumKh48+3HIjM7n352l4X0XjVgOY4iDL88vWQnJSlAXvzBPlCG/Qcd9kO1UBpCDX9x6OuOx6ihdyuDlZgORU6bUos2BL/cvllfq4xNTN61XLcR91CtN65Uqm9U0rKPNf3G+Rg4HhvLyXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAWt0Fwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1409C4CED2;
	Sun,  8 Dec 2024 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733681801;
	bh=3uNlemnxmO95ezY4tZWtw2xZMpHUZ7K6BtR5y/IvEVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PAWt0FwfVbq77yUwXhPYxNnFWr4pke1aX1ORuzCbyd393N89qksA8SgUxyBI9cE0K
	 ldFgXoP+UWj8zfMs6j9p6pZVKokBsamRSoqrGnlZsO5aUU3+P3E9uaU0k4oZdBpUOl
	 0o8YC8v4+TVV5D7NYGRWSgSmmDTdS9rr/iuUpDsk466nt9z3pc63vLp3ctyPU/qRj4
	 /z06JqWqzSy79iDavBihpC1jlxpTY7I3u3dFxvrgYKsDkVkP0SmyQnYoxDQGUe4T3c
	 saaQM5b5CaqD9l2Abcd+uOFRbYm0J4eENxKHS8tWR6ID7CMC8idUniE8jSYccjy7+N
	 DV3J4RiT1xaYA==
Date: Sun, 8 Dec 2024 18:16:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Peter Rosin <peda@axentia.se>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: consumers: ensure read buffers for labels and
 ext_info are page aligned
Message-ID: <20241208181633.120e2cba@jic23-huawei>
In-Reply-To: <20241202-iio-kmalloc-align-v1-1-aa9568c03937@gmail.com>
References: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
	<20241202-iio-kmalloc-align-v1-1-aa9568c03937@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Dec 2024 16:11:07 +0100
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Attributes of iio providers are exposed via sysfs. Typically, providers
> pass attribute values to the iio core, which handles formatting and
> printing to sysfs. However, some attributes, such as labels or extended
> info, are directly formatted and printed to sysfs by provider drivers
> using sysfs_emit() and sysfs_emit_at(). These helpers assume the read
> buffer, allocated by sysfs fop, is page-aligned. When these attributes
> are accessed by consumer drivers, the read buffer is allocated by the
> consumer and may not be page-aligned, leading to failures in the
> provider's callback that utilizes sysfs_emit*.
> 
> Add a check to ensure that read buffers for labels and external info
> attributes are page-aligned. Update the prototype documentation as well.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
This is good hardening independent of fixing any issues so I've picked this
patch up for the togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/inkern.c         | 11 +++++++++++
>  include/linux/iio/consumer.h |  4 ++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 7f325b3ed08fae6674245312cf8f57bb151006c0..63707ed98e1d7aca1e446122bbf69c85c0dd06a2 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -7,6 +7,7 @@
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/minmax.h>
> +#include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> @@ -989,6 +990,11 @@ ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
>  {
>  	const struct iio_chan_spec_ext_info *ext_info;
>  
> +	if (!buf || offset_in_page(buf)) {
> +		pr_err("iio: invalid ext_info read buffer\n");
> +		return -EINVAL;
> +	}
> +
>  	ext_info = iio_lookup_ext_info(chan, attr);
>  	if (!ext_info)
>  		return -EINVAL;
> @@ -1014,6 +1020,11 @@ EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
>  
>  ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
>  {
> +	if (!buf || offset_in_page(buf)) {
> +		pr_err("iio: invalid label read buffer\n");
> +		return -EINVAL;
> +	}
> +
>  	return do_iio_read_channel_label(chan->indio_dev, chan->channel, buf);
>  }
>  EXPORT_SYMBOL_GPL(iio_read_channel_label);
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 333d1d8ccb37f387fe531577ac5e0bfc7f752cec..6a44796164792b2dd930f8168b14de327a80a6f7 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -418,7 +418,7 @@ unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan);
>   * @chan:		The channel being queried.
>   * @attr:		The ext_info attribute to read.
>   * @buf:		Where to store the attribute value. Assumed to hold
> - *			at least PAGE_SIZE bytes.
> + *			at least PAGE_SIZE bytes and to be aligned at PAGE_SIZE.
>   *
>   * Returns the number of bytes written to buf (perhaps w/o zero termination;
>   * it need not even be a string), or an error code.
> @@ -445,7 +445,7 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
>   * iio_read_channel_label() - read label for a given channel
>   * @chan:		The channel being queried.
>   * @buf:		Where to store the attribute value. Assumed to hold
> - *			at least PAGE_SIZE bytes.
> + *			at least PAGE_SIZE bytes and to be aligned at PAGE_SIZE.
>   *
>   * Returns the number of bytes written to buf, or an error code.
>   */
> 


