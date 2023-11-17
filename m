Return-Path: <linux-iio+bounces-149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490117EF94B
	for <lists+linux-iio@lfdr.de>; Fri, 17 Nov 2023 22:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EF7B20AA6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Nov 2023 21:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFE946436;
	Fri, 17 Nov 2023 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyyMBqi4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E17DB6;
	Fri, 17 Nov 2023 13:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700255652; x=1731791652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eVRu9XIzXKbN6tfwpVjUfg4tPIpkN45JOzL4f+o8wFg=;
  b=cyyMBqi4huGzPjALh3/lVFeBf+q4F+tvcwc1JttcwBDXeP6KvBSIlBKn
   MyFJ6aTwo2tHv2u3IsL6/iicpqDijZim7pwsoJ2Z5gS/aM00uRSCF3o7c
   SXX46KktzRdiwq9x4mHXOkZUMEnN9NEZUqTdOSs84CfwB6OtGZN0KHg7S
   sjNlIUeCyyBciGSauVAYszfFgrfO+at7zSi4rzkPJPQbnLBAA9SxffjsL
   AGTo6f7Jy1FCwHDRg9VrM+PQmNQsZodofqNFxXlkIUTeljokjSz73AATQ
   YR9XOblVX4CH+33JnKTFku0CWWorur659Utak3TkhoSqWePdT+WfZKh2d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="422463588"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="422463588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="794931834"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="794931834"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:14:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r46A6-0000000Eu87-2FQ3;
	Fri, 17 Nov 2023 23:14:02 +0200
Date: Fri, 17 Nov 2023 23:14:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Cixi Geng <cixi.geng@linux.dev>, apw@canonical.com, joe@perches.co,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org, rdunlap@infradead.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Industrial I/O <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: add judgment condition for Kconfig help test
Message-ID: <ZVfXmlBbB3Y12Zz3@smile.fi.intel.com>
References: <20231116153904.15589-1-cixi.geng@linux.dev>
 <ZVarTLiczTZ8oCBg@archie.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVarTLiczTZ8oCBg@archie.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 17, 2023 at 06:52:44AM +0700, Bagas Sanjaya wrote:
> On Thu, Nov 16, 2023 at 11:39:04PM +0800, Cixi Geng wrote:

...

> > the checkpatch result:
> >     WARNING: please write a help paragraph that fully describes the config symbol
> >     #23: FILE: drivers/iio/adc/Kconfig:1050:

> >      	help
> >     +	  Say yes here to build support for the integrated ADC inside of the
> >     +	  Say yes here to build support for the integrated ADC inside of the
> >     +	  Say yes here to build support for the integrated ADC inside of the
> >     +	  Spreadtrum SC27xx and UMPxx series PMICs.
> > 
> >      	  This driver can also be built as a module. If so, the module
> >      	  will be called sc27xx_adc.
> > 
> >     total: 0 errors, 1 warnings, 17 lines checked
> 
> This confuses me. What are you trying to achieve there?

Is the indentation correct in each line? No TABs/spaces mix?

-- 
With Best Regards,
Andy Shevchenko



