Return-Path: <linux-iio+bounces-21312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F03BDAF77CF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8581B1C8201B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CADE2ED16A;
	Thu,  3 Jul 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECrnGc3E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C92D9EEA;
	Thu,  3 Jul 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553660; cv=none; b=CpCwRWg3PeHOLsT1cvv4zQU+sAurtlppd65Tzj0Cch+IUlIC+wbODQw3AOZMH/0Hz4ZusI4vqVSAExQ1eEWKkDNEppoUjVc7AwBUmQDYAiSDVcDLDiNd4KuQ29hC70LOKExr+iCiFxRJngg50guh7j/96UBNeE5HJTC9hBqETKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553660; c=relaxed/simple;
	bh=z4NRIUhiE7mvp2Mp3EnicFhxWJQYsP7G97E9kbng+zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ3R8yupHKWZZrMR+gFM94Hdvie/kTNGtUA0FZEJ+erz+qc7/T1O32UpSyE1wyXrDVvZQJfnqxLDTzlS6HvQX938yoaY9hTbbiIGovOY68mDGT43IECiIyl6Z7BiiksmAn8dpj0eXEIx6GI8mPI6pQk1HfI6qd6dHs0yTT2GyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECrnGc3E; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751553658; x=1783089658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z4NRIUhiE7mvp2Mp3EnicFhxWJQYsP7G97E9kbng+zg=;
  b=ECrnGc3EWnUlfOyXBxSpsOWZmB3DjH+QX9vvLjhOWrsBbB54oDwnJLVE
   qex8ihNFie+K0TCKacQBaRu4wLA0XEmmpc6M4bV0vCu823AjAOrfArAye
   VskUfn2+16CnTBdgM/EgC9id28XVcpHbmniisSQKG83ZnnhHrsCjd3xzW
   Wny4r9KFGA6xHHBt+/LtPWyCSvP5y/AUrBko4VAzllKMuVbdAHBInkxIE
   C6dkJRbFiYWhhzh4GXzYvhmfvf0I9UTePJE6f2J/sZSjbhVCA2/7bCp4I
   O6UtVfWLZy7g1uGy5FSpvypR/xreOQc1JYX5NTOy+HLm32wL1MlP9h2ZD
   g==;
X-CSE-ConnectionGUID: Aio3o61JTpKTA5gLleeD6w==
X-CSE-MsgGUID: /ey/Cij1Qviesv7PCW+pNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57556026"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="57556026"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:40:57 -0700
X-CSE-ConnectionGUID: TE8+tTSzRjaJUDhXwfxqOw==
X-CSE-MsgGUID: DKyqnIL4QH2ui/pEZHKn6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="158430505"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:40:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uXL7M-0000000CEJV-3MMt;
	Thu, 03 Jul 2025 17:40:52 +0300
Date: Thu, 3 Jul 2025 17:40:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, bagasdotme@gmail.com,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iio: accel: adxl313: add power-save on
 activity/inactivity
Message-ID: <aGaWdEto-z3_dKr9@smile.fi.intel.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702230819.19353-1-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 11:08:11PM +0000, Lothar Rubusch wrote:
> The patch set covers the following topics:
> - add debug register and regmap cache
> - prepare iio channel scan_type and scan_index
> - prepare interrupt handling
> - implement fifo with watermark
> - add activity/inactivity together with auto-sleep with link bit
> - add ac coupled activity/inactivity, integrate with auto-sleep and link bit
> - documentation
> 
> Sorry for the fuzz: when I was about to rebase for submitting I
> noticed Jonathan actually already applied parts of this. I'd recommend
> to consider v6 rather over v5.
> 
> Since activity and inactivity here are implemented covering all axis, I
> assumed x&y&z and x|y|z, respectively. Thus the driver uses a fake
> channel for activity/inactiviy. AC-coupling is similar to other Analog Device
> accelerometers, so MAG_ADAPTIVE events are chosen. Combinations are
> documented and functionality tested and verified working.

Overall LGTM, one nit-pick somewhere, otherwise feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
to the rest of the series (which has no my tag yet).

-- 
With Best Regards,
Andy Shevchenko



