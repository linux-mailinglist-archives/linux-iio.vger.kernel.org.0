Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0DFE05FA
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 16:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfJVOGk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 10:06:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40332 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfJVOGk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2019 10:06:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id o49so19090145qta.7;
        Tue, 22 Oct 2019 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sHs2QlhxbBkINZWNWfLKn7toSRHDRtAjO+pu/W5oZEw=;
        b=dQSQd8zvq44JjJnas5gkyT5ZaMzsJTMqzIIN148V+8hv85hrKwU+zj8JrDLPyXSdif
         zRloFwPsMvDEODBLgvr3a8aU2D8kN/k59FU15NF7CS0RtLaWtog5pW5jZQ6DIaooIMgy
         EcSxbdLmkeL4UgrN4Unz7fHfLtxpmMGZQLQcaJpQyCqeI+hTj7H4VG2YKfsgtD49HKE2
         LknFWZIpbyAdg0qu0TZ0GiJAys2u2+MzNx15bxD8az7B6zACrkl50NS++A0kyDyaFDYA
         7efqODlPKgBgmxIQRj5gnv+DMaqb7KTKd0dWOIYHxH8p/x3Navcf00+tZLJXS9P9mvj4
         j1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sHs2QlhxbBkINZWNWfLKn7toSRHDRtAjO+pu/W5oZEw=;
        b=QNwBmshhIYnwhFZdR60Y1hWExa7UMVaRh5c2IB2xeqVX7PATSsXKcs6ao7ILUXCwQ9
         Nb8m7klSh+bBAJHdoSU66St23bQsq0zeQjRUGP7Jvktrfgg2yb50YxMZ81uoEy1z1/qp
         ba7nLKjGAkOnAV/nzGKXRO66uRBhHJHoqeIUzXQTS0ae/xapooELzCBKylq+B2NMmOG5
         J77Nx0sxmAiF1zNxTI1+kAarlI6ZFPdjr1pZadzfzHSx+fm1YEsD/kZSb+K0YoRFA+En
         QV+gl/C+pEuPixQzl1Y8Uws3FLTI04OHYg9x73xyp05UaLyFIsN4pomMPLI2LosuT9lK
         DNwQ==
X-Gm-Message-State: APjAAAXecgLyqlL+1wOannSSOArRGorVowh2anCU1QcOWjbweFxguqKc
        rPYSGJ8e9BbwAu4z9dcqwds=
X-Google-Smtp-Source: APXvYqygfBqxEFPNJIXaP/QrHWQzCuZsQXrnLgNtmuWg9S65iYxDR5QdCFZUXUmf0bttAcOU+7mXOg==
X-Received: by 2002:ac8:4243:: with SMTP id r3mr3365473qtm.329.1571753199574;
        Tue, 22 Oct 2019 07:06:39 -0700 (PDT)
Received: from smtp.gmail.com (gwcrusp.semfio.usp.br. [143.107.150.86])
        by smtp.gmail.com with ESMTPSA id q8sm3970384qta.31.2019.10.22.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:06:39 -0700 (PDT)
Date:   Tue, 22 Oct 2019 11:06:33 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: Add DT docs for AD7292
Message-ID: <20191022140604.ovmooly47qax2sms@smtp.gmail.com>
References: <20191016025220.td3xb7oxlfkznxl6@smtp.gmail.com>
 <20191017191152.GA11222@bogus>
 <20191019150652.h6bkfz2w2ohemvwy@smtp.gmail.com>
 <CAL_JsqKqgko02KstmytNNUUF0-QR7rpMF4dV=X55N=TnDahd+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKqgko02KstmytNNUUF0-QR7rpMF4dV=X55N=TnDahd+Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I ran the DTC and CHECK for AD7292 schema however, the target '__build'
did not run due to errors found in regulator/fixed-regulator.yaml and
arm/allwinner,sun4i-a10-csi.yaml.

I recall seeing something about the maxItems requirement over regulator
supplies being changed on the iio mailing list, so I updated my repo
locally, cloned and reinstalled the dt-schema toolset. However, I still
can't make it go through the '__build' target.

Python 3.7.5rc1 is my default python and I got the following pip3
packages installed:

ruamel.yaml        0.16.5
ruamel.yaml.clib   0.2.0
rfc3987            1.3.8
jsonschema         3.0.1
dtschema           0.0.1  at $HOME/<iio repo dir>/dt-schema

Debian Bullseye packages installed:
python3-yaml/testing,now 5.1.2-1
libyaml-dev/testing,now 0.2.2-1

I was only able to run DTC after installing the libyaml-dev package, so
I think it might be worth to add it to the project dependencies at
https://github.com/robherring/dt-schema.

apt-get install libyaml-dev

Thanks,
Marcelo

On 10/20, Rob Herring wrote:
> On Sat, Oct 19, 2019 at 10:07 AM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Hi Rob
> >
> > Thanks for the review.
> >
> > I'm having some trouble with the DTC.
> > I installed the DT tool from https://github.com/robherring/dt-schema.
> > Running make -k dt_binding_check goes through all the checks (CHKDT), producing
> > the .example.dts files but then gives errors like:
> >
> >   DTC     Documentation/devicetree/bindings/arm/calxeda.example.dt.yaml
> > FATAL ERROR: Unknown output format "yaml"
> > make[1]: *** [scripts/Makefile.lib:314: Documentation/devicetree/bindings/arm/calxeda.example.dt.yaml] Error 1
> > make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/calxeda.example.dt.yaml'
> >
> > My pip3 installation has:
> > jsonschema jsonschema-3.1.2.dev6+g0d827f3
> > rfc3987 1.3.8
> >
> > $HOME/.local/bin is listed in my shell's PATH variable.
> >
> > I was trying to follow the documentation at:
> > Documentation/devicetree/writing-schema.rst
> >
> > Are there any other DTC dependencies that I am missing?
> 
> Yes, libyaml. See Documentation/devicetree/writing-schema.rst.
> 
> Rob
