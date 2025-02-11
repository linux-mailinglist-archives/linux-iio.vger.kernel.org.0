Return-Path: <linux-iio+bounces-15364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29792A3162D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFE818898C9
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5758C26561F;
	Tue, 11 Feb 2025 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdZVgMh6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF9265605;
	Tue, 11 Feb 2025 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303837; cv=none; b=B0U7kE6wQgxsYouUhBprOs0sQQq1Wj2IhIMKQxRxbLmGGeeHliJCy/LCLzOYqSNUGBLDFF7MN+GzEA1v+IZCdnpZW7VYYtdLamBtcWPHz1kdIV1Y86WTfBv0njw2qz9j61uCkGZYlwXFyTVHcR8qVS4QQqosFdPxQRqy1zxW+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303837; c=relaxed/simple;
	bh=IV9T9bitTlYtN5sne85kozOsvatYZdCUdUerPTORWek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PG8VIan50FBKMilGyMp2AwvANNMcNQat0keHhJfM6GDldDfZX5nvf2QkttNEOFg00FR2OHlTRlTLD8ArhPSaN37t9situ70gnz8iXQ3ehGy5qm9O4eKBnlg4ie7ykNThgLN8jJDx+fnZkTurnpGfcfJk5UpHyKHAFGrcgtCuN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdZVgMh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA8EC4CEDD;
	Tue, 11 Feb 2025 19:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739303836;
	bh=IV9T9bitTlYtN5sne85kozOsvatYZdCUdUerPTORWek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KdZVgMh6n7bFBpRHaiVtvwzlDjSFrhY03C12fyEtCAcjxowLFtwOL1uG5jMq0wphS
	 XwUg+gwK14l7QnfeabLwPfsZ+Yv5BZK0E4IwfI1Xn1Uy0FiOt9Gt1ZG02jObIJ11L8
	 /w/d+o/AhOrNSkhSRfsMQVSBm+67qI5c+cMdTj7xAZdP+Rzqg0APeLHNxU78vhx/E5
	 v94UiDb4GgkfjtMiby31jcNYD/gIeB+ZfxOIA9D8J/TleFY/s6ZXIrdb8tajeAP7En
	 P8gIGuggZXEbXJ9lwfMJ8TiANZMyUvay4uaLYxyaQRs15cHkbVjheKB8E5bxMxn0p4
	 3JY5NrAizYlgg==
Date: Tue, 11 Feb 2025 19:57:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alexandru
 Ardelean <aardelean@baylibre.com>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Guillaume Stols
 <gstols@baylibre.com>
Subject: Re: [PATCH v4 0/9] add support for Software mode on AD7606's iio
 backend driver
Message-ID: <20250211195706.5b3565ba@jic23-huawei>
In-Reply-To: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
References: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 17:10:50 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> The previous series added iio_backend mode, but the configuration for this
> mode was only possible through GPIOs (Hardware mode). Here, we add support
> for configuring the chip using its registers (Software mode).
> 
> The bus access is based on Angelo's ad3552 implementation, that is we have
> a particular compatible for the backend (here axi-adc) version supporting
> the ad7606's register writing, and the ad7606 is defined as a child node
> of the backend in the devicetree. Small changes are added to make the code
> a bit more straightforward to understand, and more compact.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Applied to the togreg branch of iio.git.  Briefly pushed that out as testing
to let 0-day take a first look.
Thanks,

Jonathan

