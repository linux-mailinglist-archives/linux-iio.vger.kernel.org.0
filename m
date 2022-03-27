Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1644E8A63
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 00:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiC0WPF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 18:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiC0WPF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 18:15:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A21496BF
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 15:13:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h1so14984307edj.1
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 15:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDySBlxQ+Nz0DTmu06UDJZd80+mN/K47Fg5Hb87k06Q=;
        b=AtRNcIcdBf8OmWFWjk2KgfzbTK4GgCAtpWwMyk27L3+mdp9VedBy8t/yZisZ6vf5fR
         InO9avLPCirHiwGcdfXPSj0ZoDsZ7248jb1FzcVV5JR4hkhFP1Z/zwwxF5osBjAVAvf7
         G2qBTz3tk8GE2I/grcpBGUHX9Mkk9nl6fOibthigGQpwxpaQMrbIkW1c+Ejrt5hDKdlf
         DJfMBGIld9U6x+F/MQZZaCBvwJkDMMbsweP+k1lQbRbam9BbEYpXSJwP0zMyppugW2i+
         vJ0wDZXZ0ccF4X2RWPnOtH0ldyEc0LeB2UjD93qDl5owrjYJQ0i4gOYcdI8/PNIT0TNQ
         xBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDySBlxQ+Nz0DTmu06UDJZd80+mN/K47Fg5Hb87k06Q=;
        b=rDVMr1qIebdmwjNsZfUlEgg9Q7sO7e09Tv8+AA1UrcHK1UXIp1shG8eQ85aHFlfPmQ
         N5l3BE9yrMOa2iI3J9HebIBLYQEj7Sb4tnqcwHzomXUx/Oqa7RFZF6iGU+s1wYcoRBnx
         nSvd6L1o5SuJzKG216jrMe52kZJGOnebbHmovGgQfOEU6FYPowuqDZ3hQS801vDrvd5y
         dzEsBjD4C9zNF8rTI5qAZxABVYHC6qqVTk+RUW8tWFqk4PcK7k69OBNJn358BlA8HD1I
         fFi7JwC2SRUZAnqy/Uo1oSR2rzJPPm1f151mCsJgrMtG8DOuJIDQCIx2/PxZbiznmtoB
         qxHg==
X-Gm-Message-State: AOAM532yJsUHKwsyopj8RmKmFxa+qjOYR4lXX5KUsZvVG/3mSKIsPOiB
        +eunoc7igRpcR549/1vywCdkWBdnW2U+FVQyhPI=
X-Google-Smtp-Source: ABdhPJwc2o1hZEh9N+C7bvlQoYwoGN9nJwwrVtgdpEYtZPbc+QheA5SI1Icq72pyrg1/FP/FAYUfyTihT9kjS5t3MJM=
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr12651490edu.158.1648419204748; Sun, 27
 Mar 2022 15:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220324110157.13143-1-jianchunfu@cmss.chinamobile.com>
In-Reply-To: <20220324110157.13143-1-jianchunfu@cmss.chinamobile.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Mar 2022 01:12:48 +0300
Message-ID: <CAHp75VfT6rXihJrqVGLTs-pUbOueXh8z8on2PZAGpk4AHxU2og@mail.gmail.com>
Subject: Re: [PATCH] tools:iio: Fix the potential stack overflow risk
To:     jianchunfu <jianchunfu@cmss.chinamobile.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Thu, Mar 24, 2022 at 3:15 PM jianchunfu
<jianchunfu@cmss.chinamobile.com> wrote:
>
> Add judgment to fix the potential stack overflow risk.

>                 trigger_name = malloc(IIO_MAX_NAME_LENGTH);
> +               if (!trigger_name) {
> +                       ret = -ENOMEM;
> +                       goto error;
> +               }

Isn't malloc() sets errno? Why not use it instead?

-- 
With Best Regards,
Andy Shevchenko
