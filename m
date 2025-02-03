Return-Path: <linux-iio+bounces-14894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D9CA2564E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E756D3A9A12
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B261FFC6B;
	Mon,  3 Feb 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1D9ePu3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4691FF7D8;
	Mon,  3 Feb 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576335; cv=none; b=D4WS1Zn42fsk2nptY7o6mFRujXSakzUvIguCKI3ZefnASEbi5liR9JBWqj5jO0S8KDWPZWAdh1q9ntwu5zhFU0gUqr2Bon4R4jriLqacH38PtsHmhNrquOxkx5ZfUFQh5mNeDE6lSP7AIzd/VhfFFwqpyopmJCmxw59Vb0T8jJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576335; c=relaxed/simple;
	bh=cblmMUJNiPz4UQllEox9b1hEz0MRKGnRBsoBx+6v+14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmnDbRdHRcNFMT+IcumsrVcJ5Bc/yVHaGSMLb4+cMWVCEj1KH3XVl8N2gBteCZxHP68Ex+p4X+p+ie3t9Sy7wp7ZwKZcA7fqe2YTiwajqAvjwOaTkuhFtBVIEKHsNXksKkVNoqziUiSQzw7m+9rTJJzIUxMeHKK2o8oDjCHfbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1D9ePu3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738576334; x=1770112334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cblmMUJNiPz4UQllEox9b1hEz0MRKGnRBsoBx+6v+14=;
  b=V1D9ePu3GXSOIZxAnPompSiWGLDhDyRh4ULBG9aC4W5KxYageTTBRlDT
   KIjdbO/Ln2PNDflOlxgp6OZUFr/o7qjoCzfMgOB8zWaqfFf/LrLoimoHq
   C1strADtE5tYXU4/llVlc5QkRN40c8P+UFGy4zKJzLEvzE4Zmks0g/tHi
   wO/29aw9Czw3tL3S7pV2w1BU6eTII2xmKs1N1XZ5ejleg6WDO9O6eziRF
   3xvdbrGCtA7jtNfdPSyPhdTx7cZPQSqoJMN3Gn1Wq3I53vVM4YDoFJdsl
   lYJViXGgfCzXQi+b3un4E3JL/ZRZ1C56sV6Cov/bxBoxUwBPqW6EVKrk/
   A==;
X-CSE-ConnectionGUID: j6msojXmSkyS9m9DLM4DMw==
X-CSE-MsgGUID: iXBVrLP7SVSD1ekihSj5Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="39216035"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="39216035"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:52:13 -0800
X-CSE-ConnectionGUID: 4O1EirNkQqSB7l13kBm7BA==
X-CSE-MsgGUID: V2WX8eFlRsu+0NnUDE++Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110189359"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:52:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tet7d-00000007n1K-3W0n;
	Mon, 03 Feb 2025 11:52:05 +0200
Date: Mon, 3 Feb 2025 11:52:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 16/20] ASoC: hdac_hdmi: use devm_kmemdup_array()
Message-ID: <Z6CRxUpEU--tVsgO@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-17-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203080902.1864382-17-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 01:38:58PM +0530, Raag Jadav wrote:
> Convert to use devm_kmemdup_array() which is more robust.

...

> -	se->texts = devm_kmemdup(&hdev->dev, items,
> -			(num_items  * sizeof(char *)), GFP_KERNEL);
> +	se->texts = devm_kmemdup_array(&hdev->dev, items, num_items, sizeof(char *), GFP_KERNEL);

In similar way, sizeof(*se->texts) ?

>  	if (!se->texts)
>  		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



