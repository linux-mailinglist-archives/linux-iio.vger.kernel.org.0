Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940C326AD77
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgIOTYc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:24:32 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44933 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgIOTYX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:24:23 -0400
Received: by mail-il1-f193.google.com with SMTP id h11so4077267ilj.11;
        Tue, 15 Sep 2020 12:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AdYq3ZYzJCD0ilwZtMULOgtlKuJSOlppJPNgt0D2goY=;
        b=Qj21dhJ1li8cI892NuXRo4nrtbvA3jhaIbhJE3Jl7MQpv1ZSpuuUpCYi5WlhuOGckt
         TUh15XBzKcX+30NOb1ny8Y7QYYISr2COhlaS/gQhr+BRSv8BaADr9PVlYdSpVnzZp14r
         dzIFcDF+P1ggA/rN4I7Fxat9bfupG60v68LCJ2CGEnok5ac0QHQmdYsAElTAa1Kephwo
         zjSJ7suMUsuQh+zK3xY3duJn5xv2kDxu8wd5rkF5LR8JYT/RR7zPHRiAgozOtGCiSffO
         Ptl/hPqYgvNpMIOQQ5DdU1Pzcw9K5Oa2PgjeCxwrPNWhi9hctQTx5s39OaRB29XDcgtd
         27cw==
X-Gm-Message-State: AOAM530KbtjmDH1W7l2NevZPRcKE1OJq6ySL1/M4HTxGDi0QJvB3ygBt
        YN1J29ohSgEu7VsXWxmo/16fjQkrFmulZVc=
X-Google-Smtp-Source: ABdhPJxBwQCHXIHegZMf7AGBUr5yTHpNciDsvUtAKovuJA4NdQF/3f1G+U2K+WJ4vJ/ELguIJHrp6w==
X-Received: by 2002:a92:9a92:: with SMTP id c18mr18391631ill.265.1600197861506;
        Tue, 15 Sep 2020 12:24:21 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w22sm8014123iob.32.2020.09.15.12.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:24:20 -0700 (PDT)
Received: (nullmailer pid 2351523 invoked by uid 1000);
        Tue, 15 Sep 2020 19:24:18 -0000
Date:   Tue, 15 Sep 2020 13:24:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Haibo Chen <haibo.chen@freescale.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 19/20] dt-bindings:iio:adc:fsl,imx7d-adc yaml
 conversion
Message-ID: <20200915192418.GA2351467@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-20-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-20-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:45 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A nice simple binding.  Only real different from txt is that I dropped
> some descriptions where the naming of the parameter was self explanatory
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Haibo Chen <haibo.chen@freescale.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/iio/adc/fsl,imx7d-adc.yaml       | 62 +++++++++++++++++++
>  .../devicetree/bindings/iio/adc/imx7d-adc.txt | 24 -------
>  2 files changed, 62 insertions(+), 24 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
