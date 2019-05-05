Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2664913F7D
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfEEM7p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 08:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEM7o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 May 2019 08:59:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB492082F;
        Sun,  5 May 2019 12:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557061183;
        bh=OYgI343ZtwZsMYkCCr5+/f4njEWi3WQsFQBAc5e2gCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UCMCuu9WXNG8dYbFQCyhkCsmJgm1anx2J8O+kQuQVvmYyXF8GvIzq7HZakKjmeALn
         Rup1nw2pHiwYbdBjvLKeDX3foK6bAlOBDR1p8ahuZdubCtUiPb+lx0OhqBIb/vg2nP
         lOz2nuuLA338iDCf5Dsxe2DW17f/Zb/uinGwlI0k=
Date:   Sun, 5 May 2019 13:59:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Melissa Wen <melissa.srw@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 3/4] staging: iio: ad7150: simplify i2c SMBus return
 treatment
Message-ID: <20190505135937.03e7be65@archlinux>
In-Reply-To: <CA+U=DsoYaN_gCc=jcQ9nHHNpC+voPfHCc=RP_ZyQAC497Jx_7A@mail.gmail.com>
References: <cover.1556919363.git.melissa.srw@gmail.com>
        <18725f7ddc3ac42b1c781b1848b05fabd4bd8320.1556919363.git.melissa.srw@gmail.com>
        <CA+U=DsoYaN_gCc=jcQ9nHHNpC+voPfHCc=RP_ZyQAC497Jx_7A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 4 May 2019 13:36:43 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sat, May 4, 2019 at 1:26 AM Melissa Wen <melissa.srw@gmail.com> wrote:
> >
> > Since i2c_smbus_write_byte_data returns no-positive value, this commit
> > making the treatment of its return value less verbose.
> >
> > Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> > ---
> >  drivers/staging/iio/cdc/ad7150.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> > index 4ba46fb6ac02..3a4572a9e5ec 100644
> > --- a/drivers/staging/iio/cdc/ad7150.c
> > +++ b/drivers/staging/iio/cdc/ad7150.c
> > @@ -201,16 +201,12 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
> >         ret = i2c_smbus_write_byte_data(chip->client,
> >                                         ad7150_addresses[chan][4],
> >                                         sens);
> > -       if (ret < 0)
> > +       if (ret)  
> 
> For i2c_smbus_write_byte_data(), checking "ret < 0" or non-zero, is the same.
> Changing this doesn't have any added value.
The slight note I'd add to that is that if you are (and I think you should)
just doing
return i2c_smbus_write_byte_data()
for the last call then that effectively means we are assuming ret is never positive
in some paths and not others.  I'd encourage consistency so would would prefer
this is changed to if (ret).

As in the earlier patch the line between what is noise in a staging (or new
driver) and what is noise in a driver that has been outside staging for years
is different.  Not so good for Alex perhaps if there is a chance Analog will
backport fixes for their drivers, but tough luck :)

> 
> >                 return ret;
> > -
> > -       ret = i2c_smbus_write_byte_data(chip->client,
> > +       else
> > +               return i2c_smbus_write_byte_data(chip->client,
> >                                         ad7150_addresses[chan][5],
> >                                         timeout);  
> 
> The introduction of the "else" branch is a bit noisy.
> The code was a bit neater (and readable) before the else branch, and
> functionally identical.
> 
> Well, when I say neater before, you have to understand, that I (and I
> assume that some other people who write drivers) have a slight
> fixation for this pattern:
> 
> example1:
> ret = fn1();
> 
> if (ret < 0)  // could also be just "if (ret)"
>    return ret;
> 
> ret = fn2();
> if (ret < 0)  // could also be just "if (ret)"
>    return ret;
> 
> example1a:
> +ret = fn3();
> +if (ret < 0)  // could also be just "if (ret)"
> +    return ret;
> 
> 
> Various higher-level programming languages, will discourage this
> pattern in favor of neater patterns.
> 
> I personally, have a few arguments in favor of this pattern:
> 1) it is closer to how the machine code ; so, closer to how a
> low-level instruction looks like
> 2) if (ever) this needs to be patched, the patch could be neat (see
> example1a) ; the examle assumes that it's been added via a patch at a
> later point in time
> 3) it keeps indentation level to a minimum ; this also aligns with
> kernel-coding guidelines
> (https://www.kernel.org/doc/html/v4.10/process/coding-style.html )
>     (indentation seems a bit OCD-like when someone points it out at a
> review, but it has it's value over time)
Nicely laid out argument.  Strongest one is the maintainability and
reviewability aspect of it being how kernel code is done and hence
takes every so slightly less thought ;)

Errors paths are indented, good paths not (in general).

Jonathan


> 
> > -       if (ret < 0)
> > -               return ret;
> > -
> > -       return 0;
> >  }
> >
> >  static int ad7150_write_event_config(struct iio_dev *indio_dev,
> > --
> > 2.20.1
> >  

