Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DD623F8B
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 19:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfETRzn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 13:55:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36005 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfETRzn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 13:55:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id y124so6356890oiy.3;
        Mon, 20 May 2019 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmOplSbOfwPXiFLdMSnHPPDbLWjw+oFluB1geaReHmI=;
        b=KZjhBKGLwyndxwWL6jtb95hY1xBVkukLaGn9BsJy2YgB9WI9qT5FUGS8fweJo82pMN
         FEVaoluxUufAssA0ighz7jFjymDluWnk0dPaXuThEfHLH20ItweBAuY7OZx9Fo7ztOcp
         gm2NNK7UdUnNEt4hCYMsK5iKjn5xPL3i6kht8hl4AWIVaN8BFVU6Qve7hGvouVopgfR/
         4czpH6/ycX1pHYeBexVlbIgnzgOocLq/qc/aO1Ih8v+BblWAn6Mgz+XyXa+uNsmiGQlU
         IgpfuMQ+QzlcDleA35auW9O6vee/TqOr8zXg+pL5yKfkOR2M77+sU5KBn2wLeOlcivMt
         X15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmOplSbOfwPXiFLdMSnHPPDbLWjw+oFluB1geaReHmI=;
        b=gtrVuFTjaowMKiLgYpCS0DqkshGs0Y6lww4KQp1iZXIbuEm5FigURi3dgJztzD93Cq
         3DKinQXwTaanCGD57xHQApxr1AXd6adZM/G7hgczdu4RgHuLE4JCVowFMR+v6YsAmpkE
         86VfAwSoPtrWUGABNGfiOatb2OsL67PVTtdVL0tyIlID2pA68NpevEOVQbg8lvUtBcUJ
         ZlQOgBJ8QWN7gBnAUvkTdwTHTjO0XxRvCPCwjHua1/8BI7z9FoP/zMFVSykJt1w0OI5P
         LOQR8UQ1txVPYvLmlnaZLEB3BO4t+lb6HTMabv96di/w2oS648u0Ac9PbIDndD03KDlW
         D35g==
X-Gm-Message-State: APjAAAVs9f+JRyBikiEMSqr1kOZ/tR3njxJKwzLUzOx7CmSpaYWRCvuy
        Y7TPh/2mHkimuDUmylPAMLJPUxbktDZDiNMgXIQ=
X-Google-Smtp-Source: APXvYqyG0v0OSWuexhekflnwntq/Q+vi0aE9b2sYgWysotk+X4xcLiCnq0ct6UNtu0iUbwSdClu2x6C9Fc4llN1jktw=
X-Received: by 2002:aca:f144:: with SMTP id p65mr277382oih.47.1558374942891;
 Mon, 20 May 2019 10:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190520140228.29325-1-narmstrong@baylibre.com>
In-Reply-To: <20190520140228.29325-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:55:32 +0200
Message-ID: <CAFBinCD8Gkb0aRXWPb1uuezSHuS9DxQmnhuuSttspDzWHNAV1w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson_saradc: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Neil,

On Mon, May 20, 2019 at 4:02 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/iio/adc/meson_saradc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 510d8b7ef3a0..e39d95734496 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1,14 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
the original license text didn't mention "... or later"
personally I'm happy with either GPL-2.0 or GPL-2.0+
