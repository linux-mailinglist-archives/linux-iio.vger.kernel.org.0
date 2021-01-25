Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B082E3035A0
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 06:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbhAZFs3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 00:48:29 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:37124 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730011AbhAYPgu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 10:36:50 -0500
Received: by mail-ot1-f54.google.com with SMTP id h14so13093919otr.4;
        Mon, 25 Jan 2021 07:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FEBt/SrotSicnDDRXYm3hYtm6m7tZEPXr+a4FOUO12I=;
        b=MZ0joswGtIyDAKN/6NpvWDFO5f8uG5Q4YenpX6wcCJaNaIuaUDf8uUq/XvluQLSF5r
         YhanqmirJE21H+ZFtBY6xLFK+a+Wy0M10t/X0vLjwPXWmbp+VpyksuxfYn9rQBfX6ySN
         xG2CgiolbmoCQmyck0HEahTBUTYvDTBdvk5+0P2sSdqHZqCCtuUvbTjAkqHfWXXryPgs
         7mO8GPD6Bw8RshbsdIrPWt4xqeL8BTNky9bq9VWsmKPC6YLxVQQqV9KSOqKtblBJ+GGW
         /BR55YkB/y0+LctaYEKdCjXxonavXbAvj5jlkJ6+mVkvZMOb4wdfcljCLYzb1gxNmIqm
         7vHA==
X-Gm-Message-State: AOAM5329wyAQapUTAOlJ20x6Wv/hc5iekOnPjArbhGLFF2SVqTndGinn
        GFjkYeQvXeyEX/Yi4jqmza0aclPi6A==
X-Google-Smtp-Source: ABdhPJwe95zDlCb2mWAtJRJWQg7ZdYrrnzSkvMRjto0OGYewjVAM12bcKOjBpLRmiaW8A2ktwQyI/g==
X-Received: by 2002:a9d:748a:: with SMTP id t10mr722094otk.336.1611586925207;
        Mon, 25 Jan 2021 07:02:05 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k15sm3519063otp.10.2021.01.25.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:02:04 -0800 (PST)
Received: (nullmailer pid 346850 invoked by uid 1000);
        Mon, 25 Jan 2021 15:02:03 -0000
Date:   Mon, 25 Jan 2021 09:02:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Message-ID: <20210125150203.GA341275@robh.at.kernel.org>
References: <20210122225443.186184-1-swboyd@chromium.org>
 <20210122225443.186184-3-swboyd@chromium.org>
 <20210124172756.69ef7c5a@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124172756.69ef7c5a@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 24, 2021 at 05:27:56PM +0000, Jonathan Cameron wrote:
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
> > +
> > +  label:
> > +    description: Name for proximity sensor
> > +
> > +required:
> > +  - compatible
> > +
> > +unevaluatedProperties: false

additionalProperties: false

> > +
> > +examples:
> > +  - |
> > +    proximity {
> 
> Can we at least have the example making it clear this is a child of the
> cros_ec device?

Move this to the core Cros EC binding. The core binding needs to define 
'proximity' and reference this binding ($ref).

> 
> > +        compatible = "google,cros-ec-proximity";
> > +        label = "proximity-wifi-lte";
> > +    };
> 
