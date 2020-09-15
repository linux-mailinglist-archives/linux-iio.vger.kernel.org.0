Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D0A26AEF3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 22:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgIOUyR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 16:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgIOUqL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Sep 2020 16:46:11 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8A320771;
        Tue, 15 Sep 2020 20:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600202770;
        bh=xNij15p4P49UNSI8vqX3G0I5polWfTUWSoVh58ATT6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gt4lAV7fxLb85ApZtUqFZ3IzVTYfnWrB961LD+BzrH/sLM4DN6PZahqA/l/A6+NDF
         pksf1fSgAlvCnqNdsFnbF8aL8CfbyvOtZrufeX8Bylmsf7+aD1BPzAl3puTjUJVDUs
         xFgO4jMlgZ8fb/lSEYLyDYYs165ANIlTgCafXi8c=
Received: by mail-oi1-f182.google.com with SMTP id i16so61919oii.12;
        Tue, 15 Sep 2020 13:46:10 -0700 (PDT)
X-Gm-Message-State: AOAM530+W7NHm5eIbHmTvz36ewG7VSQlfVdoD6hOgW9A7QGDPqWCM57M
        +x8kGs3NL5Nawl7eTazRsXTCrehqd0IM5hB8xQ==
X-Google-Smtp-Source: ABdhPJyOODYWcSrHt9Kx+eyXWwxqZbYs/tH3pLU1MLwVuDm22nO5URIVSWzHwWTplm4mqSWTjghDhs5XNwqtszUSXnQ=
X-Received: by 2002:aca:4cc7:: with SMTP id z190mr888591oia.147.1600202770088;
 Tue, 15 Sep 2020 13:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200909175946.395313-1-jic23@kernel.org> <20200909175946.395313-2-jic23@kernel.org>
In-Reply-To: <20200909175946.395313-2-jic23@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Sep 2020 14:45:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJhBFqi8=gku8sv5=8MTB1uCTq=DkuoVzEaUMxO1QhBAg@mail.gmail.com>
Message-ID: <CAL_JsqJhBFqi8=gku8sv5=8MTB1uCTq=DkuoVzEaUMxO1QhBAg@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] dt-bindings:iio:adc:fsl,vf610-adc conversion to yaml.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fugang Duan <B38611@freescale.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 9, 2020 at 12:02 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> A simple conversion of this freescale ADC binding from txt to yaml.
> For maintainer I went with Fugang Duan as the original author of the
> binding. Would be great to have confirmation of this.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fugang Duan <B38611@freescale.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/iio/adc/fsl,vf610-adc.yaml       | 81 +++++++++++++++++++
>  .../devicetree/bindings/iio/adc/vf610-adc.txt | 36 ---------
>  2 files changed, 81 insertions(+), 36 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> new file mode 100644
> index 000000000000..99b6b55fd0a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/fsl,vf610-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADC found on Freescale vf610 and similar SoCs
> +
> +maintainers:
> +  - Fugang Duan <B38611@freescale.com>

I assume you got a bunch of bounces on this series, too? Looks like 1,
4, 7, 9, 13, 16, 19, and 20 bounced. Please fix those addresses before
applying.

Rob
