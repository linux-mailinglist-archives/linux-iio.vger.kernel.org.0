Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D295568B5E
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jul 2022 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiGFOht (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jul 2022 10:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiGFOhs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jul 2022 10:37:48 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B52F1836D;
        Wed,  6 Jul 2022 07:37:47 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id p13so9315924ilq.0;
        Wed, 06 Jul 2022 07:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qc8X/1LaMy2WznH4PBEmnzF+GVIKVnqPUAAQ7c6UFzY=;
        b=yemtQXHiV9p+ZML88zDYY9rnmka+jQJ06tN/bTgobDsJvuWYA05WaXO46V/0DiIarn
         0iJabHwiHMxMBL3OT5Tda8ECsHRKInZ+yuM/8JJ8bZBgxmuPYKsZRGm7VcGTJEqSjjLT
         5sgxaT3wZWk8ZYcXYPXHK4unGLwpgMOmBi+DSuEwWBbWS7EyXiv2SEpNRBkw2BzCs2PU
         c/r9wkhRkBF7GPRSai8UekoY2/DNRXLIqhAMDYWvYdZc4CGoIZOrAjTsUwr/idIC6jIo
         wj9UxIsKMDCeS6W1UM5kKk82X4vRZOE2PRt6EWBsijjzTNqNpm54Y9dbmmfCj3okvGXq
         NQqg==
X-Gm-Message-State: AJIora+MVTjZVz0ylq/GCu1CV7nvwiBg1EFdUCkwWe/DFOjtB8qjZGpG
        tQPsJsJgvb/g7+mUPckTGQ==
X-Google-Smtp-Source: AGRyM1vNXiruOQpnrCzruFXGrXb492DjvZelE7rIiAG8dXbAIlUC/fQZ/w+0wnCe1gztq0UT9xa11g==
X-Received: by 2002:a92:d409:0:b0:2dc:40d:169 with SMTP id q9-20020a92d409000000b002dc040d0169mr12580351ilm.135.1657118266757;
        Wed, 06 Jul 2022 07:37:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m29-20020a02a15d000000b00339ceeec5edsm15799374jah.12.2022.07.06.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:37:46 -0700 (PDT)
Received: (nullmailer pid 6765 invoked by uid 1000);
        Wed, 06 Jul 2022 14:37:44 -0000
Date:   Wed, 6 Jul 2022 08:37:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     maccraft123mc@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>,
        paul@crapouillou.net, contact@artur-rojek.eu, jic23@kernel.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: adc-joystick: add poll-interval
Message-ID: <20220706143744.GA6709-robh@kernel.org>
References: <20220705190354.69263-1-macromorgan@hotmail.com>
 <20220705190354.69263-2-macromorgan@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705190354.69263-2-macromorgan@hotmail.com>
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

On Tue, 05 Jul 2022 14:03:52 -0500, Chris Morgan wrote:
> From: Chris Morgan <macroalpha82@gmail.com>
> 
> Add poll-interval support for the adc-joystick documentation. This is
> an optional value and if not provided the adc-joystick works as it
> does today (with buffers). If this value is provided, the adc-joystick
> driver is polled at the specified interval. The existing attribute of
> "poll-interval" was used instead of complying with property-units.yaml
> after discussion of the issue on the mailing list.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  Documentation/devicetree/bindings/input/adc-joystick.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
