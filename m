Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D6F8949
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 08:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLHEX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 02:04:23 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43317 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfKLHEX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Nov 2019 02:04:23 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUQDe-0007eF-Fo; Tue, 12 Nov 2019 08:04:06 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUQDd-0000zU-7K; Tue, 12 Nov 2019 08:04:05 +0100
Date:   Tue, 12 Nov 2019 08:04:05 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ltc2496: provide device tree binding
 document
Message-ID: <20191112070405.zinuqnfb3wqbehvw@pengutronix.de>
References: <20191111214025.18310-1-u.kleine-koenig@pengutronix.de>
 <b6ed43afbfb0128301f11198eb83a8f72b7661e9.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6ed43afbfb0128301f11198eb83a8f72b7661e9.camel@analog.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Alexandru,

On Tue, Nov 12, 2019 at 06:57:49AM +0000, Ardelean, Alexandru wrote:
> On Mon, 2019-11-11 at 22:40 +0100, Uwe Kleine-König wrote:
> > The ADC only requires the standard stuff for spi devices and a reference
> > voltage.
> 
> DT bindings must be in YAML format.

Yeah, I noticed this trend. But given that I only saw .txt files for
iio, I thought I'd stick to that.

> But in this case, you can probably extend the existing
> "Documentation/devicetree/bindings/iio/adc/ltc2497.txt".

I considered that shortly, but as the ltc2497 is an i2c device and the
ltc2496 uses spi I chose to create another simple document instead of
complicating the existing one by describing two nearly orthogonal sets
of properties.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
