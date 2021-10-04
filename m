Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB094421465
	for <lists+linux-iio@lfdr.de>; Mon,  4 Oct 2021 18:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhJDQuc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Oct 2021 12:50:32 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41473 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhJDQub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2021 12:50:31 -0400
Received: by mail-ot1-f41.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso22395459ota.8;
        Mon, 04 Oct 2021 09:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+hwLdOp02R5EAiJ4KNQCp4lIQVkoRkYxlsfTnQeSF+s=;
        b=RnMCWzq7SnOzrARXYYHpsnJ7nE3KtOS4B4iBDBV7DoHOnBtIeOtqlHlajNL2PnDV7O
         pgcK5lUwx0Vk22KcdFu9HIGjmTO4s/7AFzPyWqlmzlpudmEDjbdf4Qy4kY6QohFwYk+d
         wjGKohwyDbshkNXRF/IP2rRXr3lbysKw/X6XgCCaBbl8x4u9zDxdkhr1RkV2dErHPIz1
         noT9FOf6YANmHFBVmBfYSOXWXAZ7+hevsynaxAvMcdKTvXKQX8PwFdCpzbL2EE31E18+
         BLlIUaWhiXlyoHw2z6GzvSZWwRfbw/1Ge3Jh1o7Rd+rukIUuHXfZ71j2mo6mBuXJPeoH
         +GDw==
X-Gm-Message-State: AOAM5323eyLtmILfH0anBgAMzaAL9XJEitpT59HX/z11YsCRn/WwpI+E
        0mu6sQziseIdIpXE0aJA6Q==
X-Google-Smtp-Source: ABdhPJxXLkpec85mPyfX/0RbHai/r0l5yavVd7LFW2ZoMky+8OA1PzKRe3k0EPzIC0t3fGYXtAWlyw==
X-Received: by 2002:a9d:4a8d:: with SMTP id i13mr10341023otf.180.1633366122440;
        Mon, 04 Oct 2021 09:48:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c4sm2552956ook.5.2021.10.04.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:48:41 -0700 (PDT)
Received: (nullmailer pid 1455411 invoked by uid 1000);
        Mon, 04 Oct 2021 16:48:40 -0000
Date:   Mon, 4 Oct 2021 11:48:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Boor <florian.boor@kernelconcepts.de>
Cc:     Michael.Hennerich@analog.com, Jonathan.Cameron@huawei.com,
        devicetree@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: iio: ad779x: Add binding document
Message-ID: <YVswaEcToAR+4bLG@robh.at.kernel.org>
References: <20210930104249.2924336-1-florian.boor@kernelconcepts.de>
 <20210930104249.2924336-2-florian.boor@kernelconcepts.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210930104249.2924336-2-florian.boor@kernelconcepts.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Sep 2021 12:42:49 +0200, Florian Boor wrote:
> New binding documentation for AD799x series of I²C ADC ICs.
> 
> Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>
> ---
> 
> Changes in v6:
> - Minor documentation change (label and contact info)
> 
> Changes in v5:
> - Correct errors in documentation found by
>   'make DT_CHECKER_FLAGS=-m dt_binding_check'
>   + Reduce title length
>   + Move information to description
>   + Add I²C bits to example
> 
>  .../bindings/iio/adc/adi,ad799x.yaml          | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
