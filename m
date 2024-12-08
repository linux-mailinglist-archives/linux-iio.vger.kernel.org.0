Return-Path: <linux-iio+bounces-13240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B309E8719
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F611884077
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6172A18754F;
	Sun,  8 Dec 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQsZaER1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23822EE4;
	Sun,  8 Dec 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733679264; cv=none; b=fwC5U4wc/uOlTUS70yUoIQWzTjQCwA2P612HCRQ8IsyKt+UqsDBQKsJzq42vmBBmWpECthZrr9ztzMzsF/H2ZMrCqXj7A/IJTTHU44e6Nu+hBDa0JU24Lij6DJYnlVGUBjvCsv95feQ7dQShH+fI1bGLi52J1FoZk7/s77597Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733679264; c=relaxed/simple;
	bh=0tMjJvNUglAsKPSgqHCefRFhhPqxQRqeTXYuDhbP3ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyQ6cyJ4yIO4aU62IfWDSN9bILgMset5xAI5AyAn+HrtC2fM4DPvKgC8JDz4oP6+TobPjtP4SFJ6OQuFHvkQ153Eb0IulHogHOorOKqAlUKyzgDBkw+G0urGbgP64tjxghvuohNut0aWEKouuxXcTRYXvbPzV2vIc4oF00283sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQsZaER1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733679262; x=1765215262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0tMjJvNUglAsKPSgqHCefRFhhPqxQRqeTXYuDhbP3ig=;
  b=RQsZaER1hONPXgDhly/kZc1Js/TJQKXNfC83sT2jFReiiZXRrHst2djr
   NDz61EbbfJdNAmESPjqp/L6C/gzAop9XxD1nRnwq9UYEBUqvKjuD6twtu
   2lHgM2YI9S/dZOxthy86QfVI35JnUbjmwaD4KpUj+5FAG4y8DgiX2cUt4
   er/uy38+v6jwEyiRwLXbdKIQp6LOAhLj+h5mB7a2JlFoiW8G3o9m0QOFc
   ht1YCJ979MMCpg+eLtYkk0KfWEu1RbRgUGJb+8Ofw7oi9jK5NsvuMiQ2+
   hQHZ0OCi+ysD/PdeOUyR4eOweNdAnFW2i4KVmfdbBsRhJqqgTAogOB9Tk
   A==;
X-CSE-ConnectionGUID: wlf0MzvCRPapGqYTdI43vg==
X-CSE-MsgGUID: RLU9pYxxQwaVMSiIhYd26Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33300512"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="33300512"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 09:34:21 -0800
X-CSE-ConnectionGUID: 23ikPc2iTMOdOAMOOZrBgA==
X-CSE-MsgGUID: mMpg/EOeTEGVeKlHsjSe2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="95321595"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.245.12])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 09:34:20 -0800
Date: Sun, 8 Dec 2024 18:34:10 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: kx022a: document new chip_info structure members
Message-ID: <gfgubkilfcsqf4tcfovib6ny7nizrb7xsptyhgs5grz5w6zme2@m5c3lkjwx7fz>
References: <Z1LDUj-naUdGSM6n@mva-rohm>
 <20241207180201.51deb7ce@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207180201.51deb7ce@jic23-huawei>

Hi Jonathan and Matti,

thank you Matti for the patch.

On Sat, Dec 07, 2024 at 06:02:01PM +0000, Jonathan Cameron wrote:
> On Fri, 6 Dec 2024 11:26:42 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> > The kx022a driver supports a few different HW variants. A chip-info
> > structure is used to describe sensor specific details. Support for
> > sensors with different measurement g-ranges was added recently,
> > introducing sensor specific scale arrays.
> > 
> > The members of the chip-info structure have been documented using
> > kerneldoc. The newly added members omitted the documentation. It is nice
> > to have all the entries documented for the sake of the consistency.
> > Furthermore, the scale table format may not be self explatonary, nor how
> > the amount of scales is informed.
> > 
> > Add documentation to scale table entries to maintain consistency and to
> > make it more obvious how the scales should be represented.
> > 

Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> > Suggested-by: Mehdi Djait <mehdi.djait@linux.intel.com>
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Applied to the togreg branch of iio.git. Initially pushed out as testing.
> 
> Mehdi, if you want to give a tag (or more feedback) I am happy to rebase
> for a few days.

the kernel-doc looks good to me.
thank you Jonathan.

--
Kind Regards
Mehdi Djait

