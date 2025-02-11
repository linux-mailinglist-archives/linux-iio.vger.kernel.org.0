Return-Path: <linux-iio+bounces-15355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E8A314D0
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D175A3A2D88
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4F91E9B1B;
	Tue, 11 Feb 2025 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJRC6hcS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917726156C;
	Tue, 11 Feb 2025 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301330; cv=none; b=fNd5PhEa6Y5sumYVVHrGdrZOV+GLQseTrTpU8eaVja+EfwrYwOzYUkjUoPvyY0D8YmcjXixpfSE4uD4DfuA4CwJpokeQqBFJQOQMtZaV8OODOj0kqJBjNC2z9yRp3BXSuOzEraVOuixRQkF37N2cibOWw/vhr9HrDCydXewBO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301330; c=relaxed/simple;
	bh=Oblq2TnFLcoxe/Hl4UEtbkwhXKUUSr5A7sarI5RJwQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEWJzM0/DvZpvpqPRk/QIVKSZbo0edkcJiKaO+9sYAr+KYOmF9Wu9DCDMoXejw3wn+ekCzSHDAkAnnnBf4Sdu3vW9Jai7bZ5LdzPCb1bHlh3MSNOXr414jBqbcSOKZaTum50lnppVYAd2qDDFEG7zhKRo87h5Nc2NexERT7d7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJRC6hcS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739301329; x=1770837329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Oblq2TnFLcoxe/Hl4UEtbkwhXKUUSr5A7sarI5RJwQ0=;
  b=SJRC6hcSo083p55N9HCxMqMlaBwXn4VAYeoNX6xVp/s6IaDTTShLeTyq
   mCUZyGQrVAt6KiIEMn2VUp5FC9/nwDXuQqsPMR1xb5d6F+YhMVPjkGiAk
   XfG9rcRmbFswFnzSnnuihYOdULJeeLpmbTioa00FhtfdeebinwFtwaakd
   N96fPJZLHEY/d2VfikUyQgH6L2qiTdtFziLJyQ+LViDi1FperlKN7jh5w
   rDxNfAqMh1/ZvdqGh4llmABdmCNIUcoIOBkhg5ker4t86IaB3EJmG86kY
   GZMD7TC9jSNpkVPJu5UsV326uLD37L0S1NrHowjBJwFrPYzATV+jVIHFs
   A==;
X-CSE-ConnectionGUID: HpJ8cMYMQlyGs++jEjLDXQ==
X-CSE-MsgGUID: WSBIULAoTW2Otj2Usp5sKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57348293"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="57348293"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:15:29 -0800
X-CSE-ConnectionGUID: Zw9aQiFwQJG5xVAEMo4CuQ==
X-CSE-MsgGUID: /1rrT6vjR+qIurzT7752og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112563124"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:15:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1thvj6-0000000AbYy-3k29;
	Tue, 11 Feb 2025 21:15:20 +0200
Date: Tue, 11 Feb 2025 21:15:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
Message-ID: <Z6uhyNPbk_93lsci@smile.fi.intel.com>
References: <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
 <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
 <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
 <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
 <Z6tezVXVxVCwXuds@smile.fi.intel.com>
 <Z6tfUfHilO2KLmxv@smile.fi.intel.com>
 <Z6tgNjH6Qq5pe9Gt@smile.fi.intel.com>
 <tnjsrq3trijh4agmbhrfnqeq4iojhwybtg45bwt5n7mg7qqgcx@s7gw7idjuxgd>
 <094f00bc-1001-425f-87ca-84646b68bd70@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <094f00bc-1001-425f-87ca-84646b68bd70@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 06:53:17PM +0000, Mark Brown wrote:
> On Tue, Feb 11, 2025 at 07:45:30PM +0100, Uwe Kleine-König wrote:
> 
> > There was a similar discussion some time ago about the lpss pwm driver
> > (https://lore.kernel.org/linux-pwm/Z09YJGifvpENYNPy@smile.fi.intel.com/).
> > The arguments that you didn't accept back then already are similar to
> > the ones that were brought forward here.
> > The TL;DR; is: Adding MODULE_IMPORT_NS() to a header makes it easier for
> > code to use the exported symbols. Yes, that includes abusers of the
> > code.
> 
> > But if you mostly care about the regular users of an API/ABI, making
> > things easy for those is the thing that matters. Agreed, if you think
> > that module namespaces are primarily a line of defence against abusers,
> > adding the import to the header weakens that defence (a bit). However a
> > typical header includes function prototypes and macros. Those also make
> > it easier for abusers. With your argumentation we better don't create
> > headers at all?
> 
> > There are other benefits of module namespaces like reducing the set of
> > globally available symbols which speeds up module loading or the
> > ability to see in the module meta data that a namespace is used.
> 
> FWIW I fully endorse what Uwe is saying here, forcing every user of the
> API to separately import the symbols seems more likely to create
> busywork than to avoid problems.

I see. Another problem that comes to my mind just now is the module.h to be
included by every header that wants to use MODULE_*() macro. Maybe someone
wants to split mod_namespace.h to decrease an added chaos?

-- 
With Best Regards,
Andy Shevchenko



