Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720C644D6CC
	for <lists+linux-iio@lfdr.de>; Thu, 11 Nov 2021 13:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhKKMw5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Nov 2021 07:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhKKMw5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Nov 2021 07:52:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37248C061766
        for <linux-iio@vger.kernel.org>; Thu, 11 Nov 2021 04:50:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f4so23628335edx.12
        for <linux-iio@vger.kernel.org>; Thu, 11 Nov 2021 04:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=drcudKrG4NRhDHEcl9/w97XqVMdqPhV217y3tv0fnzw=;
        b=pkCWPGf7wlAQPh0hj62dBI02ieFCcrrIBY+klZasmfJFVWI0u/8p3z9uL36LSG78Nc
         VEzuei1XlBROwzIp3II567fvYORpJUV2SDENv/TwZVM7cjoIQOcdhnk7zczu9bhSb3SD
         38lN962H03UXPp1OwudPhZGk1xCboguabF/gvzyHtBm1OFzVLPP3A8YzNErlQwK7LekR
         0uPxfZJDjAIkSlNZdvtaj72L8wk2//CXQMd06TbQMVF/VGSKlQDQ6TiUUo5Vm+7wgbss
         qXACJ1G40dTP0T9vhb4Ju+qR4MCsT86bDv6XtpwESLsOF5LN6TsJE5pZV3qACHPwMi4C
         JycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=drcudKrG4NRhDHEcl9/w97XqVMdqPhV217y3tv0fnzw=;
        b=ZA+440u1WWCCNixtniXyVvY2+rStxd6LVDhIB9rJKvsglT05BriQrUzmWZf05Hz89J
         Gtcv2ykVBmEGVG05z0mzReZ+R9SHuIOrDA82o68jXr/uPy/sWPGH8Y+fb0XVuzwOrri8
         +mgP6e35TDZbEY068RAERoZnelCPj4JdPNHaD8uXWc4wwbvBt5OlRmUfB9LmtQqXFJxL
         /RBJ4FjrrIh7r3xuVE+QCUkJdYz4kJqAy7WKK2FFNcnyxhS9+8BcSil3yC9KMpSA5yvi
         y4qNETLIArjY5HY5TFC4XqJbh0/ntiwULzFr8U4Oqrvdt6Sq6t3zg8QJn8Yhj3yHPlO7
         iOdw==
X-Gm-Message-State: AOAM533lgUzDLySpsyH0hViD7m7aTNWhnWHLx+OiysCa8vUFKHNqjr3t
        aM156FH8+zbtMDdb4msZkaA6mz80rDCv4JBb0JM=
X-Google-Smtp-Source: ABdhPJykS0dFBTnIvNeowTQKfnCXVr8eUYn5jPj35vYUSGzitF3wP8ZzTqHNi5+WJzGS2fTEbalMcJtWVrgohtShwF0=
X-Received: by 2002:a05:6402:1801:: with SMTP id g1mr9558968edy.107.1636635006810;
 Thu, 11 Nov 2021 04:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20211111121915.173616-1-nuno.sa@analog.com>
In-Reply-To: <20211111121915.173616-1-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Nov 2021 14:49:22 +0200
Message-ID: <CAHp75VdDBXehV0NTt15AOHdE5qqYn2k96+JkY1+nM+rReGWHUQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adxrs290: fix data signedness
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Kister Genesis Jimenez <kister.jimenez@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 11, 2021 at 2:19 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> From: Kister Genesis Jimenez <kister.jimenez@analog.com>
>
> Properly sign-extend the rate and temperature data.

...

>         /* extract lower 12 bits temperature reading */
> -       *val =3D temp & 0x0FFF;
> +       *val =3D sign_extend32(temp & 0x0FFF, 11);

What role does the ' & 0x0FFF' part play now?
Isn't it simply a dup (redundant) piece?

--=20
With Best Regards,
Andy Shevchenko
