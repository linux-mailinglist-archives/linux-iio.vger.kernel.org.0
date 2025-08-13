Return-Path: <linux-iio+bounces-22664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C13E2B24A59
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1DFD4E32DE
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25F62E7F2F;
	Wed, 13 Aug 2025 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdPaoKKi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F982E7F02;
	Wed, 13 Aug 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090922; cv=none; b=LJqsX1RKiHrRitvvavWvuDSfE1aT5TbmqZvMs0xp/bVP0YCbGgFUrILz7VQPkrfT4lRX//fw30nqSR+kgJbS2D9sWd7801nNPfJa5ezORMmJjTL8pPnMj6WStIH22Of8Q/ZRWqEBG8o5ju1s3VY55ER5uvYiV7VN15ot3UnD8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090922; c=relaxed/simple;
	bh=A2tgh7/qAd1TIge+H+3IgABjLhCELs6ONkvI8pXJgQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSLo2mEpwolmiwFjSqgrDifqNRisxzKWHBO0qLsYVFeVtgHws4pJDCpTVUWL54fjomniYX2ZhOSoeBBHeC7oP6EfC1Z+ugncq++rUwb4Gbs89alFWzC9aBgiq19WpRo5zhsrKqK7ZES9s8IhFVxWJ1ZL6sITUBmaeXYo7rP4ZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdPaoKKi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755090921; x=1786626921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A2tgh7/qAd1TIge+H+3IgABjLhCELs6ONkvI8pXJgQM=;
  b=TdPaoKKi7+R9Bqhw9/7JJ/048O5I9bc/Vo+fehU8hBMSvuDbk626n3el
   GyNxcHXBzwuuAO9aBqp+jwio/xaxyk6UchTuoBqUzbY2mxu34YiPqHzc4
   U558rW/wxJAzov5QRTYypebZfQyUwnX4x7eQaU21XmdUFJAs7NgMg/74g
   xD7whmSdRLv0QvMtYTpCtNV/R+SaNF3IWVH6aWT/upsGiYl0fcGx4d5Rx
   VJeMgKGW8RpGxICs0N7K++pRCP72xFJmYnN3iFig85F0TM8n63s6sVArM
   WiL2TTzjEpQoXo7FLuWJXYZasTmRGNcz8cwLNNO6OUMGg2oQA2QTyaZ/u
   Q==;
X-CSE-ConnectionGUID: 6Hyy4/TWSk61N3G8CYUz7w==
X-CSE-MsgGUID: nzjErotcStqyMs5SZWTZ+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57460752"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57460752"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:15:21 -0700
X-CSE-ConnectionGUID: ZvnCXHHETFekeikGklQQFA==
X-CSE-MsgGUID: WPq5Uw5gR/ayVSTikizNzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170601778"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:15:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1umBK0-00000005RTh-1sK7;
	Wed, 13 Aug 2025 16:15:16 +0300
Date: Wed, 13 Aug 2025 16:15:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@anaog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: iio_format_list() should set stride=1 for
 IIO_VAL_CHAR
Message-ID: <aJyP5PhTcNv8QWQL@smile.fi.intel.com>
References: <vidvwybkm3vwmtopihyaj6tlvswwa5ixmgptfzpk5ujl2ixjjb@olz6275ftabs>
 <CAHp75VfQFN+F0xMyhWvHOejD0AefDfBLf9s4eu1bpqCBY7bkdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfQFN+F0xMyhWvHOejD0AefDfBLf9s4eu1bpqCBY7bkdA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 12, 2025 at 10:44:13PM +0200, Andy Shevchenko wrote:
> On Tue, Aug 12, 2025 at 1:13 PM Ben Collins <bcollins@kernel.org> wrote:

...

> > Signed-off-by: Ben Collins <bcollins@kernel.org>
> 
> Please, keep the Cc list after the '---' line (note, you may have more
> than a single one in the patch, hence you may just add it here). This
> will reduce the unneeded noise in the commit message as the very same
> information will be available in the email headers and in lore
> archive.
> 
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Nuno Sá <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> >
> > ---
> >  drivers/iio/industrialio-core.c | 1 +
> >  1 file changed, 1 insertion(+)

Forgot to add that no need to resend just for _this_ case, take the above
advice for the future contributions. I hope Jonathan may remove these Cc from
the commit message.

-- 
With Best Regards,
Andy Shevchenko



