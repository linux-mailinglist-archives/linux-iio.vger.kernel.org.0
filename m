Return-Path: <linux-iio+bounces-22567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C3B208FF
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 14:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FD64216AE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5672DAFAE;
	Mon, 11 Aug 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUiForYF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD722D77E2;
	Mon, 11 Aug 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915947; cv=none; b=W57VB7teofQUzGcNPR+jha5nrbkrcyAvX3nGJK2xRMCy9e7BsZomBiUGXJpJMgcGmRVBogi3AKSj57NsKPcK/KtW7JU1lfFgjuVh0nX+RYW/xRGdrzvKsJoQgKWdH4UJfZfL6UNYCF/ekORkZxBR62vhuqoH24bxTbtZUof8K68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915947; c=relaxed/simple;
	bh=dhBKEeU5ldQLq/3XtEZvKKj307e0aSyze9dkI+ujZdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siroIKSChMBQYkG2Rmen/ix+6B/K6hgANbXuHEc72EabIldusApkXE81SnO+mbyS+p0yAo47RqRCpl3ZvlnH1R7bB9jqMBkf6fClea3JVJv3EzTI9RuCmKsHGRPcBj1gQhd6osKcD/Zwkutv5bIio4CWZsqCXQVL1uCJO0xyDqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUiForYF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754915945; x=1786451945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dhBKEeU5ldQLq/3XtEZvKKj307e0aSyze9dkI+ujZdQ=;
  b=cUiForYFbQb4u4n6MdqmfHdqmWxG53uJMuwJvPec8gUdIYRusJOa146h
   l68op4xCPEnN9xxZPHh2XWkBcZ2eHfq4uIEINE8F+qxD3IRQR/VpZNQGW
   ChloKatfrCXn4+AlqFfD0CF7yNJ0aHBCQFhjGilUaKfEjdzoyJ1IGM4Gf
   4HtAqp0foknn5QYTh8PqCkCT5bW/rNDP2Ot0PG2PPPuoQpce9UpXzbxtY
   jmw6yGhRidhUthNFiuIZgUMYfsgDuyGHFWgdEhlYk+1CSgkY8c+BLi7NX
   mSZ3Yzm4X/gSTM7C6j5Ay9AlZGEmk3I3Yl0xq/4llb4szCoQbiIjSY9RD
   Q==;
X-CSE-ConnectionGUID: jD9SyHoxSjWoeMQ1+BsATw==
X-CSE-MsgGUID: 5ctARMVoT9qlkulraF9fyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="60968657"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60968657"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:39:04 -0700
X-CSE-ConnectionGUID: xSVS8NyHQXmcsesZ23AQDA==
X-CSE-MsgGUID: ltCEpc67QXCqN9i6K1Q+ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165808200"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:39:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ulRnm-000000052Up-4BX2;
	Mon, 11 Aug 2025 15:38:58 +0300
Date: Mon, 11 Aug 2025 15:38:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <aJnkYn4nN5K6AO2q@smile.fi.intel.com>
References: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
 <20250807-tlv493d-sensor-v6_16-rc5-v3-1-b80d2cb41232@gmail.com>
 <CAHp75VeKPr=3H_wOvcesqj4OsrqN7zwRFFk3ys3O012JpQtxrQ@mail.gmail.com>
 <aJcw8icGvsDzFGpJ@dixit>
 <CAHp75Vc7Jftvmgb0EgnYmiKtT2TTYb2uQGNgaqm7hvkFWpJ9cg@mail.gmail.com>
 <aJdcUhz-vqnx8DwA@dixit>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJdcUhz-vqnx8DwA@dixit>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 09, 2025 at 08:03:54PM +0530, Dixit Parmar wrote:
> On Sat, Aug 09, 2025 at 02:44:00PM +0200, Andy Shevchenko wrote:

...

> > > > > +       data->wr_regs[TLV493D_WR_REG_MODE1] |= mode1_cfg;
> > > > > +       data->wr_regs[TLV493D_WR_REG_MODE2] |= mode2_cfg;
> > > >
> > > > No mask for the existing values in the respective wr_regs? Wouldn't
> > > > you need to use FIELD_MODIFY() instead?
> > > >
> > > I believe, we are doing OR op with the value created using FIELD_PREP,
> > > so it should not interefere with the existing non-masked values.
> > 
> > I am talking about existing values in the array.
> >
> Right. So in that I think it will make more sense to directly use
> FIELD_MODIFY instead of using FIELD_PREP first and then doing this OR
> op. Right?

Just double check carefully, but sounds about right.

> > > However, as FIELD_MODIFY is there, I should utilize it.

-- 
With Best Regards,
Andy Shevchenko



