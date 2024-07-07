Return-Path: <linux-iio+bounces-7420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7D2929A44
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 01:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFEE280E8E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 23:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE56F307;
	Sun,  7 Jul 2024 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iIn1Glt1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE9524F;
	Sun,  7 Jul 2024 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720395493; cv=fail; b=crspQApxU0mxriHtS6r/5lCTIig5E4jXpRyhH4rpjfWRQmMyvq+2xTsUwpu5dphJMmoZ/DB0dY4tck8iZsfmTr/JX+3hlpcIW/3qdE6P8dMyY0eioAB4fVY2EVLsxdHENMZR6aiJWo2NiyoaC4q5WghvOHBkWxP/NN+DeDOQP4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720395493; c=relaxed/simple;
	bh=mMSpO8UDWQaqmR+S7dvgtxe9jhJNkuAsMNsD/gdtVno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j5Byb5PBkaPU5REAwa3EVjAB0acQeAIvoE7CJkmqA4XQMckuvjlZJFThSMrwdbVFdMCa1ZUwmDEXHGK0Q5hfHRup9T34FEiYF5magGvSbj/mgCrBRAf7PhGeCHccviOmsW35fW42tRWCoMg6re9cOaAn/GYWkrTX0H5vTk2inLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iIn1Glt1; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467MWT32020693;
	Sun, 7 Jul 2024 19:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mMSpO
	8UDWQaqmR+S7dvgtxe9jhJNkuAsMNsD/gdtVno=; b=iIn1Glt1NA/0ltuzoIEyo
	xsCQSCfOKuSxsxQSRItUKE8D8AehMphiApIQHk/AXFsqW2/7dlKx0KeuHOayzMIf
	KwnhG89SsxJt0B2FPc43YURTleAQ+pT9cIX2EHJg98fMDy6pD0257wdZF+H7e/qD
	QXy7TdUbX3+9m4M15Qmb7D0dQkFX2nYbGN7v067XCctlctUkUg0E4rJTR86ahv35
	incU0tWkz1GduzjDsqEoyw66mpzkXKt0gh9l/4M8K553V0xyAOKwJpySyRzht7zn
	oxwpXQ/N0wYGHL2SJIge5acXZ9w/nA6D8SQhZgOhCTsj0YQN0q7jkUbMle60bg/w
	w==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 406ys2kuus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 19:37:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeBtudVe+94cyGba1wduCEJ7i3Yftt4hNztuEicUDSkXQoCU5taxvXyIdxq23ZyBd2aMELg8Bln1Mc/ZYE4WfYKQ9ewiLjMww0Dh69pAfGqF/lCmiYz3fWjdL1RMGAY69KV1O9jqFymgtLRh7cNWZ7McF4d4DarNB+AtalgE4oB6NQnoL8cIPWJal5tP8RHJK2X5l+lbsgqMKGBkNt2h1/yYbql5ItDN5cZEfK2Xqm8tKJGdYXQ3vd4QgV34M43u3ooChBknGl4Ch6DkOvUhrSlCmeL/MSfSfZuO040V6AknvC4YUtS3S2AoTfYc8gTd0fXO08r5VCe0Mcvb2lKW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMSpO8UDWQaqmR+S7dvgtxe9jhJNkuAsMNsD/gdtVno=;
 b=R0vpLmss8JoFIAqqzOJOVpAlzyutiIYXMrXpc3kGkL7bhzBfIYZOHFB2dDtQ+tpfcaWhNI72m0M13fmr3FIDVffGyux82ovVnnDdAsdSDTZj30JLvQeO3MU/rrIIsIHAVrbPQutD6Xp2Aenf31ydt0W/jUXXYTG+sNkABHZWp24Hz8FVhD47FOcGU5mvj75ov1o8njiiJLF7+A5ORQ+q4RFaJy0TSKDW8dK7tHaMfmNjGoe3QEadhtlPujavYkk1h0Ja7nmQBx8VdI2tQR5dMvd/KE88d4MRBasdsoR4xXjtB4UMsA/K+6/AeGB6iMjJKgT+qsMVUZ4UlgaW6QPE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by SA0PR03MB5387.namprd03.prod.outlook.com (2603:10b6:806:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Sun, 7 Jul
 2024 23:37:42 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%6]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 23:37:37 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Topic: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Index: AQHao8JvQg6+h8gTiUiRiY/wSfSRo7HWmXKggAc3TACADnL84IAAAbBQ
Date: Sun, 7 Jul 2024 23:37:33 +0000
Message-ID: 
 <SJ0PR03MB6224ECBBCFD4B7179D1AFD9D91D92@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<20240510064053.278257-3-Mariel.Tinaco@analog.com>
	<20240511174405.10d7fce8@jic23-huawei>
	<SJ0PR03MB6224D9A14475071E8A1D921A91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
 <20240628195106.215839df@jic23-huawei>
 <DM8PR03MB621392355B8871452D7F9DA491D92@DM8PR03MB6213.namprd03.prod.outlook.com>
In-Reply-To: 
 <DM8PR03MB621392355B8871452D7F9DA491D92@DM8PR03MB6213.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzEwYVc1aFkyOWNZWEJ3WkdGMFlWeHliMkZ0YVc1blhE?=
 =?utf-8?B?QTVaRGcwT1dJMkxUTXlaRE10TkdFME1DMDROV1ZsTFRaaU9EUmlZVEk1WlRN?=
 =?utf-8?B?MVlseHRjMmR6WEcxelp5MWxNR0kyTlRJNU55MHpZMkk1TFRFeFpXWXRPR014?=
 =?utf-8?B?WkMwM05EQTBaakUxTWpOalpUaGNZVzFsTFhSbGMzUmNaVEJpTmpVeU9Ua3RN?=
 =?utf-8?B?Mk5pT1MweE1XVm1MVGhqTVdRdE56UXdOR1l4TlRJelkyVTRZbTlrZVM1MGVI?=
 =?utf-8?B?UWlJSE42UFNJeE1qUXdNQ0lnZEQwaU1UTXpOalE0Tmprd05URTRPREV5TXpr?=
 =?utf-8?B?NElpQm9QU0p5YUhvemJIRklRVU0xWmtOeFoxaFdaelpGVVdWdWJGcDVVVkU5?=
 =?utf-8?B?SWlCcFpEMGlJaUJpYkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNT?=
 =?utf-8?B?RlV4VWxOU1ZVWk9RMmRWUVVGRmIwTkJRVVIxTldoSGFuaDBSR0ZCVjBaRGVu?=
 =?utf-8?B?VjZOM0pMVTNaWlZVeFBOMUIxYzNCTE9FUkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlNFRkJRVUZFWVVGUlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUlVGQlVVRkNRVUZCUVROTWFGTm1aMEZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVbzBRVUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFX?=
 =?utf-8?B?Tm5RbXhCUmpoQlkwRkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21k?=
 =?utf-8?B?Q2FFRkhkMEZqZDBKc1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpz?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVdkQlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RD?=
 =?utf-8?B?YkVGSFRVRmtVVUo1UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdR?=
 =?utf-8?B?VWhOUVZoM1FqQkJSMnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlVVRkJRVUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFV?=
 =?utf-8?B?ZHJRVmgzUW5wQlIxVkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5?=
 =?utf-8?B?QldsRkNha0ZJVVVGamQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJRVDA5?=
 =?utf-8?B?SWk4K1BDOXRaWFJoUGc9PQ==?=
x-dg-rorf: true
x-dg-refone: 
 Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|SA0PR03MB5387:EE_
x-ms-office365-filtering-correlation-id: 24028de8-c2ed-4fca-a4d8-08dc9eddc6d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cjNTY0dLeUZ3OUl4L1VlZ0YvS0hCUXhzTkNVYkN4cXBIQ2psMnBNOFdOQjIv?=
 =?utf-8?B?NHdwQUxYSGNMZWlkRmp1a1NzdUtzYmRlc3dqNnJoUVVnQUhzQXlWazl3ZTBp?=
 =?utf-8?B?MWRCK3dkY3JHeGxWZGtvSXJ5YndQMVJJbmdvMHcvWVhhc05adG9VaDdzNkJK?=
 =?utf-8?B?d1dac2FYbUpaYUx4Q1BORjRtUS9RVTJaUEVRUGJ1RUlrcEMzNFBuOEZtUzRF?=
 =?utf-8?B?eE9LNGYyd09mQUk5YUZTTnNzaXlHckFTalEzVWdyTWZPaXhwaXhlUkdNZTE3?=
 =?utf-8?B?VlN6aStkRkk4eDFBR2JCSTg5d0FIRVFBMkZmOUgxVjNNcm9MMGE0NEU1ZUg1?=
 =?utf-8?B?blpFV1hwRVVRSGhUdUlQdnpUcnpaUktuajc3VFg2bVRqS2VNQVBpQmVLSkEz?=
 =?utf-8?B?UFdxM1IvZ3BaeWhVQTZxNE9yRTlvZkl4STlEaTZkWlFhbW9XRmF2MVM2V1JM?=
 =?utf-8?B?UUY1Yk0yM2hGUHJFL3Y3bXliK1poWHB3RWFoVUdFajAzN1VaeE1WWTFCVUQ1?=
 =?utf-8?B?ajJhK2lYd2hGYzZRTVZwNXk3WlcwdHlGWUNMN3ZyMEdIT3pqTzVFcXloMkRQ?=
 =?utf-8?B?U20rSXlJNWVtRW8za2l5ODJ4Z3lmS25vQXAvbWhBZzFyV0k1TE1PUk9zN1BD?=
 =?utf-8?B?cHJJbmJ6RHZWdFFjZWhGZWlSaEtuUGdIVXZhT2J6SkpmTkI4S3NtQXFDZWdW?=
 =?utf-8?B?UFQ2Uzg2SXkzSmU3M3Rmaitmc2JYbXA2VWtCME8xaENRWTZ4TzkwdTlKR1d0?=
 =?utf-8?B?Tk5pOVpPOUwvYnhQWit3a3NTTjdUOVAxQkt2S1ptTGJrSURSYjRmN1ZIN2hv?=
 =?utf-8?B?T1IvdEdPSGNLaEkvQ0NySUIwNjMyVllZbC82VTM5SFJnV0ptNTRMTW5jcWE0?=
 =?utf-8?B?TEQxbHo0M2lqWFU4ZXZVOEZZcDA0NXc4aHpLOG1uRTJOTjhvMS9LTlRqWWpC?=
 =?utf-8?B?WTMyTVNGMm9HTVZ2eGtRV2txcFhpL3czanU4M0REVHUydHNuZS84Mkljc0tL?=
 =?utf-8?B?UkwvbzhyUnlRSmtDWER1bHR1QWM0Q2Y5QWdPaUsrbFdma0d2OUs3S3VxOFRH?=
 =?utf-8?B?dms0SlBRenFpNHpxdEoyNVpsNndOZS9SOUI4ZmRncjM0UTg4Q1JURkRqMTFH?=
 =?utf-8?B?b05TcDMvbldGQUdleGtwaUdVRFVsWTRsVmV4QmkvZmlveDArKzc4d09FQWtp?=
 =?utf-8?B?dlExOGpEOW1nVEp1Q0Z1L3ZEOUpHL3dqNHJxVFpObnl2Q3YyekR0ZmVjVE9G?=
 =?utf-8?B?b1RiaEVPdU5uRUUwdmRGcFpwUlUvN1FMU01jRXBHVFJmenhqSmU4SVYzS1Bl?=
 =?utf-8?B?emVqQmJrbWVkMjRvZ1pzcnVrYkViTkRzQ2JNQnAzc3UwcXhXV2l3SFhtMEpU?=
 =?utf-8?B?QmtvaG82c09yOEd0MG1jc2JzVXJMQ0xTWHIxaFlxRCt4WjYwdHg4QjRtM0pH?=
 =?utf-8?B?a2c4em05SWYzR2N0UmR6a042VzV4UmtuRnBUVTN6eDJ6c2F5WFJNandlWmRW?=
 =?utf-8?B?eWpTbVA5RGptTWtRNjFXR2VmTm82cytLU0JKdEZ6NXpGUGpCY01jRDhRREh2?=
 =?utf-8?B?ZEZNdTRIdW9MR05WTU15b3NzTWpGcGJZNzNGNWdqQ3o1V0kwR2paZEpiNUpV?=
 =?utf-8?B?dklyMEdhaTdlcTZwTU5YbmYxVjV5cURBc3RxR0tMSTF3a0Urb3dXUUx1VVBu?=
 =?utf-8?B?MU8yWGhmL3ZOR3NBR2VOU0FhejBmNTlubXA3SnpOUGNFQ3VVRFhXM0pxb0sx?=
 =?utf-8?B?VDZ0U0lpcERGU2VITEd0RmNOVVBQMmNkdTRCOVhMd0wxS3hQd1Jnd3hWTEY0?=
 =?utf-8?B?WElXaHJ1T0tXYVQ5aHFDN0s4OXFrSEorYjRhYUovcy90YXlZWHQ2b0ltVDNS?=
 =?utf-8?B?OTRCaGk0TUdOVUFsNDM3VGUzRG5jOUo1RzhQa0Fkd0w4OGc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QTdxZGFYdTNhQlBoMDNBaHRNWDVTRlNGMzJzZk90R2tmdUwwenp0VThyZzcx?=
 =?utf-8?B?emgxOG1Jc2IwOXRXSkRxeFJJVEFsL0NZNGs4T3gxL3c5V3l0ZkZ2SURKVkx3?=
 =?utf-8?B?KzFhZDRrNGw4a3JRQUNKSVpaTkJickRLTlZHK0tGZFVnRU8yT3lLRk5jNTdY?=
 =?utf-8?B?ZTcxRWdpM0FSMWJQdTVRSGFkVUczMkdETzdCS2oyUnI5cE1GZVJlVDZOdjVU?=
 =?utf-8?B?Mjd0VGQySzJHK25HT3J6QVlEUWpRQXF6Tlh0VDNnaE01SVQ3NDgvMWZvOFo2?=
 =?utf-8?B?WkxENDV2MU1xUWVPUkJubkMvVFlpWnQ1SGI0Si9ST3VDTWNsQXFKSVBEaWlj?=
 =?utf-8?B?SitiM0JhdTdWeFFTTlRVa1ZkTkdwTDZ4c2Y4NDdZY0IrOTZHRmMwMUdNTUhJ?=
 =?utf-8?B?ei9DTm8vNk14MWE5K2NUTEdWN2J2TDFUNEpCRk5kbFZPcHdJQXMwL2pEQ2Z5?=
 =?utf-8?B?YUxvRjVWL1hFOE1qMVlIQWNmOGNMRDNKajB1Rkd3TUF4cm1Xb001OFFTbGx2?=
 =?utf-8?B?WG1xT3RCWmh2aDNpb1QrakVzMEl2STBsVE1QOXBwMTJXUVBOS3lJSnBGbnli?=
 =?utf-8?B?a2ErUlJaYVBodENvZXBIdTQ3akpaUjdQSUloYXh4Q2s5NjR6alhXNjNRSW81?=
 =?utf-8?B?a2h3NTVWLzd2cGJSQ1B5Q1I3anhmSFBWNmFmWU4yRkswUjBjYVBnMHE1YWJZ?=
 =?utf-8?B?YS82dEljbTVqcklrL0hpWHoyMU15enkxNS9NY3N4MXQvaWZpOFpYUitnMG02?=
 =?utf-8?B?bm1adStKdWo4L0JyNGdTS25NRVRoc3B2UUlPOEg0VVJoYWUwTWZvVUdrSzhD?=
 =?utf-8?B?NG53Q2czbnNJN21WTGpBc1huR1ZORkcrTUVHM1JROVBoSEVVL2YrbUprcEx1?=
 =?utf-8?B?ZGt3S09kQWhOZjJmL1IrS3lXVHVhenFrZncxeEQxTXlzZ3h0eFE1M2xBdEJR?=
 =?utf-8?B?R1VkUWcyejdNMkdTYUZ1d2RldVRHQndaaFJ4cE1zMnRkL3YwaE9iVlhNOU00?=
 =?utf-8?B?VnQyVnVnOUNsc3BKZXY2TUNrZVRNaWhML3VFSXpRaVZWRVNwK3J0d2xmYkVT?=
 =?utf-8?B?NFRWeTREdDI1L3NSOGFNanBOSkc4M0V5dDFFMmVZZFAvMlMvQnBIU1A2S1Uw?=
 =?utf-8?B?Mm5IVVRwbXpZYlc4OGVLUis1NFlQQmNlTCtOVDIweWk4dWo2S3lONDlIandw?=
 =?utf-8?B?RHZIcis3ZHRjTUUwSHk4RTU3RlV1blZqc1BRYmxQa0VQdlF3enpjV1NpK3Jv?=
 =?utf-8?B?M1pST3RMalFOWWNxaWpGOWh3M3l3THN4Nk5WTnlTeGJWZ2pNOXhQWGRMVzVo?=
 =?utf-8?B?TTZOb05lL3YyVTNwSGZ5Y3ZDa0dOTXhKNzFxSlo2WitJcXcyVDM5OTdrUGpL?=
 =?utf-8?B?RnQxUDJZc29uOGlmbkZsME84S1hadmxTVDFYYm05bEcyZ3QrQTl6L2JveEpy?=
 =?utf-8?B?TTZLWHhNMnZlaWd5ZmxBa0lJSG9zQ0h1NkJmb1JqK1pvem43VlZjdHZvNUNF?=
 =?utf-8?B?RGl6U0tOZitwbnE1ZkIyMzRUN25zRzhiTHNjNnJ5djUvT0t3K0I0UkxvQ3Jv?=
 =?utf-8?B?ZnByaHNZa2pZKzQ1QW1BK1FsZDFXZDhsOUZOTFZ4OXJwN084czBQWlpYNXRY?=
 =?utf-8?B?cEMrRGVtbXlmTXZJaXhCQlNNZ0pkZ1pUVWFsT3RRNnFTQ0pEOE9kK2VzUzc2?=
 =?utf-8?B?VDVtOXpSdFR4NlhZU1lNTzhSNlNUZ3BObWpZaE83ZWxXMjdDYWx3SU4rOUtG?=
 =?utf-8?B?V25pZ1lKd0hyMHpyUWVIWUlsYXh1MHp1UlhiNHVwMkhsNDZlVFRWbk1ueXFs?=
 =?utf-8?B?ZHZxK09ONms0bDU3aFNNL25yekI1Z1lacG5OWjhGOFBDTFYxRjVyWk1ja1Jl?=
 =?utf-8?B?Q0Raek9QTHUyalR5dU4zbzJLLzlrQmF5YlF2OG5QNFpKamNNbkVjNWNlYUll?=
 =?utf-8?B?ODYxbDlla0RjVVg5d2dMWm9RV25yN1RsdDJ4bTgzV3VMTlBpWXdjMzVVVGhB?=
 =?utf-8?B?QTZlYVYwSnE4ZjduWWJubkgzYitObXM1c1lMRktkRHFveFJyb0ozK1I2Z0wx?=
 =?utf-8?B?dmR4MmhCV3hGNkQ3SzVEaGdQK3FhZFJmeTU3VVllV2dkZkd6QnRLeEZzZjRz?=
 =?utf-8?Q?8FTVAtXiKkpGy/m9LGFmkvaIZ?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6224.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24028de8-c2ed-4fca-a4d8-08dc9eddc6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2024 23:37:34.0207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HauD058Rd6WPkqGT34yACLf/6pdwink1TvGd6GoPmsHtYlplG0hkFWFZcROgPtvNPtjJesI8zqoqSlBLelDOO3U1N/rXowE0HfQv1rDbi6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5387
X-Proofpoint-ORIG-GUID: 9gxCgqdaQwyB56MRIZ_gvwBVB8tj8aDY
X-Proofpoint-GUID: 9gxCgqdaQwyB56MRIZ_gvwBVB8tj8aDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407070196

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGluYWNvLCBNYXJpZWwN
Cj4gU2VudDogTW9uZGF5LCBKdWx5IDgsIDIwMjQgNzozMiBBTQ0KPiBUbzogSm9uYXRoYW4gQ2Ft
ZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBSb2IgSGVycmluZw0K
PiA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwu
b3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTGlhbSBHaXJkd29v
ZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1hcmsgQnJvd24NCj4gPGJyb29uaWVAa2VybmVsLm9y
Zz47IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47DQo+
IE1hcmNlbG8gU2NobWl0dCA8bWFyY2Vsby5zY2htaXR0MUBnbWFpbC5jb20+OyBEaW1pdHJpIEZl
ZHJhdQ0KPiA8ZGltYS5mZWRyYXVAZ21haWwuY29tPjsgR3VlbnRlciBSb2VjayA8bGludXhAcm9l
Y2stdXMubmV0Pg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvMl0gaWlvOiBkYWM6IHN1cHBvcnQg
dGhlIGFkODQ2MCBXYXZlZm9ybSBEQUMNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+
DQo+ID4gU2VudDogU2F0dXJkYXksIEp1bmUgMjksIDIwMjQgMjo1MSBBTQ0KPiA+IFRvOiBUaW5h
Y28sIE1hcmllbCA8TWFyaWVsLlRpbmFjb0BhbmFsb2cuY29tPg0KPiA+IENjOiBsaW51eC1paW9A
dmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4g
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28u
ZGU+OyBSb2INCj4gPiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+Ow0KPiA+IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2Vy
bmVsLm9yZz47IExpYW0gR2lyZHdvb2QNCj4gPiA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1hcmsg
QnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IEhlbm5lcmljaCwNCj4gPiBNaWNoYWVsIDxNaWNo
YWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgTWFyY2VsbyBTY2htaXR0DQo+ID4gPG1hcmNlbG8u
c2NobWl0dDFAZ21haWwuY29tPjsgRGltaXRyaSBGZWRyYXUgPGRpbWEuZmVkcmF1QGdtYWlsLmNv
bT47DQo+ID4gR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi8yXSBpaW86IGRhYzogc3VwcG9ydCB0aGUgYWQ4NDYwIFdhdmVmb3JtIERB
Qw0KPiA+DQo+ID4gW0V4dGVybmFsXQ0KPiA+DQo+ID4gT24gTW9uLCAyNCBKdW4gMjAyNCAwNDo1
Njo1NyArMDAwMA0KPiA+ICJUaW5hY28sIE1hcmllbCIgPE1hcmllbC5UaW5hY29AYW5hbG9nLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
ID4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4gPiA+ID4gU2Vu
dDogU3VuZGF5LCBNYXkgMTIsIDIwMjQgMTI6NDQgQU0NCj4gPiA+ID4gVG86IFRpbmFjbywgTWFy
aWVsIDxNYXJpZWwuVGluYWNvQGFuYWxvZy5jb20+DQo+ID4gPiA+IENjOiBsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPiA+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9v
LmRlPjsgUm9iDQo+ID4gPiA+IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBL
b3psb3dza2kNCj4gPiA+ID4gPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29u
b3IrZHRAa2VybmVsLm9yZz47IExpYW0NCj4gPiA+ID4gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFp
bC5jb20+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+Ow0KPiA+ID4gPiBIZW5uZXJp
Y2gsIE1pY2hhZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBNYXJjZWxvIFNjaG1p
dHQNCj4gPiA+ID4gPG1hcmNlbG8uc2NobWl0dDFAZ21haWwuY29tPjsgRGltaXRyaSBGZWRyYXUN
Cj4gPiA+ID4gPGRpbWEuZmVkcmF1QGdtYWlsLmNvbT47IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJv
ZWNrLXVzLm5ldD4NCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGlpbzogZGFjOiBz
dXBwb3J0IHRoZSBhZDg0NjAgV2F2ZWZvcm0gREFDDQo+ID4gPiA+DQo+ID4gPiA+IFtFeHRlcm5h
bF0NCj4gPiA+ID4NCj4gPiA+ID4gT24gRnJpLCAxMCBNYXkgMjAyNCAxNDo0MDo1MyArMDgwMCBN
YXJpZWwgVGluYWNvDQo+ID4gPiA+IDxNYXJpZWwuVGluYWNvQGFuYWxvZy5jb20+IHdyb3RlOg0K
PiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBBRDg0NjAgaXMgYSDigJxiaXRzIGluLCBwb3dlciBvdXTi
gJ0gaGlnaCB2b2x0YWdlLCBoaWdoLXBvd2VyLA0KPiA+ID4gPiA+IGhpZ2hzcGVlZCBkcml2ZXIg
b3B0aW1pemVkIGZvciBsYXJnZSBvdXRwdXQgY3VycmVudCAodXAgdG8gwrExIEEpDQo+ID4gPiA+
ID4gYW5kIGhpZ2ggc2xldyByYXRlICh1cCB0byDCsTE4MDAgVi/OvHMpIGF0IGhpZ2ggdm9sdGFn
ZSAodXAgdG8gwrE0MA0KPiA+ID4gPiA+IFYpIGludG8gY2FwYWNpdGl2ZSBsb2Fkcy4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEEgZGlnaXRhbCBlbmdpbmUgaW1wbGVtZW50cyB1c2VyLWNvbmZpZ3Vy
YWJsZSBmZWF0dXJlczogbW9kZXMNCj4gPiA+ID4gPiBmb3IgZGlnaXRhbCBpbnB1dCwgcHJvZ3Jh
bW1hYmxlIHN1cHBseSBjdXJyZW50LCBhbmQgZmF1bHQNCj4gPiA+ID4gPiBtb25pdG9yaW5nIGFu
ZCBwcm9ncmFtbWFibGUgcHJvdGVjdGlvbiBzZXR0aW5ncyBmb3Igb3V0cHV0DQo+ID4gPiA+ID4g
Y3VycmVudCwgb3V0cHV0IHZvbHRhZ2UsIGFuZCBqdW5jdGlvbiB0ZW1wZXJhdHVyZS4gVGhlIEFE
ODQ2MA0KPiA+ID4gPiA+IG9wZXJhdGVzIG9uIGhpZ2ggdm9sdGFnZSBkdWFsIHN1cHBsaWVzIHVw
IHRvIMKxNTUgViBhbmQgYSBzaW5nbGUgbG93DQo+IHZvbHRhZ2Ugc3VwcGx5IG9mIDUgVi4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmllbCBUaW5hY28gPE1hcmllbC5U
aW5hY29AYW5hbG9nLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gSSdkIGxpa2UgdG8gc2VlIHNvbWUg
QUJJIGRvY3MgZm9yIHRoZSBkZWJ1Z2ZzIGludGVyZmFjZS4NCj4gPiA+ID4gVGhlIGRldmljZSBp
cyB1bnVzdWFsIGVub3VnaCB0aGF0IGEgZ2VuZXJhbCBpbnRybyBkb2N1bWVudCBvciBhDQo+ID4g
PiA+IGxvdCBtb3JlIGluIHRoZSBzZXJpZXMgY292ZXIgbGV0dGVyIHdvdWxkIGJlIHVzZWZ1bC4N
Cj4gPiA+ID4NCj4gPiA+ID4gSSdtIG5vdCBzdXJlIHdoYXQgdGhlIGRtYWVuZ2luZSB1c2FnZSBp
biBoZXJlIGlzIGRvaW5nIGZvciBleGFtcGxlPw0KPiA+ID4gPiBEcml2aW5nIHRoZSBwYXJhbGxl
bCBidXMgcGVyaGFwcz8gIERhdmlkIHdhcyBjb3JyZWN0IHRoYXQgdGhlDQo+ID4gPiA+IGJpbmRp
bmcgc2hvdWxkIHJlZmxlY3QgdGhhdCBwYXJ0IGFzIHdlbGwuIEkgd2FzIGFzc3VtaW5nIHlvdSdk
DQo+ID4gPiA+IG9ubHkNCj4gPiBpbXBsZW1lbnRlZCB0aGUgc3BpIHBhcnQuDQo+ID4gPiA+DQo+
ID4gPiA+IEhvdyB0byBoYW5kbGUgdGhlIHBhdHRlcm4gZ2VuZXJhdG9yIGlzIGFsc28gYW4gaW50
ZXJlc3RpbmcgcXVlc3Rpb24uDQo+ID4gPiA+IFRoYXQgcHJvYmFibHkgd2FudHMgYSB2ZXJzaW9u
IG9mIHRoZSBzeW1ib2wgaW50ZXJmYWNlcyB3ZSB1c2UgZm9yDQo+ID4gPiA+IFBTSyBhbmQgc2lt
aWxhci4gIFdlIGRpZCBoYXZlIHNvbWUgRERTIGRyaXZlcnMgYSBsb25nIHRpbWUgYmFjayBpbg0K
PiA+ID4gPiBzdGFnaW5nIGJ1dCB0aGV5IG9ubHkgZGlkIGEgZmV3IGZpeGVkIHdhdmVmb3JtcyBz
byB0aGlzIGlzDQo+ID4gPiA+IGJyZWFraW5nIG5ldw0KPiA+IGdyb3VuZC4NCj4gPiA+DQo+ID4g
PiBJIGFsc28gdGhvdWdodCBhYm91dCBob3cgc2hvdWxkIHRoZSBwYXR0ZXJuIGdlbmVyYXRvciBi
ZSBoYW5kbGVkLiBJTg0KPiA+ID4gdGhlIGxhc3QgcmV2aXNpb24sIHRoZXJlIHdlcmUgdHdvIGRl
YnVnIGF0dHJpYnV0ZXMgdGhhdCBtYWtlIHVwIHRoaXMNCj4gPiA+IGZlYXR1cmUuIFBhdHRlcm4g
ZGVwdGggYW5kIHBhdHRlcm4gbWVtb3J5LiBVbHRpbWF0ZWx5IEkgZm91bmQgYSB3YXkNCj4gPiA+
IHRvIGNvbWJpbmUgdGhlc2UgdHdvIGF0dHJpYnV0ZXMgaW50byBvbmUgY2FsbGVkICJ0ZXN0X3Bh
dHRlcm4iLiBUaGUNCj4gPiA+IGF0dHJpYnV0ZSBpcyBhIHN0cmluZyBjb250YWluaW5nIGFuIGFy
cmF5IG9mIHZhbHVlcyB3aXRoIGEgbWF4aW11bQ0KPiA+ID4gb2YNCj4gPiA+IDE2IGRhdGEgd29y
ZHMsIHdoaWNoIHRoZSBEQUMgd2lsbCBjeWNsZSB0aHJvdWdoIHRvIGdlbmVyYXRlIGEgcGF0dGVy
bi4NCj4gPiA+IFRoZSBudW1iZXIgb2YgdmFsdWVzIHdpdGhpbiB0aGUgc3RyaW5nIGNhbiBiZSBh
bnl3aGVyZSBiZXR3ZWVuIDEgdG8NCj4gPiA+IDE2IGFuZA0KPiA+IGhhdmUgYSBzcGFjZSBpbiBi
ZXR3ZWVuLiBJIGFsc28gYWRkZWQgYSAidGVzdF9wYXR0ZXJuX2VuYWJsZSINCj4gPiA+IGRlYnVn
IGF0dHJpYnV0ZS4gRm9yIHRoZSBBQkkgZmlsZSwgc2hvdWxkIEkgY3JlYXRlIG9uZSBhbG9uZ3Np
ZGUNCj4gPiA+IG90aGVyICJkZWJ1Z2ZzLQ0KPiA+ICoiDQo+ID4gPiBmaWxlcyBhbmQganVzdCBt
ZW50aW9uIHRoZSBuYW1lIG9mIHRoZSBwYXJ0PyBlLmcuICJkZWJ1Z2ZzLWRyaXZlci1hZDg0NjAi
DQo+ID4NCj4gPiBEb2luZyB0aGlzIGluIGRlYnVnZnMgYmFzaWNhbGx5IG1lYW5zIHlvdSBhcmVu
J3QgaW50ZW5kaW5nIGl0IHRvIGdldA0KPiA+IHVzZWQgaW4gcmVhbCB1c2VjYXNlcy4gIFNvIHdl
IG5lZWQgc29tZSBzeXNmcyBBQkkuDQo+ID4NCj4gPiBUaGF0IHByb2JhYmx5IG1lYW5zIGEgbW9k
ZSBzd2l0Y2ggc2ltaWxhciB0byB0aGUgb25lcyB3ZSBoYXZlIGZvcg0KPiA+IGRldmljZXMgdGhh
dCB1c2UgYW4gZXh0ZXJuYWwgdG9nZ2xlICh0eXBpY2FsbHkgZm9yIEZyZXF1ZW5jeSBTaGlmdA0K
PiA+IEtleWluZyBvciBzaW1pbGFyIG9yIHNvbWV0aW1lcyBqdXN0IHRvIGZsaXAgYmV0d2VlbiB0
d28gREMgdm9sdGFnZXMpLg0KPiA+IFdlIG5lZWQgYSBuZXcgdGVybSB0aG91Z2ggYXMgdGhpcyBp
c24ndCBhIHRvZ2dsZS4NCj4gPg0KPiA+IEZvciB0aGUgdmFsdWVzIHdlIGNvdWxkIG1hcCBpdCB0
byB0aGF0IGludGVyZmFjZSB3aGljaCBpcyBzb21ldGhpbmcNCj4gPiBsaWtlDQo+ID4NCj4gPiBv
dXRfdm9sdGFnZTBfcmF3MA0KPiA+IG91dF92b2x0YWdlMF9yYXcxDQo+ID4NCj4gPiBldGMuICBU
aGF0IGF2b2lkcyBuZWVkIGZvciBhIG5ldyBBQkkgZm9yIHRoZSB2YWx1ZXMsIGJ1dCBwZXJoYXBz
IGlzbid0DQo+ID4gdGhhdCBlbGVnYW50IGlmIHRoZSBwYXR0ZXJucyBvbiBvdGhlciBkZXZpY2Vz
IHdlIGV2ZW50dWFsbHkgc3VwcG9ydCB0aGlzIG9uIGdldA0KPiBsYXJnZS4NCj4gDQo+IEkgc2F3
IHNvbWUgZHJpdmVycyBtYWtpbmcgdXNlIG9mICJ0ZXN0X3BhdHRlcm4iIGF0dHJpYnV0ZS4gSSB0
aGluayB0aGF0IG1pZ2h0IGZpdC4NCj4gQnV0IEknZCBsb29rIGludG8gInJhdzAiIGFuZCAicmF3
MSIgYXMgd2VsbA0KDQpJJ20gc29ycnkgYWJvdXQgbWVudGlvbmluZyAidGVzdF9wYXR0ZXJuIiBh
Z2Fpbi4gSSBmb3Jnb3QgSSBhbHJlYWR5IG1lbnRpb25lZCBpdCBpbg0KQW4gZWFybGllciByZXBs
eQ0KDQo+IA0KPiA+DQo+ID4gQW55b25lIGtub3cgaG93IGxhcmdlIHRoZXNlIHR5cGljYWxseSBn
ZXQ/IEknbSBiZWluZyBsYXp5IGFuZCBkb24ndA0KPiA+IHdhbnQgdG8gZGF0YXNoZWV0IGRpdmUg
dGhpcyBldmVuaW5nIQ0KPiANCj4gSXQgb25seSBnZXRzIHVwIHRvIDE2IHZhbHVlcy4NCj4gDQo+
ID4NCj4gPiBKb25hdGhhbg0KDQo=

