Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0433ACE8
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 09:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhCOIAr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 04:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCOIAe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 04:00:34 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D16C061574
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 01:00:34 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b5so8468684ilq.10
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zRqJhLCeuzPIFTJD0+tvL51PbuX6OecrRLrwWI5uxGo=;
        b=ldZBDduJ2BE6x1A54h4IZlvCqeKUVx1BfX8+wT+Xaek73Y1FLSQmvgJRCtKy/t2jPT
         3pnX2IfE1yxXCTRjlJF2kIaY/MvsPwZlO0OPza2GSHB8MR606IL/wH/+4WiA7kRdisyH
         7yQ0saA9FygpGVKwDhOfZ0MckDOwCa4LajqP76yiqFfypG89m/BsFmjByKIbxfjO1KSr
         Ht9/WtzTJj6gLkzsNx7Pw3jnD3JYL2WtMqoF8ezLdnrJF6cIeYCFA1hGVHbEafvpXtrd
         cPvjBCxu5dAbnf/GSpZCtueGqSNhRHffi5Asu+LaYkn7ztzByWl+bOGh7twPTMYyApNo
         mjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zRqJhLCeuzPIFTJD0+tvL51PbuX6OecrRLrwWI5uxGo=;
        b=pKeQqrfjunnnBSSdtqPOQCO2Osd29/duDITl1cRf6efwwL+7+9B4Pli/DeZ3263Bur
         SvfPKOoe1K8moRfLNWen7/QijZudPAPOAYbUq8/2mmEBPtLJiYn7gxwj9AyXO0RS6rAF
         ANI+Ia56ykNgs65WFFvhtgklQ+Z4sxABHSQuUsyWekg0MQW6hDHMRDYBXjh/21O7IhmI
         xaCSIc2FvnyHpID4aHnmBe7QzfcE9UTdn/uQNvQg4kOplMhzbvwRL7R7acMjDP4sg7BI
         zH2cr3G/4Q38rsIzskS+E3DX4p0VR/IzzNvrdfPtk83byaJfynUZltg2W1OCk0mB5RlZ
         07kQ==
X-Gm-Message-State: AOAM532y1A8eSiPcvUTfEU8no1EG6KFrCBP7Lr/HgdXCL/JhM6sOmwiY
        SydJILytPHESg59AZ9PoEANdc3+uTecWkyGN18E=
X-Google-Smtp-Source: ABdhPJzUparwwXV9pqNXub/pIfG3O/K7jd4zTPju4v0vcTrc24VoXJSGD5dNBiKyX1hp0UQtAONmY4REWm9LA682CIk=
X-Received: by 2002:a92:194c:: with SMTP id e12mr10899112ilm.292.1615795233715;
 Mon, 15 Mar 2021 01:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210314164655.408461-1-jic23@kernel.org> <20210314164655.408461-7-jic23@kernel.org>
In-Reply-To: <20210314164655.408461-7-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 15 Mar 2021 10:00:22 +0200
Message-ID: <CA+U=DsqYpjBM9Ds+Wjp3eU6jeA74Eqb+5JhazzSXQsOWCU3nRQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] iio: adc: adi-axi-adc: Drop false marking for kernel-doc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 14, 2021 at 6:54 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This comment block isn't in kernel-doc format so drop the /** marking.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index 2e84623f732e..d5f6ffc5b5bc 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -23,7 +23,7 @@
>  #include <linux/fpga/adi-axi-common.h>
>  #include <linux/iio/adc/adi-axi-adc.h>
>
> -/**
> +/*
>   * Register definitions:
>   *   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip#register_map
>   */
> --
> 2.30.2
>
