Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7481D9E03
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 19:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgESRhm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 13:37:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34023 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESRhm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 13:37:42 -0400
Received: by mail-io1-f66.google.com with SMTP id f3so63923ioj.1;
        Tue, 19 May 2020 10:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PzvrAlMTo3QjrszDPhpWXPfC5/eKge0TGeIBkPLaXP8=;
        b=lS+r7O+E0qg0Rd3qnBsa4U7/i54p2SRYNbjcSMPSRSU4iu4VRYvrxt3YLSabBbK+WQ
         TD77uec8RYyL7P0C5mFRt1aszleCQE1vioTJ3J0Y7Yt4+LGoSiU7XhXqAbXn0mMxjr+J
         zjrvGDnki5bAmpwSMAJBpCEU1vL5dEp95yqR3fslRPtSQ/Ru+LQjh0fsaR6She0vHIwN
         jMj74Q9pWjmaIpbDDbRKMOD+V8fRSZ4ffsHs6lLrcdZQjXnXb3iN4xFIlpGPRHBLn28p
         oessbRjPnok+glSnqvpVMrNijoE5MXsUrZsp1qKc5hy85BDObxwCfVPmIkQkgH51beO+
         /ATQ==
X-Gm-Message-State: AOAM532H0siypnrnq7HvnkBON8VIzpWUuR9AcsGDdaGoV6NeKHnf+rwd
        Hl1KD9GhL6dgDdzc60uRKg==
X-Google-Smtp-Source: ABdhPJz58zqeZlv/dD+ROsNtuxzjCBnL3izOh+epsxfI28X04sumVUJ16GKDoaGt4Y3OAF9rK9Gkog==
X-Received: by 2002:a02:a1c8:: with SMTP id o8mr841870jah.38.1589909860215;
        Tue, 19 May 2020 10:37:40 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b1sm111766ioe.46.2020.05.19.10.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 10:37:39 -0700 (PDT)
Received: (nullmailer pid 342793 invoked by uid 1000);
        Tue, 19 May 2020 17:37:38 -0000
Date:   Tue, 19 May 2020 11:37:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt format
 to yaml
Message-ID: <20200519173738.GA342367@bogus>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-2-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519075111.6356-2-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 May 2020 09:50:57 +0200, Jonathan Albrieux wrote:
> Converts documentation from txt format to yaml
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
>  .../devicetree/bindings/iio/imu/bmi160.yaml   | 84 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/iio/imu/bmi160.example.dts:37.1-2 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:312: recipe for target 'Documentation/devicetree/bindings/iio/imu/bmi160.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/iio/imu/bmi160.example.dt.yaml] Error 1
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1293085

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

