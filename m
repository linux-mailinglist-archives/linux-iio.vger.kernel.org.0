Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C935F5568
	for <lists+linux-iio@lfdr.de>; Wed,  5 Oct 2022 15:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJENa7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Oct 2022 09:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJENa6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2022 09:30:58 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BBA1DA49;
        Wed,  5 Oct 2022 06:30:58 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13207a86076so15625607fac.3;
        Wed, 05 Oct 2022 06:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34udKxk5udhg6cu0beQbV4sqmx9aK1A2AfjZO7sGd5U=;
        b=fR6tmcXFA28DYxj7PPX4dcIBxkVLOZsvdHCNlvYO/NbbSaPOkMgGOZTLzoOPi3UOhr
         6MWS6gyJ9+e/hiPdzsLQArcOmNx5yIM1uDo/43+8wmypraEWGAweqVNglSxEBmnr8Dwm
         TcMGouiX21Ryb9PJ9YhbHaLQEx9/v9/DQfNRoAGR3/Lem3eGHWXN1oc4bEUQhO4bm6aq
         TaCDrf/3KKB6FAaXhq6tj8IQiDkJX0/7/R756tjUs8g0Er2AJFPEK4yxSf3sOQ98M53o
         jyNBc9g1YJOBqBW4GS1+QQNNCsz80sVqhPYcEgmRtcA7weFrZiMHP6bMX+KTRMTJDQjm
         oJnA==
X-Gm-Message-State: ACrzQf1jq+oJtJodE8eyo+n8sF//JNEACAdTrrav6aZfg4FZ2UWJqK6O
        Q3ltACwandd9TAPNu+J1Mw==
X-Google-Smtp-Source: AMsMyM4s20ITbrKqXuYwSnt0zCV7zhn2XSpE7Ku/27PhiNlL8T5di+jOcpm+UMnW58r7Ylt/1YYA9A==
X-Received: by 2002:a05:6870:b396:b0:12c:2ba9:8e2d with SMTP id w22-20020a056870b39600b0012c2ba98e2dmr2737248oap.159.1664976657639;
        Wed, 05 Oct 2022 06:30:57 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id q65-20020acac044000000b00342fc99c5cbsm4268491oif.54.2022.10.05.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:30:57 -0700 (PDT)
Received: (nullmailer pid 3275709 invoked by uid 1000);
        Wed, 05 Oct 2022 13:30:56 -0000
Date:   Wed, 5 Oct 2022 08:30:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: change ad5766 maintainer
Message-ID: <166497665565.3275646.2703728693957259548.robh@kernel.org>
References: <20221005085044.204701-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221005085044.204701-1-nuno.sa@analog.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 05 Oct 2022 10:50:43 +0200, Nuno Sá wrote:
> As the maintainer email no longer exists, change it to myself.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
