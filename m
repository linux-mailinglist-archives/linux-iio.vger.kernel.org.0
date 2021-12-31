Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26624482254
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhLaFtD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaFtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:49:02 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBBDC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:49:02 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id l3so29571041iol.10
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLYiS2VeOB0rwDrdg+cJMbUUfl2cE1z8SIqy4Oie4wc=;
        b=NzJJaqzmQZGCSdjSI760ZmseVsJAb99Mbr5cRReQXMAJq9o05Hll+HQ6vIZjlWfUBt
         MmsAGmNQg40yDe0NN+BYV5hjk3kYQTScR3NRlYoW2A6E4kR+TAsdMkG+ROQSDBVMWJay
         aGYZi9KUE3KieqHei29YINyf2+v0KzOa1zDQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLYiS2VeOB0rwDrdg+cJMbUUfl2cE1z8SIqy4Oie4wc=;
        b=lDXjayB9brl2I1hWatDMGCvstEaPblhqMp27av4pvw/9J7tPQTYG3DBhk/vybTQ9Bg
         I8s+noShivM4RpKCzIPs/EBvoyr4r/rS2alebV3Hadupm1PrJsM3zOXxft164RKVHWOA
         60nUKEc5mfTghj/jq8PCjoLPkCShHUpY27ZLepBXewg04Ly2rsNtKlU6h0m2bMNN3s+J
         HZkMMovR0aJcCIkMoqnt588TuNQrcJ3uECW4ORxX6LFBzup5x6/NATFhU5LGnRUZwGHu
         TbukyzTxK/JhLnsx/5xqNe1M4ALq2HLi509GXq/8+QtOdF8EoJAXWBQlrf4ELBKvD30S
         QnRA==
X-Gm-Message-State: AOAM5321yD8XwjQ/XDX85R8x45ldEQSmzxXOQGPtLZhy/+9tMRqPfrTT
        99olg1uUnJEM9RQQfwObqZ+r5goObOStW0psQXQ9mQ==
X-Google-Smtp-Source: ABdhPJwy9Cxu/jgKRYpqtakm5CNf2EiBkBbN2HRgsFWBXB1llo+7wD0e6Hk4g14V/jhKz5fNsARmToUpVg00nlen7LM=
X-Received: by 2002:a6b:dc10:: with SMTP id s16mr15266910ioc.131.1640929741985;
 Thu, 30 Dec 2021 21:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-9-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-9-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:48:50 -0800
Message-ID: <CAPUE2uutLVbWGVsPSG67dJo1jjmkpxTSEuQ8CCpmStzwx7+hAA@mail.gmail.com>
Subject: Re: [PATCH 08/16] iio:proximity:srf04: White space cleanup of spacing
 around {} in id tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The spacing in this driver was inconsistent with a space after the {
> but not before the }.  Tidy this up to avoid providing a bad example
> to copy into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andreas Klinger <ak@it-klinger.de>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/proximity/srf04.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index fe88b2bb60bc..4e6286765f01 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -235,12 +235,12 @@ static const struct iio_chan_spec srf04_chan_spec[] = {
>  };
>
>  static const struct of_device_id of_srf04_match[] = {
> -       { .compatible = "devantech,srf04", .data = &srf04_cfg},
> -       { .compatible = "maxbotix,mb1000", .data = &mb_lv_cfg},
> -       { .compatible = "maxbotix,mb1010", .data = &mb_lv_cfg},
> -       { .compatible = "maxbotix,mb1020", .data = &mb_lv_cfg},
> -       { .compatible = "maxbotix,mb1030", .data = &mb_lv_cfg},
> -       { .compatible = "maxbotix,mb1040", .data = &mb_lv_cfg},
> +       { .compatible = "devantech,srf04", .data = &srf04_cfg },
> +       { .compatible = "maxbotix,mb1000", .data = &mb_lv_cfg },
> +       { .compatible = "maxbotix,mb1010", .data = &mb_lv_cfg },
> +       { .compatible = "maxbotix,mb1020", .data = &mb_lv_cfg },
> +       { .compatible = "maxbotix,mb1030", .data = &mb_lv_cfg },
> +       { .compatible = "maxbotix,mb1040", .data = &mb_lv_cfg },
>         {},
>  };
>
> --
> 2.34.1
>
