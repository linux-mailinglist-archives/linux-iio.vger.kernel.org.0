Return-Path: <linux-iio+bounces-18686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E55A9DACB
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 14:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3236F1BC0C65
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2DCA5A;
	Sat, 26 Apr 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/yjAY/M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB78F5A;
	Sat, 26 Apr 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745671753; cv=none; b=C42bmvITL0tdUl3TrObMIh0UYAl3633Uu4oBwNlGCrA88/8GVB3a6IJR4Bgb1E5MAcJwXwB4491x3FkRSSkJfCgDpQr9bY0OHSZxe5TaaqsVya9Uj+kKgKXvL48qOyeeeOq6pXhB8pN01laAwKELmNBJkafxx6ZYZkQvXTo6tdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745671753; c=relaxed/simple;
	bh=3IwxfYhPqqfQZ+MA07TU0Kmr5RuA9Hk6yvABNGkXtjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0HaupFQeqI4Tk1kI213tlSaRTb6xku3PZ3BESTMKOagZ9gKjLhJjRDLWLPHz2jdfnSb7B7VjH8MMbz96SFk5lCKMcCBbaUhyZK7L+U/yzdXUcIjZzuIdvAORFoP7H8XU+lw5pRMFUVI5MNVvO6DPPqysCLnqTbMcRBw1pe4yAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/yjAY/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94450C4CEE2;
	Sat, 26 Apr 2025 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745671753;
	bh=3IwxfYhPqqfQZ+MA07TU0Kmr5RuA9Hk6yvABNGkXtjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D/yjAY/MZMs9TxBw/aSqz84hDOQUOAOta8EZFGCoQ3G+6pieJxBJCI722JXFER7Yv
	 YoUmmLfHjPUUU2X68q1Pr6bCVXBqZxApZjuSNTfDEPrQP3IYgmw4/3JG4imluj/YmQ
	 Rbcs5K1fJXFvW/xSGhKS7iic1qh3U2vFbUiTVsOBOv4KtlIOMDc775ymh/CcK+nTqn
	 AF6PcTy8GXoa8IbbQHwlcHeG158haRsNpQzFwHHB8ZWfZtjw+ygXk6bLqh0250Na76
	 BLJssAUXy3C3d5pZcdtAhGYr7MBLCNgG5FviQpMfX3/Zoyiy0sTgdyOd1+4PaRMewE
	 GWAThNV40jsRQ==
Date: Sat, 26 Apr 2025 13:49:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <20250426134907.764491cb@jic23-huawei>
In-Reply-To: <8ea9b3b7-1896-470e-9c7e-023d4ea248bc@baylibre.com>
References: <20250425-togreg-v6-0-47b6f9878ae5@analog.com>
	<20250425-togreg-v6-3-47b6f9878ae5@analog.com>
	<8ea9b3b7-1896-470e-9c7e-023d4ea248bc@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Apr 2025 11:48:50 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/25/25 7:54 AM, Kim Seer Paller wrote:
> > The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> > low-power, 16-bit, buffered voltage output DACs with software-
> > programmable gain controls, providing full-scale output spans of 2.5V or
> > 5V for reference voltages of 2.5V. These devices operate from a single
> > 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> > variants include a 2.5V, 5ppm/=C2=B0C internal reference, which is disa=
bled
> > by default.
> >=20
> > Support for monitoring internal die temperature, output voltages, and
> > current of a selected channel via the MUXOUT pin using an external ADC
> > is currently not implemented.
> >=20
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > --- =20
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>=20
> Just a few small things in the latest changes that could be improved...

FWIW I took another look and have nothing to add to David's review comments.

Hopefully with those tweaks v7 should be good to go.

Thanks,

Jonathan


