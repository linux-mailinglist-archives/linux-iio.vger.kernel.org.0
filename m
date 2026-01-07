Return-Path: <linux-iio+bounces-27528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7AACFFC5B
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 20:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A58E93008726
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 19:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211D633AD81;
	Wed,  7 Jan 2026 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHYe90kO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE14335567;
	Wed,  7 Jan 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799857; cv=none; b=YPVvo9VRCppsMw1aFbyoOkkciP7Wgd5gK0VGJ/YRbn6akzTCjvEqN1RnK2pT3qlD7dNjDY5zeBvYxRq5+68FgIAcnDljGG9f4wmJhV2zjMLMWjYlnqTQ5wiKtcwm79rNAn+PvIfwS/TgOYb3BSw0S3m/be/X/fzQhkHSTkYlyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799857; c=relaxed/simple;
	bh=e8FKn11v79ssXsv0JerpySvSnmHmZncjqqH0AJm/f+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpVHIfkCnSsnEdvfn66Dt8SAD8Y/dv2zWDDN7vTs0PBbhGvM/J/uqIsedqzyQnLKmf0nFS+/JHd8gA5FUsTj8bL3kO6HLZ5DDtd9ZYff6gyBKTIILdfS4RuVXbm+GbHlnhTiutPag3PyuU7iRlbrFmtH8m1xHQnKZSZ4+Z2Gk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHYe90kO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767799854; x=1799335854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e8FKn11v79ssXsv0JerpySvSnmHmZncjqqH0AJm/f+I=;
  b=YHYe90kOvlx1Je6JKnwi0ZLZdhU3+cuznDzzyhIvgu3ZSAky8W1yEAk2
   p2unS8Lc5Mz0fDH8olwgRWsaVgCfF7LYtG3FqEAlKTOX5Mj05ioT8O58S
   FiyPesoOzy0pnushVwgXZ2ZIJa9g4ES0TUKP8K5TB5MoGFUah9el1h4O4
   MzgKTLMdNXQeDgmt04xHBdw1FqY9ItJ0Gos/ioaeJrOhDjAQsaJbXjq9V
   iEdRmJRn5yqazmIY0v8s/3tw1NjtKWKHKyqgFFm7OoqJHcK/Qn8GIWTCI
   ksM/F/MxHidz5j7PWmdUuF54dGjmHB2rTPvZn4h3cwwy9cqubASrxf7WE
   Q==;
X-CSE-ConnectionGUID: 4vl9Qk7jTsuy5WLhVY09Wg==
X-CSE-MsgGUID: nzG/lcV9QkCyTTZmU/cbkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="94639313"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="94639313"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 07:30:52 -0800
X-CSE-ConnectionGUID: 2Ig73mmiRQC9/YDa8EoXow==
X-CSE-MsgGUID: t64rvZbTRtKmUQ6tZebOQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="202963615"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 07:30:51 -0800
Date: Wed, 7 Jan 2026 17:30:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
Message-ID: <aV58KPqNn9uYRMk6@smile.fi.intel.com>
References: <20260107143550.34324-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107143550.34324-1-linmq006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 07, 2026 at 10:35:50PM +0800, Miaoqian Lin wrote:
> When simple_write_to_buffer() succeeds, it returns the number of bytes
> actually copied to the buffer. The code incorrectly uses 'count'
> as the index for null termination instead of the actual bytes copied.
> If count exceeds the buffer size, this leads to out-of-bounds write.
> Add a check for the count and use the return value as the index.
> 
> The bug was validated using a demo module that mirrors the original
> code and was tested under QEMU.
> 
> Pattern of the bug:
> - A fixed 64-byte stack buffer is filled using count.
> - If count > 64, the code still does buf[count] = '\0', causing an
> - out-of-bounds write on the stack.
> 
> Steps for reproduce:
> - Opens the device node.
> - Writes 128 bytes of A to it.
> - This overflows the 64-byte stack buffer and KASAN reports the OOB.
> 
> Found via static analysis. This is similar to the
> commit da9374819eb3 ("iio: backend: fix out-of-bound write")

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



