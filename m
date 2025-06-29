Return-Path: <linux-iio+bounces-21113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CEDAECEC5
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000293B4D8F
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17FF233136;
	Sun, 29 Jun 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/Y0EuMA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC81FE45D;
	Sun, 29 Jun 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751215939; cv=none; b=Xfy0ejvyXgpqhI99/d2VDsT211moumFTfthYJVLM46LvSz1VVzd2YtbVM7d5OukZK7nX3mjhYbcC/5nPjQXD3+2SFvntXs/dWRfYVIutxk+r6cWmaZQG9ovR2h+700M68KWscDd19NDAcCyyDrQMp9/i+LwRNnSUQwFbG/vijdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751215939; c=relaxed/simple;
	bh=MPyVmXt/3QyZszVR5nGrkX1tRmk/RGhsjU/EYDV5kPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMSw/mSFRnNhGOvmR42v2nt1vWq78rCLq4+VWlGJThJ2MpQ71sjFppzWaY1uoae6hmqB9r8imZBO6C9Y57F4k3rVeKr1ZCNDoX4yr18glz8sPjIUyc5QbGt94aWebdMgSyXooKjwOibo6pmjH5sn62KrAbJPbGPKswy3ACPEINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/Y0EuMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934A7C4CEEB;
	Sun, 29 Jun 2025 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751215939;
	bh=MPyVmXt/3QyZszVR5nGrkX1tRmk/RGhsjU/EYDV5kPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C/Y0EuMAJPH67735Bw2p9Gb263mrkQs0Ypxx/NyH+jChrhvuCQw+XNKMEG66K1s72
	 BGASN3zYpJ2FY/Nb+uiKN6102z0E/X15r/8/1K8Xz7tz9QoQX/oo0toexZmYukj9M7
	 yPoCSzMCByp61ZFJBUGjR0f1FWQ7yIe0L4PX4/Lp6AjhD70y19SG4Yby2MLiN+0vP4
	 GpKES0lkroqnlSQbLukis+ykWxg6WrEKQK5IIDUvoKbtGLFL+uxorMr6e/lW6N7Q2K
	 Zy+4c+h5DpcxPwYK7kFa9tnHIKInVYRiZyjNwmeMT4enTMvg1fR5Oe9UXOA6zhAs+D
	 EtZ04z5+I1etw==
Date: Sun, 29 Jun 2025 17:52:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91_adc: make at91_adc_caps const
Message-ID: <20250629175210.1d3d33f7@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-6-v1-1-fbb1ca5edc8d@baylibre.com>
References: <20250628-iio-const-data-6-v1-1-fbb1ca5edc8d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 11:19:36 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct at91_adc_caps at91sam*_caps. This is
> read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

