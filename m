Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E8F23EC27
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHGLOk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 07:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgHGLOD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2020 07:14:03 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91BCC061574
        for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2020 04:14:00 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id p16so1469337ile.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2020 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QI/umtxQ1YXgKla27Pwdzds0LtdSy3IHSqgsViy/06s=;
        b=ewZh95nhv2iojWLtSgsX2ciqQSOG7OvgG8HlC3AR8pmyx+iY/0uwVggo/O3NG4mbS8
         i1d5KngKd11AV9cAnEcRYYL2duc0hopOH38NKaOfxKGKFScArzSHgECQqS7qYEEBAm+g
         +lgaVyAcHQI0J/KLZ3yjjd35WglnpYhoDBsnDqw/+pUrukivnut9epbbKuySRYy6T56r
         1HPxItTbs1TJVAqPLhLa8zNAr2wWDCkBHgJq0hxBpuTxBWPNBG+p967yuJt3D8Hle6Rq
         R4KGc4MK8zl7YM+e8YNQ8lnTx3ctYE+YnmYm547YTh4Np9IkVmXSWfZIi1TU5ABh680J
         zzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QI/umtxQ1YXgKla27Pwdzds0LtdSy3IHSqgsViy/06s=;
        b=tnXKG3bWU8RdNYZV1OVz+g5XvAdCMxD2TAmeUaZDgq9VN8Lh0TDOHSeeeYWP33+ifa
         jli84kaIuD8LJX3cAfhuuc8BXl2gYQxY51VtQLSdFTTQXaoWoz3XyrfGRiV/EjW0KtY7
         i4QAT45q5xa1iMf1NdsvDWYr0A5pFD03SK2+vbJYHJe6axLuJUcngQOdVopFDTMLqsit
         SZRPRMY/A/FqyxFYCtmHISFdKho8HG/EhUfR2xA0ainccs9kjS8nCOH/p/+CdAqJb7Or
         vXn5x6YzjAQQ2WrJuqmd+3VZmaz0HkZl2Bla/kRUtcT533r86OCNx5N3u+mfp4LnhkqW
         aQDA==
X-Gm-Message-State: AOAM530dcGLcqOf+pvSoDg9tJumW8kSKAo39Ab3ypcnVII2W1q8BhZmh
        4+FIARO/knDXySg+NNpJ/lQvVi/KcBL2JXHfZJcCTw==
X-Google-Smtp-Source: ABdhPJzcDgCrb/zea5KM9ondVwkPEgrqMYQSPv2+6UUDeeyxz5Fy2dnjbb1oEyxfjWOtYesfe35NiOi4NDPg0B4qNWE=
X-Received: by 2002:a92:5f87:: with SMTP id i7mr3741112ill.67.1596798838732;
 Fri, 07 Aug 2020 04:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200807092014.967262-1-cmo@melexis.com> <CAHp75VcBa7kpmnHi84363pL-CHffSmYhObNa7r0t-g_rtmP++g@mail.gmail.com>
In-Reply-To: <CAHp75VcBa7kpmnHi84363pL-CHffSmYhObNa7r0t-g_rtmP++g@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Fri, 7 Aug 2020 13:13:22 +0200
Message-ID: <CAKv63utf8v_BWwU35JNZpaBMkgq9XtezT3TtB4uSYMs7tEogWQ@mail.gmail.com>
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

On Fri, 7 Aug 2020 at 12:29, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 7, 2020 at 12:21 PM Crt Mori <cmo@melexis.com> wrote:
>
> Oh yeah, you are right, there will be some comments :-)
>

Told ya. No matter how many times I go through it, I always find
something. I will prepare v3 with fixes, except for some additional
questions below.

> > For some time market wants medical grade accuracy in medical range,
>
> the market
>
> > while still retaining the declared accuracy outside of the medical range
> > within the same sensor. That is why we created extended calibration
> > which is automatically switched to when object temperature is too high.
> >
> > This patch also introduces the object_ambient_temperature variable which
> > is needed for more accurate calculation of the object infra-red
> > footprint as sensor's ambient temperature might be totally different
> > than what the ambient temperature is at object and that is why we can
> > have some more error which can be eliminated. Currently this temperature
>
> errors
>
> > is fixed at 25, but interface to adjust it by user (with external sensor
>
> the interface
>
> > or just IR measurement of the another object which acts as ambient),
>
> 'of another' or 'the other' if we know what it is exactly.
>
> > will be introduced in another commit.
>
> ...
>
> >  struct mlx90632_data {
> >         struct i2c_client *client;
> >         struct mutex lock; /* Multiple reads for single measurement */
> >         struct regmap *regmap;
> >         u16 emissivity;
>
> > +       u8 mtyp; /* measurement type - to enable extended range calculations */
>
> Perhaps better to switch this struct to follow kernel doc in one of
> preparatory patches and add the description of this field accordingly.
>

Can you explain a bit more? I was looking in kernel doc, but could not
find much about how to comment these members.

> > +       u32 object_ambient_temperature;
> >  };
>
> ...
>
> > +static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
> > +{
> > +       int ret;
> > +
> > +       if ((type != MLX90632_MTYP_MEDICAL) & (type != MLX90632_MTYP_EXTENDED))
> > +               return -EINVAL;
>
> Not sure I understand the point of & vs. && here.
>

Should indeed be &&, if it is needed at all. Both are boolean types.

> > +       ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> > +                                (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
> > +                                (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       mlx90632_pwr_continuous(regmap);
>
> > +
> > +       return ret;
>
> Since you are using ' < 0' above and below (and I think it doesn't
> worth it, i.o.w. you may drop them) here is something interesting
> might be returned (actually not, see first part of this sentence).
> Should be
>
> return 0;
>
> > +}
>
> ...
>
> > +static int mlx90632_read_ambient_raw_extended(struct regmap *regmap,
> > +                                             s16 *ambient_new_raw, s16 *ambient_old_raw)
> > +{
>
> > +       int ret;
> > +       unsigned int read_tmp;
>
> Please keep them in reversed xmas tree format.
>
> > +
> > +       ret = regmap_read(regmap, MLX90632_RAM_3(17), &read_tmp);
> > +       if (ret < 0)
> > +               return ret;
> > +       *ambient_new_raw = (s16)read_tmp;
> > +
> > +       ret = regmap_read(regmap, MLX90632_RAM_3(18), &read_tmp);
> > +       if (ret < 0)
> > +               return ret;
> > +       *ambient_old_raw = (s16)read_tmp;
>
> > +       return ret;
>
> Same comments as per previous function.
>
> > +}
>
> > +static int mlx90632_read_object_raw_extended(struct regmap *regmap, s16 *object_new_raw)
> > +{
> > +       int ret;
> > +       unsigned int read_tmp;
> > +       s32 read;
>
> Besides all above comments being applicable here...
>
> > +       ret = regmap_read(regmap, MLX90632_RAM_1(17), &read_tmp);
> > +       if (ret < 0)
> > +               return ret;
> > +       read = (s16)read_tmp;
> > +
> > +       ret = regmap_read(regmap, MLX90632_RAM_2(17), &read_tmp);
> > +       if (ret < 0)
> > +               return ret;
> > +       read = read - (s16)read_tmp;
>
> ...I'm wondering if you can use bulk reads of those registers.

I cant, sensor does not support it and single read case did not work
few years back, but maybe regmap now improved...

> Also I'm not sure you need explicit castings.
>
> > +       ret = regmap_read(regmap, MLX90632_RAM_1(18), &read_tmp);
> > +       if (ret < 0)
> > +               return ret;
> > +       read = read - (s16)read_tmp;
> > +
> > +       ret = regmap_read(regmap, MLX90632_RAM_2(18), &read_tmp);
> > +       if (ret < 0)
> > +               return ret;
> > +       read = (read + (s16)read_tmp) / 2;
>
> Ditto.
>
> > +       ret = regmap_read(regmap, MLX90632_RAM_1(19), &read_tmp);
> > +       if (ret < 0)
> > +               return ret;
> > +       read = read + (s16)read_tmp;
> > +
> > +       ret = regmap_read(regmap, MLX90632_RAM_2(19), &read_tmp);
> > +       if (ret < 0)
> > +               return ret;
> > +       read = read + (s16)read_tmp;
>
> > +       if (read > 32767 || read < -32768)
>
> These are defined as S16_MIN and S16_MAX. Use limits.h.
>
> > +               return -EINVAL;
>
> -ERANGE
>
> > +       *object_new_raw = (int16_t)read;
>
> Oh, no. Please avoid user space types in the kernel. And what's the
> point anyway after checking the range?
>
> > +       return ret;
> > +}
>
> ...
>
> > +static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *object_new_raw,
> > +                                             s16 *ambient_new_raw, s16 *ambient_old_raw)
> > +{
> > +       s32 ret;
> > +       int tries = 4;
> > +
> > +       mutex_lock(&data->lock);
> > +       ret = mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_EXTENDED);
> > +       if (ret < 0)
> > +               goto read_unlock;
>
>
> > +       while (tries-- > 0) {
> > +               ret = mlx90632_perform_measurement(data);
> > +               if (ret < 0)
> > +                       goto read_unlock;
> > +
>
> > +               if (ret == 19)
>
> It's funny. What does this magic mean?
>

That we should break the loop once channels up to 19 are filled (we
read 17 18 and 19 in this case, we read 1 2 in normal case). A comment
maybe here?

> > +                       break;
> > +       }
> > +       if (tries < 0) {
> > +               ret = -ETIMEDOUT;
> > +               goto read_unlock;
> > +       }
>
> Timeout loops are much better in a following style
>
> unsigned int iterations = 4;
>
> do {
>   ...
> } while (--iterations);
> if (!iterations) {
>   ...-ETIMEDOUT...
> }
>
> Besides that consider the iopoll.h APIs, perhaps it may be applied here.
>
> > +       ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
> > +       if (ret < 0)
> > +               goto read_unlock;
> > +
> > +       ret = mlx90632_read_ambient_raw_extended(data->regmap, ambient_new_raw, ambient_old_raw);
> > +
> > +read_unlock:
> > +       (void) mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_MEDICAL);
> > +
> > +       mutex_unlock(&data->lock);
> > +       return ret;
> > +}
>
> ...
>
> > +static s64 mlx90632_preprocess_temp_obj_extended(s16 object_new_raw, s16 ambient_new_raw,
> > +                                                s16 ambient_old_raw, s16 Ka)
> > +{
> > +       s64 VR_IR, kKa, tmp;
> > +
> > +       kKa = ((s64)Ka * 1000LL) >> 10ULL;
> > +       VR_IR = (s64)ambient_old_raw * 1000000LL +
> > +               kKa * div64_s64(((s64)ambient_new_raw * 1000LL),
> > +                       (MLX90632_REF_3));
>
> And the point of using parentheses? It's not a Lisp language :-)
> (Applicable everywhere in your code, the rule of thumb that any
> particular comment given by reviewer should be considered against
> entire code where it's appropriate)
>
> > +       tmp = div64_s64(
> > +                       div64_s64((((s64)object_new_raw) * 1000000000000LL), MLX90632_REF_12),
> > +                       VR_IR);
> > +       return div64_s64((tmp << 19ULL), 1000LL);
> > +}
>
> ...
>
> > +       TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
> > +       Tr4 = (div64_long(reflected, 10) + 27315) *
> > +               (div64_long(reflected, 10) + 27315) *
> > +               (div64_long(reflected, 10) + 27315) *
> > +               (div64_long(reflected, 10) + 27315);
> > +       TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
> > +               (div64_s64(TAdut, 10000LL) + 27315) *
> > +               (div64_s64(TAdut, 10000LL)  + 27315) *
> > +               (div64_s64(TAdut, 10000LL) + 27315);
>
> Okay, looking at this I definitely think that this patch should be
> split into a few smaller logically separated pieces like introducing
> some helpers to calculate above with them.
>
> ...
>
> > +       mlx90632->object_ambient_temperature = 25000; /* 25 degrees Celsius */
>
> Comment is lying. milliCelsius.
>
> --
> With Best Regards,
> Andy Shevchenko
