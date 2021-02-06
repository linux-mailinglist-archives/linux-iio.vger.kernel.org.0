Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68B31192F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 03:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBFC5X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 21:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhBFCb4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 21:31:56 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFECC03327B
        for <linux-iio@vger.kernel.org>; Fri,  5 Feb 2021 17:41:52 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o16so5780747pgg.5
        for <linux-iio@vger.kernel.org>; Fri, 05 Feb 2021 17:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=M6zU1nSggIV/6j6KEwfwFBakfOGZKmVEUakZfR0AFdw=;
        b=iVxCEkcyOVKkGFtHC2mDRf16QL5rCz6TZoJy+Y0xAPnJJYMbSJYOYeZgLW8vvwxEb2
         z4bNTU1nb83K+SR4F1HwquPEoNaQsZCxCWRbZtAB7dq/2rYdxdhDrrcu5xAUNJs+DMVm
         CLe0QMoPTAlBu709v8nSjE2bsDE0f0BWBbAjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=M6zU1nSggIV/6j6KEwfwFBakfOGZKmVEUakZfR0AFdw=;
        b=Z68u0mHE+KYxltBRUfO2NxEpQguIcv4oE/N3UOCPr+vyxzxHeVe0gexuGlpA+fFja0
         nycaRRSRJh/Tq/7OKBdehQbkpr9ic6O/0NGJc4iVUs7pMSXWXW955oJEbpLJknvyoTya
         EmtZgy8UxBhdEFV7cvHG1PZg698tI6gx1uU4kx03iQ5RfrBLttbOOK7XF6y2jAIDYwhH
         csHRWZaBeVfAOQ8++7dJhKgN4nNd17nWw2z2CcD1aztwBLMFSASMLuasFku4CUzudGs3
         s/pBlQT1AUhB3yQ3mTvfWVbYuU29KRkYnz7J92JDgeOGEO4Z7TjUTjrBSuNEQYof0hK2
         glSg==
X-Gm-Message-State: AOAM532AAr6l4ms07PJn4WOwewZBg1mzkzMkOw5zo1ZCmojD9hoI2s1A
        azO+uZLr7j7Hr0TZ3U/wuALXMw==
X-Google-Smtp-Source: ABdhPJyniiPB/UZtJODtzf4Imck1qGjO6PhTKZHC7QQ3/y7rlTBHYNMrt/nMSMkuUC6KAjnBTUUstA==
X-Received: by 2002:a63:2746:: with SMTP id n67mr6920721pgn.54.1612575711902;
        Fri, 05 Feb 2021 17:41:51 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3d74:5f76:aaaa:6cb8])
        by smtp.gmail.com with ESMTPSA id j7sm10938007pfh.147.2021.02.05.17.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 17:41:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPUE2uu0y8pRmCHxhLQ3Ca2oAMJ0ihwAHfUdHNBOUNS-hZhmdA@mail.gmail.com>
References: <20210202064541.2335915-1-gwendal@chromium.org> <161229346726.76967.648868878998146729@swboyd.mtv.corp.google.com> <CAPUE2uu0y8pRmCHxhLQ3Ca2oAMJ0ihwAHfUdHNBOUNS-hZhmdA@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Support ACPI property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 05 Feb 2021 17:41:49 -0800
Message-ID: <161257570963.76967.16707158676326253606@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-02-05 13:49:12)
> On Tue, Feb 2, 2021 at 11:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Gwendal Grignou (2021-02-01 22:45:41)
> > > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/s=
x9310.c
> > > index 37fd0b65a0140..1a8a441c9774d 100644
> > > --- a/drivers/iio/proximity/sx9310.c
> > > +++ b/drivers/iio/proximity/sx9310.c
> > > @@ -1213,31 +1214,36 @@ static int sx9310_init_compensation(struct ii=
o_dev *indio_dev)
> > >  }
> > >
> > >  static const struct sx9310_reg_default *
> > > -sx9310_get_default_reg(struct sx9310_data *data, int i,
> > > +sx9310_get_default_reg(struct device *dev, int i,
> > >                        struct sx9310_reg_default *reg_def)
> > >  {
> > > -       int ret;
> > > -       const struct device_node *np =3D data->client->dev.of_node;
> > > +       int ret, count;
> > >         u32 combined[SX9310_NUM_CHANNELS] =3D { 4, 4, 4, 4 };
> > >         unsigned long comb_mask =3D 0;
> > >         const char *res;
> > >         u32 start =3D 0, raw =3D 0, pos =3D 0;
> > >
> > >         memcpy(reg_def, &sx9310_default_regs[i], sizeof(*reg_def));
> > > -       if (!np)
> > > -               return reg_def;
> > > -
> > >         switch (reg_def->reg) {
> > >         case SX9310_REG_PROX_CTRL2:
> > > -               if (of_property_read_bool(np, "semtech,cs0-ground")) {
> > > +               if (device_property_read_bool(dev, "semtech,cs0-groun=
d")) {
> > >                         reg_def->def &=3D ~SX9310_REG_PROX_CTRL2_SHIE=
LDEN_MASK;
> > >                         reg_def->def |=3D SX9310_REG_PROX_CTRL2_SHIEL=
DEN_GROUND;
> > >                 }
> > >
> > >                 reg_def->def &=3D ~SX9310_REG_PROX_CTRL2_COMBMODE_MAS=
K;
> > > -               of_property_read_u32_array(np, "semtech,combined-sens=
ors",
> > > -                                          combined, ARRAY_SIZE(combi=
ned));
> > > -               for (i =3D 0; i < ARRAY_SIZE(combined); i++) {
> > > +               count =3D device_property_read_u32_array(dev,
> > > +                               "semtech,combined-sensors", NULL, 0);
> > > +               if (count > 0 && count <=3D ARRAY_SIZE(combined))
> > > +                       ret =3D device_property_read_u32_array(dev,
> > > +                                       "semtech,combined-sensors", c=
ombined,
> > > +                                       count);
> > > +               else
> > > +                       ret =3D -EINVAL;
> > > +               if (ret)
> > > +                       count =3D ARRAY_SIZE(combined);
> >
> > I wish this could be written simpler. Unfortunately there isn't any sort
> > of for_each_device_property() iterator macro like we have with
> > of_property_for_each_u32(). Or device_property_read_u32_array() can be
> > OK if the length of the property doesn't exceed the size of the
> > 'combined' array?
>
> device_property_read_u32_array(...,nval) calls
> acpi_data_get_property(..., nval) in ACPI case.
> If nval > obj->package.count, then -EOVERFLOW is returned.
> Therefore count can not be to SX9310_NUM_CHANNELS, in case
> combined-sensors is only 3 entries or less.
>=20
> This method of asking first for the number of element and a second
> time for the values is already used at different places in the kernel:
> drivers/power/supply/gpio-charger.c : see init_charge_current_limit()
> or  madera_get_variable_u32_array insound/soc/codecs/madera.c.

Sure it's used but that doesn't really mean it's a good pattern to copy.
If the number is more than 4 I'd say we should ignore it and move on,
but if it's less than 4 is an error returned?

>=20
> However, it could use device_property_count_u32(...), which is more
> readable than device_property_count_u32(..., NULL,0).
>=20

How about

  ret =3D device_property_read_u32_array(dev, "semtech,combined-sensors", c=
ombined, ARRAY_SIZE(combined));
  if (ret)
  	break; /* Must have overflowed or not existed; ignore */

  for (i =3D 0; i < ARRAY_SIZE(combined); i++)

and then it should work as before?
