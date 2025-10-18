Return-Path: <linux-iio+bounces-25225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0849BED1F4
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24A824E5D47
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1651C84C0;
	Sat, 18 Oct 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjjhC76e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A027462;
	Sat, 18 Oct 2025 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799862; cv=none; b=nZIaO5wfvc3zBFSdMWpW5CDxKcgL7/KSrz6f3yL/WjFecCZyeso54UsbsUqx60+Lnu4ewSy31YUVrzvweThN6HKivSh7+jz49Jg7kTgKMUjMHOytjaxKgH44JWvbca40kv0NQrVONzt4tD7B83e6IEAmJdEGe3Rm+3lwIDQCBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799862; c=relaxed/simple;
	bh=mto8f88gLALMyI3SNVJ1Ul1TkcLFVZc2m0V1CadkF+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqli1zPYoL1fCp4LnXBKFPgHUFLVxzCcb84uybrVPy2FZnSKL28Yq2KdtK+5ZPJUPI+en0S6hP8HLWwI5FpSG490SQUckX3BKubyjnoC357E112/PxKRbSXpKuGuE9Ctf7Tw6nVsz/M1bfFVEcfDQg8xC9yYUl34TtaKBVGlq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjjhC76e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A95C4CEF8;
	Sat, 18 Oct 2025 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760799861;
	bh=mto8f88gLALMyI3SNVJ1Ul1TkcLFVZc2m0V1CadkF+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MjjhC76e1DQoBOd3H6v/7l94fVoDLbKfgOAFk+tpRDkkKZvPfHcQmFnkXOjXSG+fi
	 nHTQNBFiQwD7V532Qb873EHrUhjI7UdRqDTdBY/Sg5zHYDeTxUFJWgrGltGnlMPCDh
	 OpD03YIq54oQYc3wtk8ljd1GBXj9v81b5ATNRGpLUP2r08rApa6IN3LyxQP/VSpHMl
	 QQ1Gv1zSfiLxeZq10g4wlRp/pqDJ99lD81SeNVjY9z2aLcmeSaeCMWF71G1b4XwDno
	 4kXicIKFP+4JbNfGcZ9gfy2W5f+bsMRlV5eYDPxrj1KzDH1n5Bbs4+BMLtrSPxTFw8
	 DPL2CftoKjdlQ==
Date: Sat, 18 Oct 2025 16:04:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 matt@ranostay.sg, skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 0/2] iio: health: max30100: Add DT LED pulse-width
 support
Message-ID: <20251018160400.6921df6c@jic23-huawei>
In-Reply-To: <20251012173035.12536-1-raskar.shree97@gmail.com>
References: <20251012173035.12536-1-raskar.shree97@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Oct 2025 23:00:33 +0530
Shrikant Raskar <raskar.shree97@gmail.com> wrote:

> Add Device Tree support for configuring the LED pulse-width of the MAX30100
> sensor, and updates the driver to read and apply this property. 
> 
> Testing:
> - Verify DT property read successfully in probe().
> - Verify default fallback to 1600 us when DT property is omitted.
> - Confirm SPO2_CONFIG register programmed correctly using regmap_read().
> - Validate different DT pulse-width values (200, 400, 800, 1600 us)
>   are applied correctly.
> - Validate probe() failure for invalid LED pulse-width
> - Tested-on: Raspberry Pi 3B + MAX30100 breakout board
> 
> Changelog:
> Changes from v2:
> - Fix DT binding schema errors
> - Add default value
> - Remove changelog from commit message
> - Add missing header file
> 
> Shrikant Raskar (2):
>   dt-bindings: iio: health: max30100: Add LED pulse-width property
>   iio: health: max30100: Make LED pulse-width configurable via DT
> 
>  .../bindings/iio/health/maxim,max30100.yaml   |  8 ++++
>  drivers/iio/health/max30100.c                 | 38 +++++++++++++++++--
>  2 files changed, 43 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 8bd9238e511d02831022ff0270865c54ccc482d6

Applied to the togreg branch of iio.git and pushed out as testing for now

Thanks,

Jonathan

