Return-Path: <linux-iio+bounces-23217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDAEB33E12
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD7F1A82E72
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340E72DBF47;
	Mon, 25 Aug 2025 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/bp8JiS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E62E1C63;
	Mon, 25 Aug 2025 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121475; cv=none; b=sYbC+n5C0vcGB9q3VR8vpw8im0QdsarV2qjG+ey9C/FkoL4LA06c8ommox1H8UAkANNRHNgNGcZMuRGlbfa6PwW+EypQk3PxZyTEYPLrq0RPkzGy1dKDzlSLBHU4tEVPot8PIF1qqDeYN84+SMaTzX/VrmiM9giS2VHFcuZtaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121475; c=relaxed/simple;
	bh=OgbR/W4gItCa2yQLXixaqQP3APnO9bdaKfA3LJBQfCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUMor6dtcI5DWJalEBxk6/s8xm2oM9dMZ++FU+qS9xsvFbybScWYfXczfOEpSxkfLHS/frEOZNOv3BGJByhnJjAwk/mUQUc0j18MLOUphD1KTgFGH7+yR0vki+bnHTqP/+KlWHvdyRxpzWal63WMHyITy21Tkjp0dT0qVQOSkEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/bp8JiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE62C4CEED;
	Mon, 25 Aug 2025 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756121473;
	bh=OgbR/W4gItCa2yQLXixaqQP3APnO9bdaKfA3LJBQfCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L/bp8JiSSu+DlgC5Jlw27azJqw5qLfIPDzMWuWAVBFPdKWEEDCulvu0L+jZv6fqfs
	 8t/v6LSdy7Eo44fugSbuHh85J3k7JnIBwt4hbQMAAr5kmbgIN+Y1HaadG7wACwCM32
	 Uk01Y6fBU95g41Qx4lOb75wliUbj41wOVpN4415IB84qZot8lJoPgwvH1qqse6qsVv
	 ZSxCqjrUCOwcZFqTFWpBvo4CZqbQhuJBAAkGHz4Fp+7DlHCIqeE+Tj2g9ES2VT5JWw
	 iY8BLMV9Ej4+JIfEV2QrNjEVEdzfAQMicwOeUVuk94uDqkSzX6Bh9HQpcwPQe487Bh
	 iv1JIsfuKy/HQ==
Date: Mon, 25 Aug 2025 12:31:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Ray
 Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Support Opensource <support.opensource@diasemi.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Haibo Chen
 <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Cai Huoqing <cai.huoqing@linux.dev>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andreas Klinger <ak@it-klinger.de>, Crt
 Mori <cmo@melexis.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 03/10] iio: dac: Drop unnecessary -ENOMEM messages
Message-ID: <20250825123100.43d8c4ff@jic23-huawei>
In-Reply-To: <20250822-enomam_logs-v1-3-db87f2974552@gmail.com>
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
	<20250822-enomam_logs-v1-3-db87f2974552@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 09:19:51 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> The drivers do not require their own error messages for error
> -ENOMEM, memory allocation failures. So remove the dev_err
> messages from the probe().
> 
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> ---
>  drivers/iio/dac/ad5380.c     | 4 +---
>  drivers/iio/dac/ad5764.c     | 4 +---
>  drivers/iio/dac/ds4424.c     | 4 +---
>  drivers/iio/dac/ti-dac7311.c | 4 +---
>  drivers/iio/dac/vf610_dac.c  | 4 +---
Raced with another series doing a dev_err_probe() conversion and the relevant
lines are gone.

I'll fix up.

Jonathan

