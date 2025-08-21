Return-Path: <linux-iio+bounces-23081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40160B2F055
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718A53B4EE8
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F9296BA6;
	Thu, 21 Aug 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="J+n0gphu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5ED2D4B4E
	for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763106; cv=none; b=j+tgbSAb69X0xDKuTZ2g6pK+Ou8wN2PCym0G0FdaJPgf8UoNI5LNJDJUH4TSiQnhVazmTxzSd5G+zmkhXXxGj5XUXGMZg2+xgef3yUVLRGZWsvRYunNQxDVnD/QoevzrWG1jzf1p4QMXY5HfnXHgJlg2z826FHWVUoQSOwH4tyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763106; c=relaxed/simple;
	bh=mWlpw+fkzNl2HTOTZh9Un5HqYgwUcx6hxK0zkS34qjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRL9w18jZIAqs/wRrr378efLXsWANIB+WN1JxpgO1cPdRR4pBlEKzcqln6xRFGgF+XXQoLKQFZCF4HZ7O2W4TmpeeWe/sFwj1Rq5VP/D83IhBev7xTNdr6hJcwkRFaHRHakrU1EowlhJ22LEmXJzubdrpBjSpanJQ7nzgcTW91E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=J+n0gphu; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755763041;
	bh=sax2l/uhGaoVMc5A5beGcQGw8z9geLQ5SDB6E7o7aIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=J+n0gphu4se3pvo7QHE7UeQMxI7zPFhH8jlv74uzpV0yubesbjsd29Cxo5OlNScLU
	 KNFZgRz5P3MSWufSVdnyOmZhXcXClSjoHzJ2pfjdAD5xicvVJiWznmPE3sZASNm7Mt
	 23TwUaHmpAazEFBC0gBKg5NDhOub80YdZN9Wn+8w=
X-QQ-mid: esmtpgz15t1755763015td44f2826
X-QQ-Originating-IP: k3xqsQ6QizxKHvrmeVfM0flZPWWA4AlqFE6ixRPd+vY=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 15:56:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3014638784407985306
EX-QQ-RecipientCnt: 13
Message-ID: <C559DC784053B698+aaafc990-e62a-4b71-86ba-a1ea4ce1c069@uniontech.com>
Date: Thu, 21 Aug 2025 15:56:52 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: imu: bmi270: Match PNP ID found on newer GPD
 firmware
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@deepin.org>,
 Jun Zhan <zhanjun@uniontech.com>, niecheng1@uniontech.com2
References: <20250821-bmi270-gpd-acpi-v3-1-91a873cb87c0@uniontech.com>
 <CAHp75VeTgWifRnqYxi8P_yfMv_GMvJJi4+xJNB98gtKp0z93=A@mail.gmail.com>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <CAHp75VeTgWifRnqYxi8P_yfMv_GMvJJi4+xJNB98gtKp0z93=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N3IC8um5pMyYn7iimufSD9vENDcT/RqlJTayM2/lK8eck5t2Nsbtqf4D
	/kt14BijQA1y8vSURPo2iqMLOeodJBHW1+Blgmi27oWTJjflvxlB/RKT8Mdt2NdN0jrbLZH
	IDmcuSEKWgukUW+GEd0smvkj4FTtcbFywYtbE9M6v3lAZobEk8l7lV8qwHHYGn3aBD7xnVD
	yexAHeHVrtvDecqoi1BUFWvfdfX3n1d/UV0qCLmFlArcPB7sFt7Jfb8iw35H18gokamNty4
	VJ0LhcI/nh1NHm3VkNWXn6QwqlWdJVWIKlrAX0DWTDSrehGV+DhfdB6/s7p9D1mJF1yES5k
	FelXX62hsgSe/cK7SvaR+LHsq6mR1vD4cpEGe6e7zGDOZZvKXZLZjp8iJmWkJsdwtLkGSkB
	7tQpn/2sptRj4b96UWY0ZlYhkuChBju24ZggYqKayW1qP3lLvvgiiJyU6A09gOYLvZi6bBP
	LG/PvcEvuKOfJPZevBZct4FQrljq81pDyBQoQN/TnObSbenMuoPbu7kUP5xuJqO73uiJEyZ
	XlScgGFA/pW+l9ZBofwjsv6VvPB9N7Ba2ApuzY3ZUXyXyT5SGGVXr9lq2cSKXmo57rvbg44
	J8YkCJ847Y0Rodg0TNlF+lrAWZyNPpWlabxZ6Qhv9EDjvjxByvYyJekGQZyD+ptZro7CNU7
	/3lVAoKWhpnmXt+F+JezX8VILSOul3l0jfG3YBjrdL099DoeoS71IWIDosw0VFcIapUpdMW
	ln2IsgkwS2Jy2KhKMK5wV7yL5desZIoKjdj1x1lM7hwV1nQ0yRtN+2kZtZ21pl3cYLE82cW
	+W4iAg64BwEFN3EgtHhvpg8jec0vMPIuddQFkqgz5r5HquvEqYQ+rvzEuYFJtzL4sVTxHwC
	/QtwvcWHpPLjh967hJvThIWpnYWqMexsbmPaxE0zH96JbkP3xCgjgg2OTOYA9SYry7Nijv1
	Y/ALCDuGUybtmUvBX4ELW0OJXf8k9V2N17Izx+QQesEJ7AvAWued7W/3MFbQzIj2hMf5V17
	daefYiVQmMouLKCb0ExlwV96HSic1vRwI9cd/D2hhi25j75Ow4
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0


On 21/08/2025 15.36, Andy Shevchenko wrote:
> On Thu, Aug 21, 2025 at 9:17 AM Cryolitia PukNgae via B4 Relay
> <devnull+cryolitia.uniontech.com@kernel.org> wrote:
>> From: Cryolitia PukNgae <cryolitia@uniontech.com>
>>
>> GPD devices originally used BMI160 sensors with the "BMI0160" PNP ID.
>> When they switched to BMI260 sensors in newer hardware, they reused
>> the existing Windows driver which accepts both "BMI0160" and "BMI0260"
>> IDs. Consequently, they kept "BMI0160" in DSDT tables for new BMI260
>> devices, causing driver mismatches in Linux.
>>
>> 1. GPD updated BIOS v0.40+[1] for newer devices to report "BMI0260" for
>> BMI260 sensors to avoid loading bmi160 driver on Linux. While this
> the bmi160 driver
>
>> isn't Bosch's VID;
>> 2. Bosch's official Windows driver uses "BMI0260" as a compatible ID
>> 3. We're seeing real devices shipping with "BMI0260" in DSDT
>>
>> The DSDT excerpt of GPD G1619-04 with BIOS v0.40:
>>
>> Scope (_SB.I2CC)
>> {
>>      Device (BMA2)
>>      {
>>          Name (_ADR, Zero)  // _ADR: Address
>>          Name (_HID, "BMI0260")  // _HID: Hardware ID
>>          Name (_CID, "BMI0260")  // _CID: Compatible ID
>>          Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>>          Name (_UID, One)  // _UID: Unique ID
>>          Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>          {
>>              Name (RBUF, ResourceTemplate ()
>>              {
>>                  I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
>>                      AddressingMode7Bit, "\\_SB.I2CC",
>>                      0x00, ResourceConsumer, , Exclusive,
>>                      )
>>              })
>>              Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
>>          }
>>          # omit some noise
>>      }
>> }
>>
>> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip #1
> This blank line is not supposed to be here (the tag block is
> considered as the last lines in the commit message without blank
> lines, like a text paragraph).
>
>> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ...
>
> No need to resend for these nit-picks, I hope Jonathan will tweak them
> whilst applying.
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
Oops, I edited it without seeing this line before sending it out. I hope 
it won't cause too much bother. thx for your review.


