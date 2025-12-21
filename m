Return-Path: <linux-iio+bounces-27303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF39CCD4538
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D75B93007614
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1882877EA;
	Sun, 21 Dec 2025 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+LMxpIK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBA2FFDD8
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346998; cv=none; b=dYJG5YwYsdDSUi+4r6BXdbZjiWEl1u3j5eN+isnMv1xTwyYC9m3sFdbi9y/pOChyyxo+tgyDSuAoXwfXmPVmIrjT1IHBSaV9Ib85CxlkwxM/68+NWvA9uCpUsuvbMN8d32FX5VgiPw5Xtq/2JEPF936ExhVCbrHcUcOvwBRO/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346998; c=relaxed/simple;
	bh=Zg2cyqa43/fS38leRVp+Cmg9KBJTxkiqZ9lPUseRZvM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIjS0EafAGw672YpI//mTOa2/DXsIrSsT3moTX4V2BluegqiA/9NoIlwWlEjCHCH25N4oaT7QK+13466gBxz1kObPUBgQ6ti14ql0sM1m3dyGs7aKv0fQbjieNAl5oObWhYsPWWsn8GgibuinEBT2jOADkRdsuK8l6Iv2nuyv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+LMxpIK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so25297565e9.2
        for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766346994; x=1766951794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oanJNjBi0nhu6Fe7NXetWbEAkPhL+bUTYUyYexZzPZQ=;
        b=T+LMxpIKh1dcLBtuOMlBEal96W4YgLygV971/X+mll/ezZ/E2GKraZbjUJBomYYsCn
         vnLvs+YyrfR6GmK6L9JKEluMdDQEBvD6I8jDoFKVQm1Jfhesqbir0AEceAgfEykySaYr
         5ppc4mhL0a48zjl2rN1+YqtZDK9T+yy+Ne8iaG9Jb5N8cLipradLAVXrbMWxXfPm3Afz
         VIGluewzXI5pYtDYd18DQF+zVUYx95d6IH7Q97rqP5iORo14vrZjL6Q2W+Y0fiDquhDe
         0xOv/ClobM7/HxSpxtxC7EdRxtQAokp6AITfazpNSyLteZx2Kg3XAWVJ8w0W3wsxjDCT
         7SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766346994; x=1766951794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oanJNjBi0nhu6Fe7NXetWbEAkPhL+bUTYUyYexZzPZQ=;
        b=L7sA5qfecVAYJfYIiCgrl2kY1OiYpHR+ijo6FGAuvMJYQ9UdbZooobedc45IwWSXSu
         Tve53D5sfyDz1Rwg7YGrSbg4mZ3LYdQ3s86Vngfe0afwJzmA3RY50fu6atKQqG8mbalS
         LO8PF8YxkQcFYcAqF+JiPg2AeJhrlgpPKCIOgvXxEwMt1yqrOC0XLd2GGkgZiHLDsDzW
         3xNKmk0HmWxrRWKDJp2F4WB+RQJXbjvwHMG9c4Ghj0QvtojcVgcZkgHIk3Y3Crm6JIlR
         m+l/9LexikkvsXoGF0AecA1Y7FbmNS2kwAQizS9a2GY/GKmPgCHTgNOe3TmcgVVqLlTC
         bmTg==
X-Forwarded-Encrypted: i=1; AJvYcCUesu4oG8astnvS+8CM94rj5JpbMrmrV5OFdn/P1fIIqElT9+s+F3cLbg/a3WNeYOfPCTyrN37ENWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIFyy/PVDVQLe33evv4O4DGhXeeMhhLa5g3nEMuWrXEXkcX8G
	3awOInLFRR9b/vfoCRhc1ANmCOeWgxcvfkidzceGh3UGKabLULhpqWG4
X-Gm-Gg: AY/fxX7Sa6GYyBP5S34p0LKCw9AEcv5UV2XtgdteBLiAsaDihd0SQvelyNrfXWfgwul
	07cj8/vTE5juDLxQJ7l3X/y+QPeCw/q8PekFN2mrYEQa2zPyL0fVsQURbmQm+grVuUAPmso/J1v
	MiTlqUNBgCu6jyWoEgH0//fCp0T4feXfkLtUugrP/wExmjy9BwmjLPCVtQdecr1NuMV4rg80sfv
	04u3yNRtdr09SpAjqumzKCNi0Dxfyy8YTwKhlokZgkmPYN2NhH0NxSzrPWxdz4eCBs4xCWMFdz4
	54DvzyaJkzxa0oewUcYn7UuSQAw0R+/psy0Zb9xIl9r2jfXFVNFfJE/OOHUI6Z8RxQ0sCmMu+qW
	2m9Wt7h5VUuDwtbYVElv7VaIqNACK8CbtLlJUc9fyfbzO2pFzVH263I7TbLW5Sz+pvLrSsh79UI
	tXZFmGtk9880xB6aC6vHUOI430qOi7gDOBFxCg4Y7z7Rx/dtalw60TZCZqwRVRl6ALaBgDdoPd/
	6lk
X-Google-Smtp-Source: AGHT+IHwwBwTv7Y5lI87hzfx1K3wKJyr/X7181zxigbdOJRrLUvysf2AdPVllDEHu3OPucj3Mid0Tg==
X-Received: by 2002:a5d:5f90:0:b0:42b:3b62:cd86 with SMTP id ffacd0b85a97d-4324e4c38bcmr8908861f8f.6.1766346994214;
        Sun, 21 Dec 2025 11:56:34 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43264613923sm1327943f8f.26.2025.12.21.11.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 11:56:33 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 21 Dec 2025 19:56:29 +0000
To: Jonathan Cameron <jic23@kernel.org>, 455.rodrigo.alencar@gmail.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Rodrigo Alencar <rodrigo.alencar@analog.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: frequency: add adf41513
Message-ID: <s2dy34ui3ed3ay3yp4dpar3vysbg7mtksfmlboj7izoa7mt2uk@lxsrakxmvke2>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
 <20251219-adf41513-iio-driver-v2-1-be29a83d5793@analog.com>
 <20251220-bouncy-perky-tarantula-d9b3be@quoll>
 <gz36kmewv4bhwqz6d3xqatcx65uzukqcgsvfbwhr7c3yhw225z@edeggfhjws2h>
 <20251221155611.6af6ce1b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221155611.6af6ce1b@jic23-huawei>

On 25/12/21 03:56PM, Jonathan Cameron wrote:
> On Sat, 20 Dec 2025 18:05:34 +0000
> 455.rodrigo.alencar@gmail.com wrote:
> 
> > Hi Krzystof,
> > 
> > thanks for taking a look into this again. It was my first patch it didn't want
> > to draw more attention or discussion to the V1 patch as it was declared not ready
> > at its very first review.
> > 
> > On 25/12/20 10:21AM, Krzysztof Kozlowski wrote:
> > > On Fri, Dec 19, 2025 at 12:34:48PM +0000, Rodrigo Alencar wrote:  
> > > > dt-bindings for ADF41513, an ultralow noise PLL frequency synthesizer that
> > > > can be used to implement local oscillators (LOs) as high as 26.5 GHz.
> > > > Most properties refer to existing PLL driver properties (e.g. ADF4350).  
> > >
> > > What is "existing PLL driver"? I know about motor drivers, but can you
> > > drive PLL?
> > >
> > > And how is ADF4350 related to this binding. I do not see ADF4350
> > > compatible here at all. Describe hardware, a real one.  
> > 
> > ADF4350 is an older one, and its bindings can be found at:
> > Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
> > It is a similar part, but yet very different.
> > 
> > >
> > > Nothing improved.
> > >
> > > You ignored comments, did not bother to respond to them and then sent
> > > the same.  
> > 
> > Sorry for not responding on the V1 thread, but the previous patch had to be reviewed internally
> > first. It is not true that nothing is improved, in fact, it has changed a lot, here are some notes:
> > * adi,power-up-frequency is not carrying the -hz postfix because it forces to be a uint32 by
> > the dt-bindings check. For that variable it needs to be uint64 as the part supports up to 26.5 GHz > 2^32
> 
> What granularity is necessary?  E.g. Could -mhz work here? It's already defined in dts schema for MHz.

That is a good point, granularity is needed when we want to compensate for a
offset flagged during a calibration. That part supports micro Hz resolution
with the dual-modulus support, but that is something I cant have it here.
Since the important thing for this property is to have a frequency in a range
supported by the loop-filter/VCO design, MHz should be fine.

> 
> > * The properties related to the reference input signal path: reference-div-factor, reference-doubler-enable
> > reference-div2-enable are declared here because they are constraints for the PFD frequency definition,
> > which is the frequency that the output signal is updated, important for the loop-filter and VCO design.
> > * added support for all different power supply regulators.
> > * adi,lock-detect-precision and adi,lock-detect-bias-microamp: removed, now set
> > with adf41513_set_ld_window() following datasheet recommendation
> > * adi,fast-lock-enable: removed, faster lock detect clock is set depending on the lock-detect-count value
> > * adi,phase-resync-enable, adi,12bit-clk-divider and adi,12bit-clk2-divider: removed, now set with
> > adf41513_set_phase_resync(), based on the t_sync (from the datasheet: Phase Resync section)
> > value determined by adi,phase-resync-period-ns, which is also bound to the loop filter design.
> > 
kind regards,
 
Rodrigo Alencar

