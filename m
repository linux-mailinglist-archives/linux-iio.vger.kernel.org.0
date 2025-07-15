Return-Path: <linux-iio+bounces-21677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F92B05613
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 11:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B663B5AE3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0F02D46D1;
	Tue, 15 Jul 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="X2KqY9R5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B171F4615;
	Tue, 15 Jul 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571049; cv=fail; b=U+PJQ4vd1NNkMoFlU/ErA+xMRSfUh/FvQPQu8mwNU8CUoTHvy1UNKor+fkJH2Ha9fxLUSpGM1tFa8HGGL53PtxNWeUmn0aHVQKnRqveTKnwjyhQbeTEITF4rbjbJaRooMkPgRXgdsHShNQUhlejATx0i9tQWE5VXX7QBui+nR7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571049; c=relaxed/simple;
	bh=/o+bSD5mvso9vvHjJ59Y/AzaqAwj/n96c+P3N1x5/iA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aay4eBBwzYToDAC3KyrJzjm7aPe+A5Wnz3zME5GHIlCpaMw2Ak8o46MpGU8ImVvbz5Byz/Yy9f8zalTp0mxngzUc8fynD2reEm/cMA7rjfjf6Heg+wCVl9QAWP4oIUrKbuwWrzKmt5uxKJDpj2Z61cU63uZHBu8finWOHjbFlk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=X2KqY9R5; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ELo6cX013827;
	Tue, 15 Jul 2025 09:17:17 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012000.outbound.protection.outlook.com [40.107.149.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47uh2mhyyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 09:17:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6xxjDMJ/nz0/OOyFuOsy0lwq4pZh3vyO3XGPUlJIveg3qlTqgp/IjYxEb7i2KEEv1ayTS99f6u9Mp7voJTtormCuOSdL9A/VaJlfS/7I+Lh4Xfx1HcMrn9GEdO+FuYk2L+d2J7yd4ix5SVM9B1wOUUjsOku5a6lDmFnttqJ5Xhti+sRSDkcdWIWwHyRshC8Eb8TY81aaPy/kLqTQXLUZOOK7+zL3oZtapXle4ATpBWLG3fNniNkS4F4RCgL6boDeevAjXgr//pII1bcUaDKdIFCwom5JtRU+/ywCL4ClpIJWtV9IGOLdw55zzpA2D0qSCHxJWwvOyfbohEJb8rPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o+bSD5mvso9vvHjJ59Y/AzaqAwj/n96c+P3N1x5/iA=;
 b=f5auOnV7GLw0ZxEaAllzQ4vI7Y3l734Fzv286HexeKtc/i/hRSerhacMFkTup70wFrfH4d64qiA3aNoSR7OOgb2+ZtlGZyR2x0VX3W+hCVZGJBiXRk0D6M8V1LZV3zK8JDid4sz0OKGUlirQPBjIlVgjzzCN/lXbly48J0huo6QrbAhRyhOIGSqAOH3wtBZYD0psoe4C35j0u4+BYGyLBtJgNBHRKTc/U6myr0+RVyIsE8DhhcvX0U0NjDs0nIqrynpVMVuPh0/uBfFmK7lcOjUlH+dg4Sat3CjQl7kDm3T02FYdYHWyIHTAbFigzDJZvKU1h/zX4Jfwh0ziyd/Dmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o+bSD5mvso9vvHjJ59Y/AzaqAwj/n96c+P3N1x5/iA=;
 b=X2KqY9R5tBIB0WfhDsKgG9TXgGhNwpWrc8VfGDEtjMupdw99bDTJjuA2iymgerpkIRU6qSRJPejWgZ8997R+zJkZWSWbMHbeCArc08LwZKVAqhxF72qocq63OCp4U7sa6bwPcgHV9O01TgPRFqptyLya7qmIzJs3KoOx4eLNsmM4lt7MafYsdG+RnUQVf1ANzTB3qQFV7egrmBDUQ/OvIhoOah2MmUQoV6epNnfY5kzEpfPRAkMwX4QGxrPW7/HUTup8oRFz1BaWNquJh6gzzLPmA9HS8i4ti4Dqk6e2Dyh6+/9epHAsS0tkqKfNf57vjGnp3cU+USifHaRWDT3qAQ==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BE0P281MB0163.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:12::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 09:17:12 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:17:12 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>,
        Remi Buisson via B4 Relay
	<devnull+remi.buisson.tdk.com@kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 5/8] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Thread-Topic: [PATCH v2 5/8] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Thread-Index: AQHb8XjFf1xXeBUsO0GR/zXYnfKq3rQyFsOAgADXaUA=
Date: Tue, 15 Jul 2025 09:17:12 +0000
Message-ID:
 <FR2PPF4571F02BC266F9F1668F1BB0CF4868C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-5-bf76d8142ef2@tdk.com>
 <9d091fe4-3068-4e8b-8a9c-49c25036a216@suswa.mountain>
In-Reply-To: <9d091fe4-3068-4e8b-8a9c-49c25036a216@suswa.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BE0P281MB0163:EE_
x-ms-office365-filtering-correlation-id: 8cbc3b57-c990-421c-0940-08ddc38061f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|19092799006|1800799024|921020|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTBrQXJNMUY2MXBwUUlLQmlkWFFOSVZDSmZtbzhUTkZvTDVZcmtHbEl4S1pE?=
 =?utf-8?B?Y3BrclBwYm9IaXZVazVWNmNpY0xWNWlWSkF4SGhRdGs5Z3dQRmpIODZkOVdq?=
 =?utf-8?B?L1JwNlFtaXJUNWs5VzQ3M2FoMnJVY2Rid2l1NjE1MTBQaGgxOHFVT2NSWnBy?=
 =?utf-8?B?SWF5SUJMejFNc0w3WDAvaW9UN0RWQXhoV1BnbzcrbDJCcG9kRGIvekdKYjBq?=
 =?utf-8?B?Ly9LVExyNHQ1dkNiR0Z4eWZoMTJ0eEhpclM5eXh6NS9XODRtWUdwSkpyTVpV?=
 =?utf-8?B?d3lyTUIvVUVKeUhEbkJhQnk4Zk9iMC9qU0g1dkVNNm1qSHV0SXdqSWx2aHBE?=
 =?utf-8?B?MUYrUHhOaExpRkRidlBTQXg0WTNsU3A5c1hBVStWMU5aVjFIQmpZQVZUNUc4?=
 =?utf-8?B?RURidTV1akxQc3lELzdGMkdSaXFnb1R1OUNOOHg2MU9LdmRQZk43ZTBQV1JV?=
 =?utf-8?B?aFlBYVQyNHBzaFI1RytzWUJwKzg5cXlEWkJkakhuK08yL29Lc3NCNEU3citu?=
 =?utf-8?B?bEhXVndqZGpGVy9pZjZtajFVNXRUTmUwSVJhRjRMTVYxVDIzUlNVZnFiUDVq?=
 =?utf-8?B?OEhWQTdPZTRuNC9TVDBkV3hiNGRqUTBxYTNQMHlQZiszdnh2Si9UVnBMVkQz?=
 =?utf-8?B?L2xKWVNMdnBZcm8xVW8vdExvKzhBRmZrVjVGSnhvcmx4ZWtTaHFlOC9KU1Bv?=
 =?utf-8?B?c2JqVnZGQllUMy9sejZDZGsrUGwvUFJMS3VDREloZmUwaTRONzJrSHpEN1lt?=
 =?utf-8?B?d2FlQ04rM1RZTHN2a1VaVFFRWWJvalc0ay9OQnhiaS81RWdTd1BLVGVpRFpX?=
 =?utf-8?B?cGRRSVVoeVBjdTBZbmVpcVdnb3NPM2toK2VrVktFVTJBUzVrL2x6a2NyTnBq?=
 =?utf-8?B?M2Rkdld6S0NKeE8xT1dMRkpObFNacENIT09Dcy8vdjlQaTVWYi9GcFlZd3Jh?=
 =?utf-8?B?c1VZTEYvZEV3a0VOMGpucXZuMUtOcE1rc1BlcDR4NFpibHhOTXRtemdlYjJH?=
 =?utf-8?B?Vi83ci9SQVZjcmU0b2g0OFFFUVo1Tkk0dlIwVSsvcWFkTnFvclJzaCthRGZX?=
 =?utf-8?B?aTZadnVDRUtHUE9vZEhBbGFBVmZRYTZMb0N6VFh0UHM5ZlozQlJQaWJ2UGRM?=
 =?utf-8?B?d2FEYlpabnNRby9JMk41Y28zZmpDQlBtQnJXYW1YZnFvc3VvaUY4SVdiK0ht?=
 =?utf-8?B?K3lBbVBRM0NhLzJKamwvcm9rbU9xYlhGUXhiKzUzcElsM1NpaG5lVDFYODly?=
 =?utf-8?B?TkpPTnRPZ0dqQjJlUUdqYjN1d251OGZQZ1hCSEFuTTlkWU8yV0hXMms2MmJY?=
 =?utf-8?B?K09zQ01qQ2JlNEViYUpubHRlcitDOUlFRU9IVkVvek9iL05jRlRmcm1nRDlE?=
 =?utf-8?B?MmtqZXlVOTRCbGw0bGxoZ2pxWVNMQ2pHRk02NHJ4aGRnM1g5Nk1Xb25vSlQ5?=
 =?utf-8?B?bnljMHdxVEh4RWN2Y0lDMytTT1JXTW5aRXpURkpHZGl6amZZYWx3bkNWMGR0?=
 =?utf-8?B?RzByODhOUWQ1VEZSZUZnR0tYbWxqWHJsUU55MW9sVkFXMEl0Yjg1TmlxRnNK?=
 =?utf-8?B?dGw3RkdKTjFkSGc5UndWVWZzUzA2UWUvcENlOGJFREN3eXRrNm5vZ0UzNjlU?=
 =?utf-8?B?ZGswbGZ1WGRWZndnNE5Oa3RKdmM5OFRHdWxUYkJ4THFKVnB0MXpCd2JyLytH?=
 =?utf-8?B?dUs1dWRFMEFTbFpjM1JRd3M2aGVRejFvRmkvWjNNWHR4MW1Od2htN2EwbVJE?=
 =?utf-8?B?R1FDSVc2dmxyRWpXbjBQWWRNS3gxZEdCVHdwN1V2eVQya3Vrc283QS9RejBl?=
 =?utf-8?B?VDNaUzZ3a0NLbnhZTDliR3NWR0FVWCtPbzlIQUVEbjJxT1ZiQjVsTXU0cmRv?=
 =?utf-8?B?TFMxMlV2aXJoelZDdThhbjZhUFNtMW9LYXFXZlJ3aTdRMUlIeDdaeDh6LzFP?=
 =?utf-8?B?VjdOUCtwYklzdE5FNCtRNU05VjZCNnRXNXhqM0IrMjgyRi9mVkF6SHNaU3RG?=
 =?utf-8?B?WHZzc0VkYzBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(19092799006)(1800799024)(921020)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnNFMDBhZGszUU84ZEtINzVkUSt3K1VjeDhFNS91c0IvNzF3SmF3b3Z4UkpK?=
 =?utf-8?B?RkYrKzNlTlVvbFZ1bThqQ2U5QWhLcCtIUWdxS3hOSGd0TXRxd2l4bklQbjlL?=
 =?utf-8?B?aktsQVI5VTRRc0szUGtnQThUZVRGb1NqcU9EYXk1VWFIR2RLdWZPYU14VUFl?=
 =?utf-8?B?enJUT0hHc25pNmY1d3h6L2wxQnZrWmxjaE5mdlc5VDBPamYzYU1pMmhRczRj?=
 =?utf-8?B?RGVmazhjRTBacjBTdWo3MUVKR0UzdnM5ZEh4L1RPemdmaHFlUVBRNzlzTkhy?=
 =?utf-8?B?b0p6L0VpYlFnb29Sa3JlMVhjMkpxZDFpUnpmbCt3RTBidERwZ3NEdFdkTUZB?=
 =?utf-8?B?dWJBWWNudjRwV0NJR2VaT3poODBXRVBRWFU4M2RkQTFKVkpSMjg5cmNqQVd2?=
 =?utf-8?B?ejRIS0d5Y0t0YkttcU5ZbmVqNHJMV3B6eTF5OVpYODZhblRsa2JrTUI3byt1?=
 =?utf-8?B?MTJER1J1N3RtVys3OW1ycGdNNXZTQlpHZDdIZkY1TmduZlBiR1VOeWpOYTlM?=
 =?utf-8?B?bWhkNThiS1FPTUU5cEUxZjZOV0dBVUtRSFpqTklPTEdXY3FiYXBNVjF6Z2Ex?=
 =?utf-8?B?Vzg0UjJLVjFVdGpQQmpVc05TcWhmNVZNdXRiUEJ2QUR2MUJVdUE0dGF1WGRl?=
 =?utf-8?B?YWEzb0tLWFR5S2hrY0JpeXJHd092eG5DL1JsVHRSSENqNHJDcE5IM1hmNzlY?=
 =?utf-8?B?RnVEMHRFMEdiTG1EVFRPa1YwR3FrMmludmt3ZFo0NGNoT0xudmxGNWNVVzJH?=
 =?utf-8?B?ekdrOG9VTThRcGZPQ0FYei94Q2ZaR2lWcjhrOFhQUUtndHpERXpaUWdheEtm?=
 =?utf-8?B?aHI2VGQyVFZVMlJwTkhSTE8yU21iZTcrd1crVG1IeDVpNkZ2bnFHSWo3cWNO?=
 =?utf-8?B?Mm44VXY5SGRNSThYbE9qNjdBTnZJQlFOMmVMRXlBZTQvWUhxVGQwL244aFpl?=
 =?utf-8?B?K2tlYmM5d2lkRDNmQU5nbUtibjQweVpzYmMremR2dHdSK3RvaEFIYis5OEhT?=
 =?utf-8?B?aWRzV3QrMEM2VWQ4NTlDRFUvY2VtbUtINXFzUCtRUDIxcG9DckEyTEpYaGJR?=
 =?utf-8?B?L0F4RTFhRnJTQU9hMU5PVlJlTncwdkhEYUZiMkFQU3dkVUVZcVozSkFvYXFX?=
 =?utf-8?B?Y2tDQk9GQzlSKzF0dEtKR216ZEprVkRVcE5EeFk1YWFxcDVvMExEc0djWXM2?=
 =?utf-8?B?NkdyaDZrMEUyVE9oem9wMmZNQ0N3bSt1SllxZUdHSVZnTDlQZ2pkd0p1WC9M?=
 =?utf-8?B?YmxGOUZVdEx2UElwcTVqN2VtQ25zc1pYUWh6UERPOTVmRStmVmlmQnVrNHlr?=
 =?utf-8?B?TktIMFI4eDR6WGRkclVLcDd6WnZXUytTRStUa2ZvR3FmcU1jeC9uZmt4VUhn?=
 =?utf-8?B?bFRtdzJXZGtJb3R6emZsYnNaZlZOdVl1dFlEZlZqRkZNVStpK1BQOFJtQmFI?=
 =?utf-8?B?YlFzWG80MENpQWpxY2kvWHQ4eU1tVGdiUEdQTzFWQXBjZXRNQk54cllDekhj?=
 =?utf-8?B?b2NYN0dZUnJ5UmN0VWdPU0MrcCt1ejA5TVRXakZ6NnJkdUZzdG5XVDFQYWJY?=
 =?utf-8?B?VmdGNlozM1ZsWmovK0ZyMjk1d0lIQ0M4ajJiZkdsMkNIOG1pQlBnL3doWTJa?=
 =?utf-8?B?Tm1lR25IM1R1Ly90eXoydG9Vak5LT284UGgzZkdlVGFBTlRMZmNjUWV5c2Ru?=
 =?utf-8?B?S3B5b3Y3RUZzd2s3d256UGVEVzNId1NvQzhOZ0RvMTYxSEwvWUpLdm9EQXFT?=
 =?utf-8?B?eXZKelB1YjV1ZmFqd0QvS1pVTytlWG5OSkZqQi9EUi9LdzNaUS8rMWtqUks1?=
 =?utf-8?B?a29aS1hUeHM4eVkrejRjOTVRWWluNEZuVnYyS2Jzd0hXbU83L1dVK05yN3B5?=
 =?utf-8?B?UHJqaGdpVklHaGdyLzdqeis1T2FUakJGd0dOSWx2dk81Vk8zdjFpcUlDRmw5?=
 =?utf-8?B?dW83bkJsaWwwalQ0TThRdlZhYlV0ZEc2MFl5aVFtcEhnV2JtZlJvODBscDNM?=
 =?utf-8?B?QnV1cUZoVUpaakJJNkhKWWFiYjVmcjI1TmpMekx0SDgzd0JSN1RkaWNJMVdS?=
 =?utf-8?B?QkhCb09nN1VqWUxNM3M5MmIvTFlhelVIVll2NDduaGhkL2sxM0NyK00zSDVV?=
 =?utf-8?Q?TbR8kzARAIL4pcI/Tu+7Doold?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbc3b57-c990-421c-0940-08ddc38061f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 09:17:12.2569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DMTbd/887TpJYdyfplcbLqx3jlMKDBCX9goLK8jYJx4aBGHNK9MOBUraixPMkwRgUQmnE7v4smvsYkox+FRTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0163
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NCBTYWx0ZWRfX4IlTnS0wP1cy
 5SmmUkeg1lrQD2ydQ/9BGvWBfdPjH3fpKyEP20kOezXtFM8P4SgK/jIBoKYbSAFmccvVs5DwJbh
 Fnge6kRKs+2kSl9e1l6FhgoqgIHj2B8gdTQS8pv4rqgGMZJBT5AHxGrTaGsT7bQ2nfM+h1i6hNW
 ae1jmnpbXNBHiCmTd2rLWwJ2i39a1Lh3NNpMr33+Npbw6eULJMq+mHuVLDXMOBYsnT8lP8I8737
 vow+3PMeD2IZPbgyZShHwIoHLq6M/bix58eLVwFxg+0L/iqKGGf46GJ/hV4m6WKdidB+ilb0H4L
 dCsvro86S8yq/64KrJleHeiSlYSxxEdU/RHQM4/4fDwNGc6sO2x9cZXRh1pAVRSVq8VMuyrsCYY
 Yi2foPaES1RRQ4abHhg7IqRbyrfXKSVb7fCzrhm69DE428+zkohW7THrPXSz8Gz7Txx/CbPZ
X-Proofpoint-GUID: XFidnQVwFSiZFG_9ksTyJ4dGr_z5YQs_
X-Proofpoint-ORIG-GUID: XFidnQVwFSiZFG_9ksTyJ4dGr_z5YQs_
X-Authority-Analysis: v=2.4 cv=MdZsu4/f c=1 sm=1 tr=0 ts=68761c9c cx=c_pps
 a=KlGr2jfGjhDqsS4dmcNryA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=i3X5FwGiAAAA:8
 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=wreabgCWl6lXUE7R3xEA:9 a=QEXdDO2ut3YA:10 a=EFfWL0t1EGez1ldKSZgj:22
 a=mmqRlSCDY2ywfjPLJ4af:22 a=cvBusfyB2V15izCimMoJ:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150084

Pg0KPg0KPkZyb206IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4gDQo+
U2VudDogTW9uZGF5LCBKdWx5IDE0LCAyMDI1IDEwOjIxIFBNDQo+VG86IG9lLWtidWlsZEBsaXN0
cy5saW51eC5kZXY7IFJlbWkgQnVpc3NvbiB2aWEgQjQgUmVsYXkgPGRldm51bGwrcmVtaS5idWlz
c29uLnRkay5jb21Aa2VybmVsLm9yZz47IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5v
cmc+OyBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoSA8bnVu
by5zYUBhbmFsb2cuY29tPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBSb2Ig
SGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJu
ZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPg0KPkNjOiBsa3BAaW50
ZWwuY29tOyBvZS1rYnVpbGQtYWxsQGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IFJlbWkgQnVpc3NvbiA8UmVtaS5CdWlzc29uQHRkay5jb20+DQo+U3ViamVjdDog
UmU6IFtQQVRDSCB2MiA1LzhdIGlpbzogaW11OiBpbnZfaWNtNDU2MDA6IGFkZCBJMkMgZHJpdmVy
IGZvciBpbnZfaWNtNDU2MDAgZHJpdmVyDQo+DQo+SGkgUmVtaSwNCj4NCj5rZXJuZWwgdGVzdCBy
b2JvdCBub3RpY2VkIHRoZSBmb2xsb3dpbmcgYnVpbGQgd2FybmluZ3M6DQo+DQo+dXJsOiAgICBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1s
a3AvbGludXgvY29tbWl0cy9SZW1pLUJ1aXNzb24tdmlhLUI0LVJlbGF5L2R0LWJpbmRpbmdzLWlp
by1pbXUtQWRkLWludl9pY200NTYwMC8yMDI1MDcxMC0xNzAxNDNfXzshIUZ0cmh0UHNXRGhaNnR3
IUdPOFIzWnVoWjFWRnBMekhOTXhOZ0xRaF9NblRxT2YwUWZodmdBVklNZzE1SjZFRlhKd1BJQ2xJ
OVhuM0FXcllyU2cwQUd3ZW5EeEFuZ2N6UlZQUzhaRWEkW2dpdGh1YlsuXWNvbV0NCj5iYXNlOiAg
IGY4ZjU1OTc1MmQ1NzNhMDUxYTk4NGFkZGE4ZDJkMTQ2NGY5MmY5NTQNCj5wYXRjaCBsaW5rOiAg
ICBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDI1MDcxMC1hZGRfbmV3cG9ydF9kcml2ZXItdjItNS1iZjc2ZDgxNDJlZjIqNDB0ZGsuY29tX187
SlEhIUZ0cmh0UHNXRGhaNnR3IUdPOFIzWnVoWjFWRnBMekhOTXhOZ0xRaF9NblRxT2YwUWZodmdB
VklNZzE1SjZFRlhKd1BJQ2xJOVhuM0FXcllyU2cwQUd3ZW5EeEFuZ2N6UlhlVjFvLTIkW2xvcmVb
Ll1rZXJuZWxbLl1vcmddDQo+cGF0Y2ggc3ViamVjdDogW1BBVENIIHYyIDUvOF0gaWlvOiBpbXU6
IGludl9pY200NTYwMDogYWRkIEkyQyBkcml2ZXIgZm9yIGludl9pY200NTYwMCBkcml2ZXINCj5j
b25maWc6IHMzOTAtcmFuZGNvbmZpZy1yMDczLTIwMjUwNzEyIChodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjUwNzEz
LzIwMjUwNzEzMDExNS43ZzBYV0IyRS1sa3BAaW50ZWwuY29tL2NvbmZpZ19fOyEhRnRyaHRQc1dE
aFo2dHchR084UjNadWhaMVZGcEx6SE5NeE5nTFFoX01uVHFPZjBRZmh2Z0FWSU1nMTVKNkVGWEp3
UElDbEk5WG4zQVdyWXJTZzBBR3dlbkR4QW5nY3pSZHB1LVUxWCRbZG93bmxvYWRbLl0wMVsuXW9y
Z10pDQo+Y29tcGlsZXI6IGNsYW5nIHZlcnNpb24gMjEuMC4wZ2l0IChodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL2xsdm0vbGx2bS1wcm9qZWN0X187ISFGdHJo
dFBzV0RoWjZ0dyFHTzhSM1p1aFoxVkZwTHpITk14TmdMUWhfTW5UcU9mMFFmaHZnQVZJTWcxNUo2
RUZYSndQSUNsSTlYbjNBV3JZclNnMEFHd2VuRHhBbmdjelJWck4tWGpBJFtnaXRodWJbLl1jb21d
IDAxYzk3YjQ5NTNlODdhZTQ1NWJkNGM0MWUzZGUzZjBmMGYyOWM2MWMpDQo+DQo+SWYgeW91IGZp
eCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBu
ZXcgdmVyc2lvbiBvZg0KPnRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93
aW5nIHRhZ3MNCj58IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNv
bT4NCj58IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5v
cmc+DQo+fCBDbG9zZXM6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjUwNzEzMDExNS43ZzBYV0IyRS1sa3BAaW50ZWwuY29tL19fOyEhRnRy
aHRQc1dEaFo2dHchR084UjNadWhaMVZGcEx6SE5NeE5nTFFoX01uVHFPZjBRZmh2Z0FWSU1nMTVK
NkVGWEp3UElDbEk5WG4zQVdyWXJTZzBBR3dlbkR4QW5nY3pSVzNaYkRLayRbbG9yZVsuXWtlcm5l
bFsuXW9yZ10NCj4NCj5zbWF0Y2ggd2FybmluZ3M6DQo+ZHJpdmVycy9paW8vaW11L2ludl9pY200
NTYwMC9pbnZfaWNtNDU2MDBfZ3lyby5jOjEyMSBpbnZfaWNtNDU2MDBfZ3lyb191cGRhdGVfc2Nh
bl9tb2RlKCkgZXJyb3I6IHVuaW5pdGlhbGl6ZWQgc3ltYm9sICdzbGVlcCcuDQo+ZHJpdmVycy9p
aW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDBfYWNjZWwuYzoxMjMgaW52X2ljbTQ1NjAw
X2FjY2VsX3VwZGF0ZV9zY2FuX21vZGUoKSBlcnJvcjogdW5pbml0aWFsaXplZCBzeW1ib2wgJ3Ns
ZWVwJy4NCj4NCj52aW0gKy9zbGVlcCArMTIxIGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAv
aW52X2ljbTQ1NjAwX2d5cm8uYw0KPg0KPjFmYjVjMmJmNzM0OGQwIFJlbWkgQnVpc3NvbiAyMDI1
LTA3LTEwICAgOTMgIHN0YXRpYyBpbnQgaW52X2ljbTQ1NjAwX2d5cm9fdXBkYXRlX3NjYW5fbW9k
ZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPjFmYjVjMmJmNzM0OGQwIFJlbWkgQnVpc3Nv
biAyMDI1LTA3LTEwICAgOTQgIAkJCQkJICAgICAgY29uc3QgdW5zaWduZWQgbG9uZyAqc2Nhbl9t
YXNrKQ0KPjFmYjVjMmJmNzM0OGQwIFJlbWkgQnVpc3NvbiAyMDI1LTA3LTEwICAgOTUgIHsNCj4x
ZmI1YzJiZjczNDhkMCBSZW1pIEJ1aXNzb24gMjAyNS0wNy0xMCAgIDk2ICAJc3RydWN0IGludl9p
Y200NTYwMF9zdGF0ZSAqc3QgPSBpaW9fZGV2aWNlX2dldF9kcnZkYXRhKGluZGlvX2Rldik7DQo+
MWZiNWMyYmY3MzQ4ZDAgUmVtaSBCdWlzc29uIDIwMjUtMDctMTAgICA5NyAgCXN0cnVjdCBpbnZf
aWNtNDU2MDBfc2Vuc29yX3N0YXRlICpneXJvX3N0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4x
ZmI1YzJiZjczNDhkMCBSZW1pIEJ1aXNzb24gMjAyNS0wNy0xMCAgIDk4ICAJc3RydWN0IGludl9p
Y200NTYwMF9zZW5zb3JfY29uZiBjb25mID0gSU5WX0lDTTQ1NjAwX1NFTlNPUl9DT05GX0lOSVQ7
DQo+MWZiNWMyYmY3MzQ4ZDAgUmVtaSBCdWlzc29uIDIwMjUtMDctMTAgICA5OSAgCXVuc2lnbmVk
IGludCBmaWZvX2VuID0gMDsNCj4xZmI1YzJiZjczNDhkMCBSZW1pIEJ1aXNzb24gMjAyNS0wNy0x
MCAgMTAwICAJdW5zaWduZWQgaW50IHNsZWVwOw0KPjFmYjVjMmJmNzM0OGQwIFJlbWkgQnVpc3Nv
biAyMDI1LTA3LTEwICAxMDEgIAlpbnQgcmV0Ow0KPjFmYjVjMmJmNzM0OGQwIFJlbWkgQnVpc3Nv
biAyMDI1LTA3LTEwICAxMDIgIA0KPjFmYjVjMmJmNzM0OGQwIFJlbWkgQnVpc3NvbiAyMDI1LTA3
LTEwICAxMDMgIAlzY29wZWRfZ3VhcmQobXV0ZXgsICZzdC0+bG9jaykgew0KPjFmYjVjMmJmNzM0
OGQwIFJlbWkgQnVpc3NvbiAyMDI1LTA3LTEwICAxMDQgIAkJaWYgKCpzY2FuX21hc2sgJiBCSVQo
SU5WX0lDTTQ1NjAwX0dZUk9fU0NBTl9URU1QKSkNCj4xZmI1YzJiZjczNDhkMCBSZW1pIEJ1aXNz
b24gMjAyNS0wNy0xMCAgMTA1ICAJCQlmaWZvX2VuIHw9IElOVl9JQ000NTYwMF9TRU5TT1JfVEVN
UDsNCj4xZmI1YzJiZjczNDhkMCBSZW1pIEJ1aXNzb24gMjAyNS0wNy0xMCAgMTA2ICANCj4xZmI1
YzJiZjczNDhkMCBSZW1pIEJ1aXNzb24gMjAyNS0wNy0xMCAgMTA3ICAJCWlmICgqc2Nhbl9tYXNr
ICYgKEJJVChJTlZfSUNNNDU2MDBfR1lST19TQ0FOX1gpIHwNCj4xZmI1YzJiZjczNDhkMCBSZW1p
IEJ1aXNzb24gMjAyNS0wNy0xMCAgMTA4ICAJCQkJIEJJVChJTlZfSUNNNDU2MDBfR1lST19TQ0FO
X1kpIHwNCj4xZmI1YzJiZjczNDhkMCBSZW1pIEJ1aXNzb24gMjAyNS0wNy0xMCAgMTA5ICAJCQkJ
IEJJVChJTlZfSUNNNDU2MDBfR1lST19TQ0FOX1opKSkgew0KPjFmYjVjMmJmNzM0OGQwIFJlbWkg
QnVpc3NvbiAyMDI1LTA3LTEwICAxMTAgIAkJCS8qIGVuYWJsZSBneXJvIHNlbnNvciAqLw0KPjFm
YjVjMmJmNzM0OGQwIFJlbWkgQnVpc3NvbiAyMDI1LTA3LTEwICAxMTEgIAkJCWNvbmYubW9kZSA9
IGd5cm9fc3QtPnBvd2VyX21vZGU7DQo+MWZiNWMyYmY3MzQ4ZDAgUmVtaSBCdWlzc29uIDIwMjUt
MDctMTAgIDExMiAgCQkJcmV0ID0gaW52X2ljbTQ1NjAwX3NldF9neXJvX2NvbmYoc3QsICZjb25m
LCAmc2xlZXApOw0KPg0KPnNsZWVwIGlzbid0IG5lY2Vzc2FyaWx5IHNldCBpZiBub3RoaW5nIGNo
YW5nZWQuDQpIZWxsbyBEYW4sDQpUaGFua3MgZm9yIHRoZSB0aXAsDQpJJ2xsIGZpeCB0aGlzIGZv
bGxvd2luZyBBbmR5J3MgcmVjb21tYW5kYXRpb24uDQoNCj4NCj4xZmI1YzJiZjczNDhkMCBSZW1p
IEJ1aXNzb24gMjAyNS0wNy0xMCAgMTEzICAJCQlpZiAocmV0KQ0KPjFmYjVjMmJmNzM0OGQwIFJl
bWkgQnVpc3NvbiAyMDI1LTA3LTEwICAxMTQgIAkJCQlyZXR1cm4gcmV0Ow0KPjFmYjVjMmJmNzM0
OGQwIFJlbWkgQnVpc3NvbiAyMDI1LTA3LTEwICAxMTUgIAkJCWZpZm9fZW4gfD0gSU5WX0lDTTQ1
NjAwX1NFTlNPUl9HWVJPOw0KPjFmYjVjMmJmNzM0OGQwIFJlbWkgQnVpc3NvbiAyMDI1LTA3LTEw
ICAxMTYgIAkJfQ0KPjFmYjVjMmJmNzM0OGQwIFJlbWkgQnVpc3NvbiAyMDI1LTA3LTEwICAxMTcg
IAkJLyogdXBkYXRlIGRhdGEgRklGTyB3cml0ZSAqLw0KPjFmYjVjMmJmNzM0OGQwIFJlbWkgQnVp
c3NvbiAyMDI1LTA3LTEwICAxMTggIAkJcmV0ID0gaW52X2ljbTQ1NjAwX2J1ZmZlcl9zZXRfZmlm
b19lbihzdCwgZmlmb19lbiB8IHN0LT5maWZvLmVuKTsNCj4xZmI1YzJiZjczNDhkMCBSZW1pIEJ1
aXNzb24gMjAyNS0wNy0xMCAgMTE5ICAJfQ0KPjFmYjVjMmJmNzM0OGQwIFJlbWkgQnVpc3NvbiAy
MDI1LTA3LTEwICAxMjAgIAkvKiBzbGVlcCByZXF1aXJlZCB0aW1lICovDQo+MWZiNWMyYmY3MzQ4
ZDAgUmVtaSBCdWlzc29uIDIwMjUtMDctMTAgQDEyMSAgCWlmIChzbGVlcCkNCj4xZmI1YzJiZjcz
NDhkMCBSZW1pIEJ1aXNzb24gMjAyNS0wNy0xMCAgMTIyICAJCW1zbGVlcChzbGVlcCk7DQo+MWZi
NWMyYmY3MzQ4ZDAgUmVtaSBCdWlzc29uIDIwMjUtMDctMTAgIDEyMyAgDQo+MWZiNWMyYmY3MzQ4
ZDAgUmVtaSBCdWlzc29uIDIwMjUtMDctMTAgIDEyNCAgCXJldHVybiByZXQ7DQo+MWZiNWMyYmY3
MzQ4ZDAgUmVtaSBCdWlzc29uIDIwMjUtMDctMTAgIDEyNSAgfQ0KPg0KPi0tIA0KPjAtREFZIENJ
IEtlcm5lbCBUZXN0IFNlcnZpY2UNCj5odHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9naXRodWIuY29tL2ludGVsL2xrcC10ZXN0cy93aWtpX187ISFGdHJodFBzV0RoWjZ0dyFHTzhS
M1p1aFoxVkZwTHpITk14TmdMUWhfTW5UcU9mMFFmaHZnQVZJTWcxNUo2RUZYSndQSUNsSTlYbjNB
V3JZclNnMEFHd2VuRHhBbmdjelJhZGtMcVpNJFtnaXRodWJbLl1jb21dDQo+DQo+DQo=

