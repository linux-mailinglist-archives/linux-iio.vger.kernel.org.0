Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F35754B57F
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356984AbiFNQMy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357039AbiFNQMx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 12:12:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251672871B;
        Tue, 14 Jun 2022 09:12:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x62so12336109ede.10;
        Tue, 14 Jun 2022 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjc7Yr/ErA3zp8OTbDL5CmDnRX1voumk9vLY3Tug8DQ=;
        b=EGmBu0R0JyubwoXTK1QexYyYlgjuu0lOVroA0GqrOJxfVvX7a9plLRn5cZMPNuv3lE
         NuCLj0+JA/Bu9cfvwgr+FUIdTznZ7WQw3OEC6Xx9arg0rYKEQOIvvA5SX1Cci7pYw4V/
         TzV0YeoE+cVeUbpHYXItfoo47CM7R8MquVEW+IAfEqHK5/y3OBgfctemtPZeFB3b4P3n
         Tw3WF3rVjRJdXbhyggZf1S10npP3PxzEM+CtHB3Q2TkOLP2LbIcVB7gB7RcSpaeGn74r
         QHUpZVyMEk6Fu4eKJr8wCGgB8dV0MJXCJ8Tw44DT15SvY3MxdO1e8k14Twjwu1VyRYbW
         r7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjc7Yr/ErA3zp8OTbDL5CmDnRX1voumk9vLY3Tug8DQ=;
        b=LBCKHUKboRCW1IEGWWlBBNcATrobsgeT64E9XvIWrfKaqHkCowlbFSexxwnpDgqX7t
         rTI/t537t37Fj3JsbEHxrghfWwlSvbfSnfj+Vu5NeQgOeB7QrzlHWKKXno6KMSLr2Asz
         PxMIoByZE986htC1GFPzmDoKsWlDyrr69T9o4BEVHnTQ403hVf/TKFFz2J55Qm3v/3M3
         ZlzJm9Pkfb8lKN0FEQHB7yh/lETnPMvtmlshTbg11vUtPxCPvfu5/Q20QoUfeSHyibqB
         zgvhNEhQ3kcdQzHDXgLO+iMdxswHWjnYYYZV17Tf6GPj/18zvABck+/f2Vf6XW/sFVRn
         ehKA==
X-Gm-Message-State: AOAM531400GtexEwI2n9yTEdfViXBwWLIefSafx8kYfCezZ6Mz+s7ALp
        9DYorpKUZUZpQNBLkircP3TjFf+Jvdl7Pbf6yEQ=
X-Google-Smtp-Source: ABdhPJyiUXZvGGc032b6sj/qHxGWFTDMztNL0Ct+5us5gcLF/orDegpHW1e/1c4NfcOfozDAO/s2h9vLcov5eRauY8Y=
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id
 p3-20020aa7d303000000b0042dd1924c41mr7087360edq.178.1655223162056; Tue, 14
 Jun 2022 09:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220614151722.2194936-1-sravanhome@gmail.com> <20220614151722.2194936-5-sravanhome@gmail.com>
In-Reply-To: <20220614151722.2194936-5-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 18:12:05 +0200
Message-ID: <CAHp75VffZ3u+mP=wqThbiFAaDk7u=O-E5qhTWD_HAxv0PN1Q_w@mail.gmail.com>
Subject: Re: [PATCH 5/6] power: supply: Add support for mp2733 battery charger
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 14, 2022 at 5:17 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> mp2733 is updated version of mp2629 battery charge management
> which supports usb fast-charge and higher range of input voltage.

USB

...

> +static int mp2733_get_usb_type(unsigned int rval)
> +{
> +       int type;

Unneeded, just return directly.

> +       switch (rval) {
> +       case MP2733_SOURCE_TYPE_APPLE_1p0:
> +       case MP2733_SOURCE_TYPE_APPLE_2p1:
> +       case MP2733_SOURCE_TYPE_APPLE_2p4:
> +               type = POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID;
> +               break;
> +       case MP2733_SOURCE_TYPE_SDP:
> +               type = POWER_SUPPLY_USB_TYPE_SDP;
> +               break;
> +       case MP2733_SOURCE_TYPE_CDP:
> +               type = POWER_SUPPLY_USB_TYPE_CDP;
> +               break;
> +       case MP2733_SOURCE_TYPE_DCP:
> +               type = POWER_SUPPLY_USB_TYPE_DCP;
> +               break;
> +       default:
> +               type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +               break;
> +       }
> +
> +       return type;
> +}
> +
> +static int mp2629_get_usb_type(unsigned int rval)
> +{
> +       int type;

Ditto.

> +       switch (rval) {
> +       case MP2629_SOURCE_TYPE_SDP:
> +               type = POWER_SUPPLY_USB_TYPE_SDP;
> +               break;
> +       case MP2629_SOURCE_TYPE_CDP:
> +               type = POWER_SUPPLY_USB_TYPE_CDP;
> +               break;
> +       case MP2629_SOURCE_TYPE_DCP:
> +               type = POWER_SUPPLY_USB_TYPE_DCP;
> +               break;
> +       case MP2629_SOURCE_TYPE_OTG:
> +               type = POWER_SUPPLY_USB_TYPE_PD_DRP;
> +               break;
> +       default:
> +               type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +               break;
> +       }
> +
> +       return type;
> +}

...

> +       return sprintf(buf, "USB DP %u:DM %u\n", !!(rval & BIT(2)),
> +                        !!(rval & BIT(1)));

sysfs_emit() ?

...

> +static const struct mp2xx_chip_info mp2xx_chip_info_tbl[] = {
> +       [CHIP_ID_MP2629] = {
> +               .rfields = mp2629_reg_fields,
> +               .chip_props = mp2629_chip_props,
> +               .has_impedance = 1,

> +               .has_fast_charge = 0,

Unneeded.

> +               .mpxx_get_usb_type = mp2629_get_usb_type,
> +       },
> +       [CHIP_ID_MP2733] = {
> +               .rfields = mp2733_reg_fields,
> +               .chip_props = mp2733_chip_props,

> +               .has_impedance = 0,

Ditto.

> +               .has_fast_charge = 1,
> +
> +               .mpxx_get_usb_type = mp2733_get_usb_type,
> +       },
> +};

-- 
With Best Regards,
Andy Shevchenko
