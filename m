Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF289D50A8
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfJLPZA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 11:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfJLPY7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 11:24:59 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFE72089C;
        Sat, 12 Oct 2019 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570893899;
        bh=ehj8RuJ0xMy3ZkPqhE50rPFf/uuHvf3MTvG5AwSbPiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vS4I5+AV3cy0cSFtS+2FE3tmVAxsBBSNLrhwP2GsWrVs4MIVryG9RS4Sxc/mxZSgB
         s069e3ItcRDnsD4lI6MmxC8c7rpf1CH/fiNisRrK2GNKzeTp5WlFjMfH7RLWLXT/Bg
         n2m8KIFhItTP5FI53Ndax/xr+9JzulMLsL8kTAbg=
Date:   Sat, 12 Oct 2019 17:24:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO new device support etc for the 5.5 cycle.
Message-ID: <20191012152455.GA2116116@kroah.com>
References: <20191012102436.752a861d@archlinux>
 <20191012105119.GA2074969@kroah.com>
 <20191012121619.5c3e7453@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191012121619.5c3e7453@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 12, 2019 at 12:16:19PM +0100, Jonathan Cameron wrote:
> On Sat, 12 Oct 2019 12:51:19 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Sat, Oct 12, 2019 at 10:24:36AM +0100, Jonathan Cameron wrote:
> > > The following changes since commit b73b93a2af3392b9b7b8ba7e818ee767499f9655:
> > > 
> > >   iio: adc: ad7192: Add sysfs ABI documentation (2019-09-08 10:34:49 +0100)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.5a  
> > 
> > I'm getting build warnings in drivers/iio/imu/adis16400.c, is that to be
> > expected?
> > 
> > drivers/iio/imu/adis16400.c: In function ‘adis16334_get_freq’:
> > drivers/iio/imu/adis16400.c:334:4: warning: ‘t’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> >   334 |  t >>= ADIS16334_RATE_DIV_SHIFT;
> >       |    ^
> > drivers/iio/imu/adis16400.c: In function ‘adis16400_get_freq’:
> > drivers/iio/imu/adis16400.c:360:11: warning: ‘t’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> >   360 |  uint16_t t;
> >       |           ^
> >   CC [M]  drivers/iio/light/bh1750.o
> > drivers/iio/imu/adis16400.c: In function ‘adis16400_read_raw’:
> > drivers/iio/imu/adis16400.c:557:10: warning: ‘val16’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> >   557 |  int16_t val16;
> >       |          ^~~~~
> > drivers/iio/imu/adis16400.c: In function ‘adis16400_write_raw’:
> > drivers/iio/imu/adis16400.c:424:14: warning: ‘val16’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> >   424 |       (val16 & ~0x07) | i);
> >       |       ~~~~~~~^~~~~~~~
> > drivers/iio/imu/adis16400.c:411:11: note: ‘val16’ was declared here
> >   411 |  uint16_t val16;
> >       |           ^~~~~
> > 
> > 
> > Can you fix that up first?
> > 
> > thanks,
> > 
> > greg k-h
> Hi Greg,
> 
> I got these as well, but as they weren't the result of anything done
> in this series (seems to be GCC 8 getting fussier) I pointed them out
> to Alex and he sent a fix.  Was about to queue it up for next series.
> I'll tack it on here and send you a new pull in a few mins.

The warning goes away when I drop this pull request, so something in
here triggered it :(

thanks,

greg k-h
