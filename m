Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1996E26ACD7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgIOTAd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:00:33 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35153 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgIOTAW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:00:22 -0400
Received: by mail-io1-f67.google.com with SMTP id r9so5344323ioa.2;
        Tue, 15 Sep 2020 12:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xwoaUlq5NpEGvhJdzwFyRJKq3+Cx8o1N40O4sESvSfs=;
        b=VMkP7EUUuehoOngAxS3sK9HCrapgM5bvnF55MNBg8tLTgTCqdWDP1jwN1q5/gJCVcw
         2QZ/kCtCqQXr0Jeaxr//Hc7PZl7hkD3JVdI4gBys/UvIFUkEQvrkDH+d30fvIb92w6Te
         s014WVeg9qe111gZQz+vT6kbXVZO6p0+KkFSuNFZlIIs4Kp7zjD2S2rMZ7ycQ08ZFejT
         ByPnPmXKR5ZY5fg3QgV2U2lenYSbg/fuLdZnpPAnYHQjkJcYrt5vyLl7ECyZWiTxprbC
         ZcJwTc2nMjyvJxb0l2PPjWM0Qd6nwPJEiIBjV56F1G60ajwZqFayvfAzL0LRfcPhqYur
         WRkg==
X-Gm-Message-State: AOAM532fnRrMVmnbL48M2rHjYUUSZHUJREZMDcPmKoXB8PoLX8Fa3dRN
        HOW/RATbAp3BDaRa7ic6pg==
X-Google-Smtp-Source: ABdhPJx9hRnwyKNaVO8i3jU86RCRrRRV80SoSLjaI0RCLdJazgu5srQFmm2mu98FUim5XSBDArR8KQ==
X-Received: by 2002:a6b:197:: with SMTP id 145mr16158129iob.100.1600196421633;
        Tue, 15 Sep 2020 12:00:21 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w22sm7986353iob.32.2020.09.15.12.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:00:21 -0700 (PDT)
Received: (nullmailer pid 2311911 invoked by uid 1000);
        Tue, 15 Sep 2020 19:00:18 -0000
Date:   Tue, 15 Sep 2020 13:00:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fugang Duan <B38611@freescale.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 01/20] dt-bindings:iio:adc:fsl,vf610-adc conversion to
 yaml.
Message-ID: <20200915190018.GA2311858@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-2-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:27 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A simple conversion of this freescale ADC binding from txt to yaml.
> For maintainer I went with Fugang Duan as the original author of the
> binding. Would be great to have confirmation of this.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fugang Duan <B38611@freescale.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/iio/adc/fsl,vf610-adc.yaml       | 81 +++++++++++++++++++
>  .../devicetree/bindings/iio/adc/vf610-adc.txt | 36 ---------
>  2 files changed, 81 insertions(+), 36 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
