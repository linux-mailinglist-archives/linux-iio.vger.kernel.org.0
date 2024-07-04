Return-Path: <linux-iio+bounces-7329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BBE927C86
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2183CB22A9B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFE0130A7C;
	Thu,  4 Jul 2024 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeB7kLdg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2C757E7;
	Thu,  4 Jul 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115416; cv=none; b=X5jMs4EDEeKg95rDKP/5wNy6d77LhZD64zUo2Sq1m1gcefxxHNeybRRtgZCmEXJ3sOjARF8gGaR5xmS86ntUr5mR2O4GWMYGfrRdfYIK5jXxw2KTUsbnAoa2dZ2mcxIvQBISP7A9FgN9RCol7JHRkW+m1kf8fIKkG8cO0LnHhxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115416; c=relaxed/simple;
	bh=Lx/lp8JyHRt6YZGLK+fFnv0bd7CXeMHcoelSaMDZAxo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dGuAQbJddbfugsHab68zB0UEUXUfs4ZjNybAc67sPeBT5kxAjGuMJLIM/SbMZBU6QF35rEUZpx7JWd1tQrx5Ik4SfLyKhOUxx4bJ2B+fcsXof8OJwrx1ad9LNoh3dq8uFb2nX97aDmIizdA2epiPNBY8V9qTrxyR0Wpaw2FTeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeB7kLdg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36740e64749so513618f8f.0;
        Thu, 04 Jul 2024 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115413; x=1720720213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvtJUrSM2HBk734fijihCAzifwC4hKlOHe36I6FHlJI=;
        b=jeB7kLdgaU8BPoAxw4T/qKKfCJrOu8LO9sId6pdb6mxuPf3/okuw2Y6+KHIWn2xAft
         xyR6t49J9KLaAq9ZKwrF1ptT5NFVurHbpW3JvTs3gVemGP2KYQIUR3PEDY9WlHq5DwEt
         Sfji8BIgB2+y4+y9KDI00wKt+fHWmj2x15Qew6QoteHQX1q/AuwDJdOBoBYI1onovt08
         3CRfxkX957RaURMi8HVLzB9/n0Tl4wylihYufcmMLf7SIajIuimsi+8Kh1m0YmPk+w+0
         8JdHnYiCHs3D4Y9vb2OOtFSEjD91ZVQnhiRSBdqyZwgr1QBmjmOoYmtH7dKOLC4aYTno
         mvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115413; x=1720720213;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HvtJUrSM2HBk734fijihCAzifwC4hKlOHe36I6FHlJI=;
        b=WrVzma3CRQ1sMwaVV9QB0job9EkacnxzDIbzvLUBpAXs9sEHHnnWlYIH7Msk+Mc2wM
         jgjbRQdP5uYRBdKrTE3RE49prgnjbBOD6Cm1uXz35rTbvGX+flONWkWXJKYQq1Urk81s
         lehsVAPUyWlVnUVIn9ywqt2DpU2+wqcWdNMg5W/0dV91wXXnFZRciIU4X1QXgukeu2QF
         VmNSgL9XSiUqsKVi1TFkuuB8qlHqZHAyqO9U7Tek8At83cUGZDdLn7LPsRcgkFo/UCaL
         ncbV6PMfDAuH13Q2hFmNEUHAPbBHEfX2bQF58vXemrlnv/ue1fKEV5TTFpTb1at7eSxH
         7tSA==
X-Forwarded-Encrypted: i=1; AJvYcCWquOyZbotNbU9uWcZPzlBifrdvQjUv7/ajXYMAYRon0Qd8zAM1I0NZv12h7Bhj0PaJ09Co0JSc95tSZG1HL8Y/4KDHEZgP7eOIeaNs6fdMb4YYClnGARspxi0jwJpsyUxQbH7BFc2c1G6/VlxnqnmXBb/8YouDow25mmezNq0o1BSrfg==
X-Gm-Message-State: AOJu0Yyp7Ssj6igoFfR3B1C+H3eh/o4LHY/2bYwWsJGEkScpl21jbsBj
	GrSqCJ853ZNPfK+GW3ecl0p7LSzyff5SgPPU1c6mx1byY9s9xBjf
X-Google-Smtp-Source: AGHT+IEF+so6LAM109TmVNF+G2wrprUUjvAbkco4Iu0FbniEyMnEafoMl9PkJLA9t6uwii0heiPddA==
X-Received: by 2002:a05:6000:aca:b0:362:def2:3949 with SMTP id ffacd0b85a97d-3679dd2958cmr1691831f8f.22.1720115413168;
        Thu, 04 Jul 2024 10:50:13 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36795d1fc9csm4358107f8f.83.2024.07.04.10.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:50:12 -0700 (PDT)
Date: Thu, 04 Jul 2024 19:50:12 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6686e0d41dd61_397df3708e@njaxe.notmuch>
In-Reply-To: <20240704-distinct-sulk-4fc97a9ddbab@wendy>
References: <20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com>
 <20240703-iio-pac1921-v1-1-54c47d9180b6@gmail.com>
 <20240703-bovine-thumping-c3747fd7caa1@spud>
 <668674271f02d_92937078@njaxe.notmuch>
 <20240704-distinct-sulk-4fc97a9ddbab@wendy>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add binding for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Conor Dooley wrote:
> On Thu, Jul 04, 2024 at 12:06:31PM +0200, Matteo Martelli wrote:
> > Conor Dooley wrote:
> > > > +
> > > > +  microchip,dv-gain:
> > > > +    description:
> > > > +      Digital multiplier to control the effective bus voltage gain. The gain
> > > > +      value of 1 is the setting for the full-scale range and it can be increased
> > > > +      when the system is designed for a lower VBUS range.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [1, 2, 4, 8, 16, 32]
> > > > +    default: 1
> > > > +
> > > > +  microchip,di-gain:
> > > 
> > > Why is this gain a fixed property in the devicetree, rather than
> > > something the user can control? Feels like it should be user
> > > controllable.
> > 
> > Gains are user controllable via the IIO_CHAN_INFO_HARDWAREGAIN. I also added
> > them as DT properties thinking that they could be pre-set depending on hardware
> > specifications: for instance by board design the monitored section is already
> > known to be in a particular voltage/current range (datasheet specifies
> > gains-ranges mapping at table 4-6 and table 4-7). Then, even if gains are
> > pre-set, the user can change them at runtime for instance by scaling them down
> > upon an overflow event. However, I can get rid of those gain properties if they
> > are out of the DT scope.
> 
> Usually gain values are left out of DT entirely, unless the gain is
> something set by the board, for example, whether or not some input pins
> are tied high or low.
> 
> > > > +    description:
> > > > +      Digital multiplier to control the effective current gain. The gain
> > > > +      value of 1 is the setting for the full-scale range and it can be
> > > > +      increased when the system is designed for a lower VSENSE range.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> > > > +    default: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - shunt-resistor-micro-ohms
> > > 
> > > You're missing a vdd-supply btw and the !read/int pin isn't described
> > > here either. I think the latter needs a property to control it (probably
> > > a GPIO since it is intended for host control) and a default value for if
> > > the GPIO isn't provided?
> > 
> > The driver does not currently handle the vdd regulator nor the gpio for the
> > !read/int pin. Should they be added to the DT schema anyway?
> 
> Yes.
> 
> > I think I can add the vdd regulator handling with little effort, my guess is
> > that the "vdd-supply" property can be optional and defined as "vdd-supply: true"
> > in the DT schema. Then the driver, if the vdd-supply property is present in the
> > DT, would enable the regulator during device initialization and PM resume, and
> > disable it on driver removal and PM suspend.
> 
> Nah, the regulator should be marked required in the binding, since
> without power the device cannot function, right? The regulator core will
> create a dummy register if one is not provided in the device tree, so
> you don't need to add any conditional logic around regulator actions.
> 
> > Reguarding the !read/int pin, the current driver overrides it with a register
> > bit so it would not be considered at all by the device.
> 
> We should fully describe devices, where possible, even if the driver for
> the device doesn't use it.
> 
> Cheers,
> Conor.
> 

Thanks Conor, I sent a patch v2 addressing these points.

Link to v2: https://lore.kernel.org/linux-iio/20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com

Matteo

