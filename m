Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD533C5E83
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhGLOok (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 10:44:40 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:35359 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhGLOok (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 10:44:40 -0400
Received: by mail-io1-f51.google.com with SMTP id d9so22931677ioo.2;
        Mon, 12 Jul 2021 07:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=np4XRmePldXERnfmJAreepqhvPuNElEqZd5QybFo6Tg=;
        b=TgrwANPo7DVZUf3xqW1umfvME2XeLDT8Pcrtd0KCuQcF0Rz7nSqXoAxmL5nmE8EgFV
         LxNL1iXfYFgeo6gSNFyG5DSedWGJYU0pEN+H0vI1FNV9pld3QT9b/Yj0ggXL1yedHFPF
         Yhjq33PCgwtvWmfwd3KMVr6o1bFltONUYqn5cQ6Kjo7gL29ZKWymve+xIxTLbaTtCBSC
         zpZG+2/HF9tfWugxR0uu/YzONEecggT7IxWmJmtLIgWRpY6Ggl+xyjMK/9mzz8VBxwkJ
         WfxoAP27TZajilTA9wbF77rtXpM9f+X4VovDY0L5+1HkVfBxCpmjbzeZoa8a64CyI6Wx
         gLOg==
X-Gm-Message-State: AOAM531aR+gjKjC/rly04ABVnT8lsnaG4Oz+MlHJ5myXGaDs07DORLTp
        akd8pIISBgX4MfxfJzrK/w==
X-Google-Smtp-Source: ABdhPJxCokjE/VRomn+BDqJ5WdQKFS5UCgSlYnnQqCUCie2z86GyxKcrojRFf3T7Qz+eeElUOqqAiA==
X-Received: by 2002:a6b:3b08:: with SMTP id i8mr30784452ioa.153.1626100910569;
        Mon, 12 Jul 2021 07:41:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d8sm4951277ilq.88.2021.07.12.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 07:41:49 -0700 (PDT)
Received: (nullmailer pid 1894651 invoked by uid 1000);
        Mon, 12 Jul 2021 14:41:47 -0000
Date:   Mon, 12 Jul 2021 08:41:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, lee.jones@linaro.org,
        lars@metafoo.de, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/4] dt-bindings: mfd: ricoh,rn5t618: ADC related nodes
 and properties
Message-ID: <20210712144147.GA1886650@robh.at.kernel.org>
References: <20210703084224.31623-1-andreas@kemnade.info>
 <20210703084224.31623-2-andreas@kemnade.info>
 <20210703170245.1d310342@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210703170245.1d310342@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 03, 2021 at 05:02:45PM +0100, Jonathan Cameron wrote:
> On Sat,  3 Jul 2021 10:42:21 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
> > Add ADC related nodes and properties. This will allow to wire
> > up ADC channels to consumers, especially to measure input voltages
> > by the power subdevice.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  .../bindings/mfd/ricoh,rn5t618.yaml           | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > index 032a7fb0b4a7..185f87a14a54 100644
> > --- a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > @@ -73,6 +73,48 @@ properties:
> >      description: |
> >        See Documentation/devicetree/bindings/power/power-controller.txt
> >  
> > +  adc:
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - ricoh,rn5t618-adc
> > +          - ricoh,rc5t619-adc
> > +
> > +      "#io-channel-cells":
> > +        const: 1
> > +
> > +    additionalProperties: false
> > +
> > +    required:
> > +      - compatible
> > +      - "#io-channel-cells"
> 
> Strictly required?  If not used below (where it is optional)
> then why do we require the ADC driver to provided the services?
> 
> I don't mind you leave it as it is though if you prefer - it doesn't
> do any harm!

The device is either a provider or it is not regardless of whether 
there's a consumer, so I prefer this to be required. Also, if a consumer 
is in an overlay, then it is easier if we can rely on #io-channel-cells 
being present already.

Rob
