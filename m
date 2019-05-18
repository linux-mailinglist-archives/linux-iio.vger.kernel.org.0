Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35843224B5
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 21:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfERTjW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 15:39:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39652 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfERTjW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 15:39:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id r7so9685141otn.6
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5NuDZB3z1z6fHgPc6nXYPmga6PXsvYCiZhUO8FdXjI=;
        b=LXDLu5qm4EmbNCzBNP3Ddj0qXYYrP5Ib9zxf6yPXPgp1oixLF4hlf+qM8aTvvmdNGs
         HNSuC/6I2fCqC8lfpyMhUL0AajAlfo1BS/Q4h/Nmry4F6pVGZIo8hRUHJ5a3X2DNWdQ+
         FT52ohufcc7XZdLLrNkHcUD8Ycc+PqqKd51GIcXvSgdrGO9hUECJpI7brMfBI1LYxgtj
         3QuJzv0CiiJSsy89moZR7stCmD1zHVs+MF6pBMf27QnijfUXkWmyreUOapMDTwfvrVZc
         YOs5zRymR1a1U9Y4YV914niHp0Sn2q5r1ck14boZtKp06H4/ioc+pjOzyy21qAH/6Eo0
         Cf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5NuDZB3z1z6fHgPc6nXYPmga6PXsvYCiZhUO8FdXjI=;
        b=a7mFWQVYdTgtLEfzV1wWj3dJxp/MozbIYohadmbd/kmS6l6aYZpV0iGtaSJVe2Kam4
         U8LSLbu3mc4Qn3yFn4yv+RKeuo+Y/zF46CACRKE1qwT5Qf/pky3KNRI91qmetb6u4Jbc
         e5lqJXMKC8OefyJjpBn/lb5umvMIriBcCprPHhpvj00Rw3DCk8pT6h5LdwGaxeY47r/M
         EOYG5NtvpNGSZFc9HK5PvhDTCF77ZUM74NkTdiUlMl4AXpMB+yqWbUENjEPZ/U2cFAAS
         aNVUMyTL33enuGTYQ6AoOaSNE1iVR3z0fujS5C0AvXMt+6cYdiwrNyZ1fMo5A4VHewT+
         6Eyg==
X-Gm-Message-State: APjAAAWUj/XflwYbfvAK7NGxC7OZMWZY2Se6QX2mSdA82FUSJhxIJd/n
        rbYY9H+tCY0TO3sjGFWXCpSzwg5CKQfE0dvxmmM=
X-Google-Smtp-Source: APXvYqyTx6Qw60orAIuwEUUscuIep21W9WurTj44PcjIKZrBlClDCmu7oOqZkdDs0Qu6TJj/Ku3XkhgsQqUeN9zPMiE=
X-Received: by 2002:a05:6830:1182:: with SMTP id u2mr28166945otq.71.1558208361319;
 Sat, 18 May 2019 12:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190517141938.10315-1-alexandru.ardelean@analog.com> <20190518110043.3c7fb04b@archlinux>
In-Reply-To: <20190518110043.3c7fb04b@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 18 May 2019 22:39:09 +0300
Message-ID: <CA+U=Dsr6YpAjJ9K98f7J_Gg_f_Lb_Hrey1QyqGUj9CihYguVpQ@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: ad9523: add eeprom read/write verification
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 18, 2019 at 1:01 PM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Fri, 17 May 2019 17:19:38 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >
> > This change adds a basic verification of the EEPROM by writing a known
> > value to the customer version ID register, and reading it back.
> >
> > This validates that the EEPROM & SPI communication are functioning
> > properly, and the device is ready to use.
> >
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> I'm going to assume that the write cycle limitations of that eeprom
> have been taken into account here and it won't be an issue until
> a very large number of probe and remove cycles.  There is also the
> slightly amusing possibility of breaking a customer part if someone
> managed to pull the power whilst you have the wrong customer ID
> in the eeprom.  However your device and I assume there is a customer
> who really wants this sanity check so fair enough...
>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.

I was also a bit unsure about this patch in this form.
But now that you've raised these points, I am now somewhat paranoid.

I guess, I'll have to go back and start a internal discussion about
this. Maybe it makes more sense to add a device[-tree] property to
configure this somehow, and if someone really wants this behavior,
he/she can enable it.
This patch was also created some time ago [before I joined Analog] so
there is some context I may be lacking here about it.

Maybe let's drop this, and I can come back with a version that would
not allow users to shoot-them-selves-in-the-foot without a safety
mechanism off.

Sorry for the noise.
Alex

>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/frequency/ad9523.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> > index 9b9eee27176c..dd159a1237f3 100644
> > --- a/drivers/iio/frequency/ad9523.c
> > +++ b/drivers/iio/frequency/ad9523.c
> > @@ -749,6 +749,30 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
> >       return ret;
> >  }
> >
> > +static int ad9523_verify_eeprom(struct iio_dev *indio_dev)
> > +{
> > +     int ret, id;
> > +
> > +     id = ad9523_read(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID);
> > +     if (id < 0)
> > +             return id;
> > +
> > +     ret = ad9523_write(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID, 0xAD95);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = ad9523_read(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (ret != 0xAD95) {
> > +             dev_err(&indio_dev->dev, "SPI Read Verify failed (0x%X)\n", ret);
> > +             return -EIO;
> > +     }
> > +
> > +     return ad9523_write(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID, id);
> > +}
> > +
> >  static const struct iio_info ad9523_info = {
> >       .read_raw = &ad9523_read_raw,
> >       .write_raw = &ad9523_write_raw,
> > @@ -780,6 +804,10 @@ static int ad9523_setup(struct iio_dev *indio_dev)
> >       if (ret < 0)
> >               return ret;
> >
> > +     ret = ad9523_verify_eeprom(indio_dev);
> > +     if (ret < 0)
> > +             return ret;
> > +
> >       /*
> >        * PLL1 Setup
> >        */
>
