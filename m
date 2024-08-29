Return-Path: <linux-iio+bounces-8885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF2D964E96
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 21:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B32B242CA
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A992F1B86C5;
	Thu, 29 Aug 2024 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoqN2EV6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39639FC1;
	Thu, 29 Aug 2024 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958921; cv=none; b=tAOHXNdsSSuM7EIy7QdvZNsUwabhq+QqKRB+xUh/egZJ2bl2VJLHQnlynMVUBquwvEuMD7+VZSPbgavIEVoQjLr7tF/KeQSh+0RDBa5S4rmyyvicQX35Ol+anQMw62OIA8+yB4kJoq7SaESfvZYoapefCEaK6HRZ31JtLmr6kAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958921; c=relaxed/simple;
	bh=VHRQ6wf9pASIVs0NmwnOb3Zk5nT39iYNBnojgSvFuB4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owbhehfy6NGiL4S1BxP0n9lRy+SIqhfttUZuOAnK58E02yBNo5l431Rrp25avnwgDRUGbFeX5NJ/74JiUafRb9KXJP3LS+T0POKhfCmro/XAYYLQf/gS5qVRkjusB7TNwPgQTebqVRuQlkqtvIx9PeMrCMi/HB1BujoGNlhlo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoqN2EV6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so1133924a12.3;
        Thu, 29 Aug 2024 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724958918; x=1725563718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQxMrVtFfx3iaAIR/DPAoViy1DT9cORfUF5Ff0JKuaQ=;
        b=AoqN2EV6srNL30eh5v9hHT7RCHwxiA3IQeuISV23ESr0rjm3+2Qkb4LxQOtS1vgWz6
         XjHRizGnWHYNXTPqnEzMWGA1Yo/WGmwE/HmmUZN3IkV4BVHxhCr1mc2KgdIfy0n5hMA5
         t0lu5jiqzErKpq3ra21fm1lbNYF2cqEPRCnvwnTuu3aqjZrgHbywIZHKDf4aRtCHLTV7
         rm41n+RDoobcKkcQfGqQqMtd5pLxnTOY9QhPgMltVIxBTo3orVdT6s9N/JUcAP40r8+z
         BvY6FT6kvM0DrB3CFvlXhjRBUiwZcMj5AuWztbiRsG6lhEaAA5jJyd9GUD4oVmcDHDzt
         J0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958918; x=1725563718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQxMrVtFfx3iaAIR/DPAoViy1DT9cORfUF5Ff0JKuaQ=;
        b=nwxhR7aSqDSZJsxQD7lFP17kUVYfopjHa7o2Ry66dUhuXT7CrnhhpwVvGNmvF1X4C1
         IZJ+5/Wc7RTMmLwHEewqfT6zdialnkH994I1ZOijO+hYsOhaS0M4ilHRYMn5+g0Wq76R
         kwq/u/INxbR+g6gWVjbDRWkxEAUbkMV2opY+aXgaFLNXK+jkkg2OByWgDml1JHm/npRi
         XxLZh7X0sTtHPHjINi2f/l7F33ZauhVh/QuggyzPpJkWTDC5a3edxMAKW3FIgrsyAIeI
         ugPDVWzJz8RnuUrqEg9EmMYC1SqsN9Io8BBo0yt1jTT99uU8TinCBUndj29qMCUegmqs
         WvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7hMlXQVZY2WD8QkBmkWik8XJJE1q8TNAZjajRDbdajfFgGiVYsL2gw8WJSIjx4DToL+oIItE9pE+X@vger.kernel.org, AJvYcCWLi4E3bNNIew9TZsoupPFzneI869Gu1ouem7OEDvbVn5xYv9Gry1+43NPxcu4uScEYJ1lVJpQxd/rkTq2T@vger.kernel.org, AJvYcCXRdjtbfxmWBAxKBX4PZJMjnqxuyiuV716D/NPhjQPRNaNIRtlNsZtEtL0eDgdv36BHUv3P4YgiG09s@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5it29THMrhKlJQKNG6QXyhm3TwpRcA37QOxXbQ9Sa7QCPXd/M
	o3cg029NbrnYBSqnDHzzp6gE1gq1ihm8vYtHf2GfCCNKWdMVuLfu
X-Google-Smtp-Source: AGHT+IEMEpVMwRHUID3qppOiNOjip0uISdiyTcHF26ujuUdsmlYKuybpxmku/4sDzekFVAf8pt6vig==
X-Received: by 2002:a17:907:7e88:b0:a86:b923:4a04 with SMTP id a640c23a62f3a-a897fa74422mr294061166b.50.1724958917156;
        Thu, 29 Aug 2024 12:15:17 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:f22f:934f:9b88:e7ce])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d7495sm110879466b.166.2024.08.29.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:15:16 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 29 Aug 2024 21:15:14 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 5/7] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <20240829191514.GD3493@vamoiridPC>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-6-vassilisamir@gmail.com>
 <fzdd26t5kjtwhvxxjq7k7ilbmx7i5r6phcygv5nlq2ajntlqht@pkt3kmr2hv6s>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fzdd26t5kjtwhvxxjq7k7ilbmx7i5r6phcygv5nlq2ajntlqht@pkt3kmr2hv6s>

On Thu, Aug 29, 2024 at 08:06:07AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 28, 2024 at 10:51:25PM +0200, Vasileios Amoiridis wrote:
> > Add interrupt options for BMP3xx and BMP5xx devices as well.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  .../bindings/iio/pressure/bmp085.yaml         | 22 ++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > index 6fda887ee9d4..edf5901c6c87 100644
> > --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > @@ -48,14 +48,34 @@ properties:
> >  
> >    interrupts:
> >      description:
> > -      interrupt mapping for IRQ (BMP085 only)
> > +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
> >      maxItems: 1
> >  
> > +  drive-open-drain:
> > +    description:
> > +      set if the interrupt pin should be configured as open drain.
> > +      If not set, defaults to push-pull configuration.
> 
> I don't think you implemented my comment.
> 

Hi Krzysztof,

Thanks for you reply!

Indeed, I totally forgot this change, I will do it in next
version. If you see the cover letter I didn't even mention it
there so I totally forgot it...

> > +
> >  required:
> >    - compatible
> >    - vddd-supply
> >    - vdda-supply
> >  
> > +allOf:
> > +  - if:
> 
> not:

ACK.

> 
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - bosch,bmp085
> > +            - bosch,bmp380
> > +            - bosch,bmp580
> > +    then:
> > +      properties:
> > +        interrupts: true
> > +    else:
> 
> so no need for else:.
> 

By default this property is considered false?

Cheers,
Vasilis

> 
> Best regards,
> Krzysztof
> 

