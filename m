Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51285B5F89
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfIRItE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 04:49:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35130 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730522AbfIRItD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 04:49:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id w2so7226988qkf.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Sep 2019 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G5YbJWFGfh3PunxXFzgcpBaC8N6gVE+B9QKsVJivxZY=;
        b=D1AILnudmGYgiv6O0vqrHBIUC8fGqP21v5M2nIJSybEf8eNpSJm83VOozFQDs9j6Zu
         JdouMaFHOanSZq/NR8LQDrLSq5343LGwkvv4AZ4loO5yf/+6caCULzuaT7SijUJ+wXqD
         Pk8fPoxC5yDj2TXdh8aACnUKN+wSUXcU4htyf+JNcp1Q3921zB+uO2NUmm+TflmZvSK4
         2BoqGCl0IClrgba6sGoW95T0OcyYLALFFCFO0K46dVk/ZHhE4hkLmdr+DrwqiOt4qBhs
         dzeN4GEzr5cOhr5IZiKjFcDi+JHNlluVDZ4l/LYJlTFBGxjKaEbhdbg28BK4Nz1CVyso
         wtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G5YbJWFGfh3PunxXFzgcpBaC8N6gVE+B9QKsVJivxZY=;
        b=bU8FFABhWeUCt1Xj1u6nuMBV1wdLia9JUFOv9LPDhmHC6yMPIsshJdtHTidZ3VCyX7
         XD+45II7cxABNeTOGeB58z7CR46oESguJFrpq4TCgDZb7EXCwBDVH/tw84WtaD6Cv99S
         tBHDGjzDSQS7rm30hXxsoHvI3FsoRQM++L/u1ywlzNsDosfmOg8O8Zh6EAf7Wvw2vw9F
         60CHrldJTJypSDFkAwtcAygzEQyAPB0D1MmG+m9Ls49v/yv2HLsXFc0mbUCBhrzUCEMh
         JB2hPCxdcxIjazvvsjtgex8vC0MCUpIjiB6IpiZ3szSN+49tobaSOZGNR/p+G+9WizW0
         YHtw==
X-Gm-Message-State: APjAAAWEfazLithDwPNVGYsKrMv8UV3ii49fDNmzVHl0JS0P9GpfAW6c
        cTZyFKSFHB3dSj1PKiG4NfI4K6gq0UuLmWY3Vr8VvA==
X-Google-Smtp-Source: APXvYqy6epwJY7MhGtovSNnXDgOF3DzUxJAuMiuZYv0/5SaRC9poymus+HIxyCOScdZgFRZnhwGO9IGsB5+2H3SgsjM=
X-Received: by 2002:a37:7086:: with SMTP id l128mr2718999qkc.433.1568796542176;
 Wed, 18 Sep 2019 01:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568792697.git.vilhelm.gray@gmail.com> <f7969048e5db977cc6cc9daa8d32b170cf9f4c17.1568792697.git.vilhelm.gray@gmail.com>
In-Reply-To: <f7969048e5db977cc6cc9daa8d32b170cf9f4c17.1568792697.git.vilhelm.gray@gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 18 Sep 2019 10:48:51 +0200
Message-ID: <CA+M3ks45XTRjED2+2FAwcaG96YSszu2BZshTA7DSGscQQzAOFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] counter: Simplify the count_read and count_write callbacks
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le mer. 18 sept. 2019 =C3=A0 09:53, William Breathitt Gray
<vilhelm.gray@gmail.com> a =C3=A9crit :
>
> The count_read and count_write callbacks are simplified to pass val as
> unsigned long rather than as an opaque data structure. The opaque
> counter_count_read_value and counter_count_write_value structures,
> counter_count_value_type enum, and relevant counter_count_read_value_set
> and counter_count_write_value_get functions, are removed as they are no
> longer used.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Hi William,

This first patch break the compilation because you remove some
structure needed for the drivers.
You should merge all the serie in 1 patch to avoid that.

Benjamin

> ---
>  drivers/counter/counter.c | 66 +++++----------------------------------
>  include/linux/counter.h   | 43 +++----------------------
>  2 files changed, 12 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
> index 106bc7180cd8..1d08f1437b1b 100644
> --- a/drivers/counter/counter.c
> +++ b/drivers/counter/counter.c
> @@ -246,60 +246,6 @@ void counter_signal_read_value_set(struct counter_si=
gnal_read_value *const val,
>  }
>  EXPORT_SYMBOL_GPL(counter_signal_read_value_set);
>
> -/**
> - * counter_count_read_value_set - set counter_count_read_value data
> - * @val:       counter_count_read_value structure to set
> - * @type:      property Count data represents
> - * @data:      Count data
> - *
> - * This function sets an opaque counter_count_read_value structure with =
the
> - * provided Count data.
> - */
> -void counter_count_read_value_set(struct counter_count_read_value *const=
 val,
> -                                 const enum counter_count_value_type typ=
e,
> -                                 void *const data)
> -{
> -       switch (type) {
> -       case COUNTER_COUNT_POSITION:
> -               val->len =3D sprintf(val->buf, "%lu\n", *(unsigned long *=
)data);
> -               break;
> -       default:
> -               val->len =3D 0;
> -       }
> -}
> -EXPORT_SYMBOL_GPL(counter_count_read_value_set);
> -
> -/**
> - * counter_count_write_value_get - get counter_count_write_value data
> - * @data:      Count data
> - * @type:      property Count data represents
> - * @val:       counter_count_write_value structure containing data
> - *
> - * This function extracts Count data from the provided opaque
> - * counter_count_write_value structure and stores it at the address prov=
ided by
> - * @data.
> - *
> - * RETURNS:
> - * 0 on success, negative error number on failure.
> - */
> -int counter_count_write_value_get(void *const data,
> -                                 const enum counter_count_value_type typ=
e,
> -                                 const struct counter_count_write_value =
*const val)
> -{
> -       int err;
> -
> -       switch (type) {
> -       case COUNTER_COUNT_POSITION:
> -               err =3D kstrtoul(val->buf, 0, data);
> -               if (err)
> -                       return err;
> -               break;
> -       }
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(counter_count_write_value_get);
> -
>  struct counter_attr_parm {
>         struct counter_device_attr_group *group;
>         const char *prefix;
> @@ -788,13 +734,13 @@ static ssize_t counter_count_show(struct device *de=
v,
>         const struct counter_count_unit *const component =3D devattr->com=
ponent;
>         struct counter_count *const count =3D component->count;
>         int err;
> -       struct counter_count_read_value val =3D { .buf =3D buf };
> +       unsigned long val;
>
>         err =3D counter->ops->count_read(counter, count, &val);
>         if (err)
>                 return err;
>
> -       return val.len;
> +       return sprintf(buf, "%lu\n", val);
>  }
>
>  static ssize_t counter_count_store(struct device *dev,
> @@ -806,9 +752,13 @@ static ssize_t counter_count_store(struct device *de=
v,
>         const struct counter_count_unit *const component =3D devattr->com=
ponent;
>         struct counter_count *const count =3D component->count;
>         int err;
> -       struct counter_count_write_value val =3D { .buf =3D buf };
> +       unsigned long val;
> +
> +       err =3D kstrtoul(buf, 0, &val);
> +       if (err)
> +               return err;
>
> -       err =3D counter->ops->count_write(counter, count, &val);
> +       err =3D counter->ops->count_write(counter, count, val);
>         if (err)
>                 return err;
>
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index a061cdcdef7c..7e40796598a6 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -300,24 +300,6 @@ struct counter_signal_read_value {
>         size_t len;
>  };
>
> -/**
> - * struct counter_count_read_value - Opaque Count read value
> - * @buf:       string representation of Count read value
> - * @len:       length of string in @buf
> - */
> -struct counter_count_read_value {
> -       char *buf;
> -       size_t len;
> -};
> -
> -/**
> - * struct counter_count_write_value - Opaque Count write value
> - * @buf:       string representation of Count write value
> - */
> -struct counter_count_write_value {
> -       const char *buf;
> -};
> -
>  /**
>   * struct counter_ops - Callbacks from driver
>   * @signal_read:       optional read callback for Signal attribute. The =
read
> @@ -328,15 +310,10 @@ struct counter_count_write_value {
>   *                     signal_read callback.
>   * @count_read:                optional read callback for Count attribut=
e. The read
>   *                     value of the respective Count should be passed ba=
ck via
> - *                     the val parameter. val points to an opaque type w=
hich
> - *                     should be set only by calling the
> - *                     counter_count_read_value_set function from within=
 the
> - *                     count_read callback.
> + *                     the val parameter.
>   * @count_write:       optional write callback for Count attribute. The =
write
>   *                     value for the respective Count is passed in via t=
he val
> - *                     parameter. val points to an opaque type which sho=
uld be
> - *                     accessed only by calling the
> - *                     counter_count_write_value_get function.
> + *                     parameter.
>   * @function_get:      function to get the current count function mode. =
Returns
>   *                     0 on success and negative error code on error. Th=
e index
>   *                     of the respective Count's returned function mode =
should
> @@ -357,11 +334,9 @@ struct counter_ops {
>                            struct counter_signal *signal,
>                            struct counter_signal_read_value *val);
>         int (*count_read)(struct counter_device *counter,
> -                         struct counter_count *count,
> -                         struct counter_count_read_value *val);
> +                         struct counter_count *count, unsigned long *val=
);
>         int (*count_write)(struct counter_device *counter,
> -                          struct counter_count *count,
> -                          struct counter_count_write_value *val);
> +                          struct counter_count *count, unsigned long val=
);
>         int (*function_get)(struct counter_device *counter,
>                             struct counter_count *count, size_t *function=
);
>         int (*function_set)(struct counter_device *counter,
> @@ -486,19 +461,9 @@ enum counter_signal_value_type {
>         COUNTER_SIGNAL_LEVEL =3D 0
>  };
>
> -enum counter_count_value_type {
> -       COUNTER_COUNT_POSITION =3D 0,
> -};
> -
>  void counter_signal_read_value_set(struct counter_signal_read_value *con=
st val,
>                                    const enum counter_signal_value_type t=
ype,
>                                    void *const data);
> -void counter_count_read_value_set(struct counter_count_read_value *const=
 val,
> -                                 const enum counter_count_value_type typ=
e,
> -                                 void *const data);
> -int counter_count_write_value_get(void *const data,
> -                                 const enum counter_count_value_type typ=
e,
> -                                 const struct counter_count_write_value =
*const val);
>
>  int counter_register(struct counter_device *const counter);
>  void counter_unregister(struct counter_device *const counter);
> --
> 2.23.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
