Return-Path: <linux-iio+bounces-13389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2509EE8FA
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 15:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786681631F1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66F62153C3;
	Thu, 12 Dec 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLi6SZHd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F02144A8;
	Thu, 12 Dec 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014104; cv=none; b=skM/S5hBm1iwIOJPdFXH7U1wc/sWOVBiRfvdCVwzOBYwk0ZzEidiKgwQ5a7YGKmSkQm1vrYnleDJoifBF3U8z00hJ4m9IkH5WLMtmfRrgjSqRzvruouSP6TUJ7HVDwiv012QAY3yhQ/cazRYFZmxG1OhN5YTdYcQ/snwijk0LZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014104; c=relaxed/simple;
	bh=wKL6O0V8PlpwI/SZUcYNFrhlk9RIxopn6lR3SDGOjys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf/qOPHm2Aeb2fwnl6O7ybO7HAgcfJ8PFC88JDbxhpk+/Rk9/3fsBOHimAFoaEoror+fhlbJ8S/TR4cwzlSk8tiu3wjKshm6odITtGyT+utZGzse51NtGzTqWPsDNZHgp4pJImgzzR9rDuucgWljXNx9ENrCQmajOg6bY420nvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLi6SZHd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734014103; x=1765550103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wKL6O0V8PlpwI/SZUcYNFrhlk9RIxopn6lR3SDGOjys=;
  b=lLi6SZHd6dWqMbJdMkSH+IztfRULpRpCMpN6vtGEzKMxBpsC2woLO6o8
   P2SPbKShnqT+tqlPSCukOPKe51DXslPuLW9TPXftGywYieNoJAxxzYKaa
   ZqsXofrkJieY4Qzz6v6d1LzGein3kLC9CwZDHcMzXw/1ClFwBkCDIK+ko
   5LflHBDNNASXRxvCUWB5sVe0KKkzuSewp16nK9P4JdvY8Yu5g1AT19lJG
   Mqnaf867rhAJVFtQQRmsPPO9d3X7f6sRcl3W5x+kBJPwUYT+ows7OIZTD
   q0KlwBz6RSvqQ5FWfXqpKDC/cRxw4L5qnZH1MeCQdPARHhExh6icLIKUp
   g==;
X-CSE-ConnectionGUID: ON/UNsUDQXeNK2XkuVAvyQ==
X-CSE-MsgGUID: GDuo9hSjTmqo3P5Mu7/L2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45039713"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="45039713"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:35:02 -0800
X-CSE-ConnectionGUID: 7c1UhcIWQLa7l0U6S0Pt9g==
X-CSE-MsgGUID: kCJ/UkwvTQOQFEG0nfpLAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96690584"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:35:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tLkHK-00000006vJV-33H9;
	Thu, 12 Dec 2024 16:34:58 +0200
Date: Thu, 12 Dec 2024 16:34:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 0/2] driver core: move devres APIs to a separate header
Message-ID: <Z1r0kkNh1R97T5e0@smile.fi.intel.com>
References: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 03, 2024 at 09:48:50PM +0200, Andy Shevchenko wrote:
> There are a lot of devm_*() APIs defined in the device.h and sometimes either
> the rest of the device.h is in use or only stuff from (new) devres.h.
> Especially helpful to have it separated for the headers that want to use
> devm_add_action_or_reset() or similar APIs in inline functions.
> 
> I don't mind any subsystem in question to take it (IIO or driver core), but
> I would need an immutable branch/tag since there is a pending series that
> adds yet another devm_*() into the device.h and supposed to go via one of
> mine trees. Of course it would be possible to route that series via another
> tree.

FWIW, the mentioned change that may influence this series (and vice versa)
is https://lore.kernel.org/r/20241126172240.6044-1-raag.jadav@intel.com.

-- 
With Best Regards,
Andy Shevchenko



