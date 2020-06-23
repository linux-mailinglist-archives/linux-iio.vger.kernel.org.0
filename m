Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9477204BD0
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jun 2020 10:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbgFWIBM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jun 2020 04:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbgFWIBM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jun 2020 04:01:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F15C061573;
        Tue, 23 Jun 2020 01:01:12 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so9731347pfe.4;
        Tue, 23 Jun 2020 01:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDH4ZfrBuoWx+BiIJhwwh/FBQ8J1kbRargPKwEZiV2U=;
        b=d+uI922mr0oQu2pI3Bl9AxYVkOLmjht77lyasvbxW2g20pZChmks5C4hrEJKE1iUs3
         fJGUETnz7ARQYllkMrVg4FCydRSOBdgfhY7BSnKOU1/DEB3/jh8sevqo47L3pJnUzB5q
         oZ7Xg60zRpul9N1h70nI4GJNX0/M4PkSLdIuMp/JW9+tziPf+33gPyfscDThy65e4ZIb
         CsZ5Cz7D/W8wmFOpoDxOsp1X4wrZAFv7g8lDgb8a5iM1ilY+Bb0/yy8Zfs8rPHHm1rpd
         S9xL96ogn6HCjcShGpt50WyqSdqGbAwyHIUSHjK7hglVnZrzMa/f+E3wTlWpRa96HZ1s
         Kg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDH4ZfrBuoWx+BiIJhwwh/FBQ8J1kbRargPKwEZiV2U=;
        b=oia6nhbDFa6tHF0XrSczUNFZSxjS4gREgISiebk9qcUF3AG7D0my7gIxaSkvIpqSgC
         aSxJabwMQq/fyJfx6Mw0RQ5FVswEznHv6FW8hG1b8NS2dktM6OmaGN8DEn+Yn1A7E4+2
         h0JxUEKgctoT+LXo+C/3vkx5d+GV5HQT6B0lyzTmvqBXCnARMyzMaD9Z1hwrxIgFZgrG
         cW7FtmxSFR54PbzvkfHTA/aSgpjGI7as0j5TXDV9E21ieSGwEiDAF/PA88GMPjg9+d0t
         TDcODNdPtEux+f3aljWfO2f9l9zYIjliL4EjnLxj2xIyZ8SFUFLmqpfqGTnwSmyBvspM
         kntw==
X-Gm-Message-State: AOAM531JGE1Tmh+98gWxn8Ym70vbwknFNFt8MguuIfYlbMKdfVlm/5iR
        989r+lKXsapGr7C7AYGmm4bcTmaS6mlzAXyyITg=
X-Google-Smtp-Source: ABdhPJzxISO0ZpY7F9TVRtbWJLoGkKaST1kxWhY9HiMj9vCRgtrIL7u54bzGieMgLzRuseOzra/4MyeNG14p3hh2HpU=
X-Received: by 2002:a63:f042:: with SMTP id s2mr15816496pgj.4.1592899271743;
 Tue, 23 Jun 2020 01:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <1592897399-24089-1-git-send-email-jprakash@codeaurora.org> <1592897399-24089-4-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1592897399-24089-4-git-send-email-jprakash@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Jun 2020 11:00:58 +0300
Message-ID: <CAHp75Vd4V3nkaMhRA9kGSzwq22ALyvL-0xSUxpyS08jbmAe=ow@mail.gmail.com>
Subject: Re: [PATCH V7 3/7] iio: adc: Add info property under adc_data
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 23, 2020 at 10:31 AM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> Add info property under adc_data to support adding ADC variants
> which may use different iio_info than the one defined for PMIC5.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c   | 4 +++-
>  drivers/iio/adc/qcom-vadc-common.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 21fdcde..0fa1d37 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -629,6 +629,7 @@ static const struct adc5_data adc5_data_pmic = {
>         .full_scale_code_volt = 0x70e4,
>         .full_scale_code_cur = 0x2710,
>         .adc_chans = adc5_chans_pmic,
> +       .info = &adc5_info,
>         .decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>                                 {250, 420, 840},
>         .hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> @@ -643,6 +644,7 @@ static const struct adc5_data adc5_data_pmic_rev2 = {
>         .full_scale_code_volt = 0x4000,
>         .full_scale_code_cur = 0x1800,
>         .adc_chans = adc5_chans_rev2,
> +       .info = &adc5_info,
>         .decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>                                 {256, 512, 1024},
>         .hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> @@ -777,7 +779,7 @@ static int adc5_probe(struct platform_device *pdev)
>         indio_dev->dev.of_node = node;
>         indio_dev->name = pdev->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
> -       indio_dev->info = &adc5_info;
> +       indio_dev->info = adc->data->info;
>         indio_dev->channels = adc->iio_chans;
>         indio_dev->num_channels = adc->nchannels;
>
> diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
> index e074902a..6a7553f 100644
> --- a/drivers/iio/adc/qcom-vadc-common.h
> +++ b/drivers/iio/adc/qcom-vadc-common.h
> @@ -136,6 +136,7 @@ struct adc5_data {
>         const u32       full_scale_code_volt;
>         const u32       full_scale_code_cur;
>         const struct adc5_channels *adc_chans;
> +       const struct iio_info *info;
>         unsigned int    *decimation;
>         unsigned int    *hw_settle_1;
>         unsigned int    *hw_settle_2;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With Best Regards,
Andy Shevchenko
