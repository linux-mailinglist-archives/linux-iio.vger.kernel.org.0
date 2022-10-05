Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69765F556A
	for <lists+linux-iio@lfdr.de>; Wed,  5 Oct 2022 15:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJENbO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Oct 2022 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJENbN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2022 09:31:13 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAD04C618;
        Wed,  5 Oct 2022 06:31:13 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id t79so4149474oie.0;
        Wed, 05 Oct 2022 06:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTIPhig5Ie9VOFbWKLP3zaUvCPlldSA2E1ZwzIC2iDs=;
        b=dow3Q3rKh9KgQCencfU9t3Qom22vq5iC7WpfCx7n1M+YLbBndnHvqpF7NG9CtEwP7D
         2zvgWSMhxCmBKITsOPKsOa/q+is3aR/Ixb/oLuDi1Koob7Aochag4X+u2SVKlcB8XWZB
         7BVW2nUcfImR8A6za45tigRDSfZcZMj32l0e7D8POA+jd75AsyxulOCb2kt4Y47fWR8y
         FKFVbnx2ay5/Uko0aOxtK1zf9sUBj+vQmASaeudFmM+XDI51yzI2vpNnFSNvDLGbRFW6
         X1zcZFe096RNa5glVa584AJKZE4xGVhH0lDfCBWxF6ucL3d39hpKItEPIXSryVucp50S
         AqSg==
X-Gm-Message-State: ACrzQf1xsQ3pcEe2BpGIDnGnyl0iaExxNYkv3KI9Bm87zRqhAsop/ToH
        3+aWUVa/q3/EwPDASQKImg==
X-Google-Smtp-Source: AMsMyM6pDwVIeNVC63QqA3QzzkzNt2WqrugHJWzzqR20g/mEypP09v77am14UdFCsnLL5btLL+Bf/Q==
X-Received: by 2002:a05:6808:1446:b0:350:9b8b:2398 with SMTP id x6-20020a056808144600b003509b8b2398mr2202320oiv.15.1664976672555;
        Wed, 05 Oct 2022 06:31:12 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id c36-20020a05683034a400b00660db0c0cc8sm816017otu.75.2022.10.05.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:31:12 -0700 (PDT)
Received: (nullmailer pid 3276086 invoked by uid 1000);
        Wed, 05 Oct 2022 13:31:11 -0000
Date:   Wed, 5 Oct 2022 08:31:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: frequency: change admv4420
 maintainer
Message-ID: <166497666336.3275912.15393357731871877356.robh@kernel.org>
References: <20221005085044.204701-1-nuno.sa@analog.com>
 <20221005085044.204701-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221005085044.204701-2-nuno.sa@analog.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 05 Oct 2022 10:50:44 +0200, Nuno Sá wrote:
> As the maintainer email no longer exists, change it to myself.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/iio/frequency/adi,admv4420.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
