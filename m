Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1784616715
	for <lists+linux-iio@lfdr.de>; Wed,  2 Nov 2022 17:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKBQHf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Nov 2022 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiKBQHd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Nov 2022 12:07:33 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25EB2C665;
        Wed,  2 Nov 2022 09:07:32 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 16-20020a9d0490000000b0066938311495so10530167otm.4;
        Wed, 02 Nov 2022 09:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfA4vzhyX0ZUotNLpEXw+D/N+Kggn1F0m5/KTjbV0bA=;
        b=q4ShH0zcN7M2leR+WkNiL8qJwqoctmddeP39tfwSL4IF3jTix1WbzXUyne3KitDZ37
         xBK5+IatxKOQNN2PE+EuYk7bxXYaBOPJdq5f/xnwiYcs9/6wQRHugb5CL/+zHaIT9zg2
         GgqmaB+XTCkK3bvXElCCzpwwzOmingBsZnFe/x3n3bTDz4I3VYvatGmk4aPynj6M4sL+
         3WKGYeh8Abq1DylEsTZhhFiNFG8uDrOvAs3v6alBtlS7wfHo+1lbBZeuY3htwHGBYTkU
         FGA7unwlDwrtbhppE4kExhb2w/6rguvk8GMYlHMkoIHThOvo5v4e2OwhbjmxzGHZKi/M
         oCeg==
X-Gm-Message-State: ACrzQf1KZgBZS2fCEXNqQMFjOc2sZp5r9zyoUy++hrau1FeRng4geCLi
        Ap/Kv5o4CVKmbDB2lCx4Mdy9GL3vZg==
X-Google-Smtp-Source: AMsMyM5YaR2HntVXbfWlYimv5yXk3DrCSz3gpppHoipUPq0dES93AEnq55+N3/LzH5I2hrh3kjjyPg==
X-Received: by 2002:a9d:7f84:0:b0:66c:53ef:e555 with SMTP id t4-20020a9d7f84000000b0066c53efe555mr8068704otp.34.1667405252148;
        Wed, 02 Nov 2022 09:07:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v21-20020acaac15000000b0035763a9a36csm4636219oie.44.2022.11.02.09.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:07:31 -0700 (PDT)
Received: (nullmailer pid 3979696 invoked by uid 1000);
        Wed, 02 Nov 2022 16:07:33 -0000
Date:   Wed, 2 Nov 2022 11:07:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        jic23@kernel.org, linux-iio@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv
 device bindings
Message-ID: <166740525307.3979649.17970099370405453857.robh@kernel.org>
References: <cover.1667216004.git.lorenzo@kernel.org>
 <c34cea4468dc26050dff812f47e1a21f8e544758.1667216004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c34cea4468dc26050dff812f47e1a21f8e544758.1667216004.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Mon, 31 Oct 2022 12:41:26 +0100, Lorenzo Bianconi wrote:
> Introduce device bindings for LSM6DSV IMU sensor.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
