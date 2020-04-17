Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E21ADB0C
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 12:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgDQK1x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 06:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728893AbgDQK1w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 06:27:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F525C061A0F;
        Fri, 17 Apr 2020 03:27:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np9so914294pjb.4;
        Fri, 17 Apr 2020 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/sWUOMORUKum104p8fgduP75zm2yCeLIzJBIrqZB+Ps=;
        b=KahVJP5ItSiIPFpot2mBBqQ9e76gqyDsccm5Ukxw//dMpOmX5viM8xZUjKXz/6lfi9
         5Hvc7ldn+DOuaclp1L7zs7rnA4NM3ZI8bq7Ichtjfe5UDxStI3clkhfX3ca4jD/nUOmL
         1TLjQOGtEd7MWJXjXSwUX+H4YoDGcoTobjSLqQUtXrkuCLK/sIyppBH6GF27qyKvxCK+
         gO+vhwHWBV+pe1zqObTSMAjc684ujLkFfjX7nhG3Ehc+OeVEzKLfZauZEnviGakP/kQy
         EhOX94KWOGczkebdlYbEJgAVo+9U6bwRZvJ1QjdBxzFfIWbamMAOUVW3teppP/S1aOh1
         HfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/sWUOMORUKum104p8fgduP75zm2yCeLIzJBIrqZB+Ps=;
        b=K4to3HOWczvt9WFBg5+5hC7oGSOLSqQfbmqUJNkT2/zQ9ZCTvgIp9nKAd7D0Y9lSjt
         5wdlUpehC1LzRZm8Zt7j3sRxQorrlXJ1/s1RLpUpid5sBEojw5MZPtQDTyaWyoTeECUE
         dwtRXHo2STYzvmcpJ1FoPv3U3eLGjjmQ2ce5jhFPdVgP8FgRjCm8bAYZopJJn2Fm4UJS
         wp+5kNympvbm0gjFg2vsljDgJEmhHDRym3gANbeICymFByKCfF/4k6vmQuG3dN9uPsIf
         5NFDLd3bKd7DHc6ncOzck6XRpuVmCpAA1puTS2YfhsrfKPprfQorXDIgXFYFTclTgSPs
         wYsA==
X-Gm-Message-State: AGi0PuaPpDT2efc5mAeL0Np6XBjveCyBL/IC41H6MHWADzrQIWnuQwsj
        znS30jmCr6j+bYiVx47ogA/vAFlOb7sxf+9HXAwFhzkWcNlIwA==
X-Google-Smtp-Source: APiQypJJLjV2o0/L1MJrfkO016rcaDEjMxTgdiZvyKNt5MBCK0q9Wsq4v0LzlfRjwCzi73fcGjHqkEZULNtssGBUydY=
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr2880287plb.18.1587119271627;
 Fri, 17 Apr 2020 03:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200416012016.21422-1-chris.ruehl@gtsys.com.hk>
 <20200416012016.21422-3-chris.ruehl@gtsys.com.hk> <20200416065655.cxy67hlj267dpjrw@pengutronix.de>
 <e4a6af21-a8ec-e9b5-2c5e-1e109888f0c7@gtsys.com.hk>
In-Reply-To: <e4a6af21-a8ec-e9b5-2c5e-1e109888f0c7@gtsys.com.hk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 13:27:40 +0300
Message-ID: <CAHp75VfN4Fj0J4n2xKmK8fDKACT0epo_xXQnMzKDW-Y1XH46Pw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: DAC extension for ltc2634-12/10/8
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
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

On Thu, Apr 16, 2020 at 10:15 AM Chris Ruehl <chris.ruehl@gtsys.com.hk> wro=
te:
> On 16/4/2020 2:56 pm, Uwe Kleine-K=C3=B6nig wrote:
> > dropped stefan.popa@analog.com from recipents as the address bounces fo=
r
> > me.
> the maintainer script added this email automatically , I will remove it
> in the future mails.

Somebody from Analog Devs should sent a patch as an urgent fix.
I also suffered from very same bounces.


--=20
With Best Regards,
Andy Shevchenko
