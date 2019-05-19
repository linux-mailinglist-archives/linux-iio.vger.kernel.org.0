Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC222831
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 20:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfESSD7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 14:03:59 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39358 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfESSD7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 May 2019 14:03:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 015939E7A86;
        Sun, 19 May 2019 09:34:47 +0100 (BST)
Date:   Sun, 19 May 2019 09:34:46 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] iio: frequency: ad9523: add eeprom read/write
 verification
Message-ID: <20190519093446.3c3e9f7c@archlinux>
In-Reply-To: <CA+U=Dsr6YpAjJ9K98f7J_Gg_f_Lb_Hrey1QyqGUj9CihYguVpQ@mail.gmail.com>
References: <20190517141938.10315-1-alexandru.ardelean@analog.com>
        <20190518110043.3c7fb04b@archlinux>
        <CA+U=Dsr6YpAjJ9K98f7J_Gg_f_Lb_Hrey1QyqGUj9CihYguVpQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 22:39:09 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sat, May 18, 2019 at 1:01 PM Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
> >
> > On Fri, 17 May 2019 17:19:38 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >  
> > > From: Michael Hennerich <michael.hennerich@analog.com>
> > >
> > > This change adds a basic verification of the EEPROM by writing a known
> > > value to the customer version ID register, and reading it back.
> > >
> > > This validates that the EEPROM & SPI communication are functioning
> > > properly, and the device is ready to use.
> > >
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> >
> > I'm going to assume that the write cycle limitations of that eeprom
> > have been taken into account here and it won't be an issue until
> > a very large number of probe and remove cycles.  There is also the
> > slightly amusing possibility of breaking a customer part if someone
> > managed to pull the power whilst you have the wrong customer ID
> > in the eeprom.  However your device and I assume there is a customer
> > who really wants this sanity check so fair enough...
> >
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > the autobuilders to play with it.  
> 
> I was also a bit unsure about this patch in this form.
> But now that you've raised these points, I am now somewhat paranoid.
> 
> I guess, I'll have to go back and start a internal discussion about
> this. Maybe it makes more sense to add a device[-tree] property to
> configure this somehow, and if someone really wants this behavior,
> he/she can enable it.
> This patch was also created some time ago [before I joined Analog] so
> there is some context I may be lacking here about it.
> 
> Maybe let's drop this, and I can come back with a version that would
> not allow users to shoot-them-selves-in-the-foot without a safety
> mechanism off.
> 
> Sorry for the noise.
Cool. Dropped for now then.

Jonathan

> Alex
> 
> >
> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > >  drivers/iio/frequency/ad9523.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> > > index 9b9eee27176c..dd159a1237f3 100644
> > > --- a/drivers/iio/frequency/ad9523.c
> > > +++ b/drivers/iio/frequency/ad9523.c
> > > @@ -749,6 +749,30 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
> > >       return ret;
> > >  }
> > >
> > > +static int ad9523_verify_eeprom(struct iio_dev *indio_dev)
> > > +{
> > > +     int ret, id;
> > > +
> > > +     id = ad9523_read(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID);
> > > +     if (id < 0)
> > > +             return id;
> > > +
> > > +     ret = ad9523_write(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID, 0xAD95);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     ret = ad9523_read(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     if (ret != 0xAD95) {
> > > +             dev_err(&indio_dev->dev, "SPI Read Verify failed (0x%X)\n", ret);
> > > +             return -EIO;
> > > +     }
> > > +
> > > +     return ad9523_write(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID, id);
> > > +}
> > > +
> > >  static const struct iio_info ad9523_info = {
> > >       .read_raw = &ad9523_read_raw,
> > >       .write_raw = &ad9523_write_raw,
> > > @@ -780,6 +804,10 @@ static int ad9523_setup(struct iio_dev *indio_dev)
> > >       if (ret < 0)
> > >               return ret;
> > >
> > > +     ret = ad9523_verify_eeprom(indio_dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > >       /*
> > >        * PLL1 Setup
> > >        */  
> >  

