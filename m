Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A884112AF3A
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2019 23:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfLZW3h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Dec 2019 17:29:37 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44779 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZW3g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Dec 2019 17:29:36 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so21085430iln.11;
        Thu, 26 Dec 2019 14:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0HfQukFEOKou0TWVAOyJEghUYeBtOwFmOGUx5hYQoQQ=;
        b=FWneVoon1qpjIG/zrUrKluXRyc/5nXH53yI73RGCsKkaL4EWBfRQShNd5cfCsLEfNk
         mowt+ksiEZy+qAKuAy2POiRSbtlmVbAFzVtin3LzHnNAPI45e+isQrvbmT3GTYnwg7ax
         4cDol6sA8KALk7A4m/JGqGiHRKNsu5vrQObYzcPcP8EXmqhFjxIWqbsaOD21AXJ9UTak
         sNWWSp1MIyJaV54eoL9bHDG95gNNpSGzeOZZ0VJsEuVgJGIYQu1Zur38h34mj6SZonpy
         D1ficwMv+G1eMJ5qIx0CsHhUG4o10OUyj8dbP3OpdjfX8PpYtzvnYTTBlPOodN8LvTcH
         uYAw==
X-Gm-Message-State: APjAAAXr69NmzzDBMDDoijI8vr2VHFoF3O8/z7ST1vUCLFKen+KdLS9e
        taad2AskJn7yzHUOv+Iykg==
X-Google-Smtp-Source: APXvYqyKHeFTS1rgXKIJtDHqKWaKwJuhNX9UygXL9K1AQkx1JoP6Vcp4Eq4BkAUtVgXSERlQ2Nhkgg==
X-Received: by 2002:a92:ce85:: with SMTP id r5mr42607880ilo.301.1577399376036;
        Thu, 26 Dec 2019 14:29:36 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t23sm12668682ila.75.2019.12.26.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:29:34 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:29:33 -0700
From:   Rob Herring <robh@kernel.org>
To:     YuDong Zhang <mtwget@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: chemical: Add bindings for
 Dynament Premier series single gas sensor
Message-ID: <20191226222933.GA20958@bogus>
References: <20191217102930.26102-1-mtwget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217102930.26102-1-mtwget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 17, 2019 at 06:29:30PM +0800, YuDong Zhang wrote:
> Dynament Premier series single gas sensor.
> 
> Signed-off-by: YuDong Zhang <mtwget@gmail.com>
> ---
>  .../iio/chemical/dynament,premier.yaml        | 39 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  1 +
>  3 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
> new file mode 100644
> index 000000000000..e2bbae4dd086
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/dynament,premier.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dynament Premier series single gas sensor
> +
> +maintainers:
> +  - YuDong Zhang <mtwget@gmail.com>
> +
> +description: |
> +  single gas sensor capable of measuring gas concentration of dust
> +  particles, multi-gas sensor are not supported.
> +
> +  Specifications about the sensor can be found at:
> +    https://www.dynament.com/_webedit/uploaded-files/All%20Files/SIL%20Data/tds0045_1.44.pdf, read chapter 1.5.2 Read live data simple
> +
> +properties:
> +  compatible:
> +    enum:
> +      - dynament,premier

Typically compatible strings are for a specific part #, so you can 
handle any differences. Unless the differences are discoverable in 
another way (like registers).

> +
> +  vcc-supply:
> +    description: regulator that provides power to the sensor
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    serial {
> +      single-gas-sensor {
> +        compatible = "dynament,premier";
> +        vcc-supply = <&reg_vcc5v0>;
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 6046f4555852..5afca0586c41 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -261,6 +261,8 @@ patternProperties:
>      description: Dragino Technology Co., Limited
>    "^dserve,.*":
>      description: dServe Technology B.V.
> +  "^dynament,.*":
> +    description: Dynament, Ltd.
>    "^ea,.*":
>      description: Embedded Artists AB
>    "^ebs-systart,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ae228ac7adc9..4842a0afe32b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5796,6 +5796,7 @@ DYNAMENT PREMIER SERIES SINGLE GAS SENSOR DRIVER
>  M:	YuDong Zhang <mtwget@gmail.com>
>  S:	Maintained
>  F:	drivers/iio/chemical/premier.c
> +F:	Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
>  
>  DYNAMIC DEBUG
>  M:	Jason Baron <jbaron@akamai.com>
> -- 
> 2.24.1
> 
