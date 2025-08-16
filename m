Return-Path: <linux-iio+bounces-22841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075C9B28EB1
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 17:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02277B1F7E
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855552F39BC;
	Sat, 16 Aug 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMwJH/nw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459542F0672
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356410; cv=none; b=uayrOJdHw6zuEMYiYTMVhcCsupY9zQw2mEmQp18evnfooMwcTUElmjUV07RRsjj3K3ZYaFh+x9FJndutqx0F3nWUloeLzm80j6TP7QOmBU0YLyR5Q+VbRLfHEgULhfOEUf4Wy0VnMjlyjHv2BvHBB/mEaFRlDslJPRsk0JNRuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356410; c=relaxed/simple;
	bh=5tTwbyHD/SRoXxR6ibRwPty2zjWaJiSW+AIPKyG9+NU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQ4ProqkH2xXD0wmA2vz8bp0ZOUSgRPAEYVEWZcrm4hI+82g6qG/BL3VKP3upAUnvlluDMtDKNV5+bUq6qbld17uNJOyBc9pjiU4AcUt3QI1HNii/00i3Rk0aik0f7XmsaeINo5Ncn3x8H+Wd/wW304swV/NTjPSTdO3dOr83Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMwJH/nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C57C4CEF5;
	Sat, 16 Aug 2025 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755356409;
	bh=5tTwbyHD/SRoXxR6ibRwPty2zjWaJiSW+AIPKyG9+NU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aMwJH/nw+7LF8U4zybDubScTQHR/qFh7wo5IUDblkFwB0uMxPbV4Pm1nLLjNAZUEI
	 luR0fSMwAn3k0qYpXxqjceevLbz5w1+Y9bpk6k5/GyLQi/NHAUT5MWaUKq7Vf+EhdM
	 mXJ2HQlDjeEXi9/YfvqKpjCFGIBA+x7T4xkCRLFKHVzlUc1mEKOl4Klu6TUeuD622n
	 Ipn288Z6ScRSMoHAruI2FNLB4nD9UsBKRKOpjGF+FtB7yvYrYcBHdHfFB65DLrBiYi
	 38F/Fp3nEKqhZWNebl/1LJRk4qpar224yZI1V0/Ik4L+tGkiXY+RhQHznQzP2hgrZf
	 bG1Q9CyZ08H/Q==
Date: Sat, 16 Aug 2025 15:59:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 15/16] iio: light: vl6180: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
Message-ID: <20250816155959.14f47015@jic23-huawei>
In-Reply-To: <20250802164436.515988-16-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-16-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Aug 2025 17:44:35 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Also move the structure used as the source to the stack as it is only 16
> bytes and not the target of an DMA or similar.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Abhash Jha <abhashkumarjha123@gmail.com>
Applied. Description tweaked as per earlier feedback.

