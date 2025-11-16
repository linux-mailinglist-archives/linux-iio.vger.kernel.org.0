Return-Path: <linux-iio+bounces-26262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F871C61827
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 17:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5FE3AA84F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266F30C634;
	Sun, 16 Nov 2025 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbOcgCD2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D019D8A8;
	Sun, 16 Nov 2025 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763309432; cv=none; b=WbTlCbS281RlQkmMc5bUwmL0ce+jIBM9p1dapK7HQhukIxTDvxek7DLdfI8qHc8PwrXycYLdPn6soXxk9r+5ubni+M6Cz+HkA6KM/JYFh8s2V3jr/Tm/QnqTE1k2lnqYZ7I0MbeQb9/8dvxyNhTSFmLuR09VA7YYQFmhyXhutZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763309432; c=relaxed/simple;
	bh=zlADVKGYtLKdaZN2C+6k7dyzgFpOTlp3zF7I0SqUksg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQzXgVjkhACJYyrQ0pbCahFOF8U9yxbKWTDO31UPgTswAJOupPcGQxGw2U2WovmTPnm+ZmoT0Vojvd0rjaKADtc3g9BI63kwy7G8DI/PLV+txXBSupmqrVj3BBKFFqmhKfSqopBlu+eqdFx7PhdYTIBgCxAVns3HlEJzzqtFKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbOcgCD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D05C4CEF5;
	Sun, 16 Nov 2025 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763309431;
	bh=zlADVKGYtLKdaZN2C+6k7dyzgFpOTlp3zF7I0SqUksg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mbOcgCD2eKGFlZbKJhp2UXOO5OUOvjCoVYim4/fdmyvmnWo2z9S5+EUiGlcCqDNTr
	 xCtYNT9yfNPLTZNufz3FGZocmBy8BU6DSfjXi5NJfY5bDPEHUvpC5EUCubroyL7xmZ
	 BdWNQb4LnW7c02Muj5q4fQr/M/3kC1/ZwC0gzybgJ5Anr4txyJ8IwrluAZ+W2FntVT
	 WMQinzdV5Z20CvWwuvHHmWjTmsh1zAPn2tWhGtb/CtWNZDSW3+QPH6OMoZcd0GLChS
	 HiqZXFK93D61XtbibwOu/qDN0PS148wvH8Vcygpdh/QzAuaHfgpNorKi6oT62BfxbX
	 KyRMtYR5viOSg==
Date: Sun, 16 Nov 2025 16:10:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/3] ADF41513/ADF41510 PLL frequency synthesizers
Message-ID: <20251116161023.7a4b1b6e@jic23-huawei>
In-Reply-To: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 15:44:43 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This patch series adds support for the Analog Devices ADF41513 and ADF41510
> ultralow noise PLL frequency synthesizers. These devices are designed for
> implementing local oscillators (LOs) in high-frequency applications.
> 
> The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41510
> operates from 1 GHz to 10 GHz. Both devices feature exceptional phase noise
> performance and flexible frequency synthesis capabilities.
> 
> Key features supported by this driver:
> - Integer-N and fractional-N operation modes
> - Ultra-low phase noise (-235 dBc/Hz integer-N, -231 dBc/Hz fractional-N)
> - High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
> - 25-bit fixed modulus or 49-bit variable modulus fractional modes
> - Programmable charge pump currents with 16x range
> - Digital lock detect functionality
> - Phase resync capability for consistent output phase
> - Clock framework integration for system clock generation
> 
> The series includes:
> 1. Core driver implementation with full register programming support
> 2. Device tree bindings documentation
> 3. IIO subsystem documentation with usage examples
> 
> The driver integrates with both the IIO subsystem (for direct hardware control)
> and the Linux clock framework (for use as a system clock source), providing
> flexibility for different use cases.

For v2, provide a little more info on why we need both interface types
specifically what you can do with IIO that you can't do with a clock
driver.  Also +CC the clk driver folk and list from MAINTAINERS.

We have evolved to this dual interface state drivers, but I'm not sure
we aren't in a case 'If we were doing this again we'd never start from
here.'

Jonathan


> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
> Rodrigo Alencar (3):
>       iio: frequency: adf41513: driver implementation
>       dt-bindings: iio: frequency: add adf41513
>       docs: iio: add documentation for adf41513 driver
> 
>  .../bindings/iio/frequency/adi,adf41513.yaml       |  268 ++++
>  Documentation/iio/adf41513.rst                     |  377 +++++
>  Documentation/iio/index.rst                        |    1 +
>  MAINTAINERS                                        |    9 +
>  drivers/iio/frequency/Kconfig                      |   11 +
>  drivers/iio/frequency/Makefile                     |    1 +
>  drivers/iio/frequency/adf41513.c                   | 1435 ++++++++++++++++++++
>  7 files changed, 2102 insertions(+)
> ---
> base-commit: d16d1c2553248f9b859b86c94344d8b81f0297cd
> change-id: 20251110-adf41513-iio-driver-aaca8a7f808e
> 
> Best regards,


