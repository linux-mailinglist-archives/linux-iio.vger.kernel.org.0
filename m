Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C0044E9EE
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 16:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhKLPXI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 10:23:08 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37530 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhKLPXE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Nov 2021 10:23:04 -0500
Received: by mail-ot1-f50.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so13432412otg.4;
        Fri, 12 Nov 2021 07:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XL7WHChnykm1XEF7Yo39vqcbHAAH7PV5WQdRdC97D8s=;
        b=j/kb4VzmWa3hc5pDznIKRehK+N59F1bNGOZtILMbDTe3ECF9L9oSczTWGculZbJN7Q
         FTR3zKvhbHC0AzL7KtVIdZ1DAHokoMvRxMPvTUI4kujuZ+9WpDgXdObeSjKoyljLO/Jl
         jC74L8E6lMvlKARedX87iiQrQb59txTzFTPhvdyReocvBKcAQM1Ce1nIxz35AzT2EDv4
         gNyxwLdBW2gttXfinOuej3zyn6CQrEBkjc1biraEFVokoiPM10SDJmDyDK1CHFJuzxRU
         0IP2w1oNCPtK9eVpNJW4+in3t0+u3gwwYOIS225FnC1C7V9PRTLCuPBzGjcd3nBTHXdW
         TI4g==
X-Gm-Message-State: AOAM5333tlPyoyh5irS3Pm3scWuX+6bvdlWtZW+4U1kdkyLMtm9eFJAJ
        BcowvGKt4PfZm8AhjjJ5WCyim6o58w==
X-Google-Smtp-Source: ABdhPJy8eBQbPOkE+3SSIRibQY8WLVPaKWMwduUfydGqT0FYX5JU0EsXU2XqNIyLKmS5Pu87s0EaTA==
X-Received: by 2002:a9d:5190:: with SMTP id y16mr13227870otg.364.1636730413416;
        Fri, 12 Nov 2021 07:20:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g1sm1150338ooq.2.2021.11.12.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:20:12 -0800 (PST)
Received: (nullmailer pid 2872324 invoked by uid 1000);
        Fri, 12 Nov 2021 15:20:11 -0000
Date:   Fri, 12 Nov 2021 09:20:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        michal.simek@xilinx.com, jic23@kernel.org, git@xilinx.com
Subject: Re: [PATCH v8 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Message-ID: <YY6GK3K5B/cgdczY@robh.at.kernel.org>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
 <20211108210509.29870-4-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108210509.29870-4-anand.ashok.dumbre@xilinx.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 08 Nov 2021 21:05:08 +0000, Anand Ashok Dumbre wrote:
> Xilinx AMS have several ADC channels that can be used for measurement of
> different voltages and temperatures. Document the same in the bindings.
> 
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> ---
>  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     | 227 ++++++++++++++++++
>  1 file changed, 227 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

