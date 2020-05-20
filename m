Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8F91DAB90
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 09:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgETHHF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 03:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgETHHE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 03:07:04 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE46C061A0E;
        Wed, 20 May 2020 00:07:04 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id er16so882162qvb.0;
        Wed, 20 May 2020 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N9nY7Nz6gwu5FrcNeOcXemzIizmbKBDnLPp3m4VuvqM=;
        b=UCXM2PujW0MqBkGgv1FFV0/F+4nAmR4CqvG3VqN+ZJu13YAvYdrYwQFViR7mdogoVI
         BxO4xpZ1F/U01gWFua+hJxyzxjgpLb2km2RgOmkB9i8BwiW/ExZr/3/FfJ+UjCf3RVUd
         6CcY+A6XLPcWMTDOa4GUmEC8pBU7hbAU2AEtEAJSxF3XY6C0bRFk9rouIL7ifK+ErKpk
         nJDMlhNU+NleG8SpJmxmn5mfQl/qdXdQKK+hllHb40q0z+5WUUIJ7Ced/Q3MPKliwcqK
         7a/zp54Ew0ee1tJreQCI3tw0TpX95MQ51c3oZ48eZUJfCZ5IwNTZApTmP1yEbX5E/3wz
         0eGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9nY7Nz6gwu5FrcNeOcXemzIizmbKBDnLPp3m4VuvqM=;
        b=PTnqeBtRNPu5RO8uloxoA1te0HHkH5nds7Kjwj9R6ru8sBcMkNYrnaSVWr7iPpbhl3
         ByaHhECUGzBUpERsvpHfOYQOAFkilpc/U9+lNOGGh9UNA0WNjCx/KGLANiGogbdJhtc7
         EgGrEK7Y2/v3+unAnvj7JUnTvc/8FUG++hJ113izV4I+ET3DE+qg9C403DaA8tArpgWY
         SkPo6b3vyagRBzKlJjpn0u9s4zYOyHcDPleAuQfX0JCO6n/ZgoLHYepDtMRahtrH0+hH
         39xb+9sxHRewv7X0PfQ6EaD896QxLue6PAMUm1el5RZEY7xmWy1kTNTnfilbWCEOlkLg
         wpjg==
X-Gm-Message-State: AOAM5323v3nYjUaXQlccy/zpi+i3tjCRZbrB1lshSFwX7HZEX2Fk4wAb
        SrHvSEMDNOHPOBKRgCPz14w=
X-Google-Smtp-Source: ABdhPJzMfBTm/klO3f5I9gk53xR0ZxsILmHi0KRJOgGETbg6kAA3OEondSzE6d8ZaHPnDfXJscyvwA==
X-Received: by 2002:a05:6214:8e4:: with SMTP id dr4mr3266633qvb.97.1589958423778;
        Wed, 20 May 2020 00:07:03 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id n9sm1581138qkn.10.2020.05.20.00.07.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 00:07:02 -0700 (PDT)
Date:   Wed, 20 May 2020 09:06:58 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <20200520070658.GB3361@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-2-jonathan.albrieux@gmail.com>
 <20200519173738.GA342367@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519173738.GA342367@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 11:37:38AM -0600, Rob Herring wrote:
> On Tue, 19 May 2020 09:50:57 +0200, Jonathan Albrieux wrote:
> > Converts documentation from txt format to yaml
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
> >  .../devicetree/bindings/iio/imu/bmi160.yaml   | 84 +++++++++++++++++++
> >  2 files changed, 84 insertions(+), 37 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > 
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Error: Documentation/devicetree/bindings/iio/imu/bmi160.example.dts:37.1-2 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:312: recipe for target 'Documentation/devicetree/bindings/iio/imu/bmi160.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/iio/imu/bmi160.example.dt.yaml] Error 1
> Makefile:1300: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1293085
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 

Uhm I don't get that error, will try to update to see if it gives me the same error,
Thank you,

Best regards,
Jonathan Albrieux
