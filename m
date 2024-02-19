Return-Path: <linux-iio+bounces-2772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B504085A321
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5681F2560C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9E22D638;
	Mon, 19 Feb 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpmjjmMG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009802C85D
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345475; cv=none; b=eaoM05vRU/KXxo1O7OlKoimjhlKQqHqAs7L83WNcEwd0VLpt9eoURtkPbxPfMJOUrqvr/sCtJbjj3xw/gZHKsPXdXheLRkOg1DAjnMIP1INNmfMguAtr5eQnP+XN4WzIVA+EvTI3+SUoM11CfVW0DVmxfXtfu1u7oMJiys0d/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345475; c=relaxed/simple;
	bh=kgoXYaz6wqxE0szmMcU66ivacRIF/q+hPoFMuYkcm3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mylbFmLQlVD8oHB/a5OeJkyVJo00vYgWEKhABrBx+H2i3JU/QIix7gRIshJh5W8+Rraf4mf4cbAk+TuahcL0PDAMnPOwriZLsrG0wN9n4zhdWtjJOrN4ib54Dj9NvCEUX72qhfDJRp4d/FrbF3dGUGJTRdFXQcM1WnLv//PdvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpmjjmMG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708345474; x=1739881474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kgoXYaz6wqxE0szmMcU66ivacRIF/q+hPoFMuYkcm3U=;
  b=MpmjjmMGDPXHOPc9lDQ1yqzvcri+gqKp5S4Z8ylSHLjnF3q+g/CwPxcT
   Cs3KiY8/jONUMEz/T29wtJy/xupIv0k+QF6qfoNAWWvjDefzPXlphjsEs
   1WT7/hH+4L1ike9IV653kbYdvffr/5IU5PcTUCebOTfRm/nQiXSCSy+9a
   b+bqv3bcSVf8y8tKTUf6bI/XTkFhj0hDvP934Im+A9mFSBf7nqPrMGN/U
   snY3tj29MeMdT1dcDWgtbVsh5fLQRVZ2gRJH6Xg6WbgW2O414RIEYLF3y
   V1ZXjgQ997Pm++5yIqP8c3rTpgouhwxtvKxTcBIYjeOVDkQQRr0Iisc67
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="5383168"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="5383168"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:24:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912866852"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912866852"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:24:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc2hB-00000005omk-3llF;
	Mon, 19 Feb 2024 14:24:29 +0200
Date: Mon, 19 Feb 2024 14:24:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] IIO: Drop incorrect includes of linux/of.h
Message-ID: <ZdNIfangVS5GzKiD@smile.fi.intel.com>
References: <20240218173323.1023703-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218173323.1023703-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 18, 2024 at 05:33:15PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These were false positives when I was looking at which drivers
> should be converted over to fwnode based handling from
> linux/property.h
> 
> None of them use anything defined in linux/of.h, so drop the include
> and include more specific headers (mostly linux/mod_devicetable.h)
> instead.

Simple and important one (makes me not look into unrelated code),
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



