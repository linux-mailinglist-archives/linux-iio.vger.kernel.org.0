Return-Path: <linux-iio+bounces-25473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE90BC0E600
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC55422DA6
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809FC3081A5;
	Mon, 27 Oct 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHp4XZQm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4F307ACA;
	Mon, 27 Oct 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574247; cv=none; b=GHwar5AmMlnn3VmtdU+ig9HqGl1tk/hZguLUCnR4Xg/d30PjDFwRBT9+IiioMhJBOQUokaLpA7nsP4jI/3XuahMa3tiXMBBg/fyPuev556SJJgL+QUBMriiQI9EwqECe4S1/w3qep9VMt11ehwICcwKfADp+skEfUgw79woGCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574247; c=relaxed/simple;
	bh=H0DN0/KuZGCZno6hLZ2l5ytFCobzGeaGFJikn/jhnxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HP73GIdrrV/AHPwnryr2b8z676GFiwsNbaF3o2gpHnDbN4+Vz8fJdZzlx2JEuJY3GnsjyaKFViPZCwitXqb/PLuON2TCSp8leNKgZ0m53ckp4/FFv8VsKS5sgSez7bEcpaS4sSQm2Nvq0RE2mmiIHU6ClTvmTEBiWudOgfogmxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHp4XZQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC17BC4CEF1;
	Mon, 27 Oct 2025 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574247;
	bh=H0DN0/KuZGCZno6hLZ2l5ytFCobzGeaGFJikn/jhnxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dHp4XZQmUC5hkYEo2m5n7kmn73UcCgkLKD/FZ4VUKnC6PWawxhl+aILUbWpGP2zuz
	 /k6kRZYSs8ZDdts8GeqI92X65hPSVok5wi3Zy2YiZwFA6oeUbCkrAqHsEoRszB1lLy
	 w4BW08ZFuA0ZUzgOHDpf//2+8c03h6LxO/XVCKguYSllo90FCxBInwF/f1ofS23EQp
	 4mRm0ljUMq0RR4xcc6rmNvxPZKiyh0xlyU9foRDrPrsz+38uwRvEGhFxnQT+pwdjI8
	 ubLT3ePHHQDciHKbvfOa4En+mlH4suY8yotPJlUYYHvOH+0bsLM0V9y5gBJInbFm6H
	 50fi+l02p1G/w==
Date: Mon, 27 Oct 2025 14:10:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] iio: accel: bma220: move set_wdt() out of bma220_core
Message-ID: <20251027141041.7741a592@jic23-huawei>
In-Reply-To: <20251021-bma220_set_wdt_move-v1-1-6c99f6fd951c@subdimension.ro>
References: <20251021-bma220_set_wdt_move-v1-1-6c99f6fd951c@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 13:31:49 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Move bma220_set_wdt() into bma220_i2c.c instead of using a conditional
> based on i2c_verify_client() in bma220_core.c that would make core
> always depend on the i2c module.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510102117.Jqxrw1vF-lkp@intel.com/
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied to the togreg branch of iio.git.

Thanks,
J

