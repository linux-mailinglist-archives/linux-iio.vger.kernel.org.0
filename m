Return-Path: <linux-iio+bounces-25723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E009C23D96
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 09:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0962B4F5715
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C72EDD75;
	Fri, 31 Oct 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EslHc7G6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726C2E339B;
	Fri, 31 Oct 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899563; cv=none; b=Lu5qCXx75ncF3QHrWUFM4MAsU73u2caNz0jg4tH83rA3/y6+OEQqq2s6Dk+GLQ3i+VTZIi8q+/xUGDxnkSqnURs3vkB/w6rodgOH23S1SEQx/xoXfP7LHQkkWdp+70+mVe+4ezKsYgbqKIRO4jKj25NRGQ7q726X+FooFAchIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899563; c=relaxed/simple;
	bh=kIM+hlR14oLQcGB55fGG4M66nQBzT/POqSRrYN5M+0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjHQTMbvBqqjOyOIZ8464ZJJJOMYQLv5mD/c/AsKrYWfXOpzv+Aqnq9G+FUxRNKAkLM5s0cS5O3hUhE9PdodPjE53QLkXmuWwGAQ75mnlMe4iZRzGeqZonL9UCOKmwiqEqlv0GFqxhNgMrRUD3g/b+fQjCuY2u8q5iUyujFuhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EslHc7G6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761899563; x=1793435563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kIM+hlR14oLQcGB55fGG4M66nQBzT/POqSRrYN5M+0g=;
  b=EslHc7G6ppqAvT46wLeAO6PnZJIWF6N3a+zoBbbAZJ3/pgEPBSS7IU5S
   jhxKysDCZGsNGsckRDPD4qJobXQ/X6fY00VHHp+gMbBr3qUUQoolx+LuQ
   TRDnS2ZQQWIUi/Ov8vcxLfPULTwjFWUAvXw4PmdoXclEKr7xlxMXpupZm
   pVnY1rltz3z8I7LEWI4m+eFyKJ3L+B9uLBFDq6eurJgwmWOIzEnsd4/Zt
   0ZQYjpAlWwEmTDjfxU8SJJwX0NPp4nNSIf79ChLcViouZmewF2mQeBj4f
   O3F5V9eJsjHq27ZCKLsAEzNasIHEB+4h2gQihzycjp3qrMxQJI8HwrRkf
   A==;
X-CSE-ConnectionGUID: MVbugi4fT4mQvDP/SzoL5Q==
X-CSE-MsgGUID: qYRNVLxbSeyxQuYhA79+zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63959358"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63959358"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:32:42 -0700
X-CSE-ConnectionGUID: FH1rl+GhS3OSOg0NjyHCVw==
X-CSE-MsgGUID: 2FcHal3bTBuraaATMPr8wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="185866615"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:32:40 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEkYm-00000004D2p-0K5a;
	Fri, 31 Oct 2025 10:32:36 +0200
Date: Fri, 31 Oct 2025 10:32:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
Message-ID: <aQR0Iy2UJn9-XxpG@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-2-flavra@baylibre.com>
 <aQOVcCinTd-ZJJX3@lore-desk>
 <3e7944588d3011b6a144d70ab9027a05a1e230d0.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e7944588d3011b6a144d70ab9027a05a1e230d0.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 09:26:19AM +0100, Francesco Lavra wrote:
> On Thu, 2025-10-30 at 17:42 +0100, Lorenzo Bianconi wrote:

> > > +       chan->ext_info = st_lsm6dsx_ext_info;
> > > +       if (id == ST_LSM6DSX_ID_ACC) {
> > > +               if (hw->settings->event_settings.wakeup_reg.addr) {
> > 
> >         if (id == ST_LSM6DSX_ID_ACC &&
> >             hw->settings->event_settings.wakeup_reg.addr) {
> >             ...
> >         }
> 
> In patch 4/9, the inner conditional will be replaced by more generic code,
> so we would revert to if (id == ST_LSM6DSX_ID_ACC) [...]

Hmm... The obvious follow up question is why can't we stick with the original
conditional to begin with?

-- 
With Best Regards,
Andy Shevchenko



