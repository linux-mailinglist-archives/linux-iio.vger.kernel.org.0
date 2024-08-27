Return-Path: <linux-iio+bounces-8830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56739613F5
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 18:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08174B221C8
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430A1CDFCE;
	Tue, 27 Aug 2024 16:25:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D261C7B6F;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775933; cv=none; b=MuOSUTRD4Ppq7aTYaZQ8O87sT+qDD/QGYf1XV/ooF6qZ0hwLOsqceZ8Ufb/X1pYXDYyfdgCyTZPMy6V36PODBIdBMv6UlcGi6UqwL0R49ENt5RNL78rtj/iH4tyhDLotBy4lUyc7UQQGPUqiVnn70wXS8Cv+7g6nip6w8zsbrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775933; c=relaxed/simple;
	bh=KAp4JjBV/i2vUfDdcuS9arjrIYL8u1wNNy7Y+gvZPwE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DyMYzBdviGQyM+5lXhfQGzlE7ZDbMp0D4eeLRVclg40XFD2w+33P0NCOCuH+ia4eMnQkGH6kNs8t9K83n+xSQ1heTg4bb+F/mb+IDKiYHeNmtOwBTR9DrasB8Kw1je1ZTQwnucYKn497WgkEfKgkgABJSdUCfhMEfwqhWS1uL2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87644C8B7B3;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4BE03106053B; Tue, 27 Aug 2024 18:25:31 +0200 (CEST)
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
Message-Id: <172477593130.353499.14090062100249712137.b4-ty@collabora.com>
Date: Tue, 27 Aug 2024 18:25:31 +0200
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

[02/15] power: supply: axp20x_battery: Remove design from min and max voltage
        commit: 61978807b00f8a1817b0e5580981af1cd2f428a5
[03/15] power: supply: axp20x_battery: Make iio and battery config per device
        commit: db97fecb55cee4eed2f8dcdc17c4831719cbfe4d
[04/15] power: supply: axp20x_usb_power: Make VBUS and IIO config per device
        commit: ae640fc690353f6181740b50a0d6761bc67ebaa9
[05/15] dt-bindings: power: supply: axp20x: Add input-current-limit-microamp
        commit: 6f5cdb7ec8836bb5e5ab221c2f49e2b170d5a978
[06/15] power: supply: axp20x_usb_power: add input-current-limit-microamp
        commit: 6934da720aac7b0feb99d08ff27fd245a962d8d2
[07/15] dt-bindings: power: supply: axp20x-battery: Add monitored-battery
        commit: dc123a1a80933b7fba1cf53cec77c2425268ff85

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


