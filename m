Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63FB2A4AC4
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 17:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgKCQIC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 11:08:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41129 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCQIC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 11:08:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id m13so9798157oih.8;
        Tue, 03 Nov 2020 08:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LppOrRjoS2ltemazd7R9I3bmJ/2o8r3uS4AEkLPs4Jw=;
        b=TnUu0OnEtR/V7F5rGA8p5rVeq808fox3vqcUgu1e6+E5FdfZlDdRPosUokuoRNKrY8
         U2PWk3+iTjhuOJ8GsVMY4eNnemVdVKowMua/bMhC2lsjmGpm26UWMBZaT3GRWjt756ei
         1epXhq2yxX1OPiOUB1F8a46tQ6uU7PND/64JlQl1ilowxUjorosLs4vh1ueU0R4YrAkL
         cckiAnQRqAj49VNwlf4QNkVSzovI7s21Dova8qKFBpEoSWP7Gi7Rj5tFL6QE+kUYpf63
         yq6XPzY5zilF/R9kYxY+QhSJKlMe+pIYahvr+T8ufHdnsHRUiPVp6EPaw1nnRJYJR7OT
         Owig==
X-Gm-Message-State: AOAM5324Wb4segHD5dOoULBQDksJzbV3GKPiShvS+X5NuMezQXXX7N0H
        ruIXmeO1Frn/lOtTRUvLRg==
X-Google-Smtp-Source: ABdhPJxJEBnN98SZvRMckcmmoNzrl9tAOxO+q7ulEbu52U5AXSAtCqqgXDvRNFUqVvLAnn1fHYkLCw==
X-Received: by 2002:aca:aac8:: with SMTP id t191mr234134oie.119.1604419680082;
        Tue, 03 Nov 2020 08:08:00 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n18sm4495788otk.33.2020.11.03.08.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:07:58 -0800 (PST)
Received: (nullmailer pid 1754319 invoked by uid 1000);
        Tue, 03 Nov 2020 16:07:56 -0000
Date:   Tue, 3 Nov 2020 10:07:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/10] dt-bindings: iio: conversion of consumer drivers
Message-ID: <20201103160756.GB1732900@bogus>
References: <20201031181242.742301-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031181242.742301-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:12:32PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Firstly drop the old text file as the consumer binding (and the other
> parts of that file) are under review for inclusion in the dt-schema external
> repo.
> 
> This only converts consumers that happen to also be IIO drivers.
> Others may get done as part of SoC binding conversions or I may do a lot
> of them at somepoint.
> 
> A few of the examples in existing text files used providers that were
> documented in trivial-bindings.yaml which does not allow for
> #io-channel-cells. I have pulled those out to their own files as part
> of this patch set.
> 
> The iio-mux binding is not done as that has some dependencies and will
> form part of some future patch set.
> 
> There is no explicit dependency in here on any other sets, but some
> noise will occur in trivial-bindings.yaml if applied in a different
> order to I happen to have them sets locally.
> 
> Jonathan Cameron (10):
>   dt-bindings:iio:iio-binding.txt Drop file as content now in dt-schema
>   dt-bindings:iio:dac:dpot-dac: yaml conversion.
>   dt-bindings:iio:potentiometer: give microchip,mcp4531 its own binding
>   dt-bindings:iio:adc:envelope-detector: txt to yaml conversion.
>   dt-bindings:iio:afe:current-sense-amplifier: txt to yaml conversion.
>   dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion. 
>   dt-bindings:iio:adc:maxim,max1027: Pull out to separate binding doc.
>   dt-bindings:iio:afe:voltage-divider: txt to yaml conversion
>   dt-bindings:iio:light:capella,cm3605: txt to yaml conversion.
>   dt-bindings:iio:potentiostat:ti,lmp91000: txt to yaml conversion.

With the type references for properties with standard units dropped,

Reviewed-by: Rob Herring <robh@kernel.org>
