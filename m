Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A28565FBB
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jul 2022 01:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiGDX3b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 19:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiGDX3a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 19:29:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B80521A5
        for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2022 16:29:29 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id d145so15846504ybh.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Jul 2022 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYfa5SW60uxPFfpBGnze3FVN0xAr6cm6zrVNUcZRHEM=;
        b=AWcB67cILo/HS1hZgAzwpw7SGHAwg7RMS9Yb15/eVWZzDLYbgErMSIpmG3BBU/+wk8
         VM7jPaOh5XGogBh7lbr/giIa7Vme66rv/fuuN0qjpSUmuG7TtT8powmobzQ70XSSXJr4
         /9G/JY+SjqvuOLDNd+xxpU7UUrVTlnTsF0bnk09REd+n6M2val56bZJ8SFc5y8kgUaP4
         fOLTjjy0ka7xWun9Fb5EeQidBVSon2GOYBS1ExT5n/3QG/auJUubvK6fpOcI17xztGR/
         mB2VU7RSC9A+Zhqomnnnsl6S6NeAbqcavBg9ZfcmVZdl/i/RYkavuYm2qlLeYWZy/BoO
         jrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYfa5SW60uxPFfpBGnze3FVN0xAr6cm6zrVNUcZRHEM=;
        b=6iHU3TZswMPzKZ8s3B4dEKrhB0x2gc6dZR9BncIEkP5g3s7c5O3jhHdegHMTm0GkiO
         2s+qoP3t1BZVBy8/9g7nVKwqxr52GLZmghnLyiswqTKMlS5nO5R87wSi85yr9irNPwa5
         ENuAupN7LOxWvtU5zlmbVCaJJvfSnzgcyAEfSiVyDa3mQ9PmwPP+LVq7wx38ABTkgiRG
         LVRxt08VaFyeUMKdflAb5U0AeeqdqzzaOxVc4IReFV++itQLol7lx7TpqPxXrCq5muas
         r1sPnQCoK37ZkxRGdKCfmXcnFrBrK3VHNTi24LEABSNfyr8aUMXuhNbCcClTww54Rc1x
         XAuA==
X-Gm-Message-State: AJIora9TyZBE44ZEcf7sBOPtT9hZpYeEZ3EwqUvB/8XPPESe/+ImpgE+
        HKgN0p+0L9DPh8B4aHJloIaOo3/hufnNL5cqUX0CQA==
X-Google-Smtp-Source: AGRyM1vCHd+tMIgnTmjocJ+aqdEL7YLE2lS9emkkzZMxS+vgaMFBtO0bt+SgFXq+LLqP2D08Wls3VKVq9J1gAL9Xwog=
X-Received: by 2002:a25:fe04:0:b0:66e:1f8a:8e89 with SMTP id
 k4-20020a25fe04000000b0066e1f8a8e89mr17796826ybe.514.1656977368400; Mon, 04
 Jul 2022 16:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <8a1fb0faedc25aa2fbf9852cf4e1d9d085675ad6.1656883851.git.jahau@rocketmail.com>
In-Reply-To: <8a1fb0faedc25aa2fbf9852cf4e1d9d085675ad6.1656883851.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Jul 2022 01:29:17 +0200
Message-ID: <CACRpkdZ3PMff3hrZrHJaKXiacy1KZoKBZmRwte3Kp27G2O+8kg@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] iio: magnetometer: yas530: Apply documentation
 and style fixes
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 4, 2022 at 12:03 AM Jakob Hauser <jahau@rocketmail.com> wrote:

> This commit gathers several minor changes.
>
> In the device examples, "Xiaomi" is too generic, specific devices should be
> listed here. E.g. Xiaomi Redmi 2 seems to have YAS537 but it's not fully clear
> if this applies to all its variants. Samsung Galaxy S7 is often quoted in
> conjunction with YAS537.
>
> Removed defines for device IDs of YAS537 and YAS539, they are not needed so far.
>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
