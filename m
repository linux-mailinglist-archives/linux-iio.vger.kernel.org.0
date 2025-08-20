Return-Path: <linux-iio+bounces-23067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB854B2DFF5
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DA217F1D9
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66188277026;
	Wed, 20 Aug 2025 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XK/HELWP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476826E17F;
	Wed, 20 Aug 2025 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701344; cv=none; b=gtrrCA2YCI7BZaQnlZElMiipmATT7lxsJrnLTW1OKsMsm9maiGxWog6pGh78ldElXuxjDVy3ueOzLLk/T5Qb8SXb67YhonKWZrNP0KPyWmjpHgpFBLeB4GhhAQvPBB2+eMeqyBlNSD0QX0C6QzGritkre7qr6mMCetbTUoXJMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701344; c=relaxed/simple;
	bh=T6hMHvSu/tCgo9JeK3VXV11dMQkQoNNJzlM3ggONDK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6YrR3kDM5h8Vgx8bYZWWlLzVaQd9iHC084ZDvAlcgxnC+vc4yFaH4yqneH93SoHlQXqkK9hiXdnVpACUCASk6hVO3jsiMouGqUq2ChUCLdYIPmNHQL4NR601KRw2eyXqgACOmfdQxeSi0GknfA48Rwd5z0U6PY5DRtbchvHfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XK/HELWP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755701343; x=1787237343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T6hMHvSu/tCgo9JeK3VXV11dMQkQoNNJzlM3ggONDK4=;
  b=XK/HELWPQwyqPnma1iibjZK/jh2qQCuS19zZ4RpRJ9Aa58nmHO5JGGwh
   J6BXbIEuH5u0ssXQMxhF6uejBuezQOPN7RWx5zt39ntBQ12WNdSn9YdTF
   WqtniTkmt9/vL97jgNVOmtLLOXV3fftzeKSo8WFCcqThKOr4Cn4uNynlL
   eHmChs1dyP3+6bZ2PU9xenKYNDtDxpRKySdKQxseFtYDDjqrgRAeY/Naq
   XKyMpfJ9v/rAng+y+7FE15gR23rS5yBDAfqdEgjIuDvceDAVv1WvBI/+o
   RBdpiQwcfwTWWJPwpezguxJUoeOnlYHSbsRJzspT/UXb7lsWrwviBn3nB
   A==;
X-CSE-ConnectionGUID: lwKVherVRze2b5bASEIOXA==
X-CSE-MsgGUID: wM4tDI9XTaaZWmH+DPUmkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="56999127"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="56999127"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:49:02 -0700
X-CSE-ConnectionGUID: Nzw/DAAjT96x/nQdnnutPw==
X-CSE-MsgGUID: afHXTmGrRpKAWM2NGeZZJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172409775"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:48:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uok7V-00000006xjl-0Cfh;
	Wed, 20 Aug 2025 17:48:57 +0300
Date: Wed, 20 Aug 2025 17:48:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Markus.Elfring@web.de
Subject: Re: [PATCH v4 1/3] iio: pressure: bmp280: Use IS_ERR() in
 bmp280_common_probe()
Message-ID: <aKXgWNBwcHrbCbFo@smile.fi.intel.com>
References: <20250818092740.545379-1-salah.triki@gmail.com>
 <20250818092740.545379-2-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818092740.545379-2-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 18, 2025 at 10:27:30AM +0100, Salah Triki wrote:
> `devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
> Check its return value using `IS_ERR()` and propagate the error if
> necessary.

> Fixes: df6e71256c84 ("iio: pressure: bmp280: Explicitly mark GPIO optional")

> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Nuno Sá <nuno.sa@analog.com>
> Cc: Markus Elfring <Markus.Elfring@web.de>

Please, next time move the Cc:s to be the after '---' line...

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> ---

...somewhere here.

It will reduce a lot the noise in the commit message. The all people will be
Cc'ed anyway (assuming you use `git send-email`).

>  drivers/iio/pressure/bmp280-core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Jonathan, would it be possible to drop them from the commit you pushed?

-- 
With Best Regards,
Andy Shevchenko



