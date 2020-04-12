Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 751851A5E44
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgDLL2l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 07:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgDLL2k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 07:28:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91102206E9;
        Sun, 12 Apr 2020 11:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586690920;
        bh=A/TM2oZuIWL2EcklHfwd3IM6ORspyJc0stBXtKjtBtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mjSBtzPdfD5aLHkxChC+xIurPEkwhk6c8vyItlQkRMN3s1SKoXc/TQl98/wLX7vIV
         /RvUnWHx72Bw43ZtJGMnlJ+xHCQAWVocGyuSg6nBBhP5NuGtwg1AQWxTZIrmG1vBFM
         +134sAzDi5k5DYt+DYnr8paJwxvNWI0j/fPF/DPI=
Date:   Sun, 12 Apr 2020 12:28:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: iio: Introduce common properties
 for iio sensors
Message-ID: <20200412122835.15f82420@archlinux>
In-Reply-To: <8b91f0b7fa76ca4b2f3cdc251411829f71f8d810.1586094535.git.agx@sigxcpu.org>
References: <cover.1586094535.git.agx@sigxcpu.org>
        <8b91f0b7fa76ca4b2f3cdc251411829f71f8d810.1586094535.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 Apr 2020 15:50:29 +0200
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> Introduce a file for common properties of iio sensors. So far this
> contains the new proximity-near-level property for proximity sensors
> that indicates when an object should be considered near.
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
This works for me. However, I would like to give time for Rob and
others to comment on the syntax, naming etc of this file.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/common.yaml       | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/common.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/common.yaml b/Document=
ation/devicetree/bindings/iio/common.yaml
> new file mode 100644
> index 000000000000..97ffcb77043d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/common.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common properties for iio sensors
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +  - Guido G=C3=BCnther <agx@sigxcpu.org>
> +
> +description: |
> +  This document defines device tree properties common to several iio
> +  sensors. It doesn't constitue a device tree binding specification by i=
tself but
> +  is meant to be referenced by device tree bindings.
> +
> +  When referenced from sensor tree bindings the properties defined in th=
is
> +  document are defined as follows. The sensor tree bindings are responsi=
ble for
> +  defining whether each property is required or optional.
> +
> +properties:
> +  proximity-near-level:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      For proximity sensors whether an object can be considered near to =
the
> +      device depends on parameters like sensor position, covering glass =
and
> +      aperture. This value gives an indication to userspace for which
> +      sensor readings this is the case.
> +
> +      Raw proximity values equal or above this level should be
> +      considered 'near' to the device (an object is near to the
> +      sensor).
> +
> +...

