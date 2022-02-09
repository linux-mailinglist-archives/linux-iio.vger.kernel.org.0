Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ACD4AFE0D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Feb 2022 21:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiBIUMi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Feb 2022 15:12:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBIUMi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Feb 2022 15:12:38 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C5E01C685;
        Wed,  9 Feb 2022 12:12:34 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso3802342oon.5;
        Wed, 09 Feb 2022 12:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W/UQplenPqJG5Ahv1wLvwfdyAf2KshN531HhWEMo0Os=;
        b=SLobkWvgzIbcXN1cR4gbIueKPnCcpQx8t/DiAO4bz0lbsJ3XGJN1b7Lo2B6Wqa5Ls6
         HBmtYkxF5mWfKBHe1ksyFb8CBryAD3LJqCTDKumPW/SzLYqr643+Lvxtd5pcUdf/kDi1
         s+rPN669/Ns2nzmvHgU85RYbWx290HaqMyD4Bajh7tV0J3t/7sUU7hz1na7cO4FARhYG
         a0RqvEwYa87fMmLA9xA/d95W2nh0fp0Bvn0VhMXsVqUgqftNvUweW0sWlTYtT1gAFZOE
         Y+Hf1sLceKhr1pio05ZUqCumZYP6wV6JtGK2kSs6vJTSd6VWdOpDQDx4PxLkmkGMe4gH
         0/og==
X-Gm-Message-State: AOAM533vyXRoeRzsyiUisOvr8OL6zeKz/Ikd9Ffd5e3+7A2l9bUrqcCg
        uNFllbzy3ukHl2k808xSZg==
X-Google-Smtp-Source: ABdhPJyJnWKtKnilwNEZkRI00kcGwsaPrryq0cnq/wxVeIG0VHXas0PCuWn9oxYzmsPBPWQlVRgNFQ==
X-Received: by 2002:a05:6870:d385:: with SMTP id k5mr1323114oag.174.1644437553443;
        Wed, 09 Feb 2022 12:12:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w9sm7109862ool.31.2022.02.09.12.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:12:32 -0800 (PST)
Received: (nullmailer pid 817305 invoked by uid 1000);
        Wed, 09 Feb 2022 20:12:31 -0000
Date:   Wed, 9 Feb 2022 14:12:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     devicetree@vger.kernel.org, lars@metafoo.de,
        anand.ashok.dumbre@xilinx.com, manish.narani@xilinx.com,
        robh+dt@kernel.org, michal.simek@xilinx.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: zynqmp_ams: Add clock entry
Message-ID: <YgQgL4+WsPyzh3nG@robh.at.kernel.org>
References: <20220127173450.3684318-1-robert.hancock@calian.com>
 <20220127173450.3684318-2-robert.hancock@calian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127173450.3684318-2-robert.hancock@calian.com>
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

On Thu, 27 Jan 2022 11:34:47 -0600, Robert Hancock wrote:
> The AMS driver DT binding was missing the clock entry, which is actually
> mandatory according to the driver implementation. Add this in.
> 
> Fixes: 39dd2d1e251d ("dt-bindings: iio: adc: Add Xilinx AMS binding documentation")
> Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> ---
>  .../devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
