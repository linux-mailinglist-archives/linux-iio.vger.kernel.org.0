Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F234AE88
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 19:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhCZS1U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 14:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCZS1U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 14:27:20 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF77C0613AA
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 11:27:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d10so5808654ils.5
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwvHT1vxmXiCrTOzPU3exgwc23FADjBCZW+3xtAZlv0=;
        b=H5Xul7h43adFkJcEOlcs677pDclxyGp/Ga6QKPPbjnKZPANQcFzayafpAk4vp9AJQH
         F9h841jN0YgrOV4eJpq2Ee1Q/fYBwC+SxIHJZrLURJ8jIBz/JxZw2uxbGfO8DZvKJ6cm
         zKNhYxPgUHvHoPNz5VUwF+/YB/cK/ETQ72D9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwvHT1vxmXiCrTOzPU3exgwc23FADjBCZW+3xtAZlv0=;
        b=WKyuOBNJh9fioTfqtU6CDAi6Y471GO2Mou3TlG9nhs8itTvyNp1mpUxyjavAgxPV8R
         LOLGTH9lg0sh3Y4fOxKnP2seWaflp2J1WeftwfzmK5fPvZJh8Y78ZAx7PmVCKUOm3roc
         1JmUTWzO5JQbfOgLyPM0iySr7L5wbmRJKB9S6lcaSmGa8wLgH+QTotAnNdDXGhEq8tzB
         9ZIiYOFwF6vR2IKxYu4GHOzWeoNx49DVesCV+7sBVoY6hNx7F3OigCTbLbz8hv8oOysP
         JtuUyHWhC4wINhcEFPtIxjxNUQUUpR+85ICwdPdlP5HLABkKikYvTsQGNHaC6ZvFUDxi
         DcCQ==
X-Gm-Message-State: AOAM5317lOA+f5MDyrv2hxDJ61D2+hvN/4xeOpcMVuymIyHeVngQtOPS
        8Tobm5VmPnR+1tMUzwY3aA4SURrFThlDdjzZfJ173g==
X-Google-Smtp-Source: ABdhPJxqlQahwkFX34rcARrE9iXZo/UliHi8MpQXJhF+9KyOQzDW2Km43DbGx2qLsKNy2F46qMVrFoiDFCfWLczrh7o=
X-Received: by 2002:a05:6e02:1b86:: with SMTP id h6mr10967395ili.145.1616783239583;
 Fri, 26 Mar 2021 11:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210322073220.1637117-1-gwendal@chromium.org>
 <20210322073220.1637117-3-gwendal@chromium.org> <CA+U=DsqvwOMxXt_05WnmBDccJ4S=rMoNajM8Dr3u58uek4jE4w@mail.gmail.com>
In-Reply-To: <CA+U=DsqvwOMxXt_05WnmBDccJ4S=rMoNajM8Dr3u58uek4jE4w@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 26 Mar 2021 11:27:07 -0700
Message-ID: <CAPUE2uvYEoy+QarZa8UeN1CgszHJz+4mFCGpL4oa8LZ6P1NXGg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: sx9310: Support ACPI properties
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 22, 2021 at 2:54 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Mon, Mar 22, 2021 at 9:33 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Use device_property_read_uXX to support both device tree and ACPI
> > bindings when reading the properties we need to configure the SAR
> > sensor.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  Changes in v6:
> >  Use proper function to gather the number of elements in an array.
> >
> >  Changes in v5:
> >  Split in 2 patches, one for fixing access to propery array, the other
> >  to support ACPI.
> >
> >  drivers/iio/proximity/sx9310.c | 26 +++++++++++---------------
> >  1 file changed, 11 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index 289c76bb3b024..3817a5714aab3 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/pm.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> > @@ -1213,10 +1214,9 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
> >  }
> >
> >  static const struct sx9310_reg_default *
> > -sx9310_get_default_reg(struct sx9310_data *data, int idx,
> > +sx9310_get_default_reg(struct device *dev, int idx,
> >                        struct sx9310_reg_default *reg_def)
> >  {
> > -       const struct device_node *np = data->client->dev.of_node;
>
> There may be an issue with this.
> 'np' was coming from the parent device (which is an i2c device)
>
> So, 'data->client->dev' should be the same pointer as 'indio_dev->dev.parent'
>
> Now, it's a reference to 'indio_dev->dev', so it's probably going to
> miss a lot of DT properties.
> Maybe an alternative would be to do:
>
> const struct device *dev = &data->client->dev;   [1]
>
> Or instead of pass '&data->client->dev' or 'indio_dev->dev.parent'
> when calling sx9310_get_default_reg()
>
> Though [1] looks good to me as well.
Indeed, the current code does not work with device-tree bindings. The
proposed fix solves the issue, sending v7.

Thanks,
Gwendal.
>
> >         u32 combined[SX9310_NUM_CHANNELS];
> >         u32 start = 0, raw = 0, pos = 0;
> >         unsigned long comb_mask = 0;
> > @@ -1224,21 +1224,17 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
> >         const char *res;
> >
> >         memcpy(reg_def, &sx9310_default_regs[idx], sizeof(*reg_def));
> > -       if (!np)
> > -               return reg_def;
> > -
> >         switch (reg_def->reg) {
> >         case SX9310_REG_PROX_CTRL2:
> > -               if (of_property_read_bool(np, "semtech,cs0-ground")) {
> > +               if (device_property_read_bool(dev, "semtech,cs0-ground")) {
> >                         reg_def->def &= ~SX9310_REG_PROX_CTRL2_SHIELDEN_MASK;
> >                         reg_def->def |= SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND;
> >                 }
> >
> > -               count = of_property_count_elems_of_size(np, "semtech,combined-sensors",
> > -                                                       sizeof(u32));
> > +               count = device_property_count_u32(dev, "semtech,combined-sensors");
> >                 if (count > 0 && count <= ARRAY_SIZE(combined)) {
> > -                       ret = of_property_read_u32_array(np, "semtech,combined-sensors",
> > -                                                        combined, count);
> > +                       ret = device_property_read_u32_array(dev, "semtech,combined-sensors",
> > +                                                            combined, count);
> >                         if (ret)
> >                                 break;
> >                 } else {
> > @@ -1270,7 +1266,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
> >
> >                 break;
> >         case SX9310_REG_PROX_CTRL4:
> > -               ret = of_property_read_string(np, "semtech,resolution", &res);
> > +               ret = device_property_read_string(dev, "semtech,resolution", &res);
> >                 if (ret)
> >                         break;
> >
> > @@ -1294,7 +1290,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
> >
> >                 break;
> >         case SX9310_REG_PROX_CTRL5:
> > -               ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
> > +               ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
> >                 if (ret) {
> >                         start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
> >                                           reg_def->def);
> > @@ -1304,7 +1300,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
> >                 reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
> >                                            start);
> >
> > -               ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
> > +               ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
> >                 if (ret) {
> >                         raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
> >                                         reg_def->def);
> > @@ -1317,7 +1313,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
> >                                            raw);
> >                 break;
> >         case SX9310_REG_PROX_CTRL7:
> > -               ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
> > +               ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
> >                 if (ret)
> >                         break;
> >
> > @@ -1353,7 +1349,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
> >
> >         /* Program some sane defaults. */
> >         for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
> > -               initval = sx9310_get_default_reg(data, i, &tmp);
> > +               initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
> >                 ret = regmap_write(data->regmap, initval->reg, initval->def);
> >                 if (ret)
> >                         return ret;
> > --
> > 2.31.0.291.g576ba9dcdaf-goog
> >
