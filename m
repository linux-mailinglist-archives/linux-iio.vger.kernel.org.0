Return-Path: <linux-iio+bounces-22108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410DEB13CFE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D89188BB90
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004826B2DC;
	Mon, 28 Jul 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DB98i78u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF61E4AE;
	Mon, 28 Jul 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712633; cv=none; b=BuJ73XtjBKbWSUIGiIzu6M0rpcC896F1MEAa8daoo2wrVjWABbKa+yDEurIw4n9TjV4PVbWsZqiPejQTA0fnBq9x6CNf1FWlWVjzD6WLWZCvTcUIEruKJ9dHsw2Aej7j2GIYQgTcYfqu0JDPkgkxhe4+nxuR5pXsO+ya4QTWMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712633; c=relaxed/simple;
	bh=rH8pR2ddL3a4Jy+QTC0sirjYo/PizRCw+rOm0uYcG7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmwUiN76niR+/IIVYeTFl1DmUT8QQOWV4/qi/E15nipSaHR1v8GaoOoAAaHf6swmCUGLhUkwFR8ijIKlZ04kTl9FRyBBRBrWtElLxtbNYshaPlI8iPLifWactsP7D3EUKgqjg5bU2bnqLH7+JavNTnLoT5nKeYHBbIBTQhm/yU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DB98i78u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6269EC4CEE7;
	Mon, 28 Jul 2025 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753712633;
	bh=rH8pR2ddL3a4Jy+QTC0sirjYo/PizRCw+rOm0uYcG7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DB98i78udR890RvkvpZWfYdQol0FIHGtFcytgTGR4hUpO10/i/kBPUYrg7MF/0OTq
	 15jjpmOMzZmTKiI53bHvzwdOJcWCeZbjflZmwSlVcykIlZErVnPuFcbNJv9pKBuIu+
	 lbiWqV+tvjAnUtCuwqVR7eFo7ShwZdV7HoP0bsV4=
Date: Mon, 28 Jul 2025 16:23:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, gshahrouzi@gmail.com,
	hridesh699@gmail.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] staging: iio: ad5933: Fix implicit fall-through in
 switch()
Message-ID: <2025072808-evict-snorkel-8998@gregkh>
References: <aIdKAJVnskdAVUMi@bhairav-test.ee.iitb.ac.in>
 <2025072835-singer-penny-a421@gregkh>
 <aIeDDsRurrgXqRQn@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIeDDsRurrgXqRQn@bhairav-test.ee.iitb.ac.in>

On Mon, Jul 28, 2025 at 07:32:54PM +0530, Akhilesh Patil wrote:
> On Mon, Jul 28, 2025 at 12:39:21PM +0200, Greg KH wrote:
> > On Mon, Jul 28, 2025 at 03:29:28PM +0530, Akhilesh Patil wrote:
> > > Add default case in switch() codeblock in ad5933_read_raw().
> > > Convert implicit error return due to switch fallthrough to explicit return
> > > to make intent clear. Follow kernel switch fall-thorugh guidelines at
> > > Documentation/process/deprecated.rst
> > > 
> > > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > > ---
> > > Checked build for 6.16.0 kernel with ad5933
> > > ---
> > >  drivers/staging/iio/impedance-analyzer/ad5933.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > > index 85a4223295cd..6547a259b8a0 100644
> > > --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> > > +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > > @@ -533,9 +533,10 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
> > >  		*val = 1000;
> > >  		*val2 = 5;
> > >  		return IIO_VAL_FRACTIONAL_LOG2;
> > > +	default:
> > > +		return -EINVAL;
> > 
> > What tool is requiring this to be added?  It's totally redundant and
> > needs to have the tool fixed instead.
> 
> This patch is not inspired by any tool as such.
> I observed this code pattern while manually reading the staging area iio
> code. From my eyes, there is implicit intention to return from switch block if
> no match is found which can be improved in readibility by explicit
> default block returning error.
> I agree this is redundant and will not have any functional impact.
> However, imo - this can help support kernel wide efforts to
> clarify switch() blocks.
> 
> The motivation for this patch is from a035d552 which talks about
> eleminating ambiguity by clearly defining swich() case blocks.

Yes, but the code right after this does the "default return", so that is
now dead code.

I'd recommend the "pattern" that the current code is in, it's simpler.

thanks,

greg k-h

