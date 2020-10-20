Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEEE293FF7
	for <lists+linux-iio@lfdr.de>; Tue, 20 Oct 2020 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgJTPxD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Oct 2020 11:53:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42639 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbgJTPxD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Oct 2020 11:53:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id 16so2627733oix.9;
        Tue, 20 Oct 2020 08:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iSUnJ3zC+i96Tee9HE3Ma7rzjDtB6lhpcHKRFjv2ccE=;
        b=QTI7twpdbwfwxd9wFaD/kxU5LlqiTv1PKGs2643exe1StTGOFf1NM54SmhADOVwyVI
         2dXvl92hZz1w0MHI+dD7wpXqEiggF52LXG3S+K69JblHl4yuWfpzff/467pNG/kSdjI/
         Cqot+KNCegQIuiVOuo/iolDv9hjCigCcbkSdsJ6kbHR/B2HdAC+t18FP9gFr8bB4Juo7
         lA7wA6/iNxp1L++whlwcDE9lPIr1zDuiVxHMmQzdoi0Xb9stk0S+ltVtRhQiqWiZY0RW
         InzrGMa/T1GFPwdh2EndRmaockmE9+tWzpJ/lZqg6pxDgNhoQ99BPPcBwWZlRFsP5mdo
         UgpA==
X-Gm-Message-State: AOAM533Cu61rA/T7qTZKTf6g/QiE6rM8VLj9xVWzNCfsy6A1W8/SMgYN
        qhL7Wq+J/8MZneOD4bPLd6gi4xSOVA==
X-Google-Smtp-Source: ABdhPJw7jKtcBX1HJmvImu3OtQLdkpQmW076DYW/d4yYauIv/uHxi67eNnw6fzLjEkrKebqPLx3YMg==
X-Received: by 2002:aca:1105:: with SMTP id 5mr2380044oir.46.1603209182630;
        Tue, 20 Oct 2020 08:53:02 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j84sm640090oia.25.2020.10.20.08.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:53:01 -0700 (PDT)
Received: (nullmailer pid 907213 invoked by uid 1000);
        Tue, 20 Oct 2020 15:53:00 -0000
Date:   Tue, 20 Oct 2020 10:53:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Wilma.Wu@mediatek.com,
        matthias.bgg@gmail.com, knaack.h@gmx.de, cy_huang@richtek.com,
        lars@metafoo.de, jic23@kernel.org, gene_chen@richtek.com,
        linux-iio@vger.kernel.org, benjamin.chao@mediatek.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        shufan_lee@richtek.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, pmeerw@pmeerw.net
Subject: Re: [PATCH v7 1/3] dt-bindings: iio: adc: add bindings doc for
 MT6360 ADC
Message-ID: <20201020155300.GB906028@bogus>
References: <1603181267-15610-1-git-send-email-gene.chen.richtek@gmail.com>
 <1603181267-15610-2-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603181267-15610-2-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Oct 2020 16:07:45 +0800, Gene Chen wrote:
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

