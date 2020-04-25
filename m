Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4841C1B889E
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 20:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDYSwj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 14:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYSwi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 14:52:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B64C09B04D;
        Sat, 25 Apr 2020 11:52:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h11so5067723plr.11;
        Sat, 25 Apr 2020 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5aMK2w5+Vqp54D9P1CUzu4V0aJIFIn99GKnzqvS3pY=;
        b=I/nqQv4PsSCinTp2bGWPZKkw/qhM+PwatB+57nhF/lbed55Qg2wt0pD/QNJmUYIxiA
         leW3VMuvuYbLA7R0w0EZMW4raL6BvVARRQ3u0fOJ7nHG0GUkY0P8ugTM1i7GDU8SeAbk
         RETJKLJuRfEO2+gmLObJ43fA9/QKTppyx40ZE1JnuC0t7f7eO2/QLQddOAQtblS6C4+X
         G6l+LPfFRigHggyPgXrFLP671kHeawEPw4wXld/PEJ9XkXW8u/x3hXrA15y+PM0F/6hz
         sxuU0ArrKBaK27/5iI6cGRo4dCyb6XId42F8+1t3PNktvZ6erN3BShVBMrUQmhuJFUfY
         KR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5aMK2w5+Vqp54D9P1CUzu4V0aJIFIn99GKnzqvS3pY=;
        b=RxthsJxq3vSURSGrY5kGWkBv+j1Y047sFRoTpjtZaepwkc8fhzSyoqdt1b1fZ9O6k/
         6IxfVzaFT6iv2jpAsQFVJs7mCHj++Gh8vcIceQDdvC1fqUGvmucHugrwjNSnRTQrpYUC
         g4MMXCAEicWVn9MZxLXafPKnrIMRrSTU2scnVKoKFpiJa92Edff9uHNKVCTOSIj+creC
         IRzYwio1AgpGwtUfnvtbJKl8A0NxdAYlTv8lAWxNtjHpBc5JJeHWlLN/S+QAlsJPW4Xb
         4NcCnCejDNvI+GipHvYy3uWx1FhgeChZu+vcQ185wiLv6thjI/Klb10lUxi4Vuw4m4jZ
         BDag==
X-Gm-Message-State: AGi0PuaDZub/rmv/texAAv6/T8vlLawL+MANi5NnHG5PNNXDPMMPK41/
        2D+sfk9I2azPfVwmr+wEDd3wVaaaByBIIvBPjzzR03qlm/A=
X-Google-Smtp-Source: APiQypJj1jonQSlBM68iDTHvO7nXzVE6SAE8XStQ5gZkbJB7NZXoA1Z82+2FBKmkUqxG4TtXnXibucMBWyCgXUCuSro=
X-Received: by 2002:a17:90a:2401:: with SMTP id h1mr14321206pje.1.1587840758078;
 Sat, 25 Apr 2020 11:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-2-tomasz.duszynski@octakon.com> <CAHp75VcbaGYj76qkDJnTnuG5SM215qVmFo7FLR6YzHA37PgF_g@mail.gmail.com>
 <20200424190413.GA2731@arch> <CAHp75Vdajf7Ci3ytxP7Qs9=fFaxvVBQoL5uh+HUDwxHS5r9MUg@mail.gmail.com>
 <20200425184130.GA37271@arch>
In-Reply-To: <20200425184130.GA37271@arch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Apr 2020 21:52:25 +0300
Message-ID: <CAHp75Vez8wSaYHbXmvfXUS5N+vScQqHGg055DNKrEnCunP7awA@mail.gmail.com>
Subject: Re: [PATCH 1/6] iio: chemical: scd30: add core driver
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 25, 2020 at 9:42 PM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
> On Sat, Apr 25, 2020 at 02:43:35PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 24, 2020 at 10:05 PM Tomasz Duszynski
> > <tomasz.duszynski@octakon.com> wrote:
> > > On Wed, Apr 22, 2020 at 10:49:44PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Apr 22, 2020 at 5:22 PM Tomasz Duszynski
> > > > <tomasz.duszynski@octakon.com> wrote:

...

> > > As for ABI that's in
> > > a separate patch.
> >
> > It's not good from bisectability point of view. If by some reason this
> > patch or documentation patch gets reverted, the other one will be
> > dangling.
> > Please, unify them.
> >
>
> Huh? Reverting core and leaving leftovers would be wrong and pointless.

Exactly my point why it should be one patch. To secure impossibility
to do pointless reverts.


-- 
With Best Regards,
Andy Shevchenko
