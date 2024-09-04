Return-Path: <linux-iio+bounces-9145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A33296C18E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 16:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F3AB2C6F2
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96791DCB06;
	Wed,  4 Sep 2024 14:57:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927001DC061;
	Wed,  4 Sep 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461820; cv=none; b=U9/VBc7rnxFxPYMrhA8sk3D5uCyCQfm4+cfPC+S+xbVs3cdNP/llyFOJJF9Qt0PocDwGvMfddMioC6D7Ie1stlnZiyC3m8CVk5a7hSnt8iyc49LWcW4MX6KlrJ0ARgqgpzF4j0w0ha81X+ZDvjQXz+BNR+eYahQp8uSOLbiiC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461820; c=relaxed/simple;
	bh=Rr1nqpusYjQ2Y3RkVEkM8vCK+kqo+gxtMCYsFdLMMeA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rjKJkVO3q4GQwkkTb/t9By0p7N+g3O74JP2omcumNxQ26yNKy9349/VO4mxeKtpdOS+7GUyUqXlynqW8BUrjxigkK43Q9nog3gBDfQuAwWvWfVBiy5A9djxXVoIY8rytE98vT7HY1PFOrQt3w3IQeKb3YsQfremO/nGa08ZJozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BDFC4CEC2;
	Wed,  4 Sep 2024 14:57:00 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 2C6645F882;
	Wed,  4 Sep 2024 22:56:57 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
 quentin.schulz@free-electrons.com, mripard@kernel.org, 
 tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com, 
 u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org, 
 jernej.skrabec@gmail.com, sre@kernel.org, conor+dt@kernel.org, 
 krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de, jic23@kernel.org, 
 jonathan.cameron@huawei.com, Chris Morgan <macromorgan@hotmail.com>
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
Subject: Re: (subset) [PATCH V4 00/15] Add Battery and USB Supply for
 AXP717
Message-Id: <172546181715.1883804.14864644851699017908.b4-ty@csie.org>
Date: Wed, 04 Sep 2024 22:56:57 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 21 Aug 2024 16:54:41 -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for monitoring the USB charger and battery charger on the
> AXP717 PMIC. This required some driver refactoring of the axp20x USB
> and battery charger as the AXP717 is somewhat different but can still
> benefit from some common elements.
> 
> [...]

Applied to sunxi/for-next in sunxi/linux.git, thanks!

[15/15] arm64: dts: allwinner: h700: Add charger for Anbernic RG35XX
        https://git.kernel.org/sunxi/linux/c/6b5502c1d43d

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


