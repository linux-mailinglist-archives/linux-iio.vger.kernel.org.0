Return-Path: <linux-iio+bounces-13687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564379F849F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 20:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE65188992D
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 19:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B86E1B5EA4;
	Thu, 19 Dec 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Y4ASiIA7"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D791AA1C9;
	Thu, 19 Dec 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734637436; cv=none; b=GJ6E9u1XJ2q8xM/lGZLxb0+8ZPA/UY9P5d+KvSg6MMDnS73Dw8jeafI5tJ/Cu34Xq2evj+bvKw9w5a6SCwjl4eU8kZZgAtzigYHFOctMipWfQ+gxWOH/Io94coBFukhFRMAN4i+NWDTQpkvP5rPYXLUlU5zqOuVy7mk9knPH2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734637436; c=relaxed/simple;
	bh=i3cPteIfIVnhWjHZhPIlwE1zwndbKSSYnSQS6sFoWmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzaOFNvxGd8TJ/0IW5WM+y9Ex+XLsYKJJ7rhtVOjma53/dJghHFJtSV0zX+q9Fs1+ktuQXciRO783/mZBQQpmOT7uX9idqOJAVsOkb2FPJYEXtVAm1Wh02ZS3VamqO/epynyNZOKh8pIH7JYxitJWvHABBWxwZDd4TMDY/LHTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Y4ASiIA7; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Trw19/+QiBbtHhclK1EUrKm5kQfG8IrKDSpHB+S9x+s=; b=Y4ASiIA7RKiZIUxh6Wkxf5FMz2
	rmFwCsDftnxyt6CGxD5KPW2LNHr8SzvanArYNnYOPykiyu8lZxtFr3MmpSQEhB2qiSfw3gC6jAjwZ
	VrI+879M/z3zrKTQV4UtRbKdva49oo7T1SQgaoeTu6ZzMpqGwfRWnbSCJej19tSJxN0pGgxBgJLUz
	QcEnFLtnpBpa/hdJMKMRmgn2qqYGlf2gWXmsFEgX/XE/kwthI1rD1mQWqx4yHLHPsjL/l6pHFFljJ
	1ePb61zC1vWf4XoADcpxwRv6BNUcHJn0AqAcvLYsVeaY5KN+he/3zSPok95HIXpdUPH7DAogou5ig
	vTqbkzBg==;
Received: from i53875bfb.versanet.de ([83.135.91.251] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tOMQQ-00028H-7j; Thu, 19 Dec 2024 20:43:10 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: lee@kernel.org, jikos@kernel.org, jic23@kernel.org,
 Kees Bakker <kees@ijzerbout.nl>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jdelvare@suse.com, linux@roeck-us.net, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, dmitry.torokhov@gmail.com, pavel@ucw.cz,
 ukleinek@debian.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org
Subject: Re: [PATCH v9 4/9] mfd: add base driver for qnap-mcu devices
Date: Thu, 19 Dec 2024 20:43:08 +0100
Message-ID: <3130486.CbtlEUcBR6@diego>
In-Reply-To: <5d1ddf7e-2df5-4563-81e5-e0cfa7ef58da@ijzerbout.nl>
References:
 <20241107114712.538976-1-heiko@sntech.de>
 <20241107114712.538976-5-heiko@sntech.de>
 <5d1ddf7e-2df5-4563-81e5-e0cfa7ef58da@ijzerbout.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Kees,

Am Donnerstag, 19. Dezember 2024, 20:18:38 CET schrieb Kees Bakker:
> Op 07-11-2024 om 12:47 schreef Heiko Stuebner:
> > These microcontroller units are used in network-attached-storage devices
> > made by QNAP and provide additional functionality to the system.
> >
> > This adds the base driver that implements the serial protocol via
> > serdev and additionally hooks into the poweroff handlers to turn
> > off the parts of the system not supplied by the general PMIC.
> >
> > Turning off (at least the TSx33 devices using Rockchip SoCs) consists of
> > two separate actions. Turning off the MCU alone does not turn off the main
> > SoC and turning off only the SoC/PMIC does not turn off the hard-drives.
> > Also if the MCU is not turned off, the system also won't start again until
> > it is unplugged from power.
> >
> > So on shutdown the MCU needs to be turned off separately before the
> > main PMIC.
> >
> > The protocol spoken by the MCU is sadly not documented, but was
> > obtained by listening to the chatter on the serial port, as thankfully
> > the "hal_app" program from QNAPs firmware allows triggering all/most
> > MCU actions from the command line.
> >
> > The implementation of how to talk to the serial device got some
> > inspiration from the rave-sp servdev driver.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >   MAINTAINERS                  |   6 +
> >   drivers/mfd/Kconfig          |  13 ++
> >   drivers/mfd/Makefile         |   2 +
> >   drivers/mfd/qnap-mcu.c       | 338 +++++++++++++++++++++++++++++++++++
> >   include/linux/mfd/qnap-mcu.h |  26 +++
> >   5 files changed, 385 insertions(+)
> >   create mode 100644 drivers/mfd/qnap-mcu.c
> >   create mode 100644 include/linux/mfd/qnap-mcu.h
> >
> > [...]
> > diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
> > new file mode 100644
> > index 000000000000..4be39d8b2905
> > --- /dev/null
> > +++ b/drivers/mfd/qnap-mcu.c
> > [...]
> > +int qnap_mcu_exec(struct qnap_mcu *mcu,
> > +		  const u8 *cmd_data, size_t cmd_data_size,
> > +		  u8 *reply_data, size_t reply_data_size)
> > +{
> > +	unsigned char rx[QNAP_MCU_RX_BUFFER_SIZE];
> > +	size_t length = reply_data_size + QNAP_MCU_CHECKSUM_SIZE;
> > +	struct qnap_mcu_reply *reply = &mcu->reply;
> > +	int ret = 0;
> > +
> > +	if (length > sizeof(rx)) {
> > +		dev_err(&mcu->serdev->dev, "expected data too big for receive buffer");
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(&mcu->bus_lock);
> > +
> > +	reply->data = rx,
> > +	reply->length = length,
> > +	reply->received = 0,
> > +	reinit_completion(&reply->done);
> > +
> > +	qnap_mcu_write(mcu, cmd_data, cmd_data_size);
> > +
> > +	serdev_device_wait_until_sent(mcu->serdev, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS));
> > +
> > +	if (!wait_for_completion_timeout(&reply->done, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS))) {
> > +		dev_err(&mcu->serdev->dev, "Command timeout\n");
> > +		ret = -ETIMEDOUT;
> > +	} else {
> > +		u8 crc = qnap_mcu_csum(rx, reply_data_size);
> Here `rx` is still not initialized.

The MCU works in a way that a sent command always causes "reply_data_size"
bytes to be returned.

So for each qnap_mcu_write() above we know that this amount of bytes has
been returned (and thus written into rx) if the completion above finishes
sucessfully.

"rx" is assigned to reply->data above (same as the expected received size).
When characters are received on the serial line, this will trigger
qnap_mcu_receive_buf() from the serdev and thus fill those elements in rx.

So if we land at the qnap_mcu_csum() call, we do have received the expected
amount of bytes from the serdev and thus rx is filled accordingly.

If we don't receive the needed amount of bytes, we end up in the timeout
above that.

What did I miss?


Heiko

> > +
> > +		if (crc != rx[reply_data_size]) {
> > +			dev_err(&mcu->serdev->dev,
> > +				"Invalid Checksum received\n");
> > +			ret = -EIO;
> > +		} else {
> > +			memcpy(reply_data, rx, reply_data_size);
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&mcu->bus_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(qnap_mcu_exec);
> >
> 





