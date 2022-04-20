Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902BD50936E
	for <lists+linux-iio@lfdr.de>; Thu, 21 Apr 2022 01:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354433AbiDTXRK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Apr 2022 19:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbiDTXRI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Apr 2022 19:17:08 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4BB13DF9
        for <linux-iio@vger.kernel.org>; Wed, 20 Apr 2022 16:14:21 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ebf3746f87so34798137b3.6
        for <linux-iio@vger.kernel.org>; Wed, 20 Apr 2022 16:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYRM9qktnYDaa3m8ekDwBnefJ70L+h8+LPGzeuAwAW8=;
        b=PM9Q4FWkCG9dzfZg0PVI2vzhj45QKMnRwiq7QmmlnRFeMdzS74TyWfUFCtQNmsOjht
         goEjr7b0a+mmKNjqg763zJCKW1Y3Vsj/ETv6gGXXor9fpSi02aizIOzJx9GlgWKOHvyV
         fyUA6ogjKBV6nag2EKCpPT/UcN+bty/fNl/rOTijVnNi9mCxZMpvVzlMvB04wVZsxBHf
         E6dio4yncjQwEqpTU/Q/DkMVJdZZ8aoDXGbg1FE3RuFTHhHiQVbtNEx2uGwW09PjUL+r
         +d22UOmWFDu0jXwXwxcVO5Z3FWzl6HugwZ8NGiALvehDK9z8zUHO9bOuFxx3Pa/g+Dxq
         0vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYRM9qktnYDaa3m8ekDwBnefJ70L+h8+LPGzeuAwAW8=;
        b=ghxw+j1Vqc8i26RbS/B8QbcOEuvBWPyb+PnPet9TJUi37xISHVsBYRIyQTpuCOMQDq
         lvtOjXOwsO2HsaEImlffT/KNQB12A8x1k7S6r7QARWd0kP/p8d0aUhk4aZjBhdo/MPND
         1bjwvZWLN0dxcrar2G51kGOpvxwXGSspwnMncCmvmikKAxqFg3yNJk6LuPW3xAbxmHgp
         az999KAD+C/UpvCg+TvZVx4/ELGhKuHVaziuDk+MFPME1mE9muTTn1LKTL90lRVlGBwX
         HOlmKb4pzk2qb3DXNd9VUb4SdLJbHbyGEYED17Y9D9yIna0I+2cJ/WVAVduPTDr30u1E
         aH0w==
X-Gm-Message-State: AOAM533JwIHTxBM7d9njzmEKmyMf8PWtmFXb+sAW6Uy+mT7a5OyKUIlM
        HoTFvwqBqAKWKTQ+vP8W1f8tPTzYH9ZvA2hOL5yZKcCdMN0=
X-Google-Smtp-Source: ABdhPJzrOvt+32bvB/JOtbibZUy7E1gzG00WtbSE17MMsGjTOm8rogn79zYa9DvcpEodQdUtI64CWfpl2gi/QFxwYI4=
X-Received: by 2002:a81:5dc5:0:b0:2eb:3feb:686c with SMTP id
 r188-20020a815dc5000000b002eb3feb686cmr23848260ywb.268.1650496460802; Wed, 20
 Apr 2022 16:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220409034849.3717231-1-zheyuma97@gmail.com> <20220410165425.6c2f60e7@jic23-huawei>
In-Reply-To: <20220410165425.6c2f60e7@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Apr 2022 01:14:09 +0200
Message-ID: <CACRpkdaFgB55HHR8a3vyVbZphu5fpguutBYemyVvGz=tcn6j+A@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8974: Fix the error handling of ak8974_probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Zheyu Ma <zheyuma97@gmail.com>, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 10, 2022 at 5:46 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sat,  9 Apr 2022 11:48:48 +0800
> Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> > When the driver fail at devm_regmap_init_i2c(), we will get the
> > following splat:
> >
> > [  106.797388] WARNING: CPU: 4 PID: 413 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> > [  106.802183] RIP: 0010:_regulator_put+0x3ec/0x4e0
> > [  106.811237] Call Trace:
> > [  106.811515]  <TASK>
> > [  106.811695]  regulator_bulk_free+0x82/0xe0
> > [  106.812032]  devres_release_group+0x319/0x3d0
> > [  106.812425]  i2c_device_probe+0x766/0x940
> >
> > Fix this by disabling the regulators at the error path.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> + CC Linus W as it's his driver.
>
> Fix looks correct to me, though the handling of runtime pm in here is
> probably more complex than it needs to be (and hence this odd error
> handling for this one place in the probe).

At the time I discussed how to do runtime pm with Ulf Hansson a lot
and I think it was the state of the art at that time. It might have
changed since.

> > ---
> >  drivers/iio/magnetometer/ak8974.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> > index e54feacfb980..84bbf7ccc887 100644
> > --- a/drivers/iio/magnetometer/ak8974.c
> > +++ b/drivers/iio/magnetometer/ak8974.c
> > @@ -862,6 +862,7 @@ static int ak8974_probe(struct i2c_client *i2c,
> >               dev_err(&i2c->dev, "failed to allocate register map\n");
> >               pm_runtime_put_noidle(&i2c->dev);
> >               pm_runtime_disable(&i2c->dev);
> > +             regulator_bulk_disable(ARRAY_SIZE(ak8974->regs), ak8974->regs);

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
