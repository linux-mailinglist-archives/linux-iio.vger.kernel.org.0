Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02729D551B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 10:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfJMH7o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 03:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfJMH7o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 03:59:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A2520659;
        Sun, 13 Oct 2019 07:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570953583;
        bh=ScV0sWJNv6OL5+7JcMR5aYVd6w7psSHkuXIqQWeOcIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yW/wT63WV/TG8fzXwnnyGXTFRqTztSef8Hz3P5dPwI96MyM1je5mz/Z6w01dV7cbS
         6olyS+ELace6f9WZRdjVw5fUpjaNfBQPzx1nbqo8owvHMYE260884TjnSXI9tlvgUq
         59uAiDKtV9A/4tMR8vzGKMZcWvuMQUTEjCfmuebk=
Date:   Sun, 13 Oct 2019 09:59:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PULL v2] First set of iio new device support etc for the 5.5
 cycle
Message-ID: <20191013075940.GB2207105@kroah.com>
References: <20191012121946.051b646f@archlinux>
 <20191012152744.GA2142233@kroah.com>
 <20191012152841.GB2142233@kroah.com>
 <20191012170615.01546a96@archlinux>
 <CA+U=DspmQcUZU3q-ntJEVaqtkkK=gk0GCCu06ntYf_kvnpnLZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+U=DspmQcUZU3q-ntJEVaqtkkK=gk0GCCu06ntYf_kvnpnLZw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 12, 2019 at 09:41:45PM +0300, Alexandru Ardelean wrote:
> On Sat, Oct 12, 2019 at 7:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat, 12 Oct 2019 17:28:41 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > > On Sat, Oct 12, 2019 at 05:27:44PM +0200, Greg KH wrote:
> > > > On Sat, Oct 12, 2019 at 12:19:46PM +0100, Jonathan Cameron wrote:
> > > > > The following changes since commit b73b93a2af3392b9b7b8ba7e818ee767499f9655:
> > > > >
> > > > >   iio: adc: ad7192: Add sysfs ABI documentation (2019-09-08 10:34:49 +0100)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.5a-take2
> > > >
> > > > Better, but I see this now:
> > > >
> > > > drivers/iio/imu/adis.c: In function ‘__adis_check_status’:
> > > > drivers/iio/imu/adis.c:295:9: warning: ‘status’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> > > >   295 |  status &= adis->data->status_error_mask;
> > > >       |         ^~
> > > >
> > > >
> > > > I'll take this, can you just send a follow-on patch for this?
> > >
> > > Also I see:
> > >
> > > drivers/iio/imu/adis16480.c: In function ‘adis16480_enable_irq’:
> > > drivers/iio/imu/adis16480.c:950:6: warning: ‘val’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >   950 |  val &= ~ADIS16480_DRDY_EN_MSK;
> > >       |      ^~
> > >   CC [M]  drivers/iio/magnetometer/hmc5843_i2c.o
> > > drivers/iio/imu/adis16480.c: In function ‘adis16480_write_raw’:
> > > drivers/iio/imu/adis16480.c:571:7: warning: ‘val’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >   571 |   val &= ~enable_mask;
> > >       |       ^~
> > > drivers/iio/imu/adis16480.c:557:11: note: ‘val’ was declared here
> > >   557 |  uint16_t val;
> > >       |           ^~~
> > >
> > >
> > > So did you really fix anything here?
> > >
> > > I'll drop this pull again.
> > >
> > > What version of gcc are you using?  Might I suggest a newer one (i.e. a
> > > modern one?)
> >
> > Ah. This is my mistake.  I did see all of these, but still thought we were
> > in the category of tidying up some compiler version caused issues.
> >
> > The adis16400 came up in my local tests, so I previously pinged Alex on
> > basis it was something to do in a follow up. The other two showed up, but
> > again I still thought these were compiler version issues, particularly
> > as 0-day didn't highlight them (there were several other issues it
> > did highlight this week). Hence again I requested a follow up to tidy
> > it up.
> >
> > Anyhow, did some digging.  The issue here was a 'fix' I put in to an initial
> > 0-day issue in the inline functions that Alex added.  Note that one
> > appears to be compiler version dependent as it didn't turn up in my
> > local builds. There are now inline functions that check if (ret)
> > and don't set the value if ret is non 0.

Oddly, 0-day is not always seeing stuff like this, and I don't know why.

> > Out in the drivers, the check is the more specific (unnecessarily)
> > if (ret < 0) and hence the compiler is concluded that there might be a path to
> > val not being set.  Previously it was giving up figuring this out.
> > So reality is they are a false positive (sort of as in reality ret
> > is never positive) but the compiler has made a reasonable point
> > that it can't see that.
> >
> > Never mind, I'll do a new pull request once fixes are in place.
> > Given there are two obvious ways of suppressing this and it's Alex's
> > driver I'll wait until he has time to take a look.
> >
> > Sorry for wasting your time.
> >
> 
> If it helps, let's drop the ADIS patches for this round, and I can
> take a closer look as well.
> The cleanup does seem to have revealed a few gaps in our CI in
> relation to upstreaming things.
> 
> We use Travis-CI for our stuff and stuff is public:
> https://travis-ci.org/analogdevicesinc/linux
> 
> So, if anyone sees anything we should do better, I'm open to
> improvements/suggestions.

Building 'allmodconfig' with a recent version of gcc?  That's all I did
here to catch these warnings, nothing special :)

thanks,

greg k-h
