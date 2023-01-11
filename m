Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0171F6662F5
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jan 2023 19:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjAKSpK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Jan 2023 13:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjAKSpI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2023 13:45:08 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC281EEF6
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2023 10:45:07 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s25so16975727lji.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2023 10:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC9VszkUjzB46weASVJAm/C/PX8Y6M6iqGSqwUkZ5lo=;
        b=DbaWY22Fabiuo9vgRpxxk0bsZCAX5+H5VdZCXvFJpykaSGmU0kAgSmQWHkujzCgiIy
         e38l88/Lex+840OrV64AAM8dCAbRgzCdtEQFR3Cis3vP5p1swt1ryu87bzRYjD5rWVxm
         GUZ38imgTXQ542gIuIgZAssB80gCcYNNiW6mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC9VszkUjzB46weASVJAm/C/PX8Y6M6iqGSqwUkZ5lo=;
        b=UVDR/NXP6Wrsq3Md2zwSsHmZawaOFQf7GJ4Mq1QAHu9b7GEV860P+AduvlvKhiWNh3
         m2ILTgi8q1kUfEElM40z2uyucVE3PiL0LAG0QFod7e18jyCyiwkEaCTbLE2Gak+fSCcn
         KRPHgzJWglKprqcYx2vPsi+0RlhWYN+MVc3cnusaY0jI+YQgICW1pNz267FrlXpbw5+Q
         lBPpayS7oRlr1E7ZaigUUnIA+3kBB/AQvGPlkSwvc7zWXstUA4aWE8MvnelHS/sYU8xj
         kc1jx5OmZ4x7AjpO5GfYG49jPL/EUiJeG5XJPn7cjnjA3OBpf+SrVVBMeJ6I9ezEtQzK
         bFMA==
X-Gm-Message-State: AFqh2kqsoPry1YfRsaIe4rlaDjQXgvIG8DxkQVLoQR2IkDBKSHLcoEgW
        9i78gJKoTpA33+LM4s8VBN4Okbh5OCQ8Tkqpm7Qc9l6VIdDDxA==
X-Google-Smtp-Source: AMrXdXv6jd0itdjCeR5hRW4GukynGQhPUyfqtsz0R4iW64BCjoP8ZSWrSLZ6/Rus8Jm/j688SCmC3EWLysKsYWCZiFc=
X-Received: by 2002:a05:651c:149:b0:287:4eeb:53dc with SMTP id
 c9-20020a05651c014900b002874eeb53dcmr353396ljd.27.1673462705400; Wed, 11 Jan
 2023 10:45:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jan 2023 10:45:04 -0800
MIME-Version: 1.0
In-Reply-To: <20221220193926.126366-1-gwendal@chromium.org>
References: <20221220193926.126366-1-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 11 Jan 2023 10:45:04 -0800
Message-ID: <CAE-0n510iX=_ZGS06ckHdLdRTYJvbHhdQO80iw6yRAjTw+CDHw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: sx_common: Add old register mapping
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-12-20 11:39:26)
> Older firmwares still send sensor configuration using a list of
> registers with opaque values defined during sensor tuning.
> sx9234 and sx9360 sensor on ACPI based devices are concerned.
> More schema to configure the sensors will be needed to support devices
> designed for windows, like Samsung Galaxy Book2.
>
> Support schema is: "<_HID>.<register_name>". For instance
> "STH9324,reg_adv_ctrl2" in:
>
>     Scope (\_SB.PCI0.I2C2)
>     {
>         Device (SX28)
>         {
>             Name (_HID, "STH9324")  // _HID: Hardware ID
> ...
>             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /*
> Device Properties for _DSD */,
>                 Package (0x3F)
>                 {
> ...
>                     Package (0x02)
>                     {
>                         "STH9324,reg_adv_ctrl2",
>                         Zero
>                     },`
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
