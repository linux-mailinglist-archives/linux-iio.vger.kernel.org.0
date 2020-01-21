Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339E1144811
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2020 00:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgAUXNM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jan 2020 18:13:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35849 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXNM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jan 2020 18:13:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id m2so4624091otq.3;
        Tue, 21 Jan 2020 15:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ooI0TC2R0RPnixxhz1OoqRc6n/Cpz0oN4+WUYyVQIJQ=;
        b=CGba/AGft6uyQb4xAt8nAoEH2ZFMFcztqdYDKFdVInE4HS3SBC4PrhwlNN8Zp6ADx6
         hPNWlAd8NpxW6te0TP/516LVo+3UHXGBQ5J73qN+eh5OqRo4NHGl7mpfHzZEWGXcR/3i
         gZ90CqxOKoNGatOi/QQ/Kn4lIPsMotHBGJmwQmCrz8Qn8/DXabNGB1pmlvXEFEpRrSKl
         bZjVg11/spkdN7dG1519N3XIU8Kw4es67tP2PUUtXvfvbloQ9eV74vXfiZehX31KMz1R
         9EDSMIpWfhDiMEIMe3cwNglJt8hXEh/f8ygwuXMzQNs88G/tz0GVm8MTzXn5NC2QU8oQ
         XKQg==
X-Gm-Message-State: APjAAAU6NBW2bKP01Qsrza3atBhSf5Dy2RonN4LqhvzMYZALsTxRDwmJ
        ZMrBhf1crLDLUwcW575vYQ==
X-Google-Smtp-Source: APXvYqyPBzxIhoP3H+P9LqIiK3hX3lZ5SBs7l9OTqvE4gQGrbgUrEC2A1vykW7mfrIfYpBNwc/eCWQ==
X-Received: by 2002:a9d:3cf:: with SMTP id f73mr5553811otf.11.1579648391091;
        Tue, 21 Jan 2020 15:13:11 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 67sm12497977oid.30.2020.01.21.15.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:13:10 -0800 (PST)
Received: (nullmailer pid 17419 invoked by uid 1000);
        Tue, 21 Jan 2020 23:13:09 -0000
Date:   Tue, 21 Jan 2020 17:13:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, alexandre.torgue@st.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com, lars@metafoo.de,
        knaack.h@gmx.de, pmeerw@pmeerw.net, fabrice.gasnier@st.com,
        olivier.moysan@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: adc: stm32-adc: convert bindings to
 json-schema
Message-ID: <20200121231309.GA17359@bogus>
References: <1579095941-18648-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579095941-18648-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jan 2020 14:45:41 +0100, Fabrice Gasnier wrote:
> Convert the STM32 ADC binding to DT schema format using json-schema
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in V3:
> - Fix minimum and maximum syntax for uint32-array properties as pointed
>   out by Rob.
> - update example to better show this syntax e.g. st,adc-channels = <0 1>;
> 
> Changes in V2:
> - Take almost all of Rob suggestions (removed reg generic description,
>   added minItems, maxItems, st,max-clk-rate-hz range, drop some pipes,
>   simplify clock-names, remove unneeded allOfs)
> - For now, keep all in one file despite there are lots of if/thens in the
>   bindings
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 149 -------
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 458 +++++++++++++++++++++
>  2 files changed, 458 insertions(+), 149 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
