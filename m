Return-Path: <linux-iio+bounces-17746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEFDA7D99E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE0E1887195
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D693822371F;
	Mon,  7 Apr 2025 09:25:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2C14A82
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017931; cv=none; b=cB2g/qNrElpIbu6VdTcU7CfPNAwyPn0q5NSMh4b1qhgJdJyiteKn7x6FZWSkb6U4mRkmHLtKUpr72pdD25qDpIXHMV+BTNZAVcN32U5ObFWcClbaEYrxLe7NJNEQrz8ZkQWU6KG3FKv1dHyKY8rj/hAqaGYKNCLpY15rMCBpoV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017931; c=relaxed/simple;
	bh=tNZWVu19sLU+/9Chw5VirpZ8WUQWF78Y4fE6dexS/Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPitrSAVflrn/TpF04ceasdFCT+ccrN3ijrRmp4Y59vTi542S5Mp7IVhOZbxph0OtvktRG3LJQw/dNkubzTe1UFxPy1CO/YLzMZkqX2QwMvtK0Rs8pokU63VxPld5Td7jBFnFRJCpOaev24hhrslb9va80MuSAkEbH8yRVkXfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: uGBVXwsBSWy5d5nj1qvaXg==
X-CSE-MsgGUID: cWKZdxkRSR6JFCoaEIl0QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45561838"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45561838"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:25:29 -0700
X-CSE-ConnectionGUID: +Q32XNTcSnqsipPI+113mg==
X-CSE-MsgGUID: fxPV4WArSIGg+/wSXiZBIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="165095295"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:25:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1ijN-0000000A1Au-1rpS;
	Mon, 07 Apr 2025 12:25:25 +0300
Date: Mon, 7 Apr 2025 12:25:25 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 07/20] iio: dummy: Switch to
 iio_push_to_buffers_with_ts() and provide size of storage
Message-ID: <Z_OaBUw3zGrEAy21@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-8-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406172001.2167607-8-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 06:19:48PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Provide the storage size so that the helper can sanity check that it
> is large enough for the configured channels.

...

> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),

> +				    iio_get_time_ns(indio_dev));

It even returns s64! (See the comment to the implementation patch
of _with_ts() call.)

-- 
With Best Regards,
Andy Shevchenko



