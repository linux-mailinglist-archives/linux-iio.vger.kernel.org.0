Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0B518BC0
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbiECSGq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 14:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbiECSGi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 14:06:38 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BBD3EA86;
        Tue,  3 May 2022 11:03:02 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-deb9295679so17955929fac.6;
        Tue, 03 May 2022 11:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c4y777QuZ0rKKaCWE+GQgAB76G2BUz6LnE4csQPAmbo=;
        b=F4+VsA+4ZzQ6pml+OE2AJPrcFEDlGGgjV9G7ITAi51zohR/ygcVmNAY0hqxMICff7L
         LrdzUFL1NsdnWLLjydhVhGRpISgfG1TAz3FJ7Y+ob4+Q8OoRid1OGp7QEBM+ELDPEC2z
         gXJlh46Sz7UZ++0LHoqtD8Gi3fIYO0XZG6N9Ma6Co8TwHwzBSak5Kn5FXRY58P8o4V9Y
         pQhlyUH1+F3y9vxQCB4Ph1ellTvxZKf9vzWMMvYKJP+ElyyWbIfWjVcEeawl9PGiMnNB
         F7Q4VdKwqIdmhGprGaQLdtTeItodD1DbPpFexH90f9OLoTeY7f+DkGPGlQnA9LstgmUb
         wBqA==
X-Gm-Message-State: AOAM531jBQ630WUE1KF52AItEYNpAjt3Dbcn2nWPTmr0iOFNBDTGsME3
        TLEvFgQ1/+ZIfvt1f3LqOA==
X-Google-Smtp-Source: ABdhPJwkS+JKL3alM12RMwuyuhcf9h5jeTVKKREM/bjV2+Wk/fKjUl3bbLaTwQhMPoy7s0/gSSqlkg==
X-Received: by 2002:a05:6870:5708:b0:e2:8a41:2261 with SMTP id k8-20020a056870570800b000e28a412261mr2301964oap.247.1651600982258;
        Tue, 03 May 2022 11:03:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n2-20020a4ae742000000b0035eb4e5a6b2sm5187127oov.8.2022.05.03.11.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:03:01 -0700 (PDT)
Received: (nullmailer pid 3966876 invoked by uid 1000);
        Tue, 03 May 2022 18:03:01 -0000
Date:   Tue, 3 May 2022 13:03:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     swboyd@chromium.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v5 09/10] dt-bindings: iio: sx9360: Add precharge
 resistor setting
Message-ID: <YnFuVfurEsrYxFdE@robh.at.kernel.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
 <20220429220144.1476049-10-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429220144.1476049-10-gwendal@chromium.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Apr 2022 15:01:43 -0700, Gwendal Grignou wrote:
> Allow configure the resistance used during precharge.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes since v4:
> - Add multipleOf propery
> - Move description at the end, to match convension.
> 
> Changes since v3:
> - Fix maximum field. Check make dt_binding_check passes.
> 
> Changes since v2:
> - Change kOhms into ohms.
> 
> Changes since v1:
> - Suffix property with kOhms.
> 
>  .../bindings/iio/proximity/semtech,sx9360.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
