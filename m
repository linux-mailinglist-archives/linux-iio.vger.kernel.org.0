Return-Path: <linux-iio+bounces-7490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4855392D4E8
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2024 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA01B21FF4
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B4719415C;
	Wed, 10 Jul 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kd5YoOaN";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xi6XdeMa"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2170190678;
	Wed, 10 Jul 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625135; cv=fail; b=bIuv+YsZ1q2CoQTsafzVU6zmz7ugGrbesCiRnoWO0aZjcSe6dPphdCsY2L8pxZFRIujlvmv/SeArtFJF8bhnL7gbVNwWMXaAZwP92SrCIFdTi9ACelyC9x8qkFrlRw1dZZgHqFGdWgKHPhElhKPRD18OV4CPbBbwtC/WDEVL/ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625135; c=relaxed/simple;
	bh=yU7nktb09lTjwO660NXNTicXYahVPg8dK9R+h46FKMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pB1r2L2oo6Njfl3FCYmGWjLegTVz0z/sIaqfWEDv1KzANISazCw49hCBbOfOd/+hUaHc8HwyUXV+nz7TnbMyZ6IXxng5QYq7phsVIwEDyCCO71SWmeVGacHydcgNKZkktc5pzegiU4yp/EFf8uIX2oLjLVXZTcVRzFrAB+3KzZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kd5YoOaN; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xi6XdeMa; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720625133; x=1752161133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yU7nktb09lTjwO660NXNTicXYahVPg8dK9R+h46FKMc=;
  b=Kd5YoOaNQKbztLnVK4cz99c0fuTOIim7s3p45vLOKYZrbRK9a3cjOLSl
   XGarXQzT7c/6kKhIXthehl5EHYO5yEBbX0v+LGnJHX6+4YKgRVYMwLgYI
   FnBY8dTaPfGKaMh6LdyRDAvPF4ntjCg5SsyrG8RK74CQIH+YoPV3EPFyl
   Ww1V1RXGgst7oK3L2xu7Ixep9xZkqlXufJUL1UkPhxU1YyWxq/tew4OXP
   dfX/DNSPfIpgG1eV5G+4y1jVWgx9qCcTuF5u6OwLLMN8UpNEgfR2V0fnw
   h3fTU4saS7briWeMVW6DGFm1gCxpxHfGe0NjRqAKSy/KokWhu3v6nhRlq
   A==;
X-CSE-ConnectionGUID: nZPvG1HuTsG25ISP9uYERQ==
X-CSE-MsgGUID: CYjZDtQCTIypmIPpCRjZ+g==
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="259955904"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2024 08:25:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jul 2024 08:25:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jul 2024 08:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABbTX2cxs9RSTtICUwBzKWq9y82FU/e3yYCgJpkCYbuwO/BrtCBBdCvhHp+5J2OAJt2WutJjQ7POSzrsZXWfxFDej0hZGTDGWIvgSSPebiIJp8pYuv+DgEDUi4/jOnHq6ruJfdh3t74hf2W+M77ZMCTmG8BI6F0LLsK8EFpvumHnsBy9k2iKE2quVWog8fxAwNhiong6S6Q5MbsR5b8BCZveqTcIr15TUm8YRszZh3lUGyD5RO50kx+5u4GpSgOWjFosG5Trha4v42PurvjM6gGe1x2Sdt7yJJXRabpUBb3YlO24K8e8n3J8+IiRUbxJ2nij+DXCjCJg8vuOk0CqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yU7nktb09lTjwO660NXNTicXYahVPg8dK9R+h46FKMc=;
 b=kqfjEHz5R2ZtiBE10Yhvlfa1wlN01s6eo1ZP8K5U5PNQXW6rHhy3HqUa0CFmBt+R2X2tKEUQobQaLaCulyA+5yazYx2flUTLRhTNqljsMSbyvqaOkaNq5bBKNzbKzsOK/jlI5GVKJt/33KjJNGqXBcU+kStX7Nsqp11OoCT+NEv/AqD1QUJ1UXACv73ShXpEn+NB67Y7+/9ziNr9/QFC5LQgnRZS87Lxo5TUfXgQKGfs2/Ur1eojFsNML/87isD1a9bWWu1V3gwJo4p5Poss+eAOvQbifP8b0SRxZLxnKsYaW4xk62X4Xa7T3POJ7btZJAgj5lf44EHEKdTlPdKMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yU7nktb09lTjwO660NXNTicXYahVPg8dK9R+h46FKMc=;
 b=Xi6XdeMaonF9CLkMolaw9wIXFNDYOEpJJhqfIx15dJvTg7UWY+Sye/GvJQ5hAscJ6CbzjdTfX4TKYnmqQT4YlhITC4bo7wblQDtR9IQiR3eTI8laXvafiHOdBDG52yupowiBC8VMDldmBhbXX88JvGUVsfvB4Bn1PHpSnX0fvuFkesd/GcMT1WTRd2OBzyJKGOGEwUjL1Sd/3FQJg/GFRLPgWz35SoRJypLivxF2RreJweBMfknNEtoH71B+kfdFV1xKjT8FwFuvGVcR39pSwYsdB0EG5XeayPmi0Kizael0UqKb8quZhahb1gFuMkvNTC3l/wchpSjXAksSub0BVg==
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (2603:10b6:805:c6::10)
 by CH3PR11MB7893.namprd11.prod.outlook.com (2603:10b6:610:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 15:25:08 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 15:25:07 +0000
From: <Marius.Cristea@microchip.com>
To: <Jonathan.Cameron@Huawei.com>, <matteomartelli3@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<robh@kernel.org>, <lars@metafoo.de>, <linux-kernel@vger.kernel.org>,
	<krzk+dt@kernel.org>, <jic23@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Thread-Topic: [PATCH v2 2/2] iio: adc: add support for pac1921
Thread-Index: AQHazjmP/m+FUirFLUmAMKoURJhChrHrYYoAgAF6owCAADDUgIABCHCAgAIIzIA=
Date: Wed, 10 Jul 2024 15:25:07 +0000
Message-ID: <db5f4afee71043ff6a0b2e75c6e905aa37e658fb.camel@microchip.com>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
	 <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
	 <20240707160442.6bab64c9@jic23-huawei>
	 <668bec2a8b23a_6e037017@njaxe.notmuch> <20240708173439.000070b4@Huawei.com>
	 <668cf2f3ece62_1f6ba37012@njaxe.notmuch>
In-Reply-To: <668cf2f3ece62_1f6ba37012@njaxe.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3167:EE_|CH3PR11MB7893:EE_
x-ms-office365-filtering-correlation-id: 63e4ff45-e04f-4f13-a628-08dca0f47b24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NytXdm5iVmVkQjNVb0taRERub0NiRE44NGlNdFhrcUwwZUhtazRteWEvbTFM?=
 =?utf-8?B?YXcyTnB4dnA1cVdDdmZUZWdQaCtPeW5uTmdMREJoZWRYZGl2cFYyL1FIbGEv?=
 =?utf-8?B?dGZkTUFHNDhiQ0ZGelo2NWFXSjRnd3hIS09ibEhOZkgzSFI3SE1saEJtWC82?=
 =?utf-8?B?Mi9IbWpDM1hPcnNib2lLSTZLdGZXRzVCaEcwd1NUWVNwUVBCTVg0N280OFVG?=
 =?utf-8?B?MzBqOXIySDJQeWladU1rNUQ2ckVxWi91ZStDTFppbGFId3JjZExRZWUrSnVW?=
 =?utf-8?B?VmJtZFppTFgxd1E2OFpKMmZMa2wwdjhobWtZK0tRaGxMQTNJU1Vhanl1Z0VS?=
 =?utf-8?B?K3ZWelY2WWIyNDdBbEliNDdMOVhIVlJmSnNFL1pGYmdHSTJpeVdUUjZDQSta?=
 =?utf-8?B?Rm5rMXAwRXZLU2RsOEJ2aURFMkxNWnkweTk5OGhXNlJwZ2g2SmZJMTg0TUZW?=
 =?utf-8?B?M2d4S3pIWE4zVzgvOWFLaHNoMU44KzZOQlA4Qlk4a1VDQW1nbVdyUlh5R0t0?=
 =?utf-8?B?L1JFcHhMZmY2eWMxWUUvTGhTUWs2RWJjZkxZMUx4amNEMXVUMlUzUlE5aHlB?=
 =?utf-8?B?UGJSaVNIM0IyT0I1Y0g3ZXowMXNBZm1qZUxCbmRSemNoVGY4eTFpZDR1Nldk?=
 =?utf-8?B?M29vODRUajkxOU52STBxZ3M5OWQ4V0xDZzROMFRTOTFZQ1dBdENHRDc4Y0V2?=
 =?utf-8?B?bnp5TlVMMTQrakY0eXNLTU1Wc0ljcG9qbWRaWWE2MFlXWloyaytVcVhnbVFx?=
 =?utf-8?B?ZDdIR0cvRGdtaEtnRkFXQngyL1M3VUh6RWxBK2N3ZEhOenZWZ3VEd1c1b0JT?=
 =?utf-8?B?MEFpK0x5VHV0MVJNMHNhTFkwWmE1dUpiY3o5ak9wWlpmWmVyRjNOK0t0Z2tw?=
 =?utf-8?B?S280aldiYzM5QlBjS2JselZPMEFFa1JJQjF2VHJXZC9pcWtZNDVSVEJNWDJF?=
 =?utf-8?B?LzRiRU1ubEUzNzc1TEhISFBDODNuWXZWUjZRWE03R3JsZTltU3BjN0NsU05M?=
 =?utf-8?B?UlFNTXc2YXYvZVF5b3o3MmUxSXVSMzlFSEhETjFIZUx0UitHYzlnNVBPTHhH?=
 =?utf-8?B?SHBIMmZVbnlWWUR2V2gvZHZZdTVEamFFYUFzNjMzOExIbjBGVGFuemNyTnBV?=
 =?utf-8?B?Qlppdks3MHRYZ0ZDSmc1TE1oRkVGMVlEMytybzlmLzZUUFkyWFp5ODEvVkxq?=
 =?utf-8?B?M0lDRW5XOHRzUWYwYzVydVpmbjhUb294UFVDR3RXbW9uU0tsSzJTOTV5aHp2?=
 =?utf-8?B?Ty9CUnlobjZNcVJETGVHRTkvZEQwY1U2TWt6eDF0aWY5T1E2TlNYZUlNVm5H?=
 =?utf-8?B?Um1jcjVhbGdvYkRUYVpna3FaVlhqTWFjM0dpcXN6SXpiblFvWnRuR25sTTc1?=
 =?utf-8?B?MjhmL0NteDNsUUpUQk9BazZrbU1HcFNoSDdXajB5dWJLaGZBNUVnWHJhY3dF?=
 =?utf-8?B?WWFTVnRVQXUwQjlVOXUvK01MOXhDZmU1THlraXY2SWtJMU9xSlNKcyt4MS9w?=
 =?utf-8?B?MElYME5WYy9OaERMaW5ka05kVDdsRWFvYmF5NnV1cFk5bkM2TVVsdWdKVmhN?=
 =?utf-8?B?a2VkR0xmd2F0VkN3UXN2R2xiZkNIV25QdnpTeFNBWnBuYXZFdE85R3V1TkRQ?=
 =?utf-8?B?YzlOUEM1V3ZLdUxBWFRCN25JTDBxZTBKalJXRXJ4RkxCWnF6T0tXY0R4cjhr?=
 =?utf-8?B?WWxrOGxXR2tkYlVOaENGUVZRUTdxbW5CYzh5NE85MElDK3piQ0dwYzc5cTRI?=
 =?utf-8?B?dkxya3dRM0hmZGlFM1l2QkFoakVSaytVeWN1OXZOa2lRaFlpeDAyc2libTdm?=
 =?utf-8?B?cW9lbXhLYWljVzBPa0g4R25JVEZobXFSODU5R1I4MEtYY1FTUDF1TWR0dk1K?=
 =?utf-8?B?VktMZTl5Wk0rMFlCaThPREpvYm9SVnFLcXRuTU81NDdQbUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0M5cFZLdUhuTE9oM2RZT2d1UHRZY0U3NDhIelg0QWNRUWQ4d2ZWNTE2QnJD?=
 =?utf-8?B?Ky9GYVgxQ3R1MS92ZEdyeERYd1hQYk5SZG1tRjhVUC93UThoN1R1eXlxeVJX?=
 =?utf-8?B?dlB5WU9FZ2hoeGJVZVlvaDBTT1FKbG5IV2hYYjliT21Iek13b3pRT2tjaHRh?=
 =?utf-8?B?L25zTG4yeUxwUjRUQnlkVTZNUHlmSzF4UXI2UklzR3UvaHlMRS9NbDloZ1Vl?=
 =?utf-8?B?dWNhSURKZmpGZ2xBS1UrMExkdU53RyswQk16WDJNWnNodkVJMGxiZEhzcWcz?=
 =?utf-8?B?YzJRRm5ieDQ0MFdwQmhDYkthaDBkaEI1MUxGbHh4bXJkN2plcFNxaHF3YmdL?=
 =?utf-8?B?K0ZkL2FVY2Z4U0FWdkdmclVCOE9xWEpGeml4bjhpelJJRWdlVlVLcmpESUVV?=
 =?utf-8?B?eWF0WTF2empxemptU1cvVjAzOHoxTkhnZmEzNzN1cU05cXRvaTQ0dys1M1V3?=
 =?utf-8?B?YnlLZ3NVUjBRaGlOZE8xVlEwZ3d0UUhheEdrbmRpMGFKOEwrZmhZY0ZNYU42?=
 =?utf-8?B?OTF6MmlXYU9vYnp4dHIvUzVTQ2FRenpVaExXZWs0MnRiNHBVOHJYNUxJdjAv?=
 =?utf-8?B?clpPSDBBV3FaRVpNRnpkeDE2T0VXQm0vNkVhQWxDMlNBa1phSTU0Q3UrZzJp?=
 =?utf-8?B?Zk5RNTJMUTlhTlNPSGpKV2N6K2tSNVg1aTI3RzJGREZvSHBRRGkySWd5MVNy?=
 =?utf-8?B?NzN1RzFtMTNCVFVVOUwrbzg4MTJWMDdPKy9EVW50OUlkVG13NFFZZ0lzczVP?=
 =?utf-8?B?cnVYSWx3eGtuTHpBUnpUL2lJZ2Q1b0VMb051TmozbWVsQXMzWVh1dnE0N2tN?=
 =?utf-8?B?OUdwSVFzOUFWMlIrNkkvMVQ3QVhCYlJpL0J1Y1RITmRnNkxwOG14SXl1dXBz?=
 =?utf-8?B?ajFxenpqdUxQeDNGQkpsY2lBbjI3dHBqakt4TC9RQUFMZzBmREZwaGhrdTc3?=
 =?utf-8?B?MXRtMGRkSXlGU3pGMWNwMEh1bStaZkdmdERGT3hzWlNIRHZvUTEvTzQ5a0JI?=
 =?utf-8?B?Ym9OWHR2Wk9aaStHMnN6MEhXc1piQXBlK2FISkxBSWk5R0NRZ3cwUGtvUkFE?=
 =?utf-8?B?STRiaXRtVWFheENtaW93eHJXVURBVGx3WUJjYkI0VnRwSThyVVUveEIxWGJQ?=
 =?utf-8?B?bkJSZjAzU3BPNHZPeG93enRRKzVtNW1mQW5kaitCa1d6VndNNE94cWFsTENZ?=
 =?utf-8?B?c1BMUVVCNEdKOGZEdGVnT1Y1L3BPM21NYkZuSHNqZTR6dkx4VGFLSTI5dk5h?=
 =?utf-8?B?Y2pyRjQ2bW9wM0l2UllZRUtnQjE1NGpXMk8zMUdYcnVReDJ3WlVYT0xJcEdW?=
 =?utf-8?B?VjZOZm9FdDU0eGh4TFFLOW1uSllDbDhQcVhMa0ZmQ3BlQVdNRHFOSXBTNTdk?=
 =?utf-8?B?ZENOOWZURXd5ZC90Mi9sd0JTUHlnVmk3ZkpJT21TdWdUWUQ0UkYreVZQNWk4?=
 =?utf-8?B?ajJZZ1NmNW1RNVdySFdyS3Z5VW5LRHBLaUw3ZDVEV3BkL2N5UlNjVlZVM25x?=
 =?utf-8?B?K3Y4Z20raDI2SDM1OURtQkpzcHRyWDlXMDduaTZrYjV0V05UdE5tVWtLdE9H?=
 =?utf-8?B?Z1grZmVTZ0pXTHQrQnhSNjVNY21IM083ci8wSmI3TVpPM3NZamMvTmZkOU9r?=
 =?utf-8?B?UFBLWlp0c0h4VXFyUjRBem13ZHhKbGp0NHFnTXQ5SkZQT3crV09uWEY1dk9W?=
 =?utf-8?B?akR5a2xBLzN6a3lIQXQrN3IyMVcyUzBxNW4vVThKcmxxeXQxeEMvcWQxd2RW?=
 =?utf-8?B?V2g5b0FPQ2NDMGNnaUlRRXhkS0lrc3llNm1FTkpSNkswN1JTMzF0eXMwck9Q?=
 =?utf-8?B?S3M5L3ZySWQ5bG5xNk8rWjNPcWpITXdsZ3JEOFZ6QzA1U0lJUDVEb0I1cXgw?=
 =?utf-8?B?ODBlZnJJektYZmpzZFFIaFVnTGZPcVQ0TEZmYWJqMFNmSWMvREZvdWRISFZH?=
 =?utf-8?B?UG53VEZnK1V0dzJiUzFONlAwVGlma3VBQmp6OEZKWS9kaFVCVlI2MnJYbmJ3?=
 =?utf-8?B?MjlQdjZqTUlteGFOb1FDZncrWWwxVDYxc1BjOFQwNWMrenZub2I2KzB3RnRt?=
 =?utf-8?B?TFZIYUl0cG9pU0RDZ3RRb2lLVEtVVURYVGovOVArNU5rRm5uSllWVFlSZFA4?=
 =?utf-8?B?QVZEbEVmd0I4N0RMWDF4a1h2ZEhXVlRBSHUzNE5ESGhyUzM5NnVBQ2lKYkk5?=
 =?utf-8?Q?3YSKHZ9suB9qplopDPGG0Ms=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAB387FB2BCAAC4DAA7CD370396F9835@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e4ff45-e04f-4f13-a628-08dca0f47b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 15:25:07.7695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpM8mVpvOgNpBM++q2p2Pkrm0YBL2hjFPj691Y/DyOBw5n0jpBpeJE+4d99BEJxGM9wbgvvim8K/l3Pgvkv9H+1gLesBP5VfaPB0AfSys14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7893

T24gVHVlLCAyMDI0LTA3LTA5IGF0IDEwOjIxICswMjAwLCBNYXR0ZW8gTWFydGVsbGkgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSm9uYXRoYW4g
Q2FtZXJvbiB3cm90ZToNCj4gLi4uDQo+ID4gPiBJIGNvdWxkIGFkZCB0aGUgc2h1bnQtcmVzaXN0
b3IgY29udHJvbHMgdG8gYWxsb3cgY2FsaWJyYXRpb24gYXMNCj4gPiA+IE1hcml1cw0KPiA+ID4g
c3VnZ2VzdGVkLCBidXQgdGhhdCdzIGFsc28gYSBjdXN0b20gQUJJLCB3aGF0IGFyZSB5b3VyIHRo
b3VnaHRzDQo+ID4gPiBvbiB0aGlzPw0KPiA+IA0KPiA+IFRoaXMgd291bGQgYWN0dWFsbHkgYmUg
YSBnZW5lcmFsaXphdGlvbiBvZiBleGlzdGluZyBkZXZpY2Ugc3BlY2lmaWMNCj4gPiBBQkkNCj4g
PiB0aGF0IGhhcyBiZWVuIHRocm91Z2ggcmV2aWV3IGluIHRoZSBwYXN0Lg0KPiA+IFNlZSBEb2N1
bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tYWRjLXBhYzE5MzQNCj4gPiBmb3Ig
ZXhhbXBsZSAoc2ltaWxhciBpbiBvdGhlciBwbGFjZXMpLg0KPiA+IFNvIGlmIHlvdSB3YW50IHRv
IGRvIHRoaXMgbW92ZSB0aGF0IEFCSSB1cCBhIGxldmVsIHRvIGNvdmVyDQo+ID4gbXVsdGlwbGUg
ZGV2aWNlcw0KPiA+IChyZW1vdmluZyB0aGUgZW50cmllcyBpbiBzcGVjaWZpYyBmaWxlcyBhcyB5
b3UgZG8gc28pLg0KPiA+IA0KPiBJIHdvdWxkIGRvIHRoaXMgaW4gYSBzZXBhcmF0ZSBjb21taXQs
IHdvdWxkIHlvdSBwcmVmZXIgaXQgaW4gdGhpcw0KPiBzYW1lIHBhdGNoDQo+IHNldCBvciBpbiBh
bm90aGVyIHNlcGFyYXRlIHBhdGNoPw0KPiANCj4gLi4uDQo+ID4gPiANCj4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gK1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4gPiA+ID4gL3N5cy9idXMvaWlv
L2RldmljZXMvaWlvOmRldmljZVgvcmVzb2x1dGlvbl9iaXRzX2F2YWlsYWJsZQ0KPiA+ID4gPiA+
ICtLZXJuZWxWZXJzaW9uOiA2LjEwDQo+ID4gPiA+ID4gK0NvbnRhY3Q6wqDCoMKgwqDCoMKgIGxp
bnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gPiArRGVzY3JpcHRpb246DQo+ID4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTGlzdCBhbGwgcG9zc2libGUgQURDIG1l
YXN1cmVtZW50DQo+ID4gPiA+ID4gcmVzb2x1dGlvbnM6ICIxMSAxNCINCj4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gK1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4gPiA+ID4gL3N5cy9idXMvaWlv
L2RldmljZXMvaWlvOmRldmljZVgvaW50ZWdyYXRpb25fc2FtcGxlcw0KPiA+ID4gPiA+ICtLZXJu
ZWxWZXJzaW9uOiA2LjEwDQo+ID4gPiA+ID4gK0NvbnRhY3Q6wqDCoMKgwqDCoMKgIGxpbnV4LWlp
b0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gPiArRGVzY3JpcHRpb246DQo+ID4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTnVtYmVyIG9mIHNhbXBsZXMgdGFrZW4gZHVyaW5n
IGEgZnVsbA0KPiA+ID4gPiA+IGludGVncmF0aW9uIHBlcmlvZC4gQ2FuIGJlDQo+ID4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0IHRvIGFueSBwb3dlciBvZiAyIHZhbHVl
IGZyb20gMSAoZGVmYXVsdCkNCj4gPiA+ID4gPiB0byAyMDQ4Lg0KPiA+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRoaXMgYXR0cmlidXRlIGFmZmVjdHMgdGhlIGludGVncmF0
aW9uIHRpbWU6DQo+ID4gPiA+ID4gaGlnaGVyIHRoZSBudW1iZXINCj4gPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZiBzYW1wbGVzLCBsb25nZXIgdGhlIGludGVncmF0aW9u
IHRpbWUuIFNlZQ0KPiA+ID4gPiA+IFRhYmxlIDQtNSBpbiBkZXZpY2UNCj4gPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhc2hlZXQgZm9yIGRldGFpbHMuDQo+ID4gPiA+
IA0KPiA+ID4gPiBTb3VuZHMgbGlrZSBvdmVyc2FtcGxpbmdfcmF0aW8gd2hpY2ggaXMgc3RhbmRh
cmRzIEFCSS4gU28gdXNlDQo+ID4gPiA+IHRoYXQgb3IgZXhwbGFpbg0KPiA+ID4gPiB3aHkgeW91
IGNhbid0IGhlcmUuDQo+ID4gPiANCj4gPiA+IEkgYW0gbm90IHN1cmUgdGhhdCB0aGlzIGlzIGFu
IG92ZXJzYW1wbGluZyByYXRpbyBidXQgY29ycmVjdCBtZQ0KPiA+ID4gaWYgSSBhbSB3cm9uZzoN
Cj4gPiA+IGdlbmVyYWxseSBieSBpbmNyZWFzaW5nIHRoZSBvdmVyc2FtcGxpbmcgeW91IHdvdWxk
IGhhdmUNCj4gPiA+IGFkZGl0aW9uYWwgc2FtcGxlcyBpbiBhDQo+ID4gPiBmaXhlZCB0aW1lIHBl
cmlvZCwgd2hpbGUgaW4gdGhpcyBjYXNlIGJ5IGluY3JlYXNpbmcgdGhlIG51bWJlciBvZg0KPiA+
ID4gc2FtcGxlcyB5b3UNCj4gPiA+IHdvdWxkIHN0aWxsIGhhdmUgdGhlIHNhbWUgbnVtYmVyIG9m
IHNhbXBsZXMgaW4gYSBmaXhlZCB0aW1lDQo+ID4gPiBwZXJpb2QsIGJ1dCB5b3UNCj4gPiA+IHdv
dWxkIGhhdmUgYSBsb25nZXIgaW50ZWdyYXRpb24gcGVyaW9kLiBTbyBtYXliZSB0aGUgY29tbWVu
dCBpcw0KPiA+ID4gbm90IHZlcnkNCj4gPiA+IGNsZWFyIHNpbmNlIHRoaXMgcGFyYW1ldGVyIGFj
dHVhbGx5IG1lYW5zICJ0aGUgbnVtYmVyIG9mIHNhbXBsZXMNCj4gPiA+IHJlcXVpcmVkIHRvDQo+
ID4gPiBjb21wbGV0ZSB0aGUgaW50ZWdyYXRpb24gcGVyaW9kIi4NCj4gPiANCj4gPiBOby4gT3Zl
cnNhbXBsaW5nIGlzIGluZGVwZW5kZW50IG9mIHRoZSBzYW1wbGluZyBwZXJpb2QgaW4gZ2VuZXJh
bA0KPiA+ICh0aG91Z2gNCj4gPiBoZXJlIHRoZSAnaW50ZWdyYXRpb24gdGltZScgaXMgdmVyeSBj
b25mdXNpbmcgdGVybWlub2xvZ3kuwqAgWW91IG1heQ0KPiA+IGhhdmUgdG8gaGF2ZSBzYW1wbGlu
Z19mcmVxdWVuY3kgKGlmIHByb3ZpZGVkKSB1cGRhdGVkIHRvDQo+ID4gaW5jb3Jwb3JhdGUgdGhh
dA0KPiA+IHRoZSBkZXZpY2UgY2FuJ3QgZGVsaXZlciBkYXRhIGFzIHF1aWNrbHkuDQo+ID4gDQo+
ID4gPiANCj4gPiA+IEluaXRpYWxseSBJIHRob3VnaHQgdG8gbGV0IHRoZSB1c2VyIGVkaXQgdGhp
cyBieSB3cml0aW5nIHRoZQ0KPiA+ID4gaW50ZWdyYXRpb25fdGltZQ0KPiA+ID4gY29udHJvbCAo
d2hpY2ggaXMgY3VycmVudGx5IHJlYWQtb25seSksIGJ1dCBzaW5jZSB0aGUgaW50ZWdyYXRpb24N
Cj4gPiA+IHBlcmlvZA0KPiA+ID4gZGVwZW5kcyBhbHNvIG9uIHRoZSByZXNvbHV0aW9uIGFuZCB3
aGV0aGVyIGZpbHRlcnMgYXJlIGVuYWJsZWQgb3INCj4gPiA+IG5vdCwgaXQgd291bGQNCj4gPiA+
IGhhdmUgaW50cm9kdWNlZCBzb21lIGNvbmZ1c2lvbjogd2hhdCBwYXJhbWV0ZXIgaXMgYmVpbmcg
Y2hhbmdlZA0KPiA+ID4gdXBvbg0KPiA+ID4gaW50ZWdyZXRpb25fdGltZSB3cml0ZT8gTWF5YmUg
YWZ0ZXIgcmVtb3ZpbmcgcmVzb2x1dGlvbiBhbmQNCj4gPiA+IGZpbHRlciBjb250cm9scw0KPiA+
ID4gdGhlcmUgd291bGQgYmUgbm8gc3VjaCBjb25mdXNpb24gYW55bW9yZS4NCj4gPiANCj4gPiBI
bW0uIFRoZSBkb2N1bWVudGF0aW9uIHNlZW1zIHRvIGhhdmUgYW4gdW51c3VhbCBkZWZpbml0aW9u
IG9mDQo+ID4gJ2ludGVncmF0aW9uJyB0aW1lLg0KPiA+IFRoYXQgbG9va3MgbGlrZSAxL3NhbXBs
aW5nX2ZyZXF1ZW5jeS7CoCBJbiBhbiBvdmVyc2FtcGxpbmcgZGV2aWNlDQo+ID4gaW50ZWdyYXRp
b24gdGltZQ0KPiA+IGlzIG5vcm1hbGx5IGFib3V0IGEgc2luZ2xlIHNhbXBsZSwgbm90IHRoZSBh
Z2dyZWdhdGUgb2Ygc2FtcGxpbmcNCj4gPiBhbmQgcmVhZCBvdXQNCj4gPiBldGMuDQo+ID4gDQo+
ID4gSSBndWVzcyBoZXJlIHRoZSBjb21wbGV4aXR5IGlzIHRoYXQgaW50ZWdyYXRpb24gdGltZSBp
c24ndCBhYm91dA0KPiA+IHRoZSB0aW1lDQo+ID4gdGFrZW4gZm9yIGEgY2FwYWNpdG9yIHRvIGNo
YXJnZSwgYnV0IG1vcmUgdGhlIHRpbWUgb3ZlciB3aGljaCBwb3dlcg0KPiA+IGlzIGNvbXB1dGVk
Lg0KPiA+IEJ1dCB0aGVuIHRoZSB2YWx1ZSBpcyBkaXZpZGVkIGJ5IG51bWJlciBvZiBzYW1wbGVz
IHNvIEknbSBldmVuIG1vcmUNCj4gPiBjb25mdXNlZC4NCj4gPiANCj4gPiBJZiB3ZSBqdXN0IHJl
YWQgJ2ludGVncmF0aW9uIHRpbWUnIGFzIGRhdGEgYWNxdWlzaXRpb24gdGltZSwgaXQNCj4gPiBt
YWtlcyBhIGxvdA0KPiA+IG1vcmUgc2Vuc2UuDQo+ID4gDQo+IEkgdGhpbmsgSSBub3cgZ2V0IHdo
YXQgeW91IGFyZSBzdWdnZXN0aW5nLCBwbGVhc2UgY29ycmVjdCBtZQ0KPiBvdGhlcndpc2U6DQo+
IA0KPiAxLiBMZXQncyBjb25zaWRlciB0aGUgc2FtcGxpbmcgZnJlcXVlbmN5IGFzIGhvdyBvZnRl
biB0aGUgZGV2aWNlDQo+IHByb3ZpZGVzDQo+IMKgwqAgY29tcHV0ZWQgKCJpbnRlZ3JhdGVkIikg
bWVhc3VyZW1lbnRzIHRvIHRoZSBob3N0LCBzbyB0aGlzIHdvdWxkIGJlDQo+IMKgwqAgMS8iaW50
ZWdyYXRpb24gcGVyaW9kIi4gVGhpcyBpcyBub3QgdGhlIGludGVybmFsIEFEQyBzYW1wbGluZw0K
PiByYXRlLg0KPiANCj4gMi4gSSB3aWxsIGV4cG9zZSBzYW1wbGluZ19mcmVxdWVuY3kgKFJPKSwg
b3ZlcnNhbXBsaW5nX3JhdGlvIChSL1cpDQo+IGFuZA0KPiDCoMKgIG92ZXJzYW1wbGluZ19yYXRp
b19hdmFpbGFibGUgKFJPKSB0byB0aGUgdXNlciwgd2hlcmUNCj4gb3ZlcnNhbXBsaW5nX3JhdGlv
DQo+IMKgwqAgY29ycmVzcG9uZHMgdG8gd2hhdCB0aGUgZGF0YXNoZWV0IHJlZmVycyB0byBhcyB0
aGUgIm51bWJlciBvZiBBREMNCj4gc2FtcGxlcyB0bw0KPiDCoMKgIGNvbXBsZXRlIGFuIGludGVn
cmF0aW9uIi4NCj4gDQo+IDMuIFdoZW4gdGhlIHVzZXIgd3JpdGVzIHRoZSBvdmVyc2FtcGxpbmdf
cmF0aW8sIHRoZQ0KPiBzYW1wbGluZ19mcmVxdWVuY3kgZ2V0cw0KPiDCoMKgIHVwZGF0ZWQgYWNj
b3JkaW5nbHkuDQoNCkxldCBtZSBjYW1lIHdpdGggc29tZSBjbGFyaWZpY2F0aW9ucy4gSW50ZXJu
YWwgc2FtcGxpbmcgZnJlcXVlbmN5IGZvcg0KdGhpcyBkZXZpY2UgaGFzIGEgZml4ZWQgdmFsdWUu
IEJhc2VkIG9uIHRoZSBudW1iZXIgb2Ygc2FtcGxlcyB0aGUgUEFDDQp3aWxsIGludGVybmFsbHkg
YWNjdW11bGF0ZSB0aGUgcmVhZCB2YWx1ZXMgYW5kIHRoZW4gdGhlIGF2ZXJhZ2UgaXMNCmNhbGN1
bGF0ZWQuDQoNCkkgdGhpbmsgdGhlICJiZXN0IiBhcHByb2FjaCBpcyB0byB1c2UgdGhlIG92ZXJz
YW1wbGluZ19yYXRpbyBhbmQgdGhlDQpmcmVxdWVuY3kgZ2V0cyB1cGRhdGVkIGFjY29yZGluZ2x5
IGFuZCBpdCB3aWxsIGJlIFJPLiBXZSB3aWxsIGFsc28gbmVlZA0KdGhlIG92ZXJzYW1wbGluZ19y
YXRpb19hdmFpbGFibGUuDQoNCj4gDQo+IDQuIFdpdGggdHdvIHJlYWwgZXhhbXBsZXM6DQo+IMKg
wqDCoCA0LjEuIFRoZSB1c2VyIHdyaXRlcyAxNiB0byBvdmVyc2FtcGxpbmdfcmF0aW8sIHRoZW4g
cmVhZHMgNDMuNDc4DQo+IGZyb20NCj4gwqDCoMKgwqDCoCBzYW1wbGluZ19mcmVxdWVuY3k6IHdp
dGggMTYgc2FtcGxlcyB0aGUgImludGVncmF0aW9uIHBlcmlvZCIgaXMNCj4gMjNtcw0KPiDCoMKg
wqDCoMKgIChmcm9tIFRhYmxlIDQtNSkgc28gMS8wLjAyMyA9PiA0My40NzggSHoNCj4gwqDCoMKg
IDQuMi4gVGhlIHVzZXIgd3JpdGVzIDIwNDggdG8gb3ZlcnNhbXBsaW5nX3JhdGlvLCB0aGVuIHJl
YWRzIDAuMzQNCj4gZnJvbQ0KPiDCoMKgwqDCoMKgIHNhbXBsaW5nX2ZyZXF1ZW5jeTogd2l0aCAy
MDQ4IHNhbXBsZXMgdGhlICJpbnRlZ3JhdGlvbiBwZXJpb2QiDQo+IGlzIDI5NDFtcw0KPiDCoMKg
wqDCoMKgIChmcm9tIFRhYmxlIDQtNSkgc28gMS8yLjk0MSA9PiAwLjM0IEh6DQo+IA0KPiA1LiBE
byBub3QgZXhwb3NlIHRoZSBpbnRlZ3JhdGlvbl90aW1lIGNvbnRyb2wgdG8gYXZvaWQgY29uZnVz
aW9uOiB0aGUNCj4gc28gY2FsbGVkDQo+IMKgwqAgImludGVncmF0aW9uIHBlcmlvZCIgY2FuIGJl
IGRlcml2ZWQgZnJvbSB0aGUgc2FtcGxpbmcgZnJlcXVlbmN5IGFzDQo+IMKgwqAgMS9zYW1wbGlu
Z19mcmVxdWVuY3kuDQo+IA0KPiAuLi4NCj4gPiA+ID4gPiArc3RhdGljIGludCBwYWMxOTIxX3Vw
ZGF0ZV9jZmdfcmVnKHN0cnVjdCBwYWMxOTIxX3ByaXYgKnByaXYsDQo+ID4gPiA+ID4gdW5zaWdu
ZWQgaW50IHJlZywNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgbWFzaywgdW5zaWdu
ZWQNCj4gPiA+ID4gPiBpbnQgdmFsKQ0KPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoCAvKiBFbnRlciBSRUFEIHN0YXRlIGJlZm9yZSBjb25maWd1cmF0aW9uICovDQo+ID4gPiA+
ID4gK8KgwqDCoMKgwqDCoCBpbnQgcmV0ID0gcmVnbWFwX3VwZGF0ZV9iaXRzKHByaXYtPnJlZ21h
cCwNCj4gPiA+ID4gPiBQQUMxOTIxX1JFR19JTlRfQ0ZHLA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFBBQzE5MjFfSU5UX0NGR19JTlRFTiwNCj4gPiA+ID4gPiAwKTsNCj4gPiA+ID4gPiArwqDC
oMKgwqDCoMKgIGlmIChyZXQpDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHJldDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCAvKiBV
cGRhdGUgY29uZmlndXJhdGlvbiB2YWx1ZSAqLw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgcmV0
ID0gcmVnbWFwX3VwZGF0ZV9iaXRzKHByaXYtPnJlZ21hcCwgcmVnLCBtYXNrLA0KPiA+ID4gPiA+
IHZhbCk7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAocmV0KQ0KPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+ID4gPiA+ID4gKw0KPiA+ID4g
PiA+ICvCoMKgwqDCoMKgwqAgLyogUmUtZW5hYmxlIGludGVncmF0aW9uIGFuZCByZXNldCBzdGFy
dCB0aW1lICovDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCByZXQgPSByZWdtYXBfdXBkYXRlX2Jp
dHMocHJpdi0+cmVnbWFwLA0KPiA+ID4gPiA+IFBBQzE5MjFfUkVHX0lOVF9DRkcsDQo+ID4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFBBQzE5MjFfSU5UX0NGR19JTlRFTiwNCj4gPiA+ID4gPiBQQUMxOTIxX0lOVF9D
RkdfSU5URU4pOw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKHJldCkNCj4gPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgIHByaXYtPmludGVncl9zdGFydF90aW1lID0gamlmZmllczsN
Cj4gPiA+ID4gDQo+ID4gPiA+IEFkZCBhIGNvbW1lbnQgZm9yIHdoeSB0aGlzIHZhbHVlLg0KPiA+
ID4gPiANCj4gPiA+IENvdWxkIHlvdSBlbGFib3JhdGUgd2hhdCdzIGNvbmZ1c2luZyBoZXJlPyBU
aGUgY29tbWVudCBhYm92ZQ0KPiA+ID4gc3RhdGVzICJyZXNldA0KPiA+ID4gc3RhcnQgdGltZSIs
IG1heWJlIEkgc2hvdWxkIG1vdmUgaXQgYWJvdmUgdGhlIGFzc2lnbm1lbnQgb2YNCj4gPiA+IHBy
aXYtPmludGVncl9zdGFydF90aW1lPyBPciBpdCdzIHRoZSB1c2Ugb2YgamlmZmllcyB0aGF0IGl0
J3MNCj4gPiA+IGNvbmZ1c2luZz8NCj4gPiANCj4gPiBXaHkgaXMgaXQgamlmZmllcz/CoMKgIFdo
eSBub3QgamlmZmllcyAqIDQyPw0KPiA+IEknbSBsb29raW5nIGZvciBhIGRhdGFzaGVldCByZWZl
cmVuY2UgZm9yIHdoeSB0aGUgcGFydGljdWxhciB2YWx1ZQ0KPiA+IGlzIHVzZWQuDQo+ID4gDQo+
IEkgdXNlZCBqaWZmaWVzIGp1c3QgdG8gdHJhY2sgdGhlIGVsYXBzZWQgdGltZSBiZXR3ZWVuIHJl
YWRpbmdzLg0KPiBTb21ldGhpbmcgSSBhbQ0KPiBub3QgY29uc2lkZXJpbmcgaGVyZT8gT2YgY291
cnNlIGppZmZpZXMgZ3JhbnVsYXJpdHkgbWlnaHQgYmUgbGFyZ2VyDQo+IHRoYW4gdGhlDQo+IG1p
bmltdW0gc2FtcGxpbmcgZnJlcXVlbmN5LiBJcyB0aGVyZSBhIGNvbW1vbiBiZXR0ZXIgYXBwcm9h
Y2g/DQo+IA0KPiAuLi4NCj4gPiBGb3IgZnV0dXJlIHJlZmVyZW5jZSwgbm8gbmVlZCB0byBhY2tu
b3dsZWRnZSBzdHVmZiB5b3UgYWdyZWUNCj4gPiB3aXRoLsKgIE11Y2ggYmV0dGVyIHRvIGNyb3Ag
dG8gdGhlIHBsYWNlcyB3aGVyZSB0aGVyZSBhcmUgcXVlc3Rpb25zDQo+ID4gb3IgcmVzcG9uc2Vz
DQo+ID4gYXMgaXQgc2F2ZXMgdGltZSBmb3IgdGhlIG5leHQgc3RlcCBvZiB0aGUgZGlzY3Vzc2lv
biENCj4gT2suLi4ub29wcyENCj4gDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IA0KPiA+IEpvbmF0
aGFuDQo+ID4gDQo+IA0KPiBUaGFua3MsDQo+IE1hdHRlbw0KPiANCg0KVGhhbmtzLA0KTWFyaXVz
DQoNCg==

