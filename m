Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B7A1DA2FF
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgESUoC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 16:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgESUoB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 16:44:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD20C08C5C0;
        Tue, 19 May 2020 13:44:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so382972plr.0;
        Tue, 19 May 2020 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NKe0dGCLuIFUTSDu/e/oZFqvqubemBEs4EDLcjwgzA=;
        b=i1AE9fbb1/4A3jewEktdiPlEhm44n+aEzpUF/J6C5L/Vmt4RDWpg5l+3XaTGXPR2pA
         jYk5iOBvDHwFMaVrwgNve7m/NAowuc6ceW2X3lcl2kZP59FjRMMXrnp847fkHyPRyzrn
         UhA6HJ+izxCChQA+GOq4qeGv5WoioDVdSyW4BU7HYcc+qrbQW8rRzv+gbAGnSLZSb4f3
         k1WxMhiBEPV33vNC4h/pD9HAg+wyRr2lHno32blg6wWj18WZ9xUxuCONDAezkJyOlUUr
         MaQdqTBwSHwq3ZLdk9dN7iQJxhykm4NGX/Bfnws7VGfXepvQYlrCnwxGW025/zgM08Ul
         jJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NKe0dGCLuIFUTSDu/e/oZFqvqubemBEs4EDLcjwgzA=;
        b=WCslaEhlN1HbhQmSOS3zVK6kWkvaw582VrPQ5o3oQG/Q97mtCJr/wcqgdFug8Ou9Xf
         FMPPafnwyJKMMdjkO6fGTow7whp5nyT/Kksj51dUTgX5n+qInaNsU0cnS8uXSqSuQHJA
         LFNW+4spMBMwKX+wOFZiJGMUqPSVZ8Jv2bCu+JyveakNfmuLSc3YJY42W566yfBukmji
         hXgk2A6i9DLvN6AjlGhN80w0KiG/Hh1WIcl7ww/HPnHjWLbrlgs0exwBsugs+VFNErGr
         b91l4zdzs1cB/mvQhfs6XRmT+rrq9fDdiVtC1Atn5dFHCwkLoDqwFxyT3qO4HCWM6KDf
         K9pQ==
X-Gm-Message-State: AOAM533L0MWHQ8Bv3o0WHvyopBdRpSCsNTNhHoQk31dFA8A58mtn6leR
        /+/eLoZhuPOScsJEKMAQnI9BJEUEVGmKE8siuzQ=
X-Google-Smtp-Source: ABdhPJyhoLKOvXYwlEtqNyJEFcVPhsytjjZvjtEBaBNriSxQfrCm3qrr6XzTUriBFI1NitA6C5nmn1Lg7mL7k2fxWGA=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr1366526pjd.181.1589921041122;
 Tue, 19 May 2020 13:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200517194904.34758-1-contact@artur-rojek.eu> <20200517194904.34758-7-contact@artur-rojek.eu>
In-Reply-To: <20200517194904.34758-7-contact@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 May 2020 23:43:44 +0300
Message-ID: <CAHp75VcChHOrxrqBM==-_SaTL4vSojKmRWvkNn-CHLH99pcAuQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] input: joystick: Add ADC attached joystick driver.
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 17, 2020 at 10:49 PM Artur Rojek <contact@artur-rojek.eu> wrote:
>
> Add a driver for joystick devices connected to ADC controllers
> supporting the Industrial I/O subsystem.

...

> +static int adc_joystick_handle(const void *data, void *private)
> +{
> +       struct adc_joystick *joy = private;
> +       enum iio_endian endianness;
> +       int bytes, msb, val, i;
> +       bool sign;
> +
> +       bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> +
> +       for (i = 0; i < joy->num_chans; ++i) {
> +               endianness = joy->chans[i].channel->scan_type.endianness;
> +               msb = joy->chans[i].channel->scan_type.realbits - 1;

> +               sign = (tolower(joy->chans[i].channel->scan_type.sign) == 's');

Do we need tolower()?

> +
> +               switch (bytes) {
> +               case 1:
> +                       val = ((const u8 *)data)[i];
> +                       break;
> +               case 2:
> +                       if (endianness == IIO_BE)

> +                               val = be16_to_cpu(((const u16 *)data)[i]);

Yeah, you have to provide bitwise types to satisfy sparse.
Maybe using *_to_cpup() will cure this.

> +                       else if (endianness == IIO_LE)
> +                               val = le16_to_cpu(((const u16 *)data)[i]);
> +                       else /* IIO_CPU */
> +                               val = ((const u16 *)data)[i];
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +
> +               val >>= joy->chans[i].channel->scan_type.shift;
> +               if (sign)
> +                       val = sign_extend32(val, msb);
> +               else
> +                       val &= GENMASK(msb, 0);
> +               input_report_abs(joy->input, joy->axes[i].code, val);
> +       }
> +
> +       input_sync(joy->input);
> +
> +       return 0;
> +}

...

> +       /* Count how many channels we got. NULL terminated. */
> +       while (joy->chans[joy->num_chans].indio_dev)
> +               joy->num_chans++;

I don't see how useful this is. Why not simple do below...

> +       bits = joy->chans[0].channel->scan_type.storagebits;
> +       if (!bits || (bits > 16)) {
> +               dev_err(dev, "Unsupported channel storage size");
> +               return -EINVAL;
> +       }
> +       for (i = 1; i < joy->num_chans; ++i)
> +               if (joy->chans[i].channel->scan_type.storagebits != bits) {
> +                       dev_err(dev, "Channels must have equal storage size");
> +                       return -EINVAL;
> +               }

...something like

  for (i = 0; joy->chans[i].indio_dev; i++) {
    bits = joy->chans[i].channel->scan_type.storagebits;
    if (bits ...) {
      ...error handling...
    }
    if (bits != joy->chans[0].channel->scan_type.storagebits) {
      ...second level of error handling...
    }
 }

...

> +static const struct of_device_id adc_joystick_of_match[] = {
> +       { .compatible = "adc-joystick", },

> +       { },

No need comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
