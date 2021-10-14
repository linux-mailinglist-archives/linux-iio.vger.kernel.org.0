Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6142E2CD
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 22:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhJNUac (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 16:30:32 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46656 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhJNUab (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2021 16:30:31 -0400
Received: by mail-ot1-f53.google.com with SMTP id 62-20020a9d0a44000000b00552a6f8b804so9261328otg.13;
        Thu, 14 Oct 2021 13:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NsPNXpPSOeaaXCtuDXOwMbIICppUrSTSR4q6unEndC8=;
        b=ZBzrH4cBqMXu8nYyhzzXyIu5vdS1OIvxLe4W01UpIdAYslYhi4bDlcA7SDtBMiKC5f
         UqzPUCrMd+GPWfQ2HbjvKL3sUzZy0niMMA0Bx2raAX8DTG6L8b7TVHMWPxEdK1QF2Xsk
         eTMhij+ct/DGRiklF/fka5YjFrgyzwtwKl/PYE+cO7NhdUS9fk+oVCGuV9YMhyxi7v4c
         Bbth/5gOGWhlxDg3EfVxMv24UqOZdB7KOqjhM1cqOtXkGh5Wbxbtx1Vh5yiob0b4NPGN
         HlFFsq6Kvtt6gGs5M/7LA3turfDxoYAMMcCb6hDeerCBJT99FwpjV/QAd1pOpf1+ioML
         lpsw==
X-Gm-Message-State: AOAM532AFIoaRtCTdEclPnkyojsBgpCjPazswmXWtRHWsxSPY7BlnWUs
        05g3eozSurRY/xsokfu4TA==
X-Google-Smtp-Source: ABdhPJzjBek49pTLH3+IPD3oP9+PnNIAhQ+FrKbJpu7dPnee1MLJJelDtzK16Lrkbo6HxjLu2gqDLA==
X-Received: by 2002:a05:6830:714:: with SMTP id y20mr4479730ots.257.1634243306146;
        Thu, 14 Oct 2021 13:28:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 12sm751453otg.69.2021.10.14.13.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 13:28:25 -0700 (PDT)
Received: (nullmailer pid 3868490 invoked by uid 1000);
        Thu, 14 Oct 2021 20:28:24 -0000
Date:   Thu, 14 Oct 2021 15:28:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de, stephan@gerhold.net
Subject: Re: [PATCH 2/4] dt-bindings: iio: light: Document ltr501 light
 sensor bindings
Message-ID: <YWiS6GTiEyQ0HQ0F@robh.at.kernel.org>
References: <20211006163058.145842-1-nikita@trvn.ru>
 <20211006163058.145842-2-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006163058.145842-2-nikita@trvn.ru>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 06 Oct 2021 21:30:56 +0500, Nikita Travkin wrote:
> Add devicetree bindings for ltr501, ltr559 and ltr301.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../bindings/iio/light/liteon,ltr501.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
