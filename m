Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F076050A1C9
	for <lists+linux-iio@lfdr.de>; Thu, 21 Apr 2022 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388979AbiDUOLA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Apr 2022 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388941AbiDUOK5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Apr 2022 10:10:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0213AA67
        for <linux-iio@vger.kernel.org>; Thu, 21 Apr 2022 07:08:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w1so8918026lfa.4
        for <linux-iio@vger.kernel.org>; Thu, 21 Apr 2022 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZKj1C/7IWF1iYJGVivOJHvLTfKPwwnbxFO7kqmcYXc=;
        b=VVH2HU+P5/bdjm7H3wzAdQ7BcWbgJCF7v1P82ysb8AVZD3iccsTHzkFCl8Y/gMyyBl
         qPbuNS8l4NofUrpKlHZ8maQ+cDnVSeKdOdR57Eujj79fMAkNWAmnuY3kE0AC86rXN3uj
         eTSAqUDNMsVZoAtc1ZBbeRlRtzOT+2rF/wZlnYOzxRmj/AIQgvBrba3TaAG6t90YVqI/
         P+rI4f1hCrPlbWZP2vjCOsIxACq1zH/0UT1K8dXDNPHGBGqFC1w1DuiP1icoaXrBNjyS
         ERYqfURAbUs0JEAKRxF8EMGd5dNnQJcLngybujXSNP9rgYZ4jIudsK8WAbSPXmjjKaWx
         y9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZKj1C/7IWF1iYJGVivOJHvLTfKPwwnbxFO7kqmcYXc=;
        b=PFL8s+XdO0GU8x0roHMjmv7c9NNuNjipGGu5sMICd5+QYOI2q8LY8s+oaTHJyfO9+X
         k9+wEpfRNSR4Lt4H8G7Vu9/x/Q7pJv5M9L7HoBlcy+/4RGx274TJjxw+Sidto/+VzccH
         mAs0ygtyLbz2iBtJa3KGkem7Z/AnJxjez1CDsLBVQLVjtVggLoYEK6FHuWw4hM2YXK4X
         e8oChCW2KzURjH4Cd9JlaOEDOkvd5+joall2hgw/PW5bjBH1WjmcsB+p2KoAWefU3zCW
         6X7fzSCF0XQ5VvwfDJjDS/7zqsg0sx/xhWj/lsXKgQHXYyi0fAx2Bwj3G3RxOQ3IVgZe
         BNiQ==
X-Gm-Message-State: AOAM530ceEGQiPYiwABoQ+SxWG6SDPTfmeP5/TqNs9MAcvPQj2IFj85F
        5FWgDAuYD/7MqvoAZ2K6CcF8aGxyLBrSX0a20xO5qw==
X-Google-Smtp-Source: ABdhPJw98b2hHI0MkVoCHhTocWu+CF6auK8Paa8Q5ZmRRVEYZylYEkvr/IJyDyAPKTDyS3ZiOItIHGQjaDcjfjEeFHA=
X-Received: by 2002:a05:6512:c12:b0:471:a932:cfe1 with SMTP id
 z18-20020a0565120c1200b00471a932cfe1mr9020055lfu.358.1650550085053; Thu, 21
 Apr 2022 07:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220409034849.3717231-1-zheyuma97@gmail.com> <20220410165425.6c2f60e7@jic23-huawei>
 <CACRpkdaFgB55HHR8a3vyVbZphu5fpguutBYemyVvGz=tcn6j+A@mail.gmail.com>
In-Reply-To: <CACRpkdaFgB55HHR8a3vyVbZphu5fpguutBYemyVvGz=tcn6j+A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 16:07:28 +0200
Message-ID: <CAPDyKFr50QirUvkUy+b665=2prMkGz=EXtbyc+Bty1woT=qO3w@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8974: Fix the error handling of ak8974_probe()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Zheyu Ma <zheyuma97@gmail.com>, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Apr 2022 at 01:14, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sun, Apr 10, 2022 at 5:46 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sat,  9 Apr 2022 11:48:48 +0800
> > Zheyu Ma <zheyuma97@gmail.com> wrote:
> >
> > > When the driver fail at devm_regmap_init_i2c(), we will get the
> > > following splat:
> > >
> > > [  106.797388] WARNING: CPU: 4 PID: 413 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> > > [  106.802183] RIP: 0010:_regulator_put+0x3ec/0x4e0
> > > [  106.811237] Call Trace:
> > > [  106.811515]  <TASK>
> > > [  106.811695]  regulator_bulk_free+0x82/0xe0
> > > [  106.812032]  devres_release_group+0x319/0x3d0
> > > [  106.812425]  i2c_device_probe+0x766/0x940
> > >
> > > Fix this by disabling the regulators at the error path.
> > >
> > > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > + CC Linus W as it's his driver.
> >
> > Fix looks correct to me, though the handling of runtime pm in here is
> > probably more complex than it needs to be (and hence this odd error
> > handling for this one place in the probe).
>
> At the time I discussed how to do runtime pm with Ulf Hansson a lot
> and I think it was the state of the art at that time. It might have
> changed since.

It still looks good to me. One could switch the order of the calls to
pm_runtime_disable() and pm_runtime_put_noidle(), but it's not a big
thing.

Whether it looks complicated or not, that's a different story. :-)

Note that some drivers are always being built with CONFIG_PM being
set, which allows some simplifications. Although, I don't think that's
the case here, right?

>
> > > ---
> > >  drivers/iio/magnetometer/ak8974.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> > > index e54feacfb980..84bbf7ccc887 100644
> > > --- a/drivers/iio/magnetometer/ak8974.c
> > > +++ b/drivers/iio/magnetometer/ak8974.c
> > > @@ -862,6 +862,7 @@ static int ak8974_probe(struct i2c_client *i2c,
> > >               dev_err(&i2c->dev, "failed to allocate register map\n");
> > >               pm_runtime_put_noidle(&i2c->dev);
> > >               pm_runtime_disable(&i2c->dev);
> > > +             regulator_bulk_disable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

Kind regards
Uffe
