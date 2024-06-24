Return-Path: <linux-iio+bounces-6839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB4C915739
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 21:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850A01F217EA
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F08D1A01C0;
	Mon, 24 Jun 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp8/TvQV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7AF1A01A9;
	Mon, 24 Jun 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257672; cv=none; b=Gdegd4kKYVxIAM/4lQ2GjX2cXiCBA24Eu0cDTy/MLp/Q8qUMXUytkeukTLjTU2U7irM3+gGQwaVAfTzLRD8+cp/+Oi0Zg3YbpEjBSUS0T03labL2dZv2YfR91t85j0Y07Sv8GCaZXSuzH9+pxaLl7c2vGe3CIZZUCkd2TxOXS6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257672; c=relaxed/simple;
	bh=BoW+izWMrB0vUIgdczTG8eY31gFwP4//AAgzMGmL2dM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzRu/+m6OQZoqybNwVBRVvlKGN1Kye9B8RG5bwTUycjlkexTdDiEvUj5y7I2pgBTK3Mr0DfeQCpe8vzF3Qus9zSxYY7j3RNxlon4tolrYa9lqDglRNVaVQy8tjocOX1zuPDaegUK3ccbXIkXzcknbP0qQ557exavROuGhkf+IkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp8/TvQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3A2C2BBFC;
	Mon, 24 Jun 2024 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719257672;
	bh=BoW+izWMrB0vUIgdczTG8eY31gFwP4//AAgzMGmL2dM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lp8/TvQVYFswu33lkx0ks1qmHin9SfvJe1OJt6aVDfBxiJNuzBjVuZFPAocNe2Kp2
	 xl6aghAFbuwFuQKmECp3Xmai3FPZLHnTJHzss/36QxfOkIFf55zJXtabwaKanPOPh/
	 Uz47iksDtHlIskOzDB2umFQ/EGOHLyGKqDeKufzeVhxAnsNz3fV/i3r/6VIyyxm1t0
	 eVpNTmPaLCBlKqLB19kEmOwwSRQABWY7OuJCyi5I3eZIWV/Qbrjj2aGSYKpBh9KXig
	 4eITZGGCY4Mj3SnAJE6G6NUvNhjELmIZbx9uA8lz4Ef1CdUgUv3DNj/k7EpfmTJIZu
	 dqIS7gbbMISUw==
Date: Mon, 24 Jun 2024 20:34:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Andreas Klinger <ak@it-klinger.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] iio: use devm_regulator_get_enable_read_voltage
 round 2
Message-ID: <20240624203426.1970ec62@jic23-huawei>
In-Reply-To: <20240623111247.1c4a5e2a@jic23-huawei>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
	<20240623111247.1c4a5e2a@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jun 2024 11:12:47 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 21 Jun 2024 17:11:47 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > This is the second round of patches making use of the new helper
> > devm_regulator_get_enable_read_voltage() to simplify drivers.
> > 
> > All of the changes in this round should be fairly straight forward.
> > And as a bonus, there are a few patches to get rid of driver .remove
> > callbacks.  
> 
> LGTM.  Obviously only been on list for a short time though and
> some of these have active maintainers so I won't pick them up just yet.

I think most of the people I thought would review did super quick so 
applied.

Thanks,

Jonathan

> 
> Jonathan
> 
> > 
> > ---
> > David Lechner (10):
> >       iio: adc: aspeed_adc: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: hx711: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: hx711: remove hx711_remove()
> >       iio: adc: hx711: use dev_err_probe()
> >       iio: adc: ltc2309: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: max1363: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: ti-adc108s102: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: ti-ads8688: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: ti-ads8688: drop ads8688_remove()
> >       iio: dac: ad3552r: use devm_regulator_get_enable_read_voltage()
> > 
> >  drivers/iio/adc/aspeed_adc.c    | 30 +++++-----------
> >  drivers/iio/adc/hx711.c         | 78 ++++++++++-------------------------------
> >  drivers/iio/adc/ltc2309.c       | 43 ++++-------------------
> >  drivers/iio/adc/max1363.c       | 28 +++------------
> >  drivers/iio/adc/ti-adc108s102.c | 28 ++-------------
> >  drivers/iio/adc/ti-ads8688.c    | 59 ++++++-------------------------
> >  drivers/iio/dac/ad3552r.c       | 28 +++------------
> >  7 files changed, 53 insertions(+), 241 deletions(-)
> > ---
> > base-commit: 7db8a847f98caae68c70bdab9ba92d1af38e5656
> > change-id: 20240621-iio-regulator-refactor-round-2-28a1e129a42d  
> 
> 


