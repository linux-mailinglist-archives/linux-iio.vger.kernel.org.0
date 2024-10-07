Return-Path: <linux-iio+bounces-10263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A479925F1
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 09:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3548CB2294A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94EB175D44;
	Mon,  7 Oct 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="D1hk9mmm"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E60165F17;
	Mon,  7 Oct 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285551; cv=fail; b=juKXCrvUkKXPN8tfYEsLuh9cjijpfzmq6zPRKBi0p8DPxs+xL3SZ0vM06vhzc3Yx+tpm6lruYRl7j8rMI7sya77eot4KlSBji1Cn1Z38T8ZLrJUOodc6oWzMhnHl3RUx7T0PL/3wbB/Bd8nOXx80qOiiaC36MzIuPCPmGlFU8EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285551; c=relaxed/simple;
	bh=tAnbHu4kvX8kVu4BUZhAllAHHZ64ajnPPItpSqnIRrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=goF50twNizTq4Eijt1NSv1f9HotNyedowspgGgZqv42vjeCoNN5EIJTeBMxmsZsVhLvPIjnUOHaKzNf7yRXuL3IAPqqV4GpqBjPWcuFCb9uk82fF0OgcbRd/o3QNTTLNhfV7JAn8ibyPGnQxZeSKrCMznUdDUf3w4AHAj1e8y8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=D1hk9mmm; arc=fail smtp.client-ip=40.107.104.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMaJSCb+DCgxL7BFnCqmryyTuWMG9aTzYSgv1yv2lZi59Q1KpBepgPoRJf6taij+7Y8e+g+44jqgTp+rn7Ca59k7nFrfCyZeIV0I8A/KoDI52pLkNGhbQwtraHtglGafjg18Ew6Nnzt8TnAARuX6pKaGeLLhgeRnRGN9WB6ZNfurgONJ4gxTCD7v1OKAYKTqpg7+8NcV4Jv+9yavYy93BaZfXwN9vqa8yTIt+uo0dxxEkemtPcevVX0K5qME0zYxJtdNPkOBrAQAEuvmJViAQbzu59XmKjJ4tUXzvCCUHB56bB8NIHYStyn4PW4wQk2jZQZXPpvDb+3upSmOeXsOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAnbHu4kvX8kVu4BUZhAllAHHZ64ajnPPItpSqnIRrU=;
 b=mTi59B5lFQeEkx9l/XBW1b8pxLN1ikz0KhejjSxqFrQQ5NknEsqnBIljT68CwAWrfsFQgSy3PDHFLEOVY8CTU7mtyOn95ceBIMVTWOpX19nTidwM+gKA1J2Pbs9VUOFoHL0tmtXM3Z0TFl8SVplUu2dkQylcj/P7r8YGSVLqWxMkoQWL2aMn5wL3JpepzuftSVvV6ZNcnRl/NsqE+okbnKa+YkGV4CSXlp6EkcrmyPQ81+KdSXZrAtEci09dgY1emGNgzgh7BZPO8EpZIAUUkI90aL5nffK1KtUjo0Yykr5oGMBLaFRkvhX+Xagby/OW6P6xrMfEpAnSWwzALbJS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAnbHu4kvX8kVu4BUZhAllAHHZ64ajnPPItpSqnIRrU=;
 b=D1hk9mmmjtpCVvnnNpvAltdO1YAjfEirKPJVVPOi71jCdY3VhQkLv7lYgjpB7xCl/dtIYaDjdMKa3TStg8uhIdY8OdDW/O2v7RqgaOGbPbWxTKbHKalK/mOwgeB43vbuKQ+ZWhgOaaHS/1DAbnp8rSP8tlpxpGpU+iYOHrY96N8=
Received: from AM0PR02MB5779.eurprd02.prod.outlook.com (2603:10a6:208:189::21)
 by DBBPR02MB10532.eurprd02.prod.outlook.com (2603:10a6:10:535::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 07:19:06 +0000
Received: from AM0PR02MB5779.eurprd02.prod.outlook.com
 ([fe80::e74f:6969:b1e9:30bd]) by AM0PR02MB5779.eurprd02.prod.outlook.com
 ([fe80::e74f:6969:b1e9:30bd%6]) with mapi id 15.20.8005.026; Mon, 7 Oct 2024
 07:19:06 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH v4 2/2] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Topic: [PATCH v4 2/2] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Index: AQHbFY8HuXJEWWs0RkmgVD58ZYYY2rJ5uMQAgAEugIA=
Date: Mon, 7 Oct 2024 07:19:06 +0000
Message-ID: <b40d22b5bdf487b40207e676d35a0507c47cbb26.camel@axis.com>
References: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
	 <20241003-add_opt3002-v4-2-c550dc4591b4@axis.com>
	 <20241006141624.3fa5bf34@jic23-huawei>
In-Reply-To: <20241006141624.3fa5bf34@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB5779:EE_|DBBPR02MB10532:EE_
x-ms-office365-filtering-correlation-id: 157fd4ec-5b88-4efe-d2d4-08dce6a05448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Sm9DVFAraytHbTFINFY3Mjl0TkVhMXRRMEwrbTN1RTA3cmlzMnBGckFVWm82?=
 =?utf-8?B?eUJ1bk9mU3g2U1hvTW9JZXgwelVyb0xsOEVMRkx6OU1HdkFTS1RpSml6aXl6?=
 =?utf-8?B?UjIwQVVaakEzMHhLZ24yM1VlZjd3N2k3c3ZhZ1pVVXMzUE9GWGppdU5XWDBI?=
 =?utf-8?B?NWlSQ25vNkoyKzAxclBQOFdQS2p1Qy8zYUxoT1VGaDl2b0pJeUdXaWtTQjNx?=
 =?utf-8?B?UFBYby9Wdm5kYXlFNVZmSStzQStGWlk3OFdkUFV4MS9VNUQvWnJYWEhCbHNk?=
 =?utf-8?B?aDR0OTNzMnNHOExIc0o2MnpCNy9ia1RmY1hiZUNubW04Z0tjRnhnSk1vbXZZ?=
 =?utf-8?B?OER5MUN6NCtWSFc5NjRyVHVwRXhEb0UzczRyNGMwRTFXUExsV2FUR3ZYL0c5?=
 =?utf-8?B?NFpsYnhHL0ZPRFo3Rkswa1RxNDdrVm1nS2NRdFdKV0YyOWs4K0N2bnNBNmZZ?=
 =?utf-8?B?M04zc3Q4WXRScEZHcG0zaHN6dVZoejBzdWNzdWRNYjRyM29qM084eEJEa1l6?=
 =?utf-8?B?eDFYYnhqMEc5VDdxc2JLQWVjcUhYc2lNWFJiSDdrYk9HTVdNQmJja3dmcDRY?=
 =?utf-8?B?M1JpcHNWYjgrWjV4cWw2VnM4SEQ1Z2Ntc1UzSlY2cTMxYmNjak9aeE1UdVVp?=
 =?utf-8?B?U3FycWpLYnlKaWJFeFVxOWlrK0lRYXA3MVI0K2dUZUhNVFFRbjJiRmxqeDJ6?=
 =?utf-8?B?aWEvWnpiOU9tUlVhLzdFM0dBZW8xaU1GQStSQ2Q5Y09rU2I1M1BFK1hzYkl2?=
 =?utf-8?B?bnFuVGtDc21JaEd5WEY4MUo2TGFkbnhDRUd2Wi9rRzlDbExBdk11alcwazhJ?=
 =?utf-8?B?Zjc0ai9uSG83QU5OZ0w2OVFZNmhJV2o1ZitUdjlqN00zdFhHSlpEVk1zYzhK?=
 =?utf-8?B?RkhCc0RlMEhSZDVCZkRtYUNLYzVhbWQ4QVZHRXQvSU5wd1M3VDUrVThPVmlx?=
 =?utf-8?B?UWdQeFRkeDQ1WjNNbEF1MzJYU1JNYWd3TlBqN1p0aTIxY1dNT2xralE2QUpK?=
 =?utf-8?B?WG51bGV3dTBaR0UxQUxrT1BkNmlzd3NZSVlJTXE5WHErRzVzNEdNelZIU2hZ?=
 =?utf-8?B?VUF4bk1CSFVMK2Via0ZpWk5TL0M2MjRuYjY3NEluUzdHeER3c1ZMVXhodnh4?=
 =?utf-8?B?K2tFK28ycEYzOE1OMXFjWFp5RzZBM3NyaXlna1J4TEJHY2NhclY3TXJyb09R?=
 =?utf-8?B?OXJzdTRsYjRFS1ZtaWF1VFFvWmhJbFhQWFpqSFVOTGhBVkY3YkZ3TFY0Mmhz?=
 =?utf-8?B?Nld3a3hjamhoZktNSFloQUdFOFpBRThBVjJMc3Z3cnhsVlNIRGdEZnRBVlp3?=
 =?utf-8?B?bmVMOS9ab0ZLY3pBN1pKT1NUWGxHYUhyZ2xJSTRIQThrVHR6K2F1SkMzY0xu?=
 =?utf-8?B?QUs3bUFwcW9QMHJDOExvNVBBNFhZLzdHR1dRNndVUThyOHVEcW5FQUcvWDJ4?=
 =?utf-8?B?WTZlUE93MXZPTS9wRllYaThPUCtJaW5wZnd5aEZtWW40b2t1NGVVSHgwTUd1?=
 =?utf-8?B?bVZYbm5rNnZvL2VYdm4vQWhLM0kvVjB4MW05di9vNlZVZEUwajhsSXJ4WHBw?=
 =?utf-8?B?L3pwQjZjdzdwVkhGV25vdTM5cFVhZ2ZzSWtNYXdEZXIvcDZWdU5LK3JTd0xm?=
 =?utf-8?B?TC9vMnlLWFVVakZkWFVUL3N2VHJZalVqRWNUa0ZJV2RCVW5oVTRrQ1pjUkVv?=
 =?utf-8?B?akpTbzRHdTRLVGdrZTZubjhwZWFFa1daVERlZ3g1Q3ZxRE1wUnBFYk9aTXp3?=
 =?utf-8?B?blcxajJXYm5XNmtWWTJaQmlDaWxtcUUrMnRManB6OXhwbkhqSStsZXFUTzRm?=
 =?utf-8?B?VGdjbXBzd2lnTGpPMGluZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5779.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjJFTWZ3bXYvY3huSjJVTFIyek9tbGtjWG41TC8zQVdHUmhqajdreGh6d0Jy?=
 =?utf-8?B?TVVRK3ZBUVBzMWVLSmZ5OU1XUHBQekNRZDkxVk9wbDRzOWVVT2tXd1c4Smpx?=
 =?utf-8?B?ZjQybVZCeDJxdkhocXhKTXZqNHRnWWoxYVhraEhPaHExRjAxYk9VWlBmOUdk?=
 =?utf-8?B?UExyMTVmblR5dnIrTXVtMzNUalZnczFDYUtJSjFQRWNaK2VLaWRwUmR1MS9j?=
 =?utf-8?B?eVgweVpqOG9FSVUrcTRSeHdoSW5Odk5WRzRpRHNoS2ZRb2YzNjdOSFNRcllY?=
 =?utf-8?B?QXc2K0g2VEtKV3FRNDNuaTFRZU9kUU1DemRySHo0WllwVExSRHJndVpjSVR2?=
 =?utf-8?B?VE10VXhPWlhYYytwQmkxSm5XN21Na1pycjJBKzZUek1pZzQ0cTBRT2p1bFFi?=
 =?utf-8?B?Y3dOOXBNaS9Ob1F1YjF3WE9ySVdrOERIWUh4VHNhazNBQUR4RlVBb0FwRXZJ?=
 =?utf-8?B?cllsSXduUGk0U1BoMStybDJYbmxQR1pTb09ha2x6ZXQwTEN3aHVmVHdLM0xm?=
 =?utf-8?B?U2RZUjBNcVVoenhFMTBGK2Z1MDZrV2NoMlc4a1dyRE9xMVNjblYxU0VCSHhU?=
 =?utf-8?B?dSt5b0NqbUNUczlCU2tWdXBRVHdKK2xUODhXbFF1WURVZGtac3AyeWd4OElP?=
 =?utf-8?B?YnRXemZ2SFlRWmdyaWVmWGtLOFROOUF5MlVUQ0xmMUNQQjdrYzM4OGtIdjFT?=
 =?utf-8?B?SjJueWhnVEZqaTB5djV4OTJUMEhnK2hmeXBtWmliOTlGQkRTdkU5c2ppQXln?=
 =?utf-8?B?ZkdmVVBld2owa1NJS0x4TTQyZWVxN2c4WEF5Vy9VSWVmTjQ4N0JacnRadFI4?=
 =?utf-8?B?SHB1QmNhdGQwZjNwZXRYSVZ3MloyRkVNUWtyZkV6RW9LeksyZXBaL09WVXFz?=
 =?utf-8?B?WjJOdDZXTm10UkxvZXFNdTJWTUJKWnlKN0hNa0diaDJuTnpxY211dWhvYlRZ?=
 =?utf-8?B?azh5ZThwWDgrblhERUFHVjkyWWZuL2lkbkNZM0RzTUpLZUt0RWppc2RTSlYz?=
 =?utf-8?B?d1pCcE9CcUpiY0J4S3U5YXdJRDg4VFBkbzNZQ3JtbU40emFoUXc4S1hSK0lq?=
 =?utf-8?B?eVVrMCtYeTFaNkh6blp3TUFhS0lFMnk1L0ZDYW0rNUluMUN1VXAvc2FDaThi?=
 =?utf-8?B?dzRRSE11RGxWcGdOSEtaWHlpTkY0TnQ4aHpGU01EaFNVVGcyY1EyZm5mMDF0?=
 =?utf-8?B?bWhYMXo0QjVnT1FUc0hJZVNvajdhQTNObmhIUlFpWHJXd2RRTG54M2JMYWpW?=
 =?utf-8?B?MUNLMHBWT3l4TFhPQ1E0Z296bmk5WWZWTHI1UmxIY3J3dUtlYVdwVlAyWEFW?=
 =?utf-8?B?STljcmdNcW96R0o2UzBTcmZaNUhoZEFWT1VRS3ZhYmVKQ1FHQitRK1NLUCtU?=
 =?utf-8?B?d0FKL2hQOUNaZG8wdGRCUCtmZWdmMzF0YW14YVp0cy9Wb1Ixem5oSStZYlFU?=
 =?utf-8?B?MjBFV2IxeTk0cG5zZ1BxaWN4SmhSN1o4NFdMamQ3L3ZGZ3B2QjRhRTJHc0xy?=
 =?utf-8?B?Q0FwdG03VEhQOEFrOUhKeGh6bm5WYll2K3lTSDdXT2FvZ1RyZ0p2b1JUcUtS?=
 =?utf-8?B?b2hSeG5FRXJCK1A3SVM0UHlqbHo0MTJVb044a1JxZ09pTjJvdkdQbGpqUHZ1?=
 =?utf-8?B?WXdkWjBjTGcwenM1ckVUMVJPZ3V0SkYxWkxRMGU1ampMejVhU094eCs1VGxR?=
 =?utf-8?B?aVljeFp2NmhMQVhPNDlwNmtiQit3cTZvSkRqT0NBak9vUkNQOE1yQlYyY3BH?=
 =?utf-8?B?OEhMbE1jWUJ2SjkzSEUvUXVINzgrU2gxb1hKQ2NvZGtiVmtkekZTb3hHOU42?=
 =?utf-8?B?VXhNcHJ5SlAzblNnNWtUUmNpL0FIcklOTmV4L3hZRUtwSU5EeGZ4M1R0ekNW?=
 =?utf-8?B?THZUMVJOQS9vQUF0b21ralhmN0RuM1Eyd2pvcUZXdlFIbG5MTVg3Y1dLdUk3?=
 =?utf-8?B?Slo4VXlaVDRmWDdlK3ZFdzMyU1J0ZVV5WGpOK0NrWmtRYUx1ZWl5WnZDZ04x?=
 =?utf-8?B?SExNZmRva0toR2R2a2JjUmxVMWxtWmNwMXlaOGJma0JRMU1zYzE1cGFyMXds?=
 =?utf-8?B?YmR2cHFONk1makZyWWdvV056clgySDJjNDd1Tk8wYXFCU2F2enFXeTNTUjV4?=
 =?utf-8?Q?I3jbrqjHcfoZkBTTJogc7P4o+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1755DC847FAFBD49974D35A246EB077E@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5779.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157fd4ec-5b88-4efe-d2d4-08dce6a05448
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 07:19:06.2923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zf9OYeXIir/pbv5HoBN5BbLKgKTgERlgl+6myDPpPVa9FSMP6AiG4CERlKoU3jr9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10532

T24gU3VuLCAyMDI0LTEwLTA2IGF0IDE0OjE2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUaHUsIDMgT2N0IDIwMjQgMTQ6MjI6MTcgKzAyMDANCj4gRW1pbCBHZWRlbnJ5ZCA8
ZW1pbC5nZWRlbnJ5ZEBheGlzLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gK3N0cnVjdCBvcHQzMDAx
X2NoaXBfaW5mbyB7DQo+ID4gKwljb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAoKmNoYW5uZWxz
KVsyXTsNCj4gPiArCWVudW0gaWlvX2NoYW5fdHlwZSBjaGFuX3R5cGU7DQo+ID4gKwlpbnQgbnVt
X2NoYW5uZWxzOw0KPiA+ICsNCj4gPiArCWNvbnN0IHN0cnVjdCBvcHQzMDAxX3NjYWxlICgqc2Nh
bGVzKVsxMl07DQo+IFRoaXMgZG9lc24ndCBjb21waWxlIGZvciBtZSBhcyBvbmUgb2YgdGhlIHR3
byBvcHRpb25zIG9ubHkNCj4gaGFzIDExIGVudHJpZXMuICBZb3UgY291bGQgZWl0aGVyIGZvcmNl
IHRoZW0gdG8gYmUgMTINCj4gZW50cmllcyBlYWNoIG9yIHVzZSBhIHBvaW50ZXIgd2l0aG91dCB0
aGUgc2l6ZSBhbmQNCj4gYWRkIGEgbnVtX3NjYWxlcyBlbnRyeSBpbiBoZXJlLg0KPiANCj4gSm9u
YXRoYW4NCg0KSGkgSm9uYXRoYW4sDQoNCkFyZSB5b3UgYnVpbGRpbmcgb24gdG9wIG9mIHRoZSBw
YXRjaCB0aGF0IHdhcyBhY2NlcHRlZCBpbiBlYXJsaWVyIHZlcnNpb25zIG9mIHRoaXMNCnBhdGNo
IHNldD8gVGhhdCBwYXRjaCBhZGRzIHRoZSB0d2VsZnRoIG1pc3Npbmcgc2NhbGUgdmFsdWUgZm9y
IHRoZSBvcHQzMDAxLg0KU2VlOsKgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwOTE2
LWFkZF9vcHQzMDAyLXYzLTEtOTg0YjE5MGNkNjhjQGF4aXMuY29tLw0KDQpTaG91bGQgSSBoYXZl
IGFkZGVkIHNvbWUgdGFnIHRvIGhpZ2hsaWdodCB0aGUgZGVwZW5kZW5jeSBmb3IgdGhpcyB2ZXJz
aW9uIG9mIHRoZQ0KcGF0Y2ggc2V0Pw0KDQpCZXN0IHJlZ2FyZHMsDQpFbWlsIA0K

