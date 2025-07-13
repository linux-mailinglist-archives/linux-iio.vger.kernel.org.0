Return-Path: <linux-iio+bounces-21626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB907B0320C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 18:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F58F7A14F2
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA927C162;
	Sun, 13 Jul 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dESv4oQK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13332594;
	Sun, 13 Jul 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752423231; cv=none; b=piv6XW3s0sKmEsuAH4os9YiHYcvk0Cyb26J1tOTzZIlr90BCqudU1OWGriHbV91sE7IbbmJbWANgR9jf5HTKQ1M+fjJV12BpoeLdCI2EMRPp748oSBC4u0Xki16Hp2j6/5sFKc4APKiEUcM2/3nK6kmhr0ImeANCZbRLgQ1e8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752423231; c=relaxed/simple;
	bh=lwqMcmb9kzS5fpq0wMbtS1pwIVY20vukUW9V5Dgl2ro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5Vq8dGAVmh6FAc51N4SJ9TTRzPI4e3OAxrBRFqQEONDryM8KEUrIumbbRr4R/Yujdyt178NAC4Ex8CCQXw2PNxNDEPIIG4GP8XMTsacNSEFHnguwciyJJHPSVJ6YJJW+5yRLRuLEINeq5KmT3W6iXTyWLj05QjbQNHF5ghcWD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dESv4oQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56487C4CEE3;
	Sun, 13 Jul 2025 16:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752423230;
	bh=lwqMcmb9kzS5fpq0wMbtS1pwIVY20vukUW9V5Dgl2ro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dESv4oQKzVX7k2PJFrp8iB9H9J0HlArhqbphhcWQZXdKPipMFCH9UnWyFu5ux/9ZG
	 Niqz4XJipCVt7kzkPOxPvZLWnzgRVenAyJca26dILfyogbQB5HwobVOatKtl0K69Aj
	 Dxu+9olhRx8LZfArGSxlZmwO/yx9WB/7OkW7MOPZcXpleMLe5bOdxvD2nbqFL3bg9d
	 2Qd9VD2iGIepxuit8nbCGY75PZuF+cAhNbxcbhFogOUeTCJ+IqfJKrXC8147MVxxTF
	 3RlAgEJnag1JBY77EvG0p0NXwOUfIrg/d4K9u1apSvq/e42fl/MpN2We8hFsh/Mj4l
	 /OtGUCWrWlbtg==
Date: Sun, 13 Jul 2025 17:13:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: Few cleanups to vf610 and ti-adc12138
Message-ID: <20250713171343.6c63ddc4@jic23-huawei>
In-Reply-To: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
References: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 17:59:54 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Just few cleanups.  Not tested on hardware.  Only the first patch could
> have an observable effect.
> 
Applied 2-4.  As the 1st patch is more complex - I'll let that sit a while
first to see if anyone had views on the ordering change.

Jonathan

> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (4):
>       iio: adc: ti-adc12138: Simplify with devm_clk_get_enabled()
>       iio: adc: vf610: Drop -ENOMEM error message
>       iio: adc: vf610: Simplify with dev_err_probe
>       iio: dac: vf610: Simplify with devm_clk_get_enabled()
> 
>  drivers/iio/adc/ti-adc12138.c | 30 +++++++++++-------------------
>  drivers/iio/dac/vf610_dac.c   | 23 +++++------------------
>  2 files changed, 16 insertions(+), 37 deletions(-)
> ---
> base-commit: a62b7a37e6fcf4a675b1548e7c168b96ec836442
> change-id: 20250713-iio-clk-get-enabled-4764482c8ff3
> 
> Best regards,


