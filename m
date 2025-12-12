Return-Path: <linux-iio+bounces-27056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5785FCB98D7
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 19:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A5E3063912
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB5F3019CF;
	Fri, 12 Dec 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYbb4AJo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A72FFF84;
	Fri, 12 Dec 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563715; cv=none; b=N42ro8k+9iN4TCIhDl3cbioO4WlB385SMZu6inVyFYUYXM3UWRu44oM4QPL1A6nolLoW9FRc/dRxUCh89Rzh3I4qEluN+ovr5xhdeBExkoQxscI6IR/CZ4a3LFJE0VTpF7IpyaolTzts20buHENHDQniM2IXnCgy7P6WapnG6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563715; c=relaxed/simple;
	bh=GZZ0d7Hml8oMWewK9iqVLDllmfgbMRQkmTkgaGvsdCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvVdYEJQUC1gs9iGJGr2L2RjlYDuL2zIQI6V80sNMriQboIu7ypvU3jpl/S/2fhmkcdZVHGsDyErVEUcvtDkzqstGqPdygVcO7/D+OXRn+2jT8h6zRzBUqK7ROfr7AfowK0IIICxsG9Hofa7VoNUYt2DMW1owcaUnLFlgejBr3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYbb4AJo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765563714; x=1797099714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GZZ0d7Hml8oMWewK9iqVLDllmfgbMRQkmTkgaGvsdCw=;
  b=bYbb4AJo4e4P5W28brC9yO71cyy5xEs2vBAP1TdNPDKFGSVffZ8b+3Xc
   uqaRM8iql849KJYuELH6Qg4k0Hod+rhi+LMNE+FC4Pg3VlKsR5R10xkIO
   KvXaq2FgHsbB5n9wL8x6P8nK4+YtqZ+ZFJDY3UA5e7iYcHjaQQOORKp9R
   J09OD2cAb0ad5eQFhpPK+ZIGfLmvwWO5Hv12A7pHVcyIdIa+zghtyU6Td
   FhecVADYkwI8EwEmp6BrKm7KIWriN8y4F8/FU/qoh2cHfpGIkQIHLnrVA
   rtBjBdsiw4oN77WY3OfBTN3KNSthrMJbCwkRGBiP9O6gWvyPzpGtwllp9
   Q==;
X-CSE-ConnectionGUID: 0usTzu1BSrOaNxrSmXG6dg==
X-CSE-MsgGUID: mXLSA2GPSJmoCcZKkP8efA==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="71432303"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="71432303"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 10:21:53 -0800
X-CSE-ConnectionGUID: s/0KmlBLTlyIFl0U2zBDow==
X-CSE-MsgGUID: Sa6E84rARrasPgSXBSBM5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="201633209"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 10:21:48 -0800
Date: Fri, 12 Dec 2025 20:21:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 1/7] iio: core: Add and export __iio_dev_mode_lock()
Message-ID: <aTxdOiDFqyT8oA3t@smile.fi.intel.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-1-6fb47bdaaf24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211-lock-impr-v2-1-6fb47bdaaf24@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Dec 11, 2025 at 09:45:19PM -0500, Kurt Borja wrote:
> Add infallible wrappers around the internal IIO mode lock.
> 
> As mentioned in the documentation, this is not meant to be used by
> drivers, instead this will aid in the eventual addition of cleanup
> classes around conditional locks.

...

> +EXPORT_SYMBOL_GPL(__iio_dev_mode_lock);

> +EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);

Put them to "IIO_CORE" namespace.

-- 
With Best Regards,
Andy Shevchenko



