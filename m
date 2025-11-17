Return-Path: <linux-iio+bounces-26269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24557C65240
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 17:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2896428ADF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872BF2C15B1;
	Mon, 17 Nov 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=spektradresdende.onmicrosoft.com header.i=@spektradresdende.onmicrosoft.com header.b="fkkXOmqY";
	dkim=pass (2048-bit key) header.d=spektra-dresden.de header.i=@spektra-dresden.de header.b="SmlQhcuH";
	dkim=pass (2048-bit key) header.d=mail-dkim-eu-central-1.prod.hydra.sophos.com header.i=@mail-dkim-eu-central-1.prod.hydra.sophos.com header.b="F34e3l8H"
X-Original-To: linux-iio@vger.kernel.org
Received: from ix-euc1.prod.hydra.sophos.com (ix-euc1.prod.hydra.sophos.com [94.140.18.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EB2D192B
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.140.18.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396958; cv=fail; b=Y7C0K98Bk3OOrpdidDnFR5xyJJyckG7dKab+iUW8O5iltwZ87Tfjm5yKDbLQJ0ddG0o/6ny2qwiIKEeJSB3FT7LFWGus3IKfULUXGlxUNuRqpO+o+rc3dteoQgsOUCFhHsu+cYjZJVRW5uZ6e4F/Vn71YSAVxdV/upmToY4T3OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396958; c=relaxed/simple;
	bh=pEdR21DYcaK9ahK/hmGsJON7hKI0XBT56c6fdCHDS8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SKuYN9XWZv+9H9aDnr5UqXAuPoZcw2mjXRdsvRKENn6SP/Bmm5lLTZI+X/DZwdqvUOtQILIGAH5jthp2WtuI8gV2YEV1bGc+8GBavCjoENC/nfdhuP4Jj4bLmDC8FppAItQSAc31EeVRC0ve2w3+v5mk7BQbxERCgxZOKeMfzsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spektra-dresden.de; spf=pass smtp.mailfrom=spektra-dresden.de; dkim=fail (0-bit key) header.d=spektradresdende.onmicrosoft.com header.i=@spektradresdende.onmicrosoft.com header.b=fkkXOmqY reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=spektra-dresden.de header.i=@spektra-dresden.de header.b=SmlQhcuH; dkim=pass (2048-bit key) header.d=mail-dkim-eu-central-1.prod.hydra.sophos.com header.i=@mail-dkim-eu-central-1.prod.hydra.sophos.com header.b=F34e3l8H; arc=fail smtp.client-ip=94.140.18.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spektra-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spektra-dresden.de
Received: from id-euc1.prod.hydra.sophos.com (ip-172-20-0-45.eu-central-1.compute.internal [172.20.0.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ix-euc1.prod.hydra.sophos.com (Postfix) with ESMTPS id 4d9Cjr5W08z3Rm
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 16:24:00 +0000 (UTC)
Received: from ip-172-20-0-23.eu-central-1.compute.internal (ip-172-20-0-23.eu-central-1.compute.internal [127.0.0.1])
	by id-euc1.prod.hydra.sophos.com (Postfix) with ESMTP id 4d9Cjj025Cz1xnp
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 16:23:53 +0000 (UTC)
X-Sophos-Product-Type: Gateway
X-Sophos-Email-ID: 28305d17380a44b78bc65c041e0ead17
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023100.outbound.protection.outlook.com
 [40.107.159.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by relay-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4d9Cjg3n4Kz1xmy; Mon, 17 Nov 2025 16:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkWaUdI00DgrCZVP0aSLQulHMPmAMwOc0ueHyrqYhtMH+YEePhlC0VprcVU0rJRK8nkHH611roJPjeSkzz84C+BxTBUuXQJoZt2Qi1tnBmZmz0YCBQYTn5jIDma3AQcUHrKAl1etYgUsi4Bdo+wi1xX+ecrMe4sPODsc7wibPnwIHch26os4hl5+aoSjcyhER2ZvDAQx0KjLX+5fKEuoTGChZKZD7niTypVwZbLz4+naAyWOGoyzJQyhT7ey2i3hDqNltw9RBWoWV0iMUrMS/zfA/rzQbIygR8J3lX9ffNl2J5PXoaORC4r4BVbF4us5m0cSy0o+O58JaJsSzRMUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEdR21DYcaK9ahK/hmGsJON7hKI0XBT56c6fdCHDS8o=;
 b=pQxNGyFqRJcV930w9dx2L6YqTbpXqgAHHtHw8ajqyBFg9ejeBXvXn8W5ssjLb14hrey7k0DSTsRVPq3BlDb75Bz17utYcxFGEVxFHQrA3dlQIvIdtgky8IfoNCEqOWT3Xg9km+/GaOMwr8FVNYCwK3CYHM7MBMBca/WLosO74rKAKF/wB8F8t0Pl2NI+/ghikB+cmfsGlxjpSTT+hPCJiIZxTJLQ5iPUU+LKa6rCORezf11LClT+/HgyfSkAmqlTY24MYYnHjVfd0A0jDysybDZeeewoFSPX0DWjtwqeu3vR21ai2ac2KzwbXYwgPxwDl/Is6uVJSYovSpqWAaC4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=spektra-dresden.de; dmarc=pass action=none
 header.from=spektra-dresden.de; dkim=pass header.d=spektra-dresden.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=spektradresdende.onmicrosoft.com;
 s=selector1-spektradresdende-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEdR21DYcaK9ahK/hmGsJON7hKI0XBT56c6fdCHDS8o=;
 b=fkkXOmqYpwZ7XQQi+A/nhx0uWCXeL4Qfk1fg9FlLyEYZOCySQ/npMfp8Xaese2IBPJM5u2PAECizQ6Bb80txs1zjPwwriWZo9PFUOxmm8mLhk6nCK1OC4klUdvj6QQjrXlsLSfvhiB13ST+RBj4HjsdKGsDkP/wOGG5+TkAkeOM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763396627; 
 s=sophosd47ca55e60634ddf88e33a41e9d317ef; d=spektra-dresden.de;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=pEdR21DYcaK9ahK/hmGsJON7hKI0XBT56c6fdCHDS8o=;
 b=SmlQhcuHmmSLBZ68/Kc9+gSexBVxvrLsRNI16Y8y7urYsG/0yyoXASexqyBmzjly
 TqJOEONJEjcjsHuBAcmJUC1UYo74kf4cdoXwxZu78mlYophUcVA2w1xzhFUJeGF+rR1
 rw5/Ohnay9598Z6f37r6NWAfRwNycGrBcX7Azj+IaYvXbCVU1bHcOkM9qZm9SCzrKG9
 HE1onNoVoeq1OVMCujmsLPHBYlDsuEWKAtlO6vYVvtzejpbnBD+perZtKVyOakgnO1s
 vBmR9GWy0sW4LsrAMZ8kOxtRVkX2CjnRSxX3TZ9hSBX/YZmgDrCMh/4snysQi/VQl78
 7H2kbMi+zQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763396627; 
 s=v1; d=mail-dkim-eu-central-1.prod.hydra.sophos.com;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=pEdR21DYcaK9ahK/hmGsJON7hKI0XBT56c6fdCHDS8o=;
 b=F34e3l8HF0QzEzrgBK2xXkri3TTe+e0fThMqHcZyiqHQr2DiN/r9q4BN4Ptzw8Vg
 rRU0mv79CD7KNF9z69jYLg13gIi5vgOMT4jZ8NLm7cz7lLiq5o6AojnORMVRg1uW9ZB
 H/8/8CYXQ+hag28dIOZfqhrLpn3hc7Sb5FlGPJLRC/GcGe/hXi9EvFZT4P0ttLb5Yqm
 Z4LKsMMd1/TvzTIkArEqxIZlFbi26XvOOQBKJpV/XIOsjGDGezmnRAC48c7pllcwOO4
 P/2j90sJP1E6GGduhSUwkOy2Xa3abi5B4F0Vnj7GPWHSQm3CwPYkFjiirlV6s5fD/jH
 w9rf/HM/MA==
Received: from PAXPR09MB5040.eurprd09.prod.outlook.com (2603:10a6:102:133::7)
 by VI2PR09MB7572.eurprd09.prod.outlook.com (2603:10a6:800:22e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 16:23:47 +0000
Received: from PAXPR09MB5040.eurprd09.prod.outlook.com
 ([fe80::9607:5126:cfdb:6ecf]) by PAXPR09MB5040.eurprd09.prod.outlook.com
 ([fe80::9607:5126:cfdb:6ecf%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 16:23:47 +0000
From: =?utf-8?B?S8O8YnJpY2gsIEFuZHJlYXM=?=
 <andreas.kuebrich@spektra-dresden.de>
To: 'Jonathan Cameron' <jonathan.cameron@huawei.com>
CC: "'jic23@kernel.org'" <jic23@kernel.org>, "'linux-iio@vger.kernel.org'"
 <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl
Thread-Topic: [PATCH] iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl
Thread-Index: AdxXo+PhXUZmvITaTsKp4NFvoo0u5AANoNMAAADV+CA=
Date: Mon, 17 Nov 2025 16:23:47 +0000
Message-ID: <PAXPR09MB50402CA81386A6A999727729B4C9A@PAXPR09MB5040.eurprd09.prod.outlook.com>
References: <PAXPR09MB5040DBBE59B2BA98F1108581B4C9A@PAXPR09MB5040.eurprd09.prod.outlook.com>
 <20251117155406.000002af@huawei.com>
In-Reply-To: <20251117155406.000002af@huawei.com>
Accept-Language: de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=spektra-dresden.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR09MB5040:EE_|VI2PR09MB7572:EE_
x-ms-office365-filtering-correlation-id: 98e21268-6743-4b1a-f810-08de25f5af54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?YUFzbGgxdDkvMm43OTFaMDUvbFFsVk8vRmhFYUR4RVVFQzBnYzZZdFRMcGF5?=
 =?utf-8?B?L1ZHTGxQNXJRU055eVZFM1FqN0V1SXhDZ1I1MHhlSXZnZ3JqdkI3a09aamhr?=
 =?utf-8?B?cE5KdFgvY1JENkwxU3J1MDNKMW9iNmxZYkRJRkJ3MkdGTXdFQmJyM2NGaG0z?=
 =?utf-8?B?N01sN0MzbHZnL1Y2S1pEYzY0blRaN3hsY1k0dXQxY2NOaFRhWmdqUU1iK2ZF?=
 =?utf-8?B?cXlUdzNEMWJieUtRVWh1YkFKZ1NPa2ZxVTh1YUVJTUV2RDlhOEJVWnl5Yk5o?=
 =?utf-8?B?ZS8yZ09YQVVsdFNvcnlUY2h1d0MzMk4yS1dPdG5PNTl3RmR3UHpORVRnSktl?=
 =?utf-8?B?UDhvbEVwRTRiYlJFbm91TzZucW5FWnYycitYd3U4NytxSDcyMVVodzJuOE5C?=
 =?utf-8?B?TUtUNiswdi9ZeHF4S1NYdm1PMHFZbTFLa0NzWVY3dHNNREw1a0ZxZzFremRz?=
 =?utf-8?B?TlJldDFaeDZmcnRFc1VMMlJ0dGNtdVQycWd4K0wyZFpOQzlvU0syT1kyUWsr?=
 =?utf-8?B?Y0x3VS9Wd0ZKeGhURmNiRjRjS3lCMEd2R3l4R2srTUpjeHdLS09BV2VzRjA2?=
 =?utf-8?B?cUVOcC9MbTlrL0JIYnhGMEFPVElEeHRhSmRmWmV2bEpjbkhhVG5pV0xjc0tC?=
 =?utf-8?B?WkVYUDhiZ25waHJiUGp0aUJSY1ZOQ1hic3ZTL3R6YXpXMm4zWUFkVWN0MVBC?=
 =?utf-8?B?RnhZR0hsbXQ1RUtiWGYwOXBiT1VXU1F6MHlPeU1WU1V0bVpMd1RPbG1NSTE1?=
 =?utf-8?B?VDZXT3RXbG55eWFydXpWSjFDbHlYSW1EUlhLV3ZjNTMyT0tvekRWdEZtTHNR?=
 =?utf-8?B?VUc2RUREdm5BQS9WTGFERU5EeDM3TDRkK0tEempRUEI3SnNhMEkrb1BNQkcz?=
 =?utf-8?B?SDBUaFdMTTFUa1lBa015VjNwYlowMitjSFBhNXVBM3kxMmtBRHQ4NVB3QWM5?=
 =?utf-8?B?Q05iR1B4VU92SVJBczZ4ZXE1MFlPTmJJQzJacDh3K0JTNDFSTXpCWVJxcVRB?=
 =?utf-8?B?c3RYR0w4Tm5FM3JMQzA4OHBXOUhyc2loYmhscGpoTDVla1YwTEk4c1RjaGVV?=
 =?utf-8?B?cDNFbVo2TUJ4bTJKWUNRcFc2NmVuZnR6Z2RzbGNMbGRneFpxa2dPaUN4UDc4?=
 =?utf-8?B?Tk5rOEhPUVRjMitNQUVudjNHeTQya2VoaEpISkZHZ1B2T00xb1Nmc2h4ZzVp?=
 =?utf-8?B?a2V1eTJ1YkZCVG1nQ3BiVWRLUURmcVNJVXBuTkdIaTE2L2dJZ3A1cUtCUnc4?=
 =?utf-8?B?L1dUMVJRSys0ckhZSng3MzNLaUtPaWpvU2h0UWRhN3dTWkFGQnNUU3hNWHFt?=
 =?utf-8?B?T3pZbUdQOWFyWVR3dG9VM2ZkNjdPV0JETTV5RmRHbVI4cGhGbU5ySHdONUp0?=
 =?utf-8?B?TERWc3VJS256a242ak9ScGV2OVZOR1RqMzlQbXIwY0x0SmFLQmxLZFNHUzFv?=
 =?utf-8?B?WmkvRlowVWZxeStTOFoycHZ0ZXlzMCtoRUtpYWpFK1RkdzBVZ0xVQ0dXb1gw?=
 =?utf-8?B?YzdhVWI3ejVMbWxpS3FNQ2NKckdraUZwaFNOdEF4SVNwR3QrVUR2QW9GVVFI?=
 =?utf-8?B?OTNoNGdpNGtia2hGc3g2UVBWU3E0dHNVaVBxUytBb01TZ3lNR3lYS0E1QWt2?=
 =?utf-8?B?YUJDakkwZDFBZld0QkNRdHZLUFk2cVJYdGh4cStUYUVvbmpFUWYvc1ArMzlJ?=
 =?utf-8?B?RSt5S2wwSjV0cDR6aWVtRkRWRXFKcmFFU3BrRVB1eXgxSlF1UVk2TEpuOXND?=
 =?utf-8?B?TU5JeVBzT21OYWprcU5aMTdPcWc3VC8rTnlJUW92LzZUd3JEbTVYWEdJbkI2?=
 =?utf-8?B?c3ZPL1Z5VTdjd1FFc2F1TklWR2U3UVVIMWU0Qm02dnd2MWhIOXlySWRSNWp5?=
 =?utf-8?B?bUZYUTBVMWFEYXJKZDlXSUVUOFJkalJzMTlLc2VXOC9rQVBXMzJrT2NYNmdF?=
 =?utf-8?B?ZjVLUXk4ai9kSDNuZ0pqdzBrYWRGWkhYRisrUUpia3liVCtVKzg0YlE4TVNK?=
 =?utf-8?B?Yk1DbUh0U0xobG91bHlrOXpYNmM3V3ZjamFvL3l6MmdWNDZBTWRReVhYUWFL?=
 =?utf-8?B?MnhUUE1FYUViS2kydDFuZTZJcEJSQ3JwNUFmUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR09MB5040.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(1580799027); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czlRV052M2RQTWhhR1NEN3pJMkxlaktBRWJDN241clhuUDF1L3B5TmQ4dndr?=
 =?utf-8?B?WXJFc1RScWE5dm1Oc2U4Yy9NN1NjajlPNjhHcmJybUpESm9rUUkwR2RFd2Qw?=
 =?utf-8?B?RG01R1RYUjVvWDJjRFBrTnZ1ZTZub0Q0UWNPUkJSWmJHOUlBRllNdWtpWHVY?=
 =?utf-8?B?STVXZDZzaUd2cUthZ2xzSnZuUHV0dGN0RTh2ZVVkSWpNbGRxTjFkRlBydzBx?=
 =?utf-8?B?bzF3aWFKWEF6Z1cyLzlRREVacmNoM1VjaEttZmhQY24xUkM5SWFOSGRWV2k2?=
 =?utf-8?B?YmlrMHV5Zkh1STBjVW5oc1JZNDYwVDBXYXBrbHZpUkVWaGcvcDU3L0J6bmI5?=
 =?utf-8?B?c3RPQ2haQ1FyVEtwaVhUZEZ2dTdGZnkwbXVUMmxrNWxrOWcyTU05THQ2UDli?=
 =?utf-8?B?SkZBMGdrZStmV2VrWjltaTJxSk1VVWE1S0JYZkFCQm9zVG41TzhyK1JaaE9o?=
 =?utf-8?B?YWlFa01VTFhNNUZ4UW5HUXdramx0T05icnhkb256QmZ0dU9HUGFqZjY5L2dG?=
 =?utf-8?B?TkJIZ0dxYzdpUEp2aU10UStLMm1od0xLUldBeXpGS0tNVjFBdloyNjlLaDhI?=
 =?utf-8?B?UERTRWxYVGlEdHVuWWJ1cGhyY1R2R0RVSHdWR0hsUFNTVVNTVkZXNmtVYzN6?=
 =?utf-8?B?Z3E1bmlXK3Vhc3VjWE5XeXFPN1EwRjM5bi9xY09xeDZ1WnU0WWpZOEhPaEl1?=
 =?utf-8?B?TlR4REl5bHFZNjBhc3l3T21XelFRRU1ENHIzMUp5WFUxR1ZTZzVtOW14bzRL?=
 =?utf-8?B?ajk5Tzg5T0lNNUZJOFpJZ1kzWm1WMWVFb1F3ZGdiejJTdjlkbk0zV2ozdGpm?=
 =?utf-8?B?cUhyWkdXSGNpeTJRb0hDTlZWV1AybUNMUXdrRjhKNFFFSE1vMjh4N1h4NjI0?=
 =?utf-8?B?QW83a3FUUjBVT0VTUGsyclBQVG1Fb1Zmd1gxQzdLU1ViL0UyM3Nya1RUanNG?=
 =?utf-8?B?WWxzS05QeG5rREJCTlkzQlBpenQvYnkvcGJueng1NTZ2czVLT1l1VW5kdFZI?=
 =?utf-8?B?cmJndDJta0tVci8zQWo1MHRCbkpGU1RNSm5Ed0lsb3BNSlFvYmt1dFg3SnlP?=
 =?utf-8?B?eUR4WE84djJWMUJndkIzRU1DNGw2TmI4VS93dldEbEdMYnduZ0F3YzdCVkFC?=
 =?utf-8?B?UkhYSHR4ZkNhU2VEVTZHcFZhUjJoelNqczd6TCtqZU5KUC9OcHNTL2xtRGVu?=
 =?utf-8?B?bERUWUhrbkdWei82Vk5ha01hMHVpZGhKdTROY2ZCUHJBUCtpeitYMElqamNX?=
 =?utf-8?B?N1NDemJQdys5eW9BYUxGbHFVdFNVREZJUkdQbWtReDAvSFNyZmlhM2JqZnhQ?=
 =?utf-8?B?bGhMU3dQNHlDdmR6WTBDYzBoekRlR1RjUEV1R0dMbk5UOC8vYlNmUWExRU5x?=
 =?utf-8?B?Sk1DRFlJWmVWSzZWS1FYbVVGYmpwU01xSWordDlZNGhyV2hYZlZVYzlPa0NU?=
 =?utf-8?B?VXJFbVg2OTdqaUc4a3hsWEplTGFDMTJ0RlNZZ0tKVDNjaVpwQWpHaWVCeHlB?=
 =?utf-8?B?eERHRDR6WStVUGF5dklWbTkwdG9mdE9SNVlSN3poblE0ekZUT1Ruak9RSU5R?=
 =?utf-8?B?YjVqVlFaT1V4Sk4xWG50a09xTmQ0TVA2UzJ3K1grem9WMWZXbzFkOFczZUQ2?=
 =?utf-8?B?R25XdGpkUFRkUE4yM0hUVCt4RC8xRW0xYUZMN3d5YkR1TXQzNTNJVWU5NjBF?=
 =?utf-8?B?ZzZoK2owR1R5SjZDeHRmQ3ZzYWNiSjhKVVFOUnFKWHYvZlB3bnYydlRZRlpn?=
 =?utf-8?B?VkkvZzMwYm8rUFlQYitoaXkwMDJZMWFoZE1GV1lzRXVoUVdQUjJKSmtuelQ2?=
 =?utf-8?B?cWp0aENoYTM3VDYrU3JvQVNmY1NkckVGUjdPalZ3dlZROFdmTThPTUZ6LzU2?=
 =?utf-8?B?WEdrbllEVFNSZkJRekR0WFhEM1ZKSW14NllrVWxMVDFmYTJwa25CSlk1dnJV?=
 =?utf-8?B?aXlkTTNFTExXUHRyU0lud3JTUG51K2JlZ0g4MGgxTWRlV2UwOGJ0Y2w1Ym9w?=
 =?utf-8?B?MUlmZ2xhTEFLMHVZenNFZWpkamhQK1U1WUhqczg5ZVZqanVhZVJKb1BMY1Jz?=
 =?utf-8?B?YzN0YStDbmx1M1Jvejl4ZjBGTmRQcDlRcUJOYWdCMWg1THQ2TlRLVkcwQTl1?=
 =?utf-8?B?TjZYRWh0bmIzWnVveVM5T0szYjc4eGprOUYrd2pzYjljNDY3U213QUlmbFJB?=
 =?utf-8?Q?QEiSJLl74Y1L9IqQnUvfqJQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: spektra-dresden.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR09MB5040.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e21268-6743-4b1a-f810-08de25f5af54
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 16:23:47.1361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f0fc6769-01ad-4c8e-9da9-38ead3013d23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZD4hD4K/cCPOibPVWfEEoTMcQ1Ia+fBvfi6aF1DlPfkVxlCKsyxYny6/Xiby/hO4pB7SgqYGe/wbQ+2+e+SXmq+WOOcBYdhTdo+PNPhYU3TUHr6ekXlvmMo4uX2LiTH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7572
X-Sophos-Email: [eu-central-1] Antispam-Engine: 6.0.3,
 AntispamData: 2025.11.17.155719
X-LASED-SpamProbability: 0.083173
X-LASED-Hits: ARCAUTH_PASSED 0.000000, BODYTEXTP_SIZE_3000_LESS 0.000000,
 BODY_SIZE_2000_2999 0.000000, BODY_SIZE_5000_LESS 0.000000,
 BODY_SIZE_7000_LESS 0.000000, CTE_BASE64 0.000000, DKIM_SIGNATURE 0.000000,
 HTML_00_01 0.050000, HTML_00_10 0.050000, IMP_FROM_NOTSELF 0.000000,
 IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000, MSG_THREAD 0.000000,
 MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
 NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
 SUSP_DH_NEG 0.000000, __ANY_URI 0.000000, __ARCAUTH_DKIM_PASSED 0.000000,
 __ARCAUTH_DMARC_PASSED 0.000000, __ARCAUTH_PASSED 0.000000,
 __ARC_SEAL_MICROSOFT 0.000000, __ARC_SIGNATURE_MICROSOFT 0.000000,
 __BODY_NO_MAILTO 0.000000, __BOUNCE_CHALLENGE_SUBJ 0.000000,
 __BOUNCE_NDR_SUBJ_EXEMPT 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000, __CT 0.000000,
 __CTE 0.000000, __CTYPE_CHARSET_QUOTED 0.000000, __CT_TEXT_PLAIN 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FORWARDED_MSG 0.000000, __FROM_ENCODED 0.000000,
 __FROM_NAME_NOT_IN_BODY 0.000000, __FROM_UTF_B 0.000000,
 __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
 __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000, __HAS_X_FF_ASR 0.000000,
 __HAS_X_FF_ASR_CAT 0.000000, __HAS_X_FF_ASR_SFV 0.000000,
 __HIGHBIT_ASCII_MIX 0.000000, __IMP_FROM_MY_ORG 0.000000,
 __IMP_FROM_NOTSELF_MULTI 0.000000, __IN_REP_TO 0.000000,
 __JSON_HAS_SCHEMA_VERSION 0.000000, __JSON_HAS_TENANT_DOMAINS 0.000000,
 __JSON_HAS_TENANT_ID 0.000000, __JSON_HAS_TENANT_SCHEMA_VERSION 0.000000,
 __JSON_HAS_TENANT_VIPS 0.000000, __JSON_HAS_TRACKING_ID 0.000000,
 __MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
 __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MSGID_32_64_CAPS 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PRODUCT_TYPE_GATEWAY 0.000000,
 __REFERENCES 0.000000, __SANE_MSGID 0.000000, __SCAN_D_NEG 0.000000,
 __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
 __SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_NEGATE 0.000000,
 __SUBJ_REPLY 0.000000, __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
 __TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
 __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000, __URI_NS 0.000000,
 __X_FF_ASR_SCL_NSP 0.000000, __X_FF_ASR_SFV_NSPM 0.000000
X-LASED-Impersonation: False
X-LASED-Spam: NonSpam
X-Sophos-MH-Mail-Info-Key: NGQ5Q2pyNVcwOHozUm0tMTcyLjIwLjEuMjM=

SGkgSm9uYXRoYW4sDQoNCj4gPiBUaGUgY2hpcCBpbmZvIGZvciB0aGlzIHZhcmlhbnQgKEkyQywg
Zm91ciBjaGFubmVscywgMTQgYml0LCBpbnRlcm5hbCByZWZlcmVuY2UpDQo+ID4gc2VlbXMgdG8g
aGF2ZSBiZWVuIGxlZnQgb3V0IGR1ZSB0byBvdmVyc2lnaHQsIHNvIGFkNTY4Nl9jaGlwX2luZm9f
dGJsW0lEX0FENTY5NVJdDQo+ID4gaXMgYWxsIHplcm9lcy4gSW5pdGlhbGlzYXRpb24gb2YgYW4g
QUQ1Njk1UiBzdGlsbCBzdWNjZWVkcywgYnV0IHRoZSByZXN1bHRpbmcgSUlPDQo+ID4gZGV2aWNl
IGhhcyBubyBjaGFubmVscyBhbmQgbm8gL2Rldi9paW86ZGV2aWNlKiBub2RlLg0KPiANCj4gSGkg
QW5kcmVhcywNCj4gDQo+IFRoYW5rcy4gVGhpcyBpcyBhbm90aGVyIG9uZSBmb3IgYSBsaXN0IG9m
IHJlYXNvbnMgbm90IHRvIHVzZSBhbiBlbnVtIGFuZCBhcnJheQ0KPiBmb3IgdGhlc2UhIFdlIHVz
ZWQgdG8gZG8gdGhhdCBhIGxvdCwgYnV0IGN1cnJlbnQgYmVzdCBwcmFjdGljZSBpcyBzZXBhcmF0
ZQ0KPiBzdHJ1Y3R1cmVzLg0KPiANCj4gV3JhcCBjb21taXQgZGVzY3JpcHRpb25zIGEgbGl0dGxl
IHNob3J0ZXIgKDc1IGNoYXJzIGlzIHR5cGljYWwpLiAgVG9vbGluZyB0ZW5kcw0KPiB0byBlbmQg
dXAgaW5kZW50aW5nIHRoZXNlIGZvciBzb21lIHJlYXNvbiBzbyB0aGF0IGNvbnZlbnRpb24gaGFz
IGJlZW4gYXJvdW5kIGEgbG9uZw0KPiB0aW1lLg0KDQpPaCwgdGhhdCdzIHNvbWV0aGluZyB0aGUg
a2VybmVsIGRvY3MgZG9uJ3QgbWVudGlvbjsgSSB0ZW5kIHRvIHdyYXAgbXkgY29tbWl0DQpzdW1t
YXJpZXMgYXQgNzIgYW5kIGV4dGVuZGVkIGRlc2NyaXB0aW9ucyBhdCA4MC4gVGhvdWdoIGl0IHNl
ZW1zIEkndmUgbWFuYWdlZCB0bw0KaGl0IDgxIGluc3RlYWQsIHdob29wcy4gR29vZCB0byBrbm93
IGluIGFueSBjYXNlOyBJJ2xsIGtlZXAgdGhhdCBpbiBtaW5kIGluIHRoZQ0KZnV0dXJlLg0KDQo+
IFBsZWFzZSBjb3VsZCB5b3UgcHJvdmlkZSBhIGZpeGVzIHRhZy4gKHNlZSBzdWJtaXR0aW5nIHBh
dGNoZXMpLg0KDQpSaWdodCwgd2lsbCBkbyB0aGF0Lg0KDQo+IFJlcGx5aW5nIHRvIHRoaXMgZW1h
aWwgaXMgZmluZSByYXRoZXIgdGhhbiBzZW5kaW5nIGEgbmV3IHBhdGNoLg0KDQpUaGVuIGhlcmUn
cyB0aGUgdXBkYXRlZCBkZXNjcmlwdGlvbjoNCg0KVGhlIGNoaXAgaW5mbyBmb3IgdGhpcyB2YXJp
YW50IChJMkMsIGZvdXIgY2hhbm5lbHMsIDE0IGJpdCwgaW50ZXJuYWwNCnJlZmVyZW5jZSkgc2Vl
bXMgdG8gaGF2ZSBiZWVuIGxlZnQgb3V0IGR1ZSB0byBvdmVyc2lnaHQsIHNvDQphZDU2ODZfY2hp
cF9pbmZvX3RibFtJRF9BRDU2OTVSXSBpcyBhbGwgemVyb2VzLiBJbml0aWFsaXNhdGlvbiBvZiBh
bg0KQUQ1Njk1UiBzdGlsbCBzdWNjZWVkcywgYnV0IHRoZSByZXN1bHRpbmcgSUlPIGRldmljZSBo
YXMgbm8gY2hhbm5lbHMNCmFuZCBubyAvZGV2L2lpbzpkZXZpY2UqIG5vZGUuDQoNCkFkZCB0aGUg
bWlzc2luZyBjaGlwIGluZm8gdG8gdGhlIHRhYmxlLg0KDQpGaXhlczogNDE3NzM4MWI0NDAxICgi
aWlvOmRhYzphZDU2ODY6IEFkZCBBRDU2NzFSLzc1Ui85NC85NFIvOTVSLzk2Lzk2UiBzdXBwb3J0
IikNCg0KU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBLw7xicmljaCA8YW5kcmVhcy5rdWVicmljaEBz
cGVrdHJhLWRyZXNkZW4uZGU+DQo=

