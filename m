Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693BE1A6D20
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 22:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgDMUU5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388255AbgDMUU4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 16:20:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD79C0A3BDC;
        Mon, 13 Apr 2020 13:20:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m16so3811313pls.4;
        Mon, 13 Apr 2020 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhP8togHEFOdKrEhVMamW4MRO722aEfkopEuZNN/wOI=;
        b=muwUYuehGhzwsgmvrzKmt4pgdN4QkY+03DonmZB9ONRyVR3wLUNGv4QmN/mlS95AEP
         QAKBUY6ZVRYMN3mCDf9Px0fpWYYsN1ivAllgSX9ZhTZs48PYiSoWvq7Mr+hroAmUXZRK
         jdZXh8S9NsD5Vplx6KHkljE4S/P7mXMfpMo2RPcoI0e6B8wc9jH2YsllR1gE3YagnZAn
         RDeCSxaduKyp8Lhog0moA43DdJxf7LZCA2Z4qpOX3AE1M0b8vm0x8GfnTVKXocWyZaZo
         GMSy45tMweLjHjzteh/dZH+XEqx9wNuF9/i7SvczCMvF6nLN4AVzxvb3tcQKoDsAMlKR
         fP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhP8togHEFOdKrEhVMamW4MRO722aEfkopEuZNN/wOI=;
        b=Ou8RE0ix9xzA3+FZwBx8+gA78GwO9Oo8P//hCVAr1p85EUuJxC6NiQVf96p4n5zwpi
         J/3gLw272faInCAeabAT1dAvqOZSS1zNUOo2YihFpBrjnVUqpvcm8VMCHBZiwXaQQGW4
         C12q6zZOmuHhVjsHhtjSYDbqsnbWxPr5vBPrkh5vVccjIGR5YhYsps5/q7vIVtty7Xq/
         nvHvssfCcoeSYjrHD+BGf71LI2XsM8KsKbPFXzWBdH+uonShRblY+ID4QmjUt6HwB8Vq
         vB7jbJGl5VhWps7RFnR0Com7mhM8P47TjYTtg8Qz9t5LMR6fotBcw+hw/p5SyuGjVfNg
         VrUw==
X-Gm-Message-State: AGi0PuYVmreznnVuPyEq9VrevwpB8Fm7bUoj4glZgoFNWGYioefPnVUY
        CPNr16t+mEcos6ZKtkPmYF6jKNTwNUc05PL1tBE=
X-Google-Smtp-Source: APiQypIgRVIiNAo/CmIcX7f33PN0CQ9kB3cxHtZlVhBp3gUUznxaxkngllL8DZt3NoX6LOk97BucPhJbTgIWavQIXAM=
X-Received: by 2002:a17:902:5985:: with SMTP id p5mr14336982pli.262.1586809254098;
 Mon, 13 Apr 2020 13:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200412183658.6755-1-mani@kernel.org> <20200412183658.6755-3-mani@kernel.org>
In-Reply-To: <20200412183658.6755-3-mani@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Apr 2020 23:20:42 +0300
Message-ID: <CAHp75VdCK26wXiw0c=1fc0vKsea4w=tthCBrroLOqqaDbwuMVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: chemical: Add support for external Reset and
 Wakeup in CCS811
To:     mani@kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, narcisaanamaria12@gmail.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 8:34 AM <mani@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <mani@kernel.org>
>
> CCS811 VOC sensor exposes nRESET and nWAKE pins which can be connected
> to GPIO pins of the host controller. These pins can be used to externally
> release the device from reset and also to wake it up before any I2C
> transaction. The initial driver support assumed that the nRESET pin is not
> connected and the nWAKE pin is tied to ground.
>
> This commit improves it by adding support for controlling those two pins
> externally using a host controller. For the case of reset, if the hardware
> reset is not available, the mechanism to do software reset is also added.
>
> As a side effect of doing this, the IIO device allocation needs to be
> slightly moved to top of probe to make use of priv data early.

...

> +#define CCS811_SW_RESET                0xFF


> +       reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> +                                            GPIOD_OUT_LOW);
> +       if (IS_ERR(reset_gpio)) {
> +               dev_err(&client->dev, "Failed to acquire reset gpio\n");

> +               return -EINVAL;

Do not shadow actual error code.

> +       }
> +
> +       /* Try to reset using nRESET pin if available else do SW reset */
> +       if (reset_gpio) {
> +               gpiod_set_value(reset_gpio, 1);
> +               usleep_range(20, 30);
> +               gpiod_set_value(reset_gpio, 0);
> +       } else {

> +               static const u8 reset_seq[] = {
> +                       0xFF, 0x11, 0xE5, 0x72, 0x8A,
> +               };

Is 0xFF here is CCS811_SW_RESET? If so, can you put it explicitly?

> +               ret = i2c_smbus_write_i2c_block_data(client, CCS811_SW_RESET,
> +                                            sizeof(reset_seq), reset_seq);
> +               if (ret < 0) {
> +                       dev_err(&client->dev, "Failed to reset sensor\n");
> +                       return ret;
> +               }
> +       }

...

> +       data->wakeup_gpio = devm_gpiod_get_optional(&client->dev, "wakeup",
> +                                                   GPIOD_OUT_HIGH);
> +       if (IS_ERR(data->wakeup_gpio)) {
> +               dev_err(&client->dev, "Failed to acquire wakeup gpio\n");

> +               return -EINVAL;

Ditto.

> +       }

-- 
With Best Regards,
Andy Shevchenko
