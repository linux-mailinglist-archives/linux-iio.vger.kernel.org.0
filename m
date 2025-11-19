Return-Path: <linux-iio+bounces-26318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED7DC6FF76
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 17:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6ACBA3A8218
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131CF36E55E;
	Wed, 19 Nov 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkjeXlf3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554636E575;
	Wed, 19 Nov 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567909; cv=none; b=RS8r+fM/LA1jgxSk17c6FvExFP/ksA0ke3TE8rpk7MWnRoR6KfeupQN5Fco2hUMxJlYTtwprismWfS/52SGXIJafEuu9bSM9UI5gILanlocaFiqKzmUmrGogn6iOaakTVhMUhc8UZvUHTS6ONQxz3Dd8ZTL8kgWyHJDtQLX2ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567909; c=relaxed/simple;
	bh=mjsTWSnRr7lGCQg1/uTCVXVJKVn6B2SqCh5DqRGiSs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot6P4BWQFZIkwwxDk5lCIBee2cX2AebyPuBMucD5DIB6w+Jt6Vqyk08BvwIjw6/Zm7JIoFvb2/lhAdH50c5sKXh3EcyNROmLRqmUud6uTDh+2JYDlDWRIOoKvf/vU54Zk2ldDWZu4RS3PbH6WxOdBKBUm1QOmZZMJtSgViOfF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkjeXlf3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763567908; x=1795103908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mjsTWSnRr7lGCQg1/uTCVXVJKVn6B2SqCh5DqRGiSs8=;
  b=bkjeXlf3JbOp90vWXfBHcy6+PdcSGncS5XtKqsvIJpsJO4uJKIwDmAFD
   TVYP62mSmBnQybRi3pkQlBaZF+3+nQyOq8DUKibmRgb3S7LWQtH1bNV+X
   taS8zMb+u8JEDccKQ05GkwuROxtEWar+YMJc8MeJmxFHAhBlFcyYQM1YU
   pKO5DUAudF8v2sF2/Df5bKIve+vHVQj2IVOPcvV3Y/yMs3FAovhR1IFgC
   141d6XZyHFNMEf0rgXk+r09erAsamS8I+YdXh9Wx71hEsxdcWlIz3AoAY
   S14wU/++Befb8cg3AFH7TY9khgieSihOVI3A09puewyMbsVRo/n7gMwar
   Q==;
X-CSE-ConnectionGUID: vTVCDyU3TqST0SnDi3peLw==
X-CSE-MsgGUID: eajTyhQvS22iPCYIy/lofQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65647017"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65647017"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 07:58:28 -0800
X-CSE-ConnectionGUID: 4KZTxpf4Q963/vB8ThHCAg==
X-CSE-MsgGUID: dQkV7QBXRRG2V33oyHD3Pw==
X-ExtLoop1: 1
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 07:58:24 -0800
Date: Wed, 19 Nov 2025 17:58:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana.Lazar@microchip.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, linux-kernel@vger.kernel.org, andy@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/2] iio: adc: adding support for PAC1711
Message-ID: <aR3pHtpdfnqcPahC@smile.fi.intel.com>
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
 <20251015-pac1711-v1-2-976949e36367@microchip.com>
 <20251019112846.774d7690@jic23-huawei>
 <9741143f091acf1a2791ced6ea26f5cac720a283.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9741143f091acf1a2791ced6ea26f5cac720a283.camel@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 03:31:24PM +0000, Ariana.Lazar@microchip.com wrote:
> 
> There has been an unsuccessful attempt to submit this function to the
> unaligned set. It was rejected because of the lack of current possible
> shared uses. Please see the discussion thread below:
> 
> https://yhbt.net/lore/lkml/20240927083543.80275-1-
> marius.cristea@microchip.com/T/#u

Please, make sure you provide working links which should be this one if I am
not mistaken:

https://lore.kernel.org/r/20240927083543.80275-1-marius.cristea@microchip.com/T/#u

Also put lore site directly. I don't want to make my browser crawling from
whatever possibly fishing and malware sites.

What you provided is two non-working links.

-- 
With Best Regards,
Andy Shevchenko



