Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1326C58C781
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiHHL1U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHHL1U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:27:20 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F5E0A5
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 04:27:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l188so10006849oia.4
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 04:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1NiXaYC0ntOiN3PvWq+lhn9cdt6wvOhdWi8VRusQOPE=;
        b=EsowCaCYHCuorMLgPxNUTuSUShm1xqdPO8KnMd6LhpcGu5VS0f1J1HPtXDTuF2ouvy
         UoDAICIXywes0ITteDMsa7prp/TgBSuLzBn1d2r+GM66gu8yqvdMpoVtrCeR5cGcNCVi
         2sDXUDf1U/KWLZGaLxX4388l3BlCCXJpGh2/ao60b8zy4QdRGl1teqHMMPvFgjlILJQy
         F4DEXx4rCoxuy3cNIeuEzIFQj/01rMaVMskCB1y8eaRJY2RZEup5K7DAzU7WWKxEYQB2
         Wf7hYvbAaDwRymL/dy9fRLvTRFY5uWmdv9+lbfCpM1zHEJOUcpipWWEbIe1A1B3wis+7
         YEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NiXaYC0ntOiN3PvWq+lhn9cdt6wvOhdWi8VRusQOPE=;
        b=aJnXHGpxY0sBPsm8tZwyeg2lDnsUYVzK1snyIC/9ir3NZIEMWA2kIFHje/zq+EJx5q
         2iu/GnStEegAOaKb245tAaSdn1hRB+1IftgMbMUmcMuJuLZJyW6NQ+7h6MPXm6PDNTLZ
         GnK6BqGupeUkHE3Hvu8aB3lOLIHp9gOyMW4xD5OgEaAruKTfUUc0i5x+MIEtO4dZMtIL
         uzulaIYG8kDgOdahjyJry/9bRPOHizwSWunKtQvaVdJnRuYfPIp4I7EDFGYhCRRJ6tgZ
         F08P7WNiYvcmVE5uaZk85rfz/e1rVBF6x6s+UEQFljOTzCp30dg3GKXEsIciXnCEHIIY
         9BPw==
X-Gm-Message-State: ACgBeo2l+ZrkHKeSq5Yyec004oW6mQmxxMXtz1ebnzGP+aGtDtxLRWts
        Wo/ktFDYVR4pUzMcVPL+BcKQ4ZHgO6VTOkrdoywGLVHMtW4=
X-Google-Smtp-Source: AA6agR5UMYOA4UKcWu/LtIJXtvTRNiHOvaG4Cj7E6NuZXh0DfBk2SHf7tyW8UWYFkKDXqaCuNJI3hibtJQAMEqh4hZk=
X-Received: by 2002:a05:6808:1708:b0:335:1b16:fb09 with SMTP id
 bc8-20020a056808170800b003351b16fb09mr11053015oib.7.1659958038259; Mon, 08
 Aug 2022 04:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220807190414.1039028-1-jic23@kernel.org> <20220807190414.1039028-3-jic23@kernel.org>
In-Reply-To: <20220807190414.1039028-3-jic23@kernel.org>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 8 Aug 2022 13:26:42 +0200
Message-ID: <CAKv63us-VHQLwAMCbw9wMR=2KXGjWASgkDRVPgMg9zi1oRZmtA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: temp: mlx90632: Switch form UNVIVERSAL to DEFINE_RUNTIME_DEV_PM_OPS()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Not sure if I should apply both but:

Acked-by: Crt Mori <cmo@melexis.com>
Tested-by: Crt Mori <cmo@melexis.com>


On Sun, 7 Aug 2022 at 20:54, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The callbacks in this driver are simple and it doesn't matter if
> they are unnecessarily called multiple times.  However, we might as
> well not repeat the effort if the device is already suspended.
> The new DEFINE_RUNTIME_DEV_PM_OPS() has the advantage that we don't
> need to mark the callbacks __maybe_unused.  The compiler will still
> remove them for us if CONFIG_PM is not set.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 7ee7ff8047a4..9fc69d099784 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -952,7 +952,7 @@ static const struct of_device_id mlx90632_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mlx90632_of_match);
>
> -static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
> +static int mlx90632_pm_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>         struct mlx90632_data *data = iio_priv(indio_dev);
> @@ -960,7 +960,7 @@ static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
>         return mlx90632_sleep(data);
>  }
>
> -static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> +static int mlx90632_pm_resume(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>         struct mlx90632_data *data = iio_priv(indio_dev);
> @@ -968,14 +968,14 @@ static int __maybe_unused mlx90632_pm_resume(struct device *dev)
>         return mlx90632_wakeup(data);
>  }
>
> -static UNIVERSAL_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
> -                           mlx90632_pm_resume, NULL);
> +static DEFINE_RUNTIME_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
> +                                mlx90632_pm_resume, NULL);
>
>  static struct i2c_driver mlx90632_driver = {
>         .driver = {
>                 .name   = "mlx90632",
>                 .of_match_table = mlx90632_of_match,
> -               .pm     = &mlx90632_pm_ops,
> +               .pm     = pm_ptr(&mlx90632_pm_ops),
>         },
>         .probe = mlx90632_probe,
>         .remove = mlx90632_remove,
> --
> 2.37.1
>
