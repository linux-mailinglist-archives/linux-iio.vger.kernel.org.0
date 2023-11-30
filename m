Return-Path: <linux-iio+bounces-501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854B17FE507
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 01:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B792A1C20B9D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 00:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2962B;
	Thu, 30 Nov 2023 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxj+FLfA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE31AD;
	Wed, 29 Nov 2023 16:39:27 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db4422fff15so312020276.1;
        Wed, 29 Nov 2023 16:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701304767; x=1701909567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrRnNCCUb/SdbujX/8piKGYQVRghzHGFa2Vr9K58E7k=;
        b=jxj+FLfAxUMm43s4zGeBtigTZEdsACq+z3LYtT7HTCrWD7bAWdX7uN9J6Qig4c/KmW
         0Twn+2CbKWBfC7y2R7gZylJgv54rs8rXTkNv47AsPF24HdBbUz3tAWhXkHgZCd3hfRsC
         /GWOvHzB3K2tRpsnKBE7rZuabYEcGLi45zSp7l4T9dGe1q7QqmGvc8GAZVkCxRZzHoN7
         0Nt1oJZCfsNQ7NnrpqTBgZQqGTKCK10AnrGq4y9I4R0RwQiXGgBoNvxACeDYghEL0qB3
         oe/ajLMOGgIfL63B+VcMBUM7Pmo+6thzGTXx1WwRBrkRI5JFypnVl75FmWkDK35l7ujo
         8xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701304767; x=1701909567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrRnNCCUb/SdbujX/8piKGYQVRghzHGFa2Vr9K58E7k=;
        b=F1n+CR2JLkmEEPwCdi3peXfDTCuob+K4U4974Jtzxo93EJJBYhj31y4hfJSHjpAOzc
         kg3n9UJTV9AsIqelWE29AKwHxuRp1o2GV/rgryNZFTmQFsX6t70/LFWfX9NuKmLbr7AV
         aAt1EY08ines5UYECeEKl0eVbDXOmFRmD5w0spLPGFOFmKPDIBg4kT2XBt1+7eLar6Y2
         lcLNzRdqqPPQWEHoETViaoZQyrquQNozEQw1Q/JMrBGULluuPZ+FGLVRA/+Lji6PNEIi
         WMF4msfxF0O8YnhtKpRZrpd6jf/dt+6jTSgOSwkoFthwA5ThW5kcyEFxO4od/iVbi70w
         c3TA==
X-Gm-Message-State: AOJu0YwOO77fnBap4T530HBohrzlUSKUHNQkFv9e7HKK4d0qJjpmb8bE
	DWXo8tl+QbIAs8TKfxM1Dn4=
X-Google-Smtp-Source: AGHT+IGAumAgSzBejyshel1sfFBCB/NCfiyEP8bsGE49yCUQfGnYArTWcCGev/JR+SSzHXXbP8YNxw==
X-Received: by 2002:a25:f904:0:b0:da0:48df:cafa with SMTP id q4-20020a25f904000000b00da048dfcafamr17581443ybe.16.1701304766961;
        Wed, 29 Nov 2023 16:39:26 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id z15-20020ad4414f000000b0067a631bb7bfsm1657128qvp.92.2023.11.29.16.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:39:26 -0800 (PST)
Date: Wed, 29 Nov 2023 19:39:16 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Message-ID: <ZWfZtGp9PvuPIB03@abdel>
References: <7e108db19cd9ad19b6413f65099280c010325a91.1699740057.git.alkuor@gmail.com>
 <20231126173002.3783271f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126173002.3783271f@jic23-huawei>

On Sun, Nov 26, 2023 at 05:30:02PM +0000, Jonathan Cameron wrote:
> On Sat, 11 Nov 2023 17:05:01 -0500
> Abdel Alkuor <alkuor@gmail.com> wrote:
> 
> > as6200 is high accuracy temperature sensor of -/+ 0.4C degree
> > with a range between -40C to 125C degrees
> > 
> Hi Abdel,
> 
> Welcome to IIO.  Just one comment on specifying power supplies below.
>
Hi Jonathan,

Thank you for the warm welcome :D

> Jonathan
> 
> 
> > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> > ---
> >  .../bindings/iio/temperature/ams,as6200.yaml  | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> > new file mode 100644
> > index 000000000000..97a73b92a789
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/temperature/ams,as6200.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMS AS6200 Temperature Sensor
> > +
> > +maintainers:
> > +  - Abdel Alkuor <alkuor@gmail.com>
> > +
> > +description: |
> > +  https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: ams,as6200
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> 
> I'd like to see
> vdd-supply: true
> and it added to teh required list.
> 
> The device needs power. Note there is
> a devm_regulator_get_enable() function that can then be used in the driver to turn
> on any regulator specified in DT which will provide a stub regulator if there isn't
> one (not unusual if a fixed power supply is used that is always on).
>
Sounds good. I'll add it.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        temperature-sensor@48 {
> > +            compatible = "ams,as6200";
> > +            reg = <0x48>;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
> > +        };
> > +    };
> > +...
> 

