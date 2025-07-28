Return-Path: <linux-iio+bounces-22105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825A1B13CAA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CC4545563
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB7271442;
	Mon, 28 Jul 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="r/ZfobB5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF426E6ED
	for <linux-iio@vger.kernel.org>; Mon, 28 Jul 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711396; cv=none; b=ceAI5uGSf3/l3LMuVOgxoPemw9RthRr5EVNsZxvuNRcumvsue7qZxDim1L80cKO9WlnWq27lHrwIKT4htnnVSqRQs4MAHQIt/bo4wh6D3FopVYWJ8Fz23lLJ0Qs28k1oGZxVe6NeRV+VXnWVwKyQRmvUSg1IkrscJlxGQLffEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711396; c=relaxed/simple;
	bh=RTHUsWGnTosevy6Q8OKwIgh47UnQ066Os9T+V5HyCAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNBKBY8mOtECikcC0FleQA8G7lZkXu8KdGkDT1DNsSjGe6H8IvA1OZBwt7NGRR7AjP6NUf0wochRc2RMmg8p+xhSSDX4FU9JTEJY0+XDAMI+K6jxRSj3HWOwT61l0ZaxD80aXq1/EoUDp2iAQOgCuSv9u67cdk3OEH9wyjHyhJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=r/ZfobB5; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 779721014A60
	for <linux-iio@vger.kernel.org>; Mon, 28 Jul 2025 19:33:04 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 779721014A60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1753711384; bh=RTHUsWGnTosevy6Q8OKwIgh47UnQ066Os9T+V5HyCAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/ZfobB5RIU1lH78OFU/2CURMEDbXorXxcHijCNqRyYod+3h+YMx7a7kURDoc2b+j
	 1KJkJ80raDWweC/ymmspijuyCl9rIoIHH2iFqYCwBCqVl2Dv3hxLa38wKckxI/7nGs
	 iiFPHH4XPOm1WRZ86SGNlTEznNJJwxf1+iivk4VU=
Received: (qmail 21921 invoked by uid 510); 28 Jul 2025 19:33:04 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.530725 secs; 28 Jul 2025 19:33:04 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 28 Jul 2025 19:33:01 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id DBA1336003D;
	Mon, 28 Jul 2025 19:33:00 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 9DD2B1E8126F;
	Mon, 28 Jul 2025 19:33:00 +0530 (IST)
Date: Mon, 28 Jul 2025 19:32:54 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, gshahrouzi@gmail.com,
	hridesh699@gmail.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] staging: iio: ad5933: Fix implicit fall-through in
 switch()
Message-ID: <aIeDDsRurrgXqRQn@bhairav-test.ee.iitb.ac.in>
References: <aIdKAJVnskdAVUMi@bhairav-test.ee.iitb.ac.in>
 <2025072835-singer-penny-a421@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025072835-singer-penny-a421@gregkh>

On Mon, Jul 28, 2025 at 12:39:21PM +0200, Greg KH wrote:
> On Mon, Jul 28, 2025 at 03:29:28PM +0530, Akhilesh Patil wrote:
> > Add default case in switch() codeblock in ad5933_read_raw().
> > Convert implicit error return due to switch fallthrough to explicit return
> > to make intent clear. Follow kernel switch fall-thorugh guidelines at
> > Documentation/process/deprecated.rst
> > 
> > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > ---
> > Checked build for 6.16.0 kernel with ad5933
> > ---
> >  drivers/staging/iio/impedance-analyzer/ad5933.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > index 85a4223295cd..6547a259b8a0 100644
> > --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> > +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > @@ -533,9 +533,10 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
> >  		*val = 1000;
> >  		*val2 = 5;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> > +	default:
> > +		return -EINVAL;
> 
> What tool is requiring this to be added?  It's totally redundant and
> needs to have the tool fixed instead.

This patch is not inspired by any tool as such.
I observed this code pattern while manually reading the staging area iio
code. From my eyes, there is implicit intention to return from switch block if
no match is found which can be improved in readibility by explicit
default block returning error.
I agree this is redundant and will not have any functional impact.
However, imo - this can help support kernel wide efforts to
clarify switch() blocks.

The motivation for this patch is from a035d552 which talks about
eleminating ambiguity by clearly defining swich() case blocks.

Thanks for the review, 

Akhilesh

> 
> sorry,
> 
> greg k-h

