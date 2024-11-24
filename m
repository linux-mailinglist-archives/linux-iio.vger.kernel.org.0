Return-Path: <linux-iio+bounces-12609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8079D7789
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A10282592
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F128B13C918;
	Sun, 24 Nov 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTCx9tP4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3CD2500C3;
	Sun, 24 Nov 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732474702; cv=none; b=le6m1x8zjKmM1yp+aqo9bEQ5yNexCTmthUZF0cIJmVhG10mhEdbqujAzOm/832rAOfrObMiUoIEyVQZVtpNY3/3K3xVmTwQxoXZL1M1fljHKl0dPC3dCxWHPzXlfrFby1x0HsEXwKUkaiTlOAoph8JjYuiU/ilFUmWMqc+ZKdZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732474702; c=relaxed/simple;
	bh=EReRqPnaarxfCp3xRMb80SHm6sQAbVAsHfXhvODNuk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntAd15N9+rT4H1Oj9g7C31AyL20Zu3fwUE8SPbjW7lbFdE0eKsSVKhg+v7yPz+GEQuAEmlwFmVsLRaklDMKQpbJjCo/mtSH9bN9yRraeH5AHfO/JDFKFm3NvmTOHEN0jihlUiNvRev+fJs0Tw0h2L4EP1+nhf1kPA8Ro6u4FUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTCx9tP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1240C4CECC;
	Sun, 24 Nov 2024 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732474702;
	bh=EReRqPnaarxfCp3xRMb80SHm6sQAbVAsHfXhvODNuk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cTCx9tP4S7AMnXb4AfCjHnmyi/8ms52+MQV5BjI8NISuZ+yF3FkSdS5Vl8kyGkU35
	 jYtiKkvxHCZgyUTptXpahJEQZ08ISS8JMDJkPjzE55kvlSZ3hg71dFCgFuqbyQwVi3
	 qil+HN/DLnyw3Xina7Bz6cFjnwQ+aBAfw8T8MQKyInwF2k28QaCg/z8EYrEFVNeNqD
	 TjXvXjiwbQB8bRCwYn3gbNxRpPaqTpiO/wBolILhj6okPdxT1w8aLjpMtFSDVK2Nan
	 lDJfHhtbRymi7nE0xGu+zr+88OjtKx0pqbJHQyo/3tC3oTHBdWlRB3dWY7/9Qy9+S8
	 4MWRBTe31sHYQ==
Date: Sun, 24 Nov 2024 18:58:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 17/22] iio: accel: adxl345: push FIFO data to iio
Message-ID: <20241124185815.7e9c6fad@jic23-huawei>
In-Reply-To: <20241117182651.115056-18-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-18-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:46 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add FIFO and hwfifo handling. Add some functions to deal with FIFO
> entries and configuration. This feature will be needed for e.g.
> watermark setting.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 38 ++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index d58e1994ff..a653774db8 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -437,6 +437,41 @@ static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
>  	return 0;
>  }
>  
> +static int adxl345_push_fifo_data(struct iio_dev *indio_dev,
> +				  u8 status,
> +				  int fifo_entries)
> +{
> +	struct adxl34x_state *st = iio_priv(indio_dev);
> +	int ndirs = 3; /* 3 directions */
It's const. Maybe a define is appropriate instead?
> +	int i, ret;
> +
> +	if (fifo_entries <= 0)
> +		return true;
It returns an int. Also how did you get in here with negative fifo
entries?  That rather suggests something went wrong at the caller.

> +
> +	ret = adxl345_read_fifo_elements(st, fifo_entries);
> +	if (ret)
> +		return false;
> +
> +	for (i = 0; i < ndirs * fifo_entries; i += ndirs) {
> +		/* To ensure that the FIFO has completely popped, there must be at least 5
Comment format.

> +		 * us between the end of reading the data registers, signified by the
> +		 * transition to register 0x38 from 0x37 or the CS pin going high, and the
> +		 * start of new reads of the FIFO or reading the FIFO_STATUS register. For
> +		 * SPI operation at 1.5 MHz or lower, the register addressing portion of the
> +		 * transmission is sufficient delay to ensure the FIFO has completely
> +		 * popped. It is necessary for SPI operation greater than 1.5 MHz to
> +		 * de-assert the CS pin to ensure a total of 5 us, which is at most 3.4 us
> +		 * at 5 MHz operation.
> +		 */
> +		if (st->fifo_delay && (fifo_entries > 1))
> +			udelay(3);
> +
> +		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> +	}
> +
> +	return true;
> +}
> +



