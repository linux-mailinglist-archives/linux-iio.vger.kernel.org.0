Return-Path: <linux-iio+bounces-25558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDDCC13BB3
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4872B503F07
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3312DCF4E;
	Tue, 28 Oct 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9UkrCtS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8712E8B96;
	Tue, 28 Oct 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642431; cv=none; b=Wq7PVSrMctnwHhdtcDIF6MYI1TALBKh/+0L7DrOavVhVflM9CDA+WHZ1NvFs4BU0/nsKwef16IE4NAdhbcol1ke4jlqkZ+mYLOf7I8+T6xjaMvjHct85ckIL3BjkCVhxvpomYqVVP9oK5a+6TKp9bduuAkIrlFY6zpMM8s7q2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642431; c=relaxed/simple;
	bh=6sOJNyYpfxdUF4bKHa5kwY8CVFYlhF1MaSnjNBPXnAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAMzb10zJNBE+5lz/izejK+cvoF9IIlqzXt3jXsBai8ZFMYxWLC7F5vI8cHnCmY2tUok6df5MWWSr2bnNoTa//IEEFJK6SdY+wHmS/0dj3eN9tVC6CcB+cm2hmA7xyieagNHHpOCcGCoVZNWjlQbRfBJqxhnG2Yt5aAu6hD9KxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9UkrCtS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761642430; x=1793178430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6sOJNyYpfxdUF4bKHa5kwY8CVFYlhF1MaSnjNBPXnAI=;
  b=X9UkrCtS67KoVdBRzkIFW0ICuzg/bMJtRpyh3P4i/Yr4Ber5kBO6Z8GS
   BTnNiFr8fezuMKVr9fpTo6mMkXa7ohampncKodBBNOmesTSM6Tm6vKpdC
   zP7wMkTaABCdfLUmmC3OVCiLns216hcT+TTyRA1zXZ+Zbod+G7LOyTzzE
   dqQGwI4osNtvXlYZUpjt06WzTqL0m+Iq2VX0BfDGPXPDBArfWvU2vMV1+
   mMjZwE7Uk/KnKT7kbid6bVMxs7l01fAmoiXbH4RUiepboVDS6AOvuwI1O
   tgfwp/RY7n24BXEoNWCx30YgZFHjWaMLRsc9NPKMWESdHL0icOZOIHhhm
   A==;
X-CSE-ConnectionGUID: wlyhL3p6SSi2FIbq/A2lpA==
X-CSE-MsgGUID: zT208oAkS/ywx/JSw2bLjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63663586"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63663586"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:07:10 -0700
X-CSE-ConnectionGUID: mjScgg4IS32FsBzpR4Yw5Q==
X-CSE-MsgGUID: D1+U8ZLKTleyPWb7SyVLBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="215948786"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:07:07 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDffT-00000003GLD-3WHG;
	Tue, 28 Oct 2025 11:07:03 +0200
Date: Tue, 28 Oct 2025 11:07:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miaoqian Lin <linmq006@gmail.com>, Markus Burri <markus.burri@mt.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
 <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
 <aQB8j7Hc3b9vAT5_@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQB8j7Hc3b9vAT5_@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 10:19:27AM +0200, Andy Shevchenko wrote:
> On Tue, Oct 28, 2025 at 10:18:05AM +0200, Andy Shevchenko wrote:
> > On Mon, Oct 27, 2025 at 11:07:13PM +0800, Miaoqian Lin wrote:

+Cc: Markus Burri for the da9374819eb3

...

> > > +	if (count >= sizeof(buf))
> > > +		return -ENOSPC;
> > 
> > But this makes the validation too strict now.
> > 
> > >  	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> > >  				     count);
> > 
> > You definitely failed to read the code that implements the above.
> > 
> > >  	if (ret < 0)
> > >  		return ret;
> 
> > > -	buf[count] = '\0';
> > > +	buf[ret] = '\0';
> 
> Maybe this line is what we might need, but I haven't checked deeper if it's a
> problem.

So, copy_to_user() and copy_from_user() are always inlined macros.
The simple_write_to_buffer() is not. The question here is how
the __builit_object_size() will behave on the address given as a parameter to
copy_from_user() in simple_write_to_buffer().

If it may detect reliably that the buffer is the size it has. I believe it's
easy for the byte arrays on stack.

That said, without proof that compiler is unable to determine the destination
buffer size, this patch and the one by Markus are simple noise which actually
changes an error code on the overflow condition.

The only line that assigns NUL character might be useful in some cases
(definitely when buffer comes through indirect calls from a heap, etc).

> > NAK.
> > 
> > This patch is an unneeded churn.

-- 
With Best Regards,
Andy Shevchenko



