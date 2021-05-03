Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3343B371E3A
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhECRQY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 13:16:24 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:34551 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhECRPl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 13:15:41 -0400
Received: by mail-oi1-f170.google.com with SMTP id l6so6103809oii.1;
        Mon, 03 May 2021 10:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MqiyjQ3EFs8Wrezz9jJ5DYGiprpcVkpW5pMHmRup4lE=;
        b=ZNvHv7D1RBm/VjLFu09hTOPVEl3hmJ1QjNDvbhjzUkQ4ZScVtD2jgmLRmu45ety6bZ
         UOM2/wYQX3kycr2TAwpGQTi8n4gEG8cjUJYnywJJPsxrwLa6+Kf2simxmm/jxzV/CBwj
         4HnU2QObu8HOS8gvZO2bypdDahIi1GFqjh/G5Vw3/s6y+Ylz8VA5aVei7lFDCTbEY+2n
         5ddWSSgQmvZaoD3f2t48KcJZOnnQAucAP99/twVDkZG3B8zranXv8Z1t9hoYHO0xZKR+
         fuAVBNQsmCuNwH+yDmjpTsEQjH+CHkfGf9ledIp0uhTkgluT2dUY7trrd6uc7DG79jlL
         tyGQ==
X-Gm-Message-State: AOAM532ms8B+7ZDq6lTR5bEH9ZHXOhGhPa+caP9cEllzX2sPfVFUqQKK
        9rT3RS6CPf+qHd9MbqEnyA==
X-Google-Smtp-Source: ABdhPJxSur5zijA8cVwbE+9gC2tArkuzNARf5pBR8meCpZPjawUQpnZfnH9jc2edK6U2BFd+/JNZmw==
X-Received: by 2002:aca:1211:: with SMTP id 17mr14468967ois.20.1620062087296;
        Mon, 03 May 2021 10:14:47 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h59sm93019otb.29.2021.05.03.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:14:46 -0700 (PDT)
Received: (nullmailer pid 2030975 invoked by uid 1000);
        Mon, 03 May 2021 17:14:45 -0000
Date:   Mon, 3 May 2021 12:14:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings:iio:dac:ad5755: txt to yaml format
 conversion.
Message-ID: <20210503171445.GA2030945@robh.at.kernel.org>
References: <20210424173015.534941-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424173015.534941-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 24 Apr 2021 18:30:15 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Straight forward conversion.  Only fiddly bit is the XOR of
> spi-cpol and spi-cpha.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Link: https://lore.kernel.org/r/20201031184854.745828-40-jic23@kernel.org
> ---
> This has been in a few different series, so version numbering is a bit
> scrambled.  Let's just call it v2.
> V2:
> * Drop unnecessary refs where units in naming
> * Drop unnecessary brackets in child node naming
> 
>  .../devicetree/bindings/iio/dac/ad5755.txt    | 124 -------------
>  .../bindings/iio/dac/adi,ad5755.yaml          | 169 ++++++++++++++++++
>  2 files changed, 169 insertions(+), 124 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
