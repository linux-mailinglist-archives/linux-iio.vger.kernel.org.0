Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519BA375E10
	for <lists+linux-iio@lfdr.de>; Fri,  7 May 2021 02:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhEGAxt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 20:53:49 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:43721 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhEGAxr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 20:53:47 -0400
Received: by mail-oi1-f180.google.com with SMTP id j75so7227789oih.10;
        Thu, 06 May 2021 17:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=730yCidVaF7UqEn0Z+nYrT2OtebyefuFsPE1idfkvVA=;
        b=kqCmyKyX6Obkg5czjxh6L9ZMNLJzMFNTzhnAHrIIL0UUFYTZmANsVyMkCoyx+j+1bN
         yoYw4i1EUi20EM/qIVbClQ0toCEXetQ6JaAEr27U8Hkz26jr53wvCzpV7F187N3kMC3r
         DHHCo11gIXbsUOIecdeyxOAfnfspHvoIgauGaEXhmCPAvz3rvA9NEXDzFFm6ZPeCAMXh
         8LX1726H2Nkv1I+lw1TsvgI4NxWU3zwGlU27i2bfzvTG8CTTokK8Fj2cC2pOZ3ucFUwI
         4ogb0wVjX4g64HbHw/iZUt6HPLSS52Is5v0+mdn/Axqwji0/cxX91csYIwpdKLCqWAGl
         jFhg==
X-Gm-Message-State: AOAM533HyU8MzVusJA2CNH/U9W3C6FqJzqcpjNxobCuj2cVeE8W2BmEn
        kWiaehk4vQX4cT15KEz8mF2BD/TUQQ==
X-Google-Smtp-Source: ABdhPJyhLUj36MZKsD1jJNAgYPQimK7lpn9GeTIUVUyfj0Rs71lpL9XQpQZMYWsZGIOw4na34pJMvQ==
X-Received: by 2002:aca:3c09:: with SMTP id j9mr12629423oia.28.1620348768736;
        Thu, 06 May 2021 17:52:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k35sm896772otc.13.2021.05.06.17.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 17:52:48 -0700 (PDT)
Received: (nullmailer pid 1097796 invoked by uid 1000);
        Fri, 07 May 2021 00:52:47 -0000
Date:   Thu, 6 May 2021 19:52:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     robh+dt@kernel.org, tomas.melin@vaisala.com,
        linux-iio@vger.kernel.org, lars@metafoo.de, Nuno.Sa@analog.com,
        devicetree@vger.kernel.org, jic23@kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v5 2/6] dt-bindings: iio: accel: fxls8962af: add bindings
Message-ID: <20210507005247.GA1097749@robh.at.kernel.org>
References: <20210506070940.312959-1-sean@geanix.com>
 <20210506070940.312959-2-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506070940.312959-2-sean@geanix.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 06 May 2021 09:09:36 +0200, Sean Nyekjaer wrote:
> Add devicetree binding for the NXP FXLS8962AF/FXLS8964AF
> accelerometer sensor.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes for v2:
>  - removed requirement for interrupt
> 
> Changes for v3:
>  - None
> 
> Changes for v4:
>  - Included the dt patch from the RFC
> 
> Changes for v5:
>  - fixed interrupt enum
> 
>  .../bindings/iio/accel/nxp,fxls8962af.yaml    | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
