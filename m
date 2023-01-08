Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309636614DC
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 12:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjAHL7F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 06:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAHL7E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 06:59:04 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99059F000
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 03:59:03 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id s25so6086968lji.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Jan 2023 03:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YVxT2RdagP7AWEwWMUOaF45uDjcQyD/F4ZR4OQsnm+I=;
        b=HNGFu3RB/dRZ50PlvJGvbCKsAVdRFghHdt7jGg6zNcE/JfcmtC5UWXd8b0jim3jWV2
         djbQVrTyOG2mchp5xzgRvq/yjZFpMBB4or2yrfe15vPJOYP+ZfutKms6qUi/v5kNsS0A
         crErkc6AVoJ/z36DFzig97QthEDy+hyMWXEcG37BQNpn4UleaxWTptxkBmRdHeb8Zs73
         uHRjZMUK/jTweW1BNV0FJqmqMwB273/jfnU88lqL7Rl/QlmTCD7DUhMyr+G7TV/A4xm/
         i3R/kWB6B45mG1L3JsP8Kv4fIvaJm+/Co28MPk9uhd/GHRxIRP0IJS2AmNaGoCh5BLCO
         KWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVxT2RdagP7AWEwWMUOaF45uDjcQyD/F4ZR4OQsnm+I=;
        b=EsTNRqqnXtj+WqwL1G7O85rT8ISfxqQXyLICWzEtM6bQPOpS6aT7C9Ai8m2CRbEt3f
         pIGKtmNVCo17MXGzN3gz7oMDZRnMQ5Iu0MFW42rlWsJYQ+yuSYWDcyHnnwk90/0mN9F6
         GiwwzYrKE1o1upRjucWAPVpnSZ1rVPI45Mk+2KFRlymwZm3op5q4+vgRltzJycNE4omg
         cp2iAXUHHkolM9/YEJFXBoFHc3NnfQqGpXuKZn8d8yF+lEeI/2wWuMgkSxPQZB8WuYQj
         LUrNBkJhUx/MYlRvDhkIfkfom1O+orNB25Kgc8ZmJMFs7cmf77PMGUI/iGv4ACL+jmn2
         s8WQ==
X-Gm-Message-State: AFqh2ko0Dnyb9nNuwpzJUUgOZTZjwNaFgR7d5B5dl9R1dHQX9H4walYq
        LDlD9h2E0LhlNKwMXnslwvZz9ebL8wshqp4Zhsiqd2sImK9DJDdH
X-Google-Smtp-Source: AMrXdXtlgXyqjxcRg9JXA+yGF+TeZDerpRFnrEO3eDmG4VrhhmvQS99gvCdu7yhZkRE6wOnvN2dSDFP6v6FoLdamvqk=
X-Received: by 2002:a2e:7a0d:0:b0:27f:d911:acf9 with SMTP id
 v13-20020a2e7a0d000000b0027fd911acf9mr1471308ljc.23.1673179141707; Sun, 08
 Jan 2023 03:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20230108074750.443705-1-pbrobinson@gmail.com> <20230108074750.443705-3-pbrobinson@gmail.com>
 <20230108113046.461ec222@jic23-huawei>
In-Reply-To: <20230108113046.461ec222@jic23-huawei>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Sun, 8 Jan 2023 11:58:50 +0000
Message-ID: <CALeDE9M3jLKbGoLCfyBVACJpuHwkiBPO9rrdggTBoQGuKLd1gA@mail.gmail.com>
Subject: Re: [PATCH 3/4] counter: FTM quad: Depend on the Layerscape SoC
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 8, 2023 at 11:17 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun,  8 Jan 2023 07:47:49 +0000
> Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > At the moment only the Freescale LS1021A is the only HW that
> > supports this IP block so add an appropriate dependency and
> > compile test.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
>
> Ah I see you had deliberately not put COMPILE_TEST for the x86
> one - fair enough I guess.
>
> For this one, the IP is fairly generic and I think appears on other
> chips - not sure they are supported by Linux however.  Maybe it's
> fine to limit it like this for now and see if anyone shouts...

It's currently only referenced in arch/arm/boot/dts/ls1021a.dtsi and I
don't have access to all the Layerscape docs to verify the IP, no
doubt there's others but they may need other changes for different IP
revs etc hence why I specified that one.

> Jonathan
>
>
> > ---
> >  drivers/counter/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > index 011e6af840fc..ef78386ccd2e 100644
> > --- a/drivers/counter/Kconfig
> > +++ b/drivers/counter/Kconfig
> > @@ -31,6 +31,7 @@ config 104_QUAD_8
> >
> >  config FTM_QUADDEC
> >       tristate "Flex Timer Module Quadrature decoder driver"
> > +     depends on SOC_LS1021A || COMPILE_TEST
> >       depends on HAS_IOMEM && OF
> >       help
> >         Select this option to enable the Flex Timer Quadrature decoder
>
