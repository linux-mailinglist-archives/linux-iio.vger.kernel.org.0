Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F93C8824
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhGNQA0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 12:00:26 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:47063 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbhGNQA0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 12:00:26 -0400
Received: by mail-il1-f176.google.com with SMTP id y6so2061128ilj.13;
        Wed, 14 Jul 2021 08:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1wZIZOEFDZFkMCSRbf78wJDBUSgnwkscloWWTEPvVfM=;
        b=FhQz2TeAOVsGHcZ05cW4VEudztJvOCsU6iQsiibSBGVvCFF2Sfo2qClI1i0nlt2mZQ
         gSoteJ3DTmRRnXS+9PHxde4ZetI9U9l+dVRnzQaq6yrn1oiuAIaG/C6kH4/2nptBb2qZ
         syJyj2BB/xoFoqe8qj4FssCPH+6WBHM+4K2vJSBW9jQvzzwWTm6bAzlO/4FhRL+R3fsV
         4kNrx+TOcyAChK+sJQbTWp9FXHLY2PC5JbPLxWLKezwhJ37tAaVYpP0Ae2sta0iAar6O
         YLULJlmtDqTfWDxL5rYWBVGfvElem+8b37kdxz8gM2fNO9/azmECxOkzsZ1NIq7w+e9/
         9a5w==
X-Gm-Message-State: AOAM532fG1iveHAC6TkzcTwN/Jnz+wkUu+ocu8GbRDxORS9IdbENFOEj
        4cZtacKQroJ+Fnw45qojMw==
X-Google-Smtp-Source: ABdhPJxPTzwvl1yR9PTpQJk2+aTjXq9rChD2ZNy51TgRZy0Uo5Zs9R5qqesuJUqU7w1jVEKOkvxmtA==
X-Received: by 2002:a92:ca8f:: with SMTP id t15mr7169400ilo.262.1626278253125;
        Wed, 14 Jul 2021 08:57:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n14sm1438630ili.22.2021.07.14.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:57:31 -0700 (PDT)
Received: (nullmailer pid 2652374 invoked by uid 1000);
        Wed, 14 Jul 2021 15:57:29 -0000
Date:   Wed, 14 Jul 2021 09:57:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 10/15] dt-bindings: iio: dac: ad5686 and ad5696: Add
 missing binding document.
Message-ID: <20210714155729.GA2650609@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-11-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-11-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 27, 2021 at 05:32:39PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The use of vcc-supply for the reference voltage is unsual and should

unusual

> probably be deprecated as there is an explicit VREF pin on at least
> some of these parts.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/dac/adi,ad5686.yaml          | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
