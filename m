Return-Path: <linux-iio+bounces-9103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896796AABA
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 23:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F87D1F24BB5
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2F1D589E;
	Tue,  3 Sep 2024 21:58:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD51D223A;
	Tue,  3 Sep 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400681; cv=none; b=JhS6uWp0/HDU/cZBbbCfCHldZWKz+0Vnar58WMyKA+Ne6WjkooQuzlI1tR1JNRGD036cgTLUHai04KWGXBLh2vqPf3pIegzRU1qF78vjPRMCZiy9SXuJ1fdu0Lfq9UlHjGpaCuNDKLfWbbPGnWhyIdPoIuTOPvBpArZjfQaERKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400681; c=relaxed/simple;
	bh=bfkASTT+Az0WHoeeWuQspysfBtzPVt+pivV/Wg/6HLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B6cwA6V3rDlEj+EcxpNojgtiYdWyBrzyJxhugjN156A3NYW3LCrgz5YejIccuq1pLunyFgMs4TFBn112fENH8QkpiZO6eFuDTrNUa4kT1RqU8Y5toEneqLDadCgfnCA/HQTta8EYE+gHNkap45x7tZP8mAHmRB5/qgmnnfXq1AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD69C4CEC9;
	Tue,  3 Sep 2024 21:58:00 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 473811060534; Tue, 03 Sep 2024 23:57:58 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
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
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
Subject: Re: (subset) [PATCH V4 00/15] Add Battery and USB Supply for
 AXP717
Message-Id: <172540067828.972525.2485048078454932049.b4-ty@collabora.com>
Date: Tue, 03 Sep 2024 23:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 21 Aug 2024 16:54:41 -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for monitoring the USB charger and battery charger on the
> AXP717 PMIC. This required some driver refactoring of the axp20x USB
> and battery charger as the AXP717 is somewhat different but can still
> benefit from some common elements.
> 
> [...]

Applied, thanks!

[09/15] dt-bindings: power: supply: axp20x: Add AXP717 compatible
        commit: e44c5691822962dc6f50793029bef5e71f5b0a62
[10/15] dt-bindings: power: supply: axp20x: Add AXP717 compatible
        commit: e44c5691822962dc6f50793029bef5e71f5b0a62
[13/15] power: supply: axp20x_usb_power: Add support for AXP717
        commit: 75098176d17fab88c06120b453b4b0d1641e2a41
[14/15] power: supply: axp20x_battery: add support for AXP717
        commit: 6625767049c2e0960ba9835392a6ef9143170be6

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


