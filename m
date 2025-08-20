Return-Path: <linux-iio+bounces-23039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E56B2DAD3
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 13:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D295218824A8
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 11:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802552E2678;
	Wed, 20 Aug 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3WhvX3a6"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9869475;
	Wed, 20 Aug 2025 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688987; cv=fail; b=LjokSRVqgKHN2htngQK7fGbSYxVs8zXQdmFyI6KaSZqJ1SS4H5vyhTAQSLgEVnju5P/YSaka4IPJMNoApWyYQ2RDQkT7OpsZEc7CZS2NxnOW357JNn4Y7Hk+KKjoDFDOFFE/R8BfBEccbRxqj1E82bWtspq/PDdUepi3oEbp1Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688987; c=relaxed/simple;
	bh=S0Zk7e+5S0osbQBBpDgd3quOLz5K30dEsMuhVQ1rKaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GbVAS6mPhuDxYlo4ajFOckL6bjiTfts+IEAV/X699OQA14ybDM3HE3adAIdYnoUKv2v45swp84CNiHhrbmwtD8nxRKKRIAS+NUJgoSQkQPcNHPUNqW48hwOTVqZmHYy6r6fkdXa9e0oJfLJ8Ba5OKEapJHtT9X3Je/pnkJhTGUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3WhvX3a6; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lea11N8Q7u+A2BjMQVuOfX+jMHG679WsKCDlMkcN+27lY4wNqHapjwAkyCeEpztRhE6920aihhtXfEe18a64Gl+yYV3egfYDocN2K58BXRthc2c0vchS1pUaMiItS61Dpn0Y/2GQKtx6R2aZpcWk3riqhIheoUXgT9MaxpntGiUk2Sh78VRsLRgO9clCcODqMW9HHpl3mpcO4RtNNS7Ohdzppu2bmwTpjoUdq6xUtmgHh+d5OzWJUzbRHzSgmM0N56lDhP/VMQcNUp4DzISjnM4vIph15sZtYYYrlYwatu9UKsFGvDOOvywDQJE8PXCaVzeATqY3XQGeNhPEshSMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0Zk7e+5S0osbQBBpDgd3quOLz5K30dEsMuhVQ1rKaY=;
 b=UTOAmfZ6S1vURwUKj7UVFwQcRuYovjvbCO5ip6iI+kN0QlSLUJchn2TQmrLo6fjrkANZyauvm67/+L6cdB0T8AGuhvFb54ZZ8i38JLJM7tx+QxjUBBJy7QhSn9pxBnOq9/GxIiF5Xjuzucwa8tCQHA2sWEPxvtkGS8TnNe/p6c2C8OvzOkgAmRUozjPeflVIColGGOKj7fTE6lrGS9rK6VgJm8dIwSQpK5acfgnCWJBXIpzdXVPKq6HtyTmwcaDKiiA+RlQNe2HLg484p8EygoI1YW12gNrEWsXEQRgfXjs57Z2qJXtqKe080woeZOklEvCUUJ5TxcesgKLVO7RX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0Zk7e+5S0osbQBBpDgd3quOLz5K30dEsMuhVQ1rKaY=;
 b=3WhvX3a6/M2Iq41kEm7kCe6MjVV7gam02w5nBGaPPSa24xaW2zixTSdbm5HdwKBL3QcwPKb+0nzRCZOI3jfokFP6VpFgPpQQd+nwC0RllBu2wZnAskZ946w4Vm/E3BF98tVcz1JVGmhhtLaoE4jCjSHJW+/p6u2fB0kR5BsP1Uo=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 11:23:03 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 11:23:02 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Jonathan Cameron
	<jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"O'Griofa, Conall" <conall.ogriofa@amd.com>
CC: David Lechner <dlechner@baylibre.com>, =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
	<michal.simek@amd.com>, Andy Shevchenko <andy@kernel.org>, Manish Narani
	<manish.narani@xilinx.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: xilinx-ams: Unmask interrupts after updating alarms
Thread-Topic: [PATCH] iio: xilinx-ams: Unmask interrupts after updating alarms
Thread-Index: AQHb9R/b1tmWBACI9EytyB8y8tMvrrRrnVtA
Date: Wed, 20 Aug 2025 11:23:02 +0000
Message-ID:
 <IA1PR12MB77367112004CB445B805E2B59F33A@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20250715002847.2035228-1-sean.anderson@linux.dev>
In-Reply-To: <20250715002847.2035228-1-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=f592de17-b426-4173-a9ab-cb0bb386d6a9;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2025-08-20T11:16:24Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|PH7PR12MB9221:EE_
x-ms-office365-filtering-correlation-id: 1410e6be-9fd3-4705-a87d-08dddfdbed48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEpDemN4Tm1mdG5naUg5VVVqTXRtZElTbVZ2bkFFMkMvdzMrcG1Ibm90RHVO?=
 =?utf-8?B?OE9iNmRXaHI2SnpVZnJkaDdIS0U1V0RzT1FEbEpIbFZjRWxPQlZ4cWtEUGtM?=
 =?utf-8?B?T1UzRkxhSVI4ZmpIb2YrRloxSFRIb2o4VzFJNTBISmpwQ2h0TnRWTWtvVzJ6?=
 =?utf-8?B?cTIySTQzekJCZk1nVEFPQVpPakVYN21XOU1FcVlBYmg5ZFp0N25JWkY5TGM5?=
 =?utf-8?B?alBVNnVNSlNNYVJJOXp4ODBVZ2ZNd2ZQU0NtejhFNFhqMU0xQ3A0WFdnazJY?=
 =?utf-8?B?S0ZpYVBicmlObXd1eDRLdXBFdkZ6WWYzbWM4ZWRsQnZVazJhYVdJUkxXc2Vj?=
 =?utf-8?B?MlJRQm5lcFUzckF1bysxeU5ZZk5MQS9VMk5FRFJhVURabTFhSEVmUkdmaFdi?=
 =?utf-8?B?c1ZLcmg2OWtMVGZNVFBvWlFlanAzUnJGZitlYTIwR2VIWjlvN1dwajJ3MTlT?=
 =?utf-8?B?VWdWNnkvSHpOOHNEN0w5RjROeUVETzVnRHBWeCthUkx2YjBCZXY4YWJYMmlJ?=
 =?utf-8?B?N04vMUJZeXlTUm9qRnFnUXNGVkgxSW1uWmk4L2FoU05aVUdqUHRwRjhkcWh5?=
 =?utf-8?B?OG9nVStPOXFXQUpaRkpnb2FnbGxkVWpCQkZDcGJlZFIxY1d3K2FMZlBoZWZh?=
 =?utf-8?B?VFZteUt5bzNSeTFiTmc5WkVJM094R3cxZFBQc0pOZUNsbCtMRUZ4cXRyNUoy?=
 =?utf-8?B?VlRKd0t1R2NwaG8vZTB0V0FPSXBKanIzN1pXcHFVenYvS29ONlN5VXkwKzg4?=
 =?utf-8?B?OXNreFJ2c3JOTldRZExEUDQ4cC9kVTdhUnhyZXF3WVpzRUJCS0FpS3gyTjFa?=
 =?utf-8?B?b1gyMjBraXhvVkZVV3ZLeGgxUDBtMVBsTzVJTUVrL1pnaHZLNkFZWVNJVTRB?=
 =?utf-8?B?UUxjOWh1SmN5SXBDWHYrWGl3WVEwRCtoU2l3QVc2WWhFNmYxMm5ZZEhRczRs?=
 =?utf-8?B?NzNudTY2Q3I0ZTdqN2pFYmhkTEZweXhqa2IxdWxhK25wZU1jNFRYZG80eFBG?=
 =?utf-8?B?TURqdE9LNVJ3Tm5MeDNnV1Nmb0dKZVdMS0RCdFRaOHljcHNMdVJ1d0tsTE5h?=
 =?utf-8?B?dWJKM01zVlNRVUxQWG4rbHZFbkN2WnRvcHJ4NGlYNWh6dUIxTkI0OFdlVEdj?=
 =?utf-8?B?SE9OQ2lOL0ZEcmx6YStzVEN2QjNSZTA0WURYVzZUZElkcDYwYVFHNHpWMUtm?=
 =?utf-8?B?OTdHZXF3MVZDMitBeGFONis1V2pmRXptZzhrblVYdWhRTjE1V1JVMXQwRE90?=
 =?utf-8?B?NzQ1cjZmY0Fzb0RLbzVDZE5YNnpQWnlGZG8yS05wTVF5TEcvTktHT0czQjV0?=
 =?utf-8?B?ZlFHRzRBMnZNakU1bkViT29JUjR2YnB2UTVob1RTc2d3THN5VDNuKytRRllK?=
 =?utf-8?B?VXBLbTNac3VhYVdJS1ZXQ1ZPS0s3S1JTRnRFSU1QbERRdlNZUzQvbFl0SWVZ?=
 =?utf-8?B?eGJ3SjcyUkZ3T2ZXNDFadVBMSUVLb1d2Tlp4VkZ1OXNUL2plT2lPaFplbVRR?=
 =?utf-8?B?cGxaRFR4SzJka2NSM2NRd1RER2REOUhCQ3pveXBHSmlhd0Rteis3U1ljNmlE?=
 =?utf-8?B?aTVoOUZFUkpjNlZ5eENCWk00aVV2elJTeHAyUmdMQlFwN1Q1TXBPTzQrc0lm?=
 =?utf-8?B?emJVSFlyRFE0NVNjU2dRYlRpZkhuSER6VWppSjdqL09hWmFYQXhMaGdPajNo?=
 =?utf-8?B?M3dDdGJrQ1pxWFArMEV4R2hMbWM5bGZUSi9WSE1hcHhYT1k4MHFOdlRUL1NE?=
 =?utf-8?B?U3cra1N4K0Z4dmhIcUhHaFJUbWNKSmtXZE1xeVdLVFZFU1I2V0RhTVZmeWVS?=
 =?utf-8?B?dWd4R1kvNUh1VlNxV0FFOWNWSy90WStXRFl5VXhoenNXZFBUUjR0cUEwNjE2?=
 =?utf-8?B?Z2Qvc1lPMGo2cHZiS0swRTVFU2NIZ25sNTNOdXMzZUYyaDJ5WFVodEtJaEtn?=
 =?utf-8?B?cHdVcnVOTlI4ZDltWEdOenpsQmNOeEdMRmc3VWJuRUlsQWpvbGZ5SkVSWWQw?=
 =?utf-8?Q?RCeoXeXOUWDeo0JSaN2gxOWzlylQEQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGZrOVFTeEw0WTN4MWR3QVZtbEY5THVPZnRVbUdRZE9EMnJocXlPWUE2RHl4?=
 =?utf-8?B?eEFPNm9KRjVFQ0dZbUNNKyt5OWtzZTd1MkppVm54cWFxYWhkSTY4VXBxby94?=
 =?utf-8?B?L3VIQ21YaSs3Y2FzNGRRZVhuckg5c25yZUJhYUJEb1FURVRQamV2SXVXOWVC?=
 =?utf-8?B?N2UyMVFWU1h5UnpDeDdrOWxwT0xGUUMxZFJnV0VyZGgxQnFoSVQyQVE3cnoz?=
 =?utf-8?B?L1dOMmlGeHFTTklwd1JLeXdFbGFLeFNPeTRPVVI0aTRpYVROZ0VCRzZ4THBF?=
 =?utf-8?B?RnQ4WHFFckFTZklhbmFDQzBMc3NEVW9JSi8rUlJxc0c3V1ovRFJXOS8yREdi?=
 =?utf-8?B?Z09iZi9WS2VERjJYRE43OHJPWWQrdFFpV1dZaGd2NGY2cjBiWlV5VmdSTDl2?=
 =?utf-8?B?NlB0Q0J3OGx1U3M4aTdBcXJNWlR3QXgwUHB5ZzMxZlo0WElhNmNzYnJoZ1B5?=
 =?utf-8?B?bW9qb0ZiZ0NSd2J2Zy9jWHFOTkFmSHR0QlRIc1h2cExWV1FkTkFIQ3FsM3JW?=
 =?utf-8?B?cEpCSWJtT0JqTlo2M28zTmhWRzdjVnZheFp4VWxvWUVmMldJMndicG0rOGF1?=
 =?utf-8?B?RGxXNGRIQkZCZll6enlDR3lER012bFZTcjVDNnZVTDFkNm1MdDR6Y2FBemcx?=
 =?utf-8?B?Q0VuVFpFTFVpWnRQY21uTVVmK2hKcXk1MGpUNVVJR2xIb0g1SnBjVXZnMEFi?=
 =?utf-8?B?Z2NVRHhqc3h3YmY4dUtrOW4xWlhjbmhkUy9WcEsveVJ4cFJySDFOdFI3YTc2?=
 =?utf-8?B?cm5pdFZRY3BaVzU5R2tPL01yVVQ2N1VWRFE4T25NbVJjRlpycjV3NzlhNkxp?=
 =?utf-8?B?aFpWR0VQNU5nSXB6UFNZZEQ2QXBGU2FjLzZFTUJQNjYxdWYzWjBRSjJQMFpC?=
 =?utf-8?B?TlF5b09Bd2cvZnB4NkY1NTRRSDNZb3JmcFI1NndRTTdscTJaeE1JK1dVZmd4?=
 =?utf-8?B?ZVBTdEwzVEU5Qkd4UkI1Ujk2aExBSkhhU2VidGNiM2VORDV0WlozQWphUW82?=
 =?utf-8?B?YytPajV4S2wrLyt4R3YxTTJhMjRFTnZYK0NIajlQUGM0Mmw0NlA0QTJpUW1h?=
 =?utf-8?B?THpTOWw5ODNwY3BsbFp0bXQ1N245RTNKYS8zTlBubnI0YkJ6R2pqUkEvTHVB?=
 =?utf-8?B?Uk94ZUZ1WWorVjJWR0c1cVdiR0MxT0E5YVBLWkRzb3UxaDJvWWgyRSs5dFRT?=
 =?utf-8?B?d1EyenVkNzJFUXM4VzJ0aFQ3bjRrY3VPeWxLRnFIcC9KWjBJRlhjSkhzUEhG?=
 =?utf-8?B?TnRkVXR5aUJieFFQK28rUjJsMWtZY3lxYURmcDZlV3lrZVJ0U1lRK200Tkw5?=
 =?utf-8?B?T0tiNXh1UEI5VjB0L0VOWTNxdk8wWGZDbGsxcG1ONVM0ZS9SdEtVWkZXbUd1?=
 =?utf-8?B?NzNaUWZZRkZSUi9UOTNNODJPMHRvaUhxUVZWbHA5YnIxRlFDTmJVMEF1ZTNa?=
 =?utf-8?B?VXV0Y2V2VzZLdzFpMTF6a2ZjdHBMRHAyMmo1WmE1aldjY0d5dVBGUm10aTVp?=
 =?utf-8?B?MG5aSVZMSTgxQUFwYW8zQ3B4SXVXalJYNnQ5b0FLZ3FMRVJEcEdhMjlGcng5?=
 =?utf-8?B?SWwvK29jL2lMTU1RL1J6ckVBVXU5MWE4a1hNc3VpcVM2YkxINzNUWThycUcz?=
 =?utf-8?B?U3RxL3BzTlo1WGlPdmlFOUJ4T3BlK080d3haK2gvaDF0RHE0T3dTb2FVSlhQ?=
 =?utf-8?B?aEgyYWtIMlM1ZURkUmpHZFhoN25oOU5iZUV6VnpYWGVPNzZHblQyMFY3Sm5y?=
 =?utf-8?B?cHlFLzN3L0kzS3pZenJxZlJYRXRBZGVTank4WWpMK3p6NkJ1RnIrcTZPUVhB?=
 =?utf-8?B?d2VWOVJ5dS8veG9zbWFjMVVOaGtPNXNLS21KZS9EZ0ZGZmhuMUdDTHpxaXlz?=
 =?utf-8?B?Y0FvSURHNmxRblB0bmpTUXdRTVB6dVRBSlZNT0pKQU1DaU5VZ1UxcHE5SkQ4?=
 =?utf-8?B?b2tPdFYwUEY3b1FwS3BKa09pYlNYTUN3dXVGMVloSUZMbzA5eDVnUE9vdGo1?=
 =?utf-8?B?VC8rS0x3dDB6ZDJIejU4V0FZVmxKWCtpNzI0SDUwbm1sRkkwTGt1M29MWlZX?=
 =?utf-8?B?VGNOdGZSdHV2cDhkU0ZXTzQwUHVHMFBQNmtMNE9GeFlFaWl6cWVEOHFGZXNt?=
 =?utf-8?Q?tr40=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1410e6be-9fd3-4705-a87d-08dddfdbed48
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 11:23:02.8037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvUwMJon66jrwjJnd2jHFFn9SfGwWeX5VXMvvpyXVJz92N5OaAylCDlh1eYZxkuj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

SGkgU2VhbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWFuIEFu
ZGVyc29uIDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU2VudDogVHVlc2RheSwgSnVseSAx
NSwgMjAyNSAxOjI5IEFNDQo+IFRvOiBBbmFuZCBBc2hvayBEdW1icmUgPGFuYW5kLmFzaG9rLmR1
bWJyZUB4aWxpbnguY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8amljMjNAa2VybmVsLm9yZz47
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IERhdmlkIExlY2huZXIgPGRsZWNobmVy
QGJheWxpYnJlLmNvbT47IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+Ow0KPiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1l
a0BhbWQuY29tPjsNCj4gQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBNYW5pc2gg
TmFyYW5pDQo+IDxtYW5pc2gubmFyYW5pQHhpbGlueC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBTZWFuIEFuZGVyc29uDQo+IDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4g
U3ViamVjdDogW1BBVENIXSBpaW86IHhpbGlueC1hbXM6IFVubWFzayBpbnRlcnJ1cHRzIGFmdGVy
IHVwZGF0aW5nIGFsYXJtcw0KPiANCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQg
ZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5p
bmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPiANCj4gDQo+
IFRvIGNvbnZlcnQgbGV2ZWwtdHJpZ2dlcmVkIGFsYXJtcyBpbnRvIGVkZ2UtdHJpZ2dlcmVkIElJ
TyBldmVudHMsIGFsYXJtcyBhcmUgbWFza2VkDQo+IHdoZW4gdGhleSBhcmUgdHJpZ2dlcmVkLiBU
byBlbnN1cmUgd2UgY2F0Y2ggc3Vic2VxdWVudCBhbGFybXMsIHdlIHRoZW4NCj4gcGVyaW9kaWNh
bGx5IHBvbGwgdG8gc2VlIGlmIHRoZSBhbGFybSBpcyBzdGlsbCBhY3RpdmUuDQo+IElmIGl0IGlz
bid0LCB3ZSB1bm1hc2sgaXQuIEFjdGl2ZSBidXQgbWFza2VkIGFsYXJtcyBhcmUgc3RvcmVkIGlu
DQo+IGN1cnJlbnRfbWFza2VkX2FsYXJtLg0KPiANCj4gSWYgYW4gYWN0aXZlIGFsYXJtIGlzIGRp
c2FibGVkLCBpdCB3aWxsIHJlbWFpbiBzZXQgaW4gY3VycmVudF9tYXNrZWRfYWxhcm0gdW50aWwN
Cj4gYW1zX3VubWFza193b3JrZXIgY2xlYXJzIGl0LiBJZiB0aGUgYWxhcm0gaXMgcmUtZW5hYmxl
ZCBiZWZvcmUNCj4gYW1zX3VubWFza193b3JrZXIgcnVucywgdGhlbiBpdCB3aWxsIG5ldmVyIGJl
IGNsZWFyZWQgZnJvbQ0KPiBjdXJyZW50X21hc2tlZF9hbGFybS4gVGhpcyB3aWxsIHByZXZlbnQg
dGhlIGFsYXJtIGV2ZW50IGZyb20gYmVpbmcgcHVzaGVkIGV2ZW4gaWYNCj4gdGhlIGFsYXJtIGlz
IHN0aWxsIGFjdGl2ZS4NCj4gDQo+IEZpeCB0aGlzIGJ5IHJlY2FsY3VsYXRpbmcgY3VycmVudF9t
YXNrZWRfYWxhcm0gaW1tZWRpYXRlbHkgd2hlbiBlbmFibGluZyBvcg0KPiBkaXNhYmxpbmcgYWxh
cm1zLg0KPiANCj4gRml4ZXM6IGQ1YzcwNjI3YTc5NCAoImlpbzogYWRjOiBBZGQgWGlsaW54IEFN
UyBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29u
QGxpbnV4LmRldj4NCj4gLS0tDQo+IA0KPiAgZHJpdmVycy9paW8vYWRjL3hpbGlueC1hbXMuYyB8
IDQ1ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDI1IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMgYi9kcml2ZXJzL2lpby9hZGMveGlsaW54LWFt
cy5jIGluZGV4DQo+IDc2ZGQwMzQzZjVmNy4uMTgwZDQxNDA5OTNkIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2lpby9hZGMveGlsaW54LWFtcy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy94aWxp
bngtYW1zLmMNCj4gQEAgLTM4OSw2ICszODksMjkgQEAgc3RhdGljIHZvaWQgYW1zX3VwZGF0ZV9w
bF9hbGFybShzdHJ1Y3QgYW1zICphbXMsDQo+IHVuc2lnbmVkIGxvbmcgYWxhcm1fbWFzaykNCj4g
ICAgICAgICBhbXNfcGxfdXBkYXRlX3JlZyhhbXMsIEFNU19SRUdfQ09ORklHMywNCj4gQU1TX1JF
R0NGRzNfQUxBUk1fTUFTSywgY2ZnKTsgIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBhbXNfdW5tYXNr
KHN0cnVjdCBhbXMgKmFtcykgew0KPiArICAgICAgIHVuc2lnbmVkIGludCBzdGF0dXMsIHVubWFz
azsNCj4gKw0KPiArICAgICAgIHN0YXR1cyA9IHJlYWRsKGFtcy0+YmFzZSArIEFNU19JU1JfMCk7
DQo+ICsNCj4gKyAgICAgICAvKiBDbGVhciB0aG9zZSBiaXRzIHdoaWNoIGFyZSBub3QgYWN0aXZl
IGFueW1vcmUgKi8NCj4gKyAgICAgICB1bm1hc2sgPSAoYW1zLT5jdXJyZW50X21hc2tlZF9hbGFy
bSBeIHN0YXR1cykgJg0KPiArIGFtcy0+Y3VycmVudF9tYXNrZWRfYWxhcm07DQo+ICsNCj4gKyAg
ICAgICAvKiBDbGVhciBzdGF0dXMgb2YgZGlzYWJsZWQgYWxhcm0gKi8NCj4gKyAgICAgICB1bm1h
c2sgfD0gYW1zLT5pbnRyX21hc2s7DQo+ICsNCj4gKyAgICAgICBhbXMtPmN1cnJlbnRfbWFza2Vk
X2FsYXJtICY9IHN0YXR1czsNCj4gKw0KPiArICAgICAgIC8qIEFsc28gY2xlYXIgdGhvc2Ugd2hp
Y2ggYXJlIG1hc2tlZCBvdXQgYW55d2F5ICovDQo+ICsgICAgICAgYW1zLT5jdXJyZW50X21hc2tl
ZF9hbGFybSAmPSB+YW1zLT5pbnRyX21hc2s7DQo+ICsNCj4gKyAgICAgICAvKiBDbGVhciB0aGUg
aW50ZXJydXB0cyBiZWZvcmUgd2UgdW5tYXNrIHRoZW0gKi8NCj4gKyAgICAgICB3cml0ZWwodW5t
YXNrLCBhbXMtPmJhc2UgKyBBTVNfSVNSXzApOw0KPiArDQo+ICsgICAgICAgYW1zX3VwZGF0ZV9p
bnRybWFzayhhbXMsIH5BTVNfQUxBUk1fTUFTSywgfkFNU19BTEFSTV9NQVNLKTsNCj4gfQ0KPiAr
DQo+ICBzdGF0aWMgdm9pZCBhbXNfdXBkYXRlX2FsYXJtKHN0cnVjdCBhbXMgKmFtcywgdW5zaWdu
ZWQgbG9uZyBhbGFybV9tYXNrKSAgew0KPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+
IEBAIC00MDEsNiArNDI0LDcgQEAgc3RhdGljIHZvaWQgYW1zX3VwZGF0ZV9hbGFybShzdHJ1Y3Qg
YW1zICphbXMsIHVuc2lnbmVkDQo+IGxvbmcgYWxhcm1fbWFzaykNCj4gDQo+ICAgICAgICAgc3Bp
bl9sb2NrX2lycXNhdmUoJmFtcy0+aW50cl9sb2NrLCBmbGFncyk7DQo+ICAgICAgICAgYW1zX3Vw
ZGF0ZV9pbnRybWFzayhhbXMsIEFNU19JU1IwX0FMQVJNX01BU0ssIH5hbGFybV9tYXNrKTsNCj4g
KyAgICAgICBhbXNfdW5tYXNrKGFtcyk7DQo+ICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmYW1zLT5pbnRyX2xvY2ssIGZsYWdzKTsgIH0NCj4gDQo+IEBAIC0xMDM1LDI4ICsxMDU5LDkg
QEAgc3RhdGljIHZvaWQgYW1zX2hhbmRsZV9ldmVudHMoc3RydWN0IGlpb19kZXYNCj4gKmluZGlv
X2RldiwgdW5zaWduZWQgbG9uZyBldmVudHMpICBzdGF0aWMgdm9pZCBhbXNfdW5tYXNrX3dvcmtl
cihzdHJ1Y3QNCj4gd29ya19zdHJ1Y3QgKndvcmspICB7DQo+ICAgICAgICAgc3RydWN0IGFtcyAq
YW1zID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBhbXMsIGFtc191bm1hc2tfd29yay53b3Jr
KTsNCj4gLSAgICAgICB1bnNpZ25lZCBpbnQgc3RhdHVzLCB1bm1hc2s7DQo+IA0KPiAgICAgICAg
IHNwaW5fbG9ja19pcnEoJmFtcy0+aW50cl9sb2NrKTsNCj4gLQ0KPiAtICAgICAgIHN0YXR1cyA9
IHJlYWRsKGFtcy0+YmFzZSArIEFNU19JU1JfMCk7DQo+IC0NCj4gLSAgICAgICAvKiBDbGVhciB0
aG9zZSBiaXRzIHdoaWNoIGFyZSBub3QgYWN0aXZlIGFueW1vcmUgKi8NCj4gLSAgICAgICB1bm1h
c2sgPSAoYW1zLT5jdXJyZW50X21hc2tlZF9hbGFybSBeIHN0YXR1cykgJiBhbXMtDQo+ID5jdXJy
ZW50X21hc2tlZF9hbGFybTsNCj4gLQ0KPiAtICAgICAgIC8qIENsZWFyIHN0YXR1cyBvZiBkaXNh
YmxlZCBhbGFybSAqLw0KPiAtICAgICAgIHVubWFzayB8PSBhbXMtPmludHJfbWFzazsNCj4gLQ0K
PiAtICAgICAgIGFtcy0+Y3VycmVudF9tYXNrZWRfYWxhcm0gJj0gc3RhdHVzOw0KPiAtDQo+IC0g
ICAgICAgLyogQWxzbyBjbGVhciB0aG9zZSB3aGljaCBhcmUgbWFza2VkIG91dCBhbnl3YXkgKi8N
Cj4gLSAgICAgICBhbXMtPmN1cnJlbnRfbWFza2VkX2FsYXJtICY9IH5hbXMtPmludHJfbWFzazsN
Cj4gLQ0KPiAtICAgICAgIC8qIENsZWFyIHRoZSBpbnRlcnJ1cHRzIGJlZm9yZSB3ZSB1bm1hc2sg
dGhlbSAqLw0KPiAtICAgICAgIHdyaXRlbCh1bm1hc2ssIGFtcy0+YmFzZSArIEFNU19JU1JfMCk7
DQo+IC0NCj4gLSAgICAgICBhbXNfdXBkYXRlX2ludHJtYXNrKGFtcywgfkFNU19BTEFSTV9NQVNL
LCB+QU1TX0FMQVJNX01BU0spOw0KPiAtDQo+ICsgICAgICAgYW1zX3VubWFzayhhbXMpOw0KPiAg
ICAgICAgIHNwaW5fdW5sb2NrX2lycSgmYW1zLT5pbnRyX2xvY2spOw0KPiANCj4gICAgICAgICAv
KiBJZiBzdGlsbCBwZW5kaW5nIHNvbWUgYWxhcm0gcmUtdHJpZ2dlciB0aGUgdGltZXIgKi8NCj4g
LS0NCj4gMi4zNS4xLjEzMjAuZ2M0NTI2OTUzODcuZGlydHkNCj4gDQoNClRlc3RlZC1ieTogRXJp
bSwgU2FsaWggPFNhbGloLkVyaW1AYW1kLmNvbT4NCkFja2VkLWJ5OiBFcmltLCBTYWxpaCA8U2Fs
aWguRXJpbUBhbWQuY29tPg0KDQo=

