Return-Path: <linux-iio+bounces-25609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19FFC19016
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 09:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAA11C8706D
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B105313E34;
	Wed, 29 Oct 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1quZ97a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C15313E22;
	Wed, 29 Oct 2025 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725637; cv=none; b=iA3jBL62bjTRXpFvSFZGilfwp8EBIWA6arX8DMrCqlimUvIKOUP6gtD357hB/dZ94MAETLPj+Oy0J1jsXqYmU4xOv/99P+m/jEk4/d0sO31r8qlrLw2eD6q1r1ha6SOYN4JxXdLahYrCou38z58OlQ5OrEldTsEC6ccCvAWHQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725637; c=relaxed/simple;
	bh=Dzv/pCCsahShivNzdwwnXPDb373keXPupORPmlHLcHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRnbEy4UAP10EwGBCwJRgUzUCmwM/nCv+srZUJIwMHTg4HkJN5NAl3Axom5tPzaQT36LeR7Kja49poX9Gj6tIaJWXU9LEv2ut1D98X0L0XGu9FDfXSw6DcL8dP/ChBsC9/htVEPygrc20k7TzGhl8dLra/k1s+534/PETPHPZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1quZ97a; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761725635; x=1793261635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dzv/pCCsahShivNzdwwnXPDb373keXPupORPmlHLcHA=;
  b=A1quZ97aB2MKdWvYVaMEMvDTZJ9cfqXV1NvLu9u78FtJqPlo0+u8IO4o
   HRTIWJlk6kLk1shjWYXg3q8olOG4GzGt+bJKPpgwEyKSYjUHqi5zZ0YI4
   H1gzdd96j2cLcWUH9/ru2hIapyY36GWbDxx4bgnEVQCUMU+xsa6K8gOvh
   klp8BzYO+4y5gkygpPGySDY4rv6aLfVR6SZ3nPdlNhecV8syu0WN7OJna
   koePKLSMEEhYNgwCrByLN81aGPYUjnB3UbvpLToX4Zklnnw+SpicNa83W
   ucs+ZStHXZ2mVIDinka4Ct6dQ7MaqgZEiOmZbflO4V+/Y/Eesn9SMm0Dv
   w==;
X-CSE-ConnectionGUID: /RfdCP+uT8KhvuK3XoIq+w==
X-CSE-MsgGUID: URZ9qdm5SMu5lM3P488PYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67675818"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67675818"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 01:13:55 -0700
X-CSE-ConnectionGUID: TrhRsUlVSxmcy34w0n0yTQ==
X-CSE-MsgGUID: hXGR3vlTSZO3A2t9pb8FSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="216247061"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.248])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 01:13:53 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vE1JW-00000003YGY-0x7h;
	Wed, 29 Oct 2025 10:13:50 +0200
Date: Wed, 29 Oct 2025 10:13:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	"open list:IIO BACKEND FRAMEWORK" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, shuah@kernel.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] iio: backend: document @chan in
 iio_backend_oversampling_ratio_set kernel-doc comment
Message-ID: <aQHMvdQXD4eRvPSV@smile.fi.intel.com>
References: <20251029075117.104758-1-hsukrut3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029075117.104758-1-hsukrut3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 01:21:16PM +0530, Sukrut Heroorkar wrote:
> Buidling with W=1 reports:
> Warning: drivers/iio/industrialio-backend.c:727 function parameter 'chan'
> not described in 'iio_backend_oversampling_ratio_set'
> 
> The @chan parameter was added when iio_backend_oversampling_ratio_set() was
> updated so the contexts could specify the channel, but the parameter was
> never documented. Document @chan to silence this warning.

There is already more comprehensive patch available:
https://lore.kernel.org/linux-iio/20251028093326.1087660-1-kriish.sharma2006@gmail.com/

-- 
With Best Regards,
Andy Shevchenko



