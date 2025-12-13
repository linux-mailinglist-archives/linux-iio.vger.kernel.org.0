Return-Path: <linux-iio+bounces-27067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A4CBB16B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 17:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E0C303B2E6
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9D2D8DC4;
	Sat, 13 Dec 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlvutLtY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FE26E173;
	Sat, 13 Dec 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765643314; cv=none; b=J/0uBu7L1Tj3anCYTJQcHGeoD+todWley6pTmQvHa96wh3LadlzBzP1VuTSXcUuaZdnzEDY9umZ37OsmnncYW+7kvvhiP+LsZ9VrmFhLXslJJXy0nPg2bNZchZwe3Ym0EpvpyabghLnTY6/7KFZk+OFkY8xI/vprUmMv4TdH22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765643314; c=relaxed/simple;
	bh=rLPDMcZMQ8IVCKYjA9zVS43Co1QAX9+nfitjtq7zSWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrVtFedEce43etJXWLsLOsb8cdie/HOzmrMqeHaNFWtBemQAG/0xyt+IjdCI+a62TUKTm6Lwjui0NCS9y9LMk+UIUCdBPLYiv0OAREULNl/hv6+dcWG87RkMFYk7gFlZtRxvhzdBc2JhOTLIpeLR2JkykoZ5gSX+dTcsv7RIBIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlvutLtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DCAC4CEF7;
	Sat, 13 Dec 2025 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765643313;
	bh=rLPDMcZMQ8IVCKYjA9zVS43Co1QAX9+nfitjtq7zSWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlvutLtYRdTYo/9AqOnUh9dXphab/WtPGYI4xgLU9W9nmZUBrkCMgfvdyOOw3jkj7
	 jVK2jIdoIa8eEOE1Gy9rl/2CQw4T+4fSgjeuVkdryKL/GPpbHvXsEyYvRAEYXNZKpY
	 mz9DSECAoreiAmyMXq6ECcrFU5XkiLuEo16aZC4NiFJW1INiFSohQG5Yu0FXeNw+rY
	 DHFX5kDP+3B14urO0hMYv8S63RiPZoi+IoIzhXSmkcVE8nPLuuBbiJQdPk8q95sZzq
	 LolZJquESttPBoK2Z8YTnUnnG1Hi81UuW07CzXF+xLEd2Ueo0FRSOVaR7rZdDxLG7Y
	 jMITNz7a98acw==
Date: Sat, 13 Dec 2025 16:28:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/2] iio: amplifiers: add support for ADL8113 Low
 Noise Amplifier
Message-ID: <20251213162827.7d5c6b08@jic23-huawei>
In-Reply-To: <20251212153908.138422-1-antoniu.miclaus@analog.com>
References: <20251212153908.138422-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 17:38:24 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> This patch series adds support for the Analog Devices ADL8113, a 10MHz to 12GHz
> Low Noise Amplifier with integrated bypass switches.
> 
> The ADL8113 provides four operation modes controlled by two GPIO pins:
> - Internal Amplifier (14dB gain)
> - Internal Bypass (-2dB insertion loss)
> - External Bypass A (configurable gain) - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
> - External Bypass B (configurable gain) - Signal routes from RFIN to OUT_B and from IN_B to RFOUT

Applied to the testing branch of iio.git.

Thanks,

Jonathan

> 
> The driver allows selecting between these paths via the IIO hardwaregain attribute,
> with optional external amplifier gains configured through device tree properties.
> 
> Antoniu Miclaus (2):
>   dt-bindings: iio: amplifiers: add adl8113
>   iio: amplifiers: adl8113: add driver support
> 
>  .../bindings/iio/amplifiers/adi,adl8113.yaml  |  87 ++++++
>  drivers/iio/amplifiers/Kconfig                |  12 +
>  drivers/iio/amplifiers/Makefile               |   1 +
>  drivers/iio/amplifiers/adl8113.c              | 269 ++++++++++++++++++
>  4 files changed, 369 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
>  create mode 100644 drivers/iio/amplifiers/adl8113.c
> 


