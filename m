Return-Path: <linux-iio+bounces-13026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CDF9E1E33
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 14:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715911668A1
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EAE1F12FB;
	Tue,  3 Dec 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZsoufkj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F11EE006;
	Tue,  3 Dec 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233822; cv=none; b=SyFZq1ZfWBDLevonW+BWMUKIfHGELe2IBP1rCytKRDc4+pk7EjUzpGqqxyq0CXRP8s8rCvhGM9H8uu07feaYF51suyuDv41LkxfU0k2RjMaxVXQHvldsbpPBg2UBNj8doUvp76NaHYfmYBQ8i9yt0qunxK/GYsBYm8HnDJ6/XD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233822; c=relaxed/simple;
	bh=Zib4VMRdhk2SyW/n2/OIybINtZxsOwBjr0XGB3bosyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOY4zvJvYlffNO86tJv3+slXnbiIksYbiMlnxEhuqfq0J5LtHpF9MEPrft3vLg9hmnSAQujAOQ7BhLSlh+jkCJsZPta43UXRF49gnYVYur9HJ9dOzGqsgCvpu2ikEdvRqXate8QJPySVfiMa69Z5AYNwkLBScgmpnYtRNIIKFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZsoufkj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733233821; x=1764769821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zib4VMRdhk2SyW/n2/OIybINtZxsOwBjr0XGB3bosyo=;
  b=dZsoufkjYJiRMBnMGI+ljKejykHpieC7uSDfBfpMuF/C8SYsLG+4kNL5
   0lrOREsiLKD93WMo9joY1rsW4xu8qt+htzacOiUmafNWCB27zq2IAlP5q
   WRo2EAU2JxnwfnZds1FlGAgJWYDIAUrdkM4Da25/k1RaisF2Ntf4/8PP9
   pPTNXPIHbVTtMj/hZUwBqGj6/GJWDOxItqDsihFm1n/BnM6iQJN7Vnt8d
   QnxT/ohjRHBbeSSbpCtmOIfWFYlif3KG2Ihc/oFnSHjqM3ENUWaDcIYnl
   sXqaPQOPSz0lUne1vIvQFpMJsLqCOpX/8ac8yk72dnLBZF+VONj0Bbdfs
   Q==;
X-CSE-ConnectionGUID: C4gnboSiRYO8WQHA3/mU6Q==
X-CSE-MsgGUID: Z6rHieKvSMOIyfAUnbVPyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="36299231"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="36299231"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:50:20 -0800
X-CSE-ConnectionGUID: Y3t33y3ySZ+ldxE8KMacsw==
X-CSE-MsgGUID: 4TpyAc/pSOWCHKgyzIC1TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130904309"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:50:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tITI1-00000003S9G-1cCT;
	Tue, 03 Dec 2024 15:50:09 +0200
Date: Tue, 3 Dec 2024 15:50:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com, tgamblin@baylibre.com,
	matteomartelli3@gmail.com, alisadariana@gmail.com,
	gstols@baylibre.com, thomas.bonnefille@bootlin.com,
	ramona.nechita@analog.com, mike.looijmans@topic.nl,
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
Message-ID: <Z08MkR40fjfW3MXZ@smile.fi.intel.com>
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
 <20241203091540.3695650-3-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203091540.3695650-3-j2anfernee@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 03, 2024 at 05:15:40PM +0800, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up to
> 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins for
> independent alarm signals, and the all threshold values could be set for
> system protection without any timing delay. It also supports reset input
> RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events support.

Please, get rid of explicit castings where the are not needed or implied, like

	u16 foo;
	...
	foo = (u16)bar;

you have a lot of this in the code.

Second, why do you need two regmaps? How debugfs is supposed to work on the
registers that are 16-bit if you access them via 8-bit regmap and vice versa?

Can't you simply use bulk reads/writes when it makes sense and drop 16-bit
regmap completely?


-- 
With Best Regards,
Andy Shevchenko



