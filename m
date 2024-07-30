Return-Path: <linux-iio+bounces-8065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF9294154C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8962F282968
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A041A2570;
	Tue, 30 Jul 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dekimo.com header.i=@dekimo.com header.b="MIyhtYJ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020106.outbound.protection.outlook.com [52.101.69.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099D1A2561
	for <linux-iio@vger.kernel.org>; Tue, 30 Jul 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352665; cv=fail; b=f1wbvehNWXmIK2GU1eFLm+m9rslHZdCnyez3D6chMranSrBAhKwg8KJnjRS1rqO/1f3Umti+toKSeKqxSCyfU4ZLT8QmpSvmmdwrNhJm3xLL/VCVT01WZSvI1Sx5JOmEXeT43yW/m+YhvwAo1kjBC5YnezG4IybqlDqqhuFClmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352665; c=relaxed/simple;
	bh=Jfzf2GnTdpzncBjY9vMJE33cpQAEJjc55IaiUPcuWKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6YoSRoIpu7yySp6FCVi1pRYZFsepXFe6/WE8xXnKu/15CMC6bEUYXgCi+25MNf7fzQbg8LAoZPYbs5SIoQtmC5dpfIu2UwQN8g227Y9IZFYllAkFiqj9s6lOTnC92q0e0dlcSrcZMUUYXzr9oWEbT6MzeaFEWgwDDSeSymKq+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dekimo.com; spf=pass smtp.mailfrom=dekimo.com; dkim=pass (1024-bit key) header.d=dekimo.com header.i=@dekimo.com header.b=MIyhtYJ/; arc=fail smtp.client-ip=52.101.69.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dekimo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dekimo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkmtUsvDsXbxhr4cBH79WlsXSNhpYCu6nlflsc8daCn2mjj0P1gO9DgwdegKVXq7FzBvGohpvyKsuRoXRm0OucKdCxxcIsLWAGUnUwhgJj2tF80cc24Fv9l4kKwxUL5wkl4PBOxqZS9VKCs3uBUV4Ih2VqGosV7SAn1zeTttKtQFTGBI6beswNAw4n3aY7SwApxHrPWIXwXQd8otSCU9Ul1xL/khWzPs65uXfjoukEA7c8FLKWUYB4PC7AFpjeBDDkFBFRzJ7K1fQvzT5F4tVJw5n2Sh9F76iy7FcDEu4RJ6ecquuiEQkPEfgHgSDmtYfyA/ktyZogB5Bu8maM7Vng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11tR7VQfZ6KR4D/7o7+YX2yXkwNLR+IEN6YUeKey3qI=;
 b=GwvXlz5jW2C0J/XKsoQX1ShvLd3us5DI70HWMXLt363wa0TfaTTdDgjkYOdkiBBdeQJQWk5YKvkfjyOTlRF/Z1PxYhqQy3/sm2J0vTXWo418IqG5iO4GtdjHxJ4OMkWfiDbHUWtbGiR6Lw+QEwvPH4aI5KVGiiIdbcnSQ7kRq3tDBAzWIjLq442ceBpPYDifo5kSdJxPYZEOoyM3NILgKwnEyShUlrb/7BntQUaEZpZAq7vJxsMjgZlo3NWVUKh1q6+voEc+8FgGYaqbg8Pf5Gwcs//IHdI7d4ImrjLVeURK3dCv9hSrQg3vQ2DVAHX8W0qW07UT6Mo4Mz6JoVFtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dekimo.com; dmarc=pass action=none header.from=dekimo.com;
 dkim=pass header.d=dekimo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dekimo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11tR7VQfZ6KR4D/7o7+YX2yXkwNLR+IEN6YUeKey3qI=;
 b=MIyhtYJ/kOY9SNNfLqXsK6jP5nhbvuBbbxbcLUlazxq6rQBsKod7eyLXbseEDFPSDsucwqccwrzgLfWHj3BTGm3Vemlh6nPdklPzka7Fh5J428ELBOc/ftWgUNsQ0UB9EAQJU8ZcZyOHVXo0SVKkYJBpvbdlX/gNluYIpPYT+sA=
Received: from DBBPR04MB7915.eurprd04.prod.outlook.com (2603:10a6:10:1ea::20)
 by GVXPR04MB10429.eurprd04.prod.outlook.com (2603:10a6:150:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Tue, 30 Jul
 2024 15:17:36 +0000
Received: from DBBPR04MB7915.eurprd04.prod.outlook.com
 ([fe80::a9f9:8917:cf3a:501b]) by DBBPR04MB7915.eurprd04.prod.outlook.com
 ([fe80::a9f9:8917:cf3a:501b%7]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 15:17:36 +0000
From: Arnout Diels <Arnout.Diels@dekimo.com>
To: Arnout Diels <Arnout.Diels@dekimo.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "honda@mechatrax.com" <honda@mechatrax.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>
Subject: RE: iio: adc: ad_sigma_delta:  IRQ issue in conjunction with IMX gpio
 hardware
Thread-Topic: iio: adc: ad_sigma_delta:  IRQ issue in conjunction with IMX
 gpio hardware
Thread-Index: AdrijLBWHpNAiXkwSOK1ujHosVAuUAABnAmA
Date: Tue, 30 Jul 2024 15:17:36 +0000
Message-ID:
 <DBBPR04MB7915EA1E74A0313181A66E0CFEB02@DBBPR04MB7915.eurprd04.prod.outlook.com>
References:
 <DBBPR04MB79150A4614B6957A759EC31EFEB02@DBBPR04MB7915.eurprd04.prod.outlook.com>
In-Reply-To:
 <DBBPR04MB79150A4614B6957A759EC31EFEB02@DBBPR04MB7915.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dekimo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7915:EE_|GVXPR04MB10429:EE_
x-ms-office365-filtering-correlation-id: 21827142-1030-475c-c638-08dcb0aabe27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4ntj9pqFoDLN6j6sivMQMlBnTBu5zrn3K/6QmBZQ9ZRBGSY8v1fBcgx9X3Bm?=
 =?us-ascii?Q?n/E2nh798WdHEwjsPcSaHoANTBdqj1HJZLI+ZGWJ0bDJOFTA193KqKJKMKBb?=
 =?us-ascii?Q?dGn03GURxaE4h5d9GzSKFT8WJLGR9U9gRCB02ZcrubjnH+9kgG0ncyQb520m?=
 =?us-ascii?Q?y3PMTMsMNA5ooSklxbp279liTrFplIR47/HFEMs2fyuDB0/N1m4y+gI5+PoV?=
 =?us-ascii?Q?aQIY5EgwtjIVoOHE4B3/uvfBqYcYFKbqtqrcBfb49pfZP2OIOSNtcYrKHiGC?=
 =?us-ascii?Q?szaRjgGma9R/vSER92wxyhT7MiqbRDSVpRyp0ZYxXuOFieBg7nsv3aghhxdK?=
 =?us-ascii?Q?IP+bJmHelfnEU4GFaLscQqvt/iHVGNwVNELLjeGPX1hefccZkXE40CwKeLaZ?=
 =?us-ascii?Q?w+ZEd0h17MkjuuHFrN50zYPjTS5iE7jWlI8a777ci7swR59h0ck0Uu30P34/?=
 =?us-ascii?Q?J7IKI9M49Zxx4aeChSEnM76YWb0X0coJgYIYAUY2NKx7ZwQXixoj/6eJ4GmQ?=
 =?us-ascii?Q?SAT+J7YZn0WjTjvmqvHBx1DCGq/MAh1m2SG8Iw5+iW9CTjql3HcUKqdrJxQe?=
 =?us-ascii?Q?AOmvd4Ck8IOGOVzOldXcRisfRiMvp/NHDBZQWpuNncOiGRC+EMmbfM+Z1Yke?=
 =?us-ascii?Q?Dk2bDb4+KvkFS/dBEJda8oL8m446L1nll14nTsXvF+6LjDjXE6KaQMoxFlti?=
 =?us-ascii?Q?tH6FZAxKJdz4qCgS8eJCRIOGcRqyyF2rY7VL3x5FHfnMj2ZL5QQSovOsH1ce?=
 =?us-ascii?Q?PHC0ojb9Hft3OPE0lzXNYvmw1fGb6IuOSW99ed5moXzaQ9gwgct0/CD0aEhe?=
 =?us-ascii?Q?BORuG/z5qw4EJJrPkkDqlWaX0uTuvhFqV5aiuKEBSIqRfd5g1Z6L6Os7AdqR?=
 =?us-ascii?Q?2/hQqBX44zbY8cJEXSF7d32XPxls/yjNyofLxE8vO1Je3fFY/uU/yW5toKJD?=
 =?us-ascii?Q?ht82rOMF+FJeL0wsi6I5RUWIUj4F4lBDIv3Rf0SDYCPQuqOwJ+VpVPAXQbfA?=
 =?us-ascii?Q?Tfu+Yv2LlDfb1eHl99c0C7PXvQYzQ+gfb9zFRLj3pPmYNKBbpXDNRSzoZj4B?=
 =?us-ascii?Q?unDSD8YLMmvYMY1ZREOyye2AX5qoBSxyJ65Zh/vPjjee7pXwCUY5NtSgKWYw?=
 =?us-ascii?Q?Tw4txJrV208eiTp/yEqxXwgLoSP1V7QgmTm+lwZlptQCK9/IbtjKgkUKlQPj?=
 =?us-ascii?Q?a5WeUKj12fDqm2N0TzP63ReJvIiyV6PBJz5ABUmtaJ61d1zoughRSRh7jZVm?=
 =?us-ascii?Q?/PJy8jM91VYOL/STcGm3PTwERbv04Q32lVJjM02SdN2azioDGQSMYj24GCQs?=
 =?us-ascii?Q?SovBKNVZQewhqgGwKOkhnz9XF20GxdFAcyqmyIosgGe3kWYfOtrkSXU/UF3F?=
 =?us-ascii?Q?pZTIm7c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7915.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xSu7jQ+fP9e8umAhe7iA3a24z8G8chEtpFVpLtFzYXCXqA3vzVoWdMMg+tJI?=
 =?us-ascii?Q?RPyNrbd+OpxPtnUszWk5cTXeRRE4JpWuFTrZt17wIo38UxAK5DCQ6hv/jlX3?=
 =?us-ascii?Q?A636X1i+DE0MM5QM/5Lt07X7/cDk3UfkeiBafZdK1duyyMXgb7K3S2rJCCgy?=
 =?us-ascii?Q?sT1oTGPwzcM7rtKQFvLi7dQFPvIZ31lT2XKnfJZdfzkE5VKNDxPnB7jgKnwg?=
 =?us-ascii?Q?OmKDqNouXtIaQY+PYkdr9ckitN1fhP7vUpyeZ7mrfg+w7swT3SfokhyUEOE2?=
 =?us-ascii?Q?grjYIL7/ozzJ6d1U0XltEdkLRmdYZIq1Xu53LsO2GTyUGWJRS9cKsxg9OBF8?=
 =?us-ascii?Q?7CKSWtcoyMBGnJnJdnEheJmWmX0W6NAnc1u+Z7ZAS//Kzf3avig8QFQ/ojl8?=
 =?us-ascii?Q?5jHRPn9i2Up3pcTuPVsM50+RZ9nleGKVjCOvSDvuCy0Av5esesKOniRcNTiJ?=
 =?us-ascii?Q?eN1Pi2kZfwMzCTQWEXm0xVL9Fx4mx8WL2DQU/8YBBaPePWHsAuEORz+VNapT?=
 =?us-ascii?Q?/VxPNiOgvzuB5vs29ZtltPocoj74j4MVwLV7PUNys2aAJZfQlv1gJNjly6qm?=
 =?us-ascii?Q?NUYMMRrzLv/mVIHxYYomF4zR1PAAb1r+NrGottpeybHDlKjFygLMUsZfc7QD?=
 =?us-ascii?Q?cUtquN4n/r6JrKCXTk3AlSVMBZbANgq5WQsEF6hfrOgIrLgn+bcSt7kZD/Lx?=
 =?us-ascii?Q?IKEzlfpTj+PujuHzqYX9ZNTNtO9PklcP7D5YOt86btZrWk4Nnw1421Npf9gk?=
 =?us-ascii?Q?1BxBkIVhNNtvtGwIamm/Bx0k3K2EA9V8m+7JdxDqs5b8Q5RX0Nu6uo3M7rce?=
 =?us-ascii?Q?aAltlGZdIxcxRmme4DSD5PuMDTmnDc2iL1A+zVTjEmXMtK2UETJTgE/jGgfC?=
 =?us-ascii?Q?7hviXIQT8kHixhYkS8ngaj5hk08xRI6RT9dYhzuA9Qnzx64X2Mk9/4mOyV3D?=
 =?us-ascii?Q?dW0XwBzdrVeKthBzJHHaiRkh8Zle6Mz2XHTrGi3O28fitQGc2x9IkAo9WiaZ?=
 =?us-ascii?Q?bJai2QnKjLn0DbWSxrUPCZaeQ5TFUoWtKXviLJ2X/KrdTSuZXu1DGYeCI+Fw?=
 =?us-ascii?Q?jt3sQXNlIqsU8NkZPzfpVAQfvqQBljYXiz6mlQF+tuzwX0YwK5CGsqdwjfTP?=
 =?us-ascii?Q?vftkzTtw7q3XHSPofKITa2Eaeh0UDMUh1hnfb6T90F8y7nwt3OBxpI6RJ85K?=
 =?us-ascii?Q?4CyyPBmr7jHBatfLSHdUwxH2s0i48/MqpuU7Qy5GaUzr8r3zSpdYcJujEC7e?=
 =?us-ascii?Q?n4XcOoM/J+dlLOkKx2EcIUBZeHGR5wKwcL5CqR5WWfGtwyZeRjDCrKFP1d/e?=
 =?us-ascii?Q?Esy8orGjMz+NfDF7YTjjqgXQr9hcQo6UkmO8waoeT7HQDF2OsSlxu7lzMaft?=
 =?us-ascii?Q?7dQJV2+6jouYe19aA2nnH/b2ATpZY/A1GOlzchGpXypbyzxJWzt5CSY+C+jS?=
 =?us-ascii?Q?dpiVT8Pox8e5yc4R1Kk5StoPfP2K4jPmtqrm5of4GkBx6MRTw0PBv9jiOxLp?=
 =?us-ascii?Q?5VkPY4zD28rvWbBv7COxY69QnRzOIn5DVLWbikVaT7wxlUp0AFJLSKknKGEM?=
 =?us-ascii?Q?+poSzcmTb/Zj4Hrdw5n7Izowx17ykglx30dzUh0b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dekimo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7915.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21827142-1030-475c-c638-08dcb0aabe27
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 15:17:36.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 64c47e2c-9101-4dd0-9d5d-294d60d9e247
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0QOdmneC73oWfH6UtdarmqNNGWpjhkUMOtRCCn/p4G6ecmIPmhdmguFgeyTn0SPG/TPAUyIYG2IFysE7e/log==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10429

And perhaps as a followup, I have a working "fix" implemted currently by ba=
sically calling irq_ack just before the irq_enable (to clear any pending tr=
ansitions, which were queued in hardware.=20
But since this involves making a new function in irq/manage.c, I wonder if =
this is at all the correct way to handle these "queues".=20
Fundamentally this comes back to what assumptions can be made when using en=
able_irq and friends on queued HW interrupts.

-----Original Message-----
From: Arnout Diels <Arnout.Diels@dekimo.com>=20
Sent: Tuesday, 30 July 2024 16:29
To: linux-iio@vger.kernel.org
Cc: honda@mechatrax.com; Jonathan.Cameron@huawei.com
Subject: iio: adc: ad_sigma_delta: IRQ issue in conjunction with IMX gpio h=
ardware

Hello,

I have a remark regarding ad_sigma_delta's IRQ implementation, especially i=
n conjunction with gpio chips that do no support disabling IRQ, but do supp=
ort masking them on a HW level.


Specifically I was trying to bring up a ad7192 chip on an IMX8 platform. Th=
e IMX8 gpio driver (gpio-msc) does not implement interrupt disabling.
I was the same issue as others have seen, namelijk that when doing single A=
DC measurments, the values are stale, because the driver does not wait corr=
ectly for the IRQ to come through.
The fact that this chip muxes an IRQ line with an SPI MISO line is the fund=
amental cause of all trouble.=20

For one, this requires hardware designers to typically route the pin to two=
 MCU peripherals (an SPI pin and a GPIO pin - to avoid having to support bo=
th gpio interrupts and doing SPI transactions on the same pin). But ok, tha=
t can be done But the second issue, is that on this pin, per definition, no=
t just IRQ edges will be visible, but also MISO data. The driver has to cor=
rectly "time" the enablement of the actual IRQ.

The ad_sigma_delta driver .. does this, but it can only do so much, if the =
underlying subsystem is limited.

Practically, in case of the IMX8, the *hardware* supports falling-edge dete=
ction, which is needed and I configured correctly. If this is detetected, t=
his then always calls <handle_level_irq>.
The *AD driver* tries to disable and enable IRQ at the right moments using =
<disable_irq_nosync> and <enable_irq>.

But, when reading some single values from sysfs for example, triggering <ad=
_sigma_delta_single_conversion>, the following scenario plays out:

- The first time everything goes well:=20
  > SPI command to start sampling
  > IRQ enabled (HW unmasked to look for falling edges), to wait for conver=
sion finished result muxed on nRDY/MISO pin
  > Falling edge occurs and irq is done, breaking a waiting loop
    > During the callback, the interrupt is disabled again.=20

  > SPi command is sent to read out the data


But, during the readout command, things go wrong.=20
Since the hardware -cannot- be disabled, it WILL see another falling edge a=
t this point. In fact mulitple during that MISO readout.
What happens then, depends on other settings. Assuming lazy interrupt disab=
ling is used, this will actually first trigger another interrupt, which the=
n masks future interrupts on a HW level. (Or, this masking is already done =
sooner).
However, crucially, MASKING interrupts on a HW level QUEUES them. The subse=
quent falling edges on the masked hardware will set a bit in the registers,=
 and cause the issue the NEXT readout.

What then happens on the next readout, is that, when the IRQ is again enabl=
ed, it fires IMMEDIATELY (since the previous falling edge was still 'queued=
' in hardware).=20

(This then leads to the waiting loop to break too soon, and a stale value t=
o be returned)

=20

----

The proper way to deal with this, would be to (optionally) -clear- any HW-s=
aved value when enabling the IRQ. (Or wait a while to "flush" it out as a l=
ess elegant solution)

What I find strange is that that seemingly the same issue is supposedly rep=
orted to be fixed last year (https://github.com/torvalds/linux/commit/626d3=
12028bec44209d0ecd5beaa9b1aa8945f7d).=20
However, the "fix" here was to disable lazy IRQ. This does not fix anything=
 when using the IMX8 gpiochip, since this will just mask the HW upfront, ra=
ther than waiting another IRQ cycle first.



I'd love to hear your thoughts on this.=20

Kind regards,
Arnout



