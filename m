Return-Path: <linux-iio+bounces-26597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCE9C9819D
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 16:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B6864E1E60
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971BB332ECF;
	Mon,  1 Dec 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQt/mmiS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5207248898;
	Mon,  1 Dec 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604182; cv=none; b=Va4cNXJ2XqHh2dZhCfwRqzJTQdtKrxyV8Os6KjDfenfXYE84c4Wh503R9BjZBdPG3u0GE1RkCGLpBgIwC0TcqlaRRTwHX/bTAjaoAIP0vqV06InPFqmKAm6V0q7usbNFxzZaS6h3rikNXoQBYFftzo0dR9QiKCEK7fXmbkFYKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604182; c=relaxed/simple;
	bh=1c9J4q1neG1gudKs5OVJ1JNCeSTxftP6emxXSKcTElw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChX6RoW+/djAer9rbMtv9ZyDEIJJU4R6f1JpZQttvS5xSjUco75jBR47AnFw4jzBissp9ZWnm1DST8RSqlD1sv7jvF/VteG4k8v7qMd7R/4sNXNFEC1b90oqsNkOqE64mu2WFghcLSErgvrIb2sZXF/6lZWmgTw2qYsGVLxlFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQt/mmiS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764604180; x=1796140180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1c9J4q1neG1gudKs5OVJ1JNCeSTxftP6emxXSKcTElw=;
  b=iQt/mmiSK9CKXd0iIUaixDQE+VbAIWQepg/TmbJZXlQgJA0Iw9HjuLbS
   SLEmvFb6ULsr/Y7vr9oQY+hCBD8pIPE8Q7Tm4DAFsYiAXVXX8nYcFXFcA
   ugBCEvDK0IhRaqfm6bf1mKjxnYPx70JUgKnBFef/0sxu6Oc3B8C3O5xoq
   C5XBitED/xrpqIJYEM2/BV2xnAbLgsVGodPAr4sevOGCp1DSaM2+bScpb
   8DunXcspPqVheb7kcJpwlis4VUZADXry5GT9vGA9AehmePBAnTrLMoYLQ
   /qiVjlw5xdpXCXt/Yg9DNybBBBjfBCfOMeti8mm6wKzuhECWaz6V37zyC
   Q==;
X-CSE-ConnectionGUID: 8o9U/Q+mTmaEMBVygqCq+w==
X-CSE-MsgGUID: 3ZBTsc88RJK+s2iCXzu/XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="83939824"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="83939824"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 07:49:39 -0800
X-CSE-ConnectionGUID: 4pEW9aM1QU+ohR0hYSrNMg==
X-CSE-MsgGUID: dd6uz1+4QC+N72HOYq53oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="194531575"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.4])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 07:49:27 -0800
Date: Mon, 1 Dec 2025 17:49:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Hans de Goede <hansg@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] iio: inkern: Use namespaced exports
Message-ID: <aS25Beoq8YWfqLzU@smile.fi.intel.com>
References: <20251201-iio-inkern-use-namespaced-exports-v1-1-da1935f70243@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-iio-inkern-use-namespaced-exports-v1-1-da1935f70243@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 01, 2025 at 11:59:43AM +0100, Romain Gantois wrote:
> Use namespaced exports for IIO consumer API functions.

Thanks! You probably also want to explain that due to nature of the change
it may not be split to a separate patches.

...

So far we have IIO_BACKEND and IIO_GTS_HELPER, this one introduces
IIO_CONSUMER. I have briefly looked at the names of the APIs and taking into
account that they are all in inkern.c with the consumer.h header to provide
an API for the users. That said, I found the choice and implementation sane
and consistent. If we need any changes in the future it will require anyway
more than just namespace shuffling.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



