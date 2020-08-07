Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA2F23F512
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 01:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgHGXBt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 19:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgHGXBt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2020 19:01:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E335CC061756
        for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2020 16:01:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id a5so3453713ioa.13
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2020 16:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Mn2Ewcv0rE8ArObt2Bnc/hXt7ImGEZcAPTBu0GM9bg=;
        b=gkiBEOsfHFIcWOyW/TYfkO8HQpwYHznXTs4jg4W10rIB+X0ZsXh/bDPrBBpUpWtRno
         u2fbSIkSGV6R1wIXM1dZqF/7p/5jtG1lZHjSUF5kh8alQf+FJwbUWYbdlJv9rLwIDw+L
         HkWcqF/PPE3b/Gq2Ov1SNQ1DH7JoCje1XZ1X5DJvEeC8Meap6/5qqNenXQvds/9uiTN+
         OJy2+8eVq5cRd2L4or5Aun7l1em1MztewKvg/hvvvEsZ39gAM/gsMOiNGujOC5OFEMVt
         unwYpX9Z72ad2/GkdZwGkmeFp+AijgeGAqLcuUArlU9+i/zIGBzhTpM031zVCtNkEIF3
         2e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Mn2Ewcv0rE8ArObt2Bnc/hXt7ImGEZcAPTBu0GM9bg=;
        b=q1lA1BxhGop+yfNvJJmw6QL4hBU2xTMJ0YZtAG67cuAvXZeKLFuRqjYHaiduHrsTlC
         IIHHZAlVmdDi8+76zTftaSrHqtUxjIsfIRvJa5WwwusZuBf/SxWknrttxJ53jcsl1gZP
         9V+44MCY8M1mzAgvgUsL2NOLT/ALGSmXenSELRbrFXe9pwCAtUhjV6UJUfl/M4Vt+pJ+
         ZXeNJAXWRszU/LOlEZ8DNL5gu5P27SRhfqh5qomvflzcu+kbTA8W1pkRKr/QRaK9Ks2d
         l4E2gcT0MgcAIbY7nIN/qOkabAo5aqs24HhUpo0ay2eXFcK39Zhiu0jcI12Rmtl5IUo1
         Rlzw==
X-Gm-Message-State: AOAM530GaMeil8HN2NsFGReZn+etEf3TXJ+zAyNfmOFQheeRGhOUabGL
        ur8h21HhSp/cTh1Mfl+KofMwL8WIkhuk6e47yJCWSw==
X-Google-Smtp-Source: ABdhPJyCXpgBbjuhyfUmZ+gDKCW/4rGgdOCRhajanp7EPA0fXYESvGqZKzVa828nNb8c4NkUqiAV0TWDZhH+S9+HSV4=
X-Received: by 2002:a6b:700d:: with SMTP id l13mr6714067ioc.135.1596841307675;
 Fri, 07 Aug 2020 16:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200807092014.967262-1-cmo@melexis.com> <CAHp75VcBa7kpmnHi84363pL-CHffSmYhObNa7r0t-g_rtmP++g@mail.gmail.com>
 <CAKv63utf8v_BWwU35JNZpaBMkgq9XtezT3TtB4uSYMs7tEogWQ@mail.gmail.com>
In-Reply-To: <CAKv63utf8v_BWwU35JNZpaBMkgq9XtezT3TtB4uSYMs7tEogWQ@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Sat, 8 Aug 2020 01:01:11 +0200
Message-ID: <CAKv63utZSJJHvCTJYuy-iSvh6N4AGn2z0o=VV8RxGDvf5PaCjA@mail.gmail.com>
Subject: Re: [PATCH 2/2 resend] iio:temperature:mlx90632: Adding extended
 calibration option
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 7 Aug 2020 at 13:13, Crt Mori <cmo@melexis.com> wrote:
>
> On Fri, 7 Aug 2020 at 12:29, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Fri, Aug 7, 2020 at 12:21 PM Crt Mori <cmo@melexis.com> wrote:
> >
> > Oh yeah, you are right, there will be some comments :-)
> >
>
> Told ya. No matter how many times I go through it, I always find
> something. I will prepare v3 with fixes, except for some additional
> questions below.
>
I tried some suggestions and it was just not working. See the
explanation below. I am resending v3 without those.

> > > For some time market wants medical grade accuracy in medical range,
> >
> > the market
> >
> > > while still retaining the declared accuracy outside of the medical range
> > > within the same sensor. That is why we created extended calibration
> > > which is automatically switched to when object temperature is too high.
> > >
> > > This patch also introduces the object_ambient_temperature variable which
> > > is needed for more accurate calculation of the object infra-red
> > > footprint as sensor's ambient temperature might be totally different
> > > than what the ambient temperature is at object and that is why we can
> > > have some more error which can be eliminated. Currently this temperature
> >
> > errors
> >
> > > is fixed at 25, but interface to adjust it by user (with external sensor
> >
> > the interface
> >
> > > or just IR measurement of the another object which acts as ambient),
> >
> > 'of another' or 'the other' if we know what it is exactly.
> >
> > > will be introduced in another commit.
> >
> > ...
> >
> > >  struct mlx90632_data {
> > >         struct i2c_client *client;
> > >         struct mutex lock; /* Multiple reads for single measurement */
> > >         struct regmap *regmap;
> > >         u16 emissivity;
> >
> > > +       u8 mtyp; /* measurement type - to enable extended range calculations */
> >
> > Perhaps better to switch this struct to follow kernel doc in one of
> > preparatory patches and add the description of this field accordingly.
> >
>
> Can you explain a bit more? I was looking in kernel doc, but could not
> find much about how to comment these members.
>
> > > +       u32 object_ambient_temperature;
> > >  };
> >
> > ...
> >
> > > +static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
> > > +{
> > > +       int ret;
> > > +
> > > +       if ((type != MLX90632_MTYP_MEDICAL) & (type != MLX90632_MTYP_EXTENDED))
> > > +               return -EINVAL;
> >
> > Not sure I understand the point of & vs. && here.
> >
>
> Should indeed be &&, if it is needed at all. Both are boolean types.
>
> > > +       ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> > > +                                (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
> > > +                                (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       mlx90632_pwr_continuous(regmap);
> >
> > > +
> > > +       return ret;
> >
> > Since you are using ' < 0' above and below (and I think it doesn't
> > worth it, i.o.w. you may drop them) here is something interesting
> > might be returned (actually not, see first part of this sentence).
> > Should be
> >
> > return 0;
> >
> > > +}
> >
> > ...
> >
> > > +static int mlx90632_read_ambient_raw_extended(struct regmap *regmap,
> > > +                                             s16 *ambient_new_raw, s16 *ambient_old_raw)
> > > +{
> >
> > > +       int ret;
> > > +       unsigned int read_tmp;
> >
> > Please keep them in reversed xmas tree format.
> >
> > > +
> > > +       ret = regmap_read(regmap, MLX90632_RAM_3(17), &read_tmp);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       *ambient_new_raw = (s16)read_tmp;
> > > +
> > > +       ret = regmap_read(regmap, MLX90632_RAM_3(18), &read_tmp);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       *ambient_old_raw = (s16)read_tmp;
> >
> > > +       return ret;
> >
> > Same comments as per previous function.
> >
> > > +}
> >
> > > +static int mlx90632_read_object_raw_extended(struct regmap *regmap, s16 *object_new_raw)
> > > +{
> > > +       int ret;
> > > +       unsigned int read_tmp;
> > > +       s32 read;
> >
> > Besides all above comments being applicable here...
> >
> > > +       ret = regmap_read(regmap, MLX90632_RAM_1(17), &read_tmp);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       read = (s16)read_tmp;
> > > +
> > > +       ret = regmap_read(regmap, MLX90632_RAM_2(17), &read_tmp);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       read = read - (s16)read_tmp;
> >
> > ...I'm wondering if you can use bulk reads of those registers.
>
> I cant, sensor does not support it and single read case did not work
> few years back, but maybe regmap now improved...
>
> > Also I'm not sure you need explicit castings.
> >
> > > +       ret = regmap_read(regmap, MLX90632_RAM_1(18), &read_tmp);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       read = read - (s16)read_tmp;
> > > +
> > > +       ret = regmap_read(regmap, MLX90632_RAM_2(18), &read_tmp);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       read = (read + (s16)read_tmp) / 2;
> >
> > Ditto.
> >
> > > +       ret = regmap_read(regmap, MLX90632_RAM_1(19), &read_tmp);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       read = read + (s16)read_tmp;
> > > +
> > > +       ret = regmap_read(regmap, MLX90632_RAM_2(19), &read_tmp);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       read = read + (s16)read_tmp;
> >
> > > +       if (read > 32767 || read < -32768)
> >
> > These are defined as S16_MIN and S16_MAX. Use limits.h.
> >
> > > +               return -EINVAL;
> >
> > -ERANGE
> >
> > > +       *object_new_raw = (int16_t)read;
> >
> > Oh, no. Please avoid user space types in the kernel. And what's the
> > point anyway after checking the range?
> >
> > > +       return ret;
> > > +}
> >
> > ...
> >
> > > +static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *object_new_raw,
> > > +                                             s16 *ambient_new_raw, s16 *ambient_old_raw)
> > > +{
> > > +       s32 ret;
> > > +       int tries = 4;
> > > +
> > > +       mutex_lock(&data->lock);
> > > +       ret = mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_EXTENDED);
> > > +       if (ret < 0)
> > > +               goto read_unlock;
> >
> >
> > > +       while (tries-- > 0) {
> > > +               ret = mlx90632_perform_measurement(data);
> > > +               if (ret < 0)
> > > +                       goto read_unlock;
> > > +
> >
> > > +               if (ret == 19)
> >
> > It's funny. What does this magic mean?
> >
>
> That we should break the loop once channels up to 19 are filled (we
> read 17 18 and 19 in this case, we read 1 2 in normal case). A comment
> maybe here?
>
> > > +                       break;
> > > +       }
> > > +       if (tries < 0) {
> > > +               ret = -ETIMEDOUT;
> > > +               goto read_unlock;
> > > +       }
> >
> > Timeout loops are much better in a following style
> >
> > unsigned int iterations = 4;
> >
> > do {
> >   ...
> > } while (--iterations);
> > if (!iterations) {
> >   ...-ETIMEDOUT...
> > }
> >
> > Besides that consider the iopoll.h APIs, perhaps it may be applied here.
> >

I tried to apply the iopoll.h, but it is not appropriate enough as
timeout_us would have to be timeout_ms, because if you want 4 cycles
of 10ms, then you run out of range of usleep. I can create a helper,
but it does not seem like someone needs it. I am keeping current
style, because also function above (old) has the same style of poll
loop.

> > > +       ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
> > > +       if (ret < 0)
> > > +               goto read_unlock;
> > > +
> > > +       ret = mlx90632_read_ambient_raw_extended(data->regmap, ambient_new_raw, ambient_old_raw);
> > > +
> > > +read_unlock:
> > > +       (void) mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_MEDICAL);
> > > +
> > > +       mutex_unlock(&data->lock);
> > > +       return ret;
> > > +}
> >
> > ...
> >
> > > +static s64 mlx90632_preprocess_temp_obj_extended(s16 object_new_raw, s16 ambient_new_raw,
> > > +                                                s16 ambient_old_raw, s16 Ka)
> > > +{
> > > +       s64 VR_IR, kKa, tmp;
> > > +
> > > +       kKa = ((s64)Ka * 1000LL) >> 10ULL;
> > > +       VR_IR = (s64)ambient_old_raw * 1000000LL +
> > > +               kKa * div64_s64(((s64)ambient_new_raw * 1000LL),
> > > +                       (MLX90632_REF_3));
> >
> > And the point of using parentheses? It's not a Lisp language :-)
> > (Applicable everywhere in your code, the rule of thumb that any
> > particular comment given by reviewer should be considered against
> > entire code where it's appropriate)
> >
> > > +       tmp = div64_s64(
> > > +                       div64_s64((((s64)object_new_raw) * 1000000000000LL), MLX90632_REF_12),
> > > +                       VR_IR);
> > > +       return div64_s64((tmp << 19ULL), 1000LL);
> > > +}
> >
> > ...
> >
> > > +       TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
> > > +       Tr4 = (div64_long(reflected, 10) + 27315) *
> > > +               (div64_long(reflected, 10) + 27315) *
> > > +               (div64_long(reflected, 10) + 27315) *
> > > +               (div64_long(reflected, 10) + 27315);
> > > +       TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
> > > +               (div64_s64(TAdut, 10000LL) + 27315) *
> > > +               (div64_s64(TAdut, 10000LL)  + 27315) *
> > > +               (div64_s64(TAdut, 10000LL) + 27315);
> >
> > Okay, looking at this I definitely think that this patch should be
> > split into a few smaller logically separated pieces like introducing
> > some helpers to calculate above with them.
> >
> > ...
> >
> > > +       mlx90632->object_ambient_temperature = 25000; /* 25 degrees Celsius */
> >
> > Comment is lying. milliCelsius.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
