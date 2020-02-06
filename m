Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 513CA154DEB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 22:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBFV1l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 16:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBFV1l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 16:27:41 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ADCD21D7D;
        Thu,  6 Feb 2020 21:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581024460;
        bh=bGguiQxkk8XQn3N3sNxNrNWAALZLfCly9OgiprbxY7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j/IFbAtb3OufmgHFFwlE/lHuldc23vMOpKjisPtKuzw/+td4lOWTaLTmVz3uF2uUW
         pDRWadtD4kMo5YoOhzzuNuWw31DWU9tnlv8+xc2t+iKYvblEwKGoX6aKcKf0btpfhq
         seHuexWxkqfwr90SUs24AdF1W0VjAx0Wdp8moTII=
Received: by mail-qk1-f182.google.com with SMTP id 21so147490qki.5;
        Thu, 06 Feb 2020 13:27:40 -0800 (PST)
X-Gm-Message-State: APjAAAXiHrh0nMN3t4PzRJT748k+E8g39JT9O80qkeSFOXqQC78IAROE
        EpmYqty7/3HWsITaRvwznt83lhMzC37qWa42sg==
X-Google-Smtp-Source: APXvYqz0IRt4ytCktNtYMvloUMtLBfZ8eYIo0UcyfQ2YShJbLxjnnIOK1lnbAjSFLFAfxTjhGyySrIW8oOP5goykzjE=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr4532214qkg.152.1581024459364;
 Thu, 06 Feb 2020 13:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20200204093031.616409-1-david@ixit.cz> <20200204093031.616409-2-david@ixit.cz>
 <20200206190758.GA11064@bogus> <1581023799.790008.0@ixit.cz>
In-Reply-To: <1581023799.790008.0@ixit.cz>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 6 Feb 2020 14:27:26 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKQm7rnfm=QZSS+83czgaLoE6Wtg2se9r0ayvMgtfd-ZQ@mail.gmail.com>
Message-ID: <CAL_JsqKQm7rnfm=QZSS+83czgaLoE6Wtg2se9r0ayvMgtfd-ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3320A
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 6, 2020 at 2:16 PM David Heidelberg <david@ixit.cz> wrote:
>
>
>
>
> Rob Herring <robh@kernel.org> napsal =C4=8Ct, 6. =C3=BAno 2020 v 19=E2=88=
=B607:
> > On Tue, Feb 04, 2020 at 10:30:27AM +0100, David Heidelberg wrote:
> >>  This commit add dt-bindings support to al3320a driver and
> >> vendor-prefix
> >>  dynaimage.
> >>
> >>
> >>  Signed-off-by: David Heidelberg <david@ixit.cz>
> >>  ---
> >>   .../bindings/iio/light/al3320a.yaml           | 45
> >> +++++++++++++++++++
> >>   .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >>   2 files changed, 47 insertions(+)
> >>   create mode 100644
> >> Documentation/devicetree/bindings/iio/light/al3320a.yaml
> >>
> >>  diff --git
> >> a/Documentation/devicetree/bindings/iio/light/al3320a.yaml
> >> b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
> >>  new file mode 100644
> >>  index 000000000000..08e7ee4bdf55
> >>  --- /dev/null
> >>  +++ b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
> >>  @@ -0,0 +1,45 @@
> >>  +# SPDX-License-Identifier: (GPL-2.0-only)
> >
> > Dual license new bindings:
> >
> > (GPL-2.0-only OR BSD-2-Clause)
>
> It BSD usage in Linux kernel enforced for bindings?

Yes, bindings are exported and used by other projects. And may get
moved out completely.

>
> I'd like to publish my code only under GPL if possible.
