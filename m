Return-Path: <linux-iio+bounces-13684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A159F83F1
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 20:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA63E18876B6
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 19:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15831AA1C9;
	Thu, 19 Dec 2024 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="lIogWcGI"
X-Original-To: linux-iio@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3481A0B0C;
	Thu, 19 Dec 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635926; cv=none; b=OYgWu8HoDYkxEGothioye4m+QpYk0R3lFHCgJzQpkxDgixfinnswfcZ7uiAyr8vvWixiMhoeMC7A0CwWrzy+TIBR8JS/0IpOkDEVz9mBpH3cbvW27TGkXoXyd7N04epP9hchnUsf6e0n4WqT3kTbTJWXKLHVIsiv2vHN12KFk/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635926; c=relaxed/simple;
	bh=ePqid386Kw0s0U8dD6CHm5o3ERJZxHjExxMl2I2S+uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wof46T3Yn+57/gcJDJz78oo5ulZcXuIPMnC++nTHKW+yizyQxglezpC4bErBzTlz4f6OV6G7onGH77ciCWMP+ptpWujRAnovksvAEdGZt21ux42xBJruKFSJDDBrBmoDonPTu//0KUvLVPXuAfyGIxws+HRIwqGPSwPjVCKDcc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=lIogWcGI; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1734635921; bh=ePqid386Kw0s0U8dD6CHm5o3ERJZxHjExxMl2I2S+uA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lIogWcGIG+pjsUbAY/EcEX04nRe7jtAwZzi3OC/A1F2Wj+Q19sLhjWnrlkrI6Heam
	 vQ3XfW9KX1BBO5NK1YSVWgaXH2yhnItbEJYkXyWhysjMJmK05XfnQS7Lq19lkrQDSd
	 tbF0Pww4MUh8j8Uq41rfLboOrm7nHybzPJH6EC9wsCfk0svST3lfzzyWuwIdEvFHvI
	 8bz1L9ulYOLVntgDYqEGheJAegSW9TevRU4dJaQFrGEhhDsKqp4cd9jjVViEHtBvgp
	 1Cb+Gdq84z4kRPdbzh3uZoCB1UOeofBRfR47C7jPys+0f+6NOol1q2Z4qS839cy1yH
	 uzL8/wivb5tGjU1IajBpLZmpMLwPVaWXZmw7U20KW4HtGdAZvyl15Xu8Fl1GJ6Obb6
	 4O1cAHukrEq82a6TkzVsl7rKRNCYnPeOVzVwOSYRTkpWK87s5GXqjEoT2ttdhMaSei
	 ndv3zU5EllCcLxaMtxgvn8P5hQqCdJ3nHixwAh8VJshJQTNj1wi3x10UnZL1+MaEvA
	 tanO3naAd8tvzPQRyA6DypW8zcjud5R+h2nlC7nBouKxHYITKgUAjjs41x8rEWbkRV
	 vXKL9DneRi9aHD9wm1FqCgVlqFpIzAyOeT8orELDRVz6BdttjIxzQ3+gAxE2WY3DFZ
	 EMPaJ1YoWkHWB9MgcfbTP8HM=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 899FD18010B;
	Thu, 19 Dec 2024 20:18:40 +0100 (CET)
Message-ID: <5d1ddf7e-2df5-4563-81e5-e0cfa7ef58da@ijzerbout.nl>
Date: Thu, 19 Dec 2024 20:18:38 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/9] mfd: add base driver for qnap-mcu devices
To: Heiko Stuebner <heiko@sntech.de>, lee@kernel.org, jikos@kernel.org,
 jic23@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jdelvare@suse.com, linux@roeck-us.net, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, dmitry.torokhov@gmail.com, pavel@ucw.cz,
 ukleinek@debian.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20241107114712.538976-1-heiko@sntech.de>
 <20241107114712.538976-5-heiko@sntech.de>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241107114712.538976-5-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 07-11-2024 om 12:47 schreef Heiko Stuebner:
> These microcontroller units are used in network-attached-storage devices
> made by QNAP and provide additional functionality to the system.
>
> This adds the base driver that implements the serial protocol via
> serdev and additionally hooks into the poweroff handlers to turn
> off the parts of the system not supplied by the general PMIC.
>
> Turning off (at least the TSx33 devices using Rockchip SoCs) consists of
> two separate actions. Turning off the MCU alone does not turn off the main
> SoC and turning off only the SoC/PMIC does not turn off the hard-drives.
> Also if the MCU is not turned off, the system also won't start again until
> it is unplugged from power.
>
> So on shutdown the MCU needs to be turned off separately before the
> main PMIC.
>
> The protocol spoken by the MCU is sadly not documented, but was
> obtained by listening to the chatter on the serial port, as thankfully
> the "hal_app" program from QNAPs firmware allows triggering all/most
> MCU actions from the command line.
>
> The implementation of how to talk to the serial device got some
> inspiration from the rave-sp servdev driver.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   MAINTAINERS                  |   6 +
>   drivers/mfd/Kconfig          |  13 ++
>   drivers/mfd/Makefile         |   2 +
>   drivers/mfd/qnap-mcu.c       | 338 +++++++++++++++++++++++++++++++++++
>   include/linux/mfd/qnap-mcu.h |  26 +++
>   5 files changed, 385 insertions(+)
>   create mode 100644 drivers/mfd/qnap-mcu.c
>   create mode 100644 include/linux/mfd/qnap-mcu.h
>
> [...]
> diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
> new file mode 100644
> index 000000000000..4be39d8b2905
> --- /dev/null
> +++ b/drivers/mfd/qnap-mcu.c
> [...]
> +int qnap_mcu_exec(struct qnap_mcu *mcu,
> +		  const u8 *cmd_data, size_t cmd_data_size,
> +		  u8 *reply_data, size_t reply_data_size)
> +{
> +	unsigned char rx[QNAP_MCU_RX_BUFFER_SIZE];
> +	size_t length = reply_data_size + QNAP_MCU_CHECKSUM_SIZE;
> +	struct qnap_mcu_reply *reply = &mcu->reply;
> +	int ret = 0;
> +
> +	if (length > sizeof(rx)) {
> +		dev_err(&mcu->serdev->dev, "expected data too big for receive buffer");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&mcu->bus_lock);
> +
> +	reply->data = rx,
> +	reply->length = length,
> +	reply->received = 0,
> +	reinit_completion(&reply->done);
> +
> +	qnap_mcu_write(mcu, cmd_data, cmd_data_size);
> +
> +	serdev_device_wait_until_sent(mcu->serdev, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS));
> +
> +	if (!wait_for_completion_timeout(&reply->done, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS))) {
> +		dev_err(&mcu->serdev->dev, "Command timeout\n");
> +		ret = -ETIMEDOUT;
> +	} else {
> +		u8 crc = qnap_mcu_csum(rx, reply_data_size);
Here `rx` is still not initialized.
> +
> +		if (crc != rx[reply_data_size]) {
> +			dev_err(&mcu->serdev->dev,
> +				"Invalid Checksum received\n");
> +			ret = -EIO;
> +		} else {
> +			memcpy(reply_data, rx, reply_data_size);
> +		}
> +	}
> +
> +	mutex_unlock(&mcu->bus_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qnap_mcu_exec);
>

