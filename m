Return-Path: <linux-iio+bounces-8064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3E7941463
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE4E28218E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540B21A2553;
	Tue, 30 Jul 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dekimo.com header.i=@dekimo.com header.b="NYENibeb"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021074.outbound.protection.outlook.com [52.101.65.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A21A2542
	for <linux-iio@vger.kernel.org>; Tue, 30 Jul 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349771; cv=fail; b=SuvlsmU6ct/Z0tigmeKMSR2vCdrVaQyxpvgwxm5JIdPau+3T48g+N5xSOIhEx5MMml7AsSAbJL388JXjOK7cGqbF5g9xC39jw8JTdW9V7SoWt26tuq1ac7b0LicQCACNPDU5DlkA/g1tbr6DOsEwN699Um1Wchk9ihpWiK+QGXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349771; c=relaxed/simple;
	bh=ZcU6ySR6W0r6iiIVXD/y2VnpFfXMLSDqUJjxsoQk8jQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Nw2teq3AJHuursn5TQirymO6Eztrn/UtErxW9m5PBExIgtWaCW7IGOS9BVY8BjOIHJUFmQ1duCundnIDUMrgwrpOxY3vnFu4rKE5DSHc4voy3RhbTqDyp+i1y1Ta7gdcsuprMWZIDHr+Tn0rNsIunn3fY8/1Iw9+1rM0u6A8Dpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dekimo.com; spf=pass smtp.mailfrom=dekimo.com; dkim=pass (1024-bit key) header.d=dekimo.com header.i=@dekimo.com header.b=NYENibeb; arc=fail smtp.client-ip=52.101.65.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dekimo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dekimo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSY8ZjgXeCFedoPtuk4CoBOdaK53TpJMmUx4WYijONfTL98EGdZtMV4ni6CwopPtI77NzCZFLovIt8KIUtiMSS9fVh1lmMWZrt4XeCEQryahIDqibxVdJ4N9eb0rP2kNSqGgtjxoT/GYbJp7hQs1trJsviYrR1QT3oagYR84XK1x7+LY8K60KFWVKKV/tTZHz6YdA39vn7HeTjmKVXmq7XLtScsXwfxPh9pRyG35pLvCu2igXMTM3O0tv+xgq2vY2+lU3/Z8ZNXDh2LSitSd43j789XC3g9ZxmcoONiXv4S8EocHPYqEm4H1pY0WWLtUuFeCMw2fEDg+RDvBs9qJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l0zb+4ezD5blsQogE1eHbtMow8XVXIbdpqmJU2Vacs=;
 b=uw1pXB39cDvBCjyhdoj+KsUMT38M0AWQnOABywuxf7u+tRZDbPh/0OxEFP0ZY02LYFvPY56J04DlgmEyxiP3RhF8vRJPW/EWLIbxtRlmnAefVf7fAi6tCeRIWIr9C61iDWUcgs/FoD3x3TZC3pX7c8VVMxA5fQpFuwg0/PvI6RdChq8+c0zUCGMgEcdM0daflb/0eyjlxoAcSrriXrVxisfEEl9QC5IRFDnqL66DqZcmnjnyiKWmkutuVdZlZc5PHMrrPC9N2Ak6pNfwGnfl+oJapDggrtfovb7IV9Ptr1G2KzyI0ryqR0zUBQJrHekw7J5kEyCZSQ2qD8dNfqls9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dekimo.com; dmarc=pass action=none header.from=dekimo.com;
 dkim=pass header.d=dekimo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dekimo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l0zb+4ezD5blsQogE1eHbtMow8XVXIbdpqmJU2Vacs=;
 b=NYENibeb5dsOc1+gAfBB5KD3g96rCTrtUOoUuL6qdNiy5YRQne9mw0Y2NY+D7gK/mYgZ27H0IGcFtvRJNhjxnm8sPleE2HpkQBEQYDs9ZEByJQ6qSDLNqI1ajsCIdFBed15gCCr6pLYFybGY98Ht9IwAQg8mIoJowueb1TJIQnM=
Received: from DBBPR04MB7915.eurprd04.prod.outlook.com (2603:10a6:10:1ea::20)
 by AM7PR04MB6949.eurprd04.prod.outlook.com (2603:10a6:20b:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 14:29:24 +0000
Received: from DBBPR04MB7915.eurprd04.prod.outlook.com
 ([fe80::a9f9:8917:cf3a:501b]) by DBBPR04MB7915.eurprd04.prod.outlook.com
 ([fe80::a9f9:8917:cf3a:501b%7]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:29:24 +0000
From: Arnout Diels <Arnout.Diels@dekimo.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "honda@mechatrax.com" <honda@mechatrax.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>
Subject: iio: adc: ad_sigma_delta:  IRQ issue in conjunction with IMX gpio
 hardware
Thread-Topic: iio: adc: ad_sigma_delta:  IRQ issue in conjunction with IMX
 gpio hardware
Thread-Index: AdrijLBWHpNAiXkwSOK1ujHosVAuUA==
Date: Tue, 30 Jul 2024 14:29:24 +0000
Message-ID:
 <DBBPR04MB79150A4614B6957A759EC31EFEB02@DBBPR04MB7915.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dekimo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7915:EE_|AM7PR04MB6949:EE_
x-ms-office365-filtering-correlation-id: 60524e2d-1a75-411a-f1b0-08dcb0a402b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dqBd/SKtftg3f1SugOtO/0Fl1mf/FL8ZgQpdgH9cjoNZ1e/Qqm5p0L2LdtAZ?=
 =?us-ascii?Q?Q8A2FLeIRvSCie9ySQIcuSAxrHW+xtlMavRRm+2uDpoESL2Qsm5x+Xr8mCbP?=
 =?us-ascii?Q?hCruxAYkolPLG3yyZ53XHKfNnYrBvaTL+zowtHT+GDnfF7suVEt7o8eCEAal?=
 =?us-ascii?Q?wwRxBznFLjOadJXDZAoaGiF4sIyPy0XAlPX8nf3TVyG+9VhsN8ErMplZFhJV?=
 =?us-ascii?Q?7yWFeHLF0yDsazwQ+tCTlbvsIml85+ByU3zWZ/Ft+b4D+tLyq1cAG4inrLMi?=
 =?us-ascii?Q?QzGTtzvxw1ZD+jBZ73wjUtQaseDMweBXzw4mkPs38JAjQlRqkPxB8fj88uY7?=
 =?us-ascii?Q?cfx77cqQr0cXkW4KiRMCTpL7vF9TIZ12uu2k3NO6jc+WMihqU5ZL5N4SK34b?=
 =?us-ascii?Q?UACAgRfOUwSmNWYjd2Ya76C1q+jN4TJqEuQSlj1KCBtXJTedNunujogDSQuW?=
 =?us-ascii?Q?S0KC4eZ06jj7Rpytrquxa+D0GGz/qoq6ebaZtW9osB7iJcSZc4lMqFR7fjVE?=
 =?us-ascii?Q?lTnjJmlGGGlhZg3FDzOnQ+KGQyg1xGHverwfovXcZdbfcRLM09ttrdXl1Eu2?=
 =?us-ascii?Q?l/NWvOJ/a9tK9p19cdT+1e1fVCX2NbpMAjeM459SH4IJ4fcGGCdhJDNk5KSQ?=
 =?us-ascii?Q?sSg3m6NjEjfYhPUaffOySAH4gQRABrs7InwriwfeT7ckpYyvaSrQtYW+Fe3N?=
 =?us-ascii?Q?iibK8eMzzSSoNk0TsAgWh9+g1R+4HibBqMXC3qyLv5YO92hS6FvPMvohjTBF?=
 =?us-ascii?Q?2ZyF9m8KfYZ/TrpGOX9fdvxLSWiI+jhuFQgMVP74NuGQFk0RM1TgxpOFckNG?=
 =?us-ascii?Q?RbmYcYNrv9y+MKTXq1AMnQYZ4Xj8SZZKG+yOGEC86Dlt9VoZOSKRSY8NtozI?=
 =?us-ascii?Q?c9MAnUpIvOLYc1WT5GzOju3xQJFnMBYMMGDPstHS3kXlILFJprHHDnt8k4SX?=
 =?us-ascii?Q?8fa2P6zisWTDUVRtHNnx5WhV325w+mfPHGAnnn7GP4cfKFysdaZzYfTMPGfZ?=
 =?us-ascii?Q?KNbbYOlPf4hRKK5D764rTW9u3pnJMKKqaxIlWXIc5Dz36Ah4NOX/8+WzF6tM?=
 =?us-ascii?Q?q+2zPkZJ79Axc5nSMZv8BX4/cPd4FHsjYocTUtKDqJHk4uVlRFoR1qoV10tN?=
 =?us-ascii?Q?zea7ULAN9cu7PhSuYcR9WxkfLcExmeUnMRyuvy2vPKdFNd9KZFYfCuucvvrE?=
 =?us-ascii?Q?JPaSeJb/lKkTvfOV56ROTyVP6jbs+Joo+Dz1H5wvlsKsggw4O5EX+pdEQavh?=
 =?us-ascii?Q?ysCkAkj2sne3AdUAS6CZYuBejnXJvb0f0bvRd5a3WtiuHsVsOjhr+vMufRj0?=
 =?us-ascii?Q?waRvTm7F89F9H+78TkrLRx2re4omHpm0SmAF349y75sVSCBjTBsHD0q8yW4s?=
 =?us-ascii?Q?0HYPvhA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7915.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NSH5P33oODy+71z5HO15Eg80cesUXX7Npxix3HMyly631jjbTon1X/DI2PuM?=
 =?us-ascii?Q?YoWVA+YceObZdx0qcy50RLqmqlz2EeMIQY2aA5HBZ2HstlHyNGKkBFXWG5uJ?=
 =?us-ascii?Q?AbnYFdHR+JP+av+Bx31XORXKVNEakFxtNV7zAi+2zZKTKCWzd6/CcaiJWCj0?=
 =?us-ascii?Q?y4j9UxmnWgx4Zhwm121jEVCLfsVKBEbJ1dzILR70j0BaAOa5RkNqZmF5SEDp?=
 =?us-ascii?Q?pO9kRCm68gBpOwul3NPdOLsnhFVFEeKRmJCX5Xq/Hkb+wDg3YmXKafHtab7T?=
 =?us-ascii?Q?v27aj8f0UQJvnPNkdCqhee2rcwMmCcN34TE1rn22EfQK83/XjOrnnUpCokSv?=
 =?us-ascii?Q?OzDohx+YKhvLPOhUT9xapC9nmHZArE8kMoRcztGo/rzyeU+tFSLygbAsxClI?=
 =?us-ascii?Q?EWVQzlzrmtFnTwjNqGA4W+Mw8cpw3ohyEymiXv0G4tKArLQU+dQbFd37CbmF?=
 =?us-ascii?Q?3BJU1LiA3gMrIp9hiS1ZoYv5C0X/KsXoZsy7wOysk9SFbVompSNBjFbrDSPq?=
 =?us-ascii?Q?BlriErz1eYJZHDM4/q044gAww4AfsDucs3stLGEYRqplX4oONUc9M3gVA9tO?=
 =?us-ascii?Q?a3q/QmE3kpCv0IsOcGajhFAjECLgO//Cqu83jOcGyWAkIOR0JQfZ/f4/Fl/i?=
 =?us-ascii?Q?dmHIz6rG1/7ieGPX+ImNOl50mLTsACpA7LCvieyrYaOzll7xeJ1Ox+7A4ufA?=
 =?us-ascii?Q?zjnmdldk3DxN8dXi6S6bjStL5BAJL95Vmr1cRw1+gocPWVGueanm6gdF/8Jh?=
 =?us-ascii?Q?vlxoJdq/9fej/BuvE6WH/bhEY+35lpsqmI7SDmYi0R3g6C6ys2wd71NYa0s2?=
 =?us-ascii?Q?9/QKLPloxroAgtik4xfReQqDrzIF3jmP3kHWTNvqa5cJVq93Vnoc48CR1Ghs?=
 =?us-ascii?Q?6X6ObVicZm0PizJ7Q1Iq8lOmNsDjtwxm3zG7yuwc5zRDPOWmVwLvzHhy5h2a?=
 =?us-ascii?Q?rp0YqAjgB+Tyltc8vfUI0Jh/ypM4qBS6fE19jraKD2aM/CZBsbLaES5WizcQ?=
 =?us-ascii?Q?VsRdXw5HRWL0egXfMULn+Gu88Dhgcwynx0c7sLJBXqbvROCSwCr4z3zdbTmi?=
 =?us-ascii?Q?CIA1FOSR8FVnVZ35rc19uTBPrVCCeSwfO7uAtd0DFGH5+6OcWZsTbVSkkoJn?=
 =?us-ascii?Q?wBJkQUgkJqzsgQ58Ww7ettZ47jOeQ/PjV80qesQ6p8jVThyNOZqfXTPERC1l?=
 =?us-ascii?Q?4i9XhueBj4Jr0HfatSjCyaKlRCmShJzc2JoBAnfodkoCb+vcA8lCaNKxeeeN?=
 =?us-ascii?Q?EtFP0rpIWvle93mmwNfZXxdYSlyZ6YtYA+2qbNtRJ94ep0h0VNpToThV0D7v?=
 =?us-ascii?Q?ycLxcdBCEaBt6j+wkjMl3tfXWUXE6dbAXI+j4I4TBK24M2QKxVOUJyZwDrBa?=
 =?us-ascii?Q?WBD3gb8HbpRDgZvp6s+w3kJsVB0OjK6Ap6iRBAj4mod4kBeArGxAQCf3rXr2?=
 =?us-ascii?Q?PcTIhYg1YHS7KQLXOXyEgAxGWluDls2pEx+qg2vxcch5yIwfuAfkE8zG2MTi?=
 =?us-ascii?Q?87cpbDGWZqw6Gsa4ps2ZCmGsmgbWOBM78Cvw3BxP1RppTY29sjqjZ+VuVItG?=
 =?us-ascii?Q?1WhqoJCCmgeXeG4lhZv9Af72xO8bdjp/EDhDAQCi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60524e2d-1a75-411a-f1b0-08dcb0a402b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 14:29:24.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 64c47e2c-9101-4dd0-9d5d-294d60d9e247
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oG7xkPFQ0fXyAzzYt8YTgG9wKwzlPvki2URS66tSWp67H6F3VIg2sPAYHuiz3cG6hb9GfMKUJdMuDtYMuEZ05A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6949

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
t can be done
But the second issue, is that on this pin, per definition, not just IRQ edg=
es will be visible, but also MISO data. The driver has to correctly "time" =
the enablement of the actual IRQ.

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


