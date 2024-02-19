Return-Path: <linux-iio+bounces-2770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A86A85A2D3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3991E1F21076
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D542D052;
	Mon, 19 Feb 2024 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXdDCKW/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8032C1AE
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344383; cv=none; b=SLUCGkFc78yCxBcFrhfdzue0ZZ/zx4eNlSgOxX2bw3tp3k9rkr8idd9MT3Is3jMk9tPvJTZRq7s7wyXOwcikUGh60vt/SVoXAULRMiDW/5cMiZSRTyiMr/Ulky+Se+TYuLMYecNnyiLLObrXzLDsNHFaAvfijjTng8cyF+4vsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344383; c=relaxed/simple;
	bh=nopoSf0ea4TPTyR9viOv+N5U2ed903puwDXgFhgxhMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCLqPVUvNu1RH46dNy2+FPPxpNTH5tgGIVukym+alQIpKWnPZHJicAPnQhfI0f8PJKFMVR4BeS2Z9Ef2NTk8NKmhWpChSN1hn38z6cPvzOEThpehtXqCgEk5AbKNu1xyScU75/2Nqvc2pHVL5YvAYHnKpu6u3IQltbYtz3RQtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXdDCKW/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708344383; x=1739880383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nopoSf0ea4TPTyR9viOv+N5U2ed903puwDXgFhgxhMw=;
  b=eXdDCKW/kJlM/k7sHvmZ8TdzpvbmTa1aqFZRfZXwSshLrCCP6O5+lgP0
   g0w0gR41+nTM4c8ZtqKJwGtdGs71w5VkGTr9WXE744trFwZ26yGpSZxCK
   QOcnP7luJA8VnZur39iOc+sOez3Qcy2EFItjIu+TmbqWe3rcqCwgLedNE
   9D9vcmWuKhZW9zYTkzL+bndGLx42Qv7G28RaiiNKywS8n72M6FMDwBf7y
   xycSEDoE4qQrEzXd1CIxIpFk2/U33IvP5mzZfgKVbvJVhXtThe4oQTpCg
   29BtwldnC4XT9RdAcbCpJQA6YnqzHaMZg3n6305am/eKNHXwf37uIT2jO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="5381043"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="5381043"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912864147"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912864147"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:06:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc2PX-00000005oYA-1K6t;
	Mon, 19 Feb 2024 14:06:15 +0200
Date: Mon, 19 Feb 2024 14:06:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 8/8] iio: adc: hx711: Switch from of specific to fwnode
 property handling.
Message-ID: <ZdNEN6LR68GCUSqp@smile.fi.intel.com>
References: <20240218172731.1023367-1-jic23@kernel.org>
 <20240218172731.1023367-9-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218172731.1023367-9-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 18, 2024 at 05:27:31PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Allows driver to be used with other firmware types and removes an
> example that might be copied into new IIO drivers.

...

>  	struct device *dev = &pdev->dev;

...

> -	ret = of_property_read_u32(np, "clock-frequency",
> +	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
>  					&hx711_data->clock_frequency);

You have dev, use it!

	ret = device_property_read_u32(dev, "clock-frequency",
					&hx711_data->clock_frequency);

Also seems the indentation of the second line is broken.

-- 
With Best Regards,
Andy Shevchenko



