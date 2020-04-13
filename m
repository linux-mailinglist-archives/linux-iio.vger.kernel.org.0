Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE391A6CFC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgDMULI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 16:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727816AbgDMULH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 16:11:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F309C0A3BDC;
        Mon, 13 Apr 2020 13:11:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e16so4015309pjp.1;
        Mon, 13 Apr 2020 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZqafRmRyQFCaiVXl6/7KpQLXAfpOOpFwxoy3qp4Wzo=;
        b=hBeooTLLnG54arHcFVqwFhOl1MSgWJ4FhzUtM+sQZPihXrROPFPV2lnHuZ0pGySA8I
         urXtzC0sB4meF1fs4fMKK2pL+/Bqf3dBmA3dg4mNrDYsFuPmn4VUQ8xhL9mb2mooWd4E
         x2nPBzbFJKztHKSEoIDE4hTSoVaVcln1WbG7g3g5Jwc66+4Jt1G1I/+Rh0Mo6RPwBxSC
         kc3b39fvUkquG01Z2KtnpGCg2Pa6XqFKkwE2AadgpddodUClLJQNCFPNNh8QwfvAyv6r
         CDgiw3nvaivXxy7nKQ/1qJGfY5SJP30o7EFRClHKr2zXs3SjXOR7QjuJVDXijsQu4hxU
         aF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZqafRmRyQFCaiVXl6/7KpQLXAfpOOpFwxoy3qp4Wzo=;
        b=AKUCPALX2z2FUaVmlJK2cLbZubN8Vb6bkyr2vf+rdLlCRkQgeiGV4t1iO/GaU+wAnY
         4H1RpW07rLZK1KpV1tbp7zMFCG3LhebJW/FkUkC+PE2BVp3yHPtIpiSu0qqxk2G3BcSe
         +MNtEukJRtj63gX4NxaflMrPYBqfWhnUHXBd/qhBRFH9HeG8Rpa2a8GUxFCIrynpWP6c
         kvBdL/aP/NX7QBWgaheBfj7UUl62PLztNyKc0SYo+OCkG2ZO+TRofOlcAobgwgFljjXN
         BP/aB3oIRIahFltyrK/aLbg2Z0jBFlMxD9rZZG9VQFdFoWitXt9RzaPJMyx2q9m6KfBk
         mThA==
X-Gm-Message-State: AGi0PuYdnFBSW90QHFegWBUlO/KKFHPX34lKFl+2N7/1+4bYTG/dItRJ
        YkRxxRPqLdWqHA4WwN8vS3BkDERSmTsgxKcXypI=
X-Google-Smtp-Source: APiQypINs7COjR3S1/ugzSWIcMYXhZLkL2dyDG4xs6MC97WDLSg7ekcSNiRGo6qgUndOlT4SrKpI4lG4HPbClh15hPA=
X-Received: by 2002:a17:90a:ff06:: with SMTP id ce6mr457333pjb.1.1586808665986;
 Mon, 13 Apr 2020 13:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200413173656.28522-1-sravanhome@gmail.com> <20200413173656.28522-5-sravanhome@gmail.com>
In-Reply-To: <20200413173656.28522-5-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Apr 2020 23:10:54 +0300
Message-ID: <CAHp75VeYFY1CW4AH+D4HAgzppMZ5J8dL8kKPYmcwsXNVGNSYjQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] power: supply: Add support for mps mp2629 battery charger
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 8:37 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> The mp2629 provides switching-mode battery charge management for
> single-cell Li-ion or Li-polymer battery. Driver supports the
> access/control input source and battery charging parameters.

...

> +static int mp2629_charger_probe(struct platform_device *pdev)
> +{

> +       irq = platform_get_irq(to_platform_device(pdev->dev.parent), 0);

Why not to use temporary variable dev?

This should be platform_get_irq_optional().

> +       if (irq) {
> +               ret = devm_request_irq(dev, irq, mp2629_irq_handler,
> +                                IRQF_TRIGGER_RISING, "mp2629-charger",
> +                                charger);
> +               if (ret) {
> +                       dev_err(dev, "failed to request gpio IRQ\n");
> +                       goto iio_fail;
> +               }
> +       }

> +}

-- 
With Best Regards,
Andy Shevchenko
