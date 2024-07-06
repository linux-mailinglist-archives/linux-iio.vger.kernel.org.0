Return-Path: <linux-iio+bounces-7374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0686792929F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383001C20E4D
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE726F068;
	Sat,  6 Jul 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV8YUw1u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3D4778B;
	Sat,  6 Jul 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720262600; cv=none; b=poR4cpDvczHr42zlCBqDWoSjYltIyeyYtrckBfImSXJPycQl3X+H6FkqGjtz2uZFgmIXvC6Rw1ijlQ0hCoxNKAwmoFF9p6/bbqbB8rl41WjhXo5dTdiSOXiVRW9xO++46024RkW7MObVBnZQ2+HVWjEbRQTPTZ45oG/nFt5VYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720262600; c=relaxed/simple;
	bh=BMq3hRE63Nc6Gaod6A+IsrsDJIRMrXliC5k+8pxkqM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFC2DYqtkrFR9neOaTIuMLmfAeFqZCrxFTirtxMGB4FmlCTJh1nHzfrhFXAIvrSu7XO6xLPWfd/nzbNdYVmPCmdyx1c8QWWBOBrWvJ0d1J/0e4qBLNi9IwSjaqVnmvtFuug2+D/EDMRIyJSW/PQM2DuF2mYd2rPGCEP1Ai2vf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV8YUw1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5F9C2BD10;
	Sat,  6 Jul 2024 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720262600;
	bh=BMq3hRE63Nc6Gaod6A+IsrsDJIRMrXliC5k+8pxkqM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IV8YUw1uy+k3XfD88zLEmgy58tSyHTdzK2k0GqxB+Kvq+sB6vgvSCoD9Y1sEWL0mA
	 pcEtF1u3n/h1PzCUPzSAkYT6hRlef3ReMCbae8P+hpRZenU9ZUsgJQYKqt0SHj01CZ
	 VuP/dQ4Nqtu7Bfxxu6yHFcREfG6IEAYS6w4iI376Gh69xtqshC9QSZV0OgYqshuI+f
	 u1MomCLFIIbccZdXlrzxynB9x3xRD1i9XjEr6ZcmeHTPZGPMkHk9XM/02gGs9BWpaa
	 0AYE5SQ+so77OOBMhSlDrBDdFSC+8G4btdprfZU+B9dGov3rnHXfSt7Nczax5TigDt
	 PxVj5WPLhjG0Q==
Date: Sat, 6 Jul 2024 11:43:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Dan
 Robertson <dan@dlrobertson.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jagath Jog J <jagathjog1996@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] iio: Constify struct regmap_bus
Message-ID: <20240706114312.19e6f375@jic23-huawei>
In-Reply-To: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
References: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jul 2024 23:04:43 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series adds the const modifier to the remaining regmap_bus
> structs within the IIO subsystem that are effectively used as const
> (i.e., only read after their declaration), but kept as writtable data.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied, but for now only to the testing tree of iio.git as I'm unlikely to
do another pull request this cycle and will want to rebase the tree on
6.11-rc1 once availabled.

Thanks,

Jonathan

> ---
> Javier Carrasco (10):
>       iio: accel: adxl367: Constify struct regmap_bus
>       iio: accel: bma400: Constify struct regmap_bus
>       iio: accel: bmi088: Constify struct regmap_bus
>       iio: adc: ad7091r8: Constify struct regmap_bus
>       iio: chemical: bme680: Constify struct regmap_bus
>       iio: dac: ltc2688: Constify struct regmap_bus
>       iio: imu: bmi323: Constify struct regmap_bus
>       iio: imu: bno055: Constify struct regmap_bus
>       iio: light: gp2ap002: Constify struct regmap_bus
>       iio: pressure: bmp280: Constify struct regmap_bus
> 
>  drivers/iio/accel/adxl367_spi.c          | 2 +-
>  drivers/iio/accel/bma400_spi.c           | 2 +-
>  drivers/iio/accel/bmi088-accel-spi.c     | 2 +-
>  drivers/iio/adc/ad7091r8.c               | 2 +-
>  drivers/iio/chemical/bme680_spi.c        | 2 +-
>  drivers/iio/dac/ltc2688.c                | 2 +-
>  drivers/iio/imu/bmi323/bmi323_i2c.c      | 2 +-
>  drivers/iio/imu/bmi323/bmi323_spi.c      | 2 +-
>  drivers/iio/imu/bno055/bno055_ser_core.c | 2 +-
>  drivers/iio/light/gp2ap002.c             | 2 +-
>  drivers/iio/pressure/bmp280-spi.c        | 6 +++---
>  11 files changed, 13 insertions(+), 13 deletions(-)
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240703-iio-cont-regmap_bus-f7578bc89954
> 
> Best regards,


