Return-Path: <linux-iio+bounces-15988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E097A40FBE
	for <lists+linux-iio@lfdr.de>; Sun, 23 Feb 2025 17:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE31174BF0
	for <lists+linux-iio@lfdr.de>; Sun, 23 Feb 2025 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310DE78F37;
	Sun, 23 Feb 2025 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW7/guI7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6793EEA8;
	Sun, 23 Feb 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328236; cv=none; b=n3Sv7Eumzbv0dyFEbc27werQamUVeJkJiZbPO0vCUHBXuWABwPUhWlHGa+GixkdzE9CRgXDwuILzyJmXAGnjYKnbQb7oDSDFEvQE16pQiU7t/8bkheh1yyI9J/eHmizRfSu3vQJPDL5tzJl+gKaR95PLJd4zDKwl0/DZu8hwBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328236; c=relaxed/simple;
	bh=QfKdiEk49aDWt010gngXbc3vJUxTK0YB03j5djAbuSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nlqv7LgwCj8zMgssetHyffn7XpzQmEoqSuRy8YsiML7j9hZNtlr6yHy1sjv3WJk0JQbzAyPEJQ3CvevAhMV5fW4P7BOy8Q2a3F8gOs5cdUrl8z3SDylfwY/0v9g84hQG8l18HUjbXYbNTqykGwV4+94gDU80+Yyq+ok7J+AY/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW7/guI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82E5C4CEDD;
	Sun, 23 Feb 2025 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740328235;
	bh=QfKdiEk49aDWt010gngXbc3vJUxTK0YB03j5djAbuSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SW7/guI7iN1/8drBB39h5FaVJkqRojBn31+ZtOaZr/aaBcQue6cIy5785HZ3oXljI
	 LlOBYYxYWKHKcJWFJdxoV3zXYKpE0BLR8pTvle0s8Ja5wcFDTffbOAoHN6L5d7Rw+9
	 tqADmqonQH4E9OrvZhopW7RHnGAfOAMS0eoLk11Ofps6vd0nyRaWzA1M95vScL8NMV
	 vFgfnLj5JyEn2y+1mSDcxfSoEFbrVrAumZlqbQzYbURtpuiK/h71NvTqXe8PFG7gcg
	 sAxp72j1ftLeBSd+AZBa+NZ6AiqjX43hcWKBlATuc5AJocQ+atufejV26yCkg1sv90
	 LEF5z7wRlxjeA==
Date: Sun, 23 Feb 2025 16:30:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 6/9] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <20250223163018.2c0290e8@jic23-huawei>
In-Reply-To: <25c5d22f6f0cbd1355eee2e9d9103c3ee71cebdc.1739967040.git.mazziesaccount@gmail.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
	<25c5d22f6f0cbd1355eee2e9d9103c3ee71cebdc.1739967040.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 14:31:38 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
> drivers avoid open-coding the for_each_node -loop for getting the
> channel IDs. The helper provides standard way to detect the ADC channel
> nodes (by the node name), and a standard way to convert the "reg",
> "diff-channels", "single-channel" and the "common-mode-channel" to
> channel identification numbers used in the struct iio_chan_spec.
> Furthermore, the helper checks the ID is in range of 0 ... num-channels.
> 
> The original driver treated all found child nodes as channel nodes. The
> new helper requires channel nodes to be named channel[@N]. This should
> help avoid problems with devices which may contain also other but ADC
> child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
> string didn't reveal any in-tree .dts with channel nodes named
> othervice. Also, same grep shows all the .dts seem to have channel IDs
> between 0..num of channels.
> 
> Use the new helper.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

I should have read on.  Definitely more convincing with these usecases.
however drag them to start of series.  Better to add infrastructure
so some use and then on to your new driver.

Looks good to me.

Jonathan


