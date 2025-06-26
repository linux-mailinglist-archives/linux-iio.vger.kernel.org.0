Return-Path: <linux-iio+bounces-20970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E79AE9A11
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 11:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A192E1C4243F
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5D2C15A6;
	Thu, 26 Jun 2025 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="UTeKBXLb"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ECC2BEC31;
	Thu, 26 Jun 2025 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930288; cv=fail; b=niuMA+BTcp+Vr/n9CJLig90gEyncifKjE6OeImBgjfu9DJMeesvvr+sDq/ncZfkzxunw0GtmDfr80YgclftHQmujTfWCvKu3O/Ca4McrY47LpEh7r1zH/8CeCQ3NUwDtp+TehAYyEL9wUc3WtRuhIyBjWP9cg2fGSsrmHfv2RNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930288; c=relaxed/simple;
	bh=/DDkCRJ0UdeqVAM42YM71SaZV0qtaUKeKpC3K4jlhHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jow/s0uaTT2hkISwnegTlyqHDZxzS9+V4yebWUZTvEKCTPznCa7yN0jsWyGHK4P+qo3q5k1fIPkHDD+Xk5PqX0aWC2EnE+bp0FGM5qJjdSHt74g3Z8K7ynlmXkOe1zCeEJ1N2r0SI22Quo1Xe9MQZiPLGDzQiWjC1IdlxipTIZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=UTeKBXLb; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+EDCPbavjqhhzgqDmAWFlCzzbObDQFvQH6ZLd/Oq+bq1Xs+PVLyj8/SKooD8kzW4lt3mi0qoqUR0ZMBdp/Fbhpp1LEgW1Rs317sXm0My/F1lYnmHAFzoYMEqpOlDc7reCl37NNQeB0UeQwW7cPQuDs6BJLOnE3OL7Kx/PJI0f4nmZxXFMRMvr+Q9uRy7E3H4lWAy0KupoLA3yzvSHxDxHAHH3dm/vc6Rbx1/d/N5mFcO9uzu4JydG/ZsFLqHcVyFS+u7EePj+ZxJx17Xw9rZD4Z9TEk95n93Hqekdsku4pcUOHh7M578CqW8G3RQhujJMVSIHyWsAtRM5dPSOGW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt/ejxiPkn6dwA/+L/zpScpt+VM0nSO7MEbKyWqAXrY=;
 b=WU34l4gBjffPw6SFknkx3Q7mK4AiLsCMIvPAc08nz+b7vVkWofjOdwq8kWAoUoYJrxv3YzLPArQg0V6SEObagnS5CXHPLJ3a+4UldjHxzNqr6kyT0mVVVXWfHGr85itYlXwMJqd17pSHmJQhHOtUVklCAFgJbNQLGRYXlPpSSwDjrjTrG1EPf+pawfVPm4NLEM9GCLpZcX015jOA2pGxWcrt5lneumRTFNFXxdvYhTTRDrNV1ASfJyJiIE63eDvN8vX+iz5o317hq16cp1lAI6O6RfbnMlWwH3qJpMHuhdWxqoGM9CqaH2bMQkBIhPX4uoafYx6xz2bgXjzPV5y4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt/ejxiPkn6dwA/+L/zpScpt+VM0nSO7MEbKyWqAXrY=;
 b=UTeKBXLba3iv3NbOXL8N0pN7iLxdBQGeolIXuESX/RTBHEdFBrArW9herXjfguOz82GwbSX6gGjY3nmxU4NngobiawS19f/hRktepl9e3f3lrIzsUqU6AGceYyh3KVgg2gcQ9WkZ5Q1Rt9shd0QVHHUJD0yd08MRazzOGDObSZvoqWOqMSqL49/wR74k7eysfl4je3BZNB5OTxMzjJAIhvgQbx+nIG4LI9K85jtlglwraiFs8W5h5FH1MrqwKu6D8/la4eggSuGe4uCKGtgErXThsw53iiCXECMOsNhI2s5QIPR4iLcbABFL/rrzy5KiElvpOuWWf/lXYWN8sjqxSw==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by PAWPR10MB7221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 26 Jun
 2025 09:31:19 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 09:31:19 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dima.fedrau@gmail.com" <dima.fedrau@gmail.com>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lorenz
 Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike
 (ME/PJ-SW3)" <Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: AW: [PATCH v2 2/2] iio: imu: smi330: Add driver
Thread-Topic: [PATCH v2 2/2] iio: imu: smi330: Add driver
Thread-Index: AQHbxBftA2gDqLq0h0CuDDE2kkGvVLPjonaAgDHDi3A=
Date: Thu, 26 Jun 2025 09:31:19 +0000
Message-ID:
 <AM8PR10MB4721C0BBFBAE160FB494482CCD7AA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20250513150028.42775-1-Jianping.Shen@de.bosch.com>
	<20250513150028.42775-3-Jianping.Shen@de.bosch.com>
 <20250525175157.2446f878@jic23-huawei>
In-Reply-To: <20250525175157.2446f878@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|PAWPR10MB7221:EE_
x-ms-office365-filtering-correlation-id: 26e2918f-8cee-4d7c-d636-08ddb494350b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q3k/6FhkaFh3TbtUv+e6kaHhj902BIvSPLdwLsx88K51x7ffyJHN3ADhwl/4?=
 =?us-ascii?Q?AkDdQzKIIcENlk6B+zBB2eOL7iC8jLtcKRxMs87fllFW0ExKHzr+LVoVvkRe?=
 =?us-ascii?Q?mffIKVxTAuy17v9QtUeGWvsiq01POn8HpPZbtVw04l7bgE/+VhJL07ROBmiT?=
 =?us-ascii?Q?CzGwr+A27hcfC9F9srilygWO+hBtwOkkYQDxCA036tKW1iOuyk2kz/KLeFv8?=
 =?us-ascii?Q?DVeuzPjnOGLR+DbQMMmQCH91r2DzCNJ2+3AP5761gW8pg2eGNbMbh9We+W60?=
 =?us-ascii?Q?VkfLL1aZGclJHx4tHnmwtjJuFNkbtX8/Gh7jzGF6OtxPr8ZruC8rEGqOKLg0?=
 =?us-ascii?Q?LKVv2CS2CVr+Q493jXG2Y70S88dN7C6CT0TbbfAilm4tEyl6FFh0NFtL/o86?=
 =?us-ascii?Q?SHgNO9frlGGe8MmjaFR/q1BlcbuviM9uhkFAiM590FeH6yv8mPRD8niZEmrq?=
 =?us-ascii?Q?4ZOCabwjbPrqUzQvF8HRUTYxsHra2dgZKWQFwbOxTt1nAz2TRLm3hc9b4sa4?=
 =?us-ascii?Q?E8A/gPMXw2DvEv9efuFJbCPTWAmQlP6tBE0KwnSAtocPHcVw2MAPWL77B7Oy?=
 =?us-ascii?Q?FX04KxInobRNMZ4P+SdrX+rb7qRSvLwemMX06oWGFHNHzWpT1ZkVvrwdn5EV?=
 =?us-ascii?Q?dgkSaUQUkngyBhA+YJoDI5Ypli9UpgwO+Fj8k+LU0C4+VwJnP/Jea0qSi1CU?=
 =?us-ascii?Q?BI93GP8AyG4YTp9hGGnaK4YOZpZP02NqnI9dMTX/w8eTiUu4IEETpocJstlU?=
 =?us-ascii?Q?eLeuRWOjucNEf0vLDJ5DAJieWwBmOBP6TiSqQMHEk4Uds/sUWKWe6qlj7aX0?=
 =?us-ascii?Q?llsnJvDO1QB3xCXCzlUPQWd8u/Qn0Cyl1HAQtjeyU9SnhydrkrasAjM9Paix?=
 =?us-ascii?Q?TcIWWo3IAYthF6PAr9R/vgbfKk5HzT6SDi0gMSIbI2KGb5p5Z+CbZ2dNoaHv?=
 =?us-ascii?Q?y57Jv3/yDiYctbOT3qRmAeLakLidrlExZP09Sa5OadzJWdlaI9ABuQjKO4Ig?=
 =?us-ascii?Q?QXQtDIVY8N+1R5pjjmT4YBk3J/tI5u4FU8hNehwJ7hWqMwF0YS4VYchys+db?=
 =?us-ascii?Q?dIRS2yGmNQDT4vi0TFAzDGCr35F+fqSA9oLWubHSRjrEhhAGZbKXu8FNtbxh?=
 =?us-ascii?Q?uMXi9gkCONAGoATByOt465SQQPi785qu7cI6kPv/fj2bW3N23zXn8BnuEXEL?=
 =?us-ascii?Q?xCIqEsewf3PlYVk4dvmt6kTqfpp/2dzpK6LO3w6TJrbbDK95o/rtAadvM/FS?=
 =?us-ascii?Q?8orcaHzpdRs2qoycjVq99JU2z0siWKcaJBJ7uY5t20WizSGCfdrWdqcLLjsb?=
 =?us-ascii?Q?hzfLqQd23yNMOrTDAboC/Tg19a3EQIxloDplm33zFxJxfOD3u9eoVdiQSIGe?=
 =?us-ascii?Q?UeRNtOu4tK/fJzozQ2HgPTEr3vwPkBk3HFyZzgNoTqR3Lo2Q4l1tu/atd1Az?=
 =?us-ascii?Q?FILIi03TZQ6K2w5jiZ4+Wj0f7JD77ZCAEQ5Yefvl+YhKJZUaL9D07g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B4iCWxjk9wbT9Qcaf0oYaUbOTr6aOeBDt0O/XxxHWjWX/1ZGAvUe1lBNnVp5?=
 =?us-ascii?Q?O7xBau7XGUgmzoFQqbCep2cg9Oz5qRcLbQj12KZpdR6TpzAPkazecSEVgTUg?=
 =?us-ascii?Q?vS2BcqduWyH/TbuKOjv5hH68daN/jVlAk66WHlV3IXYmiAMFcuO5P4rdqn/l?=
 =?us-ascii?Q?Nvs+P/evFuKgBOloM9BMYjE6mA5p4+dJeCb366dR+iMIumz34t9y9greWL4B?=
 =?us-ascii?Q?DcAJ0AlBULKdJ185+DT4wTZrN4/xlg7RA2+ifM9vRInwKn2B2irg6VQoIcSH?=
 =?us-ascii?Q?OEBFEuRcN3RAQRZB7BKLrsARIKxeLaN8gzMF7aqhMrx2dKweVe8iKOYSBIQw?=
 =?us-ascii?Q?HfBw9MGbjsCVg+fTzbKyFoUI1fykuk60j4vzJ2JF2BLbxpXLV8vjB/yT3T06?=
 =?us-ascii?Q?Yo+/r9D1TDmWC0VBEQ7iFK9eyp2d1ta0Rer7VMasoKDIbMWOCEZG3yOUhQVk?=
 =?us-ascii?Q?jvMou5lj3HNirfar/YYnsAV09d1a0is7NLdXEfQa8/zIZ45Vpel1ysZtyLij?=
 =?us-ascii?Q?zQw6FLlzecOCTRGT/YNEL74e6afwWVEMGiGBEk/8kssQH9ZJrdZsHoO9Hm2p?=
 =?us-ascii?Q?UQM5/Emx5JEn56fTMBZEN/A/fAuCVLzCZq3PM6hHGx7ydOT1Irui1n0LdpXX?=
 =?us-ascii?Q?7jn1sv3jYHQfAA9imiPZNiNHWcEb9cseZNLlG0FWczVMK+2HhrxXKUUM2yGq?=
 =?us-ascii?Q?P0blzz7UqVLMjcn648fGBLd0BywvuTtSHy4nRcTiqsqxZQB4LB1PVlDVJ1p4?=
 =?us-ascii?Q?TM06FhceWgrp2lTvQn82HGbCwq/O4x3Ds1nSxTlo8KYb4fF3SB9gDrOqomuE?=
 =?us-ascii?Q?a+zf8Od76C4XL95a6+D2QCO1I/pMIb2fCDQ2R2p9LbPIl31weqn6t8vFJ0pX?=
 =?us-ascii?Q?hMpWmvjO/LPFqgp33mQRm+cRBefiwZGYXc4OmjLlJdolLvH/WN4Vw1P2cPuU?=
 =?us-ascii?Q?ptlk96wv83ooqQYUlXhAuXtOW7cY2R829ctbX0kx47UA5W8yLb5uXpUs6DGc?=
 =?us-ascii?Q?t0CJNFEi3SJ2U7OZJTi4XuDDuQ06fcoUO/t0BN/4URrRo1unskfYpefnHQ+L?=
 =?us-ascii?Q?GMalwDeYMwE+1gAykPpi/+4dYpCksAIQnAsg2K8p9idZ0Ifg9VEvXCUQ3Uwy?=
 =?us-ascii?Q?NB1W7PG93U8C4zou1jbx4a+EbrLweGYlx6NXi1RWvoQsD1E6R/VFGDRonRmV?=
 =?us-ascii?Q?0kFHhkKLg/0buI3DHE/nx57uIuKJ2Oyd9GGkHmafkJjUoirkQ/CDzcqf2Lr5?=
 =?us-ascii?Q?4PUTAssVfOpzxyJ+zua+KiuT6LMOUVt8fTxjGYfuahgfXqYtfOsxPYhf6KMX?=
 =?us-ascii?Q?UU3vAHaWLX7uYOODFavBbvJo2C+6xQdhKtSGaFEFDakBESj4ZuAfKg8QgvmZ?=
 =?us-ascii?Q?oR2wG0339IlUV6n8+FIDwPlBeQ6gP0cFbCWzlHZ3yeOwpFDTDs89LyOIlT4R?=
 =?us-ascii?Q?qOCyLgtUc1BqjjJr5nO75PQEcmoIEMb5JediBoNFaoMBrUbz5EFjg7NNA4ag?=
 =?us-ascii?Q?CUpTEZPpVN8B9a+bzIINhHNt8gCWsE2UgkzyUE18Oj2EzqFaCtTu/3kP2M0G?=
 =?us-ascii?Q?qYuUV8h2IeY8wELsl7g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e2918f-8cee-4d7c-d636-08ddb494350b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 09:31:19.4097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrP0Y/YFBp4TCVyNYn8m3WYKEcNzf1X01eMnkEPG4U0L8dYT8C/1sN4+stohN7DckbBs/YcCQBwarGxEmkEczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7221

Hi Jonathan,

most findings are already fixed. For 3 findings we still have something unc=
lear. It will be nice if you can give us little bit more indication.

>> +
>> +static const struct iio_chan_spec smi330_channels[] =3D {
>> +	SMI330_ACCEL_CHANNEL(IIO_ACCEL, X, SMI330_SCAN_ACCEL_X),
>> +	SMI330_ACCEL_CHANNEL(IIO_ACCEL, Y, SMI330_SCAN_ACCEL_Y),
>> +	SMI330_ACCEL_CHANNEL(IIO_ACCEL, Z, SMI330_SCAN_ACCEL_Z),
>> +	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, X, SMI330_SCAN_GYRO_X),
>> +	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, Y, SMI330_SCAN_GYRO_Y),
>> +	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, Z, SMI330_SCAN_GYRO_Z),
>> +	SMI330_TEMP_CHANNEL(SMI330_TEMP_OBJECT),
>> +	IIO_CHAN_SOFT_TIMESTAMP(SMI330_SCAN_TIMESTAMP),
>> +};
>> +
>> +static const struct smi330_sysfs_attr smi330_accel_scale_attr =3D {
>> +	.reg_vals =3D (int[]){ SMI330_ACCEL_RANGE_2G,
>SMI330_ACCEL_RANGE_4G,
>> +			     SMI330_ACCEL_RANGE_8G,
>SMI330_ACCEL_RANGE_16G },
>
>Do we need the (int[]) part here?

Remove it will lead to a compiler warning.=20


>> +
>> +	if (*indio_dev->active_scan_mask =3D=3D SMI330_ALL_CHAN_MSK) {
>> +		ret =3D regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG,
>> +				       data->buf, ARRAY_SIZE(smi330_channels));
>> +		if (ret)
>> +			goto out;
>> +	} else {
>> +		iio_for_each_active_channel(indio_dev, chan) {
>> +			ret =3D regmap_read(data->regmap,
>> +					  SMI330_ACCEL_X_REG + chan, &sample);
>
>Given there is always a trade off between the efficiency of a bulk read an=
d reading
>just the channels enabled, we often just set available_scan_masks, read th=
e lot and
>let the IIO core worry about resorting the data as needed.

Is any IIO API available to take care the resorting data?

>
>For example, if you want all but 1 channel that is almost certainly quicke=
r and that is
>more likely to be the common case than you want 1 channel only using the b=
uffer.
>
>So I'd like some more explanation here on why this path is needed.

We try to read the data just for activated channel and put them in buffer. =
If just one channel activated, reading data for all channels leads to unnec=
essary data transfer on bus.

>
>> +			if (ret)
>> +				goto out;
>> +			data->buf[i++] =3D sample;
>> +		}
>> +	}
>> +
>> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
>> +					   data->current_timestamp);
>> +
>> +out:
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}


>> +static irqreturn_t smi330_irq_handler(int irq, void *p) {
>> +	struct iio_dev *indio_dev =3D p;
>> +	struct smi330_data *data =3D iio_priv(indio_dev);
>> +
>> +	atomic64_set(&data->irq_timestamp, iio_get_time_ns(indio_dev));
>
>Why do you need the atomic here? If there is a top half / thread race then=
 you could
>get garbage data anyway.

The atomic here is used to prevent simultaneous read (in bottom half) / wri=
te (in top half) to the "data->irq_timestamp"
This happens if the next interrupt comes too early when the current bottom =
half is still reading "data->irq_timestamp".=20
The next top half will interrupt the execution of current bottom half and c=
hange the "data->irq_timestamp".=20
Finally, the current bottom half get a wrong value.



