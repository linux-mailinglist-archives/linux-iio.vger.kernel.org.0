Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44682550416
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 12:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiFRK6L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 06:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiFRK6K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 06:58:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8760614D1D;
        Sat, 18 Jun 2022 03:58:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s12so12961033ejx.3;
        Sat, 18 Jun 2022 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QfaOZr1oajPaK5kYlkRNPUIs5UkmJAcy6slBJGoufrY=;
        b=GBPmgmf0nY5UCMcWwEimdRDm31gfSmSqDHuxkNmUa8mSbjohssnXsK3CnEuFQdK+BV
         qdxiFkhkMs/2nGFXqZKz3XI32cYDAiuQYAG3XdSGA1/gjh9QTRx/xmZNiJRO5aXztnY1
         DCSAdT3N0VyhCscr9zmiJ9aVsrFNwLHruOTIYXSmhRcMeveeaRr8e2X0UKVWLR8dbkyB
         NTYKu7+tzykbREzg2cwAn1/ILgaPdJnrsQ5Jud7qq5BeFQRTWSGnji5XH5MR4DWi8ARD
         rTvk66yPjqwFVr44tVRC564WA8FyitRf6feLZ2aGbM/IdXf4sZJCtqf7kXj3iZevjlbe
         PV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfaOZr1oajPaK5kYlkRNPUIs5UkmJAcy6slBJGoufrY=;
        b=r3Szm2Z7Oi3dqrk4nzXMgQFtP9dyL2ojk1IWaM4izLo23TeCMACC9WDRbM+RABoxHC
         NDii9dtm2po7c/aWtdO6ixkrQbYdGgHH+9Bk8vXHWTmwqBDf9NMsCQ7eHVJxJqAAtssP
         T9lx619Dp2fjYl0DTJ0EF2ESetGZOui4eYCDdlMDFQdxEySkOFJ0XWVBpYLoRsznw0/i
         idpG8Rcy0R45Wsyz/4T/3+FNEykhPWKdrD9G8xNFAcBuJmZDc8R1WPAyqeeONHCd3Pql
         viLQVTOZ8BZ2Fh23/DA6r/SAUAlpFyrGaQ3lcaH8Afr62M+UKEz9HFQULXy9YsZkZ+0m
         NZtg==
X-Gm-Message-State: AJIora/6QHrfH1GakIUWM9y4q9f9Os7A3az3yD/m73d2dH4jcqPTIfa+
        /wCCC+uSq3VtwD48iMiudnnLa75Jx06bGluGcx4=
X-Google-Smtp-Source: AGRyM1u9fRzHtbVOuiKwQv7j+A4Rhcl0ZItoF8BhaUMVKxI0HL93RzSk8wI1CjfhstQcJ7zlCrjPNvkXQyKZz97Yf30=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr12973742ejb.639.1655549887912; Sat, 18
 Jun 2022 03:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655509425.git.jahau@rocketmail.com> <3bdb392bb75073bdfe10aab1739fee2d6c64f10c.1655509425.git.jahau@rocketmail.com>
In-Reply-To: <3bdb392bb75073bdfe10aab1739fee2d6c64f10c.1655509425.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Jun 2022 12:57:30 +0200
Message-ID: <CAHp75VdvNMu=U8me4J4pD3AUCxaVaVC6fk-SZUsgTHt5ya+kkA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] iio: magnetometer: yas530: Add YAS537 variant
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 18, 2022 at 2:15 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This adds support for the magnetometer Yamaha YAS537. The additions are based
> on comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 [2].
>
> In the Yamaha YAS537 Android driver, there is an overflow/underflow control
> implemented. For regular usage, this seems not necessary. A similar overflow/
> underflow control of Yamaha YAS530/532 Android driver isn't integrated in the
> mainline driver. It is therefore skipped for YAS537 in mainline too.
>
> Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537()
> function, a measurement is saved in "last_after_rcoil". Later on, this is
> compared to current measurements. If the difference gets too big, a new
> reset is initialized. The difference in measurements needs to be quite big,
> it's hard to say if this is necessary for regular operation. Therefore this
> isn't integrated in the mainline driver either.

...

> -/* These variant IDs are known from code dumps */

Not sure why this change
a) is here (means maybe you need to move the comment somewhere else?);
b) done at all (means maybe this comment is still actual?).

...

>         case IIO_CHAN_INFO_RAW:
>                 pm_runtime_get_sync(yas5xx->dev);
> -               ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
> +               switch (yas5xx->devid) {
> +               case YAS530_DEVICE_ID:
> +               case YAS532_DEVICE_ID:
> +                       ret = yas530_532_get_measure(yas5xx, &t, &x, &y, &z);
> +                       break;
> +               case YAS537_DEVICE_ID:
> +                       ret = yas537_get_measure(yas5xx, &t, &x, &y, &z);
> +                       break;
> +               default:
> +                       dev_err(yas5xx->dev, "unknown device type\n");

> +                       return -EINVAL;

Can't return here, because you leave the PM counters imbalanced.

> +               }
>                 pm_runtime_mark_last_busy(yas5xx->dev);
>                 pm_runtime_put_autosuspend(yas5xx->dev);

...

>                         /*
> -                        * Raw values of YAS532 are in nanotesla. Divide by
> -                        * 100000 (10^5) to get Gauss.
> +                        * Raw values of YAS532 and YAS537 are in nanotesla.
> +                        * Divide by 100000 (10^5) to get Gauss.
>                          */

Be consistent (you used milli degress above, I would suggest to use
millidegrees to have it aligned with this comment spelling style).

...

> +       switch (yas5xx->devid) {
> +       case YAS530_DEVICE_ID:
> +       case YAS532_DEVICE_ID:
> +               ret = yas530_532_get_measure(yas5xx, &t, &x, &y, &z);
> +               break;
> +       case YAS537_DEVICE_ID:
> +               ret = yas537_get_measure(yas5xx, &t, &x, &y, &z);
> +               break;
> +       default:
> +               dev_err(yas5xx->dev, "unknown device type\n");

> +               return;

Same issue with PM counters.

> +       }
>         pm_runtime_mark_last_busy(yas5xx->dev);
>         pm_runtime_put_autosuspend(yas5xx->dev);

...

> +       switch (yas5xx->devid) {
> +       case YAS530_DEVICE_ID:
> +       case YAS532_DEVICE_ID:
> +               if (reg == YAS530_532_ACTUATE_INIT_COIL ||
> +                   reg == YAS530_532_MEASURE)
> +                       return true;
> +               break;
> +       case YAS537_DEVICE_ID:
> +               if (reg == YAS537_MEASURE)
> +                       return true;
> +               break;
> +       default:
> +               dev_err(yas5xx->dev, "unknown device type\n");
> +               break;

> +               /* fall through */

What does this mean?

It seems here you may actually to return directly.

> +       }
> +
> +       return false;

...

> +       /* Writing SRST register, the exact meaning is unknown */

Wild guess: Software ReSeT (SRST). Would explain why it should be done
before calibration.

> +       /* Sanity check, is this all zeroes? */
> +       if (!memchr_inv(data, 0x00, 16)) {
> +               if (FIELD_GET(GENMASK(5, 0), data[16]) == 0)
> +                       dev_warn(yas5xx->dev, "calibration is blank!\n");
> +       }

  if (a) {
    if (b) {
      ...
    }
  }

===>

  if (a && b) {
    ...
  }

...

> +       case YAS537_VERSION_0:

> +

Redundant blank line.

> +               /*
> +                * The first version simply writes data back into registers:
> +                *
> +                * data[0]  YAS537_MTC          0x93
> +                * data[1]                      0x94
> +                * data[2]                      0x95
> +                * data[3]                      0x96
> +                * data[4]                      0x97
> +                * data[5]                      0x98
> +                * data[6]                      0x99
> +                * data[7]                      0x9a
> +                * data[8]                      0x9b
> +                * data[9]                      0x9c
> +                * data[10]                     0x9d
> +                * data[11] YAS537_OC           0x9e
> +                *
> +                * data[12] YAS537_OFFSET_X     0x84
> +                * data[13] YAS537_OFFSET_Y1    0x85
> +                * data[14] YAS537_OFFSET_Y2    0x86
> +                *
> +                * data[15] YAS537_HCK          0x88
> +                * data[16] YAS537_LCK          0x89
> +                */

> +

Ditto.

> +               for (i = 0; i < 17; i++) {
> +                       if (i < 12) {
> +                               ret = regmap_write(yas5xx->map,
> +                                                  YAS537_MTC + i,
> +                                                  data[i]);
> +                               if (ret)
> +                                       return ret;
> +                       } else if (i < 15) {
> +                               ret = regmap_write(yas5xx->map,
> +                                                  YAS537_OFFSET_X + i - 12,
> +                                                  data[i]);
> +                               if (ret)
> +                                       return ret;
> +                               yas5xx->hard_offsets[i - 12] = data[i];
> +                       } else {
> +                               ret = regmap_write(yas5xx->map,
> +                                                  YAS537_HCK + i - 15,
> +                                                  data[i]);
> +                               if (ret)
> +                                       return ret;
> +                       }
> +               }
> +
> +               break;

> +

Ditto.

...

> +       case YAS537_VERSION_1:

As per above.

...

> +       case YAS532_DEVICE_ID:

> +

Redundant blank line.

> +               if (yas5xx->devid == YAS530_DEVICE_ID) {
> +                       ret = yas530_get_calibration_data(yas5xx);
> +                       if (ret)
> +                               goto assert_reset;
> +                       dev_info(dev, "detected YAS530 MS-3E %s",
> +                                yas5xx->version ? "B" : "A");
> +                       strncpy(yas5xx->name, "yas530", sizeof(yas5xx->name));

strscpy()

> +               } else {
> +                       ret = yas532_get_calibration_data(yas5xx);
> +                       if (ret)
> +                               goto assert_reset;
> +                       dev_info(dev, "detected YAS532/YAS533 MS-3R/F %s",
> +                                yas5xx->version ? "AC" : "AB");
> +                       strncpy(yas5xx->name, "yas532", sizeof(yas5xx->name));

strscpy()

> +               }

...

> -               strncpy(yas5xx->name, "yas530", sizeof(yas5xx->name));

Okay, strncpy() -> strscpy() perhaps in the separate patch.

> +       case YAS537_DEVICE_ID:
> +               ret = yas537_get_calibration_data(yas5xx);
> +               if (ret)
> +                       goto assert_reset;
> +               dev_info(dev, "detected YAS537 MS-3T version %s",
> +                        yas5xx->version ? "1" : "0");
> +               strncpy(yas5xx->name, "yas537", sizeof(yas5xx->name));

strscpy()

...

>                 break;
> +
>         default:

Unneeded change.

-- 
With Best Regards,
Andy Shevchenko
