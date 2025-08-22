Return-Path: <linux-iio+bounces-23133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B190DB31046
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 09:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE151CE3AC7
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 07:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055BB2E7BCD;
	Fri, 22 Aug 2025 07:25:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6B2E6114
	for <linux-iio@vger.kernel.org>; Fri, 22 Aug 2025 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847516; cv=none; b=Dir+itnprE3h3Bt/H6TJGHt4Ix6yM/6Jn16WBGSlSrnjt7WcWpK5qj7u69T7X87udZBzOri5ootcEfBYGO8DoKz6zXaCua2WgYqEAywjcqArlj79BDELJkLxekBdoRaA6i01uiMr8+PfHmqL4AJ76mf2onIeEDWjuM4VNXAuBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847516; c=relaxed/simple;
	bh=52izTYgMEdjIP4k2Ao5qp2Debi3MKaEkalsTTFyU1Rc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYufkIpYfQcnPzj0EyMdKRR7Nxmqbb4tXhSbwlgYXyTCet6BMVA0Mk1HAQatTTfdrMDHeNu2nOfYoozDO6ouYCbsYZEy5agNGChs2aeoO8KD4o0xZRrcUBB4WA2epVEPoi9lhTK8ZX3wOxWrYvq3oTDKlWYpVR/tJQbVWcYJiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id f70bf665-7f28-11f0-a198-005056bd6ce9;
	Fri, 22 Aug 2025 10:23:57 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Aug 2025 10:23:56 +0300
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de,
	javier.carrasco.cruz@gmail.com, arthur.becker@sentec.com,
	perdaniel.olsson@axis.com, mgonellabolduc@dimonoff.com,
	muditsharma.info@gmail.com, clamor95@gmail.com,
	emil.gedenryd@axis.com, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aKgbDAk9G5Vbsxeq@pixelbook>
References: <20250715085810.7679-1-ak@it-klinger.de>
 <20250715085810.7679-3-ak@it-klinger.de>
 <aHdWAUMMH43tIqV4@smile.fi.intel.com>
 <aIMy_BHJYNA20k-x@mail.your-server.de>
 <aKbqLpJMCxJd3QXW@smile.fi.intel.com>
 <aKdrO7DE8ky2DBu2@mail.your-server.de>
 <4d4120fa-3a20-4cc4-a078-ee94e03229f9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d4120fa-3a20-4cc4-a078-ee94e03229f9@gmail.com>

Fri, Aug 22, 2025 at 08:39:35AM +0300, Matti Vaittinen kirjoitti:
> On 21/08/2025 21:53, Andreas Klinger wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Do, 21. Aug 12:43:
> > > > > > +	part_id = le16_to_cpu(reg);
> > > > > > +	if (part_id != 0x0001)
> > > > > > +		dev_info(dev, "Unknown ID %#04x\n", part_id);
> > > > > 
> > > > > For 0 it will print 0 and not 0x0000. Is it okay?
> > > > 
> > > > I just tried and it prints 0x00 if the part_id is 0.
> > > 
> > > This is interesting... So it's not 0, nor 0x0000?
> > 
> > No. It prints 0x00 on my BeagleBoneBlack with kernel 6.16.0-rc5.
> 
> I think this makes sense because of the '#' -flag. The "0x" is appended
> because of it, and this consumes 2 characters from the 4 character field,
> leaving only 2 chars left for the value.
> 
> What I find interesting is that gcc on my PC does:
> 
>         printf("%#04x\n", 0);
>         printf("%#04x\n", 1);
>         printf("%#04x\n", 10);
>         printf("%#04x\n", 17);
> 
> 0000
> 0x01
> 0x0a
> 0x11
> 
> gcc version 15.2.1 20250808 (Red Hat 15.2.1-1) (GCC)
> 
> It'd be nice to learn why the zero is treated differently? Andy, did you
> have some insight as you asked this?

Nice, we have so many variants now on how to treat 0 with %#x cases...
My understanding was that it should print plain 0 without even 0x prefix, but
since we specify 04 it prints 4 of them, so this behaviour seems consistent to
me, the 0x00 case seems buggy.

Now to the standards...

https://pubs.opengroup.org/onlinepubs/9699919799/functions/fprintf.html

Read this:
"For x or X conversion specifiers, a **non-zero** result shall have 0x (or 0X) prefixed to it."

** -- is my marking to make a point.

So, 0x00 is a bug in Andreas case and has to be fixed somewhere.

-- 
With Best Regards,
Andy Shevchenko



