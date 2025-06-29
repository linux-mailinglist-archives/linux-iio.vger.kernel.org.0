Return-Path: <linux-iio+bounces-21128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F21CBAECF01
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA1A18906CE
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CB1232379;
	Sun, 29 Jun 2025 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHax899I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D942DF68;
	Sun, 29 Jun 2025 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217732; cv=none; b=oDN1Y/7FDuByvWML4iC/P45I0svQZUC5LaPPzDQeY4iU6PhpcmMz+UjZU+yTe/AaMaDsrZ/cRmGTWvu2bt5XQfa5HHXBfCqI2SQctXJ4ssi6NmmLjQ1TeT6qHRemya0DadpdDUv2kAjS4xBRbroSuHGr6GUwFEnsuI88YNCIM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217732; c=relaxed/simple;
	bh=XrP11innq+Dfv3pmX0f1K76FsEZ7sFl8ynAspjcEEds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRKO+7ovXypnYVmWnjiV+IrhYChLp4KyWvq7K3dnzPA6YJ7C7FQZiZ9cX/hEDAOndZdHBBtBSx33DOyrmGcCvr5u+1bwFTpt5XLxd+ozOZSX8KCivvSh/5p2EbldKsjKruPwHNWfdCirnUHVP2Ei1lCqQWsIqpCmzGTBh5qmDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHax899I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7E2C4CEEB;
	Sun, 29 Jun 2025 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751217731;
	bh=XrP11innq+Dfv3pmX0f1K76FsEZ7sFl8ynAspjcEEds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uHax899IZC2/o1p/VmP0JWkemwtaJPDaCj30Ev+i+Rd5qLP6QVfMkP7tzZp58Xdc9
	 LLR4H+0CIBsSJWUAvxY3X7NdtFiWewjmtP2Zi7c4hoVNCDar8baAG9zoU9FMtv+kqh
	 Bb3yrbqbkVqW40JcPrtpWH+vosSh4o8bDWN1u+GbW7K6WyhdyuhlxBwg21hWGKRBxu
	 MDl1zxHhZNpP7MspPjR4HF6B9erwBgOb7NysWdUyAXWAZtxPqHMUY6YEZPi5iAxod7
	 jpTi2DLbhZx9rQY0/Bq46efISQAVTlXsZFrGBpL3zja3QU6YQPPf+Fb5xI6DIpzNyy
	 0LrFZgtUfIocQ==
Date: Sun, 29 Jun 2025 18:22:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: proximity: vcnl3020: make vcnl3020_property
 const
Message-ID: <20250629182204.68dfa4ec@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-25-v1-0-5d99cf17790e@baylibre.com>
References: <20250628-iio-const-data-25-v1-0-5d99cf17790e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 13:23:47 -0500
David Lechner <dlechner@baylibre.com> wrote:

> We can make const struct vcnl3020_property vcnl3020_led_current_property
> const since it is read-only data. For this to really be useful, we also
> have another change to pass this struct by pointer instead of by value.
> 
Applied to the testing branch of iio.git.

Thanks,

Jonathan

> ---
> David Lechner (2):
>       iio: proximity: vcnl3020: pass struct vcnl3020_property by pointer
>       iio: proximity: vcnl3020: make vcnl3020_property const
> 
>  drivers/iio/proximity/vcnl3020.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-25-452e9458133b
> 
> Best regards,


