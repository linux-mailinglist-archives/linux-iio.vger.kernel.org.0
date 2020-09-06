Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82A925EE89
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 17:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgIFPXP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 11:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbgIFPWl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:22:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C263320714;
        Sun,  6 Sep 2020 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599405759;
        bh=A79A9Iqg7IapUO3QuOtEmzHrXji7k3atFmJOwoO3ZbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MsPAbUlthj2WrDZfz3AwTEVTgUeS5QLL4onmQlHQBvaierE/ZG7w69rPpApjAde11
         kCVvkMdf1lYhguEoAv/mE56+dUFY6uiKMZuUdXp6isQkmK7GEge72WmSrD/YF7V+uZ
         g6ft6VM6XhwWkhTZ+4WL7gTPOhy2CPBPxn408L94=
Date:   Sun, 6 Sep 2020 16:22:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: sx9310: Prefer async probe
Message-ID: <20200906162234.4a829a0a@archlinux>
In-Reply-To: <CAHcu+VarBz3m_zKfDB0osQsjZ0dMpvUk+q2Qt-yC5DbPjr0bRA@mail.gmail.com>
References: <20200901081920.v2.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
        <159897502625.334488.7103007623601336114@swboyd.mtv.corp.google.com>
        <CAHcu+VarBz3m_zKfDB0osQsjZ0dMpvUk+q2Qt-yC5DbPjr0bRA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 1 Sep 2020 11:01:29 -0600
Daniel Campello <campello@chromium.org> wrote:

> On Tue, Sep 1, 2020 at 9:43 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Douglas Anderson (2020-09-01 08:19:43)  
> > > On one board I found that:
> > >   probe of 5-0028 returned 1 after 259547 usecs
> > >
> > > While some of this time is attributable to the pile of i2c transfers
> > > that we do at probe time, the lion's share (over 200 ms) is sitting
> > > waiting in the polling loop in sx9310_init_compensation() waiting for
> > > the hardware to indicate that it's done.
> > >
> > > There's no reason to block probe of all other devices on our probe.
> > > Turn on async probe.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---  
> >
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>  
> 
> Reviewed-by: Daniel Campello <campello@chromium.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

thanks,

Jonathan


