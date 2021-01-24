Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404C4301F46
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 23:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbhAXWel (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 17:34:41 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42347 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbhAXWej (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2021 17:34:39 -0500
Received: by mail-oi1-f176.google.com with SMTP id x71so12810016oia.9;
        Sun, 24 Jan 2021 14:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2RMG+c0LYr9lQCOK29vflqsSlW578VaXZKlXgzpefEk=;
        b=qJ2G9JwwDFNWYKGqHWztSHkJr+5IDWQ+hOte+5LW0rSHpwpsQJ8DsYfguUwG+LzGHX
         FS7AxhssuVnPdptqTUEl7qgcjEEGicaBll0EzdYGvBGeLUU/aVnXVAOKQCjOVv4bPaaK
         MYIb6gKNQAU8cPHJJW4wN18Q5spHo4qxfCuN8KBvE6amTktDftVqScGScXMhT6BAonXL
         ErdEq8L0LD+EY8BP9EgEF2DzgQa/1NBaGcYozokV17G19nM7Gi46IzHxSI8hyFE9rbTI
         iCLgzdNrHy/8/gc5w+Np3EV6/PbrtaTdhAALdsplHnv8N6K1yrWeHMQa+WvGsFnzfy4P
         E+dQ==
X-Gm-Message-State: AOAM530S8+vPkgk7BTNL7DWEJ7b4CO8QF9zbi9XJpM/erci15dT5ZAxG
        hVGPDvF/m5Y4H5vUm2+ZrA==
X-Google-Smtp-Source: ABdhPJwWnU/Gjn+nXvD8dzcHe+2p56vqZrZL0rHU800KtpCJYrtpuF8vMc8TYLgN2puOMYrtXGrPNw==
X-Received: by 2002:aca:b255:: with SMTP id b82mr2288689oif.98.1611527638582;
        Sun, 24 Jan 2021 14:33:58 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e17sm3133948otf.32.2021.01.24.14.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 14:33:57 -0800 (PST)
Received: (nullmailer pid 2741588 invoked by uid 1000);
        Sun, 24 Jan 2021 22:33:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-iio@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <20210122225443.186184-3-swboyd@chromium.org>
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-3-swboyd@chromium.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Date:   Sun, 24 Jan 2021 16:33:56 -0600
Message-Id: <1611527636.605154.2741587.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Jan 2021 14:54:42 -0800, Stephen Boyd wrote:
> Some cros ECs support a front proximity MKBP event via
> 'EC_MKBP_FRONT_PROXIMITY'. Add a DT binding to document this feature via
> a node that is a child of the main cros_ec device node. Devices that
> have this ability will describe this in firmware.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../proximity/google,cros-ec-proximity.yaml   | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml

See https://patchwork.ozlabs.org/patch/1430611

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

