Return-Path: <linux-iio+bounces-13400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374F9EF5BC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 18:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6350A28B7FD
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D009211A34;
	Thu, 12 Dec 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAFBxTTU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DF1F2381;
	Thu, 12 Dec 2024 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023954; cv=none; b=rRTFzwWbf/2+7MWUhMh8zclgNtUj4hhALqDRTB9opJ9wWzR3b9V/2GxvtYEof1nfV7RD6TFDhNScjG72KurwfudflMh5H6AaZKReVSKHWZNBw/b08IieSn2PBQRBBp8kw4IVLHxNWlVeQoKMjHvzme6bCncmumJZRQomACZbyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023954; c=relaxed/simple;
	bh=dL4WW9+TXrzEbjOQekzg4UUu2Gjw4DpLiaVHi1/aOKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkcsGweP573Hh2guXb0TSAYjGNW8ENEuWTcyzNxIiFTPikrhtGDeiPlvU4/o2WFzdqNgH9JpgPT587V3HxYiPzr2CGw4QCOn38r705pWIfDxCi1qZW7NF9oweO6+O8gD5n48pcOQkwm+kmTzFE9naY1uJ0GIz/11RG1UHLCTaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAFBxTTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E566C4CECE;
	Thu, 12 Dec 2024 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734023954;
	bh=dL4WW9+TXrzEbjOQekzg4UUu2Gjw4DpLiaVHi1/aOKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAFBxTTUbMlBGLRFwOH6uh1gu5uAk8ul2LapCE7redfiakr9lU+DfqDw/seZ+XoNn
	 E6DGSLBYJh7dFu+6ZkF7BhQkdzPA7mUac827B1k8Urw/zdZWbLDD/DNxJ1woAe8y7G
	 wCFonH7xizERAAxBt5bphJl7R+fJA4hewWQH+0u//juj2h/GwnkuRMahMo2Cpk2pVD
	 jZ+mk4U5Vu7srWztySgGNYYFUNk+nyEli4QyUdJC3f6to2Kt8rlUNaYWr+doOc0m4b
	 maDp5ajaHerrociMJr8b03kExwIGeBn/yeWJ/KyfFulCE/uZhjAHXtgGnmkqaTq4Wq
	 5TzBc4ttsq5KQ==
Date: Thu, 12 Dec 2024 17:19:07 +0000
From: Lee Jones <lee@kernel.org>
To: jikos@kernel.org, jic23@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, pavel@ucw.cz, ukleinek@debian.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v9 0/9] Drivers to support the MCU on QNAP NAS devices
Message-ID: <20241212171907.GH7139@google.com>
References: <20241107114712.538976-1-heiko@sntech.de>
 <173402387748.2234929.7484373598047473898.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173402387748.2234929.7484373598047473898.b4-ty@kernel.org>

On Thu, 12 Dec 2024, Lee Jones wrote:

> On Thu, 07 Nov 2024 12:47:03 +0100, Heiko Stuebner wrote:
> > This implements a set of drivers for the MCU used on QNAP NAS devices.
> > 
> > Of course no documentation for the serial protocol is available, so
> > thankfully QNAP has a tool on their rescue-inird to talk to the MCU and
> > I found interceptty [0] to listen to what goes over the serial connection.
> > 
> > In general it looks like there are two different generations in general,
> > an "EC" device and now this "MCU" - referenced in the strings of the
> > userspace handlers for those devices.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/9] HID: hid-sensor-hub: don't use stale platform-data on remove
>       commit: e079a120f31e3f9c00180aa13c1df18cc138f7fe
> [2/9] mfd: core: make platform_data pointer const in struct mfd_cell
>       commit: 8f4009ad901c44f0428dbde654c4dd1fb29c863b
> [3/9] dt-bindings: mfd: add binding for qnap,ts433-mcu devices
>       commit: 8877bcff3e3b4f08a1fc0232dbfdaeda085cfdf3
> [4/9] mfd: add base driver for qnap-mcu devices
>       commit: 944ca826f69e4723853b3876875b03aeafe67b60
> [5/9] leds: add driver for LEDs from qnap-mcu devices
>       commit: fe6a21ee38f12e3e5f9adbd2f9a840be105b943f
> [6/9] Input: add driver for the input part of qnap-mcu devicesj
>       commit: 4b27e0da257371d3d141fae38fdbdc3c3a67bce6
> [7/9] hwmon: add driver for the hwmon parts of qnap-mcu devices
>       commit: 41755872a8a8ab8d1644459d9634c53b743fe2be

> [8/9] arm64: dts: rockchip: hook up the MCU on the QNAP TS433
>       (no commit info)
> [9/9] arm64: dts: rockchip: set hdd led labels on qnap-ts433
>       (no commit info)

As you can see, I have _not_ applied these two DTS patches.

-- 
Lee Jones [李琼斯]

