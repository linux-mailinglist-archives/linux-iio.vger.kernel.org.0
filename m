Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC0F1B4DBD
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDVTzS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbgDVTzR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 15:55:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEFEC03C1A9;
        Wed, 22 Apr 2020 12:55:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r4so1634956pgg.4;
        Wed, 22 Apr 2020 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zs8P//rvg1SHF869DDtGbnL1grMzFoBcMAhWEXUbn6o=;
        b=KlXXhxukDACNLMUxpYlTVSzYG6IvesGADSdCuxMosdiu9EKeJNaTlEvk1Ajs9junY3
         UIRo9RskUrRx0zTQ77/IZAhjY+dXigzRdC9Hfvm17e8wuVTeyXTR+1BxFhQeGZax8Don
         bH+R1wrMoEMuqHZwwta9VKDTfRLdi3InCi8Ak0eXzjkxVTrq3f+WVPPRbAMgf7DUCTgW
         0TpgX124ei9O8xtv07Vr8+M4fdOdOpmviyfftxoHs73SaVLm3F2msDSVg9spxnupq6o1
         9Dr5PrtirY4tjGIl9lppDQvDzlDlhAPTt31Aq8BKnfPFooYEeVQjbgHG+jKuGbiKqSBp
         oU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zs8P//rvg1SHF869DDtGbnL1grMzFoBcMAhWEXUbn6o=;
        b=VxovGCUo+SBCbk/+VGmKoCTs7tewYAkJWZWV3rybKypIXjSInLEO6vlLwnqi6V1ndB
         M1EvOOaRKYCOBM6xjf+10koKrXVIZ40k28l4lu/axRGeqCqOrkrJQN1Sdtmafti1YqKw
         ryFRxziJK+TPgJvULH782Z0AA5tZpQFc2yT0ySZemKTlHaDDdttdZYMJd/KpNvX4+m3S
         i13vAHEnRqZh7QJxuBAy7s27xR0mKrG9KzvGp64LZiwBsCdQK63EiGTuNz+vvTwGKB6M
         E1Kfn2q+c2Fgb07ks5nVcYAbK1lVL+A7wtShVwzb6QrLAF5Fhkurjg6Vqe2jDeOZBqSI
         kgTQ==
X-Gm-Message-State: AGi0PubEsG10a+BSH/dhyB6Py9zNIg1JsRBEDJzKYivOIxp7fcnZfkqB
        +OnnTYREGntQgJps1N76HRxPnfnH2M8vD+h5jCQ=
X-Google-Smtp-Source: APiQypJH46V+NkKJyqIIaJ0hU0KoYCno8EKW/Oi/CecMsV4MkYyux/EQvd9iy76qKPRUhBptl4/+K6Zb3chyB9UssPY=
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr206525pfr.36.1587585317156;
 Wed, 22 Apr 2020 12:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com> <20200422141135.86419-4-tomasz.duszynski@octakon.com>
In-Reply-To: <20200422141135.86419-4-tomasz.duszynski@octakon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Apr 2020 22:55:05 +0300
Message-ID: <CAHp75VeXd7hgdZ-1FDCpyad7_rHV1ERiigctn-6AYvVhLyX5QA@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio: chemical: scd30: add serial interface driver
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 5:22 PM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
>
> Add serial interface driver for the SCD30 sensor.

...

> +#include <linux/of_irq.h>

Do you need this?

> +static int scd30_serdev_probe(struct serdev_device *serdev)
> +{
> +       struct device *dev = &serdev->dev;
> +       struct scd30_serdev_priv *priv;
> +       int irq, ret;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;

> +       irq = of_irq_get(dev->of_node, 0);

fwnode_irq_get() ?

> +       if (irq <= 0)
> +               irq = 0;
> +
> +       return scd30_probe(dev, irq, KBUILD_MODNAME, priv,
> +                          scd30_serdev_command);
> +}

-- 
With Best Regards,
Andy Shevchenko
