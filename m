Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F6D1606A0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2020 22:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgBPVHz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Feb 2020 16:07:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38833 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgBPVHz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Feb 2020 16:07:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so16505205ljh.5
        for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2020 13:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OOZ4PjE77cwP6qXPtnnWF1ug4IfH7DQ7i9i7a7qCaUU=;
        b=wGzp3VieyNBHHPNe852QT0PCfI54qDMkyWDe3m5Tr3D97SppFv9oodXMT3dRosx10G
         nluLQiYxpWDj3MaHJK1zD5wmBsoGlmivn18snXb6k3EohbgPJvJc9JQwLsvX1sIYb4TM
         oMnZYwrRGwGmkX80MpyR5x/AQNopxll1qFPhtgUhq81UzvgP6Zj7Hn7uAGqkd7NWsOGT
         nayAarn8AE81vcGxDe4EIqUnxRw0hCWD3rscIwIyUlNo5syyERYHzoy9rurdybNm8Uvh
         aZIYBtzYP3AtXZlYDTnELydQp77ipe9b2TsbxzcB56T+mWwNH1lNf0budpXBIV0ukNkM
         HJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OOZ4PjE77cwP6qXPtnnWF1ug4IfH7DQ7i9i7a7qCaUU=;
        b=To3YJnstA1+Bjs6yDHNP5kuROF9SX3Dz9zkwBWhf6JFItETr2xQQxyYwMeG5UXA93n
         OcQUEGa/qYjS6UR9LOQNWXc4WwuJxUXUQoQOKxuLn7+MD2VWCbI3HPzKY8qJO74hNSmp
         GBeGTmqVizRoMnldhzfaYjcR+pPKXTIz+AihhuSoTqvAIpmEm2alW/+vrrVbTMW8HHqC
         ptOqDUQATb/x38WGJbDdppS9nsa4MUguA6NnDEafKdO4bvC+hnXMXL0PE8II0HgNl3iz
         U4LvY3PGDTSLcVfnZxP/A44AT8ejit+JPVQnuBfNeYQ57QAOv3iQXBZL5PiLbuDVQjBw
         KHFQ==
X-Gm-Message-State: APjAAAXD0767GmmKI7eGMKhKA4qtmDajJd9hLwEk3558yzNKb4FWUjGP
        W1bv7g5Wlt9/NtMxi1dt0a1EIct1L5cU2Kd73ku+vA==
X-Google-Smtp-Source: APXvYqwrzz6tDwwu00Qc6QjSkBJm0s/uX5VaG/Yl0r/v5hEkBRCUwAQk+mLw6gf11ZRVkUff3dYUQl/Ev2iXs6GAObw=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr7493793ljo.99.1581887273689;
 Sun, 16 Feb 2020 13:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20200214110324.70972-1-stephan@gerhold.net>
In-Reply-To: <20200214110324.70972-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Feb 2020 22:07:42 +0100
Message-ID: <CACRpkdYkPeDp8m=v4FbpiEy4XqQf4+=bRc6nF88MNLG2WN4MJw@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8974: Fix negative raw values in sysfs
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Nick Reitemeyer <nick.reitemeyer@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 14, 2020 at 12:04 PM Stephan Gerhold <stephan@gerhold.net> wrot=
e:

> At the moment, reading from in_magn_*_raw in sysfs tends to return
> large values around 65000, even though the output of ak8974 is actually
> limited to =C2=B132768. This happens because the value is never converted
> to the signed 16-bit integer variant.
>
> Add an explicit cast to s16 to fix this.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: 7c94a8b2ee8c ("iio: magn: add a driver for AK8974")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Waleij <linus.walleij@linaro.org>

It's my bug, thanks for fixing!

Yours,
Linus Walleij
