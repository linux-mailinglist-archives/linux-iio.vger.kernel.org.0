Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC05585A3D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jul 2022 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiG3LdU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jul 2022 07:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiG3LdT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jul 2022 07:33:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0DB2496F;
        Sat, 30 Jul 2022 04:33:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id tk8so12509659ejc.7;
        Sat, 30 Jul 2022 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VvYg/CL1I3r8dHS3x/B2hatcu1jC3itrUA2DHNmFFd4=;
        b=mWO91qiHEvCEjEuIS1mWxJOHRz5CQt4du4H+AJyyxZWoDto9z7/g1KdikUv3gVtcIR
         YJhfi9OAx9+MAyVtgsCYrz6MWZX3tBGfcdLNyMxrC9JkySyjsnx8kUPDhyxzcX/AuVoh
         TnX3b25uCTl8kNx5TRiyIBm6JRQxwjrhVz9bl2g/vLn+pYBycEOm6xTx9otbDX+32FTY
         FZnONJW2kB63Ub1U5NABobYsaHVyNzSlCtl7FoN/6IwHoMwULdaZY3oJWrM89rzU8ZeU
         ctduW+4nFrhu1V6hEIh9ROhI4ahz1VOsMmkyIEaLHXjva+oSc8OicUvIVgIVcFysXEFS
         KKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VvYg/CL1I3r8dHS3x/B2hatcu1jC3itrUA2DHNmFFd4=;
        b=8O5P3nrgp5SApfiafieaOeHa3vaqCKXg/WFaT6/q9uerVe8WJGmwhYVKtzJ0oONJVv
         sJP0JarvEM/wHZoXM8+k6CwOfmE1zFUcm83qjJFNx8xQvG8MM8C0CXLkNmxKxK4B5vzx
         j/DYcb9guBIzZIeTrBYIeRZlSfJ9kvJDYGLMAOSioQEbY+ddAcPr0PRA5mF8pvkVYmZb
         3l5AjqrD65F02RMnr6JLk7ShF5KilHSnwOhpIgG88xu1Z+zQrzmHQdILR1jZDzRhBB60
         vfJsWVds/JDGvJ15Sngo+fMez3yareowcv17VH3phjZyylUpw8Uszn3M9YuwxYUvNrEJ
         iPlQ==
X-Gm-Message-State: AJIora8DUspmYN8WQ2DPK37rC8lm+dPRu5nVf4Fcdfa9oxcVI7qtMbEH
        NAx0jWDLOKjDdpT9lac5VJ6AEoF084tIyuA46MI=
X-Google-Smtp-Source: AGRyM1u3kTIFffjaneKqov0bWZAXQtBgZ7FyoMRx9I+4ygtJlriDYUctxrr3OgNnUpaCEI2EiIXnnVlv4toDKxzowWA=
X-Received: by 2002:a17:907:2dab:b0:72f:f7:bdd6 with SMTP id
 gt43-20020a1709072dab00b0072f00f7bdd6mr6184496ejc.330.1659180797115; Sat, 30
 Jul 2022 04:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <69a512cf5b62b34415d5983a6406c3d5ba438a1d.1656883851.git.jahau@rocketmail.com>
 <CAHp75Ve5Z9OOx94FtXY77_Fwkp27D32Hn7bAG+Da++HXmupytA@mail.gmail.com>
 <c5643cee-8491-3fae-b9d4-ac03d86c1e8a@rocketmail.com> <CAHp75VdDdKo7rt+cik4J+_4tDRgBXhgZYc8p+dOSH4s_gtCOUg@mail.gmail.com>
 <6e13daf2-179f-d37f-ace4-db5cd37be8d3@rocketmail.com> <CAHp75VdLBowZ7=6g4aFVr5zkN5Pkv7ir68vPCdkRmoFysqRz9Q@mail.gmail.com>
 <f8071532-14c5-c2a8-ca75-f4327066817b@rocketmail.com>
In-Reply-To: <f8071532-14c5-c2a8-ca75-f4327066817b@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jul 2022 13:32:40 +0200
Message-ID: <CAHp75VcPMZSpDS_S_4mM2bfq4154HVMHzZHvdJnP6oUA7RtpiQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] iio: magnetometer: yas530: Add YAS537 variant
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 30, 2022 at 1:10 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 29.07.22 19:24, Andy Shevchenko wrote:
> > On Fri, Jul 29, 2022 at 1:13 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> >> On 27.07.22 19:46, Andy Shevchenko wrote:

...

> >> We don't know for sure whether it is a 16-bit register or an incomplete
> >> register naming.
> >
> > By the values you write into it seems to be a __be16 calibration
> > register. The value to write is 0x3f8 which might ring a bell to you
> > if you know what other values related to ADC.
>
> Sigh, ok, I'll apply bulk write.
>
> How to do it correctly? I guess:
>
>         __be16 buf = cpu_to_be16(GENMASK(9, 3));

Looks like that, yes.

>         ret = regmap_bulk_write(yas5xx->map, YAS537_ADCCAL, &buf, 2);

sizeof(buf)

>         if (ret)
>                 return ret;
>
> The whole block would then look like:
>
>         /* Writing ADCCAL and TRM registers */
>         __be16 buf = cpu_to_be16(GENMASK(9, 3));

(Taking into account that definitions are at the top of the function it would be

  __be16 buf;
  ...
  buf = cpu_to_be16(...);

>         ret = regmap_bulk_write(yas5xx->map, YAS537_ADCCAL, &buf, 2);
>         if (ret)
>                 return ret;
>         ret = regmap_write(yas5xx->map, YAS537_TRM, GENMASK(7, 0));
>         if (ret)
>                 return ret;

...

> > To the 4100 denominator:
> > https://github.com/XPerience-AOSP-Lollipop/android_kernel_wingtech_msm8916/blob/xpe-11.1/drivers/input/misc/yas_mag_drv-yas537.c#L235,
> > seems you can find a lot by browsing someone's code and perhaps a Git
> > history.
>
> I've seen that comment before but I don't understand its meaning.

It points out that there is a SMPLTIM, which I decode as Sample Time,
which is in 4.1 msec steps (up to 255 steps).

...

> >> Still I didn't get your comment. Is your intention to change the "50
> >> milliseconds * 1000" to "50000 microseconds" in the define?
> >>
> >> It would look like ...
> >>
> >>         #define YAS537_DEFAULT_SENSOR_DELAY_US  50000
> >>
> >> ... though I would prefer to keep current define, as it is implemented
> >> now and stated above:
> >>
> >>         #define YAS537_DEFAULT_SENSOR_DELAY_MS  50
> >
> > No, just to show in the actual calculation that you convert MS to US
> > using MILLI.
>
> Sorry, I still don't get what you want me to do. What do you mean by
> "using MILLI", can you elaborate?

You use formula x * 1000 to convert milliseconds to microseconds. My
suggestion is to replace 1000 with MILLI which adds information about
exponent sign, i.e. 10^-3 (which may be important to the reader).

-- 
With Best Regards,
Andy Shevchenko
