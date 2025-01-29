Return-Path: <linux-iio+bounces-14721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9325A22203
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE691624A6
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E931DF255;
	Wed, 29 Jan 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H//wKLLR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823313957E;
	Wed, 29 Jan 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169185; cv=none; b=TB9Spg5PUkgxkbjnJl80Ok/wQEH4ORPhBaPcehxAVKImy5m7Ym+qYwsUlYq7A3sEfbShY4UVLERZClHFxUKOfAoNBwGhtEMJjVS8cfLeAHJC8CA3BZ0qGiVdSLom/EEL6rTN6Zr2J/5rPofL6JIpZ277iPhCeWhKtqXHInOMUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169185; c=relaxed/simple;
	bh=+7dE6xxM1MDrrSw+p+oGO9/K2fEH2oBNr9zQLgO5+9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9YEZDvVS8rsxKGqEnWu/8OVHV6iXqPVxfrLJQZMzCRy9+8P+L/BzTUXl9KXvF8ZpJmYPcxyaDX07e5O/clf+WpJW4GtPpxSeMjJ40ymOs+VR2qwYZlShZjd0a7nKtBT4wxKivtAqExapf2ECGy6asHrw4WwO6T0wgwgEbqYbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H//wKLLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB87C4CED3;
	Wed, 29 Jan 2025 16:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738169185;
	bh=+7dE6xxM1MDrrSw+p+oGO9/K2fEH2oBNr9zQLgO5+9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H//wKLLR39baaQLqUDBlA3B079tJFKWNOSQdXhYOqvPR7gCwJXn+1af+DPjgG8XJP
	 aQXB2MTDSWJ2Gz8xN8vb9n2c/cX/f1lBjvYAn6ydN5gMXN8M5Mm0HSESRmAcEJCrSC
	 8iuV/Hp2ZyZmiNJ0Y0GuuQ4MCCTntklZXD1cEpqj59rxQX8MX801w28J1oZip0qVku
	 Nb4esqEPw6/5pZ8ZspAOcWkhb81ruezQKLQhVYhoPrduwlqtJicM/9i+nJZCgIHtkb
	 sCicGAsTWxXYz7tB71fRAnRrPQ+qJA2S6Hg/IipfzbITIudjpBgITtxPgwDLG5OctD
	 6ls+ZmzpJzE9Q==
Date: Wed, 29 Jan 2025 10:46:24 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Guillaume Stols <gstols@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 02/10] dt-bindings: iio: dac: adi-axi-adc: add ad7606
 variant
Message-ID: <173816918368.2213890.7415978291666353573.robh@kernel.org>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
 <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-2-c3aec77c0ab7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-2-c3aec77c0ab7@baylibre.com>


On Wed, 29 Jan 2025 12:03:03 +0100, Angelo Dureghello wrote:
> From: Guillaume Stols <gstols@baylibre.com>
> 
> A new compatible is added to reflect the specialized version of the HDL.
> We use the parallel interface to write the ADC's registers, and
> accessing this interface requires to use ADI_AXI_REG_CONFIG_RD,
> ADI_AXI_REG_CONFIG_WR and ADI_AXI_REG_CONFIG_CTRL in a custom fashion.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   | 70 +++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


