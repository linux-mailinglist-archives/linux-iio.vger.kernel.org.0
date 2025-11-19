Return-Path: <linux-iio+bounces-26317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D5C6FA99
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 16:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DA6712ADB6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA32472B6;
	Wed, 19 Nov 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EkbkAHhL"
X-Original-To: linux-iio@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5D150997;
	Wed, 19 Nov 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566295; cv=fail; b=hNi72rlj/VZ2+CAqpRVPFIxCjU7pAMR9g9E05RmoFJwoctqCF4ZZHuEPiBEXOS2FusyzLTfZD6+XSZP2K7nQUw/Ef1o80X5CLYYHoI7hdPPFCquMLp1nZ9osj5pEfsn/alipO1csj8+y6ghzSzPcAQCqNuqqEZU9kzqxvYmC8jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566295; c=relaxed/simple;
	bh=wnMovSbReU8HkdRIIQV3ugVnrASCd3HclpI6DHByi3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BMaV4+HiR6sUTq7VzJ22tRIib1dGLs0WsChuhZtVmX2PXDedAITGw1M9u4uHqlIUdght9QL0IR8k+jIf91+TFepLHx6Wrvfo3PNcgY4rYViE3doFuIoG5gBs9RpmuI4aeerqs4F/24L7sK7hx+rvbgTI8Lm90HgJTysNNb1hgb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EkbkAHhL; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URWEYb9+cQQlDZb+SXTB6ODlvO9OTyIFP98C7VWam57gg1a/Wf707Rq4xmgPOSJNM3hW9OdIUpj/TzS7e3ZESXwiPRXbPVCqBnL17MOoAmPctQpPqIsxobS3V8opNZuIiljvb1ieGqFja/YN96XECZzXP+bG5KYg3ei8XpYj7SBVsia23I0Ns1P5n1gZf/YSJOTUFJYWIQnVSpG5ubLSCZDyxEstSTyBYBzvOrT0VyXUPBWtYVaE2CG73mJMuiqqDhSMSF0l8ce3PExClujGR67uwMVFYlWZ87jXgtfef/vn4oYVx8ApASW6Ojzmw2HjpeXkDU6F8xJiR8FBIa8AmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnMovSbReU8HkdRIIQV3ugVnrASCd3HclpI6DHByi3M=;
 b=ukaTZUxoElu9ecU3pAzvGoTObq5faX0mXD48HQ63OyJJB9+vORd3EjLwgNQIgneaSEfRHv+4glvDtgTeVv3xuyGg9DGNqRb/uc2ZcE3MVx6vc4fSYjg4ZTobGVA3SHdWP6ykvYKuT+IHaM/aC26h4wCW5fgYXslJLyrJzD6/s45T47lRo8TnlcV3lB8gW/W5bBG+9pul7KiDx4DcDl7Q2dOcN2MibOeoQ+LCZk9Xwmj3/PFgpkzDH5G4Cinywidggj5s/BXDRKayj7Zbl0BAGBXb6tHtlOjuyjOWVQ0VfqXfKUytZNHmIrpVNDObaMW66gqr9d1SU/XRMuolZC9HEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnMovSbReU8HkdRIIQV3ugVnrASCd3HclpI6DHByi3M=;
 b=EkbkAHhLplXnnyiNzBiZytQOyg3hc0NrXswwC9HiMpRUHFSY/t4rwOzbmMk0Pq7KFGAcwPU0Io2Pr2EKYaP6wjVu2rHGqnHErcwlE8+E8Ds9CjdrZm1XqueR3BAuONef1jWgQnn4YefJRPQ6RMFOrPuTneg4nnrCne5UybO070Vz5R979D7Tis29tpLq3UY+HBdyAIFIW7Q2EEhYbHO9lgejvjBsxVrCpwkZTZZhPwtkDXTuaIFx6GLfrrhGyn8HoH7fcERUAYbdHZvc0p6843v2VB75hIA8Ffvo2nERb89HeEdD9r83vddYG6tp/s3TF0R/GRM8GR1t+qc4sglmpw==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by SA3PR11MB7584.namprd11.prod.outlook.com (2603:10b6:806:305::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:31:25 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 15:31:25 +0000
From: <Ariana.Lazar@microchip.com>
To: <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: adding support for PAC1711
Thread-Topic: [PATCH 2/2] iio: adc: adding support for PAC1711
Thread-Index: AQHcPe+QwW9C2WH4o0WFP8h/mVHNELTJSm0AgDD7coA=
Date: Wed, 19 Nov 2025 15:31:24 +0000
Message-ID: <9741143f091acf1a2791ced6ea26f5cac720a283.camel@microchip.com>
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
	 <20251015-pac1711-v1-2-976949e36367@microchip.com>
	 <20251019112846.774d7690@jic23-huawei>
In-Reply-To: <20251019112846.774d7690@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|SA3PR11MB7584:EE_
x-ms-office365-filtering-correlation-id: 89275781-2bb8-4340-b7a6-08de2780b369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGpsOG1QenJlSjk0bGtpOGJ1NzB5WXM2WjRGVFFmak9JVXRXYzJZVjJJOEdt?=
 =?utf-8?B?MlRLUlVyQUhsdmhBVWljUmVWQmJPWGRHeVBNeEVsMFN0K0R6akNmZWdJSGti?=
 =?utf-8?B?M0VHbTk2YmZ2ZFJHQjZOZzVCSDFUMnBNWFh5U3lqdXdRdG5wUDMzRG5wcmNH?=
 =?utf-8?B?bG5MbkJWaVAzbnJTVU45TU00Mm12WnNEVWd6aTIrMlJ2b0g3Z05FTVBPWThm?=
 =?utf-8?B?TWw2OEY5NFhrUEFDZTQ3MjRqWjJKZWJTQ2I3L0xzZzd3ZjIxTXZzd1ZzUlhH?=
 =?utf-8?B?YjNPc1FzeEVXQVlzc2c0SmJRenBzU2EwMjFNL2MwM1MzaG9rcHVsdVNEMVI5?=
 =?utf-8?B?RE12WnpHNWJXd3Q2QmthWDJUc25ucUZvakdncEU4WDAwSitZNEFYeHRzRTJS?=
 =?utf-8?B?QkpkSUFUcUlIRFVJaS94OC9zS20vdDBvaFlMVjRjL1ljaDNBck9yQ3NXKzhU?=
 =?utf-8?B?RS84Y21zZ0oyNDl4L2RxMkZnYjFaN3BMcVY2UUtTd3dIdTJ3d3dpTS9NMDJ6?=
 =?utf-8?B?K1JScWwzZElpOE9pOUR4c1Y1K1d1OFZKa3k3bFhNdTNtZmVNdVovVVl6QVA2?=
 =?utf-8?B?dFVpZWdBTnhzd1FpWjFjdmpxanFPY2JadHhkcHRRTUlLVk9zY2ZnS01hLzlJ?=
 =?utf-8?B?NzhLTVZ4bjhESGRhVSt4WTBzSDJkV09qdDNBeXBmUkdLQjJaZDhjTEkrTGdz?=
 =?utf-8?B?OWRyTUJ5cUFRZ053VkdhVlBmYXUwQXMyQkIxN3FTOFdOZlh4UHhWQkc0VXJO?=
 =?utf-8?B?MjN0a0pzZ29kVWZWK3pYUDVhcUgzS05kS0VDUFhNRjlEOGhtVDFML2RDbFM2?=
 =?utf-8?B?VkpBT1h4QTV0L2tCdTVlMWdlSWN4RnRaVzNPdk9HaGJxYS9FcVhab2M4OWdn?=
 =?utf-8?B?OUVNa05MclRWZXZNNnVuQTJtc25Tbmk0YnpaOW5lS0lndXpUYXpIYnFNeVBw?=
 =?utf-8?B?dzdPZEUxK2NQbkc2YjBPL3R2MWx0STlEYnNieWFPNE5oczFOT1hFUGtjMEVn?=
 =?utf-8?B?VzFKUHRSSGpqSm5JMVRrZGt6ajdKbG5pWXJydXVLZ2V2YTJUN3dNeVd5UXNk?=
 =?utf-8?B?TWtOTmhDeHo2RE5MRE1FZEkrQ2pLKytoUUJqZ1oxNDZvUG1lNGNWMkNPNUVH?=
 =?utf-8?B?VjRVU1VvOWRyZUhBcHp6QW9FYS8yZnVmWUFVVUd3bVo2cEJMUTZkL3B3YzA5?=
 =?utf-8?B?eTZvZkpJQ0hrNDJrK3FWQTdBTG5Obnd3d2VIZ09sUm5VcmNGd0RpVWNIYWta?=
 =?utf-8?B?NnNaUit4Tk9DNER5SGV3c0g1MW15ZTZQd3dFWTA1N3o0azVvVWVQUFNrWVh0?=
 =?utf-8?B?UFBUYzNNbGtrWHNrNzcvS2tob0VLV01ncmszdklBLzJXOTducVZ5UmtoSGNZ?=
 =?utf-8?B?cUg5NVdNakp1RDV1MnlvalNMbThnZEUvSVFmVlVOSEFTVWtjWkVxRDU0WTIv?=
 =?utf-8?B?d2FSb2N0Smd1RGVJSjFWOUVCUVorL1htdjcwdVlEdmhibFlTcmtobUZmbVZ1?=
 =?utf-8?B?UUZCL3A5MmI5Ukl4dVBrNmFucFhlT045OXZOUnpaNW4wQm5vcjRxSHpjdy8v?=
 =?utf-8?B?RFhFOEh3dDlBM3RlbGFxSU9yWnFySU5rekJxR1JZaGV1M0w0SGhSNmlNbTNW?=
 =?utf-8?B?RVpzR3d0blJEN1VNRTQ4dEdaa0tvWTJPRnlHcFFjSklFV09rT25PeG5paXRB?=
 =?utf-8?B?c0IxeGlSNUN2elZyQmlUWXJHNnJyK3F4L3M5VmFPZGR2RjlJdzV1ZXQvd2xZ?=
 =?utf-8?B?RmZGUHlZS2lPV1NtQ2k1VkZPeGJaeEZDV1BGVGxpaDJOenEvcWNmeXd1ZWYw?=
 =?utf-8?B?b01hZXpQa1JDT0lYSURFdlpzeHRqTDFyaXFUYmlKalZrR1VUcThqQzUyZ1BX?=
 =?utf-8?B?OE9EdTNEelp1bUxlTkpPSFM1clVoNjY3MDROWWtobGxEUDlQT0o3a0tGbWM5?=
 =?utf-8?B?M2dtZWxzendjbmtkOElnR3hWajdGVGRkUkZKTExheTFDdlM2dFpBbnB1TU1C?=
 =?utf-8?B?b1R3K1c3RTR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0Q3KzI3aFg0ZWtnRk94c3YydmlTZUxnbGV3SnpEbHRNODc2U2tldlFyREJE?=
 =?utf-8?B?eGl0OEprTzJhT2ZCcGxuMGZydUsxUTY5LzRxZnQxNEtmWWUwN2M2YnZKVEtN?=
 =?utf-8?B?QzVZZGxMUzRyakNmMVJzNkVYRXBHT20zdW1HeWRKRmNLYTl1dTNJZGY0K2sr?=
 =?utf-8?B?VGZJMS9KUHhkN3RCZGc4L2M1OURGak5pMWovQU10VCtoN1FEem14MXhBWmVo?=
 =?utf-8?B?K1RLejBZMDNEN0c1VmVXdGxieWptV240MFczM1lLOVIrTGFxWFhoYWZ3bTZp?=
 =?utf-8?B?WC9CbGFjVTVkRURaRm1TZ0lpODJnOXY4ekJKUGZQemNEeWlXZTA2aG5DakI5?=
 =?utf-8?B?bTFEVVIwcUtIT3FmQUpjWlJvMkE3a0kyZGFGMjVPTzcwUnJxZm1KcEgveVYz?=
 =?utf-8?B?TWdjNENySWlFWjBWMTNQM2h3L3lZQ3hvNlpIWDhnam9qN0RmbGc2azUrM24z?=
 =?utf-8?B?Z2VoZy9mSS9DWmp6TzB2VkpKK2dMNU8vTEhUSk41d2xKNzY4NndmQ3djWkpn?=
 =?utf-8?B?TjhTSGUxSEJkVmZheFZtMWtvekNJQjg1TWIrYmN5dkZSY0VmMGMwTzlTUHYy?=
 =?utf-8?B?L0x5cTlYMDBiVkxYeEdxMVRyVGkxZFRqdzFRR2FER3hMR1p1UFhGd09veE10?=
 =?utf-8?B?UHdYOFdwUUZ3NU5rTStVaVUzTmpESEh0K0Q5T1orL0VQWnozait6bmJycW81?=
 =?utf-8?B?UWtzSDZsNVZGc2pSc0VmdFlLWmFuR1N2WGZXc2NwSFFBd1JQOWU1aUtvb0lO?=
 =?utf-8?B?MHVoaGI5VWpZcGRLd2NheHdaaUw0M1RUUFdxVkxSN0dBUlVkL1lHYTc4SkFv?=
 =?utf-8?B?dURURFozSXRkY25QeDVLMTdNWE45VlJZUVN2ZzBaSWo1b3V2U0NkSEpFa2lz?=
 =?utf-8?B?WHV5MjJRa3hseXkvckdzaXRGZmJzc0Y5WGZrU0hULzhmSDlSZzZYOTZpZzBK?=
 =?utf-8?B?bEIyQnFJcURWaXNwQTB0VkdoV3hHUzdPL0J1eVE1ZHM4WmxWc2JNSG5FU2Uv?=
 =?utf-8?B?UHhWSG5BOURrajgrRGdUa2luMzBFM2hwSkFxYmdVTHB1ZERqSTZ4QzFOU1N5?=
 =?utf-8?B?QnV4TnRWamhMWVFFMVY4a3ZyMklkT0pSWnRYQ0VJcmtSaWFtcWdjU05hZ3k1?=
 =?utf-8?B?SE52WUZZVk9BMDJ6aHJZcnhoTGd2Q0xMdWluNklXaGlKWDIzeXFSZTNPckdr?=
 =?utf-8?B?dWFTbG1oQ1cxSVRCcVBSUWh5UlA1QlFHQkNEd21ma3hyZSthcHBsdEcvTUd0?=
 =?utf-8?B?eTZkNFFUR1dSS2x0OEZvc2Jld0VKS1k5Y3NKMmxwK0F0Nkt3b0hINDJHTTIw?=
 =?utf-8?B?NjE5R1Y1TFhoSzRpRldvNUVPTkNkcm1DWUpCdC9PVnpyOGtsVlBHdFpDTkhR?=
 =?utf-8?B?TVFHWDROQ3RoQ08rdlJYSzdzb2hFbDJmUkZaL0hEQWFtVHY1SnZEVUErMjJL?=
 =?utf-8?B?dzBMcy9XSTFYUlhvZCtrS213ZXJLcjNKTGdUU1JuN2RiZG02MXVwdjNOV2l6?=
 =?utf-8?B?Z3RvRGNMMDBWRkFzQnV6QnRLbFhyOEdoZCtrVWJVWDdEY2FtcTFHMDNUR1NR?=
 =?utf-8?B?YjNEODdoc0NtcDV1YzFUS21BOWtYYjVGUk1MTmxlYkRiUFUzWDhhWWlDOEYx?=
 =?utf-8?B?SmduVnE5UGJxMFA4M3piNzVjM1QyV210c0VZNDZ6eVI0Njl4UWF2NUhBeElN?=
 =?utf-8?B?R2hPWFNIdjJZNWxSdDJTWUllQ0JPaUlaYkx1VFBVaWhiV2NvQnVXR3cwWERm?=
 =?utf-8?B?T0NOTjVDOWxxT3pXZCt5VnhYWUxIS0lKbXJYQ2I3ekRCcVIzZXk4NlY2RmdL?=
 =?utf-8?B?OU1kcXR3eHV2TXI5NWZlQkdUYzhSZlA4S29rNXNnUWtFTExqQndlWDVxVXIv?=
 =?utf-8?B?SVBMb0dTZ2FSV3JYWEJ3bzdJb2F0MmJ0UlIzRnlnV0orQnpNdGpJZGdJM0ds?=
 =?utf-8?B?NThFcEpPMElkQlpBbnlrbVp1ckNKZVM0YzdSSlVtQ3c5aWNBOEZ4SGRJdWFw?=
 =?utf-8?B?eDhXWjB3R1NRWHIzVURiejc4UGxhQXl6WlpJMml5dzNQL1JzdC8zWWZURDZq?=
 =?utf-8?B?THdNL2ZpbmRmdndJTXhWdzZCRnVHS05WSFdJa0Q3NUF3Y2VjZmpldFdxNUVO?=
 =?utf-8?B?Z2s3NjlJZlhHdlU0TzRENzl3SzB4WG1WRW1QZDk0cUYyZ1ZmZExvY3pIRWo2?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <378ADAFF70478A41B0AD7F9557D02656@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8251.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89275781-2bb8-4340-b7a6-08de2780b369
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:31:25.1546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytI8+FqeMa9RErMa6A3MB8NECC6xHXXiaHGYB7irx+KpxWV8tPQ8zz0sZH1vDVOi/PN2mOvRxJy48NVwprBtVGxthngbMhTJhTUWVAPCldM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7584

SGkgSm9uYXRoYW4sDQoNClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLCBwbGVhc2Ugc2VlIG15
IGNvbW1lbnRzIGJlbGxvdzoNCg0KPiA+IEJlc3QgcmVnYXJkcywNCkFyaWFuYQ0KPiA+IA0KPiAN
Cj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUgdTY0IHBhYzE3MTFfZ2V0X3VuYWxp
Z25lZF9iZTU2KHU4ICpwKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgIHJldHVybiAodTY0KXBbMF0g
PDwgNDggfCAodTY0KXBbMV0gPDwgNDAgfCAodTY0KXBbMl0gPDwgMzIgfA0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKHU2NClwWzNdIDw8IDI0IHwgcFs0XSA8PCAxNiB8IHBbNV0gPDwg
OCB8IHBbNl07DQo+IA0KPiBIbW0uwqAgTWF5YmUgdGhpcyBvbmUgaXMgcmVhc29uYWJsZSB0byBh
ZGQgdG8gdGhlIG1haW4gdW5hbGlnbmVkDQo+IGZ1bmN0aW9uIHNldC4NCj4gUGVyaGFwcyBub3Qg
eWV0IGFzIGEgZ3JlcCBkaWRuJ3QgZmluZCBtdWx0aXBsZSBvZiB0aGlzIHNpemUuDQo+IA0KDQpU
aGVyZSBoYXMgYmVlbiBhbiB1bnN1Y2Nlc3NmdWwgYXR0ZW1wdCB0byBzdWJtaXQgdGhpcyBmdW5j
dGlvbiB0byB0aGUNCnVuYWxpZ25lZCBzZXQuIEl0IHdhcyByZWplY3RlZCBiZWNhdXNlIG9mIHRo
ZSBsYWNrIG9mIGN1cnJlbnQgcG9zc2libGUNCnNoYXJlZCB1c2VzLiBQbGVhc2Ugc2VlIHRoZSBk
aXNjdXNzaW9uIHRocmVhZCBiZWxvdzoNCg0KaHR0cHM6Ly95aGJ0Lm5ldC9sb3JlL2xrbWwvMjAy
NDA5MjcwODM1NDMuODAyNzUtMS0NCm1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb20vVC8jdQ0K
DQo+IA0KPiANCi4uLg0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgaWlvX2NoYW5fc3Bl
YyBwYWMxNzExX3NpbmdsZV9jaGFubmVsW10gPSB7DQo+IA0KPiBBcyBiZWxvdy4gQ2xlYXJseSBu
b3QgYSBzaW5nbGUgY2hhbm5lbC4NCj4gDQo+ID4gK8KgwqDCoMKgIFBBQzE3MTFfVlBPV0VSX0NI
QU5ORUwoMCwgMCwgUEFDMTcxMV9WUE9XRVJfQUREUiksDQo+ID4gK8KgwqDCoMKgIFBBQzE3MTFf
VkJVU19DSEFOTkVMKDAsIDAsIFBBQzE3MTFfVkJVU19BRERSKSwNCj4gPiArwqDCoMKgwqAgUEFD
MTcxMV9WU0VOU0VfQ0hBTk5FTCgwLCAwLCBQQUMxNzExX1ZTRU5TRV9BRERSKSwNCj4gPiArwqDC
oMKgwqAgUEFDMTcxMV9WQlVTX0FWR19DSEFOTkVMKDAsIDAsIFBBQzE3MTFfVkJVU19BVkdfQURE
UiksDQo+ID4gK8KgwqDCoMKgIFBBQzE3MTFfVlNFTlNFX0FWR19DSEFOTkVMKDAsIDAsIFBBQzE3
MTFfVlNFTlNFX0FWR19BRERSKSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBJSU9fREVW
SUNFX0FUVFIoaW5fZW5lcmd5X3JhdywgMDQ0NCwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcGFjMTcxMV9pbl9wb3dlcl9hY2NfcmF3X3Nob3csIE5VTEwsIDAp
Ow0KPiA+ICsNCj4gPiArc3RhdGljIElJT19ERVZJQ0VfQVRUUihpbl9lbmVyZ3lfc2NhbGUsIDA0
NDQsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhYzE3MTFf
aW5fcG93ZXJfYWNjX3NjYWxlX3Nob3csIE5VTEwsIDApOw0KPiA+ICsNCj4gPiArc3RhdGljIElJ
T19ERVZJQ0VfQVRUUihpbl9lbmVyZ3lfZW4sIDA2NDQsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhYzE3MTFfaW5fZW5hYmxlX2FjY19zaG93LA0KPiA+IHBh
YzE3MTFfaW5fZW5hYmxlX2FjY19zdG9yZSwgMCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgSUlPX0RF
VklDRV9BVFRSKGluX2N1cnJlbnRfYWNjX3JhdywgMDQ0NCwNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFjMTcxMV9pbl9jdXJyZW50X2FjY19yYXdfc2hvdywg
TlVMTCwgMCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgSUlPX0RFVklDRV9BVFRSKGluX2N1cnJlbnRf
YWNjX3NjYWxlLCAwNDQ0LA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwYWMxNzExX2luX2N1cnJlbnRfYWNjX3NjYWxlX3Nob3csIE5VTEwsIDApOw0KPiA+ICsN
Cj4gPiArc3RhdGljIElJT19ERVZJQ0VfQVRUUihpbl9jdXJyZW50X2FjY19lbiwgMDY0NCwNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFjMTcxMV9pbl9lbmFi
bGVfYWNjX3Nob3csDQo+ID4gcGFjMTcxMV9pbl9lbmFibGVfYWNjX3N0b3JlLCAwKTsNCj4gPiAr
DQo+ID4gK3N0YXRpYyBJSU9fREVWSUNFX0FUVFIoaW5fdm9sdGFnZV9hY2NfcmF3LCAwNDQ0LA0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYWMxNzExX2luX3Zv
bHRhZ2VfYWNjX3Jhd19zaG93LCBOVUxMLCAwKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBJSU9fREVW
SUNFX0FUVFIoaW5fdm9sdGFnZV9hY2Nfc2NhbGUsIDA0NDQsDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYWMxNzExX2luX3ZvbHRhZ2VfYWNjX3NjYWxlX3Nob3cs
IE5VTEwsIDApOw0KPiA+ICsNCj4gPiArc3RhdGljIElJT19ERVZJQ0VfQVRUUihpbl92b2x0YWdl
X2FjY19lbiwgMDY0NCwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcGFjMTcxMV9pbl9lbmFibGVfYWNjX3Nob3csDQo+ID4gcGFjMTcxMV9pbl9lbmFibGVfYWNj
X3N0b3JlLCAwKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpwYWMxNzEx
X3Bvd2VyX2FjY19hdHRyW10gPSB7DQo+ID4gK8KgwqDCoMKgIFBBQzE3MTFfREVWX0FUVFIoaW5f
ZW5lcmd5X3JhdyksDQo+ID4gK8KgwqDCoMKgIFBBQzE3MTFfREVWX0FUVFIoaW5fZW5lcmd5X3Nj
YWxlKSwNCj4gPiArwqDCoMKgwqAgUEFDMTcxMV9ERVZfQVRUUihpbl9lbmVyZ3lfZW4pLA0KPiA+
ICvCoMKgwqDCoCBOVUxMDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IGF0dHJp
YnV0ZSAqcGFjMTcxMV9jdXJyZW50X2FjY19hdHRyW10gPSB7DQo+ID4gK8KgwqDCoMKgIFBBQzE3
MTFfREVWX0FUVFIoaW5fY3VycmVudF9hY2NfcmF3KSwNCj4gPiArwqDCoMKgwqAgUEFDMTcxMV9E
RVZfQVRUUihpbl9jdXJyZW50X2FjY19zY2FsZSksDQo+ID4gK8KgwqDCoMKgIFBBQzE3MTFfREVW
X0FUVFIoaW5fY3VycmVudF9hY2NfZW4pLA0KPiA+ICvCoMKgwqDCoCBOVUxMDQo+ID4gK307DQo+
ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqcGFjMTcxMV92b2x0YWdlX2FjY19h
dHRyW10gPSB7DQo+ID4gK8KgwqDCoMKgIFBBQzE3MTFfREVWX0FUVFIoaW5fdm9sdGFnZV9hY2Nf
cmF3KSwNCj4gPiArwqDCoMKgwqAgUEFDMTcxMV9ERVZfQVRUUihpbl92b2x0YWdlX2FjY19zY2Fs
ZSksDQo+ID4gK8KgwqDCoMKgIFBBQzE3MTFfREVWX0FUVFIoaW5fdm9sdGFnZV9hY2NfZW4pLA0K
PiANCj4gSWYgdGhlc2UgZGlkIG1ha2Ugc2Vuc2UgKHNlZSBvdGhlciBjb21tZW50cykgdGhlbiB0
aGV5IHNob3VsZCBiZQ0KPiBkb25lIGFzIGV4dF9pbmZvIGZvciB0aGUgZ2l2ZW4gY2hhbm5lbHMg
cmF0aGVyIHRoYW4gZ29pbmcgdGhvdWdoDQo+IHRoZSBjb21wbGV4aXR5IG9mIGN1c3RvbSBhdHRy
aWJ1dGVzLg0KPiANCj4gQ3VzdG9tIGF0dHJpYnV0ZXMgbWFrZSBtb3N0IHNlbnNlIHdoZW4gbm90
IGFzc29jaWF0ZWQgd2l0aCBhbnkNCj4gY2hhbm5lbHMuDQo+IEEgbG90IG9mIGRyaXZlcnMgaGF2
ZSB0aGVtIGZvciBoaXN0b3JpY2FsIHJlYXNvbnMgYXMgd2VsbCB0aGF0IHdlDQo+IGhhdmVuJ3QN
Cj4geWV0IGNsZWFuZWQgdXAuDQo+IA0KPiBFdmVuIGluX3NodW50X3Jlc2lzdG9yIGlzIGNhbiBi
ZSBhIHNoYXJlZF9ieV9hbGwgZXh0ZW5kZWQgYXR0cmlidXRlDQo+IGFzIGl0J3Mgc3RpbGwgYXNz
b2NpYXRlZCB3aXRoIGEgYnVuY2ggb2YgY2hhbm5lbHMuDQo+IA0KPiANCg0KQXMgZm9yIHN3aXRj
aGluZyBhY2N1bXVsYXRvciBjaGFubmVscyB0byBleHRfaW5mbyBpbnN0ZWFkIG9mIGN1c3RvbQ0K
YXR0cmlidXRlcywgb25seSBfZW4gY2hhbm5lbCB3b3VsZCBiZSBlbGlnaWJsZS4gQm90aCBfcmF3
IGFuZCBfc2NhbGUgZG8NCm5vdCBoYXZlIGNvbnN0YW50IHZhbHVlcywgdGhlcmVmb3JlIGNhbm5v
dCBiZSBkZWZpbmVkIHdpdGggY29uc3RzIGF0DQpzdGFydHVwLiBTY2FsZSBjYW4gYmUgbW9kaWZp
ZWQgZHVyaW5nIHJ1bnRpbWUgYnkgY2hhbmdpbmcgc2h1bnQgdmFsdWUNCmFuZCByYXcgY29uc3Rh
bnRseSBhY2N1bXVsYXRlcyB0aGUgcmVhZCB2YWx1ZXMuIEl0IGlzIG5vdCByZWNvbW1lbmRlZA0K
dG8gc3dpdGNoIGFjY3VtdWxhdGlvbiBtb2RlIGR1cmluZyBydW50aW1lLCBidXQgdGhhdCBkb2Vz
IG5vdCBtYWtlDQpwb3NzaWJsZSBkZWZpbmluZyBhcyBjb25zdHMgdGhlIF9yYXcgb3IgX3NjYWxl
IGF0dHJpYnV0ZXMuIElmIHRoZXJlDQp3ZXJlIGFuIHdvcmthcm91bmQgd2hpY2ggZG9lcyBub3Qg
bmVlZCB0aGUgZGVmaW5pdGlvbiBvZiBpdGVtcyBhbmQNCm51bV9pdGVtcyBmaWVsZHMsIEkgd291
bGQgc3dpdGNoIHRvIHVzaW5nIGV4dF9pbmZvLg0K

