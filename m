Return-Path: <linux-iio+bounces-622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD5B804492
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 03:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9D11F21394
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5B4A11;
	Tue,  5 Dec 2023 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDcPDltk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1C2A0;
	Mon,  4 Dec 2023 18:19:33 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d875809921so2069186a34.3;
        Mon, 04 Dec 2023 18:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701742773; x=1702347573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vphQhhcDfHQB3HrvKSiie3dMqka1KtYIdFVLBfGKx+s=;
        b=PDcPDltkK3XmqtX/V+AweuAs1WKf5N9gnaTp6jv5I6q19AiCfp7Yzntj0em0SVtoQd
         fQwsZYyzf/7B9J1uvHLjpXK3CGIAsQEtcqW3qoeHYaSDrMYMp01IVbcWhZPMUCSm1IJr
         9GRq/PEQbgnTC9uTo3Ebutg+F2gszwDi/Qw7o6ahAYlRDuLW6ydpUKDrotbyqCs95wZH
         cLuBgnIpJWMBnXBcTwEYOXiS6jQaDObTwgJvC1Jqi/5zRvu3QN0CMWOVjps8di+kNCEq
         vY6IrKLvQffauejmTSuOlZd2waFT7YSepdJFOIW4tESrMtNJtnp1l4hhtfJZIWYbBSCA
         EplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701742773; x=1702347573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vphQhhcDfHQB3HrvKSiie3dMqka1KtYIdFVLBfGKx+s=;
        b=wbSz49U335EXQQtpwWBuOfoNeOJmshnPpeynR4AwW7GQZMLmOD2wX+nYJSOxTPh45z
         cX84KM4vYWFXeae+3CUH5yhGRNW+EalOTD38CJQDCK1B8+/4SbzF+boGXQSNKK7MNiVf
         DhoTWBLHTHnJ9Cy/2470XQTET8UjiPqTANSY2ucHghykVOfeDdmA/dviVXf4BG4r+L7c
         /cbPUaIyFHmFzDf9s7BSYAy5VE/nWrJ2L1dFQNjnSaUmTZu2taTH3GefCwYeZLsSKdDo
         uJMXNccRashu22cjdoCSBiRRHpNVWBy9eH0PFTWoDcLeEVgCbqnKEqgZMO/YQvdMCD5X
         iQ1w==
X-Gm-Message-State: AOJu0YyhZkcsFky+r7ES5nHJFJKlP7j1MAkrdt1L2gsM2O5Kw4Zmx2xh
	0lD0Smpj95KTNCvsOMtun8xgS1o2iDqvBw==
X-Google-Smtp-Source: AGHT+IG06+JMoeu4sFgUHtQtyNBz0W1pAaoueEKgoJMozYMM7eujxRkY4vw6BaonmhAg2cDw+XNDOA==
X-Received: by 2002:a05:6830:719c:b0:6d3:132a:5350 with SMTP id el28-20020a056830719c00b006d3132a5350mr5429847otb.11.1701742772561;
        Mon, 04 Dec 2023 18:19:32 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id p3-20020a0ce183000000b0067a4f49a13csm4758176qvl.127.2023.12.04.18.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:19:32 -0800 (PST)
Date: Mon, 4 Dec 2023 21:19:22 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	lars@metafoo.de, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Message-ID: <ZW6IqoelmMhTgjgW@abdel>
References: <20231202041651.719963-1-alkuor@gmail.com>
 <20231203-wrecking-sneer-d34f19c39f04@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203-wrecking-sneer-d34f19c39f04@spud>

On Sun, Dec 03, 2023 at 11:24:31AM +0000, Conor Dooley wrote:
> On Fri, Dec 01, 2023 at 11:16:50PM -0500, Abdel Alkuor wrote:
> > as6200 is high accuracy temperature sensor of -/+ 0.4C degree
>
Hi Conor,
> Is +/- 0.4 degrees really "high accuracy"?
>
That's what the datasheet says :D. I'll remove it.
> > with a range between -40C to 125C degrees
> > 
> > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> > ---
> > Changes in v2:
> >   - Add vdd-supply
> > 
> >  .../bindings/iio/temperature/ams,as6200.yaml  | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> > new file mode 100644
> > index 000000000000..a1817795cdca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> > @@ -0,0 +1,49 @@
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
> 
> Please add the text from your commit message (although perhaps dropping
> the "high accuracy" section) here.
> 
> Otherwise, this looks okay to me.
Sounds good. Will add it in v3.
> 
> Thanks,
> Conor.
> 
Thanks,
Abdel
> > +  https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: ams,as6200
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
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
> > +            vdd-supply = <&vdd>;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
> > +        };
> > +    };
> > +...
> > -- 
> > 2.34.1
> > 



