Return-Path: <linux-iio+bounces-20547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B68FAD70CC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AA33A1985
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58856236A9F;
	Thu, 12 Jun 2025 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTbw5GCr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148A229B12;
	Thu, 12 Jun 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732683; cv=none; b=PKZGrFB1BgaFMgYPhV2M8HlX1O1+ch93wnCdg0cWl4KgaWypj12wBNlks6hA80qnBvPpZV4nbeKlfwWOru/qFkWzxkY6v8Tm2LIJ0jeQQd06/57UFI/MS1dZlO3zVQ9/r+9/9hI+iiDti7iLowYLj6Gb5QEOTpwOMd++7PyzWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732683; c=relaxed/simple;
	bh=Bql/TNuo24JhgENmtOEIa3XVAhbnXtyYW3C4rsZ9KFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idHWieGUPobc6h8YA+ceGzemyfsN4MXJym1n6SPGo+YbR/dj0X2xnE7naZKz7TAVGNe6YNiPe43fjlM4H4gM6V9ErKQ50jOvITcgj/OwhmX+UrNoEyrG6zUdFKUnwvUmG+ol1iOW4apDTqv14VB4CR9Gwg3avC1SyAE9e66Zd/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTbw5GCr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749732681; x=1781268681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bql/TNuo24JhgENmtOEIa3XVAhbnXtyYW3C4rsZ9KFs=;
  b=MTbw5GCrj8cZ49UjGa/fQ1M84+qU7t62+lgblrLZjg9Y1UZebm9jNPQi
   IL3VVoZE4GL9VB+whVLMHZqOOHVWrB/s8sWY1G+oir0fEPE9X+oyW2QXt
   qgYEhrct+w1MrGggOC6oGqol2XQwiwIIk5r9GLE7zxoVPPTl2coMDgp6M
   6Hzz3jnr/5kxS287+/i4pjenDv0TWVI88hDjfRpJkcH8/WEFaWklPlln8
   ym0yXM5C6GTliF2bFhAAU9MXOna1MAPFFxLlo/TL6WFIJH1RLj5bIH4TL
   ymU7xmx5raR+ZhylZWDh7RRzw3h7nOEltpNG24U03hC6Mxz+1Lr36Iw5l
   Q==;
X-CSE-ConnectionGUID: JbRmwnexSgqEcnNRs8UQ6Q==
X-CSE-MsgGUID: c7YryAzOSxa4gVYOQ2e9Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69478287"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="69478287"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:51:20 -0700
X-CSE-ConnectionGUID: mofzayPbSfemxo/78nvEhA==
X-CSE-MsgGUID: 65CP34ARQ+yNMlLSnRyUqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="152795140"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:51:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uPhOg-00000005x89-01m7;
	Thu, 12 Jun 2025 15:51:10 +0300
Date: Thu, 12 Jun 2025 15:51:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
	Roan van Dijk <roan@protonic.nl>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Andreas Klinger <ak@it-klinger.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/28] iio: zero init stack with { } instead of memset()
Message-ID: <aErNPaZzvgAps_-b@smile.fi.intel.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 05:38:52PM -0500, David Lechner wrote:
> Jonathan mentioned recently that he would like to get away from using
> memset() to zero-initialize stack memory in the IIO subsystem. And we
> have it on good authority that initializing a struct or array with = { }
> is the preferred way to do this in the kernel [1]. So here is a series
> to take care of that.

I believe we may do that independently of the compilers that can leave garbage
in the padding. In case it happens, it will be good adventure to fix the bugs
in the code, that for some reason take padding(s) into account for the real
values.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



