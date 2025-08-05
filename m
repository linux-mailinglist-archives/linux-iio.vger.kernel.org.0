Return-Path: <linux-iio+bounces-22300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA4B1AEC3
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 08:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93496165CD5
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 06:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F1021E087;
	Tue,  5 Aug 2025 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTsEJoO3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802121D590;
	Tue,  5 Aug 2025 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376698; cv=none; b=nwD2iI/1+pwbKLQo1H9MJmwNbvEfVms9M5KnwNI4K9qnQLV/ub0x/7k/orswNwhcAINDPgqzXYLqlf//Md+re4fipPCdoJdPCjNE5vimepcJquADdONOwOs1IQp6+239yFENSFpHk2eKBc+hyqNY2HZqk0gjkZjMpiuUS1IorgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376698; c=relaxed/simple;
	bh=2vhYiK9y/EgMAQMFYv1KpiYYEmofbXB6Kpl40cFvolU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCkfb/xfQO0niy03cHrmlgcQmc566g/PTzDkA86bj4Y34vkZvTQL/WggIk6n2PHsQE7P357tZEgKixfTCj2vnWsbU+FHcQhgGWL9T1eaf6mJDGa6QqVrYgfIeo3tZbZw/wUbrCTNHP3Mv7Qs2VA9WF5w1YXykJYDatxy7kZyMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTsEJoO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167C0C4CEF4;
	Tue,  5 Aug 2025 06:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754376696;
	bh=2vhYiK9y/EgMAQMFYv1KpiYYEmofbXB6Kpl40cFvolU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTsEJoO3F8w2Eo7qxTjajp+cezhSwl9wIMjKbvGSUnrwF3fGDSCpQ+iJMRGaJxRRJ
	 5glHnaCrHEmNtWPuM85Ob6op+nGctz1GYEEMC/+yXbNHEI6n/sp71g14PPEzaR0Opw
	 Zp3HnmHW9SWcghyJP18Fs73OtOqCS4fsYvWMj3rorprS2oKpwnIb42CM8P4vUQxH8T
	 Gj7TfYW+mH3oxA54x/i58s6YMAFuF7Wg2ehXWhG/3FNrfxDOlUivGvWp8BpJho0Vd9
	 65zc7lWrq7XphfKZWu8b+VKbM8N1fdv1eso/f3UMw+l2LfJpUWhZ3KdGIDQcAHaqO7
	 /GEc38pAh9mrw==
Date: Tue, 5 Aug 2025 08:51:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, srini@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] ARM: dts: microchip: sama7g5: add packet tag as
 offset for calib
Message-ID: <20250805-calm-kestrel-of-fame-a7c9b3@kuoka>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
 <20250804100219.63325-6-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804100219.63325-6-varshini.rajendran@microchip.com>

On Mon, Aug 04, 2025 at 03:32:09PM +0530, Varshini Rajendran wrote:
> Add packet tag as offset to access temperature calibration data from otp
> memory for sama7g5.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/sama7g5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Not only driver breaks users, but also stuffing DTS change in the middle
of patchset instead of postponing it, breaks kernel.

Please learn how SoC trees are handled. This is clearly documented.

Best regards,
Krzysztof


