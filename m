Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE904E1D43
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 18:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245730AbiCTR5t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 13:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiCTR5r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 13:57:47 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217A2DD49;
        Sun, 20 Mar 2022 10:56:23 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id h196so10294978qke.12;
        Sun, 20 Mar 2022 10:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PlrhYK0n+/1TEhP4CYqWfa5XsyR6AYoCKIhvlTep8IQ=;
        b=ksFyphtZDSkqH/lXaCKJLcBRkQ1BPyXesyaAmdP+VKuj5K9QTirXRuTtfUAJ1k7P3p
         leMyfpFw6zjIPAKAfM9trGVNuko2hSeUGqmt2WL8kGUwbMbsd4rhXKzk3Hl7rQi249Us
         Xqa/T7P0D5+Iftfb9hbw+s3i2ABLEiZ41DdinZ7V4XTiX9+uPoYPJr+Vdpv21eyVeJHe
         AdNd79MoO5MVi4etuMKubiXvEXs20eJJZbZJLwN0SsfX2NWOWRMIw7qszqwT1rDjCFg+
         Vw9C6YIY8Sm7oJfbTB+tDUWMlDQoG/YuXG1ZfuLNxe5IHwBIHyEGezvS1gGOQ3IcgHIJ
         xr1A==
X-Gm-Message-State: AOAM533f5QwGqJudFaxCZ4//47sK2X4SPPdfXhcSoT4UrGLrNJcXbxoI
        omClho7JUKV4+5pdYUg9gw==
X-Google-Smtp-Source: ABdhPJyMOSzhfb9Z4S+S6qTagxZd8GY8RYrfC2Te8jUzL4fQFSf1VvWKOCDovc/DZr81o+V2aSMYcA==
X-Received: by 2002:ae9:f444:0:b0:67e:7985:8331 with SMTP id z4-20020ae9f444000000b0067e79858331mr3309202qkl.465.1647798982352;
        Sun, 20 Mar 2022 10:56:22 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c6d:21ec:c4f5:bb3:5269:3b0e])
        by smtp.gmail.com with ESMTPSA id k1-20020ac85fc1000000b002e1c6420790sm10279552qta.40.2022.03.20.10.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 10:56:21 -0700 (PDT)
Received: (nullmailer pid 3117956 invoked by uid 1000);
        Sun, 20 Mar 2022 17:56:18 -0000
Date:   Sun, 20 Mar 2022 13:56:18 -0400
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     michael.srba@seznam.cz, Lars-Peter Clausen <lars@metafoo.de>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Message-ID: <Yjdqwlp4NFpuj4vT@robh.at.kernel.org>
References: <20220311161600.1469-1-michael.srba@seznam.cz>
 <20220311161600.1469-2-michael.srba@seznam.cz>
 <20220320151525.34db502c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320151525.34db502c@jic23-huawei>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 20, 2022 at 03:15:25PM +0000, Jonathan Cameron wrote:
> On Fri, 11 Mar 2022 17:15:59 +0100
> michael.srba@seznam.cz wrote:
> 
> > From: Michael Srba <Michael.Srba@seznam.cz>
> > 
> > ICM-20608-D differs from the other ICM-20608 variants by having
> > a DMP (Digital Motion Processor) core tacked on.
> > Despite having a different WHOAMI register, this variant is
> > completely interchangeable with the other ICM-20608 variants
> > by simply pretending the DMP core doesn't exist.
> > 
> > Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> > ---
> > changelog:
> >  - v2: require specifying "invensense,icm20608" as a fallback compatible
> 
> Apologies that I joined the thread for v1 late, but no. That doesn't work.
> If the older driver before the new ID is present with this binding
> it won't probe because of the WHOAMI value difference so it's not
> compatible.
> 
> I'm fine with the v1 version.

If the driver didn't check WHOAMI then it would be compatible. So does 
driver implementation determine what's compatible or not? It shouldn't 
as those are supposed to be decoupled.

Generally, if there are h/w id registers, then we'll rely on them and 
don't need a compatible for every variant.

Rob
