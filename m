Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0A276B46
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgIXH5Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgIXH5Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 03:57:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522BCC0613CE
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2020 00:57:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id md22so3929858pjb.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2020 00:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=nIx2g9hE/0bXNM/pwrWkRdm4URrOvOfMohT8HMjo9Ao=;
        b=aTSU7n5fMU41yviqESs2c9mMPf+IYx8QwuWCdmdhLxJz0Jh7jgGhtT9KnY6hRtSnKx
         1W4tIig0G0+UQUeoFk336wE8ZPR5Xl/ucbuyBnPKA6SjCe26xJRJ+kaPRtjpTOvI85L1
         16HJ5NyO5LBSiWXQFYz1YCXlgYWz3dVEO3dss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=nIx2g9hE/0bXNM/pwrWkRdm4URrOvOfMohT8HMjo9Ao=;
        b=FueQ24/mEBiNFVTjcHUC9eEY4fC4tUwCw9MYgXj1fs8yndrHd10F0kWAteJ9wYnJOo
         CbNxJKcon4q3Q1rzwc+xtjwJ3Rcb3PV8Xd7misEn6j1oNClzGOb41rzIFHxwE4uCedLW
         i8SYLPuzIiONuMnGmnTAcdUym88UAAYdfaWzJql5LLeaSwFekXqiUsWz8w8OnxjVVru2
         +7nG6Jn0byxiV75JSFv7hXh5vVY048xbsZIZtu7bqIgmUNoPaAkdjqMIY8rExUYqTwj9
         5thekvck+tQ46reVQ4TCpAwnYSWWdnzYPfgGWwceG5TPJr4sGdQ0ZPrgNZvCs9nieabg
         da4Q==
X-Gm-Message-State: AOAM5314c/nvAmhH4FyhxVHfhmy66n3U1zXQo58A3iHBqogoOPGlYi3s
        SKq0Qp8CAFurXGN84NNuZOdmZQ==
X-Google-Smtp-Source: ABdhPJxEM4eeBUcECdk2ALrU71tfv2XbEcD9NoBcPVvA8okwUHKyVVkEBPPPodWG+BJiiN8IUazBEg==
X-Received: by 2002:a17:90a:8a04:: with SMTP id w4mr2894263pjn.72.1600934235780;
        Thu, 24 Sep 2020 00:57:15 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id bx22sm1583848pjb.23.2020.09.24.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:57:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <160090354388.310579.2465697259775252128@swboyd.mtv.corp.google.com>
References: <20200903221828.3657250-1-swboyd@chromium.org> <20200906150247.3aaef3a3@archlinux> <159963232334.454335.9794130058200265122@swboyd.mtv.corp.google.com> <20200909121550.00005ede@Huawei.com> <160090354388.310579.2465697259775252128@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT properties
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date:   Thu, 24 Sep 2020 00:57:13 -0700
Message-ID: <160093423392.310579.10143738916599003618@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Stephen Boyd (2020-09-23 16:25:43)
> > > > > +
> > > > > +  semtech,close-debounce-samples:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [0, 2, 4, 8]
> > > > > +    default: 0
> > > > > +    description:
> > > > > +      The number of close samples debounced for proximity/body t=
hresholds. =20
> > > >=20
> > > > This feels like something that has more to do with the object motio=
n than
> > > > the sensor setup, so perhaps should be controlled from userspace?  =

> > >=20
> > > Sure. Is there an IIO sample property? Or I should make a custom
> > > knob for this?
> >=20
> > It's kind of close to in_proximity0_thresh_period and that may be how t=
hey
> > have implemented it.
> >=20
> > That control specifies a number of samples for which a condition should=
 be true
> > before it is reported.
>=20
> Sounds good. I can do that. It looks like the driver reports close/far
> via an event and these debounce values are the same for me so I can
> write both fields (close and far) with the same thresh_period value from
> userspace. If they need to be different between the two then this can be
> reevaluated?
>=20

Or I can assign thresh_period to falling and rising corresponding to
close/far debounce. Seems that the direction is the same, but that can
be split apart and each direction gets a different sysfs file?
