Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16F41E1E98
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbgEZJcK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbgEZJcJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 05:32:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18804C08C5C1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 02:32:09 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c12so11901265lfc.10
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYw+tYM8bbjvDaBrvccyjr1qaeMi6SQMX6gjapj2HjU=;
        b=TomsnslXfXeqB9GzlKe+1oBlCjnhC4HoALX5uKNqKl7rbpXiuL1ra5zpBOFyqWo0K+
         CD4lRHgTX5R0jQs3K66+BdL8W/6xe04fqJSCw3QKKhJR2sNgtJ6HRqSRqu6cQ3VRigx4
         wn9IWMBpzbDzI1vLRzmFF9I8c89YVKwj8dg+VRAcd02ISTSomt4JlggQov9QkA2KTN4r
         Ezcgw1l2966Cjweh5ZyDhZnIdq7w7fqQCSywi6faBZhV1GxjM2EmbPJnsu1wC+pksviW
         nXVaEZeKa3s/B5Uf7rn7Qz2qDyjun9sqoxQOpts+t4wWoIyz8bxayVS1raQ3P5yYa6/m
         fOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYw+tYM8bbjvDaBrvccyjr1qaeMi6SQMX6gjapj2HjU=;
        b=tkHB5/NPN4EeR4MoLRiJcNNWK01r2fjouVdgTaGoPW31ZzQAHWtC2dwOTDMEf3lIsV
         PTtumxwvUdFg9xSf8aHF8zm6aemRG0uFViXjp73GTuVCA1uhOt4YuXnRtseWkYbOkvKq
         dREavDYTgOl5zbAXhxiSXGOG/yqi4T3B0BTHHF9yb1EZrX+ax7zEb3ODDWaik/8etPUj
         QLNIXszfN2basKwohFIEzFy1FiyOtp8Pjk1Bmj3vmZ+/RzWMHQuR+Fm3ESAMbfJsHxOH
         +iMKl87ZEJ4r2U2EgQrKbBLDVi3aXNSaClwTGMzFh+wRUkNK9sWjVt3x3kyhzc3YBoIQ
         VPvw==
X-Gm-Message-State: AOAM532GT7g8Eq7T14WuJbtqB3BOp3LYoFErG8SddPh2b+L4kXNrr3PP
        1YFjVCAvAFvO2gE1CuIubI4PxCwCS7vFsjl2pPx/vA==
X-Google-Smtp-Source: ABdhPJyY8QOc4NQanHGk277urw9P/tSEpFU4FaDnC2qV6MzVnDwh3lf26WEmK3E9rv4KAp3GZLiszj2pR0rS6+2ofT0=
X-Received: by 2002:ac2:414c:: with SMTP id c12mr76335lfi.47.1590485527533;
 Tue, 26 May 2020 02:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200524025117.15679-1-dinghao.liu@zju.edu.cn>
 <CACRpkda9ENYMLZVnTzN2rn9UvsMOWpeDnOhh7zs4ttAJqgipKw@mail.gmail.com> <58a22985.cfec2.1724f66f322.Coremail.dinghao.liu@zju.edu.cn>
In-Reply-To: <58a22985.cfec2.1724f66f322.Coremail.dinghao.liu@zju.edu.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 May 2020 11:31:56 +0200
Message-ID: <CACRpkdYr7mprhK9rdWEfuuwb7hxxc5aS5LZqKf4x5OgMrvh4CQ@mail.gmail.com>
Subject: Re: Re: [PATCH] iio: magnetometer: ak8974: Fix runtime PM imbalance
 on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 26, 2020 at 7:14 AM <dinghao.liu@zju.edu.cn> wrote:
> > On Sun, May 24, 2020 at 4:51 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> > >  disable_pm:
> > > -       pm_runtime_put_noidle(&i2c->dev);
> > >         pm_runtime_disable(&i2c->dev);
> > >         ak8974_set_power(ak8974, AK8974_PWR_OFF);
> >
> > Keep the top pm_runtime_put_noidle().
>
> I found that there was already a pm_runtime_put() before
> iio_triggered_buffer_setup() (just after pm_runtime_use_autosuspend).
> So if we keep the pm_runtime_put_noidle() here, we will have
> two pmusage counter decrement. Do you think this is a bug?

Yes you're right.

What about just moving the pm_runtime_put() until the end
of the initialization? Right before return 0;
Then we can keep this nice goto exits as they are.

Maybe move all these three:

      pm_runtime_set_autosuspend_delay(&i2c->dev,
                                         AK8974_AUTOSUSPEND_DELAY);
        pm_runtime_use_autosuspend(&i2c->dev);
        pm_runtime_put(&i2c->dev);

Yours,
Linus Walleij
