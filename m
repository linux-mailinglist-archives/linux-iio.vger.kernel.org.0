Return-Path: <linux-iio+bounces-13399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8155D9EF64E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 18:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E90C1940273
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C04222D46;
	Thu, 12 Dec 2024 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwKkrDWj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEE21F2381;
	Thu, 12 Dec 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023882; cv=none; b=mQjLHsCnDbu24sk2c1AJ6EymvaGX/W4GhGaze/Qd8bO6QXZ14P4Cp04kahZDOOgNNO9rFgXGXjlJeFQ2io4yY/V89tSzeqV+32NgJ6e/HBF7Q+GwLFNdS3WFmVqgfsjDpgSoxnOarJI7CxyXCN8oJqTglB1QojyyGgVD29Iirhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023882; c=relaxed/simple;
	bh=gUkmLslWwau7PQ/rqBKBXnsLHUj3XhDqGxojh6HslHA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pZHu6ObiLAXVsA97CtzNSC/6VBS98yCfc+GEVED+fHKNPygpakRXamvTI7mUkZmptZHt5ztVwevDAF/u5wJHu41zqYJ4DsXqGbPRuhONR9gROGjrY/lM9w25/0Jq4r5lDiK+nqKH5ZzC7/XZV45l1L/VbverKVtV2iUynlA0mxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwKkrDWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59C5C4CED3;
	Thu, 12 Dec 2024 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734023881;
	bh=gUkmLslWwau7PQ/rqBKBXnsLHUj3XhDqGxojh6HslHA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cwKkrDWjiW8TR9jqZjKrU5uWhsvufo/SKwmpc6Rrg5GZe5ncsc0bu0jgz9DXMVafs
	 8R6byDSjz6nc2ZkWvgF5RbtYq71wKsVEdqrV6fwEA6XyvtQIdZKd4xkI+0SIzcCFap
	 ML8vQ0pyQ0njSAHDp0uPzqdPz71t2MOZDRe/1enAn+qslPZy3NqdtQoF5MD0jD+xqw
	 29v5HrtCmxHLLU5wAX/vzzKNtSLBKqwG6zJvUnfq+UeiVScxVgufqWl55r7UM6J8CF
	 xTOLKFCL1wLJZ+pr0NBzm3mztQKnxZg/w1/U8W2DTEW5wm2t8fkr66dfhpSTfhjRjL
	 xwR/tXpUcsMIQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, jikos@kernel.org, jic23@kernel.org, 
 Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 jdelvare@suse.com, linux@roeck-us.net, srinivas.pandruvada@linux.intel.com, 
 bentiss@kernel.org, dmitry.torokhov@gmail.com, pavel@ucw.cz, 
 ukleinek@debian.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-leds@vger.kernel.org
In-Reply-To: <20241107114712.538976-1-heiko@sntech.de>
References: <20241107114712.538976-1-heiko@sntech.de>
Subject: Re: [PATCH v9 0/9] Drivers to support the MCU on QNAP NAS devices
Message-Id: <173402387748.2234929.7484373598047473898.b4-ty@kernel.org>
Date: Thu, 12 Dec 2024 17:17:57 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

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

[1/9] HID: hid-sensor-hub: don't use stale platform-data on remove
      commit: e079a120f31e3f9c00180aa13c1df18cc138f7fe
[2/9] mfd: core: make platform_data pointer const in struct mfd_cell
      commit: 8f4009ad901c44f0428dbde654c4dd1fb29c863b
[3/9] dt-bindings: mfd: add binding for qnap,ts433-mcu devices
      commit: 8877bcff3e3b4f08a1fc0232dbfdaeda085cfdf3
[4/9] mfd: add base driver for qnap-mcu devices
      commit: 944ca826f69e4723853b3876875b03aeafe67b60
[5/9] leds: add driver for LEDs from qnap-mcu devices
      commit: fe6a21ee38f12e3e5f9adbd2f9a840be105b943f
[6/9] Input: add driver for the input part of qnap-mcu devices
      commit: 4b27e0da257371d3d141fae38fdbdc3c3a67bce6
[7/9] hwmon: add driver for the hwmon parts of qnap-mcu devices
      commit: 41755872a8a8ab8d1644459d9634c53b743fe2be
[8/9] arm64: dts: rockchip: hook up the MCU on the QNAP TS433
      (no commit info)
[9/9] arm64: dts: rockchip: set hdd led labels on qnap-ts433
      (no commit info)

--
Lee Jones [李琼斯]


