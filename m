Return-Path: <linux-iio+bounces-12601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524A9D777F
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B4AB2399E
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9B8127E18;
	Sun, 24 Nov 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhdXzYTe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9A2500BD;
	Sun, 24 Nov 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732472530; cv=none; b=fzMq8ku9wwbmeNjuD6xBe1jeoci795ygB6Jm0Jr7fWEswd35JTLjmfUIFeRyJ/3gSns+0+Vrdgz+Cj6PJOS46boD78NC3Bh9S3WiXVqyfURZsdRLgAY7k3AUsvIlvJ68tEkeNqrfzI9H+22H7t+mTKhcXEQolrErGI1kahRsu6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732472530; c=relaxed/simple;
	bh=RPvOw357BKcstkrazraC2MqzvydeGkaWCEENraR6VDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Isa1VADP721sJ/phc4yIeNgAjeO1a91piw+kJ97ivjrMeuoDTB3EZJ6kfscUy6qsXfB0FrUWM4ZHVh8qIfI5ZLkyLn30+OpCLTC4jTwuAGYozl3ugHAj8a5l+piBzlUzTTm6bkGfyOCN3osOO5MKlLEu88jemDicfK1H6yFSHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhdXzYTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AF2C4CECC;
	Sun, 24 Nov 2024 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732472529;
	bh=RPvOw357BKcstkrazraC2MqzvydeGkaWCEENraR6VDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhdXzYTewY7Zup0kapE8lE1wt3ozx/+qYudPOvLB9E7kcgIENttsafIySj9PNfh1y
	 sLT3lvTQyAoamzksSX+jmsyeAPEZzNlTn118w7MCDjqUIn0EzFnUcpf3IJrSRXIVT8
	 MHqMph4Y3rV4iX6I1473KJ/hhuUwpqdyl0yqS91h9kj0Ys+RKSBHPnrH0Bptsn8021
	 A3Wefx7o+su9slhAZ81qhXX5YzfPqVgP9LliZEaMp6kH4u9JFT93dOlOC/qer47xAh
	 UIJh93Ak1vcYM5IyL+2StgU7MAlel/H8fKlflLbV9vAZ11KzAV85veYsWpOj9pcMMX
	 vqvOZjJgu0Qhw==
Date: Sun, 24 Nov 2024 18:22:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 09/22] iio: accel: adxl345: unexpose private defines
Message-ID: <20241124182205.42a9a378@jic23-huawei>
In-Reply-To: <20241117182651.115056-10-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:38 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> For the implementation of features like FIFO-usage, watermark, single
> tap, double tap, freefall, etc. most of the constants do not need to be
> exposed in the header file, but are rather of private nature. Reduce
> namespace pollution by moving them to the core source file.
Whilst I get where you are coming from with this, breaking up
where these are between some in the header and some in the main code
tends to hurt readability and ease of checking the definitions.

So I would prefer these remain in the header.

Jonathan

> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 51b229cc44..c8d9e1f9e0 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -18,6 +18,114 @@
>  
>  #include "adxl345.h"

> +/* POWER_CTL bits */
Drop all the extra comments unless they add something not obvious
for the naming.
> +#define ADXL345_POWER_CTL_STANDBY	0x00
> +
> +/* NB:
> + * BIT(0), BIT(1) for explicit wakeup (not implemented)
> + * BIT(2) for explicit sleep (not implemented)
Define them and don't use them and the comment isn't needed.

> + */
> +#define ADXL345_POWER_CTL_MEASURE	BIT(3)
> +#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
> +#define ADXL345_POWER_CTL_LINK	BIT(5)
> +
> +/* DATA_FORMAT bits */

The naming of the defines makes that clear. So the comment doesn't
add much.

> +#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
> +#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* 1: left-justified (MSB) mode, 0: right-just'd */
If the comment is needed move it to the line above.
better yet, use a name that means the comment isn't needed.
ADXL345_DATA_FORMAT_LEFT_JUSTIFY
for example where a value of 0 means left and 1 doesn't (hence right)

You are just moving it though, so perhaps not worth improving.

> +#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
> +/* NB: BIT(6): 3-wire SPI mode (defined in header) */
This is the sort of comment that indicates the problem with splitting
things between header and here. I'd prefer to just keep it all in the header.

> +
> +#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
> +#define ADXL345_DATA_FORMAT_2G		0
> +#define ADXL345_DATA_FORMAT_4G		1
> +#define ADXL345_DATA_FORMAT_8G		2
> +#define ADXL345_DATA_FORMAT_16G		3
> +
> +#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
> +
> +/* The ADXL345 include a 32 sample FIFO
Comment syntax 
/*
 * The ADXL345 includes a 32 sample FIFO.
> + *
> + * FIFO stores a maximum of 32 entries, which equates to a maximum of 33
> + * entries available at any given time because an additional entry is available
> + * at the output filter of the device.
> + * (see datasheet FIFO_STATUS description on "Entries Bits")
> + */
> +#define ADXL34x_FIFO_SIZE  33
> +
>  struct adxl34x_state {
>  	int irq;
>  	const struct adxl345_chip_info *info;


