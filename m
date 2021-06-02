Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37C039952D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 23:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFBVGe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 17:06:34 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36463 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFBVGe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 17:06:34 -0400
Received: by mail-ot1-f54.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so3753513otl.3;
        Wed, 02 Jun 2021 14:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xAwzBxtQTrOqLv+2WBqI2b5XM27v8MHwB+MvKVWKET4=;
        b=YZ7zcEfot4JIwuaJOnDJA8ox4l+HtBH7O5ogCeG2yR/GBLc7CTwNNP/0+4BT8Ygo0c
         28GgHx89x8FppeDwoxBmO8RtxECR6jZFZEknfO1/QqvEsKGDWvaIDJp7E8LTRjvoZD/n
         MTZqfj/y6ye2c3tdW00aqoMoAh8Qk5poERAtqOpMz6u02KunTirR48gt+eHo6s6BiFhT
         t96bfXnE/uUKPU5xsQd1TNEOrfXLJd4KEcrHUavTSNmKbd22GklcqGH95sjfXdC9+znD
         tGy9aybds0Pu69ec+44dQ/M53xr8y9o6NHMgvXjIw8sy81wwjJvSMT8N23ZDxhUntD8+
         ueXg==
X-Gm-Message-State: AOAM531fDEp7rKV64lUEYlmMQUYZdbiHRoeV2ilUXymRctRLMLmGZAXZ
        xDttvL8LD5j4Z/PyD/J+Vk1zFdck3Q==
X-Google-Smtp-Source: ABdhPJxyCi29NpDw4UBMNf7/x2arc26qns1BXNlRTTrJ0SKUOzkD/d45d99TWolrPLPxYB2zjwjyDA==
X-Received: by 2002:a9d:18e:: with SMTP id e14mr8406853ote.34.1622667878147;
        Wed, 02 Jun 2021 14:04:38 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d19sm213492oop.26.2021.06.02.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 14:04:37 -0700 (PDT)
Received: (nullmailer pid 4040019 invoked by uid 1000);
        Wed, 02 Jun 2021 21:04:36 -0000
Date:   Wed, 2 Jun 2021 16:04:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 06/12] dt-bindings: iio: io-channel-mux.yaml: fix a typo
Message-ID: <20210602210436.GA4039908@robh.at.kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
 <ab0d1f89cf64ff4904155c92e1895763fb0bf173.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0d1f89cf64ff4904155c92e1895763fb0bf173.1622648507.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 02 Jun 2021 17:43:12 +0200, Mauro Carvalho Chehab wrote:
> The file name: Documentation/device-tree/bindings/mux/mux-controller.yaml
> should be, instead: Documentation/devicetree/bindings/mux/mux-controller.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: a66cec598f49 ("dt-bindings: iio: multiplexer: Convert io-channel-mux bindings to DT schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
