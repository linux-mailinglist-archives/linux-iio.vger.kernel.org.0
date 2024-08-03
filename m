Return-Path: <linux-iio+bounces-8181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B949468FA
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0061F21A1E
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883E614D717;
	Sat,  3 Aug 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+gp9f04"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD0567A0D;
	Sat,  3 Aug 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722679097; cv=none; b=qjik4rWJMZrK+IWaqyDE47Vpmr45rIE6n4tS7YOsik5ehMU7VacV6wfflZjBpelvieayIXG/ZkENZJ0Dq7TkdgXKRw1oy2WEL/mVMj4MEZT3TfU6hnE4kuODb9ZvLetCsruelfBvtv0SewYIkIoaBfKBFaOA6l6x41Oncu/XbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722679097; c=relaxed/simple;
	bh=YtqrMf8aNUiFZOawhurcvYLojEsK3/to3ps38x3skNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FB7jqJf85rNYvor3u+ZGX0t9pEViOL10nwiIiks8CqhMPxnnFh+HS+Hm403J9/Jw/GzgndosLdGKXzYCLghvvNtGil+s2NKroRHo9ZWNEiqRwLWiD4L2XEKmG/Hv8kSyrHLJvBRlL36/VeRVFXAYk3CVIFsZCRR3Wngb3W7Ps0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+gp9f04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8296C116B1;
	Sat,  3 Aug 2024 09:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722679096;
	bh=YtqrMf8aNUiFZOawhurcvYLojEsK3/to3ps38x3skNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O+gp9f04vsDkvT68WjTeHMYN/sQ9s5MzoJrh1mJVlMSeeQ+1gpbJx+lzSVmrE50o7
	 K9GS8y1eQf59e0OUZOIYS/bU4IKO4e1wT4NjZzEI/FIbnH3W4swPDe1/NTba/oMPUN
	 pSBCKhdRjmlv+gDpp62sAt0hzf7Un37+zu7X5S7dHySRkkAW19a7W+f/63wm46w09p
	 CxsFF0/iMLvyWJaQ4aYIYZFDBNvK5JrrMh41eJO77wz6Olkeiv1w2h1yB27ndR1p6l
	 fpImKZSrz0YTHnjmuT1eLudh06UuTkotvwlErlBBMJS34bPtoalIVe+P0oAKMX0rpp
	 IuE/b7A/OvjnA==
Date: Sat, 3 Aug 2024 10:58:09 +0100
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
Message-ID: <20240803105809.1b36287d@jic23-huawei>
In-Reply-To: <0e60b324-143a-4976-869c-15d1a288f922@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	<20240722-dlech-mainline-spi-engine-offload-2-v3-2-7420e45df69b@baylibre.com>
	<20240727141512.6dfecc03@jic23-huawei>
	<0e60b324-143a-4976-869c-15d1a288f922@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 14:35:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/27/24 8:15 AM, Jonathan Cameron wrote:
> > On Mon, 22 Jul 2024 16:57:09 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> 
> 
> >> +/**
> >> + * spi_offload_prepare - prepare offload hardware for a transfer
> >> + * @spi:	The spi device to use for the transfers.
> >> + * @id:		Function ID if SPI device uses more than one offload or NULL.
> >> + * @msg:	The SPI message to use for the offload operation.
> >> + *
> >> + * Requests an offload instance with the specified ID and programs it with the
> >> + * provided message.
> >> + *
> >> + * The message must not be pre-optimized (do not call spi_optimize_message() on
> >> + * the message).
> >> + *
> >> + * Calls must be balanced with spi_offload_unprepare().
> >> + *
> >> + * Return: 0 on success, else a negative error code.
> >> + */
> >> +int spi_offload_prepare(struct spi_device *spi, const char *id,
> >> +			struct spi_message *msg)
> >> +{
> >> +	struct spi_controller *ctlr = spi->controller;
> >> +	int ret;
> >> +
> >> +	if (!ctlr->offload_ops)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	msg->offload = true;  
> > I'd set this later perhaps as...  
> 
> If we move it, then we would have to create a new function
> to call instead of spi_optimize_message() so that the controller
> driver can know that this is an offload message and not a
> regular message since they will need to be handled differently
> during the optimization phase.
Ah. I'd missed that.
> 
> >> +
> >> +	ret = spi_optimize_message(spi, msg);
> >> +	if (ret)  
> > 
> > It otherwise needs clearing here so it doesn't have side
> > effects if an error occurs.

Then it needs clearing here I think.

> >   
> >> +		return ret;
> >> +
> >> +	mutex_lock(&ctlr->io_mutex);
> >> +	ret = ctlr->offload_ops->prepare(spi, id, msg);
> >> +	mutex_unlock(&ctlr->io_mutex);
> >> +
> >> +	if (ret) {
> >> +		spi_unoptimize_message(msg);
> >> +		msg->offload = false;
> >> +		return ret;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(spi_offload_prepare);  
> >   


