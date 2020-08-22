Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E024E6E8
	for <lists+linux-iio@lfdr.de>; Sat, 22 Aug 2020 12:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgHVKe6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Aug 2020 06:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgHVKe5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Aug 2020 06:34:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1212D206BE;
        Sat, 22 Aug 2020 10:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598092496;
        bh=lT8ePGnV0IpH+H8t5vaX3Xg/C0JW0P4Ev85+R0m/tqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IKoiGQqILh/XFTtwnFg5HDAm6QP7yG8pbjfZfsRb/PkZijmWPlXCgKY+hBothX7u2
         qQB/U0V7O1DMukfOv/74OHPviNgDJ/lZ2dIgnYZyerIh/OMxAbBcxBgeIP7TxMqlvn
         G/JdBKT1VrQmdDc/MSvWZDc8m67WBuFvYybH31/Y=
Date:   Sat, 22 Aug 2020 11:34:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 09/15] iio: sx9310: Update copyright
Message-ID: <20200822113452.49082e69@archlinux>
In-Reply-To: <CAHcu+Vb3ezGgRAPWgmHMGAisOQzEm-kKs7bj0ssgyASx-fqoXA@mail.gmail.com>
References: <20200803235815.778997-1-campello@chromium.org>
        <20200803175559.v5.9.If88afce92bbc1e97a532874cca35e642a9566172@changeid>
        <CAHcu+Vb3ezGgRAPWgmHMGAisOQzEm-kKs7bj0ssgyASx-fqoXA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 19:45:59 -0600
Daniel Campello <campello@chromium.org> wrote:

> On Mon, Aug 3, 2020 at 5:58 PM Daniel Campello <campello@chromium.org> wrote:
> >
> > Fixes wrong copyright year.
> >
> > Signed-off-by: Daniel Campello <campello@chromium.org>
> > ---
> >
> > Changes in v5: None
> > Changes in v4: None
> > Changes in v3: None
> > Changes in v2: None
> >
> >  drivers/iio/proximity/sx9310.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index cd7de40a55c2f6..87b2de0d7b55a3 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -1,13 +1,13 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * Copyright 2018 Google LLC.
> > + * Copyright 2020 Google LLC.
> >   *
> >   * Driver for Semtech's SX9310/SX9311 capacitive proximity/button solution.
> >   * Based on SX9500 driver and Semtech driver using the input framework
> >   * <https://my.syncplicity.com/share/teouwsim8niiaud/
> >   *          linux-driver-SX9310_NoSmartHSensing>.
> > - * Reworked April 2019 by Evan Green <evgreen@chromium.org>
> > - * and January 2020 by Daniel Campello <campello@chromium.org>
> > + * Reworked in April 2019 by Evan Green <evgreen@chromium.org>
> > + * and in January 2020 by Daniel Campello <campello@chromium.org>.
> >   */
> >
> >  #include <linux/acpi.h>
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >  
> 
> Hi Jonathan,
> 
> After discussing with Gwendal on crrev.com/c/2360467 it seems that the
> right year for the copyright is 2018 as it was before this change.
> Sorry about the inconvenience.
No problem.  I've put the 2018 date back as it was.

Thanks,

Jonathan

> 
> Regards,
> Daniel Campello

