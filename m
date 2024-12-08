Return-Path: <linux-iio+bounces-13225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFBE9E8640
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72B51883F66
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008A15990C;
	Sun,  8 Dec 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmbMQiRH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BF13BAD5;
	Sun,  8 Dec 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733674653; cv=none; b=nel6sM2ye5EQQ39jQQbIDBhWdNArRelOTUx/i4HFQbT0uf+rzGCXLa45u1FDeuomv38cQ/+F0uZ/2gNt9rKxy3TKvQkMSwtQVBZxquxUsm1fbuR9YV4/Bm9Js2DEQ6KXvpqIXKtu4HfNgpb3jptE2CiRZKvmMoWtJEUO6tnNLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733674653; c=relaxed/simple;
	bh=LOpYr6lMGJbkcYojE1hLHvPZTgOFDcqON7cr8z/zmrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peZoA6xRClTAmZyMmkH1ycF6PHIY90OCfJWPn8w6B/4SCbJKKPY7tJR6YQFSIzFdxITSRDpH4RR74gvvTcRhHYpWrWkJ56Z7y8xhVw3MCnpa4qd9oAJ55QgNmJYTEa26sA0PSSv/C295NiZgdLU2qRcYCBjmfEGTDFhZAyaaLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmbMQiRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68956C4CED2;
	Sun,  8 Dec 2024 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733674652;
	bh=LOpYr6lMGJbkcYojE1hLHvPZTgOFDcqON7cr8z/zmrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JmbMQiRHuii/q+jMjUJ6+uPrsJ/QyoCsmvhRCzFnA5YtLOuHydMZITgycEVknUgHz
	 Jco/zz3PfXL3J4Coknz1TJte0bYGPbDRQa835YxhjqX3UT5Os1qnMnC4bpnUMbtj+y
	 J/E91J4rvsAl2ZbNmTPo05DLyFTb+j9/bSAQjJ2AF0EJxXLLa5EpkEU3L/9MGx485X
	 n0hkbxA/rAUqCc3lH5M/QOIkbu/NSOdKyVQakU2euuog4Fg7OgCJ+Yioen/BHO9raq
	 IpzEqpig6MK7NRjlzURwBUt0gWF4jqDT5t8SIgNn1X+//Q/pR7Uwbi8G+2/lN0ffQg
	 rjTKjf9I3mSKw==
Date: Sun, 8 Dec 2024 16:17:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 09/10] iio: accel: adxl345: prepare channel for
 scan_index
Message-ID: <20241208161726.3407f938@jic23-huawei>
In-Reply-To: <20241205171343.308963-10-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:13:42 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add separate fields for register and index to the channel definition.
> The scan_index is set up with the kfifo in the follow up patches.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
I'd just squash this with the net patch. It's a trivial change and there
isn't anything specific to really highlight in this description.
Also, scan_index separate from the stuff about the format seems odd.

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 0696e908bdf..3067a70c54e 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -26,21 +26,26 @@ struct adxl345_state {
>  	u8 intio;
>  };
>  
> -#define ADXL345_CHANNEL(index, axis) {					\
> +#define ADXL345_CHANNEL(index, reg, axis) {					\
>  	.type = IIO_ACCEL,						\
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##axis,					\
> -	.address = index,						\
> +	.address = (reg),						\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
>  		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
> +	.scan_index = (index),				\
>  }
>  
> +enum adxl345_chans {
> +	chan_x, chan_y, chan_z,
> +};
> +
>  static const struct iio_chan_spec adxl345_channels[] = {
> -	ADXL345_CHANNEL(0, X),
> -	ADXL345_CHANNEL(1, Y),
> -	ADXL345_CHANNEL(2, Z),
> +	ADXL345_CHANNEL(0, chan_x, X),
> +	ADXL345_CHANNEL(1, chan_y, Y),
> +	ADXL345_CHANNEL(2, chan_z, Z),
>  };
>  
>  static int adxl345_read_raw(struct iio_dev *indio_dev,


