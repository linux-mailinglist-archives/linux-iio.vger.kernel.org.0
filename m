Return-Path: <linux-iio+bounces-6740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A4691397D
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E75C2810F8
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF2412E1E0;
	Sun, 23 Jun 2024 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US3CKzY9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127F12E1D3;
	Sun, 23 Jun 2024 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719137709; cv=none; b=ZlatQwVQsov4HPyZft4ZoxfgDZnqgGMibKF/A1sq/JNRJSRIIWwmtNhiik8MOQQNDgUsMLGSjMJppEy9zvthvkBeSixghMAYK3RhdhO/eTHpybmPbjD6oZeY5gEZSaXl0n9/0bd63JsdD1v+XgAyp0P8z/d8rkQZMNKctiAna4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719137709; c=relaxed/simple;
	bh=uOZclHSo+YCAfe4mX16NYlXQzPPx/B5Swe1Q2hmbKMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFJJ4JavSV+suZ2uMB9TyWt/l+r+eedR6MBAAzROLtJdsTr7UvOmSs4qdRAvdtS+dt7SWSNCbxAcGWl1SQJawSjthML2ZUK/567Zh/x6ZBiCk9qg8o3UUPp0y1XWi1OzLexC+zwXIel4ofcrFPpfrIrGBRTzUMeEZ8MKKIvGHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US3CKzY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D953C2BD10;
	Sun, 23 Jun 2024 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719137709;
	bh=uOZclHSo+YCAfe4mX16NYlXQzPPx/B5Swe1Q2hmbKMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=US3CKzY9glSlqIQWmMVEc+HY8NQl/ATnb0KMse281M2ee3F55GjcKUDgZhUi4Hu9c
	 5bGqwQf0ph7HkPT6Nh53reps0S90YbE4YTYr85eLu7Z8V7ZYwzCPxTu38xCui7/yN0
	 VBDUlp17vqXlWcsvu6eG6UWkml60QoL5oUYv+A1BH1IyMnLBMNbTmyrMd8kb588eM4
	 /WOQ4b1mSHkisMJdsLnd20rGNKGcLXf71DXU2wL7itIzImiG7Qld5hoP2SAvKl+UCK
	 ehR2PQRvIe7xDik1dUMZLMvEMpTdd5prlfYubQSQUl/5RvWIgpMyhRRto5S+t8XSEg
	 C7NPpds73mmRg==
Date: Sun, 23 Jun 2024 11:15:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] spi: add devm_spi_optimize_message() helper
Message-ID: <20240623111500.3c8162e3@jic23-huawei>
In-Reply-To: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
References: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 15:51:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> In the IIO subsystem, we are finding that it is common to call
> spi_optimize_message() during driver probe since the SPI message
> doesn't change for the lifetime of the driver. This patch adds a
> devm_spi_optimize_message() helper to simplify this common pattern.
Looks good to me.  Obviously I need Mark's ack or an immutable
branch to pick these up though.

Thanks

Jonathan

> 
> ---
> David Lechner (3):
>       Documentation: devres: add missing SPI helpers
>       spi: add devm_spi_optimize_message() helper
>       iio: adc: ad7944: use devm_spi_optimize_message()
> 
>  Documentation/driver-api/driver-model/devres.rst |  3 +++
>  drivers/iio/adc/ad7944.c                         | 26 +++--------------------
>  drivers/spi/spi.c                                | 27 ++++++++++++++++++++++++
>  include/linux/spi/spi.h                          |  2 ++
>  4 files changed, 35 insertions(+), 23 deletions(-)
> ---
> base-commit: 0ca645ab5b1528666f6662a0e620140355b5aea3
> change-id: 20240621-devm_spi_optimize_message-ebbde029dd7a


