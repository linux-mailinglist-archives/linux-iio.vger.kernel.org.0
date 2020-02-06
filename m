Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977141541F4
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgBFKes (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:34:48 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52025 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgBFKes (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 05:34:48 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1izeUe-0003Pm-JC; Thu, 06 Feb 2020 11:34:44 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1izeUd-0003I8-9z; Thu, 06 Feb 2020 11:34:43 +0100
Date:   Thu, 6 Feb 2020 11:34:43 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Silvan Murer <silvan.murer@gmail.com>,
        linux-iio@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, kernel@pengutronix.de
Subject: Re: [PATCH 4/3] iio: dac: ltc2632: remove some unused defines
Message-ID: <20200206103443.hki3hxeiigowjlxj@pengutronix.de>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
 <20200203203126.7003-1-u.kleine-koenig@pengutronix.de>
 <20200206102915.2e32cb5e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200206102915.2e32cb5e@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 06, 2020 at 10:29:15AM +0000, Jonathan Cameron wrote:
> On Mon,  3 Feb 2020 21:31:26 +0100
> Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:
> 
> > These two defines are unused since the driver was introduced in commit
> > 02b829f9e11f ("iio: dac: Add support for ltc2632 DACs").
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> A bit of fuzz and the mysterious bit of this being patch 4 of 3 aside all good.
> 
> Applied to the togreg branch of iio.git and pushed out as testing.

If you applied patches 2 and 3 of the series before, the fuzz should
disappear. I assume the threading didn't work as intended for you and
you don't have the original patch series grouped with my patch 4/3?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
