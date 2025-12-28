Return-Path: <linux-iio+bounces-27405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B47E2CE54C0
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 18:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5874300528D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057961EF091;
	Sun, 28 Dec 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfAyTOqT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0901DFF7;
	Sun, 28 Dec 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766943233; cv=none; b=MnYWKA41zBf0aZYR7VhiauM87XcKHxypp0Rcu7+YjPwYgKwBbKnC9Dt4UVJEMIJmyMxA3EsEYYQfkiE13BwEjgrveEMCfmxdiWI5sCMpgARPwXf7YyqJf5+tZx6kKbnijde98d21kI0pTrhLH6ycZhyVsHofaBVWVgq5SNlg4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766943233; c=relaxed/simple;
	bh=JOrz30gbkT0qXLWquGlHhnTNVmDAFKHuy1gPVXL/wLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7+MnVkZTr2JZHAVq1ckDIUDGcU8RfHFKTB24vc/rhSAz3qm60GCdoBZDfS9T08XD3KGdImWXp4dGhRCkAtNuOajjscQcGcpQQAgLXlh0f+oH6XlpG+VjlYs0rXRx4yoqY4Xi8xSMCP7jfMHA1gr4eBGRDlMW5CNwGqWJQ6XaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfAyTOqT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766943232; x=1798479232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JOrz30gbkT0qXLWquGlHhnTNVmDAFKHuy1gPVXL/wLs=;
  b=DfAyTOqTc7MHxgpqb3EbGj1NqfoM6R3DjqDWUGkSqfQ54I1hf+OuCWIe
   2iCbRl1xzNLlg2Oh4CuoLu6xd1AnnBx7jBvmBqOrHSDGbbDaxjF0W4l1l
   g/1hv5QcBNtKLC0WdCtbKXnwV7FxSGqMZ2NPjHipSDJa2L9fkZKDw6fXJ
   9XbcF7jqF/OOns/0zo/Q3HRJhjzCtYuOIHG0fbcYnLnQJgEx/gDVJH2vo
   UDrlhUKCXInrI3g7UE8X6A6pxqXtwTYAmYDhbapUHZJxCZ+pfWbaWRU9d
   W5JrLF2tufYKr/wqBrLO+PhCkx9+9Qs5pzOgfLMfR+7ZCh9eQXOdlM8Zr
   Q==;
X-CSE-ConnectionGUID: X8vhJ/BIRb60sFYkyfQqhQ==
X-CSE-MsgGUID: Nm2bQxVfS7mvHT011DpeTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="67784511"
X-IronPort-AV: E=Sophos;i="6.21,183,1763452800"; 
   d="scan'208";a="67784511"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 09:33:52 -0800
X-CSE-ConnectionGUID: 00XtMDVBRraVq8U3kv+eOw==
X-CSE-MsgGUID: 42M3m4J4TkORAOX7ZHaT/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,183,1763452800"; 
   d="scan'208";a="199885444"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 09:33:49 -0800
Date: Sun, 28 Dec 2025 19:33:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?utf-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Markus Burri <markus.burri@mt.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
Message-ID: <aVFp-peLKtvyLL9D@smile.fi.intel.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
 <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
 <aQB8j7Hc3b9vAT5_@smile.fi.intel.com>
 <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
 <071e3da4d69e10d64c54a18b7dd34ae11ab68f58.camel@gmail.com>
 <aQDXF-AIF6wNIo76@smile.fi.intel.com>
 <aecd2e25900f2ef38f937a295e995269c433453b.camel@gmail.com>
 <aQDe7-ienRpcfNV_@smile.fi.intel.com>
 <CAH-r-ZE0brfZ_T0tDjV5+D90V9QVLhWUO_-zvPxS7kd=LnDrWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-r-ZE0brfZ_T0tDjV5+D90V9QVLhWUO_-zvPxS7kd=LnDrWg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 17, 2025 at 02:47:17PM +0800, 林妙倩 wrote:
> Hi,
> 
> I don’t have the actual hardware, so I built a similar demo module to
> mirror the bug and ran it in QEMU.
> With KASAN enabled, the PoC triggers BUG: KASAN: stack-out-of-bounds.
> 
> Pattern of the bug:
> - A fixed 64-byte stack buffer is filled using count.
> - If count > 64, the code still does buf[count] = '\0', causing an
> out-of-bounds write on the stack.
> 
> PoC (what it does):
> - Opens the device node.
> - Writes 128 bytes of A to it.
> - This overflows the 64-byte stack buffer and KASAN reports the stack OOB.
> 
> If you have the real device, you may run the similar PoC on your driver
> to validate—just ensure KASAN is enabled to see the report.
> I also tested the straightforward fix buf[ret] = '\0'; with that
> change, the issue no longer reproduces.
> Below are the trace, the demo module, and the PoC for reference.

Thanks for the additional information, I think it would be good to have a
summary of it in the commit message of the fix.

-- 
With Best Regards,
Andy Shevchenko



