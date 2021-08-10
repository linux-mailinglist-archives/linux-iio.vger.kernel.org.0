Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA053E59B1
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhHJMMA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbhHJMMA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 08:12:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1353C0613D3;
        Tue, 10 Aug 2021 05:11:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so5058872pjb.0;
        Tue, 10 Aug 2021 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPJdbMwthIpOx7h1CPyZc0tnb+DSHC0iqh0tr2rSRyw=;
        b=heeobiThWwJocCp2/RgvSvqY/qOe2lp5nQKleqQsJu6VXfyEzFYXPBh7MXru4EeB16
         Z5W7EsuRMm6sUMb79N7lehx75cps3CCvvzWZJgaoZaLf2+aH0AyfUjNKLGYmPc3AVBy6
         tQQsVdikPxmrLMCzKnZy30SwbjSG3YlPic7I102HrpElG2NwrujG5Z9gS8zP7w625Rpl
         opGaZz4PC9ucOygUwE9FnUSohBzBNVEUQ8e5jK4RQZdt/FN4H+o0SXfgVP/pXsrtOQrc
         U24o9fj50gC6J8XLNMmQKSbnSy4sLTgdQu+5u02l0qorqZcqdMjRARSN2BSVCDi0xpal
         V9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPJdbMwthIpOx7h1CPyZc0tnb+DSHC0iqh0tr2rSRyw=;
        b=af1/pZCVW6V1ihPvAfeciICuXAGPl5HOr1Rm95ecOl3sPVif0JeKYTMEGWUZ/fUCvJ
         i8sPP6HCaZuLb7gc308ro+RsMrlwuFbYRsgXLa22+g5Qs4cThSlM7ogkL4jvtTAjmDry
         bNm2aDLi62Y7tleQMqAcm3xRrqX4s58fBK4GQTeW+sVngf6Hp4RqAkuG6x2PAFroO2P+
         lsTO7eFmMQnbW0NIrs5yYEPrfcAxnK/bn/mF/Gvj4hS86vGxva2vNcyEtDawD0LXSnTV
         DpKZEln6NH3vs651rQNaG9U101FUpVvHoeQiVpbU3TlvA/Jz1XCpfttJ6R0WkEysaCr9
         aXdg==
X-Gm-Message-State: AOAM531L1Zuo9sKI5HCNqeAI22EVk5S9J6Qm7GSQNDGTxHGC5xlVFuR8
        sNx72mae6c/xlivM/Fb4lletpOCTWzNd1iKGYo8=
X-Google-Smtp-Source: ABdhPJzu15/RgIyPXZVn6z7GWWPFJvOByJpZKsKfipdgvGLTiDSJ+bNENKtMNFh2unu9Brzz84RTp6+Q41GKcZsVijE=
X-Received: by 2002:a17:90a:604e:: with SMTP id h14mr1585585pjm.181.1628597498005;
 Tue, 10 Aug 2021 05:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210807152225.9403-1-len.baker@gmx.com> <20210808172503.5187cd24@jic23-huawei>
 <CAHp75VfSX-7UqH9Lbr_GxQRY3dGjGo7H8++kBdrrSds1p6nB1Q@mail.gmail.com>
 <20210809102131.000021eb@Huawei.com> <20210809161422.GA2619@titan> <CAHp75VfyJ1zSmgenn3V-2tF-X9uZJ1tByyJfJOydXZSV1as3GA@mail.gmail.com>
In-Reply-To: <CAHp75VfyJ1zSmgenn3V-2tF-X9uZJ1tByyJfJOydXZSV1as3GA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Aug 2021 15:11:01 +0300
Message-ID: <CAHp75VeAf_GYcF--=wXJmJZPr1YHn_gLFAFGHwsMCDX7Mxs5zw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/iio: Remove all strcpy() uses in favor of strscpy()
To:     Len Baker <len.baker@gmx.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 10, 2021 at 3:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Aug 9, 2021 at 7:14 PM Len Baker <len.baker@gmx.com> wrote:



> Even if we leave the logic as is, this might be better
>
> if (orient[0] == '-')
>    str = devm_kstrdup(dev, orient + 1, GFP_KERNEL);

> else if (orient[0] != '0' || orient[1] != '\0')
>    str = devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);
> else
>    str = devm_kstrdup(dev, orient, GFP_KERNEL);

Or these two swapped for better reading

 else if (orient[0] == '0' **&& orient[1] == '\0')
    str = devm_kstrdup(dev, orient, GFP_KERNEL);
else
    str = devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);

And with a comment added that we negate the result according to the
rules: 1) drop leading '-' (minus); 2) leave 0 as is; add leading '-'
(minus).

> if (!str)
>    return -ENOMEM;



-- 
With Best Regards,
Andy Shevchenko
