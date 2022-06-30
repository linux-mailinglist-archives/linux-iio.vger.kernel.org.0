Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1485617EE
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiF3K1q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jun 2022 06:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiF3K1Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2022 06:27:25 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C101E3F0
        for <linux-iio@vger.kernel.org>; Thu, 30 Jun 2022 03:27:18 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3178acf2a92so174336477b3.6
        for <linux-iio@vger.kernel.org>; Thu, 30 Jun 2022 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HNxB8VlKFnASCS1FopR17k/Gv2s9Xen6ldTXsI+bKrc=;
        b=hnJE0lAJyeZwPYGrsNV8L4oEbttpQ4QlFMXMW4YBzoCovt2Jl/FgbKSn2TyvjDA/gh
         jZ3XOS2o8JH2o95m6P5O+v/nAcGRHScum0XuDPeGpUqNchZK0gww7U9QRU1ujpDPSeSJ
         Y33Yo797S/sujoTAthiymn1Vv9U2TeQ7vG5Rb5M7gE8W/aTD1QESn+dJAt+jAFesuPsW
         SOsbxGyHumZbvUFH30/txir4jFcm6qg7wzsE/O/2TEwZt1MDCaOA1Uo5RP9O+fUQ/xtt
         kRQqn0dA7HOEwdVB75gOyheYFt3RU36ZxxWybhv5NEN/yVHLCtPdn5Mly7Tn2J/cKFje
         RkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HNxB8VlKFnASCS1FopR17k/Gv2s9Xen6ldTXsI+bKrc=;
        b=zrIAxnAEInT8nY2ZIQb1UxsNy4ulQc5tss9INQ0wXt/JI06ar79zr85Bm7aYQfOiFJ
         7PjXGl3A+a18178/BAOkSKkTxqlSeYGNh5tIha4/jQs3wxpQVIdeFL4+MeBlKhTYgR6f
         1COzZs+BVX4lgCQiV8JWKzdXlUlz56rFxcgQy/8bAdVmWltzp/BZTQFbWu+Yl5ofLfO7
         gbUeE/FZeyf3iA9098UJg8UTzaM3NBT4F9baTT6AYkaFZ1kwbz9JBVCF+2AaTQMjHs7p
         8aXmEQeykUz7syhFULgM72hHQJ58VxVi65QhAO84WjHS5mmqm5R2XUNbI7NzkYtSsU8g
         pZPw==
X-Gm-Message-State: AJIora/H9NzlG87zEbzyYd3D5+TMCks6T9pVG3g3hGiJY1dLjHWJ168K
        VJilYDO3p3d4aajeIU9Zamg41AGeKpJHH8Q4FKc=
X-Google-Smtp-Source: AGRyM1s1n9DcRQHdb1d/jDsCA1CYq3O6Tzmnp4GOUVCJsoMExwMjdPYbi8ux5TiBfcYMUt42X2ophGgJ9YoDC6pOe+o=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr9473738ywj.195.1656584837500; Thu, 30
 Jun 2022 03:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220630063528.205327-1-ukleinek@debian.org> <CAHp75VfCwQLApiQQq6FdjoXxdyArBW9e+kkXYsRDwxXT0c17dQ@mail.gmail.com>
 <1d4af147-46c3-010e-a9c5-e56044f3b624@debian.org>
In-Reply-To: <1d4af147-46c3-010e-a9c5-e56044f3b624@debian.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 12:26:40 +0200
Message-ID: <CAHp75Vf45tDDHYv4fyUsXbQhbseecFE7SAcTQxgozXbBbBZN1A@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: dht11: Improve error reporting in .probe()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@debian.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 30, 2022 at 12:25 PM Uwe Kleine-K=C3=B6nig <ukleinek@debian.org=
> wrote:
> On 6/30/22 09:17, Andy Shevchenko wrote:
> > On Thu, Jun 30, 2022 at 8:58 AM Uwe Kleine-K=C3=B6nig <ukleinek@debian.=
org> wrote:
> >>
> >> Don't emit a message for -ENOMEM, the kernel is already loud enough in
> >> this case. Add a message if getting the GPIO or registering the iio
> >> device fails and use dev_err_probe for improved behaviour on
> >> -EPROBE_DEFER.
> >
> > Why do we need additional messages?
>
> I don't understand the question. Do you really wonder why there is a
> benefit of an error message if a resource allocation in probe fails?
>
> Current state is that for Yves-Alexis (on Cc:) the driver is silent but
> unbound. I guess that's because gpiod_get fails, but seeing a
> confirmation in the kernel log would be nice.
>
> > They should be split in a separate patch, perhaps, with the explanation=
.
> >
> > Actually the rest I would split to two: converting to dev_err_probe()
> > in the case where it's not right now, and dropping ENOMEM message.
>
> So we're at three patches:
>
>   - drop ENOMEM message
>   - convert existing messages to dev_err_probe()
>   - introduce errors for devm_gpiod_get() and devm_iio_device_register()
>
> I can rework accordingly, but for me this looks a bit over engineered.

Perhaps, but they three are about different stuff.

--=20
With Best Regards,
Andy Shevchenko
