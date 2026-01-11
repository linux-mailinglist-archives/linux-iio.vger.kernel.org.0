Return-Path: <linux-iio+bounces-27593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8801D0EC4A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7EAA300D17F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0361330642;
	Sun, 11 Jan 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghE9GQ3q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B123EAA0;
	Sun, 11 Jan 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768132892; cv=none; b=iWMCCAZILmAn6jVfS62+yMSqjVEaFKIXohmVJcUlJ+OE+Zps2xBCr/oPMPB/GeCyWcX7P+FodzLilh9RUsUDILPuW82BPc3zpgQ4+Edh7wOanKRGWrTYoyQ3PV3FKydGT3lHjhu1qh3OPpU4Cet9Vt2zI1VlQnFmIu9WkrrxOD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768132892; c=relaxed/simple;
	bh=YWqEFguaKqRDnyg1DDLOnXTKg5GhRssuP6fWzriEA9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=st9WTIqf9O7YuKfLYuEWQCCBuMxqaI5J3mq2KTZF7uKtTB2lBS/0/u30nLqBlzQyACl1OB9LvpsWmdPs3x/qfV/ARD1PYDa0F7DHH80hFifxqPkFvop0w7C4W0/Z61a5CiwGx07RmjC+HtAfflZNhaTwLa6gGLBfvmYoeh+v+FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghE9GQ3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9F2C4CEF7;
	Sun, 11 Jan 2026 12:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768132892;
	bh=YWqEFguaKqRDnyg1DDLOnXTKg5GhRssuP6fWzriEA9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ghE9GQ3qmqZsKtgrkeZWPMyMDZJxee/EKwz7k7XbfdDLMDIQ5TNaU6o6Ucc/H0Mk5
	 SQWJg5SV4iVdvECppkG0xZZMSZNbIJrsda5mnuwsBU1gSvAjuKf/Pv5ne5acSRWywu
	 7phe2OTy+LcAAOIqhR3zqIZ4XEjgX9C7iXdjaoUMqhZHgQKdkqTvn7pMjfDWsy0KJK
	 r+97O0P7cMCeNL3rnCXVRrqLo6Je56QWkE73nJ12/0lA9Bv7aqJuiRMAR+Np3UWQRk
	 WUlHU9WcxQBYZIexbRIFDpFeCBrekgEqKL8xyQP9pWz0jewUaNtknrEa0NP/1+En+F
	 hPdJ6XBrQjmug==
Date: Sun, 11 Jan 2026 12:01:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Markus Koeniger via B4 Relay
 <devnull+markus.koeniger.liebherr.com@kernel.org>
Cc: markus.koeniger@liebherr.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dimitri Fedrau <dima.fedrau@gmail.com>, Markus Koeniger
 <markus.koeniger87@gmail.com>, Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH v2] iio: accel: iis328dq: fix gain values
Message-ID: <20260111120122.45e3de92@jic23-huawei>
In-Reply-To: <20260107-iio-accel-iis328dq-fix-gains-v2-1-10737cf8336a@liebherr.com>
References: <20260107-iio-accel-iis328dq-fix-gains-v2-1-10737cf8336a@liebherr.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 Jan 2026 16:32:18 +0100
Markus Koeniger via B4 Relay <devnull+markus.koeniger.liebherr.com@kernel.org> wrote:

> From: Markus Koeniger <markus.koeniger@liebherr.com>
> 
> The sensors IIS328DQ and H3LIS331DL share one configuration but
> H3LIS331DL has different gain parameters, configs therefore
> need to be split up.
> The gain parameters for the IIS328DQ are 0.98, 1.95 and 3.91,
> depending on the selected measurement range.
> 
> See sensor manuals, chapter 2.1 "mechanical characteristics",
> parameter "Sensitivity".
> 
> Datasheet: https://www.st.com/resource/en/datasheet/iis328dq.pdf
> Datasheet: https://www.st.com/resource/en/datasheet/h3lis331dl.pdf
> Fixes: 46e33707fe95 ("iio: accel: add support for IIS328DQ variant")
> Reviewed-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> Signed-off-by: Markus Koeniger <markus.koeniger@liebherr.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

thanks,

Jonathan

