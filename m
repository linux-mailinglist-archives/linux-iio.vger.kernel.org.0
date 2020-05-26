Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289E91E3142
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 23:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbgEZVeP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 17:34:15 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34279 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388740AbgEZVeO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 17:34:14 -0400
Received: by mail-il1-f195.google.com with SMTP id v11so4646801ilh.1;
        Tue, 26 May 2020 14:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4IGWiIO9QQ2uNyibpst11tBp9IaLJjLxoCP1PUreahE=;
        b=bU9OOAGwtBkzAL6bMdPibQQ6XwHLD8f9CfM+kWto3+m1XS4PcQNdhbxctUlO4ovO/D
         Sb8wXqCJU/Q4pvIgMM0REiUCDpMSpGsXoSvRPIHECFU42Fu/eT95GqvBfmrihUhhJ46Q
         OgDELuKgACjo6NN9g97cn9yTEJwpcZhr4IdRfINFt5yvdlBx71y0T0T8o8fuzNSGQJHP
         p8/ZuO9sMTXOOVbxZoxNflwiUsD0WPqciF3A0uuhcLK6n1nDO4bqZiZ3mItpaMPktB3C
         aOGLzK2k+bhBY2GNuPCK7VVa+Zb9hTTKIGM6+G8xftv0YNuREJ7WwUQLSP+IoEIuN2s0
         1QrQ==
X-Gm-Message-State: AOAM532JOGkhVoWM3jNmmDGtGI+6U6jOMcJ7W1Hn4AGPBtc4TDBY/kXA
        cJo4ShMp+P3E2YqrFIJZ+w==
X-Google-Smtp-Source: ABdhPJzp0EwE7XGT6pdGkzbmHIL2nvEZ3e4SrIoV0m8LDZZ/TRFJq39YHaGw2aIXJtWbDhLLb2+Z1g==
X-Received: by 2002:a05:6e02:1072:: with SMTP id q18mr3065200ilj.121.1590528853402;
        Tue, 26 May 2020 14:34:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h10sm417843ioe.3.2020.05.26.14.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:34:12 -0700 (PDT)
Received: (nullmailer pid 415156 invoked by uid 1000);
        Tue, 26 May 2020 21:34:11 -0000
Date:   Tue, 26 May 2020 15:34:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7 1/7] dt-bindings: iio/adc: Convert ingenic-adc docs to
 YAML.
Message-ID: <20200526213411.GA414898@bogus>
References: <20200517194904.34758-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517194904.34758-1-contact@artur-rojek.eu>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 May 2020 21:48:58 +0200, Artur Rojek wrote:
> Convert the textual documentation of Device Tree bindings for the
> Ingenic JZ47xx SoCs ADC controller to YAML.
> 
> The `interrupts` property is now explicitly listed and marked as
> required. While missing from the previous textual documentation, this
> property has been used with all the boards which probe this driver.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
>  Changes:
> 
>  v6: new patch
> 
>  v7: - specify `maxItems: 1` for single entry properties
>      - get rid of redundant descriptions of said properties
> 
>  .../bindings/iio/adc/ingenic,adc.txt          | 49 -------------
>  .../bindings/iio/adc/ingenic,adc.yaml         | 71 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
