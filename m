Return-Path: <linux-iio+bounces-24158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E97B59760
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754123B85CB
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6CF307AD5;
	Tue, 16 Sep 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtxF34Bt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC6625;
	Tue, 16 Sep 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028831; cv=none; b=gNAcfJzHQTSmzVPvj2FzLK0nMG1TMNQKiq43AUpSqtH2NW4wBw+ieTjfvW6Da0BLZ93RGJOMYyQ7FBteAQkLZJ92U4bWbnK8j1/VLXedHWKFxaw3BfM9pm40Jl7DT3n8IHNNNzJI+g47tBfGNOgCm2/F5UnX1A5XAn9qy1xk5hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028831; c=relaxed/simple;
	bh=gSOzalppVW+Cs4aEMq5xGn/SpYraHmgemFo8kPlu0Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ugxh3zKJCe4eqlzTpgW2HXStdDxoz/pJQQlbbANneU2KUPFQINW1KQvdPq3vqYb9TMDujTUwrjCOgrH4fSPSKu/WaDHWLpyiMbjz3/8de5kVwKTVcI5L6fevgB9ORkKZ5ECuZv9MIH37TjZeeSXaUvN80znyjIfpUuIQh6VqBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtxF34Bt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758028830; x=1789564830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gSOzalppVW+Cs4aEMq5xGn/SpYraHmgemFo8kPlu0Dw=;
  b=mtxF34Btx8vYUBi8M5ImJEGYW58YCqPBEAW7r+UvUnZwvWQqE8MD+DPJ
   fugDNC0mJYAUx8JfhO5nAXOX6aMvJ6x3FiIbHIG8ojGfUWOvB+1gQB1Jf
   ogu5nTp3RTHqmuMlTq42ylJbwsXQ9k7C0aQjqYhTxoFNaBgrFnOQF6aJj
   AQiEabNCrU1fTayoaBrkc9ypFYrdU9jNfkYEpWy8gXL81Lx16yXeUmK++
   LrNs9UjSZq/4ZMA2p8FdTZ4aniWsWx3pIBxK96kLjw80okPv7hmN6ovSn
   Af6abnepg2zxjhaMkxsvZ17yOex/T0hTVCv/x/etRDEbofaIU+O41VbFl
   g==;
X-CSE-ConnectionGUID: b/C0DjmLRquNnIJlEr3NuQ==
X-CSE-MsgGUID: kvqIs9/WQUO3iQjA8yvpwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60367007"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60367007"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:20:29 -0700
X-CSE-ConnectionGUID: 7te56LYIRSmrUXVyTGQj2Q==
X-CSE-MsgGUID: Z/f947bGRZmbsf9xhKnqjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="198629465"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:20:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uyVbb-00000003XEH-0HQG;
	Tue, 16 Sep 2025 16:20:23 +0300
Date: Tue, 16 Sep 2025 16:20:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] regulator: Support the LTM8054 voltage regulator
Message-ID: <aMlkFka1cm0qv9Bj@smile.fi.intel.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-3-fd4e781d33b9@bootlin.com>
 <aMliRTuUDNPkeM8C@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMliRTuUDNPkeM8C@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 04:12:37PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 12:24:08PM +0200, Romain Gantois wrote:

...

> there are also many headers are missing here, but Mark
> usually not insisting in following IWYU principle [1])

Forgot to put a link: https://include-what-you-use.org/

-- 
With Best Regards,
Andy Shevchenko



