Return-Path: <linux-iio+bounces-13690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA899F8570
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 21:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4343B1894DAE
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 20:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE51BD9C2;
	Thu, 19 Dec 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vBiqfcfL"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352191B85D4;
	Thu, 19 Dec 2024 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638546; cv=none; b=JvnkJ1RCg9eE6xbz1VRj9ISTQv0PEJqEdGzZd+rIeMFuZtJO5lK1GRi4VfT/9NwoekCgOICUCkMfhDFxvvJHnPF1VyiTERRfAR+Y0rq84TljeGKVkJyuH6Q74IpEM1dlFXTQrOuoAtFFvAavdmHsciw2E3ftl0no2cYA3EAPBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638546; c=relaxed/simple;
	bh=3E1Tb12F+l4dP3zB5NxFkn7UV3D8TCq4z0Ef116fyLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brHQmyjIYI2PXXVkDDQAul7hvyan58LH0QvBGmj5LZyPt20BQ5+vdw+NIs2WKmY10Bou382vaMwo2GYywXUrbh562VNap88DQgQGIw8MxUDYQ6I03duP4PKwjMPWGMqUJ7RbjeoBaI1woWkIu+CkNDlJfCw0akY0zA/TNEDG1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vBiqfcfL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tp2pK6lzyD5U9SMCt2mZyhgNP17G7t7mTEM/wB/wlzQ=; b=vBiqfcfLrYdj2SfSKxFCxxLjK5
	+BS3nhubWvI92g3iIT3ypQf/dHEO/g1f4zOpaKzpvZEkvmPLoEPep20OfdzOiF2SAWqbnhTytrPdA
	uJVoWP87LdoKm3S+yL2kc94F48IauVLGVGpB/Q1Wy51CmGC0fh3qxpWm7VJUqeUNWE8WDVJl4MuKQ
	q2eS+OKgcX7UDcMJrvQ4PlWw7PHEuZty29h2oTg7fH79wzGku+teodDzj3V5awl2mb7A3z1R5Uzd6
	7EBx3lL/rpI4kEgylLcBNvjVY438SLRm13XuU67Eb/Y+fxgQElD/NL/09Xisvf18vDUwJPoJfNKJx
	twovPmzA==;
Received: from i53875bfb.versanet.de ([83.135.91.251] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tOMic-0002JL-NF; Thu, 19 Dec 2024 21:01:58 +0100
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
Date: Thu, 19 Dec 2024 21:01:57 +0100
Message-ID: <5047567.0VBMTVartN@diego>
In-Reply-To: <4cecc705-84ab-44d5-8725-eb973254f257@ijzerbout.nl>
References:
 <20241107114712.538976-1-heiko@sntech.de> <3130486.CbtlEUcBR6@diego>
 <4cecc705-84ab-44d5-8725-eb973254f257@ijzerbout.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 19. Dezember 2024, 20:51:41 CET schrieb Kees Bakker:
> Op 19-12-2024 om 20:43 schreef Heiko St=FCbner:
> > Hi Kees,
> >
> > Am Donnerstag, 19. Dezember 2024, 20:18:38 CET schrieb Kees Bakker:
> >> Op 07-11-2024 om 12:47 schreef Heiko Stuebner:
> >>> These microcontroller units are used in network-attached-storage devi=
ces
> >>> made by QNAP and provide additional functionality to the system.
> >>>
> >>> This adds the base driver that implements the serial protocol via
> >>> serdev and additionally hooks into the poweroff handlers to turn
> >>> off the parts of the system not supplied by the general PMIC.
> >>>
> >>> Turning off (at least the TSx33 devices using Rockchip SoCs) consists=
 of
> >>> two separate actions. Turning off the MCU alone does not turn off the=
 main
> >>> SoC and turning off only the SoC/PMIC does not turn off the hard-driv=
es.
> >>> Also if the MCU is not turned off, the system also won't start again =
until
> >>> it is unplugged from power.
> >>>
> >>> So on shutdown the MCU needs to be turned off separately before the
> >>> main PMIC.
> >>>
> >>> The protocol spoken by the MCU is sadly not documented, but was
> >>> obtained by listening to the chatter on the serial port, as thankfully
> >>> the "hal_app" program from QNAPs firmware allows triggering all/most
> >>> MCU actions from the command line.
> >>>
> >>> The implementation of how to talk to the serial device got some
> >>> inspiration from the rave-sp servdev driver.
> >>>
> >>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >>> ---
> >>>    MAINTAINERS                  |   6 +
> >>>    drivers/mfd/Kconfig          |  13 ++
> >>>    drivers/mfd/Makefile         |   2 +
> >>>    drivers/mfd/qnap-mcu.c       | 338 +++++++++++++++++++++++++++++++=
++++
> >>>    include/linux/mfd/qnap-mcu.h |  26 +++
> >>>    5 files changed, 385 insertions(+)
> >>>    create mode 100644 drivers/mfd/qnap-mcu.c
> >>>    create mode 100644 include/linux/mfd/qnap-mcu.h
> >>>
> >>> [...]
> >>> diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
> >>> new file mode 100644
> >>> index 000000000000..4be39d8b2905
> >>> --- /dev/null
> >>> +++ b/drivers/mfd/qnap-mcu.c
> >>> [...]
> >>> +int qnap_mcu_exec(struct qnap_mcu *mcu,
> >>> +		  const u8 *cmd_data, size_t cmd_data_size,
> >>> +		  u8 *reply_data, size_t reply_data_size)
> >>> +{
> >>> +	unsigned char rx[QNAP_MCU_RX_BUFFER_SIZE];
> >>> +	size_t length =3D reply_data_size + QNAP_MCU_CHECKSUM_SIZE;
> >>> +	struct qnap_mcu_reply *reply =3D &mcu->reply;
> >>> +	int ret =3D 0;
> >>> +
> >>> +	if (length > sizeof(rx)) {
> >>> +		dev_err(&mcu->serdev->dev, "expected data too big for receive buff=
er");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	mutex_lock(&mcu->bus_lock);
> >>> +
> >>> +	reply->data =3D rx,
> >>> +	reply->length =3D length,
> >>> +	reply->received =3D 0,
> >>> +	reinit_completion(&reply->done);
> >>> +
> >>> +	qnap_mcu_write(mcu, cmd_data, cmd_data_size);
> >>> +
> >>> +	serdev_device_wait_until_sent(mcu->serdev, msecs_to_jiffies(QNAP_MC=
U_TIMEOUT_MS));
> >>> +
> >>> +	if (!wait_for_completion_timeout(&reply->done, msecs_to_jiffies(QNA=
P_MCU_TIMEOUT_MS))) {
> >>> +		dev_err(&mcu->serdev->dev, "Command timeout\n");
> >>> +		ret =3D -ETIMEDOUT;
> >>> +	} else {
> >>> +		u8 crc =3D qnap_mcu_csum(rx, reply_data_size);
> >> Here `rx` is still not initialized.
> > The MCU works in a way that a sent command always causes "reply_data_si=
ze"
> > bytes to be returned.
> >
> > So for each qnap_mcu_write() above we know that this amount of bytes has
> > been returned (and thus written into rx) if the completion above finish=
es
> > sucessfully.
> >
> > "rx" is assigned to reply->data above (same as the expected received si=
ze).
> > When characters are received on the serial line, this will trigger
> > qnap_mcu_receive_buf() from the serdev and thus fill those elements in =
rx.
> >
> > So if we land at the qnap_mcu_csum() call, we do have received the expe=
cted
> > amount of bytes from the serdev and thus rx is filled accordingly.
> >
> > If we don't receive the needed amount of bytes, we end up in the timeout
> > above that.
> >
> > What did I miss?
> Sorry, my fault. I missed the essential part of the external event (exter=
nal
> for this function that is).
> Thanks for explaining.

no worries :-) .

The more eyes, the better.

Heiko



