Return-Path: <linux-iio+bounces-21378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B98AFA428
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BDA3A75FC
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218C31F9F61;
	Sun,  6 Jul 2025 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVXDjdfR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E6145355;
	Sun,  6 Jul 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751795501; cv=none; b=CKPR9/1tswhVdVu0m2KoJrYgk59w/VsUCICAFmdzfDH05nWIPUtvmRN8iEyknoM/SllBpfU6Oe6+T7kasbrZV1csgGUl8jP57Dt9uAHGieGG01seKf1z5FzLN2goEragNgwTPmezo68u1e0OYCenlL9/UIjg/aTzZWymWCaAvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751795501; c=relaxed/simple;
	bh=kxnzSceAwuYi0YrqNkljwF9gWxBSBTLMe3ataLh2uMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSDwwDV51Cee5S5GCiGzA7duEYSVu0aiH3IDEZLoAs57+1DkW9esD4SLVUpIcC0Lnwz695RV0RkqZIW5/etx6cgYVOTzAdcMJf16Nq/3bN0R0DUQmyA7xz0VpQ0GyO+kX6e2XOHMyVaF0NxcMNNHAs0pa+eWYDptjhbcCyt/7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVXDjdfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13543C4CEED;
	Sun,  6 Jul 2025 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751795501;
	bh=kxnzSceAwuYi0YrqNkljwF9gWxBSBTLMe3ataLh2uMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVXDjdfRxEVD7EBflkf2s4nGP5ardTX0S750RRwCOTxZqwkwQVPhJmPtdbwiFndK2
	 6ug4otjGoxuc0X+tSAUqiyZsRbXL0MV6W2i5wUy0nbffXVhfYp2qYyjHTXWoYAoi36
	 hHLnEWFrcjlGTmWRykBDuGbwHz406UqNPvCP4bCGdqrKPKYlK2XLQqyzcvJTkuy2k4
	 vJFelTH91FTgKTnODq+3Z6W9KxJnq04D4flN+9ZTc5x/TCu0IP/j7OSuQ+/jpg3tQ2
	 5lwB66lIlVWvYcmiQTBM+Xch2jN9L3p3eTAnzQHkLGPPuTyVjgGDEMR5Ikk6oTiGBn
	 SK2ruCJr3kwRQ==
Date: Sun, 6 Jul 2025 10:51:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: light: cm3232: make struct cm3232_als_info
 const
Message-ID: <20250706105134.0f327b3a@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-20-v1-0-2bf90b03f9f1@baylibre.com>
References: <20250628-iio-const-data-20-v1-0-2bf90b03f9f1@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:52:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Typically, chip info structs are const. Before we can make that change,
> we need to move the calibscale field to the driver data struct. This
> also allows individual instances of the driver to have different
> calibscale values.
> 
> ---
> David Lechner (2):
>       iio: light: cm3232: move calibscale to struct cm3232_chip
>       iio: light: cm3232: make struct cm3232_als_info const
Applied.

> 
>  drivers/iio/light/cm3232.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-20-1f1a05001890
> 
> Best regards,


