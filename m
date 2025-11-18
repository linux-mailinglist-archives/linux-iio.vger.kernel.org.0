Return-Path: <linux-iio+bounces-26280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8307AC68A52
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 10:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3438E2A794
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 09:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347C2EA743;
	Tue, 18 Nov 2025 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YhprrxvF"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538B25A354;
	Tue, 18 Nov 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459470; cv=fail; b=hgHQRBmdmFvcMfdo14t58TCvQBv5pLo6GTJRJ1dILAJoKvk+8LKxsNnC52nDVgbjuctvIM4aZEJdLu5aQMV887mZTs3l8432uaCKlyo7mCBOPxgNHe+WvEjviZHEC75yWAvxKhuzOzY9upLEJj2A4QrDStspw0Zo0kzGr5E31aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459470; c=relaxed/simple;
	bh=X3ncnz2hLr3dNO9jYwJUXURv1FlPRqAUee9sc9GggQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XyFQ7K5O9M7pZ8cbQ6AaXHvasKDeubbhkAZS+4MxN8IAhzCweyiOxEXCjaBf8Lkj0/kHFIdcbRnIKpY0OMAckFYpxkcwwPWdWtU9PrsPCrJ54aPMku2lfGynb7D8AzikGzKjMaSLAkd47hHTV3diJ2x8C3yd6k4TA3bUxmSibys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YhprrxvF; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHcF9hw9g6SxTtGQGH9e9kBt9xiYLGLzQXpN9pwgGqeL3BCHHR3dDiPyhdcAYt+YhDnpz+KBcyQfUqA1rscFawCA+EDu7hRV0OS0cC9SdpF4DZ87kSWjzclBLCNC3KJD4A/ElArTxmuwwstB7lLCiHF4bLj1vjBm5yI+088zRprMgTvbBwpJW4FqyFGPBm6ftaqrxCyVrq+OBAKSl0OBAxMeSARFo/jLxObIOwanRPea3U3Jqmu55r4fADAdp/elkwh6BPg99d6o828VXILoWDcFtYIfYZZ9bDurZfgnH0STw4iCUypxJqTeVA3YeMCd2OvVv8pPgVHJueUyPcuSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3ncnz2hLr3dNO9jYwJUXURv1FlPRqAUee9sc9GggQs=;
 b=nyu6/UGQ2GWUiHxD9cHsOLuhHp3q4xfjLJ2yG/h0ohHBkW0oKqORlYP4J/Z/A+DatYZ+4MPFlEU64pXOMST4B25L4O8fs3Tnwne9ztwzx8ZMTTu2v/UTDc6U48D4P7NSoq3eH6c7XOEhdsygmHv8O++p6Mtp5k/tYZRx2G8XE6XLT1xo1ClTencJJ9pzKDRsaNFTl1CCMNTnLwGqg3pmqAE1pGXdYp8Aw3+naDAhhZRaUBWIi1ge62KLWOqVGtDtaLmeEv2Gu0qXV+B7V/8P3j4JcSTw7Qk0nuM7tDyCO+OnSuM1FvVuhBoB+aBZkROKjpTnq+qZidr0pcO6SQlszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3ncnz2hLr3dNO9jYwJUXURv1FlPRqAUee9sc9GggQs=;
 b=YhprrxvFl/K/kuZRflpGmmlWcAH6zm3psXTlqNXeb05BlTCS09wQf4+ROgthNCZa8Yc2RLlVWvpOfyCl4rwKZfy1SzsvHSMI6pqHNof3uPOp7YvhqhqpEypej04iWqxV6z3NHmX02HobYqTkjRrKI8y/wN3TCFHv1T9R1RqT9uP9rW9hL8NBMSfE99CPV6Pvr7bM0ZCYNg1/9G0/VBoD2KQiZ6iHflK3jCmgU31+WbVNhjt0KxZH2TY78k7pfVmq8cYyScc9PbKhaKPSqRfBOg2pb2qiTC+PxYI+RrjAHFafY9PKtU5g9QvTLghzLAncenuXMCRuJ+eavOcFcBsssA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB6998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 09:51:03 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 09:51:03 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
CC: "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "wbg@kernel.org" <wbg@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
Thread-Topic: [PATCH] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
Thread-Index: AQHcWGZkr/tRP+Xi4Ui/hhb0tWUS0LT4JkAAgAAKpQA=
Date: Tue, 18 Nov 2025 09:51:02 +0000
Message-ID: <c23143c9edb2444e145849d46794d580715eeb8f.camel@siemens.com>
References: <20251118083603.778626-1-alexander.sverdlin@siemens.com>
	 <aRw4mIZpWdsr9exb@pengutronix.de>
In-Reply-To: <aRw4mIZpWdsr9exb@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB6998:EE_
x-ms-office365-filtering-correlation-id: f89da78e-a7ea-42ef-0950-08de2687fc69
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bG8rNzI4YWFSV014SWZMQ29vTXFsREZSTjZHbDJmdFlrQjBYVloxRHlGUmx3?=
 =?utf-8?B?TUFHVitEWFZ0UStFSnY0Qkk2Y2RtNDlGcXdWWC9tNEd4VTlRUmt0TzQyMEFV?=
 =?utf-8?B?bVp6bnoreDgrL3F4QUg3T3g0SGdPemhHWER4S1owR1hoUDlZMERjdTlxbmJ2?=
 =?utf-8?B?T1FDNFBNRlJtVVRWS3g3dmNKdGFYYmZRVzZTajQ5UVcrNDdHWVFWcFRrMmM0?=
 =?utf-8?B?ckxBQUplMjI3N1hQUXl5VGU4TkhENEh1M0hFNnd4NkcwSzl5b2taVFlQZXgv?=
 =?utf-8?B?U3RqSXdHQWd4QU9Lc2JpbmRXVmxlWWxVNVNXMnB5dytLdWJhVFFyQndtVVEw?=
 =?utf-8?B?ZVExeEJrd21qakFETVdBWlFORjA1RW10SzBLN3FyNkNibjhEWDEzQ0RHN04r?=
 =?utf-8?B?WTRIY2ZMUHE4bnFKV21ML1h6SlBobUU3c28vTU9UVlhzclppcU41aUYvazQ3?=
 =?utf-8?B?Z3R2MFRJTTYyRjNVSUgzTmt2NnJSdEc5N0lOSFZ2TjdBYWh2QTV4dUVSSWVl?=
 =?utf-8?B?K1VaeFd1OE9aWVo2VjlPVzFqdG1KZi9IMlhOb3RDOFBubEZ1NnJXMGxPS1Nh?=
 =?utf-8?B?Mi8xZ2tEYkZXUEVTanZEYm5JUzY0THl6WHVjaHBUN1RDQVVId3VRT1MxWHV4?=
 =?utf-8?B?MVdaMkJlMDd2ZW1tRkgreDFXV1NkVDkzcTB1Qm9JdFhpaWU3dXdGUTVsdU5Y?=
 =?utf-8?B?YnQ0aXNUMVg5Ylp2eVllRWIyU3lnY2ErTlUwcjJYaVl2R0JTVHJUL1E5OG9m?=
 =?utf-8?B?SUJ6bmptbXFaV2pDS25vZXBnMGZlMUNIYnVSTlV2ZUx6cUljbzFRc2FBM3JU?=
 =?utf-8?B?ZzluWmorakhIcEhvVWNnNnlobWNNWmk3NGhPRzNlV0RLazMvSjVVaXcxVVRX?=
 =?utf-8?B?bXFSb3laTTQ4RWJRSndkTHhyQlFoVTJXSXIwNTdXZ1BtdmdXa0VpNm1qUjJh?=
 =?utf-8?B?RmZKdVk3d0xWemxBUTBZaXBqQStOaFdRZEk0YlpLQmpaMEk5TGZHMTNSeDlo?=
 =?utf-8?B?UHEwOXFSU2V4RjBOM1NhbFBySDNsbEIvdmYzOTFMRnFrNlREdHZka2RBSTFC?=
 =?utf-8?B?UmlxK1pCQ3ZCMkF4dmVwblFBbGdKa05GaFVtb2hrVVl6eGgzckZiZ3JjOGg0?=
 =?utf-8?B?UjEwZGg2blJieHFWZXV6Z2tJYllhSDJhQkV5TnhvMUVaRXJmdG5rVVZZRkh6?=
 =?utf-8?B?emRvVm9oSHVzMVZXVjEvcVM4NEk2VE1QR1VxTGd1OHhmRVJpTWtlODBrWVJv?=
 =?utf-8?B?MC85cWM0SklZYW1ZbU12MFdDMllQRGF3T1JKYXVDcHIxeU5BR3JyOXhQNGMw?=
 =?utf-8?B?b3lybzlOaGd6YWppUUcwczF0VlhvQmRBZGd6MHQ0YjJyMjBiYjhhSGp5aEEz?=
 =?utf-8?B?TCtrSWtLbWhydXVVSGlzc2RkSWdBRndEZFlpWExPM2tXdE1VSXJ6N2g4dXhU?=
 =?utf-8?B?Q012ME5Jc1RpaWkwOGNkOFFRUmtMdVFkQkxWRkRuZCsrOG9FYmFCTGMydWly?=
 =?utf-8?B?N2oweCtoRGtqbzdQSm9Tam1FU1ZBeW9rbk9oaEtPZ2dSSTRsSWZaT3ViVm9F?=
 =?utf-8?B?cFJkekk3R0NORTViQlM2RXRFYzJTcCtjZmp0TWs0RFFVZUlmT0piZnM4SEF2?=
 =?utf-8?B?UEQ4OTRrb3ViRlppOTNETStZUWNVWXhlMVh5eFkwRWJhSTY5VjNRVUo3QzQ4?=
 =?utf-8?B?UUZ0YTZzVkVVSlIrR3JvQ1V6MnBUNlpNemwyUVBaWVdhK1JPZGNOeGdleFJ2?=
 =?utf-8?B?UVUxVEFLU1pQUVBwOWhoU3Q0VnlNb3BIdkpOanNVc2hUcHdYMGdCU0J2U29P?=
 =?utf-8?B?ZnN5dnZIZHpCaHZJSmNYOS9uWUFzSXdUcCtaVHBJZzF6WEhoTU14aFZtcnlQ?=
 =?utf-8?B?eHFjand6R0tJbllhTXFsbi8yZXRxd2E3TE9iRFNWcHJIVXZlc1dtVjhJVWVZ?=
 =?utf-8?B?ZTlmOUc1T2F2ejR3ZXNyQ3RVa2lualZHdEJIZTZtaHFSeDhXTXhCT29wdU1W?=
 =?utf-8?B?cTFTaWhmM0c5Z0FnUGdsN01BeW0rVDJseXVCZTlqR0hmWUc4bFNDRG40TU9r?=
 =?utf-8?Q?GKPeZA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bW01N2tUWEJkM2pDcDgxbU9NRzlSZVJ1QTZNMCtOU0lBRG1nUlNOL0pJbEhj?=
 =?utf-8?B?OHZLSlRYVkxiMDdBVi9YeHBHdFdJQ2NpSlJSYkkwREQ4QmJzR0FKdUZUN24z?=
 =?utf-8?B?YWNpQ3cvdWJERGdxRFF0MVo1S3g0KzNUYStOL0JpZ1pDalFRTEpHajdYRjN6?=
 =?utf-8?B?eWFOSjlUSmloYVQ4dFZsdVdzV0RRc3IrTGZFVFRGT3VwaVVZVDFrdFEzWG9R?=
 =?utf-8?B?dDl3QXFxZGxNb0VxaFBsVUZMS2twZ1RXWllFU2o5dlUvN2dudEhMSnExdkdW?=
 =?utf-8?B?ZDVwaGV3SmpsUnkyME1vdWpZUmt3YXVVcU9qNVd5anBOTXc5dGtoT3pVTFQw?=
 =?utf-8?B?d0o4c1RTYmcwbjVwUnIxTlN2alA2NGw1Z1FlZDR0Z0pwNThnbExJOVdPazNt?=
 =?utf-8?B?c3BiSGZaemxCK2hXK0w4Z3lkbDZUOVZaM1d4ajNJRzZ1T2h3NVFienVtWEF3?=
 =?utf-8?B?WjE1ZzF4eFBuelNvd2dDOUQ4Ym5QRTVidzE2R1o4Zm1DRWhISTJZQkR4Q0Qr?=
 =?utf-8?B?WGpJaExZcTlKaGRibkFpOUFKTWJFUjRVMnRHV1kxeUNEWE02My9HbU5Qb2Jh?=
 =?utf-8?B?d05IRzZ2L1I1eC9HU0laeHhHbExNK0pseXR1S2U2STZkc0xtazhMVVQ0dTh2?=
 =?utf-8?B?TGJXMklycjBFT2FPSTRTWXJDaXlLRktpQk1jNDNyYlQwS0Q5bzIwM1BiaWZE?=
 =?utf-8?B?bkZpR2ZPaTduT0hDZ29PRHBGQWtxeVlweVB1U0FDRmdOdmtWanc5YXdXMzNm?=
 =?utf-8?B?TnI4WFpLdTI3czNuWHJrV0RiMGRKVG5VZGVUczB5M2ZRSkxFa3ZKb1I4L05v?=
 =?utf-8?B?clBYOW1walpLZGpxRnZtTDRNWGhSNmJKc2VjZW5CTitnMHR4aTFmbHBGKzZ1?=
 =?utf-8?B?bzFSWUpkQzdvYlhkUEt5bkg4cUN0RktTM2JBOGdIVUJXbDZyUUtodDJzS0tK?=
 =?utf-8?B?M1k0TFZPWEZYeGRMdWZQQ3FYUkFlNS9tMCtPY2VLMmp0OC9NWFhrYS9vTWxM?=
 =?utf-8?B?b0x1TFk2NE9hRDE5VkF4UjVDRzBTQ1FNbHZ1RGNKTEdPRlJhNVNjU3dPUitv?=
 =?utf-8?B?T3lSbVlVZjFUaHozbGJkb1JJQitxdCtJOGsxbU9kdXpnaUJneDhSSW9WTnAx?=
 =?utf-8?B?Zm1NaGZHbStFSldRK3M2eVFkT2VQc3p3NHRxQ0duMnRLalNDOFNCdjV3ZDdv?=
 =?utf-8?B?WWVnWEpNMjR0UXNMeSs4OUFkSDZZQVB0VTdndHozZXhPTWV2d2xpYVh3bFBl?=
 =?utf-8?B?dVlLczg1K05ZL3hYdEFaNVhlOUJYYW1jQmJMUnVwaUFhaWZjR3lDSDZZVTFT?=
 =?utf-8?B?OHN6eUFGQjc1eWRCdjNsTXYweWp3VitsMk1Dc1VHK0p2K09BMWJ2eGpUaWVl?=
 =?utf-8?B?Q0RjZ1ZmT004eWVpQzI3ckVtMTlpa2lRazFBeWkvVTlHOUx1QVFmZUpETGFF?=
 =?utf-8?B?MUJZNGFFKzZNa1NuZjFzSEN2THhVeVVVcDN1K2RpelVEK05LR2NUTkdwSm0v?=
 =?utf-8?B?dW9KVTl3d3NSK3czRDhhTG0vV2plMWVXelRwSDVaUE4wUm1ZT04yN1lialF6?=
 =?utf-8?B?cmtGeUdEWXJSSzdVVUhQU0h5dHpPd2IwMzZOYThrNWZQZm9zeW80SXozM2RR?=
 =?utf-8?B?K3BaQnpxZHo4Y1I4SXR6RllyYVZjQTJhN0Z1WEJ6ZWNtV1NGaVNRNWVTV3Vo?=
 =?utf-8?B?NzY4QktkVmdINDdXL1lra0FRc1cvRmt1S0o0Rkc0aFlYbXM0TXVMZGtXdFVx?=
 =?utf-8?B?eVJ4QklUMWVRMlNkTitFWmdMOEdDT0lyVzBqRk81bWttTnk4TTIxcHo5aEZF?=
 =?utf-8?B?Z3IzclI4ZWRaN29heUNuYnZmNU9jTmRQL01lRjFOd1BNcEo1d2Z3TEg3WEk0?=
 =?utf-8?B?WmJidTFuR1NkbDJHV0ZuVzFMRmxINklVUE9VVDlibzBndE8yMVRUVmk1TlVI?=
 =?utf-8?B?RVIvbkd2aENyOG1uUUc1blJvaHgyYXBJK0NtUUoySjREdDUyV0pOUFdmN2p1?=
 =?utf-8?B?cldPU21xaFdSdjVETVlGZS9lenBIblFYbkhYREMrVDRJTk1Tby9mbC9wTWtz?=
 =?utf-8?B?TUtlZGg0QlZJdjlRR3FMbFFOUEQ5Um1YR1FKbkNFcFlvQzFka2VMNUtIMUxJ?=
 =?utf-8?B?NWZJT3ZyYmVxaHpMK3hMQnZMRUdHK1E4QXU5TGxQVHdZYXJHeWZEWTM2TDVM?=
 =?utf-8?Q?utWK5VJxQNbHYiMMfFsP+7I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FED0FD0AEA774B48BAA9E5CBB6D3867A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f89da78e-a7ea-42ef-0950-08de2687fc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 09:51:02.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9mYsjtM58GccPCmZXRBKgwxUwYQlNw2VX9cMuCvdh9hcvnOQBWxIuWbR1AAWVInR6Blsb5UWmjxcqhsGyUu9milPrpfxTd2ia/1CJ5O7Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6998

SGkgT2xla3NpaiENCg0KT24gVHVlLCAyMDI1LTExLTE4IGF0IDEwOjEyICswMTAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gPiBBbiBJUlEgaGFuZGxlciBjYW4gZWl0aGVyIGJlIElSUUZfTk9f
VEhSRUFEIG9yIGFjcXVpcmUgc3BpbmxvY2tfdCwgYXMNCj4gPiBDT05GSUdfUFJPVkVfUkFXX0xP
Q0tfTkVTVElORyB3YXJuczoNCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+
IFsgQlVHOiBJbnZhbGlkIHdhaXQgY29udGV4dCBdDQo+ID4gNi4xOC4wLXJjMStnaXQuLi4gIzEN
Cj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IHNvbWUtdXNlci1zcGFjZS1w
cm9jZXNzLzEyNTEgaXMgdHJ5aW5nIHRvIGxvY2s6DQo+ID4gKCZjb3VudGVyLT5ldmVudHNfbGlz
dF9sb2NrKXsuLi4ufS17MzozfSwgYXQ6IGNvdW50ZXJfcHVzaF9ldmVudCBbY291bnRlcl0NCj4g
PiBvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOg0KPiA+IGNvbnRleHQt
ezI6Mn0NCj4gPiBubyBsb2NrcyBoZWxkIGJ5IHNvbWUtdXNlci1zcGFjZS1wcm9jZXNzLy4uLi4N
Cj4gPiBzdGFjayBiYWNrdHJhY2U6DQo+ID4gQ1BVOiAwIFVJRDogMCBQSUQ6IDEyNTEgQ29tbTog
c29tZS11c2VyLXNwYWNlLXByb2Nlc3MgNi4xOC4wLXJjMStnaXQuLi4gIzEgUFJFRU1QVA0KPiA+
IENhbGwgdHJhY2U6DQo+ID4gwqAgc2hvd19zdGFjayAoQykNCj4gPiDCoCBkdW1wX3N0YWNrX2x2
bA0KPiA+IMKgIGR1bXBfc3RhY2sNCj4gPiDCoCBfX2xvY2tfYWNxdWlyZQ0KPiA+IMKgIGxvY2tf
YWNxdWlyZQ0KPiA+IMKgIF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUNCj4gPiDCoCBjb3VudGVyX3B1
c2hfZXZlbnQgW2NvdW50ZXJdDQo+ID4gwqAgaW50ZXJydXB0X2NudF9pc3IgW2ludGVycnVwdF9j
bnRdDQo+ID4gwqAgX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNwdQ0KPiA+IMKgIGhhbmRsZV9pcnFf
ZXZlbnQNCj4gPiDCoCBoYW5kbGVfc2ltcGxlX2lycQ0KPiA+IMKgIGhhbmRsZV9pcnFfZGVzYw0K
PiA+IMKgIGdlbmVyaWNfaGFuZGxlX2RvbWFpbl9pcnENCj4gPiDCoCBncGlvX2lycV9oYW5kbGVy
DQo+ID4gwqAgaGFuZGxlX2lycV9kZXNjDQo+ID4gwqAgZ2VuZXJpY19oYW5kbGVfZG9tYWluX2ly
cQ0KPiA+IMKgIGdpY19oYW5kbGVfaXJxDQo+ID4gwqAgY2FsbF9vbl9pcnFfc3RhY2sNCj4gPiDC
oCBkb19pbnRlcnJ1cHRfaGFuZGxlcg0KPiA+IMKgIGVsMF9pbnRlcnJ1cHQNCj4gPiDCoCBfX2Vs
MF9pcnFfaGFuZGxlcl9jb21tb24NCj4gPiDCoCBlbDB0XzY0X2lycV9oYW5kbGVyDQo+ID4gwqAg
ZWwwdF82NF9pcnENCj4gPiANCj4gPiAuLi4gYW5kIFNlYmFzdGlhbiBjb3JyZWN0bHkgcG9pbnRz
IG91dC4gUmVtb3ZlIElSUUZfTk9fVEhSRUFEIGFzIGFuDQo+ID4gYWx0ZXJuYXRpdmUgdG8gc3dp
dGNoaW5nIHRvIHJhd19zcGlubG9ja190LCBiZWNhdXNlIHRoZSBsYXR0ZXIgd291bGQgbGltaXQN
Cj4gPiBhbGwgcG90ZW50aWFsIG5lc3RlZCBsb2NrcyB0byByYXdfc3BpbmxvY2tfdCBvbmx5Lg0K
PiA+IA0KPiA+IENjOiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9u
aXguZGU+DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBMaW5rOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTExMTcxNTEzMTQueHdMQVpyV1lAbGludXRyb25peC5k
ZS8NCj4gPiBGaXhlczogYTU1ZWJkNDdmMjFmICgiY291bnRlcjogYWRkIElSUSBvciBHUElPIGJh
c2VkIGNvdW50ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxl
eGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+IMKgIGRyaXZlcnMvY291
bnRlci9pbnRlcnJ1cHQtY250LmMgfCAzICstLQ0KPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jb3VudGVyL2ludGVycnVwdC1jbnQuYyBiL2RyaXZlcnMvY291bnRlci9pbnRlcnJ1cHQtY250
LmMNCj4gPiBpbmRleCA2YzBjMWQyZDcwMjdkLi5lNjEwMGI1ZmIwODJlIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvY291bnRlci9pbnRlcnJ1cHQtY250LmMNCj4gPiArKysgYi9kcml2ZXJzL2Nv
dW50ZXIvaW50ZXJydXB0LWNudC5jDQo+ID4gQEAgLTIyOSw4ICsyMjksNyBAQCBzdGF0aWMgaW50
IGludGVycnVwdF9jbnRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiDC
oCANCj4gPiDCoMKgCWlycV9zZXRfc3RhdHVzX2ZsYWdzKHByaXYtPmlycSwgSVJRX05PQVVUT0VO
KTsNCj4gPiDCoMKgCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBwcml2LT5pcnEsIGludGVy
cnVwdF9jbnRfaXNyLA0KPiA+IC0JCQnCoMKgwqDCoMKgwqAgSVJRRl9UUklHR0VSX1JJU0lORyB8
IElSUUZfTk9fVEhSRUFELA0KPiA+IC0JCQnCoMKgwqDCoMKgwqAgZGV2X25hbWUoZGV2KSwgY291
bnRlcik7DQo+ID4gKwkJCcKgwqDCoMKgwqDCoCBJUlFGX1RSSUdHRVJfUklTSU5HLCBkZXZfbmFt
ZShkZXYpLCBjb3VudGVyKTsNCj4gPiDCoMKgCWlmIChyZXQpDQo+ID4gwqDCoAkJcmV0dXJuIHJl
dDsNCj4gPiDCoCANCj4gDQo+IEhtLCBJIGd1ZXNzIGl0IHdpbGwgYnJlYWsgdGhlIHJlcXVpcmVt
ZW50IHRvIGhhbmRsZSBhdCBsZWFzdCAxMGtIeg0KPiBpbnRlcnJ1cHRzLiBNYXkgYmUgd2Ugc2hv
dWxkIG1vdmUgb25seSBjb3VudGVyX3B1c2hfZXZlbnQoKSB0byB0aGUNCj4gdGhyZWFkPyBvciB1
c2luZyBkZWxheWVkIHdvcmtlcj8NCj4gDQo+IFJpZ2h0IG5vdyBJIGRvIG5vdCBoYXZlIG5lZWRl
ZCBzeXN0ZW0gZm9yIHRlc3RpbmcgdG8gY29tZSB3aXRoIGJldHRlcg0KPiBwcm9wb3NhbC4NCg0K
SSB0aG91Z2h0IGFib3V0IHBvc3NpYmxlIHBlcmZvcm1hbmNlIGltcGxpY2F0aW9ucyBvZiB0aGUg
cGF0Y2guDQpCdXQgdGhlIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gd291bGQgaGFwcGVuIG9ubHkg
d2l0aCBQUkVFTVBUX1JULg0KSG93ZXZlciwgaXQgbXVzdCBoYXZlIGJlZW4gYnJva2VuIChhbmQg
YnkgdGhhdCBJIG1lYW4gcmVhbGx5IGJyb2tlbiwgbGlrZQ0KInNjaGVkdWxpbmcgaW4gYXRvbWlj
IikgZnJvbSB0aGUgdmVyeSBiZWdpbm5pbmcgaW4gUFJFRU1QVF9SVCBhbmQNCkkgc3VwcG9zZSB5
b3VyIGluaXRpYWwgdGVzdHMgd2VyZSBwZXJmb3JtZWQgbm90IHdpdGggUFJFRU1QVF9SVCBrZXJu
ZWwuDQoNClNvIG92ZXJhbGwgdGhlcmUgc2hhbGwgYmUgbm8gcG9zc2libGUgcGVyZm9ybWFuY2Ug
cmVncmVzc2lvbiBpbiByZWFsaXR5Lg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVu
cyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

