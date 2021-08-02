Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E47F3DE19B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 23:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhHBV0z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 17:26:55 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:38572 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhHBV0z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 17:26:55 -0400
Received: by mail-il1-f172.google.com with SMTP id h18so17764712ilc.5;
        Mon, 02 Aug 2021 14:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Szk4wIhknQuUacA+Q1dPMQsx0YA8Mud6H8BQF9JSdFg=;
        b=M8LBYUCiGlb3ShnTRF8cV/BWvLAIeFAGeAbxKbqy6nv0+0e/9vJ8DSYMxIPMhR9rZ1
         svjt8S4EJjCwLpM2XM0qgBx23JwU3Ft0HAM0YXXYMUP0HKLT7E39rDgyM73wW73PY4L8
         spqR4QAzBA/ybkMf3e+uvCf/xqi4fJBV+ZIHznuJaaj1jr2QHkxd08R2eW3G0zv26PJg
         +SVcgDKIVxnCQwLaU7cgfj5NfF3WN4esstDs4R7l0daXeJ8KmbCxA5H7Lv20ysahG+4I
         0GaMO6KjvUvHiGsUIw4FR1CfzYAo+EvA1mj0lkEP2YjhctLY22rSV3M+9LWAaZfbEbA7
         AMTg==
X-Gm-Message-State: AOAM532fnhXpm4C9J79ZdIWjbELQw7e1NoGS3L77VEjC19YztZZaR+QS
        y79OSiYBxZjdGkXuAx59Vw==
X-Google-Smtp-Source: ABdhPJy20gVpw6QtakQT+Lh0Ki5QXcX31HbCjTyBfXP9bahiUXiLAhUpiRil7DbxzGI/iiOs3l2XBA==
X-Received: by 2002:a05:6e02:1aa2:: with SMTP id l2mr27445ilv.224.1627939604911;
        Mon, 02 Aug 2021 14:26:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a17sm8291582ios.36.2021.08.02.14.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:26:44 -0700 (PDT)
Received: (nullmailer pid 1642364 invoked by uid 1000);
        Mon, 02 Aug 2021 21:26:43 -0000
Date:   Mon, 2 Aug 2021 15:26:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, Nuno.Sa@analog.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        charles-antoine.couret@essensium.com
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: adc: ad7949: add per channel
 reference
Message-ID: <YQhjE27mKQkQL1pr@robh.at.kernel.org>
References: <20210727232906.980769-1-liambeguin@gmail.com>
 <20210727232906.980769-5-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727232906.980769-5-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Jul 2021 19:29:05 -0400, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Add bindings documentation describing per channel reference voltage
> selection.
> This adds the adi,internal-ref-microvolt property, and child nodes for
> each channel. This is required to properly configure the ADC sample
> request based on which reference source should be used for the
> calculation.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../bindings/iio/adc/adi,ad7949.yaml          | 69 +++++++++++++++++--
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
