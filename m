Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71922A1F08
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgKAP0a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgKAP0a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2020 10:26:30 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE422C0617A6
        for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2020 07:26:28 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t22so5512665plr.9
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2020 07:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vKigyyy69RrMO2wivE7nOb9ykQ6TIQpd+G42MBJUIn8=;
        b=bmy5XVeGN9uxrIuvcEDzy4ODGtU/npvWAz3Di8wXje7L8s+RkPgEt7FLctGjHyJ/ca
         /f57AnwK47m24PE3lLnBR0qzdRkEBhMssb4YgAPByPKreiBMrTwuyGbGvNEqjMdsvdIc
         oEMxycFPRvzR8ADLHm3NOTQWbGZNW6BvzFVR4CLhcuRoMSFkoe7GugD+1bK9CmDrBSkg
         hNjtMr7GEjXEjK1ueNq2QfU4qoQwsnZP4qDfrNf0SRty2CEQACoAon5eLgMNCQa0+U6R
         VOJA/KsanPbt9iQP+2qf33WnNBKw46Pj8SESJd8C4j4nA4S+ZNlsEqPlxOKSy3pqZzMI
         d2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vKigyyy69RrMO2wivE7nOb9ykQ6TIQpd+G42MBJUIn8=;
        b=j1Qo6OhXDp4y4qMFu9VpcKBIpGWuAwYPAP69tA9hDEoQsJte9BqBLiE9Hy6+N537Qd
         4B1+y6q384Z41wwhaLHf9i+yVFeonwKmS0VzUojKC92mzG/IeRaqWUmAQVnzuT5ZvUUC
         WC4R7fDZ0WkUWtSwT4x4vRPH6LKlaLU/XxPLOn1XuQVKLkajYjB+Elg+RYPkRPbSTr1D
         GOcEmrZ7eydbyTQhhNSLcilPPgdU37/pRWTVzSNvVluJDFSm7UIBaY14n9Ord0WL79dJ
         sLyc+tZMRSezOvZjL3S1tgDxt5dYeW5TRzw2rt0B31/ws4QXzpYzCnVWw4WvmO/8I6MY
         hO8g==
X-Gm-Message-State: AOAM532ECiWbs6VKD8+UUs/Wou5VDNhW/VhQ6Kh8xI/++9CDwPXuyzJ+
        B6iqdwjRD89VeBQjurHteMIr
X-Google-Smtp-Source: ABdhPJwGNneB5X/GX07OnmKf6zv3cmd3EbewFrLINom47KVIkTLnce6GvYo5gLMlnHhJ/BJ4vEekfg==
X-Received: by 2002:a17:90a:65cc:: with SMTP id i12mr13031446pjs.193.1604244388341;
        Sun, 01 Nov 2020 07:26:28 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6d8d:be1b:b0c0:14ff:1364:f14c])
        by smtp.gmail.com with ESMTPSA id q8sm10867819pfg.118.2020.11.01.07.26.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Nov 2020 07:26:27 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <manivannanece23@gmail.com>
Date:   Sun, 1 Nov 2020 20:56:21 +0530
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 22/46] dt-bindings:iio:light:st,vl6180: txt to yaml
 format conversion.
Message-ID: <20201101152621.GB5384@Mani-XPS-13-9360>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-23-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031184854.745828-23-jic23@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:48:30PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I'm not sure anyone would use this part primarily as an ALS,
> given the time of flight laser also present, but I'll stick with the
> original decision on where to put the binding.
> 
> Added interrupts property as the device has a GPIO interrupt even
> if the driver is not currently using it.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Manivannan Sadhasivam <manivannanece23@gmail.com>

Thanks,
Mani

> Cc: Manivannan Sadhasivam <manivannanece23@gmail.com>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> ---
>  .../bindings/iio/light/st,vl6180.yaml         | 45 +++++++++++++++++++
>  .../devicetree/bindings/iio/light/vl6180.txt  | 15 -------
>  2 files changed, 45 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml b/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
> new file mode 100644
> index 000000000000..27c36ab7990d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/st,vl6180.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/st,vl6180.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicro VL6180 ALS, range and proximity sensor
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannanece23@gmail.com>
> +  - Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> +
> +description: |
> +  Proximity sensing module incorporating time of flight sensor
> +  Datasheet at https://www.st.com/resource/en/datasheet/vl6180x.pdf
> +
> +properties:
> +  compatible:
> +    const: st,vl6180
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        proximity@29 {
> +            compatible = "st,vl6180";
> +            reg = <0x29>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/light/vl6180.txt b/Documentation/devicetree/bindings/iio/light/vl6180.txt
> deleted file mode 100644
> index fb9137d85df9..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/vl6180.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -STMicro VL6180 -  ALS, range and proximity sensor
> -
> -Link to datasheet: https://www.st.com/resource/en/datasheet/vl6180x.pdf
> -
> -Required properties:
> -
> -	-compatible: should be "st,vl6180"
> -	-reg: the I2C address of the sensor
> -
> -Example:
> -
> -vl6180@29 {
> -	compatible = "st,vl6180";
> -	reg = <0x29>;
> -};
> -- 
> 2.28.0
> 
