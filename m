Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27BB23E3DF
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 00:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHFWMs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 18:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgHFWMr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 18:12:47 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE374221E3;
        Thu,  6 Aug 2020 22:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596751967;
        bh=5kIwo2Mps+WdhyyhERg/v0Yl22kiC8RQaCXpPI4M014=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=InKJtaBBiNTqyGpsmNkDccmciz3oHLLWtcH3xB9h2+Vzs0MB1bUqnpN+kB/KuGDLm
         vrVKeETgv4CVf3pfiEuyvS1p6bVA0WpFpdDmY+VQWV7ACFUzR1vK5Q1sKV5wXbb+AD
         8eBlV9CcL2zJkfes/ta+8AnwX84RPfk7pMR/Ued0=
Received: by mail-ot1-f53.google.com with SMTP id h22so74752otq.11;
        Thu, 06 Aug 2020 15:12:46 -0700 (PDT)
X-Gm-Message-State: AOAM5315Tnja29A1HsgZeSUWrvCtrCONpFK4yAanBfwQADLmrXR17wR8
        pVa4zn6Ei3+Fdw2J+SE/uUOsm9PObd7t6Wma4Q==
X-Google-Smtp-Source: ABdhPJymKfUI6jSAReX64xGfCidAykanzrZqSlJ6L628ZfqbwHcACImpWOlyFoKKUkxKjQjAZZyIRI+/aKWC/GjuN+U=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr8745864ote.107.1596751965884;
 Thu, 06 Aug 2020 15:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200731164853.3020946-1-campello@chromium.org>
 <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
 <20200801160639.1410944e@archlinux> <159648122347.1360974.1094560524092762187@swboyd.mtv.corp.google.com>
 <CAL_JsqLs99Q7o32mqZROQSLuaf-_6vVg_wSVbpMr0u3eD9LVEw@mail.gmail.com> <20200806191451.3ce5ec57@archlinux>
In-Reply-To: <20200806191451.3ce5ec57@archlinux>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 6 Aug 2020 16:12:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJou=yHsyQB+TUvwbNHDh81g7Lm7oWJfavYmPuYtxhREQ@mail.gmail.com>
Message-ID: <CAL_JsqJou=yHsyQB+TUvwbNHDh81g7Lm7oWJfavYmPuYtxhREQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
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

On Thu, Aug 6, 2020 at 12:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 3 Aug 2020 20:01:06 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
>
> > On Mon, Aug 3, 2020 at 1:00 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Jonathan Cameron (2020-08-01 08:06:39)
> > > > On Fri, 31 Jul 2020 10:48:38 -0600
> > > > Daniel Campello <campello@chromium.org> wrote:
> > > > > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> > > > > new file mode 100644
> > > > > index 00000000000000..5739074d3592fe
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> > > > > @@ -0,0 +1,65 @@
> > > [...]
> > > > > +
> > > > > +  "#io-channel-cells":
> > > > > +    const: 1
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - "#io-channel-cells"
> > > >
> > > > Missed this in earlier review (only noticed when I saw whilst santity
> > > > checking earlier versions.
> > > >
> > > > Fairly sure we should only need #io-channel-cells if we have
> > > > a consumer of a channel somewhere else in DT.  So it's not
> > > > required as far as I can see.
> > > >
> > >
> > > This is mostly a decision for Rob to make, but I would make it required
> > > because the device is always an io channel provider. It may be that it
> > > isn't providing anything in the DT to something else in the DT but it is
> > > providing this information somewhere so always having to spell that out
> > > is simple and doesn't hurt.
> >
> > I agree. If the user is split in a board file or overlay, we don't
> > want to have to be adding it to the provider at that time.
>
> That is perhaps a reasonable view point for devices with channels that
> are likely to be used by consumer drivers, but in this particular case we
> are talking about a proximity sensor.  So far I don't think we
> have any consumer drivers for this type of sensor (I might have forgotten
> one of course!)

Indeed, I didn't consider whether it made sense in the first place. So
should it just not be specified at all in this case? I can't really
picture what the usecase for a consumer node would be.

Rob
