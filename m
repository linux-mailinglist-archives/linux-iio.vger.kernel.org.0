Return-Path: <linux-iio+bounces-27274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E2CD4284
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 16:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81A92300ACD1
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB982FFDCC;
	Sun, 21 Dec 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJzsxqls"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592512882AA;
	Sun, 21 Dec 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332584; cv=none; b=YBZGjTstqftV+uFoqDBzfhQdpC48Nd1K2Q856Twy3e07qOY3cltkIH+0zbH5l85L6ixLrOf6ErLb+nsO744dPo5kd2apuLuOPscsPx7X2igRYCoGTcA3EK4YV+vVA95Jok+boRjyGCKQcjBk70Rf+B1LzX6Ks2YdsZr+Br8pwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332584; c=relaxed/simple;
	bh=qnVAvPRptzueFsRVargTxO3Iuukt1Gi9CAOz5YCTYJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5F8buvHE8n58E8GZAHcH1Oz2GeEnyrPjTTpVQ2DTJStDZgR8BJloK6HhdzwSbUH6HQuzqhKyG6kV92Yd04bLpbT2/fspsvbA5424Ry29gWfUZZj10eDrIfS/kESa9484l4FnawLH4h2zZTMvuSfUYukdcY9QY503B3/Gid46Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJzsxqls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985EAC116C6;
	Sun, 21 Dec 2025 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766332582;
	bh=qnVAvPRptzueFsRVargTxO3Iuukt1Gi9CAOz5YCTYJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dJzsxqls1XqhcYhVOXKdD6WpRhIzScCbCZNz+t0RCMM1j4JJOLMG9Kmou4/sUi1uF
	 3xNpdzRF7hwXeeOOm5eG+RmfChnLIQLd5N850MY8uJQ1si4kXueqwG+Bd35/ezd71r
	 UGb99BQXnzzjEKMYHGo4DNGuZEbR0MXIyloctudRI00kFn3V2MgwrzoLx6MFy3MsiF
	 BRYQJhrV2Nbx+Cd6Ul+/2NE6y5yykp0aSQKPDn5FMmD1qS0htPZbWgvhequxwWI/fQ
	 HwZNISQS27ZOj3ccbi+XRlXGWU5O02h+ni8P47Mm1CcDk9cbrWxX/q6N5iDxqENbi4
	 UDFPmJQr2wF8Q==
Date: Sun, 21 Dec 2025 15:56:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: 455.rodrigo.alencar@gmail.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rodrigo Alencar
 <rodrigo.alencar@analog.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: frequency: add adf41513
Message-ID: <20251221155611.6af6ce1b@jic23-huawei>
In-Reply-To: <gz36kmewv4bhwqz6d3xqatcx65uzukqcgsvfbwhr7c3yhw225z@edeggfhjws2h>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
	<20251219-adf41513-iio-driver-v2-1-be29a83d5793@analog.com>
	<20251220-bouncy-perky-tarantula-d9b3be@quoll>
	<gz36kmewv4bhwqz6d3xqatcx65uzukqcgsvfbwhr7c3yhw225z@edeggfhjws2h>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Dec 2025 18:05:34 +0000
455.rodrigo.alencar@gmail.com wrote:

> Hi Krzystof,
> 
> thanks for taking a look into this again. It was my first patch it didn't want
> to draw more attention or discussion to the V1 patch as it was declared not ready
> at its very first review.
> 
> On 25/12/20 10:21AM, Krzysztof Kozlowski wrote:
> > On Fri, Dec 19, 2025 at 12:34:48PM +0000, Rodrigo Alencar wrote:  
> > > dt-bindings for ADF41513, an ultralow noise PLL frequency synthesizer that
> > > can be used to implement local oscillators (LOs) as high as 26.5 GHz.
> > > Most properties refer to existing PLL driver properties (e.g. ADF4350).  
> >
> > What is "existing PLL driver"? I know about motor drivers, but can you
> > drive PLL?
> >
> > And how is ADF4350 related to this binding. I do not see ADF4350
> > compatible here at all. Describe hardware, a real one.  
> 
> ADF4350 is an older one, and its bindings can be found at:
> Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
> It is a similar part, but yet very different.
> 
> >
> > Nothing improved.
> >
> > You ignored comments, did not bother to respond to them and then sent
> > the same.  
> 
> Sorry for not responding on the V1 thread, but the previous patch had to be reviewed internally
> first. It is not true that nothing is improved, in fact, it has changed a lot, here are some notes:
> * adi,power-up-frequency is not carrying the -hz postfix because it forces to be a uint32 by
> the dt-bindings check. For that variable it needs to be uint64 as the part supports up to 26.5 GHz > 2^32

What granularity is necessary?  E.g. Could -mhz work here? It's already defined in dts schema for MHz.

> * The properties related to the reference input signal path: reference-div-factor, reference-doubler-enable
> reference-div2-enable are declared here because they are constraints for the PFD frequency definition,
> which is the frequency that the output signal is updated, important for the loop-filter and VCO design.
> * added support for all different power supply regulators.
> * adi,lock-detect-precision and adi,lock-detect-bias-microamp: removed, now set
> with adf41513_set_ld_window() following datasheet recommendation
> * adi,fast-lock-enable: removed, faster lock detect clock is set depending on the lock-detect-count value
> * adi,phase-resync-enable, adi,12bit-clk-divider and adi,12bit-clk2-divider: removed, now set with
> adf41513_set_phase_resync(), based on the t_sync (from the datasheet: Phase Resync section)
> value determined by adi,phase-resync-period-ns, which is also bound to the loop filter design.
> 
> kind regards,
> 
> Rodrigo Alencar


