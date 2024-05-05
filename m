Return-Path: <linux-iio+bounces-4824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6D48BC356
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 21:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B227B281C0A
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D68B74427;
	Sun,  5 May 2024 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4iEXlVw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4766F06A;
	Sun,  5 May 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714938378; cv=none; b=qycwqr+u2IZYFJX2R0c6D+2wd7dICvVlqarPg/CtDW6tzof0rPUlmjbSvvBfaEtnQrutiTygff8R1sFXXOy3kekBzous67Mtl93IWLcumd/UGGo6r4vF30jWF9YMuCBVKivZvhVTPJ/R7k1t2EYlIiMQOjDsanJwECbQG3mQn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714938378; c=relaxed/simple;
	bh=0xWVR+hZm1hbLhnVuDoCeCqqADDcUffOxV9wWM5nJTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPC7gUBe4DuoBZwMtD4eBrpAIUrlUP8y+stme7myudLiJ1xTmS0B8ZBCsr9TNpmPVOV9uCDdcWi0SvtjzkUD2bCRxh8hC741Efa3r5kGIZ23nG32xi9nTdb2H7oLXqxBa+W98qmvLAW+wa85+U24bpqxmufLBeIx/bLDVb7sCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4iEXlVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D52C116B1;
	Sun,  5 May 2024 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714938378;
	bh=0xWVR+hZm1hbLhnVuDoCeCqqADDcUffOxV9wWM5nJTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E4iEXlVwv03Q1LXj60ldMa3YKet2nlH76YkVFc6V/+H3oTyRcrtr/hnRfT4zgZtUn
	 PKfGNdrVT/CDB9d63NfQAMPH/ZARA8WyU5wSqWm9r1S1TyBPpBg1njo4jNvwEUf71A
	 MUKNRGjwhWP4hxiM/x8/vRKT+FMhCH+61w1ktYgp6yZFAlKuABTmEeV52YNJC7Idn9
	 Xdcp4dPyJchJ9EolLB5C0HK/RK9gsAS62/txGmeFN/dvX+4UWUFFX9gQ/fWRPOO1Kq
	 yJxkRtbsWW5MN3cRYbzb1uFpYELxY+59/qO91D5lDlskT2dWReVNfK8ch7zd5gINQU
	 SFdQT2E8h8fcg==
Date: Sun, 5 May 2024 20:46:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v7 5/6] dt-bindings: iio: adc: ad7192: Add AD7194
 support
Message-ID: <20240505204602.5d4cbfa0@jic23-huawei>
In-Reply-To: <20240430-winnings-wrongness-32328ccfe3b5@spud>
References: <20240430162946.589423-1-alisa.roman@analog.com>
	<20240430162946.589423-6-alisa.roman@analog.com>
	<20240430-winnings-wrongness-32328ccfe3b5@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 18:21:01 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Apr 30, 2024 at 07:29:45PM +0300, Alisa-Dariana Roman wrote:
> > +      diff-channels:
> > +        description:
> > +          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
> > +          appropriate value from 1 to 16.
> > +        items:
> > +          minimum: 1
> > +          maximum: 16
> > +
> > +      single-channel:
> > +        description:
> > +          Positive input can be connected to pins AIN1 to AIN16 by choosing the
> > +          appropriate value from 1 to 16. Negative input is connected to AINCOM.
> > +        items:
> > +          minimum: 1
> > +          maximum: 16  
> 
> Up to 16 differential channels and 16 single-ended channels, but only 16
> pins? Would the number of differential channels not max out at 8?

May not really be limited to 16 differential. Many chips use general purpose
muxes on both sides so you can do all combinations. In practice that's normally
pointless.

A more useful case is to do all but one channel as positive inputs and the remaining
channel as the negative for those 15 differential channels.
This is effectively the same as doing pseudo differential channels, but
on more flexible hardware.  This is in contrast to a device that only supports
pseudo differential where there is a special pin for the negative
(this device has that as well as full muxes on the other 16 lines).

Having said all that.  The ad7194 datasheet says 8 differential channels..
I have no idea why though... Maybe something to do with the mux switching?
Or maybe assumption is that if you want to do pseudo differential you'll use
the pseudo differential mode rather than wasting hardware?

Jonathan



