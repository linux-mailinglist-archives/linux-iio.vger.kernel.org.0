Return-Path: <linux-iio+bounces-7969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B83B93DF82
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EF51C20C3D
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2B4155A26;
	Sat, 27 Jul 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoyCUnhp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70415572A;
	Sat, 27 Jul 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722086122; cv=none; b=RdYm7FrfRYxj6pKe1B6wYY5S32wQmhWIlBin7AJj1yrExZEStSACwbQepqil9YmKNNT72ZeDYCwCxUj0BSX5tUlsqc9faUoPloVkH2sORK4BjyUMafoHv9zGNfjvUBFywaYpseLjUKZa7TnyYVgvyy7t5Y3/HJrG/Ui5eWqFTUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722086122; c=relaxed/simple;
	bh=YY30Z5vupIFa3g6VTA98yRyyZaHpk/gD8ZHVbkeLOD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYBOCgu4cTg0fqPm3MoNoN1YHtrrZVKVGvLdSTZMpUMn3AoAUR9SBRqXfTLJoRqBQAA7XpbKMLSAN+HNic77BgzwBGZeMhw5xg6bsDCdrz9DRRyyZsCq/H/bQTz4InGenPEN3qqBzvkNlCRn5+AE8KIQ1KduS430pmftOEF89so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoyCUnhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816C8C32781;
	Sat, 27 Jul 2024 13:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722086122;
	bh=YY30Z5vupIFa3g6VTA98yRyyZaHpk/gD8ZHVbkeLOD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SoyCUnhp5X0eoUNsMozvitTkJbefCgH6pAy0lwrhibwoq75muwrrH3ThFio/FGSTo
	 xQiYVECt1v+7pXIzVguZZPUMqbx/f+OeNUHjOUMsg5xlOiswMJ0vS0C5OQMiFK6qSc
	 jjVzEeo4/EZji+L9n+oRgB2b27f0DhjgdFSCnOcein6Nq7qts46p15XFi6Cw3NynQs
	 6cF75Gni1MI+lAqh0zLSnPBdabEy+84Q90EABfoG/I1xCwJNKRRZ8cZn/onba3O1/s
	 7RwaXNHnAdgWTByNxd6wt3B5Ib8ZSK9R2NGk9tS2TB/If6ufFQNgJbeOjjJ7bZJ72E
	 bUkXbEjHDPKIw==
Date: Sat, 27 Jul 2024 14:15:12 +0100
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
Subject: Re: [PATCH RFC v3 2/9] spi: add basic support for SPI offloading
Message-ID: <20240727141512.6dfecc03@jic23-huawei>
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-2-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	<20240722-dlech-mainline-spi-engine-offload-2-v3-2-7420e45df69b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 16:57:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> SPI offloading is a feature that allows the SPI controller to perform
> transfers without any CPU intervention. This is useful, e.g. for
> high-speed data acquisition.
> 
> This patch adds the basic infrastructure to support SPI offloading. It
> introduces new callbacks that are to be implemented by controllers with
> offload capabilities.
> 
> On SPI device probe, the standard spi-offloads devicetree property is
> parsed and passed to the controller driver to reserve the resources
> requested by the peripheral via the map_channel() callback.
> 
> The peripheral driver can then use spi_offload_prepare() to load a SPI
> message into the offload hardware.
> 
> If the controller supports it, this message can then be passed to the
> SPI message queue as if it was a normal message. Future patches will
> will also implement a way to use a hardware trigger to start the message
> transfers rather than going through the message queue.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
A few trivial comments inline.

J

> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index d4da5464dbd0..d01b2e5c8c44 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2477,6 +2477,51 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  	of_spi_parse_dt_cs_delay(nc, &spi->cs_hold, "spi-cs-hold-delay-ns");
>  	of_spi_parse_dt_cs_delay(nc, &spi->cs_inactive, "spi-cs-inactive-delay-ns");
>  
> +	/* Offloads */

Might be good to factor this out as a little utility function.

> +	rc = of_count_phandle_with_args(nc, "spi-offloads", "#spi-offload-cells");
> +	if (rc > 0) {
> +		int num_offload = rc;
> +
> +		if (!ctlr->offload_ops) {
> +			dev_err(&ctlr->dev, "SPI controller doesn't support offloading\n");
> +			return -EINVAL;
> +		}
> +
> +		for (idx = 0; idx < num_offload; idx++) {
> +			struct of_phandle_args args;
> +			const char *offload_name = NULL;
> +
> +			rc = of_parse_phandle_with_args(nc, "spi-offloads",
> +							"#spi-offload-cells",
> +							idx, &args);
> +			if (rc) {
> +				dev_err(&spi->dev, "Failed to parse offload phandle %d: %d\n",
> +					idx, rc);
> +				return rc;
> +			}
> +
> +			if (args.np != ctlr->dev.of_node) {
> +				dev_err(&spi->dev, "Offload phandle %d is not for this SPI controller\n",
> +					idx);
> +				of_node_put(args.np);
> +				return -EINVAL;
> +			}
> +
> +			of_property_read_string_index(nc, "spi-offload-names",
> +						      idx, &offload_name);

Check for errors?  If not, perhaps a comment on why not.

> +
> +			rc = ctlr->offload_ops->map_channel(spi, offload_name,
> +							    args.args,
> +							    args.args_count);
> +			of_node_put(args.np);
> +			if (rc) {
> +				dev_err(&spi->dev, "Failed to map offload channel %d: %d\n",
> +					value, rc);
> +				return rc;
> +			}
> +		}
> +	}
> +
>  	return 0;
>  }

...

> +/**
> + * spi_offload_prepare - prepare offload hardware for a transfer
> + * @spi:	The spi device to use for the transfers.
> + * @id:		Function ID if SPI device uses more than one offload or NULL.
> + * @msg:	The SPI message to use for the offload operation.
> + *
> + * Requests an offload instance with the specified ID and programs it with the
> + * provided message.
> + *
> + * The message must not be pre-optimized (do not call spi_optimize_message() on
> + * the message).
> + *
> + * Calls must be balanced with spi_offload_unprepare().
> + *
> + * Return: 0 on success, else a negative error code.
> + */
> +int spi_offload_prepare(struct spi_device *spi, const char *id,
> +			struct spi_message *msg)
> +{
> +	struct spi_controller *ctlr = spi->controller;
> +	int ret;
> +
> +	if (!ctlr->offload_ops)
> +		return -EOPNOTSUPP;
> +
> +	msg->offload = true;
I'd set this later perhaps as...
> +
> +	ret = spi_optimize_message(spi, msg);
> +	if (ret)

It otherwise needs clearing here so it doesn't have side
effects if an error occurs.

> +		return ret;
> +
> +	mutex_lock(&ctlr->io_mutex);
> +	ret = ctlr->offload_ops->prepare(spi, id, msg);
> +	mutex_unlock(&ctlr->io_mutex);
> +
> +	if (ret) {
> +		spi_unoptimize_message(msg);
> +		msg->offload = false;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_offload_prepare);

...

> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index d7a16e0adf44..4998b48ea7fd 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -31,6 +31,7 @@ struct spi_transfer;

...

> @@ -1122,6 +1127,7 @@ struct spi_transfer {
>   * @pre_optimized: peripheral driver pre-optimized the message
>   * @optimized: the message is in the optimized state
>   * @prepared: spi_prepare_message was called for the this message
> + * @offload: message is to be used with offload hardware
>   * @status: zero for success, else negative errno
>   * @complete: called to report transaction completions
>   * @context: the argument to complete() when it's called
> @@ -1131,6 +1137,7 @@ struct spi_transfer {
>   * @queue: for use by whichever driver currently owns the message
>   * @state: for use by whichever driver currently owns the message
>   * @opt_state: for use by whichever driver currently owns the message
> + * @offload_state: for use by whichever driver currently owns the message
>   * @resources: for resource management when the SPI message is processed
>   *
>   * A @spi_message is used to execute an atomic sequence of data transfers,
> @@ -1159,6 +1166,8 @@ struct spi_message {
>  
>  	/* spi_prepare_message() was called for this message */
>  	bool			prepared;
> +	/* spi_offload_prepare() was called on this message */
> +	bool			offload;

offloaded? To match with prepared.
>  
>  	/*
>  	 * REVISIT: we might want a flag affecting the behavior of the
> @@ -1191,6 +1200,11 @@ struct spi_message {
>  	 * __spi_optimize_message() and __spi_unoptimize_message().
>  	 */
>  	void			*opt_state;
> +	/*
> +	 * Optional state for use by controller driver between calls to
> +	 * offload_ops->prepare() and offload_ops->unprepare().
> +	 */
> +	void			*offload_state;
>  
>  	/* List of spi_res resources when the SPI message is processed */
>  	struct list_head        resources;
> @@ -1556,6 +1570,49 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
>  
>  /*---------------------------------------------------------------------------*/
>  
> +/*
> + * Offloading support.
> + *
> + * Some SPI controllers support offloading of SPI transfers. Essentially,
> + * this allows the SPI controller to record SPI transfers and then play them
> + * back later in one go via a single trigger.
> + */
> +
> +/**
> + * struct spi_controller_offload_ops - callbacks for offload support
> + *
> + * Drivers for hardware with offload support need to implement all of these
> + * callbacks.
> + */
> +struct spi_controller_offload_ops {
> +	/**
> +	 * @map_channel: Required callback to reserve an offload instance for
> +	 * the given SPI device. If a SPI device requires more than one instance,
> +	 * then @id is used to differentiate between them. Channels must be
> +	 * unmapped in the struct spi_controller::cleanup() callback.

Probably a good idea to talk about possible return values as well.

> +	 */
> +	int (*map_channel)(struct spi_device *spi, const char *id,
> +			   const unsigned int *args, unsigned int num_args);

