Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038A844F903
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhKNQb6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 11:31:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhKNQbt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 11:31:49 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DBF16109E;
        Sun, 14 Nov 2021 16:28:51 +0000 (UTC)
Date:   Sun, 14 Nov 2021 16:33:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 07/10] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <20211114163338.5dfe0069@jic23-huawei>
In-Reply-To: <CAN8YU5MKgvx3LA_s4LMTnxkwRsv4ZhBtJot55OwLT2tXU4bZHA@mail.gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-8-andrea.merello@gmail.com>
        <20211028143123.6dcd30e7@jic23-huawei>
        <CAN8YU5MKgvx3LA_s4LMTnxkwRsv4ZhBtJot55OwLT2tXU4bZHA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Nov 2021 12:52:14 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Some inline notes. OK for all the rest.
> 
> Il giorno gio 28 ott 2021 alle ore 15:27 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Thu, 28 Oct 2021 12:18:37 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > This patch adds a core driver for the BNO055 IMU from Bosch. This IMU
> > > can be connected via both serial and I2C busses; separate patches will
> > > add support for them.
> > >
> > > The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> > > that provides raw data from the said internal sensors, and a couple of
> > > "fusion" modes (i.e. the IMU also do calculations in order to provide
> > > euler angles, quaternions, linear acceleration and gravity measurements).
> > >
> > > In fusion modes the AMG data is still available (with some calibration
> > > refinements done by the IMU), but certain settings such as low pass
> > > filters cut-off frequency and sensors ranges are fixed, while in AMG mode
> > > they can be customized; this is why AMG mode can still be interesting.
> > >
> > > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Side not. Please crop out bits of the discussion we aren't continuing.  Makes it easier
to find the relevant parts of the email!  Note this is a do as I say rather than do
as I do as I don't always remember to do this either.

...

> >  
> > > +/*
> > > + * Reads len samples from the HW, stores them in buf starting from buf_idx,
> > > + * and applies mask to cull (skip) unneeded samples.
> > > + * Updates buf_idx incrementing with the number of stored samples.
> > > + * Samples from HW are transferred into buf, then in-place copy on buf is
> > > + * performed in order to cull samples that need to be skipped.
> > > + * This avoids copies of the first samples until we hit the 1st sample to skip,
> > > + * and also avoids having an extra bounce buffer.
> > > + * buf must be able to contain len elements in spite of how many samples we are
> > > + * going to cull.  
> >
> > This is rather complex - I take we can't just fall back to letting the IIO core
> > demux do all the hard work for us?  
> 
> Hum. I'm not sure.. I admit that I'm not familiar with the demux
> thing, but as far as I can see it needs to be initialized once with a
> list containing all allowed scan masks; IIO core will pick one of them
> and eventually cull extra samples it contains. Is this right?

yup - that's pretty much it.

> 
> I would say we may precalculate this list at probe time (depending on
> the burst break threshold) and populate it with all the possible scan
> masks in which there are no gaps < than the bust break threshold. But
> this could be a quite high number of combinations..
> 
> This way the IIO layer will only request xfers in which gaps are
> always > than burst break threshold, which the driver in turn will
> always split in several xfers.
> 
> Does this make sense to you?

If it works and ends up simpler than this I'm all for it, but I'll confess
you've lost me in the explanation.  

Whether the approach you are using here ends up more efficient than the
one in the demux (which IIRC works by doing an expensive copy map building
just once and can then use that to do things like merging copies of neighbouring
elements) will be dependent on exact combinations of enabled channels.

There is also a usecase question for how much effort it is worth putting in
to optimise these paths.  In a lot of cases people have put an IMU in because
their application needs one so will be grabbing almost all channels all the time.

It is unlikely they want a random set of scattered channels.


> 
> > > + */
> > > +static int bno055_scan_xfer(struct bno055_priv *priv,
> > > +                         int start_ch, int len, unsigned long mask,
> > > +                         __le16 *buf, int *buf_idx)
> > > +{
> > > +     const int base = BNO055_ACC_DATA_X_LSB_REG;
> > > +     bool quat_in_read = false;
> > > +     int buf_base = *buf_idx;
> > > +     __le16 *dst, *src;
> > > +     int offs_fixup = 0;
> > > +     int xfer_len = len;
> > > +     int ret;
> > > +     int i, n;
> > > +
> > > +     /*
> > > +      * All chans are made up 1 16-bit sample, except for quaternion that is
> > > +      * made up 4 16-bit values.
> > > +      * For us the quaternion CH is just like 4 regular CHs.
> > > +      * If our read starts past the quaternion make sure to adjust the
> > > +      * starting offset; if the quaternion is contained in our scan then make
> > > +      * sure to adjust the read len.
> > > +      */
> > > +     if (start_ch > BNO055_SCAN_QUATERNION) {
> > > +             start_ch += 3;
> > > +     } else if ((start_ch <= BNO055_SCAN_QUATERNION) &&
> > > +              ((start_ch + len) > BNO055_SCAN_QUATERNION)) {
> > > +             quat_in_read = true;
> > > +             xfer_len += 3;
> > > +     }
> > > +
> > > +     ret = regmap_bulk_read(priv->regmap,
> > > +                            base + start_ch * sizeof(__le16),
> > > +                            buf + buf_base,
> > > +                            xfer_len * sizeof(__le16));
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     for_each_set_bit(i, &mask, len) {
> > > +             if (quat_in_read && ((start_ch + i) > BNO055_SCAN_QUATERNION))
> > > +                     offs_fixup = 3;
> > > +
> > > +             dst = buf + *buf_idx;
> > > +             src = buf + buf_base + offs_fixup + i;
> > > +
> > > +             n = (start_ch + i == BNO055_SCAN_QUATERNION) ? 4 : 1;
> > > +
> > > +             if (dst != src)
> > > +                     memcpy(dst, src, n * sizeof(__le16));
> > > +
> > > +             *buf_idx += n;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +static irqreturn_t bno055_trigger_handler(int irq, void *p)
> > > +{
> > > +     struct iio_poll_func *pf = p;
> > > +     struct iio_dev *iio_dev = pf->indio_dev;
> > > +     struct bno055_priv *priv = iio_priv(iio_dev);
> > > +     int xfer_start, start, end, prev_end;
> > > +     bool xfer_pending = false;
> > > +     bool first = true;
> > > +     unsigned long mask;
> > > +     int buf_idx = 0;
> > > +     bool thr_hit;
> > > +     int quat;
> > > +     int ret;
> > > +
> > > +     mutex_lock(&priv->lock);
> > > +     for_each_set_bitrange(start, end, iio_dev->active_scan_mask,
> > > +                           iio_dev->masklength) {  
> >
> > I'm not seeing this function in mainline...  I guess this series has a dependency
> > I missed?  
> 
> I've been pointed to Yuri Norov bitmap series (I mentioned this in the
> cover letter). Assuming it is close to be merged, I've updated my drv
> for its API changes, but if you prefer I can revert to the current
> mainline API. It's a trivial change.

Ah. Thanks for pointing that out.  I missed the note in the cover letter.

Jonathan

