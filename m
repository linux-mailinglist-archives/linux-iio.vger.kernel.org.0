Return-Path: <linux-iio+bounces-8691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8467795B7C2
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 15:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F661C23D48
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DE1CBEB5;
	Thu, 22 Aug 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBxMu/Qq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7F1C9449;
	Thu, 22 Aug 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334858; cv=none; b=uJnxiqDdIa1sLeh02Fd5qsFpXLBATUBn5uq7zrFN+vLgx81fp9Lw+WprpFQqkDszoF3PefjZDXovr4LSdumbL/MWHppRD/UpfFCOZi0GO9C75dwfO0PIAHs98TAsW48PVZWf0UXtJzX5ajPyM2DpY11SGEbmUhd3vm3dnK4fbew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334858; c=relaxed/simple;
	bh=6WD4597q5Hvbt9P6xZ0ON6oN0TTnndPGmI59xwiWKqc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JulUHf1smT3jBDRx3LqL6ZHQiKMscxbMrF6USi1FaM76dLM8gza1ofNHZ3ZOtlYzbwlUsI8F5kQPt/t4kFtcw2uiBv73PGiMgkd4FjmVSHNgW2ybNAPIRRTEqBambPBBLiDh9OqRcYiw2crVPRfM2dLTIaz6FP0bUG//a5Y4/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBxMu/Qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E107C32782;
	Thu, 22 Aug 2024 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724334858;
	bh=6WD4597q5Hvbt9P6xZ0ON6oN0TTnndPGmI59xwiWKqc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XBxMu/QqDQ4cGB8jQFs1IuSkBYSIxCFS3goNt5UkG1qfywV9HMJKJn3vGjSfSmUfl
	 IhHn6hRwgI8+BpGkioxnq2VTS5iuilqM/YBZ1PPJuluU9hrm2hQ8CNXkWAAEe8V3Dt
	 B3alQjdqHvQPf40OzSHlmvHpVTbG/TZx5l0z7Ah5NeX6oXVSOXm7a8zx7uuHDdSWBt
	 FDaM9kEKQ6NYtMzjaF8GJ2JXA/BCggqwpzq6Ah6zIRzd7DmT3BH4pl4GKAIHkiv3Oi
	 sNLndTaZdVtCWsXn2U8OdkO8HrkUV1HD2oPtMLEwcWu6Ft3him2oste9xccH+cwUBy
	 Siz3hYaYy5PVQ==
From: Lee Jones <lee@kernel.org>
To: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
 quentin.schulz@free-electrons.com, mripard@kernel.org, 
 tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com, 
 u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org, 
 jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org, 
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de, 
 jic23@kernel.org, jonathan.cameron@huawei.com, 
 Chris Morgan <macromorgan@hotmail.com>
In-Reply-To: <20240821215456.962564-12-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
 <20240821215456.962564-12-macroalpha82@gmail.com>
Subject: Re: (subset) [PATCH V4 11/15] mfd: axp20x: Add ADC, BAT, and USB
 cells for AXP717
Message-Id: <172433485381.1334876.7027428905035727559.b4-ty@kernel.org>
Date: Thu, 22 Aug 2024 14:54:13 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 21 Aug 2024 16:54:52 -0500, Chris Morgan wrote:
> Add support for the AXP717 PMIC to utilize the ADC (for reading
> voltage, current, and temperature information from the PMIC) as well
> as the USB charger and battery.
> 
> 

Applied, thanks!

[11/15] mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
        commit: e1043ad46060c181ffb8f981ccb25d9f698b2f09

--
Lee Jones [李琼斯]


