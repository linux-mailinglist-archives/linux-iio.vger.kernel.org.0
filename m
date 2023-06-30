Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B1743D2C
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jun 2023 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjF3OHM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jun 2023 10:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjF3OHL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2023 10:07:11 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758732690
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 07:07:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40345bf4875so103991cf.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688134029; x=1690726029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHNKzb0xtZDRFm7xSfYT1lsm0g1hDdSqIsV7ISLU2gI=;
        b=i5USUPNBwEgaWF6g3Ro3jJBZF0WCeUDXRsn1xhd0FxR78OIlDFWaH3iDqPaCWYR4zo
         rVJ3qxPJdk/YrREY2Ow1EbO5Su+C8P1RzMEFUaya5wLBYiiJyFEoSTxL/0GPgcSc1QVr
         D3LW+JuJFov5xzMJRxCfjmZrBXeAX5Gu6VM0itL0VgihJEAvPD3FVD52WD25TMdElH3q
         t7k+28lpecAagScvi7y1pWnNiectOUUsd+dotGV4WB4WDne/WjnxeRgJaaJrh6dgn04R
         QJJfDeoooGqTKpO9mEtx9zM/nxVuibRfIt5e+/cK8sEa3vvO5btL/Gw0FGK+z5/w6ym7
         at/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688134029; x=1690726029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHNKzb0xtZDRFm7xSfYT1lsm0g1hDdSqIsV7ISLU2gI=;
        b=GRrRrcgIiyprY/CKjJii+RtzQndoX+zb6Crfi8NxJ23dho2brS3j7wCBjFvAnaiTpt
         Fle4EzH8ATj37c1ktr5V0O1jFvJifnLNCfXIKA/fvJeN4N+ifkTLU78hrfHGVW270VYJ
         VkaXHr8RvBhsu89jocm8xekSyfxSssbb08J+9Esy4i6gYPn4Usiz/jYmzeJaoyrdOfvV
         zFM2g3OsVYpQcwNuQRmLtXUYzSsVP0BW6O6FOfm9Dx0Nw1UwEeJlcBjOBqHfOwbXdadw
         XX0OwbQoC3kulZL8EebLJEQfQZdZ8HTKQB6cHCp9UrI9tlnEpQOAPsg6c03Qp/ZutYo5
         m1xA==
X-Gm-Message-State: AC+VfDwmUnuIHg65+gWmGq62Wzq0OnA1ttyJ8Mzt/o6OrNQuaqIvBPGr
        JQKxKH/8Ca3NbNlZefWoVXEs0U9OHcHVQKrrWOIWAg==
X-Google-Smtp-Source: ACHHUZ47S2nLH6V2FUJYX+wiY64v1gecK1rWqbO/Z6+l5S28oyXmumxGHbDpZZEMVcwaepD8n4Eg0dLjxQoQ1/fdKbI=
X-Received: by 2002:a05:622a:188e:b0:3fa:45ab:22a5 with SMTP id
 v14-20020a05622a188e00b003fa45ab22a5mr702360qtc.27.1688134029436; Fri, 30 Jun
 2023 07:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <ZJ6F4THLoYy6S8HP@google.com> <20230630083112.2344234-1-yguoaz@gmail.com>
In-Reply-To: <20230630083112.2344234-1-yguoaz@gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 30 Jun 2023 07:06:58 -0700
Message-ID: <CABXOdTdPTaJp8AwxfZzOZHDBsJSHpXH+KPsA3z_ZheekHPowpA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: cros_ec: Fix the allocation size for cros_ec_command
To:     Yiyuan Guo <yguoaz@gmail.com>
Cc:     tzungbi@kernel.org, jic23@kernel.org, lars@metafoo.de,
        bleung@chromium.org, groeck@chromium.org, dianders@chromium.org,
        mazziesaccount@gmail.com, gwendal@chromium.org,
        linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 30, 2023 at 1:31=E2=80=AFAM Yiyuan Guo <yguoaz@gmail.com> wrote=
:
>
> The struct cros_ec_command contains several integer fields and a
> trailing array. An allocation size neglecting the integer fields can
> lead to buffer overrun.
>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>

Please _never_ send a patch as reply to a previous one, much less with
a Re: subject.

Guenter

> ---
> v2->v3:
>  * Added R-b tag from Tzung-Bi Shih
>  * Aligned the code by adding an extra tab before "max"
>  * Added a patch changelog
> v1->v2: Prefixed the commit title with "iio: cros_ec:"
>
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/=
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 943e9e14d1e9..b72d39fc2434 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -253,7 +253,7 @@ int cros_ec_sensors_core_init(struct platform_device =
*pdev,
>         platform_set_drvdata(pdev, indio_dev);
>
>         state->ec =3D ec->ec_dev;
> -       state->msg =3D devm_kzalloc(&pdev->dev,
> +       state->msg =3D devm_kzalloc(&pdev->dev, sizeof(*state->msg) +
>                                 max((u16)sizeof(struct ec_params_motion_s=
ense),
>                                 state->ec->max_response), GFP_KERNEL);
>         if (!state->msg)
> --
> 2.25.1
>
