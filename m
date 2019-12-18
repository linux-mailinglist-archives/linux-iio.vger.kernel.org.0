Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B53124EF7
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 18:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLRRUK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 12:20:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33656 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRRUJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 12:20:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so3378841otp.0;
        Wed, 18 Dec 2019 09:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=39Bl4Z57fFv4D5CXbdgD7WFD7KvEvFFwFUvRcMq+Wno=;
        b=iPgZH2YLQ72soVFp2pFW5hXVjaxWD4Y8v00/+hqY3koviNjRmz6pvZd28puEhNm9Dd
         qbLlbszn3bDEOuoPk6zGvFD7Nrjxiugk33gx4zbQbxOhuxQl9YFoNuVP+Jj8lednmtrK
         a9AFqdaKRM90uPptW1d+THSB0o49cGGvBlAPY3zGLm2pIpNFTfx1UPrrEeSC95pJK2a0
         +IxWVqZmcwuMSHmfYE+89YG06BI62qwC3crzJdjlWIFxe3YKDFOUcfFWqtUuWr9I2oH/
         5jJtiAe+Y/iylXS7leJSFUKQ5Z7+vdvks99kVphz0C+gBqHz6adsOmJde+vwIM49PZX0
         uWgQ==
X-Gm-Message-State: APjAAAX7UDC14gNBRM+/p3S6ASok+OULGJzOyLJSpkbXXwBF5lE3NiWx
        g2eU8m5/cghkZT2TBUHPyQ==
X-Google-Smtp-Source: APXvYqw8k2Mc71+My1ybl/LT2IgZ9SoRthFTb2hdFnXkuJYxr9KNIOclSyO+MnX8BF+Tt3VVUtL5nA==
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr3795396otp.339.1576689608725;
        Wed, 18 Dec 2019 09:20:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j26sm1000719otq.18.2019.12.18.09.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:20:08 -0800 (PST)
Date:   Wed, 18 Dec 2019 11:20:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191218172007.GB18325@bogus>
References: <20191211010308.1525-1-dan@dlrobertson.com>
 <20191211010308.1525-2-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211010308.1525-2-dan@dlrobertson.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 11, 2019 at 01:03:07AM +0000, Dan Robertson wrote:
> Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> accelerometer sensor.
> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> ---
>  .../bindings/iio/accel/bosch,bma400.yaml      | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> new file mode 100644
> index 000000000000..03b7ad345523
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/bosch,bma400.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMA400 triaxial acceleration sensor
> +
> +maintainers:
> +  - Dan Robertson <dan@dlrobertson.com>
> +
> +description: |
> +  Acceleration and temerature iio sensors with an i2c interface
> +
> +  Specifications about the sensor can be found at:
> +    https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA400-DS000.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - bosch,bma400
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      accelerometer@14 {
> +        compatible = "bosch,bma400";
> +        reg = <0x14>;
> +      };
> +    };
> 
> 
