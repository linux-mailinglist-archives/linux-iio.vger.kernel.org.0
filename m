Return-Path: <linux-iio+bounces-8049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D580E940B32
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 10:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD8A284D5D
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497F1922F6;
	Tue, 30 Jul 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="leElblsG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BFC187844;
	Tue, 30 Jul 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327814; cv=fail; b=WWpLvAtSmMl/gu+2HEeYGEmFW1bduCN3CeVhjTwvXSfTDTtXGFIymf8Yljj8XX7DckgW/oZh5qWH7Arn3DgcS0n9rMCj6TbLbSxbFmg8WGfbq6odOeByxK+wUnGYbWZm1JgKM3vHfTFvSaktFy/YYr+hr8a4/K/ZxsyAYDjkwFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327814; c=relaxed/simple;
	bh=IB8rZ88X1EB/H4eyYzGAaaatVHbSNPuLKYLiolyJaj0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fU31XMZa2FK7Z34MBXj8ctsRGBVmqwWonQyb3xjSXex/bPD52uAtegWSe4ferhlm8oCAvcsgEvDz9FGEvZQ1hEGUjCIOdRFCBdnPBH4tQKmNkxSw3K7uR3BZ7XVAqRXEA9RDYFzPTE4rmilTp7kQlH+KHGwuDAhSSantzIHyeOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=leElblsG; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U48eOL019808;
	Tue, 30 Jul 2024 04:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IB8rZ
	88X1EB/H4eyYzGAaaatVHbSNPuLKYLiolyJaj0=; b=leElblsGPg4k6GOGtByDy
	qxAVN+1w/lj3WTgomdS9806XGum5hB+nyMBWO6ZkRpaMNKGcod7aIhJNYxX0PlFW
	oHFXBUoalef5SP90G/Co8A9Nals14ZI3FjNB1WHgzB+Dknr8H6NDXl6tAfkLkQog
	g0bDNCPk2IuKLEqMop3udkP0PaYBvI/FsYyeWvspjWR3V6NMPFCD6g2TjIvV+nbA
	RKIXIwdj5zAmGS6e1kZHH1AFrZvdUYzOVDSzA1Uq4GSPYi2zNP1Fi3oujBYokkza
	1aUjxaTIS4/Ns5mNo1IzPfeahR6gINBgVrdb+FVq16BtXGjYyoM/hVHAHcL/YmVl
	g==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010004.outbound.protection.outlook.com [40.93.11.4])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40prvq0sp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 04:23:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iel+hTKZaYZFTVS+JglxoMcmX7WeRlxJDxeeNfv7MR405+5WYSU/4rE1EcxihGzedMaWQ7+06E4b2OhS+HPm7dMECt/E3tJ3Sq8mpVXRU8ZTlUWJdsDotcoIaFBXiTrbzmTcBBcUdbTc31MMPMLFaYf6EFanIUjtDYTP25Mh6tkj9+g3jiYZKD+nH0sn0x7z+83tsnTMnlSU5lyXaAPdfFUE5G+8H8s7rqm5yoKts4s+Sv9B+XJATQNvHzoa3LP4qs0uB/qTyFOPh3OPJkGc2anGmkHFNAJTJT2ItADWjgS1VBSrZN5jQldEixUntCYUuh/Gnzm+xTa75gGC319A6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IB8rZ88X1EB/H4eyYzGAaaatVHbSNPuLKYLiolyJaj0=;
 b=XUkyKIzsZ9IeWb687+Xt4eeC2vjf445AnCWzVCSZL1X7RoRjRS31ZrJKmnQ64NJIsOla5+29O8jP1WwQBMSWxXMSTZdqZMpyUvUkQcMaplOF2OWsigSYEPED8OhKyKkVMhoS6tfQp+r0G3gvXuSx2GKv3yPjOKVdqMz/CTZW3PdIrhioJUQkOXobvdwQ/sHuo3IGkDaTF2bIll2u0SUkiAuNd2kvK+rAvvq3HInuqX9dFB5iUzGuCAzP4G0Y56U821kxolMOMQIVmnlD5E/yO21h+Ei8s9aif8kgzddlivXLTYdOduwxK3jgwTmc0AHYVNc6dWUAa/3ydeo70bhJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BL1PR03MB6007.namprd03.prod.outlook.com (2603:10b6:208:31a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 08:23:14 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%6]) with mapi id 15.20.7784.017; Tue, 30 Jul 2024
 08:23:14 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bogdan,
 Dragos" <Dragos.Bogdan@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] *** Add ADF4378 Support ***
Thread-Topic: [PATCH v3 0/2] *** Add ADF4378 Support ***
Thread-Index: AQHa4ZzWPc7j/x2ZSkmIDLJEPfDsybINzFGAgAEi4MA=
Date: Tue, 30 Jul 2024 08:23:14 +0000
Message-ID:
 <CY4PR03MB339984EFB38E801AEEE1368D9BB02@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240729095047.25040-1-antoniu.miclaus@analog.com>
 <c93a6bf3-7360-4696-833d-82726d10f604@kernel.org>
In-Reply-To: <c93a6bf3-7360-4696-833d-82726d10f604@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFtTkdVME4yUTJOQzAwWlRSakxURXhaV1l0WVdZM01pMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWmpSbE5EZGtOall0TkdVMFl5MHhN?=
 =?utf-8?B?V1ZtTFdGbU56SXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhOVFF4SWlCMFBTSXhNek0yTmpnd01UTTVNVFV5TkRnMU5UY2lJR2c5SWxN?=
 =?utf-8?B?MU4yNXNXV2xaTlUxUWMxQnVSV3hTV2pOWmVFVlZZa2RQTUQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTNSR01FTXpWMlZNWVVGbVYwcDJWRGhzYWxKemJq?=
 =?utf-8?B?bFpiVGxRZVZkT1IzbGpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQldWQlVTVEpSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BL1PR03MB6007:EE_
x-ms-office365-filtering-correlation-id: c3eaa327-e53c-48e8-73b0-08dcb070db7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZndPd1BKREpxMnFrVzRxMjRvRFkzVWFmYkJXTm5tRVNMUEFpaFV0RFZ6SWVo?=
 =?utf-8?B?NDRUVEZ4WSthR1pHSU9sdmtaT0dwRW8zcW5kNmlnVjdCWFk2aWdFSFRpVzIz?=
 =?utf-8?B?YjNBRkFSaUNIaXlNYU1hL1JzVDRDTnhSSy9ZZUtjRFAzdWJkTTBhY3lHQXh3?=
 =?utf-8?B?RGFDRmZSWGl0bUM3WHR0MTFMV21oQy9yWEx2RTUzOWJtSkpqdERCaTdqTzk4?=
 =?utf-8?B?UjdqRVk0U3FwaERlVFhFMEVIYTJtVjBqcVJUZDhPSmFEdkVZNy9Oc2xqbWFD?=
 =?utf-8?B?SW1EZW91WTN2UnJzWHZUUWxWQWxYbFV4WUl0ZzRhMkhaODNTTzNDc2dRaWlJ?=
 =?utf-8?B?QUlNNnZIU0V2azNrRzBuSlQzMmNwK1lVVFl6RkpNVWN0emxncFpzTUxVQW93?=
 =?utf-8?B?M2I1ZTlJbEJNRkwzUDhmaU12U1BLaGRyQWdNa05ZUWUxRXlUVzJDbTRSK1hO?=
 =?utf-8?B?RWh3QW82QTNzRHJtWVBaRXA2N3Y4UkMxRm9ndEpvdXhWZ1hwd1Fpd0lIZVlx?=
 =?utf-8?B?OWVBdjFJR2NPbCs5NUxTVXZxSXpUeitkUVNpTXNzbzhzMWhZUFpkU1lRWU02?=
 =?utf-8?B?QnMzelpaRHF6VzQrZUZMb3BIWHZNb1dpR3lrU1MzQ1d5WWl2L3lVYVZrUW9w?=
 =?utf-8?B?TW56TE1YS3ZSN1lpS2FWSjI2MTlvM240aFVjbmQ4TVAyT1ZxRlBGMXpsSVph?=
 =?utf-8?B?RkVldmhxZ1U5VENZbTVOREd6SHZPL2tmUllsT3JDSFg1RVJVZjBkTHRwYkFZ?=
 =?utf-8?B?UXlyZlN4cDVtSy9EdklmcUFnSEN1NStiakxSaWhvSWxHVm56c0RNTUgvZTRF?=
 =?utf-8?B?bk1zbVFWcnQ4R1J1b1JFTEI1S2xxKy9OaHpqYXcrMHk4dkpFbENiR3diQkZR?=
 =?utf-8?B?L29kRlQxNFFwSDIxMDRXWWlwK1BXZS9FdW5YdlM4RzFlM0hWUXRDZUVIM2Ur?=
 =?utf-8?B?cWtaSFkyMXlidmRtMmJBN1VURnNSV1kra0k0ZE9va3E3WTBxWm5aRC9iSXBK?=
 =?utf-8?B?WUljbVdqckRucHpJSDVBRE96ZUNxc2FTUVFqbzhaZDMrQWV5NFdDSTRUM0pC?=
 =?utf-8?B?NFdPN3pqMzdaWGtDbzBqdzVUWDJRTjMwam9iWjRYY3dWT054aFUwYm1SckNN?=
 =?utf-8?B?VW5HNDlpdjYzS0U4NlByMkx0VzZzTThUUVRzSGd5YTRhMVh5SGc2RFZCdXhG?=
 =?utf-8?B?cHF3bmNKUEp4UTUva0owbkZzTU1zVnhQWEdhd0VwM2xaSnowTTk5OS8vZVVu?=
 =?utf-8?B?V3NxZXNkNi9icEZYMThLQzBNTEV1RFN0dTNwcnpmYXcrN1EvYytNWUdQaHh5?=
 =?utf-8?B?UU9wejgyT3ZmQ2VsREwrZmJ4WjdUbUI2SWRWbGpOeS9YRUhzMUdwUlc3emMy?=
 =?utf-8?B?TExIcU8rR0tnOGZpM2tSK3dDRGg1SFVpOWJHRDVTZHZ0TVE1M1pYaThxRlgr?=
 =?utf-8?B?UkJEU1NsNXdjWENOWDFUODh1dlFZMmdxamNDaEZhamcwbzJCVjEydjRDRThj?=
 =?utf-8?B?Q0xGOUtMY1RnL1VKQUhpaWlhbDVXYm5iWmI0ZE0reFZMRmh2K1R1cWxzWENP?=
 =?utf-8?B?bmpTMnNzU2hBY3JnQStwQmVlall2Z0trZitSK3lyZVk1Q1IvbVpzRnhjakxQ?=
 =?utf-8?B?QklxZGQraVFUZGJYWUVXR25wdjgyaEtBM2NYS2FmYTZPOVRMQzJsS2o3K0hQ?=
 =?utf-8?B?ZW1hT2UyYTdxamFtS1BDVWk5OG1Yak5wK3VuV0UvS2Z3bXB3RGRWdWxpaDY1?=
 =?utf-8?B?NEJYNSs4NWhKQ3ljT2JMUlZURTl6YWtKTkUrQVVRblNVMytvK2RPOEs0Mkh2?=
 =?utf-8?B?Vk9mWDhYQ1QyaWJKczVTeUpseTdCa2ZwZnl3b3hFbThQYis5L2txZFFyU0lu?=
 =?utf-8?B?c3ptdG5nbndwL2VGekdvdEp0UStMTFM5L0pHclVjNlhXMDMrOWtwY1hIUXUv?=
 =?utf-8?Q?kIFqgIcZxcw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anF2dzVPU00vS2VaclNKZndhRHJucDFZMnEzSjE0ZFlrelBBY3Qvd00rUnQ3?=
 =?utf-8?B?ajdJdldUTTAzZzlXQndEYkltd2JVUzNSb2xwQWtLQXJ4V3JlaW4zZXdhTE5h?=
 =?utf-8?B?QzMyeVpnNDZGMVVXbVdnTVdsMWVZbytFWjRkR1FJSUN2bUNEY0MzYVFiOTMw?=
 =?utf-8?B?dWtjQ2VNTHROOXJJaWpZcEhpVWlkNitGU2RSalRIaS9IL2JTRVpJWmJ6ZVFx?=
 =?utf-8?B?dnpCYyt2aVdDVDJjUmpCS1BwUVBFQWh6aVNNQ3ZMeGY0V25DVTZBRkZtN0h5?=
 =?utf-8?B?K3pmWUY0Vlo1MVRmMnFHSVY4cXBXbHBNQ2lpZ1BpMnd6T0oyY3o1SWs5YkNB?=
 =?utf-8?B?REJtNVJuYjh2YkRPdDJVRi9GdUJuajBBMUo4VGdQWVhsT05yeXYvK0Jmdmsx?=
 =?utf-8?B?V2x3a0o3eFF3MDZ5Tnk5SGlUSWdNWjF1cmZ1NDRVZm91bldrbUQ5ejBaTThu?=
 =?utf-8?B?WnZyNEFBYU5BZGVlVlJUcngvR2psMkhENGxYOGhlQ3pVaHp6WkZPSCtta1FG?=
 =?utf-8?B?QVJndmNaQ0tNMXRVSVYxaDVZeFlCVzRxemwyZ0RXUm95enhvcm1oNlc3bE1M?=
 =?utf-8?B?d21tempOT0tDQTkzV2g5b1E1alZkWjIzUk10NW9Hb2dPL0YyMEFtZDkvQVAv?=
 =?utf-8?B?M1B3ZG5aaFNTWjNvZWFyTnJTWmRjamZqMEJYaXZtd29uTzZpNWhGenBxMDFX?=
 =?utf-8?B?TGhuYWpPaUNSNGJRL1hLVGRTQ3N5cTlvQjVhQVFzWW1FZFB5ZkhiaTdWVmMw?=
 =?utf-8?B?VzNzZUxYYWJLWVN6citMOWNaZlEwcElSWktyK2dvRFBYcXgzMmMva2lROWk0?=
 =?utf-8?B?bGpsVHczeFB5WThib0pPekQ2WVZra3JqTXJkb3NJZzg2TXB2aU1kNkIzRnF4?=
 =?utf-8?B?WERJRWkvTG50b0tQM0hFTjVuc3hSUlZSSjJlNUNFeW1MREhqZWtSUkw3cjVU?=
 =?utf-8?B?YTBsNnIyTVJBakFxc1JCdGw3LzE0N0JXWXRrMm1FWXpSUlY0Y2JJbUJrUnI2?=
 =?utf-8?B?dDhnL0RsME9SSm9mQWJXQ242NG1BNGl5N3Bwc2ljTUpLMCtDOWgxWE5xM05a?=
 =?utf-8?B?THFFU2p1N1hud1AremxYWjIzRUs1OEhMYm85QTUyUytNeUFmMlE1eFVSWDB6?=
 =?utf-8?B?Y1V2QTlueGFvY1JHWGwyeU9sQlhsNEFrQUJsSHJ6RXgwWklSNlBhOENVaDVa?=
 =?utf-8?B?V25ZbTBhdnd6V2ZDRmVPZncrVUdPY2dESmI3T0FRN2NmTG5iSkRtZXVOMzcx?=
 =?utf-8?B?b1ZnVE5xNW8xOWs1NUtkK2RKdi90OXFBQlp3TmRQaWFVTDNwVU1Zb29tUTJm?=
 =?utf-8?B?MHJOcG1kdjE0dkJ2TTZNOVBhUU5LOGZVayswdFBMZ3JhcFBOd2JsUzNhSFlX?=
 =?utf-8?B?QU43V0F2UUtjd3VBblJrV2ZvdHlYR1lsR2F5KzBxdHQvbDhGNmYyaUc5U0xV?=
 =?utf-8?B?ME04THFaRzJMZjlVZ1Y4QkRtVG5EUVcrOStvMVhhL3hCQnRXYVRRU3d2Y0k2?=
 =?utf-8?B?Rm9aNHZyc1AwamZGeWF4QkV6UlJ1VGtqRk9BN0xVZ3p0ckZQSEU3VWVXV3E3?=
 =?utf-8?B?WTZBZk5Cc0t5RjQ5TUQ1RGx1NzJzVUw5UVNCVHpIVitrQ2VwUUw3djA3bHpF?=
 =?utf-8?B?YXhJUmg0ZjAvL3UwMjg0WVBmUWVxRjgwK2c3dTA3SHNRdmVleS82bjBKM3Bx?=
 =?utf-8?B?ZXZwVUhrd1ptOXYwbTVueTZBL0pCNnFDNHJyekRTZG45OGtxQjlHYXZVM1c4?=
 =?utf-8?B?aWw5Yy9BL3RReXgvNFQxK1NCSU9iSEhJUEtuTW43LzBKcDRJMzNIRkQ5NWZw?=
 =?utf-8?B?M3hCV0k4YkJHZXdjVVdNZEpLb3h6QnBCWVFtbmlIbGtpaTNXV2RUZUJSUWh3?=
 =?utf-8?B?czVJMTFwV0dZTkZXYUpodm1pdnNNTys1MWZxV1JqM0NhWW1WdmdlMWNnWG14?=
 =?utf-8?B?czlzTlcxWVlDVkIxeGhYTi9QeFlIRHpyb2MxQTFQOWwya0xaMVJNbW5tVUxu?=
 =?utf-8?B?N2psdDFrRldNTm4xOHdXVnk5WnNoWlFEL3hHd015QngvRzhENXo0WEpkVDBv?=
 =?utf-8?B?cTdkYmU0aFJFWlRiVitNVzU0Q29KTDJJMDFWWW51ZFViSUJ6TjlWaW1tQmVW?=
 =?utf-8?Q?U+znsJxeceb/IVRJ4DwZ6YS56?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eaa327-e53c-48e8-73b0-08dcb070db7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 08:23:14.4311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzu2yMsmheixFhWR9dckatn3qJKVRVThvtXJyNgDvE/3ZmMLlM87dXvhppwgJyQmReFk+9qatRM5DJviCw379CTMcwVEFmS41dUI9q2bzvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6007
X-Proofpoint-ORIG-GUID: vaTZvGbuJMISLTwba5OoYULZaJHZ92e0
X-Proofpoint-GUID: vaTZvGbuJMISLTwba5OoYULZaJHZ92e0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300061

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAyOSwgMjAyNCA1OjU4IFBN
DQo+IFRvOiBNaWNsYXVzLCBBbnRvbml1IDxBbnRvbml1Lk1pY2xhdXNAYW5hbG9nLmNvbT47IExh
cnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNoLCBNaWNoYWVs
IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8amlj
MjNAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9y
K2R0QGtlcm5lbC5vcmc+OyBCb2dkYW4sIERyYWdvcyA8RHJhZ29zLkJvZ2RhbkBhbmFsb2cuY29t
PjsNCj4gbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgMC8yXSAqKiogQWRkIEFERjQzNzggU3VwcG9ydCAqKioNCj4gDQo+IFtFeHRlcm5hbF0N
Cj4gDQo+IE9uIDI5LzA3LzIwMjQgMTE6NTAsIEFudG9uaXUgTWljbGF1cyB3cm90ZToNCj4gPiBB
ZGQgc3VwcG9ydCBmb3IgQURGNDM3OCBoaWdoIHBlcmZvcm1hbmNlLCB1bHRyYS1sb3cgaml0dGVy
LCBpbnRlZ2VyLU4NCj4gPiBwaGFzZWQgbG9ja2VkIGxvb3AgKFBMTCkgd2l0aCBhbiBpbnRlZ3Jh
dGVkIHZvbHRhZ2UgY29udHJvbGxlZA0KPiA+IG9zY2lsbGF0b3IgKFZDTykgYW5kIHN5c3RlbSBy
ZWZlcmVuY2UgKFNZU1JFRikgcmV0aW1lciBpZGVhbGx5DQo+ID4gc3VpdGVkIGZvciBkYXRhIGNv
bnZlcnRlciBhbmQgbWl4ZWQgc2lnbmFsIGZyb250IGVuZCAoTXhGRSkgY2xvY2sNCj4gPiBhcHBs
aWNhdGlvbnMuDQo+ID4NCj4gPiBUaGUgbWFpbiBkaWZmZXJlbmNlIGJldHdlZW4gQURGNDM3NyBh
bmQgQURGNDM3OCBpcyB0aGF0IHRoZSBzZWNvbmQgb25lDQo+ID4gcHJvdmlkZXMgb25seSBvbmUg
b3V0cHV0IGZyZXF1ZW5jeSBjaGFubmVsIHdoaWNoIGlzIGVuYWJsZS9kaXNhYmxlZCB2aWENCj4g
PiBvbmUgR1BJTy4NCj4gPg0KPiA+IEJvdGggdGhlIGRyaXZlciBhbmQgdGhlIGJpbmRpbmdzIGFy
ZSB1cGRhdGVkIHRvIHJlZmxlY3QgdGhhdCBkaWZmZXJlbmNlLg0KPiANCj4gVGhhdCdzIGEgdjMs
IGJ1dCB3aGVyZSBpcyB0aGUgY2hhbmdlbG9nPw0KDQpFYWNoIG9mIHRoZSB0d28gcGF0Y2hlcyBo
YXMgdGhlaXIgb3duIGNoYW5nZWxvZy4NCkZvciB0aGUgY292ZXIgbGV0dGVyIHRoZXJlJ3Mgbm8g
Y2hhbmdlbG9nIHNpbmNlIGl0IHdhcyBhZGRlZCB3aXRoIHYzLiANCg0KUmVnYXJkcywNCkFudG9u
aXUNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

