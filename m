Return-Path: <linux-iio+bounces-8439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D64E2950337
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 13:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E71C21F71
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A4198A35;
	Tue, 13 Aug 2024 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9faWz5u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1F189911;
	Tue, 13 Aug 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547079; cv=none; b=HfKPRdqptbO2mtMLl4EASAIw+t0DbBwdaDgGq1U6W+RPInsA02tV9E6YWqZImQWMbylbSR2vzkIAUfvi4lBMejlzw+lftPu5bDKyPSdeHv1Yi1titvdeiNsGmBLngtLzk/2beUwPfFp9Yp/4a3bhHykLSYYRNP0vfXnrdGa22Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547079; c=relaxed/simple;
	bh=njoHA5JSKaX6TwL7T+KhWyO4vGic5hSRZmgTLQWpcxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIg6Re5jer6x0VIk/l4xEhF5qT0qzMjZCY2qfR9JNepzx47zIpvHE2rocmpwZH8gvEZ10ZHv5UySiyBmISNj/fKiZnCx+qv89l658NCGVwogCHDOXCNSvPsufL7Y9xb43JzLnqkh2r9zzzxbQEI7wcrqRvSMG3Z+YORalnpEyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9faWz5u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723547077; x=1755083077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=njoHA5JSKaX6TwL7T+KhWyO4vGic5hSRZmgTLQWpcxM=;
  b=k9faWz5uIRYh1Dc2p3XH/+zutSJwVI/OxqOKR9rQ8eAsvbt9a2ELESM1
   ozIBMhJVaTX4m/+DT0exabIwgMZfu3I6Sgd5IFyXCpQyJ5ue+iz7QdWg3
   y6o74n1N20GelUyz+rNp8TmZ/oLqr3taowHOn6gJDszeSVwT9patj6bf5
   7T6t1CZoidH7AdBhu78BqOiCkCvmGewYimOuIUSVEXOEpi5+xUTP8yh8a
   ddjke0MaI130jUPqTiwC/TLhqDfzrDVFWahUQZVLlbRXTKtxCGQeaQ9Xq
   HLsstxcfnOMsmUm266y4CupF37icSZTGnEF4s06zEhdIHAmA2iVafPTro
   Q==;
X-CSE-ConnectionGUID: K/NcO4JmQH+4+dZcoptWeA==
X-CSE-MsgGUID: pl/DkCLERGKh4xWlKGLk2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33104878"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="33104878"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:04:36 -0700
X-CSE-ConnectionGUID: 6KFF9cYnQxiaAxRB/h5AIg==
X-CSE-MsgGUID: WBEqdBVlQ+qJYQbfWPKPgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="89291865"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:04:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sdpKH-0000000EhZn-1SMV;
	Tue, 13 Aug 2024 14:04:29 +0300
Date: Tue, 13 Aug 2024 14:04:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <Zrs9vYERyOmeOEZ8@smile.fi.intel.com>
References: <20240724155517.12470-1-ramona.nechita@analog.com>
 <20240724155517.12470-4-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724155517.12470-4-ramona.nechita@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jul 24, 2024 at 06:54:40PM +0300, Ramona Alexandra Nechita wrote:
> The filter mode / filter type property is used for ad4130
> and ad7779 drivers, therefore the ABI doc file for ad4130
> was removed, merging both of them in the sysfs-bus-iio

Missed grammatical period at the end.

...

> +What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> +KernelVersion:	6.1

> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> -KernelVersion:  6.2

> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
> -KernelVersion:  6.2

So, the commit message is silent about version downgrade. Was it a typo
or on purpose?

-- 
With Best Regards,
Andy Shevchenko



