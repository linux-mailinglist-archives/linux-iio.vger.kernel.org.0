Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE223FAD4E
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhH2Q7k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 12:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhH2Q7j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 12:59:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC74760698;
        Sun, 29 Aug 2021 16:58:43 +0000 (UTC)
Date:   Sun, 29 Aug 2021 18:01:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Colin King <colin.king@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] iio: adc: Fix -EBUSY timeout error return
Message-ID: <20210829180136.58a11601@jic23-huawei>
In-Reply-To: <CA+V-a8ugKC8z2=0usUca4eYFLTHEorxdtmdmbE5vXZDo_Ob5vA@mail.gmail.com>
References: <20210817172111.495897-1-colin.king@canonical.com>
        <OSZPR01MB7019DD199CB1B9A4521A3C28AAFF9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
        <CAHp75VdWFTi4oSWG45NunJwpe=LdMhAMEAEJh21ML2QXszgS+A@mail.gmail.com>
        <CA+V-a8ugKC8z2=0usUca4eYFLTHEorxdtmdmbE5vXZDo_Ob5vA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Aug 2021 18:39:02 +0100
"Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:

> On Thu, Aug 19, 2021 at 6:21 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Wed, Aug 18, 2021 at 6:51 PM Prabhakar Mahadev Lad
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >  
> > > with the subject changed to above: Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>  
> >  
> Again with the above fixed:
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> > Always put your tags in a single tag per single line. This will allow
> > tools to catch them up automatically.
> >  
> My bad, fixed that now.

Tweaked patch name as suggested and applied to the fixes-togreg branch of iio.git

Too late to sneak this in pre merge window, so I'll do it after rc1.

Thanks,

Jonathan

> 
> Cheers,
> Prabhakar

