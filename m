Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D773113E6
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 22:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhBEVvG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 16:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhBEVuI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 16:50:08 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34318C0613D6
        for <linux-iio@vger.kernel.org>; Fri,  5 Feb 2021 13:49:26 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id e133so8684419iof.8
        for <linux-iio@vger.kernel.org>; Fri, 05 Feb 2021 13:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaUQ2wNwyNcFCL3TJkJvczWWZz4w9iYO7FZEvDtwCU0=;
        b=g9huoabcoG48d5NJ4zbwn2EqG3Ve+vM81lTN2Mvhfm2jlvjxlo26zCEbPFIRhKW68A
         JjT8pZLU6iPyhPeL0CXvZCV9AyOWS7mLLwiL68PV/WhXdde8O+zVX+A8nwjQyF9lbZ3b
         C/XIwqa+jNWDVfoc6r8huQaf+4taKEcn1Gv2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaUQ2wNwyNcFCL3TJkJvczWWZz4w9iYO7FZEvDtwCU0=;
        b=WdIu2W8IOp6fG2TydZtZgN7cfGYQO20jkXfImAwdXBSd8ScQ11z44BS4orqOQm8E/W
         sjbPTx7SAKEPZJ01sOUoPLV/DsFkYps9dKdLfrLlXjNCYtL+wBa56ylp4t7xMF9ysNKm
         l+RNsmX6p+z3WQfHTKguPw9zsLnxaHXi8q9WpPBb4bZ3zSrsvN5XaN2IHOPy0MbwnXXR
         3Iw9Ut+GU+98lAStQNQwScc9gulYYkkWyoJF9wTDf1+3VtWN6eKWOJUw/rSPmmhNUAJw
         xe7TgsP9YYEJnaB+YRV0NDzsgaMcffYuMD4LhJTBzN3mSvj5oqref6pdb/P1YnrApdMK
         OugA==
X-Gm-Message-State: AOAM532fhVdhOBFtcpKurbYVVBLgCtlUbqXofH2K2YsoSy6yjQjPIq5d
        vw4KBJg1RqoDuxcGDhcwnI1RnAphAjwhdgmmuCTORg==
X-Google-Smtp-Source: ABdhPJxsk3M09u4zn0p7F9nEuDYA7zP5vNk/cQSgOdaURDagpPRT/0e1iLUQkrM1x/qYTrtAIdj1tuqBdz2YRYOYdE4=
X-Received: by 2002:a02:ce33:: with SMTP id v19mr7053302jar.52.1612561765600;
 Fri, 05 Feb 2021 13:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20210202064541.2335915-1-gwendal@chromium.org> <161229346726.76967.648868878998146729@swboyd.mtv.corp.google.com>
In-Reply-To: <161229346726.76967.648868878998146729@swboyd.mtv.corp.google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 5 Feb 2021 13:49:12 -0800
Message-ID: <CAPUE2uu0y8pRmCHxhLQ3Ca2oAMJ0ihwAHfUdHNBOUNS-hZhmdA@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Support ACPI property
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 2, 2021 at 11:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2021-02-01 22:45:41)
> > Use device_property_read_... to support both device tree and ACPI
> > bindings.
> >
> > Add support for variable array per documentation
> > ("iio/proximity/semtech,sx9310.yaml").
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/proximity/sx9310.c | 36 ++++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index 37fd0b65a0140..1a8a441c9774d 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -1213,31 +1214,36 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
> >  }
> >
> >  static const struct sx9310_reg_default *
> > -sx9310_get_default_reg(struct sx9310_data *data, int i,
> > +sx9310_get_default_reg(struct device *dev, int i,
> >                        struct sx9310_reg_default *reg_def)
> >  {
> > -       int ret;
> > -       const struct device_node *np = data->client->dev.of_node;
> > +       int ret, count;
> >         u32 combined[SX9310_NUM_CHANNELS] = { 4, 4, 4, 4 };
> >         unsigned long comb_mask = 0;
> >         const char *res;
> >         u32 start = 0, raw = 0, pos = 0;
> >
> >         memcpy(reg_def, &sx9310_default_regs[i], sizeof(*reg_def));
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
> >                 reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
> > -               of_property_read_u32_array(np, "semtech,combined-sensors",
> > -                                          combined, ARRAY_SIZE(combined));
> > -               for (i = 0; i < ARRAY_SIZE(combined); i++) {
> > +               count = device_property_read_u32_array(dev,
> > +                               "semtech,combined-sensors", NULL, 0);
> > +               if (count > 0 && count <= ARRAY_SIZE(combined))
> > +                       ret = device_property_read_u32_array(dev,
> > +                                       "semtech,combined-sensors", combined,
> > +                                       count);
> > +               else
> > +                       ret = -EINVAL;
> > +               if (ret)
> > +                       count = ARRAY_SIZE(combined);
>
> I wish this could be written simpler. Unfortunately there isn't any sort
> of for_each_device_property() iterator macro like we have with
> of_property_for_each_u32(). Or device_property_read_u32_array() can be
> OK if the length of the property doesn't exceed the size of the
> 'combined' array?
device_property_read_u32_array(...,nval) calls
acpi_data_get_property(..., nval) in ACPI case.
If nval > obj->package.count, then -EOVERFLOW is returned.
Therefore count can not be to SX9310_NUM_CHANNELS, in case
combined-sensors is only 3 entries or less.

This method of asking first for the number of element and a second
time for the values is already used at different places in the kernel:
drivers/power/supply/gpio-charger.c : see init_charge_current_limit()
or  madera_get_variable_u32_array insound/soc/codecs/madera.c.

However, it could use device_property_count_u32(...), which is more
readable than device_property_count_u32(..., NULL,0).

Gwendal.


>
> > +
> > +               for (i = 0; i < count; i++) {
> >                         if (combined[i] <= SX9310_NUM_CHANNELS)
> >                                 comb_mask |= BIT(combined[i]);
> >                 }
>
> Otherwise
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
