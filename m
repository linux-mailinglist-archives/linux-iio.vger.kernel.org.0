Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD0D301EC8
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 21:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbhAXUnt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 15:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbhAXUns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2021 15:43:48 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3E1C061573
        for <linux-iio@vger.kernel.org>; Sun, 24 Jan 2021 12:43:07 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id u17so22627290iow.1
        for <linux-iio@vger.kernel.org>; Sun, 24 Jan 2021 12:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvqt0wMUCgaJb2QCjgNdTwtimCxgRvZpl4rRhVBBS5I=;
        b=LmhOmYVIGy5XQClncUyexrRr2nyzzZ80LyVKXYcHeogY3kQlq9h27lGRCLlVKS6A2G
         /e2O5eXC1MYyJC0kVerfiTBR+g8dtlGlF2ydWCk8tPr6+F3H6zXaeDWJvYTf4Fyh7pJH
         oVnnUoS/qcenGu5Z0Sp8nk4fx5LOKw81YU+wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvqt0wMUCgaJb2QCjgNdTwtimCxgRvZpl4rRhVBBS5I=;
        b=mogjoIHTqn4q6wg6pqbpyKdm9mmzt2ZfRvjk+11gzrPgJbzfo5vt0mbMIfpMHu2S2G
         na8Vmlm84qbSUMqJIStTnYwG76EnxY4HdJB8H8MEBiKvT/1MZy69B1rE0g5uz7+sfHHH
         bbGjRmecBmpTsmFNwhpEHBguJfw+TaV8sgx6inHivxt+DZRTt60f2kAEs1LxqMDYcLlH
         bebyB7RBY8p5F/oIUSSOh2V1HCf0upvG3LXmT6/kybK05S5gcbOabp5UBAenz+ZwnAEg
         LR5dYD+HrfKX4l+6iKkJ4ToZhrNiu2xhLFhsSw4s6MyAzLMrpL28tLvx/XTBnKMrzG69
         9zDg==
X-Gm-Message-State: AOAM533ZcXK9P25kDuGGkQWrrPecUVkpEYGWCNtS1CWAMhhFUwgGTI8q
        jEoFAuYoGUwNDkVI/2mtLjlo+Bg86WK+VILTUf/UZA==
X-Google-Smtp-Source: ABdhPJwype5xvCWqyKuPey1tYYGsPyFxF6WSVIwdk/KUZElF0gzRHJBgBfVCZ07FNu5ZO2JirfBz7bUG63o1LmxkCA8=
X-Received: by 2002:a05:6638:1b6:: with SMTP id b22mr623152jaq.52.1611520987222;
 Sun, 24 Jan 2021 12:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-3-swboyd@chromium.org>
 <20210124172756.69ef7c5a@archlinux>
In-Reply-To: <20210124172756.69ef7c5a@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sun, 24 Jan 2021 12:42:56 -0800
Message-ID: <CAPUE2uvd+zyWQZm=LWM6sH7tCU8MUeZVo-zJrsWzLArXA1tROg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 24, 2021 at 9:28 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 22 Jan 2021 14:54:42 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> > Some cros ECs support a front proximity MKBP event via
> > 'EC_MKBP_FRONT_PROXIMITY'. Add a DT binding to document this feature via
> > a node that is a child of the main cros_ec device node. Devices that
> > have this ability will describe this in firmware.
> >
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: <devicetree@vger.kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../proximity/google,cros-ec-proximity.yaml   | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml
> > new file mode 100644
> > index 000000000000..c0a34bdfe4fd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml
> > @@ -0,0 +1,37 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +
> > +$id: http://devicetree.org/schemas/iio/proximity/google,cros-ec-proximity.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ChromeOS EC MKBP Proximity Sensor
> > +
> > +maintainers:
> > +  - Stephen Boyd <swboyd@chromium.org>
> > +  - Benson Leung <bleung@chromium.org>
> > +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > +
> > +description: |
> > +  Google's ChromeOS EC sometimes has the ability to detect user proximity.
> > +  This is implemented on the EC as near/far logic and exposed to the OS
> > +  via an MKBP switch bit.
> > +
> > +properties:
> > +  compatible:
> > +    const: google,cros-ec-proximity
Given we have proximity detection in cros_ec via specific sensor (si
1141) or algorithm (on-body/off-body via
MOTIONSENSE_ACTIVITY_BODY_DETECTION), can we name the property
cros-ec-mkbp-proximity?
> > +
> > +  label:
> > +    description: Name for proximity sensor
> > +
> > +required:
> > +  - compatible
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    proximity {
>
> Can we at least have the example making it clear this is a child of the
> cros_ec device?
>
> > +        compatible = "google,cros-ec-proximity";
> > +        label = "proximity-wifi-lte";
> > +    };
>
