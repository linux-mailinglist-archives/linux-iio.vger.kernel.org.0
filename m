Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE29322DD24
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 10:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgGZIK0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 04:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGZIK0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jul 2020 04:10:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BFCC0619D2;
        Sun, 26 Jul 2020 01:10:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x72so7461531pfc.6;
        Sun, 26 Jul 2020 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ci0GEGWDXBHNdaM2N8ArkTe5Ogg7XLroxwBro1NOoU=;
        b=WWJqL44lCJHN7Hil5pug7eNJDWFrIyqg09cDu5uq2oGwZlPuFwDTojXDF0Wzvdz1F7
         Y335stE9p6nFTUiyTV4xtzEgw4W8DhyaDJe5MkC2kTl9WzQbvG8gQ+4HShlMkcpDNo0j
         bz3bL7ynrzCN2iq5RzA3P/Hq1V3nRFrbfYbvgp7vJg5tKtoJzm6DN+E4eosNkSyHktAC
         p5IBgibIIDINLG3op0+KCCTk0Wty6D0XgagFZ4vtB2lmfQpAeE3zFtdOno2jAZUyo7t4
         jIAVxgNNvHFyZx71llaa7cLVdb0FxOOGZSc2jB3EymnXT5jR9CxubIng0asx4qn2H3um
         6iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ci0GEGWDXBHNdaM2N8ArkTe5Ogg7XLroxwBro1NOoU=;
        b=cspuVskybD2XQb4Dv81EitJnBSBm0b+W3CsdjR4tnsWXYuniQT5g2QxSvwJ64nglRq
         B+yOO7HB/XVl1DlhOdpPyiaho5JSiXLP28p9IeavcIkGJaFwtZoYZI8UgEREfvbDR32k
         5EH3+Ca8Q+vDNKPt1pKNqXj+m1m9KIw2sg26C05z+1buR302CEhsa69RLgA7HldJt0/B
         Kq2smA9OhUWROM2oOUf03JhivOqUyZs9E1/lD1FX7ejlkNBd+RBSB+7xr1YRPcxXR1GE
         DXCr9iX41pbG1nyFMNnrmKj/cAEVYSJEjyHT6pv7jlOxj5izvpTsyvzHCAqFIjHQgK5Y
         jBCQ==
X-Gm-Message-State: AOAM531sjkWLeWTjaBYbo8ezzjfZAnwl1qx5I4lGyUrdr55oBSqDNCpq
        5aC+k9341LZX6qtkmMAcPpxbsYs2Da6f+T1H8WI=
X-Google-Smtp-Source: ABdhPJwtZc58lG+WVXr5/XYKGSgbqukfPLNzFC4b7SM8NrubD1g++pU9d8oQ0Dxqxpzn5yYuIbjdHehj3ZF6+oszWkk=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr15385245pgi.203.1595751026076;
 Sun, 26 Jul 2020 01:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
In-Reply-To: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Jul 2020 11:10:10 +0300
Message-ID: <CAHp75Vdh=GymXnzA4NaMJVsNqb=7qqq52+U5hCif4H2shDQ4uQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Fixes dropped on initial commit
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 25, 2020 at 3:41 AM Daniel Campello <campello@chromium.org> wrote:
>
> This patch brings back fixes on v9 of initial patch that got dropped
> when v8 was taken instead.
>   - Updated Copyright
>   - Updated macro definitions
>   - Simplified return condition checks
>   - Removed ACPI and of table macros

Please, split to a series of patches.
I see at least ~4-5 by the changes below.

-- 
With Best Regards,
Andy Shevchenko
