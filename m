Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F053A3F1F42
	for <lists+linux-iio@lfdr.de>; Thu, 19 Aug 2021 19:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhHSRkG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Aug 2021 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhHSRkF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Aug 2021 13:40:05 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402FFC061575;
        Thu, 19 Aug 2021 10:39:29 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id m193so13758447ybf.9;
        Thu, 19 Aug 2021 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g64bEUOGnUgUs+DzbHBHBOodT6css7EVktoxeKzWQEM=;
        b=eoDSZYvqSB8bJgtZRWfkeMH4EX1qopHU31cPOp2EIVyzpSLRKgqcCoCSkf1LZpw32F
         1pkmt+UW3sAfYxv+P8O1hYIKf408b13yiH5QtYGiV3sF82e9PN0L7y38VIlIUCF9Wg+H
         eewpLOha/CLKg0OoV7LSQ5sqhjmQqN1EK+4wdxpHmyxH69jNZve/FKPiBZG1jFDe6egg
         MAS1/PkdRfl2vmUtOq0f3vjDcCssu8kx9damejetWFwXGsamlGYVQ0rr9MPVvfXMZjyu
         X6GrFhksNYkD/HchePJ1hoRYMqcTqrB38+jNRJ2ZJRJo3cprk0iqNZ+dEfOd7SGfCGz9
         +oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g64bEUOGnUgUs+DzbHBHBOodT6css7EVktoxeKzWQEM=;
        b=BTzm9juBhbZ7BtS7kFMPPhnyuFWJ0xIaM7TcePw7GPN5/5KgMjd/qT4pq8jwE+qN2a
         L27UZe4PwfbzQxFLxhlUgmByfOin1ebPx0A+TMe8tOQdLm9bupJ75BstOnXZZqLTge9J
         lOIMaRm/gHqGagLVXEIBKIQkiFGxAdav2CzQdn5/v6imiTpUd8U5DLHnky8gwjspoq5w
         vyp7n+KzSStcM73bWR5zm61Ic2mBKWaWBWXSnV9WawLWL65/wzyWZ454KRs/Hnt88mD7
         q2VTiDDilF0EHhHe+BTdh2STm61LISvIPXI4Nl4R/jFcUgu4ACq9cuUtDwFm4U+pmtD8
         qSJw==
X-Gm-Message-State: AOAM530eYdc7F+DeWgl6aA5V8ZspF12f0KajEBJMYb1C2GSTF8Q4YcMN
        xRi9DTgHvGYdxvwxcGdAdoI2/DcozM6Axku779g=
X-Google-Smtp-Source: ABdhPJwZy8x0cRGTqE0c4ivPPX2xImAbsC9Z6rV7yS2b7qK44Vt2sjRUhNr20juNI/h83f/41Hb5cCvsFcYr6eBQsOw=
X-Received: by 2002:a25:bd89:: with SMTP id f9mr19534861ybh.222.1629394768464;
 Thu, 19 Aug 2021 10:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210817172111.495897-1-colin.king@canonical.com>
 <OSZPR01MB7019DD199CB1B9A4521A3C28AAFF9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <CAHp75VdWFTi4oSWG45NunJwpe=LdMhAMEAEJh21ML2QXszgS+A@mail.gmail.com>
In-Reply-To: <CAHp75VdWFTi4oSWG45NunJwpe=LdMhAMEAEJh21ML2QXszgS+A@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 19 Aug 2021 18:39:02 +0100
Message-ID: <CA+V-a8ugKC8z2=0usUca4eYFLTHEorxdtmdmbE5vXZDo_Ob5vA@mail.gmail.com>
Subject: Re: [PATCH][next] iio: adc: Fix -EBUSY timeout error return
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Colin King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 19, 2021 at 6:21 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 18, 2021 at 6:51 PM Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> > with the subject changed to above: Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
Again with the above fixed:
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> Always put your tags in a single tag per single line. This will allow
> tools to catch them up automatically.
>
My bad, fixed that now.

Cheers,
Prabhakar
