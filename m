Return-Path: <linux-iio+bounces-8765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4295DDC1
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 14:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CFC1C21182
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355E1714B7;
	Sat, 24 Aug 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aERqwiBh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409B154C1E;
	Sat, 24 Aug 2024 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501349; cv=none; b=tLdKqBSLbm8mcb9Dx6RDg9/43VfPCQREhRXNZtssK59xA6H8MK3ZB6tAK63t5DwjTR/ofHwGiBjUFU7r6okmQXfb6vpnjr5FfvlUVBV9IWut6myN9S3S8xnlN5gGRmNQW90R2vmt1Ip5hxAigM3VhvtWtCAB/0glM/ohLbNp5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501349; c=relaxed/simple;
	bh=/+jktZuYwzkTWpBIChCl+LRWbwotDiMea9Zn1vVSPA4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqelzvLZOFjfXmB8bp96epQmYIa88HwQHRjuZT9swpe4klPzEIh7EIBzfwa5AS8fRam13WHcxr1O+JfAdcXIN/U8BHRBHVvdop7BEp/X5tDJ+aNHSUWocwRVbIVQAw72O+ixorRP+U11wMBcpoWlQSftesWf6R31Yq8IGcPXpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aERqwiBh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8677ae5a35so309688866b.0;
        Sat, 24 Aug 2024 05:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724501347; x=1725106147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I18kqHK6RFkvR01e7jiU1ZtohyiwGdNcF6JR8v8pW7o=;
        b=aERqwiBh6gLa0JPUrqhC9202IiW78C0pNuiuGGhMHeIvnozzj6ySiAlzUolvncEUx3
         6Ka+zG7hEzpovlQj+5NUoZwYH+Lxvztt3UT0RO9oz0XRfgzUxGvN0EbZEK2JTcvDEV8t
         o/B1EMrxX/f1YuaVGCWkvg5tjkX1iw+0j0ANKSJhHN1m6ptFH8NBqZNPhrquFOymo8FP
         v70d4Q4sRUjhNHFSdtVCD38H73fEHywXxQCL+uZbhmb6tr2GJIB8JOAUhJdEmfxbiOhp
         jMnaNT9Hj/qEEfWAb82MSUVKMORO0HjS/3sL8Zjma2LUb4hp2r0h8tZNaIlU3e2LXPN2
         OviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724501347; x=1725106147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I18kqHK6RFkvR01e7jiU1ZtohyiwGdNcF6JR8v8pW7o=;
        b=o1TRIiDfv/zvYMtPLbYUCOygMvQg0eQGBsMbN1xaNeNrN4PyFB/pK7bbZU3nDp6H+q
         bmBd3od+UvOJEzyt/H2uFXdwkucslD8AvygyCDejGEvjLJL+FrK2aiF7SHav64K9FtQ8
         FUCbtJoLuTgoeslmkbswvrXjoO30TbBtkdjZ4D5cSFzgE5i0BBTalY7uYNIq9eGlMwyV
         8pmir/r5QvSDxnqm4ejPaNDyut7upYMPHw9YRJjP5Ts8vkZWkJPONnc29nV5jPYb23NI
         PlRCbRcm8rKV3ONKVkORPzV0wh/MhT7g/rqdpkIL922S4gfQtEMHm9siU/WgVxiQRwlG
         CqMA==
X-Forwarded-Encrypted: i=1; AJvYcCUvE2GHm1NET4S3Ltbv55wrkVKlewURQZ2QwzS0HnjnI076g5q1WUX5djpBX7s43fOlrT3yBpp9nZML@vger.kernel.org, AJvYcCVcGm5NYU5XvTYJQJaeUXti0UcyV8hp041JvPTqv456iUVI3Vilfu1n99dEFEHwm5mtY60FRAbG07HX@vger.kernel.org, AJvYcCVi0tRc/bL+a+zmMKTBMzqCrrwJ0faZXD/l0X96pCsB+crXtejEUX9uLV+w56KdK46B3iwBELxFZ8wtEeSo@vger.kernel.org
X-Gm-Message-State: AOJu0Yydh+X88DP0l7mOUqVTs79a1JWpx9jOv+43+ulOGlOtwj3zAXVU
	WN9FUkb9ny0Lp1Sp1Wwj+9hN89PDF3nCKZGAqRVU8sfiwnkluSfV
X-Google-Smtp-Source: AGHT+IF4AINRMvHDCHXiXVmcO42Se6Af9rT2yUSC6qYkv9jUdkPDbqLTBODHes5o23ICSTd5tjloWA==
X-Received: by 2002:a17:907:6d1b:b0:a86:99e9:ffa1 with SMTP id a640c23a62f3a-a86a54cca07mr354027966b.64.1724501346032;
        Sat, 24 Aug 2024 05:09:06 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9aa7:6f8c:e4ad:5d20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4360c0sm392299966b.108.2024.08.24.05.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 05:09:05 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 24 Aug 2024 14:09:03 +0200
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
Message-ID: <20240824120903.GI9644@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-6-vassilisamir@gmail.com>
 <TY3PR01MB1134611B456FEFAE4E4791CBB86882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20240824113128.GE9644@vamoiridPC>
 <TY3PR01MB11346D61FB9088AE3C5BCE2B686892@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346D61FB9088AE3C5BCE2B686892@TY3PR01MB11346.jpnprd01.prod.outlook.com>

On Sat, Aug 24, 2024 at 11:41:26AM +0000, Biju Das wrote:
> Hi Vasileios Amoiridis,
> 
> > -----Original Message-----
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > Sent: Saturday, August 24, 2024 12:31 PM
> > Subject: Re: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx
> > devices
> > 
> > On Fri, Aug 23, 2024 at 06:51:55PM +0000, Biju Das wrote:
> > > Hi Vasileios Amoiridis,
> > >
> > > Thanks for the patch.
> > >
> > > > -----Original Message-----
> > > > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > > Sent: Friday, August 23, 2024 7:17 PM
> > > > Subject: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add
> > > > interrupts for BMP3xx and BMP5xx devices
> > > >
> > > > Add interrupt options for BMP3xx and BMP5xx devices as well.
> > > >
> > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 7
> > > > ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > > b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > > index 6fda887ee9d4..eb1e1ab3dd18 100644
> > > > --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > > > @@ -48,9 +48,14 @@ properties:
> > > >
> > > >    interrupts:
> > > >      description:
> > > > -      interrupt mapping for IRQ (BMP085 only)
> > > > +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx,
> > > > + BMP5xx
> > >
> > > Since you have updated the description. It is better to enforce the
> > > same in conditional schema?? So that dt binding check throws error if
> > > interrupt used in bmp{180,280 and bme280}.
> > >
> > > Cheers,
> > > Biju
> > >
> > 
> > Hi Biju,
> > 
> > Thanks for the feedback! It is true that it would be good to throw an error in case the IRQ is used in
> > a not supported sensor. If you could point me to an example of another sensor implementing it, it
> > would be even more helpful, but I am sure I will find something :)
> 
> As Krzysztof Kozlowski mentioned it depends upon driver(s/w) or device(H/W).
> 
> if it is driver(s/w), then you don't need conditional check as bindings describes
> hardware.
> 
> There are plenty of examples for allOf:if:then: 
> 
> Cheers,
> Biju
> 

Hi Biju,

Indeed, I checked Krzysztof's mail later. I will implement it like this
since it is a device(H/W) issue.

Cheers,
Vasilis

> > 
> > Cheers,
> > Vasilis
> > 
> > > >      maxItems: 1
> > > >
> > > > +  drive-open-drain:
> > > > +    description:
> > > > +      set if the interrupt pin should be configured as open drain.
> > > > +      If not set, defaults to push-pull configuration.
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - vddd-supply
> > > > --
> > > > 2.25.1
> > >

