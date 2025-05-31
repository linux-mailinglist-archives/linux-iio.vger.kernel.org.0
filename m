Return-Path: <linux-iio+bounces-20096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BAEAC9D20
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 00:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF2A1895B13
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398811DF270;
	Sat, 31 May 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zash.se header.i=@zash.se header.b="jJvRM59/"
X-Original-To: linux-iio@vger.kernel.org
Received: from dimidiatus.zash.se (dimidiatus.zash.se [185.97.32.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E3EEA8;
	Sat, 31 May 2025 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.97.32.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748729620; cv=none; b=M+YoGxQcKBWi6eJIG/NaVLYoyDmWNhF6j5eFMh9GP+frKGEnMigYDvKoDWHWmcAYYOF9UrI34oFAo5Lwt9BQHA6/NKzMXfHfsuKsytcSc9HHZe9kKAU12ArN/dKMF+8r+VVweJih0IaywZPA+P+2eCZ0GcYZU6W63SGmK8m4KRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748729620; c=relaxed/simple;
	bh=EufhE4khXJfcXaIToKySlWjWh0rkPLuopmauJx8nfF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a13PW8zFeYyHOhYcujEo5JyftGE6qiCSqEnlIBrWVRPSPaI8GSwizS1JAqiBa+FwY19NkrVP1FSNdgY7yRYujqoFJQBnAiwfWBeWzvbNa28TqeFCL8bpYNky7NiPVEG/72Uw1su4BsqXBel/K5Vt64UsYIk8K3ZFk/n/Z4wedr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zash.se; spf=pass smtp.mailfrom=zash.se; dkim=pass (2048-bit key) header.d=zash.se header.i=@zash.se header.b=jJvRM59/; arc=none smtp.client-ip=185.97.32.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zash.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zash.se
Received: from mail.zash.se (cerdale.zash.se [IPv6:2a00:66c0:7:1::cd1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	by dimidiatus.zash.se (Postfix) with ESMTPS id 958E719F5D8;
	Sun,  1 Jun 2025 00:05:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zash.se; s=2025;
	t=1748729105; bh=SVotxztx5CJUQc5mS0Q1kj0N0+zv2DMFiBjZ7PfRb3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJvRM59/TB7v+qAsievCIxoXPQ7HUOs3PNoXZWguAzaFIVEQ4j+Vt8ic2WdEiqYUt
	 YoyVBrWTNWYUq2fv4Vp1MVDL5P32SZnM8Ijsfw3PotFs7duJXUd3keVcrC1suyxuoL
	 CKicMw0Pn4wLfoqVyZZCzTSAqBt8eMwRsqlrkBTR6gTm1Ozm4C0RIiWfbQdd8kFp1I
	 PM9pfEruXnMlFUjEINDm3BN8l5ksFYLrZgcfQw/vAqJyUVcYxPEMQnOScNesLU1155
	 MAQYMfNTxpfzdbanXwUAhKrfzAJvFwxhREdN18a+OVxinb2aUs/85Z5MsYgsRuLxB2
	 63o0yD50N4XBw==
Received: from localhost (localhost [::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.zash.se (Postfix) with ESMTPSA id B4C376E0076;
	Sun,  1 Jun 2025 00:05:04 +0200 (CEST)
Date: Sun, 1 Jun 2025 00:05:02 +0200
From: Kim Alvefur <zash@zash.se>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: 1106411@bugs.debian.org, Stephan Gerhold <stephan@gerhold.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel NULL pointer dereference in bmc150_accel_core / RIP:
 0010:bmc150_accel_set_interrupt+0x68/0x120 [bmc150_accel_core]
Message-ID: <aDt9DrWxKOUZHQ3K@spisula.zash.se>
References: <174809774197.3242.15028356144506391196.reportbug@spisula.zash.se>
 <aDMuJsV4Mxb1IVoZ@eldamar.lan>
 <174809774197.3242.15028356144506391196.reportbug@spisula.zash.se>
 <aDnt9LkEZjb4DOO-@spisula.zash.se>
 <aDtZqwjKtpyguppg@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aDtZqwjKtpyguppg@eldamar.lan>
Jabber-ID: zash@zash.se

On Sat, May 31, 2025 at 09:34:03PM +0200, Salvatore Bonaccorso wrote:
>On Fri, May 30, 2025 at 07:42:12PM +0200, Kim Alvefur wrote:
>> So far it seems to happen on every boot, between unlocking LUKS and the
>> login manager starting.
>>
>> I wonder if this is related to another symptom this machine has, where
>> it fails to complete suspend and goes into a state where the only action
>> that has any effect is a long-press of the power button to turn it off.
>
>Looking through the boot log I'm noticing the following:
>
>> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:00: supply vdd not found, using dummy regulator
>> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:00: supply vddio not found, using dummy regulator
>[...]
>> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:base: supply vdd not found, using dummy regulator
>> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:base: supply vddio not found, using dummy regulator
>
>and iio-sensor-proxy might fail to handle then the bosch 0200
>accelerometer. You proobably cannot temporary purge the
>iio-sensor-proxy if installed by reverse dependencies, but might you
>try to temporarily mask the service and retest a boot?

That seems to have an effect, no "BUG: ..." in dmesg now, and the
machine made it trough a suspends and resume cycle.

-- 
Kim "Zash" Alvefur

