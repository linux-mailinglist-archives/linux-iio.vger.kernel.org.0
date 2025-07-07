Return-Path: <linux-iio+bounces-21432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69223AFB649
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DE3189EED9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA72E11B0;
	Mon,  7 Jul 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="B5fqpXWb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0682E11D6
	for <linux-iio@vger.kernel.org>; Mon,  7 Jul 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899378; cv=none; b=d+QWhiR9B4oFFSptL0JDisUB4sBUTDmH9Fw5CHv6Hkc0t+e6X7ZfcbU/TonG8XzdOWkhXMgODd8Q10cYuHd5GP5ZbhQh+FvfymIVwTHnoBmt3rWlj2Il+bdj7knmxJmljbPzrxPpD99VcJA0Y0w1Xt23aJocazKP6b7P/D6/v5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899378; c=relaxed/simple;
	bh=xCBTYv81PeNF975QR9IFKu2lr+NuN+oBXKx/ZFbPYcQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ToPUZDrKpb2MWtu++BrrNCz1SoG2wq+oXu36ACIMSpIgSUDjRt0wqCST1XL4j0w+LuOermoxg7pbFzNk62EXsFmYh3/fFVOdkvo5VRqDdXWTiHR9ykg+UQvZwz7EpMt8NCh9Pcco88h/VYnFZnVXMTOZidIBxCcXTnqB2+e9mYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=B5fqpXWb; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751899365; x=1752158565;
	bh=xCBTYv81PeNF975QR9IFKu2lr+NuN+oBXKx/ZFbPYcQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=B5fqpXWbZjCSoktNW7gYJaux5xKOqazmjCNpk+VP8r4lArLwyJ/V7yrLl9Rzat85B
	 FCaI11+KL5x7V0/NAogUfLYgQ4lUiUvuatVQHaTysSe7kIxYbFfyUDzVMIvpgQIEQK
	 Jt51pmvWfXbJM9EP3t6f5L8NMazmlQpH5UtdX7+Ao21YRdn6Lr+YbPsGTUtxZF1Mjm
	 BkudWzhHGbr1bj5ri+5lERVjBOcFDj7Pj1ZFtLJyZnJQzdmvu6d3DgEs7P0MUzK6as
	 p8Oiit7eehqmcUgj3LlTcWaA3Cv+SY0wKHKb7t3XslaP8RU0opdm6w+O5hvHOABj15
	 GFSs+7B/u6tng==
Date: Mon, 07 Jul 2025 14:42:39 +0000
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Argument
Message-ID: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: c7efb7625ee9c2f1de90bca2a8eadf23815e631b
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm having some weird issues with reading the temperature of the icm42605.
Kernel version: 6.16.0-rc5

# cat /sys/bus/iio/devices/iio:device2/name
icm42605-accel

When reading the temperature I get:
# cat /sys/bus/iio/devices/iio:device2/in_temp_raw
cat: read error: Invalid argument

But if I read from the accelerometer first, I will go better:
# cat /sys/bus/iio/devices/iio:device2/in_accel_x_raw
-378
# cat /sys/bus/iio/devices/iio:device2/in_temp_raw
600

Then after "some" time, I re-read the temperature I recieve
"Invalid argument" again.

I have traced the -EINVAL to inv_icm42600_temp_read() because I receive
INV_ICM42600_DATA_INVALID.

Register dump diff:
--- invalid-read
+++ ok-read
@@ -10,14 +10,14 @@
 0x1a =3D 0x00000010
 0x1b =3D 0x00000000
 0x1c =3D 0x00000000
-0x1d =3D 0x00000080
-0x1e =3D 0x00000000
-0x1f =3D 0x00000080
-0x20 =3D 0x00000000
-0x21 =3D 0x00000080
-0x22 =3D 0x00000000
-0x23 =3D 0x00000080
-0x24 =3D 0x00000000
+0x1d =3D 0x00000002
+0x1e =3D 0x00000038
+0x1f =3D 0x000000fe
+0x20 =3D 0x00000085
+0x21 =3D 0x000000fe
+0x22 =3D 0x000000df
+0x23 =3D 0x000000f8
+0x24 =3D 0x0000003a
 0x25 =3D 0x00000080
 0x26 =3D 0x00000000
 0x27 =3D 0x00000080
@@ -26,7 +26,7 @@
 0x2a =3D 0x00000000
 0x2b =3D 0x00000000
 0x2c =3D 0x00000000
-0x2d =3D 0x00000000
+0x2d =3D 0x00000008
 0x2e =3D 0x00000000
 0x2f =3D 0x00000000
 0x30 =3D 0x000000ff
@@ -59,11 +59,11 @@
 0x4b =3D 0x00000000
 0x4c =3D 0x00000032
 0x4d =3D 0x00000099
-0x4e =3D 0x00000000
+0x4e =3D 0x00000002
 0x4f =3D 0x00000009
 0x50 =3D 0x00000009
 0x51 =3D 0x00000016
-0x52 =3D 0x00000000
+0x52 =3D 0x00000060
 0x53 =3D 0x0000000d
 0x54 =3D 0x00000031
 0x55 =3D 0x00000000

Will the iio core retry a read? If the -EINVAL is returned,
inv_icm42600_accel_read_raw() is call once more.

One more thing...
When I'm removing the module, the kernel prints this:
inv-icm42600-i2c 1-0068: Runtime PM usage count underflow!

I will continue investigate this
Br,
Sean


