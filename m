Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1444EF76
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 23:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhKLWlR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 17:41:17 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35688 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhKLWlR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Nov 2021 17:41:17 -0500
Received: by mail-oi1-f178.google.com with SMTP id m6so20636706oim.2;
        Fri, 12 Nov 2021 14:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zVdxqzVctj9Oqf20bPsjcEst9TsvfhlgOE+Wh1Q+xeE=;
        b=RgI5q/JHo0j/KjsZZN9W2+/4jiVcaEuyDdPLM9BwCIVnr3H8x66shz50KAuk+cR5M2
         /n+yaaKC++vON4Oz/wD8ybekfJG3QbYWb32KksKqjFENkrgM5ubHVWdx+2+wQXKnMmJQ
         RRFJ5ClIXk0E8bOMvddNf7jU11eFCmmq2Kk3psvY9aHInpY0RXb5M3VMtpzHbIRNFnRk
         mNCWEW6yEkAD232Kfs1Cky+HXQgAPHxeJoFTskjNp8MG5FYsiloANiF0muGSZGMfjA1D
         5SlM72NDDSLagC65kdrF5jjf850QVXUC6l81doHOYQaY0Lvl78cj9B7Y6cVMZSm3Rxya
         TQVA==
X-Gm-Message-State: AOAM531kpa0U8Ycg7fmXjfyVYDOCT/nUVWqg+1gy3pLr8+jO4fHPAhdM
        qajvQwD688wxT1Dl4Fbpcg==
X-Google-Smtp-Source: ABdhPJxfdumWnbqOr/j0+RwqPdcvWFxEzlA6pRvka0MVXO271xz7EuPSasgVNGp/gtQw6dDZCYyZvw==
X-Received: by 2002:a54:4616:: with SMTP id p22mr28895162oip.96.1636756705579;
        Fri, 12 Nov 2021 14:38:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k4sm1609123oij.54.2021.11.12.14.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:38:25 -0800 (PST)
Received: (nullmailer pid 3504211 invoked by uid 1000);
        Fri, 12 Nov 2021 22:38:24 -0000
Date:   Fri, 12 Nov 2021 16:38:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: frequency: add admv1013 doc
Message-ID: <YY7s4G2LIIqYiZyT@robh.at.kernel.org>
References: <20211105112930.122017-1-antoniu.miclaus@analog.com>
 <20211105112930.122017-3-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105112930.122017-3-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 05 Nov 2021 13:29:29 +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the ADMV1013 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/frequency/adi,admv1013.yaml  | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
