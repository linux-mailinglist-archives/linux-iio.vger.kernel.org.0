Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000A81B1814
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 23:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDTVLO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 17:11:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33586 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgDTVLN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 17:11:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id j26so9453602ots.0;
        Mon, 20 Apr 2020 14:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rrQbEYWwzszNqdguJ2RsCui3P5b9+iPM7VYp9zcM3Ro=;
        b=HbVsvjmQYr619gz9TP0NL6EjK9+cab/080a+vAvYrAbdvHwIb43MMC+z13JqDaoSfu
         MvKr40TGo5gCb7VGZeBC0neD0r7AGp1gvkFyu1IMtjDgMfVO+C5tvSqJQHQXxpXYQ51p
         67MFAlFUpgdtmV5vNccURrIGQlQgcOiq/w2LqiyJBSIRqVkSpty8j67nM4ysJE50Kkml
         yFrrsvP3H+2YuEjVHCy0ad/afjOLY0oMZf964Nvl8gNAZ2lmBPymoZ0z8bOpD6T9rm0I
         bLMwI5gOTe+eberl6ey2E4DuemPOXymuyDKU+AU7cYB0x748HxWj6G6or0YQTILs4VDu
         JgKw==
X-Gm-Message-State: AGi0PuYI/zgCovtgZTH9wkXuw4BASg6fN7CkbroF65kxA7Ak9fOA5fie
        9O9tpc5JotuFcIFiDc/2TCC75zk=
X-Google-Smtp-Source: APiQypK7kvsoeDEAlVJFLzruH3SBuCc/ldyxdkjmBQzCeJggPL8JjNC8Q4RYtINDgl9EHYVK3puc/Q==
X-Received: by 2002:a9d:7282:: with SMTP id t2mr10743537otj.302.1587417072722;
        Mon, 20 Apr 2020 14:11:12 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a8sm206373otq.58.2020.04.20.14.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:11:12 -0700 (PDT)
Received: (nullmailer pid 5880 invoked by uid 1000);
        Mon, 20 Apr 2020 21:11:11 -0000
Date:   Mon, 20 Apr 2020 16:11:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     mani@kernel.org
Cc:     jic23@kernel.org, narcisaanamaria12@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [RESEND PATCH v3 1/3] dt-bindings: iio: chemical: Add binding
 for CCS811 VOC sensor
Message-ID: <20200420211111.GA754@bogus>
References: <20200414184930.5576-1-mani@kernel.org>
 <20200414184930.5576-2-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414184930.5576-2-mani@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 15, 2020 at 12:19:28AM +0530, mani@kernel.org wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> This commit adds devicetree binding for AMS CCS811 VOC sensor.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  .../bindings/iio/chemical/ams,ccs811.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> new file mode 100644
> index 000000000000..5cb068666a3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/ams,ccs811.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS CCS811 VOC Sensor
> +
> +maintainers:
> +  - Narcisa Vasile <narcisaanamaria12@gmail.com>
> +
> +description: |
> +  Ultra-Low Power Digital Gas Sensor for Monitoring Indoor Air Quality.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ams,ccs811
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO connected to the nRESET line. This is an active low
> +                 input to CCS811.
> +    maxItems: 1
> +
> +  wakeup-gpios:
> +    description: GPIO connected to the nWAKE line. This is an active low
> +                 input to CCS811.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Add:

additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
