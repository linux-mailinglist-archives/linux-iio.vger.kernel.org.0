Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C784E1C2B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 16:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245324AbiCTPJ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 11:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245329AbiCTPJ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 11:09:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A3613FAE;
        Sun, 20 Mar 2022 08:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41266B80E73;
        Sun, 20 Mar 2022 15:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9904C340E9;
        Sun, 20 Mar 2022 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647788880;
        bh=q/k6omWUC4vFENIVP+s1xcuF82EKnFzFSW43LrnV6jA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oPpzN8CLCoCjpHoDSJ8h9NHirYDCICT/2i7+sluwMyy3Y7BG+lC/63o9ZUdyEp5L5
         OUC+HkUevCEmwiVcP5VAXIHK1eFiBLvsq0s01fOdwPg5b1KaH+9Q5dN1hn7EuLw4V9
         lmhUEuU1oSFUwv+2hdVbAVnREeK946PXCxQsEsNaAiBUNaXgfeuT1UoMdKs9yHewNL
         syQpuj3qtNDByrl8tLO0ZNvZRy7iDCNwySatkLL5jaRObqk+lm3ENxEhAsOoQi89R7
         o6Mp/oPvwo21Hf53gb4LY3oFSH6QW7riQyjd6rdc9fz7Mx2wZNNEZe5BDyivjb0S3G
         +lA0bbnP+77CA==
Date:   Sun, 20 Mar 2022 15:15:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     michael.srba@seznam.cz
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Message-ID: <20220320151525.34db502c@jic23-huawei>
In-Reply-To: <20220311161600.1469-2-michael.srba@seznam.cz>
References: <20220311161600.1469-1-michael.srba@seznam.cz>
        <20220311161600.1469-2-michael.srba@seznam.cz>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Mar 2022 17:15:59 +0100
michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> ICM-20608-D differs from the other ICM-20608 variants by having
> a DMP (Digital Motion Processor) core tacked on.
> Despite having a different WHOAMI register, this variant is
> completely interchangeable with the other ICM-20608 variants
> by simply pretending the DMP core doesn't exist.
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
> changelog:
>  - v2: require specifying "invensense,icm20608" as a fallback compatible

Apologies that I joined the thread for v1 late, but no. That doesn't work.
If the older driver before the new ID is present with this binding
it won't probe because of the WHOAMI value difference so it's not
compatible.

I'm fine with the v1 version.

> ---
>  .../bindings/iio/imu/invensense,mpu6050.yaml  | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> index d69595a524c1..dbd214e7baba 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> @@ -14,21 +14,25 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - invensense,iam20680
> -      - invensense,icm20608
> -      - invensense,icm20609
> -      - invensense,icm20689
> -      - invensense,icm20602
> -      - invensense,icm20690
> -      - invensense,mpu6000
> -      - invensense,mpu6050
> -      - invensense,mpu6500
> -      - invensense,mpu6515
> -      - invensense,mpu6880
> -      - invensense,mpu9150
> -      - invensense,mpu9250
> -      - invensense,mpu9255
> +    oneOf:
> +      - enum:
> +        - invensense,iam20680
> +        - invensense,icm20608
> +        - invensense,icm20609
> +        - invensense,icm20689
> +        - invensense,icm20602
> +        - invensense,icm20690
> +        - invensense,mpu6000
> +        - invensense,mpu6050
> +        - invensense,mpu6500
> +        - invensense,mpu6515
> +        - invensense,mpu6880
> +        - invensense,mpu9150
> +        - invensense,mpu9250
> +        - invensense,mpu9255
> +      - items:
> +        - const: invensense,icm20608d
> +        - const: invensense,icm20608
>  
>    reg:
>      maxItems: 1

