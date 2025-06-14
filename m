Return-Path: <linux-iio+bounces-20639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1B9AD9C9F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3FD1899BE9
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40911C5489;
	Sat, 14 Jun 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NceRONTO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3DB2E11A9;
	Sat, 14 Jun 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749902500; cv=none; b=hHAuHVsP8v1y3ycIpHxiHLsROWrGjpUvFwq6eD3IbrtKAskIlKW9bM2bROPK2Yzrc4tRSSrsaiHXxNzF31y1WYJ4FoLWbJ/fpeH56rb92Z1PdfxJrkoFEXNlUkJuHAswYGTeH0xPqqTJBL+b0/9TugWmCNUmEctww93GdWpcmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749902500; c=relaxed/simple;
	bh=V/YX15KceR9j1D+Znn/NpYtvkwVdytOe3oVxnRZEXxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCBzRsJk/zeu4Yql9EDRLfToHSiO7n0lxteKIirQql0JewNIA4rs1Wpfqjt2YnrOse06oDzcEC6jY5Xt1fKDp618hYW1hvUQTltb8dngoAbuElpGTa1DPAq8I64gpGEaDyOow7mw+iNQ0Kw7xebIOym/Al8gSkEhUJeQyn/hrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NceRONTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1617C4CEEB;
	Sat, 14 Jun 2025 12:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749902500;
	bh=V/YX15KceR9j1D+Znn/NpYtvkwVdytOe3oVxnRZEXxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NceRONTOoq6pDnYpgyPlKcm5kW3/lZvmgVSPbkx/Wd2DqYMrg47X15/AGcwJtuCl/
	 ldv+dYAFR/ZgmMrNUm1+5Kn/mt0VAdzONqoYm2Zn2wqhJCH7A1cYQzNMMW4+QT/PzU
	 Kaf9/vDn0S3N8rR9IvLH9LY3QeqdbhMzTtH+QpBBqJ1GVExbl5JvGW7KYirfOb8K9h
	 VvNIp6eeF/UaO1ZuRXAXOdZkQ0uh1QkatYZcnLgjH2skcQ7KvUvlRGeC7qDGyGfxk+
	 pRoWvGRdkks2IPW7egTPnXuo8Rw1sdR0WgQjCobCvxHqeu5qgYBms34az7JTjXstO4
	 4GAQHlVZraLPw==
Date: Sat, 14 Jun 2025 13:01:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for
 handling mutex lock
Message-ID: <20250614130132.220f5f16@jic23-huawei>
In-Reply-To: <20250611194648.18133-4-andrew.lopes@alumni.usp.br>
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
	<20250611194648.18133-4-andrew.lopes@alumni.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 16:39:21 -0300
Andrew Ijano <andrew.ijano@gmail.com> wrote:

> Use guard(mutex)(&st->lock) for handling mutex lock instead of
> manually locking and unlocking the mutex. This prevents forgotten
> locks due to early exits and remove the need of gotos.
> 
> Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> ---
> For this one, there are two cases where the previous implementation
> was a smalllocking portion of the code and now it's locking the whole
> function. I don't know if this is a desired behavior.

I'd call out more specifically that you are going from

lock
stuff
unlock
call which contains lock over whole useful scope

to
lock
stuff
call with lock no longer done inside
unlock

In at least one case.  Looks cleaner to me. I'd guess this is a silly
bit of code evolution that you are tidying up as that lock dance looks
pointless to me.

Otherwise just the {} for cases thing needs fixing up.

Jonathan

