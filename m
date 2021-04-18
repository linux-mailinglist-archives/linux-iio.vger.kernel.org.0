Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B173636B5
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhDRQpM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 12:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhDRQpL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 12:45:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B9756101E;
        Sun, 18 Apr 2021 16:44:38 +0000 (UTC)
Date:   Sun, 18 Apr 2021 17:45:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Matija Podravec <matija_podravec@fastmail.fm>,
        Sergey Borishchenko <borischenko.sergey@gmail.com>
Subject: Re: [PATCH v1 6/7] iio: st_sensors: Add lsm9ds0 IMU support
Message-ID: <20210418174510.64df5344@jic23-huawei>
In-Reply-To: <CAHp75VeRgGcat18p+dN+pbHEYqm+YLGB_06kFEjFsahB2EW9Fw@mail.gmail.com>
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
        <20210414195454.84183-6-andriy.shevchenko@linux.intel.com>
        <20210418120655.3b2501fc@jic23-huawei>
        <CAHp75Vcrf02cVaeDevN-cEFFTPoxq6kyO3gGQYTcs-U4yHOFaQ@mail.gmail.com>
        <CAHp75VeRgGcat18p+dN+pbHEYqm+YLGB_06kFEjFsahB2EW9Fw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Apr 2021 16:59:02 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Apr 18, 2021 at 4:49 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sun, Apr 18, 2021 at 2:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > Thanks for review, my answers below.
> >  
> > > On Wed, 14 Apr 2021 22:54:53 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >  
> > > > We can utilize separate drivers for accelerometer and magnetometer,
> > > > so here is the glue driver to enable LSM9DS0 IMU support.
> > > >
> > > > The idea was suggested by Crestez Dan Leonard in [1]. The proposed change
> > > > was sent as RFC due to race condition concerns, which are indeed possible.  
> > >
> > > If you are going to mention races, good to give some flavour in here!  
> >
> > I meant that the initial idea is racy due to different devices
> > communicating to the same i2c address.
> > So, any sequence of transfers are not serialized and you may end up with
> >
> > drv1 -> i2c
> > drv2 -> i2c
> > drv1 <- i2c # garbage
> >  
> > > This driver makes me very nervous indeed.  
> >
> > Why?! This one is race free as far as I can see. Or maybe I interpret
> > this wrongly and you are talking about initial RFC?
> >  
> > >  I haven't 'found' any places
> > > where the fact we'll write the same registers from each of the drivers
> > > causes problems (e.g. int pin setup etc) but perhaps I'm missing something.
> > >
> > > Shall we say that makes me rather keener to get eyes (and thought) on this
> > > patch than normal :)  
> >
> > How should I amend the commit message to state:
> > 1. First idea (RFC by the link) *is* racy AFAIU
> > 2. This one *is not* racy.  

Great.  I read it as meaning they were both potentially racey!
This is less worrying.

> 
> I re-read this and now understand better what you meant.
> So, it may be that the initial proposal may work without any
> amendment, but since I haven't investigated much, I should rather use
> the phrase "potentially racy". In my variant it's using one regmap for
> both drivers (not two), which makes the register state consistent. Am
> I wrong?

I think this approach is fine.  I'd be more worried about the two 'sub' drivers
not necessarily being happy that someone else touches state they care about.
There are places where I think we write the same value to the same register
twice during setup with this model, but that shouldn't matter.   I'm not 100%
sure that there aren't other cases though I think there aren't.

So what you have is probably fine, but more eyes would make me happier ;)

Lots of people care about this particular driver so hopefully we'll get
them.

> Do we have some places where we may write to the same register concurrently?
> 
Only ones I can find are the setup ones where it writes the same value twice
I think.  So *crosses fingers* :)

Given timing (missed merge window) we have masses of time to let this sit
on list a while and see if anyone can spot issues neither of us have found.

Jonathan
