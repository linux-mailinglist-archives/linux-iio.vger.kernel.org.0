Return-Path: <linux-iio+bounces-22916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40EB2A017
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 13:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BB53AA7AF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8E430F803;
	Mon, 18 Aug 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b="ezcP+By0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00015a02.pphosted.com (mx0a-00015a02.pphosted.com [205.220.166.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8212C2363
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515321; cv=none; b=moAjQV75yGVOH4PZfnLeT1EFCWStQHkHOCKqvqEUgb+n5nL9JuSvLxEzPkJ4BamN1BqYs1cLuyNaPpAFfXS/S5tPM/6+OmqRGJfQ2N5NyPz3ciWlR7TElfbj/kk3nu+ARxadbggR+0icw9HdBLQV+BXf0/kMlHOevcwhSZkP9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515321; c=relaxed/simple;
	bh=fR8z9AOhV3XFlMPXO0SlMhZzFpWm4ih6CCyo9HnpLBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=rGPGrxY7IRGsUcD6IBZJdZobAEc9qCqQcET19ffFDwHaDomXD7S6URV4n7F4BC/ijUtlXoAcSB0UICKsa7h6xAp0x/H2GLBHnzcNJMoHeCzWwR9XzXaw/vXIfwZ6vxdb2DfABO75sydEWFMDK1X0HxY0aGdOdGD3OF8/kzt/dCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com; spf=pass smtp.mailfrom=belden.com; dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b=ezcP+By0; arc=none smtp.client-ip=205.220.166.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=belden.com
Received: from pps.filterd (m0264209.ppops.net [127.0.0.1])
	by mx0a-00015a02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I71FIm008264;
	Mon, 18 Aug 2025 07:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=podpps1; bh=3u
	usKrZvbYn771Ega/1jK54xaN70W1soGzqVjpKKu4s=; b=ezcP+By0EPu+Q7YgMz
	MyVC2vVNAsjWJv2XhQgMLaLd6ziTckmM/cj/xFyzW9SmaNqzShKUslyeRDfsuKO1
	OfjgbIhbkxGHDXOHZjg+cGOQzbwNbrM0ZSCnCsdUZPcT/J3Unr9lLgJNWN7qCE5r
	O8a+8lHnGUlmTnz1cC7G7vnBdNr7guqF8xMKk648+bnpBrFuLuw/cNIJt34orcH/
	rXets6oK6Ph75SoSR3GJ85dS26ceN5j8fXdd+HGE3KWfaFUQSYoUdcKLoE+TnFVB
	mvzikQesfxOALo+awu207zSy3ldiGsyG/OhRwheOYPsXgaCPwTiW3hnr8lLhUaYy
	lnKw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2093.outbound.protection.outlook.com [40.107.244.93])
	by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 48jpaajmpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 07:08:37 -0400 (EDT)
Received: from SA1PR18MB5692.namprd18.prod.outlook.com (2603:10b6:806:3a8::9)
 by IA1PR18MB6414.namprd18.prod.outlook.com (2603:10b6:208:59b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 11:08:33 +0000
Received: from SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::1b82:7cf8:55cf:35e3]) by SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::1b82:7cf8:55cf:35e3%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:08:33 +0000
From: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "marius.cristea@microchip.com" <marius.cristea@microchip.com>,
        Rene Straub
	<Rene.Straub@belden.com>
Subject: RE: [PATCH] iio/adc/pac1934: fix channel disable configuration
Thread-Topic: [PATCH] iio/adc/pac1934: fix channel disable configuration
Thread-Index: AQHcCsEkPwmfwU9r6EyB33LmET6FlLRlUhgAgAL3x1A=
Date: Mon, 18 Aug 2025 11:08:33 +0000
Message-ID:
 <SA1PR18MB5692ED633F65FF2361A30AC59931A@SA1PR18MB5692.namprd18.prod.outlook.com>
References: <20250811130904.2481790-1-aleksandar.gerasimovski@belden.com>
 <20250816144352.53e61562@jic23-huawei>
In-Reply-To: <20250816144352.53e61562@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB5692:EE_|IA1PR18MB6414:EE_
x-ms-office365-filtering-correlation-id: 4501eab5-8e91-457c-36df-08ddde47927b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzMrMlNxZ3VYZUZScWk2U2dKRkZMY0p2UmQ1ajEwYm1xYktwT2ZTaEFYZ1Yw?=
 =?utf-8?B?TFIwR2s3bVo1Tnk1NjlDK3h3YTUrVCtNMldVaUxjMjkwTCsrNUFpZ0J5d2Nn?=
 =?utf-8?B?SlVOclRTUlZLQVdGdFpDT05qZHdiSy9nS0Q3YkZXRjQvbnZQZk1TbzJER0dj?=
 =?utf-8?B?NEV1RTFQbmZsbWRwem8rcUNEd2JIRzVFZkRocUFvdVB4MVptZEkzcnNXclJq?=
 =?utf-8?B?bm94MkltMlE4SVRycFRSRURvcHZlWG90bm01U2luZld1WGlJNnlJLzJnMnl5?=
 =?utf-8?B?ZlJ5UWREOERUOGN1UlNvcWsrdjBDUk9jNFlnVkJFazVyMHRJa0JpZmlsMWhT?=
 =?utf-8?B?WisvNkR6TEQ2WW5uV0tOOHFNMlAvK2lYdmhqV3ZCSHFxZjFSNFI0a3g5b3dw?=
 =?utf-8?B?TUVTL01iUDd4eWlPcXFGYmNHVUhRbHFsOFpPQnM2akgwMkNrZ3dzUXFuSEFi?=
 =?utf-8?B?SkhUV1V6emNyemFGRWJQWjc2YXhJRi9ZOHNOZ0lUNlg2MFlwRmFmeGJydWdI?=
 =?utf-8?B?OWdJWmtWK3RWelB4R041V0xoOTkyci9WOE1wbXp0S1B5cGRCRnQ4S090eFZ6?=
 =?utf-8?B?bDdGL1l0Z21LL1pUa1l4SkVoNTZJWGkrZDc0UW1KSUFLdG4rWVB2SDZUZ0Rn?=
 =?utf-8?B?eWEwY0R2ZXNCK2dZZGhzSG0xbzFMcGd1SG5MMVlZeFhCa0ptQldTd0RUdnZo?=
 =?utf-8?B?MjRmTEMvckVNM09Ka0NoQXhpYytIUElPMk5xeEVKRkthcmFJd3ZLS0M3YURr?=
 =?utf-8?B?Q3N3NmV3NlFwaUwrRWQ1eXhqSFRpRjZnTFBRL015dnIvdjNQaGdOSzVmUXoy?=
 =?utf-8?B?bE9MY0VrdVJySDZNZlZOS25iQUkxWWl4bVBybVFackE4dU1DNThOZDhNaTVQ?=
 =?utf-8?B?WEd3YmtuRWl0TFNDQTcxU1BaNEp0U3hpYTZpTDNidTRvMUVndTlDKzRKazNz?=
 =?utf-8?B?NEI1YU0rZk1UQmtoVVM1L2Rmcy90NUxIN1E1bytEdG5nRWl2RGtHaXRjb1k3?=
 =?utf-8?B?T2E4U3owSDA2Vy9ON3NKK2wva1VGNDJzOEZBb01xTklDWnIvQkpMYmg0NlE0?=
 =?utf-8?B?bnB4S09Iaml3aXVVTk1mdXdYcURHVzRFVHgxVHBVN2NydEpOY0xHa3BIUTg0?=
 =?utf-8?B?Z1p2U0JVaDU3ekNuL2xpVlY1dnBEdzRIOTRsZ1c3QU53WWVseEp1Q1BlaU1S?=
 =?utf-8?B?SHVzTDRqaFQrdnluZGVhckIrNnh3bEtaRlVGMi92UElNeFdta3h3OUZ6bDRN?=
 =?utf-8?B?Qkt6SW9GYXlNekJQZFZ3TkRsUXBBc3BRb0xtZnM5ZGlEbVlyUDJXcFBXR1lI?=
 =?utf-8?B?eW94eTIxUXJOQWdqN28vb2R0UTMxNHZQMnluZ3NWMFhvaTBEeHpIcTRFaS81?=
 =?utf-8?B?R0d4SzZDb2pkMXhNb1J2ZUNBM0c5a1ROaGR4dUlkYzQyYTkrbHkzckNtSHZm?=
 =?utf-8?B?TGtZSHBwMFMzN3N0dGpJN1BkZFR1WjJ6cnhaVjMzUk44VkpmRWR0Q2sya256?=
 =?utf-8?B?MTU1TlBIUzVBbEJEU055Z3A3d0dCVDZUdC9YZXZ1OXlkZXdrL2RqMlliYzB6?=
 =?utf-8?B?THdrWUU0SmpWY1NCR0Z4VU41UXRXRCsrQWNRaEpwTHBKRzlxc0hvM0RBaWZq?=
 =?utf-8?B?Y01lK1E3UzVid3NqTThZMjZRRDhDM1NiYmt6V1pFV3F2Nk5ETEhmc3MzMDFs?=
 =?utf-8?B?TlROTGtyWXVxVDJHeU1zRFFwcmNEY3Q3REwvcGRkcFhtWFl1SUNCLytEY3da?=
 =?utf-8?B?TjluSmdRY1BhQTVSS0VwUzU5Z2ZZY0JYZXpVVkYyUzZsQzlUMS94VThHZUZP?=
 =?utf-8?B?WUxITjA4L2orVGQ0MmhxZU9hK2FXMER2T2ZUSGF5ZCtITXN1bGJQUEoxRXJy?=
 =?utf-8?B?MnVLdEEzYVg1eFlyNmRNSlk4dGRxcHhiTWVjekdML3NtalRlSlpxTEhzMlNZ?=
 =?utf-8?Q?PS/Z5BgnXX4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB5692.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3NrU3diRWViNHlzMWFFRjE1Sm04MHRBTFNQeHZnVG1uc0R5RkVGNTFxdGJ2?=
 =?utf-8?B?eFF2aDdReVRBZ0NPTlQrT2lKamtBd21KTmcrdWxKY05QYitoZVJGTG1kY3hj?=
 =?utf-8?B?MS9yaFpqR25sUWx4U0JaL25aSHpnRFlqT0orL3hQVHlMRGJzaURGWE9QVmJo?=
 =?utf-8?B?djVSeS9IR0tReVhYbi9mK0QvSEFkWFdha3d4YWh4dGlXemRwZmdiaFkxYy93?=
 =?utf-8?B?Ym9tcEtvRm1tazl0L01FM0l5c0syTkUvMDBseWhyZ2pMV2FMRUlFVGhVRHVO?=
 =?utf-8?B?cWFnN2FOdWEvTThYRCt5TFNCN1d5WTVnUVQxQVdEY0dBNlVxYnBPVjBIMi9X?=
 =?utf-8?B?dldMMVlFR3h6TDYvR2dJQmZ2STRxQytLcWJmRWIyK01IalJUZUhpSEFsMUxx?=
 =?utf-8?B?RWlyTjZJSTV6VDBLditVM1l0TmVBVUxGUjMzKzlobloxbUQ1ZHBzc3BNZTRC?=
 =?utf-8?B?OUxSZE13STBHdmZtSlh2Q2RsVmcyVjFIVFVzY01OTXlqbUJIbGxsZjN6WldH?=
 =?utf-8?B?WEdwdkgraXlLVlU3c1duREZsa2Qvdi95UzFIMFhWUUJMZ1VIdUxZbElyd0hR?=
 =?utf-8?B?eHNKaU5KYndMNkJZZFIwYjJVSkJQRzU3SkNjc0Rvc1FqUE80Rzg3S2FOR2Vy?=
 =?utf-8?B?bWk4WDhnM0M4L0JyMUdpcHlyeFdEZDhhUVlxSE5qTDJBS1lsdm4zeFZCSW5P?=
 =?utf-8?B?QytZbHYvNlQ5eTVDVmw0OWRnZFRSM0ZxeHNXdktiVVZrd1hqNVFzWVJxWkNt?=
 =?utf-8?B?YVFJSkc4bkxLaWU3QXpHN25hbUc1VFdyUWR1SklpNy9tb2h3aStqVEcxTllU?=
 =?utf-8?B?aEo0aVRXUkdvOW1MWDdheDZIV0N2ZnlSNG5yZzY5c0NUeXdIOXplaUYyQVFT?=
 =?utf-8?B?ZFFIZjZNc29jSEdtM3RaNUI4OWFHb3E2bDdLZmpwc2c4U1I2WVZBT2ZkOHZp?=
 =?utf-8?B?YU4wZkZCVzY4cExHWXgvRUNxL29vZVRnSHE2UUwrZ2VLcFdpQ1dYbkZRUzk0?=
 =?utf-8?B?SkNGRjdxM21MeU44Y1JGOWdYQkFIem9wNE9Vak5FeEhacXM4b3NEVUVSa1Jr?=
 =?utf-8?B?NUxpaHk4ZlhsdGhlOVlOMFhrTWVkUUF3QTM0ME9rQW9ZYzMyT3gwclUvWUNC?=
 =?utf-8?B?R1ZrcTBiYnBTRHl0OURmK0hOVkRZWXNwN3h5c0t0ankvYlJwS1RmVm9PdmJK?=
 =?utf-8?B?amFJeFJCenIySzJ0dEw5NGVleDJzTENPL3MxMmhVemFvaTZIaEJQZldQZmo1?=
 =?utf-8?B?RlhmaG4vUWppUFRPT3ZyYjljelhOUUF4K3ZBTnVEb1hJUk8zc0hTT05Oc25B?=
 =?utf-8?B?STRVbGVIVlhQdThpMWJXV1VlaXA4TnlESTg2RW53bHFQdkxkTHVrQmtNTy9N?=
 =?utf-8?B?U3UvUHBHdXNOMWhWdVU1S3NuM0lDZm9GRGZCZ1VXczR5YjRPeHY4RG1ScG9W?=
 =?utf-8?B?K01ET1dzMnlRcmRualp5M0V3L1dvc1I3ZEJkU3VyaFV6MFp4ZnhkZ2tNRjRS?=
 =?utf-8?B?c1QrN3FoWUtaSHMxZSt6VmZ4dHB0d2llTDZ6MFM2L1BOQnhhNWluR2tXVVU5?=
 =?utf-8?B?enNzZjZIVW5hNXhrSmplZ09BSStIdUIraWdrSFJHenZOOUdDWXVVRzdzL3dy?=
 =?utf-8?B?WXZCcUt2dWgva25LR1dkcjQ4NzJUbUU2eGVtUFBXWUNOVnJuR1FmVWEyK3hP?=
 =?utf-8?B?RUpKWFNmSUtpN3JjTEJ6NXVWQ3MxZFlPVmJYZW40TWZRQW16NGF3SEpmWm1j?=
 =?utf-8?B?SVN2TGR0MThjUTAyM3RobkJXb0NTcWR0QjJETWNZQzJHSmEwaVhlZjB0LzVJ?=
 =?utf-8?B?VUtQb2orVzhvb292blJYL3luWm9pNitiTm9TTHRwKzc0V2oyUlk0Q3B4b09S?=
 =?utf-8?B?NGtJZE1ZZEhZeDRVUmdoOE9PeHlSQTdzb0EvOGVPZzN2TittTzQzQWk0Z2tF?=
 =?utf-8?B?OFU1ZTdwZVBkTWhWVThHMXhwWEV3MysrYzFMMk1UMXpqQU9IL0JpQ2F2ZDBT?=
 =?utf-8?B?K3pkclVXend1SFRnR2NMSmtoQmZEemw0b3JKTnlUTGRqYXRRVU1KU3ZJTzkz?=
 =?utf-8?B?dmlvZEJtWGZOMzNqVkpNZVZRdFYvb2FxcG5SaTdxcmdnek5UMk5ZYUlEak53?=
 =?utf-8?B?UEY2czhxV1pqOTFMZHF5L1EyR2hrU05pL0srbDZzRkRKMlpvbUF0cG00Tk5S?=
 =?utf-8?B?Y0RWNmF0QkowV0tKdnE5U0szQ0Y3dmhrYTA5UGtXU2NFbFU1M0tyOE9WdGhS?=
 =?utf-8?Q?ZFcEJscd3TRirNJkE/0SIyUvYXFFckWO4UuZK0jviY=3D?=
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jK5d5XOGg+4gFyGp7h+kSiGixqox64w5XQRfNVOGAbbrvsIQ0J6H/ynu5qlWvMiOf+LlcmfO7y0IDoSh5JIRryB92G9bJFEOQwer1RZ02aevJ66waiXRvF6nzRG0H3V1mU2994aKUj2vBu0O8rNayxX9L7BlmP0oFv31VZkdz4BnQWugShE0HfN0DUz/pvAbIbwPQRxQc+bn4oEtXrl0QfOvnRZJbA7vE+EMOVQieTompR+Ys394igizQdM6c2kBboBH1XO4bX6WJot+oo/Ff2BOCeGwKzOPTC/r2urrjojm74pfNM53tH+JwC6QGxlN+e8a8V4gqDlQaQ0lbDY1Bf0htBeiqQWA/9gvyqRCEIHydZDKdh21tL9c8247PiGy4lDP8VZMGVp54VF1izMNsCyzSn9ssGXBkkHUxvbCcXIH16+0NOWlrrNYtC3KXLN9fHTdO6RJOtMKYb0CXkTd7sljpfAhv8+lKreGuD5FbTA2KdTzXpwVkBJOy/sAGhokjOxwb6QOZa6CEMWEN9wNXzsrhXENREeNbovBcKdps5pX8+pkBqthxBW8dmqbbyChhLOZ8xtz7HTGJOpz7ckrl2hzO8aHjg6t/BoJKPx5j1o3sHLJ7UP+M4uY7/G/1SBIy5URaTSJOJ8r041kL+C3Lw==
X-OriginatorOrg: belden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB5692.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4501eab5-8e91-457c-36df-08ddde47927b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 11:08:33.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0f7367b1-44f7-45a7-bb10-563965c5f2e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLU9y6wX3INFWm2CwYb8qP1pUQ/ZKNjkpOZp0ia+Ol3LOr/64oOScZ48rkCPx4tKyK5+HC3bYxNdzBW/f/8QwzB7w7LYMR+vzTzqJFdoW498cczjBvAWIKLH9EIGLEZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB6414
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: emastj8sFJV7PvV0ILQDIjZDZzT-KcRA
X-Proofpoint-ORIG-GUID: emastj8sFJV7PvV0ILQDIjZDZzT-KcRA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA4MiBTYWx0ZWRfXzvog8yg52bVC
 5x6X9GW8MVz2LEOKbT5MUdRYKZlKtS5/sxmPol6n/HHPM2j8iOb9Udw/UtgxDTYb0YxYJ7MaIY/
 LzvVkZrzZ5FKH9EkeBaGb7PaTKFAOjF6+LSgULJjxQXVuG0QwDrz7oyJJwVlC/6xWup0txshuVP
 hOeSKNpkEogyGcrspngUMPn0mCBxhhphrLMPa9O/FhymXecf1+3y9Q1lCw73Kh6pBYYYlwJVHOQ
 wZnAj/f9VVQfXD2LfE5IbmzUvGSdk0jXXnlo5jj589Zwo0h0vpc+5mZbL+5ppc5n+2oxep5PpKc
 5hVsLcrk6C/jrsAZKpwvpnINv3aUOEQqZy1qQG/HUDe3MBMDTg4HzpS3aafRV1r7OusTCm0ciWy
 a3hDJIsa
X-Authority-Analysis: v=2.4 cv=I7hlRMgg c=1 sm=1 tr=0 ts=68a309b5 cx=c_pps
 a=oXwIvQvTOe716DARGc1IMQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=mCf63rc527wA:10 a=RpNjiQI2AAAA:8 a=VwQbUJbxAAAA:8
 a=WDlp8lUfAAAA:8 a=XYAwZIGsAAAA:8 a=HpWLchbfDhzW0IRkwsEA:9 a=PRpDppDLrCsA:10
 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160082
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam
Content-Type: text/plain; charset="utf-8"

Hi Jonathan, and sorry for the previous non-plain text message:

Fixes: 0fb528c8255b (iio: adc: adding support for PAC193x)

Regards,
Aleksandar

From: Jonathan Cameron <jic23@kernel.org>=20
Sent: Saturday, August 16, 2025 3:44 PM
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
Cc: linux-iio@vger.kernel.org; marius.cristea@microchip.com; Rene Straub <R=
ene.Straub@belden.com>
Subject: Re: [PATCH] iio/adc/pac1934: fix channel disable configuration

On Mon, 11 Aug 2025 13:=E2=80=8A09:=E2=80=8A04 +0000 Aleksandar Gerasimovsk=
i <aleksandar.=E2=80=8Agerasimovski@=E2=80=8Abelden.=E2=80=8Acom> wrote: > =
There are two problems with the chip configuration in this driver: > - Firs=
t, is that writing 12 bytes (ARRAY_SIZE(regs)) would

On Mon, 11 Aug 2025 13:09:04 +0000
Aleksandar Gerasimovski <mailto:aleksandar.gerasimovski@belden.com> wrote:

> There are two problems with the chip configuration in this driver:
> - First, is that writing 12 bytes (ARRAY_SIZE(regs)) would anyhow
>   lead to a config overflow due to HW auto increment implementation
>   in the chip.
> - Second, the i2c_smbus_write_block_data write ends up in writing
>   unexpected value to the channel_dis register, this is because
>   the smbus size that is 0x03 in this case gets written to the
>   register. The PAC1931/2/3/4 data sheet does not really specify
>   that block write is indeed supported.
>=20
> This problem is probably not visible on PAC1934 version where all
> channels are used as the chip is properly configured by luck,
> but in our case whenusing PAC1931 this leads to nonfunctional device.
>=20
> Signed-off-by: Rene Straub <mailto:rene.straub@belden.com>
> Signed-off-by: Aleksandar Gerasimovski <mailto:aleksandar.gerasimovski@be=
lden.com>

Hi, Thanks for the patch.

Needs a fixes tag so we know how far to back port it.
You can just reply with one to this thread rather than sending a new
version.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/pac1934.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> index 09fe88eb3fb0..2e442e46f679 100644
> --- a/drivers/iio/adc/pac1934.c
> +++ b/drivers/iio/adc/pac1934.c
> @@ -88,6 +88,7 @@
>  #define PAC1934_VPOWER_3_ADDR			0x19
>  #define PAC1934_VPOWER_4_ADDR			0x1A
>  #define PAC1934_REFRESH_V_REG_ADDR		0x1F
> +#define PAC1934_SLOW_REG_ADDR			0x20
>  #define PAC1934_CTRL_STAT_REGS_ADDR		0x1C
>  #define PAC1934_PID_REG_ADDR			0xFD
>  #define PAC1934_MID_REG_ADDR			0xFE
> @@ -1265,8 +1266,23 @@ static int pac1934_chip_configure(struct pac1934_c=
hip_info *info)
>  	/* no SLOW triggered REFRESH, clear POR */
>  	regs[PAC1934_SLOW_REG_OFF] =3D 0;
> =20
> -	ret =3D  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
> -					  ARRAY_SIZE(regs), (u8 *)regs);
> +	/*
> +	 * Write the three bytes sequentially, as the device does not support
> +	 * block write.
> +	 */
> +	ret =3D i2c_smbus_write_byte_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
> +					regs[PAC1934_CHANNEL_DIS_REG_OFF]);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D i2c_smbus_write_byte_data(client,
> +					PAC1934_CTRL_STAT_REGS_ADDR + PAC1934_NEG_PWR_REG_OFF,
> +					regs[PAC1934_NEG_PWR_REG_OFF]);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D i2c_smbus_write_byte_data(client, PAC1934_SLOW_REG_ADDR,
> +					regs[PAC1934_SLOW_REG_OFF]);
>  	if (ret)
>  		return ret;
> =20

**********************************************************************
DISCLAIMER:
Privileged and/or Confidential information may be contained in this message=
. If you are not the addressee of this message, you may not copy, use or de=
liver this message to anyone. In such event, you should destroy the message=
 and kindly notify the sender by reply e-mail. It is understood that opinio=
ns or conclusions that do not relate to the official business of the compan=
y are neither given nor endorsed by the company. Thank You.

