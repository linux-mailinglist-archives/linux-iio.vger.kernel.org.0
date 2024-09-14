Return-Path: <linux-iio+bounces-9544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716319790A7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CAC1F229A9
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50C1CF2AA;
	Sat, 14 Sep 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZbxP2yh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5A1482F3;
	Sat, 14 Sep 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314576; cv=none; b=fwmDC4x899I4Ej2iK4cvDXVzpGVwlChnnzqs8EV5XZzDH4Oa8BnA08pwIMvLh0KrVccDx73LXjWQcyFdU2xbAF5kCvWMgtARPiNjJTA98ZvjMWzW3B68zAPdaVzJU0o1Tnreb0eT2UDmEnV9oGxA65WggWaIeYjUp9mc2FQsQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314576; c=relaxed/simple;
	bh=fVrlqcJJqkdaMA/D4EnRn6ztxLfJah9+dpv3lnwwjfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uX01gxpK10pymvcg86AjBswKK3CIKQBmNlJJNFbvuy8vnBcoqLzmmME5wn/u/zb/TPXDijg8d8TcK2BYWYmJKWbAUnb0przRawWRRHB0drK0FiqzJIFsdmLQO9GZZBNuO2jbf6PLx2qWqXoGETCjIS0QvBkHLF6LpfjJQpyopeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZbxP2yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE910C4CEC0;
	Sat, 14 Sep 2024 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726314575;
	bh=fVrlqcJJqkdaMA/D4EnRn6ztxLfJah9+dpv3lnwwjfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZbxP2yhuIhtDHIajP610BxZAK8re9DDp+iTqr0Wau9Qe4+M0+En6xZ3XKLC3q0do
	 ZoB2sM/IaXxNXrb8w1w9w4O/sTpb6gZJNSb+iHQ5+THnfslbYzAxyJ16qmZULki2Ce
	 kqZ9vES9ojpyJkVU0SKgGXdZY50t/jNIV9SVVTw2wWMIFmrzTUZpXs70tIIyUEnvZz
	 A6uXXlo//P7kVlARyBqyS1K0zOT197+/xI6rL5SXRJgsbw0ujcYXaEZjq2lZVaUpAG
	 a37PaFEHPs5d+ZfUmo1FHbOBOKsosvmd1fcI59dkE1nex/xkeJMEEn3Q437MXPRtFU
	 4ajs3s55odUoQ==
Date: Sat, 14 Sep 2024 12:49:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: temperature: tmp006: support for drdy irq
Message-ID: <20240914124927.55e019e0@jic23-huawei>
In-Reply-To: <20240908172153.177406-1-apokusinski01@gmail.com>
References: <20240908172153.177406-1-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Sep 2024 19:21:51 +0200
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> This patch series adds support for the data ready interrupt of tmp006
> sensor. The interrupt line is pulled down once there is a measurement
> available to be read. Hence, triggered buffers are used in order to
> support continuous data capture for the sensor.
> 
Applied to the testing branch of iio.git.
I'll rebase that on rc1 once available and push this out as togreg
at which point linux-next will pick it up etc.

Thanks,

Jonathan

> Changes since v1:
>   * dt-binding: improve the commit message
>   * tmp006_read_raw: use iio_device_claim_direct_scoped()
>   * tmp006_channels[] : add trailing commas
>   * tmp006_trigger_handler: use s32 to check return value of read_word_data()
>   * tmp006_set_trigger_state: fix data alignment
>   * tmp006_probe: check return value of devm_iio_triggered_buffer_setup()
>   * tmp006_probe: remove IRQF_TRIGGER_FALLING from irqflags argument of
>     devm_request_threaded_irq()
>   * tmp006_probe: set avaliable_scan_masks to tmp006_scan_masks[]
> 
> Antoni Pokusinski (2):
>   iio: temperature: tmp006: add triggered buffer support
>   dt-bindings: iio: temperature: tmp006: document interrupt
> 
>  .../bindings/iio/temperature/ti,tmp006.yaml   |   6 +
>  drivers/iio/temperature/Kconfig               |   2 +
>  drivers/iio/temperature/tmp006.c              | 134 ++++++++++++++++--
>  3 files changed, 129 insertions(+), 13 deletions(-)
> 


