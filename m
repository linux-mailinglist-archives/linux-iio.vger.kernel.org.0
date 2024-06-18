Return-Path: <linux-iio+bounces-6467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A0D90C977
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFFA1F2123B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E04144D2A;
	Tue, 18 Jun 2024 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="egdCB+HI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B901304A3;
	Tue, 18 Jun 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706780; cv=fail; b=W42p7n2dVLb5IUfhtxsjMo9kbHzMNm5n/CI/JE2uQsyze2NNXPJFy1tO9zGC/yQGCDxNzxSlkh4UUv8VVx7b0oZetAaDWvNbdf1Jkix3yPsWyZK3lHl6pujX4gW+SJBh4XGeYTFL3twl9bHX8FHQwZE/pcwFDW68ChAlo9gB7/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706780; c=relaxed/simple;
	bh=U5OlFlxAMvKrgZB35caZoLLv8k47QZhsedg7OZJWKa0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ByAgGuusaRy0JLhfLNoDacl++BxDkMaHs4xa0+1gKG3Pdx+VdjmwOFyY3o9we0rTVMdgZ8DA5lbIMjWwqeBG+pEBlrg4fhrSpwz73NLdg69BhllYm8TP23M0Du+V9lqqBsnkSSbm5tFkiGjTqvFmrIsokp9x4XZpddDfG4INq/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=egdCB+HI; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7AQZ5001624;
	Tue, 18 Jun 2024 06:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=U5OlF
	lxAMvKrgZB35caZoLLv8k47QZhsedg7OZJWKa0=; b=egdCB+HIFe51Veq7+I1sN
	kAtNWISDK6q5axq3fIW5wkUlVaowMPE/qGyEFM6XRsj6RHBJAUtcPiJ3U7yL2QTe
	2QQGddlpE3T2Q9c6VYGFQb1rMrQ9zicFT+ZrzZmFT/wJKfRNfDPd0HHko/bI5RSU
	R7TUTyv2t55NTJwfdsAFOrIJgL7wpcDF3c1V015Hrl8B7m3pI6JU/yr9rKb7CA4M
	WInexiz+X1AUtE0oXCw+S5BUGa0/EI0Qj8QUsvKmzHUdtKrGPIt2tOev0keCle19
	RK83w2upLC7NpcRSPfJhHC+6glVsVV8WGL4B3B/VLpb//GzN0d8+nHNAVBRvTIhy
	g==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yu02qhwsu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 06:32:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1XnPavfP4G93asfoEzrF+FnNqhKBG/yeUGodZE5AAp9XeKgmEsZs2kivgr2Dn+DiR3ni7UJNrFxDnP9fZcV6+yEt+vc3lESL3xV/YTPnf6ydbUI2Hkm/5vIVwWzsnFYmLFAEWky+2Dr41Z0TMgnsAADQBnmvxj4d+KafviFdveWUcyfZu/pr3txcnD9T7dq1VwitH9b6ZZLHQjrPq6bQkMttEfyfQBQhe3bbpI3apG7QykP9Qn0cboxX1m39F+F00grzoTnGKT646WQg+i/NrCdhKaJxlu3mNVCVCCacOBhSzPnIVBm8sn0L4hyVEG005tyZ5g/oIcJhbPuHMdOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5OlFlxAMvKrgZB35caZoLLv8k47QZhsedg7OZJWKa0=;
 b=ZJ1nj1XL1budOgHgvHGwFvM1QWPgcLV9gZLPJcLTBamcOAXStD1T+Nr844S3Z4aXnsnHC8G7cUpwHmvWYgNY9DQSrVi6mmnNNV0wGU4lFxyJxCTPvQKiDJUQWbG5YWhNN41PyOHMIMhrDMblaf2Rosl7gd/4HbW9Bz0YbIYcss6DOCCBaAIarI6o6GCkfKhyITsH1oPPJCnid+8RchKhad+6Z455uqMU4mH/31LJkOpgVKDmUccwv1Gl1Zc2B5T0dVerUtvGTtmI3GU3XluUplZdJr6W3MU5Akdwv2G7K63PrIn4ctUEyY0HQw/lb+1jwmfHg+GGMN+StBnvYetWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SA1PR03MB6321.namprd03.prod.outlook.com (2603:10b6:806:1b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 10:32:32 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 10:32:32 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri
 Fedrau <dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v3 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Thread-Topic: [PATCH v3 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Thread-Index: AQHatVSYiawUUvGO7Uuq7Pr8wl80WbG2grCAgBbkJlA=
Date: Tue, 18 Jun 2024 10:32:32 +0000
Message-ID: 
 <PH0PR03MB714164FC9335DFBC003E4F57F9CE2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
 <20240603012200.16589-6-kimseer.paller@analog.com>
 <408aa030-23df-418d-a04d-a5551119624b@baylibre.com>
In-Reply-To: <408aa030-23df-418d-a04d-a5551119624b@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB4TURNek9Ea3lNUzB5WkRWbExURXhaV1l0WVdGbU5TMW1PR1Uw?=
 =?utf-8?B?TTJJek0yUTJObVZjWVcxbExYUmxjM1JjTVRBek16ZzVNak10TW1RMVpTMHhN?=
 =?utf-8?B?V1ZtTFdGaFpqVXRaamhsTkROaU16TmtOalpsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhPVGN5TmlJZ2REMGlNVE16TmpNeE9EQXpOVEF6T1RJMU5UUXlJaUJvUFNK?=
 =?utf-8?B?TFNHMUxaMmcxY0V4MlpqRkVTV05uYjBkcFJuZGtUMkl5YlRnOUlpQnBaRDBp?=
 =?utf-8?B?SWlCaWJEMGlNQ0lnWW04OUlqRWlJR05wUFNKalFVRkJRVVZTU0ZVeFVsTlNW?=
 =?utf-8?B?VVpPUTJkVlFVRkZiME5CUVVGdE1sbDJVMkZ6U0dGQlpWWnlaSEYzYVZoRmRW?=
 =?utf-8?B?bzFWM1F5Y2tOS1kxTTFhMFJCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJTRUZCUVVGRVlVRlJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlJVRkJVVUZDUVVGQlFUTk1hRk5tWjBGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VW8wUVVGQlFtaEJSMUZCWVZGQ1prRklUVUZhVVVKcVFVaFZRV05uUW14QlJq?=
 =?utf-8?B?aEJZMEZDZVVGSE9FRmhaMEpzUVVkTlFXUkJRbnBCUmpoQldtZENhRUZIZDBG?=
 =?utf-8?B?amQwSnNRVVk0UVZwblFuWkJTRTFCWVZGQ01FRkhhMEZrWjBKc1FVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFXZEJRVUZCUVVGdVowRkJRVWRGUVZwQlFuQkJSamhCWTNkQ2JFRkhUVUZr?=
 =?utf-8?B?VVVKNVFVZFZRVmgzUW5kQlNFbEJZbmRDY1VGSFZVRlpkMEl3UVVoTlFWaDNR?=
 =?utf-8?B?akJCUjJ0QldsRkNlVUZFUlVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJV?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVU5CUVVGQlFVRkRaVUZCUVVGWlVVSnJRVWRyUVZoM1Fu?=
 =?utf-8?B?cEJSMVZCV1hkQ01VRklTVUZhVVVKbVFVaEJRV05uUW5aQlIyOUJXbEZDYWtG?=
 =?utf-8?B?SVVVRmpkMEptUVVoUlFXRlJRbXhCU0VsQlRXZEJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUWtGQlFVRkJRVUZCUVVGSlFVRkJRVUZCUVQwOUlpOCtQQzl0?=
 =?utf-8?B?WlhSaFBnPT0=?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SA1PR03MB6321:EE_
x-ms-office365-filtering-correlation-id: 66bae49c-7d89-4379-7be9-08dc8f81f613
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|366013|1800799021|7416011|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?KzJlUkR3c2Q4aUtFbzdvV3VTTldmZ2x1RzNWYmxBZnkya2duK1VSSEMzbnFF?=
 =?utf-8?B?SWtCSEhTalRBcEw5TkdER3pqb080K2kzSmJCVWQvVDdOaTlORUpZNWl5SEM3?=
 =?utf-8?B?OHdxNHh1YVpEbDdNQm5oQXovTTcyeEN2OUlJV3duSEl0VW5td3JWTVoyTDcr?=
 =?utf-8?B?bWV4cUk2NzVyRm5Pc2oyak92OGxmYmF2aWpoQ3dJa2VvVk1vcVc5Snczblpl?=
 =?utf-8?B?bFoyMmd2ejFMYitpN1RzTGNaRkxiU29HVlhndFdlbGVRM01JcS8xeTR0Q1cw?=
 =?utf-8?B?NUVoSjdlK01YME5LcGI0VnlwZ1BmOHpheENPRUk1SlVSNm56MlQvOGlkQUQz?=
 =?utf-8?B?RE1oNnIxUnQzYzNmV29vaFpKVkhVMnNSNXRoQ2NnTlQrNy94Skh0YlZuQjFq?=
 =?utf-8?B?dVhReHRyQnp3ZjRKM0d3K3NIR1NKWktSK2JHeE42eHZuc1BkTHpGUU81VHFn?=
 =?utf-8?B?VllSQmxCSGxzampVR1FQWGpJSDhXNHRyWFNDVVRqb2xLLzBKanVEVTZjWlBD?=
 =?utf-8?B?STlmQmcwTTVRdDlHVTAxQjFNU25UdEk0bXZSVUlMc3ZXR25ZZjBvSHNYWlJV?=
 =?utf-8?B?QUFYNnJoQjhibmM1eVJPNTBmdEp1aTVKcFYxUmIrTHp4UU5oRXBwQjViS2oy?=
 =?utf-8?B?aUtHZE9OVmNuMzZFSWtBNnIvaUtBU21sOTRobE5QZUlFT1NaNmFMRDcwUFJQ?=
 =?utf-8?B?bkwvMU1WL3pyOEF2OHF0dmtHdGg4bERDeC9VTld0VU9PM1B6WnFSMWIrWlA2?=
 =?utf-8?B?MTczS2o5b1Z3WmMwTDhzTU51a0x4dUVnMVlxZzBydlBQcDJQMmpVVnJlQ1JF?=
 =?utf-8?B?OVVEZ29oVEhMNmttdi9DbHJFTlRobVNrUDY3SXA5OTdtNXNYbXQrOU9wQXFj?=
 =?utf-8?B?c0lGVTI2blgyYzhwd1h3Y2l1QXdQM2t0ZGZDbllYaDZLYmFXR051NFIxbmwx?=
 =?utf-8?B?V2NnSTBUeDR4NVFGVHc2KzB5RVg1dTVWUEc2RW1SRGlmZGRGRjlTamdZNDFk?=
 =?utf-8?B?OWRZOUFad2xUanB2NHMvNGhmOEJWRW1jWHU3MHN1NlhZNU5nUmg0M041Vnl1?=
 =?utf-8?B?RkZpMVEvbVp5bnNrd1BLWWJHMXc4OFVkeDl6VHJKUk5pWk1OZHVuZGI2Smg0?=
 =?utf-8?B?UitGQk00TDEyVGZnRWxWRC93cUNHWlErcmNBL1RLa285YXNqdmszMUttWUNF?=
 =?utf-8?B?QkRkQ3RCWWExaU5qUnpFZ1E1WGEzR2wrb2V4MmVFb0pmcEhYQUJKOXlvYjN1?=
 =?utf-8?B?VkZkZzRTdzNwQnY1Z2VNbkE5Z2FCdFVSZU1LNkxFL2xGS2hTUUZqeGorRDlp?=
 =?utf-8?B?OFAwZTg5SE9UeUh3K2NnNkExTVpINnFzTllGSDVsWU43ODBNek5mYmMwTEVM?=
 =?utf-8?B?OVYrTHpqY1R1QzM4NFNKa0xRc1FBVUFxYTRVUmdydGovZHJsbFhBaktBMmxr?=
 =?utf-8?B?VUdBMHdhV3JTTitvalpwTC9WY0JFRisxWkRwYXlqV3pQTU5sNFJ1cHFraDBz?=
 =?utf-8?B?MENYYTB2NVZleVFwUms4dUg5MHpTeENnaGhCcmtnZzY2KzAxdFRyYXJtQm9V?=
 =?utf-8?B?OVhpMWU4WkIwZDVUUDRKNzBqbERvZnozZFVoTHdzQzlMVFBuSDBkZUdxeElD?=
 =?utf-8?B?UWFkMWNteFIvb0RqQXRYN05BLzNpelZINmVVR01Ya2dlSVNOUVNwaEdUUW5K?=
 =?utf-8?B?a1pDU0NDQnUxK1dQenJPTUtNcVBKZFBhdjJQbHh4WmhxWmhVWHhGaEU1Rm81?=
 =?utf-8?Q?PCoiWcFpzYjvM1K0uO96WxfYfMeZa2O8nIS8Jc4?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WkFBbVdSWmE3V3IvZ3FtR09YWVhWM1F5VGVISVhvV3R1NFBSQkMzN0NqNUJQ?=
 =?utf-8?B?Z290V1E3VUpzY1o2a0g1a21LS3VlR2QvY3Z2M3JyK0xmM2I2cEZqdjZZZlB6?=
 =?utf-8?B?NlpuSytTRnpWVFhDNTNLMmJUc1loWFc4R1BIcmJlSXlFdSt4Mnk4cDlCV015?=
 =?utf-8?B?Z3VaMjJJZVhUZWdZNTNnQ0NveFdpRDlCa0h3WjNPTzZielFyK0l0RnRGOUFT?=
 =?utf-8?B?QktnNlVpMmdlNFpaSG40UWdjSmdLS1dUMWNTMU5SUitpVzVNaHVyYm5pelU5?=
 =?utf-8?B?RkJ3SVhqNkozUjI1Wi9tcWZ4UjFJUnQ2WTR3aWdtSmYxK2gxYy9rdDdDSThT?=
 =?utf-8?B?cWhJRkdua2c2ekN2MEpTYTYySGNRVFpodE1rM3NSWmxXay82MWptd3hHM0Ev?=
 =?utf-8?B?VDUxeHcwcDBnaUVrczhuRlJvZHhpWUY1QnNvdS82ZVc4b0dYY3ZrdHI3TXBr?=
 =?utf-8?B?TGJzQ3VkQWlZMUkvemJic0Z5L3l0ckZoWktYdWl4OXE1RDM5ZzIvZlUvYWF4?=
 =?utf-8?B?WDNMd0ZCRDRKcVludUh0dlhBYi9pMGZLbnZIZXlxb3k0MEZoWWxScjNPVVNY?=
 =?utf-8?B?WWJLQWxrQVVrZmdkYnQyenlnRjF3SWlnZnVtbkwvS2lHWlRXd0RleFJHWXly?=
 =?utf-8?B?cDlHTzcwaUNWR0k0WmJVUEcrbWU0b1o0elZiR1VIN3IxUkRoYVN2R0x2QjJu?=
 =?utf-8?B?M2M0aG5ieWcxV0N6MnFJRnpPclgvc29YSmM3WlRhNWpQcjFxM09waUszbUFx?=
 =?utf-8?B?ZFJ2dTBNbkhIWHkrRXlGMjNJSWUzWlJZYXFpdlgzaVhLTWlxemF3TzI5VFZP?=
 =?utf-8?B?ZHQ0eUZjVkV0K2lSZWVYbnRVRW15YTFRaWF3OG05TU9LQVFjRlQxUHdLL21s?=
 =?utf-8?B?b1pPRjkvSzlsaTlZcXkybGdsNFFEcTFMc0VaSE5Ka3BWclFIWCsvaExLR2Nl?=
 =?utf-8?B?dFpSbVlPRXlDSnQzTnFBN1BBZGNUcDc1NjFlT3hJVEJpSUNWTEJ3dDVJenA3?=
 =?utf-8?B?T2xVRnVDS3NETTQ3TTNZQXlNTHNhQVQxV21BUk43bFhScXdwaXc3blQrNWRF?=
 =?utf-8?B?dVlYTzR5WXVoUDBYTVZSNXJwc0tFbWIzNDUxd1RLajlZMy8rc3BQU1B0QWlt?=
 =?utf-8?B?anVHR1hnVlRWRTIrdGR6SXVnWlgvbDg5V3A4Uno1V3FKVXgxM1ZxSDRHVDg4?=
 =?utf-8?B?N1VtdkUzL0ZZOXFnVHQ4VjdVcEJrWWozV1hucFo0KzFNcGlLMHNEOTZOc2sr?=
 =?utf-8?B?MnRvL2lNdFVvV1JKKzNCUis0bGpnTjdOcTNZc3RrbFFUbmExZlQ5Sm5aY3c1?=
 =?utf-8?B?elQ4cUN1N0lmbFgvcE5ZS2tlTVp6UDllNlJRdjg3ZFZEUkc5T05Uc2xpaXRa?=
 =?utf-8?B?N2JWdGpLNDlsMkJEVmpPTkR4RXZOcEF0RlFpeTZpaE1nN0EydDZ6akNTQ0Zo?=
 =?utf-8?B?NmFxb2hYMmJGdTZjcGxoemppSFRka2R6Mlp1K25jR2JWK0FCdWoyR1pqb25T?=
 =?utf-8?B?VFBHYWN3SE5SWWVEV3V2ZXplT0dEankxODJaQ0k3TXRzcHpibVJQWktKZG4y?=
 =?utf-8?B?RHZLTUZKcFd3azNvb1FkZEpocVZNeUFpc0JVRk93Q1dreGxoZ0Q2MzlQVjZS?=
 =?utf-8?B?RlFacGtFUW5OdGJZNnMrWUdEN0YxMWYvZUpYRC9yeHJtQ3pMMTN3Ykt1aThv?=
 =?utf-8?B?bEp6azJaaE5NNGo4QndIR0ZTRDd5bldyNEpXN1lNT29HV1hYVU9WTHRmZStn?=
 =?utf-8?B?MDg5Nms1aWJBU2lscWJJenlyY01UVnJ2ZjhNd2RFaUNCRVdzTzhXWEVyeVZP?=
 =?utf-8?B?YVlDdUlCTHdYRlBrckJxaXlrSEVLZTJRT0JKdnczL2N1ZHJGTFkwVkpGNlov?=
 =?utf-8?B?anJGbnZTT25VUmlXb1hLUHhtcmVyVzJVOTI1UjdTTzJkL0xRU0duSXNCRjl2?=
 =?utf-8?B?S2tPZEg2S29GdWtXWG91bEZKbjNwSllZR0YzOXhXME1oNlpOVUhoajV5dGRr?=
 =?utf-8?B?czVicitacWdvMHJIRUZac3ZyTHFNbE8zdTBXaStqd3RQTUtlWlMrVjQ1RDBB?=
 =?utf-8?B?NW5xeUt1YjRMajV4OFBXR3FSWTJnOWxpU0t2dHdOeGh2YkluRGxJRTJDTnZE?=
 =?utf-8?B?WHIxMm5VaUpsbkVjOEhNWmlpb1dYNmNnR2lCck92U28yTTNvRHlYakVCM0RM?=
 =?utf-8?B?VVE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bae49c-7d89-4379-7be9-08dc8f81f613
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 10:32:32.1597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CV1CdW3IQf+C2Lg1WWrCtvmq0Hw00d5mGWWaOXmIo1ZOIyK+wGejvNtVyNjkF6ZA7EQ2386SyYObVc5bgioEF2sE7zT5XIHpItpdt2sUp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6321
X-Proofpoint-ORIG-GUID: JSs91KkuVKP9wIkDEZN8NqdZGBam-nlH
X-Proofpoint-GUID: JSs91KkuVKP9wIkDEZN8NqdZGBam-nlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180077

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDQsIDIwMjQgNDo0
MyBBTQ0KPiBUbzogUGFsbGVyLCBLaW0gU2VlciA8S2ltU2Vlci5QYWxsZXJAYW5hbG9nLmNvbT47
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8
amljMjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRl
PjsgTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1hcmsgQnJvd24NCj4gPGJy
b29uaWVAa2VybmVsLm9yZz47IERpbWl0cmkgRmVkcmF1IDxkaW1hLmZlZHJhdUBnbWFpbC5jb20+
OyBLcnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPjsgQ29ub3INCj4gRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3Jn
PjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsg
TnVubyBTw6EgPG5vbmFtZS5udW5vQGdtYWlsLmNvbT47DQo+IGtlcm5lbCB0ZXN0IHJvYm90IDxs
a3BAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDUvNV0gaWlvOiBkYWM6IGx0
YzI2NjQ6IEFkZCBkcml2ZXIgZm9yIExUQzI2NjQgYW5kDQo+IExUQzI2NzINCj4gDQo+IFtFeHRl
cm5hbF0NCj4gDQo+IE9uIDYvMi8yNCA4OjIyIFBNLCBLaW0gU2VlciBQYWxsZXIgd3JvdGU6DQo+
ID4gTFRDMjY2NCA0IGNoYW5uZWwsIDE2IGJpdCBWb2x0YWdlIE91dHB1dCBTb2Z0U3BhbiBEQUMN
Cj4gPiBMVEMyNjcyIDUgY2hhbm5lbCwgMTYgYml0IEN1cnJlbnQgT3V0cHV0IFNvZnRzcGFuIERB
Qw0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29t
Pg0KPiA+IENsb3NlczogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL29lLWtidWlsZC0NCj4gYWxsLzIwMjQwNTI0MTE0MS5rWWN4clNlbS0NCj4gbGtw
QGludGVsLmNvbS9fXzshIUEzTmk4Q1MweTJZITY1TVBTWUt5cUZpempzX3RTeHBBQmw0NUJOS3FX
dXR4NE5PQmkNCj4gRWttbW1ZOGtKa3dlcC0yN09OMnJxbmUtWG5VSWQyTTNLc3FnR2JReTdHSV9h
WWk5VGckDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBNaWNoYWVsIEhlbm5lcmljaCA8bWljaGFlbC5o
ZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEhlbm5lcmlj
aCA8bWljaGFlbC5oZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLaW0g
U2VlciBQYWxsZXIgPGtpbXNlZXIucGFsbGVyQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gIE1B
SU5UQUlORVJTICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2lpby9kYWMvS2Nv
bmZpZyAgIHwgIDExICsNCj4gPiAgZHJpdmVycy9paW8vZGFjL01ha2VmaWxlICB8ICAgMSArDQo+
ID4gIGRyaXZlcnMvaWlvL2RhYy9sdGMyNjY0LmMgfCA4MDYgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA4MTkgaW5zZXJ0aW9ucygr
KQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9paW8vZGFjL2x0YzI2NjQuYw0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gPiBpbmRleCBh
YzFlMjllMjZmMzEuLjEyNjJlMTIzMTkyMyAxMDA2NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0K
PiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTEzMDcxLDYgKzEzMDcxLDcgQEAgUzoJU3Vw
cG9ydGVkDQo+ID4gIFc6CWh0dHBzOi8vZXouYW5hbG9nLmNvbS9saW51eC1zb2Z0d2FyZS1kcml2
ZXJzDQo+ID4gIEY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2Fk
aSxsdGMyNjY0LnlhbWwNCj4gPiAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lpby9kYWMvYWRpLGx0YzI2NzIueWFtbA0KPiA+ICtGOglkcml2ZXJzL2lpby9kYWMvbHRjMjY2
NC5jDQo+ID4NCj4gPiAgTFRDMjY4OCBJSU8gREFDIERSSVZFUg0KPiA+ICBNOglOdW5vIFPDoSA8
bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9kYWMvS2Nv
bmZpZyBiL2RyaXZlcnMvaWlvL2RhYy9LY29uZmlnDQo+ID4gaW5kZXggM2MyYmY2MjBmMDBmLi4z
ZDA2NWMxNTc2MDUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vZGFjL0tjb25maWcNCj4g
PiArKysgYi9kcml2ZXJzL2lpby9kYWMvS2NvbmZpZw0KPiA+IEBAIC0zNzAsNiArMzcwLDE3IEBA
IGNvbmZpZyBMVEMyNjMyDQo+ID4gIAkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1
bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KPiA+ICAJICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgbHRj
MjYzMi4NCj4gPg0KPiA+ICtjb25maWcgTFRDMjY2NA0KPiA+ICsJdHJpc3RhdGUgIkFuYWxvZyBE
ZXZpY2VzIExUQzI2NjQgYW5kIExUQzI2NzIgREFDIFNQSSBkcml2ZXIiDQo+ID4gKwlkZXBlbmRz
IG9uIFNQSQ0KPiA+ICsJc2VsZWN0IFJFR01BUA0KPiA+ICsJaGVscA0KPiA+ICsJICBTYXkgeWVz
IGhlcmUgdG8gYnVpbGQgc3VwcG9ydCBmb3IgQW5hbG9nIERldmljZXMNCj4gPiArCSAgTFRDMjY2
NCBhbmQgTFRDMjY3MiBjb252ZXJ0ZXJzIChEQUMpLg0KPiA+ICsNCj4gPiArCSAgVG8gY29tcGls
ZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlDQo+ID4gKwkgIG1v
ZHVsZSB3aWxsIGJlIGNhbGxlZCBsdGMyNjY0Lg0KPiA+ICsNCj4gPiAgY29uZmlnIE02MjMzMg0K
PiA+ICAJdHJpc3RhdGUgIk1pdHN1YmlzaGkgTTYyMzMyIERBQyBkcml2ZXIiDQo+ID4gIAlkZXBl
bmRzIG9uIEkyQw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9kYWMvTWFrZWZpbGUgYi9k
cml2ZXJzL2lpby9kYWMvTWFrZWZpbGUNCj4gPiBpbmRleCA4NDMyYTgxYTE5ZGMuLjJjZjE0OGYx
NjMwNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9kYWMvTWFrZWZpbGUNCj4gPiArKysg
Yi9kcml2ZXJzL2lpby9kYWMvTWFrZWZpbGUNCj4gPiBAQCAtMzcsNiArMzcsNyBAQCBvYmotJChD
T05GSUdfRFM0NDI0KSArPSBkczQ0MjQubw0KPiA+ICBvYmotJChDT05GSUdfTFBDMThYWF9EQUMp
ICs9IGxwYzE4eHhfZGFjLm8NCj4gPiAgb2JqLSQoQ09ORklHX0xUQzE2NjApICs9IGx0YzE2NjAu
bw0KPiA+ICBvYmotJChDT05GSUdfTFRDMjYzMikgKz0gbHRjMjYzMi5vDQo+ID4gK29iai0kKENP
TkZJR19MVEMyNjY0KSArPSBsdGMyNjY0Lm8NCj4gPiAgb2JqLSQoQ09ORklHX0xUQzI2ODgpICs9
IGx0YzI2ODgubw0KPiA+ICBvYmotJChDT05GSUdfTTYyMzMyKSArPSBtNjIzMzIubw0KPiA+ICBv
YmotJChDT05GSUdfTUFYNTE3KSArPSBtYXg1MTcubw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9kYWMvbHRjMjY2NC5jIGIvZHJpdmVycy9paW8vZGFjL2x0YzI2NjQuYw0KPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5lZjVkN2Q2ZmVjNWENCj4g
PiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9paW8vZGFjL2x0YzI2NjQuYw0KPiA+
IEBAIC0wLDAgKzEsODA2IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wDQo+ID4gKy8qDQo+ID4gKyAqIExUQzI2NjQgNCBjaGFubmVsLCAxNiBiaXQgVm9sdGFnZSBP
dXRwdXQgU29mdFNwYW4gREFDIGRyaXZlcg0KPiA+ICsgKiBMVEMyNjcyIDUgY2hhbm5lbCwgMTYg
Yml0IEN1cnJlbnQgT3V0cHV0IFNvZnRzcGFuIERBQyBkcml2ZXINCj4gPiArICoNCj4gPiArICog
Q29weXJpZ2h0IDIwMjQgQW5hbG9nIERldmljZXMgSW5jLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvY2xlYW51
cC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9ncGlvL2NvbnN1bWVyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9paW8vaWlvLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5o
Pg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxlLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9tdXRleC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcHJvcGVydHkuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVndWxhdG9y
L2NvbnN1bWVyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zcGkvc3BpLmg+DQo+ID4gKw0KPiA+
ICsjZGVmaW5lIExUQzI2NjRfQ01EX1dSSVRFX04obikJCSgweDAwICsgKG4pKQ0KPiA+ICsjZGVm
aW5lIExUQzI2NjRfQ01EX1VQREFURV9OKG4pCQkoMHgxMCArIChuKSkNCj4gPiArI2RlZmluZSBM
VEMyNjY0X0NNRF9XUklURV9OX1VQREFURV9BTEwJMHgyMA0KPiA+ICsjZGVmaW5lIExUQzI2NjRf
Q01EX1dSSVRFX05fVVBEQVRFX04obikJKDB4MzAgKyAobikpDQo+ID4gKyNkZWZpbmUgTFRDMjY2
NF9DTURfUE9XRVJfRE9XTl9OKG4pCSgweDQwICsgKG4pKQ0KPiA+ICsjZGVmaW5lIExUQzI2NjRf
Q01EX1BPV0VSX0RPV05fQUxMCTB4NTANCj4gPiArI2RlZmluZSBMVEMyNjY0X0NNRF9TUEFOX04o
bikJCSgweDYwICsgKG4pKQ0KPiA+ICsjZGVmaW5lIExUQzI2NjRfQ01EX0NPTkZJRwkJMHg3MA0K
PiA+ICsjZGVmaW5lIExUQzI2NjRfQ01EX01VWAkJCTB4QjANCj4gPiArI2RlZmluZSBMVEMyNjY0
X0NNRF9UT0dHTEVfU0VMCQkweEMwDQo+ID4gKyNkZWZpbmUgTFRDMjY2NF9DTURfR0xPQkFMX1RP
R0dMRQkweEQwDQo+ID4gKyNkZWZpbmUgTFRDMjY2NF9DTURfTk9fT1BFUkFUSU9OCTB4RjANCj4g
PiArI2RlZmluZSBMVEMyNjY0X1JFRl9ESVNBQkxFCQkweDAwMDENCj4gPiArI2RlZmluZSBMVEMy
NjY0X01TUEFOX1NPRlRTUEFOCQk3DQo+ID4gKw0KPiA+ICsjZGVmaW5lIExUQzI2NzJfTUFYX0NI
QU5ORUwJCTUNCj4gPiArI2RlZmluZSBMVEMyNjcyX01BWF9TUEFOCQk3DQo+ID4gKyNkZWZpbmUg
TFRDMjY3Ml9TQ0FMRV9NVUxUSVBMSUVSKG4pCSg1MCAqIEJJVChuKSkNCj4gPiArDQo+ID4gK2Vu
dW0gbHRjMjY2NF9pZHMgew0KPiA+ICsJTFRDMjY2NCwNCj4gPiArCUxUQzI2NzIsDQo+ID4gK307
DQo+ID4gKw0KPiA+ICtlbnVtIHsNCj4gPiArCUxUQzI2NjRfU1BBTl9SQU5HRV8wVl81ViwNCj4g
PiArCUxUQzI2NjRfU1BBTl9SQU5HRV8wVl8xMFYsDQo+ID4gKwlMVEMyNjY0X1NQQU5fUkFOR0Vf
TTVWXzVWLA0KPiA+ICsJTFRDMjY2NF9TUEFOX1JBTkdFX00xMFZfMTBWLA0KPiA+ICsJTFRDMjY2
NF9TUEFOX1JBTkdFX00yVjVfMlY1LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArZW51bSB7DQo+ID4g
KwlMVEMyNjY0X0lOUFVUX0EsDQo+ID4gKwlMVEMyNjY0X0lOUFVUX0IsDQo+ID4gKwlMVEMyNjY0
X0lOUFVUX0JfQVZBSUwsDQo+ID4gKwlMVEMyNjY0X1BPV0VSRE9XTiwNCj4gPiArCUxUQzI2NjRf
UE9XRVJET1dOX01PREUsDQo+ID4gKwlMVEMyNjY0X1RPR0dMRV9FTiwNCj4gPiArCUxUQzI2NjRf
R0xPQkFMX1RPR0dMRSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCB1MTYgbHRj
MjY2NF9tc3Bhbl9sdXRbOF1bMl0gPSB7DQo+ID4gKwl7IExUQzI2NjRfU1BBTl9SQU5HRV9NMTBW
XzEwViwgMzI3NjggfSwgLyogTVBTMj0wLCBNUFMxPTAsDQo+IE1TUDA9MCAoMCkqLw0KPiA+ICsJ
eyBMVEMyNjY0X1NQQU5fUkFOR0VfTTVWXzVWLCAzMjc2OCB9LCAvKiBNUFMyPTAsIE1QUzE9MCwN
Cj4gTVNQMD0xICgxKSovDQo+ID4gKwl7IExUQzI2NjRfU1BBTl9SQU5HRV9NMlY1XzJWNSwgMzI3
NjggfSwgLyogTVBTMj0wLCBNUFMxPTEsDQo+IE1TUDA9MCAoMikqLw0KPiA+ICsJeyBMVEMyNjY0
X1NQQU5fUkFOR0VfMFZfMTBWLCAwIH0sIC8qIE1QUzI9MCwgTVBTMT0xLCBNU1AwPTENCj4gKDMp
Ki8NCj4gPiArCXsgTFRDMjY2NF9TUEFOX1JBTkdFXzBWXzEwViwgMzI3NjggfSwgLyogTVBTMj0x
LCBNUFMxPTAsDQo+IE1TUDA9MCAoNCkqLw0KPiA+ICsJeyBMVEMyNjY0X1NQQU5fUkFOR0VfMFZf
NVYsIDAgfSwgLyogTVBTMj0xLCBNUFMxPTAsIE1TUDA9MQ0KPiAoNSkqLw0KPiA+ICsJeyBMVEMy
NjY0X1NQQU5fUkFOR0VfMFZfNVYsIDMyNzY4IH0sIC8qIE1QUzI9MSwgTVBTMT0xLA0KPiBNU1Aw
PTAgKDYpKi8NCj4gPiArCXsgTFRDMjY2NF9TUEFOX1JBTkdFXzBWXzVWLCAwIH0gLyogTVBTMj0x
LCBNUFMxPTEsIE1TUDA9MQ0KPiAoNykqLw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RydWN0IGx0
YzI2NjRfc3RhdGU7DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbHRjMjY2NF9jaGlwX2luZm8gew0KPiA+
ICsJZW51bSBsdGMyNjY0X2lkcyBpZDsNCj4gPiArCWNvbnN0IGNoYXIgKm5hbWU7DQo+ID4gKwlp
bnQgKCpzY2FsZV9nZXQpKGNvbnN0IHN0cnVjdCBsdGMyNjY0X3N0YXRlICpzdCwgaW50IGMpOw0K
PiA+ICsJaW50ICgqb2Zmc2V0X2dldCkoY29uc3Qgc3RydWN0IGx0YzI2NjRfc3RhdGUgKnN0LCBp
bnQgYyk7DQo+ID4gKwlpbnQgbWVhc3VyZW1lbnRfdHlwZTsNCj4gPiArCXVuc2lnbmVkIGludCBu
dW1fY2hhbm5lbHM7DQo+ID4gKwljb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqaWlvX2NoYW47
DQo+ID4gKwljb25zdCBpbnQgKCpzcGFuX2hlbHBlcilbMl07DQo+ID4gKwl1bnNpZ25lZCBpbnQg
bnVtX3NwYW47DQo+ID4gKwl1bnNpZ25lZCBpbnQgaW50ZXJuYWxfdnJlZjsNCj4gPiArCWJvb2wg
bWFudWFsX3NwYW5fc3VwcG9ydDsNCj4gPiArCWJvb2wgcmZzYWRqX3N1cHBvcnQ7DQo+ID4gK307
DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbHRjMjY2NF9jaGFuIHsNCj4gPiArCWJvb2wgdG9nZ2xlX2No
YW47DQo+ID4gKwlib29sIHBvd2VyZG93bjsNCj4gPiArCXU4IHNwYW47DQo+ID4gKwl1MTYgcmF3
WzJdOyAvKiBBL0IgKi8NCj4gPiArfTsNCj4gDQo+IEkgd291bGQgZmluZCBpdCBoZWxwZnVsIHRv
IGhhdmUgbW9yZSBjb21tZW50cyBleHBsYWluZ2luZyB3aGF0IHRoZSB2YXJpb3VzDQo+IGZpZWxk
cyBhcmUgZm9yLiBGb3IgZXhhbXBsZSwgcmF3IHRvIGJlIHVzZWQgdG8gc3VwcGx5IGRhdGEgdG8g
YSBTUEkgeGZlcg0KPiBidXQgYWN0dWFsbHkgaXQgaXMganVzdCBhIHNoYWRvdyBjb3B5IG9mIHRo
ZSBjdXJyZW50IHN0YXRlIG9mIHRoZSBjaGlwDQo+IHJlZ2lzdGVycy4NCj4gDQo+ID4gKw0KPiA+
ICtzdHJ1Y3QgbHRjMjY2NF9zdGF0ZSB7DQo+ID4gKwlzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpOw0K
PiA+ICsJc3RydWN0IHJlZ21hcCAqcmVnbWFwOw0KPiA+ICsJc3RydWN0IGx0YzI2NjRfY2hhbiBj
aGFubmVsc1tMVEMyNjcyX01BWF9DSEFOTkVMXTsNCj4gPiArCS8qIGxvY2sgdG8gcHJvdGVjdCBh
Z2FpbnN0IG11bHRpcGxlIGFjY2VzcyB0byB0aGUgZGV2aWNlIGFuZCBzaGFyZWQgZGF0YQ0KPiAq
Lw0KPiA+ICsJc3RydWN0IG11dGV4IGxvY2s7DQo+ID4gKwljb25zdCBzdHJ1Y3QgbHRjMjY2NF9j
aGlwX2luZm8gKmNoaXBfaW5mbzsNCj4gPiArCXN0cnVjdCBpaW9fY2hhbl9zcGVjICppaW9fY2hh
bm5lbHM7DQo+ID4gKwlpbnQgdnJlZjsNCj4gDQo+IAl2cmVmX212DQo+IA0KPiBBbHdheXMgbmlj
ZSB0byBoYXZlIHRoZSB1bml0cyBzaW5jZSByZWd1bGF0b3JzIHVzZSDCtVYgYW5kIElJTyB1c2Vz
IG1WLg0KPiBPdGhlcndpc2Ugd2UgaGF2ZSB0byBndWVzcy4NCj4gDQo+ID4gKwl1MzIgdG9nZ2xl
X3NlbDsNCj4gPiArCXUzMiBnbG9iYWxfdG9nZ2xlOw0KPiANCj4gU2hvdWxkIHRoaXMgYmUgYm9v
bD8NCj4gDQo+ID4gKwl1MzIgcmZzYWRqOw0KPiANCj4gCXJmc2Fkal9vaG1zDQo+IA0KPiA+ICt9
Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IGludCBsdGMyNjY0X3NwYW5faGVscGVyW11bMl0g
PSB7DQo+ID4gKwl7IDAsIDUwMDAgfSwNCj4gPiArCXsgMCwgMTAwMDAgfSwNCj4gPiArCXsgLTUw
MDAsIDUwMDAgfSwNCj4gPiArCXsgLTEwMDAwLCAxMDAwMCB9LA0KPiA+ICsJeyAtMjUwMCwgMjUw
MCB9LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IGludCBsdGMyNjcyX3NwYW5f
aGVscGVyW11bMl0gPSB7DQo+ID4gKwl7IDAsIDMxMjUgfSwNCj4gPiArCXsgMCwgNjI1MCB9LA0K
PiA+ICsJeyAwLCAxMjUwMCB9LA0KPiA+ICsJeyAwLCAyNTAwMCB9LA0KPiA+ICsJeyAwLCA1MDAw
MCB9LA0KPiA+ICsJeyAwLCAxMDAwMDAgfSwNCj4gPiArCXsgMCwgMjAwMDAwIH0sDQo+ID4gKwl7
IDAsIDMwMDAwMCB9LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGludCBsdGMyNjY0X3Nj
YWxlX2dldChjb25zdCBzdHJ1Y3QgbHRjMjY2NF9zdGF0ZSAqc3QsIGludCBjKQ0KPiA+ICt7DQo+
ID4gKwljb25zdCBzdHJ1Y3QgbHRjMjY2NF9jaGFuICpjaGFuID0gJnN0LT5jaGFubmVsc1tjXTsN
Cj4gPiArCWNvbnN0IGludCAoKnNwYW5faGVscGVyKVsyXSA9IHN0LT5jaGlwX2luZm8tPnNwYW5f
aGVscGVyOw0KPiA+ICsJaW50IHNwYW4sIGZzOw0KPiA+ICsNCj4gPiArCXNwYW4gPSBjaGFuLT5z
cGFuOw0KPiA+ICsJaWYgKHNwYW4gPCAwKQ0KPiA+ICsJCXJldHVybiBzcGFuOw0KPiA+ICsNCj4g
PiArCWZzID0gc3Bhbl9oZWxwZXJbc3Bhbl1bMV0gLSBzcGFuX2hlbHBlcltzcGFuXVswXTsNCj4g
PiArDQo+ID4gKwlyZXR1cm4gKGZzIC8gMjUwMCkgKiBzdC0+dnJlZjsNCj4gDQo+IFNob3VsZCB3
ZSBtdWx0aXBseSBmaXJzdCBhbmQgdGhlbiBkaXZpZGU/IDMxMjUgaXNuJ3QgZGl2aXNpYmxlIGJ5
IDI1MDANCj4gc28gdGhlcmUgbWF5IGJlIHVud2FudGVkIHJvdW5kaW5nIG90aGVyd2lzZS4NCj4g
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbHRjMjY3Ml9zY2FsZV9nZXQoY29uc3Qg
c3RydWN0IGx0YzI2NjRfc3RhdGUgKnN0LCBpbnQgYykNCj4gPiArew0KPiA+ICsJY29uc3Qgc3Ry
dWN0IGx0YzI2NjRfY2hhbiAqY2hhbiA9ICZzdC0+Y2hhbm5lbHNbY107DQo+ID4gKwlpbnQgc3Bh
biwgZnM7DQo+ID4gKw0KPiA+ICsJc3BhbiA9IGNoYW4tPnNwYW47DQo+ID4gKwlpZiAoc3BhbiA8
IDApDQo+ID4gKwkJcmV0dXJuIHNwYW47DQo+ID4gKw0KPiA+ICsJZnMgPSAxMDAwICogc3QtPnZy
ZWYgLyBzdC0+cmZzYWRqOw0KPiA+ICsNCj4gPiArCWlmIChzcGFuID09IExUQzI2NzJfTUFYX1NQ
QU4pDQo+ID4gKwkJcmV0dXJuIDQ4MDAgKiBmczsNCj4gPiArDQo+ID4gKwlyZXR1cm4gTFRDMjY3
Ml9TQ0FMRV9NVUxUSVBMSUVSKHNwYW4pICogZnM7DQo+IA0KPiBBcmUgd2UgbG9zaW5nIGFjY3Vy
YWN5IGJ5IG11bHRpcGx5aW5nIGFmdGVyIGRpdmlkaW5nIGhlcmUgYXMgd2VsbD8NCg0KSGksDQoN
CkluIHRoZSBjYXNlIG9mIG1heCBzcGFuIGZvciBsdGMyNjcyLCBJIGZvdW5kIHRoYXQgcGVyZm9y
bWluZyBtdWx0aXBsaWNhdGlvbg0KYmVmb3JlIGRpdmlzaW9uIGNhdXNlcyBhbiBpbnRlZ2VyIG92
ZXJmbG93IGR1cmluZyB0ZXN0aW5nLiBJIHdhcyB3b25kZXJpbmcNCmhvdyB0aGUgdXBzdHJlYW0g
aGFuZGxlcyB0aGlzIGNhc2UuIENvdWxkIHlvdSBwcm92aWRlIHNvbWUgYWR2aWNlPw0KDQpUaGFu
a3MsDQpLaW0NCg0KDQo=

