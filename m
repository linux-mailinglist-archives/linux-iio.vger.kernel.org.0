Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41A1339EB5
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 15:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhCMO5i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 09:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhCMO5J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 09:57:09 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CC464F14;
        Sat, 13 Mar 2021 14:57:07 +0000 (UTC)
Date:   Sat, 13 Mar 2021 14:57:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v6 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity
 driver
Message-ID: <20210313145704.46775626@archlinux>
In-Reply-To: <CAPUE2uu90ySZu6iyanakBZ+Oy-1YSTaHwBaeZdnUxK3ncW9BZA@mail.gmail.com>
References: <20210211024601.1963379-1-swboyd@chromium.org>
        <20210211024601.1963379-4-swboyd@chromium.org>
        <20210214124809.4abfa363@archlinux>
        <161333519805.1254594.18000613822693540497@swboyd.mtv.corp.google.com>
        <20210221155314.56f55e85@archlinux>
        <CAPUE2uu90ySZu6iyanakBZ+Oy-1YSTaHwBaeZdnUxK3ncW9BZA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Mar 2021 13:23:35 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Sun, Feb 21, 2021 at 7:53 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sun, 14 Feb 2021 12:39:58 -0800
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >  
> > > Quoting Jonathan Cameron (2021-02-14 04:48:09)  
> > > > On Wed, 10 Feb 2021 18:46:01 -0800
> > > > Stephen Boyd <swboyd@chromium.org> wrote:
> > > >  
> > > > > Add support for a ChromeOS EC proximity driver that exposes a "front"
> > > > > proximity sensor via the IIO subsystem. The EC decides when front
> > > > > proximity is near and sets an MKBP switch 'EC_MKBP_FRONT_PROXIMITY' to
> > > > > notify the kernel of proximity. Similarly, when proximity detects
> > > > > something far away it sets the switch bit to 0. For now this driver
> > > > > exposes a single sensor, but it could be expanded in the future via more
> > > > > MKBP bits if desired.
> > > > >
> > > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > Cc: Benson Leung <bleung@chromium.org>
> > > > > Cc: Guenter Roeck <groeck@chromium.org>
> > > > > Cc: Douglas Anderson <dianders@chromium.org>
> > > > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > > > Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>  
> > > >
> > > > I'm fine with this, but want to leave a little time for others to take
> > > > one last look.  We've missed the coming merge window now anyway.
> > > >
> > > > If I seem to have forgotten this in a couple of weeks, feel free to
> > > > give me a bump.
> > > >  
> > >
> > > Ok no problem. Gwendal had some comments on v5 that may be applicable
> > > here too but I think they mostly mean that the resume handler may not be
> > > needed if cros ec is fixed. Having the resume handler shouldn't hurt
> > > though unless I missed something. Gwendal?  
> >
> > @Gwendal, could you take a quick glance at this, or alternatively let
> > us know if you need more time to get to it.  
> It will work as is.
> 
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Applied to the togreg branch of iio.git.  My local build test highlighted
a much older kernel-doc naming issue so I've sent out a patch to tidy that
up whilst we are here.

Thanks,

Jonathan

> >
> > Thanks,
> >
> > Jonathan
> >
> >  

