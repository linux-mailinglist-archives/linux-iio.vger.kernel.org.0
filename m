Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E13F1EDE
	for <lists+linux-iio@lfdr.de>; Thu, 19 Aug 2021 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhHSRSk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Aug 2021 13:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhHSRSk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Aug 2021 13:18:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7B1C061575;
        Thu, 19 Aug 2021 10:18:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z2so14544014lft.1;
        Thu, 19 Aug 2021 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+CJjNZBvFbAbSirOz4YJmF/GjuhPQCkOEK3Sd4SS78=;
        b=pax0VTBWQRtew3cj1PCFwJOHzuP8R+XNuG4yXPjf1pZ8g1iFmTbJaulBcCq2nXMFHF
         7hQIEwG0YE8jFQCLEMZWm1/+UltB8/T9s0PivmHu/cnnS0OclWT0xhP7T4Mehw5o5i+q
         CI+lVvGw883JLlnG1Jd4CrpdLI/NIvzbABe1lz+6Dy0eZ7pCRJvoMocsCSE0ZS/VyYHi
         a37xFNiKnee7AAtGzocb2q/N9Bs6BomQFg+N9RAiBOrJ38EeUNu2cGMNrRJLRNStLrR7
         GysRr7MI6jstNzZbP3sT+/4IPbCi2xAHcGKq07XIHEEVEmj8TYQUtYG5DQzR8M/jEyAA
         8SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+CJjNZBvFbAbSirOz4YJmF/GjuhPQCkOEK3Sd4SS78=;
        b=bb+KM/iEI0b3R1GkCB0qz4OzqrWOJBlLbpCKxKSCihjOl7nXH5JCMy99Ai3sm4pGz5
         DsEQEYB5uqNJhgQDdG1h1fUjJ/f6w/1r3ZDOUmp0b9sKzX5cKYgRNiM247KUzEuZ0F3f
         dEHn53gqvRWydA4V8Br/LMN7UczE2lVJpqkdtVeIEAW0DTO6F4rqwhXEUs+4Bxivew0q
         MUohvgwNczeqpwRHYis0jRuRWFrZm1gCKCT21p6KVg+Hseyqw4/lwq1i/2z3KCZ8CvAs
         uIg0x7QCxT3HIuopIK/y9tV0xPMd0HirIwHl6CL2SHlC974wwzRWQQeIwcsQdQJ7gFBQ
         t2yQ==
X-Gm-Message-State: AOAM531s+qDksTVrnbLj1r5RNT8Y74MJ50NblmXP6jgkcp4uRbGpVAv9
        zyAwkA8nQOKOzwgQr+ipAawma+goRkbramQQN80=
X-Google-Smtp-Source: ABdhPJwtTFNaMIb6AG3hmvIap6xlLZXCVu2oPTObpV+GA/AO7eYan+n3NRr6PD61KpNy7QSUw5XexmcgBpprZekT6WA=
X-Received: by 2002:ac2:5d49:: with SMTP id w9mr11403550lfd.450.1629393481865;
 Thu, 19 Aug 2021 10:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210811073027.124619-1-puranjay12@gmail.com> <20210811073027.124619-3-puranjay12@gmail.com>
 <20210815164654.3c51a8e3@jic23-huawei> <CANk7y0gY7HHdfwPYq3KFSTbaZM+sT4XSxv2yDvx2_io=9hLX0A@mail.gmail.com>
 <20210818101128.7c1f40ee@jic23-huawei>
In-Reply-To: <20210818101128.7c1f40ee@jic23-huawei>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Thu, 19 Aug 2021 22:47:50 +0530
Message-ID: <CANk7y0iDOCop1j=kL=nwWLf5UjDuy_dc9PjZ3tVgD9b6UimU9A@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] iio: accel: Add driver support for ADXL355
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 18, 2021 at 2:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 15 Aug 2021 21:59:42 +0530
> Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> > On Sun, Aug 15, 2021 at 9:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Wed, 11 Aug 2021 13:00:27 +0530
> > > Puranjay Mohan <puranjay12@gmail.com> wrote:
> > >
> > > > ADXL355 is a 3-axis MEMS Accelerometer. It offers low noise density,
> > > > low 0g offset drift, low power with selectable measurement ranges.
> > > > It also features programmable high-pass and low-pass filters.
> > > >
> > > > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl354_adxl355.pdf
> > > > Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > Hi Puranjay,
> > >
> > > I took one last look at this so I can apply it without looking again assuming
> > > the dt review is fine.  Noticed one issue with error handling, but I can tidy
> > > that up whilst applying assuming you aren't doing a v13 for some other reason.
> > > If you are please incorporate these changes as well.
> > >
> >
> > Hi Jonathan, It would be great if you could make these changes while
> > applying. I am not doing a v13 as all comments have been covered
> > earlier.
> > I shall be thankful to you.
> I ended up tweaking those 3 functions a little more than I was originally planning
> so please check it all looks good to you.
>
> Series applied to the togreg branch of iio.git and pushed out as testing
> for 0-day to poke at.  Note these won't hit mainline until 5.16 now.
>
> Thanks,
>
> Jonathan
>

Hi Jonathan,
the changes you made look good to me.

Thanks,

> >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > >
> > > ...
> > >
> > > > +
> > > > +static int adxl355_set_odr(struct adxl355_data *data,
> > > > +                        enum adxl355_odr odr)
> > > > +{
> > > > +     int ret = 0;
> > > > +
> > > > +     mutex_lock(&data->lock);
> > > > +
> > > > +     if (data->odr == odr)
> > > > +             goto out_unlock;
> > > > +
> > > > +     ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> > > > +     if (ret < 0)
> > > > +             goto out_unlock;
> > > > +
> > > > +     ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
> > > > +                              ADXL355_FILTER_ODR_MSK,
> > > > +                              FIELD_PREP(ADXL355_FILTER_ODR_MSK, odr));
> > > > +     if (ret < 0)
> > > > +             goto out_unlock;
> > > > +
> > > > +     data->odr = odr;
> > > > +     adxl355_fill_3db_frequency_table(data);
> > > > +
> > > > +out_unlock:
> > > > +     ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > >
> > > As below, we should do this because it risks returning success when a failure
> > > actually occured.  Again, unless you are respinning for some other reason I'll
> > > add the logic whilst applying.
> > >
> > > > +     mutex_unlock(&data->lock);
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int adxl355_set_hpf_3db(struct adxl355_data *data,
> > > > +                            enum adxl355_hpf_3db hpf)
> > > > +{
> > > > +     int ret = 0;
> > > > +
> > > > +     mutex_lock(&data->lock);
> > > > +
> > > > +     if (data->hpf_3db == hpf)
> > > > +             goto unlock;
> > > > +
> > > > +     ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> > > > +     if (ret < 0)
> > > > +             goto set_opmode_unlock;
> > > > +
> > > > +     ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
> > > > +                              ADXL355_FILTER_HPF_MSK,
> > > > +                              FIELD_PREP(ADXL355_FILTER_HPF_MSK, hpf));
> > > > +     if (!ret)
> > > > +             data->hpf_3db = hpf;
> > > > +
> > > > +set_opmode_unlock:
> > > > +     ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > >
> > > We can't do this as it might potentially eat an error that meant the regmap
> > > update didn't occur.  To avoid that a little dance is needed using a second
> > > return value and we only set ret = ret2 if ret == 0
> > >
> > > Alternatively we just have a separate error handling path which doesn't set
> > > ret for the adxl355_set_op_mode(). I'll probably go with that as it's more
> > > code but easier to read.
> > >
> > >
> > >
> > > > +unlock:
> > > > +     mutex_unlock(&data->lock);
> > > > +     return ret;
> > > > +}
> > > > +
> > >
> > > ...
> > >
> > > > +static int adxl355_write_raw(struct iio_dev *indio_dev,
> > > > +                          struct iio_chan_spec const *chan,
> > > > +                          int val, int val2, long mask)
> > > > +{
> > > > +     struct adxl355_data *data = iio_priv(indio_dev);
> > > > +     int odr_idx, hpf_idx, calibbias;
> > > > +
> > > > +     switch (mask) {
> > > > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > > > +             odr_idx = adxl355_find_match(adxl355_odr_table,
> > > > +                                          ARRAY_SIZE(adxl355_odr_table),
> > > > +                                          val, val2);
> > > > +             if (odr_idx < 0)
> > > > +                     return odr_idx;
> > > > +
> > > > +             return adxl355_set_odr(data, odr_idx);
> > > > +     case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> > > > +             hpf_idx = adxl355_find_match(data->adxl355_hpf_3db_table,
> > > > +                                     ARRAY_SIZE(data->adxl355_hpf_3db_table),
> > >
> > > Mixing different indentation styles isn't very nice for readability.
> > > I'll tweak this whilst applying.
> > >
> > > > +                                          val, val2);
> > > > +             if (hpf_idx < 0)
> > > > +                     return hpf_idx;
> > > > +
> > > > +             return adxl355_set_hpf_3db(data, hpf_idx);
> > > > +     case IIO_CHAN_INFO_CALIBBIAS:
> > > > +             calibbias = clamp_t(int, val, S16_MIN, S16_MAX);
> > > > +
> > > > +             return adxl355_set_calibbias(data, chan->address, calibbias);
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +}
> > > ...
> >
> >
> >
>


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
