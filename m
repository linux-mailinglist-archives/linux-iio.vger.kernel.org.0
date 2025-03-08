Return-Path: <linux-iio+bounces-16572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC484A57C01
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 084607A493D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374E1E8356;
	Sat,  8 Mar 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/aNA7Z3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D981E8341;
	Sat,  8 Mar 2025 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451717; cv=none; b=Ay1wc4HfCgkk/JgKkS2LMd64xIq5EHR7JUUOyromFzaOQ4M6cGbcXpIvHyu22C8Tn2YZHpvnN8zFSuttX1DtPwEg16cCkVaYg1Zq2J7p6u/sltN7SCFhMQb+DGb+nuSH68vYX8EjzPiUf7DtK85nRhnAjZXhTsw/xaMtFmU/YZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451717; c=relaxed/simple;
	bh=hHfV8kx8wrHR7+8E6WI3ssEv6MnebcU05CUBb1yiFgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aircnjygWBzNhnjR3ywvdpYMSjQPRfeKKIAWzcGNbAtQN0LHpygXt/myZzyIPLsmSnS+mHnPeFEygbKlw0S+R1Qbq5jWXW1QEK+C2BCFX6/oQotZwFgLbTeR09YBvSBDC9d+9bYciqUhoOh6ZFVhymQDg+JtLnXNhU2LEfZSDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/aNA7Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B44C4CEE0;
	Sat,  8 Mar 2025 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741451717;
	bh=hHfV8kx8wrHR7+8E6WI3ssEv6MnebcU05CUBb1yiFgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X/aNA7Z3E5cln+jCB0zSs1H9LkqPep9eoxzzWKcZIU+8eV5SJC7Niy4qJcuheOy7M
	 9jXNklRhgO0354yo/C0Y7a9lNVMmswFZstnIFJkTrL4Q5IsPNPf7lX2oHj1TIk1U+7
	 Zn9MUQGVFMy4M9oEc8qByBN/K1guazaezxjZ73xjTCxKLUEDWOcydNFoRPX+WtRPjb
	 FMRb2z0PoepLTIe3zlLIcWgjAVQLXvmF1dLr8Gd2x9jcyfsZO3qx9SRix/detu8+k4
	 x0fa1g2TCb2uW0OhpL58j6TrY/YF4JNNEywgQLK5/8XFYN5XqNbBpzphLfSouQURjD
	 ymqt8ajSytsyQ==
Date: Sat, 8 Mar 2025 16:35:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <20250308163505.200135cc@jic23-huawei>
In-Reply-To: <aabd8836dbe54ef54730d1cd112edb52a57cd353.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
	<aabd8836dbe54ef54730d1cd112edb52a57cd353.1740993491.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 13:33:02 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
> drivers avoid open-coding the for_each_node -loop for getting the
> channel IDs. The helper provides standard way to detect the ADC channel
> nodes (by the node name), and a standard way to convert the "reg"
> -propereties to channel identification numbers, used in the struct

same typo.

> iio_chan_spec. Furthermore, the helper can optionally check the found
> channel IDs are smaller than given maximum. This is useful for callers
> which later use the IDs for example for indexing a channel data array.
> 
> The original driver treated all found child nodes as channel nodes. The
> new helper requires channel nodes to be named channel[@N]. This should
> help avoid problems with devices which may contain also other but ADC
> child nodes. Quick grep from arch/* with the sun20i-gpadc's compatible
> string didn't reveal any in-tree .dts with channel nodes named
> otherwise. Also, same grep shows all the in-tree .dts seem to have
> channel IDs between 0..num of channels.
> 
> Use the new helper.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
Otherwise LGTM

