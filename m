Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1021ADBBA
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 12:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgDQK56 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 06:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730127AbgDQK54 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 06:57:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B41C061A0C;
        Fri, 17 Apr 2020 03:57:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so841150plo.7;
        Fri, 17 Apr 2020 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3fSK2DPSrZQ03rN1exfbu/DuncvDZ7rl47wg/eGnnv4=;
        b=i4yCtaOtzwnfKDnk8KtbzYo/q6+KO6LXk8YMzcPF5b3otBQAEZ7M3Wjk3B6C7MKDd8
         kNU1KqqIP1bTsBAkeMnRx0WcFWEfaXiP0JgsKDmgfhDi25gwVsFZ45dDQApHh971a2wx
         94Dy6JWScJAbDyXunDK+KOlRQJN44rJ7Siv3CQnBXmT2qcDAGsMpYG9pNtwlBkbxXNhq
         lSNv/5GxE4Z4chcgNzUubOTtkZl0zYzuxu8WaBg79a1dBERlwV0h0nwJBD8uxTAuGVSm
         XYD8YhP8lYe/MfDxJvjKg5jIBXxDxweMT142Cj93sEHrnsD+xtSbh41HrKtmzCRC9X2g
         vonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3fSK2DPSrZQ03rN1exfbu/DuncvDZ7rl47wg/eGnnv4=;
        b=tOmUJZt5/3LW1LPYBVci2DTo144ve0FcuazbqPCMOtAKTbt8ssGSZawj2YCXdIa2gQ
         w24KIkBGJWzOsoqzBWcmC7ZMLY6ocEBL5JC9vdZXYwm9J4so0ZIpniicow73zYn8vVEi
         IIAUDJRpwH0eNGHxSr8AmZxzdj+/0irsnfrSJvg8fwaC3M9uhEVesIwLXbb8HsUjN4ZU
         H+5pZlm/ev4LpHCcgL65os/Ftv3RXHYLgZeIp7jqycvU6OMXd7BSAAyUYSJThVpRX3dO
         CKHbb18E8MR2ABHGma1EXT0ttxnTRx9AeJFQEDww3n2iUEB2LNWGaMF5TKe+ZTiCkRvr
         hT/g==
X-Gm-Message-State: AGi0PubFObAX5iucI+LqPoSIfHjfqi4cH7948ZEKqpnuabm5fawzkQHR
        LqTZMKJpC2CP1Mz+Tb5sK/u2g0qyE4y/r5e5Bho=
X-Google-Smtp-Source: APiQypJci118f5LiyBfKV5L18v5aFIDLfnqixHAslNkLLuiUgR2OOW80nFzDzeZNb3S3g8xQguA2iF2RNXDmk8CnaRA=
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr3627454pjb.143.1587121074335;
 Fri, 17 Apr 2020 03:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200416012016.21422-1-chris.ruehl@gtsys.com.hk>
 <20200416012016.21422-3-chris.ruehl@gtsys.com.hk> <20200416065655.cxy67hlj267dpjrw@pengutronix.de>
 <e4a6af21-a8ec-e9b5-2c5e-1e109888f0c7@gtsys.com.hk> <CAHp75VfN4Fj0J4n2xKmK8fDKACT0epo_xXQnMzKDW-Y1XH46Pw@mail.gmail.com>
 <cdea4538-ef75-f000-8b9c-db10a9bdd173@metafoo.de>
In-Reply-To: <cdea4538-ef75-f000-8b9c-db10a9bdd173@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 13:57:42 +0300
Message-ID: <CAHp75VcjUt0QGrs3Bxv4yRpsOxauzJjjN_2VDSZ6si8x-pZQMw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: DAC extension for ltc2634-12/10/8
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Steve Winslow <swinslow@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 1:56 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 4/17/20 12:27 PM, Andy Shevchenko wrote:
> > On Thu, Apr 16, 2020 at 10:15 AM Chris Ruehl <chris.ruehl@gtsys.com.hk>=
 wrote:
> >> On 16/4/2020 2:56 pm, Uwe Kleine-K=C3=B6nig wrote:
> >>> dropped stefan.popa@analog.com from recipents as the address bounces =
for
> >>> me.
> >> the maintainer script added this email automatically , I will remove i=
t
> >> in the future mails.
> > Somebody from Analog Devs should sent a patch as an urgent fix.
> > I also suffered from very same bounces.
> https://lkml.org/lkml/2020/3/21/63

Jonathan, can we get this into v5.7-rc2, please?

--=20
With Best Regards,
Andy Shevchenko
