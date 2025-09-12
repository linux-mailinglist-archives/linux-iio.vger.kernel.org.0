Return-Path: <linux-iio+bounces-24029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A48B55563
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 19:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B5B3BE80F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 17:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48DA238D54;
	Fri, 12 Sep 2025 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NV7sv65x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075F19047F;
	Fri, 12 Sep 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697328; cv=none; b=k26PFsip4qqjHVxrFFqmF2COLu1kIdovvLe4c2rIPgWtGcncDIY8Zs72niZK9N9rFg5XX23jXnGC64swI0MQM7gbF3Q2fvkFCfaXzwDSlrr1BpNIG5uglLKblFw7pnaN7lqiN9rvvy/oy4D1cUQ877rJLLp+Ii3d/6aemYw9gbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697328; c=relaxed/simple;
	bh=3yUPX5W3UH28cZob8s9+3PMIEJkOYcKfdH+1yj1YBcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g832icQswZbL6FlS4lue+pJQDB4IPsV4a+Plk/2GR4iv6MnfUqabcPzSq+LWbPFhAkXioF1cld7HsEHR7tQkrDY/NQxNQoU423uzW7xYQv4fCSQAGS6i2fAWYis9PjUFV9vAzrF6zujl5oRaZhuHw/IWYfp2kN+PtJ3GbrfiUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NV7sv65x; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757697327; x=1789233327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3yUPX5W3UH28cZob8s9+3PMIEJkOYcKfdH+1yj1YBcc=;
  b=NV7sv65xXwqDwMIEVD5DoJ4u6uWCQgZTlbbMibRwiWmSqsZWm9sxnSEO
   9ciN4EqilwkBaMRXPc4JK6lnAofJUogxsEOdx4q6LBHarNLB8LE56oix4
   FZWRDbpNGZix+o++VZAbK1Bu8MrJ4RQ2tSqQTi3jdRnmyhyXPxb7Bady7
   VgRrmuKVSB9dMjun+BHRU3UjSwysk10Pt1asOm0VrM+hJGuh1muW8T39B
   jYpJkw7SZWjq/yy/eShARbCDcDgYfovqI/z4mKGLpikw6ptRFq0yBRhgN
   +pCGWg0+qMOzDqNlZp/PagfjkAMtU29qK4duZfwDtPDutI1dR5vxY2rGu
   Q==;
X-CSE-ConnectionGUID: cmXJMcB1Tr2pKWeMvb550Q==
X-CSE-MsgGUID: QFDwz+r+QgCHO8d+S1dMrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85479824"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85479824"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 10:15:26 -0700
X-CSE-ConnectionGUID: 9VHk5/OPREeKVQLAkUNLdA==
X-CSE-MsgGUID: W/XpwHLDTJCl34Y6R1yKKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="174091094"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 10:15:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ux7Mn-00000002SDB-2gxd;
	Fri, 12 Sep 2025 20:15:21 +0300
Date: Fri, 12 Sep 2025 20:15:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: adc: ad7124: use guard(mutex) to simplify
 return paths
Message-ID: <aMRVKZGPv4PwR8-o@smile.fi.intel.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-3-b09f492416c7@baylibre.com>
 <CAHp75VdVUOxkKhiheujAK0gjk_GXGqQ0g=LhNDjZr-Of1gH=sQ@mail.gmail.com>
 <d5e53a9c-418c-4c33-bbf4-b7d49d523cf2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5e53a9c-418c-4c33-bbf4-b7d49d523cf2@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 12, 2025 at 09:19:36AM -0500, David Lechner wrote:
> On 9/11/25 11:39 PM, Andy Shevchenko wrote:
> > On Fri, Sep 12, 2025 at 12:42 AM David Lechner <dlechner@baylibre.com> wrote:
> >>
> >> Use guard(mutex) in a couple of functions to allow direct returns. This
> >> simplifies the code a bit and will make later changes easier.
> > 
> > From this and the patch it's unclear if cleanup.h was already there or
> > not. If not, this patch misses it, if yes, the commit message should
> > be different.
> 
> cleanup.h is already there. I'm not sure what would need to be different
> in the commit message though.

I expect something like "finish converting the driver to use guard()()..."

-- 
With Best Regards,
Andy Shevchenko



