Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D6D58C78B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiHHLcs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHHLcr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:32:47 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9E5EE37;
        Mon,  8 Aug 2022 04:32:45 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d8so1554105qkk.1;
        Mon, 08 Aug 2022 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QYlJekI9VvtrD5jrayQNhLL5kl7tKesHj1vgz7DRC2w=;
        b=Z1B2Kd6wSRPSh0JJY5XQozB8SUKE4BD72AgyNlVx3bPq1Gmp2M+IEhoX9k19WU8isj
         +wDoecdBuSyGDyl/ynsjNlPt/vZUcj3eN86uNYdPWl2r2lSj0UtbO3CIJ6qCNTCkILsD
         07Id0LAEKOs14bogDKMvAe4zWJ4d9T9z5nAqfybjyUuhlJuiGGf/u3EfSz+uehi6CJuX
         AjWkrRuxTkz5oVDbP7sNgeZWUa9N2YuuVWC1KhHNyS6odwJqaHb5xAIl6iRbplS0TGCs
         EaLq5N7hl+1MHaigfOdZn8XN9aMP1MFCFA5xNsc8QRe244PWGpYanbiXJkLwwSlM0lSD
         06vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QYlJekI9VvtrD5jrayQNhLL5kl7tKesHj1vgz7DRC2w=;
        b=V3uZGfYcIuR6hNJBuLHub+OIYP4BNKu0dfGyl9TlN4kCj2wersnNJgifM8/kUBXnPW
         EE9hkJNiJF/vuqE940hfV8t+a1dzr/8o7AroWd5lg7IVo2fh7brP9Hswh0/AJikNpp0B
         hO4woO+4oKsJuGDY5gVdjCd2e8rAQhwGZNBrwSDtGNF3Y7u16FywaY5wrMPAdamQ4sWq
         UcBF9BvrrC05GDDKAGj02irAbvlU3BTPixwofYiF6Ctwu93Kb+h7jHryW5WpcdNFCt+Q
         b8oGuJzmgD42zQF8v4g5B/t58SNJpWKQBWWBEvDTEqiT6onYWBeqH8ZELk8YG67jFAnJ
         JRlg==
X-Gm-Message-State: ACgBeo1GjsZXTcJcj5IbBuvQH0RR9iGkAotDtWJcv8rRw62dP5T/C6Lp
        ZgVo/BQyzfgW/cEsZVLnJQbiwwlbMd+t+GQeweU=
X-Google-Smtp-Source: AA6agR7UhEjgKFe/6ud5Tmv6VCdBzS3g3R9Tx7aN2/IbC0PRXiqUWslxsNWuGe6nIK5Eb3ivZG1CZLHPxj2K8MMR1R0=
X-Received: by 2002:ae9:e88d:0:b0:6b9:4a0b:cea5 with SMTP id
 a135-20020ae9e88d000000b006b94a0bcea5mr3439839qkg.748.1659958363803; Mon, 08
 Aug 2022 04:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659909060.git.jahau@rocketmail.com> <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
In-Reply-To: <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:32:07 +0200
Message-ID: <CAHp75VdfketWiZc+72TLdabMN0Vw7VHBveGfVp8OHH5bzSkcrg@mail.gmail.com>
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

...

> +       yas5xx->chip = id->driver_data;
> +       yas5xx->chip_info = &yas5xx_chip_info_tbl[yas5xx->chip];

I don't see how ->chip is being used, I would expect it is the part of
chip_info, if it's really needed. That said, please make it directly a
pointer, so the above becomes:

  ... ->chip_info = (const struct ...)id->driver_data;

...

> +       {"yas530", yas530 },
> +       {"yas532", yas532 },
> +       {"yas533", yas533 },

Read above and here:

  yas53... ==> (kernel_ulong_t)&...[yas53...]

-- 
With Best Regards,
Andy Shevchenko
