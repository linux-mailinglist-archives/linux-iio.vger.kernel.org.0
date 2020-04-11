Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7851A4F47
	for <lists+linux-iio@lfdr.de>; Sat, 11 Apr 2020 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgDKKQA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Apr 2020 06:16:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44782 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDKKQA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Apr 2020 06:16:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id n13so2062911pgp.11;
        Sat, 11 Apr 2020 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scubK+r04ANvJ29JphyW/4RuEQax/zyXuzaYQPzCFCM=;
        b=GNaRhQ9nYhkAq0UI9ryUmQD01lO3Pku9cYd7QbjSFYzwMvPG1d+YJDoqUKlnvk7IzZ
         x9bZUR+RrVUlKk8vCjUP04j5VRT0hMHfzIC6ON9X/AIlPiaDIVEfqZ5Qq3w0gEPSf/Rg
         ozUvI420hMOdneTBRCsQTvemtvPrxsVUAs3L4rQ0IIuZUQuOGoSoEVL7Me24EuCtlT3Z
         IeVOO36F2l/VTog/B0fNq7Qekt1MczQ5iuivaNqH0H4r1kJ8YKBXAJbFXL2HL25V8f/z
         R3EdXokEF+FbRyfJV91LEuhtmU3XyM6Eu4qpfbdb52sKQX6l7YfsyAWsIR5N3CR5vm6p
         gQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scubK+r04ANvJ29JphyW/4RuEQax/zyXuzaYQPzCFCM=;
        b=RaOd+JlvVina3JNEgoB4cSkoG4oXNIzRdNKmvXJJu8wXkmWViIPclijBhyQKtkbmEZ
         AEBPa7NWo3LB+85iyF0DQyHJu2PBkUPwOPd3lRnR0iMhz+jZd8tw2pMws38ls+PIG1uL
         Q3umwHpScao4flAJGKHzQbvWmiloBXvgjiLyOn6byfFdEr9XJvz2WnAKnyYZotAvG/qe
         CW+Yx1E2U+IUE3ovwBJjzeTxGD/Cs6yj/4GfH2pUGRx17mAxCS1pIYEASasJg30PUe95
         B0vd+XCrlB234J0ptgOyKdsTgnVEtBblzGsDy1vKf9QTiBVxMBmISZVspt1/cmiIvKFd
         UvUQ==
X-Gm-Message-State: AGi0PuZ+RiGKYAaltPmg96AFjfPiSckPxDadIesxzB8Aj07n76N1zR8x
        SSJaqG+Bztjyxua9cFhD1c4pAslkKK6JgSZ/t20=
X-Google-Smtp-Source: APiQypLM96wHbtB2AIkNdcMbN+kWGkC6xP7eQasEi3VO1Wybh6tYHb/ULm6Eu2U8rQX6Ofw0T/+J4sqqH+vz/vQFac8=
X-Received: by 2002:aa7:9097:: with SMTP id i23mr9016213pfa.170.1586600159486;
 Sat, 11 Apr 2020 03:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200410201948.1293-1-sravanhome@gmail.com> <20200410201948.1293-5-sravanhome@gmail.com>
In-Reply-To: <20200410201948.1293-5-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 11 Apr 2020 13:15:47 +0300
Message-ID: <CAHp75Vc2Gf_=wWKdH2rgEhGTb0HmZkbVeUYx2hpdKE0P6Ru7FA@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] power: supply: Add support for mps mp2629 battery charger
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

On Fri, Apr 10, 2020 at 11:20 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> The mp2629 provides switching-mode battery charge management for
> single-cell Li-ion or Li-polymer battery. Driver supports the
> access/control input source and battery charging parameters.

...

> +static DEVICE_ATTR_RW(batt_impedance_compensation);
> +
> +static struct attribute *mp2629_charger_sysfs_attrs[] = {
> +       &dev_attr_batt_impedance_compensation.attr,
> +       NULL
> +};
> +ATTRIBUTE_GROUPS(mp2629_charger_sysfs);

Did I miss ABI documentation?


-- 
With Best Regards,
Andy Shevchenko
