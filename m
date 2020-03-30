Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0478A1987A8
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 00:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgC3W7h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 18:59:37 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43837 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3W7h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 18:59:37 -0400
Received: by mail-il1-f194.google.com with SMTP id g15so17580536ilj.10;
        Mon, 30 Mar 2020 15:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kaww/X906RvhEBeXpHvQ7H0BgU+ZNwj0MfgsRF9EmPo=;
        b=aphs+ArrWHW4zJbhnSXSazwL6dS5FZ3ssBhqJSB1LwH+guwse+z+jkPX2h5E4ixLkf
         nkY8ZvTvZeO9655qTtUE9Kf+7vs0KjkbGxVcwZ8y5xCGADPMPaspqbfhln7xaarZeYJx
         tROdErPVaX2EYhNIAf71der9v5YWCjzzMXTFw1m+z7ss03cGq53mx0XPS4RqNFkk/jHD
         OzCNsjD8ewKXFy+8VgBsIFiQnpq5YScWi1gIJ0GRstYEDTi3r/kC2nBUjwJf+bD8W9tW
         lLYoN9E2OTLJflWVJiQnIcm1a8cv/IONo2CxTH0vGp6h2ZbQhMYatZqRbfJ4wMtCbE7L
         Wliw==
X-Gm-Message-State: ANhLgQ3l6x4w8C31REgRupW7K8VdiOnbuFhEboDY6ZSAPp3ECvQma+J5
        LXj8gnpQ2ZxqoQ5lyvIO9g==
X-Google-Smtp-Source: ADFU+vu/V8SE4+GhvyNKh8/DXvbO0KPS1E8HxLuvvNK9BpS6lC2+zQOjy4fxqTBKuoq0LwxVH3IPEw==
X-Received: by 2002:a92:dcc8:: with SMTP id b8mr13269509ilr.244.1585609176223;
        Mon, 30 Mar 2020 15:59:36 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r29sm5358442ilk.76.2020.03.30.15.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:59:35 -0700 (PDT)
Received: (nullmailer pid 19335 invoked by uid 1000);
        Mon, 30 Mar 2020 22:59:34 -0000
Date:   Mon, 30 Mar 2020 16:59:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: iio: tsl2563: convert bindings to YAML
Message-ID: <20200330225934.GA19255@bogus>
References: <20200318071940.12220-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318071940.12220-1-nish.malpani25@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Mar 2020 12:49:40 +0530, Nishant Malpani wrote:
> Convert the TSL2563 device tree bindings to the new YAML format.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> ---
> 
> Changes in v4:
>   - Change $id property to reflect corrected relative path.
> 
> Changes in v3:
>   - Include the complete diff (changes from v1).
> 
> Changes in v2:
>   - Rename the dt-bindings to include manufacturer's name.
>   - Synchronize the bindings with the driver.
> ---
>  .../bindings/iio/light/amstaos,tsl2563.yaml   | 49 +++++++++++++++++++
>  .../devicetree/bindings/iio/light/tsl2563.txt | 19 -------
>  2 files changed, 49 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
