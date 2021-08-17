Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B096D3EF59B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhHQWRU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 18:17:20 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35477 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhHQWRS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 18:17:18 -0400
Received: by mail-oi1-f178.google.com with SMTP id r26so1488200oij.2;
        Tue, 17 Aug 2021 15:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEln33rQ3wnb6Du21VuSLVe94OM4FvH0QBwyo/CSwKY=;
        b=ZRr4ezGViI7qytz6HpXLJ1Cyyctawclt0hWYsSFViIEKmT0mByuVi4hbADZ/7Lv+bn
         X3kF8SEFPIn5IGijWRzyZyqShcMaGB+gA4DmQeyurQ8/PzMZUZ+ZjHDDTDCp12m7c7kK
         1XoW+xOK8Ktf3KVbwNpvRFeM9DEIi0+lOPK7/34t0cv0/aJGeZMzKpa4V5xyc87rpkIC
         y6e467bqtoH0qpTBjnhNH9wZZiLeKugfQkfJYrFxARcYfQBHdCGXFMrQg4bSAOUHPAHs
         e6RzSSNuRPxIEJrOG3D/9btZ7wJfnhl30zboVxXHVolSEdxfP/NuhdgSFb8iFbW3KXoO
         g9pg==
X-Gm-Message-State: AOAM532wE0KmS2RxtLw6DNJ2rzlXyPBfyf43oBLKs9O/uT5nQwMaZXvG
        3ZatwgAgIK/uXkf5HMihmw==
X-Google-Smtp-Source: ABdhPJwjeyORPrrl7WrQoexDO+Afgt3Dgm1qZSAweOUT57k1wtLob8EWg6G5iWr8o3ZyW/fT2qlpGg==
X-Received: by 2002:a05:6808:356:: with SMTP id j22mr4420961oie.130.1629238604904;
        Tue, 17 Aug 2021 15:16:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x8sm692727oof.27.2021.08.17.15.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:16:44 -0700 (PDT)
Received: (nullmailer pid 936717 invoked by uid 1000);
        Tue, 17 Aug 2021 22:16:43 -0000
Date:   Tue, 17 Aug 2021 17:16:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Michael.Hennerich@analog.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Nuno.Sa@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] dt-bindings: iio: adc: ad7949: update voltage
 reference bindings
Message-ID: <YRw1S+cLD1gVxNiO@robh.at.kernel.org>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
 <20210815213309.2847711-5-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815213309.2847711-5-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Aug 2021 17:33:08 -0400, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Update bindings to describe support for buffered and unbuffered external
> voltage references selection, and add adi,internal-ref-microvolt for
> internal voltage reference selection.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../bindings/iio/adc/adi,ad7949.yaml          | 51 +++++++++++++++++--
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
