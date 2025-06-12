Return-Path: <linux-iio+bounces-20551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30353AD7115
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 15:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34163A7C9D
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E505923D280;
	Thu, 12 Jun 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXBx/gTW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949E23C8AA;
	Thu, 12 Jun 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733468; cv=none; b=iEQPiMhcHuXvPv9b4zuDj4wCamH7/+UulhoXtsoDxOAaP8Ff3mdEz6E/aHKCaUdjecpLXw7/SlU+KQR4JCWrPv63jDt5mXT9uJpqo8n3KhxFoNGd6OOwprGjvJvVohFAMSYxiBITs2HWd4vjYtuURgVwRqmPbLLgBQlg1sNdO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733468; c=relaxed/simple;
	bh=VsjpuMxJdphetYvirF1+2jsleRh+qXWpUmmPzT9VbMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkYHBM8xae5QemR1CIvr6n4Y0nbvT2ufA0x25nR2dybYsL9w0JTHU2kIq8EDDpbxqIhiSfUvR6jqtnWCkLkoGEWUjzPCbmhmkcFNxsofbCDOA/2hPDRNIGzFocuwUSKLG6x9K8xbN5AoKYfJFick6vnQmLKIO0Fc+oRwsI156/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXBx/gTW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749733467; x=1781269467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VsjpuMxJdphetYvirF1+2jsleRh+qXWpUmmPzT9VbMY=;
  b=BXBx/gTWZjh4AXvbi211LA6Cu2w8iSwUgOchW+8r9PL1aTiRWC+mtYLi
   athbHL8cFHIlK333KwvUP96JaT0NYmcNXMwW0D05kqf+0E5o042lQ+6Lj
   aaSZ7SOOEyNQZdDlklSHqT9PLBuv8fDMs/ErCSH9DnvG7vJRhQcxRu0Nc
   AGBscoh/Tykm1Vyxh2dkhcpO+KVmRh58Pm6rNLGqvCi/3lqwoi8bnfU8C
   UI2zOEnWLS4q7iIOf74sat5AaCUR7Vni2z7oGFRFHVR+96QIjvvm1sXbY
   iHNL2Jem5kq5Rn8wyDdFRugzc2ddrprhjQim3dSZRnRrq+l4zwes6HIWp
   w==;
X-CSE-ConnectionGUID: cHQAU4H4Sj6FITgUqu43wA==
X-CSE-MsgGUID: B6bLKz8tRx6pSccuIpYfng==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51017567"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="51017567"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:04:26 -0700
X-CSE-ConnectionGUID: 3BFy9XZpTsCOmIwIX23i2w==
X-CSE-MsgGUID: xVSGvdEtTvCeaqwAJdMTAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147386394"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:04:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPhbQ-00000005xIv-2abY;
	Thu, 12 Jun 2025 16:04:20 +0300
Date: Thu, 12 Jun 2025 16:04:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iio: amplifiers: ada4250: move offset_uv in struct
Message-ID: <aErQVKul7Gnxvu3F@smile.fi.intel.com>
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
 <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-4-bf85ddea79f2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-4-bf85ddea79f2@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 04:33:04PM -0500, David Lechner wrote:
> Move offset_uv in struct ada4250_state. This keeps things logically
> grouped and reduces holes in the struct.

Can the (smallest part of) the diff for `pahole` runs be added here?

-- 
With Best Regards,
Andy Shevchenko



