Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84677B5F0C
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfIRIXB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 04:23:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39099 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfIRIXB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 04:23:01 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAVEg-0006sZ-GZ; Wed, 18 Sep 2019 10:22:50 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAVEf-00074x-Ai; Wed, 18 Sep 2019 10:22:49 +0200
Date:   Wed, 18 Sep 2019 10:22:49 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/3] ADC AD799x improvements
Message-ID: <20190918082249.5i45s42obst7mffd@pengutronix.de>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
 <4cab6e664f65d890d9dc7cf03b12eb2ff9f396e1.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cab6e664f65d890d9dc7cf03b12eb2ff9f396e1.camel@analog.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:21:52 up 123 days, 14:40, 70 users,  load average: 0.04, 0.05,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alex,

On 19-09-18 07:00, Ardelean, Alexandru wrote:
> On Tue, 2019-09-17 at 18:09 +0200, Marco Felsch wrote:
> > [External]
> > 
> > Hi,
> > 
> > the main purpose of this serie is to add the pm_ops support. This is
> > important to free the regulators we are using within the driver.
> > 
> 
> Hey,
> 
> Thanks for the patches.
> There are some minor issues with patch 3 with regard to error paths.
> 
> Overall they look good.
> I do have a general comment that maybe ad799x_resume() & ad799x_suspend()
> could be re-used in ad799x_probe() & ad799x_remove().

Thanks for the quick response and comments you made. Please check my
comments I made in line.

Regards,
  Marco

> 
> Thanks
> Alex
> 
> 
> > Regards,
> >   Marco
> > 
> > Marco Felsch (3):
> >   iio: adc: ad799x: fix probe error handling
> >   iio: adc: ad799x: factor out config register update
> >   iio: adc: ad799x: add pm_ops to disable the device completely
> > 
> >  drivers/iio/adc/ad799x.c | 70 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 63 insertions(+), 7 deletions(-)
> > 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
