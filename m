Return-Path: <linux-iio+bounces-25259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A3FBEDA4D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 21:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E061A3B2F50
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490C256C89;
	Sat, 18 Oct 2025 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljdkS0UI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8E27FB1E;
	Sat, 18 Oct 2025 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815497; cv=none; b=LJN+Y6CydFMXRJalb8lB2FaRfjkhnRznljR43Bl6KT6Yx7AFzvl2KbryBWNukp0czt0k276RhaCrxwK4+bFQyPSRZLwaxav+/5lucuew1CLVnmbt+UaozAhNOsE+6DLRzSaY+iBHHI7OI5B+CXzMJcBNC+77+7gEKWX2T7sSz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815497; c=relaxed/simple;
	bh=9bSfGES7Gw7ogivfHR6C9Hea5CliMZxATD6hFb1jHbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j3z2OMI/FGsGJAtVB+g2xAglo2aG6RMSEf87lyHek8zvN24MoovwgZg/EE0bLutVkoVhdaoPsJX678f4hrFT/PTJAXhH/EeJ0rD+JJlMvZUyFpev9C2i9hpaUbinSO66+Rub7290YLuMgrA9VCuOKnGG0mvQxGv/94yUAMJdRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljdkS0UI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760815496; x=1792351496;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9bSfGES7Gw7ogivfHR6C9Hea5CliMZxATD6hFb1jHbM=;
  b=ljdkS0UIRq661INCr8DBpdF3pAvX5viqFZrRTBoCTdWy4RK0RYG1Fl6y
   TpZGE6Z9f/HIllv15aLuVT/0KtkxTxmCc83+qnoG9iMnC8n2ijAlakoAj
   GwjuvLpyAXQigdiZMKhwQ5cxT6UZDUwSrJe3xjo0GtCriXeOHnYnv7guQ
   X4QFb2wLRxl5ftYnRP5rwZcraHDZCubSO4FdtDEI3SUFmLWFfT/zt1ONB
   86lPWyVrN1SZJvPbzqUNfrIUjwwdaxYSI0uZYyKEN/YgjiIvW50dN21ua
   kRMO4KD41CkzPz9012GsFH7ZaLVrFJ0X43r/TdzOZ3lhIlDYIePgm/UwW
   A==;
X-CSE-ConnectionGUID: TpUHD50iTWqXB3kQshY/Aw==
X-CSE-MsgGUID: YHqazwxDS7qStBcht+6tag==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62904312"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62904312"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:24:56 -0700
X-CSE-ConnectionGUID: vE+QGANHQC6+xeZM7vJy0w==
X-CSE-MsgGUID: 6gid/VJoQmma1OBvyB5wOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182545573"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:24:54 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vACXr-00000000xUU-1s8s;
	Sat, 18 Oct 2025 22:24:51 +0300
Date: Sat, 18 Oct 2025 22:24:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: test: fixed-point: new kunit test
Message-ID: <aPPpg9lb-UQ02m-0@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo


On Mon, Oct 13, 2025 at 04:33:43PM -0500, David Lechner wrote:
> Add a kunit test for iio_str_to_fixpoint(). This function has an
> unintuitive API so this is helpful to see how to use it and shows the
> various edge cases.

...

> Discussion unrelated to the patch:
> 
> I'm also a little tempted to introduce a new function that is a bit
> easier to use. Many callers of iio_str_to_fixpoint_s64() are doing
> something like int_part * 1000 + fract_part and ignoring the possibility
> of negative values which require special handling.
> 
> static int iio_str_to_fixpoint_s64(const char *str, u32 decimal_places, s64 *value)
> {
> 	int int_part, fract_part;
> 	int ret;
> 
> 	ret = iio_str_to_fixpoint(str, int_pow(10, decimal_places - 1),
> 				  &int_part, &fract_part);
> 	if (ret)
> 		return ret;
> 
> 	*value = (s64)int_part * int_pow(10, decimal_places) +
> 		 (int_part < 0 ? -1 : 1) * fract_part;


Obviously if you go this path, the int_pow() can be called only once
(yes, we would need a multiplication or division for the other case).
The question is how we treat the decimal_places == 0 case.

> 	return 0;
> }


-- 
With Best Regards,
Andy Shevchenko



