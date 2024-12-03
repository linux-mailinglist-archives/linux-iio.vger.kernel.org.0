Return-Path: <linux-iio+bounces-12987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8857C9E144D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 08:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2D0283101
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 07:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C02500A8;
	Tue,  3 Dec 2024 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQJLAW0S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433242500BD;
	Tue,  3 Dec 2024 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211215; cv=none; b=nuljyD1ReYua8hEc0907NYdWUIDaJSTCTcfmy9itCzZVv8kWl87L5Hicy1Or0mYnd9scCLWciVx3e8Ihp3CbJoHeFW8QT9M18NEAFouxb1Iu8gAd+kqOTi+isfbdriQ5pNdTnW8mNFEhNXgr4kVl61nr/ylG9/h7jwE6Ww6NBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211215; c=relaxed/simple;
	bh=T4eN6pNDOjZnwidPG7cu0volcseWSi1XdkMehtdNmKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL6UOL1UCRIMtLj5gE/thAIfPll+v/gij+Lp9oYp8b9s6p51sf/Ct0Y4gNhotSDDUH/kakZ7ZX7xUYjsQhDmSRlH3TJaw6afWKb6KjJwIIvmOd/1W9f+9kofNUn+uG4oWG8BpnZwEXzF4q2fYrnITTDyG4gNNDql528wdanEtuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQJLAW0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72BCC4CECF;
	Tue,  3 Dec 2024 07:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733211214;
	bh=T4eN6pNDOjZnwidPG7cu0volcseWSi1XdkMehtdNmKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQJLAW0SiNkVflHOHKEmPlaV7TM7HLSPGkbEtRZso+7rQxFX1ftPWgEpE7mTtzLyI
	 JTr4T+slme0l7HZtkFLI8raQFVl/qatF+zdeEaI2B4Zyomq83S/btF/OsdcP/EJ/n7
	 Rq3BWSV8fmb96eZcIXAipXiN6APAZieVtN2In1ooxqtGq5WxmypwzTPAeIw1KVtmVq
	 8bYOOxT0rXTmbDlRBN7biWv6D4RIvOQC7930bapr+qDy64+/PBmvzkh6dCE0K3K4FE
	 QggVI2ZpGdhQzhtVwHf9lsV+Y3LxN0nxcHYtZajLyUKq76GC5Dp6IhNB3bxXNk8Uqy
	 4JzYHe33WRiWg==
Date: Tue, 3 Dec 2024 08:33:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v6 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Message-ID: <wqiiqne5xrxhpbokrkn37tafi2u2dgnxzai3faworvz5zo3cg4@eayiq5w2mxjm>
References: <cover.1733147443.git.marcelo.schmitt@analog.com>
 <cc05f1471c409ab38722cd0e80fd5857ff9ce5db.1733147444.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc05f1471c409ab38722cd0e80fd5857ff9ce5db.1733147444.git.marcelo.schmitt@analog.com>

On Mon, Dec 02, 2024 at 11:07:38AM -0300, Marcelo Schmitt wrote:
> Extend the AD4000 series device tree documentation to also describe
> PulSAR devices.
> 
> The single-channel series of PulSAR devices is similar to the AD4000 series
> except PulSAR devices sample at slower rates and don't have a
> configuration register. Because PulSAR devices don't have a configuration
> register, they don't support all features of AD4000 devices and thus fewer
> interfaces are provided to user space. Also, while AD4000 may have their
> SDI pin connected to SPI host MOSI line, PulSAR SDI pin is never connected
> to MOSI.
> 
> Some devices within the PulSAR series are just faster versions of others.
> >From fastest to slowest, AD7980, AD7988-5, AD7686, AD7685, and AD7988-1 are
> all 16-bit pseudo-differential pin-for-pin compatible ADCs. Devices that
> only vary on the sample rate are documented with a common fallback
> compatible.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v5 -> v6
> - Made compatible property doc similar to other ADC dt-bindings.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


