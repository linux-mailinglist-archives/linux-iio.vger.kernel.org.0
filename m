Return-Path: <linux-iio+bounces-13689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CEA9F84C5
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 20:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EEB188A807
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75B61B6CE1;
	Thu, 19 Dec 2024 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="S2S4Fpfx"
X-Original-To: linux-iio@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FDD155342;
	Thu, 19 Dec 2024 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734637908; cv=none; b=nHMGPB2mCENN7APG3yg1XrAN9mNgXqdQ1lI+aa7aMTHGNMkjY9xKxJHIl0FA6p//mlnEoG2rPf23W1qd6O4TNDHBuzacD2qsJtxcRIz4MXB7ZVd8BGW6MSXFIdPFPmedhQC0yNm5id1v3f7iEJSUOuFxiEPPmZRFIkmBe9WcDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734637908; c=relaxed/simple;
	bh=CLTYGlkArbh9G44nbamSYDRsT+GxW9EOzuXjgf57kew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4TITC3sZa2/gY0dHSzsVqyTqlYZ68cUXiB1H1hbUXyE1j9by7/Nkx8haOCSzRWQmBj9LWfVNV/vp6vLKyJQWBEqK9zJqLz9TNVCffXXuqLnMqkfDFSloDDhr/N36XVLwYWePjmGrucXaPB1Samz+8NUP/YTv5EHCnzENEZLebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=S2S4Fpfx; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1734637904; bh=CLTYGlkArbh9G44nbamSYDRsT+GxW9EOzuXjgf57kew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S2S4Fpfx+y2RwzTH27vG7Pm6ixE0N+e0KsxNdKwNsdOcgb97FjTAIJIrvu/OM6DBR
	 ERy16mpog/gaQJwHjFF/6+r7EPRYbbcl4QwR7jusUOIyoG61Iy/XUdXOTdawQ2DZhu
	 nlcdcwJaYiMnhnIF/ND6buzeqSKdrOQj8RI2cQQNiHxLRnn3/CyzuEananaUOPIiyW
	 lj9wtTWsMpH0THnYevKFhMdoZJRRfPi8Qzy50GzI0jTIHLQ5V8QlwpNY4NVT2SqfgF
	 GPlbSPGLKkoSM2fecuswXSU1b/PomVoiQJeZr+Vz5AEW0Cp2Q4Iwac/jPDEI4BO8iN
	 DPlnn7uVBrn2jEThiYgmvVOB80UDULTb2emYsVZFAuzReteGey4zvSSzvKVu/Mzcvz
	 F8LHEf6wE5552abnvkhU/MdN/OPuG35qiwd19fK0yglFNCOccDDBke1YgkUuSicXMF
	 PxdUdTiuiDtLjP2llVQv3U5DBDonIiYc3BxuFuH485QqvkXoiqDRUbyazCGpL6u4zL
	 nvK2JSqFQoGXA/cLpfEZo5IvMEGXkEAnKTP/DqmSzJbPBGVkXRnnvYZXXTBUlr2AcC
	 Jb0evGNO9isBVdjyhr6XKuPntK8SvMzBl7vw6VdhFLKUUcIYZlaomrY0XphpQSfwvX
	 hYoP0YM6Lij67jU1554I7ki0=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 0DB7218010B;
	Thu, 19 Dec 2024 20:51:44 +0100 (CET)
Message-ID: <4cecc705-84ab-44d5-8725-eb973254f257@ijzerbout.nl>
Date: Thu, 19 Dec 2024 20:51:41 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/9] mfd: add base driver for qnap-mcu devices
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, lee@kernel.org,
 jikos@kernel.org, jic23@kernel.org
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
 <5d1ddf7e-2df5-4563-81e5-e0cfa7ef58da@ijzerbout.nl>
 <3130486.CbtlEUcBR6@diego>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <3130486.CbtlEUcBR6@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 19-12-2024 om 20:43 schreef Heiko Stübner:
> Hi Kees,
>
> Am Donnerstag, 19. Dezember 2024, 20:18:38 CET schrieb Kees Bakker:
>> Op 07-11-2024 om 12:47 schreef Heiko Stuebner:
>>> These microcontroller units are used in network-attached-storage devices
>>> made by QNAP and provide additional functionality to the system.
>>>
>>> This adds the base driver that implements the serial protocol via
>>> serdev and additionally hooks into the poweroff handlers to turn
>>> off the parts of the system not supplied by the general PMIC.
>>>
>>> Turning off (at least the TSx33 devices using Rockchip SoCs) consists of
>>> two separate actions. Turning off the MCU alone does not turn off the main
>>> SoC and turning off only the SoC/PMIC does not turn off the hard-drives.
>>> Also if the MCU is not turned off, the system also won't start again until
>>> it is unplugged from power.
>>>
>>> So on shutdown the MCU needs to be turned off separately before the
>>> main PMIC.
>>>
>>> The protocol spoken by the MCU is sadly not documented, but was
>>> obtained by listening to the chatter on the serial port, as thankfully
>>> the "hal_app" program from QNAPs firmware allows triggering all/most
>>> MCU actions from the command line.
>>>
>>> The implementation of how to talk to the serial device got some
>>> inspiration from the rave-sp servdev driver.
>>>
>>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>> ---
>>>    MAINTAINERS                  |   6 +
>>>    drivers/mfd/Kconfig          |  13 ++
>>>    drivers/mfd/Makefile         |   2 +
>>>    drivers/mfd/qnap-mcu.c       | 338 +++++++++++++++++++++++++++++++++++
>>>    include/linux/mfd/qnap-mcu.h |  26 +++
>>>    5 files changed, 385 insertions(+)
>>>    create mode 100644 drivers/mfd/qnap-mcu.c
>>>    create mode 100644 include/linux/mfd/qnap-mcu.h
>>>
>>> [...]
>>> diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
>>> new file mode 100644
>>> index 000000000000..4be39d8b2905
>>> --- /dev/null
>>> +++ b/drivers/mfd/qnap-mcu.c
>>> [...]
>>> +int qnap_mcu_exec(struct qnap_mcu *mcu,
>>> +		  const u8 *cmd_data, size_t cmd_data_size,
>>> +		  u8 *reply_data, size_t reply_data_size)
>>> +{
>>> +	unsigned char rx[QNAP_MCU_RX_BUFFER_SIZE];
>>> +	size_t length = reply_data_size + QNAP_MCU_CHECKSUM_SIZE;
>>> +	struct qnap_mcu_reply *reply = &mcu->reply;
>>> +	int ret = 0;
>>> +
>>> +	if (length > sizeof(rx)) {
>>> +		dev_err(&mcu->serdev->dev, "expected data too big for receive buffer");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	mutex_lock(&mcu->bus_lock);
>>> +
>>> +	reply->data = rx,
>>> +	reply->length = length,
>>> +	reply->received = 0,
>>> +	reinit_completion(&reply->done);
>>> +
>>> +	qnap_mcu_write(mcu, cmd_data, cmd_data_size);
>>> +
>>> +	serdev_device_wait_until_sent(mcu->serdev, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS));
>>> +
>>> +	if (!wait_for_completion_timeout(&reply->done, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS))) {
>>> +		dev_err(&mcu->serdev->dev, "Command timeout\n");
>>> +		ret = -ETIMEDOUT;
>>> +	} else {
>>> +		u8 crc = qnap_mcu_csum(rx, reply_data_size);
>> Here `rx` is still not initialized.
> The MCU works in a way that a sent command always causes "reply_data_size"
> bytes to be returned.
>
> So for each qnap_mcu_write() above we know that this amount of bytes has
> been returned (and thus written into rx) if the completion above finishes
> sucessfully.
>
> "rx" is assigned to reply->data above (same as the expected received size).
> When characters are received on the serial line, this will trigger
> qnap_mcu_receive_buf() from the serdev and thus fill those elements in rx.
>
> So if we land at the qnap_mcu_csum() call, we do have received the expected
> amount of bytes from the serdev and thus rx is filled accordingly.
>
> If we don't receive the needed amount of bytes, we end up in the timeout
> above that.
>
> What did I miss?
Sorry, my fault. I missed the essential part of the external event (external
for this function that is).
Thanks for explaining.
>
>
> Heiko
>
>>> +
>>> +		if (crc != rx[reply_data_size]) {
>>> +			dev_err(&mcu->serdev->dev,
>>> +				"Invalid Checksum received\n");
>>> +			ret = -EIO;
>>> +		} else {
>>> +			memcpy(reply_data, rx, reply_data_size);
>>> +		}
>>> +	}
>>> +
>>> +	mutex_unlock(&mcu->bus_lock);
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(qnap_mcu_exec);
>>>
>
>
>


