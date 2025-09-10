Return-Path: <linux-iio+bounces-23946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91371B51DC3
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0565C176C4E
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDAF2441B8;
	Wed, 10 Sep 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr5h2gXi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DE329F38;
	Wed, 10 Sep 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521945; cv=none; b=omRNLQHbP7R0Q9qA8EgSn2iUrhqvnik8dDQ0/UwZOUO9fDhnX12yRbMP5uCrgu6qeISNRPAmCJva2k4EegV6kUpA5UxXdqkoXDEkcmajKvvCNwcpVJXZH89nDRsc9h5c3a8kflc4ITa/bFzCp0Dh2kT5kOnk24jZ5CGBr5cKnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521945; c=relaxed/simple;
	bh=WJ4WgkR/oVSTrlta7qBuOlEgKvSTav5ph5RoX1ymhRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZC8frjR5QQB3RWte2I1Egud/xnfEbBRVMVqruNJx0cJ5er4fZ33VSErmgpWRILG95DQBTrHAhshwNqaxTJC8N34O4R073WboePA1ncMWSkz/DvuaY6+qBaHLEucw83GoG/SEcp0X1yrDAVW+yP/oT19iZZthZ2MdkgM11bq/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr5h2gXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B136FC4CEEB;
	Wed, 10 Sep 2025 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757521944;
	bh=WJ4WgkR/oVSTrlta7qBuOlEgKvSTav5ph5RoX1ymhRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rr5h2gXiF5tnw9s8QkH6j1V8V3O7Ac8k0aVyFGk7IHb1o8gzO/xElnXaPiYcPXl3k
	 h6ZLwUCIt7FreRdMreZTRT0QlAPeRlW76m17KXoIS+Pz/R06DAvH3Fm/pC0rPbJi74
	 xiSm2wvRJ12l2tQJobAMEBDdMKwYMhR52+To8A5Vab3B8llc8WM66Lkos54sXxHWf0
	 7CsZr+SZPj7W6yc92+aZPGKQRJTnkyOsKjhqE1gFwrsOxe5q60+vNG5zAushhyGvdv
	 NSB6m9ciIQ2SIA0/YbBZafdTFC9M/GzUs5NAxwXez6V/RSoSyF5sl3fJS9x3uBs8dc
	 QZg8W3ovead3g==
Date: Wed, 10 Sep 2025 17:32:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Gerald Loacker
 <gerald.loacker@wolfvision.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: magnetometer: cleanup unused
 IIO_CHAN_INFO_PROCESSED handling
Message-ID: <20250910173219.60fec37c@jic23-huawei>
In-Reply-To: <20250910-iio_chan_617_rc5-v1-0-924091d374be@gmail.com>
References: <20250910-iio_chan_617_rc5-v1-0-924091d374be@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 19:36:48 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> This series cleans up dead code in the magnetometer drivers by
> removing unused handling for IIO_CHAN_INFO_PROCESSED. None of these
> drivers set this bit in info_mask_* fields, so the cases are never
> reached.
> These changes reduce code paths, improve readability, and make the
> switch statements easier to maintain. No functional changes are
> intended.
> 
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> ---
> Dixit Parmar (2):
>       iio: magnetometer: als31300: remove unused IIO_CHAN_INFO_PROCESSED handling
>       iio: magnetometer: tmag5273: remove unused IIO_CHAN_INFO_PROCESSED handling
> 
>  drivers/iio/magnetometer/als31300.c | 1 -
>  drivers/iio/magnetometer/tmag5273.c | 1 -
>  2 files changed, 2 deletions(-)
> ---
> base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
> change-id: 20250910-iio_chan_617_rc5-59be964d7451
> 
> Best regards,

Good find. Applied to the togreg  branch of iio.git and pushed out as testing.

Thanks,

Jonathan

