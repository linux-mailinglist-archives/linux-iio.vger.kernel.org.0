Return-Path: <linux-iio+bounces-4417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639A8AC5F9
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 09:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279A0B221AF
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E94E4D59E;
	Mon, 22 Apr 2024 07:51:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AF4D13F
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772277; cv=none; b=kGXTcf2/usElZvFUKhLBsoDSpm4Y5m9Ey+j6vusKlsEwF2gaicSwVMAY6/PSKOVgEXkFNRM6jT5d07LgpIzR41TKY61Ztzz7XAHo4+q3/Y3s30P7Nxqtss2ilLzcY9kNYmzPa0ep9HA301hBWj7uphGPBzaFh66dJY4DD/dSEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772277; c=relaxed/simple;
	bh=of3tZou+EIceDxMLhUZBWOajDfDrQFPbBTtE2KVb3UQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/y1VW4jwf88J4PZbKXR516JCVJmWioHFdirv/IYmiFzD1Ed3wXcnpU+SuANGubI61ymesjTUE7EVm7HcKdpDw6FPeFF4KnB2bZB1oeY50oT/PGLaKTLdRT+VOXf36zr9XFnjtkj5eTXsamHEUuwgZ9TyOk3RAVnQLuXm8RdWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 16df0225-007d-11ef-b3cf-005056bd6ce9;
	Mon, 22 Apr 2024 10:51:13 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 10:51:12 +0300
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: accel: Share ACPI ROTM parsing between drivers
 and add it to mxc4005
Message-ID: <ZiYW8LzDqHgu_1RS@surfacebook.localdomain>
References: <20240417164616.74651-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417164616.74651-1-hdegoede@redhat.com>

Wed, Apr 17, 2024 at 06:46:12PM +0200, Hans de Goede kirjoitti:
> Hi All,
> 
> Here is a patch series to refactor the ACPI ROTM orientation matrix
> handling in kxcjk-1013 + bmc150-accel to share the code instead of
> having 2 copies and then also use the shared implementation in
> the mxc4005 driver since some MXC6655 ACPI firmware nodes also
> include this.

You beat me up to it, as I (used to?) have it in my TODO list for a couple of
years or so. Thanks for doing this!

> Note the mxc4005 support is untested, I will ask the report of:
> https://bugzilla.kernel.org/show_bug.cgi?id=218578 to test.


-- 
With Best Regards,
Andy Shevchenko



