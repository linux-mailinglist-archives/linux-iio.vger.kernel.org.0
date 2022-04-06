Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5974F6A0F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 21:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiDFTih (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 15:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiDFTg6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 15:36:58 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8E32E3116;
        Wed,  6 Apr 2022 11:00:03 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e2442907a1so3396461fac.8;
        Wed, 06 Apr 2022 11:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vKxX5q1qGmU3P3uhPEFcWpItrjUZwEJRK1JP6o3PXj8=;
        b=2RU4/hB8117g+ctP9AxScr+DdX1hBgjU0bkPfncj13PLXjCwGI9k10FSGjc+3bN//u
         A658YA/YpQNrfJsLzUYfOsyJPOzXtK70mFsfDWRRWlmH6WLPrgUAdbkTWHwoqQOWshog
         Pgmfam6wHa1qZ6OUJo867zEuygvqbNxB3rPltk536JiynxuTeVlP1u+2Fqg3THmLjVxm
         7ScR407e/KuHR8iYw6LAVnQe+mQUGTpgzKcpMdU+0Ck/VDqm+ZoZKV8Hn5iwwDrKpUbV
         7gpwhApzGCgKlkO6JNiedNBOBOSN1OMVgWQvpoEnfnZpwWiBiLPU5lol1SATlQO4/kuF
         vSzg==
X-Gm-Message-State: AOAM530jCFaMsJmTu3rhb5hkBd+71JIUnUNbfecog57KFIcKidL2sgi6
        8p+jLJ++oGWbA5RsjvqQxkSGT2pD4Q==
X-Google-Smtp-Source: ABdhPJzbGb0jEgLE6cPbcrflcGousST6q9L6Y5xIwWyPzhUiOZaOLI50QFHynOdWi2ZbaUhkOKpegQ==
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id v29-20020a056870311d00b000de9b6c362bmr4268335oaa.200.1649268002731;
        Wed, 06 Apr 2022 11:00:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m13-20020a056820050d00b003297b35bc63sm2794457ooj.40.2022.04.06.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:00:02 -0700 (PDT)
Received: (nullmailer pid 2502470 invoked by uid 1000);
        Wed, 06 Apr 2022 18:00:01 -0000
Date:   Wed, 6 Apr 2022 13:00:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: change ad3552r maintainer
Message-ID: <Yk3VIR764LGZvXkB@robh.at.kernel.org>
References: <20220404085000.249423-1-nuno.sa@analog.com>
 <20220404085000.249423-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220404085000.249423-2-nuno.sa@analog.com>
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

On Mon, 04 Apr 2022 10:49:59 +0200, Nuno Sá wrote:
> As the maintainer email no longer exists, change it to myself.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
