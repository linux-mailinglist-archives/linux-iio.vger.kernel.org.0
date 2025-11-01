Return-Path: <linux-iio+bounces-25788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BE9C283A8
	for <lists+linux-iio@lfdr.de>; Sat, 01 Nov 2025 18:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36913BF26D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Nov 2025 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16A279324;
	Sat,  1 Nov 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7N0Y46b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C719309C;
	Sat,  1 Nov 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016509; cv=none; b=LXuNUMSkYNvt2zl6TOiYNuTeS2Rq/5Z4wPwnNWWZw3SNAXSP0ZNgkIb+7lVqhSlSUyGix3B9QP5AKE6NEtxusN6ikzLcdYD3Wyzc/VYbYZIEzZsJp/Clz3igRF0ZYaEviGTpNLnccUkM6StwIl5cl/Wulw2Oz2Ib5jDZwYS4mU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016509; c=relaxed/simple;
	bh=GP4gDrHyamNc1MWJlGO4DRUHbfFH0p+wioFnu0kmRDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTNcZ12ebwWmvW9SnJPDGSh0LGUw9id67wyEk3j6J/pU7S8RMb2EO5PgB5FEGCmqFxTrmyGwFB+lqfx3uMM5VvquoVczWjFX4P1C3ZZjFw7olRgZnT7f8NB5gvOljxmVYKSaZVvluw3LJdjrpyJSbMLRRaqW3td5AzabGad2NzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7N0Y46b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA4BC4CEF1;
	Sat,  1 Nov 2025 17:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762016509;
	bh=GP4gDrHyamNc1MWJlGO4DRUHbfFH0p+wioFnu0kmRDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j7N0Y46bpWBWILdmwRBfx/EieWyWKblN8vIi6YHFx9y+MnJTYHP5UMYH923Ey8YAU
	 vEtmaDKrsmAxUTA87sAJ3n0eNCFihZeW3tpkB/hnrYu7MpK1YoMt70FJ5M3jPITPT4
	 XCwDvqmuxXYLeeISsKUTFKL5j26hCpuQ12QFJyKaTHuzReUsm5q4Nul1fi3RGAa/2l
	 aM18xxV+l/u+iXiCSvnwzMJm8QG6okidZIIhOMNZQaq+JZv/X+gYVXqYsc7Vcxyv42
	 jfrjvOmssQYCZRilrAz179zuzRn6A2sriUYsZEX7SdovhxPb3pAE0o+Iu0CvtlkEcG
	 6pLXEB94bqeEA==
Date: Sat, 1 Nov 2025 17:01:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: remove interrupts
 from required list
Message-ID: <20251101170141.103d6689@jic23-huawei>
In-Reply-To: <20251030-glorious-nano-muskox-e37d49@kuoka>
References: <20251029-qxp_sensor-v1-0-e97ee1de96d8@nxp.com>
	<20251029-qxp_sensor-v1-1-e97ee1de96d8@nxp.com>
	<20251030-glorious-nano-muskox-e37d49@kuoka>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 09:23:37 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Wed, Oct 29, 2025 at 03:27:18PM -0400, Frank Li wrote:
> > Irq is optional signal to make sensor work. Not all boards connect this
> > signals, so remove it from required list.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml | 1 -
> >  1 file changed, 1 deletion(-)  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Applied. thanks,
J

