Return-Path: <linux-iio+bounces-21287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F6AF6E24
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 11:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77DE3AF296
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D892D46D8;
	Thu,  3 Jul 2025 09:05:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8D2D46D4
	for <linux-iio@vger.kernel.org>; Thu,  3 Jul 2025 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533535; cv=none; b=HCloxV8z6N3tRpDi7FwMjqb+H1XT6UQJObSYjM6+RdwpEkK3C7uZ+pvNZJmeoTC53rD/PRbgu+94SizTsYTBFvnSvv+Wu0NZtJxnDfsIbejOx/qo+nYqGBkURBBKe5EcCkKV7iOuwIE39WMtKs2wQUcIWLPtgTI3QtXoec/1jpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533535; c=relaxed/simple;
	bh=X/OtZrHYw9wMzUW+LghhL9+Dxd7vhit5tE+xLb7/ldc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bez1JROrVf1GVSfT0r+a9/6yQzHBcyieRQgKRMjTUIqECxYP9iHkppLQmtZiciUMLdY+86mKIFe9dy7FGpuDe/BesvJ0QPHr0vJIaiq9uG/KW7cNgFU57a/ReRpav0tJvSPSZXEgQSqBMPXbgGAYZZe9+mW28/uKNrrdC4ja8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id d4d9889c-57ec-11f0-9796-005056bdd08f;
	Thu, 03 Jul 2025 12:05:14 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 3 Jul 2025 12:05:14 +0300
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Akshay Bansod <akbansd@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Message-ID: <aGZHyr5zSRLp1m2p@surfacebook.localdomain>
References: <20250702135855.59955-1-akbansd@gmail.com>
 <f96b68a5-d750-45f0-8cdd-9761b5daca1d@baylibre.com>
 <aGVIcBLgXZj_YR7B@smile.fi.intel.com>
 <e474db53-1b52-48b0-9253-2f62a3861bb4@baylibre.com>
 <20250702163342.00003c66@huawei.com>
 <3361875b-712e-423f-88ed-baf41af5ad22@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3361875b-712e-423f-88ed-baf41af5ad22@baylibre.com>

Wed, Jul 02, 2025 at 10:53:31AM -0500, David Lechner kirjoitti:
> On 7/2/25 10:33 AM, Jonathan Cameron wrote:
> > On Wed, 2 Jul 2025 10:04:23 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >> On 7/2/25 9:55 AM, Andy Shevchenko wrote:
> >>> On Wed, Jul 02, 2025 at 09:16:51AM -0500, David Lechner wrote:  
> >>>> On 7/2/25 8:58 AM, Akshay Bansod wrote:  

...

> >>>>> +		len += sysfs_emit_at(buf, len, "%d.%03d ",
> >>>>>  				 odr_table->odr_avl[i].milli_hz / 1000,
> >>>>>  				 odr_table->odr_avl[i].milli_hz % 1000);  
> >>>>
> >>>> Let's keep checkpatch happy and change the indent of the wrapped lines to
> >>>> line up with ( since the ( moved.  
> >>>
> >>> While I see the point, wouldn't be better to have 1000 replaced with MILLI
> >>> at the same time?
> >>
> >> For anything with 3 zeros, I don't consider MILLI better (or worse).
> >> Science shows that the average human can easily see 3 or 4 things
> >> without having to count them [1]. So it is only when we start getting
> >> more 0s than that is when I think we should be picky about using macros
> >> instead.
> >>
> >> And in this particular case, we are converting milli to micro so `1000`
> >> should be replaced by `(MICRO / MILLI)` if we are going to do that.
> > No we aren't.
> > 
> > This one is converting from milli_hz to hz + sticking to milli for the decimal
> > part.
> > 
> > Lots of other IIO cases where you would have been right, but I think not here.
> 
> Oops. The %03d instead of %06d should have given it away!

I'm not sure I got your comment. The '3' vs. '6' will just define
the minimum amount of printed digits, it does *not* limit the upper
numbers anyhow (it's limited by the 'd', which is (INT_MIN .. INT_MAX).


> >> [1]: https://www.scientificamerican.com/article/your-brain-finds-it-easy-to-size-up-four-objects-but-not-five-heres-why/

-- 
With Best Regards,
Andy Shevchenko



