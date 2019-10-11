Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A367D444A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfJKPbR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 11:31:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36653 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJKPbR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 11:31:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id k20so8341927oih.3;
        Fri, 11 Oct 2019 08:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lZBxUgx9Vl2v4FPUyNZy1vxnwneedhV9vcSMUHf/Uks=;
        b=I3UWvZAgzFnKeXSccG/lMgWLz6PFCy4nk2tmY7PL6Pbk6/fReg2A5jGa0MfAlB0qWN
         Z/zSjV3/2n3SY5O7U6GrAHJAuAz0VwoxcAX3Xq4wgQepqnT++FO5wKsuI7e4G5W2dhhh
         ExjRtrJt2DP80OL9C5L64xPRP2hWQ37eJIT1h+R2nGCsyTKH0l7U+mc/TGU0Xzudvm6m
         o5OEH5vaUecOrxr3DeuCfxzmY8z2LaN4LzYUvgFxshJ3nHkcWdA6Vf3qHu+UEGrgnIsk
         W24k/cj2892jneIHHggU+vMy/XMRo/KVOFsg726lZpvtozO65E8FePCIaT5BM1rErIym
         F0tg==
X-Gm-Message-State: APjAAAWvYO8ObGFEx3+kQjMbZoj7Et0TJos1ejae1uehsuuv3SDOxGIz
        ZheFdTuPy718QJeY8Kp2aQ==
X-Google-Smtp-Source: APXvYqzMBwoebZPW21tZSXxF+eFrIe/IalA9934WUv0jd+BqnLTSpIqETXg/pzIyOuxUT6FoQ8E53g==
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr13082342oia.138.1570807875938;
        Fri, 11 Oct 2019 08:31:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 34sm2773765otf.55.2019.10.11.08.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:31:15 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:31:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     ars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        alexandru.Ardelean@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Message-ID: <20191011153114.GA12208@bogus>
References: <20191007153917.13611-1-manivannan.sadhasivam@linaro.org>
 <20191007153917.13611-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007153917.13611-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Oct 2019 21:09:16 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Analog Devices ADUX1020 Photometric
> sensor.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/iio/light/adux1020.yaml          | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/adux1020.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
