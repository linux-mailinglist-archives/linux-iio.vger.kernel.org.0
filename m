Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7354CA0F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353788AbiFONoT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 09:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347532AbiFONoS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 09:44:18 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3432C677
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 06:44:16 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x38so20574757ybd.9
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hp1aAAlFAq4/A1NH4phA+P7Vi5cvcSnxaSA1EwmzOjs=;
        b=lVfAk6c7MPyRfXkCYOWdVQURkSp+OBByvpe056Tgq9IMl2OauUoGqFUnhviTFb2AA7
         tXjeTRjUn04Ib4a9agWf/BW6v1+t9bnOMpPlIk5o5CFJmoXlocEzwCkrP+0K5pj/nEPH
         aDv8LKc+BLj2jMBaKCSoMqp253iGg+GgWOMTUrh92DiDz2nN3xzGtbNEigp2bT+lUZwW
         myZ/G45CpWEsSYjoHFTMDx2qQGWMl0eg3K0p86rOSedi3yBGeh1pOi7P0mhvV/S4b3sG
         U4p5XmESE0mUSpPZZhUtNh3JDlRWOYlEHyn8IXpD9Jk95y29uBi8BBDPzbsRgbpO+vip
         xiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hp1aAAlFAq4/A1NH4phA+P7Vi5cvcSnxaSA1EwmzOjs=;
        b=yUzf2yfA/U/G0jNYrbgLIUMaD/2vJvufIHURXsb6AevvawHRqVnce/X0iaXLOl4jCY
         H8I9LgXUhLbV9dwWWUVjWLL4enVRIeSxLc5p4YZD4VyV0cu4Ec0kmvgrEz+sZVtbMD3i
         61XF2LUIDoue3+X65uFD7XHSt+RJkX2GmFDELKQWNNKao/rHFNW8pRvdRWjw5dfpjF60
         kLSd1Oa1MLs8CwbDxvLih3iih3G7OOShJTJ7Ocxwvj5+q+39YYccOan8+YB7/gIArB3D
         Pr4UbKO1wro+subgg1+Gi/aYmQEOH3MPViBgk9g7INfF5e/J+n2xq989ktcCXjPQk3uh
         cHBA==
X-Gm-Message-State: AJIora9FkrM8UdWIi5VHTY9amRhF6ODAWmrfdu/uXMzJDgsJHqesq2NA
        tYcqYEGb2Gczsr2+nn/vOH56rx5nDaL0vRqV+F/mE2WHj7I=
X-Google-Smtp-Source: AGRyM1vwXQw90on1sHsRQC4/H0k1Bofmho0MnG9UWhioWNDMZYti404KFNThV3NhBXgLu5NZbUKp/nAL98zAv6yclsA=
X-Received: by 2002:a25:1256:0:b0:65d:6433:7993 with SMTP id
 83-20020a251256000000b0065d64337993mr10084424ybs.626.1655300656100; Wed, 15
 Jun 2022 06:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com> <20220603135714.12007-11-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220603135714.12007-11-aidanmacdonald.0x0@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jun 2022 15:44:04 +0200
Message-ID: <CACRpkdbObQ5WrzVC_xYobJPSBVSMyaz0HHXesLP+g1HCzCGJtQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] pinctrl: Add AXP192 pin control driver
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Michael Walle <michael@walle.cc>
Cc:     brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 3, 2022 at 3:56 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:

> The AXP192 PMIC's GPIO registers are much different from the GPIO
> registers of the AXP20x and AXP813 PMICs supported by the existing
> pinctrl-axp209 driver. It makes more sense to add a new driver for
> the AXP192, rather than add support in the existing axp20x driver.
>
> The pinctrl-axp192 driver is considerably more flexible in terms of
> register layout and should be able to support other X-Powers PMICs.
> Interrupts and pull down resistor configuration are supported too.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Looks good to me (TM) but I'd like Michael Walle to take a look
to check if this is one of those drivers that could make use of
gpio-regmap.c CONFIG_GPIO_REGMAP to make it even
simpler.

Yours,
Linus Walleij
