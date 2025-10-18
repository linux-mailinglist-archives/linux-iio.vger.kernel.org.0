Return-Path: <linux-iio+bounces-25257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A3FBEDA06
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 21:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A2219C2595
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA728850D;
	Sat, 18 Oct 2025 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyxqqk6E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493EA286D60;
	Sat, 18 Oct 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815205; cv=none; b=jcjl0ocM4gmb6DuKmK5JKEcWgsHOeNwgmXSpkscmSKuqTZZDmR5B51yqFgAAchQI6oxdGUb/HtbL5R3fNEP+C4j8o4lotnjPPBva7cvoj9q1x2UjVf8hX0bKbdbgzLIqqP9lFN2F7TO+U4OIMhQGEtNKycxJObsCBdLf39Eb+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815205; c=relaxed/simple;
	bh=2prTFL/x7SrFpeHp+FU7uC2IAjhEAwSTRFb6SXO0Goo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmfT9FCmfplhlXiMrU+LI6BBSFdCNIXFDxFdKRo+BrdREwf95hIFI7vunQTZ3qn4qh/uE+6SR8086xviu/LoeCBEM8VNeAhrW/4kZOcENdROXArEB5k8ojGnvImi57k7arUUX8GjKPIC+Vh2UmW+ltwtQQtbNAzcOUHkIBmHKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyxqqk6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBFBC4CEF9;
	Sat, 18 Oct 2025 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815204;
	bh=2prTFL/x7SrFpeHp+FU7uC2IAjhEAwSTRFb6SXO0Goo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iyxqqk6ERMxJilLgsGJ9ipcfHvI8aYMBqvj/vS1hdH8vgczXzFQ5L/g2D6EZVXSsd
	 mSJ8osZKZmQu9xoQzylFyyGXSBiEK4loejChmKEverNTT5NzaUsc4Vg5lEWpbFyAJv
	 YCGuC31lPUcunZsCXryiBXjVGJ+CePducHOyiTo7xkZyo/0N/An21pY/eoW0o00vnq
	 fvF7pQY0FNVjj7accZZFhxSxrWDNbLp04f90vL/PWoSsDdv7SvTdXdzTxv1qnPPT9P
	 6P+X+9n4xsC8lCulofU+smpK5JDwQbrThOOS5ijLAPYBPJBj2N3kMr7UeNUFY/m0G/
	 LiHFUdiAp5mjg==
Date: Sat, 18 Oct 2025 20:19:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from
 FIFO batch data rate
Message-ID: <20251018201959.22a013f8@jic23-huawei>
In-Reply-To: <20251017164255.1251060-1-flavra@baylibre.com>
References: <20251017164255.1251060-1-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 18:42:53 +0200
Francesco Lavra <flavra@baylibre.com> wrote:

> The rate at which accelerometer or gyroscope sensor samples are fed
> to the hardware FIFO (batch data rate, or BDR) does not have to
> coincide with the sensor sampling frequency (output data rate, or
> ODR); the only requirement is for the BDR to not be greater than
> the ODR. Having a BDR lower than the ODR is useful in cases where
> an application requires a high sampling rate for accurate detection
> of motion events (e.g. wakeup events), but wants to read sensor
> sample values from the device buffer at a lower data rate (e.g. to
> minimize the amount of I2C or SPI traffic and the rate of periodic
> interrupts).
> This change set amends the st_lsm6dsx IIO driver to support the above
> use case. The first commit is a trivial fix to the source code comment
> that indicates what measurement unit is used for the `odr` field of
> struct st_lsm6ds_sensor, while the second commit introduces a new
> `hwfifo_odr_mHz` field in the same struct to implement the new functionality.
> 
Applied to the togreg branch of iio.git which is initially pushed out as testing
for the autobuilders to poke at it.

Thanks

Jonathan

