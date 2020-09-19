Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2425270F04
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgISPbl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 11:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgISPbl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 11:31:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0D302098B;
        Sat, 19 Sep 2020 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600529501;
        bh=Qohrf9BpoBZlJjpmOfnoyBggZccjSte4L1IkpPdEpwU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e/aYfBvruQqkyRy9IScjqMSBrv3EGchdrqaBA9d2uosaBsMjSGGc+fUljN8ki4hsh
         QPrxI+zmiGdUdky2tsHk8hZbIzk/t7nT5zOp/vEph2FCmQA4O+fLDhir0jRRr49Q34
         WhzVAsJuze/leLHb78+xH6JCm7kqw+ejRXEVv2Y8=
Date:   Sat, 19 Sep 2020 16:31:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     trix@redhat.com, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: check st_lsm6dsx_shub_read_output
 return
Message-ID: <20200919163136.4a201207@archlinux>
In-Reply-To: <CAHp75Vcomp1mDUm5houAm2j2b2HtxAP8Z78Vfcdmgm_g+bbt7w@mail.gmail.com>
References: <20200809175551.6794-1-trix@redhat.com>
        <CAHp75Vcomp1mDUm5houAm2j2b2HtxAP8Z78Vfcdmgm_g+bbt7w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Aug 2020 11:08:39 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Aug 9, 2020 at 8:56 PM <trix@redhat.com> wrote:
> >
> > From: Tom Rix <trix@redhat.com>
> >
> > clang static analysis reports this represenative problem
> >
> > st_lsm6dsx_shub.c:540:8: warning: Assigned value is garbage or undefined
> >         *val = (s16)le16_to_cpu(*((__le16 *)data));
> >              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > data is set with
> >
> >         err = st_lsm6dsx_shub_read(sensor, ch->address, data, len);
> >         if (err < 0)
> >                 return err;
> >
> > The problem with st_lsm6dsx_shub_read() is this statement
> >
> >         err = st_lsm6dsx_shub_read_output(hw, data,
> >                                           len & ST_LS6DSX_READ_OP_MASK);
> >
> > The err value is never checked.
> > So check err.
> >  
> 
> 
> > Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>  
> 
> You see, the commit message can be divided to three sections
> 
> 1. Title / very short description
> 2. Detailed description
> 3. Tag block
> 
> Each of them has some specific rules:
> 1. One quite short line prefixed by subsystem / driver in the
> specified format (usually gathered by reading git log against the
> module in question)
> 2. Should explain why this change is done
> 3. Should be one tag -- one line, no blank lines in between.
> 
> Hope, you will use this in the future.
> 
> After addressing that (perhaps Jonathan will do it for you)
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Description adjusted and patch applied.  Given timing in cycle
I've queued this for the next merge window rather than trying to
get it in during this cycle.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything.

thanks,

Jonathan

> 
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index ed83471dc7dd..8c8d8870ca07 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -313,6 +313,8 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
> >
> >         err = st_lsm6dsx_shub_read_output(hw, data,
> >                                           len & ST_LS6DSX_READ_OP_MASK);
> > +       if (err < 0)
> > +               return err;
> >
> >         st_lsm6dsx_shub_master_enable(sensor, false);
> >
> > --
> > 2.18.1
> >  
> 
> 

