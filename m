Return-Path: <linux-iio+bounces-26636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D187C9BE06
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 15:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A413A7AA3
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8873223D7EA;
	Tue,  2 Dec 2025 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgNyCLpf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06061F5437;
	Tue,  2 Dec 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687569; cv=none; b=l/6SK8zX1y7C8ZjRVJL826fNfkBKfLfrh0Ega0XLpTz7pL1mFa6Bh8CjFFImcf7QHEDXVqZLAwJD83+FJuXqNy4wRiv6qywfDGdWdh2//v/6h9LRg9f7I654iapyDWn/F3qDvawAAfdmBnTKONbGSee6ux+m/3mbP2ELsUrTFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687569; c=relaxed/simple;
	bh=Y1wAGr1s54q4sMaQDi6lE+9gDZu3Y5CgtQ9oAVeAw0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJMqEiVZwYD+D5sAH1EFZXlRkFJk4YBrW/9iewIjoQUj5IdMxlOXOoVuhc5Ujk1M1W8oasmNrTJR6dfFECbOHKO3oCVfS34TKco+r65ZcemKemAuzxj1solP7WZoXw5urAlEHjzMTWf9A4qYE7Jo0ZQAPWivdPhXkvE6TzVfF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgNyCLpf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764687568; x=1796223568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y1wAGr1s54q4sMaQDi6lE+9gDZu3Y5CgtQ9oAVeAw0I=;
  b=UgNyCLpfnqKbVeBgYqgYZIm20sCUe/TWGJN6qTu5An2QVPZhSgtgFvOB
   9kz/Dmcma8imbf9HZTBKeZhEERbJTSm4bdBOlLsaZZlos9+qIuyubGBI9
   o6fzGmnLot2fFTo6rFqFvaHGQJatJHlRG2JTcRgKhyv1mjGPaBj9Z9gLr
   Ag/+DxxVUIuU8lxiVosdG8tsI4K8+r7zOzHjWLEuIsvAuuGhfk4bi8JcJ
   eBDPLsu7RosiAFUI58JvCSAbX7zpuQ4nJOqMtu0MD6SPm18N80Hc1y8Cl
   s0U7kuMSmHVjzlAkJFVYLHBiyjF1TwxpqZ4iz9aZEgyctD/I4YzaDqoln
   A==;
X-CSE-ConnectionGUID: OEAvrpEuRQa9WH5Pf6qgfQ==
X-CSE-MsgGUID: rEFnAtXVRLOxPvsacmgWHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="84255315"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="84255315"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:59:27 -0800
X-CSE-ConnectionGUID: o9WvgBwcSzup2pZ0pVbbQQ==
X-CSE-MsgGUID: h6FNiSyPQGK4g0qpLIuw4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="225357633"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:59:24 -0800
Date: Tue, 2 Dec 2025 16:59:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <aS7-yml5a2yjM28D@smile.fi.intel.com>
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <a01f95ba-23c0-4c4b-a6bc-31b316bb04ef@baylibre.com>
 <DENT40NRKH0V.3UD0JBGRUSCDS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DENT40NRKH0V.3UD0JBGRUSCDS@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 02, 2025 at 09:39:34AM -0500, Kurt Borja wrote:
> On Mon Dec 1, 2025 at 6:09 PM -05, David Lechner wrote:

...

> I agree, this naming is a bit confusing.
> 
> Andy, are you okay if I revert this back to __ads1018_read_raw()? I can
> add a comment on context.

Only if it doesn't start with __ (double underscore), just find the best suffix
(or prefix?) for it.

TL;DR: I'm against functions without clear semantics to start with __. Usually
this means unlocked in terms of spinlock/mutex/etc. Is it the case here? IIRC
it is not.

-- 
With Best Regards,
Andy Shevchenko



