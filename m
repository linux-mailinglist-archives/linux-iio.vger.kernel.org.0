Return-Path: <linux-iio+bounces-8760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1EF95DD92
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 13:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4745A28360F
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3710158DC0;
	Sat, 24 Aug 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHb8og6o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1014B95F;
	Sat, 24 Aug 2024 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724499094; cv=none; b=kFpgAoPWBiziwz5kLp/er/LUpzMKgQFDYxzmW8GkkSFiPzGPp8UaTNNLl10KBNKHtROqG4rrEKP0enZ3bL+mH+4553ra7n+0b0h5388pQWEpQrO1nmTrKM0U+Kb3q0BcPxXbgGUExwC3zFOA1SsQ2eX0PMwNSxbnXOtdVkCFqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724499094; c=relaxed/simple;
	bh=ThHD8zDv0vojce1ofH6jtqbW/0GjZORcewvnfM0b/vs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G33dVvyD8EWZczFo2mx5bb5OkqmdUU9mqRIZca2c4+b92Dkb1Gyknccei97cIii0wzZ88RdSNvRVwKvRyOd8IP5ZrWiufiuO56FgnvstpXstX+nVCmjwoyLsL02grlWVNsHmHeAZkrimIPQhDge4j6QlKr07uJzCmelhWXCk7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHb8og6o; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3719753d365so1448985f8f.2;
        Sat, 24 Aug 2024 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724499091; x=1725103891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m54M1zlmUQXtcPtkOe8IWbYbJxf0X6iLjt94I4vXh1g=;
        b=PHb8og6ofBSBIgHfmJvALnCGoAsT2rf+kS7ARP5nAA+rMRGhsy1XRv6cKGxzDvHQCN
         ZS/+564hu9haUEfD0cB1aMN0iuUZbvrzIZDyrJSNQ7IEdb7B+a9l3/f2Lg3tGsqtLUeZ
         oPcAkJ2UuG+6roY0sWhlcDpoW2haVPm9p7PauSBnzqkJmd1gAj5R+WTl7XzM1uLyc7N5
         CuchRKp3wF2uEA8cBJEJnuTfw1O3y297hBXn+HUHQ6IW0jelGnHawQs+chLOqHi19XU2
         AY/w0x9PDG9eQBVK4xHoYRf63K6v7ry+Vt+620/m7SPeJ1V9ohxIRELzKUEgaGrHYeFa
         CSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724499091; x=1725103891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m54M1zlmUQXtcPtkOe8IWbYbJxf0X6iLjt94I4vXh1g=;
        b=HLAOWT4jzJzNXeLMtgUf4XYmq9KPq86HLgySRNfm+wepUTWX/ykHG4iB2YxBWynVIq
         aNZFkZyei7sKxg9c4G23a++M2LRIrIAIIs9k3hbcaMP2dDwkYbK3xu8q1gvJkaaJtVT4
         xc/MAOi5JWzwOQAzmfCsbqyyyeAQtLHo5ANhIzyTfZ9znMWo5sIFbTBZ/ag4qaq8S4hw
         Uzz5LacxXgFdFA+zxtqEnk5+WYrFGmQVlbvMYXkARp9qBuEWmlXJG693jzgKejHcWDY3
         pBIFHRR+oVK3yyghUwMgykiu8L3TIylnQ6y74Xkpoy7Udx6Bo6fo+QYuEinqASV4jqnV
         xdng==
X-Forwarded-Encrypted: i=1; AJvYcCUT/EoqGR1X7o6dWsKf1rSFDSaqCEipflvIf1i2nJW0p1R4PWAe6jQXOGY1drf6JzoAbQni01VFrx55@vger.kernel.org, AJvYcCVa/3JOw50S4dejxAYDi+/rOePPokSxMO0jnA00bGfhkaug9gkDcxOBe4S8CXod5ANtNuqhNH2PDq+6rFfd@vger.kernel.org, AJvYcCVoItuisvGQ9eA/7j1oIT3vP9mRfjP5f+NWm5lB5p+rSmg4AIDWAYI9qBRtcNqkEzINN5PbP1wgiffm@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0pk1G8B125TILWXux/r6m5r8GCY9U32mrKCgj5N9oNWtn5fg
	ID0WVAv5Qus3FHebpa/Y80s0c4AkVI6iWf7djG+E0nSsUOOWqO8K
X-Google-Smtp-Source: AGHT+IGBZ+Uo4kEK+IfLwxlpX6zxCFWLchVLNEzHizWRlJuWsXPsV3+HbQZaAIq0CoRUkYRLW+tssg==
X-Received: by 2002:adf:efc7:0:b0:367:8e53:7fd7 with SMTP id ffacd0b85a97d-373118b9961mr3819008f8f.28.1724499090783;
        Sat, 24 Aug 2024 04:31:30 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9aa7:6f8c:e4ad:5d20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef8175fsm126124965e9.25.2024.08.24.04.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 04:31:30 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 24 Aug 2024 13:31:28 +0200
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"ang.iglesiasg@gmail.com" <ang.iglesiasg@gmail.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"javier.carrasco.cruz@gmail.com" <javier.carrasco.cruz@gmail.com>,
	"semen.protsenko@linaro.org" <semen.protsenko@linaro.org>,
	"579lpy@gmail.com" <579lpy@gmail.com>,
	"ak@it-klinger.de" <ak@it-klinger.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <20240824113128.GE9644@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-6-vassilisamir@gmail.com>
 <TY3PR01MB1134611B456FEFAE4E4791CBB86882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134611B456FEFAE4E4791CBB86882@TY3PR01MB11346.jpnprd01.prod.outlook.com>

On Fri, Aug 23, 2024 at 06:51:55PM +0000, Biju Das wrote:
> Hi Vasileios Amoiridis,
> 
> Thanks for the patch.
> 
> > -----Original Message-----
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > Sent: Friday, August 23, 2024 7:17 PM
> > Subject: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx
> > devices
> > 
> > Add interrupt options for BMP3xx and BMP5xx devices as well.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > index 6fda887ee9d4..eb1e1ab3dd18 100644
> > --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > @@ -48,9 +48,14 @@ properties:
> > 
> >    interrupts:
> >      description:
> > -      interrupt mapping for IRQ (BMP085 only)
> > +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
> 
> Since you have updated the description. It is better to enforce the same in
> conditional schema?? So that dt binding check throws error if interrupt
> used in bmp{180,280 and bme280}.
> 
> Cheers,
> Biju
> 

Hi Biju,

Thanks for the feedback! It is true that it would be good to throw an
error in case the IRQ is used in a not supported sensor. If you could
point me to an example of another sensor implementing it, it would be
even more helpful, but I am sure I will find something :)

Cheers,
Vasilis

> >      maxItems: 1
> > 
> > +  drive-open-drain:
> > +    description:
> > +      set if the interrupt pin should be configured as open drain.
> > +      If not set, defaults to push-pull configuration.
> > +
> >  required:
> >    - compatible
> >    - vddd-supply
> > --
> > 2.25.1
> 

