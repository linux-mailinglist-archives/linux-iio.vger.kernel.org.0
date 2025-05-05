Return-Path: <linux-iio+bounces-19116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE67AA982B
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9655D189BBB8
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF899266560;
	Mon,  5 May 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNuiVDv7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A226560B;
	Mon,  5 May 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460803; cv=none; b=h8c6vBsc4qw7i0rzLQyGW6gQD1r4B1gsqi+aOkY3wCb/Oz+O6fujstutoP8KIPqB3z8U2aHtGwIxCjzig9yFU0F+EGLip3D2O3b8POjIcRe5SXwv3f6QSV4nBFI7Afl3q0bEq211gWTw8v0tJd6gwxusu8lQaFfivJ2YSJjWQBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460803; c=relaxed/simple;
	bh=5ynFe25+2HfNv2eY3CY5suWJcgSSXs7GbguoKQuTOE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJ576gHBIjkCWf9A0/lV1SQ1077QIOIKogIfH956qdR19NraMDdcaw4Px8eZFWLbz7hP5m5NLPJZw2mTHQGFMr0qz21Js3wjn+n86bRw7hcBhShsWWwLzaARqAvjEJv9QZ/YJ90kZPjTrgJpJvdtdiioe6n6jEHx+W28X4MpaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNuiVDv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFED1C4CEE4;
	Mon,  5 May 2025 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746460803;
	bh=5ynFe25+2HfNv2eY3CY5suWJcgSSXs7GbguoKQuTOE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hNuiVDv7kHrBn3/wCxcN2vN1vpcWOk+on51UP+dYHa8YvyWX9B25k1PhiK77NMui3
	 YxVxGayr8H3TASlUA95vNO0wkSh7QaIXJytjU0AK5+DMF09BTknG2NrsE6gxGJlabk
	 U57nSCdFgyhbHYE8ShYN6Kr/pGSf6ix0jWL4kwBmuE2pmh1sxJXyceSXj+zISbYgww
	 ES+VO30OWEcLo2trKhfGSIy9vfl1hEjzPS5qUN0aysHfJ/EmZORsh5+rbNZRkUE91b
	 ntDDwaiwCeojrPTRbfEEbb9ro34cwRJROIhCYyUXTFsQDJXIwmz+bu0j3J7OGEtGSD
	 1RPf8A3KEbZwA==
Date: Mon, 5 May 2025 16:59:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <andy@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: Re: [PATCH v6 08/11] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <20250505165953.15958d58@jic23-huawei>
In-Reply-To: <c5a5376a6ffbb571d7874218494b04fd20015ee9.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
	<c5a5376a6ffbb571d7874218494b04fd20015ee9.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Apr 2025 21:13:47 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The synchronization method using GPIO requires the generated pulse to be
> truly synchronous with the base MCLK signal. When it is not possible to
> do that in hardware, the datasheet recommends using synchronization over
> SPI, where the generated pulse is already synchronous with MCLK. This
> requires the SYNC_OUT pin to be connected to SYNC_IN pin.
> 
> Use trigger-sources property to enable device synchronization over SPI
> and multi-device synchronization, as an alternative to adi,sync-in-gpios
> property.
> 

> +static int ad7768_trigger_sources_get_sync(struct device *dev,
> +					   struct ad7768_state *st)
> +{
> +	struct fwnode_reference_args args;
> +	struct fwnode_handle *fwnode = NULL;
> +	int ret;
> +
> +	/*
> +	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
> +	 * to synchronize one or more devices:
> +	 * 1. Using an external GPIO.
> +	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
> +	 *    synchronization pulse that drives the SYNC_IN pin.
> +	 */
> +	if (!device_property_present(dev, "trigger-sources")) {
> +		/*
> +		 * In the absence of trigger-sources property, enable self
> +		 * synchronization over SPI (SYNC_OUT).
> +		 */
> +		st->en_spi_sync = true;
> +		return 0;
> +	}
> +
> +	ret = fwnode_property_get_reference_args(dev_fwnode(dev),
> +						 "trigger-sources",
> +						 "#trigger-source-cells",
> +						 0,
> +						 AD7768_TRIGGER_SOURCE_SYNC_IDX,
> +						 &args);
> +	if (ret)
> +		return ret;
> +
> +	fwnode = args.fwnode;
> +	/*
> +	 * First, try getting the GPIO trigger source and fallback to
> +	 * synchronization over SPI in case of failure.
> +	 */
> +	st->gpio_sync_in = ad7768_trigger_source_get_gpio(dev, fwnode);
> +	if (IS_ERR(st->gpio_sync_in)) {
> +		/*
> +		 * For this case, it requires one argument, which indicates the
> +		 * output pin referenced.
> +		 */
> +		if (args.nargs < 1)
> +			goto err_not_supp;
> +
> +		if (args.args[0] != AD7768_TRIGGER_SOURCE_SYNC_OUT)
> +			goto err_not_supp;
> +
> +		/*
> +		 * Only self trigger is supported for now, i.e.,
> +		 * external SYNC_OUT is not allowed.
> +		 */
> +		if (fwnode->dev == dev) {
> +			st->en_spi_sync = true;
> +			goto out_put_node;
> +		}
> +
> +		goto err_not_supp;
> +	}
> +
> +	goto out_put_node;
> +
> +err_not_supp:

Split the good and bad paths here so we don't have good paths jumping to
mid way through the block. If the good paths need to jump then I'd
suggest factoring out the stuff with the node held into a separate function.
Superficially it just looks like one condition flip and you are refactoring
this anyway based on other feedback so maybe this comment becomes irrelevant!


> +	ret = dev_err_probe(dev, -EOPNOTSUPP,
> +			    "Invalid synchronization trigger source");
> +out_put_node:
> +	fwnode_handle_put(args.fwnode);
> +	return ret;
> +}
> +



