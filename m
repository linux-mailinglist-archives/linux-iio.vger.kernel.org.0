Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E91814A791
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2020 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgA0PyZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jan 2020 10:54:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35149 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0PyY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jan 2020 10:54:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id b18so3142991oie.2;
        Mon, 27 Jan 2020 07:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tu9ZlBYkC6o1zbN6Prwgx0xQgg3OVVMzuDrAyUe9dwo=;
        b=Lk5FWyL3MULbH0sDvBbGYzs6JidrBIuFv+11P95UOCzy0bHsEdtx8ifMi6q1ETO/L/
         xTdnx0VtPrE0zUKWhnZ++qK2VRfVn8dRBj+sS4m7slGmGXq5GdclJBp5x4whP81xMVkc
         bWjzNnn0KOkgnUFahL4QuYr2B8a2CTdHFtogbfEcCk38OU/16kEMiqpFV9iJ3U4dEG8n
         VAWYlhoMlNNYpTfIAjxjCtQ1qd+6R9WpIgbDYzwvEgFaROeclFbDEfK0X5tAYx9ZpU8y
         yWLC7o+Fjo96MZdC7C5Ee8Q0ThNMy/LUIZcouujJqaejgW/i9fZ0c4vOiGtC/dN93r/f
         n50Q==
X-Gm-Message-State: APjAAAXABCIjCWDXEB5k1zm5KnOc40AB1cBYR59+LR2X2NXc8KanerWY
        vCyaX7YTSWjSb5XPNt6KVA==
X-Google-Smtp-Source: APXvYqy5dQoTgHQWvCOWBsQEb02lntw0zQ/+al7/2pS20P4aUtSrP6rYXXWdtPasUTvJ51MfVHiL7A==
X-Received: by 2002:a54:4896:: with SMTP id r22mr7924750oic.30.1580140463895;
        Mon, 27 Jan 2020 07:54:23 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g61sm5658999otb.53.2020.01.27.07.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:54:22 -0800 (PST)
Received: (nullmailer pid 25360 invoked by uid 1000);
        Mon, 27 Jan 2020 15:54:21 -0000
Date:   Mon, 27 Jan 2020 09:54:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors
Message-ID: <20200127155421.GA21914@bogus>
References: <101D4944-A6B0-4CF7-AF6E-A6196619E3CF@norphonic.com>
 <23805E09-AF91-4984-BF5D-29D989C2E48A@norphonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23805E09-AF91-4984-BF5D-29D989C2E48A@norphonic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 23, 2020 at 09:19:12PM +0000, Eugene Zalkonnikov wrote:
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
> 
> diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml
> --- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml	2020-01-23 17:13:51.573766898 +0100

Full compatible string for filename is preferred: ti,hdc2010.yaml

> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/hdc2010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDC2010/HDC2080 humidity and temperature iio sensors
> +
> +maintainers:
> +  - Eugene Zaikonnikov <eugene.zaikonnikov@norophonic.com>
> +
> +description: |
> +  Relative humidity and tempereature sensors on I2C bus

checkpatch.pl reports a typo.

> +
> +  Datasheets are available at:
> +    http://www.ti.com/product/HDC2010/datasheet
> +    http://www.ti.com/product/HDC2080/datasheet
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,hdc2010
> +      - ti,hdc2080
> +
> +  vddd-supply:
> +    description:
> +      digital voltage regulator (see regulator/regulator.txt)
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      interrupt mapping for IRQ

Drop this. Nothing specific here for this binding.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      hdc200x@40 {
> +          compatible = "ti,hdc2010";
> +          reg = <0x40>;
> +      };
> +    };
> 
