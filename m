Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB71B926B
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDZRpA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 13:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726152AbgDZRpA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 13:45:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD5CC061A0F;
        Sun, 26 Apr 2020 10:44:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so7652149pfa.1;
        Sun, 26 Apr 2020 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dG4g/Wc27MfoHE4kuPXuXjJcelUNLckZGS9QKVqtQo=;
        b=XORoiASJnnPBgR8HrW3JZMrvpRFgbz2qcclrrIcoxlU/DfDu70ntcgTIN6gn4Gua1r
         EfMr/ulYWzdO2m3f8Am5ZSI2AlRWyk7Z7C4LaDMjqJeTjjg4qokD032uXOJnAUpZc+Cr
         RXdYDpIMFwGfC9y/nlV8Tb7bdj9dIb+vhcpS6K1G6URSOWAwLKz7kM06DtiiBew9t/08
         zUf9y4B+CpAODwPqN9orxw6bb0J6xf7nsAZNKosB6DIuKXeEyTLx4FG4CHx/MQ6D9rj9
         QUXFPvnVnzLB1Fgo6oEzslHM2oUCR9yyqsTb7WOL5/UexCbFaZ+KyZAsfk/FkB/f8fhh
         Samw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dG4g/Wc27MfoHE4kuPXuXjJcelUNLckZGS9QKVqtQo=;
        b=M8ru/IOL8Fa7H1X66DSiB9Loio9Sx0ETSLrPOWVhI7s/f4lKCcUr5boWPJ8B3sag85
         Su2kI4f+Jhe+8uwTn1JmP7gNO44+mPqcdrja979vvWdoiiGSf/sV1r3RSaVpx10AS+E2
         8DO1/5xXOvyJItdi3IjC3XpQ5JD0kpAP9Hi01UFWlnryvTHevAZ6CJLRo+mnm9pp7KJT
         UaQwqAIhg7LYuvIutPhNAzPBDekULty7+ng8NceKmeWBdfHIlipAkQY18g/Zwvvd5ndG
         4XBMjr3OzCT50v1K12dw8SlU2LM6laiGS8mGYP/tSI8bKgYFUBAR2u671IUvP0Wh9wX9
         txgw==
X-Gm-Message-State: AGi0PuaV71FhEZv5Kv27s9q7PFSAwc47VzBoXbsVmQwKUvCktbbmYIYP
        Y7P89kcJdN3kQMy8R+YqaRXvUprRC0DSoxQPe08=
X-Google-Smtp-Source: APiQypJO44KFNM1GFefYxLwrizC37VoBcyLI6pX68R8aPvilpqaTZwGbII5qj5yXqq65lW0i2GZj/7eGnNDeLtCabP4=
X-Received: by 2002:a63:5511:: with SMTP id j17mr18813822pgb.4.1587923098612;
 Sun, 26 Apr 2020 10:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200426110256.218186-1-hdegoede@redhat.com> <20200426110256.218186-4-hdegoede@redhat.com>
In-Reply-To: <20200426110256.218186-4-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Apr 2020 20:44:46 +0300
Message-ID: <CAHp75VfqBGyN5KZW1fZtvCU6GgReDLqcPkWxF4Ovku9n9vdjPA@mail.gmail.com>
Subject: Re: [PATCH 4/8] iio: light: cm32181: Change reg_init to use a bitmap
 of which registers to init
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
> This is a preparation patch for reading some ACPI tables which give
> init values for multiple registers.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/iio/light/cm32181.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index e8be20d3902c..e31c1005b03d 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -26,7 +26,7 @@
>  #define CM32181_REG_ADDR_ID            0x07
>
>  /* Number of Configurable Registers */
> -#define CM32181_CONF_REG_NUM           0x01
> +#define CM32181_CONF_REG_NUM           4
>
>  /* CMD register */
>  #define CM32181_CMD_ALS_DISABLE                BIT(0)
> @@ -53,10 +53,6 @@
>
>  #define SMBUS_ALERT_RESPONSE_ADDRESS   0x0c
>
> -static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
> -       CM32181_REG_ADDR_CMD,
> -};
> -
>  /* CM3218 Family */
>  static const int cm3218_als_it_bits[] = { 0, 1, 2, 3 };
>  static const int cm3218_als_it_values[] = { 100000, 200000, 400000, 800000 };
> @@ -71,6 +67,7 @@ struct cm32181_chip {
>         struct i2c_client *client;
>         struct mutex lock;
>         u16 conf_regs[CM32181_CONF_REG_NUM];

> +       int init_regs_bitmap;

unsigned long

>         int calibscale;
>         int num_als_it;
>         const int *als_it_bits;
> @@ -117,14 +114,17 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>         /* Default Values */
>         cm32181->conf_regs[CM32181_REG_ADDR_CMD] =
>                         CM32181_CMD_ALS_IT_DEFAULT | CM32181_CMD_ALS_SM_DEFAULT;
> +       cm32181->init_regs_bitmap = BIT(CM32181_REG_ADDR_CMD);
>         cm32181->calibscale = CM32181_CALIBSCALE_DEFAULT;
>
>         /* Initialize registers*/
>         for (i = 0; i < CM32181_CONF_REG_NUM; i++) {
> -               ret = i2c_smbus_write_word_data(client, cm32181_reg[i],
> -                       cm32181->conf_regs[i]);
> -               if (ret < 0)
> -                       return ret;
> +               if (cm32181->init_regs_bitmap & BIT(i)) {

for_each_set_bit()

> +                       ret = i2c_smbus_write_word_data(client, i,
> +                                                       cm32181->conf_regs[i]);
> +                       if (ret < 0)
> +                               return ret;
> +               }
>         }
>
>         return 0;
> --
> 2.26.0
>


-- 
With Best Regards,
Andy Shevchenko
