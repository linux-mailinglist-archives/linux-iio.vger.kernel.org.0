Return-Path: <linux-iio+bounces-22785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AEFB28CAE
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3E6AC10E0
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A616F28D827;
	Sat, 16 Aug 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rlb05og6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57728C039;
	Sat, 16 Aug 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755338969; cv=none; b=GiFglRHB/lQ5lLHn0/CjGQYxG0DOjsChIW6TYHE2NHq7OCg665iSaiUQ5l226DHCKBqaZ6KX/Z5eMJZ1ql/xI1HTkIV6FbI/YKFRdCQkF2/4msKhIQV5mURq5IY96nca+A1t2EjWbChRM2hZAW1a4nNptr8CaD3jDFE3e8Y75v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755338969; c=relaxed/simple;
	bh=jaTxjgtJrNRkh/dbTd55p8FruDlWhMwNR666ZZJv3OU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DN/tLUMl21V+oqn6D30ogeo3v+8ltB7zh3vFGAptm9qLlpuNdovoTY5+mHkiF5Qg/yji/ZLs4gBZ85zMCQjHCMVvebBgpBaAOENwspLe2NW/+46WOPYgtE180Fq62qj2EgwxtVl2gE7siyqUlIwWIn+vXCVIm8noyrtRtFlT1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rlb05og6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51335C4CEEF;
	Sat, 16 Aug 2025 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755338968;
	bh=jaTxjgtJrNRkh/dbTd55p8FruDlWhMwNR666ZZJv3OU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rlb05og6ZnSD8IZnNAHaeH/mIIvjVOmqALFStsQW0523dhUMabwOLIwRp4Jp143z2
	 WnClgwkn2pGCM9vqHKRzKW52bbrJrSoNB1DHxrQavVQ9tWKrDZbpsdtTQ5dlX8tRaA
	 f7Qjl5Gvsc0gDrBwft/4BNIXInmKD3+zkjendCh1bTr2HyldNp75jLm+UhuI8yBnMf
	 V6NdL6fh6SmZ5Id8u1bjjkaQVANciUe9kkpIBq7Kt1WYjTFWI/prn8ZMGamkrOU7va
	 V6UsnjY7+apjxbVz2bIiHv4egmYumdojR44XG4eJlhYAzFSENfL2WTJlibTVFGmQtC
	 Xi04Ii8W/XJKg==
Date: Sat, 16 Aug 2025 11:09:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ben Collins <bcollins@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Hepp <andrew.hepp@ahepp.dev>
Subject: Re: [PATCH v3 0/5] iio: mcp9600: Features and improvements
Message-ID: <20250816110918.76858b07@jic23-huawei>
In-Reply-To: <20250815170304.22606-1-bcollins@watter.com>
References: <20250815170304.22606-1-bcollins@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 17:03:00 +0000
Ben Collins <bcollins@watter.com> wrote:

> From: Ben Collins <bcollins@kernel.org>
Ah.   Given this didn't get threaded with the previous posting, it can end
up in a very different place in peoples in boxes.  If you miss a version
number or something like that just reply to the cover letter to say so.

Either way patchwork etc aren't going to figure out which version this
applies to.
> 
> ChangeLog:
> v2 -> v3:
>   - Improve changelogs in each patch
>   - Based on feedback from Andy Shevchenko <andy.shevchenko@gmail.com>
>     * Set register offsets to fixed width
>     * Fix typos
>     * Future-proof Kconfig changes
>     * Convert to using chip_info paradigm
>     * Verbiage: dt -> firmware description
>     * Use proper specifiers and drop castings
>     * Fix register offset to be fixed-width
>     * u8 for cfg var
>     * Fix % type for u32 to be %u
>     * Make blank lines consistent between case statements
>     * FIELD_PREP -> FIELD_MODIFY
>     * Remove explicit setting of 0 value in filter_level
>   - Based on feedback from David Lechner <dlechner@baylibre.com>
>     * Rework IIR values exposed to sysfs. Using the ratios, there was no
>       way to represent "disabled" (i.e. infinity). Based on the bmp280
>       driver I went with using the power coefficients (e.g. 1, 2, 4, 8,
>       ...) where 1 is disabled (n=0).
> 
> v1 -> v2:
>   - Break into individual patches
> 
> v1:
>   - Initial patch to enable IIR and thermocouple-type
>   - Recognize mcp9601
> 
> Ben Collins (5):
>   dt-bindings: iio: mcp9600: Add compatible for microchip,mcp9601
>   iio: mcp9600: White space cleanup for tab alignment
>   iio: mcp9600: Recognize chip id for mcp9601
>   iio: mcp9600: Add support for thermocouple-type
>   iio: mcp9600: Add support for IIR filter
> 
>  .../iio/temperature/microchip,mcp9600.yaml    |   6 +-
>  drivers/iio/temperature/Kconfig               |   8 +-
>  drivers/iio/temperature/mcp9600.c             | 209 ++++++++++++++++--
>  3 files changed, 201 insertions(+), 22 deletions(-)
> 


