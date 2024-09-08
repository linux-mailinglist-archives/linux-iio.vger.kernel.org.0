Return-Path: <linux-iio+bounces-9341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40697970931
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 20:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0A51C20A8F
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403E176AC2;
	Sun,  8 Sep 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlDvjW6V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C1C8D7;
	Sun,  8 Sep 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725819684; cv=none; b=Vbsz0ZiviHS5TWQ6gYTrrpx54aXpUAuzV8F3z6FyOUN0cQMvjyTh+fFdXpLxxD8f/e+x7cOk7UtJY80CJf5PmEMZRslmnlJ7p670hrp6JAkMPMkCkMuyk4OeAOBV/zwxn/0x1EcXPScTktMdRWLez6KpZjTDXBxhgtzKNbn2otk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725819684; c=relaxed/simple;
	bh=3HYeaqqVbWWLuM6OA/ypsrqs6vWrj9Lf8e94p5J7ny4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHXRi6+yiAEVS8mGOMwi/kjOPvG5Ol4wPRuVMvCbgAGk8j56KAN9s00J8mbOJVfUnJh/3h3mub2EEp5NiET3FdMpsvuvgQQ5HWR48MshRoEUe1SNxr1E6rNJ/2tFbiDa6JAzra0SvU+vrmwnnksdxiC+cAh/CEoWCzQFortmlMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlDvjW6V; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4581ec0e00eso14267911cf.3;
        Sun, 08 Sep 2024 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725819682; x=1726424482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YqmqHRKCpL6x+1lsPapogj4+nAp/0jRfZNYEmkU5RY=;
        b=TlDvjW6VV6epzeCgSDiuJEIQDAdm/t3x3KMzhCcBCcBZSVV483HNSpeDKqvgHk4HBy
         eyYBUPn8BiQSB6HJyZFEcdBjFopBpEoQ4o54ybO5wLHFAKNLcTeahgi9TI/bTbNnMaCQ
         AmnRVcCwhM1vmeQ4E2+FM6f1o+javNVtOLX9oDPMJsffSO3k3BpeS+DA1fw3woFOpboy
         NyWu2Oi18gP0Cm0WWlops+61jYHk+Ky+6qjm7drepHN6+CspD4q2RQIm5JI0VAGu3EYv
         WXErquf7GSV2LmeFd8JTWCDT4RiYADJdR9elIhcWecQMvct66iPyZL4GddDAp3Dj44bn
         fjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725819682; x=1726424482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YqmqHRKCpL6x+1lsPapogj4+nAp/0jRfZNYEmkU5RY=;
        b=RNpGoiR7mrp2Ncs1vV449egzvqYZ6dtUlB1mkLhmEqyr0lTGUG5C4PdrD9Hl1n805O
         oNL1mxwgg5YyZhWjt8WxXeLGMjDUeCyRiLxpkdNnEoO/4GCEkI0JMw+k/+LWtjH/7Zw5
         EY7RxNF0b8r/TECnIvjlFtdIxgONU/5O6B7yLQS7BuA2BnqNmtmTyjg0XVStTnB6TQt3
         O9pemqYnDgImwRfrBhvz20k9+IgeQRpd353DOPQz+0gPAzI24JYmKK/Zr1LMhOG9lFko
         Y/uE9vycA4hHuCpT/zKwUaaH9AuMuXCMsxfg+JHMQ64rmgj14tE0PGeFUUmMHl/IDdoQ
         orKg==
X-Forwarded-Encrypted: i=1; AJvYcCUiTZlOraV06ZfM2EcEZye/+0b/0bH5JVsIETc0tU3xl+CxnzL2KfqRfUo4c9113eD0Mot9LgUJnQAN@vger.kernel.org, AJvYcCXO86b526iu7WhV76UhfAQOU//GHrBOBN/A7KeZG8FTGgs3k4QBnYYxlMsa+ZXKnXVRcuZ1/U9IaQs13Ozd@vger.kernel.org, AJvYcCXbnUfaEAyo9ibfYFXC0bX6cDPX2cVfYmXnI7FFRqynHDctfrz26pj/9DFl1DT9LgRGclyWcTVRGqlR@vger.kernel.org
X-Gm-Message-State: AOJu0YwE43g/V53Jj8fmZnk46buXhEUL+ZX9Vf+J+eyFEhBXU0SBaace
	UCtYWq8zeJI/YTZ784XgmdvGYpFFvV7rbl5XzkgJ49rJCIUqv0eQnYrSmHDQ
X-Google-Smtp-Source: AGHT+IGVv6laIPP4952ucmfTHF1E+SFRopLmcmDS6Rx2ZezDW8S4Atg1D1dfLb14h4JzZON8hgI1Vg==
X-Received: by 2002:a05:622a:7295:b0:458:2607:d5a7 with SMTP id d75a77b69052e-4582607d83fmr65660641cf.43.1725819681975;
        Sun, 08 Sep 2024 11:21:21 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45830ec2d72sm3059221cf.41.2024.09.08.11.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 11:21:20 -0700 (PDT)
Date: Sun, 8 Sep 2024 14:21:17 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jagath Jog J <jagathjog1996@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: add bmi270 bindings
Message-ID: <2jvzk37rx3lx47j4p5sjl4xgzcsinog5mc5ew2nseos2fuqnhm@mj7wzzgwtdpq>
References: <20240906165322.1745328-1-lanzano.alex@gmail.com>
 <20240906165322.1745328-2-lanzano.alex@gmail.com>
 <20240907164743.1cb7070e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907164743.1cb7070e@jic23-huawei>

On Sat, Sep 07, 2024 at 04:47:43PM GMT, Jonathan Cameron wrote:
> On Fri,  6 Sep 2024 12:52:50 -0400
> Alex Lanzano <lanzano.alex@gmail.com> wrote:
> 
> > Add device tree bindings for the bmi270 IMU
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> Hi Alex 
> 
> One totally trivial thing inline. If nothing comes up in
> driver I'll tidy this up whilst applying
> 
> Jonathan
> 

Will apply in v3!

> > ---
> >  .../bindings/iio/imu/bosch,bmi270.yaml        | 77 +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > new file mode 100644
> > index 000000000000..7de35b9bfa2e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/bosch,bmi270.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bosch BMI270 6-Axis IMU
> > +
> > +maintainers:
> > +  - Alex Lanzano <lanzano.alex@gmail.com>
> > +
> > +description: |
> > +  BMI270 is a 6-axis inertial measurement unit that can measure acceleration and
> > +  angular velocity. The sensor also supports configurable interrupt events such
> > +  as motion, step counter, and wrist motion gestures. The sensor can communicate
> > +  I2C or SPI.
> > +  https://www.bosch-sensortec.com/products/motion-sensors/imus/bmi270/
> > +
> > +properties:
> > +  compatible:
> > +    const: bosch,bmi270
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +  vddio-supply: true
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      enum:
> > +        - INT1
> > +        - INT2
> > +
> > +  drive-open-drain:
> > +    description:
> > +      set if the specified interrupt pin should be configured as
> 
> pins
> 
> Even if they are configurable separately we've previously argued that
> it is very unlikely a board designer would want one open drain
> and the other push-pull.  So simply making the description plural
> should be enough.
> 

Will Fix in v3!

> > +      open drain. If not set, defaults to push-pull.
> > +
> > +  mount-matrix:
> > +    description:
> > +      an optional 3x3 mounting rotation matrix.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +  - vddio-supply
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        imu@68 {
> > +            compatible = "bosch,bmi270";
> > +            reg = <0x68>;
> > +            vdd-supply = <&vdd>;
> > +            vddio-supply = <&vddio>;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <16 IRQ_TYPE_EDGE_RISING>;
> > +            interrupt-names = "INT1";
> > +        };
> > +    };

Thanks so much for the review!

Best regards,
Alex

