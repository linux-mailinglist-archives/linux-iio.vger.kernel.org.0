Return-Path: <linux-iio+bounces-26428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C997CC813D6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07583A3E7D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B064A311C1F;
	Mon, 24 Nov 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6NrePaN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B2296159;
	Mon, 24 Nov 2025 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996871; cv=none; b=Vd4GrwYIa3sqTi5QeHBXZJ03KViN8xH21r1/GOzG3Rjg8LNVynprM72FKyMKdwTRp7ADjtXyKMbuXwWzttQf8zRQIFZxAhdm+m0rt1qevAAtuFgJiTDjgV0yo623jzwsx0cAJcWYs8AyTDsXVrYGOnjq2QhuS1VML6z8xZzA65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996871; c=relaxed/simple;
	bh=Z56v9C0Rg97jOdx0MwIq/SrG80i12igOo1dqKgEs9Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0pdOdujL8RQZ45S8HkTxd+EaNHFA91smytrd2MKi9PchsQL0sUgkwXL88YtHY9QRDDxRTSW2CBvAqUxgr+PZ6JJlyvnBpUKxRKZemP9MR1n6Q4yFK6rho8g2zbVRHsYUdVR1RYFatDDNkSslJLVIik7pV2JhEkTBQOrSZGRHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6NrePaN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763996870; x=1795532870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z56v9C0Rg97jOdx0MwIq/SrG80i12igOo1dqKgEs9Ik=;
  b=b6NrePaNL+uRJY5DdLvqxObT3ecxxRAmTsXijFpLB/VEwlRFYEkJHqZP
   2OWOEOnyDcNOzEZRbitoBxh2svLRhwP8RnIgkIVGqkWgBJAtlzTgWN7wv
   CZf2a+vuPkIwOlw7sVfD52tlwADANnqALv6M5fzB/MgzAr6p7hGzHcw01
   TGzfx49S8KJ3aKyLaB3bpE9JkvfnfziUmXbf7NS6bHi1e1n0RgggopzAE
   ALDFp8GH2rIqrzRP6O7wkeXo1oZYFhdgduU6j/75rtwks8eM4IDZrYpgx
   2HJ7L/Qn7zImokSG4GspGsFTarOABdcXHybBLxfm9aafSIof8yolyhG+E
   g==;
X-CSE-ConnectionGUID: PB+sxuGMSDSny6s1TBgRig==
X-CSE-MsgGUID: myrndp5eRjCpZ0NBJkVDjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="88647375"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="88647375"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 07:07:49 -0800
X-CSE-ConnectionGUID: P/h9s0EiQjK4ZI/Rp7ebrQ==
X-CSE-MsgGUID: gvu9jDc3QauPN63N7QPpOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="192595689"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 07:07:35 -0800
Date: Mon, 24 Nov 2025 17:07:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Peter Rosin <peda@axentia.se>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Iskren Chernev <me@iskren.info>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	Saravanan Sekar <sravanhome@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dixit Parmar <dixitparmar19@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 0/6] Add support for the LTM8054 voltage regulator
Message-ID: <aSR0tcV0ULNYvf7t@smile.fi.intel.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <24527d76-4f6a-4008-a369-23510d492a94@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24527d76-4f6a-4008-a369-23510d492a94@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 24, 2025 at 06:57:41AM -0800, Guenter Roeck wrote:
> On 11/24/25 06:48, Romain Gantois wrote:
> > 
> > This is version four of my series which adds initial support of the Linear
> > Technology LTM8054 voltage regulator. The driver supports a fixed voltage
> > and a tunable output current limit using a DAC-controlled pin.
> > 
> > I'd say that the most unusual part of this series is the usage of the IIO
> > consumer API in a regulator driver. I think this makes sense here, since
> > the regulator driver has to access a DAC to read/set the output current
> > limit.
> 
> I don't think that is a valid reason. Literally every driver measuring voltages
> or current uses a DAC to do it. How else would one convert an analog value
> into a digital value ?

While I'm not objecting your vision on this, the ADC is also possible to use to
"measure" the analog signal. DAC approach IIRC considered cheaper solution, but
require an analogue comparator.

-- 
With Best Regards,
Andy Shevchenko



