Return-Path: <linux-iio+bounces-18186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A0A91546
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 09:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40E619E0E1E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C283421ADC2;
	Thu, 17 Apr 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uXJmfc76"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2E221ABCB;
	Thu, 17 Apr 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875016; cv=fail; b=BK6+8Xxf85l7Fz05Jv3rtYfa0R8U6zDgECthM9/cTHtaZtlKFxJLr7CrjJECT/z0XMnTljEyATvVSONBnT+CywqoIFsxba9Mao29zpkk9x22nG8M1O6YFD+R+OXng8Ri3N4KwoUDn+1HSsG3uqft08q4ulu+TKMqZHme+Ip0CtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875016; c=relaxed/simple;
	bh=QFGO9ST1IRssF1AnAY5iTYP1nU6Jk/ilFmW0lrIidzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dRfv4BT+mEfY7uqv0iVThVhc6fDpk+PFwk5aydubl5jpFjqEnileFGqK9mA0WGvXHAe3wUdo2uMhN8Pe0uj60qvPmpvR3vhBkN4jnLqXPL4Ngx1alySYprHmaI9ybxehAbPGSogtqhKuz0haqdwiJAy5YGwuavSNFJkvTqbA/+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uXJmfc76; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQS5ht5eu7mcsePfTKGijqrWJphvHdagttF3IGuvBWMPvFOrzhjsg7BCKr9QcgrFm/gqSKgeUnTNUova/PYf3dcgzAfCBtX/cdvGYvZV2vjFVESQy/jU8bh35wpO5MLKOSMGIEEcYX3bGCFT7XOWCMWI1SzAVveP8nIZEGUELZqiz311GcjR0m2I9QbcP7lk6f8BRpkX1zXs/t4kmJpdBQF01yg7W6XuSOwINj17OZ8Ll9z4TDT7muGqBV6SOWKwgpRBpIFnHLP6UIevlcfRp8TpBHjkTMlYaRKdheZ7ionsmoSsuZMfyr6ReQg5Hd2gJAbwa6hh0w/UQyKg7bZJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFGO9ST1IRssF1AnAY5iTYP1nU6Jk/ilFmW0lrIidzQ=;
 b=jzVTGpAB45i10OxyPyb6yP85Gx21u9IN0XMNQHSXYG58eU+ALE6Qc+7VnuJ6KQBqggITM4PS4/vdq5oCjw17vIjcmsbNyUqfIfzebKAz4yqNxIxowu+yr+BuzKexY37tXIKGSI7nPY2I8eDWZequ+iKhqgWRX+NG/1nuAaMZbcr56xibAKVqnInw5hubRHTHhSl1by8rLW0rr8Q2dSex+5NoNxMFSsaX/6D8g1VPOcYe3xF7Aob/zOuQJpbjMgiuGPIAD99SGJmrUoNJQTi6xuT3P4remq1Au1rFp9X4nv1fvkR6cbf7kLGKFTVDyzL7bV8KGEx1224arCdEdstGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFGO9ST1IRssF1AnAY5iTYP1nU6Jk/ilFmW0lrIidzQ=;
 b=uXJmfc76EzSBbSNUZWyXQNcczIu9TU3LDCwg9w3XR/FYRyps5YfVIIblRXRkZlG6wmPLfmiAjMNXuoVN+aD+yg2MWofAEeXTYXcy1FuOwVreQ/eClgfIZSh0fP5fcJpeaPL/mi8HevgaDb1BpQ7u13ry5Z/GvFD9qVQISRsxY3SU93YgjCOeOiwM95+IxvHvyU7/BUMnzwqxXNz+q8ewmHwBEMAqP7Pt/vOsczgTmHtFwHBhcsSHknIrICeUQIGzebcMO1oFLUCXyxRJK92q1l58yya7OkYUsd/CZMR8jJ5vi5KVbnrV8VwA6k3qxCs83rD47vvuPQ0MQWtVab0cyQ==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by CH3PR11MB7675.namprd11.prod.outlook.com (2603:10b6:610:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 07:30:09 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%7]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 07:30:09 +0000
From: <Victor.Duicu@microchip.com>
To: <jic23@kernel.org>
CC: <Marius.Cristea@microchip.com>, <andy@kernel.org>,
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>, <nuno.sa@analog.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] add support for MCP998X
Thread-Topic: [PATCH v1 0/2] add support for MCP998X
Thread-Index: AQHbrgoYtDMacT0SjE+TYb2teFxhyLOk/54AgAJ5ZAA=
Date: Thu, 17 Apr 2025 07:30:09 +0000
Message-ID: <d1b4916456101d95adc84f9e9847fefdff80792d.camel@microchip.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
		 <20250415184308.2deb6d3f@jic23-huawei>
In-Reply-To: <20250415184308.2deb6d3f@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|CH3PR11MB7675:EE_
x-ms-office365-filtering-correlation-id: 13cfb3b5-ada0-4c8d-9589-08dd7d81aef4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2dIQTlNUHUwZ0dOTGlKTmswSnJxQ0ZqTmFZTTdsa1BpWVZqY2pUK085OCti?=
 =?utf-8?B?MDVLSlBCRUM5Yk4weDVDR3RKQkl5NkFtRlhneE1zNDhJUHFvWllZdit0TzZE?=
 =?utf-8?B?eXhWU2JFbjhvS0RMVUpTUHBHOXM5VHl2ZEpCVFRPNWFmRDdJVm5nSitxa0hi?=
 =?utf-8?B?UGRYUXNuWHFNeUVNMSthS09DY3RSYjd2VXduWG5HWDc2MHJoM1FyR2lFL0U2?=
 =?utf-8?B?eFdXZXMwNUxMZGZJQ2FPOE5JSXpaSVF4bldKeDQ3Nkl6cys0TGR0a1A3dGt2?=
 =?utf-8?B?MnVoTmxqRG9HQ1V2bHR4VE9Jb0gvQlcvbzBYMzlDSWJDaWt2N3dNTGpCSGdR?=
 =?utf-8?B?NDY4ditBVCtXM0Z4bnVwZmpYTzVHZVJlYmt5TFdYYzFmeWJYN1hvM0lGT08z?=
 =?utf-8?B?eXYybzhtMTZVbjR5S2ZYWEJxME1kQlIyRWFCTG1ZT0J3RXQ2b0ZRaG9XVmFu?=
 =?utf-8?B?eGxWb2h6UzhReGN0UmVTTVEwU3QxN1ZHMGxxbW5GZE5TWk1JVFVBN2cxUkFQ?=
 =?utf-8?B?Q1ZVYnFVMlgvTmhkMGdVYTZLQVZyMFcxUTBOUy9NTW9NK2tMQmZPTzZsSmxU?=
 =?utf-8?B?WGFmbUhLdHAwdUo1RWxpeENCVk5rV0FiYmM5WGdNMjhiSjA3OUJCcWwyY2Zt?=
 =?utf-8?B?Y3FDVjliZkRqcDVtME1sUWN2and3eDNablUrV1JkZTFES0V5VXQybEdTbm5N?=
 =?utf-8?B?VklIUnZSOHZ1WGE3c05lVmJxdWJJWUV3ZEI1cGxQNE15QU5qVnI1V3NhRFor?=
 =?utf-8?B?Y2JvYlVXQmFkeUI1d3hSUEtPdzNlOUw0dlhPY3JZdVpJdmE2S3VEcHh2N1g5?=
 =?utf-8?B?ZmNWTFdCZlNvU3A2anJ1M3drdG5Zcm1pbzdueWsvQUh0akMxaTQxdFhRZnVM?=
 =?utf-8?B?b1VWQkZwNWduaTdCczZCVzlKa2gyUDZnSThKSWhSUnQxL1dORWQ2emhYRlht?=
 =?utf-8?B?Um1xYktpMlF1Z2JFVTRHWnIxMlJzRUo0b0N4bUF4cWtuTzEwOGNtRkg1dm1Q?=
 =?utf-8?B?RTU1d2lyQnpaNytlL3UzcUFDSEI3NWNmWjRuK0szei9YMUpKMzk3WkFFd3Vr?=
 =?utf-8?B?V0ZrQ1dqTTc0UmlvNTl0elpEclR2UHl6NDE1VjFDcDg5SkgxR28vSUM5aW4v?=
 =?utf-8?B?THdXL2l0cU85NHhUUXFUWHRBUi8xbGVaWmlRUXV0dWxuQjR3RnAyT0ZLTUxa?=
 =?utf-8?B?aFRkN2tLT2hYVXJubWgvQmUvanYyK0pSSkJMa2lvL1lxY0lWNG4rcFdsZklE?=
 =?utf-8?B?VGdTR09leTVUeXlnaFg1SVhVTHBLcUJzekdNdDB5ZlBnMWRidlF0RzJUdFpK?=
 =?utf-8?B?Rno3SHRxbWRxVU15R1hPUFQ1MGRuQUEzNjdQNUVOTnZ2Ym5EVWM3bFdtK050?=
 =?utf-8?B?djN2UFBOVk9XYzBFUnk5Tml0ekVGZlA0aTRRYTBIb3pQQXk1UzFIZHVvc0Nr?=
 =?utf-8?B?RVozNWg0Q3NQZXZHMEhXRGl6OEJIWWRGQ3ZXWmpadWtXQURiY0ZxbWJnM3pn?=
 =?utf-8?B?YWFkZ09jTDd1anltNXNxd2U5SGw5NW5HbW9YbmJpTW9iOWo5bW5nbmtnTWZ1?=
 =?utf-8?B?c2VMWEJPNHVsSE9DdnR0elJCZW9IT25qQjJHeE04VkJKTy9acExHd3BuY3pK?=
 =?utf-8?B?U2tJeldoNWpDTTd2RFdEUmVKL3kvR3RnZU1WMUxXV3RIa0pITXd0Mk9kdXli?=
 =?utf-8?B?OTlEWXViM1BpeUtLZ3hiZmhSUlR1aXBKU0R3Y3hvMTU4K0Z5RmlHQWlNeFhO?=
 =?utf-8?B?bDZ5M0dsWTFldnl4R0ZPeXJ3dVliVTYwQXpITHRlWXpYQTNtUy93RjdkRi9v?=
 =?utf-8?B?cFhZQmVpQW5jQzhTeDNzOFNhZGdqUUxMelczQXRHOGdwYUd4aCs1MVZ5b2ln?=
 =?utf-8?B?bkpsc3ZaTmlZMVA2MUxlem5oVzlDTkVyb0hMOENWcStmWWJXTFhjT3ZQZFha?=
 =?utf-8?B?VDVPUVdXM2l3ZHkxQjBYWTFTY2hUWGM4WnYwREFjWlZ6bVF0Unk2VXhKTXIy?=
 =?utf-8?B?VWk0YXpXUnF3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHA1L1hsOFlFZjBiVGtqN2QvMXZ2d0RrYXJDSW1HTnVESldFbHRCSXBna3c2?=
 =?utf-8?B?QmxoYklVbFNFWHZQcEJyWDhHSTF5bGlnclVYTHFLa0JtUC8xTVNRdUVuYXYw?=
 =?utf-8?B?Y1ZxaUsvV2FOc3dydUV5Q2JNeGdWRENNOUt5RGMwVloxMDdIaUFMY1hVREM0?=
 =?utf-8?B?eWRJb3dlaDhYV1JjTk5xUm1jYkdKcm0vU3Bxd2toRUhJREFWc2dzMFhEVy81?=
 =?utf-8?B?TkJwRGJwTEJubm9CbE9vTGU1L3B3aDdkYTlyWUF4LzRYSW9kZEZ1TlNkdEZQ?=
 =?utf-8?B?dmZSZ3hOR1BRRi9iaU0wNTFsY1V1eEFLcisybGh0Y05PR2dMalE0MjZQcElR?=
 =?utf-8?B?TzZiN1lnTVVXMDJKb3JkdXFKMEdrUnNuTXYxdFB0Uk9SSXhMMC8zQVJxdWR4?=
 =?utf-8?B?R3hyS1RZTWdROElyOUJLMmF6TGpVam5nTTZub0xKdVh2cHJFSElNdjNQaEFn?=
 =?utf-8?B?Qjl0cWNHNFd3UzhDZDNwK0xUUThseEFkM1puMjYrTFNzczAwM3k1YXVsOUVv?=
 =?utf-8?B?d1FSK01QODRnYlBQZS9HRGpNc3pNU0k2ZXpONUlkTm0ySDRnck1Ra1IzNFVT?=
 =?utf-8?B?cXBjbkEwT3pxN1RkTTdrWFJvREZnbldLMnNEeUhGZXFKT3dJekUvOXdqbWc5?=
 =?utf-8?B?M01qK2UydUE4UlV6SnZRLzlPTlRNTGNaL2lvTm5jYkJpdW11OElSWEhNQjFY?=
 =?utf-8?B?ZVdncDVERkpYd25oclRzQXcvTGs4ZXpJYmR5QjcxSk55TXFwWVgrdEJYYVg0?=
 =?utf-8?B?NEdTTWdtUzFRWWtpbUlJR3VPbHpDQ05acFNwNG5JWGliVXFXRlNpOU1EOFVE?=
 =?utf-8?B?ckpKQU41aXRUYXltM240bVJDOUV6Q3hOV1lvbUFJTEgzemMxUWZqQ2l4QnNC?=
 =?utf-8?B?RlQ1V2dhTzRGaUVrUXRvVFNjTjVmc294d2lkMXJyT3NRU0hUNDBweDJ3YU5t?=
 =?utf-8?B?OHFKWTNGSUdnSDBJZEk5aGdxYndiSlRWd2o2QTZKYzhRQzNaRUowK1hwSEdN?=
 =?utf-8?B?VENrMEJXZmpjeWQvZ29ZNWpjSjRTTmZiZGQ3SWpiRERSK05iRzdhaWoyamhF?=
 =?utf-8?B?c3pwZERXd1QrOCtvaGYycWwySGRkazFVZGx6R3pGVGx4S25VUVRWZXNnZzd0?=
 =?utf-8?B?TGVRb0pScmhrLzFzTGg5OTd1WEhPK1RESnMxWEpRTUxKTTZPY0ZRcWVpV045?=
 =?utf-8?B?dFBJVHVwRGtpb0tTSktLU2xITmMwVDJyMEtKNFRXaTJEMmVsWTJ2ekVDWmZq?=
 =?utf-8?B?MFl0U1NGVnVBRWZQK1Rybjh0Nk5sTWNXVkxhL0orSkUzS3VXRzU4bzNLY0Yv?=
 =?utf-8?B?TUhqVnR2QjdLeS9FdS9nM2l3UXh0bkRucnhQN0lLS2dERWxUQnZmdjc3M21V?=
 =?utf-8?B?QmlqTjBxTloyU3JyZ0RYVGtNK0lUQ1JFYlY4TjdBd1NZK0FnMmdJaENSaC9s?=
 =?utf-8?B?K3V5cVlJd3p2YXl3RVg1TUVNT2lpTVE3Q3pidzZpK3pIOTF2RVZ0UnE4eEtZ?=
 =?utf-8?B?UGY5MEZDMGhuV29EMmRob2l5RUt3Z3A4SGJSNWVSSWtzUVpaSW0zelhxK08w?=
 =?utf-8?B?VzhITXlYeWp0eHVNSGs2Vzl3cWI4emh3MFhmN2ZYM01wM1A1TndLdXgzVTRq?=
 =?utf-8?B?NXZEOXAzRU9Gb1VkeDB3dFduNWdiSXdiMmRoMGd1SnBJWWxkeWFEdUFuWlV1?=
 =?utf-8?B?anh1QmZLTHN2WXJWeDA3dlI1TG9NbjUwK2xqODRaaCtOdWxndGcvM3ZIaUZn?=
 =?utf-8?B?djNsNDdINndnWmZkQUkwV05CTnpHUTZmMElKenlDSzE0S1RpNFl5Rm1veFo5?=
 =?utf-8?B?YWo1c3R4OE9VSWoyZUtzK1o3WmNHVXhXQ2d2REs4WW5TSEl1TURPbHI4Q3ph?=
 =?utf-8?B?OFN1bGhPTTBOYjF3akxRMjM1eEh4akFSSXBjNEErckdGRGZEM25uQ0tXZDJ0?=
 =?utf-8?B?VVZVVmFFdm5jN2FaSmJiZGUrQVVDVHBlL1E1V3lmY1YzVXVSMVF2WFZScG9x?=
 =?utf-8?B?Tm1RNUNXMzJubklOOVBHdjNCbTZVQUFGNUxsSnY2elNiRjFuSnQ1RUsvcWQ4?=
 =?utf-8?B?b2lIM0pRRXl4YnYzTUZDZ09YNS9jRjN5V21qREt0V3pZU2lMazFZMVQvUllp?=
 =?utf-8?B?bUlHM3B5SDBUTlFsdjlrVys1QWlrQXVEd0JqTWtWV2VFcnZ1cDN0MWNSMzRW?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CC1FCCA9FA67A43B40375F92CA0C345@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cfb3b5-ada0-4c8d-9589-08dd7d81aef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 07:30:09.5976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oaaiSO4uRvuXtDQvBEVN/KBKx8UYBH2HNbGy+X9XhHJ3JguKpn8fMU2zAQTJil+3XqpY466vu5IY3Dsk7TAJUrgqT8IOGCrcDdqqR1dPQLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675

T24gVHVlLCAyMDI1LTA0LTE1IGF0IDE4OjQzICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwg
MTUgQXByIDIwMjUgMTY6MjY6MjEgKzAzMDANCj4gPHZpY3Rvci5kdWljdUBtaWNyb2NoaXAuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogVmljdG9yIER1aWN1IDx2aWN0b3IuZHVpY3VAbWljcm9j
aGlwLmNvbT4NCj4gPiANCj4gPiBBZGQgc3VwcG9ydCBmb3IgTWljcm9jaGlwIE1DUDk5OFgvMzMg
YW5kIE1DUDk5OFhELzMzRA0KPiA+IE11bHRpY2hhbm5lbCBBdXRvbW90aXZlIFRlbXBlcmF0dXJl
IE1vbml0b3IgRmFtaWx5Lg0KPiA+IA0KPiA+IFRoZSBjaGlwIGlzIGNhcGFibGUgb2YgbW9uaXRv
cmluZyB0ZW1wZXJhdHVyZXMgb24gZm91cg0KPiA+IGV4dGVybmFsIGNoYW5uZWxzIGFuZCBvbmUg
aW50ZXJuYWwuDQo+IEhpIFZpY3RvciwNCj4gDQoNCkhpIEpvbmF0aGFuLA0KDQo+IFRoaXMgZ2V0
cyB0aGUgc3RhbmRhcmQgcXVlc3Rpb24gZm9yIGEgdGVtcGVyYXR1cmUgc2Vuc29yLi4uDQo+IFdo
eSBJSU8gYW5kIG5vdCBod21vbj/CoCBHb29kIHRvIGhhdmUgdGhhdCBpbmZvIGluIHRoZSBjb3Zl
ciBsZXR0ZXIgb3INCj4gcGF0Y2ggZGVzY3JpcHRpb24uDQo+IA0KDQpUaGlzIHBhcnRpY3VsYXIg
dmVyc2lvbiBvZiB0aGUgZHJpdmVyIGlzIG5vdCB5ZXQgZmVhdHVyZSBjb21wbGV0ZS4NCkkgaW50
ZW5kIHRvIGFkZCBzb21lIGZ1bmN0aW9uYWxpdHkgbGF0ZXIsIHN1Y2ggYXMgaW50ZXJydXB0cyBh
bmQgZGF0YQ0KYnVmZmVyaW5nLg0KDQo+IEknZCBub3JtYWxseSBtb2FuIGFib3V0IHRoZSB3aWxk
IGNhcmRzIGV2ZW4gdGhvdWdoIHRoZXkgYXJlIG9ubHkNCj4gaW4gcGF0Y2ggdGl0bGVzLCBidXQg
bWVoLCB0aGUgZGF0YXNoZWV0IHVzZXMgdGhlIHdpbGQgY2FyZA0KPiBzbyB3ZSBhcmUgcHJvYmFi
bHkgc2FmZSBmb3IgYSB3aGlsZSBhdCBsZWFzdCENCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiANCj4g
PiANCj4gPiBWaWN0b3IgRHVpY3UgKDIpOg0KPiA+IMKgIGR0LWJpbmRpbmdzOiBpaW86IHRlbXBl
cmF0dXJlOiBhZGQgc3VwcG9ydCBmb3IgTUNQOTk4WA0KPiA+IMKgIGlpbzogdGVtcGVyYXR1cmU6
IGFkZCBzdXBwb3J0IGZvciBNQ1A5OThYDQo+ID4gDQo+ID4gwqAuLi4vdGVzdGluZy9zeXNmcy1i
dXMtaWlvLXRlbXBlcmF0dXJlLW1jcDk5ODIgfMKgIDE3ICsNCj4gPiDCoC4uLi9paW8vdGVtcGVy
YXR1cmUvbWljcm9jaGlwLG1jcDk5ODIueWFtbMKgwqDCoCB8IDE4MiArKysrDQo+ID4gwqBNQUlO
VEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDcgKw0KPiA+IMKgZHJpdmVycy9paW8vdGVtcGVyYXR1
cmUvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEwICsNCj4gPiDCoGRy
aXZlcnMvaWlvL3RlbXBlcmF0dXJlL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgMSArDQo+ID4gwqBkcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9tY3A5OTgyLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCA3OTQNCj4gPiArKysrKysrKysrKysrKysrKysNCj4gPiDCoDYg
ZmlsZXMgY2hhbmdlZCwgMTAxMSBpbnNlcnRpb25zKCspDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvLQ0KPiA+IHRlbXBlcmF0
dXJlLW1jcDk5ODINCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvbWljcm9jaGlwLG1jcDk5ODINCj4g
PiAueWFtbA0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaWlvL3RlbXBlcmF0dXJl
L21jcDk5ODIuYw0KPiA+IA0KPiA+IA0KPiA+IGJhc2UtY29tbWl0OiAzMWM1MmZlM2IyZWZlZWJm
YzcyY2M1MzM2NjUzYmFhYTk4ODliNDFlDQo+IA0KDQo=

