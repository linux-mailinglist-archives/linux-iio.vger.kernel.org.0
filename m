Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905F754EE8
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jul 2023 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjGPN4A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jul 2023 09:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPNz7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jul 2023 09:55:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AAEE71
        for <linux-iio@vger.kernel.org>; Sun, 16 Jul 2023 06:55:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-993d1f899d7so532287366b.2
        for <linux-iio@vger.kernel.org>; Sun, 16 Jul 2023 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689515756; x=1692107756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyTcxwXZFWWWTJdMWT4XbgZXuCWSZ8AXlZ0nPqWqSY4=;
        b=KSJoqnJBl2+0lT/a7j3tDK0q2sxreRow6mWn6XmuqnFGdvSxYrW4kA3aQwJNTUdjC3
         Oulz0Ct5XACEowOvC/c3b8NfGZ5cCGdCkDrLd1OYPGCl/E8krCdTGQnyIeejiap+JB7r
         bT9MQbNhgFOmaRC/COkInbI1LQ1O19WSI5/EwuHkX9xvrrERqXem17dgiMqaZNG30O+p
         PLFyYEUFXJ2jf+OlCSHxptnhXWkX6nitnQZvleqjAh1vnRTV8lHgjsGZ7NEMZg3/s4S3
         Fi0oN9NcKhgEi7IDHkZ7dPV+R7efMqTvYbe48v9YG69pF26pUk6S6PvGMzvf77bbfKJi
         GCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689515756; x=1692107756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyTcxwXZFWWWTJdMWT4XbgZXuCWSZ8AXlZ0nPqWqSY4=;
        b=RIM/J8T6+P6Oh62E99srOgL1qfWpkPgQC8u2DmU5jb4d3Ky91TIx0LuiT2qfdkTeap
         nGTWDoniU2Yld474/jQsEZBj3wAgCBtN1UFyqfsqEej2Ru51OnrJwU5J6qh9anUXjZdk
         JqK9ZmvoOioYF8oNot248nmdP2uRTZq/h5GS/25oAEubAqgSPLBzAL+J1HJf/EPmHb+j
         upGehK4XKw5n8jNM7LgoES8xqkC7srEy7FFTtqoqDTJfFr2h3stktEijwyAZdoqeAp53
         oiZUcqPwGh4xDool6r9VXbNRi4nPWArqpuWWBGzAvkJGoAAmBM0EMPQN3wgwQx18QNxL
         al7w==
X-Gm-Message-State: ABy/qLYT9RUzFE6750xf54HyvC59wViHAfgvd86IDGU5HCGkqiVtYlLt
        fTY/aV2ThAW4h29qW2wosDlod6Byrhmca3+A0tw=
X-Google-Smtp-Source: APBJJlGepphVzYcdY5n66RwHkHtAiFaEQtCcoIUXoGiOA9JXzM3b03+GmSgOJPmGuCzJGIcJW2tqQzwLQ9wYh7V6VsY=
X-Received: by 2002:a17:906:109b:b0:994:54e7:1287 with SMTP id
 u27-20020a170906109b00b0099454e71287mr6409125eju.73.1689515756297; Sun, 16
 Jul 2023 06:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230630143719.1513906-1-yguoaz@gmail.com> <20230716141028.4c57c5c7@jic23-huawei>
In-Reply-To: <20230716141028.4c57c5c7@jic23-huawei>
From:   yguoaz <yguoaz@gmail.com>
Date:   Sun, 16 Jul 2023 21:55:45 +0800
Message-ID: <CAM7=BFqJQZ6A3ssLhMA3NYRbk9vg6O+41J=Njz1KGYQTi9yXbw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: cros_ec: Fix the allocation size for cros_ec_command
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     tzungbi@kernel.org, lars@metafoo.de, bleung@chromium.org,
        groeck@google.com, dianders@chromium.org, mazziesaccount@gmail.com,
        gwendal@chromium.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes: 974e6f02e27e1b46 ("iio: cros_ec_sensors_core: Add common
functions for the ChromeOS EC S=E2=80=A6")

On Sun, Jul 16, 2023 at 9:10=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 30 Jun 2023 22:37:19 +0800
> Yiyuan Guo <yguoaz@gmail.com> wrote:
>
> > The struct cros_ec_command contains several integer fields and a
> > trailing array. An allocation size neglecting the integer fields can
> > lead to buffer overrun.
> >
> > Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>
>
> Hi. I'm sitting on this one for a couple of reasons.
> 1) No fixes tag (replying to this thread with one is fine)
> 2) Various people commented on earlier versions, and I'm waiting for them=
 to confirm
> they are fine with this version.
>
> If I hear nothing in a few more weeks I'll try and figure out the
> fixes tag + whether all the reviewer comments have been addressed.
>
> Jonathan
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
> >       platform_set_drvdata(pdev, indio_dev);
> >
> >       state->ec =3D ec->ec_dev;
> > -     state->msg =3D devm_kzalloc(&pdev->dev,
> > +     state->msg =3D devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
> >                               max((u16)sizeof(struct ec_params_motion_s=
ense),
> >                               state->ec->max_response), GFP_KERNEL);
> >       if (!state->msg)
>
