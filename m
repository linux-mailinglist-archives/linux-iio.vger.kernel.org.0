Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8711B925F
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDZRnq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 13:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726156AbgDZRnq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 13:43:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28EEC061A0F;
        Sun, 26 Apr 2020 10:43:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so6418140pfv.8;
        Sun, 26 Apr 2020 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rt8GUdb+NK0I2GLuxT6jzzSLX3k/QT9d+BbEeLX7M/8=;
        b=oAww4nbwiOwJa3AnN+BW6YViVNjnWjuz1v+e79bX1TEqOWxRMKjzI0Lg8EuX58DxPv
         BaiP1atY82h2uwvlz8ZIFIYRnrxM1hKy8un6TruMv+vWSl/tjQNoATQ899R+m8/fc5wM
         Fhb61/ckFlyL8pcJMXH2UXnDk5KQ6WNBSzJYB9gb9OWo8IwfunUQ0ykpU+T/EqNJIWSg
         8KkJHz8pneblijJXdckdaTW5k/tujhj5Ca9oD0qmjVstRGUWx8sqss7jgHXiERypca8n
         f1tIgwYXZ4ixMsXrgMNrCwzKjku5qiA447R34qrkxA6dJlzpH7jbezrgi5cen91ILRmH
         jGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rt8GUdb+NK0I2GLuxT6jzzSLX3k/QT9d+BbEeLX7M/8=;
        b=JzOcXX5k+CZyG+XQyV0AohmFU10dA5OBas/FT7ZWPMn7PsadjVVpEqUzD8xShFl2Lq
         xVuCAHbxUXDJ+F9TbV3OVinnjUCbmNEcqSqMLaoydOIwxItFKBZkWg7d4N1aFXrrLUho
         JkPjgZ05oFZ41v++9QTg0aLkyNDl+vWEFXcuz3l0MdhaB16Bmla2eocWWlJAyElSwplF
         ZLhIga6wzuQe+7ZNfLDBXbTzsdMzJUu0X0wCescZjyGxa1eSA53x+J+p3I8GLXtiUIq9
         B7LUcPQxEgJoQ+Ebtf9cPtzHtuQf/SkMpaP2be/l/8xeQEPulN/Sq6Uw+Nu0jnH3PU35
         Lb1Q==
X-Gm-Message-State: AGi0PubyjRpl1gAoMaUQq5rOiOfsfRsSqQXlGeAZHkSsZjMTJyHDZEdN
        L/FHthWKBYSsyQeFkzcUd2LXFuAGCY5P50NgkFo=
X-Google-Smtp-Source: APiQypLHROrKSegIPV4KGfP7cRTWUsVaUDA24uRQRvLT5mX/USml0FUmdqrJLTO/mMb2xeWemvIthlBhFYlVkb4LR34=
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr20431103pfr.36.1587923024164;
 Sun, 26 Apr 2020 10:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200426110256.218186-1-hdegoede@redhat.com> <20200426110256.218186-3-hdegoede@redhat.com>
In-Reply-To: <20200426110256.218186-3-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Apr 2020 20:43:32 +0300
Message-ID: <CAHp75VezxOatMRyLa8DQEYOK=QT8RgD3ET_kqDp+tL9q9fJw1g@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: light: cm32181: Handle ACPI instantiating a
 cm32181 client on the SMBus ARA
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 26, 2020 at 2:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some ACPI systems list 2 I2C resources for the CM3218 sensor. On these
> systems the first I2cSerialBus ACPI-resource points to the SMBus Alert
> Response Address (ARA, 0x0c) and the second I2cSerialBus ACPI-resource
> points to the actual CM3218 sensor address.
>
> From the ACPI/x86 side devices with more then 1 I2cSerialBus ACPI-resource
> are handled by the drivers/platform/x86/i2c-multi-instantiate.c code.
> This code will instantiate "cm32181" i2c_client-s for both resources.
>
> Add a check to cm32181_probe() for the client's address being the ARA
> address, and in that case fail the probe with -ENODEV.
>
> On these ACPI systems the sensor may have a SMBus Alert asserted at boot,
> if this is the case the sensor will not respond to any i2c_transfers on
> its actual address until we read from the ARA register to clear the Alert.
>
> Therefor we must (try to) read a byte from the client with the ARA
> register, before returning -ENODEV, so that we clear the Alert and when
> we get called again for the client instantiated for the second
> I2cSerialBus ACPI-resource the sensor will respond to our i2c-transfers.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/iio/light/cm32181.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index fd371b36c7b3..e8be20d3902c 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -51,6 +51,8 @@
>  #define CM32181_CALIBSCALE_RESOLUTION  1000
>  #define MLUX_PER_LUX                   1000
>
> +#define SMBUS_ALERT_RESPONSE_ADDRESS   0x0c
> +
>  static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
>         CM32181_REG_ADDR_CMD,
>  };
> @@ -333,6 +335,20 @@ static int cm32181_probe(struct i2c_client *client,
>         struct iio_dev *indio_dev;
>         int ret;
>
> +       /*
> +        * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
> +        * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
> +        * drivers/platform/x86/i2c-multi-instantiate.c instantiates "cm32181"

> +        * i2c_client-s for both resources, ignore the ARA client.

A nit: 'I2C clients'

> +        * On these systems the sensor may have a SMBus Alert asserted at boot,
> +        * in that case the ARA must be read to clear the Alert otherwise the
> +        * sensor will not respond on its actual I2C address.
> +        */
> +       if (client->addr == SMBUS_ALERT_RESPONSE_ADDRESS) {
> +               i2c_smbus_read_byte(client);
> +               return -ENODEV;
> +       }
> +
>         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
>         if (!indio_dev) {
>                 dev_err(&client->dev, "devm_iio_device_alloc failed\n");
> --
> 2.26.0
>


-- 
With Best Regards,
Andy Shevchenko
