Return-Path: <linux-iio+bounces-25268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5172ABEE308
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 12:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9293189DA95
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7D286412;
	Sun, 19 Oct 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8iRxkLn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CDC42050;
	Sun, 19 Oct 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760869914; cv=none; b=gflEFubhoozyauDpWj5ZfbjfG6hDgkagRAS+ZQ1vMjZ5HIjFO9JbAuVDYhsMtp0lY/JLKv7cLQVYiFjSHTHJLWSsZ8oOoEDbmFcTZ+yiDsNLfWfPSfTawczUMJEWZ+1FUWx8mCt9I4Gx/t5gzlk8W0KbaWFDDYRXRDgU36NUKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760869914; c=relaxed/simple;
	bh=LyPEy4ugtfxqZrSZMV/k9dsM19/kGVJqW5tGmrcvErU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SosExk4xD+pG9+tZrhW3Kmz0wOMBkyfPonyGYC/DHh1XylEaw/dSWlaL4JBk1m/tMtvolbz2dtsD1QHkSftFu09az+ugCBxNVjuKbwbYdOKm3+UUS3maLnV8spHmIjhz1tiuZFNpX0DjLUQxzCwFkeLIpatEun2rbsFBzDZinH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8iRxkLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FF2C4CEE7;
	Sun, 19 Oct 2025 10:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760869913;
	bh=LyPEy4ugtfxqZrSZMV/k9dsM19/kGVJqW5tGmrcvErU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e8iRxkLnoXwMqbFe1gxSQDTtQ/zD5Uab+Re6Wx2SXnz5THkSQrZuvpsaed9tQtC44
	 ebPvGFY5oGq2eviqYbHT84DADw+4lrEETDMvxUoYW9mCv7OvWM5Sogn2u714tR859d
	 6OBc9/b+pFzIsP3+8+Ts4+F66rVNToHRAYkBNkRodRW3CZZgN/5QNnc7J0haRNxtDY
	 /xD65oTuDfn+iSagikrCEs65pB2VijyCnBccGUajGrjkGEkrofPLVowlTb14XptjOP
	 TAMF2NyFwzjyybp5n5X2dFlx1S5lscYKpVDB/5XcEy6iqXuR/vr05ohBbipUTgEJPK
	 pHBuugGf0H3AQ==
Date: Sun, 19 Oct 2025 11:31:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Guenter Roeck
 <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/2] Adding support for Microchip PAC1711
Message-ID: <20251019113146.74c3f236@jic23-huawei>
In-Reply-To: <20251015-pac1711-v1-0-976949e36367@microchip.com>
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 13:12:14 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> The PAC1711 product is a single-channel power monitor with accumulator.
> The device uses 12-bit resolution for voltage and current measurements and
> 24 bits power calculations. The accumulator register (56-bit) could
> accumulate power (energy), current (Coulomb counter) or voltage.
> 
> PAC1711 measures up to 42V Full-Scale Range.

Hi Ariana,

For devices like this where the datasheet explicitly calls out usecases in
power monitoring e.g. for "Portable and Embedded Computing" (amongst other
things) there is always a question to answer wrt to whether the correct
place to support them in Linux is in hwmon or IIO. Note that, whilst this
has long been an informal policy I've become more strict on this after some
concerns were raised in the last cycle - the presence of similar devices
in IIO isn't necessarily a sign that was the right choice, but it is worth
looking at the history of those divers as it may provide more insight into
why they are in IIO.

To address that we ask that:
1) Drivers for this sort of potentially borderline device are +CC to hwmon
   list and maintainers
2) A justification for IIO making more sense is included. That can be
   based on what cannot be supported in hwmon (high speed capture being
   a typical item - that doesn't seem to apply here as it's only 200 sample/sec)

Anyhow, I've +CC relevant folk so if you can reply with that info here then
that would be great.

Thanks,

Jonathan

> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
> Ariana Lazar (2):
>       dt-bindings: iio: adc: adding support for PAC1711
>       iio: adc: adding support for PAC1711
> 
>  .../ABI/testing/sysfs-bus-iio-adc-pac1711          |   57 +
>  .../bindings/iio/adc/microchip,pac1711.yaml        |  195 +++
>  MAINTAINERS                                        |    8 +
>  drivers/iio/adc/Kconfig                            |   10 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/pac1711.c                          | 1448 ++++++++++++++++++++
>  6 files changed, 1719 insertions(+)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250901-pac1711-d3bacda400fd
> 
> Best regards,


