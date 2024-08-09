Return-Path: <linux-iio+bounces-8354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D094CFF7
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D01F284546
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E5193094;
	Fri,  9 Aug 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="M/SwYdVH"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D119155CA5;
	Fri,  9 Aug 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205909; cv=fail; b=EVfZalYjxqYoqRUfPwiwqVxu2480ZG6Q7XlfblXnTwzpp/RvO1/zhBU0NZ0WZlthp6LWfglI+D91cIWJstXlDZ3a4qjPuISpLdJoP/cf5Uy1qMdXmL6eaBfN34z9BWMQ5aOw9fnUFqi/YSFLCXmYJt5AWywtEbFeR0qj5MqkJ/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205909; c=relaxed/simple;
	bh=xfjDqKeZq3hw4vSDbgsti9Xm19rVWSB/xIPtDokkcyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LKNFSDlUggRvXpOKoRRpX8RdYqaL+03yEvYod4499EWnzrGSjEfYv+XSfO6+Wb4aDzs/444xpPF5PtUu3WxfjkZKMi41tVdxtihHWVhCxsOD8+V5R+nziPRihOPqt0j3bKhLPhIafmdUTiBW7BkDMI/UivkwpSyMtppUvntjhZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=M/SwYdVH; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gicnO+ikCom+04B/yBUQwaQGESD1qCPLHYdgBKR4j3knFXzSMnnlq4A7NQawUiuqw4jc3g7rgUB8MJEExMuCPDVJ0JKNINWeTHXj8/VAMpwJh0E6HG08CQTQdeXf6iR4UOu3uIpDB6YvHqTPjwMQ95SXV7piH4wZEC7wWB7BbQmRwqjlBgtZe3CHnNhqeXvpIa/Umwsyh331xyFWzLorMVKBEJ8ski5PP+DBQfFhi0twCikOrqa+pu4yQgvPZ2qtRyMgBL7E3uUHz6QdmUVZabtLLUAFhJcSQk4brFwfk0SYKeHpROBCh2ynAEDJcHrv9LnugQ22+ekp4ujpKAswyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfjDqKeZq3hw4vSDbgsti9Xm19rVWSB/xIPtDokkcyE=;
 b=nyC0iHkbCRUfgyDn0sjMB0U7uvPxmx7FxBeY32EjBbmnnMw4HKB8+LO0yUIZdm4uoU6YLVF067XBiOJtNkfatP2y16FxV5Ap3FEiOwyc71EPLYIEqhhjM93NM4pjuAUHQ2vXB6uClVoLylgs0pGpkygMXy0hMvV3BuEjIllKW/tHaYIA2eXlVl55Si9nh8ZtKGOyvnCCXtRPTN3BeVuKVUY6L2GjFfUY0nrSKMBcX5xMZl5q8/FYht6GNfSD9Q/hnV78IyWNuv/DVzuABc63iWbqLiaRKEiMV2otoDjQHTGzPetz4fz6Ls7Pp1CvSmsImnqqXGEZSMEMzuHhxwHn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfjDqKeZq3hw4vSDbgsti9Xm19rVWSB/xIPtDokkcyE=;
 b=M/SwYdVHkvSppgcz5x11tGyIfh6zYPwRgBmREmuQUONJYjK97WFkHW2epZ94mujh6N8yFaqT4xzVoVugvhClAFS5F9COk36QyXx1BJh0uS9dfgwhsdwwRGPQHWHsZ3uoEKMbhtzlTGxlvEsnrtGKhtiyMJA9/P2GIjdBNF13YuLWMYEkPeDnbG1R0Omcq1d/b6esd1OansPV9/Q2WJFkqNZElTTn3m35rVK0c9Z956r7LScXWShlsAJ7dzNSULssulTMK+lxM5SYu4P+PQm3VBwqGZ7VPlYAzlwMjwAu/HncZ6SqaRWp3NLgbcpU5AJBs/D1j3vZcaZlygRuBiN5aw==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by PAWPR10MB6807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:337::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Fri, 9 Aug
 2024 12:18:22 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 12:18:22 +0000
From: "Shen Jianping (ME-SE/EAD2)" <jianping.shen@de.bosch.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: "Lorenz Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>, "Dolde
 Kai (ME-SE/PAE-A3)" <Kai.Dolde@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "dima.fedrau@gmail.com"
	<dima.fedrau@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>
Subject: RE: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Topic: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Index: AQHa6k2uA9cl/09kzkKzfXi0qtLeGbIe1LGAgAABl4A=
Date: Fri, 9 Aug 2024 12:18:21 +0000
Message-ID:
 <AM8PR10MB47217E50E6A7E20DC5C89973CDBA2@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
 <16c09207-48c6-4988-873f-772fa277f3b8@wanadoo.fr>
In-Reply-To: <16c09207-48c6-4988-873f-772fa277f3b8@wanadoo.fr>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|PAWPR10MB6807:EE_
x-ms-office365-filtering-correlation-id: ace3b387-3f8b-4ad8-b914-08dcb86d5c5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmVCZUpQcmJXamd1QUZmaGh0Z2s5YUpRenA0QStRc0N3TmNIUk5hdWJlWDFM?=
 =?utf-8?B?ZysxLzlXZFZvam9rb3ZGaSt3OUxHdE1KUHh4Y2EvYWNnYXNGVU93ckRtREs4?=
 =?utf-8?B?ZU1kb1lFRnNzaUh6b1RLd2NzVndPTHlnMUJiVW9LalJrMDIyUThZbStEcHN4?=
 =?utf-8?B?bWhabmpUc0t3WTVtUGhKRkwvck03cUNnNUFHRXFnWlVsZGVhckdidUR4S0Iw?=
 =?utf-8?B?a1lhektmZGhPRmltNUEzMnRhVUdXQjV5TVp2T1UxK0o3WnY5SkRUUjA0MWE1?=
 =?utf-8?B?SzhCNXpLMmk1TkRSSkF3K2FmdHpxS0kvdDRncGhodXNEYWo1U0pydW9DMjB0?=
 =?utf-8?B?QVpsYStqUmdjTTQzcGFrOFVwdU5tay9CM2pPTjZwK3FHYk1tUVNnZlJ2U29o?=
 =?utf-8?B?Y2FSUDh0bFBHRjRqTnJxa2NFeE9FZDNIRE1aTFNqSGlXSGR0NEpDc3dxV1Q2?=
 =?utf-8?B?RjN6Sys5RU1sb1ZXVlRVZkdqQnFiK09uRWhCK0FnSG1oWmNkVks5NlJyM01V?=
 =?utf-8?B?OFpQOWJTbmMzODd4eEhMUC9wNG90eGM0MHRjdFJtNVRyK0RMdHBocjRnZHYr?=
 =?utf-8?B?OUJXcGJxakZha2VOdkVKb1ZXVmphUkxVY1oxYnJ5YzVyNlJvUE9CODdjL3Jr?=
 =?utf-8?B?S0Vxb1J0VXA4all4YlVTODc0bEh3Q1g1Vk1nbG9TdmFOYzNMZGpqQjRmZ1FO?=
 =?utf-8?B?SC9aZlJFNEw3dVpNZzJsTFBTWVRiUFBubVVWeVdsVWVGelVRalBkZ2xPN2ky?=
 =?utf-8?B?Q2tXNzBZNjN3Mkc4V2o2SW9ZOTdwUDk3UjRQVjJqdlpORlhHMFpIZUdqQ0Fu?=
 =?utf-8?B?aEswalVIK3UyK1NtZ1NSS3BiMW1UWi8rcGdMK0pET3VZM3RuSkEzcU9mRTNP?=
 =?utf-8?B?dVFSQnhUY3htSHg1TVhvVnhtS3RjUUhMa2dXWTVacVBtRTBPaHBiaDlqeGJ4?=
 =?utf-8?B?bkd1VVJFWDE5VExGVUdDNXBWcTVtbHV3VVk0TlZPUHJvOGdEclFCUTFOdkpz?=
 =?utf-8?B?ZFBLZ2pDeW5JM1dlNU51Sk9WSUltbTlWUG00RXdIQzZ0VElzMkZYK1NkV29F?=
 =?utf-8?B?YmJXZVNzN1A1dTY1NlM1VTlqd3AydTZWcVJraVVYQlRUMHJEWnJzeWJyRER4?=
 =?utf-8?B?VlZVMEg3bVBMN2xza0RTa3c3Nm5PZEw2TzdKV3ppRWM2ZWtpVnErVHkrM01B?=
 =?utf-8?B?M05iejhqVnB5a09FZXVGMEVYN21ZZkJESjJta1NHVnFJTWIrRm9HMHE4UzRx?=
 =?utf-8?B?a01iUGFWaHZoaHhCQVpsMkhqbStuUk9LY0xxWjBZUDlyR2hqVXZVbklrOE13?=
 =?utf-8?B?SmI1cDB4ZVJxVUZkb0hEbTBQaks4S0lWOU1MckhhU3JOUUlEVnFrTXVrNFdj?=
 =?utf-8?B?TnJrVVJQaGsvSEtTb1Zadm8xL0Y3TEYwUUZpc1pZZmY1V0VZUnVrcVFTeWs1?=
 =?utf-8?B?WUROUXVSRFJTT2VHRCtpVkwwSEVMQTcybW9QTkFnLzM5eVIyVlZ0Ujloblli?=
 =?utf-8?B?aUdMNitnNXhtWm5YSDdwS3BFdVZsZFRRUThtL0RMekRucmh4VTNSQ2hzMjZJ?=
 =?utf-8?B?V2RNb3NadFlYQVRaMUVTYmdHa1dwT0x1MDdLM29FN1ZVY3doeDRJTWYrbTVo?=
 =?utf-8?B?ME1rZWhDWjdWRk1KeWpmQldQYVpBWVg3U05LZ1ZLMmp0R2hoZStRK2RKNG9k?=
 =?utf-8?B?THhyby9hL1VWSUxaWlNoWDNXSUNVeEJnSHIyaTN2OEhvOURSTjdGWVFscmI4?=
 =?utf-8?B?aTM5ZnVFbWk5cExPUnJ3Z0lxdmxCcGgydnhuaHZlQlo5a0JBYzlka0pyRE1r?=
 =?utf-8?B?RC9OVlpWZlN2dWp6NnhzRWdrUUJKanp5ZVowK3h3UFpRN3l6cUl4ZXlZSXlQ?=
 =?utf-8?B?cG03RW83cjk2U2tXVk5LMzE3eGhXb2ZlUm96VUtHczFYQ0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEIvY1IrblpEZisyam1jbWVoTTBIcXRjU2lUU2FNMk94VVBGV3ZERFlZZnN5?=
 =?utf-8?B?TUwvb1M5WFNlSDExdXl1bUZYMnFleGxxd1NFZjJyRnY1ZEJRYXpGb29MV3pi?=
 =?utf-8?B?aHhRUWExSWhtbk5PdkZoZFpEcTlUaHVZVDNGaEw4NXkzT0JhS240WCtIUGhI?=
 =?utf-8?B?dVFXbHA0c1RPV0V6aDVYRHdtSDZtNmxQd3JOemJwVURxV0FUQzB1L0l6OUl0?=
 =?utf-8?B?MHlSZmFHWXdOczJ1c3VlbEkrWmlTRmdlYmJEV01YbjdGaWRwTktUYS9TbXJ6?=
 =?utf-8?B?eDVxZU1SYWV0NHJycHh4aHExUEs0QTZEOHNwMXlGc013cDRsellyakJjME1X?=
 =?utf-8?B?a3Qya3JYU2lNOTNzZmk4bGlXMlhMRVMzakRkZlh0TEd4aFlsVHBDK0lRUDNG?=
 =?utf-8?B?TlZqOVBlVXpiVnlHbXFVaXNLVGhMY3BVNzlJdjFGK0Z6OS9FRHQvaVNqdjF5?=
 =?utf-8?B?OThWc3ZOdkVxYjFTbFo0UTFDbUszaWdoNWVia2M5OWNsQkVIaXhoc0V0eEh5?=
 =?utf-8?B?ckh1Y3JkS1NXWlNyVllWT2FyYXM3RTZ0K1FERzQvbEdrVzAxT01wSUorY3A2?=
 =?utf-8?B?ZjZ6OTBwZW5uRDV4ZzJDc3RnTk5mVGNQeW5VNy9URHdkV29senpkUWpqWTlN?=
 =?utf-8?B?bE96Zjd1d3QwRjNRVk81cEhVZm1mdFJKTFVZMkVjUFRuWERkUWd6YmtubnJs?=
 =?utf-8?B?UVp2T01GaVBDUWsrcHA2T1RRcDlSSW1FNFRZQWpDUWdFS09KcTk3bk92V3dx?=
 =?utf-8?B?YVFxM2dieUs3dnh6Y0dRMjJqWk52UGdzT2xlWmVtQWE3V3N2UEkvZGoxOFpW?=
 =?utf-8?B?cEhhNW1DeUx5eGp1Q2dOSndkcWxqYTN2QjVDaWNrWGo5RVQvY3BiQko3VHRR?=
 =?utf-8?B?UjFoUlR4cGlsV2ZXK0NqTWJ4RGpNWWlDak0zM041SGpydmFJazEzN0xXWnUy?=
 =?utf-8?B?VktRRUY3NVVRV3ZyeFp2aHQ3UmIybWtRTmo3bzFYQnU3bVJvS2dJMDVFSFMv?=
 =?utf-8?B?emJreDFmV2pjODJkQzFIVlM5NkIweFdaTXlkZjd4L3F4WDcrblJMM0dpMElH?=
 =?utf-8?B?MHNMRzdBNXlZZDhicm50c25oTmpCUU1kckZnRjZjWUlvRmtGRzd3OXVvRHVk?=
 =?utf-8?B?NkF2M2hFYlJ4RXcrdTRrWDQ5SkQvc21jS1JxakI4dll0RTVjSk82RXpOUFBI?=
 =?utf-8?B?OFJMampIajlpSXRCV2M2UVAvaDRONEt4NkQ5VXhBVzFrVUVKTHpSSnVSelov?=
 =?utf-8?B?TW9QVXI3Zk5mNFVzUnRrazY1dE1OR3JGdUNoZUY3MG9hZENMUWd1KzUydEpI?=
 =?utf-8?B?VVZmVXI4aFhFU2RZRHdWWWpFRWFTUFFTV0RPdlZUU1hpQ2NISkdYSHJ6NnQ3?=
 =?utf-8?B?cks5bnlLbkZLbEY4OFNpZHBwdHJJNjQ5N0JrVGh6bnN5Y0p3TDFZY1BVKzN4?=
 =?utf-8?B?WTlzMHRmUzZxdXNxZnFWdlVKMTJ4ZEYreXBHRTBBdmp3MVovQ0QrbjBVYnI4?=
 =?utf-8?B?TlN0SFp0V2toWXU5c1ZqOEs5UVo5T0xZWFpOOWZhRVBnYkMvRGZJb0RCZUR3?=
 =?utf-8?B?LzJOdXNTSnA2VkUzVG1VUnZLZk5IQnRyYkt2WGZtbmhjdEh5ZFlPeS9NVUx2?=
 =?utf-8?B?S211K0VwczdJSjdycUZibTZVcVluNk8zV1RpbU5admNkRVoxczhiRURibGds?=
 =?utf-8?B?YXVTYnZLYlJEME9QQkh5TUtLZDFicEZhQWpQK3JrL3VuNS9ISFExQkNKOTgw?=
 =?utf-8?B?U3RjQkw0bzNSNlNCUW5iTVM3Mm8yNEV0M0Rna2oraEFCdXVDK01xenpIYldo?=
 =?utf-8?B?ZXFFalN1SWRLYXhoTytudmZ1WEh4bmJxQWY1Q2NseHVsc0N1TUVtZWxpUVIv?=
 =?utf-8?B?RFQzS3ZqYlVYSjkrYWYzem8ya0sxVWZQSE9pb2tDTmFZRDQwT3o4L2ViREx2?=
 =?utf-8?B?YkNmMzZwQUlYcXBGUG9sa3hXREw3K3NINURNQVZlc090WFIxOElrT1dudlc2?=
 =?utf-8?B?UTYra3hNY1BFc2NIZ2FVNEFSb3V5ZDdReE9qVmJua3NMaVlrTTlVT2lIQkUz?=
 =?utf-8?B?WDk2SkZEK0kySk5GU1Nnc055RURvQlBPc3V3SElXV0tpN0QwTEgwWmNIR3o2?=
 =?utf-8?Q?VwmA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ace3b387-3f8b-4ad8-b914-08dcb86d5c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 12:18:21.9657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lf8G+7qAwVv0eTkD9DHj3L97O1MDnX1v7H2yFy05tM7NlK2+4+xcj4mxEPYZNt+k4csUrHBvMzg4pAd66rc1xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6807

SGkgQ2hyaXN0b3BoZSwNCg0KLi4uLg0KPiArDQo+ICsJZGF0YSA9IGlpb19wcml2KGluZGlvX2Rl
dik7DQo+ICsJZGV2X3NldF9kcnZkYXRhKGRldiwgaW5kaW9fZGV2KTsNCj4gKwlkYXRhLT5yZWdt
YXAgPSByZWdtYXA7DQo+ICsJZGF0YS0+Y2FwdHVyZSA9IDA7DQoNCk5vIG5lZWQgdG8gZXhwbGlj
aXRseSBpbml0aWFsaXplICdjYXB0dXJlJywgZGV2bV9paW9fZGV2aWNlX2FsbG9jKCkgYWxyZWFk
eSB6ZXJvZXMgdGhlIGFsbG9jYXRlZCBlbW1vcnkuDQpJdCBkb2Vzbid0IGh1cnQgdG8gYmUgZXhw
bGljaXQsIGJ1dCB3aHkgdGhpcyBmaWVsZCBhbmQgbm90IHRoZSBvdGhlciBvbmVzPw0KDQotPiBU
aGlzIGlzIHRoZSBmbGFnIHRvIGVuYWJsZSBjYXB0dXJlIG1vZGUuIEl0IGlzIGltcG9ydGFudCB0
byBiZSBkaXNhYmxlZCBieSBkZWZhdWx0LCB0aGVyZWZvcmUgcmF0aGVyIG1ha2UgdGhpcyBleHBs
aWNpdGx5Lg0KDQouLi4NCg0KSmlhbnBpbmcNCg==

