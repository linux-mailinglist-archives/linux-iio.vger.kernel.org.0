Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7589F565D51
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiGDSGk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 14:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGDSGj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 14:06:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719E3F5A5;
        Mon,  4 Jul 2022 11:06:37 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31caffa4a45so16967507b3.3;
        Mon, 04 Jul 2022 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qqTSmSTs0aYIriL0LLu5eeSeCZwpbBv95bGRsLdHLY=;
        b=GGkGfxJ/x7ukGeolZcUia6ImELyA2JsHfmbU+wmblz2nnMfnjJ8guqa3gS0hLRx7Kr
         wvlezYcBIvgnvXITqKVwujAAvqqsQCI02odloU80/1+K8lQZkL167lvvY/G8jWGesrDb
         B+9+zFzAsF4UHAFT9Fp9EeBnR9S5Y8p9EQA88QFRb/DnjNNRTDaQ2ulsXrgtMtDk6tmz
         fe1ncZGOC+7nTHa8dKAnPeoz5Us2EYv3srZ800DkDfOhYwkcwC+sutM2JaYwJFHntu9f
         q0/6B2lUXFpErZooFUpCz0cBe2JgAnD/Fp4S1L/z3qYKVERPF3dbIBcNexa8aL2B2lHL
         1EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qqTSmSTs0aYIriL0LLu5eeSeCZwpbBv95bGRsLdHLY=;
        b=Yfio3GTQ4iwBbqK0IWqQDihKwel4qbbB/gERKL88Kt87UdQfPelPXvjTZIv3xsI0xi
         VFBi+QHqkhjlKGyp2fHjGLbZdHqAc0arQOVOkcOK1Z0VR1fiafoZi1nfpF7dKJnuODzZ
         Asbc3S7fBilYZGALozZOmsRWxLVslMgunyQsNrzpuEPOeLCE/1SNmrXPFHu+jmH2zxB1
         6Cl/SVtyHjbp0U+uQOkaRsD98jTvkn48P82iqs1vI4JOMZjHKTy+vIDe1plC60aikHZC
         GFLoibQCLUS3y2DH8gR4ZIM3mzQYC93qYCP0J2PMi98QzykI5BCSqdiTjTjZtYEWVXyJ
         kQgg==
X-Gm-Message-State: AJIora+t52OkX68gHNM4fK0MNQmLxmKwG6nXHxZGTIuTOH3RqNai813d
        NRqvY0Wu6P4MtBNlxg8mLjd0zhdGyD1HruisLl4=
X-Google-Smtp-Source: AGRyM1urcljyXcHl3mE3sPqS9fywzQYMinA6kjEzst0et2Z94MITwQXZmAr2b2qC8F/0GtWQflSTIivqvg1KLaiPnC4=
X-Received: by 2002:a81:3984:0:b0:31c:b59e:a899 with SMTP id
 g126-20020a813984000000b0031cb59ea899mr2142095ywa.195.1656957996656; Mon, 04
 Jul 2022 11:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <b311ddc1f38c6baab99af97b4d3982d0b981198e.1656883851.git.jahau@rocketmail.com>
In-Reply-To: <b311ddc1f38c6baab99af97b4d3982d0b981198e.1656883851.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 20:06:00 +0200
Message-ID: <CAHp75VePKy73bWwBDJunDM6_ZNycs5pvkG9hG2-tE=WTnrOwMw@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] iio: magnetometer: yas530: Move printk %*ph
 parameters out from stack
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

On Mon, Jul 4, 2022 at 12:03 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> Use less stack by modifying %*ph parameters.
>
> Additionally, in the function yas530_get_calibration_data(), the debug dump was
> extended to 16 elements as this is the size of the calibration data array of
> YAS530.

Suggested-by?

-- 
With Best Regards,
Andy Shevchenko
