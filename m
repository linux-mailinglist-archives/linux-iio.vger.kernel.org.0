Return-Path: <linux-iio+bounces-19662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7416EABBB65
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 12:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A45189754E
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE8D1FBC91;
	Mon, 19 May 2025 10:46:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1782CB67A;
	Mon, 19 May 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651585; cv=none; b=pSZsn4tqBfpAOPIjsP7gI5mAjL9X8U4WXzCTgR9uxJ6HeFNujN+pRPAxfckqcLf+C/f+rEGbDLkwvsk2/ffhfMQaHsiCAGe3l5fqN18r5usonRGF9Ppa1FhcAlkFzA5fKx9OGi/t4lH6hMI3ZjS/Ja/6Cb2s0f/1n+zaIUPpGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651585; c=relaxed/simple;
	bh=ivoiezpKvDWWmCC3jV7hu/l1TPKoNsTLHK0yTzRFFzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb3K6drsMgjZ6kVz43daolIZVMYgT42joDu6DS7zPTcW1vXE/anDvQTnScFiCF7UgCtrmanfA5xXZvMgK7nb8vqy46wDIvq4roorcepWHkYQzqs0N1LxoX7QYXvkTsfm72wnpMjwT4HJhsIA284s3nlyreB/h6tW5ge9SxiI+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: DuhN3gZ8SqaTMFjZpKf6iw==
X-CSE-MsgGUID: 70740P7NQAqQQUSW6IC60w==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="53359423"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="53359423"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 03:46:23 -0700
X-CSE-ConnectionGUID: +GMYtUHATsqdoX+kfzkg7g==
X-CSE-MsgGUID: 4f2eFuH/SayEv5D/ryKnqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139238419"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 03:46:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uGy0f-00000002zZp-1bAH;
	Mon, 19 May 2025 13:46:17 +0300
Date: Mon, 19 May 2025 13:46:17 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/12] iio: accel: adxl313: introduce channel
 scan_index
Message-ID: <aCsL-VOnD6TgC3lF@smile.fi.intel.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
 <20250518111321.75226-3-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518111321.75226-3-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 18, 2025 at 11:13:11AM +0000, Lothar Rubusch wrote:
> Add a scan_mask and scan_index to the iio channel. The scan_index
> prepares the buffer usage.

...

> +enum adxl313_chans {
> +	chan_x, chan_y, chan_z

Please, keep trailing comma in this (when it's multi-line assignment) case.

> +};

-- 
With Best Regards,
Andy Shevchenko



