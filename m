Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20DC74D16
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 13:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391876AbfGYLb4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 07:31:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44591 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391875AbfGYLbz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Jul 2019 07:31:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so37300874oib.11
        for <linux-iio@vger.kernel.org>; Thu, 25 Jul 2019 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhuBXKW1pqwu3I/a51C/lMMrHG93yOL/odw0jXksmsM=;
        b=NFaF/0+HWBocaTISPRN64FldkQJsCLdLOvTsLvCXfup95wjAONzWuBKO5ZBfS6oF1J
         ekdw5EqRu1vDsLkUPP8yayxmbdrOGMKKvDgdSqTumrq/ZI2blPkLolJokz3tMpSz5Od7
         HWqfiq+FtTHlUP+8d6HXhtaQyDxiNFxwvQFtqs/IPrI2nN9+kLAbJhhHho20DwC9vkII
         iPPEL36enx+NCendroTEzk3RZ2eR4hq/QsxLtDL7oviQHOAk7K1QoZ4arpkFtKrTG0OF
         2qXJXB2jE18QVAJwsyM2BX8o5PSu/f32LtkYRTY6e+0sXgxGSTCjNCgu8MFCj2e64/FE
         njZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhuBXKW1pqwu3I/a51C/lMMrHG93yOL/odw0jXksmsM=;
        b=jTi/v7ud9Kw4Nh1xYZ07CdsqVPVoixdOIF/S7/4T31uvI7elvVYCsk9kjwmPYQRkcR
         VzjLdN64pVqxvV6jml/4JIZK1inqR3rQG0zJDoLjJmZNTbEbkMa4Qah40V2lk56D5Glw
         hddx6+3DzkKxkU5wsrrF/xojtcarlMM0rdNLF2XFeTx5GHu+9bjD1BDYPLNiua6lGE5Y
         vW3diDPAzjcpEd7a1Kg4w3ifm8NUID0GfxMy4WeI9iHk/1LUgLkMm3vdlcJh+uW77Xli
         cDyg3zhEBlpNwo5ONiLYO2BmpiNrZSRnaQl0ye1G1oExbqnz8Js3RIt7wQlU6cO4kYJr
         ciCw==
X-Gm-Message-State: APjAAAXXoGKHljMQQQ5jmtAg2hz1jEjuMV463Kx9zagZgW/qkmNiw1wk
        UMJpixG7Hk/28F52FmjtpUWgqgseI5F/gwaeFD+kwg==
X-Google-Smtp-Source: APXvYqyTumoJZ0ix0stK6lv6nkJJmb3o/KhhwbmFxp6XK2dHaRDdSRFrJZl7q7gsxLKrWmIrfy6vJiZqQtl3NavRNws=
X-Received: by 2002:a05:6808:8d3:: with SMTP id k19mr41623577oij.164.1564054314741;
 Thu, 25 Jul 2019 04:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190725085458.21838-1-hslester96@gmail.com>
In-Reply-To: <20190725085458.21838-1-hslester96@gmail.com>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Thu, 25 Jul 2019 13:31:43 +0200
Message-ID: <CAKKE0ZE_9dK=nCodqHjTZFF2iQQvJRn=etdT_fm4ug7L_maCgg@mail.gmail.com>
Subject: Re: [PATCH] counter/ftm-quaddec: Use device-managed registration API
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Comments inline

On Thu, Jul 25, 2019 at 10:55 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Make use of devm_counter_register.
> Then we can remove redundant unregistration API
> usage to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/counter/ftm-quaddec.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 68a9b7393457..bccbca8681b6 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -317,7 +317,7 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>
>         ftm_quaddec_init(ftm);
>
> -       ret = counter_register(&ftm->counter);
> +       ret = devm_counter_register(&pdev->dev, &ftm->counter);
>         if (ret)
>                 ftm_quaddec_disable(ftm);
>
> @@ -328,8 +328,6 @@ static int ftm_quaddec_remove(struct platform_device *pdev)
>  {
>         struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
>
> -       counter_unregister(&ftm->counter);
> -

The orders of (de)initialization should be kept symmetrical.
In this case, now that counter_unregister() will be called via devm,
it will be executed after ftm_quaddec_remove()

This introduces a race condition where the ftm-quaddec is disabled but
the counter entry itself is not.

Somebody else (William?) should confirm this.


>         ftm_quaddec_disable(ftm);
>
>         return 0;
> --
> 2.20.1
>
