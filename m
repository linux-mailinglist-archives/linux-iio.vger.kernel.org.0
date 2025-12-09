Return-Path: <linux-iio+bounces-26962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A9ECAEF21
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 06:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1AB30762EE
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 05:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B929DB99;
	Tue,  9 Dec 2025 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="hrMxWBSe"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023101.outbound.protection.outlook.com [52.101.72.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F0223DD5;
	Tue,  9 Dec 2025 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765258446; cv=fail; b=SCnO6B8ZkgctfxyMrDaKZEBxhlVCwHO+Ky1mtU28jLtJULmYYlJ0xjRBDHyVOniQ9GUgB+IiWHwlTVm1mThMF0RDh2s1R89eCZif63BVejcvLGxw/lPIk4CZe+780GaxD8QCZbRWAiyAKM46HpqJXax2QgN7vNiPHUau3crOtvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765258446; c=relaxed/simple;
	bh=z9SYX1QQ+iwNPalhe878LTabSqMViAMwiIKLsx9GN6Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TsRSOcKdUipcRIcDiejXXYP+UWvWDcEFvjSDDJEZlbhmS1OchGIdNWXkINJlR/iXOQtCMh9W0wZfjbBJdGPrndgxnt6KTGiwBkKLcWAS4zO8m7SXtu1bRQdda+i5C/imruyOdvcfOhSP1n8HiY4ZFzH6v09yp8KXTIMHHkS9dWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=hrMxWBSe; arc=fail smtp.client-ip=52.101.72.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuasybaCjOdUWCsHyBa7r8RTKXiUXSjz+GxsuLD9KiydX8IzGNryeXNIFp4ZAgIlKuw8J/hl1O00Yr6IREcKedatmVwNeb+Tn8FFpWczov4FLr1yXVgG7xxaPKBCvMdJcWiXGhB2AiNqa9A0xrROO9qFZBgz8o3fO2FYZAUFbpqZJb24h/RJ3RIrlPORHrwiOVFm+0ge5RmO1U63Jz/azxCI7HPKggd53lp+4cwSANaqBSz8r5dgjSFWT6EfJ3dONVV718lH10qyVtmsVDHLsQUBkMzMWr/VR9EhccvBrkbGWgNkzFR0jiAoOTX5o81W3aSjACrSX0qPaByuqvZHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FzG+0JpGAN6HcbKBDTq6n3m2uASpefrnYnU8n6J3xw=;
 b=FlDVmYDcnIW9nY3umf56zCE0wilIBINq54JuwUd7MGs3Bz8RkLp6GvYh1QdyevMvUqF0CF6xbTQJDtb5igAX1vb2TH1MoFk19Y0jCn8AkM+FGLm5/u7O0KgDUM9Q6OO5Xd9j40okG4j+RYSj8Y4kP9j9MOVVoVf2peC5YtctqrMLOxl+eC5PM3PpcDQ1R/BHyw2YC0H5yvsiMFxjFQWXzZngTsckRbsntrft82x0Z+Mas5yoXyqVLHq8VZ/OKULbOX+Y5lcXIrbvXm8GAyRlKFUBcErGR9butZ1qshyNW83umEek7u1bDc5sZobQpzzlxVwr0dlkUZfub+l0XMx18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FzG+0JpGAN6HcbKBDTq6n3m2uASpefrnYnU8n6J3xw=;
 b=hrMxWBSeiVEnrUdFtgzDOw9KTLkbBd1oWI8TCyzp3jtVvHd6tqm7I1v3obEKH0zKuwj9mDQZCJwvckaGIy0aYPiPpQ/CgHtRPW+OTPbxdbSvoG2oocSVTIbAGBhZfZNkNVRbpl7PNH67+EIJDdu0krKfnD9hLFL8ZB0na919TUhbslBi0kzCiXCJ0arlwagi288Ts2Rkavb/DShvJK+yDHnfoUKP4tQrCY0jRRS5kpRCv3svrSUXL1K18Y3VpV0mpIQHbaH+MuRy7gCxWJ+QctKrhbNg6O3X0q6EjNg7eZ3aN/8RjYPwVwztnvRywWiVOhZT9EvQwu2920LFsmMriw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VE1PR06MB7053.eurprd06.prod.outlook.com (2603:10a6:800:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 05:33:52 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 05:33:52 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 09 Dec 2025 05:32:27 +0000
Subject: [PATCH v4 2/3] iio: adc: ad9467: sort header includes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-add-ad9211-v4-2-02217f401292@vaisala.com>
References: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com>
In-Reply-To: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765258430; l=1321;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=z9SYX1QQ+iwNPalhe878LTabSqMViAMwiIKLsx9GN6Y=;
 b=0AOUMMTtpHrgInaQyiHL39zO5RQYZC7wnfLniqOnyf3z2PmMuhH1WRsYnXvEaQs1F5gvs7hx6
 0CCfR2Bnl8yAu+9bgbOXPeH2eImq/poew7qB5AzbqxxxxTj/dLkfyIH
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF00002E6A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::38) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VE1PR06MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 8139883f-a3d7-476f-c16b-08de36e489c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDhzWFdDQktQNlpsRDllOUI2SE9Tc3Y4N3JzR29xRnRaVzMyWEkwZWxEWlcr?=
 =?utf-8?B?MHdqQnBlcDRCV1NPY0FFREdyTFp5NmxXWlA0dDdQanUxWGFYS2tVcDBEenp2?=
 =?utf-8?B?d3lZcTFXUjNVMzc4ZEo1ZEd1NS9FRzJ2Wk0zWlpwTXVpbkh6UWl2VDBjZER5?=
 =?utf-8?B?eVZHV1dMaTZwSitybHNCRndaMWhZNm5hVkVVVk51d21YQlhXakdrUjRQWWMv?=
 =?utf-8?B?Q3B3VWpjK0RpM0RYcU5Tb1ZEODNDMEhhTHN4a0wzTWxDYzJOek8xQXVFdm8r?=
 =?utf-8?B?OEJ5K0l1dTBWT0FyYmZ6a2RMZUVCMWpkVzJPblVNS3M1ZlVIdE5iYk9idmdj?=
 =?utf-8?B?NVA4RUZkdE9BQUVlcHdqR0ZDTVpDUWFkWEdsT3pmSVNPQ0pWOGtyTm04S243?=
 =?utf-8?B?NEQzUGNEODlmaHorL2FpaUN5OHJDMG5CM3IrOG50Q2pmaERsWjdsM2pmREZS?=
 =?utf-8?B?SUM1cEJDMCs5a2dOQ1N5MExzWDNmZG5SUU9VS01TMXpQYStBNjQ2TjhKQWpv?=
 =?utf-8?B?cW14NTFPYk9mQ3RiaEVKbjNvUjhsR3g3NHhEcGh0akV1N05FUHYrVzJsVk1P?=
 =?utf-8?B?dG9OVHNSeHNrRTBuei9WM0NJdWRVMmpDOFhDeXBOWlNjRGpuaEU0SjNuTisx?=
 =?utf-8?B?ZjBhZzMwMHd0L0tScWdyQ0ZSaGFrS3BDODluUGxFVEdDUjRybGNIRjZ1OC9t?=
 =?utf-8?B?MjludHA1ODBSdFpKR2VKcGdoWlVmVUxkUW5xckNMYzBuV2lLWUd1QkhsZWox?=
 =?utf-8?B?Q3Q3Znk4S0VqdVFmS2hhNmttQ2huNFVERGp4N3YyY3gyK212TmhocHZFU05B?=
 =?utf-8?B?UjF2bEF5NHBJOWtmemFMZkNJNkpMbGV1WFd3QUg4SVI4Wm96QnRBc2dSdGN4?=
 =?utf-8?B?TnM3OENDTVFxOVlOcXNCa0FtdmlwdVdaZWZFZzdpQnVwMWlrY0U2a2RSMk5D?=
 =?utf-8?B?QmhjOWlIRmU5NkNjSloxN3gyM21XaHh2QXJNWVQ5Qy9zS2ZieENVNDA1RktX?=
 =?utf-8?B?czF6Z0tlMkZ2MEJZMytBQmlEYlRDM0VySzdvKzNKa3greXpFYmprMFNLY2hT?=
 =?utf-8?B?dHFQNXZPdXNzZHl1aE1TOVBHb0JvZEZkYm92Zy9TcEgzRURDUEJrQmFDcGI3?=
 =?utf-8?B?Q05RQVhZWnVsTkFKd3R6UU9xcjF0b0FTcE1WckMwNHU3cFhtaytJYlJrb1c4?=
 =?utf-8?B?dkhVZHVxdjk3bTlEMDVyV1VvUUZ5bEZVOXBmOFB2eHR5S3ljM3JqVU05amNB?=
 =?utf-8?B?VGtSRlFGWXovY29vTkFBZ09xNXg4YkwwVHBvVHdvdFRXbXpPdEhyRzBsMjJT?=
 =?utf-8?B?MXRjVXRsWTM0SDBkSDk0M1dFVGFsTEV0TVovUXVrNGxPeVVWY29rbHlKUjBO?=
 =?utf-8?B?NVFQWFpWSERtNGozQVVnRXlVdkh5ek1FazIwN01rSCt3Z1NkTzhzUlpNcmQ2?=
 =?utf-8?B?SW9MRkREVEdaL0NFKzFSbGorV3RVamZXR1NlQUhDbFNnNWo5cHVwRDlWUXZK?=
 =?utf-8?B?OVhhRnlodmxjT3k5ZFFXcEtQdkVZZ2FTWVNPL3d5VGZHZmN1V1Zlbkp3KzVs?=
 =?utf-8?B?KzBNWkwxcncyb1FGcGhXc01TTEdmVDdGY3JtQzNKVFpYWGFiOE8vL084OHRB?=
 =?utf-8?B?MlJSZUtjZ1pmOW11Vit5UEl4WGVYRkU0NmdaYUhKdnZvNEZLL2Q5QmI4UGI4?=
 =?utf-8?B?YU5uenZReEs1Vm1NNXRJZ0J2RFhoNVE5M1F0Vml6MWxuSTFlSU1Td2hpbEpC?=
 =?utf-8?B?eXJaL0pTay9CZUVJOEZqbmZEb2s0QTh4WE14WllJVnk0WHhORmtDY3dTTndR?=
 =?utf-8?B?M015dDBxTHY4MXBpbVNTeE1NcUxLOU5LV1k0Wk5MdzF6VFFPZTRmNTZPNFZZ?=
 =?utf-8?B?NzZsMDQzWGI1Z2FMV0c5c3N2MXlCUVYxWXhDVStmR09RRGFmNWpqWitOVVZU?=
 =?utf-8?B?bDNpcnZGM2pOSkFRbkNTOU1EOGRsNnlUWGZsUXMzWmYybHc2NmtFNzRTQStM?=
 =?utf-8?B?L3ZueXB0dE9tcVRaRkJGU09IbFZtVzF4a3RZbEV0eDN0TTYyeFdlaG4zU2M4?=
 =?utf-8?Q?QCPgdO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWdqc3pMZGtDMDdOanRoYUtWZkJPdDk0MDhXYnRUa3ZKdTBMTnFFWkpPSExF?=
 =?utf-8?B?KzZwZnF4YUFGVnphUWRVZE1vZ2pKOXpFYS9rSHJMdUhYeWhraWxwQXdaTVc0?=
 =?utf-8?B?aU45QmgxL3RzMmNnd0RXWEFCV0ltUWFKOThReUZmS3ZCQzhHbWRjUmNnZ1JK?=
 =?utf-8?B?UXZnVTdDbXFpcmQ5NXNWd05tamxoL2t0QlhGdWIrbWNCSXRlM0lpRWZVYnZu?=
 =?utf-8?B?YVI4ODZPVEV1VEZJLzRYNGpKaFNmUXdxNzIyZUFDSFJiM1BkbnFmaVJKR0lJ?=
 =?utf-8?B?dlQ5Z1BtNnFMRFlIQTdKV1RyVCtIbXFyZnRkYXE0R25BVWhyd2VqQ2hnVEpW?=
 =?utf-8?B?QXQrU0UxZGJWSEdFbkVZTTFVYlhjTldYa1FMR2p2ZEtybDFldUl3MUZ4TGlU?=
 =?utf-8?B?VXB1eXFvV0lPVHBYZlpjNUQ0aHpqRVllM1d3ZmlGMVpQdDEwaGlRSjhieFR6?=
 =?utf-8?B?OVJzdXpSbGQwbUFsOEVpcXJTK2hBMXZxM2RrTlZ6VDJyYVR4RmpkNXdrZUZv?=
 =?utf-8?B?aHEwS1JXYzlhVTBpZ3NVVzJNbFlOaHAvWFZYWWhlZmY1eXRMZlNUTU05ZVpY?=
 =?utf-8?B?SzVGUk1QZ0pjZDJaWDNpTU00b1RXSjhtVTl0ZzNRaW1naXFScUtxSmZqNXlE?=
 =?utf-8?B?WGx4M2RGckV2eGhVOFN0ZFJsaTVMZDdBSU1NSklJQzFUMExlS3FQSVNtanYv?=
 =?utf-8?B?NkxkWFI4RyswaFpzMUlEK1J2OHgvUnlzSVQyYkk0b0FycVV2ZUtyaE1NbmVI?=
 =?utf-8?B?TXNnVVhUK2ZZYkhrdTQxdkhGRWZTeWhkWGVFN1RyWGJyVVhnczl0cUt0dXg5?=
 =?utf-8?B?TjNrVFFBUmZkajc5dGZBUzFnYXNDb2MwZThTcXIvN080K24zMU1ScmhXZVZ6?=
 =?utf-8?B?N2ZrVDNHVW51dzdSZGovcEtVdnhSOTN6ZWNpYlhLV2lJL3k4SHZHVHkya2dB?=
 =?utf-8?B?bmZqakthTUVKZUtMN3M5U0pZd1RsLzNQRXhDNE5HaEwvRkl5ZjdLbENzVHBS?=
 =?utf-8?B?cUkwM2JsZmZtdjM3V3gzbUhiU1RuNHAzYlBnZlFkZFZ4L1g1Q3FNYUoyQUZM?=
 =?utf-8?B?T3hGZ1RPVlVCQ1dQYytpWTJQa2ZuRUUrN0c4STkweFZzcS93V09ZSzZJZ09v?=
 =?utf-8?B?K3pwWXJqc2dGU2hROVZ6Tjg3QXd3eW1pWi9uZ1d2S3cxcEZRUmVCRmhYTjdu?=
 =?utf-8?B?a3NIa3Q2ekRkeUI1N09hMjQ0UXdOanVyV0J3Z2dueFJDN2dZMGlnL05QQmh5?=
 =?utf-8?B?MFdBVG1Bd3lTbVl0U2FWWDVjejFieCtnOUc2eDNBTUhUWVFpa2RON1JLRXl3?=
 =?utf-8?B?VVU2N3RiODJsWUVyNXQzRHRvWWMrcmZwV2FYT1lnMWUyZjIyOGorekdMN2Ja?=
 =?utf-8?B?Y2tneGU0QXZOSllPWmxCeStDQytCY3NsNTRwbzdibzlGUkpONGkxSThneGND?=
 =?utf-8?B?U0ZoUUVjVFZ3bkJSZGViMCtjK055dFNsWGtpRWlRVmtJbjhnSjdpM1Fhb2ZZ?=
 =?utf-8?B?c2tQd21nNG9BWlVMU09mOXpLRUVpN3Iwb0ZEdi9wSWJIYVRQQWh2enQ5SjBG?=
 =?utf-8?B?SjFlTHZLY0RoRUp6aUpyakptUEdNc3kycVZpS3NIbzVnUy8waUJNNW5vWjdx?=
 =?utf-8?B?RmpMNHBXMkZSa1hJdFplMmwyalU3cW5WUVhzZTlVSjZJTFY2NENlc1hic2pR?=
 =?utf-8?B?eHIxVktYVWYzMzdSRVZZMkluaWdkWWNNclBKS0traVY0dTl6aTE0UUVFVTVx?=
 =?utf-8?B?UlVwanFwaVdQZFVkZEFJYVlJRitVREtZVDJPU0xUc3VXUVVMK2pGbGNSUng1?=
 =?utf-8?B?N29aaXpHYnZDcUdmcXE4MHRQWE5TVGtXeG1yOHU0SE5yS0xYWTFnVytQK1U0?=
 =?utf-8?B?ZVJZQVBlNkl3OGRObFlmdmM4Mnp1RXoyTEtFTU8rMW9Ob1NMZW9hbUJ5dDVK?=
 =?utf-8?B?R3FUVDdIMTg3U05KNnFJcWdtckdhMklRdnBBTFNwSHRsWDdsYTRCY2VUQXp4?=
 =?utf-8?B?YW12RWtJYXJMSXQ5NjhmOVQ3NlU5QUJlSTB1VmdVdUkvR1Q0QlkvK0NsbkQz?=
 =?utf-8?B?MWg1N2dyMkpXWThxNk8xOFlNdW51NDF3Slh5YmVkaWJHOTE0UnUyMk91WFdp?=
 =?utf-8?B?OFBlSDVaTldjRWl1QkpNUFZMUlFIMHpVUHdlZWZadW9qWHJLUytIb0tPT1hZ?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8139883f-a3d7-476f-c16b-08de36e489c0
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 05:33:52.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3ViRILDMjGy9O3Dd5owValV04fEBbFm/Q5U7iZLGzbrJv1QGYdOB0gdIpSSI5tOMU0mazSfvTYG3pOdb1BM2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7053

Include headers in ascending order.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f7a9f46ea0dc405e25f312197df4b2131871b4bc..9e79b313ba12f92455c009ae3ade01d1e566465e 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -8,25 +8,22 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
+#include <linux/clk.h>
 #include <linux/debugfs.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/spi/spi.h>
-#include <linux/seq_file.h>
 #include <linux/err.h>
-#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of.h>
-
-
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-
-#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
 
 /*
  * ADI High-Speed ADC common spi interface registers

-- 
2.47.3


