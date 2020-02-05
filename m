Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F08153565
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 17:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgBEQkc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 11:40:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35098 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgBEQkb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 11:40:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so3628616wmb.0;
        Wed, 05 Feb 2020 08:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GSqOR+b9+qgYkv927sptBAo+A2nCBslN9AmwBEzBV24=;
        b=XAv5+8ez7KRPKbYsTPawwPJqL2ZSW8Fd/XGBoGUwS8pu//Mc6dEls6ub/FfsxwzLXD
         82bMQm5uRy5TDVx1ZpAkvZ+vkshEnjN7/6/NucTLAmeJxK3itCG+vaYxWPYNuRAfVH7L
         UyNMVDY8lYZd6Cpk+Jccm3qfDUEBkU8Z5TBcWmZmnU2F87+PQubnJxciRWO1BX2ArPV/
         XK37cAcAHYOolo0wqSs2K5NKcc0FlMHF/TY5Y/OIODwl6rKH5zaSgRsoplTEtzNHZU3X
         Z3n3sLQalsr1XBr90RpfhOwHhg4wyDWVeNxPS2TE9PDkwcGITtjPfD6bEBzrq2/V0/a1
         Fvxg==
X-Gm-Message-State: APjAAAWe8ZhxmbyHGxXLai6O4AaNNr7QecH+pkyPc919McdixEG8oAl5
        OsMek2PYvsKoEMF8aYClYK4Jl9q/TA==
X-Google-Smtp-Source: APXvYqyVdOSU70QWkKUKrn8V2QEspyC8xmP0GeGCxBtOLydvH4jQZiOte8u8+TKHEQEGsF2romS2Sw==
X-Received: by 2002:a7b:c3c9:: with SMTP id t9mr6460366wmj.18.1580920829223;
        Wed, 05 Feb 2020 08:40:29 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id y139sm150969wmd.24.2020.02.05.08.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:40:28 -0800 (PST)
Received: (nullmailer pid 3192 invoked by uid 1000);
        Wed, 05 Feb 2020 16:40:27 -0000
Date:   Wed, 5 Feb 2020 16:40:27 +0000
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: chemical: consolidate
 atlas-sensor docs
Message-ID: <20200205164027.GA1992@bogus>
References: <20200205090421.18339-1-matt.ranostay@konsulko.com>
 <20200205090421.18339-4-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205090421.18339-4-matt.ranostay@konsulko.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  5 Feb 2020 11:04:21 +0200, Matt Ranostay wrote:
> Since Atlas Scientific device support only varies from the compatible
> string is ideal all the respective docs are merged into a single doc
> named atlas,sensor.yaml
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 --------
>  .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 --------
>  .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 --------
>  .../bindings/iio/chemical/atlas,sensor.yaml   | 53 +++++++++++++++++++
>  4 files changed, 53 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml: ignoring, error in schema: $id
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml: $id: 'http://devicetree.org/schemas/iio/chemical/atlas,sensor.yaml##' is not a 'uri-reference'
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/iio/chemical/atlas,sensor.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/iio/chemical/atlas,sensor.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1233724
Please check and re-submit.
