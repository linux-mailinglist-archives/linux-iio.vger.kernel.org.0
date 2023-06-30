Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B62743DBC
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jun 2023 16:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjF3OnN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jun 2023 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjF3OnH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2023 10:43:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDEC3C3D
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 07:42:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992b66e5affso204542266b.3
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688136162; x=1690728162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVEDvLJrxohBr48Igsc93HjxIYvHu2mgIMywKz9BB14=;
        b=bc9GffOpP9nZMGcVCrz5pM/g2RyLRlzR2Y5L1H52fp7oxki52XsKtHcpVUomgc2nQO
         rBdhk3D+cM8oH1RsS7ASkmLdOj8EDqv8XzIgEmw+Kaz02+S7N3yOp38xAQKxWWPR9ySV
         n3F2coV63YRWwOLcQQP/KOv5afyrw0BnhF18tlIDZLYysTfh4nX5fwx/+YqrDvLmDysl
         UDPDcfGV/GpHLF5hiQ8JadqaYYi6+x3TO5oAkNg358VSWNfNSi/yYDGic9eVMhJurPux
         EewwmrWqxKnRmLH8Ep13QOn1uZyCkCq2zdJ6q2v4Lh3qhN7zbHJqeDM2X+fF0RqQJfT1
         tvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688136162; x=1690728162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVEDvLJrxohBr48Igsc93HjxIYvHu2mgIMywKz9BB14=;
        b=ZF1Yx47cPn24d1fpILhKNBb43+lLVSUHNc+hZxd0H18qPQR48GEmPi+3UJBZIwrRqG
         9wHnDqtKCNIUwS6vSUgqgLoJTMfDCr79aFPfEVlux8BaYK5PyabgbCa6leygEJzuAfpS
         uQCzJkJRvmNEZufsDppSlQA1g9RsQezB+Y2MaJFJf2fpPJ40MS8D65WpdQYgWp2dmQYk
         +yF8LTCq37RLvj6XdvVTiTWXwWIui+btPH7/9UPfRVodYKhrI3kbU/uo8NmS49nxNhkz
         c25aJ07QWcbdrw+J8MtyWTN4zAO7Nz4+3vuZ4WfPQ+xD2Xqq5K7b9/Ws2Ilc8IUHnp3k
         FRmw==
X-Gm-Message-State: ABy/qLYTY2xjarIPwsdaQteVfnKImPUF3CZJaKoxEfGbTj4LGt1akDCd
        bRRMrNx5JYga8ACBUSdWmAoJS2TlEp7fyYmt1DE=
X-Google-Smtp-Source: APBJJlHfDj/bhEszK89onIdRr4fkJEOKVbpLatk0YWKdcIq8bzW/QuynD8I0ESgc4B1wmYFQ9toNRk8pqCinC6pRQwg=
X-Received: by 2002:a17:906:4805:b0:992:5deb:db89 with SMTP id
 w5-20020a170906480500b009925debdb89mr1973886ejq.22.1688136161805; Fri, 30 Jun
 2023 07:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZJ6F4THLoYy6S8HP@google.com> <20230630083112.2344234-1-yguoaz@gmail.com>
 <CABXOdTdPTaJp8AwxfZzOZHDBsJSHpXH+KPsA3z_ZheekHPowpA@mail.gmail.com>
In-Reply-To: <CABXOdTdPTaJp8AwxfZzOZHDBsJSHpXH+KPsA3z_ZheekHPowpA@mail.gmail.com>
From:   yguoaz <yguoaz@gmail.com>
Date:   Fri, 30 Jun 2023 22:42:30 +0800
Message-ID: <CAM7=BFqEgpkRP30-P23wWy+hbS3HfCbKE1vb4BLQt8EgbMhxOw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: cros_ec: Fix the allocation size for cros_ec_command
To:     Guenter Roeck <groeck@google.com>
Cc:     tzungbi@kernel.org, jic23@kernel.org, lars@metafoo.de,
        bleung@chromium.org, groeck@chromium.org, dianders@chromium.org,
        mazziesaccount@gmail.com, gwendal@chromium.org,
        linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Got it. I have resent the patch in a separate thread.

Thanks,
Yiyuan

On Fri, Jun 30, 2023 at 10:07=E2=80=AFPM Guenter Roeck <groeck@google.com> =
wrote:
>
> On Fri, Jun 30, 2023 at 1:31=E2=80=AFAM Yiyuan Guo <yguoaz@gmail.com> wro=
te:
> >
> > The struct cros_ec_command contains several integer fields and a
> > trailing array. An allocation size neglecting the integer fields can
> > lead to buffer overrun.
> >
> > Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>
>
> Please _never_ send a patch as reply to a previous one, much less with
> a Re: subject.
>
> Guenter
>
> > ---
> > v2->v3:
> >  * Added R-b tag from Tzung-Bi Shih
> >  * Aligned the code by adding an extra tab before "max"
> >  * Added a patch changelog
> > v1->v2: Prefixed the commit title with "iio: cros_ec:"
> >
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c =
b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 943e9e14d1e9..b72d39fc2434 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -253,7 +253,7 @@ int cros_ec_sensors_core_init(struct platform_devic=
e *pdev,
> >         platform_set_drvdata(pdev, indio_dev);
> >
> >         state->ec =3D ec->ec_dev;
> > -       state->msg =3D devm_kzalloc(&pdev->dev,
> > +       state->msg =3D devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
> >                                 max((u16)sizeof(struct ec_params_motion=
_sense),
> >                                 state->ec->max_response), GFP_KERNEL);
> >         if (!state->msg)
> > --
> > 2.25.1
> >
