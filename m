Return-Path: <linux-iio+bounces-9109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9FD96ADE6
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 03:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D881F25727
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FADE6FB0;
	Wed,  4 Sep 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmFEEmAn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43239B;
	Wed,  4 Sep 2024 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413438; cv=none; b=eufStTsK9N0KCo/1X81G8EvplaNnx8/m661UR0RX93M/12Y6da4IUCHYRmsV5wzGA6wAqso275yg+WJrDI9l5XUjIyD7DOeoAP4/s6qeC9w+ZR6xxcC9QTpPp1PRsuijvJLrHMBVYkPaqWiRsD8w6f0sl08p8VfIMHZiiCng+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413438; c=relaxed/simple;
	bh=gRinerk3YO57PrYqsyeulhZUbYiZ/3O/3y600X6jKms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAU097oTHrV8qAKgvdqMMVYH7A0orUWVXECqkigeeUEFIrfVg43s4Xj4/6LfJWl2whGtBy/b7UCDUDTs/dbzwcTubQyZZXU07fOtp+wwzRE1X/NvTHvoDEE9xEeE9Wm8nnlX3Rl9VFUkLF5fpIHV/OjaYMlspzGfaF6mDzDpBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmFEEmAn; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a7fd79ff71so369426485a.2;
        Tue, 03 Sep 2024 18:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725413435; x=1726018235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUDWBfDPwOA/VgaP4aogYQGiN+MlQh7A7or/qZYGH0k=;
        b=SmFEEmAnGW4wmawo43BC7n/Yj4VBRfGq6d3vypmeHi6OSpOUa7ncRW9Z78k7N5lk0R
         JpbtMko+At4ldLOzmpcHlb9QVBY+Xm0poaZt6pGUO8S09IUEYj42hX3cvKBK78B4JoGw
         R2jBjeBCf//hIKpGX0+nb4YUleXrUzUaozhUvXfvZBuz17g2X6doUgWMwSTmRbqVH3LV
         JwYehhDZwE1BzEzboJZh9lo1bSKUQbwnJgGG4R1pDuMS8RygOr+7sCVYKmaSgaUD1p5L
         bE7dKcodQuiKkotVn5l+FH7pYCjHdGcc9Zwrkb7siODYzIhpBxRddPk5235SBs0ngONw
         d3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725413435; x=1726018235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUDWBfDPwOA/VgaP4aogYQGiN+MlQh7A7or/qZYGH0k=;
        b=XZjmKU2oZuDw52pVgmxFgU2yiZLuZ5oP3ShdMOEiyTEN1t3R/IaQ1MS9flwkI11DmQ
         Q/AKbkoDahbd7wsithhtJvJ0sGthhk3V3hj/o75tOowJPLFJlr2ZzwlY3EDb6SUhEeYk
         TMUvu5B854hp2Nk488OVI2V8pwPnlQdqCHDwXp8wEcuZBG3xIeGnQJSBVJViO9bJwMVa
         YsBhGWIKjrAuFnVYOduQHlN5osuxGErm6HuLRNpgF2/2UkRGIfT7XSpd++I8dEArE05M
         c6Y7bQrN5NyTeOKhIP6NqVilhdbOjm5BjQCOKyuQcqAYPVarOykEnfteJ6khzvFkW2bS
         onUw==
X-Forwarded-Encrypted: i=1; AJvYcCUUbbvmBfWlLhlXQe45JwjRMYLDVSIrYK0QonMzikGgyWvZSsAuHCycFeTdk4Sn3lJYj8W9gl6VPMwnoJLK@vger.kernel.org, AJvYcCWWqF2bl1TraKlcSeP/ou/M35XEWUNyyWqEvQyRLy235rUZSnl+hCxuctwaheqceLFgvmRyvr+kW+LT@vger.kernel.org, AJvYcCX7uH1IoOj7y1iesFgfGb4JEhF5PsEtoCzZr2FoF3kbFwjeGOCPcfD/avJ5jd1rOVjdO56GskLs7Geq@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+LXSgJFRCDv+QdeUPy4eUZ+aDMVBotwFPEaqBpSaAZWlXHdd
	BI5tbPv8ptCDCJORiA4tX0m+7BGHgPwFygNjXlZVfeLxHwFyzYDX
X-Google-Smtp-Source: AGHT+IH9eq13+WSQDbX8eIF1F279+H2bD9PJ+pUzCKnKPL5LtgAS4xiaGL2SxveUWNwR4CQsb6WrBA==
X-Received: by 2002:a05:6214:5c4a:b0:6c3:6e6f:7953 with SMTP id 6a1803df08f44-6c36e6f7c6amr67456106d6.19.1725413435098;
        Tue, 03 Sep 2024 18:30:35 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340ca6529sm59335416d6.110.2024.09.03.18.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 18:30:34 -0700 (PDT)
Date: Tue, 3 Sep 2024 21:30:32 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jagath Jog J <jagathjog1996@gmail.com>, Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: add bmi270 bindings
Message-ID: <rs6yoe6j3jkjpgvqkr57gtwp44iyggjdh5dahctcparmuiv7ar@j5gbjsktnrkr>
References: <20240901205354.3201261-1-lanzano.alex@gmail.com>
 <20240901205354.3201261-2-lanzano.alex@gmail.com>
 <y43rxkvcg5fnvef2pezzg5ckotqvfs2io6ohungfdpd7abcfm5@z62ruivg6p35>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y43rxkvcg5fnvef2pezzg5ckotqvfs2io6ohungfdpd7abcfm5@z62ruivg6p35>

On Mon, Sep 02, 2024 at 09:21:33AM GMT, Krzysztof Kozlowski wrote:
> On Sun, Sep 01, 2024 at 04:53:23PM -0400, Alex Lanzano wrote:
> > Add device tree bindings for the bmi270 IMU
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> > ---
> >  .../bindings/iio/imu/bosch,bmi270.yaml        | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > new file mode 100644
> > index 000000000000..44534ef36378
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > @@ -0,0 +1,80 @@
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
> > +      open drain. If not set, defaults to push-pull.
> > +
> > +  mount-matrix:
> > +    description:
> > +      an optional 3x3 mounting rotation matrix.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> Device can operate without power provided?
> 

Will fix!

> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        imu@68 {
> > +            compatible = "bosch,bmi270";
> > +            reg = <0x68>;
> > +        };
> > +    };
> 
> Keep just one, complete example. You miss here several properties.
> 
> > +  - |
> > +    spi {
> 
> Not much differences in this example, but if you want to keep it, then
> make it complete and fix the node name,
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Best regards,
> Krzysztof
> 

I'll make more complete examples in v2. Thank you for the review! Much
appreciated.

