Return-Path: <linux-iio+bounces-25425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0516EC074EE
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 18:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C38400FBF
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 16:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20824E4A1;
	Fri, 24 Oct 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3290crd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88F326D53;
	Fri, 24 Oct 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323349; cv=none; b=N4JHjMd8+XSIf3wZTD2ohlcRwmM+FgvuBOUVwbASNJvIhw1iUX49Uv3T5HUXKDpMFjwoTlvUgqFmsonLrnwI6Ahp8izuUMeFT16NPTW4J3WG/vfsf0R2SwJsEle5TPc9O+GhBpEtlzY1aiuqK+EUvClzdoEPSP5NDQQgZbI+0mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323349; c=relaxed/simple;
	bh=uT+YrAtnUKFxPpK6nxQRK2qpk2y5ugD7UPA8lAvrjeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXiWSS/+FRgB6EYz/0VEGAqArW08rmqerwLGmZnpMWdmgB8fzz2mMRwsVu7NyU2eg0UyR6lTEMpFw5XrqWamjG1jWkQ+H5RNPlbqkwe89p7dPB65CSN/Tec7WPxnvpO4z4K6qlH3bxvj7jqJXD44vaH28l6cg/4GmW1Bnd9PYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3290crd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761323348; x=1792859348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uT+YrAtnUKFxPpK6nxQRK2qpk2y5ugD7UPA8lAvrjeQ=;
  b=M3290crd0rus0eNOK3wxtk0l44LE6dwcqHvHmuuOnIi00ITvgbPH6ncD
   x6OuN/amt7BqbpWN3UGzXMomFr+V1JlttNWNZWnu97vYoRSge3cxg6nNT
   7b7krG1HEumjKC+nXClu0QW7L+HilB0yVBIvROQB6IVtEAbHr2gnJE25U
   GKzvt2yG5ywIIR2E/VwBYS1RZc+Q6zXqBs9BiDrSfo000OXZDDmmYa+oY
   VyOb23HL973YSzmiTofg0WJotTgdD8csPgQO9mw2kr7JUlmmgHAaoSzDU
   dsyeLH9n5d8BKvB9dHVg8k3jLNMX3O9n/2nvtOfta3SdcnEal3xRxE3x0
   Q==;
X-CSE-ConnectionGUID: 8qZIow+iQ4+xrXJVcVv2ZA==
X-CSE-MsgGUID: qnqCecJlRCinKzu20GIcGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63210536"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="63210536"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 09:29:06 -0700
X-CSE-ConnectionGUID: /yydXxvoQKakefwUifKqZA==
X-CSE-MsgGUID: 6BHnQKAxQR2jk2PIf162GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="184384565"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 09:29:03 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vCKez-00000002D7O-0OIk;
	Fri, 24 Oct 2025 19:29:01 +0300
Date: Fri, 24 Oct 2025 19:29:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: dac: ad5456: Add missing DT compatibles
Message-ID: <aPupTHhbvvMq4c7I@smile.fi.intel.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
 <20251023-ad5446-bindings-v2-2-27fab9891e86@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251023-ad5446-bindings-v2-2-27fab9891e86@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 23, 2025 at 02:01:38PM +0300, Nuno Sá wrote:
> Add missing of_device_id compatibles for the i2c and spi drivers.

How does it work at all? Is there an ugly ifdeferry? No module should have two
module_*_driver() and other stuff.

-- 
With Best Regards,
Andy Shevchenko



