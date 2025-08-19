Return-Path: <linux-iio+bounces-22969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0071B2BE91
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 12:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9893AAD18
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC66320CA7;
	Tue, 19 Aug 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oGRDadQS"
X-Original-To: linux-iio@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012015.outbound.protection.outlook.com [40.107.75.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588183203A9;
	Tue, 19 Aug 2025 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598087; cv=fail; b=Bz+CXcrkmVVe1/j26qQwNTORljAUqyLljPtZ4oCBSmk5Quadf9D++E5pDe1Ldnpla4nQqa+vuAVwVjvt76zqfxEleR6YpVeN2I743aDieV/xlO9eJDrGHa7omcOKqkszOoRlTmRkiNcEU4GeNDy9mozRLwjbL/ZzF/DjUkmYc3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598087; c=relaxed/simple;
	bh=FExIkWA4NXRkAJl5i3qGzBwZ6Kdvfv4aNUlvyQ+3am4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LJZrtMxEh0sOi7NXT4FcVw/rbmdJR66twV7eHOdSrOOw2cEaHAqaR65/A+T1k0ZE6kXmzGdDWpluWGSoWLQkRcB8FnVTQs2+LaFukxFIpRVsSOuUu4aB/DIJZti1nm1qbEjixThYvAC7AG1sPg0LtyZLHUzKyHcFEOAkGjLpEOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oGRDadQS; arc=fail smtp.client-ip=40.107.75.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E30ZDoC3Fv162asO4YIxkbXTFgG6FNcPp2tHXGERA3MwFxacN2ECglvUP9dgIDs+D8bq9ZXnZRuEjz2x14sQC3Slhu4wmOmXO4tOXSUs19xKXTde/1S5UA2x/7loFdLhnTpSmo4mAj29QlnlMyRyfTZS/V+MFe+cko5lRoyEhxNeBuylPerBhH6etEw6+F9YjRVa7pCBudC6aSC8qJ3h7dYVajJlxZt4+Oxt4cTtoe8XbcKhU5SdmqkAnbPcLiQwZlBg52yvzWCWqQzdFCdPTR2uy6+3b5/FG+QPjqztmOd0ZGuaC8xlsr2UlNdq9h9W3tUavM5Z6jeTItbnHZXv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We4tQWssLgT6WpYmAv1eECE1Z8MVyM6FGcuJJs50fJY=;
 b=UDdkI0tQuMSqPvlveqEGQzOJFQatQ8qGXwwUq1HTi09mk1jE50f99RxsrC4YFbecFdT78JT8hqwAXlmlId3zyF3PDek2uDfTXhSpBoE0S8U7NBpUF355XuCSSE5q3AWa7NXMl5UUeYXO+CSY6009LF/Dy7RxDnBdVdoMyznLysEtTmuLwe7yGtK+xLxWoDobooyj+9JzEqpn/hrW0MZuOfLHDO9AdurAmMMiBu4wPUYim5UIaFKgSSh6sdtVpm6hw4dRWk4LgonohBX4CMh4wYcyn5ZbnqEhHYNWqvirU0DppemXK5vNAHzQwnDUuq2DZaTDGSCMXHSslA4jxCWVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We4tQWssLgT6WpYmAv1eECE1Z8MVyM6FGcuJJs50fJY=;
 b=oGRDadQSIVsti1hmszpNNC+Th6cSYdyergZifU6U0yMz/K6cZ+3u4ptbaQidsCxIBDXpXuDANwgJiFLSw9rneqqfAnq8HLtdkhsMiaJ+ig188lae1s92fBbNeoPXjpzQ9OaZhAPRZe28bKbfZJ0rGTB+b0VWhaWj6ND1SblLmYl6fv0qvvXKhcZsNNeNCOo2udwhabvKwOy7XYwSnXc46a+XHlsNY+SPqhgo1klANQUw2J+WdYcGzFjpS1ELKLl1/zWJMot0srbI2M7TFCEmNMB1EU131GjsGuTsPjs9r7SDKRxVIoguwWoA5Ghop/VrdGtFMYh2OpNIvvndG7GlKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB6866.apcprd06.prod.outlook.com (2603:1096:820:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:07:58 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 10:07:58 +0000
Message-ID: <995cbacb-b01e-4799-84ab-44d58ab32ab7@vivo.com>
Date: Tue, 19 Aug 2025 18:07:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: common: scmi_iio: use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819085542.538715-1-rongqianfeng@vivo.com>
 <CAHp75VdAySwLZ8gf_mDoQDX4KdC-hsCYL3VbkZSk_NSKNY5VTw@mail.gmail.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <CAHp75VdAySwLZ8gf_mDoQDX4KdC-hsCYL3VbkZSk_NSKNY5VTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::22) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: d7406f8b-3732-48d7-88f5-08dddf084615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2d6NlpkaXdBL1JrOXZsZXBRemloMTlzQnN6L01YME5idkQxRThhM0x0Ny9N?=
 =?utf-8?B?SlVMNVdvSmVwNG16NFVTRHhnZURyYlZJK2JRTDJaOTR2ZEFSYStYMmoxUGd1?=
 =?utf-8?B?eTg2QzZwUmVRUURSNlpFcHQ0bitSMURsU0diTFJDbFFUOHh0dWdUTFBNUkNB?=
 =?utf-8?B?aFU2U1NSamVBVnJsU2NFZlJPRjIvZEduMkMzOTdvUGlRSEhVQVZWQ05td3JF?=
 =?utf-8?B?OHE4S1BTWFpuLzB0R0hiaFM3UzV4V2pkeXpndkFIM2hpdDYrK1hvbmJjTXVj?=
 =?utf-8?B?NkgwaFVTbG1zT3dsa1pSY2YvdjRMbXRJdm1WeTJralFQZUlqSUxaOFRtVXp1?=
 =?utf-8?B?akptTXhSSGpXODd2YzlETGRiaUxCWHZTNGMzbjBieFBrOTNsVS9kOTFxZU5n?=
 =?utf-8?B?bWc5YVQwVnVHMXJaRjdOWGU4d3JOd3VuNDlKc3BQNUp6RWxrR21sRHJVTTV5?=
 =?utf-8?B?a05oemMycGx4TmhJcXhCQkhzeHlwR29xMURzeUs2dVFERm5kWmc1cmxJYTcv?=
 =?utf-8?B?dHpjdFJWc2NtazhlNDloYUtqRkVnYTNMSExJRDVTTjRoMGVoek1SK05HbFc5?=
 =?utf-8?B?eEVXU2oyWVZlREpnUnlvYnhnby9yOENBNkkzT3M2dXBONEpReCtHSERReHBv?=
 =?utf-8?B?QUtpa0t1bU9CTFZrSWNXTDR5dnJhOTVOdG45K3pMWWJFNFJaM05rYkFRak5l?=
 =?utf-8?B?VFdDSnNZTmxJanNVQXpLaDR0Y2tsWlphMWp1SG13Z2p5Qk1kNzJoNThFc09E?=
 =?utf-8?B?MUpTUTFaMDBJWWx1SHNHK243aEY2N01MMjd1ZlVkR3htdVRiN0dIMVlFQWJs?=
 =?utf-8?B?eDN0aWdyWFZySFZlZTBVZlRhM1Y5RTYwVTNWaVh6Tm1YNDBpV1VGaDNjek11?=
 =?utf-8?B?OGhKQmhEd1A5bVZWYlVkb0V4eFJHNEFqOGZ3bzRUdzBEc3VLVDVQODdIWEZz?=
 =?utf-8?B?TStpZFRibTFLRk1zVGdpOXZFQmh3cGRNc2RXKzhkc2c0TlBZZ3ZacEJHalpi?=
 =?utf-8?B?WjR1YmNGVkRNSjUzNXM5OGxFZHFEa2JUcmtPaWMvTzFQZmYyM1FpaDhrUkk0?=
 =?utf-8?B?UE5lQ1pjWDlRWVdHWjNYaDhGWVFLVHVjaHUrWFdERE8vSG5BQ3RJQStDTk1B?=
 =?utf-8?B?RTdJd3M2dE5kZVByaDhoNUlFUWVueS9nTG5YRGQ0OTVaYkpYUlJIU05RSk5C?=
 =?utf-8?B?TWhzdlNGTEN5clArS1VqQ3NzTXFMVDlQSjBHV1BIVWFDU3BRcVdBOE9lZ1ZU?=
 =?utf-8?B?Q1NhazRqTU5DdTdVSS91aDZseVdmRS9XRjBhRmkxOGpPYnRIWWJDN2Z1T0o0?=
 =?utf-8?B?dDFkd3NHUDAxNkJ1Z3FURnB6Z0xKSGNza3VzSXJWcmJOZzJ4MjZGMFlsZ1pk?=
 =?utf-8?B?N0dSb2pDZ0xkenc3dys0RUtGRFYxNHdqRS9NaEg1dmVLby9ZcHkzdU44MU4v?=
 =?utf-8?B?cHdZWjcyWGhrd1hCQis3cHhBOVBpU3l0VHBYUDlZSXg3RjFWMStSSnQ4SWZZ?=
 =?utf-8?B?bDdWL2VYTSsvaUJseVBIb3ZUQ2RFZmx3SXVBR1JKNXlLdENGYWZmOGllUW9u?=
 =?utf-8?B?NjFGZ2tWNmVMWFFFdXpHd0dlRjZtcHhsL2trZzNMWHBodVVXbEJBTlh3Z2hP?=
 =?utf-8?B?ZGtMMmM0T25XOVU2b0xOR1VMaDhoYjJMZTgrNit0NVNVeUZpT21tNk1JSDNX?=
 =?utf-8?B?S2p4cUdKSUNuOXVWUGdxR1NRUGVDdkxhSDJSM2hyK0hoSVd6bklyMzhETTht?=
 =?utf-8?B?eXVaYnBReVNqbG5kei9IQUExQmdQQS9RSmh3MksrbTBYN1V3SnJrRXd1TllJ?=
 =?utf-8?B?Y2IrVmk3dk5CMVM0LzV1THFLS3pQajI5emxMK2c4MzhtTFhBUmN4VThGU1VH?=
 =?utf-8?B?YUlRQmYyaXg3NjVRbjQwNmpJbFM1NHNDYTNMVUErTUJRWjdDNHhFd2UyWVJD?=
 =?utf-8?Q?y3H4WXlnCCE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SndWcXVEZEZ5TXNjUVdQV2ZwRkhEeGdBMXdpQUhneVl1WU80aUlDZVhzbDgx?=
 =?utf-8?B?U2lKWDV4WkdRK09oZzZ0VUhRZ1NaNXdXZ0xidmhSWW5VNkhuUlhpOXJMSmlR?=
 =?utf-8?B?MTBtUjRTZzRNSU1iMmZjVHF5dXpvNjVMNkNIZlZsSERTTjc1S2YxWSt0cWxP?=
 =?utf-8?B?NVVyZ3dteE5iUFBPMWY1WDlpdThNRHBCWFBlZldRZDJaMGVFN3FEZHRDRnI4?=
 =?utf-8?B?eGlkUFpCMkZlaEZCWCtiS1lXVk9aK1J1amtUUnZSelRWYXl6VlNKUnhJdHRa?=
 =?utf-8?B?OE9MbW5rSzFlTVdkK2xKT2doR25pZm5sU3gzdjRzdzd4TmI0cTYyQkdVQkZ3?=
 =?utf-8?B?TVVYbXMxSlVBNGVTNmtBYzVSQll3MU80YzRKSDY3STZQT3ROMDV0eG9BNUZD?=
 =?utf-8?B?NHNocjNwSkloc2NlNjB0ZGtHUVRzYUJjN3p5OUYwaEJIeE1RbmMyNEdxRzE2?=
 =?utf-8?B?bEt1WEpsbDhrT2pObmpvRDVYRWVobjhTMDVQUE0xNm5XWUF5SUlyOUZOSzcx?=
 =?utf-8?B?aktMR0kwbEtLYnFlaW1GMEtpN3lCTjlrYWEyZGR4aXRzekhmVmkyaDQ3c2h6?=
 =?utf-8?B?SzJkbEdFT2g3Wmc0dmJsQmpTTWlwTFMzb1g5LzZseDJwLzBuRkI5ZzhCdmVO?=
 =?utf-8?B?TGJvNWVUWGRZTTd1ZVZ6OHRNVkZ2UDhwUURra2xTcG1raUw2L1VwejhYR1Bp?=
 =?utf-8?B?cUhXSnNuYy9DWGVZcGFlS3JnWnJFcUhvenNCREQ5b2dIQlVQVkZJaDI5RFh3?=
 =?utf-8?B?ZyszOGJSSlRRSnFHanQ2ZmVXOUxuRnp4ZzgzeWxOb1RXMVJ3Z1VVZi9LeWgv?=
 =?utf-8?B?K044bGhGYUJmRFBLQlpURENSYnFjQ2grWVdlQVk2TTRtVE9aNy9ZZHBCcDRm?=
 =?utf-8?B?KzI2K2ttamlaQ3lGMXBja2ltaXNMQlowN05UbUxHbzdIalQwYmhCdHRqZFZl?=
 =?utf-8?B?cWVqcktqR3hTbUlSV2dObm5ZUGFGK3RyblJxMU1UQWhVdFE0YSsxWVZwV2cx?=
 =?utf-8?B?RktKc28wVXNBTW92dElCc1FFWjVvNWJJQlN0NE8zTXo5elV3WmNoSjVmdXBU?=
 =?utf-8?B?MHZ6UTJGaFFhbm1rZm82alF2N21JKzBXbnp0UUt2MVVSMzYvdVZEdDdPNEtK?=
 =?utf-8?B?VVU2WDJmYnZDekJvb0tZS2ZLYUE0TU1nM0FiOEdzN3oyT0xOQmg3QU51YktK?=
 =?utf-8?B?bXJvVlU1TXNnOER6OWYxZUphUUd1NnlEdnBTTldoMG1UYTR6d2lsbnp0Rlo2?=
 =?utf-8?B?Zi9vc2tlejQvYXdMSlh4OWFEWUdMcUNZZHZ0LzZkZisvRUF0eU9jUG0yYksw?=
 =?utf-8?B?akxvTnZ4bVZqS001STROeHBBZzdld1lBNXcyUzgrTE14bFJJN0FPTmhvUW9v?=
 =?utf-8?B?N0Qzcm82VHhpemxqamtObG92NlZnY3ZPWVQxdUdvMU84MldNWkRQdzVFeit4?=
 =?utf-8?B?eGlJMkErNHJiakpGQ2hhUTNCbHAyRHZTNVo1c3o1WnU2d1BrR3MySk50K2Zk?=
 =?utf-8?B?RHh2MGhEWXJ5WU9vV3hnT1JVcUtLYmwxTGEycnFHa0JqVkVpdmJjcFpaL1dw?=
 =?utf-8?B?djRIWmlwa2VvNmVvTkJCVnlRaGJsWjFZcC9aZFRrbEE2dkFJeWlpM0JnQUVR?=
 =?utf-8?B?aUZrMXp0QTZxak10ZW9tS3VxeHZaRDV2M2taTk9hYmN6cmNIUUJ6cnR4Mm9Y?=
 =?utf-8?B?dmpPai9CcW9pZ0pUbmZwQ0tZeXFhaVNtckRuTWg2ektHY2x2eVFRRVF0bkZI?=
 =?utf-8?B?ak0vc0poWnF2Q1E2ZTdjcDFJb0FXbTZHWUF4b1pxTUVkTWkvNG5ES04xWDNI?=
 =?utf-8?B?SlFmRjU0QWIzZzRMMG9oL2EwMVNkWGw1UTJxK1VSOTgvWmhFZG9TYlBiT2NZ?=
 =?utf-8?B?ZEpCaFlZQTJ2ODlqeEp4SWNQMUc5R3lKbWF2K2dnV3V5dG5OZE9rNk10aEpP?=
 =?utf-8?B?V2RyY1RXanpDbEMyWHFzdEMwTVZROS8wMGc3Qkc3d0hScU80bmVjUThRRW1W?=
 =?utf-8?B?U1dNYWJPQXZGcUc1WXJPd3pnN1BlaDllWm1hRnlRWWhlZ0d6TW43cFFFZkxC?=
 =?utf-8?B?UXVEQlFWMGw0T2NKd3JXdTVPWW5tLzBWbmJvOGREY3pHVjI5RDJ6NGlsSDNx?=
 =?utf-8?Q?7Rhyj/0V3r62fMrDpzeVUJDBP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7406f8b-3732-48d7-88f5-08dddf084615
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 10:07:58.6682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6shgfwPEZrlzMnjCb1jDkKOdRTaTCU6AY9vPB9g8gdMdnh2IS2RmfU09rAKfRm2k961MgUOuGBml/BOfdUELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6866


在 2025/8/19 17:46, Andy Shevchenko 写道:
> [You don't often get email from andy.shevchenko@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Aug 19, 2025 at 11:56 AM Qianfeng Rong <rongqianfeng@vivo.com> wrote:
>> Replace calls of devm_kzalloc() with devm_kcalloc() in scmi_alloc_iiodev()
>> and scmi_iio_set_sampling_freq_avail() for safer memory allocation with
>> built-in overflow protection.
> While this change is correct...
>
> ...
>
>>          sensor->freq_avail =
>> -               devm_kzalloc(&iio_dev->dev,
>> -                            sizeof(*sensor->freq_avail) *
>> -                                    (sensor->sensor_info->intervals.count * 2),
>> +               devm_kcalloc(&iio_dev->dev,
>> +                            sensor->sensor_info->intervals.count * 2,
> ...I would also switch this to use array_size() instead of explicit
> multiplication as it will check for boundaries that are not static in
> this case.

I don't understand what "will check for boundaries that are not static in
this case" means. Could you explain it to me?

I've experimented with the following command and found that kmalloc_array()
generates fewer instructions than kmalloc(array_size()):
objdump -dSl --prefix-addresses <changed module>.o

> --
> With Best Regards,
> Andy Shevchenko
Best regards,
Qianfeng

