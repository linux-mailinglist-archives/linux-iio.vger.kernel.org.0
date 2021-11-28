Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC1460B13
	for <lists+linux-iio@lfdr.de>; Mon, 29 Nov 2021 00:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359516AbhK1XZM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 18:25:12 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:44014 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359549AbhK1XXM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 18:23:12 -0500
Received: by mail-oi1-f173.google.com with SMTP id o4so31028234oia.10;
        Sun, 28 Nov 2021 15:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=paxyLhmw0M9B7dZItScDveCANbfJrlrFlgXX9CqfhaM=;
        b=2Ysw4G5lYoECd8cyAWpd5z0cpYSMi7NPuXMzlit+shvIRUtV2Z68oap6aYjTLs+iCR
         TZfOfEJqq4/poXYzLbVCg6NqkeVrOk014VyYvQJciUpW4SlaeCMXUv9wKCotb+cHAccW
         QRxU9BMtpRdZmEjBlH5qSwNbAD1WBtfZefFDfDUbHV0KlYGRU/o+qhmsdxsa9TJ1sBQS
         eLVsHsuzEp+egNAYkVmZRZA/gLjNud80XKC7NvKbMEr+Q7eZHB6B3aWDSZKjlikjsT/Y
         35/69KomgfEL8qwWFw7paFEECqMEXDRUPrwaFh6dFe8XCxT+3K37/p0fRHk88xqkstKo
         /E+A==
X-Gm-Message-State: AOAM533v+SjnZ1uK55+4vZBrnjyMhULh8kKqAFNVrvCTEB+rsmSC0ptS
        fzYIQ+G4eBbZ5Xn4pLpuycGKzkhbrQ==
X-Google-Smtp-Source: ABdhPJygcBNUkmzcCIpCE0gJYPjbwuUoBq7/KmksFGrHbrAosZiwp9MqLpiPlcg1jz2b/xlmVw8gCg==
X-Received: by 2002:aca:1204:: with SMTP id 4mr37215388ois.136.1638141595684;
        Sun, 28 Nov 2021 15:19:55 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fe7:4487:4f99:dbc0:75d1:3e27])
        by smtp.gmail.com with ESMTPSA id k14sm2349572otb.50.2021.11.28.15.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 15:19:55 -0800 (PST)
Received: (nullmailer pid 2803799 invoked by uid 1000);
        Sun, 28 Nov 2021 23:19:52 -0000
Date:   Sun, 28 Nov 2021 17:19:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings:iio:amplifiers: add ad7293 doc
Message-ID: <YaQOmCMQcZiyvnbW@robh.at.kernel.org>
References: <20211122133639.132972-1-antoniu.miclaus@analog.com>
 <20211122133639.132972-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122133639.132972-2-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Nov 2021 15:36:39 +0200, Antoniu Miclaus wrote:
> Add device tree bindings for the AD7293 Power Amplifier.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - set `avdd-supply: true`
>  - set `maxItems` for reset-gpios
>  .../bindings/iio/dac/adi,ad7293.yaml          | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
