Return-Path: <linux-iio+bounces-13626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B89F7050
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 23:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A121894D2A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 22:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422921FC7F8;
	Wed, 18 Dec 2024 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UwdQuMcG"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824719D098;
	Wed, 18 Dec 2024 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562195; cv=none; b=que5LxytcZcWYk+5WbYQmxxibn03El/bvpAYyJA0uPFpYKjQInmLYUUEn5Zfg6OPCwR+MRKsjzqDqQMko+AZqwAhsQ/HCZ1ZdhEk0E6/UENrlAUCd3wEyu7cv1D7XCnhN8Xl43/id52z0Oo+CPNAi++Ty5Dm9GL5Lo1eOOF5FhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562195; c=relaxed/simple;
	bh=ZTkLKzQrDSXWYeC+XgwRqAbl/w62QmUqrsOcvrotmFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIgPM6mJdmGYaLJijyfKeWeU0PIylaTiKxYc0GFSpE1N8gKE+7yb5h+NUvLfRmaiBx/yKlY+tAk6R5Q60Gu/yPgDDykCPt/7KgCCm6TPCb7oWzcOlxAs+dnyQh1b+sdD1uFHpQ5X4WaBH+X5Rq4/2rJl8CbiNSolP1U5Gvd4EbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UwdQuMcG; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l6tgjtGuZAZYpQX7UB8px4+rlQbXawD8OcbC4h3qdLQ=; b=UwdQuMcGp6v4V6yuMHPbP3RnCj
	ZO0VOo3UBHLv4IiuJ9gdLsSqt+cwpzBMtrYaQKGUCtwMGypHW0GezgxeCjKInu3agQpIbAAg0+2re
	YSaQdwooHedwxUGw981Dl3yxMaZQbz3gm2IZxhyYNp3Ur3hhCaDf7juqUse653WvVAOAhXIEs+jA4
	Br5kiCOuJ+8rTBzCrfY92sR7xUFv1R9Y+ZvOp42vq45YcNyVGFBkKurihef3wQj5fRCvdcaWJrS5U
	qDKaL/FpoaiWWD3lbgGBcfIqKIERSI9T5+OwWOphf8IHgWbUoiRgxbThlwPrfk8Hrz1F7ArUtVLXw
	JB8yfd4g==;
Received: from i53875bfb.versanet.de ([83.135.91.251] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tO2r2-0005qY-Jd; Wed, 18 Dec 2024 23:49:20 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: jikos@kernel.org, jic23@kernel.org, Lee Jones <lee@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jdelvare@suse.com, linux@roeck-us.net, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, dmitry.torokhov@gmail.com, pavel@ucw.cz,
 ukleinek@debian.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org
Subject: Re: [PATCH v9 0/9] Drivers to support the MCU on QNAP NAS devices
Date: Wed, 18 Dec 2024 23:49:19 +0100
Message-ID: <15355121.tv2OnDr8pf@diego>
In-Reply-To: <20241212171954.GI7139@google.com>
References:
 <20241107114712.538976-1-heiko@sntech.de>
 <173402387748.2234929.7484373598047473898.b4-ty@kernel.org>
 <20241212171954.GI7139@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 12. Dezember 2024, 18:19:54 CET schrieb Lee Jones:
> On Thu, 12 Dec 2024, Lee Jones wrote:
> 
> > On Thu, 07 Nov 2024 12:47:03 +0100, Heiko Stuebner wrote:
> > > This implements a set of drivers for the MCU used on QNAP NAS devices.
> > > 
> > > Of course no documentation for the serial protocol is available, so
> > > thankfully QNAP has a tool on their rescue-inird to talk to the MCU and
> > > I found interceptty [0] to listen to what goes over the serial connection.
> > > 
> > > In general it looks like there are two different generations in general,
> > > an "EC" device and now this "MCU" - referenced in the strings of the
> > > userspace handlers for those devices.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/9] HID: hid-sensor-hub: don't use stale platform-data on remove
> >       commit: e079a120f31e3f9c00180aa13c1df18cc138f7fe
> > [2/9] mfd: core: make platform_data pointer const in struct mfd_cell
> >       commit: 8f4009ad901c44f0428dbde654c4dd1fb29c863b
> > [3/9] dt-bindings: mfd: add binding for qnap,ts433-mcu devices
> >       commit: 8877bcff3e3b4f08a1fc0232dbfdaeda085cfdf3
> > [4/9] mfd: add base driver for qnap-mcu devices
> >       commit: 944ca826f69e4723853b3876875b03aeafe67b60
> > [5/9] leds: add driver for LEDs from qnap-mcu devices
> >       commit: fe6a21ee38f12e3e5f9adbd2f9a840be105b943f
> > [6/9] Input: add driver for the input part of qnap-mcu devices
> >       commit: 4b27e0da257371d3d141fae38fdbdc3c3a67bce6
> > [7/9] hwmon: add driver for the hwmon parts of qnap-mcu devices
> >       commit: 41755872a8a8ab8d1644459d9634c53b743fe2be
> 
> Once build testing is complete, I'll send out a PR.

thanks a lot for picking up the driver patches.

Heiko



