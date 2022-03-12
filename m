Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70724D6C48
	for <lists+linux-iio@lfdr.de>; Sat, 12 Mar 2022 04:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiCLDmd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Mar 2022 22:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiCLDmc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2022 22:42:32 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE3322501C;
        Fri, 11 Mar 2022 19:41:27 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso7692654otj.0;
        Fri, 11 Mar 2022 19:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Xv3rlApdfE6GpdB21993qe2umhTQgjPykPpzL3SYX2Q=;
        b=mO5gBAxsCNfppvTLEpZpb/cELNOisHrHj4lbzos72+okGHxo1wXAaXgeSk553S4/3p
         YET85Qc/3uw2vr2nwV/Hds9bwdZjcMKKCQ06XQYv5NR4vg60h8dh+IhJZpabAI7+XW1G
         dArX6dDOYPw3X1RFusTv3RnvEuNvHkrzHvBQl589jEgx/fXWaPksmeqdtZFurDYIGadZ
         eUFo+ETPk60shaykap3kliMttSH7ID8X+x7uE49ZLh6cJ71Lqs8uilDTY4UzCJR8eyTw
         z0mSZlFGqjDBJpOsXzVD9EKz6+G1u5DI0zLZOzMHKuWTbSokMgra3pAbRiYUwUGnh6wR
         vsfA==
X-Gm-Message-State: AOAM530UFpnPJSL8DC4ILg8kVE4HWAN5s7QiAKrNnA/5MUh6T4x1KgSS
        Sa6hBWW6pbUORXpYS7N55Xo6nC/gNg==
X-Google-Smtp-Source: ABdhPJwYvVEBZMzt0Tf0iFJzN4YOWQ9jIaWkcBaYzN/8vU6ZlTeYNV6x1sBY3tFdspMBQyhv+MzSRw==
X-Received: by 2002:a05:6830:35b:b0:5b2:5f31:3e5d with SMTP id h27-20020a056830035b00b005b25f313e5dmr6655186ote.312.1647056487064;
        Fri, 11 Mar 2022 19:41:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x14-20020a05680801ce00b002d97bda386fsm4497292oic.52.2022.03.11.19.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:41:26 -0800 (PST)
Received: (nullmailer pid 724634 invoked by uid 1000);
        Sat, 12 Mar 2022 03:41:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     michael.srba@seznam.cz
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Srba <Michael.Srba@seznam.cz>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220311161600.1469-2-michael.srba@seznam.cz>
References: <20220311161600.1469-1-michael.srba@seznam.cz> <20220311161600.1469-2-michael.srba@seznam.cz>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Document invensense,icm20608d
Date:   Fri, 11 Mar 2022 21:41:25 -0600
Message-Id: <1647056485.106523.724633.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Mar 2022 17:15:59 +0100, michael.srba@seznam.cz wrote:
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
> ---
>  .../bindings/iio/imu/invensense,mpu6050.yaml  | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml:34:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1604436

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

