Return-Path: <linux-iio+bounces-23853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07ABB47B13
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D9B1B225A0
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E0D265609;
	Sun,  7 Sep 2025 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+96NWKb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F32472B6;
	Sun,  7 Sep 2025 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757245481; cv=none; b=NG+vmz17v3C+BYXRk5eTmmHzna+dVnfF44lo/1ES9MJlQvHME/eRgAwk6R00HDNH9NIv5UtCcd4LluMnGoPD0FKvcCkkq5BnAdv/Rd5nJbVrl7+M8ba+kY41pzCalSXHwTKdK4ZSGz9e6WRnUNico3X3HdqtfDzI/msBUxyl4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757245481; c=relaxed/simple;
	bh=McQxKcQ3IgA09DQIhZhbUBr9hl4vWs7RU541oD5jjDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsTWYOhX3IRm6hej5Vc8+kgfI9X6HCoPtvXOPvKSFzOmF+M34caqA2SW+yQ8TSnxCGZ6IUe0yAOqdOADouiRVr5t5rdobcmRSYckHwcWYemJ/q9shHRzCeZGEOHD28O8eu1vbNGJQVNwd41MGh5jtVSLH8LK500Sj4h44J1uRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+96NWKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A260C4CEF0;
	Sun,  7 Sep 2025 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757245481;
	bh=McQxKcQ3IgA09DQIhZhbUBr9hl4vWs7RU541oD5jjDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D+96NWKbhuU0P1mzI9gATdG0diAEJ2UX2AESQDRxNBft4tKXn1MtAIJYmXU+w1Roy
	 A1fGsYgsvancq1wpB7z9YJVTK0GwZR+mWoqh/GUMzVhRDUUGPMc69Vwiv2+QeEtZ0a
	 AHw/kIw1qeQBfK3Mb9SuFm1fFPz6ZEsBtOwRHFaORMpoxBJc71V4WbO5s1wUZi9lsT
	 yqlwd8RALYwf+Md02si0js2n+GgeOMbHKhms+UNsSHdWsBHYyGRrN0EI4xdhDTo2G+
	 d+FU6DFShwptnOL2/IgdZIKFEPxkFDYBes1F7vw1DSbJZ8Pgzx/ZIsNwXhWc8rzRvK
	 IYZ9007bVbbIg==
Date: Sun, 7 Sep 2025 12:44:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Primoz Fiser <primoz.fiser@norik.com>, Peter Rosin <peda@axentia.se>,
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 upstream@lists.phytec.de
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: afe: current-sense-amplifier:
 Add io-channel-cells
Message-ID: <20250907124429.573edbc8@jic23-huawei>
In-Reply-To: <20250905-dainty-liberal-monkey-ec28bb@kuoka>
References: <20250905065503.3022107-1-primoz.fiser@norik.com>
	<20250905-dainty-liberal-monkey-ec28bb@kuoka>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 10:20:37 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Fri, Sep 05, 2025 at 08:55:02AM +0200, Primoz Fiser wrote:
> > The current-sense-amplifier is an IIO provider thus can be referenced by
> > IIO consumers (via "io-channels" property in consumer device node). Such
> > provider is required to describe number of cells used in phandle lookup
> > with "io-channel-cells" property.
> > 
> > Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> > ---
> > Changes in v2:
> > - refactor commit msg drop warnings introduced by commit #2
> > - drop Fixes: tag  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Applied this patch to the togreg branch of iio.git.
I'll push that out as testing now because some other stuff on there
will benefit from 0-day taking a first look at it.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 


