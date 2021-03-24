Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE49347F08
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 18:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhCXRN7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 13:13:59 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:43946 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbhCXRNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 13:13:51 -0400
Received: by mail-il1-f171.google.com with SMTP id d2so22040654ilm.10;
        Wed, 24 Mar 2021 10:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/317AgX3s99KFrkx7VorpzhdeLK4kgmrKfsU5wf4js8=;
        b=qwiF6qZ4/K2cnTXyU/rp5uwmODdPtJAoPflf8+1b32VJgX2D+nFED7dBFn7DK1P6dB
         /zQ0hIqaNKWrK3UyxB1hYPAkWXY9oN1xXyyoREEG73cO1ws3JvIybpGLY1+mE5Z5HqYW
         5WQD3/b7mdgWCWFiLaFK7VgBFyUJyKCNIVOQYkrR+waQvyxtu3rrfolUUrP85oD6tg+e
         kxF/FPk+k3AuEsH69+VNyU6qAMg1AoxxiUB6LAaemKikKxONTA4Ec77UTZcBi7HJt90D
         p+3QbFVoP6ASnL9U2Ou398RT0PBFr4a8L2+v/somQTg2k3PWuSx+jCA9FE1b9EFgSNYx
         ybFg==
X-Gm-Message-State: AOAM532AEqRTj+gUD7clot2jZOL9cHoZFgM9I5VYkuxmWTVLuy0byVMP
        EzW0aoYQuvmAkfco2M+crQ==
X-Google-Smtp-Source: ABdhPJwEjumbwytU+/AtAqPrLFwDlEAjXdmLZVxZGKHBahiSjMnR8NFDw+bfXcaMS8KLfuZe9rry2A==
X-Received: by 2002:a92:c702:: with SMTP id a2mr3504492ilp.219.1616606030906;
        Wed, 24 Mar 2021 10:13:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z17sm1370166ilz.58.2021.03.24.10.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:13:50 -0700 (PDT)
Received: (nullmailer pid 3266595 invoked by uid 1000);
        Wed, 24 Mar 2021 17:13:48 -0000
Date:   Wed, 24 Mar 2021 11:13:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Robh+dt@kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 23/24] dt-bindings:iio:cdc:adi,ad7150 binding doc
Message-ID: <20210324171348.GA3266557@robh.at.kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
 <20210314181511.531414-24-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314181511.531414-24-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 14 Mar 2021 18:15:10 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Binding covering the ad7150, ad7151 and ad7156 capacitance to digital
> convertors.  The only difference between these is how many channels they
> have (1 or 2)
> 
> Whilst it is clearly necessary to provide power to the part, we don't
> need to know the voltage or anything so if it is always on, there should
> be no need to have it specified in the binding.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Robh+dt@kernel.org
> Cc: devicetree@vger.kernel.org
> Link: https://lore.kernel.org/r/20210207154623.433442-22-jic23@kernel.org
> ---
>  .../bindings/iio/cdc/adi,ad7150.yaml          | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
