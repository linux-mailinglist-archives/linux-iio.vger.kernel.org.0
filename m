Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29ED19FC11
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 19:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDFRxY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 13:53:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36856 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgDFRxY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 13:53:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2so111589plo.3;
        Mon, 06 Apr 2020 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JXoqzYzLIC3HrCv8vGdYmXOyoyfoEov4G2A1bmXZ20=;
        b=D9ZOrLIetSDZnCJTTM9zng7QJ3DDJPCZe2Mm3mEs46k8iZXhGisG4DnOVsSZR3GAse
         BHFGoVJCrHXT74p3vRpy9VUQkihmXEbevEoVAVB0FE4qOVlh27M641YBw/KAejoyfNbK
         Hqje3oAgs4uHmGQorr+TdYBkplSFvlWxvvUsNFU6ZgZ5pCzMBE4lmUjNCgLH0l3otQWG
         fSdHerh/y8vIvlmRoEoThb8Y3es/AHoY3Aox4F1U3kPrRzDlbZjm2rspR0eEE1EUpPZO
         IFze42OpFrfD/ya+q/NXjxozrOChY2abgSugfghI6NJ5lBHMD2lXUhIJO6s7wQ6TjWWu
         yW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JXoqzYzLIC3HrCv8vGdYmXOyoyfoEov4G2A1bmXZ20=;
        b=tPtvntky3nKhsxKK9MbyhPa2Zmuj6LpRA4sOwadPNZLv4uUwi/wZgmSdjB3kctxhlg
         RjredWpBjc78tFdRfrM0EI2hGsQmJlrrEZhKlZKWqs6Qj/8HUoISCyJ1kX2vGlzB6tiJ
         myBAvACTk7Ooc1LV9FHZER+X540gHu5+gMuQ2HcnOnx+fQVHMwwDtZCEl6n1GOK5avdW
         2oNRKb7irZFgkUOfSLSXe93KN3VGDRAH4TFreRaB0b1pGkEEuip5B4YWkDNR4Wb7P3jf
         WgExyBQywckoVgFgGEJOwQWOHkKY/jQ3jU8IaYJMclsUs6/97GtTsb3gSytiPnkC8HbI
         +X/w==
X-Gm-Message-State: AGi0PuZc069xlBbLE39XdbetsqgdW+8AdhooBHyeCdEg5ntKaAY7VabB
        hpGp2PlK1veJI1P9uMom3o6kA+UTahkszKOPCDXOHdjAQkQ=
X-Google-Smtp-Source: APiQypLNnHDZujZTJTpiHGYT9JZbdlvicmlk4ENHnxdkWhZoNN9zP2vmOzam5C22tguI5FtKiI1ElgkrLPri5ASUnjg=
X-Received: by 2002:a17:90a:e982:: with SMTP id v2mr401914pjy.1.1586195600993;
 Mon, 06 Apr 2020 10:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200406172002.18028-1-i.mikhaylov@yadro.com>
In-Reply-To: <20200406172002.18028-1-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Apr 2020 20:53:13 +0300
Message-ID: <CAHp75Vck19yEDsu7Sq9qMkzey+cRxw_zwFzYrh30YXJG=DqE3g@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] iio: proximity: driver for vcnl3020
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 6, 2020 at 8:19 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Add proximity sensor driver for Vishay vcnl3020. Only on-demand
> measurement is supported for now.
>

Thank you!

> Changes from v7:
>    1. forgot to add Reviewed-by tag.
>
> Changes from v6:
>    1. minor changes
>      1.1 remove VCNL_DRV_NAME
>      1.2 add braces in get_and_apply_property
>
> Changes from v5:
>    1. add get_and_apply_property function for optional parameters.
>    2. minor changes.
>
> Changes from v4:
>    1. add vdd-supply,vddio-supply,interrupts properties into yaml.
>    2. led-current -> vishay,led-current-milliamp in yaml.
>    3. add possible values enum list.
>    4. add bulk_read for result hi/lo registers.
>    5. add description of vcnl3020_data structure.
>    6. vcnl3020 id table is removed.
>    7. make "vishay,led-current-milliamp" optional in yaml and code.
>
> Changes from v3:
>    1. minor changes.
>    2. add i2c block to fix dts section in yaml.
>
> Changes from v2:
>    1. using regmap_read_poll_timeout instead of do-while in measurement
>       function.
>    2. change struct i2client* in vcnl3020_data to struct dev*
>    3. enable REGMAP_I2C in Kconfig
>
> Changes from v1:
>    1. using regmap interface instead of i2c_smbus_* calls.
>    2. switch from probe to probe_new.
>    3. s32/int32_t -> int
>
> Ivan Mikhaylov (2):
>   iio: proximity: provide device tree binding document
>   iio: proximity: Add driver support for vcnl3020 proximity sensor
>
>  .../bindings/iio/proximity/vcnl3020.yaml      |  65 +++++
>  drivers/iio/proximity/Kconfig                 |  11 +
>  drivers/iio/proximity/Makefile                |   1 +
>  drivers/iio/proximity/vcnl3020.c              | 234 ++++++++++++++++++
>  4 files changed, 311 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
>  create mode 100644 drivers/iio/proximity/vcnl3020.c
>
> --
> 2.21.1
>


-- 
With Best Regards,
Andy Shevchenko
