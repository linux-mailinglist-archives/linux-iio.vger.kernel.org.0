Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E28571708
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jul 2022 12:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiGLKQs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Jul 2022 06:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiGLKQi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jul 2022 06:16:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA33ACEED
        for <linux-iio@vger.kernel.org>; Tue, 12 Jul 2022 03:16:37 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 6so13136977ybc.8
        for <linux-iio@vger.kernel.org>; Tue, 12 Jul 2022 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hUcqtJVn66HMBewcZYvpc6qCiSSnMEEZoRseID+n0u0=;
        b=bjC7O8L1NR0KF3CANCiyFW2hjaznFuKRwBBueUeYYci6zYn8JDzzRuwnd55e9M2Tmt
         GXBuWC8xQqGaZcWLz8JDTsVoVep5qbR8bAY2PDFgldniF1rWu+DS3zfODpsBAWI39HDS
         jA/dHsTBOnBEWfla48GM9EracZhFSKkNS9GdhdDckFI+XOZUuVZKEhHXWihu9+6ixe8+
         eHmTtq8W4jEtzZy2WyCEH2W1zDGOJk1aBVqJAQ+y5q5lkZSu1ODpFpemoVGk+ug1KpRl
         Ds3zFvkF1t2Cf+BFj/bnQMzmocbicYWLP2nv3QvoxligyWmXW95oCAG3nBfKkIJYmqAk
         7R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hUcqtJVn66HMBewcZYvpc6qCiSSnMEEZoRseID+n0u0=;
        b=cT+YzOLcRRHuwEbg6rvNahjYqBEp8G4NcaaNuMQ/lr7FzYeXCm26JR9g5Fs0tTuYsi
         5b1cDEIg4DdD9XEoSWq3FJYo3U3amkZFHDwHhUNwwSdIkjR95Dw3SEVPorM4Tqn3EhGH
         SQuEdqnPzr+uhkfeJTuqOOvxelfR5QuJ1I2V64BzXkrmr5DNkK4lviOBua83iEUTph7p
         s/clSVN6vS+OC8e3NomVR/FcvuCk2FGToL8or8cN6LsMCBXQqS/eikoYPt1bGc+WIY5f
         V5wrlrStJWI/xACXMNslDQjJ/D0+09OanSXT9Ojz8yr6XaE8mJTDxTewYXlxAoI7Offz
         wDKA==
X-Gm-Message-State: AJIora+3cyr7N48Yu29EpGN+Od5t3PhHWhI91pEsrZHsLY8H4bM0vwPm
        dUf4DWmau6WziNe6ihrJ3w/YP+Uof91bAGKFsIJnCucFrlHpjA==
X-Google-Smtp-Source: AGRyM1tQb3cj9nP5D0tNdLqxifWPrdUzKVrCIuSiMBzJPtwIbZWG76KwKReIuYFkloXtqak4pbDnx5JwJrq9FBN0QX0=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr22125914ybg.460.1657620996661; Tue, 12
 Jul 2022 03:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220711193714.50314-1-paul@crapouillou.net> <CAHp75VeLktz27cTDwpoBMUNkuyz-C_jXtgxQxjo=m1FFBWqQYw@mail.gmail.com>
 <MEKWER.12CQ7QOMG6YC3@crapouillou.net>
In-Reply-To: <MEKWER.12CQ7QOMG6YC3@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 12:15:59 +0200
Message-ID: <CAHp75VcvrFHsM02Vf4A=Gyn=fFBd1qHycOEYqHZxCrVxfBrv0g@mail.gmail.com>
Subject: Re: [RFC] iio: afe: rescale: Add support for converting scale avail table
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 12, 2022 at 12:13 PM Paul Cercueil <paul@crapouillou.net> wrote=
:
> Le mar., juil. 12 2022 at 10:24:02 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Mon, Jul 11, 2022 at 9:46 PM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>
> >>  When the IIO channel has a scale_available attribute, we want the
> >> values
> >>  contained to be properly converted the same way the scale value is.
> >
> > Beside that not very readable `foo <<=3D x =3D=3D y;` line, I think thi=
s
> > will look much better if we first convert the rescale driver to use
> > struct s32_fract (or whatever is suitable).
>
> More like a s64_fract since IIO uses two ints + a type to represent how
> the value should be computed from the ints.

So, it's s32_fract :-)

> Is something like that already implemented somewhere in the kernel?

math.h  and a few drivers are already using it.

--=20
With Best Regards,
Andy Shevchenko
