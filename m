Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35629607678
	for <lists+linux-iio@lfdr.de>; Fri, 21 Oct 2022 13:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJULuq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Oct 2022 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJULup (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2022 07:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5728A24C95C
        for <linux-iio@vger.kernel.org>; Fri, 21 Oct 2022 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666353042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unK0JFZaYWpSWhHlDOeKYpNlZPKsuoMeZN5FEPPhxEY=;
        b=SDCbg6V1ZKklHk6KrThQi4YZTug13Gx2cY58378Om+jqtMXiCpJNseVfytl4+RrknhdFwp
        AVEqM4tyKXgryk6sKwHKL7uUxMAQoHx6agE7bkDJd7ar672py2By7+gohwbaL4O3ihJzb5
        b6nWiD1rbftbq8SwNbrGWHJSDdCwYDA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-XBof6D8mOiSRvWbRJxzojQ-1; Fri, 21 Oct 2022 07:50:40 -0400
X-MC-Unique: XBof6D8mOiSRvWbRJxzojQ-1
Received: by mail-lj1-f197.google.com with SMTP id m3-20020a2e9103000000b0026fbdbe4437so932740ljg.13
        for <linux-iio@vger.kernel.org>; Fri, 21 Oct 2022 04:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unK0JFZaYWpSWhHlDOeKYpNlZPKsuoMeZN5FEPPhxEY=;
        b=G5hlroO508bkd+HF4EQ5HHLS5hgyWAOTH7d8xHE64Y8hJOQ1UvkUddek4qMDKtaPDD
         xkV/046lUQq6mA/IoEsLDwNW5ZHczsG/8BqhSVvRFh7pZ7HsgyMCYnBaLwHBOnJZQ0Em
         lPO/DNbfPAwsZbIrHds6i/h9RDi/7R3TYBFnrBn9zq9L+i2di5/7b7g0OYRMHEOz/9T7
         gQktzFUDmP+EpqTEPul0dgnJzfHTxt7a54VgTfSI/D+Bb/wZyagIFr5fjo+57y5NNgzn
         +Tobqq9o0bAvmbESHllDe630gxw6UQwE5IMgQMEJMpBQWx6IlMg0WE/pSd1lW4q6+Ao4
         awdA==
X-Gm-Message-State: ACrzQf3XNaJtTeTAa4BJju4egvwccHKp/VDhVNAts/Jo1XNKeWzGcuav
        enjXiYrZVkUBCXbe9QpP1TL1TGpcOddWLEt7AMNAYzJlbwHuYUlo10NnloXjqp8oxjchIHQ3k6H
        5vKWEK6j9rZNrbDtHiPPT0vEuLfPG2FgHvn59
X-Received: by 2002:ac2:4948:0:b0:4a2:47f7:2948 with SMTP id o8-20020ac24948000000b004a247f72948mr6985869lfi.630.1666353039180;
        Fri, 21 Oct 2022 04:50:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6DDkTs8TrSOGDiGJntYAkMf3UcCUWzzgYKzDEAxHJ6pybPXSI7SjbP8y4Dj2uQJ+a16hw93JRt3PRxDFlc4qE=
X-Received: by 2002:ac2:4948:0:b0:4a2:47f7:2948 with SMTP id
 o8-20020ac24948000000b004a247f72948mr6985853lfi.630.1666353038878; Fri, 21
 Oct 2022 04:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221001005208.8010-1-matt.ranostay@konsulko.com> <20221001005208.8010-3-matt.ranostay@konsulko.com>
In-Reply-To: <20221001005208.8010-3-matt.ranostay@konsulko.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 21 Oct 2022 13:50:26 +0200
Message-ID: <CAO-hwJKzUaJ3V6cdX3geyRM7QxHL0LXgz=o5-J39fyO-vk7OCg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] HID: mcp2221: change 'select GPIOLIB' to imply
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     jic23@kernel.org, gupt21@gmail.com, jikos@kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 1, 2022 at 2:52 AM Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> To avoid recursive dependencies on GPIOLIB when 'imply IIO' is requested
> with other drivers we should switch GPIOLIB to an imply.
>
> This isn't the most ideal solution but avoids modifiying the Kconfig for
> other drivers, and only requires a singular IS_REACHABLE(CONFIG_GPIOLIB)
> check.
>
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/hid/Kconfig       | 2 +-
>  drivers/hid/hid-mcp2221.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 185a077d59cd..745fc38794ad 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1252,7 +1252,7 @@ config HID_ALPS
>  config HID_MCP2221
>         tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
>         depends on USB_HID && I2C
> -       depends on GPIOLIB
> +       imply GPIOLIB
>         help
>         Provides I2C and SMBUS host adapter functionality over USB-HID
>         through MCP2221 device.
> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index 4d10a24e3e13..fb54f1c6fd9c 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
> @@ -915,9 +915,11 @@ static int mcp2221_probe(struct hid_device *hdev,
>         mcp->gc->can_sleep = 1;
>         mcp->gc->parent = &hdev->dev;
>
> +#if IS_REACHABLE(CONFIG_GPIOLIB)
>         ret = devm_gpiochip_add_data(&hdev->dev, mcp->gc, mcp);
>         if (ret)
>                 return ret;
> +#endif

Hi Matt,

This patch actually breaks my CI because devm_gpiochip_add_data() is
not the only one function that should be protected against
CONFIG_GPIOLIB.

I am getting:
---
ERROR: modpost: "gpiochip_get_data" [drivers/hid/hid-mcp2221.ko] undefined!
---

Can you also protect gpiochip_get_data() and make sure that the driver
is not completely buggy after? I assume a simple #if around all of the
calls will be worse than the current non compiling situation.

Cheers,
Benjamin

>
>         return 0;
>  }
> --
> 2.37.2
>

