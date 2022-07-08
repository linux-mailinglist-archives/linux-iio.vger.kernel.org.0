Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF65956B6F6
	for <lists+linux-iio@lfdr.de>; Fri,  8 Jul 2022 12:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiGHKMP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Jul 2022 06:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiGHKMA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jul 2022 06:12:00 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0F83F3D
        for <linux-iio@vger.kernel.org>; Fri,  8 Jul 2022 03:11:58 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r3so37041423ybr.6
        for <linux-iio@vger.kernel.org>; Fri, 08 Jul 2022 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7IrPQOXHVSmidiZWgBlBPiRlvBMbx5W0QkyWauLkGc=;
        b=n7T0HsRHdR4b54siw5uQbBJnL4Wn/+JbLEkIvJ3rLlr/ByJ2Te+cNpB+TNLlJ9m158
         xh2uyIJJADf+z3gWvv3wMCL8h/9s2liOejXlZGR+zLrt9PpXE41o7a1pmrRPkeoUfYi0
         6g04nhdDN4oMOu5LLokxB3B8eUS4gCbkZTI+f5VoIIEI8RitvaGjx6a3BLq4GbMxSy8p
         ZhxgdrLPlQKycEX+M2nKQMymhIyf1cA+QDsBTQjP+k2XMsBXKneQsfUjgwu9fAMCcMui
         jiqhv47ltsv3LqRHOt+RAV0F1N1P1vY2+0XcHdwam5z4fZLXHE1zqL/i6Q9dnQFBDEf8
         EZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7IrPQOXHVSmidiZWgBlBPiRlvBMbx5W0QkyWauLkGc=;
        b=uXDvkLG8mRaK6Sfbv18LkGIoq1U66LDOpDQqiojKvTN0KJ7qlCiK5iI2qYmSIBF2wc
         fSOSSu/Bjs/BBnhF+gzeLPBXvwlPPqCuzKNDSw6uQg+yi/O+RRpkgZFSKxzzzQ20XJcZ
         /uo3JvXxkOoq69jwHJZEO80ci3HIXQDQIvBCVA2cTG0NXv5fMQDY0Bere+s1MFgSUrxd
         PRPabbNZ/vgb72mLRgoE16xjN5cvrRVD6WP9K4aVkh/bHqCAAGRh4rN3gzJE2EwSBk/J
         SKZiudEy90xrUNelCRsG198uDaDiBr0DD6A8214uxTkZ9bqYNVMy19OSD3QKH8d4Xxxo
         ci4w==
X-Gm-Message-State: AJIora/HW61hFZM7dSgwiNb7t8vCR99BQWvN/w570O+5wL9rJJWrTYxk
        6tIN/6dMyrLXnGuVRlqKc5zPBRREMdONvmUdeoo=
X-Google-Smtp-Source: AGRyM1sbc1dhPpOFwnyVt6kbzJOKpzuAsQLHyQQj9Mn84Dt8KmCTUKwA0b0P4s9zJrrM3mUNn3vRqP/VPWCAvMSHFIE=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr2753656ybg.79.1657275117401; Fri, 08
 Jul 2022 03:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220704105400.106-1-Ibrahim.Tilki@analog.com> <CAHp75Vc93yhKL+6FwfgvrV7QpDvP3OZt2LLZvSQcgO5PkYcaJg@mail.gmail.com>
In-Reply-To: <CAHp75Vc93yhKL+6FwfgvrV7QpDvP3OZt2LLZvSQcgO5PkYcaJg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 12:11:20 +0200
Message-ID: <CAHp75Vf-LMN=3HCPtrqxrS0oJDkwsMdQpJOa-KpnwTLFGoUY1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: add max11410 adc driver
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Nurettin.Bolucu@analog.com
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

On Mon, Jul 4, 2022 at 11:46 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jul 4, 2022 at 12:58 PM Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

...

> > +       for_each_set_bit(i, scan_mask, indio_dev->num_channels) {
> > +               ++enabled_channels;
>
> x++ will suffice
>
> > +       }
>
> {} are not needed.

Dunno, what I was thinking of, but this entire snipped is NIH
bitmap_weight() / hweight_long()

-- 
With Best Regards,
Andy Shevchenko
