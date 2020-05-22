Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BBB1DE8D3
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 16:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgEVO0t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 10:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgEVO0t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 10:26:49 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE46C061A0E;
        Fri, 22 May 2020 07:26:48 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f189so10846223qkd.5;
        Fri, 22 May 2020 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EBkBNqP4rcatLlGUJoFCCwVojRrJT2D3HEctGKEmr6Q=;
        b=gKb/u6Cq1DZYEYo68zKdl6ZxeTJbRecwKaNjg/fHM3oEACOTTcYV+DZSz6FNfraXbq
         V4Urq3zWMYWRdVw/UxOpuqfAm4Q5JSH7AZ0e3S3IngK5xDQofVcs+vQ16iNw4427M2Om
         AGe6faqTV0L3+iWj8PK9zF6rO/S0QL31UxRwjigjAK3lsgi/fu0TnHPQ0VW6ol1tCVmw
         jT+Kk3J2Q0y0GSFgQ67IUDn0M+F6IT9gR8NGbQmJPKt7NpdgMABCSt+BDyfRL10jSls5
         RcjhKr9fqsHesY/BRDtlbed/jPX+A1ryn983Sc8wBgbux52n5/5CzlURXs5JCwj1HyyD
         gTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EBkBNqP4rcatLlGUJoFCCwVojRrJT2D3HEctGKEmr6Q=;
        b=pLrnt0gNV+DrzO7fOBt13zlUdeiJm7V71uPMPqz5AAyy3cHeMJYhhFil1Ng4IZM+SS
         DhOpKi631p46R8+rakegseneXWx+/zGVba77GVGyKD/KlvU8aQwNvd6/AcgyQdg/vvFD
         WFAS7gclY+beYuPixHCcEv2iBjH/43kermv11IF/z9GsTWUgA6u7AFNqoAMYswyXETne
         kGus1qaSw5rdRbJ4nxziLBWj9KWmiZv+oFNKraAz6t7M7krJKUxzSm4/PFMrcCl7yC7B
         7qcwWedAPV7jl3xJxnkPujprtLkolf9biB0iFMmOCKaZ+0M2g/8uNwefaWgEbFoSYrMI
         wfqw==
X-Gm-Message-State: AOAM531IEbBOyYLo0VRLXrAYhURx3JmDXHnF4mTYLEzxeOFpPYr4ChtE
        HJgIhkKMKPCp7klPzkJyhtU=
X-Google-Smtp-Source: ABdhPJzkIM1JIdnV0nmVjysHRfQdWMphjrkCjmZA5BIADG8VwOO7Eowztz0DDyvVaEsDnShAQtBcXw==
X-Received: by 2002:a37:bd82:: with SMTP id n124mr15499338qkf.168.1590157607896;
        Fri, 22 May 2020 07:26:47 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id w49sm3628329qth.74.2020.05.22.07.26.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 07:26:44 -0700 (PDT)
Date:   Fri, 22 May 2020 16:26:33 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt format
 to yaml
Message-ID: <20200522142633.GA21655@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-2-jonathan.albrieux@gmail.com>
 <20200519184933.00003f00@Huawei.com>
 <20200520072423.GF3361@ict14-OptiPlex-980>
 <20200521192736.4818f17b@archlinux>
 <20200522082208.GB19742@ict14-OptiPlex-980>
 <134f419f-de85-f14e-0331-49b8bb72625c@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134f419f-de85-f14e-0331-49b8bb72625c@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 22, 2020 at 01:47:21PM +0300, Daniel Baluta wrote:
> 
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - can't find a mantainer, author is Daniel Baluta <daniel.baluta@intel.com>
> > > > > Daniel is still active in the kernel, just not at Intel any more. +CC
> > > > Oh ok thank you! Daniel are you still maintaining this driver?
> 
> I can do reviews if requested but I'm not actively maintaining this driver.
> If anyone wants
> 
> to take this over, will be more than happy.
> 
> 
> Other than that we can add my gmail address: Daniel Baluta
> <daniel.baluta@gmail.com>
> 
> 
> 

Well if you'd like to review this patch I'd really appreciate :-)
Forgive me for not having understood your answer regarding the maintainer
field, can I add you to this binding as maintainer or are you saying to
not add you? Thank you and sorry for the repeated question,

Best regards,
Jonathan Albrieux
