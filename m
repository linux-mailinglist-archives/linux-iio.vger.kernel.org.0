Return-Path: <linux-iio+bounces-13726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813DC9F9A0B
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 20:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794D8188FA67
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE9220680;
	Fri, 20 Dec 2024 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+5mQi/R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9324321A423;
	Fri, 20 Dec 2024 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734721974; cv=none; b=SVCjpp85rZu5LujNAzEcyEGTlUrHlCRcVVAsJEjdbqt5dA2FKZdH05tUdgQme88NHExpjKHRBOKnlEdw4in/dvY895cl5Zpow1h+4rymEoxoZGwajmbur0yjWqP2420KPhxgV0hZr/tcRwcMRYGBDsDcgMt9HMAtrVilfIH5pik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734721974; c=relaxed/simple;
	bh=iQnGYVwaajUJ7CmWsd19Cw2pgWco3tOwIfJCvwzDB/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtVzEU6wPKrzmRnbY9jDhRx4+OyQffr7ZNPe8EjqUx53aWUFe/qiUHfs0aJhomg4CwKAcX4wVpFdNoxOMZlaBJALqV4X8Vx8phm8LMpDid5Uz0tNCjXfUQoEU52NhqrZE+CZEZn0dW6/ZamfxrmTwRX7Fc41Y84qR0J6zwT1w2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+5mQi/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A12C4CED4;
	Fri, 20 Dec 2024 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734721974;
	bh=iQnGYVwaajUJ7CmWsd19Cw2pgWco3tOwIfJCvwzDB/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h+5mQi/RikrWIjvDiJm6D1ZKOlrj0ejGEN17xdmsoYYFBQQ7jpF1MY8I6W41nt+R1
	 8OHb+XZMMwcBN2lAsjP7C88tHO4hH+XzEhhZu8RMrBf3E2a/oZOOZ4BjvrAyObCFkc
	 W49C07GS0vB/qMo4hiNGnCLG2gSbW0e5aBUEnOiUsryWdXBLnvNA8JhVnBv5Ire03Y
	 LSDvzIagIDzGRtxQwwEOL5afYN50sVmEi5wCE8PYetNAvgPDvY4FX8Pm7W4JdilyRi
	 LbY5BvxpXBnlAvEIccRjwqSLM70np0syY+6GqFE2bcepYfKdCPqqB7VEYFswnMcoOs
	 geTG58gzVFRmw==
Date: Fri, 20 Dec 2024 19:12:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Support ROHM BD79703 DAC
Message-ID: <20241220191245.2f96a115@jic23-huawei>
In-Reply-To: <cover.1734608215.git.mazziesaccount@gmail.com>
References: <cover.1734608215.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 13:38:54 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add support for the ROHM BD79703 DAC
> 
> The ROHM BD79703 DAC is a 6-channel 8-bit digital to analog converter
> which can be controlled over SPI bus. This series adds support for
> controlling the analog channels via IIO direct mode.
Tweaked the two trivial comments from Conor and I and applied.

Pushed out as testing for all the normal reasons plus that this was only
on the list for a day so there may be more reviews! :)

What can I say, it's near Christmas and I was feeling impatient!
> 
> Matti Vaittinen (3):
>   dt-bindings: Add ROHM BD79703
>   iio: dac: Support ROHM BD79703 DAC
>   MAINTAINERS: Add maintainer for ROHM BD79703
> 
>  .../bindings/iio/dac/rohm,bd79703.yaml        |  61 +++++++
>  MAINTAINERS                                   |   5 +
>  drivers/iio/dac/Kconfig                       |   8 +
>  drivers/iio/dac/Makefile                      |   1 +
>  drivers/iio/dac/rohm-bd79703.c                | 162 ++++++++++++++++++
>  5 files changed, 237 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml
>  create mode 100644 drivers/iio/dac/rohm-bd79703.c
> 
> 
> base-commit: 4d112ebd02d10faf202aa8335b06de0aca8b536b


