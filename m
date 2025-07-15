Return-Path: <linux-iio+bounces-21669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37702B05556
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E315D1AA522B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168BE275851;
	Tue, 15 Jul 2025 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="QZ7+VJJk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADDC22129E;
	Tue, 15 Jul 2025 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569368; cv=fail; b=lOvohNyqZnHYVewIJa+qWTJnLAlrc+hlYjMFmruiSEioMdKaxXxU1RE1U2ycIbAxHjah/GK2CQX5B22yGuO+vDh06jykCD0EBZQkGMBpC9RZ3pPV8qsAy9o/dFMWbpsujMFubmEc+tgsnwn/qEzi8ufVXz/CtgvQhk//4qznJ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569368; c=relaxed/simple;
	bh=iyOfZVuxay03palXP5Jgr0amBhC7CcXtTukC4vCUcks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QxtaxyBlSEnR/JllRQo3BKh+4a3o5rR6iIBwIYKj1J4S7m8VyVZKKGDmmR+fMg3xuGsEX0NIGatsK2rnBJ9rJ54vJ6Jy3VoGa0xZXBlxFtI/tDaGrS5Uii2FWHyMJZliy3faMQXK9+SK6bt9nX3DaHw5vWD8H5dfsov+tzLbrEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=QZ7+VJJk; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EMwXHV010991;
	Tue, 15 Jul 2025 08:49:00 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010005.outbound.protection.outlook.com [52.101.169.5])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47uft5t1f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 08:49:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQhbGKYIlWE8sYEzPxAMYhx9Q1eIjT65NVZTXgT3qzx7T2Hp2vv9hqDdIR9PTbYnIByE7n40NSq63dGhyK0SbzLC2XPkVjhuH2t1sU4jCGGkbtwbqQiJDc6j2mpdD5utEVFAgI9ZzdVBuqSyWLUTyj/gnn8K5RSXF97GisB/imh9WokqdghzVVhrwfqwmhaZo6pKEGj7x3ELBHpjwF0ltiTeJG+1Ptmahj1ZihfELSynSFyTBUWOckZDJG0b82tsH9LoGpzkbNQ9ibOIkVcOF3UwRPGxvEGwcL9zVJ9/l9YAMj3uvz5+bgij9w4CJVcuQAMDg2m/k5MNUuNvND2LPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyOfZVuxay03palXP5Jgr0amBhC7CcXtTukC4vCUcks=;
 b=vJzS/Bx0z4VqLMwQEDNYtWGFECxuj8zsR45zQvSp4LUnBUmChmdol/Aoe1BdWpwZ4zyU8BoJURwLBUO8W7N6br1GBnO+/WuI02/eiQm0jeh11zhHE+axVneRUGVXH/nTU+qKEwZlHzBSenaDEl+07kOFGrwfUBDjddKYKqHGYVvUy4pCpv/plNw7Lb8gcdeSoDDweMG+Zg2wtDSZMQumQKoCgbuwc57IkZJAjAFc+62fdgoiL8BA3VrV8fsPYWINSNeh7cihyqegT5FNQMsu6dXZvuFgoFAJMP52VLbQQ23GXL3eAK1FP7TEuQ+b1OR7L6cKEiW+8xuDQ2i72NhauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyOfZVuxay03palXP5Jgr0amBhC7CcXtTukC4vCUcks=;
 b=QZ7+VJJkT/aFBVlPJLX4KDnyKDPzzR20x4Fk/XF33ItwwraBtMqHWQssItlNgqlVedbwfHzNOigbNG+sVWqnSA/pyDwoYdZfNlXcMwmeouDRVL4sv8Wjcsm6D5bKGqBcnFf5jYMGSLwGL6PCh46deQu4yFv8sW7EQG9n4cn1bKyOl7WlQprivsMEX4EyX55LkD8eL4+4QJyUBg46J6p6TsFpYV5Bu35TOSzma8eA8XA/1Zlg3r6rBYcVFLh8Fp7bTOfHim6ABwT29a0rIAuEAq3kwA3zPcsrOSfEyUzSQw7ziMqZkARntmoPO9Y9eTW/c+v05UBOyxgsC0KzcF4w9g==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR6P281MB5155.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:18c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:48:53 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 08:48:53 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Sean Nyekjaer <sean@geanix.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 7/8] iio: imu: inv_icm45600: add I3C driver for
 inv_icm45600 driver
Thread-Topic: [PATCH v2 7/8] iio: imu: inv_icm45600: add I3C driver for
 inv_icm45600 driver
Thread-Index: AQHb8XjHCc33poS7gUGoS/aDMnO4jLQxml+AgAFKBsA=
Date: Tue, 15 Jul 2025 08:48:53 +0000
Message-ID:
 <FR2PPF4571F02BC9DF92D920EFD08135E018C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-7-bf76d8142ef2@tdk.com>
 <diu7j6qvtggayvtgrrjdavxmhvjg4jeujz7mdkf2ggzgp4grvm@qdk6vxbkhvml>
In-Reply-To: <diu7j6qvtggayvtgrrjdavxmhvjg4jeujz7mdkf2ggzgp4grvm@qdk6vxbkhvml>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR6P281MB5155:EE_
x-ms-office365-filtering-correlation-id: 29617ddc-4dbe-4a2a-9e60-08ddc37c6d58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|7053199007|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yko3ZUFCOXE5QkZaU28yOXpiTHJia3RvQTdUeEhWbWMwVEcwK3J6SkpKZzR2?=
 =?utf-8?B?VVhrYTR6cU1HOWVvOHYwanhTNFc5d0JQZDMybFcySnVVNnhZdG5ZRmdjVVJ6?=
 =?utf-8?B?WDNvbXhYSWIvRzdqcmFYNnZ6ZVNCQThUNVZoQk1sU1BvMjR4Uit5S1ZsQUJW?=
 =?utf-8?B?WE5CbHZDUHJiWkVucFZUUUl4eGEwb2VlM3RJcXZEYXA4R2s1VnAvWmtzc0sy?=
 =?utf-8?B?NkpXaVJ3dWh3VlRDVHgrQm9DUCtVT3J4YW1XQ2lIK3dRbnV5enN2RkZXRWdF?=
 =?utf-8?B?SUprUEV5MEw4ZUxSSkR1YS9Rc0lDeU9RSXJzQXJuNndkZXlKK3VkRlE1QkhN?=
 =?utf-8?B?Y1M5Si84YmhhR1pIWUxaNjJsb2xwRFA1ZkQ4Z21rOURBdDlnNHc2RTIwcEoy?=
 =?utf-8?B?TUJpRVZHVVN6THdHY3dTT0dTWDJubStNODArU0ZqNk5laFF3S0VsRFJpNzV1?=
 =?utf-8?B?K1RhTWtNOFZScTcyME5nenpwa0UwUnVWOGFyYloyOWNiYUFFVWpoaFEyTlVP?=
 =?utf-8?B?YUpkdHIzcDkvVk5qUkptWHlkdHhadTJKdFo3bjg1Z01XRVNUU2llaGdOT09H?=
 =?utf-8?B?MDdxTXd6NzZnNFdlZEE1eWF0OXBWTmt2SS8wY0ZpQXR1UXcxeDlqQUFTNGlm?=
 =?utf-8?B?K1NSQU1Kc2Y2NFQxY3J6L054VkRTUFUrVHN3VXNWcnIvNXgreUdQK2ZRaTFN?=
 =?utf-8?B?V3pmbDRIRlhSS0ttbXMwNFIwTzZzT1Rlei8zcGdoYUovWTRuN2V0T3lsVmxE?=
 =?utf-8?B?TE81RURlNTJ1M2tmY0JVMzB5Ny9LeEVkUkplc29YZ21tQW1JY1NsbDBhVFBr?=
 =?utf-8?B?S0dMbW8wNHNjbVkrdXZnbUJkNmxvSE16c3RZWUZlUWM4QTZJb3lJVUhCYUxS?=
 =?utf-8?B?eXVrL1k1UURwT0hucEc0MjVqZVFjZ1ovRGk1TUJycmxLSjZ1TTcyN2hqdGU1?=
 =?utf-8?B?VEZ3K0paTTV0S29SYjVKN09aNkhYNDVXeksvZHRlK3R6TTVqRHk0U05CRG9G?=
 =?utf-8?B?ZEZ0Q1RzOG9SRjhEVEZkUTRZTS9iVW5sQUJvWkYxMVhZV1lrZ2VDVlM4OVJ5?=
 =?utf-8?B?U28wYllFNndCR29wR3VtKytFZXRKeFNCdjBDVU5GYmErRmVUelRVVGZWbjgx?=
 =?utf-8?B?WmoyOHRzNXpwZVBXTHU3d2piOUMxL3JNTVJVRGttN3dSSkNadldTWWZTQkhw?=
 =?utf-8?B?MTNQRG5ueEdLR3RpWE1BRVJVQkxmdlVHbURDZVlXdjJNWmNxQ1pOMEVJMVlM?=
 =?utf-8?B?NWIvYnhWczhrL3pVWTdkNkNzaVdzZFVJdXJmNVFDM2lmT0hxRGpNelhuQjB6?=
 =?utf-8?B?clY0NXNsdzVWWTh3MDh1VDhvaVVReVNRZW5lY3ZEMyt6blFrRDdtRzB1ZGFl?=
 =?utf-8?B?UUIzYktpM2ZybFBCZnBqZWlnS3JpQmkvQnV6M2hLeUZMbUxoSkpRbjNKVnl3?=
 =?utf-8?B?cUdTRzNoL3d2NUl4RTBlYkRJaXRZNkNQNFdVVU9xVkErdEVEOHJpZlJnczMr?=
 =?utf-8?B?N0trTWdoQ3FtTm9xWnZCeCt0SjA3NS9naFJMTk9VYytUSUNlTWN5Y1BiZ08w?=
 =?utf-8?B?V08zQ04xVUpOcWJ6VXVsdzdxOEd4ak5yZzFxN3pxei8wZ09PMmpHQWhFbGpP?=
 =?utf-8?B?bDNSUXdNVVVZb1dId0VaWndDMzVCcHcrdFhwd2lyMUNxOVhDdUFWdm5zNzE1?=
 =?utf-8?B?NjhYMjJSM3JleXVDTXVGSnM3UXBWRHhnVUYrNFBoUW1YR01lWG8zMkFMK1RM?=
 =?utf-8?B?djMvTWJ2bHMyZzdMc0QvUjhvdnp3bDhidlduWVpPbFc2Z1A4Q1FTQ0RHMnAv?=
 =?utf-8?B?eElCWFZ3bW0xOXFSU3JzVHJ2OUl5OTViRXlEM3NkVWJ3SXFYdkxzRTk5S290?=
 =?utf-8?B?QTEyK3U4UVZQMFpkN2gxZ0JCN2dZWkw0Z1J3cE1VVGczZzZrcjFPRFZzdjg0?=
 =?utf-8?B?dWJMYXFhUnpDRFNabVU3dWVGVjg5dTgzYkZrc01hck96YTgzd296VlpuSWlE?=
 =?utf-8?B?Vy9kZ2NvV3FvSlUyQnB3aTQ1S1F6em9uaWZMS0pFM0s3Z3pxWGtmbEtvMm13?=
 =?utf-8?Q?XaF/z2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(7053199007)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZExtZlRWVGN4d1I2c1E0QnVyYis1a0lNL2ZzQndIK1VybWNCM2xTajJsOTRP?=
 =?utf-8?B?VStHTVlpL1AxTTc4TjZhNW91WDAyRkh1ajZyS1pLM3VNQlZJblV1TUlGbEtx?=
 =?utf-8?B?b2RWU25iMitjVW4xL2hzcTVWQisxNWdwNjQ3QUU3NHRPbXZpTmExbWtSRzhj?=
 =?utf-8?B?ZDNYS1BGL0FEM1Q4b3c2Z0daQkdwSXVwSE9PYmtMS3dISVB0UVJiOURZd1NN?=
 =?utf-8?B?cStUaGRUVTlRL3R2SVkwY3RPQkgvd3FZYTd4RUhQSEhoc2dJWjNpMUF1SXZ1?=
 =?utf-8?B?TkEybmFXWkNIMzErT0QxTmdiTVhIeWFmeDhhVXhyNmFhbklzOHRCektqd1R6?=
 =?utf-8?B?NUNhS0ZzdUdmQ1JxRU5qOVpLTCtEd2kyeEgybVYrNzBjV1ZSeEdBb3VMQk16?=
 =?utf-8?B?ejVjZFN0eGpNSzF3azBxWkprbllNaWtyZitGZEp4MjFTa2tSYUpvTXoybkhF?=
 =?utf-8?B?anFERysxcDh4L2FZUUF6U0UybmZZK1NmdkR0cW1rNy9YV3lsamplWjFvZkRq?=
 =?utf-8?B?d1AyLzBkb3oxaGJ0MlBGc2NJb2tsZmF4MmErMTdWRUd3eHlxTUc3OVZqd3lm?=
 =?utf-8?B?bEJwM29wY1lqL01XeU9Fa3dYSmxaQ1hsZEZ4dWRMcVJaSnNIUzE3OEozWllm?=
 =?utf-8?B?WjkrenJYdDk1ZkZLcVV2UTFBWUlDU2czUW1HM3M1ZTlLbDBzTUhiYzg3OU9O?=
 =?utf-8?B?RHJCcmo1NGgyRGVEcGtqb3gvU3BrSElrcEJLamRla2srZndKUjV4RlViSEZR?=
 =?utf-8?B?TVJzakd1eTdhcllaYUx2d3ZlL3YwRTRHNWVnZ0N1NWZiQ0lYUEVhNXRwSU05?=
 =?utf-8?B?MTd3SkowY096dm1TN2lyT1JRbndNYmorM3FYc0ZNZk9XSHREVURiREgrWits?=
 =?utf-8?B?eG1HTHBpYVJPWEx3WFBFd1Rjd0JCb3d4dW5uMWR5bWVNOU1mQUg2bWJQUlhJ?=
 =?utf-8?B?NEFvVmQyUjlxN1hJby9YZ2FFMkhsZG13UW9peG5uempvTUFxL1RBMjdONWtt?=
 =?utf-8?B?Qk5kQ1U5N0w1ZlQyKzU5ZU5BbmRXVFAzdjRtbHpkSDZqUDRkbGVqS3pRaUFk?=
 =?utf-8?B?Q0pEVVYwVEtKclJlWVloVndkYkx1SzEwcTdGMkltM3RDSElISFdoRVJ0QnRS?=
 =?utf-8?B?VU91K3dWNTIxM3RhRStZNi81ZkdTK0p2Q3RJUnNMdXNIbXdRQUZ0d09EM2hh?=
 =?utf-8?B?TThJbzM0ODQyMkMwQ2xxcVMrY3dZQVFOcGNRS01PVUQrZXVQZ0ZPVUZFbXFX?=
 =?utf-8?B?NTdaaUQrL2xUMFhIRG5URTREZzE4cG5KclA3Mld6aWFlZER5MEl4S05LckZM?=
 =?utf-8?B?L1hXUG4zUThOOEV2eEdkc21RZ1YrbUNhTytha1BGempmVkVZUkxtUlJpa1VW?=
 =?utf-8?B?SklUc1h0eWpKMCtHK1VsYXMxcldCdlZDSjB5YmdPejlhZTk1NUhJeUJma2dC?=
 =?utf-8?B?M1JsMTJ0N0ZSS1k2OHdoZVd0N2lQNGhpZHJzazB3K3VVTHpJWGdOc292bDQx?=
 =?utf-8?B?WmVQM2VhckZZTEM4TDNmMnExN1p6SzQ2NlBQOXZvWkFDNjNwVTVvUU8vYnNp?=
 =?utf-8?B?bGxhL2RjOEQ5MmRyUU9aKzE1MGo0YnB1bkNCY3g4cE54RkNuRHlla3hBeXp0?=
 =?utf-8?B?SHF6TEFSOXdadjR6M29qYWRpeE54YjN4Y2hmRUhoR1ArWmZMK0g2c045VUNt?=
 =?utf-8?B?S0ljaGdjOVhWYUZOb3A2cm9UaXNpa05DUTBEc09BOFNoMFlEU1A1YnZ3SXYz?=
 =?utf-8?B?WCtVc0pocTQ2Q1BnR2k3Q0hPdldKYmphdWtyZjJPM0RwclNJYi9KU1dVV3gv?=
 =?utf-8?B?N3pXdVVnakJ4TVhQdzhONEJlcmYxVkVpN2pqbnNNb3JoTVRHTHlFaWVFSXgv?=
 =?utf-8?B?d2ZyVDdXd0EzK3VxSmxtRXJBbWhPczg1K0x2ZFUyTHN5L1R6YjhQRGU2aHJD?=
 =?utf-8?B?VGxNV1FORS8zdThsSE9zZWxBc3RyTVVhWU5WcGtvNDZWOFFiSzNPR1Njc0VY?=
 =?utf-8?B?cWduTVhWU045YkV2ejF5MittTTdleVc4VjhaWG1tSXo3aTRBOVZrL1pUZlVp?=
 =?utf-8?B?UGpkN3FveDZlL3NrTTREK0IxaHFndStsazh0NlRRaHpuM2cvMldlSnpibkhR?=
 =?utf-8?Q?PRucImY+qz/I43/TIupMW53rh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29617ddc-4dbe-4a2a-9e60-08ddc37c6d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 08:48:53.4214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0xb8e34KYrmjrNDMPV0zJQeKVohrBEQqGr8pzk9H/G1VGOOBqgPRIa/tXJBr7AdEpNzSv3JkTHV0zsvs0OKDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB5155
X-Proofpoint-GUID: 6qL8_l6o0wm2HyTCaBmVIDGAR3TnrKvm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA3OSBTYWx0ZWRfX6jyjs9DuRiO0
 1CqFKKiyooUCWYa/fo7PHAqto9+onnrUjbbmzJ76zRpIzMg3qb6ECr7/pBuq01BuzsyfqrHRfCl
 lRvk6+ZLvB+KN8NGxEyySBVEIRcJSXSbEgy6714/JTTiV2E+Zcs5EwDu/ta37bQvOR2PN9IxE1M
 RECF4Lcto1whLIX3hLLBMbahESEDZxYnwC4ADlmZg084oyOiRq6rAj86FjvyHTP2oCL/GvTEDEk
 ykumGZFgPStyCTmBWuL4R1TWLXSeFeCC9hr5Aem5mIUKL3et8/B68G7DnX/E74LwurDFjzoypzv
 22FC/3oEWt4nP8SZ2l3WS427jooaS5ypnhvFUFQaUccHTRDfMWJWzFrg2KS616IRbfcK+8crABC
 VGUFYP/i7WvL1hf6QQ+awNQXd0qRu5B8FEigOkate3jvxNNLOYbxi8CdG/NdcBbbp6QyHFdz
X-Authority-Analysis: v=2.4 cv=QLxoRhLL c=1 sm=1 tr=0 ts=687615fc cx=c_pps
 a=UTrajfYj8opMYZWTIMhHaA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=ilKATfAMAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=6NiqGpoD8KIhYUGgq9oA:9 a=QEXdDO2ut3YA:10
 a=73awMTU50e6eLoBjGbzZ:22 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: 6qL8_l6o0wm2HyTCaBmVIDGAR3TnrKvm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxlogscore=831 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150079

Pg0KPg0KPkZyb206IFNlYW4gTnlla2phZXIgbWFpbHRvOnNlYW5AZ2Vhbml4LmNvbSANCj5TZW50
OiBNb25kYXksIEp1bHkgMTQsIDIwMjUgMjo1NiBQTQ0KPlRvOiBSZW1pIEJ1aXNzb24gbWFpbHRv
OlJlbWkuQnVpc3NvbkB0ZGsuY29tDQo+Q2M6IEpvbmF0aGFuIENhbWVyb24gbWFpbHRvOmppYzIz
QGtlcm5lbC5vcmc7IERhdmlkIExlY2huZXIgbWFpbHRvOmRsZWNobmVyQGJheWxpYnJlLmNvbTsg
TnVubyBTw6EgbWFpbHRvOm51bm8uc2FAYW5hbG9nLmNvbTsgQW5keSBTaGV2Y2hlbmtvIG1haWx0
bzphbmR5QGtlcm5lbC5vcmc7IFJvYiBIZXJyaW5nIG1haWx0bzpyb2JoQGtlcm5lbC5vcmc7IEty
enlzenRvZiBLb3psb3dza2kgbWFpbHRvOmtyemsrZHRAa2VybmVsLm9yZzsgQ29ub3IgRG9vbGV5
IG1haWx0bzpjb25vcitkdEBrZXJuZWwub3JnOyBtYWlsdG86bGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbWFpbHRvOmxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IG1haWx0bzpkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNy84XSBpaW86IGlt
dTogaW52X2ljbTQ1NjAwOiBhZGQgSTNDIGRyaXZlciBmb3IgaW52X2ljbTQ1NjAwIGRyaXZlcg0K
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJlbWkgQnVpc3NvbiA8cmVtaS7igIpidWlzc29uQOKAinRk
ay7igIpjb20+DQo+T24gVGh1LCBKdWwgMTAsIDIwMjUgYXQgMDg6NTg6MDJBTSArMDEwMCwgUmVt
aSBCdWlzc29uIHZpYSBCNCBSZWxheSB3cm90ZToNCj4+IEZyb206IFJlbWkgQnVpc3NvbiBtYWls
dG86cmVtaS5idWlzc29uQHRkay5jb20NCj4+IA0KPj4gQWRkIEkzQyBkcml2ZXIgZm9yIEludmVu
U2Vuc2UgSUNNLTQ1NjAwIGRldmljZXMuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFJlbWkgQnVp
c3NvbiBtYWlsdG86cmVtaS5idWlzc29uQHRkay5jb20NCj4NCj5JcyB0aGlzIHRlc3RlZCBvbiBy
ZWFsIGhhcmR3YXJlPw0KWWVzLCBvbiBNQ0lNWDkzLVFTQiBBMyAoYWdyZWVkIHRoYXQgb25seSBm
ZXcgcGxhdGZvcm1zIHN1cHBvcnQgdGhhdCBpbnRlcmZhY2UgYXMgb2YgdG9kYXkpDQo+DQo+L1Nl
YW4NCj4NCj4NCg==

