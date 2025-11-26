Return-Path: <linux-iio+bounces-26478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1045FC8852F
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 07:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8225D3AA1F5
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35DB3164CD;
	Wed, 26 Nov 2025 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRQi91TJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B02F7AB4;
	Wed, 26 Nov 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764139995; cv=none; b=E2T1IDbyhyp8w9k+HsDsLJ/QUNhf6aJsie1Sm6djKSOQjyUoukywk4wF5Ez+6mxee8vLlbeJPuhxL7EHYTNPwfdIlbdS1eauitu84iNsuFR04/Obuz6mZzWBr3mCx5hR7aoHqeLVXAU57HOu1S2gCThCDxxndfyu6rNsdcr9qF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764139995; c=relaxed/simple;
	bh=Z497ci9nj23V64oPGTudBOjsX0eN/e6sYS5h22BjAgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxrjyeDgQHYZB+zHt6V6oyKXCW/NF2lJPnrq05PrVgkQKWb+qNA0Lttz46pvIoYyx7o53vKi7KSjz2TlDDb9FsgF7sXpMnxtWHw9M0XrnFUkWJx9P9biWwWzSHxJvypsLYmsUR3vZFc6IIX9qWbgtvXko8HUUhxdbOt5M9MpCrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRQi91TJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764139993; x=1795675993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z497ci9nj23V64oPGTudBOjsX0eN/e6sYS5h22BjAgQ=;
  b=lRQi91TJRlGM/+HeCYvYiwRQpvJdpe2IVM4Ebc0/rmu3rChU3z2oc0+W
   ReRZTntzZps5vohroM3RSej26t4fsFpzF3Qi1Dgk7rpiAOFA8Fy/NslmT
   0mIupHnaBkz6H7S1x/vIc6UjT63u3gXCQpe7x713XTB4wb2845l+tdTcC
   w2gnMCORsDqzISpy0vwmTyJ+wFQATni7GibojKyjIIzPQw4UdXCJB/Qjs
   a2usYtfmMujOG7Ybos8C9OV8WZnoht5/LGg5AKgb2qsSDb0vnyexhvSjs
   8S+t85rHLpWa5fP4kvTR4bNDVfdFZwM4WyYb34FncpLZ9VeEWvhclfzYt
   A==;
X-CSE-ConnectionGUID: RP0wnxVeRiOT8ZtUKopvQw==
X-CSE-MsgGUID: tuyWRFWpRGGFqjp11z8MKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="76851888"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="76851888"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 22:53:13 -0800
X-CSE-ConnectionGUID: PSbkwSM7QmeoMDly3/PjeA==
X-CSE-MsgGUID: WbQtaleRQfKDc2ElgH3+ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="223825694"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.22])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 22:53:09 -0800
Date: Wed, 26 Nov 2025 08:53:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, heiko@sntech.de, neil.armstrong@linaro.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: proximity: rfd77402: Add Device Tree support
Message-ID: <aSaj08GXiNwDM2Xz@smile.fi.intel.com>
References: <20251126031440.30065-1-raskar.shree97@gmail.com>
 <20251126031440.30065-3-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126031440.30065-3-raskar.shree97@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 08:44:39AM +0530, Shrikant Raskar wrote:
> This patch enables seamless integration of the RFD77402 ToF sensor
> on platforms that use Device Tree for hardware description

Missing period at the end. Otherwise LGTM.


-- 
With Best Regards,
Andy Shevchenko



