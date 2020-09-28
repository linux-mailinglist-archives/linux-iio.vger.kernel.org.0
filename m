Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3731C27B471
	for <lists+linux-iio@lfdr.de>; Mon, 28 Sep 2020 20:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgI1S1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Sep 2020 14:27:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37780 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1S1c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Sep 2020 14:27:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id o8so1921994otl.4;
        Mon, 28 Sep 2020 11:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gntewucXGAZEXsmTkYpsZuCb5osJ4WHC8uBmXkRio9g=;
        b=Cld0gdLCMDWN94yD+ledWRmIyQwuH9cOHLh/p9lxPJIJjjEW2T7JmKzg82olG6H8cX
         xyHjvzfKpApiaVHO0pb6B2dVoHyEGZWhlXljHZp3/owR41G85ZIqlwKJVfCSh6owgXWi
         nI4GdOE22r0qV4mJKOuglIif8OLB7xmOUxNejhbUjEJa4F6Q4KKpDbqM2PzrjapJW88q
         6rREIttNK3Rxm51STLMLfRyYpq4YV1SMbS9TrPoLKL5LMB71a0L8eJ82Q3jp3pDKCLJt
         i5QkD+vuaQsQjbFeOs9jxzQ2TJiinawAKQsljDdPJh4pRpAZelW2CdBDXY6CRpnvu8Rb
         fSUA==
X-Gm-Message-State: AOAM532K+hoBpPboyHOnnCIQMHlnnrWMII6+k3DPT1jQ3P7C6F02slId
        Ik5riV9DRoawVO8sFHG+0Q==
X-Google-Smtp-Source: ABdhPJynurwsMeyeH9KSDU10nJtgTWqyaJKqKSZEA8jpQUXzumTWDGrLO2HajskY1S2NhK4hbo3OTQ==
X-Received: by 2002:a05:6830:10d9:: with SMTP id z25mr205514oto.136.1601317650306;
        Mon, 28 Sep 2020 11:27:30 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 17sm402857oth.70.2020.09.28.11.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:27:29 -0700 (PDT)
Received: (nullmailer pid 3036808 invoked by uid 1000);
        Mon, 28 Sep 2020 18:27:28 -0000
Date:   Mon, 28 Sep 2020 13:27:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        cy_huang@richtek.com, pmeerw@pmeerw.net,
        benjamin.chao@mediatek.com, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shufan_lee@richtek.com, gene_chen@richtek.com, knaack.h@gmx.de,
        lars@metafoo.de, linux-iio@vger.kernel.org, jic23@kernel.org,
        Wilma.Wu@mediatek.com, robh+dt@kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: adc: add bindings doc for
 MT6360 ADC
Message-ID: <20200928182728.GA3036774@bogus>
References: <1600687442-23658-1-git-send-email-gene.chen.richtek@gmail.com>
 <1600687442-23658-2-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600687442-23658-2-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Sep 2020 19:24:00 +0800, Gene Chen wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
