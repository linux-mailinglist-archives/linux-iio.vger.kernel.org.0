Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C37DF437
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 19:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJUR2z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 13:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfJUR2z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 13:28:55 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751D32077C;
        Mon, 21 Oct 2019 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571678933;
        bh=Qzg+nSzQSl15mcasjyGbnQQil/A3TPHlMSePYlNANZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RgGKvjMKa74HImO3uxjYKvw0NK90LMd1NHS62oYJe/PK7d2Wn6sNEjJ/2E2hICDBd
         XByPz58+kfMLYVHX1NC7mvZsqWf+FPP3777xTm0eCgqua4idWWIpn63aYOk4Fv/Qdf
         Ey7ZtrC9+zWSUcPXn5OWFVJdxwLias2NyrWVNb6U=
Received: by mail-qt1-f171.google.com with SMTP id e14so2441067qto.1;
        Mon, 21 Oct 2019 10:28:53 -0700 (PDT)
X-Gm-Message-State: APjAAAWE5+HVqury7By6WCJIjedzOM76I1r2t/0LNRK6JID2UPap1e4z
        diXGGJzTrZjDWD1GeRe6bf5Mn8QxxN8RubV/pw==
X-Google-Smtp-Source: APXvYqycsWbsOq+RkNJmmVCRQvnEVotA2t3MyLrnXmKMy7TpkH+IaWBEzx0jJADgfZO6JSeE0XNQkDJsPHRfKzk4np8=
X-Received: by 2002:ac8:70c4:: with SMTP id g4mr12467338qtp.136.1571678932597;
 Mon, 21 Oct 2019 10:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191005151404.5fc7386f@archlinux> <1571664677-6984-1-git-send-email-gupt21@gmail.com>
In-Reply-To: <1571664677-6984-1-git-send-email-gupt21@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Oct 2019 12:28:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLoVf4QCYJE_Bak+httr6_bT=iP63waNNiUHz1+PdLhPg@mail.gmail.com>
Message-ID: <CAL_JsqLoVf4QCYJE_Bak+httr6_bT=iP63waNNiUHz1+PdLhPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: light: add veml6030 ALS bindings
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>, alexios.zavras@intel.com,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 21, 2019 at 8:31 AM Rishi Gupta <gupt21@gmail.com> wrote:
>
> This commit adds device tree bindings for veml6030 ambient
> light sensor.
>
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
> Changes in v3:
> * None
>
> Changes in v2:
> * Corrected grammatical mistake from 'is' to 'are' in description of bindings
>
>  .../devicetree/bindings/iio/light/veml6030.yaml    | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/light/veml6030.yaml b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
> new file mode 100644
> index 0000000..969b314
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0+

(GPL-2.0-only OR BSD-2-Clause) for new bindings please.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/veml6030.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VEML6030 Ambient Light Sensor (ALS)
> +
> +maintainers:
> +  - Rishi Gupta <gupt21@gmail.com>
> +
> +description: |
> +  Bindings for the ambient light sensor veml6030 from Vishay
> +  Semiconductors over an i2c interface.
> +
> +  Irrespective of whether interrupt is used or not, application
> +  can get the ALS and White channel reading from IIO raw interface.
> +
> +  If the interrupts are used, application will receive an IIO event
> +  whenever configured threshold is crossed.
> +
> +  Specifications about the sensor can be found at:
> +    https://www.vishay.com/docs/84366/veml6030.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - vishay,veml6030
> +
> +  reg:
> +    description:
> +      I2C address of the device. If the ADDR pin on veml6030
> +      is pulled up, this address is 0x48. If the ADDR pin is
> +      pulled down, this address is 0x10.

If you want to define the addresses, then you do:

enum:
  - 0x10 # ADDR pin pulled down
  - 0x48 # ADDR pin pulled up

> +    maxItems: 1

And drop this.

> +
> +  interrupts:
> +    description:
> +      interrupt mapping for IRQ. Configure with IRQ_TYPE_LEVEL_LOW.
> +      Refer to interrupt-controller/interrupts.txt for generic
> +      interrupt client node bindings.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@10 {
> +                compatible = "vishay,veml6030";
> +                reg = <0x10>;
> +                interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...
> --
> 2.7.4
>
