Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3507E129AC6
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 21:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLWUSv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 15:18:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46228 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLWUSv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Dec 2019 15:18:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so16433186ljc.13
        for <linux-iio@vger.kernel.org>; Mon, 23 Dec 2019 12:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2qy0HoCvQDusZ0cpEpbripvXNYqU63hvnwRNfm9upQ=;
        b=RSMz3A1SOXYb7Hu9oRtHEalCQM8Rghlg/pAjw/0nJkr3StHbJ37dfMS+us8W9kfQs4
         lSUJ5TohPdq5iPf3Pxfxr+VJUVDuZ/PDFAsRNqVyuu9QOcb/nMd9VI/ftbHNsPdmw5E2
         s23QxeugWiuS90095GgPpRgEvsgKStcQSu2PTqKeOw9s++p8dOvtHpm4Rpc1oE/gaAQr
         LUAl76WqVWuYZv5R2z2vvggRb1G13iB1irTjx7KaFLKJN37gRxlQNs3bpItZOZqf0cMg
         g3o16VDVPd2wK5KWd6C8W3wlIn41G2LpqgdH5TQvEtdxyrI+rPIAl1nGuVoSASJRU1Ky
         y2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2qy0HoCvQDusZ0cpEpbripvXNYqU63hvnwRNfm9upQ=;
        b=o4A8wXZsbzAt+WA8P/DzCPskOpRkakAT+iwrSeElWh1OiKJPStNKftLC+wHkaSSE5h
         JurqwTSVttt0cxmWcS+uUm1TUeTLDuZihotSkGJfnOiLPUlGxY+TfPyiFAgdyGjgdizK
         oD9rhKBekXQscG1eR0CK8/NAOn4dtTCNofQtZ4wXtFaygoIZmSOM2vnJe4EpJxjuUay1
         7JH82nDWeOwLPLj/hvxY/Q4EmO4poRObbQGvDHRUnx7uh9fUwvlhECn92CMX5cagWBu8
         qwph/Ch4lYWTi/tmYVnHVXirEKdfK9DMa7fkDdvChqAcWt4WlqFv2GtwtHcqVcJIvOYg
         WHsQ==
X-Gm-Message-State: APjAAAXZ9eRi08Oi89kXtSrMGgLibsr1WKyFrPxQwN5r3/RM0FFCw/0/
        QUmxt5k/DV16PAS19pzxbH0h5m/on7wcpZ6Nd+1OQ1sT+qg=
X-Google-Smtp-Source: APXvYqy1C/z6EbqtgNvxWXaICZhucKvxW5JW9qpj2yI5BD7LALc/EnJkEqdFyCydrR+zs66VVtn8FomzII1Ag/3TrfE=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr19072068ljh.183.1577132328976;
 Mon, 23 Dec 2019 12:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20191211213819.14024-1-linus.walleij@linaro.org>
 <20191211213819.14024-4-linus.walleij@linaro.org> <20191223172821.17f058ab@archlinux>
In-Reply-To: <20191223172821.17f058ab@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 Dec 2019 21:18:37 +0100
Message-ID: <CACRpkdbOq1-_C+n-zC8oE8wCNDxF=ip-2bDmAB_qRY5Vif7rxA@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: accel: bma180: BMA254 support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 23, 2019 at 6:28 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 11 Dec 2019 22:38:19 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > This adds support for the BMA254 variant of this
> > accelerometer. The only difference for the simple IIO
> > driver is that values are 12 bit and the temperature
> > offset differs by 1 degree.
> >
> > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> I'm never keen on wildcards, and there is a bma253.
>
> So please go back to using explicit part numbers.
> If you feel a need to indicate a particular structure
> applies to multiple devices, then use a comment to do so.

Actually when writing the patch I had the datasheets for
BMA250, BMA253 and BMA255 at hand as well.

The cases where I have labeled variables "25x" is where the
models are identical, so as to make things easier for people
that want to add support for BMA253 and BMA255.

What about copy/paste the previous paragraph into the
commit message and call it a day?

Or do you prefer that I edit that comment into the driver
file and resend? Either works with me.

Yours,
Linus Walleij
