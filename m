Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EDB4E55D8
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 17:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245349AbiCWQCK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 12:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCWQCK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 12:02:10 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD81B7B113;
        Wed, 23 Mar 2022 09:00:40 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso1382612otj.0;
        Wed, 23 Mar 2022 09:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ItgsvKknDgPPRT6QdI3gqczq0a2rgAWLLRXRr1H1X0I=;
        b=EN+581kvdWJdo0HTYoEqKqg0j4fi1iRJtDxmNg1dsVfDc2ELvkbbp+0O4YSbfSKssO
         u67MAL9piTFJmqdviQpKh2o+N5xsDLSVpiTjTUmdCRF5xuV002q1WAs1tCaft4K8oGmW
         yHlcciJmAhEEeA9UCrGrOSZBJi7wh4rdsbtzOoWg7MJ+yZaw97ghbjPwQE4XSWhBFri5
         U8+F6RU8GjcTokIOXfiiPskJxU+UmJF8Vs86i6XcTfs58KNDkKIA/ULPYSiek9aokfS6
         ZhEcaVPo5A9zwC+OpQMXBfzCCvRXZe10KPtXepFMbgwYmNCDlbJ6Zrpq/F6vZ+SOMFfU
         /PMg==
X-Gm-Message-State: AOAM531hMpmaKAFxnLdZiPvZT/qAlkQTmsXDvYZBnIvf7krReCpd5biw
        kmpLo7rxZwcZcI4SkFBdaA==
X-Google-Smtp-Source: ABdhPJwm8hy5dG6f7GV8HQtgTKu1aHPTQAXkVnJ9GS4vgt8Kk9tMCcQ7gxv1fc4VnI6Fpkf3vS8GPQ==
X-Received: by 2002:a9d:4798:0:b0:5b2:3791:beb7 with SMTP id b24-20020a9d4798000000b005b23791beb7mr230153otf.123.1648051240121;
        Wed, 23 Mar 2022 09:00:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t15-20020a056808158f00b002e331356c87sm91459oiw.39.2022.03.23.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:00:39 -0700 (PDT)
Received: (nullmailer pid 4184267 invoked by uid 1000);
        Wed, 23 Mar 2022 16:00:38 -0000
Date:   Wed, 23 Mar 2022 11:00:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     michael.srba@seznam.cz
Cc:     devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Message-ID: <YjtEJniv5LdFk7rY@robh.at.kernel.org>
References: <20220323121550.16096-1-michael.srba@seznam.cz>
 <20220323121550.16096-2-michael.srba@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323121550.16096-2-michael.srba@seznam.cz>
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

On Wed, 23 Mar 2022 13:15:49 +0100, michael.srba@seznam.cz wrote:
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
>  - v2: require specifying "invensense,icm20608" as a fallback
>        compatible
>  - v3: fix indentation
> ---
>  .../bindings/iio/imu/invensense,mpu6050.yaml  | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
