Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF90979120A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Sep 2023 09:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbjIDHZf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Sep 2023 03:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjIDHZf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2023 03:25:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCADAA0
        for <linux-iio@vger.kernel.org>; Mon,  4 Sep 2023 00:25:28 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58fb73e26a6so11192487b3.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Sep 2023 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693812328; x=1694417128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf7al0WUE4eC4ByNNRh0cmVR35l8BNEETortMykQPVc=;
        b=zL1+L++T/gf2+urE5HvcayUmGS/lQyWw5xc1GXVHkOnJwooAC2WWcFidVFHW4DHd38
         ETVrPbVFfZpHeIB0V84MOM/BQHgCVAas0VSBiwt1AEgemMe4jZ623A/h6Mgamlb51aC9
         s1FlymEzPNaDftbuiW92Dg2LEV1BJxQmpRkTMNTWDf83jUMZ4fzB9Zt3qF7slqYqqwyH
         Pd+iL+dcZCs3BX59BWpULg1PzjRbwyuzJGRdDyAkIym9yBA15z4cOti+aWeJvrLKlYvU
         Js4I/RU82NYgvV42Z3jiVf1iJfno68JvO10glJo+RbZIbwaEZcwxowZ13mXhWS6rutmi
         Kdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812328; x=1694417128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xf7al0WUE4eC4ByNNRh0cmVR35l8BNEETortMykQPVc=;
        b=Vru6IscaYr1aeweLf+ld04A9hYCogneYsGc8HV9crtV3g3cYfn97BPCATL4IKWiTx+
         HnouZh8c33hsUJfC6ziYH4cQq/4Kc8YepcgMDQC4cw/Q8fZZD9kIfM0D+EDlD7ahnloR
         FirF4L0HA7fL4uSWy7UoLdaliqeAtL7JEI0gIN04MG473Hqn2iqK4tN15R89L2DAL9jq
         ltKeqcax/Vumw6W9FA+BWN6S1Bh3leJCHYIzal/WAAVg4xKb5jB7WIHp58CmyPwqY+LZ
         cqZkP0jnHZBz9NbiOtP0dp2+vgohi98fmTVxJGKpLTeqQG69LU+UWmU3eM0rVJ+aJHRE
         a9fg==
X-Gm-Message-State: AOJu0Yyy8i+k8PCtiHcguPriDYYpAE9NST3M5sOcjlqIPqXh8Az4+dtb
        IRQExGtIbGCemE2ymNARZAnWENJTZElsUziL+gF30w==
X-Google-Smtp-Source: AGHT+IGTBzivgtmSJXik9OvFikBdOetGcSvNamKbBaU9KgbqUl5iymGKEcXCB7lUAzT+InPJUZmUdTDGO6qwQVpAmvo=
X-Received: by 2002:a25:db84:0:b0:d07:7a3e:1ab with SMTP id
 g126-20020a25db84000000b00d077a3e01abmr9969410ybf.50.1693812328116; Mon, 04
 Sep 2023 00:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220524075448.140238-1-linus.walleij@linaro.org> <20230903180417.22-1-bavishimithil@gmail.com>
In-Reply-To: <20230903180417.22-1-bavishimithil@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Sep 2023 09:25:16 +0200
Message-ID: <CACRpkdZU=mb2WJVOade-Gmng6aOYApTzv_S5bZqc82r-WBEPrg@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
To:     Mighty <bavishimithil@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, liambeguin@gmail.com,
        linux-iio@vger.kernel.org, peda@axentia.se, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 3, 2023 at 8:04=E2=80=AFPM Mighty <bavishimithil@gmail.com> wro=
te:
> On Mon, Aug 28, 2023 at 11:48=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
>
> > 2) If the channel has a horrible non linear and none invertable convers=
ion
> >    to standard units and events support the you might need PROCESSED to
> >    provide the useful value, but RAW to give you clue what the current =
value
> >    is for setting an event (light sensors are usual place we see this).
>
> In this very specific case yes, it is being used as a current sense shunt=
 for a
> light+prox sensor (gp2ap002), so I do think that it might be case 2 inste=
ad of 3.
> But with no other devices using the twl6030/32 gpadc for any features it =
could
> also be due to it not being updated like case 3.

See if my patch fixes the issue for you, else we need to patch twl6030 as
indicated.

> Also the fact that the adc would break in cases when its not just a light=
 sensor
> as well, we just dont have any such devices yet.

I have tested the gp2ap002 both with and without light sensor.
They have different product numbers and thus different device tree
compatibles if the component supports light sensoring and not just
proximity detection, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
So just use the right compatible (if you're using device tree) and
it'll be fine.

Yours,
Linus Walleij
