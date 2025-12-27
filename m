Return-Path: <linux-iio+bounces-27387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8575CCE00D1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54912301B2DE
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F5D283FF9;
	Sat, 27 Dec 2025 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2/4YAod"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B61DC997;
	Sat, 27 Dec 2025 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858693; cv=none; b=oJiJXcl+4zU7g0jcZjuuTbX9TpEsPfbDIOzWjKu242QzzJmd7ya/Eu6xhFWeQZVa1sddCimjCqp958YwnJi3X6YMB578J1+NsTSus3meKWMhceAWuMrKgFGCk5n4vci/QltjIjp0t+3dBuxvN21s4xXTfz1Ibak6kyjUmnsLmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858693; c=relaxed/simple;
	bh=eQ1P7Z+xXxh80QqNAbwrRIN1gNnSRziB6EGVZtUoJ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWnRX+XOAJ/K5ZUaXaeyMTyRkqZ2OPV4ZdpyViuWT2P+ZgR++hlnzaR5ZLNW6CK+e3IX5576Qm/+TuO4GZLL5qnCl0+/kuFYYWgfQBRj3KrrXfYZ1iC78DGPwo6SjoTD5Lrd1nPXBQgj3X47Lfr7C8BNn8/AwhThbXxy1/VIqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2/4YAod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35665C4CEF1;
	Sat, 27 Dec 2025 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766858692;
	bh=eQ1P7Z+xXxh80QqNAbwrRIN1gNnSRziB6EGVZtUoJ5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2/4YAodgp4/GUUUZhWpOr3YFyvFt3WxXXEfnsHgbj63VLPzhPGvAv34fgb1WmpGV
	 Bo64CIHaZcVCWxO0rUz3GNi7XZpkmpCfHGcS1PaSQimpq+otp9ZBJPLDcHBuf+Jg5v
	 qAAsz6TlHJsmPo3BVpqMH8cenOjqpwpOxp3n1DWUr5sJTJKf+Ypy6jhVVzB0m6O8bB
	 lgEOnxjZwx1IsiTXaaYge2JTzVw4gLLlU4ju7cSeA6fK6Q2ki5I6jMPkuSAb9pJQLf
	 qAZY4o4bGxZ87Dl2nB6eHxJ0NzcuIZ/UxaAiNTqHlx3Q7di72MYmskqpECUIZFwiON
	 lGBiGPQaW9WNw==
Date: Sat, 27 Dec 2025 18:04:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: imu: lsm6dsx: Support SMOCF05 ACPI ID
Message-ID: <20251227180446.45836e37@jic23-huawei>
In-Reply-To: <20251223025351.3099978-2-samuel@dionne-riel.com>
References: <20251223025351.3099978-2-samuel@dionne-riel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 21:53:49 -0500
Samuel Dionne-Riel <samuel@dionne-riel.com> wrote:

> This patch set adds the alternative identifiers for the LSM6DS3TR-C,
> just like the windows driver allows.
> 
> I have done due diligence, and verified the assertion that the SMOCF05
> is also the LSM6DS3TR-C. This was verified by looking closely at the
> Windows driver, which also uses the LSM6DS3TR-C device identifier with
> that ACPI hardware identifier.
> 
> From looking real close at the Windows driver, I am intuiting that this
> different identifier is used to change how the driver behaves, but does
> not materially change how the I2C device can work. Though I'm not 100%
> sure of this assertion, I believe it does not matter at all for the
> Linux driver.
> 
> This SMOCF05 configuration was tested on the Minisforum V3 SE.

One passing comment inline.

> 
> For completion's sake, the device's DSDT data follows.
> 
>     Scope (_SB.I2CD)
>     {
>         Device (STS)
>         {
>             Name (_HID, EisaId ("SMOCF05"))  // _HID: Hardware ID
>             Name (_CID, EisaId ("SMOCF05"))  // _CID: Compatible ID
>             Name (_UID, Zero)  // _UID: Unique ID
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 Return (0x0F)
>             }
>     
>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>             {
>                 Name (RBUF, ResourceTemplate ()
>                 {
>                     I2cSerialBusV2 (0x006A, ControllerInitiated, 0x00061A80,
>                         AddressingMode7Bit, "\\_SB.I2CD",
>                         0x00, ResourceConsumer, , Exclusive,
>                         RawDataBuffer (0x04)  // Vendor Data
>                         {
>                             0x53, 0x4C, 0x41, 0x30
>                         })
>                     I2cSerialBusV2 (0x006A, ControllerInitiated, 0x00061A80,
>                         AddressingMode7Bit, "\\_SB.I2CD",
>                         0x00, ResourceConsumer, , Exclusive,
>                         RawDataBuffer (0x04)  // Vendor Data
>                         {
>                             0x53, 0x4C, 0x47, 0x30
>                         })
>                     GpioInt (Edge, ActiveHigh, Exclusive, PullNone, 0x0000,
>                         "\\_SB.GPIO", 0x00, ResourceConsumer, ,
>                         RawDataBuffer (0x04)  // Vendor Data
>                         {
>                             0x53, 0x4C, 0x41, 0x30
>                         })
>                         {   // Pin list
>                             0x0009
>                         }
>                 })
>                 Return (RBUF) /* \_SB_.I2CD.STS_._CRS.RBUF */
>             }
>     
>             Method (SLA0, 0, NotSerialized)
>             {
>                 Name (RBUF, Package (0x03)
>                 {
>                     "-1 0 0",
>                     "0 -1 0",
>                     "0 0 -1"

That's not a rotation matrix... It's a rotoinversion which is
curious. That suggests one of these two sensor elements uses
right handed axis and the other left handed.

We just pass this stuff on to userspace though and don't enforce
that they are actually rotation matrices except by documentation.

>                 })
>                 Return (RBUF) /* \_SB_.I2CD.STS_.SLA0.RBUF */
>             }
>     
>             Method (SLG0, 0, NotSerialized)
>             {
>                 Name (RBUF, Package (0x03)
>                 {
>                     "1 0 0",
>                     "0 1 0",
>                     "0 0 1"
>                 })
>                 Return (RBUF) /* \_SB_.I2CD.STS_.SLG0.RBUF */
>             }
>         }
>     }
> 
> Samuel Dionne-Riel (2):
>   iio: imu: lsm6dsx: Support SMOCF05 ACPI ID for LSM6DS3TR-C
>   iio: imu: lsm6dsx: Add alternative ACPI mount matrix retrieval
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 ++++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 1 +
>  2 files changed, 7 insertions(+)
> 


