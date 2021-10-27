Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C0643CF4A
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 19:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhJ0RDG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 13:03:06 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35681 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbhJ0RDE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Oct 2021 13:03:04 -0400
Received: by mail-ot1-f52.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so4547735ott.2;
        Wed, 27 Oct 2021 10:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RtqV4H7eeR6u+avNn6okTQ1/JGVICcvroNZIgpDcm2s=;
        b=QAUfiQj6fUzwWHWOKK6+OxLtxFpJmwxqYDoMLwtKJGYogdtxNqHJv7c7YtaGBXX8IX
         vTSB8iIH9veUInlGe2nsn23sveAkEvXyWxA8k9AyZzkQFxJT0w6W/NIAxM0NyAS2su1w
         iDUKYP2fFia3dN9fTx1ItTchVxQtr0Sf2dGA1OllckY8zSOMZhPjIrcf26RNee2YbKf7
         U/RNhDkSEbB60kgiZSQ6SMyIP8+wlLZSd1yJ1KUs9qW/3owXyRkAG00ph87UiwGXYKs3
         v/z3ysACnpsxL5CLvRCSJZ8d9D1KsucoJYIc5Z3YbbdsPkcwTb6DVF9W52ptp2pBSTqr
         Jntw==
X-Gm-Message-State: AOAM531KnlRSZIgW+bgkROOR+lCoyQdx1i8cPZI5fhxoZFImyNavmCc/
        A87cISqJEVj1ZhcVCCdtfA==
X-Google-Smtp-Source: ABdhPJwmNeBVUUygvxX7UipNwjtEukgWRd17+LQhBDdaVzhHaOzOF5Zh6o2G4SzrMIpMlcchoTR4wA==
X-Received: by 2002:a05:6830:4488:: with SMTP id r8mr26281272otv.155.1635354038822;
        Wed, 27 Oct 2021 10:00:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 64sm40632otm.37.2021.10.27.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 10:00:38 -0700 (PDT)
Received: (nullmailer pid 1716538 invoked by uid 1000);
        Wed, 27 Oct 2021 17:00:37 -0000
Date:   Wed, 27 Oct 2021 12:00:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, michal.simek@xilinx.com,
        devicetree@vger.kernel.org, git@xilinx.com, pmeerw@pmeerw.net
Subject: Re: [PATCH v7 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Message-ID: <YXmFtd8DmAhk1ex3@robh.at.kernel.org>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
 <20211019152048.28983-4-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019152048.28983-4-anand.ashok.dumbre@xilinx.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Oct 2021 16:20:47 +0100, Anand Ashok Dumbre wrote:
> Xilinx AMS have several ADC channels that can be used for measurement of
> different voltages and temperatures. Document the same in the bindings.
> 
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> ---
>  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     | 227 ++++++++++++++++++
>  1 file changed, 227 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
