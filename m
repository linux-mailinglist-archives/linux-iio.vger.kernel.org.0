Return-Path: <linux-iio+bounces-5914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC6F8FF132
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 17:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845D81C2466A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F78198A07;
	Thu,  6 Jun 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Vceop4rd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B822198824;
	Thu,  6 Jun 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688962; cv=fail; b=HK43rFC24ZarwvPNlQW5w4xqyiliYL3FmtyKIfucxY5VlRbMfoW9aY5y82F5XZsruCzJxJJfQn7nwWnjO6mHHIaV09m3A1kGslfHRZAfAVM/KwoawjGdqPvhNnWQgu3vEF0CayQcw4xfaLErt68DsOrwzBpi0GDZL9RjG9iizHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688962; c=relaxed/simple;
	bh=10BOESU+K1VmTs8YrYZDpRxUnN2F091l+MIeIwGMl7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N2yjGj2piJ8SFvqsoGxSyUuKa2A1xVBAZbiMhwDyuMFil7J69/ES8k5lWIVSDaoQwyuekA8/SMoQ+qVf8pxonnsMCpY7WddVX6ZxEgZFAT+eG2ynvwTq1qlskhlb67EDOXV13z7J7kAvPu/BF0XXaDZixreU3Atco2xHUmecPrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Vceop4rd; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456FVBLQ019235;
	Thu, 6 Jun 2024 11:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=10BOE
	SU+K1VmTs8YrYZDpRxUnN2F091l+MIeIwGMl7Q=; b=Vceop4rdsqYnJsbmO05dQ
	pVPs9+cCJj7kX/Fab60t5ScjNWRfeEvX4omYTwQHkUmdwmcTRN3smVqvqo+ugk3B
	cTXsT7lN0FiLmlZGSyrDdYwOM3KBaq4IIgvd4DdNKUI1je8rK98jARjMfCTxYamc
	oQMgwObpeuXFM70SmPmvJJevFaVl/3rEM/G2x996KNM8VE1pqdG2T8KvVRd6RXCS
	+GEYa2oj40w1eItwnz8M15XTqFhMmm+twYBivTXhQfFqKTWRi0sEDFBbgKtFozT+
	H5u3+EXxPZb9zwgOSE/Hz8i7SeBaRW9Sdsg4f0EGw4d8dbZ4BpkBEQSgV7MqsPRI
	Q==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yjuesmp13-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 11:49:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdDCCc6QNXwFmq3zHOIQH0Vt3djBKWCuiSgUoUczIzscqK/0RkLFAVnKDpjFFGpjm3zCif1Q2dKWdnXmv41lMCm7bBUj/KlUwBgoM0NYgqP1y/XZQXxQyOYIr4rb1kTBQMWu7GUI3r518fQ8tBmmOF6OfkkVhYpAvSVLDHZ9Jj+B/smOM48DmaGKJCqv2nXLsWatnAStkZbuvBtUflYwKMBvNPgzwaO+FCtiSTkmvhuqNdhEvW8OQfxJ+/VZGahLh7rO27jpuYpevNcEydThzkf8WJZpysqwEZq2CarmndsLvqJpiT5Xluz7ClmSt4IIHMmLcx8IQSAaWQDqOHlDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10BOESU+K1VmTs8YrYZDpRxUnN2F091l+MIeIwGMl7Q=;
 b=J5XFbkR91AkeugGaTbZjkHcrjlKThzYHmckN9QA5i2W9c9xdY86JxFPp7bR7auCMFoy832LfjFIV5oC8/edMTOYawVwKaVj4StnxZhEKWE7eZhy3zi4W19XuO+ruVgcK9oqUwuGZyAXdYXcQKaO//KHs6PzaWXbJ9gxsK5BHvZ/WBcjVGl1Wq8RZHNgwsuFjbEh6kCyBonWw1cYMjEKHDUxQ20m1snNu5xzWvIQ8P2IoAfnWTuZqmFVVCyNelyGLlHsJipuQ6j0uDW3X1zPbQkMyEC7+l5lrFbs1ocRpeQdyLlfLAweAJEk0YAuyCej8f9Wi6W+r0F/AAEzKlbWiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by DM6PR03MB5195.namprd03.prod.outlook.com (2603:10b6:5:240::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 15:49:00 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 15:49:00 +0000
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
Thread-Index: AQHatVSYiawUUvGO7Uuq7Pr8wl80WbG2grCAgARdjBA=
Date: Thu, 6 Jun 2024 15:49:00 +0000
Message-ID: 
 <PH0PR03MB7141405D9A40A18E1C90FF79F9FA2@PH0PR03MB7141.namprd03.prod.outlook.com>
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
 =?utf-8?B?elhHMXpaeTAwT0dNd1pHUTNNaTB5TkRGakxURXhaV1l0WVdGbU1pMWxOVFV3?=
 =?utf-8?B?T0RVd1pETTJOamxjWVcxbExYUmxjM1JjTkRoak1HUmtOelF0TWpReFl5MHhN?=
 =?utf-8?B?V1ZtTFdGaFpqSXRaVFUxTURnMU1HUXpOalk1WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlPREEyTmlJZ2REMGlNVE16TmpJeE5qSTFNemd3TkRFd09EWXpJaUJvUFNK?=
 =?utf-8?B?alkwa3pUekJpUkUxWWRrVXdSM2xxVkhwWlJWUjZaWGRoZERnOUlpQnBaRDBp?=
 =?utf-8?B?SWlCaWJEMGlNQ0lnWW04OUlqRWlJR05wUFNKalFVRkJRVVZTU0ZVeFVsTlNW?=
 =?utf-8?B?VVpPUTJkVlFVRkZiME5CUVVSMlJsSjNURXRpYW1GQlpXNDRPWFJwVEVneGNF?=
 =?utf-8?B?YzJabm95TWtselpsZHJXVVJCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|DM6PR03MB5195:EE_
x-ms-office365-filtering-correlation-id: aef5ad8c-c39b-428b-ddaf-08dc86402eff
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eC9EV2JIZjNDTytZZ24yVHFFdVBaaFVncU5OTmdUaTlldklCVWltVmYzRjEr?=
 =?utf-8?B?RXp3MEV2Q3FsWU5abjNuQlJ5eUJvUWMxbVcrdEswWGt0L2FlSkhEUUh0U0NQ?=
 =?utf-8?B?TnVFdCtHVk9yeU9vMkV2ek92ekZXU0NyNDN4V3VBbDNPOEpteWFZRmJJbzFa?=
 =?utf-8?B?MC94bnl5aVRyNmNwd05ic0hoOGtlSHdTVlM3MktLZmx3Yjg2cTFvMEJyQUpK?=
 =?utf-8?B?aEZUekd3OWpjcldMbHhBY2lQRDdyQW1EOVFrUmpWczh1UU8wU3ZXUVFmNjQw?=
 =?utf-8?B?QTlUYWNraUV0UCtSMU9NK2g3eGdwQTJqRTY0L2kvSERxRjkxbkNTMzhqK2kz?=
 =?utf-8?B?Ym1KL2ttRzNNeFNhaU5udUwrMjRJZXN2cmMxRUNTczVyM01uQkJ3a0M3cTNW?=
 =?utf-8?B?ZHRhSEtuV0orQ1JWWjByaW9uQjBaMHlpenpqcStQbndxS2xFaXBRWVdDaUpa?=
 =?utf-8?B?U1R4cTYyZkhwRGEyOHc4c09YdTkvZ2tuY0RlUUhlaHlORi92amhlZ09zTENX?=
 =?utf-8?B?VXFSOEFxVVVoVHhrZkp1eTU0bW5SSExoNjljT3hCMno4TUhCaXNyTmVnYk1S?=
 =?utf-8?B?RFVKeExOdWdkR1pscS9LT0hUNXgzakt5aGVXVnhUOHB0TDVyelRqcFFMN3dF?=
 =?utf-8?B?S1dwRDkvUEFYYzI1LzkvdVlZTEluSHRPWXRTN3NnWE94UFpzcTh3WnFmZVdl?=
 =?utf-8?B?cEpFWStTc1RKNGVOTzNzUnZaMVN6S1ZramkyWlYyQzd4OG9SdTBybm81dG40?=
 =?utf-8?B?alV6Zzc2VlBZV01uTHdoYUVvdzJOenVsVVpnOFZzMGV4Mklxa2liNnlqU3J0?=
 =?utf-8?B?ZDB6OWhIeEdGUExwTzR3V1Y4M3JlRUNscEJTMGFvVGp3TGI3dllrYjZlaVgz?=
 =?utf-8?B?ZWo3OGdnejYrY1hlU3VXRGExVVgyRmtRZXpERFpwWnJ1NnZBQkdQWDM2NzFj?=
 =?utf-8?B?WTJZbnZJcWsvWURva2FncWduYWx4a0tTNkM4VEozNExTaUtBQmtDSStYMTdE?=
 =?utf-8?B?R2ltZnZZalhEM1FYL1A2YThLbDNMS01zdnZ0NTZIckVEUTZGQXQ1WDNSRlpK?=
 =?utf-8?B?d2J3TmhwbzZLT2lHRXNNKzBMYWxUaEF4aTN0bklSYk9XelZoV1l4YkNvc3h3?=
 =?utf-8?B?blE2U3lVOXJOTFBhZURSM1ByakptNVVQRlpqUXhiZksyUEl5QStGSjJDcys3?=
 =?utf-8?B?MGxJTDA2WHZ0TlBPdWY3QTdXK09Ja2M2ZlJvNExLQm1qZi8vSjY5YmRvREtm?=
 =?utf-8?B?L0I3WEpTOERyeHA1S3pjdzM1OFp1dXgyb0taSjg4a2dSb3dEYlpidkdvbFIz?=
 =?utf-8?B?V2gwR21YS3B2MnlrbTJoWDltell6bTB6ZGh2WnpuRmJhWkI3NlREbG5mMEht?=
 =?utf-8?B?ZWlPNzZyd1BTS2lHV0R6dEk2eW9NdGNCWEQ3VnlEM3BmZ2lFQWdxKzN6UktJ?=
 =?utf-8?B?TU5DRGhqQ0pZRjdCZkRUbzlJUGFFQmRxbXl6clZGeUh1Qy9rdHZXSkU0OThH?=
 =?utf-8?B?Mkg3MzhRSmdtVWRLT2g0dHptNGM4YXBSSy9pcDZ6NnFVN3crNkY1dHJVSjUy?=
 =?utf-8?B?eGhIL2xELzFNZHRhaVh3REhFNlU3YUtGRmhFR2l3bUJCWFVtRnpzSjVqeFJN?=
 =?utf-8?B?RVRWazJjU2VEK2Vndzg1cWtic2pXWnJpWWMra1FKK1BNSWpEUG93YmtHMk53?=
 =?utf-8?B?ZHM5Z0hSSlBlOUFiVDl1TGw2angzclV5Q1UrSGRtdXArdno0V3lSTElpbEJl?=
 =?utf-8?B?a1hhdS9EcXE5U3k0U1czTEdCVkdCNHRmZjA5WkpTQWx3VlZLRkNMZXVoYTVO?=
 =?utf-8?Q?uuYWd6FsCu/6tGRBf+DRQum4vAGa8u/afzD8Y=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZXpLOG1DVWVsbUxTV0RVcEV3L3d5ZFNlc284WE82cWVJZ05GZ1JDSHVoaDBP?=
 =?utf-8?B?dlJkWFNNOEJ1UGx6M3RGSkJ2T0xhb25WdFRZRVJBaVkxdGM5NnNzZmFoY3pj?=
 =?utf-8?B?VWw1K0NXNVNZaDhnRUpOREdyaENsUlVJZ1RReU9ySm9KdFg2Q0ZnWk1Kaisz?=
 =?utf-8?B?UUp2bDVnTm5HaXhoa3VTQXRFR3FZeDlwQWF5a0xVcTgxZldWZW1DQmR1VEJw?=
 =?utf-8?B?b3g3ZlpydGdhb2dHR2RWVVBCT0ZBNXQ2Q0hxaTYza0ZGREN6d3VLbFdsYjBN?=
 =?utf-8?B?b2RaVGN5eFgzdDhFSUprLzV0VXIwR05pbEJyOWg3aWNibkRET1czWUozZGVK?=
 =?utf-8?B?K3hrYjl3QnNOdGNIT0Z2S2pXRGlZYXBYczQweWo5dkQvREZ4MlAwV2c5L3RD?=
 =?utf-8?B?YUxJK2pYcnlDRC93L0gxQ2RCVjdyWGhvOWdsM0hpZGtxUTBzMVdzN1dJZlg5?=
 =?utf-8?B?NEIrMG5hZ051UkIwa1VBNWZkNEFpc3VpM1RLbmx4RVZndkpZbE00MTJFckU3?=
 =?utf-8?B?OWxvTDBoMmVFVGRwcG9yajBZL1NDT0RVZE5ocU5CeUtmMGdEeXNTNTRiK1d2?=
 =?utf-8?B?SzR2M0hYK0FwaDh0eVJ3UlRVb2hsQkdTeDlyR2RkWi9tK01NSW5YemZIc0sz?=
 =?utf-8?B?SFdwWUltV3k3MXdSNHpncHU0VXl3SzJjRGtJb1EzRUdVb2YxTDU1aU1OK2RZ?=
 =?utf-8?B?UHlmbWVxOUs2bFl6ZWhQSzNPWWhScWkxM2dUZFZsY21ZOXcwc3FPYlMrRmh5?=
 =?utf-8?B?eVp4ODd6MEp6WUNZc2FwT1c3cEVodHZUcTZ4Y0xRZ0RYSmx5UkhNMnpKV211?=
 =?utf-8?B?V1VNdXhCdUdldTQrTCtSM2NUMjhocjhaa0p2MEQ5Vm96VlFhSVM0THlsSHhw?=
 =?utf-8?B?RGFLaTVrcEJrRmV4a3V6ZzZmaVQvOHVwUzJZVjZBSk55OC9KeEtkVGpKekc0?=
 =?utf-8?B?dnJadlYzOVlLNlhTVTNNT3VXTHhJTXZad29BdG1YOE1hUUYwSlJsVi9NM0NU?=
 =?utf-8?B?WFlkUUFKblI4MTlzYUNicmEzNEFzdHZjRzQwV2trZVFVbWdPdDBPSFVpc2hl?=
 =?utf-8?B?cmViVVZqdm10R2M3N25vZVdJMkxRc0RsR0k3cjFyNmhJMy9Ec0lqSzlnQlRO?=
 =?utf-8?B?cjFzYUMySjJkNmQ1L09xZ3FLcm04UitOZ1Rrd1dWU3pHejd4V0kyUEtNSjE1?=
 =?utf-8?B?Z0wzbHNkNSttdU1BZ1ZUVU1ZKzN5S2NtdkdXaGZ5cGpyTEpCZGJEK09iblVB?=
 =?utf-8?B?aEEraWUzNk9QcGY1R2xxWVNKankvK2NzRDdRQTRaaG9ZREl2cVBhUyt2MmJ0?=
 =?utf-8?B?ZEhYdVFNdk5hQ3VuQVlWMVNJbTVDWjVDRTM2bHpLM2hPaU5mMGNmUzdJQUhl?=
 =?utf-8?B?aVM2NTAya29scVV3aENxWmcxOUJITS9JK0FGKy8wM0x5anc3Mk80VGxsM3JS?=
 =?utf-8?B?ZWorRkFwZDJxSmphdEZlMlFzUnlpQSttYklLR05xenkvYTNPdDhoazJxTjV1?=
 =?utf-8?B?dWZRb0IrSXdFL1I4V0dldDhjT2QzTEUxNnVYaXl6ZXlJM2FxOEMycEx6akpG?=
 =?utf-8?B?UWIvbUJPS3dNVENvUlNvcnNtWjNIeUNHNEkraTl1YWdDVE5tWnlEcGVSMkky?=
 =?utf-8?B?QTlDTXBoNU56WVgwNDJySXhtNTdpNmw1M0Nwbml6Vnd3UUZlV29PRnJlaHhz?=
 =?utf-8?B?Y095aVMwYkRJSXdtUHp3enBxZ2VPejVTczFKbE50ZjliWTJyZ0k5bHVXTVo5?=
 =?utf-8?B?eGN0NHdzdEo2eGMyZ3NTbUpsWml0ekpnRUt2UU5YeXlsY0MxVExuWmx4S2Fr?=
 =?utf-8?B?V1hOaUNxdXFPd0tNbXVnUThueVFRT0pBRG9xdGRWZEhaa1BwNWlMMFdqd1BD?=
 =?utf-8?B?WnlDVW12YmhQRHoyRk1BMjVrOFJsaVJsUktWb3hac0cweEhOenFrbmF0bDlR?=
 =?utf-8?B?ZnF2d1lTZnNyTkI1M1BoeDVoMGptM0ZuL2hCRGdDbjFEWklSUEVML3dzdm1F?=
 =?utf-8?B?STcrZzd0N3VFaHlhRmN3azZVZFNyNFVIckNKc21BcnhLTHFoN2lEcW91WDNi?=
 =?utf-8?B?VVVsbDRBcWhHeTVhSU13RFBGQWhaNkJxd0ZSaXk4MUYyaUFLTGJLbHNFZzA3?=
 =?utf-8?Q?VEwsoqkZ6RLS7u5yQ2SmiYjFP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aef5ad8c-c39b-428b-ddaf-08dc86402eff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 15:49:00.4194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGMGxEDmDGjlDpDgBelYI+6ulOhR5lhCoC8lvM/aaS29goI699/ky2EtC5DmJi68iAshzSHvcR4HdatWvHxSOLCF4st2diwoGN4xvsyhF1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5195
X-Proofpoint-ORIG-GUID: UAMbJLuFtilnYfK40BJGp38uyZPVtfsE
X-Proofpoint-GUID: UAMbJLuFtilnYfK40BJGp38uyZPVtfsE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060114

DQo+ID4gK3N0cnVjdCBsdGMyNjY0X3N0YXRlIHsNCj4gPiArCXN0cnVjdCBzcGlfZGV2aWNlICpz
cGk7DQo+ID4gKwlzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQo+ID4gKwlzdHJ1Y3QgbHRjMjY2NF9j
aGFuIGNoYW5uZWxzW0xUQzI2NzJfTUFYX0NIQU5ORUxdOw0KPiA+ICsJLyogbG9jayB0byBwcm90
ZWN0IGFnYWluc3QgbXVsdGlwbGUgYWNjZXNzIHRvIHRoZSBkZXZpY2UgYW5kIHNoYXJlZCBkYXRh
DQo+ICovDQo+ID4gKwlzdHJ1Y3QgbXV0ZXggbG9jazsNCj4gPiArCWNvbnN0IHN0cnVjdCBsdGMy
NjY0X2NoaXBfaW5mbyAqY2hpcF9pbmZvOw0KPiA+ICsJc3RydWN0IGlpb19jaGFuX3NwZWMgKmlp
b19jaGFubmVsczsNCj4gPiArCWludCB2cmVmOw0KPiANCj4gCXZyZWZfbXYNCj4gDQo+IEFsd2F5
cyBuaWNlIHRvIGhhdmUgdGhlIHVuaXRzIHNpbmNlIHJlZ3VsYXRvcnMgdXNlIMK1ViBhbmQgSUlP
IHVzZXMgbVYuDQo+IE90aGVyd2lzZSB3ZSBoYXZlIHRvIGd1ZXNzLg0KPiANCj4gPiArCXUzMiB0
b2dnbGVfc2VsOw0KPiA+ICsJdTMyIGdsb2JhbF90b2dnbGU7DQo+IA0KPiBTaG91bGQgdGhpcyBi
ZSBib29sPw0KPiANCj4gPiArCXUzMiByZnNhZGo7DQo+IA0KPiAJcmZzYWRqX29obXMNCj4gDQo+
ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgaW50IGx0YzI2NjRfc3Bhbl9oZWxwZXJb
XVsyXSA9IHsNCj4gPiArCXsgMCwgNTAwMCB9LA0KPiA+ICsJeyAwLCAxMDAwMCB9LA0KPiA+ICsJ
eyAtNTAwMCwgNTAwMCB9LA0KPiA+ICsJeyAtMTAwMDAsIDEwMDAwIH0sDQo+ID4gKwl7IC0yNTAw
LCAyNTAwIH0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgaW50IGx0YzI2NzJf
c3Bhbl9oZWxwZXJbXVsyXSA9IHsNCj4gPiArCXsgMCwgMzEyNSB9LA0KPiA+ICsJeyAwLCA2MjUw
IH0sDQo+ID4gKwl7IDAsIDEyNTAwIH0sDQo+ID4gKwl7IDAsIDI1MDAwIH0sDQo+ID4gKwl7IDAs
IDUwMDAwIH0sDQo+ID4gKwl7IDAsIDEwMDAwMCB9LA0KPiA+ICsJeyAwLCAyMDAwMDAgfSwNCj4g
PiArCXsgMCwgMzAwMDAwIH0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGx0YzI2
NjRfc2NhbGVfZ2V0KGNvbnN0IHN0cnVjdCBsdGMyNjY0X3N0YXRlICpzdCwgaW50IGMpDQo+ID4g
K3sNCj4gPiArCWNvbnN0IHN0cnVjdCBsdGMyNjY0X2NoYW4gKmNoYW4gPSAmc3QtPmNoYW5uZWxz
W2NdOw0KPiA+ICsJY29uc3QgaW50ICgqc3Bhbl9oZWxwZXIpWzJdID0gc3QtPmNoaXBfaW5mby0+
c3Bhbl9oZWxwZXI7DQo+ID4gKwlpbnQgc3BhbiwgZnM7DQo+ID4gKw0KPiA+ICsJc3BhbiA9IGNo
YW4tPnNwYW47DQo+ID4gKwlpZiAoc3BhbiA8IDApDQo+ID4gKwkJcmV0dXJuIHNwYW47DQo+ID4g
Kw0KPiA+ICsJZnMgPSBzcGFuX2hlbHBlcltzcGFuXVsxXSAtIHNwYW5faGVscGVyW3NwYW5dWzBd
Ow0KPiA+ICsNCj4gPiArCXJldHVybiAoZnMgLyAyNTAwKSAqIHN0LT52cmVmOw0KPiANCj4gU2hv
dWxkIHdlIG11bHRpcGx5IGZpcnN0IGFuZCB0aGVuIGRpdmlkZT8gMzEyNSBpc24ndCBkaXZpc2li
bGUgYnkgMjUwMA0KPiBzbyB0aGVyZSBtYXkgYmUgdW53YW50ZWQgcm91bmRpbmcgb3RoZXJ3aXNl
Lg0KDQpZZXMgdGhhdCB3b3VsZCBtYWtlIHNlbnNlLCBzaG91bGQgcGVyZm9ybSB0aGUgbXVsdGlw
bGljYXRpb24gZmlyc3QsDQp0aGVuIHRoZSBkaXZpc2lvbi4NCg0KPiA+ICt9DQo+ID4gKw0KPiA+
ICtzdGF0aWMgaW50IGx0YzI2NzJfc2NhbGVfZ2V0KGNvbnN0IHN0cnVjdCBsdGMyNjY0X3N0YXRl
ICpzdCwgaW50IGMpDQo+ID4gK3sNCj4gPiArCWNvbnN0IHN0cnVjdCBsdGMyNjY0X2NoYW4gKmNo
YW4gPSAmc3QtPmNoYW5uZWxzW2NdOw0KPiA+ICsJaW50IHNwYW4sIGZzOw0KPiA+ICsNCj4gPiAr
CXNwYW4gPSBjaGFuLT5zcGFuOw0KPiA+ICsJaWYgKHNwYW4gPCAwKQ0KPiA+ICsJCXJldHVybiBz
cGFuOw0KPiA+ICsNCj4gPiArCWZzID0gMTAwMCAqIHN0LT52cmVmIC8gc3QtPnJmc2FkajsNCj4g
PiArDQo+ID4gKwlpZiAoc3BhbiA9PSBMVEMyNjcyX01BWF9TUEFOKQ0KPiA+ICsJCXJldHVybiA0
ODAwICogZnM7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIExUQzI2NzJfU0NBTEVfTVVMVElQTElFUihz
cGFuKSAqIGZzOw0KPiANCj4gQXJlIHdlIGxvc2luZyBhY2N1cmFjeSBieSBtdWx0aXBseWluZyBh
ZnRlciBkaXZpZGluZyBoZXJlIGFzIHdlbGw/DQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IGx0YzI2NjRfb2Zmc2V0X2dldChjb25zdCBzdHJ1Y3QgbHRjMjY2NF9zdGF0ZSAqc3Qs
IGludCBjKQ0KPiA+ICt7DQo+ID4gKwljb25zdCBzdHJ1Y3QgbHRjMjY2NF9jaGFuICpjaGFuID0g
JnN0LT5jaGFubmVsc1tjXTsNCj4gPiArCWludCBzcGFuOw0KPiA+ICsNCj4gPiArCXNwYW4gPSBj
aGFuLT5zcGFuOw0KPiA+ICsJaWYgKHNwYW4gPCAwKQ0KPiA+ICsJCXJldHVybiBzcGFuOw0KPiA+
ICsNCj4gPiArCWlmIChzdC0+Y2hpcF9pbmZvLT5zcGFuX2hlbHBlcltzcGFuXVswXSA8IDApDQo+
ID4gKwkJcmV0dXJuIC0zMjc2ODsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+
ICsNCj4gPiArc3RhdGljIGludCBsdGMyNjcyX29mZnNldF9nZXQoY29uc3Qgc3RydWN0IGx0YzI2
NjRfc3RhdGUgKnN0LCBpbnQgYykNCj4gPiArew0KPiA+ICsJY29uc3Qgc3RydWN0IGx0YzI2NjRf
Y2hhbiAqY2hhbiA9ICZzdC0+Y2hhbm5lbHNbY107DQo+ID4gKwlpbnQgc3BhbjsNCj4gPiArDQo+
ID4gKwlzcGFuID0gY2hhbi0+c3BhbjsNCj4gPiArCWlmIChzcGFuIDwgMCkNCj4gPiArCQlyZXR1
cm4gc3BhbjsNCj4gPiArDQo+ID4gKwlpZiAoc3QtPmNoaXBfaW5mby0+c3Bhbl9oZWxwZXJbc3Bh
bl1bMV0gPCAwKQ0KPiANCj4gU2hvdWxkIHRoaXMgYmUgc3Bhbl9oZWxwZXJbc3Bhbl1bMF0/IFtz
cGFuXVsxXSBpcyBhbHdheXMgPiAwLg0KPiANCj4gQW5kIGZvciB0aGF0IG1hdHRlciwgW3NwYW5d
WzBdIGlzIGFsd2F5cyAwIGZvciBsdGMyNjcyLCBzbw0KPiBtYXliZSB3ZSBkb24ndCBuZWVkIHRo
aXMgY2hlY2sgYXQgYWxsPw0KPiANCj4gPiArCQlyZXR1cm4gLTMyNzY4Ow0KPiA+ICsNCj4gPiAr
CXJldHVybiBzdC0+Y2hpcF9pbmZvLT5zcGFuX2hlbHBlcltzcGFuXVsxXSAvIDI1MDsNCj4gDQo+
IFdoeSBpcyB0aGlzIG9uZSBub3QgcmV0dXJuIDAgbGlrZSB0aGUgb3RoZXIgY2hpcD8NCj4gDQo+
IEZpZ3VyZSAyNCBhbmQgMjUgaW4gdGhlIGRhdGFzaGVldCBkb24ndCBzaG93IGFuIG9mZnNldCBp
bg0KPiB0aGUgdHJhbmZlciBmdW5jdGlvbi4NCg0KSSB0aGluayBJIG1pc2ludGVycHJldCBwYWdl
IDI1IG9mIHRoZSBkYXRhc2hlZXQgYWJvdXQgdGhlIG9mZnNldC4gV2UNCmNhbiBtYWtlIGl0IHJl
dHVybiAwLg0KDQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbHRjMjY2NF9kYWNfY29k
ZV93cml0ZShzdHJ1Y3QgbHRjMjY2NF9zdGF0ZSAqc3QsIHUzMiBjaGFuLCB1MzINCj4gaW5wdXQs
DQo+ID4gKwkJCQkgIHUxNiBjb2RlKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbHRjMjY2NF9jaGFu
ICpjID0gJnN0LT5jaGFubmVsc1tjaGFuXTsNCj4gPiArCWludCByZXQsIHJlZzsNCj4gPiArDQo+
ID4gKwlndWFyZChtdXRleCkoJnN0LT5sb2NrKTsNCj4gPiArCS8qIHNlbGVjdCB0aGUgY29ycmVj
dCBpbnB1dCByZWdpc3RlciB0byB3cml0ZSB0byAqLw0KPiA+ICsJaWYgKGMtPnRvZ2dsZV9jaGFu
KSB7DQo+ID4gKwkJcmV0ID0gcmVnbWFwX3dyaXRlKHN0LT5yZWdtYXAsIExUQzI2NjRfQ01EX1RP
R0dMRV9TRUwsDQo+ID4gKwkJCQkgICBpbnB1dCA8PCBjaGFuKTsNCj4gPiArCQlpZiAocmV0KQ0K
PiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+ICsJLyoNCj4gPiArCSAqIElmIGluIHRv
Z2dsZSBtb2RlIHRoZSBkYWMgc2hvdWxkIGJlIHVwZGF0ZWQgYnkgYW4NCj4gPiArCSAqIGV4dGVy
bmFsIHNpZ25hbCAob3Igc3cgdG9nZ2xlKSBhbmQgbm90IGhlcmUuDQo+ID4gKwkgKi8NCj4gPiAr
CWlmIChzdC0+dG9nZ2xlX3NlbCAmIEJJVChjaGFuKSkNCj4gPiArCQlyZWcgPSBMVEMyNjY0X0NN
RF9XUklURV9OKGNoYW4pOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJlZyA9IExUQzI2NjRfQ01EX1dS
SVRFX05fVVBEQVRFX04oY2hhbik7DQo+ID4gKw0KPiA+ICsJcmV0ID0gcmVnbWFwX3dyaXRlKHN0
LT5yZWdtYXAsIHJlZywgY29kZSk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7
DQo+ID4gKw0KPiA+ICsJYy0+cmF3W2lucHV0XSA9IGNvZGU7DQo+ID4gKw0KPiA+ICsJaWYgKGMt
PnRvZ2dsZV9jaGFuKSB7DQo+ID4gKwkJcmV0ID0gcmVnbWFwX3dyaXRlKHN0LT5yZWdtYXAsIExU
QzI2NjRfQ01EX1RPR0dMRV9TRUwsDQo+ID4gKwkJCQkgICBzdC0+dG9nZ2xlX3NlbCk7DQo+ID4g
KwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwly
ZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGx0YzI2NjRfZGFjX2Nv
ZGVfcmVhZChzdHJ1Y3QgbHRjMjY2NF9zdGF0ZSAqc3QsIHUzMiBjaGFuLCB1MzINCj4gaW5wdXQs
DQo+ID4gKwkJCQkgdTMyICpjb2RlKQ0KPiA+ICt7DQo+ID4gKwlndWFyZChtdXRleCkoJnN0LT5s
b2NrKTsNCj4gPiArCSpjb2RlID0gc3QtPmNoYW5uZWxzW2NoYW5dLnJhd1tpbnB1dF07DQo+ID4g
Kw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBpbnQg
bHRjMjY2NF9yYXdfcmFuZ2VbXSA9IHswLCAxLCBVMTZfTUFYfTsNCj4gPiArDQo+ID4gK3N0YXRp
YyBpbnQgbHRjMjY2NF9yZWFkX2F2YWlsKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4g
KwkJCSAgICAgIHN0cnVjdCBpaW9fY2hhbl9zcGVjIGNvbnN0ICpjaGFuLA0KPiA+ICsJCQkgICAg
ICBjb25zdCBpbnQgKip2YWxzLCBpbnQgKnR5cGUsIGludCAqbGVuZ3RoLA0KPiA+ICsJCQkgICAg
ICBsb25nIGluZm8pDQo+ID4gK3sNCj4gPiArCXN3aXRjaCAoaW5mbykgew0KPiA+ICsJY2FzZSBJ
SU9fQ0hBTl9JTkZPX1JBVzoNCj4gPiArCQkqdmFscyA9IGx0YzI2NjRfcmF3X3JhbmdlOw0KPiA+
ICsJCSp0eXBlID0gSUlPX1ZBTF9JTlQ7DQo+ID4gKw0KPiA+ICsJCXJldHVybiBJSU9fQVZBSUxf
UkFOR0U7DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGx0YzI2NjRfcmVhZF9yYXcoc3RydWN0IGlp
b19kZXYgKmluZGlvX2RldiwNCj4gPiArCQkJICAgIHN0cnVjdCBpaW9fY2hhbl9zcGVjIGNvbnN0
ICpjaGFuLCBpbnQgKnZhbCwNCj4gPiArCQkJICAgIGludCAqdmFsMiwgbG9uZyBpbmZvKQ0KPiA+
ICt7DQo+ID4gKwlzdHJ1Y3QgbHRjMjY2NF9zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYp
Ow0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlzd2l0Y2ggKGluZm8pIHsNCj4gPiArCWNh
c2UgSUlPX0NIQU5fSU5GT19SQVc6DQo+ID4gKwkJcmV0ID0gbHRjMjY2NF9kYWNfY29kZV9yZWFk
KHN0LCBjaGFuLT5jaGFubmVsLA0KPiA+ICsJCQkJCSAgICBMVEMyNjY0X0lOUFVUX0EsIHZhbCk7
DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkJcmV0
dXJuIElJT19WQUxfSU5UOw0KPiA+ICsJY2FzZSBJSU9fQ0hBTl9JTkZPX09GRlNFVDoNCj4gPiAr
CQkqdmFsID0gc3QtPmNoaXBfaW5mby0+b2Zmc2V0X2dldChzdCwgY2hhbi0+Y2hhbm5lbCk7DQo+
ID4gKw0KPiA+ICsJCXJldHVybiBJSU9fVkFMX0lOVDsNCj4gPiArCWNhc2UgSUlPX0NIQU5fSU5G
T19TQ0FMRToNCj4gPiArCQkqdmFsID0gc3QtPmNoaXBfaW5mby0+c2NhbGVfZ2V0KHN0LCBjaGFu
LT5jaGFubmVsKTsNCj4gPiArDQo+ID4gKwkJKnZhbDIgPSAxNjsNCj4gPiArCQlyZXR1cm4gSUlP
X1ZBTF9GUkFDVElPTkFMX0xPRzI7DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGx0YzI2NjRfd3Jp
dGVfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4gKwkJCSAgICAgc3RydWN0IGlp
b19jaGFuX3NwZWMgY29uc3QgKmNoYW4sIGludCB2YWwsDQo+ID4gKwkJCSAgICAgaW50IHZhbDIs
IGxvbmcgaW5mbykNCj4gPiArew0KPiA+ICsJc3RydWN0IGx0YzI2NjRfc3RhdGUgKnN0ID0gaWlv
X3ByaXYoaW5kaW9fZGV2KTsNCj4gPiArDQo+ID4gKwlzd2l0Y2ggKGluZm8pIHsNCj4gPiArCWNh
c2UgSUlPX0NIQU5fSU5GT19SQVc6DQo+ID4gKwkJaWYgKHZhbCA+IFUxNl9NQVggfHwgdmFsIDwg
MCkNCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJCXJldHVybiBsdGMyNjY0
X2RhY19jb2RlX3dyaXRlKHN0LCBjaGFuLT5jaGFubmVsLA0KPiA+ICsJCQkJCSAgICAgIExUQzI2
NjRfSU5QVVRfQSwgdmFsKTsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzc2l6ZV90IGx0YzI2NjRfcmVn
X2Jvb2xfZ2V0KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4gKwkJCQkgICAgdWludHB0
cl90IHByaXZhdGUsDQo+ID4gKwkJCQkgICAgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNo
YW4sDQo+ID4gKwkJCQkgICAgY2hhciAqYnVmKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbHRjMjY2
NF9zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ICsJdTMyIHZhbDsNCj4gPiAr
DQo+ID4gKwlndWFyZChtdXRleCkoJnN0LT5sb2NrKTsNCj4gPiArCXN3aXRjaCAocHJpdmF0ZSkg
ew0KPiA+ICsJY2FzZSBMVEMyNjY0X1BPV0VSRE9XTjoNCj4gPiArCQl2YWwgPSBzdC0+Y2hhbm5l
bHNbY2hhbi0+Y2hhbm5lbF0ucG93ZXJkb3duOw0KPiA+ICsNCj4gPiArCQlyZXR1cm4gc3lzZnNf
ZW1pdChidWYsICIldVxuIiwgdmFsKTsNCj4gPiArCWNhc2UgTFRDMjY2NF9QT1dFUkRPV05fTU9E
RToNCj4gPiArCQlyZXR1cm4gc3lzZnNfZW1pdChidWYsICI0MmtvaG1fdG9fZ25kXG4iKTs+ICsJ
Y2FzZQ0KPiBMVEMyNjY0X1RPR0dMRV9FTjoNCj4gPiArCQl2YWwgPSAhIShzdC0+dG9nZ2xlX3Nl
bCAmIEJJVChjaGFuLT5jaGFubmVsKSk7DQo+ID4gKw0KPiA+ICsJCXJldHVybiBzeXNmc19lbWl0
KGJ1ZiwgIiV1XG4iLCB2YWwpOw0KPiA+ICsJY2FzZSBMVEMyNjY0X0dMT0JBTF9UT0dHTEU6DQo+
ID4gKwkJdmFsID0gc3QtPmdsb2JhbF90b2dnbGU7DQo+ID4gKw0KPiA+ICsJCXJldHVybiBzeXNm
c19lbWl0KGJ1ZiwgIiV1XG4iLCB2YWwpOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHNzaXplX3QgbHRj
MjY2NF9yZWdfYm9vbF9zZXQoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwNCj4gPiArCQkJCSAg
ICB1aW50cHRyX3QgcHJpdmF0ZSwNCj4gPiArCQkJCSAgICBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5f
c3BlYyAqY2hhbiwNCj4gPiArCQkJCSAgICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBsZW4pDQo+
ID4gK3sNCj4gPiArCXN0cnVjdCBsdGMyNjY0X3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rl
dik7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsJYm9vbCBlbjsNCj4gPiArDQo+ID4gKwlyZXQgPSBr
c3RydG9ib29sKGJ1ZiwgJmVuKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gPiArDQo+ID4gKwlndWFyZChtdXRleCkoJnN0LT5sb2NrKTsNCj4gPiArCXN3aXRjaCAocHJp
dmF0ZSkgew0KPiA+ICsJY2FzZSBMVEMyNjY0X1BPV0VSRE9XTjoNCj4gPiArCQlyZXQgPSByZWdt
YXBfd3JpdGUoc3QtPnJlZ21hcCwNCj4gPiArCQkJCSAgIGVuID8NCj4gTFRDMjY2NF9DTURfUE9X
RVJfRE9XTl9OKGNoYW4tPmNoYW5uZWwpIDoNCj4gPiArCQkJCSAgIExUQzI2NjRfQ01EX1VQREFU
RV9OKGNoYW4tPmNoYW5uZWwpLA0KPiBlbik7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0
dXJuIHJldDsNCj4gPiArDQo+ID4gKwkJc3QtPmNoYW5uZWxzW2NoYW4tPmNoYW5uZWxdLnBvd2Vy
ZG93biA9IGVuOw0KPiA+ICsNCj4gPiArCQlyZXR1cm4gbGVuOw0KPiA+ICsJY2FzZSBMVEMyNjY0
X1RPR0dMRV9FTjoNCj4gPiArCQlpZiAoZW4pDQo+ID4gKwkJCXN0LT50b2dnbGVfc2VsIHw9IEJJ
VChjaGFuLT5jaGFubmVsKTsNCj4gPiArCQllbHNlDQo+ID4gKwkJCXN0LT50b2dnbGVfc2VsICY9
IH5CSVQoY2hhbi0+Y2hhbm5lbCk7DQo+ID4gKw0KPiA+ICsJCXJldCA9IHJlZ21hcF93cml0ZShz
dC0+cmVnbWFwLCBMVEMyNjY0X0NNRF9UT0dHTEVfU0VMLA0KPiA+ICsJCQkJICAgc3QtPnRvZ2ds
ZV9zZWwpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+
ICsJCXJldHVybiBsZW47DQo+ID4gKwljYXNlIExUQzI2NjRfR0xPQkFMX1RPR0dMRToNCj4gPiAr
CQlyZXQgPSByZWdtYXBfd3JpdGUoc3QtPnJlZ21hcCwNCj4gTFRDMjY2NF9DTURfR0xPQkFMX1RP
R0dMRSwgZW4pOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKw0K
PiA+ICsJCXN0LT5nbG9iYWxfdG9nZ2xlID0gZW47DQo+ID4gKw0KPiA+ICsJCXJldHVybiBsZW47
DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICt9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3NpemVfdCBsdGMyNjY0X2RhY19pbnB1dF9yZWFkKHN0cnVj
dCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4gKwkJCQkgICAgICB1aW50cHRyX3QgcHJpdmF0ZSwN
Cj4gPiArCQkJCSAgICAgIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjICpjaGFuLA0KPiA+ICsJ
CQkJICAgICAgY2hhciAqYnVmKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbHRjMjY2NF9zdGF0ZSAq
c3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ICsJaW50IHJldDsNCj4gPiArCXUzMiB2YWw7
DQo+ID4gKw0KPiA+ICsJaWYgKHByaXZhdGUgPT0gTFRDMjY2NF9JTlBVVF9CX0FWQUlMKQ0KPiA+
ICsJCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIlsldSAldSAldV1cbiIsIGx0YzI2NjRfcmF3X3Jh
bmdlWzBdLA0KPiA+ICsJCQkJICBsdGMyNjY0X3Jhd19yYW5nZVsxXSwNCj4gPiArCQkJCSAgbHRj
MjY2NF9yYXdfcmFuZ2VbMl0gLyA0KTsNCj4gPiArDQo+ID4gKwlyZXQgPSBsdGMyNjY0X2RhY19j
b2RlX3JlYWQoc3QsIGNoYW4tPmNoYW5uZWwsIHByaXZhdGUsICZ2YWwpOw0KPiA+ICsJaWYgKHJl
dCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXJldHVybiBzeXNmc19lbWl0KGJ1
ZiwgIiV1XG4iLCB2YWwpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3NpemVfdCBsdGMy
NjY0X2RhY19pbnB1dF93cml0ZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiA+ICsJCQkJ
ICAgICAgIHVpbnRwdHJfdCBwcml2YXRlLA0KPiA+ICsJCQkJICAgICAgIGNvbnN0IHN0cnVjdCBp
aW9fY2hhbl9zcGVjICpjaGFuLA0KPiA+ICsJCQkJICAgICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6
ZV90IGxlbikNCj4gPiArew0KPiA+ICsJc3RydWN0IGx0YzI2NjRfc3RhdGUgKnN0ID0gaWlvX3By
aXYoaW5kaW9fZGV2KTsNCj4gPiArCWludCByZXQ7DQo+ID4gKwl1MTYgdmFsOw0KPiA+ICsNCj4g
PiArCWlmIChwcml2YXRlID09IExUQzI2NjRfSU5QVVRfQl9BVkFJTCkNCj4gPiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4gPiArDQo+ID4gKwlyZXQgPSBrc3RydG91MTYoYnVmLCAxMCwgJnZhbCk7DQo+
ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gbHRj
MjY2NF9kYWNfY29kZV93cml0ZShzdCwgY2hhbi0+Y2hhbm5lbCwgcHJpdmF0ZSwgdmFsKTsNCj4g
PiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlyZXR1cm4gbGVu
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGx0YzI2NjRfcmVnX2FjY2VzcyhzdHJ1
Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiA+ICsJCQkgICAgICB1bnNpZ25lZCBpbnQgcmVnLA0K
PiA+ICsJCQkgICAgICB1bnNpZ25lZCBpbnQgd3JpdGV2YWwsDQo+ID4gKwkJCSAgICAgIHVuc2ln
bmVkIGludCAqcmVhZHZhbCkNCj4gPiArew0KPiA+ICsJc3RydWN0IGx0YzI2NjRfc3RhdGUgKnN0
ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiArDQo+ID4gKwlpZiAocmVhZHZhbCkNCj4gPiAr
CQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJlZ21hcF93cml0ZShz
dC0+cmVnbWFwLCByZWcsIHdyaXRldmFsKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArI2RlZmluZSBM
VEMyNjY0X0NIQU5fRVhUX0lORk8oX25hbWUsIF93aGF0LCBfc2hhcmVkLCBfcmVhZCwgX3dyaXRl
KSB7DQo+IAlcDQo+ID4gKwkubmFtZSA9IF9uYW1lLAkJCQkJCQlcDQo+ID4gKwkucmVhZCA9IChf
cmVhZCksCQkJCQkJXA0KPiA+ICsJLndyaXRlID0gKF93cml0ZSksCQkJCQkJXA0KPiA+ICsJLnBy
aXZhdGUgPSAoX3doYXQpLAkJCQkJCVwNCj4gPiArCS5zaGFyZWQgPSAoX3NoYXJlZCksCQkJCQkJ
XA0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBGb3IgdG9nZ2xlIG1vZGUgd2Ugb25s
eSBleHBvc2UgdGhlIHN5bWJvbCBhdHRyIChzd190b2dnbGUpIGluIGNhc2UgYQ0KPiBUR1B4IGlz
DQo+ID4gKyAqIG5vdCBwcm92aWRlZCBpbiBkdHMuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IGlpb19jaGFuX3NwZWNfZXh0X2luZm8gbHRjMjY2NF90b2dnbGVfc3ltX2V4dF9p
bmZvW10gPSB7DQo+ID4gKwlMVEMyNjY0X0NIQU5fRVhUX0lORk8oInJhdzAiLCBMVEMyNjY0X0lO
UFVUX0EsIElJT19TRVBBUkFURSwNCj4gPiArCQkJICAgICAgbHRjMjY2NF9kYWNfaW5wdXRfcmVh
ZCwNCj4gbHRjMjY2NF9kYWNfaW5wdXRfd3JpdGUpLA0KPiA+ICsJTFRDMjY2NF9DSEFOX0VYVF9J
TkZPKCJyYXcxIiwgTFRDMjY2NF9JTlBVVF9CLCBJSU9fU0VQQVJBVEUsDQo+ID4gKwkJCSAgICAg
IGx0YzI2NjRfZGFjX2lucHV0X3JlYWQsDQo+IGx0YzI2NjRfZGFjX2lucHV0X3dyaXRlKSwNCj4g
PiArCUxUQzI2NjRfQ0hBTl9FWFRfSU5GTygicG93ZXJkb3duIiwgTFRDMjY2NF9QT1dFUkRPV04s
DQo+IElJT19TRVBBUkFURSwNCj4gPiArCQkJICAgICAgbHRjMjY2NF9yZWdfYm9vbF9nZXQsIGx0
YzI2NjRfcmVnX2Jvb2xfc2V0KSwNCj4gPiArCUxUQzI2NjRfQ0hBTl9FWFRfSU5GTygicG93ZXJk
b3duX21vZGUiLA0KPiBMVEMyNjY0X1BPV0VSRE9XTl9NT0RFLA0KPiA+ICsJCQkgICAgICBJSU9f
U0VQQVJBVEUsIGx0YzI2NjRfcmVnX2Jvb2xfZ2V0LCBOVUxMKSwNCj4gPiArCUxUQzI2NjRfQ0hB
Tl9FWFRfSU5GTygic3ltYm9sIiwgTFRDMjY2NF9HTE9CQUxfVE9HR0xFLA0KPiBJSU9fU0VQQVJB
VEUsDQo+ID4gKwkJCSAgICAgIGx0YzI2NjRfcmVnX2Jvb2xfZ2V0LCBsdGMyNjY0X3JlZ19ib29s
X3NldCksDQo+ID4gKwlMVEMyNjY0X0NIQU5fRVhUX0lORk8oInRvZ2dsZV9lbiIsIExUQzI2NjRf
VE9HR0xFX0VOLA0KPiA+ICsJCQkgICAgICBJSU9fU0VQQVJBVEUsIGx0YzI2NjRfcmVnX2Jvb2xf
Z2V0LA0KPiA+ICsJCQkgICAgICBsdGMyNjY0X3JlZ19ib29sX3NldCksDQo+ID4gKwl7IH0NCj4g
PiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlY19leHRf
aW5mbyBsdGMyNjY0X2V4dF9pbmZvW10gPSB7DQo+ID4gKwlMVEMyNjY0X0NIQU5fRVhUX0lORk8o
InBvd2VyZG93biIsIExUQzI2NjRfUE9XRVJET1dOLA0KPiBJSU9fU0VQQVJBVEUsDQo+ID4gKwkJ
CSAgICAgIGx0YzI2NjRfcmVnX2Jvb2xfZ2V0LCBsdGMyNjY0X3JlZ19ib29sX3NldCksDQo+ID4g
KwlMVEMyNjY0X0NIQU5fRVhUX0lORk8oInBvd2VyZG93bl9tb2RlIiwNCj4gTFRDMjY2NF9QT1dF
UkRPV05fTU9ERSwNCj4gPiArCQkJICAgICAgSUlPX1NFUEFSQVRFLCBsdGMyNjY0X3JlZ19ib29s
X2dldCwgTlVMTCksDQo+ID4gKwl7IH0NCj4gPiArfTsNCj4gPiArDQo+ID4gKyNkZWZpbmUgTFRD
MjY2NF9DSEFOTkVMKF9jaGFuKSB7CQkJCQlcDQo+ID4gKwkuaW5kZXhlZCA9IDEsCQkJCQkJCVwN
Cj4gPiArCS5vdXRwdXQgPSAxLAkJCQkJCQlcDQo+ID4gKwkuY2hhbm5lbCA9IChfY2hhbiksCQkJ
CQkJXA0KPiA+ICsJLmluZm9fbWFza19zZXBhcmF0ZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1NDQUxF
KSB8CQlcDQo+ID4gKwkJQklUKElJT19DSEFOX0lORk9fT0ZGU0VUKSB8IEJJVChJSU9fQ0hBTl9J
TkZPX1JBVyksDQo+IAlcDQo+ID4gKwkuaW5mb19tYXNrX3NlcGFyYXRlX2F2YWlsYWJsZSA9IEJJ
VChJSU9fQ0hBTl9JTkZPX1JBVyksDQo+IAlcDQo+ID4gKwkuZXh0X2luZm8gPSBsdGMyNjY0X2V4
dF9pbmZvLAkJCQkJXA0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlp
b19jaGFuX3NwZWMgbHRjMjY2NF9jaGFubmVsc1tdID0gew0KPiA+ICsJTFRDMjY2NF9DSEFOTkVM
KDApLA0KPiA+ICsJTFRDMjY2NF9DSEFOTkVMKDEpLA0KPiA+ICsJTFRDMjY2NF9DSEFOTkVMKDIp
LA0KPiA+ICsJTFRDMjY2NF9DSEFOTkVMKDMpLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjIGx0YzI2NzJfY2hhbm5lbHNbXSA9IHsNCj4gPiAr
CUxUQzI2NjRfQ0hBTk5FTCgwKSwNCj4gPiArCUxUQzI2NjRfQ0hBTk5FTCgxKSwNCj4gPiArCUxU
QzI2NjRfQ0hBTk5FTCgyKSwNCj4gPiArCUxUQzI2NjRfQ0hBTk5FTCgzKSwNCj4gPiArCUxUQzI2
NjRfQ0hBTk5FTCg0KSwNCj4gPiArfTsNCj4gDQo+IERvIHdlIHJlYWxseSBuZWVkIHRoZXNlIHNp
bmNlIHRoZXkgYXJlIG9ubHkgdXNlZCBhcyBhIHRlbXBsYXRlIGFueXdheT8NCj4gV2UgY291bGQg
anVzdCBoYXZlIGEgc2luZ2xlIHRlbXBsYXRlIGZvciBvbmUgY2hhbm5lbCBhbmQgY29weSBpdCBh
cw0KPiBtYW5heSB0aW1lcyBhcyBuZWVkZWQuDQoNClllcywgZnJvbSB3aGF0IEkgY2FuIHNlZSB3
ZSBuZWVkIHNlcGFyYXRlIGNoYW5uZWwgc3BlY3MgZm9yIGJvdGggZGV2aWNlcw0Kc2luY2UgdGhl
eSBoYXZlIGEgZGlmZmVyaW5nIG51bWJlciBvZiBjaGFubmVscy4gQXMgZm9yIHlvdXIgc3VnZ2Vz
dGlvbiBhYm91dA0KaGF2aW5nIGEgc2luZ2xlIHRlbXBsYXRlIGZvciBvbmUgY2hhbm5lbCBhbmQg
Y29weWluZyBpdCBhcyBtYW55IHRpbWVzIGFzDQpuZWVkZWQsIEknbSBub3QgZW50aXJlbHkgc3Vy
ZSBob3cgdG8gaW1wbGVtZW50IGl0IGluIHRoaXMgY29udGV4dC4gQ291bGQgeW91DQpwcm92aWRl
IHNvbWV0aGluZyBsaWtlIGEgY29kZSBzbmlwcGV0IHRvIGlsbHVzdHJhdGUgdGhpcz8NCg0KPiA+
ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBsdGMyNjY0X2NoaXBfaW5mbyBsdGMyNjY0X2No
aXAgPSB7DQo+ID4gKwkuaWQgPSBMVEMyNjY0LA0KPiA+ICsJLm5hbWUgPSAibHRjMjY2NCIsDQo+
ID4gKwkuc2NhbGVfZ2V0ID0gbHRjMjY2NF9zY2FsZV9nZXQsDQo+ID4gKwkub2Zmc2V0X2dldCA9
IGx0YzI2NjRfb2Zmc2V0X2dldCwNCj4gPiArCS5tZWFzdXJlbWVudF90eXBlID0gSUlPX1ZPTFRB
R0UsDQo+ID4gKwkubnVtX2NoYW5uZWxzID0gQVJSQVlfU0laRShsdGMyNjY0X2NoYW5uZWxzKSwN
Cj4gPiArCS5paW9fY2hhbiA9IGx0YzI2NjRfY2hhbm5lbHMsDQo+ID4gKwkuc3Bhbl9oZWxwZXIg
PSBsdGMyNjY0X3NwYW5faGVscGVyLA0KPiA+ICsJLm51bV9zcGFuID0gQVJSQVlfU0laRShsdGMy
NjY0X3NwYW5faGVscGVyKSwNCj4gPiArCS5pbnRlcm5hbF92cmVmID0gMjUwMCwNCj4gPiArCS5t
YW51YWxfc3Bhbl9zdXBwb3J0ID0gdHJ1ZSwNCj4gPiArCS5yZnNhZGpfc3VwcG9ydCA9IGZhbHNl
LA0KPiA+ICt9Ow0KPiA+ICsNCg0K

