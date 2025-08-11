Return-Path: <linux-iio+bounces-22565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C700B20889
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 14:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FCA426270
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E12D3233;
	Mon, 11 Aug 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtVg8JnO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118F2D374F
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914455; cv=none; b=mYOBlmj/yCKDcw8t2ytooXP0YnnZRoMN5WTsBnwB3n+63QZf+ewKuX2c15XUL3tzraElyTEugUzrgc3DUqKbmYJwqj2ksKHPQAmqO7Bsh7iyjGhLuay8SGxc8kG2OfNwH7KUDkGo8aKwCFl1nQeIrHAu9Fo9aq2U6OuKknH+AO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914455; c=relaxed/simple;
	bh=oTYLo2HACksWvLGkHluWgZb/3LIvpQKBKgeFD0JD+h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiwPrbBwUZIKAJTKMBvQxgpAReweayMwAre2mr/8oaduPjd8hXxoBecFem0tl8BsyYsk+YBN3nsKjHOgf4TsmsabXXlPBF49Wzl3srowVaFhfT9pvITtTeSR1au58VrzHtwMQRiDg2WoajoMlmO8Fa77AWR/hPaDxC63iQwQdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtVg8JnO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754914454; x=1786450454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oTYLo2HACksWvLGkHluWgZb/3LIvpQKBKgeFD0JD+h4=;
  b=MtVg8JnOO56eM1b7KHpPQ4mI3SJLE2FlN9BJ/drKKtvti9ouVbY0Qi4v
   qXewZF7+G4MUEnIZQowYbziuXPgRupy8m5nC3YRb1mufAkYq1JVGBn4h/
   zAU3S/k2FOk+Fp9GfQCGkDFKdoxa+v2nLbuqMRNH9tgZ21dmzyl5SF1Zx
   XPFn15qIIrgzirtbRk70uTEc/hZoucJsrjYrydl2GhTYOpiAlf8LDXH8a
   JRX9z8jePbnIpF7NGlrqgPcxVU68ZkxfLGtKaTsD/ArrgrqiWGCRJ45Iu
   VtJrmFWkjkL+kdQN6sNDkgXechUmbiG4iCKU/ZD2J9fEgJaN9BI//PDyt
   Q==;
X-CSE-ConnectionGUID: /pqDEk1hQf6K20Iq6+jYiA==
X-CSE-MsgGUID: llk9p6avQ+O0XkpVKhWNrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57306361"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57306361"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:14:12 -0700
X-CSE-ConnectionGUID: 52V3XjNpR8iTJ+83N/OvRA==
X-CSE-MsgGUID: VR7TWH3dTFeBHmgLQEfCnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170104974"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:14:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ulRPi-000000052I5-3jUo;
	Mon, 11 Aug 2025 15:14:06 +0300
Date: Mon, 11 Aug 2025 15:14:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Achim Gratz <Achim.Gratz@stromeko.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 0/9] Fixes and enhancements for the bmp280 driver
Message-ID: <aJnejqUlYke_YVk_@smile.fi.intel.com>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 10, 2025 at 08:58:37PM +0200, Achim Gratz wrote:
> Revision History:
> =================
> 
> v1:
> 	- initial proposal, incorrectly prefixed "bmp280" instead of "RFC PATCH"
> 	- patch series presented in the order it was created
> 
> v1 -> v2:
> 	- prefix as "RFC PATCH"
> 	- drop channel switching
> 	- rewrite to present patches in smaller units and in logical steps

Do not reuse the same email thread for a new version: The rule of thumb -- new
version implies new independent email thread.

> With v6.13 a change was made to the bmp280 drivers to use MODE_FORCED
> instead of MODE_NORMAL.  This broke userspace functionality: reading
> from sysfs interfaces no longer worked and an error was thrown
> "Measurement cycle didn't complete".  This series fixes the underlying
> bugs affecting the measurement time calculation and implements
> additional functionality not available for the BMx280 devices
> previously to allow the use of the sysfs interface in MODE_NORMAL
> again and control the corresponding parameters.  The implementation
> follows the already existing facilities for the BMx[35]80 devices even
> though the actual functionality of the BMx280 devices is slightly
> different.

-- 
With Best Regards,
Andy Shevchenko



