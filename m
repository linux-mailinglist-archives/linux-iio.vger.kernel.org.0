Return-Path: <linux-iio+bounces-22982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F05B2C4CC
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97966724B4B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF79340D91;
	Tue, 19 Aug 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="UCF11LiS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3333CEA0;
	Tue, 19 Aug 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608496; cv=fail; b=P8G7/DC/v1FCanZAeO79qLszu557NUDokUtjvpoyM1xu5ywubWwGC/bo6YQ7Cv21qjCwm6hLC+7xp1Zn7xnavncG+EF7JlTqHOTQMSkt3/iI23XfpN6OW93QlzN2asAz9BQu2Z/4zgasjy9zNGNWGdxrx2ujWbK9TqNQYiC9+VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608496; c=relaxed/simple;
	bh=PhFeykH/7vxkgEEXzoT72G3rWm6dB+V/qViANA/TlLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K3xbTDKo0TDQbVaHFDMiuYJHkvOD9fSf7MAi6N7nK94mwugapvkZ04kibL3cx//+0ZQObla55EcJD5DJj+fOx+tTDXR84Liov7wLoTlVvCTf3uvpN4I89uX4VChVmRg/wayZQ98IgZlNomnLuK0MP3EaMtzz3YVXFE1gy3QpGKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=UCF11LiS; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57INJRgP006391;
	Tue, 19 Aug 2025 13:01:25 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010062.outbound.protection.outlook.com [52.101.171.62])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48jkbk25vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 13:01:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4gI2n3zWOfA/0zDS2fTQFq8FSpRtq64EpGFJY+CPVCuxGLZ6iifLotIwX4M8Mf82kDkGbldPc9t6C1MbCJGbE1hl+xFwd2iIK4OgDS3Y2BTE4jnB/oA8Y5iO2vvdjgd7VeAEt4v46qkKTMEZDZECMJp7oPmpHsYoaQxBR3vR7zZbC7PDcazAHM6orYGzXBl9qkc8kjhwg8zmMZkfUV/r2CopSZDvanMm585XW6bsSTuyXrMBX847N28r7S9jSUpQV4B1aGz/kwXL4Ja6MdLse5LZY4Bc6yOL752cQcKmEPXRjzz7ZozoRSnBa7ai92Y4nF8PN368YTb2tVNTyVNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhFeykH/7vxkgEEXzoT72G3rWm6dB+V/qViANA/TlLA=;
 b=e2FwRDi+M1r+sv56DyHO7jdLA/JQfDTr0839ee/+vSwXB5ENI3HMyhUJu2gtpz5PdkiWjOPO2REDgRMGUmmv2XI3t79kVijwtJN5g6jgl7xGKF2g/7wR9Re5IeaOyQCAkUEjuTa22JhojSJmn4RiN1WJdQXWP0kLsV9kIJqHz9Qehn9JvnRfGMQRLskQGTzOYUvsG3mdT/3RFGZ5xsOOAaR/9QJvjuj3GRRi2DyWIer9pJW2CRxornt9OunOm0XAmvEnU7dtVlyK4xZIqYgI4fXtpPXhrJGkcInj43rkmBIbJnXq/LvlU+N38N+N7EpULEo298BGitFGBPv90HwlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhFeykH/7vxkgEEXzoT72G3rWm6dB+V/qViANA/TlLA=;
 b=UCF11LiShrzeL2asK4owH7MnN6e9KrL5gwhhMwlL6KFwD3ppHTQvFEzK3iC8ThPOJlO7E8nvSuqOIugUuRN3hPyw6nLQC9cD7WQEVzL5V8PXfTB7MbfxWSs2AT7f2RwlfGHzAo1PGBGUqurseVUejEu3D/U7fxFj+CFp3CR7jm9WKCm3LmXPc5lZNavARRATJAP9/iC8xXOQDwfNR1U9K/k3WKCiBamc9agcm6uR5KKBvKc776x0ytz+2YtQB7aO2Ni+EvXR8IQz4i+1uehyyIgSumYelkpAEzrGFsNo13z3nWAO98EJPnkw5jnbStFinOo6aKxlkSIoDSXor1B8ww==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BEUP281MB3633.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 13:01:14 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:01:14 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Remi Buisson via B4 Relay
	<devnull+remi.buisson.tdk.com@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 9/9] MAINTAINERS: add entry for inv_icm45600 6-axis imu
 sensor
Thread-Topic: [PATCH v4 9/9] MAINTAINERS: add entry for inv_icm45600 6-axis
 imu sensor
Thread-Index: AQHcDPl6hHmixzrE3EqUJai+ozk2qbRlNY6AgATC/EA=
Date: Tue, 19 Aug 2025 13:01:13 +0000
Message-ID:
 <FR2PPF4571F02BC619F96128FE247DA2C6C8C30A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
	<20250814-add_newport_driver-v4-9-4464b6600972@tdk.com>
 <20250816131737.64905aa5@jic23-huawei>
In-Reply-To: <20250816131737.64905aa5@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BEUP281MB3633:EE_
x-ms-office365-filtering-correlation-id: 3c5d274d-09cb-419a-e3c4-08dddf207a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|19092799006|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXhuTUp0dkVKSnZYT0tPYjRMRkpBUndFYkFxbzJhZVRKNG96MzVIbFR6WTE2?=
 =?utf-8?B?ZzZTekppNjhROG9IcGdib0VMbTNnY0ErZVExVVYyQ0xTOW9weE1uV2ZQOTlF?=
 =?utf-8?B?QmloRE5ib1YzWmNRZVR6Umlkbld3TE1mVjdEVzdNcXcyd3pGZGNjRll2RGp4?=
 =?utf-8?B?SlFpYVptN1BCVkFqMXVaWVozMlg2NkM3eXVOMFpWdEdWdGt1dEJ2aUdyOGR5?=
 =?utf-8?B?ME03aDlXNm1heXdUdzcrZVV2ck9qTWdieWlheFdKTDl3eUpwUk00c1ZpdUF3?=
 =?utf-8?B?V0l4WkNQTW9wblZEWDQwU1ZuUzJJYTZlb2dmY2ZDN0xKSkFILytvYVZZTzNL?=
 =?utf-8?B?UHFaazIvQjF6YzRjSy9sdEVZT2dkeHF5YlJmUE9HbGJhQk96eGNvRTJCU0Jr?=
 =?utf-8?B?TU45R2ZoKzU3V0xmTG95MjlLdVhPcmdLUlpMK0ZrbWhLZzhYUTQyZ3RiSHNY?=
 =?utf-8?B?bkJMYkxOZDd2ZERjWnBCNHNZdGhtK1RqZzN2VnA4WlBadi8zV1dOdXlKR3N3?=
 =?utf-8?B?eU11OUdmL053YytJQVBsLy9jWmoxY0JmeU1LWWxjNVFvdFVqcTYzYWd0OW1q?=
 =?utf-8?B?UURVMDZZWGJQTGZHVFdiejhsejhJazA3Q2hQSDMrZnJGOGlQaVJWNXhiTkJP?=
 =?utf-8?B?ZXV3SVpOTGs4d1NaK2JMRllsMlZSeFN5SENvanpJTmFlenJpVW1DVFlMaXpt?=
 =?utf-8?B?bFdVT0d6NXAyMXM4bUVnbUlXakVDTXEraDl2Q09aTmdVbWU2NGQwamlqY2dG?=
 =?utf-8?B?dEhIcW93bDFON0lveDhOaU90dkVWNENLOGkvWXdpbHd0QXZ4ZU92N0dsalhC?=
 =?utf-8?B?QmFJZUY4VVZDZWhQOC9pZU85bU56alc0Tjd1THNnZ0xxL0djeVJwcWhiSURl?=
 =?utf-8?B?L1ltbTVVQ2oyZkFhTUFOYmZsL3YwakxDZURkbEEwdVZEMGFSemVzR3lxREti?=
 =?utf-8?B?UUczSmZjaytnZGJEKzNxanVVWGJQelJEbUxEYTJzb3MxRDNIMEZJSjdZZHZG?=
 =?utf-8?B?NGVzUlU2U0EzcUxPT01EYXcreTlDYjZ4eldaN004Z3UyNzBaNHJ3clFLRVpZ?=
 =?utf-8?B?YVFvVTl3WmVHb1ZHelhRZXRiWm9CZDlOQkJ0OU9TS25JWHBTYm9oM0JjaS95?=
 =?utf-8?B?T25mS20vQk1Va0M4TnRjemozdXh3UER2MnpqYkhUeFdjUTR3WHJDeXRpcVk4?=
 =?utf-8?B?Z3QvOFQ2SUxaV0hvNW9zRUR2QjUzRkk3Vkd4N01CVzZDSkU1RUJEN09CVFhL?=
 =?utf-8?B?cmk3WWl0REZ3MU5BU1QrYWQxNXBMS1orM2pKNnBGRmhkODEwckljaGhQdEJs?=
 =?utf-8?B?TW5LNFNaempvZE4yV0xQT1lJdXNhMUFQSERXMjNmZkh4bWppRitaaWpvUmlF?=
 =?utf-8?B?STJZY3hSZnJnNWU4SjlTb1NqdlBWQnRld3oxb0ljNGlCN2d5R0VmdXpqcnpx?=
 =?utf-8?B?TWxOTWlZQW8vYU1YeFcvTUdja3VsTkU0M25RM2haeVkxazQxOW5iL0k0R2ky?=
 =?utf-8?B?WUw0WjI1OHkxdTFCMk5MNmVCMFlCVU1scXhJaFNlczNsRnRPRlkyWUIydXlp?=
 =?utf-8?B?QUdtNDlwdXFSeGRxdDV3MzdhTkRjSElFNXJuemlCdyt3ZEkvNnRvYmxiZmZu?=
 =?utf-8?B?MUo3Q3pDUnBJTE56UTk2VndHTDMwdVJRWWNnOEZDOGlMbDRxWjFoWXZjd3ha?=
 =?utf-8?B?SmFsY0RPUExRRXpGSUl2VTVXeUtraWxpTC84aUUzSnVIcWczUGNzL1J3b0VR?=
 =?utf-8?B?S3BvUWJDWnhpcEJiTjlVNjBBZ3B1bzg3Zk5ZdXpVdzRWZjJZUUd2MUJJZWR4?=
 =?utf-8?B?Mkxwc0dMd0RpME1IUDFqMUpYREd3ZHJLRldhaUNKcGMzUDFnUmJ3MnhHR0Ns?=
 =?utf-8?B?NXI1TnUrTGc1ZUZ3clE0SFVlNHk3bXREUEdXeG9rZlVsSGpURlBUYTRGaXc2?=
 =?utf-8?Q?IcEawolKOArt7aWNR39eU15fJl2Hbf1l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(19092799006)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkQwbGhHTlBhNldUMVhGbE5SRUt6bHRpN2QzM295NTMrWXlFMStUL1JrZjVJ?=
 =?utf-8?B?a2t1L3dPeDVCVTJ4YzZmVVAzYVEvOXFhUmFnYTFPZHBHWE54UGxveThoN25U?=
 =?utf-8?B?TWM2OTQzbXB1a2ZiK1pLODhSNE9LZUxUSC83aktXTDMrMGF4dmpuQ1ovcXdr?=
 =?utf-8?B?bVZaeUM1aWZtWUcvanVuc1hkQldmdDNlSUQ3MCtyUFhlREQySXNCNkt0YW5J?=
 =?utf-8?B?M1g3bW1UT2lEUjAwYUs2S2pzVE45RTdJUm8yQ1d0ZkZsVHQvc2NTbnFUcytS?=
 =?utf-8?B?Sy8yUit0K1ZLUlkyWGZJZ2xIa2hueHlXa1ZvQXZrTFFiN21IdHFqRE5LVHYy?=
 =?utf-8?B?eGxmcHlQd201NVE2UHhqd0wyNFl4TkppR2RUaHZBMEdQNEF1Zkw1U2NOVjl4?=
 =?utf-8?B?OUdaL3lEY0g3MWh0NU5VdmZrSTcyNTIwUi84bXp2ZkpiV1BJYmhGem42ZEJj?=
 =?utf-8?B?SWc0WWZhNEswTlMvNFQ0UHdXRFRuRURKQjhQajZQZ3RLV1RCSDN0K1FKVjI3?=
 =?utf-8?B?em9UMFREdFZUblpiRW9iWDhwL1RVN3pJdzlTMHQ2bVhTM2V1RW4vMW5HL1d5?=
 =?utf-8?B?dmZZOXpDYU5mQ2xGTmorNHpEZWZTOGhpTXRoeXpuaTJYa0RLRE00dWV6VGlu?=
 =?utf-8?B?c1l1eHBRTWNhSWNibnJPTkdnMFl4Z21RRmhLL3daN0p0QXhtVlN5Wm9XcUZ3?=
 =?utf-8?B?ZTErTUVHYUE5bjlYakRacVZFdlRocDJVYWRrRlRzZlk2NzZ2cjVndDQ3ZWpB?=
 =?utf-8?B?bWRkL3pmSVh6QzBqbVVReTFHeko4RTYrS21OMisyMmJpTFFQYlNGd3JVNnJE?=
 =?utf-8?B?QjFrZUFrYm9FVC91enk3OFdWWUNNZkdxTFIzWFZtRnhHSk4va2dkSVVPTjBl?=
 =?utf-8?B?dDJhMUc0Ymo0a3ZaTVlLQzI4aGJnUFBOMFBjWXM0UVJ0Z0kvUWVTRG5ncDRj?=
 =?utf-8?B?b0szelk2WCtEMTRHUlRZbjFiUDdxbE83OVovb3dEWWVrTlBpc1docmZWQis0?=
 =?utf-8?B?VFJacGdiOWJmUWUrblVTU2hjZ3BCL3V4UkJBb0sxNEY0eFlad2I2T25ZV2ls?=
 =?utf-8?B?SmQwZkhKbGwvanMvQmYvaGFKTkViSUtpblZiR0VzMXl5WWkza3FOL0ZqYnFR?=
 =?utf-8?B?WDBzV3A1RlZMU1ptbDV4MVkweThFM0dndWMzQjhXUnJIY3VKMktGMDdMeGdL?=
 =?utf-8?B?MWl1czVqOWY1UEJSczVxT1VZYWpCS3pGL1gvSFRxM2FPUkluN3NuK2hxa2JM?=
 =?utf-8?B?N2NwQlJpMElxYkQ4QWVJOE1KK3FaZHRCZDJJM3ZWUzlJaWlvTGVFc0xPQjRQ?=
 =?utf-8?B?NjJqaHVmWUFUK2JiaWJhYmFzYkpmbVNCcHNYOFU1TVdOb21mVUhXTXBxZnJx?=
 =?utf-8?B?V25ObTFQc1VzbmRZbW91WmVsSE41cHl2OUNxc3kyZkNTQjI3ZEJTUld2TmpE?=
 =?utf-8?B?NVU0N2lvQ3IwaXpEbG1ackpQcTFITC9ZQjNLUUxZK2I0cU9iR29BZHUzUFNS?=
 =?utf-8?B?cC8zdXRVNGVBemNRL1JsbDhQQW9pNFQyMWl2MndyWUkvRk1BejhiSFNSNzFo?=
 =?utf-8?B?aG9EVitpL1NVaXFqbUh4ZDNsQVNNbXRIaXVISkgwZThZdHhKNWoyYTY2eFZI?=
 =?utf-8?B?T2FuSkxPaWFxR2RkTU1XTUNGSy80UVUyL2hoUVZ4L0dnd3RXSVVRMGhtY3hR?=
 =?utf-8?B?MG9iY1hENklVMHFQUHpjMXp6R3Y3aWxYMzVDUlFRaTk1azlXNmp5NitORGlE?=
 =?utf-8?B?OGVMcXFLbmVibGhwbkk0YXZSWmlVTHhJd09WM1lLY2J4S3BXSFByaHVvVUhv?=
 =?utf-8?B?T0h2VGY2bENqUVd3Nm1GZms5eEdQWnZqVWdWU0wzakFGMzB4TEJlMUY4VVBZ?=
 =?utf-8?B?MVZ0SmZIYVlBeWRjSHYxaWZjOXFMclpCYkdHWkNreDZrVWtsT3BjTTNmOWRG?=
 =?utf-8?B?WVB0ZFhOejRHWm10V3NrSzJPc2p2ekRudUs4QmNsQ1UvL0lzNHJWQXR6OXZS?=
 =?utf-8?B?ajBHT2RDc2ZTYXRaajVEbi8zaGNkN0JFczF1dHJyYUlNUFF6b0pPNG81NmZk?=
 =?utf-8?B?Qm1EeDFvVjVjdC9IeUpXKzl3OTMrQlhjTk9lRDJKc1QwdnMwMmd3YS9uK2JM?=
 =?utf-8?B?eFFjYzVyZzg5R2M5SHhHaWw0QytEWElQVXpiV2dIUnV3MytHd3ZqUnR5VlVX?=
 =?utf-8?Q?JxfD4XvWxIt/kn/n0sYRscjoynCDwhgBJlUmGQVKSjuP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5d274d-09cb-419a-e3c4-08dddf207a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 13:01:13.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3MgUNP9MdY3cVW+XWHUuBmhgyVfhH1szFkM3HnFyUJLLPYFymNzoauOpaBasPrl3+dIa3kybNOqRCMtoqesoUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3633
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NiBTYWx0ZWRfX/ryer445jkTH
 stSYU8nT5r16rKuMvZv8zfH3kvYLTF5S3RbKr0jMt3zkKwdgjB5SmLuoG1FGbIoe6Q69Us/0bRy
 kMO/v4omiPNUjKiqCnIxm+lk7WQrXwoRxv3qJGBkJJMEheVJo1r4GFbjDIA9RQ5abybMAKlK7bX
 ArwYPCLOgoXvJWM8D8gli2sLYkvMkGVXlRPP+gqQrVKbMWym+NVNSCZ+2vX+lLBWWI9RXGNMg1T
 3y7yGqVKWaQHYj+TndEVbLujYJfZLP6Bqyua1PE6U4DmPX29tzaj1letBSDXTeSMi3MaU/PKe09
 /IeRnuZaV3yT0E25yqPrzInG7XkO7qLb7bmnx8Gb4pl7JMGESlHdRw7Mri74V5wN4Bl2d9VnmUM
 kPI24u+D
X-Authority-Analysis: v=2.4 cv=Ne/m13D4 c=1 sm=1 tr=0 ts=68a475a5 cx=c_pps
 a=e3GqXd3Pxf9yZ94BK4RHdg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=KKAkSRfTAAAA:8 a=Jsx2dPa9ajw8zc_NyisA:9
 a=QEXdDO2ut3YA:10 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZUS5BQ8_Vd-pCjrJCOUtucXUQyB_mSMC
X-Proofpoint-ORIG-GUID: ZUS5BQ8_Vd-pCjrJCOUtucXUQyB_mSMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160046

Pg0KPg0KPkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KPlNlbnQ6
IFNhdHVyZGF5LCBBdWd1c3QgMTYsIDIwMjUgMjoxOCBQTQ0KPlRvOiBSZW1pIEJ1aXNzb24gdmlh
IEI0IFJlbGF5IDxkZXZudWxsK3JlbWkuYnVpc3Nvbi50ZGsuY29tQGtlcm5lbC5vcmc+DQo+Q2M6
IFJlbWkgQnVpc3NvbiA8UmVtaS5CdWlzc29uQHRkay5jb20+OyBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPjsgQW5keSBT
aGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5
IDxjb25vcitkdEBrZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDkvOV0gTUFJTlRBSU5FUlM6IGFkZCBlbnRyeSBmb3IgaW52X2lj
bTQ1NjAwIDYtYXhpcyBpbXUgc2Vuc29yDQo+T24gVGh1LCAxNCBBdWcgMjAyNSAwODo1NzoyMyAr
MDAwMA0KPlJlbWkgQnVpc3NvbiB2aWEgQjQgUmVsYXkgPGRldm51bGwrcmVtaS5idWlzc29uLnRk
ay5jb21Aa2VybmVsLm9yZz4gd3JvdGU6DQo+DQo+PiBGcm9tOiBSZW1pIEJ1aXNzb24gPHJlbWku
YnVpc3NvbkB0ZGsuY29tPg0KPj4gDQo+PiBBZGQgTUFJTlRBSU5FUlMgZW50cnkgZm9yIEludmVu
U2Vuc2UgSUNNLTQ1NjAwIElNVSBkZXZpY2UuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFJlbWkg
QnVpc3NvbiA8cmVtaS5idWlzc29uQHRkay5jb20+DQo+QnVzIHNwZWNpZmljIHBhdGNoZXMgYW5k
IHRoaXMgb25lIGFsbCBsb29rIGZpbmUgdG8gbWUuDQpHb29kIG5ld3MsIHRoYW5rcyAhDQo+DQo+
PiAtLS0NCj4+ICBNQUlOVEFJTkVSUyB8IDggKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5U
QUlORVJTDQo+PiBpbmRleCBlM2IwMTA5YTIzMDQ1OTI2ZDZhN2U5NjU5YWZkYWIwYTZkYmY3YmVk
Li5jNGFhMjEwMmVmMzk4MTMwMDc0ZDIwZGQ1YjkzNjdjZTNmYTUxOTY4IDEwMDY0NA0KPj4gLS0t
IGEvTUFJTlRBSU5FUlMNCj4+ICsrKyBiL01BSU5UQUlORVJTDQo+PiBAQCAtMTI2MjEsNiArMTI2
MjEsMTQgQEAgRjoJRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvLWludl9p
Y200MjYwMA0KPj4gIEY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vaW11
L2ludmVuc2Vuc2UsaWNtNDI2MDAueWFtbA0KPj4gIEY6CWRyaXZlcnMvaWlvL2ltdS9pbnZfaWNt
NDI2MDAvDQo+PiAgDQo+PiArSU5WRU5TRU5TRSBJQ00tNDU2eHggSU1VIERSSVZFUg0KPj4gK006
CVJlbWkgQnVpc3NvbiA8cmVtaS5idWlzc29uQHRkay5jb20+DQo+PiArTDoJbGludXgtaWlvQHZn
ZXIua2VybmVsLm9yZw0KPj4gK1M6CU1haW50YWluZWQNCj4+ICtXOglodHRwczovL2ludmVuc2Vu
c2UudGRrLmNvbS8gDQo+PiArRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by9pbXUvaW52ZW5zZW5zZSxpY200NTYwMC55YW1sDQo+PiArRjoJZHJpdmVycy9paW8vaW11L2lu
dl9pY200NTYwMC8NCj4+ICsNCj4+ICBJTlZFTlNFTlNFIE1QVS0zMDUwIEdZUk9TQ09QRSBEUklW
RVINCj4+ICBNOglMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+PiAg
TDoJbGludXgtaWlvQHZnZXIua2VybmVsLm9yZw0KPj4gDQo+DQo+DQo=

