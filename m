Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C791A3D0C
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 01:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgDIXq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 19:46:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37850 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgDIXq3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 19:46:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id u65so291667pfb.4;
        Thu, 09 Apr 2020 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X1Y8bnD3QMGmRcwUVI82L0iDUV1q8Fy3GQNmvFYnS2I=;
        b=EBxEUf08dMeA2iEQohC5/R3ZVAHRMWWtefrFAHbK3WBKDA3GsxHCGkxIMncKubJ14s
         ZqP447beS2tDu8NLH1Z44HuydTaUOJwx4UvmH8w9UE66LnWULAeThpHVGv7KL/t1IQ0z
         nXGlMIXpzqjB9hMb2IcXye17mn11vmGodw94zXUXdpypQtgltIkMQUBpX3lpyQLcQhKs
         kQI2/Tz08GLv0yr0aet1S8RRQlqzSM7yN+zQ+e+KhdgepQmmcXKW4fxnkQaG1Dt82L0h
         xYs6faP7szYqAUT2Vq+a4PoC+D7liwiWUMPO1Y6tmyF0KcAKHRiKCImaEY+I5eSH5Prx
         zO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1Y8bnD3QMGmRcwUVI82L0iDUV1q8Fy3GQNmvFYnS2I=;
        b=k3dyzjRdfrMbravnNC7lg4kpvJooy29jyo12cVeKxCEmoS3vzkmAVw14WfU7OW2yfo
         KPX7f9WMvwSsMzcYdNwKHtd0/LwC94g5LiA87rfWPKtbevl/uBe/qfLOr5TsLTejdU17
         zCCyjBwhjnnZGlZPG1lZvYNL0GwBHr4J/CIds4kugSQG8E5uRSkH2KMERlrqj9ZE///j
         uQXdvnAT3Q7OEELy8rR6pSJ+rk2B5nVjEYkJ51oKUhxfcOeQ2UEBb4aFiqoS6rmK12Aq
         7pPR6slOjykBp9so88CzHkjWnlebwn9aa+s5/HMFKShF4eVL5NQCBkJNz5QmInh3b1OX
         3DvQ==
X-Gm-Message-State: AGi0PuZN9pfwlIF0s84F8nh8IhiSLoIpQ8SuXdlQOcLvnvPDYvZ/APzM
        y0z/J7Vjusud9n7qOW1iqpc=
X-Google-Smtp-Source: APiQypJ1xTM0Kzl/R2WKceZ2kuvIzhM7XWOQrpUymOEdXWNA+ZOn9J7ew7DVykXrVkUi5rHMe4xDrg==
X-Received: by 2002:a62:648f:: with SMTP id y137mr2268339pfb.199.1586475986437;
        Thu, 09 Apr 2020 16:46:26 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id w27sm191851pfq.211.2020.04.09.16.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:46:25 -0700 (PDT)
Date:   Thu, 9 Apr 2020 16:46:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: rotary-encoder-counter: add DT bindings
Message-ID: <20200409234623.GU75430@dtor-ws>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
 <20200406155806.1295169-3-kamel.bouhara@bootlin.com>
 <20200409222115.GT75430@dtor-ws>
 <20200409223907.GW3628@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409223907.GW3628@piout.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 10, 2020 at 12:39:07AM +0200, Alexandre Belloni wrote:
> Hi Dmitry,
> 
> On 09/04/2020 15:21:15-0700, Dmitry Torokhov wrote:
> > On Mon, Apr 06, 2020 at 05:58:05PM +0200, Kamel Bouhara wrote:
> > > Add dt binding for the counter variant of the rotary encoder driver.
> > > 
> > > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > ---
> > >  .../input/rotary-encoder-counter.yaml         | 67 +++++++++++++++++++
> > >  1 file changed, 67 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> > > new file mode 100644
> > > index 000000000000..a59f7c1faf0c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
> > > @@ -0,0 +1,67 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/input/rotary-encoder-counter.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Rotary Encoder Counter
> > > +
> > > +maintainers:
> > > +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > +
> > > +description:
> > > +  Registers a Rotary encoder connected through a counter device.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: rotary-encoder-counter
> > 
> > I wonder if a separate driver is really needed. The original driver be
> > taught to use counter device when available?
> > 
> 
> By the original driver, do you mean drivers/input/misc/rotary_encoder.c
> that is using gpios ?

Yes.

> 
> > > +
> > > +  counter:
> > > +    description: Phandle for the counter device providing rotary position.
> > > +
> > > +  linux-axis:
> > > +    description: The input subsystem axis to map to this rotary encoder.
> > > +    type: boolean
> > > +
> > > +  qdec-mode:
> > > +    description: |
> > > +      Quadrature decoder function to set in the counter device.
> > > +      3: x1-PHA
> > > +      4: x1-PHB
> > > +      5: x2-PHA
> > > +      6: x2-PHB
> > > +      7: x4-PHA and PHB
> > 
> > Is it really property of the rotary encoder itself or property of the
> > counter device?
> > 
> 
> The mode the quadrature decoder has to be put in depends on both the
> rotary encoder and the qdec.

OK.

> 
> > > +
> > > +  steps:
> > > +    description: Number of steps in a full turnaround of the encoder.
> > > +      Only relevant for absolute axis. Defaults to 24 which is a typical
> > > +      value for such devices.
> > > +
> > > +  relative-axis:
> > > +    description: Register a relative axis rather than an absolute one.
> > > +    type: boolean
> > > +
> > > +  rollover:
> > > +    description: Automatic rollover when the rotary value becomes greater
> > > +      than the specified steps or smaller than 0. For absolute axis only.
> > > +    type: boolean
> > > +
> > > +  poll-interval:
> > > +    description: Poll interval at which the position is read from the counter
> > > +      device (default 500ms).
> > 
> > Is there a way found counters to signal an interrupt?
> > 
> 
> For some counters, there are interrupts available, this is not trivial
> with the counter that is the target of this work but this is on the TODO
> list. Of course, this will also require adding a bit more to the
> in-kernel counter API to allow registering a callback that would be
> called when an interrupt happens.

Should it be a callback, or can counter create an irqchip so that users
do not need to know how exactly it is wired up?

Thanks.

-- 
Dmitry
