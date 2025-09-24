Return-Path: <linux-iio+bounces-24405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D354B99EC0
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 14:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F8D4A7A1E
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777C12FB090;
	Wed, 24 Sep 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ekMFLKrW"
X-Original-To: linux-iio@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB61F5F6;
	Wed, 24 Sep 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718056; cv=fail; b=t8XqG2z/+rmkQITG/cUozg0pabfS2yhuJnwTptnDctI/5DKF76Cogwj3pJFi46xzPbr927Ke3BTJpwwcdnDbyCq72URnIXFrPluykbtuXNRcqMsEJ7WRzGyuCw7qIrA0i0If+hP7WZam0pqfEQMLvFPzbY35POQMr/zK07y984c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718056; c=relaxed/simple;
	bh=Vb49HpUl3gpt2bUDpxCudWg11HmOaKPzAQdfV2Gs6+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QpRqFM1OzhmuOzgyZzepOTJIT/pQHpDwMaWUKLltmglWBaL3Ume20vKW+sTGIXQCXacXQ1gfS3OojnbQqw/MFH9UVB7AkZKkl1l2xW6OdpgSb0do9SwdE57ZpXrbj5Wh7/y0ePsPG8jBRBtD+9W61jT32+YV/u5ye8FAC2i6Zsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ekMFLKrW; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQvrhHjJuCvwU9Vj0WxHm81y7gMgDU5rT9XxDeZ5IU3+iV1G8yJ8cQVrvjxRkn8rR8rPI459cyYD5elI3jR/bkoHZVqYnbnUGwVUSbO5lTxhlVE3z0/LzemG/Pfnyle/SPJAIYiAxpr+d4UgEaePKrcTaCgFmGb803XgjW/q/A0E7K+D0HnSWimvOwfXPH03ui3mKuF3QrhxTB+ke7gMztOYyOWy+yyhR+dlIDz5bdSeDTDkM6qeX7yqXe6WHRb61lwz4kDdqHhy9x+lp2qGA5ZAjZ+4rSK1K8oQDj81HQd/tL0tOMwjmZL/kCl/7Q0Izsb8TDaE7xQRtM+wXpCEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb49HpUl3gpt2bUDpxCudWg11HmOaKPzAQdfV2Gs6+4=;
 b=s9zVm2qosHOdwfFG4YFOfhwCto3Pwbis7XGPc5ChiyyLjj9XKwJIPDzurnjGKeO7EaCF9JZbWHC0GopLcyD0Wkj50mJYdT+4+1+W6MRMHKiweIV5NGQlqa0QuilBhNq5uVwqjehi+Bj3hw34A8/TkW5hS+vMKUYGrZR1xFqJR2+cn/7mFZD88ZOdMnXC6dvCqZ/85WoDSooVrr9wf6M04YFYwhEPlRS3HsF75ROGcqglmkstnydtIl7/q2CHARm0d+r+SQmrVgiI61aRuNvXYaGVcKOEO9eOitzn17ZT/1NJ31Al2xpEkOmbP2rLapxjv0OeEhKTYAKa+ummeELLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vb49HpUl3gpt2bUDpxCudWg11HmOaKPzAQdfV2Gs6+4=;
 b=ekMFLKrWjPLFWg7B5VnUoxniYYqiVPfSEgzzWzXCQhdEliFqcA08oK/uL1myT1++baKF5Ag6oqT2nlbeXPw1xLV8EwvWVG1KGMa3vR34nRr9d/YDJLplOOozvnjrPrn+G3QjmMnSdVmekdltWeQxw+WcDsm8TA77baolDIR7GC8X9OOSjqhHVd7Kho2CxhmibvACio2OA3dBAIvMZZuIFfeJjBBHgFGaVmyaKqrhgeibJmHwH4VhFMYsAcMjuA19R6VIcz+jskx7VOpenNrmuyuu8HtQfC5fIQJpKfXfWZYagIF6V8tlMTf4mEZWfpXAYqBXuNZYqnnqQMVyYN1k4A==
Received: from SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 12:47:31 +0000
Received: from SN7PR11MB7511.namprd11.prod.outlook.com
 ([fe80::a6be:ea2e:cd4a:d1df]) by SN7PR11MB7511.namprd11.prod.outlook.com
 ([fe80::a6be:ea2e:cd4a:d1df%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 12:47:31 +0000
From: <Victor.Duicu@microchip.com>
To: <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Marius.Cristea@microchip.com>
Subject: Re: [PATCH v5 2/2] iio: temperature: add support for MCP998X
Thread-Topic: [PATCH v5 2/2] iio: temperature: add support for MCP998X
Thread-Index: AQHcKI5qV9HbX++jWEyps5aLO+F5SLSb6SgAgAZofwA=
Date: Wed, 24 Sep 2025 12:47:31 +0000
Message-ID: <42a376a9451ed340e0aa7f1c01a16554298c0693.camel@microchip.com>
References: <20250918111937.5150-1-victor.duicu@microchip.com>
		<20250918111937.5150-3-victor.duicu@microchip.com>
	 <20250920115554.36dc4de1@jic23-huawei>
In-Reply-To: <20250920115554.36dc4de1@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7511:EE_|DS0PR11MB7767:EE_
x-ms-office365-filtering-correlation-id: 96f7e2ba-bdc5-40fb-1a31-08ddfb6886b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUN4eXdmK0htTURmTGNyaTlyYmhNZy9uL0JIai8yVkFkWkJsam1aaFFUWEIw?=
 =?utf-8?B?ZXdSdkF2UzA2bHZ2R08rcWZ6eHBscnZ6VjVSMUFzbmp1Q0t5RXIvcEptbGdL?=
 =?utf-8?B?NU1LSS9WZG1XQnViQWZXZ3Z2TENNMzBjY1AxRGg1aTVNNWpvdmxMU3QyTDVx?=
 =?utf-8?B?YUlacWY2SWFTenJYNUxLemIza0dvazhXb1M0K1Y1aHhtdkhXUXJqeVd2M3VM?=
 =?utf-8?B?bkU2R09oTmN2bUUreTBTY1NGU1plMDN4WGxrSVBwU2dDbm8xeDdnNjdWVWlI?=
 =?utf-8?B?TUFYN0J0TmpVUy9lVnluR3QrZWtGVWZKUW0wQVBvclo4a3ZiL2ZjTGlHQjFR?=
 =?utf-8?B?c044WEEwTFZEVzZWSFhtQ2NqT1g5dEdlNldDM1VRZmVxbHdJUGFJd2dmSjdV?=
 =?utf-8?B?WE43WnFUUzVQckRwbzB0aG9BSERwSUVjV1JCNEppMllWYzh6TjFQODc2dURq?=
 =?utf-8?B?OUJXUFkrcmcrSC9mdytVTUtwQVh0TGp3dkpmcnU1TmpVRnRKSVRmeG53Zmtk?=
 =?utf-8?B?eERxNG9ZL3pTM0JjdEJWUHd3L2JyRE1OdzhvSHJoQTMwUWRaNzFMRkxjOG5a?=
 =?utf-8?B?d1ZWK241cTJvMVhPanR4OC9oYWRkRElrTTdUc3I3eXp2bTd5QzBHWG44N0V4?=
 =?utf-8?B?NG9UNzYxRVd4bHFLYzBCQ0UwWW5Ra1gwMlVLMTEybnFVVnQzMGUwVStSb05U?=
 =?utf-8?B?d0UrOFNzWUI3YkYxMGxYM3VqemZpZmNtcHh5SExTTFNCeitpcnJEZi9BamFw?=
 =?utf-8?B?TnBmSTdwMzJCbzI4ZDBrdCtaUWxDb1g1M1N3V0UvTlB1WDcyV0ptWnEzRmww?=
 =?utf-8?B?aklOZVdwcmRhVjlzdmN4Q2pjWXI5aXZ4Qnl0M2ZYT3NQY3dEbFJrNGVDMW1a?=
 =?utf-8?B?bUY3YVpiTEUwVDA0Mlg2cFZuTnZGdElwVDRva1pRZUphMTZaZjBOYXYwTS9m?=
 =?utf-8?B?ZnRFU1BsOXBSRkMzUC9HczlxSnNlYlUyenpvWWttOTV6OERnV3M3aGRub2Zu?=
 =?utf-8?B?QmhpTFpyRDVscDF0SDZyN2VSTithdTUwYXRQVWlkL1g0ZjlzV3Y3UlUrcUtS?=
 =?utf-8?B?ejRiZmdjOXl6czcwd1N5UXNRY08yWVd5QVN1NGlsN1hLMkZVN2lNaVBlcTNm?=
 =?utf-8?B?WlJ0OUlPOUFoQnNYL1Q0VnZEbTBHWXRCR2FoSU8wQjJxTDJ1Q0I3QnI4dVYv?=
 =?utf-8?B?M0RHRG1meW5tT2pJZCtZalZvSWV2WWQ0bWJVNmVPeEI4Tk54dkgvSldnNlJm?=
 =?utf-8?B?MEMyUWM0SnU1Nnhyc09ZRlFJYzFTeVVJWXN3RmlESTZOQXBUd29zYkhQOW56?=
 =?utf-8?B?b3ppMExsaC9qdkw0RThhUXZ6SkFhZnlPMUpzSFFCQTA5d1ZmRDREUUxzTlpz?=
 =?utf-8?B?NzN3ZlhlZUZRdVoydk9vaEQwK3dCUHNMbDA0MXJUNXR1bjg0ZXlzM0pxUzZp?=
 =?utf-8?B?SmFRVDgvdUlja2NraFo4a212YVFRbVI5VTEwMnJRZ3dQWVVCREhkL0diQkox?=
 =?utf-8?B?N3Y1T2QyRnJkdGFKTWFDUEVTV2xXMHVMdk1wRVNsRlJCL01hZnM2UXpGVjJM?=
 =?utf-8?B?RXd4ZFRHZVBSeHhmYWtKLzUydUF5dDNraTRRMGtlMzFJSjJOeEp3M25zQzY0?=
 =?utf-8?B?OEVPSHU1OW9RY3V0d3gwWmRjTitVZndra0llMmZBRFV3djVWL2g1SGtxdVBW?=
 =?utf-8?B?bThQQ0ZYWjRZMEZqdFVPRHpiNVJScWlrdXRGSk9zejkwSW9WWTBjMm1TWXZr?=
 =?utf-8?B?TnJZOGZHZi92R2M3d0RJalVIREgwNXo0dzdZb0cwdE02UFNwN1o0bjRQeDZT?=
 =?utf-8?B?SkhvQXR4dmR4RmNZRGpqaHB3MjBFcGRUVlRDQS9LM3dGQjFHaXV0blFJSnJt?=
 =?utf-8?B?QlVQL0psaWVoU2xkaDZvZDJOc1V0cU9uc20zVkpTb1VoL3EwQmh2L1h5eEhn?=
 =?utf-8?B?SUtYUnRHQVZZMGJtT09NbE4raU1VZVhvMGs2SnczbEFLaUxvUWtuRUpYNHhP?=
 =?utf-8?Q?0/5fEQ2dJsoS9Dn97JEq2sGXmjmV1U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7511.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cS9jZjlyL2VNeGhhaHRGbldmUXg3eVBiWDZ2bjFiWlhncXRhakFSRGZtdUtH?=
 =?utf-8?B?OFQrSDdYeGYxR2duMHFnNUVNbVVYa3UwQ1E3RHJjMCtlNkJXZ28rWmJoVVRa?=
 =?utf-8?B?SUxENFJDY3dqYlc4alBzREY4YmhGYnZydVU4Y3dza01nRjd5ekJJb2VVdThG?=
 =?utf-8?B?SzhCMGRDeW1GYTN1em5Sa2NEcUFHcHRKZ3NaSG1kVHV3c3RVcGdXL1U5dVVs?=
 =?utf-8?B?c3JJZHlpWEtXN0JtcUZPYkJ3YlNOajJwNHlIRXNPRmpsNnBLTytRakFaSG1M?=
 =?utf-8?B?SzVvMHpFa29kekVLZ3ZjTE8xUEZuMFdnbkdKOTJONy8wVFlGTUt5bWJnVnN0?=
 =?utf-8?B?UnRzVGZBZ3JQSWt6QS9QMWJLQzJQNTFkWkpDTGx1V1kwZU52SkMweStCQU5J?=
 =?utf-8?B?MGdDNGNrREMwamF6dnEyVVpJbEYzdkFLVlFmSjlXL2F2MVV5QTREV0N2b1ZR?=
 =?utf-8?B?VzBNa01JSDZzSVgyR2poUTdtT0htNGFVUC9OL29FQkNiT0ExNkNsUmtZbHov?=
 =?utf-8?B?MVlLUU13cDMwV2F6dU9UcC9PdVc3TmN6S09hY2E5Wk5sUkhtajZTR1V0enM2?=
 =?utf-8?B?Wi94d0hzVUtVWGtmc0k2OWhtMmRVYTF1Mmk3RUpqUnJCRG55K1VHQk9JdFZF?=
 =?utf-8?B?aHJVK1VzbThuTlZEaytRekU5VVVocEtidXlMNnF4QWNGSmdLVStpY1Fpdk9E?=
 =?utf-8?B?bUNuUmwvY243R1V0VEdOZENtMC9ib2Y3ZkErK25iN0RUTS84WEdUUjRMandQ?=
 =?utf-8?B?d3BEelZqb045cDVsYm95bzJzNnorZUJWN0lPRGFYNGx6czVRUzdmUVhHK0dH?=
 =?utf-8?B?Ymo0cWllblhIRkhBTnVNRkdERlpuM0lzSFEyOGEvUFBCM1R0R2M0dnJtT3Nu?=
 =?utf-8?B?YkVFRUxsRjFMOGIvY3hkWEhJeVF0RnpzRHdYUVo1bHNmcisrRnVTck5QcUQ1?=
 =?utf-8?B?bGZpZE1GNTQxenFHeDZnSktKeVZFN0lOaEJReUpMQ0d0Q3NmdWljRUtYQysw?=
 =?utf-8?B?SksyVFFtSnRmd0lwb2VDWTkvN2IwVzluMExQN280OFZSYlUrRWwxVnVHd0tG?=
 =?utf-8?B?YlRGQU1Kc0ZqT21HMkFQdFRmRjU0OGxybndnbFBORmFSSFZ1ajBWY0ZTVENT?=
 =?utf-8?B?OStFeGtmVlNkSWpZeWU2UEEwNi9HT01rUytPRnUrYXNSdjc3eDVjTTFGYjZw?=
 =?utf-8?B?cVJkYUFqUlMvTVJLQjVQblNQK1JQTEU4c0FxWEwyZUpWei8rcytrQnFVYm9H?=
 =?utf-8?B?azVHYjRnakhLOWNkNjIrYWZWU1M3YkI3N1IyK1RkT01jbmd2UlBYcmFEdU0v?=
 =?utf-8?B?Zk5IVWhsUTFyc0ZJRmVqYUl1bkxibCttdzFSaWsvaFpDVmVZY1R6ckNzd2ZF?=
 =?utf-8?B?bjU2ajEyQlgzQkM2YTBDQkZSRk5IdmlIYTRkTzRvQURyMU1MZ2lEKzJzWkJk?=
 =?utf-8?B?YmFWRzl4bmdtSVNDMUJzWnJVZjl0a1p4TVM3eG1lN083b2VxQVhOT0lCNjds?=
 =?utf-8?B?bVFoOTdFRitYUU02b2FWY0dZSlByODJGd0VQOERWS3RLZXlnam5YeitTZmRP?=
 =?utf-8?B?YTZRK1QrSUhBMzQrZEVUTjBnU3NVOTFyb1A0V1NOamUwWVhRdFJ4YmFGSkN6?=
 =?utf-8?B?Skw3aTdkOCtTUlB3bDJlN3VNdENoYWJzaHBzdTFUcGZCOUdQNXlkanVyR1lF?=
 =?utf-8?B?YVhNT3dYK3Bsc0I4QWxuY2pRUGRwZ2ZkeUdIejlmZ1BIcDdQY3dNUEdnZGFW?=
 =?utf-8?B?YW1WeEkxNXBkVGFLS1o0TnJGRi9wMVZ2OUFheHFLVXdWOW9QdytLK3NzZ3RY?=
 =?utf-8?B?QnF6T1ByaHF4L29sek1IeGQvRkNpaWx3U01KVzZlUDVmSkhZNUdybnA5T3dQ?=
 =?utf-8?B?M3hzaTVhMklITjc1Sm9WL1I3SVFkRnFIckdRYjZ1Q3VnaGhHMGZpN0c1dmNX?=
 =?utf-8?B?ckpvS3pjUWRJeTlUQXhLYlg1SEkzdHhEWWhsTGsvOFV5dmUyRnFqRXh1TklQ?=
 =?utf-8?B?b05PWVY2bkgzWTdaUGVhb0RnTERReFNpUE9MUmVER1lWT2h1TUdHSUw3ZWpo?=
 =?utf-8?B?R1RPa3VYcHZvelJrcHpUMmNkYk5TZHhmeHlvZWNxUExJTmMrMUNERUEwQlVr?=
 =?utf-8?B?MkczMi9rR1NXQkovN1A0V1h2TEgzNExLeUFWQjByVEtuSkU5WklXaDd4K0FY?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DD065382F4EB145A8E73C79DD0E7DF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7511.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f7e2ba-bdc5-40fb-1a31-08ddfb6886b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 12:47:31.1515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ghl7jorNXKgH48I6YuYY8NqYDyISLx4/GuUOoVFcvPuiFwbp1a4LkCV4hWWA78tznYcoMXPuGwXmjbzzh7Bv/kwVZIegX2POD1Bvv5tj220=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767

T24gU2F0LCAyMDI1LTA5LTIwIGF0IDExOjU1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlCj4gCgpIaSBKb25hdGhhbiwK
Cj4gT24gVGh1LCAxOCBTZXAgMjAyNSAxNDoxOTozNyArMDMwMAo+IDx2aWN0b3IuZHVpY3VAbWlj
cm9jaGlwLmNvbT4gd3JvdGU6Cj4gCj4gPiBGcm9tOiBWaWN0b3IgRHVpY3UgPHZpY3Rvci5kdWlj
dUBtaWNyb2NoaXAuY29tPgo+ID4gCj4gPiBUaGlzIGlzIHRoZSBkcml2ZXIgZm9yIE1pY3JvY2hp
cCBNQ1A5OThYLzMzIGFuZCBNQ1A5OThYRC8zM0QKPiA+IE11bHRpY2hhbm5lbAo+ID4gQXV0b21v
dGl2ZSBUZW1wZXJhdHVyZSBNb25pdG9yIEZhbWlseS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTog
VmljdG9yIER1aWN1IDx2aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNvbT4KPiBIaSBWaWN0b3IsCj4g
Cj4gVmFyaW91cyBtaW5vciBjb21tZW50cyBpbmxpbmUuCj4gR2l2ZW4gdGhlIGJ1aWxkIHdhcm5p
bmdzIEkgZGlkbid0IGVsZWN0IHRvIGp1c3QgdGlkeSB0aGVzZSB1cCB3aGlsc3QKPiBhcHBseWlu
Zy4KPiBTZWVtZWQgbGlrZSB0aGVyZSB3YXMgc2xpZ2h0bHkgdG9vIGhpZ2ggYSByaXNrIG9mIG1l
IG1lc3NpbmcgaXQgdXAhCj4gQWxzbyB3ZSBoYXZlIGxvdHMgb2YgdGltZSBhcyBJSU8gaXMgY2xv
c2VkIGZvciB0aGlzIGN5Y2xlIG5vdy4KPiAKPiBKb25hdGhhbgo+IAouLi4KCj4gCj4gCj4gPiAr
LyoqCj4gPiArICogQml0IGZsYWdzIGFuZCB0aGVpciBtZWFuaW5nCj4gCj4gQXMgYmVsb3cuIEkg
ZG9uJ3QgdGhpbmsgaXQgaXMgd29ydGggZW5jb2RpbmcgdGhlc2UgaW4gYSBiaXRtYXAuIEp1c3QK
PiB1c2UKPiA1IGJvb2xzIHRvIHJlcHJlc2VudCB0aGUgc3RhdGUuCj4gCj4gPiArICogQFJFQ0Qz
NF9FTkFCTEU6wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdGUgb2YgUmVzaXN0YW5jZSBFcnJvcgo+
ID4gQ29ycmVjdGlvbihSRUMpIG9uIGNoYW5uZWxzIDMgYW5kIDQKPiA+ICsgKiBAUkVDRDEyX0VO
QUJMRTrCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGF0ZSBvZiBSZXNpc3RhbmNlIEVycm9yCj4gPiBD
b3JyZWN0aW9uKFJFQykgb24gY2hhbm5lbHMgMSBhbmQgMgo+ID4gKyAqIEBBUEREX0VOQUJMRTrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdGUgb2YgYW50aS1wYXJhbGxlbCBkaW9kZSBtb2Rl
Cj4gPiArICogQFJVTl9TVEFURTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjaGlwIGlzIGluIHJ1biBzdGF0ZSwKPiA+IG90aGVyd2lzZSBpcyBpbiBzdGFuZGJ5
IHN0YXRlCj4gPiArICogQFdBSVRfQkVGT1JFX1JFQUQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHdoZXRoZXIgd2UgbmVlZCB0byB3YWl0IGEKPiA+IGRlbGF5IGJlZm9yZSByZWFkaW5n
IGEgbmV3IHZhbHVlCj4gPiArICovCj4gPiArI2RlZmluZSBSRUNEMzRfRU5BQkxFwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMAo+
ID4gKyNkZWZpbmUgUkVDRDEyX0VOQUJMRcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEKPiA+ICsjZGVmaW5lIEFQRERfRU5BQkxF
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMgo+ID4g
KyNkZWZpbmUgUlVOX1NUQVRFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDMKPiA+ICsjZGVmaW5lIFdBSVRfQkVGT1JFX1JFQUTCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDQKPiA+ICsjZGVmaW5lIFVTRV9QUkVWSU9V
U19GUkVRwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNQo+ID4gKwoKQ29u
c2lkZXJpbmcgdGhhdCBJIGFtIHBsYW5uaW5nIHRvIGFkZCBuZXcgZmVhdHVyZXMgdG8gdGhpcyBk
cml2ZXIsCkkgdGhpbmsgdGhhdCBpdCB3b3VsZCBiZSB1c2VmdWwgdG8ga2VlcCB0aGUgZmxhZ3Mu
Cgo+ID4gKyNkZWZpbmUgTUNQOTk4Ml9DSEFOKGluZGV4LCBzaSwgX19hZGRyZXNzKQo+ID4gKMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiBXaHkgdGhlIG91dGVyIHNldCBvZiAoKT8KCldpdGhv
dXQgdGhlIG91dGVyICgpIGNvbXBpbGVyIHJldHVybnMgZXJyb3IgIk1hY3JvcyB3aXRoIGNvbXBs
ZXggdmFsdWVzCnNob3VsZCBiZSBlbmNsb3NlZCBpbiBwYXJlbnRoZXNlcy4iCgo+ID4gK8KgwqDC
oMKgIChzdHJ1Y3QgaWlvX2NoYW5fc3BlYykKPiA+IHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC50eXBlID0KPiA+IElJT19URU1QLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5pbmZv
X21hc2tfc2VwYXJhdGUgPQo+ID4gQklUKElJT19DSEFOX0lORk9fUkFXKSzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLmluZm9fbWFza19zaGFyZWRfYnlfYWxsX2F2YWlsYWJsZSA9Cj4gPiBC
SVQoSUlPX0NIQU5fSU5GT19TQU1QX0ZSRVEpIHzCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgCj4gPiBCSVQoSUlPX0NIQU5fSU5GT19MT1dfUEFTU19GSUxURVJfM0RCX0ZS
RVFVRU5DWSkswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCgpLaW5kIFJlZ2Fy
ZHMsClZpY3Rvcgo=

