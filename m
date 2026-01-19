Return-Path: <linux-iio+bounces-27939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCADD3A0FA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 09:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD15F30424A4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6155933ADB7;
	Mon, 19 Jan 2026 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6PVXBuz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730F28689B;
	Mon, 19 Jan 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809992; cv=none; b=N9CtpCjjYKdDI9Db66LQ14JXpcF5xDbnH3+uI7/5rCBcN5KNBY4D54eiPYpljZ3NLsv0fi0lErxc57Sj3EjGjtN3LdfEjYkhWgBwf6POH+eve9L4m71oIhFLRya+E6UwGuITk8MXKwc0HorS4q268roSkGBIkTJCphgsgMjNMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809992; c=relaxed/simple;
	bh=KGfaON/5n2j4ENdZ4gm/rIt6u9utVZr1cqN0yldg69U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxShBpSRDRM54VN5X2cpainqH98oZlmhnTpsUwH28v1TImXNi6z9rEctLe1DzZ8HBu3HMrOAvzvg8o8WGKN+sxqqj8aU9aVxE2uvabQl6DfVgviBHjjGfDlBQGWRGL7MBtdaNcYmVCkENyAOtLvPsOlsVyyrK1EhoJQu+M4EFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6PVXBuz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768809990; x=1800345990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KGfaON/5n2j4ENdZ4gm/rIt6u9utVZr1cqN0yldg69U=;
  b=e6PVXBuzRcdyOV9W3N0RGB02F5nEEEuHPy1Zk4znlYOE57R12aN/56vl
   tikpUxI01KqmZoMKNClVS+mtXTsKRAw7HXK0XD6B9zH6nEfEwkMKPQ6lc
   87JWRzHZ40lVKkBeS/3b+lON5i8ILTciR9dune77+Y5GLGZgve8rxBKDi
   nEVR+jS4t5ZHkPx0yzqE3hN9TcRjMWQ0x0MirIDyN0Wf4nUbq1EegCYph
   ExiTSR/NMkvPMiYIi1qZ3HCGS8AvOQaE2hwo2Q8aoMH8Teyd6R5qzIjOf
   Kl3lXiV71CdJvaqPKIXTXITn3kWjUKUaB32VxvcQGhuT5MShD9sgeQR6S
   Q==;
X-CSE-ConnectionGUID: 6kbo06TvSw+OkqcnrkHvdw==
X-CSE-MsgGUID: elegBdKoR1q5YJGGYDIlxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="87594581"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="87594581"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 00:06:30 -0800
X-CSE-ConnectionGUID: 8pz+SPe9Q/Ci4g5E2gVxiw==
X-CSE-MsgGUID: lTt1woeDSyaIw3AnKd/LFQ==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 00:06:26 -0800
Date: Mon, 19 Jan 2026 10:06:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jonath4nns@gmail.com
Subject: Re: [PATCH v6 5/5] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <aW3mAIqHti3T5DSK@smile.fi.intel.com>
References: <cover.1768350772.git.Jonathan.Santos@analog.com>
 <fd9acf8fca67679a33441ea18d1d06b2aa2c5fad.1768350772.git.Jonathan.Santos@analog.com>
 <20260116185200.38be8bc7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116185200.38be8bc7@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 16, 2026 at 06:52:00PM +0000, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 06:27:29 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:

...

> If nothing else comes up I can do that whilst applying
> (I'll wait on Andy having a chance to sanity check the PERMYRIAD stuff anyway).

Fine with me, just one more thought about it, perhaps it's good to add a
reference to Wikipedia article in the comment there as well:

  ...
   *
   * See details on https://en.wikipedia.org/wiki/Percentage.
   *
  ...


-- 
With Best Regards,
Andy Shevchenko



