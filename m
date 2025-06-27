Return-Path: <linux-iio+bounces-21010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3236AEC08E
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 22:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA88169596
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894202EA73F;
	Fri, 27 Jun 2025 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDbSwn3P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4215F3FF1;
	Fri, 27 Jun 2025 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054648; cv=none; b=TxY5HOqi+mWXtkLQ1qxRLnXoWfg18A5HhT31urnuTQVNaNr0slUAc0wgvqDVA9Mx/GYe9PSMs6hgIbaVTNYKosNRgxsx5+Wgj6eufSXdDrmDDjUfnT19aQJwezQdVxem6iIm5shki1Spgh5kbej2Y/TjYcOBF/pzgiGV93nXd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054648; c=relaxed/simple;
	bh=tgwNd1+4u4rC2Sp0anrqTJg1qUn+7u4c6tn8yXP30sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpB8UgFO+4xu7NEBE3BDRvmomsaGUFcvlcJvdsbvbivr1O2fnFq0peF9v5GAX4laP6+Vie88QK50Q6O96VZCKcbIxtcW2pyU/F/cM2DDwpIIGpNuBbzdpK+k7wDNjBU+WXq6l+DUQ5ndUZT9UTI1lrmrMSMRxCBi9zoX61BR/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDbSwn3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED8CC4CEE3;
	Fri, 27 Jun 2025 20:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751054647;
	bh=tgwNd1+4u4rC2Sp0anrqTJg1qUn+7u4c6tn8yXP30sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDbSwn3PG6J7xcqj4WyOyCLZ1D2ALUJQcdlUyS40uZlTCkMNukQxkz2Rhi8iAdmtU
	 0WLParewBb/lZrCh8C/zZCz6viU1ie2dvVFSty8gADvJG36hKRHvTSouRNJgBE5hzQ
	 WcDMc5/nf/g/nCBG0nWJQQNqZbS9SK+6FH5Z/OlDt2jRw2dkihyuYyuoMJl3BVupP7
	 KpV3ilsPXVPIUyynaPLwpl9i90nP9YlVgGoHhyVuob9T2AbMmFUgDOyh/gVETrbnRk
	 TpdNtnC4fNA3vmNhlsqBYcsc45dfLjPol2s54kCQZ7ZVxFxYf2q16VRy6bbZc1KoEj
	 KzgPDTSsR2oaQ==
Date: Fri, 27 Jun 2025 15:04:06 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 2/5] dt-bindings: iio: adc: mt6359: Add bindings for
 MT6373 PMIC AuxADC
Message-ID: <20250627200406.GA4090376-robh@kernel.org>
References: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
 <20250623120028.108809-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623120028.108809-3-angelogioacchino.delregno@collabora.com>

On Mon, Jun 23, 2025 at 02:00:25PM +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible and channel bindings for MediaTek's MT6373 PMIC,
> featuring an Auxiliary ADC IP with 15 ADC channels for external
> (SoC) temperatures and external voltage inputs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../iio/adc/mediatek,mt6359-auxadc.yaml       |  1 +
>  .../iio/adc/mediatek,mt6373-auxadc.h          | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h

You can drop 'bindings for ' in the subject. We already said 'bindings' 
once.

Acked-by: Rob Herring (Arm) <robh@kernel.org>

