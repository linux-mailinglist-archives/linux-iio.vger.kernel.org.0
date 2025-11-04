Return-Path: <linux-iio+bounces-25900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EDDC32AB2
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 19:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E925A4EDF8C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFB133F38A;
	Tue,  4 Nov 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMERt/Hl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400733DEFD;
	Tue,  4 Nov 2025 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281052; cv=none; b=sWSOQarZgs/EpeXpdhZH/bIWxXM4zPPxymT5oB69XKV9D8zjAG92s/OrSvHyBWoM+hoBaCR17ATIIAZbh6jH4Up+5o5hPfJKhmPwzbU7cgH6wf9BmouRq3tMvvpHPNXbpOJG9qXf0nlPrfNWDmh/DbKheBNBi6WHFEDt6Xi8k/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281052; c=relaxed/simple;
	bh=Qlai3qLuQNOu4KzGnV/Jtu2hZ5VjKCz/wbHIZNh7rLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwzDH364it2g6Fy5DLsb1N1pHyTH5SbY2rFUDoJfStC/4o0qLsFGbbMsR0dapxHx/h0+EFSDJKIsnJkeAdzu6rp7dRWm8y/VADICThqBsmczJJf0dpjhN78jbjN9ylG5Yzd65O4CddozJO4YHPCoavIEXwn5yLIjm2pP7mrumMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMERt/Hl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762281051; x=1793817051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Qlai3qLuQNOu4KzGnV/Jtu2hZ5VjKCz/wbHIZNh7rLM=;
  b=AMERt/HlOTcI71RfC3X28GF10RBtm/6Y1C6TSCp8YNbWYOaD7PPLi1I1
   xdVQ1/NgDvAEcliCNlyGenOruj4cXTf8JtASTbBYbUhGj8cdVlC1ytJdi
   aDHwERO3/TCKUDzbRTNaqOzREbyVg0B/XAjHSnHGjTWtBJ+ETJ59ce1j9
   UquOmHjsCVGgsSRmuoAroeqrkjshcZT6DBalrUVsAKp4moDJ6MpXS49YE
   vwCegzpplErFQyV1mgjYrqJKHOYWVvvYHRQf0o6cKwp+Wz5PBBh6oLuxL
   9+0EaTEa+OEmykPMszDNAi/G7PMLYweLae11qcqpq940OcwcyzaoQdMSt
   w==;
X-CSE-ConnectionGUID: 6ahjcVUFRGiaJ9NaA0zzwg==
X-CSE-MsgGUID: F9ej7Ud/S1S2jTurndxrVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="67001816"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="67001816"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:30:50 -0800
X-CSE-ConnectionGUID: eRJ9mlW1S16XUbdhP6r7HA==
X-CSE-MsgGUID: dnD9Gw+DTraXq1kNRnhekQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187961081"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:30:48 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGLnp-00000005Xhm-2Cix;
	Tue, 04 Nov 2025 20:30:45 +0200
Date: Tue, 4 Nov 2025 20:30:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 00/12] iio: dac: ad5446: Refactor and add support for
 AD5542
Message-ID: <aQpGVYlOcYkSuIRo@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 03:35:05PM +0000, Nuno Sá via B4 Relay wrote:
> Alright, what was suposed to be a simple one liner patch ended up being
> a full refactor (modernization) of the whole thing :). I think the
> changes are anyways fairly simple so hopefully nothing was broken.
> 
> I'm also aware of the checkpatch failure in Patch 7 ("iio: dac: ad5446:
> Separate I2C/SPI into different drivers") but I'm really not seeing the
> added value of adding the kconfig help text to the core symbol. 

I don't see any major issue with the series, just a bunch of minor nit-picks.
FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>


-- 
With Best Regards,
Andy Shevchenko



