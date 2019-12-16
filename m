Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1612000A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 09:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfLPIkx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 03:40:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46115 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLPIkx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Dec 2019 03:40:53 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iglvv-0001o2-Hk; Mon, 16 Dec 2019 09:40:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iglvu-00058d-HY; Mon, 16 Dec 2019 09:40:50 +0100
Date:   Mon, 16 Dec 2019 09:40:50 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v4 3/3] iio: adc: new driver to support Linear
 technology's ltc2496
Message-ID: <20191216084050.mlhbdjr6hdnwe4lh@pengutronix.de>
References: <20191209203248.21555-1-u.kleine-koenig@pengutronix.de>
 <20191209203248.21555-4-u.kleine-koenig@pengutronix.de>
 <20191215121612.5e84c8a8@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191215121612.5e84c8a8@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

On Sun, Dec 15, 2019 at 12:16:12PM +0000, Jonathan Cameron wrote:
> On Mon,  9 Dec 2019 21:32:48 +0100
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
> > This chip is similar to the LTC2497 ADC, it just uses SPI instead of I2C
> > and so has a slightly different protocol. Only the actual hardware
> > access is different. The spi protocol is different enough to not be able
> > to map the differences via a regmap.
> > 
> > Also generalize the entry in MAINTAINER to cover the newly introduced
> > file.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Hmm. I'm a little surprised this doesn't run into the issues we used
> to have with single files being linked twice and the interactions
> between built in drivers and modules.

I had in mind that is didn't work in the past, too. But like you, I also
didn't find a broken config and so kept it as is.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
