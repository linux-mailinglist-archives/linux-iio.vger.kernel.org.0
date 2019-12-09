Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65256117025
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLIPSO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 10:18:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53299 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfLIPSO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Dec 2019 10:18:14 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ieKnU-0005lq-5k; Mon, 09 Dec 2019 16:18:04 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ieKnR-0007IX-6b; Mon, 09 Dec 2019 16:18:01 +0100
Date:   Mon, 9 Dec 2019 16:18:01 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 1/3] iio: adc: ltc2496: provide device tree binding
 document
Message-ID: <20191209151801.j36fywjwb4n66bip@pengutronix.de>
References: <20191121210007.25646-1-u.kleine-koenig@pengutronix.de>
 <20191121210007.25646-2-u.kleine-koenig@pengutronix.de>
 <20191201112753.156881b8@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191201112753.156881b8@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

On Sun, Dec 01, 2019 at 11:28:03AM +0000, Jonathan Cameron wrote:
> On Thu, 21 Nov 2019 22:00:05 +0100
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
> > The ADC only requires the standard stuff for spi devices and a reference
> > voltage.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Rob, even with the issues below fixed I can't build test this and get
> 'no schema found in file'.
> 
> I can't seem to figure out why so if you could take a look, that would
> be great.
> 
> > [...]
> 
> Missed this before trying to build test.
> 
> Spaces used in DT not tabs, and this should be in an spi block.
> 
> Please check the example verifies using the instructions in
> Documentation/devicetree/bindings/writing-bindings.rst

I'm not sure if it's me or Rob you are waiting for now.

I just setup dt-schema stuff locally to find out what to improve.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
