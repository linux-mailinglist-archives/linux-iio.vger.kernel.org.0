Return-Path: <linux-iio+bounces-18878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD9EAA1C6A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2D77A821E
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C084262FDF;
	Tue, 29 Apr 2025 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XQQZ67x3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125848CFC
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959617; cv=none; b=POZJ3nur05l4vgw5SV2ofoO4tAvQFFCwBmN80h6Kmqi6JliC7fN84/uH/KMAt2Vm3vRony7byyNBKordNkPxpqlLyyD8Q8O9MCp2K46DR3btGmUcesgk39lsvQGCO0q4AM9bPdEoP0z9cGXxnFvK69grL6p0rv1z/+lezn4TsFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959617; c=relaxed/simple;
	bh=D/9Y5YifH1074wJb/GS4vtYd+k1QQYAwDd3xbHbVoJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OreTnjrnTWMEQNU9qp3596C7wKWyHomwGyLGxkRR3HrgCQ2w1QiBpuOzOlqOv2X+zhXLl3M844b4uZtsCw8tXS6pEeQfzNw+Erg9vwIYLJX7DXCGBqHIC/lRR2mSxrGaPpWvr/wjGLQ3mf7Hhk70cs16Bmb6nCw4d8p2hwE6QFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XQQZ67x3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso28924295e9.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 13:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745959613; x=1746564413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZJ8j8Oe72qFBaNxqjkDCbDD8XAvsg/lPShitQQ2048=;
        b=XQQZ67x3sPK3FBhXBNJPT15x8eb/HfFmjOKB3VNN3UWQRaAIhFahpAW/1LpPWUQFlu
         qlZ1cTf06rzXsooNIQF2TsU0tIBaechMrDiGt4b4hoeoujBUlgUH5ugB3l0p+tBjbgIl
         7i9WsDR0Ib2kBwCTtnEeD12eE0xzrQZh6u7/xm7xVCrNmIk072axrKDQvoUPHjkK9+aR
         +tR+dkPwvwgbZdQdUssw9/PzjABwZbeKEdZdAf2oOhNGz1ILaB+I+12IzFfczLgeux4d
         BDbiCSvljvXJk2l5VT7I/fpwgbrXo4VksucOZUq10fkiWx+h4LTV7vI7HcEgfSymq2tq
         SWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745959613; x=1746564413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZJ8j8Oe72qFBaNxqjkDCbDD8XAvsg/lPShitQQ2048=;
        b=JPOF/CFgQORCynVby+UP6BtM1l0KJ8Pok/m0zWatxdQ6nzVF/bhGIxZJxCdjsD0icL
         VPNoyRpTgXWlXaS2aOnxILdSCau7f7Q1kF+qz2vDG5g2eL+fTp5Bp8JbO6Iuz2TBRjwn
         XgyxRk+iJMIxGmDFCJLO+5Un6k6jKpMLR6973s4YvMeQxPn/q8/wMQ8QatNiLYPusyOH
         J1+6He5z65urwXOLvFnKzf0R5BR8kPlpXImZQIe2kXjb0q17fu57ghH9Q5IWqYMZlwEf
         IqjMOYi9DLc+jA1YcJtYdVhVDWS+C3WCZ67AS2cAJLu0NesU53+GLyCN1wCP1hmBrnCs
         21hw==
X-Forwarded-Encrypted: i=1; AJvYcCWctqLK007DleYl9Qal/Zeya6blsr/RPA0I4B1TCXLL8ZwbSZIhMz/zlNd6x1mVRulHNs7NrljhvPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylLe8LSWjNmB9AdedEbwLgGfqDH2yIE1CL66AsTfZh55e63Tcq
	JZ4WdXoPilALVVu2Yh3P1B4DyxcM7V7aLY/J3HsHeoi3322uMJnMGvmnnMMws54=
X-Gm-Gg: ASbGncsgBDpZtoRbr8q+SmCQpUvvzQXyzAlCr3Z0Wmzuyqwr4kL4J8g5Ou6kiB4haYh
	LhbWrpcfxN1qH8x0GwdO+nBc1vh8Bl9/Dhy3CBpstADtLQa7MiF4vqb1XSYdQfAb0EnvMASTorG
	N03K+s2+97EE4NDpV5Yx0l3OmicmzNlr6khE8y20lP5gG4H1XFThNwPiZjALw2aFGv9DjpO+ezT
	XUJo/HJAc7R8YRSYQ1Ck6YhdwPmkx+ge7GdBTxRNfr0h94h1oIGcCGLWO8S4rA8FYbVJezJLGwC
	uCii4kfSp25rs5OnJCvMJsz4SFTuiY6r29wTSXQYegoF5xiSQyEOzUHxpt3+tOEO3vn9eGaP6kt
	CJCrnwWA=
X-Google-Smtp-Source: AGHT+IF9bv2cflSgAvGwtlEqK/Tpat8aDUtOYB8YNh//4MAjWZJ7TTuhWab4KG2FTzCSpSxKDA3ETQ==
X-Received: by 2002:a05:6000:4014:b0:3a0:7a5d:96f8 with SMTP id ffacd0b85a97d-3a08f7a2755mr614243f8f.31.1745959613249;
        Tue, 29 Apr 2025 13:46:53 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2afc6b3sm80455e9.31.2025.04.29.13.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:46:52 -0700 (PDT)
Date: Tue, 29 Apr 2025 22:45:39 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
Message-ID: <uyreqaazupbt23vmf3pwxsaneimtahsuinlfmc77aaavt4nyl6@yofmvw3rndtx>
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-4-eb4d4821b172@baylibre.com>
 <d13e3671-9330-419c-acf6-97f33060116c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d13e3671-9330-419c-acf6-97f33060116c@baylibre.com>

On 29.04.2025 10:26, David Lechner wrote:
> On 4/29/25 8:06 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add gain calibration support by a per-channel resistor value.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > index 29f12d650442b8ff2eb455306ce59a0e87867ddd..df30545fb52c89a814257443183303775a06a7f2 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > @@ -204,6 +204,15 @@ patternProperties:
> >            considered a bipolar differential channel. Otherwise it is bipolar
> >            single-ended.
> >  
> > +      adi,rfilter-ohms:
> > +        description:
> > +          For ADCs that supports gain calibration, this property must be set to
> > +          the value of the external RFilter resistor. Proper gain error
> > +          correction is applied based on this value.
> > +        default: 0
> > +        minimum: 0
> > +        maximum: 65536
> > +
> >      required:
> >        - reg
> >        - bipolar
> > @@ -271,6 +280,10 @@ allOf:
> >      then:
> >        properties:
> >          adi,sw-mode: false
> > +      patternProperties:
> > +        "^channel@[0-9a-f]+$":
> > +          properties:
> > +            adi,rfilter-ohms: false
> 
> I think this is in the wrong place. It would allow this property on ad7616, but
> ad7616 does not have this feature.
>

Looks like it cannot work on ad7616 due to

  - if:
      not:
        properties:
          compatible:
            enum:
              - adi,ad7606c-16
              - adi,ad7606c-18
    then:
      patternProperties:
        "^channel@[1-8]$": false


But maybe an additional patch should be added to add also adi,ad7606b
to the above enum.

Regards,
angelo


 
> 
> >      else:
> >        properties:
> >          pwms:
> > @@ -398,6 +411,7 @@ examples:
> >                  reg = <8>;
> >                  diff-channels = <8 8>;
> >                  bipolar;
> > +                adi,rfilter-ohms = <2048>;
> >              };
> >  
> >          };
> > 
> 

