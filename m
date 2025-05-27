Return-Path: <linux-iio+bounces-19963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDCAC4C3D
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 12:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136393AFE49
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE0F251799;
	Tue, 27 May 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="GZONnYy3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595791A23A6
	for <linux-iio@vger.kernel.org>; Tue, 27 May 2025 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748341618; cv=fail; b=rCsXcVFN8SZSbR2QBJvLC8uDQI+WEP5xobfNRRqYEtN0DUIQrOJoXp/8OXLndI4tmIP7RoCdbAzzNmwZynUbk7p2hresD340YX0BvEnv6GqmrHhsGNB4SmDMZ58FqNIGN1ispjFNSdhzpXHgHhhbXREj/ip1InNHt3QbQImK0m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748341618; c=relaxed/simple;
	bh=VzBmDGIcr1JSDoqnw3Szo+6lo8BCKgIhN2Pi0W4xW6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Za3vHfp9+2ewgv+ERjh1q83UlqGqDM90SuIDlJJRWixze+1e1+Mdn6AldpFz/hO0a0yNqJB1WK3mvTtUV/U8a8bAo3BGAnR1t717H+ovjj76oPH70B/IkKy4s4CpWqRLlW+lfYhMRgzu+6kAwC9xHNgVn4XrExHbD+e+sjdR80A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=GZONnYy3; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QN63ow009887;
	Tue, 27 May 2025 09:53:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 46u7fnj29k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 09:53:51 +0000 (GMT)
Received: from m0233779.ppops.net (m0233779.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54R9rpgU031616;
	Tue, 27 May 2025 09:53:51 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012027.outbound.protection.outlook.com [40.107.149.27])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 46u7fnj29g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 09:53:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klD+45TJgL5t7Mj513XHBVcZPZAxFaqRMlloKog5LPQeYby8983TJRgIWNhtRssdU7L1iuj4h7liv86ZJ8xd8bOD8r1yaFyngJ6gG1JDv7f6NTy7UDaptB8GrT/Gagi3fXcAstYhXsPus0ZnuyHEtfi0p+NWJo39s8k4M3qqu7MAfehM8D9f2gYH8yzSOacoPRTEIi3E/ldnExnKhWdSuDZlAmIateHJvWV0LAe+8bS8sOrHBY1LoOuBn3xjFs8YQLoZVVG4hjCgBdcMkqI/m90xo5R9cZ2LV/fSYTvB/10dB887QN7vNibUVpspNEsOdLNV0u+3Wcwv09Q4vAnRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nLKqQEAyLi0PMoZLZhqLFTSXWE+Q7YkoqycQ1DAnFI=;
 b=Tkdgf6fMfUcc2Yi+tBBRfIMHaMG3kH2dqycn7NlMCYFc2k/JgR1IDZ5HaiA4A+tXSFWe71s0qa7T+RcDrrreXUv1ToTzLkRXoFWGpBSAvzWXAHMrDkSDk9ixWp9QNJZYOFmaKvXwNwm13EWf67cbafYJgz3DeNMRD1gc7VcTCu8Bbd0ZhkAYN7iW+xhWLwoKLhslAz5w8BAw6qwi6ETXRCYJo5da5lsy3zp5vUWtpmbfjirMhUTKhdeZweoQ2mKWQpXmRxrK49efHtwEHol80fIE1UbbXnt2FwTjwVyd2Hniyk8xJj3TqKBXCMLhakynH8q1ly3qrWB4Dy4U5n4deQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nLKqQEAyLi0PMoZLZhqLFTSXWE+Q7YkoqycQ1DAnFI=;
 b=GZONnYy3fA6k+yQ9yonL2OtiAwvL7A7lWzY5CTaZ1PCycFOjg30vdXdskdODeQedWKwS3qJdUNLHUkIhJ4SBujuEXT26P3C2s4gDzlyRgvY1ZiTr1OJPm6QhxKlL+dpSK7z4ZdAGEw8fHpNeMz99lLy2rKRXsJWB74T6crV+n+VchuNfZZ+FoIpFnta0/Bo1JIYFod8xxzh/3sP7AgBmt6fsLDEnRR3AKDqxtS7ZBw6+mhFpRkTcNeqDeG//tr+Lt3ctfea1GK3I8kG1Lo1pj0rkflzOa+o5vD5X6cFgMUhRIUhWZ62PKUzi3NDXjcIXO0cTz+N8oCEsJ9O3KN6jCA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB2884.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:74::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 09:53:41 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 09:53:41 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>
CC: Isabella Caselli <bellacaselli20@gmail.com>,
        "lars@metafoo.de"
	<lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "rodrigo.michelassi@usp.br" <rodrigo.michelassi@usp.br>
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: refactor aux read/write to use
 shared xfer logic
Thread-Topic: [PATCH v3] iio: imu: inv_mpu6050: refactor aux read/write to use
 shared xfer logic
Thread-Index: AQHbv4BXGVBBcCVkfE6FDbisMDd1nbPMNr2AgAe8Q4CAD8GIgIACpZgF
Date: Tue, 27 May 2025 09:53:41 +0000
Message-ID:
 <FR3P281MB17579EB44065673FC14F049CCE64A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250507184539.54658-1-bellacaselli20@gmail.com>
	<aB-dZecEekMsAEWj@debian-BULLSEYE-live-builder-AMD64>
	<20250515174711.78457e4b@jic23-huawei> <20250525182345.351ec4cf@jic23-huawei>
In-Reply-To: <20250525182345.351ec4cf@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB2884:EE_
x-ms-office365-filtering-correlation-id: 4d3c81ca-3d83-4c87-a4c7-08dd9d045c5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Lk5Jiq38bN3ACmujHr60fUomgA5eMQmtgGdmaPZEArMcA1wcxcjV789LxN?=
 =?iso-8859-1?Q?TF3mD/vcr5L5DQW3ZenuSxKEnvqE/KYYFiU3VX4RyL8VNiLjAhwoTzua+j?=
 =?iso-8859-1?Q?v6PCaviX70yOH+T+TWQiFd8oyIIalT28BHu/mw1FlnlYMnYLYDFAmKCeS2?=
 =?iso-8859-1?Q?K70cykUeQQ9ZqMwI1Ron1+EYQ8tzecqcUlWw8UmUFRqGs7/VqU8UZTyB/u?=
 =?iso-8859-1?Q?UhgbVbAfKO/K7ek6sMObRup9rXvLlSvofFLseEi92aZQESprFFBcNRqh24?=
 =?iso-8859-1?Q?+mCFUTE8VBzaDiogErWO1/jqjUwOoBayWa32jloW811+piRGNfcYlYyxfi?=
 =?iso-8859-1?Q?M/rawVPz6G0zAVUPsYIbl2KWovbgLPOY3EB4VraayXrlDN7Q5kYZD0pNXy?=
 =?iso-8859-1?Q?fzZg9oKA8gWAx9VvbSksWhf5kwC+0ZA+mdjppm9MdZk17yf1Jr3TiQEvTh?=
 =?iso-8859-1?Q?fqTdMbgBOgmz0s/mwjnza4daoOxhzQ5ZbSqbVJ5OBxKZ1dNTcQZ/gcBds2?=
 =?iso-8859-1?Q?5gI02Z0CloXsh1mIBP/yoHiHKoBwy5eb4QGXThxuR7Qqe6pbgkH03xZLL/?=
 =?iso-8859-1?Q?ejlzwLpBhdJBSAASX8oRgcDPI69/YVR3BA8w8wl6BW5/VttyISEgwNcXaP?=
 =?iso-8859-1?Q?WIGtmSOxU83UwAV5Ax65yXO9SaG6EmIjODFT64HfoosHjGFOcfTOAcZD2m?=
 =?iso-8859-1?Q?8RLbU3lrpXU8RGFPGAwMSu99Hs5XUNXAueitu8MXU1cCJ5du/cmKBZLhgV?=
 =?iso-8859-1?Q?N5Eyj0OV9rv3j0rJmRNGShRFq+xz/GLzSNJ4cSLtmqRXpUy+sp9igubQsQ?=
 =?iso-8859-1?Q?lnrPz5WdTF7TyZbYmtQ0+OXHWlIi6k02hz9dnx6f1OLzADG5tb2YRWzRzK?=
 =?iso-8859-1?Q?MSgAtgAa0VR7YqS17SkaMo/6Q78MMPo0ZH3No2FmuymARBUon9hbnHVXQP?=
 =?iso-8859-1?Q?ONjjCO+bMqHRRmL3eUJq/xlym35JyCcgWYXdAnWySTa4NrOZy4kHx/LYZM?=
 =?iso-8859-1?Q?hq5sMn40K6V7+DgQjxzrSHCnJIVkmOtkWl4E9Nmkr2oq25dVehRH18dLsD?=
 =?iso-8859-1?Q?DfwM6oQKscqBaMulh7AcvxQNzGw/cRJfYGmTiY80ONa6DejG4/ECtrxL/c?=
 =?iso-8859-1?Q?p+xIejcFLYpqJ/RlDO5O7Ni/Fj5UbvNuDqjxx64Ni3oqanQ/mk+VUjZDCU?=
 =?iso-8859-1?Q?k4nHN3yZz48TUFGhriDsqDTzmvUekc8/nwenmraOqokqvdk9+vLVF3FgTZ?=
 =?iso-8859-1?Q?v4GY9vgrOwTnAP54uDvtSmvNW4NxJVjYkV1gwL3esWddC+ZbyCQoRbRkLb?=
 =?iso-8859-1?Q?MlPGcJbwxrIdzjd/vleggjo06e2h7me5qqJmb/5mwwqbPe3b0LXZclFukJ?=
 =?iso-8859-1?Q?O3pIGlfVtBuI/Vb6LayUjoMrpaZTr1NK9VIkpBkZE9h+n+ZJToJFcXVGzQ?=
 =?iso-8859-1?Q?8JvdHc2uGfBMwis9jVFFP25WUwojl3JslVRhNi8p3sW6omZNfcTyAegIXz?=
 =?iso-8859-1?Q?JU1mluVkJm7VU5czIrTNo3eMvpNii5fZ+31J5Oeb5THQm4z9/Stn1HlcsR?=
 =?iso-8859-1?Q?JH+pfL6vGFcobe00sv8Pj8/AOO12?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yv8nLU9bO4dclUPWG/m33Cyj7HV/NhNXIBBG15fHcDc7eqzl6q94WzcgU7?=
 =?iso-8859-1?Q?R0TL+IZLUQyDQryyL0rv2RlB3hYwugJZ0r3oWl3PyhBshe1jgeZuFJ0NMo?=
 =?iso-8859-1?Q?lshrsgAkTWC0j2G1b+SeFcfTHqmA38fIWskD4seuCgwtGIZ7EH2Rd494cS?=
 =?iso-8859-1?Q?0BZj/eSm5AkqitYYjuIRQ2SaedQYhZpdxoE+NF5UMg0FUTZddqCLcn5d6o?=
 =?iso-8859-1?Q?Cj3YFfz9if1ZHEovmrvKuaCrW1Qoof2UojiSYm5oXqFErIvBKbMX9JaFe2?=
 =?iso-8859-1?Q?/hvuaTMKjqEeiINBFbwAbDucSxvoORnDOQD1anfhSwYWTSci84Cg8oAydi?=
 =?iso-8859-1?Q?TTGWMAUuaBKS6PfSkJ8NV72qyszch8jkHNNkwlP0uyvZQB8wSk9spoQ5Cl?=
 =?iso-8859-1?Q?IHSdIEJborFMfSgDihGrOY4T9epxjqk2mGqvj3HCIfqSrPdbIIFjt0xLrU?=
 =?iso-8859-1?Q?3OonGihroUjJ/Wjsmaarktadb3i9j+IDaywCpCm2m4wAWastMh2P/5KMPK?=
 =?iso-8859-1?Q?LRK8N74uBylZYN3yfiVP67KHb0WunpeG9Z23djA09w16k7q3hzEN2uc27+?=
 =?iso-8859-1?Q?fFRH0zSwEuhKqLfRErwBB3UlWkPmtJ6O+JzWFqx9uW0upcGZ0jQn2Ibdwm?=
 =?iso-8859-1?Q?WJ+t3h0B6qcTsvQQIX6Tv/fNHHPkDqhLsbYbKbOsjPyjmUCWbQ5Y4PBAdq?=
 =?iso-8859-1?Q?L6BH423Fz5/PGb+Qut/QywehYuLrNMVyauWc+Fn+VK4MtjlP0LuckevlF4?=
 =?iso-8859-1?Q?UbBv5O7E+fkxMaCmafnq15e+83iYAr4UPf5e32LjF5ofSwtoWf8ESO3tMd?=
 =?iso-8859-1?Q?9TYNCqF0T4zy+F0UmXRiMgbmQXZnYxmapbcmZtZGQgEgFxm/Yu/ZNdE8eh?=
 =?iso-8859-1?Q?Ye+64Ilx4XpEg/mF8FwXSFAYxvaj/de6FhqovQgsizSLddtnmTeKNLAd9e?=
 =?iso-8859-1?Q?rxH7LWKE9G+rZV9ZTSjfkxf0c58ZGFrSvzstYN7bnCDKL6eYfuLlKrue4X?=
 =?iso-8859-1?Q?vyU9XEsSeCqnUCEhltNgDaXGuHO9FtsYDfN3yYyYTRC7B5En5/HRu5Pm6f?=
 =?iso-8859-1?Q?Mwv1JXRZoRPviRVWKb26vaJq+Bh1S6M4VEPB7iYMXR2E+KLr4/HVY+HltU?=
 =?iso-8859-1?Q?S62CWZbK0ymQcy3EoiUbSeIbN0vLCJYbrfHVplhtwVRwQkM56/fDdt1HPM?=
 =?iso-8859-1?Q?is8gGxFZKaf9hmZGCR9yPPmIoih4Pcx1a3zYiaL1TU20r1V5ImREJnu5XH?=
 =?iso-8859-1?Q?YE70Jqt72AYl40RM0HEL56v0ZlfHpiVU5/xLHhS20Cfp34u9e7s02fHPoJ?=
 =?iso-8859-1?Q?lJyUkW5UlvuKkxD6mejyFD8YGK+S9uhjmWgsFYzsks7uPeLRMx2nc43BMn?=
 =?iso-8859-1?Q?BXD/M8Fi+uLcc9XaCDLWyD1JMwxUtapkiy5IGxazo09sinEvYfFXYwpJR9?=
 =?iso-8859-1?Q?aN6TgyBui/xSwuT7sb/hqR+DgofTmXbemGDUYKdR3wAmmAccwlrycNHkb5?=
 =?iso-8859-1?Q?YyVw/wucLzjdODCbGPwP+UK3NzoKAnsyfM2O0Gd9/eJSYb0vQixw3ZJAcY?=
 =?iso-8859-1?Q?wjoTeqxQfDVRFQSce34B03i+BgqBgIrQu8klFZ7mv6Ymjbv+0d5BVzWaSc?=
 =?iso-8859-1?Q?KhVIZQV4WzXwzD8x4gUF8pqekztgxVC18KIoYtEpfqRgdK27Pmwk6hkg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3c81ca-3d83-4c87-a4c7-08dd9d045c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 09:53:41.1397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69FDisqSbwFkHkO/3nUOEjksTU5eBiH31wSmFFtApa3uwRIimnCY59Q+KSB/9rLHb/GeWUzkvZnRVYFutWEeqyB+nNwgyo0G20BMGvOOzas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2884
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA4MCBTYWx0ZWRfX76xG0iR8qT7O
 OpwzIeez2OHgRl1qn8jdXci51PUbymYxoF2WaQpUEwn6njgSQ7DByTZZ4VOUb5tooJl4md6S0kJ
 t4fi5qwtNaNfs2FE7TAgxoe5ZCFrZ4n9wOApJoR4foBYplhDMnP3YLLfOD1jQ2T/b/LSj9u1gXQ
 THkKcHAKKO6KokSaHi0bFYJf6X/EjMLUrYxSw0405mtxJF+a93eafmqcil2Bdo8RyJAP/hRZCSE
 U3PgqteJ7Mf4MwupeUsoWeFaMvz36qCmdgyM0cfegfy18XsKa3ORcLPrXEnM3G4RmXEF74ul21q
 DxJS1xJIYP1SSRjTKcjbWI/0nXufTeUgkovZugH1LOylyvRjDq5gdfCF2uO5TzqZqu7SMVCU4VT
 NCERKxu7JDARyxkNjUC3Rvw5aEGxbRa+L6ugHjfjUUd/XgjsH7OwOyb3E2TOAdLAC4Rnbq3k
X-Authority-Analysis: v=2.4 cv=NoXRc9dJ c=1 sm=1 tr=0 ts=68358baf cx=c_pps
 a=qR5hoZQLE1LNPqQYfnbNDw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=Uwzcpa5oeQwA:10
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=wbWoyXctUsEdya3Fkk8A:9
 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-ORIG-GUID: k57zu2nRLMSnWoY22auUVBxNaTm3b_c-
X-Proofpoint-GUID: jbwwPn71YMvRKuyuAI6L8oZ7cjenE_3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270080

Hello Jonathan,=0A=
=0A=
sorry for the delay.=0A=
=0A=
It looks good like that. It is OK for me.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Sunday, May 25, 2025 19:23=0A=
To:=A0Marcelo Schmitt <marcelo.schmitt1@gmail.com>=0A=
Cc:=A0Isabella Caselli <bellacaselli20@gmail.com>; Jean-Baptiste Maneyrol <=
Jean-Baptiste.Maneyrol@tdk.com>; lars@metafoo.de <lars@metafoo.de>; linux-i=
io@vger.kernel.org <linux-iio@vger.kernel.org>; rodrigo.michelassi@usp.br <=
rodrigo.michelassi@usp.br>=0A=
Subject:=A0Re: [PATCH v3] iio: imu: inv_mpu6050: refactor aux read/write to=
 use shared xfer logic=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Thu, 15 May 2025 17:47:11 +0100=0A=
Jonathan Cameron <jic23@kernel.org> wrote:=0A=
=0A=
> On Sat, 10 May 2025 15:39:33 -0300=0A=
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:=0A=
> =0A=
> > Hi Isabella, Rodrigo,=0A=
> > =0A=
> > This patch looks okay to me. Though, I think Jean-Baptiste made a valid=
 point in=0A=
> > v1 about inv_mpu_i2c_master_xfer() not implying any specific slave slot=
=0A=
> > previously. I'd suggest to add a slv parameter to inv_mpu_i2c_master_xf=
er(), but=0A=
> > that wouldn't make much difference since inv_mpu_aux_read/write() are s=
till=0A=
> > hardcoded for SLV 0.=0A=
> > Besides that, I have one minor comment that's probably not a reason for=
 a v4 if=0A=
> > this is deemed to be good.  =0A=
> =0A=
> I'm looking for a tag from Jean-Baptiste on this.=0A=
=0A=
Jean-Baptiste. If you have time to look at this version that would be great=
.=0A=
=0A=
> =0A=
> Jonathan=0A=
> =0A=
> > =0A=
> > Regards,=0A=
> > Marcelo=0A=
> > =0A=
> > On 05/07, Isabella Caselli wrote:  =0A=
> > > Refactors inv_mpu_aux_read() and inv_mpu_aux_write() to extract the c=
ommon=0A=
> > > I2C transfer sequence into inv_mpu_i2c_master_xfer(), which now handl=
es=0A=
> > > starting and stopping the I2C master, waiting for completion, disabli=
ng=0A=
> > > SLV0, and checking for NACK errors.=0A=
> > > =0A=
> > > This refactoring removes code duplication and improves maintainabilit=
y.=0A=
> > > No functional changes are intended.=0A=
> > > =0A=
> > > Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>=0A=
> > > Co-developed-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>=0A=
> > > Signed-off-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>=0A=
> > > ---    =0A=
> > ...  =0A=
> > >  static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *s=
t)=0A=
> > >  {=0A=
> > > @@ -23,6 +25,7 @@ static int inv_mpu_i2c_master_xfer(const struct inv=
_mpu6050_state *st)=0A=
> > >  	uint8_t d;=0A=
> > >  	unsigned int user_ctrl;=0A=
> > >  	int ret;=0A=
> > > +	unsigned int status;    =0A=
> > I'd declare status above ret, or together with user_ctrl.=0A=
> > Just minor code style thing.  =0A=
> =0A=
> =0A=
=0A=

