Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1F375598
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhEFO0f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 10:26:35 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:40458 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhEFO0e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 10:26:34 -0400
Received: by mail-ot1-f51.google.com with SMTP id c28-20020a9d615c0000b02902dde7c8833eso55778otk.7;
        Thu, 06 May 2021 07:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NO5xlMoNjYCr6KREf7vnuwTavEBKSBCosskSU2E1U4A=;
        b=BS+RpSKSesKEVKCmf8VX0CEW0UDDsroiBo+Px1rFTDjz6jejx9BYDR3dIPHH6hAtwZ
         AFCquvzJI4Yf9DircaRXDJtp4m2W6YwPPspnO4CGZg9QeREjrczmjmv0ZCjTXN/g2tMF
         Dk3E/LNq7GfH7zXNPi5dExHXH6vfQudBfuFjH65RcmKzuTYTAicV15+TzMHoM9cXDdyc
         smNfnNP5JYlnuhiXnVtWaYILQrGq2tPQx9lhmXYW2JpZ3eUiM52SX3VrrQ4sF21azNA3
         MxqYxMrF7DWPUxvbBzsfZBBC30g5wKY+KGTfCzJyNUlESndXN4M/TZLYKyp4c1pxFvx1
         XptA==
X-Gm-Message-State: AOAM533XOlLcVNf8JAa2SciESFudJulwkl1EcTuPle4DxA789vSXQhuA
        05P8trV6MBgUmkqNlaLmTg==
X-Google-Smtp-Source: ABdhPJw4F88w3A2wOguIyMIrYqJqK/2fOGIqigAkknVGyAjqgSNQEKVRVS8ziJsZawxLOzJU2MaRAg==
X-Received: by 2002:a05:6830:2159:: with SMTP id r25mr3846804otd.313.1620311136040;
        Thu, 06 May 2021 07:25:36 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m25sm443067oih.15.2021.05.06.07.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:25:35 -0700 (PDT)
Received: (nullmailer pid 277878 invoked by uid 1000);
        Thu, 06 May 2021 14:25:34 -0000
Date:   Thu, 6 May 2021 09:25:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     linux-staging@lists.linux.dev, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        Michael.Hennerich@analog.com, jic23@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: staging: iio: cdc: ad7746: add
 binding documentation for AD7746
Message-ID: <20210506142534.GA277826@robh.at.kernel.org>
References: <cover.1619841953.git.lucas.p.stankus@gmail.com>
 <2c2f4d486a94e0740e112bfac0d9306bdb7ea69c.1619841953.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c2f4d486a94e0740e112bfac0d9306bdb7ea69c.1619841953.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 01 May 2021 09:32:31 -0300, Lucas Stankus wrote:
> Add device tree binding documentation for AD7746 cdc in YAML format.
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> ---
>  .../bindings/iio/cdc/adi,ad7746.yaml          | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
