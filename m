Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8BD2F6DFB
	for <lists+linux-iio@lfdr.de>; Thu, 14 Jan 2021 23:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbhANWQ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Jan 2021 17:16:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729729AbhANWQZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Jan 2021 17:16:25 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C609421D42;
        Thu, 14 Jan 2021 22:15:42 +0000 (UTC)
Date:   Thu, 14 Jan 2021 22:15:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v3] iio: sx9310: Fix semtech,avg-pos-strength setting
 when > 16
Message-ID: <20210114221539.3e025f99@archlinux>
In-Reply-To: <161039200192.1580929.14023513752851296639@swboyd.mtv.corp.google.com>
References: <20201202200252.986230-1-swboyd@chromium.org>
        <161039200192.1580929.14023513752851296639@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Jan 2021 11:06:41 -0800
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Stephen Boyd (2020-12-02 12:02:52)
> > This DT property can be 0, 16, and then 64, but not 32. The math here
> > doesn't recognize this slight bump in the power of 2 numbers and
> > translates a DT property of 64 into the register value '3' when it
> > really should be '2'. Fix it by subtracting one more if the number being
> > translated is larger than 31. Also use clamp() because we're here.
> > 
> > Cc: Daniel Campello <campello@chromium.org>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---  
> 
> Hi Jonathan,
> 
> Happy new year! Can this be picked up? Or should I resend? 
Happy new year to you as well!

Oops. Sorry - I lost this one somehow.

Anyhow, now applied and it's the pull request I just sent out.

Jonathan



> 
> > 
> > Changes from v2 (https://lore.kernel.org/r/20201120182944.543428-1-swboyd@chromium.org):                                                                                                         
> >  * Use clamp()
> >  * Add comment to clarify
> > 
> > Changes from v1 (https://lore.kernel.org/r/20201120073842.3232458-1-swboyd@chromium.org):                                                                                                         
> >  * Changed ternary to consider 17 to 31 as the same as 16   
> > 
> >  drivers/iio/proximity/sx9310.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index a2f820997afc..0e6863e4d384 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -1305,7 +1305,8 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
> >                 if (ret)
> >                         break;
> >  
> > -               pos = min(max(ilog2(pos), 3), 10) - 3;
> > +               /* Powers of 2, except for a gap between 16 and 64 */
> > +               pos = clamp(ilog2(pos), 3, 11) - (pos >= 32 ? 4 : 3);
> >                 reg_def->def &= ~SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK;
> >                 reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK,
> >                                            pos);
> > 
> > base-commit: 5b19ca2c78a0838976064c0347e46a2c859b541d  

