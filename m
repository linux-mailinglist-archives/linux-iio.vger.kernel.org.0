Return-Path: <linux-iio+bounces-7310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4949273A2
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 12:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C35288DBF
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B81AB8F7;
	Thu,  4 Jul 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpMk3Rqg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62918637;
	Thu,  4 Jul 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087596; cv=none; b=TA6haB8t3YxjbeDRtIz8KrRsCnFKOUOCi1yCiOkjYbLb9bxN/zOR3TeFDwF/FexekW8frG6uG31vzu0Q3n6St5gdyiLcaEsNoyt/CczItuh8qLfio/+7T7udbRGBazupZwjdWyM12m5GqyvtAJzAyWk5pWkVp84zHqOFnkK1IpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087596; c=relaxed/simple;
	bh=tSzlOKj7J16zKhWQxfbOxXq2j9lBM1d7lqleazh6Vg8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EGymL35WxyTGG8k+xp2Txg8Q7ZqZPGyBVHtaeUrwl1K+upad8FdeMCoFWbOjtrSPBqYNhe07GtiEMyDBy3IFrRaR55ITCWxl0vdLXckVJbU/qh2LUGFNJbc1u8uZ/6cjx6ejfBmu9RFrxcOHSq45xRIyzsyD7RjrYpC2MA4828A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpMk3Rqg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4264a3847b6so3092305e9.0;
        Thu, 04 Jul 2024 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720087593; x=1720692393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlIjn4Ntu69O5x5oWoN15bYcnfbMpOVbMNKPzZXPEAw=;
        b=NpMk3Rqg8GlGcbPkt3gXCMgSGDbkVv1W8gf9lGP7do+v1ej5fgLVnwytRamp6erN7x
         RSdELUyeBmjfT6eijkKjvvJf1J17u/19bp8PBFxrNKgkleLy839PNrqLzL4STYsBa3cS
         EncvX3ocUpKSHw6SBqHTd3J5VMVZcRoTjc81k9jRas5v72ELlZV9Zbr/W10yRfWQbK6d
         OhxJJrQPCT66R6g721MDNeRO/FaJ4MNE2AogXYJmo5q7kzqbvGjgP3rmz8gBUjkC9WsX
         K80W4tPJUSjniFvL17bKspwtLGdfW9edLQulDQU7EEIW7dbRfASZoF1g2gTgQiZ0jEN5
         YBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720087593; x=1720692393;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WlIjn4Ntu69O5x5oWoN15bYcnfbMpOVbMNKPzZXPEAw=;
        b=wxBzxEMIkuxk8CMnDmpIH4LEO//0nn3M8xTLb9Ph7QQcGZP2qXTYpp4pipR11KWz2+
         duR1PAgsjHD5b8c36sEB7TGsCU5bL/lu48lalA2N0goa4f1h75UmhvE9NxpkouyfBonz
         VVHMIBxiYAYS7IzqHQXoUijdrjdP+QRPzaaVJt0skLtKElCTxK94se+VxXzZXnuUbUcH
         yNHRd7UuaXL+Rf7hsXoPFOjLxoq9HpIrARlr/CbTn03oEEAMyMJSB2zIviZOk6mmBa3b
         Jz5hYaHmd6gG+NfRlInPiTcD6iwCytumvVuH2RxNS9VH+GxSfpqDg4WnKQbBJrELXEVy
         Q4eg==
X-Forwarded-Encrypted: i=1; AJvYcCV9ymb+aWXfEiNkMDQGTJB/Q09MC78a2ZHRTUKEQCvLfPc5lqAD6PqO/j5Gc7x0xcK+CoeanbOFQkLCoWkfD8eSsIGL/Gwi1S6FDLZqhsCG/NRpDwHLyJC3bhLpFgkUDGjTmG6NhNQRTTqxCxFI2Whas9fIPAfvnz27wxwFKRb1tNLKbw==
X-Gm-Message-State: AOJu0YzM6M8Oh40Sg7Au4RBFniXn0Y5DLIx5j6yblNdxPbEMNp7enERd
	RSwEUjvCH1PtdprsVA0o2OKFmi/IsJTdWtPWkLJLZwIpY5zGckIp
X-Google-Smtp-Source: AGHT+IFz93kR9vhi8ICmWkFiLx7dTQqOBD/dGHu72Dday1rvCW+zLBePP+YmKjm2UF0fS5UbinrlDQ==
X-Received: by 2002:a05:600c:1ca4:b0:426:4765:16f7 with SMTP id 5b1f17b1804b1-4264a3dc17fmr8529705e9.21.1720087593190;
        Thu, 04 Jul 2024 03:06:33 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1e8014sm17597385e9.21.2024.07.04.03.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:06:32 -0700 (PDT)
Date: Thu, 04 Jul 2024 12:06:31 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Conor Dooley <conor@kernel.org>, 
 Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <668674271f02d_92937078@njaxe.notmuch>
In-Reply-To: <20240703-bovine-thumping-c3747fd7caa1@spud>
References: <20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com>
 <20240703-iio-pac1921-v1-1-54c47d9180b6@gmail.com>
 <20240703-bovine-thumping-c3747fd7caa1@spud>
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

Hi Conor, thanks for your feedback,

Conor Dooley wrote:
> > +
> > +  microchip,dv-gain:
> > +    description:
> > +      Digital multiplier to control the effective bus voltage gain. The gain
> > +      value of 1 is the setting for the full-scale range and it can be increased
> > +      when the system is designed for a lower VBUS range.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 4, 8, 16, 32]
> > +    default: 1
> > +
> > +  microchip,di-gain:
> 
> Why is this gain a fixed property in the devicetree, rather than
> something the user can control? Feels like it should be user
> controllable.

Gains are user controllable via the IIO_CHAN_INFO_HARDWAREGAIN. I also added
them as DT properties thinking that they could be pre-set depending on hardware
specifications: for instance by board design the monitored section is already
known to be in a particular voltage/current range (datasheet specifies
gains-ranges mapping at table 4-6 and table 4-7). Then, even if gains are
pre-set, the user can change them at runtime for instance by scaling them down
upon an overflow event. However, I can get rid of those gain properties if they
are out of the DT scope.

> > +    description:
> > +      Digital multiplier to control the effective current gain. The gain
> > +      value of 1 is the setting for the full-scale range and it can be
> > +      increased when the system is designed for a lower VSENSE range.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> > +    default: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - shunt-resistor-micro-ohms
> 
> You're missing a vdd-supply btw and the !read/int pin isn't described
> here either. I think the latter needs a property to control it (probably
> a GPIO since it is intended for host control) and a default value for if
> the GPIO isn't provided?

The driver does not currently handle the vdd regulator nor the gpio for the
!read/int pin. Should they be added to the DT schema anyway?

I think I can add the vdd regulator handling with little effort, my guess is
that the "vdd-supply" property can be optional and defined as "vdd-supply: true"
in the DT schema. Then the driver, if the vdd-supply property is present in the
DT, would enable the regulator during device initialization and PM resume, and
disable it on driver removal and PM suspend.

Reguarding the !read/int pin, the current driver overrides it with a register
bit so it would not be considered at all by the device.

> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@4c {
> > +            compatible = "microchip,pac1921";
> > +            #io-channel-cells = <1>;
> > +            label = "vbat";
> > +            reg = <0x4c>;
> 
> Order here should be compatible, reg, generic properties and then finally
> vendor ones.

Thanks, I will fix this in next patch version.

> 
> Thanks for your patch,
> Conor.
> 

Thanks again for you feedback,
Matteo

