Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0695578BCF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 22:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiGRUc5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 16:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiGRUc4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 16:32:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A732E9FE
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 13:32:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bp15so23472483ejb.6
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 13:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AVow+F5AyDyYSBTWDMixxqgzzT863oaZJ6tWhsfG+ug=;
        b=o0yHiKWL+aBK0gREVKejTe79GWnlURkEYDo6NEEZHqStZsWIwFBnYLq8jxG4zNbYK7
         6Fvdbh4d+JgDkPApjaxh7VvR2fDZ5sTQX3cxHojV54D/2Wuq680MqrOpRaEGwVNKfYNp
         DDHhRDwbJgIfFgs04Yvp9XqOuI9h5OHu8Kax8j3/GM0xnMi2WsOf01sEqX6rpcReZeru
         8XWPOliTkGGdcgvM5hiwsvmZyiuXl3WudbRf9qSS9vfOgNtaVino7V/1q6mCM/S8Cbv3
         obqDMRzqgIvpzIxgWuiGw63dFlCM664Umv3q7j7LvZ+23nDfCaZ+dt1bgNMuY/XqUHwD
         +0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AVow+F5AyDyYSBTWDMixxqgzzT863oaZJ6tWhsfG+ug=;
        b=bfmHbJOncYmeVHGpU9ZIGZLZWFTeYZyjQ0ipZ/Vj981060c3cAXVQyLVC9Wmwttk0V
         8YRgEywIaWkpo1RemsS8gcT5syaJvE0T0+rAANz+BAGilVEh29DwbrI1K//k2rxMHamq
         yIFdBYAnt6doFUOo7zCi8rLBFkYWkUTmP3qt8gtIHkNaedDsHDqvYQwiYLyr5acoWVNc
         XTgAlXAelZhiMFBxsiMLBcY7nTpyLsCSOtNREbXM25z+i0uh6GOoZxH9egQojZIyeYsh
         MOI1OsUZh5vy/ZMCu5K8x5JXBB+3TMWb693DTYkJUQ+PpHGjYUhekxCDn2sRIkSCqXAP
         XY1g==
X-Gm-Message-State: AJIora/OD4+AYdTYaOAAxh2nT9IHg3Fb1noPUWpjqFA4VXzW+26fW6Vf
        7bX+EIuldD7vV7vodTUp9fol2q+OWDxgKxK9/4c=
X-Google-Smtp-Source: AGRyM1tcpOZaBT8OBwOVyLCDLhYGuCKkmoRwCPCz0YctDt5P+AumbK3CLRwccAH1oCO9NzZHSCItwuBdLo6MUo4SV2Q=
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id
 nb13-20020a1709071c8d00b006f20eb21cd6mr26186921ejc.568.1658176374170; Mon, 18
 Jul 2022 13:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220718194258.181738-1-ukleinek@debian.org> <20220718194258.181738-3-ukleinek@debian.org>
 <CAHp75Vd983XT=03HMAdJmaHTR4YK-=XmZnYd+gF0SY90ywR2ug@mail.gmail.com>
In-Reply-To: <CAHp75Vd983XT=03HMAdJmaHTR4YK-=XmZnYd+gF0SY90ywR2ug@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jul 2022 22:32:17 +0200
Message-ID: <CAHp75VdC1eW-KQmQ3EXEh70k4XDQ1HoO9m5dEY9=VGKNN2K-oA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: humidity: dht11: Use dev_err_probe consistently
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 18, 2022 at 10:29 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jul 18, 2022 at 9:51 PM Uwe Kleine-K=C3=B6nig <ukleinek@debian.or=
g> wrote:

...

> And to be honest I don't like this desc_to_gpio() usage. It's not for
> board files, it will bring confusing information to the user. What is
> important is the name of GPIO, i.o.w. "connection id".

Yes, I have noticed that this is in the original code, just if you
want to make it better at the same time. Not sure if Jonathan wants
all these in the single patch again, however it will touch almost the
same line in all (three ?).

--=20
With Best Regards,
Andy Shevchenko
