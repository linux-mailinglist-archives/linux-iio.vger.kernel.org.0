Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224F01A6D2E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbgDMUXQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 16:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbgDMUXO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 16:23:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C2C0A3BDC;
        Mon, 13 Apr 2020 13:23:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c23so4978009pgj.3;
        Mon, 13 Apr 2020 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmYokySQc4mDg5AFnuTSHPu2MaxcLIZMXu10ec67aWA=;
        b=T2opoYpInMSpCsD8FGnwp8RshE9LSmcUdKcxZmnLcVWaLY+YkwwpiJEbo2CL+dXGQh
         FDSq6Fguk1B/sqw5Yfb2IUgPZw+S61mN6LTusdBkdA7Zs7fehJhoGl1tg3wvYmXnXD1w
         QD72ryeQvsJ1KZNxnLlPMDD5PINAK6oVjiQEMqi4HaTdko1Wul28U2GYxRXMBlMWwjuy
         0qmlTZ7azXWOdtMZ4Kktw6tp6kID/Q5NrgUlVvWyXChtEQ8x6vkcTUPQcukFs18FQ2WC
         qNW2Pax98aRgIsVCFqBSoF83wAVb+5+GasXsJg6xN0YdtUPVV6OtjpCNrw/6XYdZos9T
         boVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmYokySQc4mDg5AFnuTSHPu2MaxcLIZMXu10ec67aWA=;
        b=Ko4USKdTZkNbWJ3Uh5QcFrhLMpJGl0kyDmyd5PtxYDxluSmi+A57rwXGavdUH7YtSD
         k5accJ9VBhKW79Hmb+11WMfExHKU96kbt+s/N1aYpJdVmi8T2DhOuSYRvnltj8JX7kU/
         YWxMazPzqUXCr0CyZuXJt87Vk+Ru58/LOQpChxCNAcRkMu0q3zEFq/FNAqfkiFtxtWXx
         W3O2+bKlLmwg7i3MidUm+NpcVYcwNXqXsBtcodiJkS8lgGa6plGOFahAV+uS5zPVBd1H
         w4mtxu9AU47Tj0p7feVQDIkoHtKJO0J95Zij7KnbKA5xll3XXelAq/CpVN85yATrQupm
         69xg==
X-Gm-Message-State: AGi0PuZu1AGRUvCENexuCrv8prIbiK44tOXMjAA0ka5CT/H+5WDZpRZY
        fWpA7pMi7BDUcUUts0ZH/I2nU+rvpS6INiZlWKg=
X-Google-Smtp-Source: APiQypImH1MBeCQNjKwKjxst1BQnslU5r64FY1doy8gBsgZ1iDkIJUEd6FClNazs9I3WKnl7n2NFqWTsz4jHkZ5580c=
X-Received: by 2002:aa7:9097:: with SMTP id i23mr19183933pfa.170.1586809394372;
 Mon, 13 Apr 2020 13:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200412183658.6755-1-mani@kernel.org> <20200412183658.6755-4-mani@kernel.org>
In-Reply-To: <20200412183658.6755-4-mani@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Apr 2020 23:23:03 +0300
Message-ID: <CAHp75VeHctOu7+o6nMsqNU7q7gcJnK=n=dPX3xVMSgR9PsWjAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: chemical: Add OF match table for CCS811 VOC sensor
To:     mani@kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, narcisaanamaria12@gmail.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 10:23 AM <mani@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <mani@kernel.org>
>
> Add devicetree OF match table support for CCS811 VOC sensor.

...

> +#include <linux/of.h>

Why?

...

> +static const struct of_device_id ccs811_dt_ids[] = {
> +       { .compatible = "ams,ccs811" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, ccs811_dt_ids);

Since it has no ugly ifdeffery...

>  static struct i2c_driver ccs811_driver = {
>         .driver = {
>                 .name = "ccs811",
> +               .of_match_table = of_match_ptr(ccs811_dt_ids),

...use of of_match_ptr() brings a compiler warning.

Drop of_match_ptr() for good. And thus drop redundant of.h.

>         },

-- 
With Best Regards,
Andy Shevchenko
