Return-Path: <linux-iio+bounces-25591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB16DC154AA
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD95466121A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523232571A0;
	Tue, 28 Oct 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1kOWj/U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562A2550AF;
	Tue, 28 Oct 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663093; cv=none; b=ZYdgoUynNfXI0kMQQD5/Go+JA3uznBHTlCkEPxDyTpFOf3kPMkxDRBHoNmM93KMJpZPcZcno1FJjSrRxn/PNHlhrKPn4D236himN8VcNK0LjUKzZ/4bEG21qt4FCooqv4vW+oln8haa75jYQ3RROfiyBkd6FnGIcDJvUhGoLRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663093; c=relaxed/simple;
	bh=glytEKyAwbMVi2/7pNGHv7X6xwlwzIprNdGWYsCZk+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeCE2O6TdzRf3SF0q0VMMG5KJHhsErn1nYdZuk+rnzbRYNNV+4LLgd6OieMTNUcMvg6V7SDZ/vgp6o9n0YtbyERZf2xr3iRA/5qhmYX2TMRvtv+rNbfCQjGEbfBtpZy8vdfW39ElnU9l17gCGn5uGwa8gMnL+x2aqkn13H0Wx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1kOWj/U; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761663092; x=1793199092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=glytEKyAwbMVi2/7pNGHv7X6xwlwzIprNdGWYsCZk+0=;
  b=M1kOWj/ULCin5KwXun1kCmqxk4/7P82tkXrfxOBx//Ts608CxtPk/Gsg
   oLiX/HCydrypGsA0dswh9FOFVWwIGGFIzA0yBVGbY3vxO/Cckl5caH0KO
   8e7sMO1wbDMaXBWAcZfyPKFLCKGFbO1NhAi+HRHMaCyM9CN/HtjvhpDXb
   lBALzY3P4ff/bzDMliwNIbLBCjdddzSNYmdcKhAASS01Ek6zJOA+Emav3
   wK7s2W2aGDTYgLtwgZ4HzYlK+v/ghTUg2xJ/OC8VccJXz2PkgvU/oKoLp
   zWnvJI+FjNoc7j9ud485G6LqQ8OCBKKoECMrzkxAWGgJ92Q66XYYq7fuv
   Q==;
X-CSE-ConnectionGUID: yoJXj2TtTTqNd/78Pfk8cA==
X-CSE-MsgGUID: NtpwJPpcTrihxsD2D6gljw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66380922"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="66380922"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:51:31 -0700
X-CSE-ConnectionGUID: 6moAjRlNTzmLVxk8Bs4uIQ==
X-CSE-MsgGUID: fzkGLTy6Rp2yFdFhD6uvmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="208958106"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:51:28 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDl2j-00000003LJN-33uh;
	Tue, 28 Oct 2025 16:51:25 +0200
Date: Tue, 28 Oct 2025 16:51:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: Use datasheet name as fallback for label
Message-ID: <aQDYbRutGLgDmWNu@smile.fi.intel.com>
References: <20251027124210.788962-1-wens@kernel.org>
 <20251027144327.09f59982@jic23-huawei>
 <aQB5Dw2Eg0tVdNow@smile.fi.intel.com>
 <5e3bf0d87ae1b539d134edefee67d3e3ef3b46cb.camel@gmail.com>
 <CAGb2v676eOkPOc33+FMX6k9562gn34+MR15t-iucLjd0qQKs7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v676eOkPOc33+FMX6k9562gn34+MR15t-iucLjd0qQKs7Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 10:36:35PM +0800, Chen-Yu Tsai wrote:
> On Tue, Oct 28, 2025 at 5:22 PM Nuno Sá <noname.nuno@gmail.com> wrote:

...

> The axp20x-adc driver currently provides _no_ labels. Would adding labels
> now be considered backward incompatible?

It can be considered forward-incompatible :-)

This kind of discussions happen in IIO in the past and probably still will in
the future. Namely "What should be unique (enough?) string to recognise chip
(platform?)?"

So, you see, we need to answer first "What do we want to recognise?
The platform or the chip?" Then decide what uniquiness will be enough.

-- 
With Best Regards,
Andy Shevchenko



