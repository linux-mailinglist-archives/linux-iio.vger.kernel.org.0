Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E635A112
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDIObb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 10:31:31 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:35443 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhDIOba (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 10:31:30 -0400
Received: by mail-oo1-f50.google.com with SMTP id i20-20020a4a8d940000b02901bc71746525so1386855ook.2;
        Fri, 09 Apr 2021 07:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DbLILLqXq2Gu5LIj3us0Wk/MzcLqzAeWGp5UqXn+EKo=;
        b=Ke9VtmiPoziFogj+W9udwp/3hkEY4zAe8EOgTF+c4gOWAge92GvIUhSfiBERcSQnZc
         pDUJ1b8+LcnPBqRTqsek4wEtdUs4fIZ2CcYTUPmSXV0NH7Hph8UW5JeFQ6SmR4gWlc3Y
         LjhN38+1CwxmNIxnf5hqqYOrXn+WOor845pCunEp1jP2it0BgQ7CFC+fIp3xuAjuTItP
         Yr5xErROEi/E3s5Bwr9Ub5BpXw59r6ChR5bzbdD4Ukcmw1jf94aNQh8jDD7RjHSVCwVf
         BJd6zDry8jShfMRjdJzvZ8ucu3lCUkZaObd7tHt57PMP1jHnumB28lBsxqysTdgiQYu+
         uD+w==
X-Gm-Message-State: AOAM5325L3gXb+ijatyuZE44r5GNTtZ6Rv2LNQPjmLYjiH5bmvC49lYJ
        SNTbbTq5KH8AELlkMSKBoA==
X-Google-Smtp-Source: ABdhPJzHbxxaL4ZwqGPQmTH3dr2hUYEZTOlsJVdlwNrG+XNXUIGaULu4SRA5pk8VZDsxhkohmY4IMg==
X-Received: by 2002:a4a:9843:: with SMTP id z3mr12075023ooi.51.1617978677526;
        Fri, 09 Apr 2021 07:31:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i25sm645224otf.37.2021.04.09.07.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:31:16 -0700 (PDT)
Received: (nullmailer pid 3606008 invoked by uid 1000);
        Fri, 09 Apr 2021 14:31:15 -0000
Date:   Fri, 9 Apr 2021 09:31:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings:iio:dac:ti,dac082s085 yaml conversion
Message-ID: <20210409143115.GA3605953@robh.at.kernel.org>
References: <20210401140956.224084-1-jic23@kernel.org>
 <20210401140956.224084-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401140956.224084-3-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Apr 2021 15:09:56 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Fairly simple conversion with the exception of the XOR between
> spi-cpha and spi-cpol.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Link: https://lore.kernel.org/r/20201031134110.724233-17-jic23@kernel.org
> ---
>  .../bindings/iio/dac/ti,dac082s085.yaml       | 72 +++++++++++++++++++
>  .../bindings/iio/dac/ti-dac082s085.txt        | 34 ---------
>  2 files changed, 72 insertions(+), 34 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
