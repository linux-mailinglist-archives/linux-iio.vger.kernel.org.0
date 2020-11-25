Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE22C3DBC
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 11:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgKYKeA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 05:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgKYKd7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 05:33:59 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58A6C0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 02:33:59 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s63so2072574pgc.8
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlHepVVPOgyhiyzCc+1qhF+4ii1VgfcKlQ98NFeOyZ4=;
        b=rzpKHr6vzTWKnQxuKVYWOnT+b6q+i86sChjfSnvGVfxFCVhrz8FjM5/RLL4lXJ+QZj
         WZQjAAtRUIJ3VJFnqh33kP8JGSWISrxonZi23LqphMIHMELO/1HnsZd4tMuDKp1cxj3f
         Mc3YBOG3IrX+MSPC2aoPipBecPlZ0X7ryawA9IwcEA3SLolcwoO8i1dof0872S/A92QB
         KwuPLlEnRdbWqzd/8Cl7ZKNEqPhgx0Pq13+UpjO3eCD0FR2tNoCmoyvMwX2JoJv19yjM
         CpUp/RCKst81tE4j+QCTL1LH7P+9ASRA3Mar2gFJrCTE2kqdL6jfolSMkBf7YACioc0k
         7+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlHepVVPOgyhiyzCc+1qhF+4ii1VgfcKlQ98NFeOyZ4=;
        b=jIdpFowtaC5KTqQpqOi6Nk0R/6K2ePfJ2EonPkfoJgrs/hBWqYXbrw3vvJJ4RWoQcy
         oJSo5Dp+AIRYcMwgrkjwPFrhDlxZ9yysY4DMT4bRsOq5Yp7rsysNJavtr8LljrsQbQk+
         KhBIXRc8B6LPfKESDeCUJbCtaPL+csjv+JIijePRlcFCPiGb54Q81x6JtJeetQ4zcj6p
         9P5ycNKQbRy6WL/4Q8B3Bvg4lsfyT805oJpBD1EOtjOQqS4Ae3FJ+0QR7hXvzZ05PqIO
         pMh0di2zQXBbm3MOs2O8FmAKA0FkYw+L9V3EPHMu+Cde/sE0lZ7/Tgul74M0ZWXU49Yd
         8pKA==
X-Gm-Message-State: AOAM530cFAyd14U942H7wc3A38qzeVDdSA+tQ9sqZGmlv+oVLo6FhzT7
        +Tjzj9L6buwraASMeh+WmYotFun9iBTiBTgqaO67ewDJuNGMkw==
X-Google-Smtp-Source: ABdhPJzTGq7Rwzti/BKqIO5sWpQSkZYTcQUq36jjYQDqXwNHo0AbTs6KMpDdX2uza2RrQ1GxR2kA2xNK7sYu75zy4C0=
X-Received: by 2002:a62:7e4f:0:b029:18c:9322:739b with SMTP id
 z76-20020a627e4f0000b029018c9322739bmr2526772pfc.7.1606300439183; Wed, 25 Nov
 2020 02:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20201125085444.11593-1-hdegoede@redhat.com> <20201125085444.11593-2-hdegoede@redhat.com>
In-Reply-To: <20201125085444.11593-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 12:34:47 +0200
Message-ID: <CAHp75VfMxzO2Qx_t7mSv+Y_DEN8Y2KYw02No=y=VuBNACtj4zg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: kxcjk1013: Add tablet_mode sysfs file for
 exercising the KIOX010A ACPI DSM
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        russianneuromancer <russianneuromancer@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 10:56 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 KXCJ91008-s
> to allow the OS to determine the angle between the display and the base
> of the device, so that the OS can determine if the 2-in-1 is in laptop
> or in tablet-mode.
>
> On Windows both accelerometers are read by a special HingeAngleService
> process; and this process calls a DSM (Device Specific Method) on the
> ACPI KIOX010A device node for the sensor in the display, to let the
> embedded-controller (EC) know about the mode so that it can disable the
> kbd and touchpad to avoid spurious input while folded into tablet-mode.
>
> Currently the kxcjk1013 driver calls the DSM for this once at probe time
> to ensure that the builtin kbd and touchpad work.
>
> But some users have expressed interest in using this functionality to
> disable the kbd and touchpad when folded into tablet-mode as done under
> Windows.
>
> Add a tablet_mode sysfs file so that users can control the kbd/touchpad
> enable/disable functionality from user-space.

...

> +       err = kiox010a_dsm(&data->client->dev,
> +                          tablet_mode ? KIOX010A_SET_TABLET_MODE :
> +                                        KIOX010A_SET_LAPTOP_MODE);

A nit. With temporary variable it may be slightly better to read, like:

  int value;
  ...
  value = tablet_mode ? KIOX010A_SET_TABLET_MODE : KIOX010A_SET_LAPTOP_MODE);
  err = kiox010a_dsm(&data->client->dev, value);

> +       if (err)
> +               return err;

...

> +               ret = devm_device_add_group(&data->client->dev, &tablet_mode_attrs_group);
> +               if (ret < 0)
> +                       dev_warn(&data->client->dev, "Error creating tablet_mode sysfs attribute\n");

devm is a beast (sometimes). Just to make sure that on removal you
won't have situation when attribute is still there while data it's
accessing to are already gone or garbage.

-- 
With Best Regards,
Andy Shevchenko
