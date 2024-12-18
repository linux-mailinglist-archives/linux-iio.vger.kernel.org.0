Return-Path: <linux-iio+bounces-13624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DE69F6F3A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 22:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54283168461
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 21:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8B1FC7EF;
	Wed, 18 Dec 2024 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BoguQtj8"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020F14D283;
	Wed, 18 Dec 2024 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734556022; cv=none; b=OSxkV+oVwnEUo6JVVmBo7NUhzQlyehw3LWNHmU/7fxa6DQIokoo7ZelRuOqHv5anRZhqyEHOvBkU9oCam1IZElenx8fm2TGANKQqNxTBzcX7VpXwe6kCy4xC5sfpcqlbNAI7slaNcGWgFXecrx7lxaX7Q9V8sygqaqAAC3S4euo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734556022; c=relaxed/simple;
	bh=8M6pUSfgplBUQE7ZBf+ipMVV+x9QkXJD0zEyI5B/0qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlQz8MCBp6751XvIy1ga5mGSLPtfbMeChBornyTMeGVAwTcCqpC6QQ3aGhHjqpXwDZeQhF8DSL8r5xI/szvHCKToccEQCjLIBShmy+LnjEkXukK6vdCmUD2xVT+ZGqaGp/HpUKo5Em/vyiH55Fj6/U7KCC2+DFokFXtYS4xD1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BoguQtj8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q7FQw9uOElZgIZ5UDsdhuv1rYgmZlf0US1wMCQAwdrE=; b=BoguQtj8+rXLW6V6ooyLURyozJ
	TWtNmopJSj5X/ps+yMRRJ+HfXCbrW6x7W7fv+W+QJOe3dTTtfHPgR4g3GBYvrlAFnkkTn1xwiqFXt
	oBOYBIUamvHoqtRphdam47hJ6Uk1rFWHH5T3/u4P2orz33ggi8JDZBGxCa3ulryD4wTfSRYe2u7rc
	YpfhOF0yjDSP6Q/1fwoMEyt6kshqKFJZr8eJL29dPB4FO+LB9GQuoLwJZEHN0S/6loFpEN4y+zSgl
	yM4MjlhB8syG7kvS/xwIonQeJKxmWJhVn3y5BXQBv8janImfJ3HQtjWCj3ZKuTPvksRgRzKUcAOZX
	M3s4axDQ==;
Received: from i53875bfb.versanet.de ([83.135.91.251] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tO1FZ-000516-EB; Wed, 18 Dec 2024 22:06:33 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	jikos@kernel.org,
	jic23@kernel.org,
	Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	pavel@ucw.cz,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: (subset) [PATCH v9 0/9] Drivers to support the MCU on QNAP NAS devices
Date: Wed, 18 Dec 2024 22:06:23 +0100
Message-ID: <173455598053.629326.7463057625807840374.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107114712.538976-1-heiko@sntech.de>
References: <20241107114712.538976-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 07 Nov 2024 12:47:03 +0100, Heiko Stuebner wrote:
> This implements a set of drivers for the MCU used on QNAP NAS devices.
> 
> Of course no documentation for the serial protocol is available, so
> thankfully QNAP has a tool on their rescue-inird to talk to the MCU and
> I found interceptty [0] to listen to what goes over the serial connection.
> 
> In general it looks like there are two different generations in general,
> an "EC" device and now this "MCU" - referenced in the strings of the
> userspace handlers for those devices.
> 
> [...]

Applied, thanks!

[8/9] arm64: dts: rockchip: hook up the MCU on the QNAP TS433
      commit: 989e3dd871349e76919911ac628e97ff6cb1ad51
[9/9] arm64: dts: rockchip: set hdd led labels on qnap-ts433
      commit: 47f34eab58294d7bb2583f9519b4022e74d56437

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

