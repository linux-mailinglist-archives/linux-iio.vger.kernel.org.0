Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA64B78AF1
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 13:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfG2Lw7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 07:52:59 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39867 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387665AbfG2Lw7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 07:52:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so56200150otq.6
        for <linux-iio@vger.kernel.org>; Mon, 29 Jul 2019 04:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPGf0kPbvhe2HXNESzGCCBqYTl2vqafsajjrV11C25I=;
        b=p97UEoNg/4v5WyEnvrg6cBEmCngBnKeqFcpQlsDLMsJijmNXQOucbWp+t+TFovLOXZ
         qgqyVce9UCFzNi2sjQ7Zt9gV2tetGlakx45j63Mpcia5m09PM9omEz3/9LkbQmwePBL0
         VIF48g2yFADHWzzsSYLAgHOgCSTVNqoVcqaUU6txNjq6wdlFeZykRdbr6oFPL8FaU8+N
         dThYCT69kkPPeOrsWEGninxKcQ497ZwrJyIUU11P2AOJnQotM+PNQmu/63YJNzXRZwdv
         GLIEsRZvBtfJbs0do5wKLVvnCcRT1tm49qlpeRTJckOuQf8JWRg21d6AaUqUz4mY25if
         ZdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPGf0kPbvhe2HXNESzGCCBqYTl2vqafsajjrV11C25I=;
        b=ccSA8h3+v6XuRukGp8RvdwSr3B8d0WuncpUdxg2pEw1B+T8Vcgwg+O5IEBwGo++SHv
         2f/ci/gP+u8vqAM4/NtGTLGnM/w1ocs5bJJpSjBSKuV4T0JNASpn9p0DskTBoIo2JriJ
         QXYRNLmCij3aNZYDIbIYvHku+zeU72+pg2QmaFGp8YHZAhQYDEaLZb0qHNYwPQOHTRGd
         d5pMo+I2tp80wJDvW83ieKElmRmfkiuVgllb+rCFOGWIxpPZXejDbMrojN4aRT+MYdGd
         7kC7EEI14kbeoQ2Ns0ReuDXIkH7ObJKnuIAv3674Ifkg9QFqwBL7YTWY8fzXzLYd3IIQ
         0+4A==
X-Gm-Message-State: APjAAAUdl/5aSv0s26zZP0q5A/u9DwU3vgpZFDIQyuwev1dVC+WPxC/e
        xLEpZJ+wcTC8CrEZsejT0OeXgbrZrVm+tZmxghavcA==
X-Google-Smtp-Source: APXvYqyS81a5YCskF+EiZflTcgNqYeRMHdvCBcOv1gxPheP1eba17RzCLqIog5cAcS4IbQhdIPt/ugH4upY8MEazw/A=
X-Received: by 2002:a9d:48f:: with SMTP id 15mr49061044otm.160.1564401178640;
 Mon, 29 Jul 2019 04:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190726133916.26186-1-hslester96@gmail.com>
In-Reply-To: <20190726133916.26186-1-hslester96@gmail.com>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Mon, 29 Jul 2019 13:52:47 +0200
Message-ID: <CAKKE0ZFgdiViNiHD2KXvJAW4MB+0T2BM0-k+2UYWubTRHN9Sww@mail.gmail.com>
Subject: Re: [PATCH v2] counter/ftm-quaddec: Use device-managed registration API
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 26, 2019 at 3:39 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Make use of devm_counter_register.
> Then we can remove redundant unregistration API
> usage to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Reviewed-by: Patrick Havelange <patrick.havelange@essensium.com>

Maybe a bit too late, sorry for that. Thanks for the patch.

Patrick H.

> ---
> Changes in v2:
>   - Use devm_add_action_or_reset to keep
>     resource release order.
>   - remove() function is redundant now,
>     delete it.
>
>  drivers/counter/ftm-quaddec.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 68a9b7393457..4046aa9f9234 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -100,16 +100,18 @@ static void ftm_quaddec_init(struct ftm_quaddec *ftm)
>         ftm_set_write_protection(ftm);
>  }
>
> -static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> +static void ftm_quaddec_disable(void *ftm)
>  {
> -       ftm_clear_write_protection(ftm);
> -       ftm_write(ftm, FTM_MODE, 0);
> -       ftm_write(ftm, FTM_QDCTRL, 0);
> +       struct ftm_quaddec *ftm_qua = ftm;
> +
> +       ftm_clear_write_protection(ftm_qua);
> +       ftm_write(ftm_qua, FTM_MODE, 0);
> +       ftm_write(ftm_qua, FTM_QDCTRL, 0);
>         /*
>          * This is enough to disable the counter. No clock has been
>          * selected by writing to FTM_SC in init()
>          */
> -       ftm_set_write_protection(ftm);
> +       ftm_set_write_protection(ftm_qua);
>  }
>
>  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> @@ -317,20 +319,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>
>         ftm_quaddec_init(ftm);
>
> -       ret = counter_register(&ftm->counter);
> +       ret = devm_add_action_or_reset(&pdev->dev, ftm_quaddec_disable, ftm);
>         if (ret)
> -               ftm_quaddec_disable(ftm);
> -
> -       return ret;
> -}
> +               return ret;
>
> -static int ftm_quaddec_remove(struct platform_device *pdev)
> -{
> -       struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> -
> -       counter_unregister(&ftm->counter);
> -
> -       ftm_quaddec_disable(ftm);
> +       ret = devm_counter_register(&pdev->dev, &ftm->counter);
> +       if (ret)
> +               return ret;
>
>         return 0;
>  }
> @@ -346,7 +341,6 @@ static struct platform_driver ftm_quaddec_driver = {
>                 .of_match_table = ftm_quaddec_match,
>         },
>         .probe = ftm_quaddec_probe,
> -       .remove = ftm_quaddec_remove,
>  };
>
>  module_platform_driver(ftm_quaddec_driver);
> --
> 2.20.1
>
