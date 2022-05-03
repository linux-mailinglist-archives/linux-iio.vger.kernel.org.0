Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF38C518BBD
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 20:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiECSGK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 14:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiECSGI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 14:06:08 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8C63EA86;
        Tue,  3 May 2022 11:02:35 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e5e433d66dso17928197fac.5;
        Tue, 03 May 2022 11:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cct/6pnUlrhua5SxSwNoFRQefwScwzXaapCEbdg2swU=;
        b=2ThYbD/qmlhru4OvhmQV5RWtJ1RewFJnYh5l9OSZnbv/BjH0+TqwpW+1WV02GeyBTE
         g121fil/uW04ZM8ptWitLk/p5n+JxRtE6EVC5Zt8t5yTGvb6UnrPoqUR5AyT8vLn1t49
         jsoDJrZg5tL62NC31n8EVcfKMl9cSPMOvTRLIwYr/AqBE4/KRnI1RkRaZaIIRZOSB2Tq
         1n+lak+5LLKTeWpO0SxBEm7FGFQJF74JTZRgSVdWUH0mCOclc5pI3hM2CnWJCsEhjqfE
         QMuPh5aJHb24/T2/jX1DFANLYZACWG4z5pYQJTD4rNpNK18FIEi54F440+hNfSfrIAE+
         2Z7w==
X-Gm-Message-State: AOAM531ABnvgnqV+OpDUE01AAL3vjV132Zkw7b3hOYh0nQWM6u1A3a3z
        oiWfv5F1hrxJbFTR8ibHqg==
X-Google-Smtp-Source: ABdhPJzN2wV8RH4wF6jzkah5fvvSgR+54NVTC8qWmqTA9Nnoa6cUK6/PyQSVt9jwtOhabXVuMSxSeg==
X-Received: by 2002:a05:6870:b427:b0:d3:5044:db1b with SMTP id x39-20020a056870b42700b000d35044db1bmr2216783oap.2.1651600955234;
        Tue, 03 May 2022 11:02:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y1-20020a4ae701000000b0035eb4e5a6d1sm5170695oou.39.2022.05.03.11.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:02:34 -0700 (PDT)
Received: (nullmailer pid 3966061 invoked by uid 1000);
        Tue, 03 May 2022 18:02:34 -0000
Date:   Tue, 3 May 2022 13:02:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, swboyd@chromium.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v5 07/10] dt-bindings: iio: sx9324: Add input analog gain
Message-ID: <YnFuOmFFB/cgWUiQ@robh.at.kernel.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
 <20220429220144.1476049-8-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429220144.1476049-8-gwendal@chromium.org>
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

On Fri, 29 Apr 2022 15:01:41 -0700, Gwendal Grignou wrote:
> Allow setting the configure the input analog gain.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> New in v5.
> 
>  .../bindings/iio/proximity/semtech,sx9324.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
