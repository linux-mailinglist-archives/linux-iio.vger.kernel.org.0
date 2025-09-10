Return-Path: <linux-iio+bounces-23961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802A1B52029
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC88484030
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40AC26CE26;
	Wed, 10 Sep 2025 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jod+0eqH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DC19E97A;
	Wed, 10 Sep 2025 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528323; cv=none; b=uq+6b77JcwWSy6PSDkDAn7/wkuIqNFi8wocRrlSzkTLZux/VLb0tNP6UcWK95kwgCMl8oWJHN80kmQ0mTIS4ICLtEa0I/OjvsFVEYDc5zdGYTEx0AXsdENR/subfOZgn5ljucl4eW7WQSVdxjHT8rKcAWOTkLr6PlZy1X/N0OvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528323; c=relaxed/simple;
	bh=O/tH+Gn/02Eni4fXZFe3weLi71ZVLKbDdQuvcMp3yeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFlfbgGtvJOg8v6v0TQXICI4j5KvF1zRfTb7ZHjWXOADO3fIpNx8n0blhvpWPDlxY5sWguOawhh5U693IQ8bjhFTCGxATT7rm5+Wjsp1dejc2gv19LCsKAK7j1yRri2v7QekRzmxeejxC2tVwO+T2aOOD69Jn4LnBUlnIJNMQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jod+0eqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818D5C4CEEB;
	Wed, 10 Sep 2025 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757528323;
	bh=O/tH+Gn/02Eni4fXZFe3weLi71ZVLKbDdQuvcMp3yeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jod+0eqHrjgTZN4vEvGL6mPtJHBXCRJexVWIyNqy0l0bTMFrT1pnfZP9o7mlR+6uB
	 qRwhgX8ynm2NXemq8DwasOI/kajxf4QRgn4eBRwtlVqdcmxelK8rGTLzHXwQB9qVWI
	 6NDcy+GNjp56PVLHQ0ZAbG0ZF4WYHWeQj6J3u6mbENoaQPf0+fstHvW8JIW2FQt47D
	 Syw1+NQMVghcCfoXjniHgyHZ1RvK3MRaZySDEzWSPrPm/VWiNktfQpMILqVzKnNbEt
	 VzCjpqF9FaTsekdUyb5pVT0dpEiRNpNQP2dtkEBh1li2oRdZw3hP3Fxc1EQICNVH58
	 PYOV9V+1+Hyhw==
Date: Wed, 10 Sep 2025 19:18:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] iio: accel: bma220 improvements
Message-ID: <20250910191833.7c0e20b2@jic23-huawei>
In-Reply-To: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 10:57:05 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Series of patches that switch the driver to the regmap API and add
> i2c connectivity.
> 
> Tested in I2C and SPI modes with two different sensors.
> 
> Event-related code was skipped since the patch series was getting too
> large.
> 
> Contains fixes based on feedback from Krzysztof, David and Jonathan.
> 
> First time pushing with b4, crossing fingers.
Worked nicely as far as I can see.  I should try it myself at some point.
I've been using magic finger memory to format patches for far too long :)

Anyhow, this is coming together nicely.  Don't rush a new version out
for a few days though to give others time to take a look.

thanks,

Jonathan

> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> Petre Rodan (14):
>       dt-bindings: iio: accel: bosch,bma220 cleanup typo
>       dt-bindings: iio: accel: bosch,bma220 setup SPI clock mode
>       dt-bindings: iio: accel: bosch,bma220 change irq type
>       iio: accel: bma220: split original driver
>       iio: accel: bma220: add open firmware table
>       iio: accel: bma220: add get regulator check
>       iio: accel: bma220: reset registers during init stage
>       iio: accel: bma220: migrate to regmap API
>       iio: accel: bma220: add i2c module
>       iio: accel: bma220: add i2c watchdog feature
>       iio: accel: bma220: add interrupt trigger
>       iio: accel: bma220: add LPF cut-off frequency mapping
>       iio: accel: bma220: add debugfs reg access
>       iio: accel: bma220: add maintainer
> 
>  .../bindings/iio/accel/bosch,bma220.yaml           |   9 +-
>  MAINTAINERS                                        |   7 +
>  drivers/iio/accel/Kconfig                          |  18 +-
>  drivers/iio/accel/Makefile                         |   4 +-
>  drivers/iio/accel/bma220.h                         |  20 +
>  drivers/iio/accel/bma220_core.c                    | 617 +++++++++++++++++++++
>  drivers/iio/accel/bma220_i2c.c                     |  61 ++
>  drivers/iio/accel/bma220_spi.c                     | 318 +----------
>  8 files changed, 757 insertions(+), 297 deletions(-)
> ---
> base-commit: 19dc57d72d2b9365ef185286886c432f980cff55
> change-id: 20250907-bma220_improvements-e31641777e61
> 
> Best regards,


