Return-Path: <linux-iio+bounces-23137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFAFB31397
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 11:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743BCBA003C
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D72F3C20;
	Fri, 22 Aug 2025 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYnN6/Mb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C598D2F3617;
	Fri, 22 Aug 2025 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855462; cv=none; b=OBPf8fbed6Yc9mpxuF9gqpBhn2koxE8EbEFF9l3b6KwZRabISEnV8CCYxT1hLNIxKhKZnwsvVGlYcZf1Ez6A3z6spvLbFMR5jyDZPMxDBKi0pXdq+lzZKt1B/d5rqDHUyKmqvq9Q9VPt5PT/ovQWVR3O4BY2fGZvQ3dRm9FdKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855462; c=relaxed/simple;
	bh=QgkFZGSFeP9Tyb5OkVgiydGAskriNxja1kg0ydQsDXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzWN+lOqbFDVyLQtqe3ypG9e30uf54WstoYKBfFpPtpdIbXHNWgF4YRgqVD5DhvlmyvnzVAScqpykSQTjPyfc0foY22OnJYPRSvGTHF00vWmq/vUAKX8DEz4UQJUcy+Yirm8HBdjqSKrPqMT3GISepYEzFkSZs8zp/caJeTiMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYnN6/Mb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755855461; x=1787391461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QgkFZGSFeP9Tyb5OkVgiydGAskriNxja1kg0ydQsDXg=;
  b=UYnN6/MbCdgsHwtSN0d8FYWCUrMJ+N6pqOUOo5YtUNHmOmbCU81xoQTb
   w2NJbiPvsBkEafWC91aLFoD3qXFTijfvBTm/Ea2jwkgpuhNwVisv7CBPO
   Z2w6pyL3+PMNi2IxTVJBf+dbzOJFs96ve6noCkqNQz4J2ITVYt6XcU/zb
   NNbu0U8NYY3n3LTLiS4MpGh8DtMD4zMlVKc3KZdZZ3+QzHwA8XVyVHD7B
   8DOkVpJQy9JThQmzdI+klKyZjuZBDreT9+0r3rYgOLDRrQJFWeINHp5pk
   TDG/B3pPBWo/SCTyxPZPPj2ebgorgvgT/iLku91rk8x7rHK87K1ndSkSI
   Q==;
X-CSE-ConnectionGUID: dOA5gTCsTfeZD59Aw2gLHA==
X-CSE-MsgGUID: /JUsPNEqSxCrP3v6aw5h8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69599506"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69599506"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:37:40 -0700
X-CSE-ConnectionGUID: a6JIz9UlT9KH8DjMxcDzxA==
X-CSE-MsgGUID: EEY/MKcBRMWw+7H5MhgVDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="167907690"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:37:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1upODB-00000007TlT-0od7;
	Fri, 22 Aug 2025 12:37:29 +0300
Date: Fri, 22 Aug 2025 12:37:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Haibo Chen <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andreas Klinger <ak@it-klinger.de>, Crt Mori <cmo@melexis.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/10] iio: Drop unnecessary -ENOMEM messages
Message-ID: <aKg6WP361s6gcUTD@smile.fi.intel.com>
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
 <CAHp75VeTD5Y1bi-jYyfRnCPDfB4=WO+QF1uK5MSaSq=oUUMFdQ@mail.gmail.com>
 <CAFmh=S3x+SsuW79MdN6gE66CSK7smvbBy=22j=c9jGVOns6PiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFmh=S3x+SsuW79MdN6gE66CSK7smvbBy=22j=c9jGVOns6PiA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 22, 2025 at 02:58:34PM +0530, Dixit Parmar wrote:
> On Fri, Aug 22, 2025 at 11:49 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > I don't understand. Don't you have a subscription to linux-iio@ ML?
> > https://lore.kernel.org/linux-iio/CAHp75VdL9kV2fyi63zqPZnW4CaeYPmJ74tmGEgU=M7FSYBv0ww@mail.gmail.com/T/#t
> > If you found something new, please base it on that series as it was
> > already sent and reviewed.

> Thanks. I do have subscription to linux-iio@ML and did check the patch
> series you mentioned.
> That patch series by Xichao Zhao removes dev_err_probe() for -ENOMEM
> cases whereas
> this series is targeting slightly different cleanup of removing the
> plain dev_err() log messages
> that are there for -ENOMEM.

I see, makes sense.

> As far as I can see, both the series are modifying completely
> different driver files without overlapping changes.
> Since the objectives are related but independent and addressing
> different type of change, I thought to keep
> these patches in different patch series and have clear differentiation.
> Although to establish similarity it would have made more sense If I
> would have added the link to that patch series here.

With this clarification it indeed may be applied independently.

-- 
With Best Regards,
Andy Shevchenko



