Return-Path: <linux-iio+bounces-12608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C87AF9D77EC
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A8EB2387A
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE913B2B8;
	Sun, 24 Nov 2024 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hysluavZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD5B660;
	Sun, 24 Nov 2024 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732474571; cv=none; b=AribncSS6+8A7Hf1KgzqHVKsh4jXvSu5IncIQzxOGDaVd2n3CIkL7eX8cV2XnFhiAbGo0BrdUWpapMAou3al7pEYfl4oJ+R2hinYSapLVEdAYIR7ZNau2/8OXc6vpsM1mmJZ3nn9q3ztnhroU2W+uZvjhG6aR2lz62Kq0SuiL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732474571; c=relaxed/simple;
	bh=w07KLfPCx7uI9Y41dk6gTGNAzsBTKPGGWOxPzhYY+t4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORBKqXqhPDjXU3V6EvEBCzptPwnHX4jroJPhLFa460n56PrBqO+BEcPsUgNT3VInFSuuwYaYuCoVv3iS1zzZLo/gzbnKbpoPsqmEok/kGM3l3rF0RddV+Ua0I8PPnzCuhPAhE7Szmo6Ik/EeHdco0Izex3blIOFjMGTQiaa/1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hysluavZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F5BC4CECC;
	Sun, 24 Nov 2024 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732474570;
	bh=w07KLfPCx7uI9Y41dk6gTGNAzsBTKPGGWOxPzhYY+t4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hysluavZQZqgZTp8OBxa1U15v5M3gKVJWysstAxSkRVPMGCHgvt/0QYvWDsAEa4qf
	 o5Yu2uzrPDRPDNFSm6MwXwHcbfn5UJxWTOP5WWVaYj2V4W50hi/eEic+F7THG8Ii+E
	 ae6cHUYZS4H/CPdJlYs17Q4EyVq1oAbSYM6Wk8D6lmSgXz2PUB09N+OLWSt1Tz6+Fe
	 R+PS04WcK+VnQbUS97C+H+0QdMWw9786E+VA3IDcfyUzyzq2b64dHiw1LieAJ7jJNL
	 5xqMnjwlRWR2IgtHdnV8RQfmciy0jxJRI7Tz+O5FFTZl83HD+ZLlXaDju3x6ML/fL8
	 TUWhatYqzlZiA==
Date: Sun, 24 Nov 2024 18:56:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 16/22] iio: accel: adxl345: register trigger ops
Message-ID: <20241124185602.10cb3721@jic23-huawei>
In-Reply-To: <20241117182651.115056-17-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-17-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:45 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add trigger options to the sensor driver. Reacting to the sensor events
> communicated by IRQ, the FIFO handling and the trigger will be core
> events for further feature implementation.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 82bd5c2b78..d58e1994ff 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -15,6 +15,9 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> @@ -140,11 +143,13 @@ struct adxl34x_state {
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
>  	struct adxl34x_platform_data data;  /* watermark, fifo_mode, etc */
> +	struct iio_trigger *trig_dready;
>  
>  	__le16 fifo_buf[3 * ADXL34x_FIFO_SIZE] __aligned(IIO_DMA_MINALIGN);
>  	u8 int_map;
>  	bool fifo_delay; /* delay: delay is needed for SPI */
>  	u8 intio;
> +	bool watermark_en;
>  };
>  
>  #define ADXL34x_CHANNEL(index, reg, axis) {				\
> @@ -432,6 +437,35 @@ static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
>  	return 0;
>  }
>  
> +/* data ready trigger */

Data ready is a term used for a single sample being ready. 
Rename this as watermark.

However, as before I'd just get rid of the trigger entirely as it's not useful.
> +
> +static int adxl345_trig_dready(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct adxl34x_state *st = iio_priv(indio_dev);
> +
> +	st->int_map = 0x00;
> +	if (state) {
> +		/* Setting also ADXL345_INT_DATA_READY results in just a single
> +		 * generated interrupt, and no continuously re-generation. NB that the
> +		 * INT_DATA_READY as well as the INT_OVERRUN are managed automatically,
> +		 * setting their bits here is not needed.
> +		 */
> +		if (st->watermark_en)
> +			st->int_map |= ADXL345_INT_WATERMARK;
> +
> +		pr_debug("%s(): preparing st->int_map 0x%02X\n",
> +			 __func__, st->int_map);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops adxl34x_trig_dready_ops = {
> +	.validate_device = &iio_trigger_validate_own_device,
> +	.set_trigger_state = adxl345_trig_dready,
> +};
> +
>  /**
>   * irqreturn_t adxl345_trigger_handler() - Interrupt handler used for several
>   *                                         features of the ADXL345.


