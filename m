Return-Path: <linux-iio+bounces-21117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00029AECED8
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C023B49FF
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5891B4139;
	Sun, 29 Jun 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIW/YDhY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390517DA93;
	Sun, 29 Jun 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751216424; cv=none; b=OnNIU2FzxF0opshcM6B9E8Pnnk88l3hXns7jTy2mySEgSSiGkCZquaWm96ox29FrwUPdpd6ioG4O6OWfkT59XfAKcug5vw2dbKQLodGojuI/9L8H7CF1zal1B5J+U+itfaBMArDDuSAOpDoKcF52kE+QlLfigfZ7kP4z9FTLiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751216424; c=relaxed/simple;
	bh=MU4Z9EP7bSO53KKFn9ULIwyc9M5DssKRkSghJ8ajuTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzDLapPP5C0SDqWobQo7+7DHRhmkHMHQhW9lvxAGAr7nS0WOXsTd+/8pmp3qOEZbB/2a+YrQLipKsZ3DI0krDb24ZS/cdMUlmeQOW4Qh9UShAKg/3qdyEXj5zLY1RxbcnYAFswtr+grJPVpFnyLOqm8nzH7Q9VxOdlJBOyN95OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIW/YDhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5139C4CEEB;
	Sun, 29 Jun 2025 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751216423;
	bh=MU4Z9EP7bSO53KKFn9ULIwyc9M5DssKRkSghJ8ajuTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SIW/YDhYp+dpeJI6fDZLC+l+fg8EN6BOop61PFeSyT5y0PuKlkin3yrLEBJDKzdAn
	 EynVJnYZcE4utivRrmcctCTB7OC8OmDabS7bCz68Xb/momLydHr9Rk/3ggDWJo/XlC
	 Nad3mtxazC8VZbnfZOtjRwOpZLIevC0fmXOUJIpdQH58I3biCFmIqtokWOi9kX08hb
	 juuXkmm3Pp1NT0mFNOH8EZ2dAQCybmxo+7DoZfzUDjEz+UGru841b5FLvo3FmwznEX
	 +XRfJy+3bUC1tiy0zZxiN12+Bzh6UQNpIf5VxcAY05nzmVCzgY103NBHldoxzdk7VZ
	 7ZWQC9FxPr2pg==
Date: Sun, 29 Jun 2025 18:00:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-adc: make stm32_adc_trig_info const
Message-ID: <20250629180015.4aa4375e@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-10-v1-1-0ba93ac792c8@baylibre.com>
References: <20250628-iio-const-data-10-v1-1-0ba93ac792c8@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 11:39:33 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct stm32_adc_trig_info. This is read-only
> data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Seems to be in the 'obviously correct' category so I've applied it to the testing
branch of iio.git.  Thanks

Jonathan

