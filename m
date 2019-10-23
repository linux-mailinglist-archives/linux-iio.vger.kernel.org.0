Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F04E10A7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2019 05:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfJWDnO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 23:43:14 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43959 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbfJWDnO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2019 23:43:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id a194so14436443qkg.10;
        Tue, 22 Oct 2019 20:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1VLjmkD3Rwi0EmWCkc7vL9OT1uRUJflAVuUFK1TCUfs=;
        b=jBkAkT8KEpSceUnUT5D05nwe+iUUaw4Z2mTUBn3UmLbvelJfBJ0apbdnjAvMT5YvY3
         ntlBx/J1kfkGuRuxJfFxXJf2vGgCVZTHEIHO57WyPJwTDbFtfIHT+ZKaN/KMYhlFvbZg
         l5uHyObZQT100bTkbf22/rl6axphYwccnbaGlNbtA7ZHNCnG5G+uK+fKnMQcl0zxeKhy
         OjEkXlm2lczwehiMu+tWksfrRrrhUMMho7Ws55ENPgLgFzE/p/4SpSz1sJWyxxny2pCR
         I84UJUFwbPpDwBAgMSF7HEay+FmmXN2jMIRe5bgfbKXigapMT68B3xN3ohWxw4Xv9+yv
         6X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1VLjmkD3Rwi0EmWCkc7vL9OT1uRUJflAVuUFK1TCUfs=;
        b=ClIVLf5A/lh41Z4zexUPHGBx4y87X1oWdoUcY48xVnwq/m5ywxPqqB8yzGxTHfkvxE
         BB40oYAQcN2UmESTZullRmDqKSzySBma9/JBcj7/ZA5PIgE3VQxXu/EsU3m4FmyJetah
         4us3ClohzwsqdkXDAcPYOQcXL7LbTe7ZXxzyFokge9LshpWSTodH4K4l0Whg62y1P7+i
         UVuWpu18A+FLWK1VnzoakdB6+h5UsZpdMm6QQFUZOroZkIIoYtds0eBcklxG3Rp7xTUn
         /NmmwrGOVUeaoKkffCFM1omcS3b96ZTJNi88v1rn1DvqeF5KkDzpaQT3nxRVIICXvKbO
         fQeQ==
X-Gm-Message-State: APjAAAW4KF0I6+UiKmotqvdVAkHXTM+nTWIYMPNq8rtfv9Ml1pnRlg9T
        SiF3NWgFVzJ5fFKRZ52Hz6rinSVbuGc=
X-Google-Smtp-Source: APXvYqyfwugcAWTEZOsrSK/23d7kNjtNUgsTU3k7oaizdL5WSdU/HGKgK5xsqWdRyhpv5GrVnl6Udw==
X-Received: by 2002:a37:9a8a:: with SMTP id c132mr6452527qke.92.1571802192882;
        Tue, 22 Oct 2019 20:43:12 -0700 (PDT)
Received: from smtp.gmail.com (gwcrusp.semfio.usp.br. [143.107.150.86])
        by smtp.gmail.com with ESMTPSA id c15sm146qkc.101.2019.10.22.20.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 20:43:12 -0700 (PDT)
Date:   Wed, 23 Oct 2019 00:43:07 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: Add DT docs for AD7292
Message-ID: <20191023034305.f6zm6hyvh3nlltas@smtp.gmail.com>
References: <20191016025220.td3xb7oxlfkznxl6@smtp.gmail.com>
 <20191017191152.GA11222@bogus>
 <20191019150652.h6bkfz2w2ohemvwy@smtp.gmail.com>
 <CAL_JsqKqgko02KstmytNNUUF0-QR7rpMF4dV=X55N=TnDahd+Q@mail.gmail.com>
 <20191022140604.ovmooly47qax2sms@smtp.gmail.com>
 <CAL_JsqLf8kpOu0MQN-TAhQkiZCGfMKWmztnHNo+2BAVqfX8yGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLf8kpOu0MQN-TAhQkiZCGfMKWmztnHNo+2BAVqfX8yGQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

OK, thanks for the explanation.

I indeed missed some details from the documentation. I will be more
careful on my next readings.

I see there are other documentation files at Documentation/devicetree/
and Documentation/devicetree/bindings/. Besides these, would you
recommend other documentation and/or material for those who want to
write dt-bindings that validate with dt-schema?

Thanks in advance,

Marcelo

On 10/22, Rob Herring wrote:
> On Tue, Oct 22, 2019 at 9:06 AM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Hi,
> >
> > I ran the DTC and CHECK for AD7292 schema however, the target '__build'
> > did not run due to errors found in regulator/fixed-regulator.yaml and
> > arm/allwinner,sun4i-a10-csi.yaml.
> 
> Fixes for those are still pending in -next. Use 'make -k' and ignore those.
> 
> >
> > I recall seeing something about the maxItems requirement over regulator
> > supplies being changed on the iio mailing list, so I updated my repo
> > locally, cloned and reinstalled the dt-schema toolset. However, I still
> > can't make it go through the '__build' target.
> >
> > Python 3.7.5rc1 is my default python and I got the following pip3
> > packages installed:
> >
> > ruamel.yaml        0.16.5
> > ruamel.yaml.clib   0.2.0
> > rfc3987            1.3.8
> > jsonschema         3.0.1
> > dtschema           0.0.1  at $HOME/<iio repo dir>/dt-schema
> >
> > Debian Bullseye packages installed:
> > python3-yaml/testing,now 5.1.2-1
> > libyaml-dev/testing,now 0.2.2-1
> >
> > I was only able to run DTC after installing the libyaml-dev package, so
> > I think it might be worth to add it to the project dependencies at
> > https://github.com/robherring/dt-schema.
> 
> Strictly speaking, it's not a dependency for dt-schema. It's
> documented in Documentation/devicetree/writing-schema.rst. I've added
> a pointer to that in bindings/submitting-patches.txt. I'm not sure how
> else to make it more obvious.
> 
> BTW, You will get a useful error message if libyaml is missing when
> building 'make dtbs_check'. I need to make that work for
> dt_binding_check.
> 
> > apt-get install libyaml-dev
> 
> You need the lib too, but that tends to already be installed. IIRC,
> installing the headers doesn't install the lib automatically.
> 
> In any case, I wanted to avoid putting in distro specific instructions
> in the kernel.
> 
> Rob
> 
> -- 
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/CAL_JsqLf8kpOu0MQN-TAhQkiZCGfMKWmztnHNo%2B2BAVqfX8yGQ%40mail.gmail.com.
