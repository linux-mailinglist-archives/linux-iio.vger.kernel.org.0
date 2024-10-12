Return-Path: <linux-iio+bounces-10527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BDB99B6F7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 22:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96D51C20E82
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 20:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07142197A8B;
	Sat, 12 Oct 2024 20:36:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052B1946B
	for <linux-iio@vger.kernel.org>; Sat, 12 Oct 2024 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728765372; cv=none; b=R4N74apb0HqMl4jnnvRMJ8SRS/a4XyuoecaUeodAfLaTWBAYqq7RaMw848/9pKMMH8tY0kUHLy3pLxPDk+mZcXFVfWZ/NHQuWmAlCN1+ffOWcHXc2VJG4h3FFtHnxsbsEdwrnBs+L0hcA1eHOLSK3CCHOuLwRYBfvt3vhKyNJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728765372; c=relaxed/simple;
	bh=3/c35w7D83VLEAha7Zi9HE2mg2SYsKTgY17bYe1C7dk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMemUXCeEft/yEOiALrbyOyHXmUpTH89vLi+h0BQR/+q4VrNL4QKTUF/Qc1Bp85dbd+vMCa0y0gxY4gp5FiKCCt8ubWVzQ2RS4KjSEZ8Kx0JZC8tAvQLnY6c6ecbDsRz28tBYf/2uujfw2U8Z3MTiLpJ8M3I4ufzFaxrVxYgUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-56.elisa-laajakaista.fi [88.113.26.56])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 9bfc8f72-88d9-11ef-9671-005056bdf889;
	Sat, 12 Oct 2024 23:36:08 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Oct 2024 23:36:07 +0300
To: Vasileios Aoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/13] iio: chemical: bme680: fix startup time
Message-ID: <Zwrdt_uaaLaVhM-L@surfacebook.localdomain>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-4-vassilisamir@gmail.com>
 <Zwj3V1oaTO6je-w9@smile.fi.intel.com>
 <ZwlzvboBPppQMEB_@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwlzvboBPppQMEB_@vamoirid-laptop>

Fri, Oct 11, 2024 at 08:51:41PM +0200, Vasileios Aoiridis kirjoitti:
> On Fri, Oct 11, 2024 at 01:00:55PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 10, 2024 at 11:00:20PM +0200, vamoirid wrote:
> > > 
> > > According to datasheet's Section 1.1, Table 1, the startup time for the
> > > device is 2ms and not 5ms.
> > 
> > Fixes tag?
> 
> It is not affecting at all the operation of the driver so I was not sure
> if it was worth it to be backported to the previous versions. This is
> why I didn't put a fixes tag. You think for such a fix is necessary?

The commit message siggests that this is a fix. If you want to make it clear,
that it shouldn't be considered as a such, perhaps you need to rephrase it.

-- 
With Best Regards,
Andy Shevchenko



