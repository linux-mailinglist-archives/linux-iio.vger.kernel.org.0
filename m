Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D9841FC02
	for <lists+linux-iio@lfdr.de>; Sat,  2 Oct 2021 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhJBNDy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Oct 2021 09:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhJBNDy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Oct 2021 09:03:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85816C0613EC;
        Sat,  2 Oct 2021 06:02:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x7so43724010edd.6;
        Sat, 02 Oct 2021 06:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndllisJpfri3hb1olUYJenRfRB5AbrAxzqRPTi6j654=;
        b=kqogW/uhlIxcQTtD4H2CvFfmWs499lz0u1RvmeXfGNfCXzcR1fLHhyhYSUUPun0Pk7
         elB8dK7MWMXVNYG1sM3lSVzYm84IfwbW6A6MloOSCJNCMmnZq9Tqh4BnDtNoOs1bAKF6
         wBC2zpt6CzqqbmGX5mDKOiXEUh6H40XskQBGw/8ib8WRRPitFdeFTGSnh1ZefUjcfUy2
         zfqD766y31hlg9/8TY/Wc7D+jfnsp1Ch+rrWU3/+nWsJ5VYXAl0aFVaO8VFjzmajU9zq
         AlNtQBmAwmlPMp8eKnLSL2ABkE7mSkDFivB1+MrKnfl8bnSoLb4uPJ4SakEzJkkOE3EE
         rnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndllisJpfri3hb1olUYJenRfRB5AbrAxzqRPTi6j654=;
        b=oW35YKfH1z4ErilKfFT+oyOp/PLKdcUAOCDiyGknezb660AbZ+mfAiXdDL2bpscmEi
         /H1ckl8hz1bj7ArdYhIJNZ14lZn/SDOOF4CjULz8W+NR98fmXVfT3zRmYGr4anRr6yuZ
         NQi8ZqR4Gq9+zBDJHfI4al2lm6Plz7Giv2MW1SDRdmUaEqx9oVjHOi9bzzDg4thz0GE8
         2r3I2Uq6B/Ig6Tgm1D6+rQFYwOjEEAi0yxlvux9WvrYlntphUwWngQHMjJ84q2XlIx4a
         0eFvBvUhMb7qXbAVpF1e61kEyVk4vXLNrvL6Nw5f2HWpyjwcJVKWwDRjbF/+ZeTJauhG
         BhoQ==
X-Gm-Message-State: AOAM532so8LKlFRUEuszngkClUJ6KdpW6ieaBfueieuysbqOaqqPO3KI
        +goRbIIE4FilonTrXHzFVrbrm1wsv8ARsnI8+Js=
X-Google-Smtp-Source: ABdhPJxD7CMyGM7QpQq/DlkZDaDLq0WriVeer/gNXyc23grxbsElTIc3j3RxOEb0CSkMyPT3TA7hcGtTOfUpyz8+Xqo=
X-Received: by 2002:a05:6402:1848:: with SMTP id v8mr1215860edy.0.1633179726993;
 Sat, 02 Oct 2021 06:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210928141956.2148-1-caihuoqing@baidu.com> <20210928141956.2148-6-caihuoqing@baidu.com>
In-Reply-To: <20210928141956.2148-6-caihuoqing@baidu.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 2 Oct 2021 15:01:56 +0200
Message-ID: <CAFBinCB+tYAjqhyO-UAsZxqm6FkK8Q8TGPJ_ehuxwgRSSRZDJA@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] iio: adc: meson_saradc: Make use of the helper
 function dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Tue, Sep 28, 2021 at 4:20 PM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
as well as:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
# Odroid-C1

Thanks for your contribution!


Best regards,
Martin
