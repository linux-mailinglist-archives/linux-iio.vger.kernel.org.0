Return-Path: <linux-iio+bounces-26534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD46C9159D
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 10:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5724D3A6F11
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5682FFF86;
	Fri, 28 Nov 2025 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6BdqWJy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8402FF677;
	Fri, 28 Nov 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320588; cv=none; b=blH/iQ3vcgNLJbznl0RbodPgRbEyUQ3ZBPu2Tqo3F9AX0OtGFHsNrdxM13l/+IcnxQHPVpFWKsolstcpq/ZFcfw9kSblh5FRVG4cfYbfyP+ljcIU1o7RWaz32Snk9GpdbfySyX51KM8EoOpOcFzbY8rpUaIIoBin0cHGkktIRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320588; c=relaxed/simple;
	bh=S/2CR66ol+gCD1wb/XlZRG+FLjxFVpWaqgCt4200C7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttzjPMHMtIFD5ph8ph6fbOoEozb4PEDqvZWSeKDOl9a1J2Zru8N+8cAnNwKxcwfEijZie0NXJqU+OLLFph0ys5OerLHdb2J4PDZxFa9Fndhyum5lBzAUqF0W+E20gaU64v9Q+Udb7RyDZzmL10FxQymwzw2wrg2MwwORDjDyJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6BdqWJy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764320587; x=1795856587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S/2CR66ol+gCD1wb/XlZRG+FLjxFVpWaqgCt4200C7M=;
  b=d6BdqWJyLIAKiifTkI0IlBajEU78g2FBas2tc/0g997wx18eeJKAexwu
   IdWOdNiik7WalXzIV9uWvmCikLts5uEoiV9C30gRwL2FOw/1TudYx3o+5
   IdfahMV/4D0seWZjjjuXBMThCFF9BFQkf9oJcN4PkkUVyhEwBPNgpFHKL
   7hrAQ/zOjGvy67IMm8tBjtSqvGWD510eIN2tKbQbtNFLwOoX56P7u+Jlf
   vgQSuJD+97vpr+eiSDeG8AdUDJaNDOaBCM819lEstguNkyoV63DcoVAZe
   rfB4z4xauL0sfriqXm6JBKMa0tjhMsdyiJmORVMDtFIh0Ps/eZpiTnnHf
   Q==;
X-CSE-ConnectionGUID: RwqCSTqTQVuLuD5T0cpe0A==
X-CSE-MsgGUID: TcysyCaiRQewLkd1as5W9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="65541152"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="65541152"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 01:03:04 -0800
X-CSE-ConnectionGUID: Q3bMP0yYTKmeAlwSp08Ykg==
X-CSE-MsgGUID: p/2bEtBxTnGOH+52yucNlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="216769326"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.154])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 01:02:59 -0800
Date: Fri, 28 Nov 2025 11:02:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
	linus.walleij@linaro.org, brgl@kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, morbidrsa@gmail.com, jth@kernel.org,
	wim@linux-watchdog.org, linux@roeck-us.net, nathan@kernel.org,
	nsc@kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Subject: Re: [PATCH 1/2] mcb: Add missing modpost build support
Message-ID: <aSllQThEANDoZPfN@smile.fi.intel.com>
References: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
 <20251127155452.42660-2-dev-josejavier.rodriguez@duagon.com>
 <CAHp75VeNtYJPmXtDfWEN3a184YXTKNems657UDeBKp4xpOGovQ@mail.gmail.com>
 <e40e877a-130c-45f5-ad73-560704592815@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e40e877a-130c-45f5-ad73-560704592815@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 28, 2025 at 08:54:18AM +0100, Jiri Slaby wrote:
> On 27. 11. 25, 17:10, Andy Shevchenko wrote:

...

> > >   static const struct devtable devtable[] = {
> > 
> > >          {"cpu", SIZE_cpu_feature, do_cpu_entry},
> > >          {"mei", SIZE_mei_cl_device_id, do_mei_entry},
> > >          {"rapidio", SIZE_rio_device_id, do_rio_entry},
> > > +       {"mcb", SIZE_mcb_device_id, do_mcb_entry},
> > 
> > Perhaps squeeze it to be more ordered (yes, I know that the table is
> > not so ordered, but given context suggests to put it after "mei").
> 
> s/after/before/ :)

Right, good catch!

-- 
With Best Regards,
Andy Shevchenko



