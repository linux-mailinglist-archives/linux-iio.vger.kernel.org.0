Return-Path: <linux-iio+bounces-24269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCFAB869AE
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 21:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8893BE12F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB962D47E7;
	Thu, 18 Sep 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oowgo4YY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319EF23AE62;
	Thu, 18 Sep 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222042; cv=none; b=mhYvnbMUmmmXniQVRnbBa4T/BWHohi0oWLboS4ZcfgRx8wXXZ89fLEXGFC5n/m0fSTu9nOfIlRIKzBTC5HezBfOy6g+nsj8RqDWo924j+qK/0vqdNVebGk1gmLzfz9SBsIumXHcHrwaQpqxguk3A9Mh47zUg5avUILyCkFdf41k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222042; c=relaxed/simple;
	bh=ef0mTUC0aOMKx4QFCiLnqXP82GZHO1F+FgK59dzSrlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzQsMmob2TnVnILm+fCkYt6gwXUKS852rJtXt+U1VThTcMADRFf2OF2Nwqs9hYQSIzGS0ucsjdHVVzhvABeoTYPLWE3Q8ThoXkp6vMHWHFY6Wdbh7C33SN0MUQwp0ZsrqkEcqD1GwH9NYWDtVemAwb1691ZbCz+aIAe0s/q+GXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oowgo4YY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758222040; x=1789758040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ef0mTUC0aOMKx4QFCiLnqXP82GZHO1F+FgK59dzSrlg=;
  b=Oowgo4YYfVh2MruJgeRr5276ZAaKB/9coD93mJZaDxDt8NQ/RmJtmRMs
   x0N4MVKwwe7NNGPJnGvaprmb8akvEDgfeCZ1RIJlFpoubGbKdYw/EtcVy
   QQUN9z1seEnYxZ/cis8TqNB6Ui4DMEpnLI5NXRaDTnLO9K3rDTxaPSa3S
   YsSbMUkC7pe8y6DWYNkUvkpBxVYQkGrVaEvZtZ0egFG1TBKakAENpeKmv
   jji2V/bwAqw+aS5T1BAFER5uTbkbyHb5HgzlNi5rL9zKvRKKrCOWSNLNb
   Jh9/UqQ86ti9JAhT0soEbynQBDRaDe0QCWG+f16Shih9e+1ditd+jx5za
   g==;
X-CSE-ConnectionGUID: v50uP0dsTkGaSEkklLpPDQ==
X-CSE-MsgGUID: XikY+1EBS+G3CYMKaV4mvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="59785092"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="59785092"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:00:40 -0700
X-CSE-ConnectionGUID: lsksx+3EQUqb4vrXiQW2XA==
X-CSE-MsgGUID: qfVbTbAJQF+iIHcpl+feOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="174747856"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:00:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uzJrp-00000004Ad0-3os0;
	Thu, 18 Sep 2025 22:00:29 +0300
Date: Thu, 18 Sep 2025 22:00:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
	casey.connolly@linaro.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aMxWzTxvMLsVWbDB@smile.fi.intel.com>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
 <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 17, 2025 at 02:47:22PM +0200, Uwe Kleine-König wrote:
> On Tue, Sep 16, 2025 at 07:20:20PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 16, 2025 at 6:11 PM Uwe Kleine-König
> > <u.kleine-koenig@baylibre.com> wrote:
> > > On Tue, Sep 16, 2025 at 04:35:35PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Sep 16, 2025 at 03:24:56PM +0200, Uwe Kleine-König wrote:
> > > > > On Tue, Sep 16, 2025 at 10:44:40AM +0200, AngeloGioacchino Del Regno wrote:

...

> > > > > > +MODULE_IMPORT_NS("SPMI");
> > > > >
> > > > > If it's exactly the files that #include <linux/spmi.h> should have that
> > > > > namespace import, you can put the MODULE_IMPORT_NS into that header.
> > > >
> > > > Which makes anyone to import namespace even if they just want to use some types
> > > > out of the header.
> > >
> > > Notice that I carefully formulated my suggestion to cope for this case.
> > 
> > And I carefully answered.
> 
> I tend to disagree. If that anyone only wants some type from the header
> but not the namespace, the if part of my statement isn't given any more.
> Still your reply felt like objection while logically it's not.

You assumed that in case that the header that is *currently* included in the
users, may be the one that used by the same users that needs an imported
namespace. Okay, *now* (or today) it's not a problem, but *in the future* it
might be *when* one wants to use *just* types from it.
I don't think this is likely to happen, but in general including something
"by default" is not a good idea. That's what I'm objecting to.

> > Your proposal won't prevent _other_ files to
> > use the same header in the future without needing a namespace to be
> > imported.
> 
> Oh yes. But that's true for every change: If you change it further you
> have to cope for what is already there.
> 
> > > > This is not good solution generally speaking. Also this will
> > > > diminish one of the purposes of _NS variants of MODULE*/EXPORT*, i.e. make it
> > > > invisible that some of the code may become an abuser of the API just by someone
> > > > include the header (for a reason or by a mistake).
> > >
> > > Yeah, opinions differ. In my eyes it's quite elegant.
> > 
> > It's not a pure opinion,
> 
> That's your opinion :-)

All we said is just set of opinions. Facts are provided by scientific
experiments.

> > it has a technical background that I
> > explained. The explicit usage of MODULE_IMPORT_NS() is better than
> > some header somewhere that might even be included by another and be
> > proxied to the code that doesn't need / want to have this namespace to
> > be present. Puting MODULE_IMPORT_NS() into a _header_ is a minefield
> > for the future.
> 
> Well, for a deliberate abuser the hurdle to have to add the explicit
> MODULE_IMPORT_NS() isn't that big. And a mistaken abuser won't explode,
> just generate a few bytes overhead that can be fixed when noticed.
> 
> In my opinion that is an ok cost for the added elegance.

I tend to disagree. The practice to include (be lazy) something just in case is
a bad practice. Developer has to know what they are doing. We have already too
much bad code in the kernel and opening new ways for more "vibe:ish" coding is
a road to accumulated issues in the future.

I,o.w. I principally disagree on putting MODULE_IMPORT_NS() into the header
file.

-- 
With Best Regards,
Andy Shevchenko



