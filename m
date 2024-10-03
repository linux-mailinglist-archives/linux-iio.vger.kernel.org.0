Return-Path: <linux-iio+bounces-10098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5925F98F921
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1994A28259E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571C1BFE10;
	Thu,  3 Oct 2024 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="KKT+R3/n"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925984A51;
	Thu,  3 Oct 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991892; cv=fail; b=W8YpcLVAYQZEqeTfeIk/Dm+Ra4CMusbXSoLzNdwDQYXSuKSoMKBTTPV0EISLvw6t0cqN0e/r/Y7sViJNlqkUV4ii3qoxONcsUzTJjKqp+9BwQDnHaH7KMswFKOhykV02sWCTx09tTByiytsKMo0/mErlDZLaFrS18ioFySkAkYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991892; c=relaxed/simple;
	bh=XFLUHf7zjFkal5nG51Yr/kNXXigbQWunUdSeFsnN8mg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q1AUAOdCYmC8idP+U+19kRcdFJdeH8al28DLDTyenp9wKuNjnHz/6OSP1x8RZTmLUpVW7nROqv/Kxoprb6RzNDlqv1QkEs9JOkBJ6/DfT4a8GqiTiW+myhR8v32iED8CPlYSXBTruGu0w/GLyDnep2vF54IoJZAiy+KLoJpopwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=KKT+R3/n; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWrCNqRe0iBD664iDib3OBTpLFc74U1Icw6Z4r59TZXJnitWNRu68TZJyKK5SVLFifeQvCQ1MveLDj6x1VSJOtMMgDc5MMkV/0unTHl8RwBiE8aye7xXaQB9sR+zCw8I9snFBqE9CULxfWNYVTf7HzfrYs1Mufu5fw8ldzwrHKcXR/s8GjUVAD9Qw/3og1ul8aVXwNU3Jth0gyC6HT4JatAmD3D1Tl7bpJdkGrpnT/ehp4rn3yM7ncN4QyzaFOaus1glDGze3p1y/A1QopxWrRSY0lGpXGTTFN728Ld3J+Obl/KOhPOUqyWh2rTwtzVnyYShgecl9QBY+pAtK9SXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFLUHf7zjFkal5nG51Yr/kNXXigbQWunUdSeFsnN8mg=;
 b=gd90Fw7a9tE1NOpm+jYsUVLAoozjMrz66DCEdaVcrjM6Mk3/VP4lcJDSWwrMhW0IO07mJjsCg7q0JPjFwr7VqjrrBIEos21ero6UKKwGsI42SHI3fgVSnZ5K7+7CUCNZgXJe02Sgyc7mHNZijfupLybVjrtUgAda+KacXtWqHA3QPQP3WjDEhVEoJ/FtiW3VL1TR+5QsEt9lP1OrAclFgobbdsh9nBuMTKdTcTD3ceZTw1s5Nz6PH7L0u947rsScY0f9lyqYS+Lm3wF2NPtdGkJrWgpppSV2XsHq3HrL2x77prSSX7Cycg+GZDk1l9HJ8svNy1wib/ENg5rn8/Hxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFLUHf7zjFkal5nG51Yr/kNXXigbQWunUdSeFsnN8mg=;
 b=KKT+R3/n1gCLKlfWSxcIFJK5dlnrqDl8KWcePZd1+gzXYrsnUQPz1oI++ci9t0eACUm0vkZugfcksCdTj2ZUTG63FyI4Lwd4oXCMGjKtJveZO4rfajPuPi+iQRzSsoZ3reTY26xc3n+k8Ap7zVGEKt6wNbbl+A+GFqqt8XGCX4Sv1Dfu5/Y7lsRL5NMgIltjMZL9F9lyWfCyRIxVzsJN2yYAYVP7YfQvkPuq8LqRSAlpIdDbLK95TIWl7kNJgYLG+vKK2j8myXeIJ0yRB/fZvgB2O8alL0fXIE3VMDcrnn9M+/d6sX9+pFh6HfOgM8UVDgRkHB1GXxSGmhj0yDn10Q==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by AS4PR10MB6133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:584::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:44:43 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:44:42 +0000
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
Subject: RE: [PATCH v8 2/2] iio: imu: smi240: add driver
Thread-Topic: [PATCH v8 2/2] iio: imu: smi240: add driver
Thread-Index: AQHbDbXQJyb1UEtvh02vtlWF5Bgo7rJtd3WAgAf1bqA=
Date: Thu, 3 Oct 2024 21:44:42 +0000
Message-ID:
 <AM8PR10MB47217960E30212DC62ED7821CD712@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
	<20240923124017.43867-3-Jianping.Shen@de.bosch.com>
 <20240928181121.0e62f0ad@jic23-huawei>
In-Reply-To: <20240928181121.0e62f0ad@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|AS4PR10MB6133:EE_
x-ms-office365-filtering-correlation-id: d3cdae07-554e-467c-84a2-08dce3f496d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWtZUjJFeUE0NVl2TnV5dDBLbWdaVVN4UHlPNzNPTVlvMWM5VGtyRjNTSFgy?=
 =?utf-8?B?VjBDc1BtWnpwWnpSNXhVaC9MOVcyaVNIK05HTGNydmVqc2JXSDUxMTUrUWpK?=
 =?utf-8?B?TjBaUTdpTStmTkkrekxNa3kzdHlxUit0TWo0aU1VL3FWblhEYzdyTU94RnI1?=
 =?utf-8?B?VzluaUhnK0VJajI4NG1POXBCMnVINmlLTm45VG5QNm1rL2pHeE91aTNsZUU1?=
 =?utf-8?B?VHFrcUNkdExjUEZGU2ttdWFrWGowQVNEUHNubVVsVWdZOVRHbk5HM0lsVGVP?=
 =?utf-8?B?cG8wbzhXM2gvamNpQU5wbE9VNytzcnYzekNRcVJZdmRKN2dvL1NPd2oxaHgx?=
 =?utf-8?B?MTdhanlCVkVTcHJ0bFJVYVF6d0RzVS81OWJpNEEyc0dWVk1pblVVRWVkL2Qw?=
 =?utf-8?B?L21FTG8wSld1d3hSMlVPLzUySzF5amhSZENmdXVYRS9CSEFvaDZ3dEFHSDYz?=
 =?utf-8?B?dUZMaWMvdzlIQ29PSDQvR3pobG1wUVNGK0FXL2ZkUkZyV01SU3BlcUtsczVk?=
 =?utf-8?B?RnJaNG5pMk4raFgrdkhsblI1bHpzaVhyYXFlTFprakdsZU5yOXZhU1VhNU5R?=
 =?utf-8?B?SE8zMmtBYWNUb3huSTRVZnhrTWJZTFQwQTNJbmY2UGNVMldaR0pLRU85b2pw?=
 =?utf-8?B?ZVZReXBKSzhSS2JHaHJxTmJRNVd5OXpSd3JxVG92NmQzQ3Y4WTEzV05VM3Er?=
 =?utf-8?B?UFBxanRqNVBxQU1MeklvaFY5aU1JdjZrTC9xbjZzUGtmUEpLWXhqdGhEUkta?=
 =?utf-8?B?UDdjUmNGWENKRm93a1Fta29MdUEydE1CK01EdXd2Z0VuSW5MNHp2Vmk1dkx4?=
 =?utf-8?B?V1g4QUVJSHQ5Y09LK3pNUUg2VkI4KzJFYnhFOE5ISlJKMTEzTk1tc2I1Q0Vy?=
 =?utf-8?B?QlFid1ZjSkpQQXZzQklvUzdlVDMzek03elJLc3N0UGxpNUdEZWFDeWN6Y3p6?=
 =?utf-8?B?MHluWVFnWEpFNVZwYTRxaGQySEhkNG5pQzZPMEhHVzVVK2h2eG1aZE05R3VY?=
 =?utf-8?B?c1cyU0RleC8xZzlTSEYxYjh5ZGJRREJCTUplT0hZU0JEY25kMDNUeGlkbGVR?=
 =?utf-8?B?bDZQL2diNTZLejU3M2hwYnViQXVXWHB4a0h3eGE5aVpaR3JnSmpFV2dSNXl6?=
 =?utf-8?B?bFkwYnJYSCs3VGkwZVc4MEM0bndmNHJ3bVRDemc5bDBvU0xFYVFORHVJQmcx?=
 =?utf-8?B?ZC9LQXppdTFxbmxQUk93OVBOVUIyV1h1ZzBmdnR4VmhrWWhsd3FGbjhjemdN?=
 =?utf-8?B?VVRHejg4eWEwcnEzYW9IVEI2ci85TU5xNlQ2bmwzRU9VMlU2aGcySTUyMi9D?=
 =?utf-8?B?dS9nNWQ5Q2FoVHM3VXhxb2lVWFA1ZG9KOEoxa1F2cFllVTJMSVJmYW9DRHZa?=
 =?utf-8?B?dFd1STY4R2tDZ1hyTWdyRWVic3dwWlY5Zmt5YXBnTGVYWFY1ODk0Z2NRRjA0?=
 =?utf-8?B?NnlmbFZjOFIxaUM5Ni9yamcreVE3dFhGdnJTSEthRUY5R2FHZ0RhTEt3NHN1?=
 =?utf-8?B?QzBqQXRiOU10cElJeVJtQWtkUGtIcUFjYjY1SkdTQ2VtKzYrT3pmbWhNVG9X?=
 =?utf-8?B?ZlFrRVh6T3NKMU9zaWdvMUd6Mm94UEx5MS9mdGNrRVJEOUp2SmpiNGxHOU9M?=
 =?utf-8?B?VjI0Sk51R0lpb3RCQ0lVNzVEU1VZNmVQdlBYLzU2a095cEFWMjF0K3BJbm9v?=
 =?utf-8?B?aktOb2JmTWNNTndtSFFuR2x1eUdkRW9jVTRVeE9LMHRZWCtFRGdhSnpFV1FN?=
 =?utf-8?B?WnRFRnhhSkpQRS9yQXBZRXhDY2piRzdLdFV6QXV2ZjZ3Yi9EMjFhYTFzbDA4?=
 =?utf-8?B?TmVZMlVOaFB2OXdVb0Q0UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0JJcWQ1QlVJVGkyN0hCWkp4cTIvMHE4Um55Vm10cjdVTm5kTE1FNkFPeVNz?=
 =?utf-8?B?SFJZQjMrNldPd1doaTZMKy9hdHNzMHhkZVZucW55RWdiaGc2K3JyK1ZaWEZF?=
 =?utf-8?B?ZDBPZDRlTVJQMmNPamV1Mm1rRzNUR1k2SkgvVW1oSklXdHlMczdZT1k2NEdP?=
 =?utf-8?B?RW9YSm9nOWZFcmtUR0hKOGVWc2xKM09iTzBHWXI4MmFhZzFNTmY1WlZDcmFr?=
 =?utf-8?B?bE1nc3FnUEV4UkI5NlQwSlJKbnpGOTJVQS8wNm9jWDZDNWtkNWpFc3BuMUJQ?=
 =?utf-8?B?aTRyVlN6T1YwcU1KMUlvQk00SkkvSGgrb0ltSmFZa2xiTlp3NmtMdllkcmlD?=
 =?utf-8?B?OXBDWUYyOXR6QzVJeElXK3dVWm1oZVRMQmtPZkxEM2VZOFI5eVVqOWthQWQ2?=
 =?utf-8?B?KytpMW45WWRRc0NLcFdoZ3lhdVJWTUdTeGM2VlpOZTBPMjNOYVkzMmlXTDN1?=
 =?utf-8?B?cEhXdTU3ZjBJaStDYnpNL1F2ZU9sbzY1bzhPTVpsRVZUcDIyQXlGUzRRTWEr?=
 =?utf-8?B?UmtjM0plZW5KWTN3aEZaam5XaVZ6VWlQeXNYMi8xVDArdFdhOXFBaFp1WDdV?=
 =?utf-8?B?MFBQVmxUZ0t3VGU1aWcxMG5mSlg3YXJPSU1kUk0yY2RuZ0RPcHdIbkh2c0Ur?=
 =?utf-8?B?eUFqTjFTS2FBQkU3dkxoZkVkYkhBQTNrUTZ4OVJ2bExTMGR0ei9leWRlNWlX?=
 =?utf-8?B?QjBHN1lBMXVaQnova2p5OXZlS3VXTmp5ZS9UNzlLMFJmeW5LQ1d2eGN1QUdS?=
 =?utf-8?B?N0RRSEZHVDd0Y3BvUHBEYlF5Rm9hMzU5NXcxUVFCdDkybHhaYUNmSmNnVTRO?=
 =?utf-8?B?djlhNTFSbWhSelhCY2pIQk5IK0dFMXJjblVBdndCTTR5aFF6eURzL3BhZkVt?=
 =?utf-8?B?M3pTY0dLZGpXYlR2MDFRcysyWU9rVURCM0dYeFZNQ255S0tBMFJvL2pUQllr?=
 =?utf-8?B?REZkRTNhTFVmSHdZUWFmbU40YUVpRFhndTBEMUtBajJGNFo0RkJZTnl0TmpJ?=
 =?utf-8?B?elhkWXZYRDNhYlZCUm9kSlRZTUhUbmR5d3BrdW9idlZRbVlBM0J4cGxtZmd2?=
 =?utf-8?B?bGlkOEd0UFVlS2hUMEVyUnh3Y0ZqL1Y0RisyZzF0SFpQOG81MlZ5V3BvTGJT?=
 =?utf-8?B?V3RQNm9ucG14MG1PajNvbmhUa2sxNWJZZGUxZ3V0d3pUVy9STjNISkN6K1p5?=
 =?utf-8?B?azZiQ3EvYm8wVDFSMG5xT1h3N0NtWWFxUlZlSzhjVm1Qclc3RkFFbmg2dEFW?=
 =?utf-8?B?MDJLTG9hSXk4NnA5TEYyK2xZOElvSVVUa3lQbzI5aHRHbjY0b3pXS2VRd2J1?=
 =?utf-8?B?QWFSYzhETS9ENUNWUmhRVm5GaEtDSHZ5OU9SOWd2MkFyOWJtM3huSHlqVHUw?=
 =?utf-8?B?bDczSkIwRmNzenNraXd5UnRBZjVRSm5IVUwvOHRzTUlJMFFmZXVnRUlMOGJV?=
 =?utf-8?B?SjBLeXM3UlJmU05ZK2tQRjNmbWRPcVNhZG8zdjFLa0EzdTh5WDJON0xNclJ0?=
 =?utf-8?B?Z0JNNEdiU091dWtaVU9zQ21YNGZub1pPOGVuSzhWUnZUY0gyYktxMFIzV2xo?=
 =?utf-8?B?bEdCZmg1cmt0SmUxWmRDNWVFbTJ5WFZ6TWhBK3lQQ3B4YlVBdlczQ1ZLWHFp?=
 =?utf-8?B?VUN1MDRZc3F6L2VKS043cmtPcXpUek1kQXo1RTJPbis4T0liZHdXVlRXMTg5?=
 =?utf-8?B?Mnp1RjNmakNnMXp6K3hBeUJlKzNYZ3RwSFlKSVUzT3dyWnRzcEEwWTNiTnhE?=
 =?utf-8?B?SnA0Mnhha21oZFkwY1I1WC9FRjE5YU9yK3Z5ZWRyODJOclZRMDV5UUFQZ0N6?=
 =?utf-8?B?SFYrZ3RQd0hlZytSVnRYaUo1WjU1VWhVR2t6elQ0WTE2WVdHMUs2cHVyUjFO?=
 =?utf-8?B?dTJLd2pDYzhJQitXbGt0RnoxOTY4OFdic0VmaWR0dEkyTnA3NlRJZGhtS1FO?=
 =?utf-8?B?K3VpVE5TaFF3dzd1MXV6TmZVRjV5OVEwN0N6THB3VXRuU0QxNGRrbjNNN01I?=
 =?utf-8?B?b2R0SktmVkFjNk11L0w1STlyMFN3ckRkamhlZW9TS2lJYTRqY0pQYnh0bFI4?=
 =?utf-8?B?SHNNa1VscE5wOEEyWDI2WlBBVU1GdCtCcTk4bDVYK3FrV0Vsc0pkRGN1VGV0?=
 =?utf-8?Q?T0IM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cdae07-554e-467c-84a2-08dce3f496d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 21:44:42.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMDLE1OhhMoPD5OQhqMzZKGrUlnUu4Ye8VBbhmYnZJ1U58kcdoSFNz2+Ue71+l5HK9+a2ZIoi5Y9qO4NRIhEeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6133

Pj4gKw0KPj4gK3N0YXRpYyBpbnQgc21pMjQwX3JlZ21hcF9zcGlfcmVhZCh2b2lkICpjb250ZXh0
LCBjb25zdCB2b2lkICpyZWdfYnVmLA0KPj4gKwkJCQkgIHNpemVfdCByZWdfc2l6ZSwgdm9pZCAq
dmFsX2J1ZiwNCj4+ICsJCQkJICBzaXplX3QgdmFsX3NpemUpDQo+PiArew0KPj4gKwlpbnQgcmV0
Ow0KPj4gKwl1MzIgcmVxdWVzdCwgcmVzcG9uc2U7DQo+PiArCXUxNiAqdmFsID0gdmFsX2J1ZjsN
Cj4+ICsJc3RydWN0IHNwaV9kZXZpY2UgKnNwaSA9IGNvbnRleHQ7DQo+PiArCXN0cnVjdCBpaW9f
ZGV2ICppbmRpb19kZXYgPSBkZXZfZ2V0X2RydmRhdGEoJnNwaS0+ZGV2KTsNCj4+ICsJc3RydWN0
IHNtaTI0MF9kYXRhICppaW9fcHJpdl9kYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4+ICsN
Cj4+ICsJaWYgKHJlZ19zaXplICE9IDEgfHwgdmFsX3NpemUgIT0gMikNCj4+ICsJCXJldHVybiAt
RUlOVkFMOw0KPj4gKw0KPj4gKwlyZXF1ZXN0ID0gRklFTERfUFJFUChTTUkyNDBfV1JJVEVfQlVT
X0lEX01BU0ssIFNNSTI0MF9CVVNfSUQpOw0KPj4gKwlyZXF1ZXN0IHw9IEZJRUxEX1BSRVAoU01J
MjQwX1dSSVRFX0NBUF9CSVRfTUFTSywgaWlvX3ByaXZfZGF0YS0NCj4+Y2FwdHVyZSk7DQo+PiAr
CXJlcXVlc3QgfD0gRklFTERfUFJFUChTTUkyNDBfV1JJVEVfQUREUl9NQVNLLCAqKHU4ICopcmVn
X2J1Zik7DQo+PiArCXJlcXVlc3QgfD0gc21pMjQwX2NyYzMocmVxdWVzdCwgU01JMjQwX0NSQ19J
TklULCBTTUkyNDBfQ1JDX1BPTFkpOw0KPj4gKw0KPj4gKwlpaW9fcHJpdl9kYXRhLT5zcGlfYnVm
ID0gY3B1X3RvX2JlMzIocmVxdWVzdCk7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIFNNSTI0MCBt
b2R1bGUgY29uc2lzdHMgb2YgYSAzMkJpdCBPdXQgT2YgRnJhbWUgKE9PRikNCj4+ICsJICogU1BJ
IHByb3RvY29sLCB3aGVyZSB0aGUgc2xhdmUgaW50ZXJmYWNlIHJlc3BvbmRzIHRvDQo+PiArCSAq
IHRoZSBNYXN0ZXIgcmVxdWVzdCBpbiB0aGUgbmV4dCBmcmFtZS4NCj4+ICsJICogQ1Mgc2lnbmFs
IG11c3QgdG9nZ2xlICg+IDcwMCBucykgYmV0d2VlbiB0aGUgZnJhbWVzLg0KPj4gKwkgKi8NCj4+
ICsJcmV0ID0gc3BpX3dyaXRlKHNwaSwgJmlpb19wcml2X2RhdGEtPnNwaV9idWYsIHNpemVvZihy
ZXF1ZXN0KSk7DQo+PiArCWlmIChyZXQpDQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwly
ZXQgPSBzcGlfcmVhZChzcGksICZpaW9fcHJpdl9kYXRhLT5zcGlfYnVmLCBzaXplb2YocmVzcG9u
c2UpKTsNCj4+ICsJaWYgKHJldCkNCj4+ICsJCXJldHVybiByZXQ7DQo+PiArDQo+PiArCXJlc3Bv
bnNlID0gYmUzMl90b19jcHUoaWlvX3ByaXZfZGF0YS0+c3BpX2J1Zik7DQo+PiArDQo+PiArCWlm
ICghc21pMjQwX3NlbnNvcl9kYXRhX2lzX3ZhbGlkKHJlc3BvbnNlKSkNCj4+ICsJCXJldHVybiAt
RUlPOw0KPj4gKw0KPj4gKwkqdmFsID0gY3B1X3RvX2xlMTYoRklFTERfR0VUKFNNSTI0MF9SRUFE
X0RBVEFfTUFTSywgcmVzcG9uc2UpKTsNCj5TbyB0aGlzIGlzIGxpbmUgc3BhcnNlIGRvZXNuJ3Qg
bGlrZSB3aGljaCBpcyByZWFzb25hYmxlIGdpdmVuIHlvdSBhcmUgZm9yY2luZyBhbiBsZTE2DQo+
dmFsdWUgaW50byBhIHUxNi4NCj5NaW5pbWFsIGZpeCBpcyBqdXN0IHRvIGNoYW5nZSB0eXBlIG9m
IHZhbCB0byBfX2xlMTYgKg0KPg0KPkkgc3RpbGwgZmluZCB0aGUgZW5kaWFuIGhhbmRsaW5nIGlu
IGhlcmUgbWVzcyBhbmQgYW0gbm90IGNvbnZpbmNlZCB0aGUgY29tcGxleGl0eSBpcw0KPnN0cmlj
dGx5IG5lY2Vzc2FyeSBvciBjb3JyZWN0Lg0KPg0KPkknZCBleHBlY3QgdGhlIHJlcXVpcmVtZW50
cyBvZiByZW9yZGVyaW5nIHRvIGJlIHNhbWUgaW4gcmVhZCBhbmQgd3JpdGUgZGlyZWN0aW9ucw0K
Pih1bmxlc3MgZGV2aWNlIGlzIHJlYWxseSBjcmF6eSksIHNvIHdoeSBkbyB3ZSBuZWVkIGEgY29u
dmVyc2lvbiB0byBsZTE2IGhlcmUgYnV0IG5vdA0KPm9uZSBmcm9tIGxlMTYgaW4gdGhlIHdyaXRl
Pw0KDQpIZWxsbyBKb25hdGhhbiwNCg0KeWVzLCB5b3UgYXJlIHJpZ2h0LiBUaGUgImNwdV90b19s
ZTE2IiBpcyBub3QgcmVxdWlyZWQgYXQgYWxsLiAgU01JMjQwIGRvZXMgbm90IHVzZSB0aGUgc3Rh
bmRhcmQgU1BJIHByb3RvY29sLCBvbiB0aGUgb3RoZXIgc2lkZSB0aGUgcmVnbWFwIGlzIGRlc2ln
bmVkIHRvIHVzZSBzdGFuZGFyZCBTUEkgcHJvdG9jb2wgKGJ5IGRlZmF1bHQpIGFuZCBtYXkgZmxp
cCB0aGUgcmVnaXN0ZXIgdmFsdWUgZGVwZW5kZW50IG9uICJ2YWxfZm9ybWF0X2VuZGlhbiIuIFdo
ZW4gdGhlIGJvdGggd29yayB0b2dldGhlciwgaXQgbWF5IGxlYWQgdG8gY29uZnVzaW5nLiAgTGV0
IG1lIG1ha2UgaXQgY2xlYXIuDQoNCkluIHRoZSBTTUkyNDAsIHRoZSByZWdpc3RlciBhZGRyZXNz
IGlzIDggYml0IGFuZCBlYWNoIHJlZ2lzdGVyIGlzIDE2IGJpdC4gV2UgZG8gbm90IGhhdmUgYW55
IHJlZ2lzdGVyIHZhbHVlLCB3aGljaCBpcyBiaWdnZXIgdGhhbiAxNiBiaXQgYW5kIG5lZWQgdG8g
YmUgc3RvcmVkIGluIG11bHRpcGxlIHJlZ2lzdGVycy4gIFRoZXJlZm9yZSB0aGUgZGV2aWNlIGRv
ZXMgbm90IG5lZWQgZW5kaWFuLiBOZWl0aGVyIGJpZyBlbmRpYW4gbm9yIExpdHRsZSBFbmRpYW4u
ICAgVG8gYWNjZXNzIHRoZSByZWdpc3RlciwgaXQgaXMgaW1wb3J0YW50IHRvIHByZXBhcmUgdGhl
IHJlcXVlc3QgZnJhbWUgYWNjb3JkaW5nIHRvIHRoZSBzcGVjaWZpY2F0aW9uLiANCg0KQSByZXF1
ZXN0IGlzIDMyIGJpdA0KDQoJSUQJQURSCVcJQ0FQCSoJV0RBVEEJQ1JDDQoJMzEtMzAJMjktMjIJ
MjEJMjAJMTkJMTgtMwkJMi0wDQoNCklEOiBkZXZpY2UgaWQgKGlmIG1vcmUgdGhhbiAxIGRldmlj
ZSkNCkFEUjogcmVnIGFkZHJlc3MNClc6IHdyaXRlL3JlYWQNCkNBUDogY2FwdHVyZSBtb2RlIG9u
L29mZg0KKjogcmVzZXJ2ZWQNCldEQVRBOiByZWcgdmFsdWUgdG8gd3JpdGUNCkNSQzogY2hlY2sg
c3VtDQoNClRvIHByZXBhcmUgdGhlIHJlcXVlc3QgcHJvcGVybHksIHRoZSBiaXQgb3JkZXIgaXMg
aGVyZSBjcml0aWNhbC4gV2UgbmVlZCB0byBwdXQgZWFjaCBwYXJ0IGluIGl0cyBiaXQgcG9zaXRp
b24uIFRoZSByZXF1ZXN0IGlzIGNyZWF0ZWQgYXMgYSBsb2NhbCB1MzIsIHdpdGggaGVscCBvZiBG
SUVMRF9QUkVQLCB3ZSBwdXQgdGhlIHZhbHVlIG9mIGVhY2ggcGFydCB0byBpdHMgYml0IHBvc2l0
aW9uLiBGSUVMRF9QUkVQIHdpbGwgdGFrZSBjYXJlIG9mIHRoZSBjcHUgZW5kaWFuIGFuZCBhbHdh
eXMgcHV0IHRoZSB2YWx1ZSB0byB0aGUgY29ycmVjdCBiaXQgcG9zaXRpb24uICBCZWZvcmUgd2Ug
c2VuZCB0aGUgcmVxdWVzdCB2aWEgU1BJLCBhIGNwdSBlbmRpYW4gdG8gYmlnIGVuZGlhbiBjb252
ZXJzaW9uIGlzIHJlcXVpcmVkLiBTaW5jZSB0aGUgc3BpIGJ1cyB0cmFuc2ZlcnMgZGF0YSB1c2lu
ZyBiaWcgZW5kaWFuLiBXaGVuIHdlIGdldCB0aGUgcmVzcG9uc2UgZnJvbSBzcGksIHRoZSByZXNw
b25zZSBpcyBiaWcgZW5kaWFuIGFuZCBuZWVkIHRvIGJlIGNvbnZlcnRlZCBpbiBjcHUgZW5kaWFu
LiAgQW55IG90aGVyIG1hbnVhbGx5IGVuZGlhbiBjb252ZXJzaW9uIGlzIG5vdCByZXF1aXJlZC4g
DQoNClRoZSBTUEkgcmVhZCBpbiBuZXh0IHZlcnNpb24gbG9vayBsaWtlIHRoYXQNCg0KMS4gUHJl
cGFyZSByZXF1ZXN0DQoyLiBDb252ZXJ0IHJlcXVlc3QgZnJvbSBjcHUgZW5kaWFuIHRvIGJpZyBl
bmRpYW4gYW5kIHNlbmQgdmlhIHNwaQ0KMy4gR2V0IHJlc3BvbnNlIA0KNC4gQ29udmVydCByZXNw
b25zZSBmcm9tIGJpZyBlbmRpYW4gdG8gY3B1IGVuZGlhbiAgYW5kIHRha2UgdGhlIHJlZyB2YWx1
ZSBmcm9tIGNvbnZlcnRlZCByZXNwb25zZQ0KQXMgeW91IG1lbnRpb25lZCwgYW4gYWRkaXRpb25h
bCBjcHVfdG9fbGUxNiBpcyBub3QgcmVxdWlyZWQuIFNpbmNlIHRoZSByZXNwb25zZSBpcyBhbHJl
YWR5IGNvbnZlcnRlZCB0byBjcHUgZW5kaWFuLg0KDQoNCnN0YXRpYyBpbnQgc21pMjQwX3JlZ21h
cF9zcGlfcmVhZCh2b2lkICpjb250ZXh0LCBjb25zdCB2b2lkICpyZWdfYnVmLA0KCQkJCSAgc2l6
ZV90IHJlZ19zaXplLCB2b2lkICp2YWxfYnVmLA0KCQkJCSAgc2l6ZV90IHZhbF9zaXplKQ0Kew0K
CWludCByZXQ7DQoJdTMyIHJlcXVlc3QsIHJlc3BvbnNlOw0KCXUxNiAqdmFsID0gdmFsX2J1ZjsN
CglzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpID0gY29udGV4dDsNCglzdHJ1Y3QgaWlvX2RldiAqaW5k
aW9fZGV2ID0gZGV2X2dldF9kcnZkYXRhKCZzcGktPmRldik7DQoJc3RydWN0IHNtaTI0MF9kYXRh
ICppaW9fcHJpdl9kYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCg0KCWlmIChyZWdfc2l6ZSAh
PSAxIHx8IHZhbF9zaXplICE9IDIpDQoJCXJldHVybiAtRUlOVkFMOw0KDQoJcmVxdWVzdCA9IEZJ
RUxEX1BSRVAoU01JMjQwX1dSSVRFX0JVU19JRF9NQVNLLCBTTUkyNDBfQlVTX0lEKTsNCglyZXF1
ZXN0IHw9IEZJRUxEX1BSRVAoU01JMjQwX1dSSVRFX0NBUF9CSVRfTUFTSywgaWlvX3ByaXZfZGF0
YS0+Y2FwdHVyZSk7DQoJcmVxdWVzdCB8PSBGSUVMRF9QUkVQKFNNSTI0MF9XUklURV9BRERSX01B
U0ssICoodTggKilyZWdfYnVmKTsNCglyZXF1ZXN0IHw9IHNtaTI0MF9jcmMzKHJlcXVlc3QsIFNN
STI0MF9DUkNfSU5JVCwgU01JMjQwX0NSQ19QT0xZKTsNCg0KCWlpb19wcml2X2RhdGEtPnNwaV9i
dWYgPSBjcHVfdG9fYmUzMihyZXF1ZXN0KTsNCg0KCXJldCA9IHNwaV93cml0ZShzcGksICZpaW9f
cHJpdl9kYXRhLT5zcGlfYnVmLCBzaXplb2YocmVxdWVzdCkpOw0KCWlmIChyZXQpDQoJCXJldHVy
biByZXQ7DQoNCglyZXQgPSBzcGlfcmVhZChzcGksICZpaW9fcHJpdl9kYXRhLT5zcGlfYnVmLCBz
aXplb2YocmVzcG9uc2UpKTsNCglpZiAocmV0KQ0KCQlyZXR1cm4gcmV0Ow0KDQoJcmVzcG9uc2Ug
PSBiZTMyX3RvX2NwdShpaW9fcHJpdl9kYXRhLT5zcGlfYnVmKTsNCg0KCWlmICghc21pMjQwX3Nl
bnNvcl9kYXRhX2lzX3ZhbGlkKHJlc3BvbnNlKSkNCgkJcmV0dXJuIC1FSU87DQoNCgkqdmFsID0g
RklFTERfR0VUKFNNSTI0MF9SRUFEX0RBVEFfTUFTSywgcmVzcG9uc2UpOw0KDQoJcmV0dXJuIDA7
DQp9DQoNCg0KVGhlIFNQSSB3cml0ZSBpbiBuZXh0IHZlcnNpb24gbG9vayBsaWtlIHRoYXQNCg0K
MS4gUHJlcGFyZSByZXF1ZXN0DQoyLiBDb252ZXJ0IHJlcXVlc3QgZnJvbSBjcHUgZW5kaWFuIHRv
IGJpZyBlbmRpYW4gYW5kIHNlbmQgdmlhIHNwaQ0KDQpUaGUgY3JpdGljYWwgcGFydCBoZXJlIGlz
IHRoZSByZWcgdmFsdWUgKFdEQVRBKS4gIEFzIHBhcnQgb2YgdGhlIHJlcXVlc3QsIHRoZSByZWcg
dmFsdWUgc2hhbGwgYmUgcHV0IHRvIGJpdCAxOC0zIFdJVEhPVVQgVE9VQ0hJTkcgSVQuIFRoZSBy
ZWcgdmFsdWUgYXMgYSBsb2NhbCB1MTYsIHNoYWxsIHVzZSB0aGUgc2FtZSBjcHUgZW5kaWFuIGFz
IHRoZSByZXF1ZXN0LiBUaGlzIGlzIHRvIGtlZXAgdGhlIGNvcnJlY3QgYml0IG9yZGVyIGZvciBy
ZWcgdmFsdWUgYW5kIGFsc28gZm9yIHRoZSByZXF1ZXN0LiAgTmV2ZXJ0aGVsZXNzIHJlZyB2YWx1
ZSBpcyBwYXNzZWQgYnkgcmVnbWFwX3dyaXRlLiAgUmVnbWFwIGNvcmUgbWF5IGZsaXAgdGhlIHJl
ZyB2YWx1ZSB3aGVuIHZhbF9mb3JtYXRfZW5kaWFuICE9IGNwdV9lbmRpYW4uIElmIHRoaXMgaGFw
cGVucywgdGhlbiByZWdtYXAgY29yZSBoYXMgYWN0dWFsbHkgY2hhbmdlZCB0aGUgcmVnIHZhbHVl
LiAgVG8gcHJldmVudCByZWdtYXAgdG8gZmxpcCB0aGUgcmVnIHZhbHVlIHdlIHVzZSBSRUdNQVBf
RU5ESUFOX05BVElWRSBhcyB2YWxfZm9ybWF0X2VuZGlhbi4gDQoNCnN0YXRpYyBpbnQgc21pMjQw
X3JlZ21hcF9zcGlfd3JpdGUodm9pZCAqY29udGV4dCwgY29uc3Qgdm9pZCAqZGF0YSwNCgkJCQkg
ICBzaXplX3QgY291bnQpDQp7DQoJdTggcmVnX2FkZHI7DQoJdTE2IHJlZ19kYXRhOw0KCXUzMiBy
ZXF1ZXN0Ow0KCWNvbnN0IHU4ICpkYXRhX3B0ciA9IGRhdGE7DQoJc3RydWN0IHNwaV9kZXZpY2Ug
KnNwaSA9IGNvbnRleHQ7DQoJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IGRldl9nZXRfZHJ2
ZGF0YSgmc3BpLT5kZXYpOw0KCXN0cnVjdCBzbWkyNDBfZGF0YSAqaWlvX3ByaXZfZGF0YSA9IGlp
b19wcml2KGluZGlvX2Rldik7DQoNCglpZiAoY291bnQgPCAyKQ0KCQlyZXR1cm4gLUVJTlZBTDsN
Cg0KCXJlZ19hZGRyID0gZGF0YV9wdHJbMF07DQoJbWVtY3B5KCZyZWdfZGF0YSwgJmRhdGFfcHRy
WzFdLCBzaXplb2YocmVnX2RhdGEpKTsNCg0KCXJlcXVlc3QgPSBGSUVMRF9QUkVQKFNNSTI0MF9X
UklURV9CVVNfSURfTUFTSywgU01JMjQwX0JVU19JRCk7DQoJcmVxdWVzdCB8PSBGSUVMRF9QUkVQ
KFNNSTI0MF9XUklURV9CSVRfTUFTSywgMSk7DQoJcmVxdWVzdCB8PSBGSUVMRF9QUkVQKFNNSTI0
MF9XUklURV9BRERSX01BU0ssIHJlZ19hZGRyKTsNCglyZXF1ZXN0IHw9IEZJRUxEX1BSRVAoU01J
MjQwX1dSSVRFX0RBVEFfTUFTSywgcmVnX2RhdGEpOw0KCXJlcXVlc3QgfD0gc21pMjQwX2NyYzMo
cmVxdWVzdCwgU01JMjQwX0NSQ19JTklULCBTTUkyNDBfQ1JDX1BPTFkpOw0KDQoJaWlvX3ByaXZf
ZGF0YS0+c3BpX2J1ZiA9IGNwdV90b19iZTMyKHJlcXVlc3QpOw0KDQoJcmV0dXJuIHNwaV93cml0
ZShzcGksICZpaW9fcHJpdl9kYXRhLT5zcGlfYnVmLCBzaXplb2YocmVxdWVzdCkpOw0KfQ0KDQpz
dGF0aWMgY29uc3Qgc3RydWN0IHJlZ21hcF9jb25maWcgc21pMjQwX3JlZ21hcF9jb25maWcgPSB7
DQoJLnJlZ19iaXRzID0gOCwNCgkudmFsX2JpdHMgPSAxNiwNCgkudmFsX2Zvcm1hdF9lbmRpYW4g
PSBSRUdNQVBfRU5ESUFOX05BVElWRSwNCn07DQoNCg0KRmF6aXQ6DQoNClRoZSBiaXQgb3JkZXIg
aW4gcmVxdWVzdCBpcyBjcml0aWNhbCB0byB1cy4gICBGSUVMRF9QUkVQIHdpbGwgdGFrZSBjYXJl
IG9mIHRoZSBieXRlIG9yZGVyIChiaWcgLyBsaXR0bGUgZW5kaWFuKSBmb3IgdXMsIGFuZCBhbHdh
eXMgcHV0IHRoZSB2YWx1ZSBvZiBlYWNoIHBhcnQgdG8gdGhlIGNvcnJlY3QgYml0IHBvc2l0aW9u
LiBXZSBzaGFsbCBuZXZlciBtYW51YWxseSBjaGFuZ2UgdGhlIGNwdSBlbmRpYW4gdG8gZWFjaCBw
YXJ0LiBKdXN0IGNvbnZlcnQgdGhlIHdob2xlIHJlcXVlc3QgdG8vZnJvbSBiaWcgZW5kaWFuIHdo
ZW4gc2VuZGluZyAvIHJlY2VpdmluZyB2aWEgc3BpLg0KDQpJIGhvcGUgdGhpcyBtYWtlIHRoZSBl
bmRpYW4gaGFuZGxpbmcgY2xlYXIgdG8geW91Lg0KDQpCZXN0IFJlZ2FyZHMNCg0KSmlhbnBpbmcg
U2hlbg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0K

