Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A596F1B25D5
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 14:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgDUMWT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 08:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUMWS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 08:22:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96E0C061A10;
        Tue, 21 Apr 2020 05:22:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f8so5193398plt.2;
        Tue, 21 Apr 2020 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8sHt8rACV0yZYLyEpCbUse20aIl7fEUIoxUsoOswD+k=;
        b=ndBQEhgYJd0zICtRgs6Yy/gHJhOtx99YjM4TK0LBPLlYCsmWLAJwk8TcSSr6FtNZPg
         TiHeBhW9XaMym13AhQnMws+4s/5/TDA72yp8R9ebMQmdeQggvpkaEw3mh8kb72ZX1YOO
         d+/koVewepSFYmOG2Q+EhNG+MQfa8zgcdLvxLU3HoDcFfSl1A46l4rdqsQrcQuKtpQ1X
         SNkNePwjuRPsjnMEc8Aqw8VVHPPhb5O31X0igg5S6RoUTt76owjtGITaAMMTimiTAr9l
         LLBHnHN53qJhgduZlWCbpYfcei3wNocFxmH6Sg6IoKV52uiJJzJfIUT3Zo/6IGK/g5Ye
         6XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8sHt8rACV0yZYLyEpCbUse20aIl7fEUIoxUsoOswD+k=;
        b=eLV6Yi6XAaqmVno1mVmg+uZgjMAhQceb8UVvFh+sL4jkLE0jP64qTLK2zvQV6XTbMI
         8WF0AK6gMlk0vMoX8yLzIB9esLOi27+aqrulpm7lRyR48xnLu41l2EXH77e86CPl7/zy
         OpHQpeSnccCzqUHkdMd1a7MZwmxiGY+XEaaz2OCDFckQec8X4hd62bouN1PEw8GX7dks
         nZZLF7PIolmf8IhauDFoT/fwMTiGvQ4nxTqBlxqh6vT8M4Q+MKM/pYoB714JTWilmozI
         w4IZQPkSnUcWKUwpilLLKEjxKJNzjWjYxL9DcxMoBBEfosNzS/L80mzZ881rKcwF5+Y+
         x3mA==
X-Gm-Message-State: AGi0Puack588qPRxo0WO+zSz7VMXNlL2SYhORvajNCQmn8B/pXXFPp6y
        98yqWy8yiZAJiOBsV6ARJBa1XuT158hf9CAYrZCT5tiyusbPtQ==
X-Google-Smtp-Source: APiQypIGo8RVZmRCk9H0kZdzTUbSuVm0vb+/PSzTStmjUoOedvrRMvK+PmcyG4kLaA5OhYCmnzkot1teedX4nROIuUI=
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr5171704pjb.143.1587471738292;
 Tue, 21 Apr 2020 05:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200421075532.19192-1-m.othacehe@gmail.com> <20200421075532.19192-4-m.othacehe@gmail.com>
In-Reply-To: <20200421075532.19192-4-m.othacehe@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Apr 2020 15:22:11 +0300
Message-ID: <CAHp75VcJ300S8r_f2cueYzB0OaLBJK9oJySgz5Jekb7dGFWnCw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 21, 2020 at 10:56 AM Mathieu Othacehe <m.othacehe@gmail.com> wrote:
>
> Add sampling frequency support for proximity data on VCNL4010 and VCNL4020
> chips.

Couple of nitpicks below.

...

> +static const int vcnl4010_prox_sampling_frequency[][2] = {
> +       {1, 950000},
> +       {3, 906250},
> +       {7, 812500},
> +       {16, 625000},
> +       {31, 250000},
> +       {62, 500000},
> +       {125, 0},

> +       {250, 0}

Leave comma here, potentially helpful if it will be extended.

> +};

...

> +static int vcnl4010_write_proxy_samp_freq(struct vcnl4000_data *data, int val,
> +                                         int val2)
> +{
> +       int i;
> +       const int len = ARRAY_SIZE(vcnl4010_prox_sampling_frequency);
> +
> +       for (i = 0; i < len; i++) {
> +               if (val <= vcnl4010_prox_sampling_frequency[i][0])
> +                       break;
> +       }
> +
> +       if (i == len)
> +               return -EINVAL;

I would refactor this

  unsigned int i = ARRAY_SIZE(vcnl4010_prox_sampling_frequency);

  do {
    if (val > vcnl4010_prox_sampling_frequency[i][0])
      break;
  } while (--i);

You won't need to go full array to return error in this case.

> +       return i2c_smbus_write_byte_data(data->client, VCNL4010_PROX_RATE, i);
> +}

-- 
With Best Regards,
Andy Shevchenko
