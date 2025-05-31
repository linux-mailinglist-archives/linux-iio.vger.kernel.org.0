Return-Path: <linux-iio+bounces-20079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC3AC9BCF
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361BC7AB8A2
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E225918EFD4;
	Sat, 31 May 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+ygO6e4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1014A0A8;
	Sat, 31 May 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748710390; cv=none; b=QVdTOSYvfIb62rpcyXK4MV0wH85fpmgqE2vJo5zUnXSLurgE43zaJ6btj5fLVL7trLR4nx/BANUbKMwffisDG6BSvyPQn5b/5739Z1d5AI3X/6tKoqTpMSsdvr0F5Zd2ltfcRnOvfuCjowob/UB23CuMu6EjHt+xN6VIMX8q7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748710390; c=relaxed/simple;
	bh=ki2fiF5byquHZpQLnvRzyCUzg28bY60LyC64A4xgFis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyFs97czN2jr03vJdRg4A388Lysm0OKTt7uhnetXScI04mDQF1yCCbucrjBifq5WLWYzlhvpR39mXyhUUMily3UqOosdJlaU3QTm23mQf/qgYFduIWvND7na+AEDTttLwHcvD5uOcaH3F3AfRz5Azek4SHWrbdQbS0ua6z6Fkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+ygO6e4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8399C4CEEF;
	Sat, 31 May 2025 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748710390;
	bh=ki2fiF5byquHZpQLnvRzyCUzg28bY60LyC64A4xgFis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I+ygO6e4pt7WlsySCqfKWdadJCI7zFjT5gt5SuuT6sfllHDtZFadQlvrkLcnjM6+f
	 o3tPpbp5i7CG7k1rs/BQlMYhfI/fngWWCNy5BDM7lnzZRz9gdqIhpONnqurqfyd5WN
	 a6kWhONV4Ys0E7G4eyytnNyWle5188imJI7JVsxnMx7A6LzoxaL8CoCIPis+D+XSX7
	 1g4+fof/T1VhZwvKvQ7dl5DNfcYVnrbxzLxnYJ8dkUCpbcl6IgmiofrbKhTSd0uY12
	 9E4grHFbTNGKYhinirLwMqQJMbPQnZHHItstwSqn+juRzlm01ZR11y9B1wbYYOS6wk
	 dhrmQxQ60/Pew==
Date: Sat, 31 May 2025 17:53:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: Fix use after free in
 fxls8962af_fifo_flush
Message-ID: <20250531175302.05b2da17@jic23-huawei>
In-Reply-To: <20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com>
References: <20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 May 2025 12:34:09 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> fxls8962af_fifo_flush() uses indio_dev->active_scan_mask (with
> iio_for_each_active_channel()) without making sure the indio_dev
> stays in buffer mode.
> There is a race if indio_dev exits buffer mode in the middle of the
> interrupt that flushes the fifo. Fix this by calling
> iio_device_claim_buffer_mode() to ensure indio_dev can't exit buffer
> mode during the flush.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
> [...]
> _find_first_bit_le from fxls8962af_fifo_flush+0x17c/0x290
> fxls8962af_fifo_flush from fxls8962af_interrupt+0x80/0x178
> fxls8962af_interrupt from irq_thread_fn+0x1c/0x7c
> irq_thread_fn from irq_thread+0x110/0x1f4
> irq_thread from kthread+0xe0/0xfc
> kthread from ret_from_fork+0x14/0x2c
> 
> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

That's nasty and a case I'd never thought about.  Most of the
races around disabling end up with an extra sample or two which then gets
dropped because there are no buffers enabled. 

We need to consider the active scan mask as part of the buffer state.
So effectively taking mlock if we enter this code will delay the state
transition (and change of active_scan_mask until after this interrupt is done).

If David's synchronize_irq() is enough maybe that's a lighter weight path?

Jonathan



> ---
>  drivers/iio/accel/fxls8962af-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 6d23da3e7aa22c61f2d9348bb91d70cc5719a732..7db83ebeea823173d79bf8ff484add16f575edfc 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -973,6 +973,9 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> +	if (iio_device_claim_buffer_mode(indio_dev) < 0)
> +		return 0;
> +
>  	/* Demux hw FIFO into kfifo. */
>  	for (i = 0; i < count; i++) {
>  		int j, bit;
> @@ -989,6 +992,8 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
>  		tstamp += sample_period;
>  	}
>  
> +	iio_device_release_buffer_mode(indio_dev);
> +
>  	return count;
>  }
>  
> 
> ---
> base-commit: 5c3fcb36c92443a9a037683626a2e43d8825f783
> change-id: 20250524-fxlsrace-f4d20e29fb29
> 
> Best regards,


