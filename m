Return-Path: <linux-iio+bounces-12541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806269D69C5
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C60816176B
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581E29D05;
	Sat, 23 Nov 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFlW3WtA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739733A8CB;
	Sat, 23 Nov 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377168; cv=none; b=P7wqp26V//NxArS87+FOOVzH4e1peR607rGjT/H8yvB6VsYhwRmMNeIvKtFAt2pV0y2erkJz5jc1zBpb+fElQs8rypC/df2iZ0pdDSHs/h440uyu16K1qhZwiTAqF2XiXnGu71El+Gg5Q2C2CH7NQhLITeeQfW80Pjy9BP23m7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377168; c=relaxed/simple;
	bh=lP8qFzo5rBzTyTmoJFHLnCxhyHx3vDIwNWQwWTnDGy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+EJdbzlfIwq0HY+MHwsSaQnvUvRaruRN7NV+xzWDtjb6XwcM96BJ8vfeXBjt6DqggfwK27yx6tX15LKISeAmwy6w2b6iejBjE6u0zD9+0uhm3tY09pQL4IA8Xush9MZzeC8noeUmLxSqkwmyCUi6Qnl3NRnq6k66Wx46hE00MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFlW3WtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD79FC4CECD;
	Sat, 23 Nov 2024 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377168;
	bh=lP8qFzo5rBzTyTmoJFHLnCxhyHx3vDIwNWQwWTnDGy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uFlW3WtAw6CKnHui8xCE4AA35y21bBiSHdnvEBpCpBO6I8t1BOAJjWfPSwkBAQXDb
	 EgcsnBd79wYNBrXO7LXPZK/VDgtsmLYMZtT0F5NCaxC2nWWsyVzOGgNFiCtDzltOIp
	 Aq3brz7xiq68ompnDjRvU1qbO6GuMccM1lkkfcNQkqm8Yilqgqo9hh1PCsnlCWWJYJ
	 /dx4Xz+VUuGh95XaMXrrCuLEYsjy64ZFHZHIYWqpUv/sB2kauHq1C3STMD2VkUzbIr
	 sHX9FmC61y3pYEIN6DORu/qLV4wQTkVba6DMxio1p21s7NH1a7cYGaMSTXZRmOVGhj
	 pTlaMhL5a8FsA==
Date: Sat, 23 Nov 2024 15:52:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] iio: dac ad8801: drop driver remove function
Message-ID: <20241123155239.05cdd930@jic23-huawei>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-7-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
	<20241120-iio-regulator-cleanup-round-6-v1-7-d5a5360f7ec3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 15:33:30 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Remove driver remove callback in the ad8801 driver.
> 
> By making use of devm_iio_device_register(), we no longer need a driver
> remove callback. Also since this was the last user of spi_get_drvdata(),
> we can drop the call to spi_set_drvdata().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

