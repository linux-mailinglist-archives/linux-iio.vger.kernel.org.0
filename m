Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E4C23ACB2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 21:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHCTA3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 15:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCTA2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 15:00:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615DFC061756
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 12:00:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u185so18706771pfu.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2bQwe2K0XwzuOlpiqVHsdZ/mH76OOHNTt78eXB94PDA=;
        b=BH/zrsl7HzNzpTlN+nMwokcT3MWMfuojbLn05mlyEULmbsnBhqj4VAFvCzgrU3AhOq
         AAPbj5DaS06efsVQIW+JpTH153H2gSJ3+rhhTTphBEVearFVbJG6wRh+fk1ppaci8sd1
         oP5DaU5vBan2xV1jC/yq38a0U/2ZO3nHas3Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2bQwe2K0XwzuOlpiqVHsdZ/mH76OOHNTt78eXB94PDA=;
        b=CEIsfCdrwj1CnGidjHnasvNqa68U82IftvhiMWXvuNUCv3F0Rfb6ua6ZQPr6mbomo6
         Pjmr+qXhQJpN5GnKz6JPKyRHj3Jht4CzetvNNYiCZtGvs9K1x2xgBjxWV16/5yWDGYfN
         aS7AXbvUjLlzWg1eJdp3KWp4z2SRO/9YFPU1WC711tvAnDSfpczmZhtiRXJuDgy5fFfN
         +YS4cp31Vd9Uxf03Aq9ohRcpLW7cPWnUUwrZTuv89HjuJkn9+fVtz5r4bDhex1QQHv2p
         rCGb2xEKWOCu2W0gB4K1BetALh7fkugaF9JSwWRzGfWu4Hoo3WusxoV7UJoOHhWVzIb1
         NCaQ==
X-Gm-Message-State: AOAM532+ntGOY8yS8DTqpLZ1S9PsIXrlnN0T6pudhe07MrW3oFMwArIz
        61b+nMuxHTx98INRYAGiyxmr8Q==
X-Google-Smtp-Source: ABdhPJyAnvPLb+WX6KXXnGh4DTEpK7hgx9NQhChy0h95gy8dWIheKWnC0JPY4Et2iYOSVZLMlstGDQ==
X-Received: by 2002:a65:6205:: with SMTP id d5mr15445995pgv.432.1596481226804;
        Mon, 03 Aug 2020 12:00:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id p19sm19668907pgj.74.2020.08.03.12.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:00:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200801160639.1410944e@archlinux>
References: <20200731164853.3020946-1-campello@chromium.org> <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid> <20200801160639.1410944e@archlinux>
Subject: Re: [PATCH v3 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Mon, 03 Aug 2020 12:00:23 -0700
Message-ID: <159648122347.1360974.1094560524092762187@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2020-08-01 08:06:39)
> On Fri, 31 Jul 2020 10:48:38 -0600
> Daniel Campello <campello@chromium.org> wrote:
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx=
9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.=
yaml
> > new file mode 100644
> > index 00000000000000..5739074d3592fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.ya=
ml
> > @@ -0,0 +1,65 @@
[...]
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#io-channel-cells"
>=20
> Missed this in earlier review (only noticed when I saw whilst santity
> checking earlier versions.
>=20
> Fairly sure we should only need #io-channel-cells if we have
> a consumer of a channel somewhere else in DT.  So it's not
> required as far as I can see.
>=20

This is mostly a decision for Rob to make, but I would make it required
because the device is always an io channel provider. It may be that it
isn't providing anything in the DT to something else in the DT but it is
providing this information somewhere so always having to spell that out
is simple and doesn't hurt.
