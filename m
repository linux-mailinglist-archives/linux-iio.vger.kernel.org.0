Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14021A5E04
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 12:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDLKXg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 06:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLKXg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 06:23:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B5620708;
        Sun, 12 Apr 2020 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586687015;
        bh=frxqGb3ZeCMDj12BXCJ72kJINTywrbpgCn5KIN0PuA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J32CbtzRqUlmzA2j0TeJNpopZUA16VYAb9xoJe9+93Ya/Fk9yeXi/bhXnXjcBo7uV
         ME+L9z+fT+Zr3++Y5BWtxsZi1dQhSIzE4ZmeSpmL27XPS9Ygmc8iyX/UNrwiuCVyk3
         XGvVL9DiMgJme4Tl9XfxJ7uWaZkP58tNnM8HUGEg=
Date:   Sun, 12 Apr 2020 11:23:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Aishwarya R <aishwaryarj100@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: at91-adc: Use devm_platform_ioremap_resource
Message-ID: <20200412112330.39527f21@archlinux>
In-Reply-To: <CAHp75VfJMsVB2rC-Qx6mQw+e8Vw9sVaWTu2Jvxj-nO1LzadHeA@mail.gmail.com>
References: <20200409151125.32677-1-aishwaryarj100@gmail.com>
        <20200409155936.GV3628@piout.net>
        <CAHp75VcLLjjc5T+Qq8du4QgnQ-rtzFLh=5Jt-DPjigb+QUWOSg@mail.gmail.com>
        <20200410112236.GX3628@piout.net>
        <CAHp75VfJMsVB2rC-Qx6mQw+e8Vw9sVaWTu2Jvxj-nO1LzadHeA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Apr 2020 19:37:25 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Apr 10, 2020 at 2:22 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 10/04/2020 13:55:26+0300, Andy Shevchenko wrote:  
> > > On Thu, Apr 9, 2020 at 7:00 PM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:  
> > > > On 09/04/2020 20:41:23+0530, Aishwarya R wrote:  
> > > > > Use the helper function that wraps the calls to
> > > > > platform_get_resource() and devm_ioremap_resource()
> > > > > together.  
> > >  
> > > > Please elaborate the actual value of doing that.  
> > >
> > > Please, elaborate actual value of not doing that.
> > >
> > > Yes, I know that you are p* off of these changes, but why you not
> > > going further and forbid all clean ups we are doing in the code?
> > >
> > > To the point. Above change is reducing code base and showing the new
> > > comers modern APIs to use.  
> 
> > The value of doing it is to reduce the code size by 16 bytes. The same
> > people doing that will actively ruin that by adding error string for
> > error that will never ever happen.  
> 
> I don't see it in the patch we are discussing, so, not an argument.
> 
> > Also, the commit message is definitively lacking. A good commit message
> > would say that the patch has been generated using coccinelle, that no
> > testing has been done and that no thought has been given.  
> 
> That's I agree with.
> But somebody need to teach people how to do it better.
> 
> > It would definitively make sense to send one patch per subsystem instead
> > of having 475 different patches each changing only one location.  
> 
> Depends on the maintainer and subsystem. This is arguable argument.
> In my subsystems (let's forget about PDx86, where one per subsystem in
> principle is not working by nature of the subsystem, but consider
> others I'm maintaining) I prefer to have a possibility to track
> changes independently on driver basis.

Likewise.  I often request patches are broken out.

> 
> > The whole "let's let newcomers fix trivial bugs" thing is definitively
> > not working and it is not leading to an increase of the number of useful
> > reviewers and contributors  
> 
> Semi-agree. That people can be self-organized into a reviewer gang and
> try to learn together.
> In any case, as for maintainers, the task has not only technical
> aspects, but mentoring as well.
> 

It would be interesting to see if we do have examples of people who have started
with cleanup patches and moved on to more interesting things.  Some of the
outreach programs that start with simple patches as a means of getting
familiar with the tools have led to more significant improvements but
those are somewhat of a special case.

I'd rather have hundreds of people send me these sorts of patches a year
than loose one potential long term contributor.

Jonathan

p.s. Aishwarya - You've been a bit unlucky in a sense here running into
the latest instance of a very long term debate!
