Return-Path: <linux-iio+bounces-18173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC2EA906B8
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF79F189468E
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AB1FA15E;
	Wed, 16 Apr 2025 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="e0v2IIf9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37591F12F2;
	Wed, 16 Apr 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814481; cv=fail; b=sk8locpjytSBU6prBnb/Uw06iWfD/nixWpaO0yEVEbIl1qys/z8Tap8wZbwevJ4Pi7k7eri0yH3qqsGgG4CAgk8k3cL6PYctkDbfSbHGzBr8neuxu7+/sc8/owYkH5WdqdSy6woGwptEjBMlVH4zohTYaYCRYf2DuDf9adzixOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814481; c=relaxed/simple;
	bh=hFhzliBD79nd/kyEzpFR7vExUWnPIcNp26pnx3THZhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JF2uQDmLdEXAsyRgVl/8r6gfuFq6xUlMAniQPK/E754I7TwzUyklobIge/Irh1/sQU4+oaFnBNmQCC0TwkMpEuDaPOJySnuN/egVfe/OcltFC5LMj88RZZYUscP4cHGSWMqhnaWXLIqwDr0Q+4/MzYEnvNzJ6tBYaiUiul+3XmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=e0v2IIf9; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GEW0AB005282;
	Wed, 16 Apr 2025 14:40:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 45yej33mr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 14:40:57 +0000 (GMT)
Received: from m0233778.ppops.net (m0233778.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53GEeusB018606;
	Wed, 16 Apr 2025 14:40:56 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010007.outbound.protection.outlook.com [40.93.77.7])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 45yej33mqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 14:40:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=befXGlXGRMv+r8HyAckxmsEwMkYVQRN0pdnzz1NCsbSarFpjY4iAAcQQrTThT9hy2LthWP3tVKRoIadfqgNvwCUkJILgHGlnQywEQ9FVLx0muE3o+okICuBydhASuU+u+xDtCX66LWR4sZ1Awq27RsVHf8c5JwWe8pgGGSmTePULqQ/cHE7nU/iuMidXBGTSMkjzB+aLCBV0EnAPenHEKlz2h+ohphlQoZym41omNyilFxGa6E4umno0b9x1WQNytcUEE2IMJ1NMejAremD4DXd6q+3bEdN3Ij3oHIFCv6mcL3Zh6p9thsnpGlGy+ZOJ5+MNnqk2Dud5p2eurlUkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFhzliBD79nd/kyEzpFR7vExUWnPIcNp26pnx3THZhs=;
 b=LCenIXmLVc9GThdv3+0pEiMNZl0EdB2LLMVY+H4tDuZMYJeBVLQgg+/773wh1lgOEeoEV5CK6NOOrlQkhEkT+Ruk9pxzx+fxuq4z5raRUq61SMLnJK9nxw7aaxpP7yVu24dTDBWuC33/y+lRC2qWocCFEkYxVEgLGD1EBxGCg6Up7vzE9jQ1uK5iWMZnluHVWixxhu8aCJovfHH05Lt0bWORGB/TEQM2bEk7IMe1xOljSlha4Etx61h0Lm7WZ0jE9P3t0UnfhJHd9A71gaCk3xdjL+L2I/5/cd+tZ4qaxmW58LF3T2ZTurknCnwnIFq66N/NcrFG/OXZnheeoCMmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFhzliBD79nd/kyEzpFR7vExUWnPIcNp26pnx3THZhs=;
 b=e0v2IIf9up9SWgONfe8gZbxoGwUC23UHaIe4r35jgcBSDZ7QVxlxbv4i5nLx18MwxciDpStjpMba5vcIaSUgpQa2xBYFnJKSMjKPa+lN9Q0+LBBCIxzYNA4YBzmEl/2W7fRkayYP8MvWqn3hsacs0Z9302mSwxO9Lgb2JDbLL2TEDjfOHjg3honZihhB+0B6vbsjxuXkw8VVvsTfDx1HbcoLwP0M2xUjpbL6g0/TUmWMrfYFh0I8m+67B3c6C4FW6iBeTuCwQR8LA7vBZe1h6ZSqAaRA2ti2NYb49c8d+wtLTRPQ/yS7gBPMeGCZuF7ujkBxULJj8plOalYKqVMX7g==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 14:40:50 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%5]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 14:40:50 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Topic: [PATCH v2 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Index: AQHbrhVa7km3hoqQ+UCd3TA7I7lSbLOlCXMAgAEpijOAABGggIAAGaSb
Date: Wed, 16 Apr 2025 14:40:50 +0000
Message-ID:
 <FR3P281MB1757AA98627383BC411A35F5CEBD2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250415-losd-3-inv-icm42600-add-wom-support-v2-0-de94dfb92b7e@tdk.com>
 <20250415-losd-3-inv-icm42600-add-wom-support-v2-1-de94dfb92b7e@tdk.com>
 <CAHp75VdZDovPuRqQMpP=TkjeBr9AgRssPFJfmsjnXC=wUXxFHg@mail.gmail.com>
 <FR3P281MB1757B4BF12AD9F6AC5F8F361CEBD2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <CAHp75VciPdgt13GbWtH08_k-f6VHQ-e3aA+CibKNAS6WRWE9Ng@mail.gmail.com>
In-Reply-To:
 <CAHp75VciPdgt13GbWtH08_k-f6VHQ-e3aA+CibKNAS6WRWE9Ng@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB2329:EE_
x-ms-office365-filtering-correlation-id: aa622bec-1e38-4bdf-6500-08dd7cf4aeb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlM4KzVzSko0RGFmTkdTSDU5dEVOZEdCdHYxbGlEUTdFS2dPUEpTbzMvN2F4?=
 =?utf-8?B?VzRNeUFrWjRXOUtUdjBqWExNbEZzcjJxWnFyZHMwK2JRR1pHc0J4TFlJSnFL?=
 =?utf-8?B?Z1VqcFYvRzJsRERJaXhnbklvT2Y4Z2E2eDlJamgwRG1BVlIwQjB6ZmViYWdN?=
 =?utf-8?B?bjlzNE9MY3UzMkNQVVVPbVY5MkJLUGpHdWlYRUdvdERFNVJOZC93MVFjb04y?=
 =?utf-8?B?MkJVbmtRdFc3ZUg1K0g5Y3ZNUFdyQkdoSnQ0SDJjeC93bFhqWm16ekNqbjhv?=
 =?utf-8?B?eDFsRHYyZFE1WEFGMXAzYVVUdHcweS9CNXFvV25ldU9QeHdLNDdOVDRGQlB5?=
 =?utf-8?B?NXhhR1h1ZjlMY2ZJcmpjbVM3WGNqVXRrM3JlU1JiTUJ0VG9xT29UNHYxUkNR?=
 =?utf-8?B?cVhJamlUOWhmcFlKb0lReUFDZlBPa0x5dmVCRlNPWEtRUGpZekZCQUxSNVRU?=
 =?utf-8?B?UHZ2Uk8wMEVCaFU4bEJ0RmJOeEFya1hPUEFtTmYvRSs5MFFWQzlzR0dxOE8r?=
 =?utf-8?B?aHRxUXZGbXFyQStuT2lyQ1J4QWtKREtsOFVSb0RIZERPVm1tQ0t2OEZ1Y05u?=
 =?utf-8?B?dlRIODQwOUFiaFVGNDl1SGZxZXZCd2I4ZENXVnNkd3l5WWxVZ3IvYzdYcE8y?=
 =?utf-8?B?WGFyWEF5OUZud2lMeWp1Rmo4V05ScDBJVXdrOFQwbDVQM011MzVmRmJUR2xa?=
 =?utf-8?B?cW1zaG9qb2NxQXRhVE5aMjRvRlNXak5VcGJTNWlJWWJaOVUwRllBVzFCamtp?=
 =?utf-8?B?dFd3WlIxM2kxSEFCSVpCK2tPMTVJM3pvZlRtWG51bks5cy8wZUNWZnJXak9E?=
 =?utf-8?B?LytJbUNWalRYbEM5S2VLR2c5c3ZhTlJJNjRmalY1Mk9xeCs0dEZuaXJQTDhL?=
 =?utf-8?B?RUtWRGNqL01oakhkVERQeG1RWGRrdktIZVNXTGRCeDhJcWdzdFFPTjU4YmIv?=
 =?utf-8?B?cVVKZVRaOTh0cjcwZWhnbVlUdnliQkxZWnBheFU1TGdMM1ExeDdvLzlkTjlL?=
 =?utf-8?B?QTl4eVczeHc0UFlReVQ3eFc2WjZEYWdVbnhKOGpOMlpDc3pWOHI0Zk0vRWMw?=
 =?utf-8?B?UEU3ejhpZU1rWHUyMkJGZEpwcjlOYWpneEFSKzhRTXdxZ1plcnk2VFcrMDF6?=
 =?utf-8?B?am5nWXNSWndWdlZ1TzVsdGMrbytyOUxSY3Z6Y3FMdXdpQW04V0JqUG5EenEw?=
 =?utf-8?B?c1hMd0QyZzJ1NmVaVHp3UDhHWFM5UkU1ZGc0QXJyOURkd3NYQldGa1JOYXJa?=
 =?utf-8?B?Wm1YNWlFbDFnRmdIWThXanJZUXI5ekFuMmFCaEZZZjU0R0pEU2xNQmNpd0dp?=
 =?utf-8?B?WUUwZEs1RkZlNEFXbGhQRC9tYlNTUG03ZUU1YjFEanJCMEJPdFFZdFlJMEsv?=
 =?utf-8?B?Y05hUVZkdDkzY3FoYlNMYVVwck94NlZnTUpVYmVXZHExampwYmpYN1N0M0l1?=
 =?utf-8?B?bXpLd1pIQnhla1RlaVBhWU94UkxpWmdhbkw1ZXJPOGdzQ0JyZGJuMTJNYWdG?=
 =?utf-8?B?Umhld0V5RFQwZUVZWGpDZFA4d2dGQlFRUHcwUTY1VGtRc0VVZ042WEJnSnNL?=
 =?utf-8?B?WUJxWXgvbEVFUW9pWTR5bDV4UFM3RHdEUEJiRkZiM2drVHFvendvUXNDWUpw?=
 =?utf-8?B?YXRReVg4bS95UmF4MUR0Q29kWUVUQjU1S3lPbUU4L0tlaHNxT0NtSDdMNVBX?=
 =?utf-8?B?VnNiTVRyakZVdGVlNHRYeVFtWjFYYW9tUzl5UTRaMnJmSzQ0eHZCVnpqa2cr?=
 =?utf-8?B?NURzZ1RWcURlRFBWVVhRL3YxVmZSd3dSa2VDaTJSM2hOdlhwVnYraE1zNFJS?=
 =?utf-8?B?cDZ4ZjliV04zekZ3czMwOWtkb0VBRmY0NEU5bkxhYVpmQm5YdkVZbXNSQzBF?=
 =?utf-8?B?dWNFc0NEWmRkNFpnNFN4QkZwZDRaQVVycXV1TVZlSFJvSDhRNlZxUFFYZ0Iz?=
 =?utf-8?B?NVhucEZ1MXk4MEpvRFVMenNGc1pQMEdsd1FpZGFmbGVwbFBIS25WdTRhRm45?=
 =?utf-8?B?aVJSYmk4ZTA0WnRVaURaTGZnTHc0L3dXNmU5MHowcjhDc0VyTENQeXFuaWdS?=
 =?utf-8?Q?U2dd20?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1JGdlpvUGdKMDNLVXlLcEdmZjNxVnczbTFkQWVsUEpEV1FQeisxbmtwc2R2?=
 =?utf-8?B?MXFKbXUvak5vSXNWVFZKT3IzVHUyQUhFWHU2UGN6eXh2a3NrQnNRUVNMS2Yw?=
 =?utf-8?B?YTlpVG9iK3J3SGJqaFNGWkxYU0RzMi9qckRWdlFkbmJtVWo0Y25DeUN2cGIv?=
 =?utf-8?B?Z2NwT2NkaklxWVI0RVZKRWt0d0hlMXloTjBIRlFvWW0zUXdmWktFaXNITElY?=
 =?utf-8?B?aDhNNEF2Ukd2V3RsM0J1elZMbjYvRzEvR1Jrei9jWXJRakx1OSs2SFpXbEYy?=
 =?utf-8?B?QUJYWkZkRDc1cDdvVE1LOWtyUnZzVkczOFQ2UXg3UTRWeTJFeVlvMUcxaW1p?=
 =?utf-8?B?b3JITXluMkZkWFpSZDI2N3hxSHppN0VTRzlGeUZwcVFUK3N5QUtRRzFwUDgz?=
 =?utf-8?B?VzNsSHk3ZkIyS2pIZ1JMcHZiQlZIRG05bElBZTdMUko4WnVPbkxEQ3ZaQy9k?=
 =?utf-8?B?cWEyaUVtYjV2V1FEOEdVaU9veXZvQ1RtbEN1NmNiUm9heDhkN2dJbDZ2cjhy?=
 =?utf-8?B?ejJmM2NoRmIwdy9tOU9tQjA1ZTRGVW16TnNublJ4NHRPMVVpaGVBdTdVN1VM?=
 =?utf-8?B?OWJBNjJxSWZKd3UzWnlxRTh5dTlmMFVaOGpHbGtoamlFQ2JndXNCdG13S2Jp?=
 =?utf-8?B?K2lkcGNiVEpOOUUyZC9vQmdHZ1dPdG1qWlNvWnEzVmp2ZVNnTXNlZUtPbjdi?=
 =?utf-8?B?emVzTm9oSFRQRFl3c2FBOGNwN2hRQmoyazlEYUN0cDBDbjh4R1ZDNjh1ZEV0?=
 =?utf-8?B?N09ZdkRRT3hMOG9EVUxJQ0tyN3BpOXdOUDRUY3dKSjEyR1dWUmZXRXdxcU5J?=
 =?utf-8?B?Sm1iemtJK1dZRW9VdFduWS9Ja1BXUWhQR1VVOGR3ZkpLSjJnSTRLRlJQMHRr?=
 =?utf-8?B?UThla0RVRkdWa3lQakNpVnVmVHQzbWlXdSticHN6WFdKVk5FQ004aDVoMjdr?=
 =?utf-8?B?RENHTk9IZmhsUVlMekRGa2tNSzBpMVR6TDU4ZzEzOG9ucEdoclpHMTBhZWw4?=
 =?utf-8?B?WFE5MWtBbHVSY01BSWdVb2dmZzFIWmlJZm9wQXd1UVd1c3d4ZjlLV3ZtTlpi?=
 =?utf-8?B?SVIxVTFwWHMzYWJYV3RpdXFiZk15YWRkRVc1REZHZzVyTTJ6OHpobDdPMC9D?=
 =?utf-8?B?WFpmamhreGJNaTI1bTdvYndBMTJKQWF0TzNZak05TkdzM0MzT1JCQ0gxWk1s?=
 =?utf-8?B?dFBvY0N0WkV0QUxjUS9ocUhTemc1YzFjQ0xHNkl3RXBPV2ZKN3BkVU5FWDYz?=
 =?utf-8?B?bHQySG85RENkSUM5ZHQ0R1hVQlU1bFY4YUFmZTR4M3BiNzJ6dWdBc3poaTdx?=
 =?utf-8?B?TEMrNTJOQVRuTDhyTmllcExRTlR0d3ZxaTdJNi95eW1tbTV2U0tKNHhCL0Nx?=
 =?utf-8?B?MTA4NzFyRFlkSlVoODI5S1ZaSG1yNUNIcHR0dkJObFVaVEVuNmNnR2pITWZr?=
 =?utf-8?B?YndDU1BwZUVJbzFDN085WndnbUsvWFg0ZWpVS2ozY3V2Q09EMHd3cytBVklD?=
 =?utf-8?B?YWVZR1gvSlNZajNnTDZnbnBkcTkwZ3hPaDE1cDYwd2dtdkpJdytEMnhxU0RX?=
 =?utf-8?B?TGRuU3hxWWlkRUlrc3FPeE1iRVRyVnhtRXNvVS94U1AzRHhqMHpFQk9DMlJO?=
 =?utf-8?B?NDZDUGtHaFUwVGVrKzN3SHN6bzdEbkFvZ0tpV29kYU0xeUc2WGZBbFo2eStp?=
 =?utf-8?B?RnNCdmFwRU9sbXU2L2M3K2o2MmNvRGxrQ3FEa3ZjNDhjbm9raXYvTU5zWWlw?=
 =?utf-8?B?R2NyaVZ0eUpnT2l0QjhHcHI4eTdCVnZVVlJYSzVOcklSS3BENWZPNFc3TW9D?=
 =?utf-8?B?M0VJRTVKK3dScXpYbjhSTW5vNUkxUWlERlA0bG92TGQ5c0lKRXNKRnRDUmZm?=
 =?utf-8?B?bHdpMHI5dFFmUTBhMU81aWZhU2h5VGIrWjBJN0tVWlhyOHBUZFJGMnBqUHRu?=
 =?utf-8?B?S0dJV2ZEOHNQSHB5YXlJdmRqN1hyMDVvWUpNQmR1a1ZoMXJLMVZEMklWUTBM?=
 =?utf-8?B?NWRGeEovalhoUnIvWlE4NXpaa0NHbm1jQ3FoZ0c3Q0ZMelh6akVYa2dSY3dp?=
 =?utf-8?B?UGlHV2dBblo1ZjFPUjIrV3RCdkpna0NmWFZ2REFLMFd4QXdjVlhvUVg3c1lE?=
 =?utf-8?B?M3N6ZENhTlJsZERJNHZIOWwzTXJJU1RYN3puVjVob0VWMkVhVzhkdnpNRXFV?=
 =?utf-8?B?UEhTOExvQ1ZMWUhCZGhVa28weitQeHVjdzJRSWpwVnhtQnp3Q2ZWWGpjOFNx?=
 =?utf-8?B?QzdaOHpCYW1URXBINUdGTjFBWHFnPT0=?=
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
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aa622bec-1e38-4bdf-6500-08dd7cf4aeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 14:40:50.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ddjf59TdwQj+G/EPEAnEa8qk4TsQ9oSGo11mHsFahk/IyTzKOKvKHR9AGeee76POiHTtsUt/jAj64NZoxAL7mBpQKgT2932NglRl89w8QdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2329
X-Proofpoint-ORIG-GUID: ZPBUBD7Y-s4zRK-AK9dC45gEf_IX9h3y
X-Authority-Analysis: v=2.4 cv=XcaJzJ55 c=1 sm=1 tr=0 ts=67ffc179 cx=c_pps a=v7lO2Q71c9uDhDaeFh6mXA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=2C6YHBdLAAAA:8 a=pGLkceISAAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=6yoErSXb8f44zbpSRBEA:9 a=QEXdDO2ut3YA:10 a=yxGMNg53M24zlVSZdvMH:22 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: MLGEsqpyiyxQRxOkmSlO8IYd7NjQjCfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160119

T0ssIHVuZGVyc3Rvb2QuCgpCdXQgZm9yIHRoaXMgcGFydGljdWxhciBwYXRjaCwgZG8gSSBuZWVk
IHRvIHN0YXkgY29uc2lzdGVudCB3aXRoIHRoZSBleGlzdGluZyBkcml2ZXIgYnkga2VlcGluZyB0
aGUgc3RhbmRhcmQgdHlwZSBvciB1c2Uga2VybmVsIHR5cGVzIGFuZCBtaXggd2l0aCBzdGFuZGFy
ZCB0eXBlcz8KClRoYW5rcywKSkIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KRnJvbTrCoEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4K
U2VudDrCoFdlZG5lc2RheSwgQXByaWwgMTYsIDIwMjUgMTU6MDYKVG86wqBKZWFuLUJhcHRpc3Rl
IE1hbmV5cm9sIDxKZWFuLUJhcHRpc3RlLk1hbmV5cm9sQHRkay5jb20+CkNjOsKgSm9uYXRoYW4g
Q2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRh
Zm9vLmRlPjsgRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgTnVubyBTw6Eg
PG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsg
bGludXgtaWlvQHZnZXIua2VybmVsLm9yZyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
ClN1YmplY3Q6wqBSZTogW1BBVENIIHYyIDEvMl0gaWlvOiBpbXU6IGludl9pY200MjYwMDogYWRk
IFdvTSBzdXBwb3J0CsKgClRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcgpU
aGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uCsKgCk9uIFdl
ZCwgQXByIDE2LCAyMDI1IGF0IDM6NDHigK9QTSBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sCjxKZWFu
LUJhcHRpc3RlLk1hbmV5cm9sQHRkay5jb20+IHdyb3RlOgo+Cj4gSGVsbG8gQW5keSwKPgo+IGNv
bmNlcm5pbmcgdXNhZ2Ugb2Yga2VybmVsIHR5cGVzLCBteSB1bmRlcnN0YW5kaW5nIHdhcyB0aGF0
IHdlIHNob3VsZCBjb25mb3JtIHRvIGV4aXN0aW5nIHR5cGVzIHVzYWdlIGluIGEgZHJpdmVyLiBU
aGF0J3Mgd2h5IEknbSBrZWVwaW5nIHRoZSBzdGFuZGFyZCB0eXBlcyBpbnN0ZWFkIG9mIGtlcm5l
bCBvbmVzLiBJIGNvdWxkIGNoYW5nZSB0aGVtIGluIHRoZSBwYXRjaCwgYnV0IGl0IHdvdWxkIG1p
eCB1c2FnZSBvZiBib3RoIHN0YW5kYXJkIGFuZCBrZXJuZWwgdHlwZXMuCj4KPiBBbm90aGVyIHRo
aW5nIG5vdCByZWxhdGVkLCBieSByZWFkaW5nIHRoZSBjb2Rpbmcgc3R5bGUgZG9jdW1lbnRhdGlv
biBJIHdvdWxkIHRoaW5rIHRoYXQgZm9yIG5ldyBkcml2ZXIgd2UgY2FuIHVzZSB3aGF0ZXZlciB3
ZSBwcmVmZXIgYmV0d2VlbiBzdGFuZGFyZCB0eXBlcyBhbmQga2VybmVsIHR5cGVzLiBJcyBpdCBu
b3QgdGhlIGNhc2U/CgpJdCdzIG5vdCBmb3IgdGhlIHJlcG9zaXRvcmllcyBHcmVnIEtIIG1haW50
YWluaW5nIGRpcmVjdGx5IG9yIGluZGlyZWN0bHk6Cmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxNzA0MTExNDA5MTkuR0M0Mzg4QGtyb2Fo
LmNvbS9fXzshIUZ0cmh0UHNXRGhaNnR3IUFDb3I4US1XeVUwQ29yekxwdzBPdFdxTms1OVduMlpf
czdLS09adU5uZ2xLQnpONGpUcWIzYzZvZWE4M0tMRVI5N2JGeGtFSWdTbDhfSWNLSFR4dmFSS0NV
d1ZDUDV3dW52byRbbG9yZVsuXWtlcm5lbFsuXW9yZ10KCi0tIApXaXRoIEJlc3QgUmVnYXJkcywK
QW5keSBTaGV2Y2hlbmtvCgo=

