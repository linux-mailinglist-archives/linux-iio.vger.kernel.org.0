Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E617F25EE5D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgIFOvy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 10:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgIFOvx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 10:51:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F5D220714;
        Sun,  6 Sep 2020 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599403912;
        bh=InP0l+FKFxfUCyzLZPZhSXwYzVMvc8E5Css3wMf7MiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2RoUnMqJdrlR/rDJgefMAFqd9x+FvxOBqm6wLoDt6Ve43N3hEQe2FaZiO+03bCUK+
         R/iAwNLbrTzGkKn9fa2Lu3rBX6A3rqdyrPV066JwCc3Qe7TljrIRxIEQHorCQ7c3Dg
         wakt2VULUbs5+Q4xVs6CXlg+J+PFBbGf7wf2zgWQ=
Date:   Sun, 6 Sep 2020 15:51:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Darius <darius.berghe@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: gyro: adxrs290: Add triggered buffer support
Message-ID: <20200906155147.662f5df9@archlinux>
In-Reply-To: <CAEtfd9aB2jphW=x80iZ_vHJmLUGrn-SSCom0NHWbgLH3YnGOpA@mail.gmail.com>
References: <20200825124711.11455-1-nish.malpani25@gmail.com>
        <20200825124711.11455-2-nish.malpani25@gmail.com>
        <20200829174623.422f7e7d@archlinux>
        <CAEtfd9aB2jphW=x80iZ_vHJmLUGrn-SSCom0NHWbgLH3YnGOpA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 3 Sep 2020 18:07:00 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Hello,
> 
> Thanks for the review, Jonathan. Comments inline...
> 
...

> > >
> > > +static void adxrs290_chip_off_action(void *data)
> > > +{
> > > +     struct iio_dev *indio_dev = data;
> > > +
> > > +     adxrs290_set_mode(indio_dev, ADXRS290_MODE_STANDBY);
> > > +}
> > > +
> > >  static int adxrs290_read_raw(struct iio_dev *indio_dev,
> > >                            struct iio_chan_spec const *chan,
> > >                            int *val,
> > > @@ -215,24 +287,34 @@ static int adxrs290_read_raw(struct iio_dev *indio_dev,
> > >
> > >       switch (mask) {
> > >       case IIO_CHAN_INFO_RAW:
> > > +             ret = iio_device_claim_direct_mode(indio_dev);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > >               switch (chan->type) {
> > >               case IIO_ANGL_VEL:
> > >                       ret = adxrs290_get_rate_data(indio_dev,
> > >                                                    ADXRS290_READ_REG(chan->address),
> > >                                                    val);
> > >                       if (ret < 0)
> > > -                             return ret;
> > > +                             goto err_release;
> > >
> > > -                     return IIO_VAL_INT;
> > > +                     ret = IIO_VAL_INT;
> > > +                     break;
> > >               case IIO_TEMP:
> > >                       ret = adxrs290_get_temp_data(indio_dev, val);
> > >                       if (ret < 0)
> > > -                             return ret;
> > > +                             goto err_release;
> > >
> > > -                     return IIO_VAL_INT;
> > > +                     ret = IIO_VAL_INT;
> > > +                     break;
> > >               default:
> > > -                     return -EINVAL;
> > > +                     ret = -EINVAL;
> > > +                     break;
> > >               }
> > > +err_release:
> > > +             iio_device_release_direct_mode(indio_dev);
> > > +             return ret;
> > >       case IIO_CHAN_INFO_SCALE:
> > >               switch (chan->type) {
> > >               case IIO_ANGL_VEL:
> > > @@ -279,34 +361,53 @@ static int adxrs290_write_raw(struct iio_dev *indio_dev,
> > >                             long mask)
> > >  {
> > >       struct adxrs290_state *st = iio_priv(indio_dev);
> > > -     int lpf_idx, hpf_idx;
> > > +     int ret, lpf_idx, hpf_idx;
> > > +
> > > +     ret = iio_device_claim_direct_mode(indio_dev);  
> >
> > Is there anything in the datasheet that says we can't change the filters
> > whilst doing captures?  Might get crazy data but if the datasheet doesn't
> > want against a particular action, then we tend not to try and prevent it.
> >  
> 
> The datasheet, to my knowledge, explicitly doesn't mention any
> restriction on changing the filter settings during a capture.
> 
> Quoting the datasheet, "The group delay of the wideband filter option
> is less than 0.5ms" (pg. 11) - during an ongoing capture if one
> re-configures the filter, how do we address this?

To be honest, I'm not really sure what that means, so will if you think
it makes sense it is fine to keep protections to not allow a filter update
during buffered capture.

> 
> > > +     if (ret)
> > > +             return ret;
...
> > >  static int adxrs290_probe(struct spi_device *spi)
> > >  {
> > >       struct iio_dev *indio_dev;
> > > @@ -384,6 +609,7 @@ static int adxrs290_probe(struct spi_device *spi)
> > >       indio_dev->channels = adxrs290_channels;
> > >       indio_dev->num_channels = ARRAY_SIZE(adxrs290_channels);
> > >       indio_dev->info = &adxrs290_info;
> > > +     indio_dev->available_scan_masks = adxrs290_avail_scan_masks;
> > >
> > >       mutex_init(&st->lock);
> > >
> > > @@ -416,6 +642,12 @@ static int adxrs290_probe(struct spi_device *spi)
> > >       /* max transition time to measurement mode */
> > >       msleep(ADXRS290_MAX_TRANSITION_TIME_MS);
> > >
> > > +     ret = devm_add_action_or_reset(&spi->dev,
> > > +                                    adxrs290_chip_off_action,
> > > +                                    indio_dev);  
> >
> > What is this unwinding?  We should only be using devm to undo things
> > that have been 'done' in probe and the association should be clear.
> >  
> 
> This unwinding is for placing the device **back** to its default
> 'STANDBY' mode. The device, during the probe, was put to 'MEASUREMENT'
> mode during 'adxrs290_initial_setup()' a few lines back.
> 
> How else do you suggest I highlight the association?

Perhaps put it inside the call to initial_setup() so it is clearly
paired with the 'forwards' action.

Jonathan
