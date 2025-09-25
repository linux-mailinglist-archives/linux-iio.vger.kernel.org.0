Return-Path: <linux-iio+bounces-24435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F6CBA0021
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 16:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EB0167528
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041E42C234F;
	Thu, 25 Sep 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Brg+Wosi"
X-Original-To: linux-iio@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42011FCFEF;
	Thu, 25 Sep 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810461; cv=fail; b=vFhd6NA6eQvw7eC6hAyXU7k1wAsnhNnztanId6fXqbdY2wj2SDl0ylSoo4hQs/jrNCSnUkK5+AsWZYwr5QJzVjo2y3I6CE+ft9O1LcxVLXN82biIF14i2yANQb9jcs2z55QfJqo4J74sSiuSdQ5sfLMltZK/wZYX8tSXm644CRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810461; c=relaxed/simple;
	bh=DkIKUw2rRCSpU/aR6BGTqHm4DqV16iI7ITKsi+W3Nn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7849RfvOeYyA2+uVcQBlqsqjAW+2c1I3zgkKEDX89VIlroCZr8Vx7VHG06izZvfL+ggPnWYBGb9y16AoNKzuVm1IFMUts5FTmvwVOFVzohXdrKq3zX6X3tiFlKjAefawW0j/X5YA656LBs4Gw5MBw5wx3qdFdDndEx1yPDQJ0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Brg+Wosi; arc=fail smtp.client-ip=52.101.53.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OH45Hh73fdwPmBTew70jHDqgnTCq+3SFv+gaDdBMYrAX/9n4Ih7V6wZBaO/6HR3FKZT/k2a/qcYJk4fix2EYZwclWtAfvkWSyYs8fYeFMMmUA9DpzwuXg+pxrlMKKIxvPCKuIdPCJH9UObgt6CmtwEysrhRl//R0I9IBhE3AIspdCfwXzdyNn9FZIEZ+lNrPzLbnS8dypMaf8LA6uqGyYSaQSMfJn/McZNkmVe2pAmVrFI2fqA6KRFRYfGiRJ7Cil8JDcReMzFtlB8h0MmEC9dcT1ZUh4S08VStKeQtYNeXSbaPYWGsnrW6vXIqyuLAu1mpBljQKkfFPqjg1mksGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkIKUw2rRCSpU/aR6BGTqHm4DqV16iI7ITKsi+W3Nn8=;
 b=BJwFsLKY8KDLhZvGswnv03JQFr1W5Q8QVL1m4QS1dpzpoBYO3w/FgHyrRsNu0sIecZd+Ox766wy9/8uRQNk9LiQeLGkMsheel3u9anVweFUhyG9w2MwZh1dPGUE+bOMeXki20U/65I/8fzISUB9Z3fihaw79vl0ZbnFW9najZ6e4Wo2bvL2KBby5uXUfnudAXEuK/fjB4N8fYA8mu18iT5Zi/JmYheD7DOjQIYChOeLaw28KfT35lLTCdDeYb6Xgtf3QzJaxhQPQanncO1IuY9JsG3QOxib8pUm30YaUgkSK7dUV9LJ37QJS32S2DZOolX6YA0hGp69C8W8v/+a1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkIKUw2rRCSpU/aR6BGTqHm4DqV16iI7ITKsi+W3Nn8=;
 b=Brg+WosiKAOLBw63PzZ+1iMl/psm8H/9jFF3zh+O79boanbSgQc3e5irnZ8Agw6CvJyIEaFNswdwuv1jXWKqOPoMlC8v0zglXI9fYlU+jijmfb8mTN2GJqD8M5v8xm8Gz+ImtDnTqNZv2zxHtDAdDRGX4bsqsh+EAIS0xPT1AAcdNC2/dEr3vRuSoiNkNKr5jalIN0zyb1iYmcohGzSUFXFDNVxsRiOlIFk4L2Y8gUsxICThV8sOOrkI481+sHpfBdekO0aowFb8jn+q28Ee//VuxCZcXWdDoor8vjObc+NI6Z4lWdLsv/MYwNbXQEDzJM9kOfGW7yt7S+0LsARopg==
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by SA1PR11MB7129.namprd11.prod.outlook.com (2603:10b6:806:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 25 Sep
 2025 14:27:36 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae%2]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 14:27:36 +0000
From: <Marius.Cristea@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <jic23@kernel.org>,
	<nuno.sa@analog.com>, <dlechner@baylibre.com>, <conor+dt@kernel.org>,
	<andy@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: add support for
 EMC1812
Thread-Topic: [PATCH 1/2] dt-bindings: iio: temperature: add support for
 EMC1812
Thread-Index: AQHcJ83FPaMIgUra40qI+G7qPK2KobSYB5UAgAv54YA=
Date: Thu, 25 Sep 2025 14:27:36 +0000
Message-ID: <afd35ed13aec9f895335303e078926491885b9a9.camel@microchip.com>
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
	 <20250917-iio-emc1812-v1-1-0b1f74cea7ab@microchip.com>
	 <0bc1b77c-bbbc-4e8a-a792-fb7e30a2a789@baylibre.com>
In-Reply-To: <0bc1b77c-bbbc-4e8a-a792-fb7e30a2a789@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6005:EE_|SA1PR11MB7129:EE_
x-ms-office365-filtering-correlation-id: 82010598-40a5-44bb-9772-08ddfc3faca7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1lheUdyTW5UemQxZ2xhZ3BwWWptVS82WCtrL2lPRFVxVXNNb3RoWnJXR3Vs?=
 =?utf-8?B?YjVISXRPSWp1NzZrd3EwTEU5VVJJRXd4clJlem9HRlkrOWQxUHpOYnkyQWRT?=
 =?utf-8?B?NXRTNFM4eVlvUWR0TndMRWpNWVRjZkdIczBUVXZkS082Rm9TZ2Nxd0xXNFU0?=
 =?utf-8?B?M01WMDZHS05SQVAzaUdOUml5TVVvUi95ZUt0TENISk1DbWJ1bGhSQjVQOUQ3?=
 =?utf-8?B?elpJS2YrVFRIaG5peUFTeGQvUEhpK2RkdjRpVzI0cXMzQVNCMlJtTzFDallO?=
 =?utf-8?B?Zk9TcGlxU2RnYkwxQTdla3JoS3JWb2tBVWpoOWtEbUQvL09ORHcwRUpUUFJM?=
 =?utf-8?B?VERhWUVDSnVGRmZUTGJuWFQ1cTQxdElqeTRGOG9DR2VNYzljZkN4Z0xQZm41?=
 =?utf-8?B?UUxHT242NkQrRmdna0ZKVGNJa0pZeE1zSEtnMEdnM3lnaFV6ZmFwN2t1WGhK?=
 =?utf-8?B?VG1LalpRTFdBcGtOek5ZRmdLKzJQWkxGRndNUG9NckZCUWRib3RCSmU3c1lI?=
 =?utf-8?B?U2IvNGRtMEVYV3JSYnd2bDdaenVNVG94YmZLaWhoWnRWbFpIbGFBOEVNdDB0?=
 =?utf-8?B?R1NabHpVd0o4N2wrK2tnbTc5WEc0S3puZjZIR1dSTEIrbTVzN1JCclhCdEd6?=
 =?utf-8?B?SmJhMjNHMzQxYWYyMENiTnFxNWk4d1JRbGVjMlBUV2Uxb2cwZHRmYS91NjQ0?=
 =?utf-8?B?NU1XUWM0ZGNPbzJ4K3QxeERSdzJEMTJRTjM1dHhtWnpMNnhQNTUrcmdlQlRN?=
 =?utf-8?B?bmpYS2NjU0pKU2FGUWJMdnRiZ0VTZUc2Y1RPV1JRVFBpZkdxWU9XenFxQVRj?=
 =?utf-8?B?WHk5WnVDVmwvU1gxVGZyMFB4Q2FtM2dHR2pxZ1c1QTM1RTQ3VlEzK1VyVnBx?=
 =?utf-8?B?azhkbzFlKzlrY2s2MXYvMlRiQmVBQllnWTRqRzluR1NqL2dzeXd1N1hyWTZZ?=
 =?utf-8?B?QS9mZFRqREFMbWR3NENPS1g1b1h1MUpPaC96MHpvZEpQZGtrWWFUY3BtWGZX?=
 =?utf-8?B?Q0VJSmlEZHNodCtZYmZlamxDeExwc3BwVU9BakpUcGdxQWdDOWk3RVJ5Si9W?=
 =?utf-8?B?K3AwWU1rYzBhYno5bFlOZnZYWXJFZ1p6dmc4RVlkc3pRQjZoYmRtUFkyK3hK?=
 =?utf-8?B?VUxKMUhYcmlKbVUvd2N0WWErdVNwNE02NjdwYmxLR2hVZ3BGUVJ5alB3T0M0?=
 =?utf-8?B?ekh4YUNtTUJXOEFwQmU2WjNCNlBWd3d4bm5nSjAva3hBOHhQMFZRaFRFODli?=
 =?utf-8?B?T1I5ZTNOVkR2UnNQT2hVb1ZpQTI3cU83S1ZpNW83RERJSVI3YlRFc243ODhE?=
 =?utf-8?B?MHcvbkpZSFYrM0VBVDhmUmQ0UFdtbVU0eXUzamw0anFJNmZuRC9aOHBKYVpJ?=
 =?utf-8?B?dXMxWjJQZWdrVjl6bnpwOXpQYjBLN3p4WkZ1Y2R2YXdkUFZqTlU3RFI0UDc5?=
 =?utf-8?B?MnovR3EvcGJEVWFlL0p6TjlUODhCVjRubE5tVTJxWDBSbFB5d0VPT3loc3Qx?=
 =?utf-8?B?bkIzZndNdFd1Tnc5dGhqQjFxTGhCL3lkTDlzT1NQMGdVRzJRMUkzNnRqVFFs?=
 =?utf-8?B?UkdTYlozN1BQQ1l1VEM5bmhaVWVIRlZoNGtYaStISTNKTHRtTExHNGhOd1BC?=
 =?utf-8?B?NWZ6RzFkNFhjazhaRGVxRFlyNVhVcHB1MFRHRmpWbVh6Ukd3YVRPeDIxNHlK?=
 =?utf-8?B?ck9sN1creDRDSkZCRXVZSkw4UmVsUFpISWhLSmczTEdjOTI4VjZXK2ZKZTRx?=
 =?utf-8?B?OEUxdjh2OUFXYzFUckc2b1Z2WWt4cWplM3Z6ODE5ZkhVNyt6enFrdTVhREtT?=
 =?utf-8?B?VXVpNkJFejVYUDR0ODZuMVFCMnFvMU1sa1F4Y0JKdm1peWNuUkl1dVhwSkpN?=
 =?utf-8?B?MFJPeWpENjhPUzBldTZSUm94b0VrN2VPeXZvNURZQ1BtdWU0amhVL05UMUFq?=
 =?utf-8?Q?mamehvkclIHLqaDSMnBY2OsAettR8IhB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Kzd6dTNoSW1Sdzdvd1NiQkFqNkI2WGtmRG9hUTlRaXFQc21kYWp6S3d1NDRL?=
 =?utf-8?B?SEI0RTBrVFhqNGp4U3BDYytaeWNJSUhtNDFZc2I0aVpnbVFrTlhFd0VzQzdQ?=
 =?utf-8?B?MnMyNHhDeFROWFVhUFVNNTFWV0FtdmZFMzZNbGkvQ1ozUjJrQkZNZHhadWI2?=
 =?utf-8?B?U0JnckNYelZhSlAzd2Y0TFA5RDU5TlBLTXBtd0VPU3FvOTUrYk1VVGVOM0Uz?=
 =?utf-8?B?MXBVS0NQYTFJYUw4SHREWUlCYUJLaVFjR1h1dWk5NWVpZjNRclJUcy9BMlhh?=
 =?utf-8?B?ODgwa05Fa1J0VDRsbnppdWhxYTk4SnYwOGZoODdLVmRrTHVvZGhtZThqdkJW?=
 =?utf-8?B?NlNPY21zYWpaV2kzUEZ0ZnRiamJkYjl3RkxOWkNjaGZ2UDhGVndoeHBOelpQ?=
 =?utf-8?B?bmh1TE5tZFoyVmg3K3pjTjluTFRYV1h2ejFjRzl4NmZOalhRREpUQmw2NHBm?=
 =?utf-8?B?YlQ3NkxQd2dIWjFQVmhFcEtRdFduMFJ6T1E5VFdRb1QrOHpqQW1ES25QdXFH?=
 =?utf-8?B?UmQ4cTRDVm1rN2xOMkk5WWhpTTJjVGJla3VRMGJ0UkxBZ2lnMUtCUGtaVUpr?=
 =?utf-8?B?S0lDNFRMUlpWUHFjM1lTV3lpM1p0VTBFeEoyNEo3OXd1OU5NR0JsQXFhQ3Zp?=
 =?utf-8?B?SzB1WS9iNkt5MmxwTG1sTGNEanBZbkpETkVkOGFmUEV6Y01CbExiTkhvWEVZ?=
 =?utf-8?B?anJhU0habnVnSzB4MW8zT2NGcXpCaFhYdkNoZWhxK3NnQ3lQMndKZVA3R3Ix?=
 =?utf-8?B?WWpENVdmc3VNcXU5Z3JPMFlzbE1UWTFldTFrcjdkOG9iTExGYlhNVXNUVWl6?=
 =?utf-8?B?dUw3R3VtMnM0cHhoMXlmSTIvaXpPTDNWcVRBaUZySUozanI0SUtDSjg2cVZs?=
 =?utf-8?B?TmQ2WVdMNzJlMTNQTWdzekd5S2ZvTVE4RldOZ2FEa2JtUi9RbE5vYW4rdzkv?=
 =?utf-8?B?VDhZUjNsN0MwcWlDRFpRL2tydzVWc0ZPMUFGREZxcFhTWVgzNG4xSjFsZDNr?=
 =?utf-8?B?VDhGS25LTXFiZExxTXdyRC9yYzUrRTFEcS9BbDFFanlUL2JkcFZDVEhnOWFu?=
 =?utf-8?B?QlV2T0RVa1dxeTFlUjFyTUJKazZiaHF5aVF5MGZ5a2pIUUVLRmVleGFOV3Bp?=
 =?utf-8?B?Q1hhZ0drQ2VQVHR2VmVBbXlUYVNQTzhOVkpQLzNIOSsyZHlDR3BWdU55NjVt?=
 =?utf-8?B?NExUa2NuN2tlbGFPeUhWd2lJOXlOSXh4L3gxSm91akN3QjFuSnZoc1VqbTdS?=
 =?utf-8?B?QVFLUTRpNTVBcFBtbVYrVHk1NnlHbTJUQ09EekViNDhLbjFGdHBRaVUzczAr?=
 =?utf-8?B?T2lWVVZCQW1ndnZhUjVPaW53d1lCWnBreHNlUHY5VzFHSUtCMVBxQkdLa2tp?=
 =?utf-8?B?azFldEVrb2RPb1lmVUg3azhzalRVWVgvbnlMcWpzdlcvVXlwcWhCTFlqdytO?=
 =?utf-8?B?T0lPdDJYR21JZW1TN2pMT3lqT1Bwb1Brb3VaVzhGeldRTFY1MUJJOGFVTG9P?=
 =?utf-8?B?S0dOTmQwSmlCRjgzY29LcHk1aVpnTyt2QXAwM0VhbklHMzFoelhuR2FCRVYx?=
 =?utf-8?B?RkRHdXJYT0YwTmtHZVRDQUNiQmJYaWJqNWVvL2hOQWxHQzlVckk0dWVkdWFu?=
 =?utf-8?B?WVdnZ05SOFRpeDJOVG52elhQNE1jNXVXYzZHSm9MRWo3MEJ6WUEraytvZDBv?=
 =?utf-8?B?VjFvM1V5azZ6UC9NSzFRR0YyeWlKcGtJNzhxcjgyQ1g3VzRNbTlkMGhUaTRk?=
 =?utf-8?B?L3J0b2xRTm5iVWR2bjJlQmRUZ0RQUXNjdnN3dzNRcWVjT0JaSllESmRERkw2?=
 =?utf-8?B?Wk5BNWJSck1HU25GRjBLcy9UbVpDRnV5THY4Q2lsMWpYd254cjcrbHhMNzcv?=
 =?utf-8?B?SW5DSE5zUXZwVHJKTXUraHBURU91UUlsdjlpd3p5bEp3Wk93bWIxMUtGUnNB?=
 =?utf-8?B?eUR3NElYUWRhZm9lL3RoN3U4MVdEVEcwZUhjaWpxZUUyNENQZDdWTXVSY1Rv?=
 =?utf-8?B?N0VRYjIyek1kc1hPMkNtWk9yM01NZHNaOE8xM1dQQnNNcWdBZ3FHUWRacHpG?=
 =?utf-8?B?Q1JHenhKemZEdC96R1BLVmJMVlhZYlhYclRVV2FXNTVOSjdVZ0xhOVVhUjEw?=
 =?utf-8?B?MWpxUlZjU1d0V0ZENG01eE5xRjIyWGprbk93NWQvSklnWjNZeE50akpKSFU2?=
 =?utf-8?Q?ex8vlQNIE7pPmhN7OpFHDbw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A9F1366B37CCC429483C31BE0FACA18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82010598-40a5-44bb-9772-08ddfc3faca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 14:27:36.5993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mf2y54DUjNPkmU21aZfc1zMLFTCs4/TSS+UjrpIGasUPDT1LmL7m2T/DGOY5isTffu7OODYmFq+DDXEosZkIf9ogPcMGSEZvZswWjfNywE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7129

SGkgRGF2aWQsDQoNCiAgVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2ssDQoNCk9uIFdlZCwgMjAy
NS0wOS0xNyBhdCAxODozNCAtMDUwMCwgRGF2aWQgTGVjaG5lciB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UN
Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiA5LzE3LzI1IDc6MjEgQU0sIE1h
cml1cyBDcmlzdGVhIHdyb3RlOg0KPiA+IFRoaXMgaXMgdGhlIGRldmljZXRyZWUgc2NoZW1hIGZv
ciBNaWNyb2NoaXAgRU1DMTgxMi8xMy8xNC8xNS8zMw0KPiA+IE11bHRpY2hhbm5lbCBMb3ctVm9s
dGFnZSBSZW1vdGUgRGlvZGUgU2Vuc29yIEZhbWlseS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4NCj4gPiAtLS0N
Cj4gPiDCoC4uLi9paW8vdGVtcGVyYXR1cmUvbWljcm9jaGlwLGVtYzE4MTIueWFtbMKgwqDCoMKg
wqDCoMKgwqAgfCAyMjMNCj4gPiArKysrKysrKysrKysrKysrKysrKysNCj4gPiDCoE1BSU5UQUlO
RVJTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKw0KPiA+IMKgMiBmaWxlcyBjaGFuZ2Vk
LCAyMjkgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvbWljcm9jaGlwLGVtYzE4
DQo+ID4gMTIueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by90ZW1wZXJhdHVyZS9taWNyb2NoaXAsZW1jMTgNCj4gPiAxMi55YW1sDQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiBpbmRleA0KPiA+IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAuLjg5OGQ2ZDI0Njc0NmUyMjljYjAwNGY0NDcNCj4gPiA4NzJlZTZiZDVhNjUw
NzQNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaWlvL3RlbXBlcmF0dXJlL21pY3JvY2hpcCxlbWMxOA0KPiA+IDEyLnlh
bWwNCj4gPiBAQCAtMCwwICsxLDIyMyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4g
PiArJGlkOg0KPiA+IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lpby90ZW1wZXJhdHVy
ZS9taWNyb2NoaXAsZW1jMTgxMi55YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBNaWNyb2No
aXAgRU1DMTgxMi8xMy8xNC8xNS8zMyBtdWx0aWNoYW5uZWwgdGVtcGVyYXR1cmUNCj4gPiBzZW5z
b3INCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICvCoCAtIE1hcml1cyBDcmlzdGVhIDxt
YXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwN
Cj4gPiArwqAgVGhlIE1pY3JvY2hpcCBFTUMxODEyLzEzLzE0LzE1LzMzIGlzIGEgaGlnaC1hY2N1
cmFjeSAyLXdpcmUNCj4gPiBtdWx0aWNoYW5uZWwNCj4gPiArwqAgbG93LXZvbHRhZ2UgcmVtb3Rl
IGRpb2RlIHRlbXBlcmF0dXJlIG1vbml0b3IuDQo+ID4gKw0KPiA+ICvCoCBUaGUgZGF0YXNoZWV0
IGNhbiBiZSBmb3VuZCBoZXJlOg0KPiA+ICvCoMKgwqANCj4gPiBodHRwczovL3d3MS5taWNyb2No
aXAuY29tL2Rvd25sb2Fkcy9hZW1Eb2N1bWVudHMvZG9jdW1lbnRzL01TTEQvUHJvZHVjdERvY3Vt
ZW50cy9EYXRhU2hlZXRzL0VNQzE4MTItMy00LTUtMzMtRGF0YS1TaGVldC1EUzIwMDA1NzUxLnBk
Zg0KPiANCj4gVGhlIHBpbm91dHMgb2YgdGhlc2UgY2hpcHMgbG9vayBuZWFybHkgaWRlbnRpY2Fs
IHRvIE1DUDk5OFguDQo+IFdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gc2hhcmUgYSBzaW5nbGUgYmlu
ZGluZ3MgZG9jdW1lbnQgZm9yIHRoZXNlPw0KPiBPciBtYXliZSB0aGVyZSB3b3VsZCBiZSB0b28g
bWFueSBpZjogYmxvY2tzIGFuZCBrZWVwaW5nIGl0IHNlcGFyYXRlDQo+IGlzIGZpbmUuDQo+IA0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1paW8vMjAyNTA4MjkxNDM0NDcuMTg4OTMt
Mi12aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNvbS8NCj4gDQo+IA0KDQpJIGtub3cgdGhhdCB0aGUg
Y2hpcCBsb29rcyBuZWFybHkgaWRlbnRpY2FsIHdpdGggTUNQOTk4WCwgYnV0IGJlaW5nIHR3bw0K
ZGlmZmVyZW50IGZhbWlseSBvZiBkZXZpY2VzIGFuZCBoYXZpbmcgZGlmZmVyZW50IGZ1bmN0aW9u
cyBpbnNpZGUsIEkNCndvdWxkIGxpa2UgdG8ga2VlcCB0aGUgYmluZGluZyBzZXBhcmF0ZSwgb3Ro
ZXJ3aXNlIHRoZXJlIHdpbGwgYmUgdG9vDQptYW55IGNvbmRpdGlvbnMuDQoNCg0KVGhhbmtzLA0K
TWFyaXVzDQo=

