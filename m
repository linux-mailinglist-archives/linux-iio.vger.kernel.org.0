Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B888BE5153
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2019 18:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbfJYQfG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Oct 2019 12:35:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38291 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfJYQfG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Oct 2019 12:35:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id v186so2020537oie.5;
        Fri, 25 Oct 2019 09:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yF/H3rJbJdDx83JTlFll9X6DSAUOcAkkMlYZ2qdb7W8=;
        b=QiwAJalqCI8mNc1wnZCikHiR/CnYe0MVtgCchW39277vQyJo1AlM0g6QSsS4OvQ1dm
         E54K5WhID+Whu8iG2qhJHnKEZKqw63gSzsn38lbk91QT8pZWdoMmPtRJZqxEZx4xxlhv
         cpwZimI/LMynnruvrJXu2iCRP2J604IJmKxzfnMaagMQw2S47xvCCbw8e9T5fP/6WoT4
         ZqAriFHgCUWCSAVS8/dfwl2iZvP6c2B04+cm/IVqsJIER5zc1MCA8suTGWXUfPVop996
         yQvm6Ojp/DmEU3h1dromQ1RM1yUhtc3+fALxw9kqiLyCiV68bqfE5suojDchyvncnsLw
         pJUA==
X-Gm-Message-State: APjAAAWgcMoVDugrCNN3PBsfmApwWkdY9Dm8MXPeyrPAQT9VCQCuuL8a
        46M+TwQzPCWVI0W0txh5XeE5DZM=
X-Google-Smtp-Source: APXvYqzFwnoi2h7408Dc9NQGKmnU5cVF5hryFdhRKy0DlizILQRgNbq8bMnefvU0IgZdMGEtFQImJQ==
X-Received: by 2002:a54:4e8a:: with SMTP id c10mr3912144oiy.65.1572021305176;
        Fri, 25 Oct 2019 09:35:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r3sm861176otk.31.2019.10.25.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:35:04 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:35:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191025163503.GA19293@bogus>
References: <20191018031848.18538-1-dan@dlrobertson.com>
 <20191018031848.18538-2-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018031848.18538-2-dan@dlrobertson.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 18, 2019 at 03:18:47AM +0000, Dan Robertson wrote:
> Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> accelerometer sensor.
> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> ---
>  .../devicetree/bindings/iio/accel/bma400.yaml | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bma400.yaml

bosch,bma400.yaml

> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bma400.yaml
> new file mode 100644
> index 000000000000..e0a85dc7bf34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bma400.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/bma400.yaml#
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
> +    i2c0 {

i2c {

(will enable i2c bus schema)

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      bma400@14 {

accelerometer@14

> +        compatible = "bosch,bma400";
> +        reg = <0x14>;
> +      };
> +    };
> 
> 
