Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF60301DE6
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 18:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbhAXR2o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 12:28:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbhAXR2n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 12:28:43 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6DB22CA2;
        Sun, 24 Jan 2021 17:28:00 +0000 (UTC)
Date:   Sun, 24 Jan 2021 17:27:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Message-ID: <20210124172756.69ef7c5a@archlinux>
In-Reply-To: <20210122225443.186184-3-swboyd@chromium.org>
References: <20210122225443.186184-1-swboyd@chromium.org>
        <20210122225443.186184-3-swboyd@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Jan 2021 14:54:42 -0800
Stephen Boyd <swboyd@chromium.org> wrote:

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
> diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml
> new file mode 100644
> index 000000000000..c0a34bdfe4fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/iio/proximity/google,cros-ec-proximity.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ChromeOS EC MKBP Proximity Sensor
> +
> +maintainers:
> +  - Stephen Boyd <swboyd@chromium.org>
> +  - Benson Leung <bleung@chromium.org>
> +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +
> +description: |
> +  Google's ChromeOS EC sometimes has the ability to detect user proximity.
> +  This is implemented on the EC as near/far logic and exposed to the OS
> +  via an MKBP switch bit.
> +
> +properties:
> +  compatible:
> +    const: google,cros-ec-proximity
> +
> +  label:
> +    description: Name for proximity sensor
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    proximity {

Can we at least have the example making it clear this is a child of the
cros_ec device?

> +        compatible = "google,cros-ec-proximity";
> +        label = "proximity-wifi-lte";
> +    };

