Return-Path: <linux-iio+bounces-25568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9448C13FC8
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 11:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429583AD32A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF482E8E1F;
	Tue, 28 Oct 2025 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEMyhoiH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C12264D3;
	Tue, 28 Oct 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645531; cv=none; b=B+K8wQqzvErgT5RlZcDPGwXLpn7B8UcWu6YCxcBrFz3mBreNhWNKzrW5LGIDGT3pU7qbw25CKJQqUYlxIzIll82vkJEvVVCfeq0UVZ/fTslq8Iqaq4wSwRyXwNTMTbvthBFiVloM8RAfJ3FFWtQ4OxKX770RHDVVpc3SBpHPkFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645531; c=relaxed/simple;
	bh=j1Wuuai0DHLOISftaFJXhAj539lvrP+aY1BqLm3W/y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zik2HceWzchBLnq3PgxpOLZuLyOTd35MNmUo0S2eCsAahFrgTTtysYutzQxdJ+Fg8nnBq314O88+4704LfFAcPVheW705ssKQ3F/c6Sd7IpT88DEgswkX3upwZ1zeyoNpDobJaipvDj4je0xRvyJe96dm6vdtj5lpkryqi5O/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEMyhoiH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761645530; x=1793181530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j1Wuuai0DHLOISftaFJXhAj539lvrP+aY1BqLm3W/y0=;
  b=TEMyhoiH20VPij3C++/Zqoqod+bzbjyI+UjRpTT2AwD1FZTFXQpcDOk5
   plRKuVktGRx/QXA26UdEQIq2gCXOpuWLgQPkJKaN4eWdEuGN42TGHlCf/
   a/l106OgcePKDPCKVya/uj+sXoXVCK49AjszF8IAHHXkcD5Fbshld/1Zm
   24XM3pDel4C/AhETzia1euEaWa/L3oOwStmGrxzJLq8KMfGEmys5YVCec
   gNB/vZ+YSNTHjFHUW0Q9akzJCmrMbdmkHeVEtCHPdA2mEuwuFvjmjbw5W
   049T675lIdawW5oC0fv556IYbnfEcf3SEOu1Hm0EQloLB6H80E4nY7svd
   A==;
X-CSE-ConnectionGUID: PGuJD9ytTmS+qPyCi9lo+Q==
X-CSE-MsgGUID: A7L9dBxDQui3hlZViChdBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86367803"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="86367803"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:58:49 -0700
X-CSE-ConnectionGUID: 3638tNjiTaamivKL0wNKgw==
X-CSE-MsgGUID: Hui5lH8yTue+8ZrcL5g7dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="189617977"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:58:46 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDgTS-00000003H7H-3TYM;
	Tue, 28 Oct 2025 11:58:42 +0200
Date: Tue, 28 Oct 2025 11:58:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?utf-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Cc: Markus Burri <markus.burri@mt.com>,
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
Message-ID: <aQCT0q4hKtlVbJDU@smile.fi.intel.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
 <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
 <aQB8j7Hc3b9vAT5_@smile.fi.intel.com>
 <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
 <CAH-r-ZEG5qN5QNCJTnX_oK2uyheNjvzoAEgzuyTYyUWF4kf+wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-r-ZEG5qN5QNCJTnX_oK2uyheNjvzoAEgzuyTYyUWF4kf+wQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 05:46:53PM +0800, 林妙倩 wrote:
> Andy Shevchenko <andriy.shevchenko@intel.com> 于2025年10月28日周二 17:07写道：
> > On Tue, Oct 28, 2025 at 10:19:27AM +0200, Andy Shevchenko wrote:
> > > On Tue, Oct 28, 2025 at 10:18:05AM +0200, Andy Shevchenko wrote:
> > > > On Mon, Oct 27, 2025 at 11:07:13PM +0800, Miaoqian Lin wrote:

...

> > > > > + if (count >= sizeof(buf))
> > > > > +         return -ENOSPC;
> > > >
> > > > But this makes the validation too strict now.
> > > >
> > > > >   ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> > > > >                                count);
> > > >
> > > > You definitely failed to read the code that implements the above.
> > > >
> 
> I previously read the simple_write_to_buffer(), but add the check and
> think it can help to catch error eariler. My mistake.
> 
> > > > >   if (ret < 0)
> > > > >           return ret;
> > >
> > > > > - buf[count] = '\0';
> > > > > + buf[ret] = '\0';
> > >
> > > Maybe this line is what we might need, but I haven't checked deeper if it's a
> > > problem.
> >
> > So, copy_to_user() and copy_from_user() are always inlined macros.
> > The simple_write_to_buffer() is not. The question here is how
> > the __builit_object_size() will behave on the address given as a parameter to
> > copy_from_user() in simple_write_to_buffer().
> >
> > If it may detect reliably that the buffer is the size it has. I believe it's
> > easy for the byte arrays on stack.
> >
> > That said, without proof that compiler is unable to determine the destination
> > buffer size, this patch and the one by Markus are simple noise which actually
> > changes an error code on the overflow condition.
> >
> > The only line that assigns NUL character might be useful in some cases
> > (definitely when buffer comes through indirect calls from a heap, etc).
> >
> 
> I believe it is still necessray to use buf[ret] = '\0'; intead of
> buf[count] = '\0';
> If you argee with this, I send a v2 with just this fix. Thanks.

As explained above, please try to model the situation and see if current code
is buggy, i.e. provide a step-by-step test case and show a traceback that
points to a out-of-boundary access in this function. (Note, you don't need to
have a HW for that, you might need to create a dummy IIO or other module with
the similar interface and run it, in such a case, share also link to the source
code of that module.) When you prove the problem exists, I will happily ACK
all similar patches, including yours.

> > > > NAK.
> > > >
> > > > This patch is an unneeded churn.

-- 
With Best Regards,
Andy Shevchenko



