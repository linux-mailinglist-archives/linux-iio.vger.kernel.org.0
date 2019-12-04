Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A975111375B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 23:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfLDV76 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 16:59:58 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35321 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDV76 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 16:59:58 -0500
Received: by mail-vk1-f193.google.com with SMTP id o187so478866vka.2;
        Wed, 04 Dec 2019 13:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pKw4WEjtZZ+ACrJvt8REFVw2T1voAJU2FAajhV3nbNM=;
        b=IHbjuMkcZRvwD6xr8tpR8Fw6a1bd47WRYIsOp8XZY82ivdoauVqCTkQDURYAOgfRt0
         0ybeNBsSQ+wKn+UALDsjm51m1MNsA4oMT2VE3QBdljChIN891+fXUtKjCiH/oxY8KOSx
         RBTSggyxcr9sYZ8m4DIp1OsDFbsI484ct/LTj9LvEwpcjjQbVVLDeOPgGpEHzxcOLVGL
         gAu/fP8LkNflcKBbrh7jV2by42AJVCYGY8KgB3OjcAxM9QsIcTi6xJn9FtEgH5QpzR6B
         8REUVgXuZeX/4Cy6QCaCITTKDmu4BLeA5B7rkGn65pHgPujliGc4ik7eKcRIkQ1GlDPz
         pmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pKw4WEjtZZ+ACrJvt8REFVw2T1voAJU2FAajhV3nbNM=;
        b=oLxgiismnapPl3hh1LDZHuM5bOkG+sBwidRyjUCuVjo9qPSUBw9pSk+Ah52yVZPnxb
         I7YBoXAybBmDLJvI4Y+SFIfHktix1BsK4TEjtUzQ1Vy3NQ4OWp7uf1j69dcKTEcXjNxz
         yHybHJoO4Mewz4+UnKPlFkf8XrfF4kzSm5xNmSiPHMuSunx/iWrWiEk6PSRFBdXkT6LM
         jPxsvosqGqeJqwmqpaU8KCp7UJVliPGNlYmpiaSYhc6IG6jOzqudECVN3CT2LjaXfhfF
         SH8x6LinlZaLXghUNKPj2kEcXRHXcqzlr/rhsQ/ryygPVQw5v37qpsXNl4NbedsOkBEq
         thVQ==
X-Gm-Message-State: APjAAAXhhCddfgQoTiZM56w56Uo5LTlt773k0L3WaGmqm/BZmclqbI1s
        UykiO/XE51Azit/l60/0JmQ=
X-Google-Smtp-Source: APXvYqxyKYTN6LNLmiTZDvYFxhKu2IirTtOTFhUAzjcl98Cz3zJ4dbSCd+11Ii/p63J9ZE3PxGYJMA==
X-Received: by 2002:a1f:8f0c:: with SMTP id r12mr3868068vkd.78.1575496796827;
        Wed, 04 Dec 2019 13:59:56 -0800 (PST)
Received: from smtp.gmail.com (gwcrusp.semfio.usp.br. [143.107.150.86])
        by smtp.gmail.com with ESMTPSA id a63sm2627634vka.30.2019.12.04.13.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:59:56 -0800 (PST)
Date:   Wed, 4 Dec 2019 18:59:52 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ad7292: fix channel
 constraint
Message-ID: <20191204215951.n5sfpej2thk37ipc@smtp.gmail.com>
References: <20191204155918.5ot4tplceqjeul6a@smtp.gmail.com>
 <20191204185753.GA19409@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204185753.GA19409@bogus>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I see now that I had misunderstood part of the last thread.
Sorry for the unnecessary spamming. Please, ignore this V2 series.

On 12/04, Rob Herring wrote:
> On Wed, Dec 04, 2019 at 12:59:23PM -0300, Marcelo Schmitt wrote:
> > Change items property of AD7292 channels to correctly constrain their
> > quantity.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> > Changelog V2
> > - Shortened the message to make it closer to 50 columns.
> > 
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> I think Jonathan already applied this series.
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > index b68be3aaf587..18f1032b86f3 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > @@ -53,7 +53,8 @@ patternProperties:
> >          description: |
> >            The channel number. It can have up to 8 channels numbered from 0 to 7.
> >          items:
> > -          maximum: 7
> > +          - minimum: 0
> > +            maximum: 7
> >  
> >        diff-channels:
> >          description: see Documentation/devicetree/bindings/iio/adc/adc.txt
> > -- 
> > 2.23.0
> > 
