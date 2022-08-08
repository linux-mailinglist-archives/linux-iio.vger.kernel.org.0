Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7E858C779
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbiHHLXg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242764AbiHHLXf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:23:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4841AB7D6;
        Mon,  8 Aug 2022 04:23:35 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id u12so6236192qtk.0;
        Mon, 08 Aug 2022 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+2krzwmHahgUXNORuk3B+a6Vitl3Ogzono33OEv+W8A=;
        b=l5TeFUP+ySylr342GqGyF3uWd85sUUsmdA8JnRcjx6eXsRya1WltlCpK/8gMOe5A/V
         YsEs6iotz9xgzDsCPPC6HwvgoQsR+HQDLMjhqvvVZ1qsmZl2tQ6iVY3CvKw0WFac6SIB
         ZgmgD9w4Ei0UpYs69+JEoou+mxdA2qYdLuA6mIahkJVosaNt/lg6Y63ufyhxHN45lMge
         w52J2C4uv8l2trO3QJGvNkQYVooenxXIZ13o7bp9kkTW+B0EkGDso8jSifobAufbCwnp
         f4Y0yx8CeJIJ4nzEr2GlCW3lJ90EsswmstXwqA2OWr7i2Mwsfzf3zP7eU+wkVnYKTyQT
         f2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+2krzwmHahgUXNORuk3B+a6Vitl3Ogzono33OEv+W8A=;
        b=GWpF+77j+mUostlFP0Z/QtnMAmaIY0kBgKO7r+/9kRpLXq7Jj8R1J/oBK9E+e1UWhc
         9otXZ6EdCGDByMK5F9qNeJNVnLFjxZai+kfvvryKwDY3FBMUNdEIUmQ8jDoct3L8kIed
         +P2pHnDNlDA+cX2BwSB0K/uloLqJWgp7z/e5mlQYEo2/eFS2G0JCj0kXKIl+8VkgWFEY
         sMjw9XStseTRCTQn9rbVxpYt/XOFfHJYQfPlGyT2yB+/t6Hg8KW2bLGbNKca19g8oOdg
         shvPdIDoYhqJMG+r6XaQoJdMOoeCuu5y+kXSFiPoOLBRryiTjf6cglsLaX4IdoZE5d9+
         J2pQ==
X-Gm-Message-State: ACgBeo1GVLrS6qpSzD2xfmiczty3pF08HQj0Qo8nIZZX++yXommJeczz
        Zn8Ar8DQfN0XFOHCID2sKCepehgAJYR75tyJ238=
X-Google-Smtp-Source: AA6agR6YjW392Efoz1a0Rf5WLEeI9NpPi+p2DApTDKk6IDVRkFNma85RJUjnPHDH2WFpv5ekKCFn8ehKBnrb9K58PP4=
X-Received: by 2002:a05:622a:14d2:b0:341:9fcb:79a6 with SMTP id
 u18-20020a05622a14d200b003419fcb79a6mr15167469qtx.195.1659957814320; Mon, 08
 Aug 2022 04:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659909060.git.jahau@rocketmail.com> <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
In-Reply-To: <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:22:56 +0200
Message-ID: <CAHp75VcS9y=cp6+G-QweVpQ6+HdEJHuMx3dBug+aSyfae-Ra8w@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] iio: magnetometer: yas530: Introduce "chip_info" structure
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
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

On Mon, Aug 8, 2022 at 1:07 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This commit introduces the "chip_info" structure approach for better variant
> handling.

Read "Submitting Patches" in the chapter which mentions "This patch"
pattern and fix the above accordingly.

> The variant to be used is now chosen by the Device Tree (enum "chip_ids"),
> not by the chip ID in the register. However, there is a check to make sure
> they match (using integer "id_check").

...

> +enum chip_ids {
> +       yas530,
> +       yas532,
> +       yas533,
> +};

So, it's an error from Clang... Workaround can be simply to use set of
#define:s instead.

...

> +       if (id_check != yas5xx->chip_info->devid) {

> +       switch (yas5xx->chip_info->devid) {

You can make these kind of lines shorter by introducing a temporary variable:

   struct ... *ci = yaas5xx->chip_info;

-- 
With Best Regards,
Andy Shevchenko
