Return-Path: <linux-iio+bounces-12568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC3F9D7083
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 14:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F71B2259C
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B40A1E5717;
	Sun, 24 Nov 2024 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFeZLnGG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B9F1E570A;
	Sun, 24 Nov 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452463; cv=none; b=IYrUlrXLVcGzcgXM4mDM3Ja4Ff66WyGhZUe9ROMJFaGHNjd+jBk8PH212cfrPv+DzKgDJ0enKsNAz2s9DzSiz4QUeQO/Kg+QkESH4Eg8JtE9VZXBPS6lpt8iEOr0cVCz8FZENgY5IP9nfgjWQwt25Rd4gfLvavkcBoxI2i5hC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452463; c=relaxed/simple;
	bh=sVwR4ANZ8sCFvhuuZtFfFYVXx8pjT2bMpHswxQ+bGLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dde4U0zB6BbRBYx4IHLShJSgFrvRQ/Z6YiVjnIfzeUQnV8BR2FRjPkeWBvXV2VoEM6iWbZS7wDXpcdGpyXrjJUjTnwA4njbK2cVvLnaCcy3Wo1Fi7r8WRCcvNuhFZhsaJsnQVNjsCz/YcZ4TIe7F3aqmmK0XIyRkHL584KTw9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFeZLnGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A68C4CEDD;
	Sun, 24 Nov 2024 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452462;
	bh=sVwR4ANZ8sCFvhuuZtFfFYVXx8pjT2bMpHswxQ+bGLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EFeZLnGGXxlpIz4DBQVa+CRVOx1ZqoJCGjLv2HgTJG0HipJaJJ25fJ7guL9DX2XRL
	 KcxL3kZPMMyyuRX3l3CQrqk4XbCuUaTIT+iu2D1R+bt6BDFdhmZH1O7BIy6Eg8bGUp
	 ATLhpcsY63ILP+s8I3eRvH7Y1qORN1AIybiVk9UKZxeRyd/eARhGYA0L4OMgQuF6ym
	 1uEy8R04/5Y9R26n2bNgZh2xgWbqFJ0vs6uPlF/rmUQxNXYoHOYDnDDG3LAwkIbvNZ
	 AugcPpzF56OycZSQ8scypesikMLCE6T9QUZ//JfhbVp/LWBHEtWDyku1wu6C/jvBiD
	 F6a4SCHyRlzTQ==
Date: Sun, 24 Nov 2024 12:47:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamps after suspend if
 sensor is on
Message-ID: <20241124124734.3addf58f@jic23-huawei>
In-Reply-To: <20241113-inv_icm42600-fix-timestamps-after-suspend-v1-1-dfc77c394173@tdk.com>
References: <20241113-inv_icm42600-fix-timestamps-after-suspend-v1-1-dfc77c394173@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 21:25:45 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Currently suspending while sensors are one will result in timestamping
> continuing without gap at resume. It can work with monotonic clock but
> not with other clocks. Fix that by resetting timestamping.
> 
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

