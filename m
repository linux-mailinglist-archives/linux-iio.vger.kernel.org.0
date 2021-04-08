Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF935845C
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDHNPP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhDHNPP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 09:15:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04119C061760
        for <linux-iio@vger.kernel.org>; Thu,  8 Apr 2021 06:15:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m11so1777122pfc.11
        for <linux-iio@vger.kernel.org>; Thu, 08 Apr 2021 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhQqQPDGyQMxZKtfCIcfqDXGiQY0+ycfeKZZHoKU2rY=;
        b=rFVnQV2nUL9qMN7rMvNHLJG2TRzWnJVy7O2Hcm2UmyPMoOGyXYcFEwVY2n+pk7jdQv
         XEm7UTUMXPEhQ0y7zxqV8gMdP7TNgzn1CIkVQLIXs7iSRzRMtTivLiiMJjfdYefsn0lP
         m0IPqtdt5Yxqhud86mCWAzVmyFdj0nT8Sk52mbd1W4ErvKr859mcmfMEcOn79T8dHL/4
         GWtTgchpmLF9jYrG2DjpMov2iReZk6hXrLYhbuh/cZ/A0n2S56mBnX0KPdc+0/KlIpfV
         QxcZZHPuo5h591Sct/n0GTijaW6wvcNR/QxPq2d/mwgfjgec8BjBGvloXWFJfQLaABFI
         mPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhQqQPDGyQMxZKtfCIcfqDXGiQY0+ycfeKZZHoKU2rY=;
        b=nwybXQ+u4NpuQulliZ88NYOuHKsL6f4ibKQ9/b0YOaqi31hpz/qv/E25HNjvphiu7E
         4iNNPNalgnoalY6UtXpBR3vS2JFGaHkbZInm8NnOTo6K7fpzX1cHy1BOi7UMtbFnUUKg
         2Q26HU0YP8o/hXbURZ6ZgyvQM3UMgLx8NLfoeR0zgsPponxGWXac+RoaGoZatfe7rUlD
         yvi0albXMm43T9CS7u98MdaJ6ee6t/wExp+1tMRMK2pTRSpVCU3IfFY488QaE9NB2XvF
         IVQd4Bto/ryRDt2P2QA+ZOqUHIt4J2cPyAvru8YvFGcF9rLSyoOfOB6jYLCuHpzuN39q
         P/gQ==
X-Gm-Message-State: AOAM531kfgvPVHGuwxB5DsqYFcT7Car+ylncD3oiLpEvBEdcrMkKLg8H
        Qg0lUP9VR6mDWme1Jn3785EgmRBBYSZnWVMQrNI=
X-Google-Smtp-Source: ABdhPJzuOWbZmFXeQiT735OYr14lxZdmAtWLqjsOPVzJLWKrQC/S/J08R0i61GMjl3+xBgpdBx4k4iv69HSqH2raJm0=
X-Received: by 2002:a63:703:: with SMTP id 3mr8133935pgh.253.1617887703528;
 Thu, 08 Apr 2021 06:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
In-Reply-To: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 8 Apr 2021 16:14:52 +0300
Message-ID: <CA+U=Dsp7gP+LaBGdFCafn=6xP+HZ0sT29Gq4Jd9TAkuat21THg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Simplify codes with devm_add_action_or_reset
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        prime.zeng@huawei.com, Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 8, 2021 at 2:41 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> Some devm variants are implemented with devres_alloc() and devres_add()
> manually to only manage a single pointer. This can be simplified with
> devm_add_action_or_reset() which works the same. Simplify these functions.
>

Series looks good.
There are a few elements that are a bit strange (from a habit perspective).

For the devm_add_action_or_reset() callback usually there's a cast being done.
But that's a preference I don't feel too strongly about.

> Yicong Yang (7):
>   iio: adc: adi-axi-adc: simplify devm_adi_axi_adc_conv_register
>   iio: buffer-dmaengine: simplify __devm_iio_dmaengine_buffer_free
>   iio: hw_consumer: simplify devm_iio_hw_consumer_alloc
>   iio: triggered-buffer: simplify devm_iio_triggered_buffer_setup_ext
>   iio: core: simplify some devm functions
>   iio: trigger: simplify __devm_iio_trigger_register
>   iio: inkern: simplify some devm functions
>
>  drivers/iio/adc/adi-axi-adc.c                      | 22 ++++----
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 22 ++++----
>  drivers/iio/buffer/industrialio-hw-consumer.c      | 25 ++++-----
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 19 ++-----
>  drivers/iio/industrialio-core.c                    | 43 ++++++---------
>  drivers/iio/industrialio-trigger.c                 | 18 ++-----
>  drivers/iio/inkern.c                               | 61 ++++++++--------------
>  7 files changed, 78 insertions(+), 132 deletions(-)
>
> --
> 2.8.1
>
