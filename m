Return-Path: <linux-iio+bounces-16704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA93A5A4F2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797F217242E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F311DE8AB;
	Mon, 10 Mar 2025 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxTlFGHF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44768EC5;
	Mon, 10 Mar 2025 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638482; cv=none; b=TX81Ejq29t7HeyYcfaF/KImx88XHcW2RpCa4Ior3DdCrHGrdOemdM30J0mCL2iPCXctWaxpUDfN2olBNPMgt5815SuXzgyQEmm4AITF5Dyf1vO8D9k8kMTbtGoKgXOhEJNyo+jkGlbtOXjkd7m9cPqK7Mqfk13rka1JO+uU7lqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638482; c=relaxed/simple;
	bh=jrIUTRkOVwF4DrP6Op5FQkTYRiWzZRjfoY/yn1onSOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVOoL/aPZNYvZ2XGhkC7ruZTaqr3RTvs0Jzxj6eK/p6Bz2seLAX6TLXMkvh/PGPBOW25tsnsp73IqrX9BJiPtaRz7P6O5JVEisJvHlCZVqYcXC+ms8G11JoKNKEy8d9NEW6BhUmRUkP5zMzZJjwR1r8draONWjWNIo3O/mvAGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxTlFGHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E9CC4CEE5;
	Mon, 10 Mar 2025 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638481;
	bh=jrIUTRkOVwF4DrP6Op5FQkTYRiWzZRjfoY/yn1onSOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BxTlFGHFoOW0phWUqgQyWBIzCHGcDhnWX71cIrTi/V6o/OiL21j07oJLCGyw+KM9b
	 3ReRfXP2z6sHkLW/fYS14usJ4jMUA8tFPVNPUAhN+ZxdAfy1XPr0YAmsmYh3s+qBui
	 l2Wg09MH9ZYmq/RERxrvpEx04dsu66PALYPHHmAaXl1yEKkjMIGzESQeeRoKto5vB9
	 uudFqXko3mnxN3db9MwQRFSZksb8SB6QtcJFypy/s9kCh1WO+iV5BSZT1OZ5cpY3tx
	 6Lr2DFTSxmYrDwDKk7SRg7EUIcKe4UbqK4DBQxh9+NErcIzOCq2Ql/DTx8UkrUkQ8x
	 2uGVdAQ1eUAzg==
Date: Mon, 10 Mar 2025 20:27:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Herve Codina <herve.codina@bootlin.com>, Thomas
 Bonnefille <thomas.bonnefille@bootlin.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Nuno Sa <nuno.sa@analog.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, Claudiu
 Manoil <claudiu.manoil@nxp.com>, devicetree@vger.kernel.org, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-iio@vger.kernel.org, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Eric Dumazet <edumazet@google.com>, Conor
 Dooley <conor+dt@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Paul Elder <paul.elder@ideasonboard.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Matteo Martelli
 <matteomartelli3@gmail.com>, Guillaume Stols <gstols@baylibre.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, David Lechner <dlechner@baylibre.com>, Chen-Yu
 Tsai <wens@csie.org>, Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v6 00/10] Support ROHM BD79124 ADC
Message-ID: <20250310202738.13301548@jic23-huawei>
In-Reply-To: <cover.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 14:53:50 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Support ROHM BD79124 ADC.
> 
> This series adds also couple of IIO ADC helper functions for parsing the
> channel information from the device tree. There are also new helpers
> included for iterating and counting firmware child nodes with a specific
> name.
> 
> Series does also convert couple of drivers to use these helpers. The
> rzg2l_adc and the sun20i-gpadc are converted to use the new ADC helper.
> 
> The gianfar driver under net and the thp7312 under media/i2c are added as
> first users of the newly added "named child node" -helpers.
> 
> There has been some discussion about how useful these ADC helpers are,
> and whether they should support also differential and single ended channel
> configurations. This version does not include support for those - with the
> benefit of reduced complexity and easier to use API.
> 
> NOTE: Patches 4,5,9 and 10 are untested as I lack of relevant HW.
> They have been compile tested only.
This probably wants an update.  Also, 00/10? There are only 8 that I can see.

Jonathan

