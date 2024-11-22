Return-Path: <linux-iio+bounces-12521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07689D654F
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 22:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C418282CC8
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 21:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF8118C342;
	Fri, 22 Nov 2024 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSE51Zl6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344D18A6A0;
	Fri, 22 Nov 2024 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732310120; cv=none; b=rhmoS5x7Cx+ICHCtQgAtZw6btiEmkwWms4HMwPFAF06Dyi1pv4Hi3KSumjNYzzYg++HfoahHlV6b6ONSpTPC0TApMcyYz19IDs6eUGqSrgvw5pUiHN8eZ1n4uPWgAr5pwODjk4bEHA2driW2odDqCUxqDuDMRT5rk9F+b4b2XXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732310120; c=relaxed/simple;
	bh=4/YDe675pVnrrBlYEttfxz/L5BbHy6IRkdPgRnnpD6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkFilwZaxj8m93Zb98+yWEVnhd8sQ4qejmRuisynI/KbDut0Q6ReKZ3moOw3KZhRW7QfCXxOSZZUpuLNqgnCzAb1uOQNqg18ss2DNI1a6xtFuRNZoaapbz2HiFjkh/GOAE/OIY8vYcxw2zuswTBI/Nsps+jMUbmWc1vc/17B9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSE51Zl6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7246c8c9b1cso2124830b3a.3;
        Fri, 22 Nov 2024 13:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732310117; x=1732914917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jx2SCif3e101Gi5CwalnwFl0MPZKa7kOAbD7PkIQFes=;
        b=kSE51Zl6tGf2t/+74o8Pcy112YkExhRviXY7hiU9hoJkTu1S0jfZJ5sFci8PvxDofQ
         R5bEb54KRVbFzi0pxcdEUcLfjzGHgTrlmU+mspqEktLjU2843eRTofRVIynNTNWTaQWQ
         UVZotO+AHQChNdhTAi7xzvU1mFUC9uavDafJ9xQi2Q6enNKeCpjd8NXXyvgHCSIJAk0h
         ON2hCSd0+7/hNVJ1kJpKjmEhqL3RjqTTBjcug2GC0bp4ia2CQf1orAuYcG8ilPV7Kyrl
         euTHNG8sZ+ne1x84SxITkiaJQLKfc0w8EszvbUEGgF2ztCNWC18trkSFXXFZup8f4jgG
         93nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732310117; x=1732914917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jx2SCif3e101Gi5CwalnwFl0MPZKa7kOAbD7PkIQFes=;
        b=c1QaKR425JqlmHWJhC1btfAs51ogWx57rznkNdRR1tVuOwfzpF7pKhwa7qALqHAzqw
         LSwrpq1adxUn8xVcULN+Zj7PbO9UOUYFn1rT5IZdA7rHi8WzTe23uUDp9Iy9yrcdYrPR
         W+G6PTN7L3vUIRrjtES38COvGpCfbXzHBoxj1lJEMQQdRRoxpuHczNqInU96i77/lglG
         ZpqJkOPMb3sL6wfjzyIm0R6wvZwOZ0dtD5CQgxVmrKSOhH42+6g/TE7dHF5vV9p0Mwcv
         nCn7GkzJWk1LXQUgOYc3zqaU2Fdby2druigDSYzAbWmiJ5WbuXn5zdgg9DgNKh7In0/M
         cMgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV58j0629QYsynumHGsvfFAVEiYUpRM2kgv1x6f4hnZWd+foMJT7iZMth1eGQZ7QmMnegup/jtu/E5F@vger.kernel.org, AJvYcCVFAz7NEec662l3RHeE8GLOruRLqB2Nk6aGOV8Bizq29/L74q+Q/QdjxsjxvStfwooU60UMlVsBWSbI@vger.kernel.org, AJvYcCVNrdym3UeHM7M9Bm4YLWRtirCGg8YOO7Hin4rdrophu7kENgxtEb20JV4D3X77L81gwdjogcuYJUdeKoPP@vger.kernel.org
X-Gm-Message-State: AOJu0YzIo3IPskXu8Nywb2i4c/756KQhcylON+IIkJypWMmOMqL7q0w7
	lsftm11qQbm+vaWF9pUJHf+KBDSg6utC38+zz7iP8bC/YBwToTqC
X-Gm-Gg: ASbGncteCEjHafPZUpbCb2Xn1+EMafauHzZj6JFA4Ng2vrBjNa3HFYbH8xFI3bZFf2l
	f+n9tX/WMeUS3ViPzaQkAvRMRm/PVtr17h4jh2rLPCQk/VIEA0B7h+2c9bxG6p5VrbAsjwqvVXC
	YvPyYgJSGHGGsQclos7rbliShxno2h8VXRRCpcOZQZqBjbS6blrSjZ2uA+k/TGYG6YuKjZ9cgKq
	ezvX970kRV9H4MYxpta3RH3xPi/QLXFTf95Ms7Mn/EZvKLQkshXTNFUCsvB
X-Google-Smtp-Source: AGHT+IH7/jpBJ2OnVZ+XCy4Ja2Z9VdwiKqeRO4mlB65zIruYkBzxnBrS0QicPUPnrUa5VOlTC5QxYg==
X-Received: by 2002:a17:902:f54a:b0:212:3f36:d992 with SMTP id d9443c01a7336-2129f611c49mr62202345ad.49.1732310117403;
        Fri, 22 Nov 2024 13:15:17 -0800 (PST)
Received: from localhost ([2804:30c:1618:9800:694b:286f:2b3a:5414])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8d478sm20764335ad.33.2024.11.22.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:15:16 -0800 (PST)
Date: Fri, 22 Nov 2024 18:15:39 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Message-ID: <Z0D0e6mNKlVAXp0z@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1732020224.git.marcelo.schmitt@analog.com>
 <dd7fd54585e1230d2da86b5e3d4ed770256b0af2.1732020224.git.marcelo.schmitt@analog.com>
 <5kz6ghe56yiprlvhyduv7olcrajvejyvulcpjav6doiyvr6dcl@6qlt4nebp4gb>
 <Z0CkOTGhGhfV18OG@debian-BULLSEYE-live-builder-AMD64>
 <a311de1b-cd59-4f67-9bd1-61596a54c8cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a311de1b-cd59-4f67-9bd1-61596a54c8cd@kernel.org>

On 11/22, Krzysztof Kozlowski wrote:
> On 22/11/2024 16:33, Marcelo Schmitt wrote:
> >>
> >>> +      - items:
> >>> +          - enum:
> >>> +              - adi,ad7942
> >>> +          - const: adi,ad7946
> >>> +
> >>> +      - const: adi,ad7983
> >>> +      - items:
> >>> +          - enum:
> >>> +              - adi,ad7980
> >>> +              - adi,ad7988-5
> >>> +              - adi,ad7686
> >>> +              - adi,ad7685
> >>
> >> Keep alphabetical order.
> > 
> > Do the fallbacks declared here have any impact on the match try order or on how
> > the compatible list should be ordered?
> 
> I don't understand, we do not talk about fallbacks. I also do not
> understand at all how this relates to my comment.

I was wondering if the arrangement in which compatible strings appear in dt doc
could be used to suggest the sequence to add them to the compatible property of a
device node in a dts. Apparently, the arrangement of compatible strings in dt doc
has nothing to do with how they can appear in a dts file. Will sort them in
alphabetical order.

> 
> > The only significant difference between each group of devices is the sample rate.
> > A faster device can read at slower sample rates so if somebody knows to have
> > a 16-bit pseudo-differential PulSAR but doesn't know about the exact model they
> > could have a compatible like
> >       compatible = "adi,ad7980", "adi,ad7988-5", "adi,ad7686", "adi,ad7685",
> >                    "adi,ad7988-1", "adi,ad7983";
> 
> Can't you autodetect this?

There is no way of detecting the maximum sample rate other than the compatible
string or, maybe, running a data capture.

> 
> > 
> > to try from fastest to slowest device.
> > The dt doc would indicate that order in the fallback list?
> >       - items:
> >           - enum:
> >               - adi,ad7980    # Fastest 16-bit pseudo-differential ADC
> >               - adi,ad7988-5  # 2nd fastest 16-bit pseudo-differential ADC
> >               - adi,ad7686    # 3rd fastest 16-bit pseudo-differential ADC
> >               - adi,ad7685    # 4th fastest 16-bit pseudo-differential ADC
> >               - adi,ad7988-1  # 5th fastest 16-bit pseudo-differential ADC
> >           - const: adi,ad7983 # Slowest 16-bit pseudo-differential ADC
> 
[...]
> > 
> > writing-bindings.rst says "DO use fallback compatibles when devices are the same
> > as or a subset of prior implementations."
> > But, how can we use fallbacks properly?
> 
> How DT spec and tutorials like elinux ask... What is exactly the problem
> or question?

Never mind. Do the bellow follow the preferred syntax?

      - items:
          - enum:
              - adi,ad7980
              - adi,ad7685
              - adi,ad7686
              - adi,ad7988-1
              - adi,ad7988-5
          - const: adi,ad7983

      - items:
          - enum:
              - adi,ad7688
              - adi,ad7693
          - const: adi,ad7687

      - items:
          - enum:
              - adi,ad7982
              - adi,ad7984
              - adi,ad7690
          - const: adi,ad7691

      - enum:
          - adi,ad7942
          - adi,ad7946
          - adi,ad7984

> 
> > From Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml I'm
> 
> How LVDS bridge is related to this one here?

Aside from having compatible fallbacks, not related.

> 
> > inferring only one fallback should be provided per group of devices.
> > 
> >>
> >>> +              - adi,ad7988-1
> >>> +          - const: adi,ad7983
> >>> +
> >>> +      - const: adi,ad7688
> >>> +      - items:
> >>> +          - enum:
> >>> +              - adi,ad7693
> >>> +              - adi,ad7687
> >>> +          - const: adi,ad7688
> >>> +
> >>> +      - const: adi,ad7984
> >>> +      - items:
> >>> +          - enum:
> >>> +              - adi,ad7982
> >>> +              - adi,ad7690
> >>> +              - adi,ad7691
> >>> +          - const: adi,ad7984
> >>> +
> >>>    reg:
> >>>      maxItems: 1
> >>>  
> >>> @@ -133,6 +178,32 @@ required:
> >>>    - ref-supply
> >>>  
> >>>  allOf:
> >>> +  # Single-channel PulSAR devices have SDI either tied to VIO, GND, or host CS.
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - adi,ad7685
> >>
> >> Why do you need this? It's fallback is already here.
> > 
> > So dtbs_check can provide an error message if for example compatible = "adi,ad7687";
> > and adi,sdi-pin = "sdi";
> 
> 
> I mean this compatible, not if clause.

dtbs_check don't show an error message if the allOf list only has the fallback
compatible for adi,ad7685 and a device node has both 
compatible = "adi,ad7685" and adi,sdi-pin = "sdi".

The new set of devices that will be supported by this binding don't have a
configuration register like the previous ones did. Because the PulSAR devices
don't have a config reg, they don't support all features of AD4000-like devices
and thus fewer IIO ABI interfaces are provided to user space. Though, AD4000
devices also can be wired in a way that no reg access is possible, in which
case they provide the same IIO interfaces that PulSAR devices do. The difference
is on what is connected to the peripheral SDI pin. When AD4000 SDI is connected
to SPI controller MOSI line, more interfaces are provided because the config
reg can be accessed to set additional features. But that is not an option for
PulSAR devices. Even if controller MOSI is connected to a PulSAR device, we
cannot provide the additional interfaces because every attempt to use them would
fail (the device has no register to configure). No datasheets mentions
connecting a PulSAR device SDI pin to a SPI MOSI line. All datasheets show
PulSAR SDI pin connected either to VIO (high), GND (low), or controller CS.

IMHO, it would be nice to have dtbs_check warn about invalid SDI pin
configuration otherwise it may only be noticed on driver probe.
Anyway, I'm also fine keeping only the fallback compatibles in the allOf list
if that makes dt maintainers happy.

> 
> 
> 
> 
> Best regards,
> Krzysztof

