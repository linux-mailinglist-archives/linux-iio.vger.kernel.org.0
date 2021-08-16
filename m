Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2DD3ECFEE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 10:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhHPIGF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 04:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhHPIGA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 04:06:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B511C061764;
        Mon, 16 Aug 2021 01:05:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so12740752pjb.3;
        Mon, 16 Aug 2021 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1ktA99mfz2RHRsDOWxe6xNSbgh0608fnbR1bfs8vTw=;
        b=QCsNbSm6yw5FCN5rIOla9UxUBS958N2gSQZ6zo6n+i32M9ZVmrpgjhymEQqdX+nKaG
         2BBp36WUVzm9/NmMQMplPmh20d9muHXRWrg4RBJW/a8C+6aOJ8mJWEDZdjf2OSaa42YC
         Rz7ZOwMxMg5QJUr2nA9yvhgc47wATlrrQ5kNq0z/YWzWuTYrmBAMlVcFLcziLYWY4S+d
         +jVEPdDZCSs5Kv3VfR8Wp+CklRjIIcAfmydcaVd/mxKEYJNWT9IbBwRxyFY2nSg/6J6j
         avELIFZ/nvi43KV2lyfumCz5VWaZxRoaGdqYLKQmqqjfjvPIc+pz1e5uxEsU8B8fEipu
         ZpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1ktA99mfz2RHRsDOWxe6xNSbgh0608fnbR1bfs8vTw=;
        b=qnqBDamBPVQLNMaHoWBZrv4EtuUpFTPK78Hag8apOfUMYu6oiNm8cPruHYs9XhQd8Y
         K1gcC/A3MVn81CGqQW2dknxnrlnzyPOW/fygQZQyGN/1zpdSOs4OPl1sXbYBp8qBdovn
         EzfbTanrUklEpjSawesIIJIm5XS5+CHplok4BTh2BYgrvsGh8SRL/a80SV2vvnEQrPdK
         EKWmnIVIDWpXxXVaoBn8tk/Fi8LJ7Ue2uB3wbHV1WHRpsPKGyi6+90AHJwdaEHY5E7mD
         6htiKovUDf2JGbDWlakpnkOxlr+uSJZwt18rGyOEaay03DrDFNvIpPZSiyF5wTIOq6xR
         077w==
X-Gm-Message-State: AOAM532TZmxgALuHLx2w4ZmDrBzz+ahcPjcO/E112QnGbI143XGgM3i4
        ZZy4fUYnjVDpQFabPWqnr1vlZzSQSweVqUJGtRg=
X-Google-Smtp-Source: ABdhPJw7UBAhzkfV5zJCwu97WAFsxzNAYdaeXevKDbcjSwz5I7eJ9OuyMRbMFCuAHVd95l/gxFHzSvEBe+iEAdWBk1M=
X-Received: by 2002:a17:90a:604e:: with SMTP id h14mr16070462pjm.181.1629101129052;
 Mon, 16 Aug 2021 01:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210815213309.2847711-1-liambeguin@gmail.com> <20210815213309.2847711-4-liambeguin@gmail.com>
In-Reply-To: <20210815213309.2847711-4-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Aug 2021 11:04:49 +0300
Message-ID: <CAHp75Vd-AfmwMyYyy5ygwmvGfwZLh9VwvBEzSwW3fc99jxFpnQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] iio: adc: ad7949: add vref selection support
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 16, 2021 at 12:35 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> From: Liam Beguin <lvb@xiphos.com>
>
> Add support for selecting the voltage reference from the devicetree.
>
> This change is required to get valid readings with all three
> vref hardware configurations supported by the ADC.
>
> For instance if the ADC isn't provided with an external reference,
> the sample request must specify an internal voltage reference to get a
> valid reading.

...

> +       /* Setup internal voltage reference */
> +       tmp = 4096000;
> +       ret = device_property_read_u32(dev, "adi,internal-ref-microvolt", &tmp);

> +       if (ret < 0 && ret != -EINVAL) {

What does this check (second part) is supposed to mean?
The first part will make it mandatory, is it the goal?

> +               dev_err(dev, "invalid value for adi,internal-ref-microvolt\n");
> +               return ret;
> +       }

-- 
With Best Regards,
Andy Shevchenko
