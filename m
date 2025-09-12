Return-Path: <linux-iio+bounces-24033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD341B555E7
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 20:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F261D65AED
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 18:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E4A32A818;
	Fri, 12 Sep 2025 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSruaq6N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F0C302CB2;
	Fri, 12 Sep 2025 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700722; cv=none; b=lPLJLUPRck6bYGOjMH4yFEBrP+sZa09RajbfL4qf7zbr6Fq5FmjHFUnBRghFEf7miF5fwTaLkaSD25zS6i4sFxEfQdzwdXb6xfDRV/IhGwogQnuyjuwwSC60a07rMgH3EEVD2Nw5Y5AySlEO+ruDB5RlxLjGnmaYqpRI/4kJMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700722; c=relaxed/simple;
	bh=G/DfYWfyBcTIxnaGWtEtmTaIlg0y10nt3+JTC4i5X3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtZKjSsX2hL2zv6TM5zc+aX5k+xIqaZxlADGM41+ClkuAwB93lJWrsUsSGRmT/IzSMeuZWiJZATiloOz9tlQiP8W6kzBNmDXjk9Qsu36P4ox9c+P9rEhdCQ2T3sR1K9qqnTz5zH10+dZ2Y86EfX/qfn2zmm5ZbVYJ9JPDPgHbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSruaq6N; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757700721; x=1789236721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G/DfYWfyBcTIxnaGWtEtmTaIlg0y10nt3+JTC4i5X3c=;
  b=QSruaq6N4UaPLw9Nq7ooRbRjtmOHLnTkWp0ieY9TghQQxCZYRRj2UhIb
   dCwmfmrXX1zkIse18tdiQGxdU7t2fC6CgHcA21hWTGXOuE9pmkxGEG8nq
   S8LTketg1DDBP2DjZrVMzg1XDemRcpmE1Bp3DK2l+J7+tRLBJQVxC4+fL
   5Qrag4B1WK/CX0WDiA617JgnRt4pALDdpsCS5OzuOH9IgSsE5s1lmFxEF
   53OfZ7gEbM0M+oRFMPMboStORdRc9gE9Ag76dYPzORE8ZeJ8oLuGdn+16
   7U+G8NjTDZJhMTvHz2uSTboNi2bXqJILgZai/G6AaNrP02MzuICHn6Py+
   w==;
X-CSE-ConnectionGUID: Z1V3apC9Sj6wuoqHCW3gqQ==
X-CSE-MsgGUID: HbYb//Z0TBum5RQSXCBJPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="62679124"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="62679124"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:12:01 -0700
X-CSE-ConnectionGUID: FFBSDgPGQMaVi80E0z0mFQ==
X-CSE-MsgGUID: +iCzn8cwRJusFzgnqcrE/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="174466176"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:11:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ux8FY-00000002T33-2SYc;
	Fri, 12 Sep 2025 21:11:56 +0300
Date: Fri, 12 Sep 2025 21:11:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/7] iio: buffer: deprecated
 iio_push_to_buffers_with_timestamp()
Message-ID: <aMRibFBtaYu4F3_z@smile.fi.intel.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
 <20250912-iio-doc-push-to-buffers-context-v1-4-c4aad013d96e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-4-c4aad013d96e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 12, 2025 at 11:05:55AM -0500, David Lechner wrote:
> Replace the documentation of iio_push_to_buffers_with_timestamp() with
> a deprecation notice pointing to the preferred alternative.

...

> + * This function is deprecated. Use iio_push_to_buffers_with_ts() instead.

There is informal practice to mark function deprecated (in the kernel
documentation), it's something like using capitalised DEPRECATED. Grep for
better examples.

-- 
With Best Regards,
Andy Shevchenko



