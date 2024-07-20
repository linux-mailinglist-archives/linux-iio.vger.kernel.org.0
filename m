Return-Path: <linux-iio+bounces-7733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A07938168
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F02281B9F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF2E12CDBE;
	Sat, 20 Jul 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZMwn6sT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151DD28EB;
	Sat, 20 Jul 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721481032; cv=none; b=cDBHLRgZ4YIREXqCa+zXcuA8Of7wMfdzsZy24F6uiWu/MHfB3Ph0z2d55wVMrDImHagSL00hd+ENpqPIzfYKelvsPR2WzrXXFuSC7WhYu6InLnSJSOnL00OCKS9bj0CyExmReKns3v4qIwIbFtGtvMOvbS51Cd+AS9O6in86ep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721481032; c=relaxed/simple;
	bh=w3g4rGKp1i6RnV37sD1l0NUQVyU9HXKxlieDmNs59Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuUrPfmxi7lHqybVtnE2ynMFGzrIzy87C+2QeApSMEwnt+AzDgCdDfHaMoGKbABEwfxvg0Wlt4rgTaIpWP3Zh10hMSMGkaczqyJFOg6Qx5CSvmIA5Ikaq0wYWBrOQmRpCha6f4JEZlCkCtTgkV7/l/gXD9792Kb+44jxHH7xJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZMwn6sT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CEBC2BD10;
	Sat, 20 Jul 2024 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721481031;
	bh=w3g4rGKp1i6RnV37sD1l0NUQVyU9HXKxlieDmNs59Qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZMwn6sTsC3l2EL/wWuO5y/NN3qMtblLg8IfWRwd/s2BWQuWqDJ8CrtEfRDb0YOcE
	 XjbYJr5UDkdo2GGrr+aYx4SrzYJw4qvsNd+blYA+VcsDdHYp46GTsA4CsEwP+VLlEj
	 g1u8X40YQtVmi10bh+M+HENk6syTFs4VWrUMx93psUybM6/yrXdTD1fvyz7W9GcpaU
	 DsN8NWTWpH2Rnid+kSINARtUPTm3wecHcq/ykOAjklCRID7RhdqXiZVw20dx1JxA61
	 uKZM73JvTdzexyZRZb3rqof5ChK1eZ2DX/s7YMtX34Plq8aaLlzX3HkuoGVqve/lvP
	 LdIhJQH25I9gg==
Date: Sat, 20 Jul 2024 14:10:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/7] Add support for AD4000 series of ADCs
Message-ID: <20240720141021.23ba6a40@jic23-huawei>
In-Reply-To: <cover.1720810545.git.marcelo.schmitt@analog.com>
References: <cover.1720810545.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 16:20:00 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
> support configurable MOSI line idle states.
> It then introduces the ad4000 driver which uses the MOSI idle configuration to
> provide improved support for the AD4000 series of ADCs.
> Documentation is added describing the new extension to the SPI protocol.
> The currently supported wiring modes for AD4000 devices were documented under
> IIO documentation directory.
> 
Hi Marcelo,

All looks good to me. 
So at this point, as long as Mark is happy with the SPI changes, I think we are
waiting for Mark to pick the SPI parts and tag that so I can merge
that into the IIO tree with the driver.  I assume Mark won't
do that until after rc1.  All the dependencies are upstream already but mid
merge window isn't a good point to use as a base for anything!

Give this a poke after rc2 or so if you don't see progress.

Thanks,

Jonathan

