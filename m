Return-Path: <linux-iio+bounces-21442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B78AFC87F
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 12:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9771BC1992
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839B2D8383;
	Tue,  8 Jul 2025 10:35:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2D62D837F
	for <linux-iio@vger.kernel.org>; Tue,  8 Jul 2025 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970923; cv=none; b=OXt6PjcObZ738/mFQbjPWriH9SeKQ6c+pdw9wfuQt0euB4+UpEyqqlph7Kh6q3YWAvu1EJgg41NjcnNHE3V4CoQearLS/ZNgkziq+2VG74ncLcOyvZ2Pw7twoZACa4xYKF7qSqRMHu/IS87rgoLQwB5KzgQINkPdYEDzBra5t4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970923; c=relaxed/simple;
	bh=84yk8TsytVDgvxgXRWlimWjQVoEtVd8QckhPovsJOnc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/7AfjBqGm/liMS3Rbyk85m2lcScSVz7ze7GwycmQnJ3e3XwDmfedM7p2rvV0mTk9dqPx3+sDHvM/Y1UljYQPfgY7xUH+s3lTY2SNX3ewVT5r/hEOpIU0ic6bgQotR+GTU++BLYZiPtU1cuUarmHA3jmwL2ArhD24si3zzHmb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bby8d2drBz6GDNy;
	Tue,  8 Jul 2025 18:32:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A640A1402FC;
	Tue,  8 Jul 2025 18:35:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Jul
 2025 12:35:10 +0200
Date: Tue, 8 Jul 2025 11:35:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
CC: Sean Nyekjaer <sean@geanix.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [BUG] iio: imu: inv_icm42600: read temperature, Invalid
 Argument
Message-ID: <20250708113508.000027fb@huawei.com>
In-Reply-To: <FR3P281MB1757FE243D78E8F78DA6C576CE4FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o>
	<FR3P281MB1757FE243D78E8F78DA6C576CE4FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 7 Jul 2025 18:13:33 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >Hi,
> >
> >I'm having some weird issues with reading the temperature of the icm42605.
> >Kernel version: 6.16.0-rc5
> >
> ># cat /sys/bus/iio/devices/iio:device2/name
> >icm42605-accel
> >
> >When reading the temperature I get:
> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw
> >cat: read error: Invalid argument
> >
> >But if I read from the accelerometer first, I will go better:
> ># cat /sys/bus/iio/devices/iio:device2/in_accel_x_raw
> >-378
> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw
> >600
> >
> >Then after "some" time, I re-read the temperature I recieve
> >"Invalid argument" again.
> >
> >I have traced the -EINVAL to inv_icm42600_temp_read() because I receive
> >INV_ICM42600_DATA_INVALID.
> >
> >Register dump diff:
> >--- invalid-read
> >+++ ok-read
> >@@ -10,14 +10,14 @@
> > 0x1a = 0x00000010
> > 0x1b = 0x00000000
> > 0x1c = 0x00000000
> >-0x1d = 0x00000080
> >-0x1e = 0x00000000
> >-0x1f = 0x00000080
> >-0x20 = 0x00000000
> >-0x21 = 0x00000080
> >-0x22 = 0x00000000
> >-0x23 = 0x00000080
> >-0x24 = 0x00000000
> >+0x1d = 0x00000002
> >+0x1e = 0x00000038
> >+0x1f = 0x000000fe
> >+0x20 = 0x00000085
> >+0x21 = 0x000000fe
> >+0x22 = 0x000000df
> >+0x23 = 0x000000f8
> >+0x24 = 0x0000003a
> > 0x25 = 0x00000080
> > 0x26 = 0x00000000
> > 0x27 = 0x00000080
> >@@ -26,7 +26,7 @@
> > 0x2a = 0x00000000
> > 0x2b = 0x00000000
> > 0x2c = 0x00000000
> >-0x2d = 0x00000000
> >+0x2d = 0x00000008
> > 0x2e = 0x00000000
> > 0x2f = 0x00000000
> > 0x30 = 0x000000ff
> >@@ -59,11 +59,11 @@
> > 0x4b = 0x00000000
> > 0x4c = 0x00000032
> > 0x4d = 0x00000099
> >-0x4e = 0x00000000
> >+0x4e = 0x00000002
> > 0x4f = 0x00000009
> > 0x50 = 0x00000009
> > 0x51 = 0x00000016
> >-0x52 = 0x00000000
> >+0x52 = 0x00000060
> > 0x53 = 0x0000000d
> > 0x54 = 0x00000031
> > 0x55 = 0x00000000
> >
> >Will the iio core retry a read? If the -EINVAL is returned,
> >inv_icm42600_accel_read_raw() is call once more.
> >
> >One more thing...
> >When I'm removing the module, the kernel prints this:
> >inv-icm42600-i2c 1-0068: Runtime PM usage count underflow!
> >
> >I will continue investigate this
> >Br,
> >Sean  
> 
> Hello Sean,
> 
> this is expected behavior since the temperature returned is not the external
> temperature but the temperature of the mechanical component (MEMS). It will
> only work if the chip is on, meaning accelerometer and/or gyroscope is on.
> 
> That's why you can get temperature after reading accel data since it is
> turning the chip. But after a short while autosuspend is putting the chip
> back off and you cannot read temperature anymore.
> 
> You need to turn one sensor continuously on with a buffer, and then you can
> read temperature all the time since the chip is running.
> 
> Temperature data are here only to do temperature compensation of the accel
> and gyro data.

That is rather non-intuitive behavior.  Could we make a read of the temperature
channel turn on one of the components?  Given expected use case it shouldn't commonly
happen but if not too horrendous to implement it would be better to avoid the error
seen here.
 
> 
> Thanks,
> JB


