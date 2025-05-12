Return-Path: <linux-iio+bounces-19456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD400AB3250
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A2C16C386
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B31825A2A9;
	Mon, 12 May 2025 08:55:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2DE25A2A6
	for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040137; cv=none; b=FC2BBriauOld2+uYYNiMMTWyGvjPQG4HqmXDof0GsjgNwS5yYPIfF+M/ziTlf9sxqXERhkkkbYpKJslnXKh8nCTnbVVNgpBFXVC49/kOlWMYMBSflrhalxCimDB3Iy4o5/kO3An8uZTfRToxbkXil08MG4Us9HK5OEOI56NHJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040137; c=relaxed/simple;
	bh=9t08BXFE+hJZrSU1PZK1AvgGsUcwcwg1wJsvAQyIjtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+hR2FJiDXtnON8qKCoRawm69IJdUF66Xa6VP3NUuEMQrxYOmPc6BLBIPmKnh8L5xhFYMC/30no5TfPUJkAX38YpMhRx+Wcp5bdtT22DaSpxLnhrkV0R83qqWK1Ab+HZQBDyXYHn75lB8vCj5UuiPdIRoqQoQWWYMZeRV4RhyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: v/i0xB+fRYyEgCOGhWbrJA==
X-CSE-MsgGUID: nb6KJFsyRDO5GuyK889JXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="74220251"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="74220251"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 01:55:35 -0700
X-CSE-ConnectionGUID: G5MJAN/eSHGWUeSh89Zf/A==
X-CSE-MsgGUID: 6W7MH6llQyCw9YCLb0wByw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="137162781"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 01:55:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uEOwc-00000000rrg-0Ijc;
	Mon, 12 May 2025 11:55:30 +0300
Date: Mon, 12 May 2025 11:55:29 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Subject: Re: [PATCH 2/2] iio: bmi160: suspend and resume triggering on
 relevant pm operations
Message-ID: <aCG3gSSWX0-2hfOO@smile.fi.intel.com>
References: <20250509171526.7842-1-benato.denis96@gmail.com>
 <20250509171526.7842-3-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509171526.7842-3-benato.denis96@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 09, 2025 at 07:15:26PM +0200, Denis Benato wrote:
> Prevent triggers from stop working after the device has entered sleep:
> use iio_device_suspend_triggering and iio_device_resume_triggering helpers.

Same comments as per previous patch.

-- 
With Best Regards,
Andy Shevchenko



