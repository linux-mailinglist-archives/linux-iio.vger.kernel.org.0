Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBAE41FD4D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Oct 2021 19:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhJBRIP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Oct 2021 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBRIO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Oct 2021 13:08:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289CAC0613EC;
        Sat,  2 Oct 2021 10:06:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dn26so46697204edb.13;
        Sat, 02 Oct 2021 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2Fe+5HrwJTnu6L3tCqAwaOKm35V1Vq91Zrd9rcYwKc=;
        b=F1U/fSQMsbaeL82WKL86FwCqGVfXgJH/lcVE/X9OKtjg3g8c4+MGG3/26Ee50ovqo5
         sClWS6OIKYXWsMqLvoAgE9nE3vFO2xCF9yNfpshHTznIYJbQCjL+XMesGSaRW4nGPdaN
         Ry3HwXBlU0EH09YFivoGhKIEp4mFMVVoXakRUE8qfWO1jVCGU2GX0LoetwJ7OIW+t4qM
         yxUmKviC4GhVG58KnGzQdZ4HXUhx8oYP9y4qcvSvfNm4nLkPwRedUAHLoNfCldbp2BGD
         4TRlQFapvZf+a9Os9QnD2RKcg3/h7BDdEvOMqOgBXKVjaiU5CIbZf8KaEyXWQXCVD/ib
         gqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2Fe+5HrwJTnu6L3tCqAwaOKm35V1Vq91Zrd9rcYwKc=;
        b=vp87BneDxd1ZzMEXr7t7gyqvmwZKWif6txXqrQrSvVKjP8QJaxE25iHHoTKh0yV7gF
         OaC065zY/yoO6Pz05mfM9lBslq7PKMY664tz9pv2e/7YhuEPKbTvnrb0qZ2K3xGRtoWn
         s+vQKPwxgD2fZNCEJHkjVHLImR0QUa3NZzjq8GBxOk9bR5NXrG/h/jdo8F3HKgVn0Qy3
         OMkctNA8NoP/VmQWoelDihds4yv38NscO4jGrb+7V0xBp0KUMJWWnwEX7z8a5cJN3uuk
         Cz9GTscyg3JRU5dDzqR7T46Ypx3Gv/UKLDQl6WDOl58XsGSrWSPUxAWNKm851QJR/zql
         3alw==
X-Gm-Message-State: AOAM531tMbblaoYJUVE/8Hy79xw8PY4Hr3+N/UX7RBOzUpK1UaATxs1h
        Su/mc4J3Qrvcb7QQW6jP/2zXv1SmcM2QPhpvqcU=
X-Google-Smtp-Source: ABdhPJxuqgSm9BN4R8HPnjHHfNyekDXMoB+gI0/bxNwXe9vVCIueascepu98U9unJ5AE9NIsK+/oy2hmLJbFl24MJBg=
X-Received: by 2002:a05:6402:493:: with SMTP id k19mr5145256edv.386.1633194386596;
 Sat, 02 Oct 2021 10:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210928141956.2148-1-caihuoqing@baidu.com> <20210928141956.2148-6-caihuoqing@baidu.com>
 <CAFBinCB+tYAjqhyO-UAsZxqm6FkK8Q8TGPJ_ehuxwgRSSRZDJA@mail.gmail.com> <20211002170901.7378fcc4@jic23-huawei>
In-Reply-To: <20211002170901.7378fcc4@jic23-huawei>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 2 Oct 2021 19:06:15 +0200
Message-ID: <CAFBinCAka2oQorT2Dy-DiGrChQd45_u3i5zTg_H2Mnu6vZQ2=A@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] iio: adc: meson_saradc: Make use of the helper
 function dev_err_probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, Oct 2, 2021 at 6:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 2 Oct 2021 15:01:56 +0200
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > On Tue, Sep 28, 2021 at 4:20 PM Cai Huoqing <caihuoqing@baidu.com> wrote:
> > >
> > > When possible use dev_err_probe help to properly deal with the
> > > PROBE_DEFER error, the benefit is that DEFER issue will be logged
> > > in the devices_deferred debugfs file.
> > > Using dev_err_probe() can reduce code size, and the error value
> > > gets printed.
> > >
> > > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > as well as:
> > Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > # Odroid-C1
> Hi Martin,
>
> Confusing tag.  Was the second meant to be a Tested-by?
my bad - it is indeed supposed to be:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Testing was done on a Meson8b Odroid-C1 board.


Best regards,
Martin
