Return-Path: <linux-iio+bounces-16228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B65A4AF2A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 04:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45FB57A7F1C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441A15C158;
	Sun,  2 Mar 2025 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkCcPaMm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9408494;
	Sun,  2 Mar 2025 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740887232; cv=none; b=slZyz9FSdUTkgZl7jRtf0+Yzl+N0TMkboVDRZ2FsyW2uFrlrlNMVeFaAfoE1qHXFzEIr2FXSqQdFIsc8ELEBgydmBRv7doN3oCNs7g0qOr/rJrsM+8ysGkE5DrF/Ba9u3caF7PozLlqxGILvKUaQM0r0BeEBkfnjP0H+Ny47LJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740887232; c=relaxed/simple;
	bh=O1SNm9G2v5Ugd5UySXzu1wFcmNPfiG9j1G7ECdHcH2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CM/+MOpXk7ggrTLxa5epZJMWggJmHTuR1KjEyDCsciVkH65Yd6nBim6jCgvNEF4dl+VfxfC7WwfVQfabp35auonVAzm3Oxp5dZHPIM+FNDv7xLjaDEaV/aXkQK6spXyasAv1hk7QcXjE4kgp71MCRrxx4lOWbw/N1b41zJxF7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkCcPaMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90261C4CEE2;
	Sun,  2 Mar 2025 03:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740887231;
	bh=O1SNm9G2v5Ugd5UySXzu1wFcmNPfiG9j1G7ECdHcH2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MkCcPaMmrOCyOo9EpJvxcT+v05XO+mjFs+cGtaaPcQlIHiy0ZfmfySc9YoOfmWccy
	 ka+9Yr6T6T6jrWgOTmtJRKb9mZ5y4+u7hP4nA7DyJ1i4CgVuzhFlZ94xIT7Z51f0jn
	 HhDuWVMXpZ/UQlCqV3A6wBkk8vg94H4/HRAeRgvssdXI5KlUEDaBV66fSBD0qRbgXq
	 1KZPcfK+E2eNTkF1MWJf02jhfbP/K910Im0Gpf7+4ySoThmXYbV0DXkK2v1Z9Axv+o
	 +zIZJIBDhxa+muFAFDoma5JEuBhKpojQo8P40D0ZK52twsM3mNyMjj6I0FDiahSZZd
	 z5epcFx/utLWQ==
Date: Sun, 2 Mar 2025 03:46:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Guillaume Stols
 <gstols@baylibre.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru
 Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 06/10] iio: adc: ti-ads7924 Drop unnecessary function
 parameters
Message-ID: <20250302034649.2d9ec2a4@jic23-huawei>
In-Reply-To: <38d39befcca110132fd4349c87fcb5d7ff51a2c8.1740421248.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
	<38d39befcca110132fd4349c87fcb5d7ff51a2c8.1740421248.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 20:34:01 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Device pointer is the only variable which is used by the
> ads7924_get_channels_config() and which is declared outside this
> function. Still, the function gets the iio_device and i2c_client as
> parameters. The sole caller of this function (probe) already has the
> device pointer which it can directly pass to the function.
> 
> Simplify code by passing the device pointer directly as a parameter
> instead of digging it from the iio_device's private data.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Looking again at this function it doesn't seem to be doing anything
useful at all.  It checks the channel nodes are in range, but
does nothing with that data. I'd just drop it entirely.

Ah. I see David suggested the same.

We can't really 'fix' what this was perhaps intended to do now
as what it does has become ABI :(


Jonathan

> 
> ---
> This commit is compile-tested only! All further testing is appreciated.
> ---
>  drivers/iio/adc/ti-ads7924.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
> index 66b54c0d75aa..b1f745f75dbe 100644
> --- a/drivers/iio/adc/ti-ads7924.c
> +++ b/drivers/iio/adc/ti-ads7924.c
> @@ -251,11 +251,8 @@ static const struct iio_info ads7924_info = {
>  	.read_raw = ads7924_read_raw,
>  };
>  
> -static int ads7924_get_channels_config(struct i2c_client *client,
> -				       struct iio_dev *indio_dev)
> +static int ads7924_get_channels_config(struct device *dev)
>  {
> -	struct ads7924_data *priv = iio_priv(indio_dev);
> -	struct device *dev = priv->dev;
>  	struct fwnode_handle *node;
>  	int num_channels = 0;
>  
> @@ -380,7 +377,7 @@ static int ads7924_probe(struct i2c_client *client)
>  	indio_dev->num_channels = ARRAY_SIZE(ads7924_channels);
>  	indio_dev->info = &ads7924_info;
>  
> -	ret = ads7924_get_channels_config(client, indio_dev);
> +	ret = ads7924_get_channels_config(dev);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret,
>  				     "failed to get channels configuration\n");


