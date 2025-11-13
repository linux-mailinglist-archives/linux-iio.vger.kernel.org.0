Return-Path: <linux-iio+bounces-26195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D98C57DC7
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 15:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB2F234FE04
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7911E2727FC;
	Thu, 13 Nov 2025 14:12:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB42727E7
	for <linux-iio@vger.kernel.org>; Thu, 13 Nov 2025 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043153; cv=none; b=IEYxkagqhPP9+yX3tpcrnvWMjbGKHHn27IcajX8r61yJOQHA/otgwkEMenKrqRklIjVUSiS+f8DZE5osVt6bXd3xxg53rOR+aEqBDzM7lxqlZut+Nf2QsdVX//MZmJ0XR2lse6t6TDP8j67VXsc7ccNnqeoi8F5LeHC7B8HdE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043153; c=relaxed/simple;
	bh=RkB5y2VYXkNcHge0iGbkTzB52hEUcpRneg4/GbjVxgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8jf6ELP+Aa/JMI8RAevza0ski7XM1k+vzbHbKeTxuElEGh0cs8NTiTjY2YhGQfdgQaXZrOo71GnPPec0dMI0EXYYSunFwg+/GDLqWx1ABKOorrjKtiOgsBdC0GK1uJsWn9F4M7I9aE3JS5NhydwL68AYBYgasOxKgXz85ZLpw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vJY3e-00007u-V8; Thu, 13 Nov 2025 15:12:18 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vJY3d-000Gou-34;
	Thu, 13 Nov 2025 15:12:17 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vJY3d-000oXu-2i;
	Thu, 13 Nov 2025 15:12:17 +0100
Date: Thu, 13 Nov 2025 15:12:17 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <aRXnQZvyOLpYjg2i@pengutronix.de>
References: <20251110061409.726028-1-o.rempel@pengutronix.de>
 <20251110061409.726028-3-o.rempel@pengutronix.de>
 <CAHp75Vd9WCXR_QmefqPhWO1niMnESq7LAcN=eYvSiqkWfFrNhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vd9WCXR_QmefqPhWO1niMnESq7LAcN=eYvSiqkWfFrNhA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Hi Andy,

On Mon, Nov 10, 2025 at 10:46:02PM +0200, Andy Shevchenko wrote:

> > - Handles both input and output CRC; uses a non-reflected CCITT (0x1021)
> >   implementation because the generic crc_ccitt helper is incompatible.

For the crc_ccitt() related part I wrote this comment ^^^ :) in the
commit message.

Anyways, after some more research, looks like crc_itu_t() should be used. It
seems to work.

> > +/* 24-bit resolution */
> > +#define ADS131M_RESOLUTION_BITS                24
> > +/* Divisor is 2^(Res - 1) for signed 2's complement */
> > +#define ADS131M_SCALE_DIVISOR          (1UL << (ADS131M_RESOLUTION_BITS - 1))
> 
> Why not BIT() here?

It's meant to signal an arithmetic calculation, BIT() is typically used
for a hardware bitmask or a flag. Should i still use BIT() here or there
is other way to describe it?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

