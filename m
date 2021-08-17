Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416F83EF4D8
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhHQVXX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 17:23:23 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43910 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhHQVXW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 17:23:22 -0400
Received: by mail-ot1-f45.google.com with SMTP id x10-20020a056830408a00b004f26cead745so108838ott.10;
        Tue, 17 Aug 2021 14:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RxfsUNxQuHFeeinSXfwnppOEjR6lGfxHD88QKCCSZ40=;
        b=ZyRV22PkX7qVooZv3DSpszE8wx+3gyeP7HU9CFcAP0lCjKHD5gd5/knPBFvsS973uK
         HQmOOVKh2Cq7Y/zuAI1qIqnusi93HxYDEi31xZS9vpqGSC8sP2y+t+rMUWGNZldAzabR
         KUUgmvo2bsYUMG748iB8gXzEo4hexXrTXcU2quP/UD98j8XXZfbjxubkNNkg+huk2Oan
         uujzgRYlPcydRt/4D2IbsuGe7q/UKUKTW6tHksZeScBLR7hhx18ahuyI3jzcPSaHv1Eb
         0ixCF/YADDOCv+SZOznSwRU144c9Rz0ueCzrDOOoYY1xLZR9hJqIK0PuM8S36F21yXBH
         AH1w==
X-Gm-Message-State: AOAM53309f+ig9LL8E9FqOnFkeLWgTu6lJp4H7lZkHY0YBMnz5M48EPz
        HyaD3EOgFh0ySGNXX295yA==
X-Google-Smtp-Source: ABdhPJwZ1XEH427kTOCof94GE7pPcfSIOvX5lcwYwNfkKoDKIPvm6zfYAh2JbL+pudnaUVZ34mRucQ==
X-Received: by 2002:a9d:222:: with SMTP id 31mr4286176otb.79.1629235368840;
        Tue, 17 Aug 2021 14:22:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j125sm747897oif.53.2021.08.17.14.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:22:48 -0700 (PDT)
Received: (nullmailer pid 863469 invoked by uid 1000);
        Tue, 17 Aug 2021 21:22:47 -0000
Date:   Tue, 17 Aug 2021 16:22:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        devicetree@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: accel: Add binding
 documentation for ADXL313
Message-ID: <YRwop9HL/moXSdsa@robh.at.kernel.org>
References: <cover.1628713039.git.lucas.p.stankus@gmail.com>
 <1b468b9d4b22f2715ff7e8de868614e533cf1f2a.1628713039.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b468b9d4b22f2715ff7e8de868614e533cf1f2a.1628713039.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Aug 2021 18:17:07 -0300, Lucas Stankus wrote:
> Add device tree binding documentation for ADXL313 3-axis accelerometer.
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> ---
>  .../bindings/iio/accel/adi,adxl313.yaml       | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
