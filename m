Return-Path: <linux-iio+bounces-17901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82425A83D36
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 10:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F26B19E8118
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1782920B7F7;
	Thu, 10 Apr 2025 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fssojgyF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015551EF372;
	Thu, 10 Apr 2025 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274408; cv=fail; b=rvySvvxAMEU2U8xm6f9aBU+JRmGhJNKGdV0n0tZx9R+Bn+/bCaezYp4hqsX0nXi2pXZXkf+t4zIwtGAYYGdmZGxQWJAXYaElKHXg7JrtkqIynmf2WrpETsRyQcVoTLhzF0bsyB3OD3kGuDa3FQCTOztXAKUOoUMoz6E25m2lYlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274408; c=relaxed/simple;
	bh=2MZt1RxfLWnu5Y6MOFyzW/gYHkSpqMJ9salP4/W6mb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=boIGcxaMpp9WQP4v0JapP1kNrk4Q2sPOI6CV0N0ZKOhOg3TscrcEG8mKYf2Z+LUI6jyImKDjmtdvlI5Te57xnyWMg7mwWPbW/vJ4bvvtxK17n6/BOa/K5kcF2RcgF8MUpp8DaelSlPwoNaG/4if5O1726or6/nPpON6TAS82+EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fssojgyF; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A7JgA7017429;
	Thu, 10 Apr 2025 04:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2MZt1
	RxfLWnu5Y6MOFyzW/gYHkSpqMJ9salP4/W6mb0=; b=fssojgyFyvUAH5huS/oaT
	Xk2b1pbSvXqI4MOI3C+ivh0WN4JF0o2zTcdncT+LTYAPJUA94x0fK71FkoT4agiV
	mwjZav17zoHubwh1Krhr/drUPWRS86XZVhlRft6hJYByuxibQzEy4URWtryRqPhX
	j0qy8QtOg1Yt7yvsYOygvULTZ8X6PrqU0Oarg//NsejEox+q0ARKAcPXs+hZjvZw
	nqJNADklFhSGhlzs5ugdrElCGEDocL9iLf9H6FIrOVN34R5k/1Iw7laaDMGVfNP8
	MyYYX1L9Uvn9ak0AjKUyjxCVn1IBrR5vgq9zU4SFToAo7HQyhTC9MQcebvmQhwbN
	g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45wqvvnby6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 04:39:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLVNN6PSiw7UJgAj4nXfVdgLjJUvLXVYyMu9x2Uz/LPtiEV4UTq8Kxcl3XVvqkSoDyc8wnYtGNMGEdxE0PniSpeIkXEmCV79Oav4hQ64bFdCX6bAa/1vT2nvWoHGtv8b/oNoutdFKYYuTQryWqXOon8+GsPv470MPDkNYcmkOYP+i9t/YwP4Q46KKVrsoswScpeVmldB6nOzLzTIrSY2wYLKh6U617nUGPIWDTM12pvywVJ6PgrcZOQ63UYOj/sa5IfSCHO4B1gDxLYDHdTKkZyNJSNnrNELHS7pcYQdYhZMOhisnuwV0EBuhxwljR+9ssTM2HBmiTuJbxCsF3McEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MZt1RxfLWnu5Y6MOFyzW/gYHkSpqMJ9salP4/W6mb0=;
 b=XgOXxI95WQ/acsTFvg5PCkwdtn7YIkZ9NigM7IxjlK7Rh+A462gLDInZZ0utiDDrBEdoO8AA6y3l3Sjirs/8R7eyM3+XZh63agvg0k4DM0bA68L1T7SsqsVuIkUEoRko220gWFRwUAchlmoAHdzj5WK9x3fU4AM5WRQlR+BFOhwSehd/r3pCb9YU1KoUOB5qFgQPm2lK8QAKouCJcLVR+bxJT93G8URzzDThRzgw1RjQ0HNLXt/huAyps5UE4ioxymTIgpd/FZkk84bodCXAg89ppDcpHHPniaSmT2gzXxUjSc6V3mgNvg+i0MRnbHWGkPF8oDri0eZz9NqucBmPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SA1PR03MB7123.namprd03.prod.outlook.com (2603:10b6:806:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 08:39:36 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 08:39:36 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Topic: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Index: AQHbpFodVQ0K5gQpPUCv8ilGKsClk7OTytsAgAQPsrCAAfuFAIACyK9g
Date: Thu, 10 Apr 2025 08:39:36 +0000
Message-ID:
 <PH0PR03MB7141587E8AFB2844E52988DAF9B72@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
 <20250403-togreg-v3-3-d4b06a4af5a9@analog.com>
 <fd2116bd-b0e2-4db4-97ff-1a1e88545413@baylibre.com>
 <PH0PR03MB714159E822B96E7A788A5CD4F9AA2@PH0PR03MB7141.namprd03.prod.outlook.com>
 <a66220e9-f690-4f95-9a14-d2b663d63490@baylibre.com>
In-Reply-To: <a66220e9-f690-4f95-9a14-d2b663d63490@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SA1PR03MB7123:EE_
x-ms-office365-filtering-correlation-id: b5b06f19-76aa-4eae-9de6-08dd780b39e3
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UXliSHNaSDRLdWw2QTI2V3BJSExWVVhVSU9GMGRhbjVPVGk5Q0RNRFFJUUdD?=
 =?utf-8?B?WnZ2ZnZZakp6VERBZ1Azd1I4UHZNTEl5Y0xZbXVReUZlSHowc3d5YUprZURl?=
 =?utf-8?B?aWY3bmFRcFFZS041dmYyNTdjOWR1MGoxY0lPZTIrWmllY3BpT1BodEl5Z3Jv?=
 =?utf-8?B?RkUrRy81SFUrYlZ1ZFYyNGFMNDBvRXlsYlZPUXFMVitERitlMXNncUpVVlVs?=
 =?utf-8?B?SGZKNUgwVm9NUFAraHBsRmxlNUlOMzQwOWRDb0IrdzVTbG56NUdCNDJ5YzJr?=
 =?utf-8?B?ME8yQys1WEFMM05xbU9mU0ZEbzlIdkhkREs2N2NidGJOYlI5VHU3SHl5TjFq?=
 =?utf-8?B?K3hxSzF3aXVwaEFnWmpueUpvcTAxRkl1REpsVGlmSGdBMmhpbUI5WitaSDhC?=
 =?utf-8?B?WmhmSkI0MVI0a1JvN3NONU9QWWdQck9vdXRpNngxdjlUdktpcHJuUXVTTGxP?=
 =?utf-8?B?Q0c4TWNNbHU1L2ZxeTBtTTdvaXRGcE95bFFVMFdRS1hqc1o5eGwrNVN5Zk9H?=
 =?utf-8?B?VE93OU56UkxCVnlJNmdmMFBUeFY4WFFkUnFyTEdJOFNRSEJTejZpN091UlZX?=
 =?utf-8?B?WUxmTmloc25rR1lNb0d0S0huWW9QRmR0dFhJV3p5N1hub2NZcnh3ZlJ1YS90?=
 =?utf-8?B?VER5N1JQbERxVlN3SUdLamExR21ESnd3M3dlWmpyT1cwTXJodEhVYkp1S0Qz?=
 =?utf-8?B?QkVTZmFBaUlCMWxwZjlOaytjeFc0Rk83TnZHSGVsK2JkMXlxQzJKeDUxYU1K?=
 =?utf-8?B?RTF4MGlOWjVBNzBuYmgvcHlIQXNlMm5JZXk2bkpjUWNoQndtdUVvanZwS2Vi?=
 =?utf-8?B?d0J3ZmF0NnhrNTVYTWVaMUhiMkJaQmxBN2V1VjFPMGgxdG1hQXpDQ3R6QlJV?=
 =?utf-8?B?bDVGSFJXU21FOEphYmlYWURlUXhwNzdyNUpGdmZKMnJJWUhhaVByMkJzL3N1?=
 =?utf-8?B?c0w3MmcvaXpuS2hiSHI2NnVaVmxCdlBrb3M0b3gyOTc2MCtRbytmMHdyUlFK?=
 =?utf-8?B?RC92M3V5N2hQY1VpT0hRNTFrUUJZa3dYTTNpQnBhMGZSUmlHdXdxMHF4RktZ?=
 =?utf-8?B?alQzQVdlWEthVEh2NEZjdmJGZ0xONzVVdUVuQ2U1MzRmZGdDWUVlOEIxVUcw?=
 =?utf-8?B?TGV3ZXNFT3Z6RVN6dWcxdUtYek1JYWs2NXVEMGtMTkhKR3h1aVZFWm5vZ2dk?=
 =?utf-8?B?aDFiNUhpVlEwTXN0Z09BbzVTcDJsMTZURlN1QVpXVjdaL0RTMjdzSmlNcmxw?=
 =?utf-8?B?ZVRBdTAwR1gweC84VU50WlRnaXBydFNrSzJYY2JveWpRdFpRUjJBcEtYUG8w?=
 =?utf-8?B?Qy9meGU0V2c2YWI4VHZlMW9Sd1FkNEU2ZitNWDVBWEg0eU9KWk5QR2ZDLzd6?=
 =?utf-8?B?TWtTQStVaWkwd3pEeVE0dGdnUUZFNXF6R1ZLZDFxbjFteWo0OTQxc0l3dmdj?=
 =?utf-8?B?WWIwWVUwL3ZkbGxvS2htT1g0U3IzbHZBelo1UTdSYzlXNzRlallwb01zVzR5?=
 =?utf-8?B?V3pvK0NBWm5qdnppazVqeWhQbnVxRmRDWC9NT0hhWko5SG02UFhwa1IxOXFa?=
 =?utf-8?B?cU54bXBWY2prRXFiQ3dSRXNrd1BLS2J5MVRiUkRDaEdlMmF3ekF1Q2FPaU1W?=
 =?utf-8?B?WDVqU2dxYnlLamZRRHgyYWltcUpnOU11NTNhZGJJaGpMRUlOZ0JvMGF6Q2x5?=
 =?utf-8?B?YTAvVk5qUXgzZjNOMktDVjhoN1NTdzYvUGRtZ2kyejFYQ0hmUkFLOG1mSm1x?=
 =?utf-8?B?amFyMnhUeEp6RHlDa0lrbXZ0eXM3K3dWSURQWG5ueW1OWFFpdGhaVyt0eFhF?=
 =?utf-8?B?MlZXaDhXV0l0Tno0YjFCMlR0VWZqVDZOQlEyS0FiMDQycTE0eHk0Nlo1b3gy?=
 =?utf-8?B?UXFHTlAyTVhWbmtvL2lEaWozVUVrTWVkK3p6RitJRDV5VWhZTnoydXRFZ0to?=
 =?utf-8?Q?uY1hYcMg9OZmFtxhUD6Z6pjAkGJBHwtd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXFGY3BOSDRQT1NmVENuWmd6aFdxWU85S25Dc0dPcDNwQkVhZHNwU2JRSmRn?=
 =?utf-8?B?TG9ZT1pvYVNuY2JtKzNkdmYrQW1rV056RVZTNnRzZ2FRYkxQNVRmOTJQV05U?=
 =?utf-8?B?UUZMU015eGpRMjdVRW4xQkV1clZDNWJPVnYxRzB0M2VTb3NvT2x5TE5PaGh2?=
 =?utf-8?B?V296OW9BbCs0OGZIV0xhM1dTRDJLTm5DRmJac1Vhc3JVUjc5ZmtOMng5Z3BB?=
 =?utf-8?B?Vm0yUkFldHY3VG1UQWRTeHRSdlBYK2Zyb0wwL2RVUlZXZE5DclBBRmJBaDFN?=
 =?utf-8?B?MkNWTThXSlVtTUVaU1NldmFFVk5mQ3p3dVNjc1BQSnBzYUNSNmQ3aG5kdWhm?=
 =?utf-8?B?WG5hdzZKM2lEN0ZuQVJlOXB6SmU3RS9NVDZrL3pqbndzTlE2ZDJ4ZWR0VUJ4?=
 =?utf-8?B?UVpnRTVFanZOTFBKWWpHWHpnWm9mREtiNmcvSlBwUDBvcWNqRzU3citEMUhP?=
 =?utf-8?B?Y00wUFlwTURBeEFJNHByaEk1M1k0d2s0Sm5pMGFxZlRaNlM3VEpCQ2VuYkdm?=
 =?utf-8?B?aEpWOHlwK0hpNm5CL3RTM3VQcHQvTHJ4YmlGaVk1SFJhRVgxZDFYendzUTdo?=
 =?utf-8?B?Mm9oWi82VWIwZENhaERiWnJSK1kyWUlaQk5pM3RvbDdXcGlWenNVWHJGSkpD?=
 =?utf-8?B?T242b2U3a0hwUjQwSnNyUEluN2pWTDMzSzNqSGZLV3Z6azgvMm1iZjFyeTZS?=
 =?utf-8?B?cWYveThUOHFyVDhOR1p1bFQvcWwwampPK0wyalRUMHdtSFJBL3ErOEk1QVg2?=
 =?utf-8?B?cE1kU1dpdVhHd0JSYmxxR1BmTUF4SDdyTm9yalc3SE1VSFM3SHZRQlVEQWpn?=
 =?utf-8?B?SWFyZGtleWd5OWJuY3hJNUVMbFNVNUhWZDZpKzBtSW9pSEdaYmVqL01IbjE3?=
 =?utf-8?B?RFpmZHFWYVdQTHBTSGQ2eEpqUDMzVnUxWkJ5Mmk4MVZyYlk2dnZTODlNQzdL?=
 =?utf-8?B?QU1nb055SVQwYUVuOWJDOFlHVHZPN254L1c0c1NKSGlSbEhiVlRIWG9aa2Jn?=
 =?utf-8?B?a1Uyd04zR3RHZTRKM3dScFN6NnhyQklIdllCaXJiL0F3MHRqN25uTXVHNDJl?=
 =?utf-8?B?UERjSytLVG54ZEQvblB5d2ZBcVF1OGhWbjljWE5mS3NVeWN4OUdCQ0p2WFBn?=
 =?utf-8?B?Vi9PV0hDU0ZuZTZkN1EyUDUzb2ltUnZJOUZkajJxTmxQOGFhSVc0UThKanpH?=
 =?utf-8?B?ZFJ0ZnIwQ3NraTBuYXBYcGJjWVI1Wm84SUtoejJKNVNEZjFYQXFmMkx2YjA5?=
 =?utf-8?B?SUpGOTJ0Nk05WXhUQ2Ftd1dUZzRyOWNhYTdSZHQ2ZVMyYkR0Q0JqUG4yMGxR?=
 =?utf-8?B?RHNYbU9ZcmNHVStRaVF4dWVaMVQ0VzRTcjJmMkQrTTJJUUt6aXUyQnF4dFBz?=
 =?utf-8?B?aEk2cks0Q202dml1UGgxckRSVHJkK0liY3dvZHprUCs1U3gxamdabVlnOW5H?=
 =?utf-8?B?Wk9NQTVUK25iWE9yemNPYkZKb2xLMnREcmIyTWd3U1FjdlZQb1lNUzZnVGRk?=
 =?utf-8?B?TVJwVy9kTjFiNXEvUXVzSnlPSzBIWWRYRktlYUtCSFlRR0NmRjhubDJNK2ZN?=
 =?utf-8?B?Zy9nNHBKRGtwKzMvR2JhQnEyZUd5dFhrWjRmaEdaZjlPRUcyR2tjdEJFMGcx?=
 =?utf-8?B?cEgzN29WOGhPdHpjN3ZRNy9YLzVhUXFBZnhCeVBnK3FCajk1bWpFNmhnV242?=
 =?utf-8?B?ankzR2lzUjVEWldYM1htdWhaWlNhcytvbzRFSExWUi83M0k0ZUF0WnBkSjdB?=
 =?utf-8?B?NUtvb3lWbTNEMXU2ZGNBcDJkeGZMUHFjVXI4eTBGdUY1aVFJR0hmcUxPZTh1?=
 =?utf-8?B?Y1lVMTlRbG1lVUZSV2FNSE5GWTdWRUdDb0hxZmhsNkhCZ1ZRalRobHNkV2w5?=
 =?utf-8?B?QWNGWGJ1MnVpY3VuekNYR1FNekFqcElaeS8ydzNPS2sxcjRtUDBnWDQ0byt1?=
 =?utf-8?B?Z3dXR2RRaWNNYkUzL0J5bEVPbGZNQ0ZLMEhrbmFOQXQ5bE43VkZaWktzZklH?=
 =?utf-8?B?akhBaUp0MUJ2YVZMcG1NUXY2NjN3R253Vkl0R045ZzlYb0I4bXc3SDZSZXVD?=
 =?utf-8?B?bmdyTW1RMUlXV1dUc00wbG5yS2dRNGJublozdUU3Q1BXYzNWbjVOMzhXdkRY?=
 =?utf-8?Q?PK2Jr5UA/T7RPrmbTWPTthk1f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b06f19-76aa-4eae-9de6-08dd780b39e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 08:39:36.7547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMXhr6fUYJ2kuaociWsGZxzcTw26xtHf8rGlIz5LS9eMUyvFWrUS+KYO/m8MuoYSlD8czxaptdGxCTiGywNhGjqHaDxxRpBNBInW9mQjznw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7123
X-Proofpoint-ORIG-GUID: rig6LyCJPaHYzSkzKwrjJF83_npb51PO
X-Proofpoint-GUID: rig6LyCJPaHYzSkzKwrjJF83_npb51PO
X-Authority-Analysis: v=2.4 cv=J/2q7BnS c=1 sm=1 tr=0 ts=67f783cb cx=c_pps a=AwHzoy/LmQvuowsjLxKu5A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=J15ouKGxgRCrGaVk_REA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100064

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCA4LCAyMDI1IDEw
OjA2IFBNDQo+IFRvOiBQYWxsZXIsIEtpbSBTZWVyIDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29t
PjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8amljMjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xh
dXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNoLA0KPiBNaWNoYWVsIDxNaWNoYWVsLkhl
bm5lcmljaEBhbmFsb2cuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47DQo+IEty
enlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleQ0KPiA8
Y29ub3IrZHRAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy8zXSBpaW86IGRhYzogYWQzNTMwcjogQWRkIGRy
aXZlciBmb3IgQUQzNTMwUiBhbmQNCj4gQUQzNTMxUg0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4g
T24gNC83LzI1IDM6MDEgQU0sIFBhbGxlciwgS2ltIFNlZXIgd3JvdGU6DQo+ID4+PiArCWZvciAo
aSA9IDA7IGkgPCBjaGlwX2luZm8tPm51bV9jaGFubmVsczsgaSsrKQ0KPiA+Pj4gKwkJc3QtPmNo
YW5baV0ucG93ZXJkb3duX21vZGUgPQ0KPiA+PiBBRDM1MzBSXzMyS09ITV9QT1dFUkRPV05fTU9E
RTsNCj4gPj4+ICsNCj4gPj4+ICsJc3QtPmxkYWNfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlv
bmFsKGRldiwgImxkYWMiLA0KPiA+PiBHUElPRF9PVVRfSElHSCk7DQo+ID4+PiArCWlmIChJU19F
UlIoc3QtPmxkYWNfZ3BpbykpDQo+ID4+PiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBU
Ul9FUlIoc3QtPmxkYWNfZ3BpbyksDQo+ID4+PiArCQkJCSAgICAgIkZhaWxlZCB0byBnZXQgbGRh
YyBHUElPXG4iKTsNCj4gPj4+ICsNCj4gPj4+ICsJaWYgKGRldmljZV9wcm9wZXJ0eV9wcmVzZW50
KGRldiwgImFkaSxkb3VibGUtb3V0cHV0LXJhbmdlIikpIHsNCj4gPj4NCj4gPj4gVGhpcyBpcyBu
b3QgZG9jdW1lbnRlZCBpbiB0aGUgRFQgYmluZGluZ3MuDQo+ID4+DQo+ID4+IFRoaXMgY291bGQg
aW5zdGVhZCBiZSBpbXBsZW1lbnRlZCBieSBtYWtpbmcgdGhlIG91dF92b2x0YWdlX3NjYWxlDQo+
IGF0dHJpYnV0ZQ0KPiA+PiB3cml0ZWFibGUuDQo+ID4+DQo+ID4+IElmIHdlIHJlYWxseSBkbyBu
ZWVkIGl0IGluIHRoZSBkZXZpY2V0cmVlIGJlY2F1c2Ugd2Ugd2FudCB0byBwcm90ZWN0IGFnYWlu
c3QNCj4gPj4gc29tZW9uZSBhY2NpZGVudGFsbHkgc2V0dGluZyBpdCB0b28gaGlnaCwgdGhlbiB0
aGUgcHJvcGVydHkgc2hvdWxkIGJlIHRoZQ0KPiBhY3R1YWwNCj4gPj4gbXVsdGlwbGVyIHZhbHVl
IHdpdGggYW4gZW51bSBzcGVjaWZpZXIgb2YgMSwgMiBhbmQgYSBkZWZhdWx0IG9mIDEgcmF0aGVy
IHRoYW4NCj4gYQ0KPiA+PiBmbGFnIChlLmcuIGFkaSxvdXRwdXQtbXVsdGlwbGVyKS4NCj4gPg0K
PiA+IFRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLiBUaGlzIHNob3VsZCBiZSBhZGkscmFuZ2Ut
ZG91YmxlLCB3aGljaCBpcyBhbHJlYWR5DQo+ID4gZG9jdW1lbnRlZCBpbiB0aGUgRFQgYmluZGlu
Z3MgYW5kIGlzIGFsc28gdXNlZCBhcyBhIGJvb2xlYW4gdHlwZSBpbiBvdGhlcg0KPiBkcml2ZXJz
Lg0KPiA+IEkganVzdCBmb3Jnb3QgdG8gdXBkYXRlIGl0IGhlcmUuIFRoaXMgaXMgYSBvbmUtYml0
IGNvbmZpZ3VyYXRpb24gdGhhdCBkb3VibGVzIHRoZQ0KPiA+IG91dHB1dCByYW5nZSAobXVsdGlw
bGllciBvZiAyKS4gIFNob3VsZCBJIHByb2NlZWQgd2l0aCB0aGUgc3VnZ2VzdGVkDQo+IGFwcHJv
YWNoPw0KPiA+DQo+IA0KPiBJIHNlZSBhZGkscmFuZ2UtZG91YmxlIGluDQo+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDc5MjMueWFtbA0KPiANCj4gV2Ug
d291bGQgbmVlZCB0byBhZGQgdGhlIHNhbWUgaW4gdGhlIG5ldyAueWFtbCBmaWxlIGFkZGVkIGlu
IHRoaXMNCj4gc2VyaWVzIGFsb25nIHdpdGggYSBqdXN0aWZpY2F0aW9uIGluIHRoZSBjb21taXQg
bWVzc2FnZSBvZiB3aHkgdGhpcw0KPiBuZWVkcyB0byBiZSBzZXQgaW4gdGhlIGRldmljZXRyZWUg
cmF0aGVyIHRoYW4gYXQgcnVudGltZS4NCg0KSSBjYW4gY29uZmlybSB0aGF0IHRoZSBhZGkscmFu
Z2UtZG91YmxlIHByb3BlcnR5IGlzIGFscmVhZHkgcHJlc2VudCBpbiB0aGUgYWRpLGFkMzUzMHIu
eWFtbA0KZmlsZSBhcyBhIGJvb2xlYW4gdHlwZSwgYW5kIGNvbnNpc3RlbnQgd2l0aCBpdHMgdXNh
Z2UgaW4gYWRpLGFkNzkyMy55YW1sLg0KDQo+IA0KPiBJZGVhbGx5LCB3ZSB3b3VsZCBhc2sgdGhl
IGFwcGxpY2F0aW9ucyBlbmdpbmVlciBmb3IgdGhpcyBjaGlwIHRvDQo+IGZpbmQgb3V0IGhvdyBy
ZWFsIHVzZXJzIHdvdWxkIHdhbnQgdG8gdXNlIHRoaXMgZmVhdHVyZSB0byBtYWtlIHN1cmUNCj4g
c2V0dGluZyBpdCBpbiB0aGUgZGV2aWNldHJlZSBhbGlnbnMgd2l0aCB0aGF0IGFuZCBpcyBub3Qg
dG9vDQo+IHJlc3RyaWN0aXZlLg0KDQpUaGUgYXBwcyBlbmdpbmVlciBmb3IgdGhpcyBjaGlwIGlu
ZGljYXRlZCB0aGF0IHRoZSBib29sZWFuIHR5cGUgZm9ybWF0IGFsaWducyBiZXR0ZXIgd2l0aA0K
aG93IHVzZXJzIGFyZSBleHBlY3RlZCB0byBjb25maWd1cmUgdGhpcyBmZWF0dXJlLCBlc3BlY2lh
bGx5IGZvciB1c2VycyB3aG8gbWF5IG5vdCBiZQ0KZmFtaWxpYXIgd2l0aCBzcGVjaWZpYyByYW5n
ZSB2YWx1ZXMgb3IgZW51bSBzcGVjaWZpZXJzLg0KDQo=

