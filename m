Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265483F2DF6
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbhHTOYF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbhHTOYF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 10:24:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72933C061575;
        Fri, 20 Aug 2021 07:23:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h13so14605283wrp.1;
        Fri, 20 Aug 2021 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NECWUZKNw7b/hLpmAoE600RWdzonY4v+C6sxyRUZZ8g=;
        b=Z/YJds/i20w4JZpQ3TCPXBYZ31hoqY0BYWkbXU3PEnq/kGqplxX8ZuqHrKhPvi1rJ3
         r/kVSehPuauuZ7GrI7casCnsvrwiAUWxeXQxi2B8Os1v9XbvTmD/AqA1nTuoowW4K22Q
         VlRlKJgbp773XuGKr7H5jq1iExClA0o+YN+w6sWE3kXiaeKxqgsxpFWuGMJqUlp8F+6u
         kI8rrhYGi55r0cc4bKNu4U+UN7CgpGZq/JI3aWNhUDdpZmo7wLgH5ezH1ArFbwvEDH4S
         dPloTAyS3DJC5zAYDWv0X1H+f30SRLr9wTR5ooxyANyGby7PQp/94UkESsVmeNmmfkSB
         phmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NECWUZKNw7b/hLpmAoE600RWdzonY4v+C6sxyRUZZ8g=;
        b=J4t+bZ85aMXofzGV1oCUt4quvCOIDBBPP5aONQDniWVthT84i9LT0aXKgkA/0epQ04
         SkQxBHDS78hrbCyd2e6Wg5U5hkziCfzlWT6WS/ujEg7EgCllhA30z7EvOJdZmOq1uRFd
         ku8kzrxWD8x+EXV+Qz9RFkBTiWrvPo/KQ02FpB9OZup2qrCNhJxmDFXlQDzPBq2LzXad
         7FY3zyMxyT3ztc6peIBasGtzrAh5ruXlEfgnTpBywT3XPPsOQVypafACDMeUtsTFuwbM
         GD1MttmMm/hhj6rFtukVecwS/bPRdZIgVoTr2cDDsJKAdRk7EEwHSa0mhG5dUUH72az9
         kw7w==
X-Gm-Message-State: AOAM531EvsiKspsbBBOdoTzOKLbayZBw/zLVMsdvtp5BIwIDXv5tJscF
        GRGZVwKRsTvMbPooOA7tSdUzXPHFE2TgO4VXX5g=
X-Google-Smtp-Source: ABdhPJzn6ynfzMR+v88kkr1qHD/81gS2YQmM1EMV6f0pd6gIl7snP3WRYg45Wkh4+2t3yEuuDKEqcyVWT6EcvFnSo7w=
X-Received: by 2002:adf:fa11:: with SMTP id m17mr10509550wrr.323.1629469405990;
 Fri, 20 Aug 2021 07:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210820133821.159239-1-jacopo@jmondi.org> <20210820133821.159239-2-jacopo@jmondi.org>
In-Reply-To: <20210820133821.159239-2-jacopo@jmondi.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Aug 2021 17:22:46 +0300
Message-ID: <CAHp75VfxFLq4eznB1a7gJZyP+gEmKtd22wzSDAs=+_BDL1GH0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: chemical: Document
 senseair,sunrise CO2 sensor
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 20, 2021 at 4:38 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> Add documentation for the Senseair Sunrise 006-0-0007 CO2 NDIR sensor.

...

> +    description: Phandle to the GPIO line connected to the nDRY pin. Active low.

> +    description: Phandle to the GPIO line connected to the EN pin. Active high.

As Rob suggested, adding the word "typically" would resolve my claim.

-- 
With Best Regards,
Andy Shevchenko
