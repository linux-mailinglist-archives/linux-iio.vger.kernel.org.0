Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD626AD42
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgIOTNf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:13:35 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36293 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgIOTBY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:01:24 -0400
Received: by mail-il1-f194.google.com with SMTP id t12so4064818ilh.3;
        Tue, 15 Sep 2020 12:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jus/icKjw9wFBDH6DE1vRQKLo0IQYaQTDwonrJpM30M=;
        b=lhWWTOrFh7Pna6XjDH+rqRllfe/EbLbVVaCct1AhROgvVWCc3IwECZLC9RFCy3q1Ex
         4/EK+7rzHRsPGs316dp0zytkwJ6T0lr5PzVaxdeyuBSmNGB5bVStQW94s91ZVuqZTU41
         kNhzEFBOeE5b2KMcOJBt3xc0AH0o4jdynM2r1Qg+NWqm/Fc5H1NlKC8+blaeEdUsy8sm
         9BMUil8T+36UfwATLsHgfc8tliLlxot/jA5KF8GJPyOxbtRICod9RdO5bJTY1UDj9mDX
         8I7XnQyekpYEfNNqX8ak1Q2gW1gNn8AKYP7Oksb+dP00Vg1YVqCD4DvORCXb0os+grbZ
         w6RA==
X-Gm-Message-State: AOAM530hx14y2ZVxz5nFOcNbAq2pWahpHY9qbdKL7gJ2MgGjwCQ4Uc7q
        9Qnbdw25puTCKJhzMB7Xzw==
X-Google-Smtp-Source: ABdhPJwhs+xjaQhV2ANCPcFJdIj90WNqZiJRurFaMCt095j18X0FUJ5b2yd0vnXsQDXzwYsaHpidfA==
X-Received: by 2002:a92:60b:: with SMTP id x11mr16698286ilg.179.1600196470130;
        Tue, 15 Sep 2020 12:01:10 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m7sm9508054ili.26.2020.09.15.12.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:01:09 -0700 (PDT)
Received: (nullmailer pid 2313337 invoked by uid 1000);
        Tue, 15 Sep 2020 19:01:08 -0000
Date:   Tue, 15 Sep 2020 13:01:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 02/20] dt-bindings:iio:adc:ti,twl4030-madc yaml
 conversion
Message-ID: <20200915190108.GA2313284@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-3-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:28 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Conversion from txt to yaml as part of a general move of IIO bindings
> to the new format.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../bindings/iio/adc/ti,twl4030-madc.yaml     | 48 +++++++++++++++++++
>  .../bindings/iio/adc/twl4030-madc.txt         | 24 ----------
>  2 files changed, 48 insertions(+), 24 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
