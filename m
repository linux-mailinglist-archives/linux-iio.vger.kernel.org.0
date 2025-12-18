Return-Path: <linux-iio+bounces-27158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EE8CCB7D1
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E13830AEC82
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 10:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670CE33769A;
	Thu, 18 Dec 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gljlr9qD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A992337686
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052635; cv=none; b=ThEc32ZWioKY8Gdj75irCeBUvB+W7hEceuwe+v3LpSXEdpxildsUP2qGt4X732OZ2iMzz4YR32LUHcrOeI/oFEvjJx1HdnBc7W/dSd4qeijHqMnkavMrX4SYNbmX1yquYLXrvG+NhQhDljZkNVW3d0pxQ0nYKzwQJzP3zg7YEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052635; c=relaxed/simple;
	bh=d50Px/qfr+PrzgR0I8JX0AmIlDh1UVS8W8GyqkC6p9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GScsOGCM8qVanw9KuqPRoEokH4Ki4qo0TsleKu/LkFAib5+ZRPdYUjuCENEAGug70kUhjxMQ7/8uzCve9oasB8Cw6/ezdTqFgpRSQIK+2j7HdaxrNrVQ3+6AmAEC2cA/9Fuz1NwCjrlJlhmt+o5ppqyOyTVTsmoi7+kEh/jcDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gljlr9qD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 853E64E41C78;
	Thu, 18 Dec 2025 10:10:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FAC9606B6;
	Thu, 18 Dec 2025 10:10:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3913E102F0B35;
	Thu, 18 Dec 2025 11:10:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766052628; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=aO3u3ejVDuiMShV21LEf8qEp3E0KkHu3ersORiBehYo=;
	b=Gljlr9qDSS1/Gj4pw5zXrFzy1YL53sD3GN1zjdWZjbGON7nln+uq/9x/2PpstZcxSrQuR1
	3dnOrS0pBZaf3eg8tgbsv/begC9SAbs4lplOOY9uOAqsLP7+9d1HsFe6771y7BLPwJFZkn
	a/4OMdYCRBemi+S6g0tINiOJutdcrtBGUWJy33bBZASENhXnWvaqkrriXNjfzmHdvlzxs5
	yCckCm6VciJKjrIBhsHmABBIJ+84V0bUNbt1NKnH1J5J/ra1g9J5oWDyCFJUp47xm1OeNs
	v+uzDWcDm6jwem6XE0h2vycLVqofp7iahE05saicu4FG3IWB98rWtJ7e77xD1A==
Date: Thu, 18 Dec 2025 11:10:21 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, linux@roeck-us.net,
	Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v11 6/6] iio: magnetometer: Add mmc5633 sensor
Message-ID: <202512181010210ddb2a03@mail.local>
References: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
 <20251106-i3c_ddr-v11-6-33a6a66ed095@nxp.com>
 <20251109135728.223d3857@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109135728.223d3857@jic23-huawei>
X-Last-TLS-Session-Version: TLSv1.3

On 09/11/2025 13:57:28+0000, Jonathan Cameron wrote:
> On Thu, 06 Nov 2025 12:36:05 -0500
> Frank Li <Frank.Li@nxp.com> wrote:
> 
> > Add mmc5633 sensor basic support.
> > - Support read 20 bits X/Y/Z magnetic.
> > - Support I3C HDR mode to send start measurememt command.
> > - Support I3C HDR mode to read all sensors data by one command.
> > 
> > Co-developed-by: Carlos Song <carlos.song@nxp.com>
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> > Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change in v11
> > - add andy shevchenak's reviewed by tag
> > - use unsigned int for regmap
> > - compact mmc5633_read_avail arg list to few lines
> > - move check condition to one line for read_poll_timeout()
> > - leave i3c_xfer as size 1 array to align existed code style in kernel
> > tree, git grep -r i3c_priv_xfer drivers/, leave to jonathan to do decide.
> I don't feel strongly either way, so fine with just having it as
> you have it here.
> 
> I'm assuming there will either be an immutable branch that I can
> pick up to get the i3c changes, or that we'll split this across cycles
> (so i3c bit goes in this cycle, driver next).
> 
> So I'll keep an eye open for how that part merges if everyone is happy
> with it.  Feel free to poke me if I look like I missed it.

I guess you have seen the resend by now but I took the i3c patches quite
late in the previous cycle so I didn't bother creating an immutable
branch. Feel free to review and apply v12 when you have time.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

