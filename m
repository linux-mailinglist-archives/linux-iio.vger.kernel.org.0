Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D822837F8
	for <lists+linux-iio@lfdr.de>; Mon,  5 Oct 2020 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgJEOi7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 10:38:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36362 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJEOi7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Oct 2020 10:38:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id u17so2727985oie.3;
        Mon, 05 Oct 2020 07:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=naQi8NEjlXf44kRLn+g1FTyii1oFTs4V5HICiDUnCFM=;
        b=Mvyya8gaai0gmXmhXDVSW4ogakkTSVbpcBE2R57cV+Gz/hMl2t5iC9GMbxtLCnGufR
         Yr6EAj5BylUvRDeRD3NLmbsOFuk14CWqxNZ25ttVf+Quu58bamkjKX53C+8c1YTOSrFK
         yjURLTHZpbdbytgpzTyeRT/8pyPgFHBqPjfHz2JqBOwuZxf+vWS7gyJLJ33WaUVnvfSA
         qo0lNJf8Xq5s4B/ONqmSDqnlfh2Mpzq9kz+NLzrLxo694qzjR51ZwHRINUadEK1UxERz
         DIjH/1SqJpRFqxz9a6tmmbeCrDSoTD5TLzekMYzRpnRtEt1LIydrD3BeJhmKFc7RLB8h
         uBRw==
X-Gm-Message-State: AOAM532RFPDo4fmted2jp6aUwXtHG54JSPK8l5a7tCgEYg6I3eadiPek
        lJvHTN/CWZxBvS9uTYPpmA==
X-Google-Smtp-Source: ABdhPJyBNSFKOcjOpYW30Jw30TpzykIS03eABHXPs2eAFFuiWGe8CeVT1pVZB+S/XP4nZBn1bxFiKQ==
X-Received: by 2002:aca:55c2:: with SMTP id j185mr5332858oib.13.1601908738430;
        Mon, 05 Oct 2020 07:38:58 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u68sm3104760otb.9.2020.10.05.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:38:57 -0700 (PDT)
Received: (nullmailer pid 149913 invoked by uid 1000);
        Mon, 05 Oct 2020 14:38:56 -0000
Date:   Mon, 5 Oct 2020 09:38:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     shufan_lee@richtek.com, lars@metafoo.de, matthias.bgg@gmail.com,
        pmeerw@pmeerw.net, Wilma.Wu@mediatek.com,
        linux-arm-kernel@lists.infradead.org, benjamin.chao@mediatek.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, gene_chen@richtek.com,
        linux-mediatek@lists.infradead.org, knaack.h@gmx.de
Subject: Re: [PATCH v6 1/3] dt-bindings: iio: adc: add bindings doc for
 MT6360 ADC
Message-ID: <20201005143856.GA149682@bogus>
References: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com>
 <1601542448-7433-2-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601542448-7433-2-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Oct 2020 16:54:06 +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> This change adds the binding doc for the MT6360 ADC.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  .../bindings/iio/adc/mediatek,mt6360-adc.yaml      | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

