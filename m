Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09A21E8457
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2RJq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 13:09:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44183 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2RJp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2020 13:09:45 -0400
Received: by mail-io1-f67.google.com with SMTP id p20so75013iop.11;
        Fri, 29 May 2020 10:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a2QGu421ez2t5PQEVQq+/SgHTvBOn/gTqn0sjVtJtGE=;
        b=H+3zMuTRKHIoJzuRQktf8R+Lxt8l67mPX8SLIhYevqQJ0M/DjUz+NY7/IY5xykM22I
         EZtX8igemBMF92CrYd+UoASya0QYlrPxIgN46fhnq8gVIJAdqkiMKiVPRr1lb2pxo8J5
         J6gcWtrxtvG3FxOnv7gB+7EHCPz5WfUQQ/KHjNiuGTfpFk56yB5AkOCNNvtET0jXjOTn
         VHYsFxoS15ycZCxpFqjH9hKlMM4glMVXSSVoJVz+RQFbLzADqu3JPg8LLIfiG5hJSHn+
         tlv2I4kHx/eHRbWXIbCtQCu56ShwSrjTm3UicBBl+vtAaJUSxOHSct7YTr7V0jNBJjD1
         VCXQ==
X-Gm-Message-State: AOAM532U/pJA+AHUMQ3q94W74YKwleNJ6lAtTcB9Iq+rJPFC2TbViS83
        bFiaKaHdiCZ3FcFhzNPShA==
X-Google-Smtp-Source: ABdhPJwZQWo0WulZlgDVmME3mzUnoX5pm5ZHXXSnckD9PxPpBYBHxltswNiWrwj4WRIeDI0rwBeAOw==
X-Received: by 2002:a05:6638:406:: with SMTP id q6mr8134452jap.125.1590772184764;
        Fri, 29 May 2020 10:09:44 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c1sm4963408ilq.56.2020.05.29.10.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:09:44 -0700 (PDT)
Received: (nullmailer pid 2580445 invoked by uid 1000);
        Fri, 29 May 2020 17:09:43 -0000
Date:   Fri, 29 May 2020 11:09:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@gmail.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: iio: imu: bmi160: add regulators and
 mount-matrix
Message-ID: <20200529170943.GA2578764@bogus>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
 <20200525164615.14962-3-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525164615.14962-3-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 25, 2020 at 06:46:01PM +0200, Jonathan Albrieux wrote:
> Add vdd-supply and vddio-supply support.
> Add mount-matrix support.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../bindings/iio/imu/bosch,bmi160.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> index 0d0ef84e22b9..cfe40dbcd723 100644
> --- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> @@ -37,6 +37,17 @@ properties:
>        set if the specified interrupt pin should be configured as
>        open drain. If not set, defaults to push-pull.
>  
> +  vdd-supply:
> +    maxItems: 1

Supplies are always a single item, so don't need this.

> +    description: provide VDD power to the sensor.
> +
> +  vddio-supply:
> +    maxItems: 1
> +    description: provide VDD IO power to the sensor.
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix
> +
>  required:
>    - compatible
>    - reg
> @@ -52,9 +63,14 @@ examples:
>          bmi160@68 {
>                  compatible = "bosch,bmi160";
>                  reg = <0x68>;
> +                vdd-supply = <&pm8916_l17>;
> +                vddio-supply = <&pm8916_l6>;
>                  interrupt-parent = <&gpio4>;
>                  interrupts = <12 IRQ_TYPE_EDGE_RISING>;
>                  interrupt-names = "INT1";
> +                mount-matrix = "0", "1", "0",
> +                               "-1", "0", "0",
> +                               "0", "0", "1";
>          };
>      };
>    - |
> -- 
> 2.17.1
> 
