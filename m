Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1561571323
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2019 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbfGWHnM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jul 2019 03:43:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36247 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbfGWHnM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jul 2019 03:43:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so40103447ljj.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2019 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npbXQAsUfiZBLcbkpCR3x+7qby8hxGom1+tEjhLtF84=;
        b=w2FX51BoqEBTS87kh8KgQ128Lnm4K7aScbKp7p7KG0RZvuFmQ5ZeRyaNckPGbvdFfd
         8orXXAGJ+J4pQFnxBaEEcLCgF22+U7W9tc/Se+sTjW+wVQ+cOPmne1a6xgAVBwrxyiNh
         TyzT6LtLmqQi2itKyV/WpgOyRuHQxcy1se2WY8AB/7q/Rf5go+whVPWnNJF7t+VWEMBd
         pmuUhr5pgIWRD+HapcglpyXMp8CBvQlzcP+LVXe8O4I1jpUnUpCl39BNcbsU3tOVat/t
         SQFR3NgezXOd3vPtIE3FCFrwJ8jp7bjOIR2zd0+zta18H2ppvKmMQYo682YAvS+adqMp
         YIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npbXQAsUfiZBLcbkpCR3x+7qby8hxGom1+tEjhLtF84=;
        b=lwpFI1Z4tZJwuTBCNKHbwIWFbZGfvaqboEbvnCoqhvqBFy8R6YnBzwFdLirvfkUSbc
         zSfDcYIxWb0LP7ff8dYIjllPlsGVBY1XtkWNxyrlmRxaGzi5IoOEv65BeIdNSAv/8A82
         2aosYnY+hhcG90xzsN6duf3aq9XJ5NkM897l1XYH+WxXIiRG2HNwSCkfRyErQ7GfoCuf
         Mh1Uwp3UESUjNtf0qYEOslE4uwnu3vYk2aZkZzlI+700MDVaIbWM0FuVnDaDGi2/zJQ9
         iQGtEYSbX3XmI3X8DBor9oZlOYf2Lvy3y/ylyoV7Vv8an+isUiICDoVPbX+5xnwQLlpl
         U07w==
X-Gm-Message-State: APjAAAUYYnlisb/jYNiRuqkh19uM7wTciWQ8Zzu+LOX7si2e8p0yWfFn
        wU5tNieVtFJYkZih5aOqnWrdoJdSPm+dcG434ljWKQ==
X-Google-Smtp-Source: APXvYqztHvJTCupc2FazH78NnbhNbFFXwlBZr0o8C796oaMUffxQHCWl5TXPmgAEdCLgwY6Sn/kLyvB5/v3zH9bxp3k=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr17161946ljm.180.1563867790559;
 Tue, 23 Jul 2019 00:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1550768574.git.hns@goldelico.com> <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
In-Reply-To: <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Jul 2019 09:42:59 +0200
Message-ID: <CACRpkdZ5Z9VY457Fywt6X=K5XONgiPVcwbwSkwL_U+GCqZ+u5g@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi H. Nikolaus,

On Thu, Feb 21, 2019 at 6:03 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>

It is fair for you to change authorship to yourself at this point.
Just keeping my Signed-off-by is sufficient.

> The mounting matrix for sensors was introduced in
> commit dfc57732ad38 ("iio:core: mounting matrix support")
>
> However the device tree bindings are very terse and since this is
> a widely applicable property, we need a proper binding for it
> that the other bindings can reference. This will also be useful
> for other operating systems and sensor engineering at large.
>
> I think all 3D sensors should support it, the current situation
> is probably that the mounting information is confined in magic
> userspace components rather than using the mounting matrix, which
> is not good for portability and reuse.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Samu Onkalo <samu.onkalo@intel.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Did this patch fall off somewhere? I think it's really neat, even in this
form it is great help for developers. If you want I can try picking up the
comments and resend it.

Linus Walleij
