Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD2742E2C7
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 22:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhJNUaQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 16:30:16 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38716 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhJNUaP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2021 16:30:15 -0400
Received: by mail-ot1-f49.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso4797676otp.5;
        Thu, 14 Oct 2021 13:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zq1AQkFiCZUk6gXV9/TKwvkPbPsRsPVWXNKsp0IVrV8=;
        b=2GTVkxPXjmsl8Hkpzim2ZDAHdAZ4ON4FbeJZ6dxZ/AbCioMIqdlz6gCJifX2xY31HU
         QGCfcNSeeubFj0XoViDTuQd7P1rH4Q3u5rZIYh7nkPnt0NEjam5hIHILBTnd3gWDNyY/
         aoWBvIOFqZ9HLYoO/6xFtiZWpP6kt8TWoXIj9LoWLkiu86JFKLqOovflXobx1gPFklhb
         Mg7H0Lgao7m+sThi3dlMr044oz9SyeTDZovj6fCBbTLF5iKKJQbQQ/LGiO4gsjSs/SEm
         zcf1W2Lo9QB4jEPjFoqbRMgN4e/4J/5SLzWKp4QZLNX/xr9GMaMyLqKVVD08JZLh5qH4
         8/Aw==
X-Gm-Message-State: AOAM531CD7erDo/jP3euOtB0Z1A0Qg0fiN9k56e7k1OSLI9FtulcYqcu
        WjCDZPnUjCYDcL+jHA2BEg==
X-Google-Smtp-Source: ABdhPJyK1TzaisBbr6dE5qO28OsToToh79Ac9lJ0NTuWdBrJI9adSe4V8L5pDjzXrcJsJERoL2XSbQ==
X-Received: by 2002:a9d:7354:: with SMTP id l20mr4448081otk.187.1634243290124;
        Thu, 14 Oct 2021 13:28:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w2sm645044ooa.26.2021.10.14.13.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 13:28:09 -0700 (PDT)
Received: (nullmailer pid 3867978 invoked by uid 1000);
        Thu, 14 Oct 2021 20:28:08 -0000
Date:   Thu, 14 Oct 2021 15:28:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        stephan@gerhold.net, jic23@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Document liteon vendor
 prefix
Message-ID: <YWiS2J8qdrAitOUZ@robh.at.kernel.org>
References: <20211006163058.145842-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006163058.145842-1-nikita@trvn.ru>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 06 Oct 2021 21:30:55 +0500, Nikita Travkin wrote:
> Add vendor prefix for LITE-ON Technology Corp.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
