Return-Path: <linux-iio+bounces-25824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A14C1C2A8CA
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 09:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B10E84ECB17
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18352DA744;
	Mon,  3 Nov 2025 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7iBPXT9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10A28D8F1;
	Mon,  3 Nov 2025 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158142; cv=none; b=nXoRxRYRNoiWeXswVwRqZj5j3PW5KeAnS96Rb1IGVyCWHeqgLDv7PuhGWtC3CmjUmWnBAW3WGKyEVTbLo+XHrFiPdqe735To6d2B4J8r7FA6NXKCi2qjYWFK4OqfM7ypuuYgGhewmh5dOYbgtP5pbb7t+wQk5NRuFv+hB0v5A1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158142; c=relaxed/simple;
	bh=Eq36XYWFBcZDrXPNsvYnUpDc8WxwpN06pg3X7YIv2bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoWXfuMKBx6fSp792i37m85MFQpqVQHxUbpbmzDvyyjuzicrG0hJNyJ2BpZ6kFkbISVfrxksol8q/uSipUAh9mljxlBBxaQ6wWeGW8qvu2VbehoSThJc82hk7Wo3mr+7mz85Tbwa+cuIWLnLpLHMzACFxNrzAoOLpdGAsHNvObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7iBPXT9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762158141; x=1793694141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eq36XYWFBcZDrXPNsvYnUpDc8WxwpN06pg3X7YIv2bk=;
  b=K7iBPXT9OgE2pIuNl68BWfud3TRIWyiEy7oY0teCPbgKwe0LZN+RrIVH
   wjIkcCfmNCGJZOEFgA2gtND76I4NxnfjgD7WVHhIbFAM5Rzfg/JhQSf/I
   ux+fBp+U7CJpCf/kMobRnlS69pn3YIBjHElUpNpIvuKWTVQ0csA9u62RH
   E00QhSAyjQ41ssrXWfOSzF1kkbYoXSd0iX0oxlWuDxBc08L6Jksuqj5dv
   uEuXzeLyDiM9cfr6k06x7P+/tQ6pqMpUxtTAE7uyG7UnIHRDolOvXMiMQ
   XuEhx+nEtN3DV4f6DcUjsH3SUeG8JRZWLmVEyFZ2G06NfkR5ETH2beWzB
   Q==;
X-CSE-ConnectionGUID: ct1tIrLER+iuQOpBRhKnqg==
X-CSE-MsgGUID: gnR6/dukRB2Yw8mON+M8sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="75676108"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="75676108"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:22:20 -0800
X-CSE-ConnectionGUID: RJtneBp/Q2igJd13kQ5acA==
X-CSE-MsgGUID: hadtr6dEToSvkIN8RD51NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186487346"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:22:18 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFppN-000000055Vn-0wPZ;
	Mon, 03 Nov 2025 10:22:13 +0200
Date: Mon, 3 Nov 2025 10:22:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoni Pokusinski <apokusinski01@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: mpl3115: add threshold events support
Message-ID: <aQhmNDoI8k3KvyMR@smile.fi.intel.com>
References: <20251031201821.88374-1-apokusinski01@gmail.com>
 <20251031201821.88374-2-apokusinski01@gmail.com>
 <20251102103808.73cac929@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102103808.73cac929@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 02, 2025 at 10:38:08AM +0000, Jonathan Cameron wrote:
> On Fri, 31 Oct 2025 21:18:22 +0100
> Antoni Pokusinski <apokusinski01@gmail.com> wrote:

...


> Generally looks good to me, but some comments on the 24 bit value reading.

> > +		i2c_smbus_read_i2c_block_data(data->client,
> > +					      MPL3115_OUT_PRESS,
> > +					      3, (u8 *)&val_press);
> 
> This is an oddity.  Why read into a __be32 when it's a 24bit number?
> I guess it doesn't really matter as you just need a big enough space
> and throw the value away.  However, I'd read it into a u8 [3]; then size off that
> as well.
> 
> There are two existing cases of this in the driver. One of them should use
> get_unaligned_be24 on a u8[3] buffer.  The other one is more complex as it's
> reading directly into the scan buffer that gets pushed to the kfifo and is
> reading into a u8 buffer ultimately anyway so at least there is no
> real suggestion of it being 32 bits (just a +4 shift to deal with natural
> alignment as the storage has to be power of 2 in that case.).
> 
> hmm. I think either we should tidy up the easy case (_read_info_raw) +
> use a u8[3] here or just stick to this being odd.
> My preference would be to have another patch tidying up the other case
> + use a u8[3] here.

Just a side question... Wondering, if we actually can defined __be24 and __le24
types (or at least u24) for really explicit cases.

-- 
With Best Regards,
Andy Shevchenko



