Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645AD23B28B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 04:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHDCBT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 22:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgHDCBT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Aug 2020 22:01:19 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A95220792;
        Tue,  4 Aug 2020 02:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596506478;
        bh=4XVqqgwktGruGGFjT+GJfaOJ/4GWRFCLq8E7Ac4NJeM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s7Qh5+Lxr+2nDRrGsJ0Yq6A9rR6jlqp0FqJ/GFWzSLjwbl1ob1p2kW+orUqP/UbJk
         2Xwqjt0wHyyMv/vkMx9rIMQ/78hIlHhANg6hlpQem6KNvWN8cwMjtVLLOyQ382649l
         PLdpkXwlxAyRZ2msArinhyUhPJ7Yp1hqYpdnLViE=
Received: by mail-oi1-f180.google.com with SMTP id l84so22494014oig.10;
        Mon, 03 Aug 2020 19:01:18 -0700 (PDT)
X-Gm-Message-State: AOAM531pb9nPlaBn2CqhbmbXm3HuRADXrr2QBahyK2NhWG/OFRpoz9dR
        iP3PkIWsDwdAva9ejGrwUp9ROgEmgzA8vexKFw==
X-Google-Smtp-Source: ABdhPJybkTGDHYJ7RbW8usE+aYAZuvyH9Qf4GxLxWv9aK7s5b4rphMB8CDwUhA8saSycpJZznnMHvSF2z7+MYaTpAkg=
X-Received: by 2002:aca:c3d8:: with SMTP id t207mr1037981oif.152.1596506477732;
 Mon, 03 Aug 2020 19:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200731164853.3020946-1-campello@chromium.org>
 <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
 <20200801160639.1410944e@archlinux> <159648122347.1360974.1094560524092762187@swboyd.mtv.corp.google.com>
In-Reply-To: <159648122347.1360974.1094560524092762187@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 3 Aug 2020 20:01:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLs99Q7o32mqZROQSLuaf-_6vVg_wSVbpMr0u3eD9LVEw@mail.gmail.com>
Message-ID: <CAL_JsqLs99Q7o32mqZROQSLuaf-_6vVg_wSVbpMr0u3eD9LVEw@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 3, 2020 at 1:00 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Jonathan Cameron (2020-08-01 08:06:39)
> > On Fri, 31 Jul 2020 10:48:38 -0600
> > Daniel Campello <campello@chromium.org> wrote:
> > > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> > > new file mode 100644
> > > index 00000000000000..5739074d3592fe
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> > > @@ -0,0 +1,65 @@
> [...]
> > > +
> > > +  "#io-channel-cells":
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#io-channel-cells"
> >
> > Missed this in earlier review (only noticed when I saw whilst santity
> > checking earlier versions.
> >
> > Fairly sure we should only need #io-channel-cells if we have
> > a consumer of a channel somewhere else in DT.  So it's not
> > required as far as I can see.
> >
>
> This is mostly a decision for Rob to make, but I would make it required
> because the device is always an io channel provider. It may be that it
> isn't providing anything in the DT to something else in the DT but it is
> providing this information somewhere so always having to spell that out
> is simple and doesn't hurt.

I agree. If the user is split in a board file or overlay, we don't
want to have to be adding it to the provider at that time.

Rob
