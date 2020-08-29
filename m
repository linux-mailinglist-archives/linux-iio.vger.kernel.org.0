Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F9C2568D4
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgH2Pw4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgH2Pwx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:52:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B64F320707;
        Sat, 29 Aug 2020 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598716373;
        bh=gnfWmnDWzgXsZSAVuQUD4Ilt7RgCEWXUmah7mNFams4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c8ZGRwkhZUZwO9PvBV0lQ10k20fAEQm5Yx/TWDuKt+83li73Dt1nVL6ggGFA/Roy7
         3lNuZV5W9g/x4WxpSxGnkBaHTOLLwzsEZRlttVRkR8DHaleh3abTd/0ykTWOPxdM4z
         JjX0pij7+15mMbH1+rhbU5jcnTo2UdwnXDxAqq38=
Date:   Sat, 29 Aug 2020 16:52:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Rosin <peda@axentia.se>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dpot-dac: fix code comment in dpot_dac_read_raw()
Message-ID: <20200829165249.416b2efa@archlinux>
In-Reply-To: <20200826192529.GC2671@embeddedor>
References: <20200826000844.GA16807@embeddedor>
        <3fb79fa8-e86b-111b-a4a7-5da767d40b52@axentia.se>
        <3528f053-70d8-bd12-8683-3c1ed0b4d6e7@embeddedor.com>
        <13e9b0cf-9fae-5dcf-d0ac-4beaf18295d0@axentia.se>
        <20200826192529.GC2671@embeddedor>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Aug 2020 14:25:29 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> On Wed, Aug 26, 2020 at 04:16:23PM +0200, Peter Rosin wrote:
> > On 2020-08-26 16:17, Gustavo A. R. Silva wrote:  
> > >> And just to be explicit, this fix is for 5.9.
> > >>
> > >> Acked-by: Peter Rosin <peda@axentia.se>
> > >>  
> > > 
> > > If you don't mind I can add this to my tree for 5.9-rc4
> > > and send it directly to Linus.  
> > 
> > Fine by me, Jonathan might think differently but I can't find a reason why.
> > Just about nothing is happening in that file and the risk for conflicts is
> > negligible.
> >   
> 
> OK. In the meantime, I have added this to my -next tree and queued it up
> for 5.9-rc3.
Absolutely fine by me.

Thanks,

Jonathan

> 
> Thanks
> --
> Gustavo

