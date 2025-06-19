Return-Path: <linux-iio+bounces-20782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1147AE0377
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 13:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D05E3A9420
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9829F227B94;
	Thu, 19 Jun 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGWRVZe1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269D22539D;
	Thu, 19 Jun 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332409; cv=none; b=dve5xSHyuhjZQVnEl3VAG1CELIk046a6tJYEs5NpAHnKY+GzmX2VgWLu7LJ0e9WatlgClQVGuUN/RMHhUPmaV6cyJjgtTZYIcdzorkGCxCb6JlY8TpwxL6H/870553dHhxptSkrjIxSFIKTODHR/8+xRu3bme0XnY2oR9DHV2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332409; c=relaxed/simple;
	bh=YiyRb7pucNT3+6sXw2ZPl1qiFdH+sijuowL1VDYl3BM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r+6BREcLPRVpElaGD9lG39fe+56jYZL0K1bnXyTKUJ3sbUdUlj4ZDkFK8GD7DtwJDRzPAY421/xD2h6LnpWTE/oPCpjb8PGGLAP4vWgSEItXUS/KA75fO3ZWVWAPxv7txJ91hCJnoIUlFKt6er6b6NC2q/xdKqTANi3eoVQTYx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGWRVZe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D299C4CEEA;
	Thu, 19 Jun 2025 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750332408;
	bh=YiyRb7pucNT3+6sXw2ZPl1qiFdH+sijuowL1VDYl3BM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rGWRVZe1Jq0LFnj/uHkCyf65/ZmMVek9uGDJO2sdON4Q5sqap09KnZe1E5WMa8trC
	 k82LUXqM6AW0D7jyid1Pj1mhBwxPayfKs0KUwZA1kgwG+A6sm+Izqwx93NCVxbLk/j
	 2CNCZSS7sosAEuiJITueiPzgUzDd6q8vjVK8WOS4znY9tDxUxORGhI/ETCA7WZHsDX
	 7J1Nqn2QjHJ6hoKktlYSdsI37cqteX2vBZAVGW6+E5QPIwdbisB9bM7Wy3Gij7noOI
	 3LKvlSiARObPkAy/oqu8x+jYUpjA73q/oNJ3AhuuSq6ahvATRjfTSGggqFiEbfuXjD
	 Tu5aei6AOKlIw==
From: Lee Jones <lee@kernel.org>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-iio@vger.kernel.org, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Antonio Borneo <antonio.borneo@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
In-Reply-To: <20250610124855.269158-6-antonio.borneo@foss.st.com>
References: <20250610124855.269158-6-antonio.borneo@foss.st.com>
Subject: Re: (subset) [PATCH 5/5] mfd: stm32-timers: Fix build warnings
 about export.h
Message-Id: <175033240599.700502.13443689743832586360.b4-ty@kernel.org>
Date: Thu, 19 Jun 2025 12:26:45 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 10 Jun 2025 14:48:55 +0200, Antonio Borneo wrote:
> After commit a934a57a42f6 ("scripts/misc-check: check missing #include
> <linux/export.h> when W=1") and commit 7d95680d64ac ("scripts/misc-check:
> check unnecessary #include <linux/export.h> when W=1") we get the build
> warning with W=1:
> 
> drivers/mfd/stm32-timers.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> 
> [...]

Applied, thanks!

[5/5] mfd: stm32-timers: Fix build warnings about export.h
      commit: cf5d2f2deaee5dbfcac2db8758c3e6e0864a0c86

--
Lee Jones [李琼斯]


