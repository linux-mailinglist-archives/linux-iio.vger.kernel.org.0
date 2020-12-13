Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA0B2D8E34
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 16:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390284AbgLMPP6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 10:15:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389971AbgLMPP6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 10:15:58 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD96A23121;
        Sun, 13 Dec 2020 15:15:16 +0000 (UTC)
Date:   Sun, 13 Dec 2020 15:15:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: kernel bug tracker
Message-ID: <20201213151513.157f38ba@archlinux>
In-Reply-To: <CAHp75Vc5b_=KuvJxgxBJgijkKOp_bnbxGo_K04_-svB3oGds5w@mail.gmail.com>
References: <CAHp75VcDJd_ROcPE6GJvz3J4fTp_a=PX2GpjRc3RV16edzYmrA@mail.gmail.com>
        <688821bc-f93c-c98c-974c-ec46fa4111bd@metafoo.de>
        <CAHp75Vc5b_=KuvJxgxBJgijkKOp_bnbxGo_K04_-svB3oGds5w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Dec 2020 18:33:55 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Dec 9, 2020 at 6:07 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> >
> > On 12/9/20 4:58 PM, Andy Shevchenko wrote:  
> > > Hi!
> > >
> > > Does the I2O actually refer to IIO on kernel bugzilla?
> > > In any case, default there is Alan Cox' email and I didn't find
> > > Jonathan's there.
> > > If the answer is "yes" for above, does make sense to:
> > >   - change its name to IIO
> > >   - put mailing list as default assignee?
> > >
> > >  
> > There used to be an I2O subsystem, but which has been removed[1].
> >
> > I supposed if it is used for IIO drivers at the moment I supposed we can
> > take over the tag and rename it to IIO, given that there should be no
> > new I2O tickets.  
> 
> Sent request to the help desk.
Thanks!
> 
> P.S. I reverted the subsystem to I2O in one bug (#209889) to be able
> to filter them out all when we will have a proper component
> registered.
> 
> 
> --
> With Best Regards,
> Andy Shevchenko

