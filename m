Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C653713F4
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 13:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhECLGT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 3 May 2021 07:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhECLGT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 May 2021 07:06:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AEC061208;
        Mon,  3 May 2021 11:05:24 +0000 (UTC)
Date:   Mon, 3 May 2021 12:06:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
Message-ID: <20210503120615.64b396bd@jic23-huawei>
In-Reply-To: <CY4PR03MB311245DA10E715A44DDC10C099409@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210428150815.136150-1-paul@crapouillou.net>
        <CY4PR03MB3112198E9789BF3D95959E6F99409@CY4PR03MB3112.namprd03.prod.outlook.com>
        <CY4PR03MB311245DA10E715A44DDC10C099409@CY4PR03MB3112.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Apr 2021 15:33:21 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Sa, Nuno <Nuno.Sa@analog.com>
> > Sent: Wednesday, April 28, 2021 5:31 PM
> > To: Paul Cercueil <paul@crapouillou.net>; Jonathan Cameron
> > <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Peter
> > Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
> > 
> >   
> > > From: Paul Cercueil <paul@crapouillou.net>
> > > Sent: Wednesday, April 28, 2021 5:08 PM
> > > To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > > <lars@metafoo.de>; Peter Meerwald-Stadler
> > > <pmeerw@pmeerw.net>
> > > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Paul
> > > Cercueil <paul@crapouillou.net>
> > > Subject: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
> > >
> > >
> > > The ioctrl() call will return errno=EINVAL if the device does not
> > > support the events interface, and not ENODEV.
> > >
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>  
> > 
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >   
> 
> I guess this should have a Fixes: tag...

So, I did a bit of detective work on this one.  Seems this change in error
code was actually introduced as a side effect of Alex's recent rework of
the IOCTLs.  Prior to that we returned -ENODEV for this case and now
we do indeed return EINVAL.   

So we may need to figure out how to fix that, or decide that such is life
and modify this code to give the right error message as done in this patch...

Linus / Alex, thoughts?  It's always been a bit messy because we also
return -ENODEV in the path where the ioctl hits a driver that is going away
so it hasn't uniquely identified a lack of support for a long time, even
if that is by far the most likely reason for this return code.

Jonathan


> 
> - Nuno Sá

