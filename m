Return-Path: <linux-iio+bounces-25433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8435C08BA9
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 07:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBDB1B2899E
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 05:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A72D2398;
	Sat, 25 Oct 2025 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="xEnD/0mm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3382BE7CC
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761371320; cv=none; b=Z07R+OgaXtRP3veuJdZJOo+f/ZDTEf3oiiyyoP5lltM61IgF6Iaz5jGeRnd7ENWwor392ThTPUgdjFM+wU2jDIfmaWPf7v3F9x4aYjmdPj2FMvR0iZhb40nqnAWNBQIgv6NXi0ZKP2+n2t5na3+a9L/ojIg2H9wroNHY9dbIrfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761371320; c=relaxed/simple;
	bh=dMB2rkFWBqWPo+96AANSVyqIxVGRsYvhy7i2cjH8OtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDMebi8/duL5czbJoAKpgEv4zF67H1d4ra4PEJB+9xzdJwY1JDUWOsB+z2IROhkefcCAxTWwgNs2xCUMDz6jEQkcdMhrZg9DrG4GDa2gx3n+KAsdRMI52qM8hha61JanhUtqZpI+A+kL6SuIpn+ss6sJfOBo2tBM7n+6fiFFkSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=xEnD/0mm; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 70462104CBAB
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 11:18:33 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 70462104CBAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1761371313; bh=dMB2rkFWBqWPo+96AANSVyqIxVGRsYvhy7i2cjH8OtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xEnD/0mmohH4j7aa9RaMXLd9zss8M/6wGODA5xmkfxnex7WoPYYEvFwXYiQ4b+nHb
	 hBRTZo7ZQZkTsO1XL3/INlhESi+7QxWsZd6EwJYqnFpjcZ8jQlr0Rc5/GAAtsFi2Yk
	 X/LEkDgDgpnK4OvKOmzlFxK+hfbWvOSfFnvv4fg4=
Received: (qmail 7458 invoked by uid 510); 25 Oct 2025 11:18:33 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 1.177972 secs; 25 Oct 2025 11:18:33 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 25 Oct 2025 11:18:32 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 5AD2F36003B;
	Sat, 25 Oct 2025 11:18:31 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 1FCB01E8160C;
	Sat, 25 Oct 2025 11:18:31 +0530 (IST)
Date: Sat, 25 Oct 2025 11:18:25 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH v3 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <20251025-54825-942964@bhairav-test.ee.iitb.ac.in>
References: <cover.1761022919.git.akhilesh@ee.iitb.ac.in>
 <5cf1419bff57b906faeb942c5d782d7fe70ad41d.1761022919.git.akhilesh@ee.iitb.ac.in>
 <20251023183417.00007d22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023183417.00007d22@huawei.com>

On Thu, Oct 23, 2025 at 06:34:17PM +0100, Jonathan Cameron wrote:
> On Tue, 21 Oct 2025 11:20:30 +0530
> Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:
> 
> > Add driver for Aosong adp810 differential pressure and temperature sensor.
> > This sensor provides an I2C interface for reading data.
> > Calculate CRC of the data received using standard crc8 library to verify
> > data integrity.
> > 
> > Tested on TI am62x sk board with sensor connected at i2c-2.
> > 
> > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> 
> A couple of trivial bits of follow up from me given you are going to be
> doing a v4 for the stuff Andy picked up on.  Otherwise I'd just have
> tweaked it whilst applying for these two.

Sure.

> 
> > diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
> > new file mode 100644
> > index 000000000000..5fcb0447c628
> > --- /dev/null
> > +++ b/drivers/iio/pressure/adp810.c
> 
> > +/*
> > + * Time taken in ms by sensor to do measurements after triggering.
> > + * As per datasheet 10ms is sufficient but we define 30ms for better margin.
> > + */
> > +#define ADP810_MEASURE_LATENCY_MS	30
> I'd just put this value in the one place that it is used and combine the two
> comments on why it has this particular value.

Okay. Removed this macro and used value directly along with
improved comment.

> 
> 30ms seems like a bit over the top for handling silicon variation etc.
> Any background for the large margin?  If you've seen this as necessary
> in practice then just state that - it's useful info to have available
> to a future reader of the driver.

Datasheet recommends value greater than 10ms.
30ms is what I started with for initial testing.
I have checked it working for even 10ms, 20ms etc.
Let me use 20ms here with margin over 10 and mention it
in the comment in code.

> 
> 
> > +static const struct iio_info adp810_info = {
> > +	.read_raw	= adp810_read_raw,
> Trivial but there is no benefit in using a tab before the =
> 
> In general aligning this stuff isn't a good plan. It causes
> a mass of churn in the long run as some of the callbacks have longer
> names and suddenly whole thing needs reindenting.

okay, got it. Fixed. 

Regards,
Akhilesh


