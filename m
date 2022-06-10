Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865154683C
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 16:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiFJOZ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiFJOZ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 10:25:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1901EAF2;
        Fri, 10 Jun 2022 07:25:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq6so40773732ejb.11;
        Fri, 10 Jun 2022 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSjDv+clKk3USTb3Rg73MniliGLlOX4LPm3s11QIvdc=;
        b=hBsFuVDraldmdKu8v7iI+Dv/AGT71N3Jjwp7QwmJ+vaZexjL128C46YmLMovhptDUQ
         kfNBUsDroQeP32ZyTw1vhUj6QovSrA30ZI3+iT+bNYcRo0i+yIV2FfcfSFHVj3psduVp
         bdelT/RUvhshnNoJC59GS6jsWDIgBjLKIFN86HNXlrzZQlUsRfXHfckMfFnmSYGQKZH3
         2dlzACe6MoqDdjETENQt6S5bzezLUwYuaWEIvJAixeNj+acZwzHs1BpXqdvEwU4xvKKA
         dDyV3ZvbGlnfx7sJPoHQ4/q3MLETtyEvezDO95SMEOho4mgZBguhE9LUqDdHdKSSuMCQ
         kxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSjDv+clKk3USTb3Rg73MniliGLlOX4LPm3s11QIvdc=;
        b=e3Uu/gbStExVaibiNAkMPE6TyYBSKmMb+uqYsXiymmcgFBNm37m7pfiefQn9tJCb1u
         /ImQKkCb8FI8Tb05mbFNpFb84YlKPdPA7Fk632NuFv383jCHXCGxO2N9kPWXRBIwTsbz
         eSbacKJSqxTdNPmak3t3qycG6e9WUKNeWd3krzVdRoVSQntiYVPlX/yVCjBDlN0EirVt
         imr3WOTDXhRQx3qn6d900ZQ4m9EEm7gkCecG/cF+OjXKU69cqSfa16KdkarXsCREAzZw
         bfyVEFqHIHQ4eYKyc4jDd/Ma4KqKA+fskTzuJ1tyxlL6Bru29HLHj+YGc+6udbsLbAzN
         XHLQ==
X-Gm-Message-State: AOAM531kC2NSdLOZO8NozhzfjPkAToCIAzCtHmTlGpjuGhRJCCOvnRWI
        WAQxbII5K6rBl4Q5dq+3a8dnCt/UXVEyFcP+r2I=
X-Google-Smtp-Source: ABdhPJzjjNuGQ2Q9J73lU7SX2/EvzGoJgmk8pwRudNBI3mlZD9cUgVaYvcTli0XeXn4AwO9RPpL6/o6AVjXVsWj21VE=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr22936721ejb.639.1654871123687; Fri, 10
 Jun 2022 07:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <5ae4b9dda3032acba8b8b0e39352e9e3953e3f88.1654727058.git.jahau@rocketmail.com>
In-Reply-To: <5ae4b9dda3032acba8b8b0e39352e9e3953e3f88.1654727058.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:24:45 +0200
Message-ID: <CAHp75VcaVjOK=EK_x3qA6hPadw3t68VOw1xQC+BQOjRxmUKeqw@mail.gmail.com>
Subject: Re: [PATCH 6/7] iio: magnetometer: yas530: Remove redundant defaults
 on switch devid
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
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

On Thu, Jun 9, 2022 at 1:44 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This is a preparation for adding YAS537 variant.
>
> In function yas5xx_probe(), there is a switch statement checking for device
> IDs. If the ID is unknown, it exits with a device error. In later functions,
> it's not neccessary to check the validity of the device IDs again.
>
> When adding YAS537 in a later patch, several of such switch statements will be
> added. To make it more uniform, the redundant ones in YAS530/532 get herby
> removed. This is done in a separate patch for better history control.

...

> -       default:

Please, leave it. Some static analyzers or weird compiler versions may
complain on this.

> -               dev_err(yas5xx->dev, "unknown data format\n");
> -               ret = -EINVAL;

> -               break;

So leave this.

>         }

Ditto for the rest.

-- 
With Best Regards,
Andy Shevchenko
