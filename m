Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB7D1C1F96
	for <lists+linux-iio@lfdr.de>; Fri,  1 May 2020 23:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgEAV3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 May 2020 17:29:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34907 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAV3L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 May 2020 17:29:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id o7so954754oif.2;
        Fri, 01 May 2020 14:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LBBWTdBW4SlINNSKfNA/Lf6s5jnXmeXqJqpJNBD6jx4=;
        b=Rh1g00ekoo2lwVm6bYrkf0O+RWFXqQa5ndkF7oIpuQEe/HoCO23qzYIXfGhGUwNosf
         GgHlOSu52l0eKGYKV/LlcYP+hVj1+t8YAfwXTHzWS0/8MC6IX6JRWBFJlM4Ftp1JHBm4
         2kSYcFxbdQAlkBfCGlGSDVNV+lB/cxTpZIUcQVaVlyIuFRSf0D1ZV2DrW5uaxTXR5XxM
         Hhvk5+jBwHHV99UgPlTm/UTaddGbd97XbrfEjhp0IWb+jf7AhFWjSSavpQ7ktFMGcJPV
         eP7A3YTVEzN1zYBjc+pQ5eUdnQZM2RKG6DlcWjH/pQ81RAta1Y2UMSQfi8kNPgAchDS3
         aIYQ==
X-Gm-Message-State: AGi0PuZxHBhK/am3LhJketCzSwEDjgy+5ZAr7tWsK4h7JCUc3TZD6X4C
        xWLuaSzrM2DzeAi11grmgA==
X-Google-Smtp-Source: APiQypLTFGkG8jvmXy1Gqej2BQVTujE0O7c4+0cWJa3hNguybt0s2XFLDAb8MJP0qi4Q7MBgeu8C/w==
X-Received: by 2002:aca:4d53:: with SMTP id a80mr1221713oib.134.1588368548797;
        Fri, 01 May 2020 14:29:08 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u82sm265429oia.35.2020.05.01.14.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:29:07 -0700 (PDT)
Received: (nullmailer pid 32518 invoked by uid 1000);
        Fri, 01 May 2020 21:29:06 -0000
Date:   Fri, 1 May 2020 16:29:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adi,ltc2983: Add missing quotes on
 dependencies
Message-ID: <20200501212906.GA31617@bogus>
References: <20200423150523.23984-1-robh@kernel.org>
 <CY4PR03MB33502FFA293BB3F068A488B299D00@CY4PR03MB3350.namprd03.prod.outlook.com>
 <20200425181052.1588a862@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200425181052.1588a862@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 25, 2020 at 06:10:52PM +0100, Jonathan Cameron wrote:
> On Fri, 24 Apr 2020 07:26:46 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> 
> > > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> > > On Behalf Of Rob Herring
> > > Sent: Donnerstag, 23. April 2020 17:05
> > > To: devicetree@vger.kernel.org
> > > Cc: Sa, Nuno <Nuno.Sa@analog.com>; Jonathan Cameron
> > > <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter
> > > Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> > > <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org
> > > Subject: [PATCH] dt-bindings: iio: adi,ltc2983: Add missing quotes on
> > > dependencies
> > > 
> > > With the bracketed list form, any strings with commas have to be quoted
> > > or they are separated.
> > > 
> > > Fixes: 3986a14870cb ("dt-bindings: iio: Add ltc2983 documentation")
> > > Cc: "Nuno Sá" <nuno.sa@analog.com>
> > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > > Cc: linux-iio@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---  
> > 
> > Acked-by: Nuno Sá <nuno.sa@analog.com>
> > 
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Rob, Do you want to pick this one up via your tree?

Yes, I did.

Rob
