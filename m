Return-Path: <linux-iio+bounces-19554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3855DAB8D36
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 19:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD3A18887A3
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C76198823;
	Thu, 15 May 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obQG2N9J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA91253F1E;
	Thu, 15 May 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328947; cv=none; b=hVCx6MYev+2YmfV9fXbMkP/82hisyGcNpxaEEyej7+IXBfWdjv9DESgKO0I+EwylIq9yRA3EGdqG5ImaSCGwtVrdkR9pyJibD5XyZOOlTpKF4VMNL4yZ2RunrEK5MIilfa6R7Mx2wSbBRpvr8xAqkGKJjlwBCqZDMfRBcIuu8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328947; c=relaxed/simple;
	bh=hN2Noi86IAlCVFjZkLH+RLk6d2Ee/tO3RghkfloQNU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaAepbA5lcp1Ndokvdbzq5UfprSHkf0+ZdDZZJMLpwMFW18xyOxvD65cAEgiMMluozqE4m2GItSxnLpfeecPQvi2qe0iqQHm6VWx4oCwU8MI0sGbgY/85bWxfvOvrLaZlpdZLbCilj4XWdgqvPvL8iCysOGt5aC1F5YgpT/f9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obQG2N9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD85C4CEEB;
	Thu, 15 May 2025 17:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747328945;
	bh=hN2Noi86IAlCVFjZkLH+RLk6d2Ee/tO3RghkfloQNU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obQG2N9JroZvsrHz3tRBhEkmS9Dy1TPK2qfOr7wIUbJFbSCmPyALpdJpfqPrZSmg5
	 CzF90ybHTnhHq3FzDQv6mjbk7+bB0Slc7xiT6CbDYWS38oYsh+VA7bN/RF2hnEDE+K
	 rGFAqKq15/49lZanC3ANYttCtczP8HCRZydMIaxkYxVPObURVsvDpmHyhC8ffLr91a
	 wcDat7adJG5ClPfUMILj6Xmydgc1meJfZTD7PKspFwd3LILSik8fHFmmq/WivsRHbQ
	 xhdYtjEEzFu6xkZ+HgL421hYqVOE64pl+V5Hjfrp+6ooMdlg0oQPerkXfPA3hK9GR8
	 FexMGPAbSPFYQ==
Date: Thu, 15 May 2025 18:08:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: Add ROHM BD79100G
Message-ID: <20250515180858.0934b45f@jic23-huawei>
In-Reply-To: <20250514-elope-ultimate-0c44ed3be88b@spud>
References: <4907a096eee1f54afae834213cf721b551382d4e.1747203712.git.mazziesaccount@gmail.com>
	<20250514-elope-ultimate-0c44ed3be88b@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 17:23:54 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, May 14, 2025 at 09:25:13AM +0300, Matti Vaittinen wrote:
> > The ROHM BD79100G is a 12-bit ADC which can be read over SPI. Device has
> > no MOSI pin. ADC results can be read from MISO by clocking in 16 bits.
> > The 4 leading bits will be zero, last 12 containig the data.
> > 
> > Device has only VCC supply pin, which acts also as a VFS, determining the
> > voltage for full 12-bits. Specifying it is mandatory.
> > 
> > This seems identical to the ti,ads7866.
> > 
> > Support ROHM BU79100G using ti,ads7866 as a fallback.
> > 
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

This is obviously fine, even if the ongoing conversation around
SPI driver autoloading needs to continue.  So Applied.

