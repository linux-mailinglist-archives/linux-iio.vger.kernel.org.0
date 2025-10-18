Return-Path: <linux-iio+bounces-25236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F10BBED420
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1526D4E4CCD
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6F2522B6;
	Sat, 18 Oct 2025 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3SQRmZj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D62441A6;
	Sat, 18 Oct 2025 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806361; cv=none; b=F3utDzQNYukOWKoZHvTTcofk2MHTY/cIXDz4I3ZRUD4V9ox/FOR7XrTN8mawhE5jq8mkMh73R/P5LTjqaiTkHblxCbhvleA6AXU3+Ib73Wp9yJsw3DghbGnE3TGTW1RG3JK0j5KjhJ6X9gMteAc9N2QpLOm9mLIwSoCkNJiGWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806361; c=relaxed/simple;
	bh=3AQR1+KFQiELiXUBQu7oglYF6TJ85eITEGgQwbzI1yY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1humhcgCByNK8nQxNjTboMQOkvUnj1aL31f8ew5PzFCLJR8FEkZkRHtzP+wuxUu7/b7Cd8Y5MUIeHuWgllsc9oM3n/mVYUp/mpdrsWPUynxQ873wugf2H+AFR3zSugUHih6X4P7QsSzcjVy27qrp77XDjL24ndGcuuUlrge6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3SQRmZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA17DC4CEF8;
	Sat, 18 Oct 2025 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760806361;
	bh=3AQR1+KFQiELiXUBQu7oglYF6TJ85eITEGgQwbzI1yY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F3SQRmZj95mgUG2hXYdlgpHzPIbgwK0cQfpSVMVrbv8pAAkpGOQEqZOLAH0ITEZ+m
	 cyK6blLmOfrLywNaUY89AHcMarte6dL/SLqlFeZ+WaMGAxGvdamXmMWMTA6lfJIA/u
	 z8oGyMeHMKZlt93e9EADqwcNvU6mHL/scPg/0iSk6enwWyNMnRmZ5O3p44w/1U09rR
	 YtNqvj8l8z5T9tKurksQHfg1aEIlQ0jm3/CGYo92FkctGZMU+z7+bO88fmj76jrLJs
	 OlUO6S8lu7O6trq+CerP1TG9pMvY3f7OdSBBMFvWSqMLAXoJoIK+G4d6YKqssUcFyF
	 oo3UbFjKPnO7Q==
Date: Sat, 18 Oct 2025 17:52:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
 devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>, Adrian
 Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v6 5/5] iio: magnetometer: Add mmc5633 sensor
Message-ID: <20251018175232.064a8aee@jic23-huawei>
In-Reply-To: <20251014-i3c_ddr-v6-5-3afe49773107@nxp.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
	<20251014-i3c_ddr-v6-5-3afe49773107@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 12:40:04 -0400
Frank Li <Frank.Li@nxp.com> wrote:

> Add mmc5633 sensor basic support.
> - Support read 20 bits X/Y/Z magnetic.
> - Support I3C HDR mode to send start measurememt command.
> - Support I3C HDR mode to read all sensors data by one command.
> 
> Co-developed-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
LGTM.

So my ideal case (assuming i3c parts are good to go) is an immutable
branch in an appropriate tree that gets merged into both i3c and IIO trees
and has first 4 patches.  I'll then put the driver on top in the IIO tree.

I can spin one if that is useful.

Thanks,

Jonathan

