Return-Path: <linux-iio+bounces-20284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD1CAD0D5A
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 14:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA773B127E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 12:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4421FF47;
	Sat,  7 Jun 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgYjn9+w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98F4C8F;
	Sat,  7 Jun 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749298857; cv=none; b=e4oN4FjDYoM1zCvjZhJpc4Vh4GIVacgKKm53k74VKkjBqfH6OjFhhBhRqdPta+u828khV6Gkh5CIZp7WYak8w4c+cGan5DIUIO/sKO8wrauTFr11yZfyeMxj38Vmj55r42iuQ9k8DlTSG/e9l9aRVRm6UqoVaMROuWoZLw+s/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749298857; c=relaxed/simple;
	bh=5f3YyO5gNxllnHZXcnnAtqBn30LalHqPG5CQzpVx1LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgME3XvWaROEOduADZqN0v+OpD7aOuu/Z7ExKbnafrgKhQeFRkQRtMmAkTYedsUWtHywOjaAd4kvPz0J/GuEB7R+dAfjxZevV662vgbK716kS2riQ1sTab0KlB9by2DPRj3eM+Caov8fp3e0C+MQw4mmMm8oQVyQmri3GhK0r98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgYjn9+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178F6C4CEE4;
	Sat,  7 Jun 2025 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749298857;
	bh=5f3YyO5gNxllnHZXcnnAtqBn30LalHqPG5CQzpVx1LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RgYjn9+wqPBMKNEPJXB+dewBvVP/iN607GfQuaC5wMCgBJNRCj2JCvqdkQG6xJFGL
	 pNPEs4ddMqNBwB9B7HEz6RZHbMeq4wihBr6hD0XT+EwzPYKKJp+sjoy7iO/ykbAICj
	 k1iLzHdg/EudUFPq/cnJzCgBdbuzQLnDnVzlIY+nBgX5POE57xsiIbXhiv3p76aytz
	 +CWQgPTMekQlSH0VBkLQk6S+vYNh9WUeL1pDPPvRFR+MpkyRcfe6ehO2V+1XPZAxwo
	 ds/6HxwiB+6Pu9Zbn8PhQXDF75inrJeoFCmYbJjq+WEoTWSQ4lZYHih4ML6/RdjVDb
	 f+v9NtDF0HZ7g==
Date: Sat, 7 Jun 2025 13:20:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v10 09/12] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <20250607132044.39aee667@jic23-huawei>
In-Reply-To: <aEE0xiCp1IIt9c0M@smile.fi.intel.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
	<4c8cce58c3f5d84423dffee23c260b94c4cb6c36.1749063024.git.Jonathan.Santos@analog.com>
	<aEE0xiCp1IIt9c0M@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 09:10:14 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jun 04, 2025 at 04:37:09PM -0300, Jonathan Santos wrote:
> > The synchronization method using GPIO requires the generated pulse to be
> > truly synchronous with the base MCLK signal. When it is not possible to
> > do that in hardware, the datasheet recommends using synchronization over
> > SPI, where the generated pulse is already synchronous with MCLK. This
> > requires the SYNC_OUT pin to be connected to the SYNC_IN pin.
> > 
> > Use trigger-sources property to enable device synchronization over SPI
> > and multi-device synchronization while replacing sync-in-gpios property.  
> 
> ...
> 
> > +static int ad7768_trigger_sources_sync_setup(struct device *dev,
> > +					     struct fwnode_handle *fwnode,
> > +					     struct ad7768_state *st)
> > +{
> > +	struct fwnode_reference_args args;
> > +	struct fwnode_handle *ref __free(fwnode_handle) = NULL;

Sorry I was slow to reply to v9 discussion but splitting the destructor
declaration from the constructor isn't an acceptable path.  If
the general form proposed in the previous version isn't acceptable, spin
a local version in this driver doing the same thing.

Jonathan


> > +	int ret;
> > +
> > +	ret = fwnode_property_get_reference_args(fwnode, "trigger-sources",
> > +						 "#trigger-source-cells", 0,
> > +						 AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ref = args.fwnode;
> > +	/* First, try getting the GPIO trigger source */
> > +	if (fwnode_device_is_compatible(ref, "gpio-trigger")) {  
> 
> > +		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, ref, NULL,
> > +							       0,  
> 
> This 0 is close to NULL semantically, please move it to the above line to make
> the split more logical.
> 
> > +							       GPIOD_OUT_LOW,
> > +							       "sync-in");
> > +		return PTR_ERR_OR_ZERO(st->gpio_sync_in);
> > +	}
> > +
> > +	/*
> > +	 * TODO: Support the other cases when we have a trigger subsystem
> > +	 * to reliably handle other types of devices as trigger sources.
> > +	 *
> > +	 * For now, return an error message. For self triggering, omit the
> > +	 * trigger-sources property.
> > +	 */
> > +	return dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
> > +}  
> 


