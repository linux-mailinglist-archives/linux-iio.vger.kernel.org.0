Return-Path: <linux-iio+bounces-21285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8CAF6C5B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 10:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A41525E2C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649922BE7DC;
	Thu,  3 Jul 2025 08:00:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE4E2BEC28
	for <linux-iio@vger.kernel.org>; Thu,  3 Jul 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529614; cv=none; b=aJhQw15gA4G/RQNDAqY5vgaUzBmwW4MBbLc07wPSZ6ScuQH386QVolpPvJAeG3L2Oc6SUTaMoPTaVW++V0jbul/op6aEI3fdCAxzcVEQ2De5w9CgchzULBjhosshWjhoKcucJcDJ6Vn58jDVL1w0OYnXBA4wTIVi6hzVGRCDmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529614; c=relaxed/simple;
	bh=eNXha8VcPCqxvSPbnOWlzIBa3iPzaXkNKo/ZQv+7GH8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXrX7Or76/e8rckIJmekrv1AO4yBNAeGyhNcQi7m9ntmGJr6qfSyBR8PFy3Z8tmsusMQZ0sq6wvRRml3nh4eJUj6poKVTNZhVvOg8C8/yyapOOxHdLxDMZRSu1kt1ktF52ftGoQR1fviUvQSUUNNNKojKAhzsMSBok0fiVqWzYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id b8dddcc2-57e3-11f0-9796-005056bdd08f;
	Thu, 03 Jul 2025 11:00:02 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 3 Jul 2025 11:00:01 +0300
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Colin King (gmail)" <colin.i.king@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
	Andy Shevchenko <andy@kernel.org>,
	Gustavo Bastos <gustavobastos@usp.br>,
	Andrew Ijano <andrew.ijano@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>, linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: iio: accel: sca3000: dead code issue
Message-ID: <aGY4gbEW7wJ8bhjh@surfacebook.localdomain>
References: <1c1e39cb-5fe0-46b3-898e-c65bbb3beb30@gmail.com>
 <aGUh7uXenHc7NYB2@smile.fi.intel.com>
 <20250702164022.000027e8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702164022.000027e8@huawei.com>

Wed, Jul 02, 2025 at 04:40:22PM +0100, Jonathan Cameron kirjoitti:
> On Wed, 2 Jul 2025 15:11:26 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Jul 02, 2025 at 10:00:55AM +0100, Colin King (gmail) wrote:
> > 
> > >                 ret = spi_w8r8(st->us,
> > > SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
> > >   
> > > >>>  the call to spi_w8r8 returns 0 on success or -ve on an error  
> > 
> > Where did you get this from, please?  Any link to elixir or Git repo?
> 
> Hmm.  Just for reference the docs of spi_w8r8 are:
> 
> * Return: the (unsigned) eight bit number returned by the
> * device, or else a negative error code.
> 
> Not 0 on success (well not unless it is zero.

Right. My point was that the comment is misleading. With the adjusted comment
the rest becomes immediately clear.

> So the check indeed looks wrong as should be if (ret < 0)

Exactly. Report is valid, the comment in the analysis is not.

> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=ca66d8208762492df8442a503db568d9aab65f2f
> It's in my tree.

I was asking for the link to the spi_w8r8() where it's written like '0 on
success and -ve on error'. Not needed anymore as you cited the documentation.

> I'll drop the patch when I'm on the right machine.  Andrew, could
> you do a new version fixing this up?  If not can make the changes
> but will be at least the weekend before I get a chance.
> 
> Looks like there are a couple of instances of this.
> 
> > >                 if (ret)
> > >                         goto error_ret;  

-- 
With Best Regards,
Andy Shevchenko



