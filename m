Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE957DC0A
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jul 2022 10:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiGVIOl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jul 2022 04:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiGVIOk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jul 2022 04:14:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A060D9CE04
        for <linux-iio@vger.kernel.org>; Fri, 22 Jul 2022 01:14:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n185so2325406wmn.4
        for <linux-iio@vger.kernel.org>; Fri, 22 Jul 2022 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9DVxnFJwaerV12jgXMK3zBLGoxl8v4zlAcL2+s+9gAM=;
        b=fCqnxqTTH+E1xRh3T7QQ2zSDiYbfwW+3g9ru9OX3UopVRra0sKnKDGorsmKMWA1RGd
         k6TsTfDigwah7v8EoqIOYptREO8GMYZkrYG8g0VCu548fTIXtGSCGd4x1Bx+rji48mwA
         R3CFjikMPFSdYVrxtD34DPbMsyQIAqw9qOLcqOEad+xVMlP7a8Nz8UdB6YQ4yXdn2RCA
         +b5/eFidS8NP8my+rlZMh04sx/UgRlc9ITddUVpka4zCFTcPFkSKwt/1SzoHkzrOpezU
         sxmAC/nnpezPVXhgOJH/YXffp0MolN04badm69WIOT4O0OEO4429qdUSN+FycMUb9OWY
         6qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9DVxnFJwaerV12jgXMK3zBLGoxl8v4zlAcL2+s+9gAM=;
        b=GT1x2GvA4bxawWgsm2ATTZvurxF46kF/Oz9oonITBL0yg6/llPrZS5YD7BeZn6ZuMQ
         wU1Ki2cvVehUn3pheKei/Vo3a7ay+uc1PS1EOSnUGD/8R5WvpZ7kf7SNShgoLfcUFWs5
         oVwg/dtrL8iR6Nz6HtFXc9EEym7Ijbvir+KA/BaQDIYgv8oMH4lb5ndxZMRm35KPYQfL
         HdOD+6nIk9whpypHMV4rFxpvXEIpwzy1k/LwJogd3bAaVqKxuQ0oKKXuLspbDXpqatXy
         DcGKQCS/XzebHcrCm4nHfU8DOxn6jd+UhIB39/lYrrxZkrh/b36gm2SG6Hb4j8oP9srH
         oytA==
X-Gm-Message-State: AJIora+4y1Wv60yQec4h3t9aSUegj2BG/SZuK9mMaqdGLyVAxktSna5w
        dcYiqu/NyQw4vhK55QWDumXJbA==
X-Google-Smtp-Source: AGRyM1vVqORhBY4QZ5CAvwiaAPx2Tb3NLOQb5UCE7K6q3cn72VM359jXqnVIY+ofcGDmAGvG1c5Szg==
X-Received: by 2002:a1c:21c3:0:b0:3a2:fdba:3f39 with SMTP id h186-20020a1c21c3000000b003a2fdba3f39mr1620970wmh.194.1658477678048;
        Fri, 22 Jul 2022 01:14:38 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b003a317ee3036sm4515726wmq.2.2022.07.22.01.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:14:37 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:14:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, krzysztof.kozlowski+dt@linaro.org,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org
Subject: Re: [PATCH v3 0/6] Add support for mp2733 battery charger
Message-ID: <Ytpca2oosxjjQo0C@google.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
 <7d20978f-e17c-9bea-1436-68bcf4bd8524@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d20978f-e17c-9bea-1436-68bcf4bd8524@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jul 2022, saravanan sekar wrote:

> On 15/06/22 16:53, Saravanan Sekar wrote:
> > changes in v3:
> >   - fixed dt_binding_check error
> >   - fixed spelling usb->USB
> > 
> > changes in v2:
> >   - fixed spelling
> >   - revert back probe to probe_new in mfd driver
> > 
> > I do not see a cover letter, but FWIW,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > for all patches except DT binding
> > Note, some of the comments regarding spelling were given, I believe
> > you are going to address them in v3.
> > 
> > 
> > add support for mp2733 Battery charger control driver for Monolithic
> > Power System's MP2733 chipset
> > 
> > Saravanan Sekar (6):
> >    iio: adc: mp2629: fix wrong comparison of channel
> >    dt-bindings: mfd: Add mp2733 compatible
> >    mfd: mp2629: Add support for mps mp2733 battery charger
> >    iio: adc: mp2629: restrict input voltage mask for mp2629
> >    power: supply: Add support for mp2733 battery charger
> >    power: supply: mp2629: Add USB fast charge settings
> > 
> >   .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
> >   .../devicetree/bindings/mfd/mps,mp2629.yaml   |   4 +-
> >   drivers/iio/adc/mp2629_adc.c                  |   5 +-
> >   drivers/mfd/mp2629.c                          |   5 +-
> >   drivers/power/supply/mp2629_charger.c         | 208 +++++++++++++++---
> >   include/linux/mfd/mp2629.h                    |   6 +
> >   6 files changed, 212 insertions(+), 32 deletions(-)

> May I know what is the plan for merge this change-set !

It's due for v5.21.

If you're not planning on making any more changes, please collect all
of your tags and submit a [RESEND].

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
