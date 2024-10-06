Return-Path: <linux-iio+bounces-10249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F52991EC0
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E61C20E89
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DAF482EF;
	Sun,  6 Oct 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF58SFNt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192B2A8D7;
	Sun,  6 Oct 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728223831; cv=none; b=prIetotdPL3VLZSAy2IDlYCLmyy5uOsAdoQzocOLvgvTgPanUErE5m9WM6btGHhYVu+un1J60wwCLBCND2EJTuBdTxgOjhIRLbuExN15AV58JBIt2e1KlDKUkFh2CjJbEg8IYfiknphWOmjznPDdTyY0d3F8WCcMNKc3NgXUd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728223831; c=relaxed/simple;
	bh=6+KK/Rig/MKqLrBWeEuIvA5abM0tMADgpM0DP+ClW0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlDaOPmleaPiAAQ8mtRIUjrRJzyU0YdmfPI1UPfszbkCGzNymdW+7w6cTedIrlqf2X0flsAkr88GyNZXWX2D9GFRSUi2rcrB9W8NZTNjrYtFxWfTiz4tbbLI0/cERMCMP8EzEqltXKtxKvDcUws3+fDHnsFJsrY/t1Xp03dToJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF58SFNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E695FC4CEC5;
	Sun,  6 Oct 2024 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728223831;
	bh=6+KK/Rig/MKqLrBWeEuIvA5abM0tMADgpM0DP+ClW0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jF58SFNt9cnnDUZYh1rVX+XCporbFAwd6FE5gMloR/xXtHYG5lfWbzvNeVyoK15oz
	 lY/Ku0SxkfdGpT5DwdhNrmvQ6wi3beNCOaOp7aPkPFuoTr6Bo21jjfTHV8xeVHjSIV
	 qlRQBMrgOCYKCLyz/v5idxRrhXBnm7rhR3QznHKm7k9205N8RNhD0pYwOCudeT3NV2
	 QI5qOs8VZ+6qbgOHk6wc9vrg5bRqrcAf5E2MxrBOFF5RLMKjTK5/6itXctuVvHKtQ2
	 vnmV5wfXp2Gpv1BpTOglw47HPRFsAU9YC4De9dQdLc+qne3F/pXD0ScRvHahS8KKsM
	 C73mem0PBAu3g==
Date: Sun, 6 Oct 2024 15:10:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Krzysztof Kozlowski <krzk@kernel.org>, Conor
 Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/9] iio: light: veml6030: fix issues and add support
 for veml6035
Message-ID: <20241006151021.17540fb7@jic23-huawei>
In-Reply-To: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
References: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Oct 2024 22:21:13 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series updates the driver for the veml6030 ALS and adds support for
> the veml6035, which shares most of its functionality with the former.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Nice series.

Applied to the togreg branch of iio.git and pushed out initially as
testing for 0-day to take a look at it.

thanks

Jonathan

> ---
> Changes in v3:
> - drop applied patch [1/10] (fixes-togreg).
> - Fix indentation of the vdd-supply property and make it required.
> - Fix formatting (double space).
> - Fix array formatting (space after {, space before }).
> - Move action to hw_init function and add dev as an argument.
> - Link to v2: https://lore.kernel.org/r/20240923-veml6035-v2-0-58c72a0df31c@gmail.com
> 
> Changes in v2:
> - Rebase to iio/testing, dropping applied patches [1/7], [4/7].
> - Drop [3/7] (applied to iio/fixes-togreg).
> - Add patch to use dev_err_probe() in probe error paths.
> - Add patch to use read_avail() for available attributes.
> - Add patches to use to support a regulator.
> - Add patch to ensure that the device is powered off in error paths
>   after powering it on.
> - Add patch to drop processed values from the WHITE channel.
> - Use fsleep() instead of usleep_range() in veml6030_als_pwr_on()
> - Link to v1: https://lore.kernel.org/r/20240913-veml6035-v1-0-0b09c0c90418@gmail.com
> 
> ---
> Javier Carrasco (9):
>       iio: light: veml6030: add set up delay after any power on sequence
>       iio: light: veml6030: use dev_err_probe()
>       dt-bindings: iio: light: veml6030: add vdd-supply property
>       iio: light: veml6030: add support for a regulator
>       iio: light: veml6030: use read_avail() for available attributes
>       iio: light: veml6030: drop processed info for white channel
>       iio: light: veml6030: power off device in probe error paths
>       dt-bindings: iio: light: veml6030: add veml6035
>       iio: light: veml6030: add support for veml6035
> 
>  .../bindings/iio/light/vishay,veml6030.yaml        |  44 +-
>  drivers/iio/light/Kconfig                          |   4 +-
>  drivers/iio/light/veml6030.c                       | 464 ++++++++++++++++-----
>  3 files changed, 387 insertions(+), 125 deletions(-)
> ---
> base-commit: 19332fe4bd4659b2e3988f17b4d5dc59a86c266d
> change-id: 20240903-veml6035-7a91bc088c6f
> 
> Best regards,


