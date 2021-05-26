Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8890F391720
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhEZMNw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhEZMNr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 May 2021 08:13:47 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33273C061756
        for <linux-iio@vger.kernel.org>; Wed, 26 May 2021 05:12:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c15so1323991ljr.7
        for <linux-iio@vger.kernel.org>; Wed, 26 May 2021 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=76p9wT8QuwVg5ew9GnKLqtzRWlQefAzPXOCMAhErJUM=;
        b=bf5rvIezGjDJQas1Jm0FHmH8RbEFAk2UIyzPIR1txeUXwich6fHGjvGE/wUSydRWe7
         qS9Oi0IAefDve14zdC58XR5m/w14LPoXxspXqCJy4gVuqffm7FIfwVk7wnfPMRAl9yEk
         RgsIDE6rWuRNsI4ftFwYI5jz45BX/zcziV0FL6nfDYo+y2Kh8p4QKryjZH4knk0gYlpe
         t2FCgA1WGisKV2XqYE9E6XDJFMP4MApC43QyuOrF0djmmUIKFOPWZmZXt738KqSehHYK
         Q5Wpag4uqNBirsiKYo1pnrb99Dr3XBrocg4sKmnecIke2bKrTc1+Nc3j0SdNd6gBmODH
         N+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=76p9wT8QuwVg5ew9GnKLqtzRWlQefAzPXOCMAhErJUM=;
        b=nh5visQ85n7n3CdoeL62xOztwil3fka0bH2+fdgRk8F+CxO47EPvNBUz59GqKEKhuy
         B2ytL9rfH4oeHa3/AiDifxSR5LPr7DeKGvYupjsSsI4CawENMbK7TSzndMLtmwEWL63Q
         OC2Uwi7nmJ2lrfHWNu7aI3w+/zspm2ns8pMvrz56QD/jM37Mg8/im39RqUPZyS8rKtoQ
         LRe9f5zo8ZWDbjKiXxgCuETLmNVl/2IXRgtkaGrMX0GA5pohSxj692vriEwh8vCqko4o
         0oWp3Zju+BS6t54XJ0jyO7GKPmQtLfxqoADbGtWRw2DjAteYk2Ae7UPEYqedo4h6hO/N
         yvVQ==
X-Gm-Message-State: AOAM530IRq2r80AbfyPvvuser1SDkVy1aKm6+zacGw+ACjRnYYG3HZlh
        B21iSYcEZ/ItbHWLM8e9aS+AIDoMUByfH44ATiCHPQ==
X-Google-Smtp-Source: ABdhPJxGabSI+GmUS0ZHRlXFFPBAHljNRwKEJv8onxPUVj0feimpj8ZknOi25MDqd+vu2ReJ7Y3r+u/0Z9F0zsQqhX0=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr2042387lji.273.1622031134390;
 Wed, 26 May 2021 05:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210526094408.34298-1-stephan@gerhold.net> <20210526094408.34298-2-stephan@gerhold.net>
In-Reply-To: <20210526094408.34298-2-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 May 2021 14:12:02 +0200
Message-ID: <CACRpkdZweO5kCdSky8Nc+QmKWRuGLKX4QEct5LmH4RTPirRLhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: accel: bma180: Fix BMA25x bandwidth register values
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 26, 2021 at 11:44 AM Stephan Gerhold <stephan@gerhold.net> wrot=
e:

> According to the BMA253 datasheet [1] and BMA250 datasheet [2] the
> bandwidth value for BMA25x should be set as 01xxx:
>
>   "Settings 00xxx result in a bandwidth of 7.81 Hz; [...]
>    It is recommended [...] to use the range from =C2=B401000b=C2=B4 to =
=C2=B401111b=C2=B4
>    only in order to be compatible with future products."
>
> However, at the moment the drivers sets bandwidth values from 0 to 6,
> which is not recommended and always results into 7.81 Hz bandwidth
> according to the datasheet.
>
> Fix this by introducing a bw_offset =3D 8 =3D 01000b for BMA25x,
> so the additional bit is always set for BMA25x.
>
> [1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datas=
heets/bst-bma253-ds000.pdf
> [2]: https://datasheet.octopart.com/BMA250-Bosch-datasheet-15540103.pdf
>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: 2017cff24cc0 ("iio:bma180: Add BMA250 chip support")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> After spending some more time with the driver I noticed that BMA253/BMA25=
4
> would actually be better supported by the bmc150-accel driver (which
> doesn't have this problem and also supports the motion trigger/interrupt)=
.
>
> I'm preparing a separate patch set to move BMA254 to bmc150-accel at leas=
t,
> but I'm not sure about BMA250 so this patch is relevant anyway. And I had
> it almost done already, so I thought it's better to send it. :)

I looked at the preliminary patches and this looks really good
too.

Yours,
Linus Walleij
