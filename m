Return-Path: <linux-iio+bounces-9566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35636979186
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C9F282E63
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E2F1CFEC2;
	Sat, 14 Sep 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAtiWB5m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552A21EB25;
	Sat, 14 Sep 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726324588; cv=none; b=Ivf6Z4LjW8dlyPmzwAWWTEqHaqcMy8zBGVhdZYGAkj/P6xcPUJQ8Nun24jv6bPVumZh+NRFUElxOIxe053lkqM3M+mlg1hfm5IKVs0smvjYJEZhq5d8tEqKkqFfqWRBDlWGjIQ2qjGr77wxdf99mTfQo9anOWrMEKn5b1NjcNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726324588; c=relaxed/simple;
	bh=iu5lyjFiJcGW+Jw0loQT62uGM9mK+8Mfiw+ad7RNzzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUhVvlhkKPFDlB4316S3lX8+NtgX4gOyj3jX4PZiY0M/aVULGqCVzp/knRMi9u7m+cLjjlWiSpqlkbaWLdScB9kbET7GHs8R2EQCNzC1Cyfi7hNQDwC6Ww0Pk/vaygqJDfE/Tcr2jtyadjX/Sm2zBCCh/C/oyMc7KRRuQ2b4o6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAtiWB5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6B7C4CEC0;
	Sat, 14 Sep 2024 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726324587;
	bh=iu5lyjFiJcGW+Jw0loQT62uGM9mK+8Mfiw+ad7RNzzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rAtiWB5mHUJ7IrISIaRqYWp2ozeMN3TwvTClGyFEe0Cglp/devev47YrywBQtZ7Gk
	 T1y98s58+YJJ462FHbLnWkDWc83btv7KjwRuFEIcRr1pCHK7ZqiOvFDFXPnNumkb55
	 rIissevl3nxIktPKxnWsRdaYLCokVW2Br69/mtr4wxUEGEwhuC/IwNg4oraZC5jYZS
	 4uPZy6gwkueQxLfBQGzRsoSUyM/HB0sVzua4y1m1lkBoeI/ZpOC9TcYmUFv6TLGhLz
	 7Z4eT5mq7ar6hhIrF/+FmXL0dm1FEMkTYeAa8FVmI+fVey+BQ3NBmLJKcpeTBP1Se7
	 LTP3BfWm+rppQ==
Date: Sat, 14 Sep 2024 15:36:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v7 0/4] pressure: bmp280: Minor cleanup and interrupt
 support
Message-ID: <20240914153617.3f816e5a@jic23-huawei>
In-Reply-To: <20240914002900.45158-1-vassilisamir@gmail.com>
References: <20240914002900.45158-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 02:28:56 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com
> 
This looks fine, but given outstanding comments on that patch I can't
take it quite yet.

Jonathan

> Changes in v7:
> 
> [PATCH 1/4]:
> 	- Use 5ms instead of 5000us in comment
> 	- Use USEC_PER_MSEC
> 	- Move parenthesis to make checkpatch.pl --strict happy
> 
> [PATCH 2/4]:
> 	- Remove interrupt description since enforcement was added.
> 
> Added also review tags for patches 1,3 and ack tag for patch 2.
> 
> ---
> v6: https://lore.kernel.org/linux-iio/20240912233234.45519-1-vassilisamir@gmail.com
> v5: https://lore.kernel.org/linux-iio/20240902184222.24874-1-vassilisamir@gmail.com
> v4: https://lore.kernel.org/linux-iio/20240828205128.92145-1-vassilisamir@gmail.com
> v3: https://lore.kernel.org/linux-iio/20240823181714.64545-1-vassilisamir@gmail.com
> v2: https://lore.kernel.org/linux-iio/20240725231039.614536-1-vassilisamir@gmail.com
> v1: https://lore.kernel.org/linux-iio/20240711211558.106327-1-vassilisamir@gmail.com
> 
> Vasileios Amoiridis (4):
>   iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
>   dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and
>     BMP5xx devices
>   iio: pressure: bmp280: Add data ready trigger support
>   iio: pressure: bmp280: Move bmp085 interrupt to new configuration
> 
>  .../bindings/iio/pressure/bmp085.yaml         |  22 +-
>  drivers/iio/pressure/bmp280-core.c            | 580 ++++++++++++++++--
>  drivers/iio/pressure/bmp280-i2c.c             |   4 +-
>  drivers/iio/pressure/bmp280-spi.c             |   4 +-
>  drivers/iio/pressure/bmp280.h                 |  43 ++
>  5 files changed, 612 insertions(+), 41 deletions(-)
> 
> 
> base-commit: fec496684388685647652ab4213454fbabdab099
> prerequisite-patch-id: e4f81f31f4fbb2aa872c0c74ed4511893eee0c9a


