Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852793EFFFC
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 11:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhHRJJE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 05:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhHRJJE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Aug 2021 05:09:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439D561053;
        Wed, 18 Aug 2021 09:08:27 +0000 (UTC)
Date:   Wed, 18 Aug 2021 10:11:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v12 2/2] iio: accel: Add driver support for ADXL355
Message-ID: <20210818101128.7c1f40ee@jic23-huawei>
In-Reply-To: <CANk7y0gY7HHdfwPYq3KFSTbaZM+sT4XSxv2yDvx2_io=9hLX0A@mail.gmail.com>
References: <20210811073027.124619-1-puranjay12@gmail.com>
        <20210811073027.124619-3-puranjay12@gmail.com>
        <20210815164654.3c51a8e3@jic23-huawei>
        <CANk7y0gY7HHdfwPYq3KFSTbaZM+sT4XSxv2yDvx2_io=9hLX0A@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Aug 2021 21:59:42 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> On Sun, Aug 15, 2021 at 9:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed, 11 Aug 2021 13:00:27 +0530
> > Puranjay Mohan <puranjay12@gmail.com> wrote:
> >  
> > > ADXL355 is a 3-axis MEMS Accelerometer. It offers low noise density,
> > > low 0g offset drift, low power with selectable measurement ranges.
> > > It also features programmable high-pass and low-pass filters.
> > >
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl354_adxl355.pdf
> > > Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>  
> > Hi Puranjay,
> >
> > I took one last look at this so I can apply it without looking again assuming
> > the dt review is fine.  Noticed one issue with error handling, but I can tidy
> > that up whilst applying assuming you aren't doing a v13 for some other reason.
> > If you are please incorporate these changes as well.
> >  
> 
> Hi Jonathan, It would be great if you could make these changes while
> applying. I am not doing a v13 as all comments have been covered
> earlier.
> I shall be thankful to you.
I ended up tweaking those 3 functions a little more than I was originally planning
so please check it all looks good to you.

Series applied to the togreg branch of iio.git and pushed out as testing
for 0-day to poke at.  Note these won't hit mainline until 5.16 now.

Thanks,

Jonathan

> 
> > Thanks,
> >
> > Jonathan
> >
> >
> > ...
> >  
> > > +
> > > +static int adxl355_set_odr(struct adxl355_data *data,
> > > +                        enum adxl355_odr odr)
> > > +{
> > > +     int ret = 0;
> > > +
> > > +     mutex_lock(&data->lock);
> > > +
> > > +     if (data->odr == odr)
> > > +             goto out_unlock;
> > > +
> > > +     ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> > > +     if (ret < 0)
> > > +             goto out_unlock;
> > > +
> > > +     ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
> > > +                              ADXL355_FILTER_ODR_MSK,
> > > +                              FIELD_PREP(ADXL355_FILTER_ODR_MSK, odr));
> > > +     if (ret < 0)
> > > +             goto out_unlock;
> > > +
> > > +     data->odr = odr;
> > > +     adxl355_fill_3db_frequency_table(data);
> > > +
> > > +out_unlock:
> > > +     ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);  
> >
> > As below, we should do this because it risks returning success when a failure
> > actually occured.  Again, unless you are respinning for some other reason I'll
> > add the logic whilst applying.
> >  
> > > +     mutex_unlock(&data->lock);
> > > +     return ret;
> > > +}
> > > +
> > > +static int adxl355_set_hpf_3db(struct adxl355_data *data,
> > > +                            enum adxl355_hpf_3db hpf)
> > > +{
> > > +     int ret = 0;
> > > +
> > > +     mutex_lock(&data->lock);
> > > +
> > > +     if (data->hpf_3db == hpf)
> > > +             goto unlock;
> > > +
> > > +     ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> > > +     if (ret < 0)
> > > +             goto set_opmode_unlock;
> > > +
> > > +     ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
> > > +                              ADXL355_FILTER_HPF_MSK,
> > > +                              FIELD_PREP(ADXL355_FILTER_HPF_MSK, hpf));
> > > +     if (!ret)
> > > +             data->hpf_3db = hpf;
> > > +
> > > +set_opmode_unlock:
> > > +     ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);  
> >
> > We can't do this as it might potentially eat an error that meant the regmap
> > update didn't occur.  To avoid that a little dance is needed using a second
> > return value and we only set ret = ret2 if ret == 0
> >
> > Alternatively we just have a separate error handling path which doesn't set
> > ret for the adxl355_set_op_mode(). I'll probably go with that as it's more
> > code but easier to read.
> >
> >
> >  
> > > +unlock:
> > > +     mutex_unlock(&data->lock);
> > > +     return ret;
> > > +}
> > > +  
> >
> > ...
> >  
> > > +static int adxl355_write_raw(struct iio_dev *indio_dev,
> > > +                          struct iio_chan_spec const *chan,
> > > +                          int val, int val2, long mask)
> > > +{
> > > +     struct adxl355_data *data = iio_priv(indio_dev);
> > > +     int odr_idx, hpf_idx, calibbias;
> > > +
> > > +     switch (mask) {
> > > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > > +             odr_idx = adxl355_find_match(adxl355_odr_table,
> > > +                                          ARRAY_SIZE(adxl355_odr_table),
> > > +                                          val, val2);
> > > +             if (odr_idx < 0)
> > > +                     return odr_idx;
> > > +
> > > +             return adxl355_set_odr(data, odr_idx);
> > > +     case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> > > +             hpf_idx = adxl355_find_match(data->adxl355_hpf_3db_table,
> > > +                                     ARRAY_SIZE(data->adxl355_hpf_3db_table),  
> >
> > Mixing different indentation styles isn't very nice for readability.
> > I'll tweak this whilst applying.
> >  
> > > +                                          val, val2);
> > > +             if (hpf_idx < 0)
> > > +                     return hpf_idx;
> > > +
> > > +             return adxl355_set_hpf_3db(data, hpf_idx);
> > > +     case IIO_CHAN_INFO_CALIBBIAS:
> > > +             calibbias = clamp_t(int, val, S16_MIN, S16_MAX);
> > > +
> > > +             return adxl355_set_calibbias(data, chan->address, calibbias);
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}  
> > ...  
> 
> 
> 

