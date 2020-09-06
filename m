Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5AA25F093
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 23:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgIFVFi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIFVFh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Sep 2020 17:05:37 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64B2C061573
        for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2020 14:05:36 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y2so10861563ilp.7
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2020 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EP60wefHqlMyeGDK+6c012r5mW95rsDIMKVW54A0ouw=;
        b=cb8l4V0mQlrj1P6nrZvjNpPC4U9FDM7Y/Q9xyP4i+hteDL2Dc1mjmNjMTjodI0joUp
         LnEO3Nd/6QdICHori6lsWUqOJZGnJzf2sh3sWTL3Zm5XRaxm7RILSAxbkwE2pTpQvxiL
         8F56rqNKWQ/OBZlwsmPJgvEr9bnLtih5h2WWKiC2uQTMbLBLFA2tfXRhk0Kk6962gouE
         r+lke8dNeHAV+vCMvjGrf0JyHOCBXEe2TmA9oawr6gohLIWp1D5hv8nh69NH4G2Api6f
         3cu6U77roO+uoRNLxA9I6Ul0auamKty54sZbS4UBkklP21U7CzEuDHKHgoyN4JdENe9u
         ImCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EP60wefHqlMyeGDK+6c012r5mW95rsDIMKVW54A0ouw=;
        b=DHwMj1zZAbSXhTdTas/JJ60NUQBhe5ENLZTWMjyCDLfrV84Kt8mHw5VFEcGG/thoLO
         4+O4cCWgtvAapmGys+HAIhLOYIqMKLrVs6kyl3YyVfDlYAN1Ih1eN3hED20LYWBp9eRP
         AvrlupxQdFs+zvV2dL/l0hCjjaPpQvswzFgJDnfVI5NsNTf1YqFDZfmHpV+tmwDQdlg1
         FxSqH/wVsCmYy15Y8qAKEV3TQoucmFmFQmnoQ94H0Dn89y0t4PVa3EeU9H3RVLHuuCjG
         CoS+V3vKSo56FB27VLq+Npnl8oXW25ptBHeB0L7iXBSnYtA4CjNG0+GlBUMwruXI+M06
         XPtg==
X-Gm-Message-State: AOAM532XfufD2SCRXzV5mUB05+lm98WM1hqxPxoKpuxCvi2762NY1Qwo
        ZkQg3RzsUTjX3nFH5AKJyNa4V39j0IKUIJv8pjbjOnwQwLDEjQ==
X-Google-Smtp-Source: ABdhPJw8ibD3ejnipNifsBE8/mVVSRlAYCR7FvvF5ket/cAtcafp5E3Jv8nj5AwDb85wWGuYN6M6nUNWfHKSHYSbGdI=
X-Received: by 2002:a05:6e02:c61:: with SMTP id f1mr16760742ilj.137.1599426332731;
 Sun, 06 Sep 2020 14:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200904120726.199640-1-cmo@melexis.com> <CAHp75VeiR1qQkBhA0XQ2_6aVAFHfQTWGcr+NeRhFNoCEiMK9kg@mail.gmail.com>
In-Reply-To: <CAHp75VeiR1qQkBhA0XQ2_6aVAFHfQTWGcr+NeRhFNoCEiMK9kg@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Sun, 6 Sep 2020 23:04:56 +0200
Message-ID: <CAKv63uvBpM2uZYVuWb=Nhut91xMH27O9_6JEJVCjg2tF84yKxA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: temperature: mlx90632: Interface to change object
 ambient temperature
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Sep 2020 at 14:19, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Fri, Sep 4, 2020 at 3:08 PM Crt Mori <cmo@melexis.com> wrote:
> >
> > Since object temperature might be different than the sensor temperature
> > the infrared sensors should provide an interface to inject ambient
> > temperature. This was in past done via write to ambient temperature
> > interface (in_temp_ambient_raw), but I think most people did not know
> > about it. This solution introduces a new iio type of the CALIBAMBIENT
> > which is hopefully more descriptive and more explicit about the purpose
> > and capabilities of the sensors.
>
> I'm fine, but one really picky comment below. I don't think a new
> version is needed till Jonathan will ask for it.
>
> > Signed-off-by: Crt Mori <cmo@melexis.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  drivers/iio/industrialio-core.c    | 1 +
> >  drivers/iio/temperature/mlx90632.c | 8 +++++++-
> >  include/linux/iio/types.h          | 1 +
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 606d5e61c575..941011502f4d 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -165,6 +165,7 @@ static const char * const iio_chan_info_postfix[] = {
> >         [IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
> >         [IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
> >         [IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
> > +       [IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
> >  };
> >
> >  #if defined(CONFIG_DEBUG_FS)
> > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > index 94bca2b2866a..8e60d401b703 100644
> > --- a/drivers/iio/temperature/mlx90632.c
> > +++ b/drivers/iio/temperature/mlx90632.c
> > @@ -761,6 +761,9 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
> >                         *val2 = data->emissivity * 1000;
> >                 }
> >                 return IIO_VAL_INT_PLUS_MICRO;
>
> Blank line is missed here.
>

I don't have new lines before and after case: in switch statements
through whole file, so I decided to remove the blank line 4 rows down
as well to keep it all nicely unified in v3.

> > +       case IIO_CHAN_INFO_CALIBAMBIENT:
> > +               *val = data->object_ambient_temperature;
> > +               return IIO_VAL_INT;
> >
> >         default:
> >                 return -EINVAL;
> > @@ -781,6 +784,9 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
> >                         return -EINVAL;
> >                 data->emissivity = val * 1000 + val2 / 1000;
> >                 return 0;
> > +       case IIO_CHAN_INFO_CALIBAMBIENT:
> > +               data->object_ambient_temperature = val;
> > +               return 0;
> >         default:
> >                 return -EINVAL;
> >         }
> > @@ -798,7 +804,7 @@ static const struct iio_chan_spec mlx90632_channels[] = {
> >                 .modified = 1,
> >                 .channel2 = IIO_MOD_TEMP_OBJECT,
> >                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > -                       BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
> > +                       BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
> >         },
> >  };
> >
> > diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> > index e6fd3645963c..1e3ed6f55bca 100644
> > --- a/include/linux/iio/types.h
> > +++ b/include/linux/iio/types.h
> > @@ -59,6 +59,7 @@ enum iio_chan_info_enum {
> >         IIO_CHAN_INFO_CALIBEMISSIVITY,
> >         IIO_CHAN_INFO_OVERSAMPLING_RATIO,
> >         IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
> > +       IIO_CHAN_INFO_CALIBAMBIENT,
> >  };
> >
> >  #endif /* _IIO_TYPES_H_ */
> > --
> > 2.25.1
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
