Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BFE1B1ACD
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDUAg2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgDUAg2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 20:36:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569FC061A0E;
        Mon, 20 Apr 2020 17:36:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j7so2369903pgj.13;
        Mon, 20 Apr 2020 17:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jr4pepYiKfm1uIftVMCmPnL3b+xwADu0/lF4/xhGC1o=;
        b=Asw3NHTwrFrFd3xXUg6KCD3TCt1TknJTW3dnS5o7UGUGYRYsg+W9p/OX+kseROXyQs
         0XeEq89TRm4RPktbiQ8ThmTJIgb2TXEy8RU/TZBYbcJz90pxadmUOPnnnqDxQvGz9kGm
         CdvMnrPvsAbejuIiMuwu4wvYHXP66Bcr8vId9dSGaLyx/kMdbE84jiIAyrXYviiJQKYs
         TtSX82jHkGeJMvjjZYfkk7icp1B/2fJ8mAPU81vdHIjVTlZVbZ3hyUc/EDDcUz1zbz9n
         vNSe5D1WNaR/ZmTIEnuW4YCPVwLKcvPQ6oi5ahXZhuCaKTuQygg1A2fAuPbMde2o0h3M
         0vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jr4pepYiKfm1uIftVMCmPnL3b+xwADu0/lF4/xhGC1o=;
        b=R48UwQBM9NWxi5NgNLBv985Tdt9gy/kJt6aDCF1czsBHh7qtT3OrTMXrEOOSu1yMwJ
         wkmVUfz8bwSaWS6TnDBtO3elGsHMte3Ik1HEuHBV0ktkOWVqliinohLVZrujjXK6olg+
         OCBRGtSakOWl7bl2QZRR761wreE4XR4Qg9MDfJdZ6CY9KEnDG0y+FyOTyfM+hBi72LIi
         GSbXRFsetJ2TKfzHgUFWCqFZvpKiz9jk56GnXUdiWzt4RMlzQb9UxwvR/kIBX7LdMRs5
         C+yDF6W8URYRslDGLOS0pWCFf+kourRp8qggkOjTcjzsTEbC7PsNJCV80eGTpOopXU9p
         KMrg==
X-Gm-Message-State: AGi0PuailcX1bDaDk3Gmxp6SCM/f7Z7/74KCkqruexef8bJHkud2I6Qd
        6pBcrPGOuiSGU/WWlAcquZ9yd8JbYRGRhsYt6cOix4vBBr4=
X-Google-Smtp-Source: APiQypKT5yvxJB+RFskDNTzXkKxM55ZO5RUfYBByOEqqpOcm36wrNLManMQ9TB+l+iztYURHb9Z5VokY+8ZFHID76EI=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr19974359pgb.203.1587429387467;
 Mon, 20 Apr 2020 17:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200420084210.14245-1-m.othacehe@gmail.com> <20200420084210.14245-2-m.othacehe@gmail.com>
In-Reply-To: <20200420084210.14245-2-m.othacehe@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Apr 2020 03:36:15 +0300
Message-ID: <CAHp75Vd+Ri1qKUkDjOV9R4=AW-++7wp4VPfnTqKEHxR7RWzX0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iio: vcnl4000: Factorize data reading and writing.
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

On Mon, Apr 20, 2020 at 11:43 AM Mathieu Othacehe <m.othacehe@gmail.com> wrote:
>
> Factorize data reading in vcnl4000_measure into a vcnl4000_read_block_data
> function. Use it to provide a vcnl4000_read_data function that is able to
> read sensor data under lock. Also add a vcnl4000_write_data function.

...

> +       __be16 buf;
> +       int ret;
> +
> +       ret = i2c_smbus_read_i2c_block_data(data->client,

> +               data_reg, sizeof(buf), (u8 *) &buf);

Why do you need casting?

> +       if (ret < 0)
> +               goto end;

-- 
With Best Regards,
Andy Shevchenko
