Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7565F18B130
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 11:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgCSKYN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 06:24:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37868 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgCSKYN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 06:24:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id f16so878914plj.4;
        Thu, 19 Mar 2020 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3r+VAHql+NP8pG7ZRzCI1tKv/6Ke1R8Od0R0hVXCz4=;
        b=OuLtf1CvxjTW12d4iEIOBP4cT+yNyQ4jW6U1i1yAILpZN2xtuL445eKHtrwDy9o0Fg
         Ck3rGRt1jNxV5Mj1Ligt1lBm6TY+4O4Dzehr7sAStYtFzmAz0pDzJH4CDZfVGoXguJ+z
         BkMXwOlqvpohkTuI3hmL8O9nACqQP7pPqY9BwWZtDHrcLX+T3/mMAe0ODmsDXTYYgcHv
         g4t2ShsrJp3OBJegNBZmCSIwc/kq/qgfx0lu7gPFY9L/HFDM7cIDzmxseg4iMN75dsgL
         Z6w90VKsNG68UliJ8yefBdtcMSyKYjsezaNiOaZAs5P3Ohj6Ym1A/f7cmmjAo6V5yMWk
         O5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3r+VAHql+NP8pG7ZRzCI1tKv/6Ke1R8Od0R0hVXCz4=;
        b=B8ay17Os8l9v0l2Ad5Ps45wStrSg+meMGwxYhEzs0cvn7OWTZgQR27BwAjGV6xBWVJ
         ozZW6oiqI4gaCfziav9KMgJoYugWo/54z+DHVFzhaFYD+iFFibaS6Ss7P8jEC7WeVZwG
         a3/Xc+X9+gFGRLrn5cPMn/RL78nrkFUiQk6CkAR+2zqlOccyji81dm00Vxd1Qxz4nnWT
         sYR5QZywWkPKKQ4YV2GMqi7NCPnVQ4T4uLq8vzgCDi1baWrUnsrMCcUE5lgBflUbd1OL
         gnDO51g274opxRkABgXPZHReAsO/+WYyFiDcZqWgjGcEnjs9wWZn+89q6ytuU/Q9AzsW
         TsGw==
X-Gm-Message-State: ANhLgQ34rHiyeWB84M9eBFkQcWNtSju63yOmn0rj47WHy0zCyqt+LFGU
        pM/GI7jNkormnZ4nNH41MffdsdhnvL3vhPqt1Bk=
X-Google-Smtp-Source: ADFU+vtSQwZTCu2Njzsv2xzB4wNSocYdn1ZQQiF6gB56AeE27bNJyfK+qypfWdy4jN5YrJnS52/hcob4sWOz7z575Ws=
X-Received: by 2002:a17:90a:a48b:: with SMTP id z11mr3147372pjp.1.1584613451888;
 Thu, 19 Mar 2020 03:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <5e730c2f.1c69fb81.9eda3.5c70@mx.google.com>
In-Reply-To: <5e730c2f.1c69fb81.9eda3.5c70@mx.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Mar 2020 12:24:00 +0200
Message-ID: <CAHp75Vf+SA7ptRQRxvMtVfN0MzQeQ_AgzAP7fc3eaT5nmsxo_g@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w interface
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 19, 2020 at 8:10 AM Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
>
> The iio debugfs interface provides direct access to read and write device
> registers if debugfs is enabled.

But regmap API provides at least reading facility. Isn't it enough?

...

>  static const struct iio_info mpu_info = {
>         .read_raw = &inv_mpu6050_read_raw,
>         .write_raw = &inv_mpu6050_write_raw,
>         .write_raw_get_fmt = &inv_write_raw_get_fmt,
>         .attrs = &inv_attribute_group,
>         .validate_trigger = inv_mpu6050_validate_trigger,

> +       .debugfs_reg_access = &inv_mpu6050_reg_access

Leaving comma is helpful for future development.

>  };


-- 
With Best Regards,
Andy Shevchenko
