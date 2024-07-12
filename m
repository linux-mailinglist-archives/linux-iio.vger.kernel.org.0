Return-Path: <linux-iio+bounces-7547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EFE92FCC7
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 16:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CEC282AE4
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9F171E6E;
	Fri, 12 Jul 2024 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jhGLqnpM";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="efR0KAwD"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59015B134;
	Fri, 12 Jul 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795344; cv=fail; b=t4XMR957UAQFNvGXVmDDJXnk2vkhud/arUj8BraFHGM5Yl+eIyW9CtUy3LPRM2oFn/MPAoTKMyroJVUqpTtK0vuOWk8tPBFeBYA2oPXhe+IHq0Sz58OjjEHI8LwZz+kGh7pEToJswdUSWjW7oEXHHJuasRWB5KJnQssFtiz9c6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795344; c=relaxed/simple;
	bh=KVM3U7wVehb3zJNIsr/Tsdzh05h+0Kwu3T/VViwecvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+Rkoa6Wxu/cp6aUubec6ryqjnRookhUmLqTsyid8VDH1APPZ6vsilw62BbuOuhRjUylvpwv+y1mNyk1XOZHfJ39lUe9Ar8LdVTPZpYj5Cpje5WepTEAzClFT/RRzBb/pJbY4CqjdGe59UtIHWlceGZiS2K4+g8ARPR/kG7leUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jhGLqnpM; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=efR0KAwD; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720795341; x=1752331341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KVM3U7wVehb3zJNIsr/Tsdzh05h+0Kwu3T/VViwecvA=;
  b=jhGLqnpMs2A1A4Idb5mhOPR6pjF0MkbpVEDK06WJqB4rsN+1IVjRF7Ny
   5pwDluSi6YrJErwdrs7jarMmk8rHYwT36y95A33+RSN8NgBVBNIlCcLy4
   +Ee0HxY5eVJ0EDb6w8evT/aG+Ga0lTlo771fE/3E1dxK9o1NG89DTUCTs
   t1TY/M7rqzmKFN6/a6McKDtInf3AIjbpeY6dB7Sma95z5OZW10QO9qWVj
   bprc/eRO3xfdA+JTiLaBhtClzwfr9MsvmW5lzBff6NfyG0qfgCUTaWXsC
   h+OyYp1DFTbnpGZML5RkpDXqt92Q84D/0laWyvQj1LVIBmQ/+9AUNRfJB
   g==;
X-CSE-ConnectionGUID: buHuI6QESn6Yx5CI1PfyLw==
X-CSE-MsgGUID: K0/Z8RmfSrGwevrKPAcd1g==
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="31857083"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2024 07:42:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jul 2024 07:41:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jul 2024 07:41:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFSrZ69HCqgkmBzCaTCXh6XpuoGVXrM08mkEKmS4qWThdlq/sVJLYlI+GLgk0MGdR8v/s4G2+uO8nMHQ19B3eWqpHSZBvOZCWJDgqKo8L9o9SG24C/uBKf2Lbow/yWSLcLeYrmM7qfEANPP24IygNd7wWefcK4LV0tJNPdGpnsnJZ3xrdMBh/J1cX+bmXgTDXpvP/O6T7jF3DmROGRhRCigD3/Q9GA6bvkQ6cdw/ciYGtx/tLLzKoT70aAvSAS0MWuMLmLmCNjGVE6tA1gSa7N73BYcm0bY5N/MumeNIGabvc9SNEUR7TqUDpEL3jYhiCZBkoFvCjqJzrapQkWtOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVM3U7wVehb3zJNIsr/Tsdzh05h+0Kwu3T/VViwecvA=;
 b=VOrYsqDZ8asIyx510yxQ8BslZhVYF+DS/Tt/PDIecwpDLQu/4zgv5JOJk5VltQ+zLA+nyxrma8TlZDCxyfU03FxD4PcXt2+s6uhTO2Q6Vtv9Pp86jio3EQzFy7WWTkdbt0I9AeEC9UqNjuGIV9wOOpEdhSUWge10/W+77J194a7TnYphkwaQZgH0VJVemWIGUhLExYgifrX/jh7gc+6SilHvwZT2Dl5Eg2g+VerQnDrkv/C5f0qnBJhO4ssULl2OocmgcX8UjF5/nearwBtBTkSs5wQQhA/D8ayyH86LbZc9EBhe24PuIEKfZV9H2GW5AyW22k9GzSCQ5cYVy2+QrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVM3U7wVehb3zJNIsr/Tsdzh05h+0Kwu3T/VViwecvA=;
 b=efR0KAwDKyJ8FXo65QIH3QRbg+uMpbe3o0/ud1ayPvDKdbUcvxbZxR7MGe35/oCEQNQn9s6riodlqM0x0F9pQlYlHJq8EL8FHxGtWQENYIC8T6m3XlDsU3DzxzkpynULJ/it+QL0aqHdntLrtFJzu0ra91H9IpPtyvl1ZlHnpVQkbv1DyVFYY9376pkF5if6xDgnZoiI5n6Re/H5lPEUL+zk5NEXxC5bP/PT55LbDGoIu+LnetpZmA8vACZcVAjBNfaKubbf0mjvyfNaNMMAX7amqHNCeqpWmqKlgS955mVHJ8VMGdtkn1CX/6LVdM45Wm0OzgD3FAbnGzSVeRaJuw==
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (2603:10b6:805:c6::10)
 by DS0PR11MB7505.namprd11.prod.outlook.com (2603:10b6:8:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 14:41:52 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf%4]) with mapi id 15.20.7762.016; Fri, 12 Jul 2024
 14:41:51 +0000
From: <Marius.Cristea@microchip.com>
To: <jic23@kernel.org>, <matteomartelli3@gmail.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Thread-Topic: [PATCH v2 2/2] iio: adc: add support for pac1921
Thread-Index: AQHazjmP/m+FUirFLUmAMKoURJhChrHrYYoAgAF6owCAA0wuAIAA/WcAgAIRDQA=
Date: Fri, 12 Jul 2024 14:41:51 +0000
Message-ID: <ea72561a1ab953d3f2a99272c24cf5124c0c72ec.camel@microchip.com>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
	 <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
	 <20240707160442.6bab64c9@jic23-huawei>
	 <668bec2a8b23a_6e037017@njaxe.notmuch>
	 <88a54c736e0c39ead34dbde53c813526484d767d.camel@microchip.com>
	 <668f84e2f3e10_2b423707a@njaxe.notmuch>
In-Reply-To: <668f84e2f3e10_2b423707a@njaxe.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3167:EE_|DS0PR11MB7505:EE_
x-ms-office365-filtering-correlation-id: 4d1e5a9e-caf0-484c-ffec-08dca280c4af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cVpZQjNIcUdsVlYvc1dYczg4Wm4zQTdyWEJ4b1hOcGVQZ0ZxWENvR3ZmRkE0?=
 =?utf-8?B?VWFuMVlVVWRsaUd1QVNNWmJidUh0Y0ZyV1ovZjlKVFFSL0FFaC9oemMxZ3hq?=
 =?utf-8?B?RWFIK296d080bEdBK0kwcjREajg0VGUzMVhRVnFMeXJIS2RaSDFib3hoNmxU?=
 =?utf-8?B?MW5sZWdFTlZjQ1k4YkJuNjF4ME9ldktFZXE4NGpWNXlseTBJSGlFWTJla2Fx?=
 =?utf-8?B?TlFKUHJJbnJEVVE5MmU2a3l3TmlrbFFTN1RObXoxTGI3S09HdXZqUDd1SmtY?=
 =?utf-8?B?eXI2emlMM3BLS1BFRk5mMmJFMTFYQld3eGhhNUFFTGdxaXBCWi9lL0dNS212?=
 =?utf-8?B?WUp1VmtxMnF3bjc5cjlNc3l5ZjdIUmhKQTRBcWZmeTlScVpIcHRoWFdTRitw?=
 =?utf-8?B?V0U4b3BPL2ZjSE03aTdRUEFSSy9WOC9sWmMzY1ZYVUdjTUpoNVFDY1VVU2E5?=
 =?utf-8?B?QlBYQVNsNHZhRGxZSWthM21FaG5GWG55ZStrSFpDZjdxWEJQQ2hxVFJSb290?=
 =?utf-8?B?d1pzSm11Zk5WWjRFTE84UmpySVlydG04UzhtVHlBV0kwTDg3MndvT29xU3hH?=
 =?utf-8?B?aElYQlRWNFFXbzFNcHl3N2pJUTl4WERocDYvdW9kSHZJNGZaMHhXMDQwa3E1?=
 =?utf-8?B?NWxPUXBibURFUlhSdVhzc3BLN2NyTndMczN1SEdRU25ZNm5vdnRBdjVlbmNv?=
 =?utf-8?B?VmlKYlhZL2EvMVhKZGxONXg0dW8yV1lmZ0RsWitiQjRJdmJoaGpVYTdLejNj?=
 =?utf-8?B?Rzk0YmpMVUgzMVlxdlZqZTc3R0JOeU9UUUdKZmxjdWd6QnF6WmRXTTRrQjVJ?=
 =?utf-8?B?Q2wwMmZNcUFwdW1wazc2TTJnamloRHVqS0ZhS2FuT3NnWDZ6WGdLUXFwVGI0?=
 =?utf-8?B?WkMzdSs1bTZOV0VTYUdoUzcvbWQ1TUVwUVJiUmlRZUJWRHh0SXk3Rk13Qzh1?=
 =?utf-8?B?cWxqYWc3NnlQZkF4Q3gyNFBLNU03Y04zakRZNTF6MTR1UkgwZWxYWEJjWU1h?=
 =?utf-8?B?WXdzM2krSllNb2Eydk8yNExPTngzRmVHcDFLbEg4Y2U2cEZvS29QNTlMSGZM?=
 =?utf-8?B?WEU5THduUkp0aWwzcEJxR2o5RHp4UUZnN0pzazMvYkFJZXJFRFpxVi9GWTZO?=
 =?utf-8?B?OEdod0tCQ0tIaWkvZ0Zzc0R5SzVWb3I1WlJ5eFZoekVIcGt5OHBrbmhXd0hI?=
 =?utf-8?B?clhtQlQ1K25UaFFPTC9uSWxpQTJqYnY3Lzc0VENzQ1djQnRRcklqN3hPdjZJ?=
 =?utf-8?B?a3YwZ0pCenVnUWx3TjRSMHIvL1dLMWQ0bm00V0xrOWNkelgvSEdxVHVmeXZ3?=
 =?utf-8?B?TUZZcksrRVMzZ0szaVhqSmxjUnZOTm53VW05UTBZQW91eHhNUkV2Y2s3WWdh?=
 =?utf-8?B?NDlFMkprQXdJQTRWTm5qOFZKdmtMOVc2VFg4YW1ManhSdlF4QXdIdFJ4dnRp?=
 =?utf-8?B?TmNLTEt5c2w3MDlmQkVPSTVxc2d2ZzZYSGE5Q3E2eVZHbTVHcUJiM1kvUUJo?=
 =?utf-8?B?N1lVZEI5eDk1cWxtbmczcTg2ZTVvUzR1NkxEaEhER2FnejdiQklEZHUzSVFF?=
 =?utf-8?B?bzJpcmxEUmcyMlJIbENTcFhWUEliTnlBWkhlMGpCUy9iK0FXUFpXWDFLdk1G?=
 =?utf-8?B?dEJwdmNQSFNzK0VQV3VvVjFHeFBUQWVNbmhScjk4TUdsc1JKeWtZTkdLOWc2?=
 =?utf-8?B?dzFNVEZ2WWRRQWt6Nlh4cWxCZkdHY3F4WTBFNkhIZndEYU85dU42TUhqam5N?=
 =?utf-8?B?OVJRUGY5b2xleEVqMnBKOXhsZ0RXeGh1TXNocFNQUmtOdDJteW9DY0JBeTRh?=
 =?utf-8?B?Ykx5NnNsN2JhK2ZiSnkwUWJ0RkFKKytQWVBLS3BidVp3N0JqZjZyNVZqWjV3?=
 =?utf-8?B?SXlpOFFjeElyZXRiamF4a3VwaktrZ0tVWVhCSVBwdU5DdlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDZSempkcVJjOXIzbDJXcHY5NXpqU0dvN3lMaVZnU3BBeDVFNm9VTkpXVUtl?=
 =?utf-8?B?TjVBOWoyTkFNVUg2OWJaVDlPbXZpUTJZN0xTNTkyU1dINUpmczVycEZPZjJO?=
 =?utf-8?B?Y2duaEJVc1FvZkRPYkJHOVhoSGJZUDZ4NWwrdnVFS2hVS3I2RjVJZDlTVzZ6?=
 =?utf-8?B?SW5kNWNMZHU1OFBoZ3YvaktoS2tNVndITDM4NmpEa1N2QkJ3bmluaGxaSUJQ?=
 =?utf-8?B?UXVVTEJ5MTgrczdoamRGR0IvaEdNUXVVK1N5Z3JBMW5nQ0lkWjJLMTJDQ3Mw?=
 =?utf-8?B?cENEUXM3cjJaMXRGbUZ0cFgyNFNiMnRGT2dmeTFPSVU5THNkTForcjZBNU5K?=
 =?utf-8?B?RmhvMnhDRlBFbW8vd3hSNUxnbHV5aVFaNy9LT0FhR3lvdmtrUjRlcXZFVUNZ?=
 =?utf-8?B?Z0FHRzgyWTh2M2owOEtUY1J3YktKZXBaZEVyWFdpeTBlc3NYVkxGSEcxeTV6?=
 =?utf-8?B?R2o0ZHlOZUoxUW5ObWVoOUhLb1pheHNmK0lwUEk3RHZMeHp2S3BTVlgrVldl?=
 =?utf-8?B?UWRTUDhnZzVsc2lzekdJazZ4RzlNVjRpdWF0WlhIdFJ3ZEluQ0hFZ2tROWRM?=
 =?utf-8?B?Q2tmWWZ3aXBPalRJZGhDZTkzSW1lc200U1Q2RnlUcHM2SzJhUkdxS1RXREJZ?=
 =?utf-8?B?Vml2R0dNTjZZV0d2L0dFZmhuUjIzZFEzMFQvVnFZeXZ0emdRa3JvSk50aFpK?=
 =?utf-8?B?MUFMdzRtZ2lKczZ2UE9vOXBmQVJkTFYwRDhkYWgyQ2hXRGlKY2RTNDhQVnRz?=
 =?utf-8?B?U1ZTYndhcm9tTDZVWDkySG9qRDB2ZERQbmxLUGxmNzJoYm5Cbzg0QjV3Y0xI?=
 =?utf-8?B?aFpacFArRDFTQndBcG81clcvWXBFVHFPcjc3TWFwTndaci9mT1JOY0xMY2xG?=
 =?utf-8?B?TzFUdGZSRGxGME5LZVFCMXdzMUNkcnpQU092MzFrU3pWQmpKTUhtRUk3UTFD?=
 =?utf-8?B?NWlZNzN2WGQ3TkRMVXFDRndLSlJ2R21KMjFFMjQ1Ukx0MWJLc0htYmtCK1Bi?=
 =?utf-8?B?OU9wc0ZXait0V2dUZE1FNElMMm9vN3MyL2NBc0ZRenRFN3dUc2cwTFdYc0o4?=
 =?utf-8?B?MWFRblZsdzJ2V3E2MENqaG1CbU1qVGx1K1R1S0UvOVZ2clM2ZVVRODA0Ri9u?=
 =?utf-8?B?bk9iUDRqUHp3eE1rdVZCN0o0QzNIejhNWlp3c0pxdzRxTG16VmNLZ1kveEFk?=
 =?utf-8?B?ZkQweTdpSkdGSG84QnVKRkdMQU0rT0hueUdxODQvU2FDOU95WU5ZOWxjZDg5?=
 =?utf-8?B?V2p1NGVLQ284dlE4a2JvU1QwV1FwWWxHK3dCbTg1QjRRVDBSalR2c2RMdkxw?=
 =?utf-8?B?dHBSeHJUakF0U0NRWnNNRGNIYkhqNDVZOFdmdk9VaHVXZzU4WCtRckNlVUdF?=
 =?utf-8?B?L2RhV0JwZTJ3cXZwdkpSSXFTRm9SWW9najIzL3dJVHl4Y1BqMktaaC83RFVn?=
 =?utf-8?B?OVhiclB6SlM0VEJpVzdqUU1leTB3ZDAvWFF4RWZEb2ZKcWRQd0N2dDBXZlFt?=
 =?utf-8?B?cmhwMFpSbTV1SUMwRTFPRERMSFRLZHRFWkJ1MDk2NTBtdXpvZlRFUlZldmJV?=
 =?utf-8?B?alVLa2syTWpEbG4vdVpWTE5UWUNOa2twRWl3dzkvWnNoODI4ZEJ0Y0tWZk5x?=
 =?utf-8?B?eWpBVUhqclNZY0laYjdsQnRtNXo2MmZ0djloakFhUFlOTElkWldqdGNqWm5O?=
 =?utf-8?B?M0I5dzlaT1NtK1VKbkhSUFAvYWJEUk1EOVFwMlNGdlUzU0QyQVFLMmdnU1RK?=
 =?utf-8?B?WTYrekhNMHM4Sk1GUFhmVDBHeUdoWkxzcHZqbWJZZXZQdmJId0l4NmMvWjJZ?=
 =?utf-8?B?R3N4V1kwMnlsdk1FQ2tzZzYxVU0rQThpN0ZWVkNPemZRYzRqSkh1QjVRWVg1?=
 =?utf-8?B?T3pzclZKWVh1V0U3MTB4VTJuTUxmenE4RzU0VjZFdHFSU2FsNEtvMFdJZCs1?=
 =?utf-8?B?YlhXM3UyV0dMMzZ2VzZRVFd5NDFyZWRMNkJWWTZaTVFCemoxY3BMU2NzVXdk?=
 =?utf-8?B?TGp1WUxtMHR3TUlub2tpdGFoRG4wNUVUbkZPcThFWUlLUEZQVnRvbXR6RnRW?=
 =?utf-8?B?VEtOQnBTMmplTWJsZ0FUSUZDZEZ0eTIxZjJBUlhCaXF6d3ZZcmh6ZzNRZkZQ?=
 =?utf-8?B?YzJTRmc4ZHU1TDlnS0V6L0dGL092Slo2OCs1VkdsMlVpeUJDTWR6UmQ2ZTV3?=
 =?utf-8?Q?6ijLzaENc1dfmK8sI/dFTVM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82121C33DB38EF41A3FFB6731F54FC71@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1e5a9e-caf0-484c-ffec-08dca280c4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 14:41:51.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fhM5sFNY+wsDTkho7F8eWmn8cvslMz/gwfOmIBYkjrwpcbjht+XT5DczT+gBUPQJrhUEXftAkHEXKnTmO9iRGPgrb9v+jGmCWTf5bVA4+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7505

SGkgTWF0dGVvLA0KDQoNCk9uIFRodSwgMjAyNC0wNy0xMSBhdCAwOTowOCArMDIwMCwgTWF0dGVv
IE1hcnRlbGxpIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4gDQo+IEhpIE1hcml1cywNCj4gDQo+IE1hcml1cy5DcmlzdGVhQCB3cm90ZToNCj4gPiA+IEkg
dGhpbmsgdGhhdCB0aGUgT1VUIHBpbiBtaWdodCBub3QgYmUgdXNlZCBhdCBhbGwgaW4gbWFueSB1
c2UNCj4gPiA+IGNhc2VzDQo+ID4gPiBzbyBJIHdvdWxkDQo+ID4gPiBsZWF2ZSB0aGUgT1VUIHBp
biBzZXR0aW5nIGFzIGZpeGVkIGZvciBub3cgYW5kIG1heWJlIGV4dGVuZCBpdCBpbg0KPiA+ID4g
dGhlDQo+ID4gPiBmdXR1cmUNCj4gPiA+IHdoZW4gbW9yZSB1c2UgY2FzZXMgYXJpc2UuIEkgYW0g
b3BlbiB0byByZWNvbnNpZGVyIHRoaXMgdGhvdWdoLg0KPiA+ID4gDQo+ID4gDQo+ID4gVGhlIE9V
VCBmdW5jdGlvbmFsaXR5IGNvdWxkIGJlIHNldCBmcm9tIHRoZSBkZXZpY2UgdHJlZS4NCj4gDQo+
IEkgdGhpbmsgdGhpcyBzaG91bGQgdG8gYmUgY29udHJvbGxlZCBkdXJpbmcgcnVudGltZSBzaW5j
ZSBpdCdzIGENCj4gY29uZmlndXJhdGlvbg0KPiB0aGF0IGNoYW5nZXMgdGhlIGRldmljZSBvcGVy
YXRpb24gbW9kZSBhbmQgc28gYWxzbyB3aGF0IG1lYXN1cmVtZW50cw0KPiBhcmUNCj4gZXhwb3Nl
ZCB0byB0aGUgdXNlci4gQW4gYWRkaXRpb25hbCBEVCBwcm9wZXJ0eSBjb3VsZCBiZSB1c2VmdWwg
YnV0IEkNCj4gYW0gbm90DQo+IHN1cmUgaXQgd291bGQgZml0IGluIHRoZSBEVCBzY29wZS4NCj4g
QW55d2F5IEkgd2lsbCBsZWF2ZSB0aGlzIGZvciBmdXR1cmUgZXh0ZW5zaW9ucy4NCj4gDQoNCkkg
dGhpbmsgdGhlcmUgYXJlIDIgZGlmZmVyZW50IHRoaW5ncyBoZXJlLiBTZXR0aW5nIHRoZSBjb25m
aWd1cmF0aW9uIGF0DQpzdGFydHVwIGJ5IGhhcmQtY29kaW5nIHRoaW5ncyBhdCBwcm9iZSB0aW1l
IG9yIHRha2VuIHRob3NlIGZyb20gZGV2aWNlDQp0cmVlICh3ZSBjYW4gYWRkIG11bHRpcGxlIHBy
b3BlcnRpZXMgaGVyZSwgYXMgbG9uZyB0aG9zZSBwcm9wZXJ0aWVzIGFyZQ0KZG9jdW1lbnRlZCBp
bnRvIHRoZSBkdC1iaW5kaW5nIGZpbGUpIGFuZCB0aGUgdXNlciBjb250cm9sbGVkIHBhcnQgYXQN
CnJ1bnRpbWUuDQpCZWNhdXNlIHRoZXJlIGlzIG5vIHN0YW5kYXJkIGludGVyZmFjZSB0byBjaGFu
Z2UgdGhlIGZ1bmN0aW9uYWxpdHksIGl0DQp3aWxsIGJlIGVhc3kgdG8gc3RhcnR1cCBmcm9tIHRo
ZSBkZXZpY2UgdHJlZSBhbmQgbGV0IHRoZSB1c2VyIHRvIGRvDQpzb21lIG1pbm9yIGFkanVzdG1l
bnRzIGFuZCBub3QgaGFyZGNvZGUgY29uZmlndXJhdGlvbi4NCg0KDQo+IC4uLg0KPiA+ID4gPiA+
IC0tLQ0KPiA+ID4gPiA+IMKgLi4uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tYWRjLXBhYzE5
MjHCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNDUgKw0KPiA+ID4gPiA+IMKgTUFJTlRBSU5FUlPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCA3ICsNCj4gPiA+ID4gPiDCoGRyaXZlcnMvaWlv
L2FkYy9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDEwICsNCj4gPiA+ID4gPiDCoGRyaXZlcnMvaWlvL2FkYy9NYWtlZmls
ZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
wqDCoCAxICsNCj4gPiA+ID4gPiDCoGRyaXZlcnMvaWlvL2FkYy9wYWMxOTIxLmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEwMzgNCj4gPiA+ID4g
PiArKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+IMKgNSBmaWxlcyBjaGFuZ2VkLCAxMTAx
IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvLWFkYy0NCj4gPiA+ID4gPiBwYWMxOTIx
DQo+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tYWRj
LXBhYzE5MjENCj4gPiA+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiA+IGluZGV4
IDAwMDAwMDAwMDAwMC4uNGEzMmUyZDQyMDdiDQo+ID4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWlpby1hZGMt
cGFjMTkyMQ0KPiA+ID4gPiBRdWl0ZSBhIGJpdCBvZiBjdXN0b20gQUJJIGluIGhlcmUuDQo+ID4g
PiA+IA0KPiA+ID4gPiBSdWxlIG9mIHRodW1iIGlzIHRoYXQgY3VzdG9tIEFCSSBpcyBtb3JlIG9y
IGxlc3MgcG9pbnRsZXNzIEFCSQ0KPiA+ID4gPiBmb3INCj4gPiA+ID4gOTklIG9mIHVzZXJzDQo+
ID4gPiA+IGJlY2F1c2Ugc3RhbmRhcmQgdXNlcnNwYWNlIHdvbid0IHVzZSBpdC7CoCBTbyBrZWVw
IHRoYXQgaW4gbWluZA0KPiA+ID4gPiB3aGVuDQo+ID4gPiA+IGRlZmluaW5nIGl0Lg0KPiA+ID4g
PiANCj4gPiA+ID4gPiBAQCAtMCwwICsxLDQ1IEBADQo+ID4gPiA+ID4gK1doYXQ6DQo+ID4gPiA+
ID4gL3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZVgvcmVzb2x1dGlvbl9iaXRzDQo+ID4g
PiA+ID4gK0tlcm5lbFZlcnNpb246wqDCoMKgwqAgNi4xMA0KPiA+ID4gPiA+ICtDb250YWN0OsKg
wqAgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ICtEZXNjcmlwdGlvbjoNCj4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgQURDIG1lYXN1cmVtZW50IHJlc29sdXRpb24u
IENhbiBiZSBlaXRoZXIgMTEgYml0cw0KPiA+ID4gPiA+IG9yDQo+ID4gPiA+ID4gMTQgYml0cw0K
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCAoZGVmYXVsdCkuIFRoZSBkcml2ZXIgc2V0
cyB0aGUgc2FtZSByZXNvbHV0aW9uDQo+ID4gPiA+ID4gZm9yDQo+ID4gPiA+ID4gYm90aCBWQlVT
IGFuZA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBWU0VOU0UgbWVhc3VyZW1lbnRz
IGV2ZW4gaWYgdGhlIGhhcmR3YXJlIGNvdWxkIGJlDQo+ID4gPiA+ID4gY29uZmlndXJlZCB0bw0K
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZWFzdXJlIFZCVVMgYW5kIFZTRU5TRSB3
aXRoIGRpZmZlcmVudA0KPiA+ID4gPiA+IHJlc29sdXRpb25zLg0KPiA+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoCBUaGlzIGF0dHJpYnV0ZSBhZmZlY3RzIHRoZSBpbnRlZ3JhdGlvbiB0aW1l
OiB3aXRoDQo+ID4gPiA+ID4gMTQNCj4gPiA+ID4gPiBiaXRzDQo+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgIHJlc29sdXRpb24gdGhlIGludGVncmF0aW9uIHRpbWUgaXMgaW5jcmVhc2Vk
IGJ5IGENCj4gPiA+ID4gPiBmYWN0b3Igb2YNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqAgMS45ICh0aGUgZHJpdmVyIGNvbnNpZGVycyBhIGZhY3RvciBvZiAyKS4gU2VlDQo+ID4gPiA+
ID4gVGFibGUNCj4gPiA+ID4gPiA0LTUgaW4NCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGV2aWNlIGRhdGFzaGVldCBmb3IgZGV0YWlscy4NCj4gPiA+ID4gDQo+ID4gPiA+IElzIHRo
ZSBpbnRlZ3JhdGlvbiB0aW1lIGV2ZXIgaGlnaCBlbm91Z2ggdGhhdCBpdCBtYXR0ZXJzPw0KPiA+
ID4gPiBQZW9wbGUgdGVuZCBub3QgdG8gZG8gcG93ZXIgbWVhc3VyZW1lbnQgJ3F1aWNrbHknLg0K
PiA+ID4gPiANCj4gPiA+ID4gSWYgd2UgYXJlIGRvaW5nIGl0IHF1aWNrbHkgdGhlbiB5b3UnbGwg
cHJvYmFibHkgd2FudCB0byBiZQ0KPiA+ID4gPiBwcm92aWRpbmcgYnVmZmVyZWQNCj4gPiA+ID4g
c3VwcG9ydCBhbmQgdGhhdCBkb2VzIGFsbG93IHlvdSB0byAncmVhZCcgdGhlIHJlc29sdXRpb24g
Zm9yIGENCj4gPiA+ID4gcGFydA0KPiA+ID4gPiB3aGVyZQ0KPiA+ID4gPiBpdCBjaGFuZ2VzIGZv
ciBzb21lIG90aGVyIHJlYXNvbi7CoMKgIEkgaGF2ZW4ndCB5ZXQgdW5kZXJzdG9vZA0KPiA+ID4g
PiB0aGlzDQo+ID4gPiA+IGNhc2UuDQo+ID4gPiANCj4gPiA+IEkgd2lsbCByZW1vdmUgdGhpcyBj
b250cm9sIGFuZCBmaXggdGhlIHJlc29sdXRpb24gYml0cyB0byAxNA0KPiA+ID4gKGhpZ2hlc3QN
Cj4gPiA+IHZhbHVlKSwNCj4gPiA+IHNhbWUgYXMgdGhlIEhXIGRlZmF1bHQuDQo+ID4gDQo+ID4g
VGhlIHJlc29sdXRpb24gY291bGQgYmUgc2V0IGZyb20gdGhlIGRldmljZSB0cmVlLiBBcyBkZWZh
dWx0IGl0DQo+ID4gY291bGQNCj4gPiBiZSAxNCBiaXRzIGxpa2UgaW50byB0aGUgaGFyZHdhcmUu
IFRoZSB1c2VyIGNvdWxkIGFkZA0KPiA+ICJtaWNyb2NoaXAsbG93X3Jlc29sdXRpb25fdm9sdGFn
ZSIgaW50byB0aGUgZGV2aWNlIHRyZWUgaW4gb3JkZXIgdG8NCj4gPiB1c2UNCj4gPiBvbmx5IDEx
IGJpdHMgZm9yIHZvbHRhZ2Ugc2FtcGxlcy4NCj4gDQo+IEkgdGhpbmsgdGhpcyBzaG91bGQgYmUg
Y29udHJvbGxlZCBkdXJpbmcgcnVudGltZSBzaW5jZSBpdCBkb2VzIG5vdA0KPiBkZXBlbmQgb24N
Cj4gdGhlIEhXIGRlc2lnbiBidXQgbW9yZSBvbiB0aGUgdXNlciBwcmVmZXJlbmNlcyBhYm91dCBt
ZWFzdXJlbWVudHMNCj4gcHJlY2lzaW9uLg0KPiBBcyBKb25hdGhhbiBwb2ludGVkIG91dCwgc2lu
Y2UgY3VzdG9tIEFCSXMgc2hvdWxkIGJlIGF2b2lkZWQgd2hlbg0KPiBwb3NzaWJsZSwgSQ0KPiB3
aWxsIGxlYXZlIGl0IG91dCBmcm9tIG5vdyB1bnRpbCBpdCBiZWNvbWVzIG5lY2Vzc2FyeSBhbmQg
Zml4IHRoZQ0KPiByZXNvbHV0aW9uIHRvDQo+IDE0IGJpdHMsIGFzIHRoZSBIVyBkZWZhdWx0Lg0K
PiANCg0KU2V0IHRoZSBjb25maWd1cmF0aW9uIGZyb20gdGhlIGRldmljZSB0cmVlLCB3aWxsIGF2
b2lkIGN1c3RvbSBBQkkuIFRoZQ0KZGV2aWNlIHRyZWUgY291bGQgYmUgY2hhbmdlZCBhbHNvIGF0
IHJ1bnRpbWUuDQoNCj4gLi4uDQo+ID4gPiA+ID4gK1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqANCj4gPiA+ID4gPiAvc3lzL2J1cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlcy9maWx0ZXJz
X2VuDQo+ID4gPiA+ID4gK0tlcm5lbFZlcnNpb246wqDCoMKgwqAgNi4xMA0KPiA+ID4gPiA+ICtD
b250YWN0OsKgwqAgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ICtEZXNjcmlw
dGlvbjoNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgQXR0cmlidXRlIHRvIGVuYWJs
ZS9kaXNhYmxlIEFEQyBwb3N0IGZpbHRlcnMuDQo+ID4gPiA+ID4gRW5hYmxlZA0KPiA+ID4gPiA+
IGJ5DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIGRlZmF1bHQuDQo+ID4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgIFRoaXMgYXR0cmlidXRlIGFmZmVjdHMgdGhlIGludGVncmF0
aW9uIHRpbWU6IHdpdGgNCj4gPiA+ID4gPiBmaWx0ZXJzDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgIGVuYWJsZWQgdGhlIGludGVncmF0aW9uIHRpbWUgaXMgaW5jcmVhc2VkIGJ5IDUw
JS4NCj4gPiA+ID4gPiBTZWUNCj4gPiA+ID4gPiBUYWJsZSA0LTUNCj4gPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaW4gZGV2aWNlIGRhdGFzaGVldCBmb3IgZGV0YWlscy4NCj4gPiA+ID4g
DQo+ID4gPiA+IERvIHdlIGhhdmUgYW55IGlkZWEgd2hhdCB0aGlzIGZpbHRlciBpcz8gRGF0YXNo
ZWV0IHNlZW1zIHZlcnkNCj4gPiA+ID4gdmFndWUNCj4gPiA+ID4gaW5kZWVkIGFuZCBmcm9tDQo+
ID4gPiA+IGEgY29udHJvbCBwb2ludCBvZiB2aWV3IHRoYXQgbWFrZXMgdGhpcyBsYXJnZWx5IHVz
ZWxlc3MuIEhvdw0KPiA+ID4gPiBkb2VzDQo+ID4gPiA+IHVzZXJzcGFjZSBrbm93DQo+ID4gPiA+
IHdoZXRoZXIgdG8gdHVybiBpdCBvbj8NCj4gPiA+ID4gDQo+ID4gPiA+IFdlIGhhdmUgYW4gZXhp
c3RpbmcgZmlsdGVyIEFCSSBidXQgd2l0aCBzbyBsaXR0bGUgaW5mb3JtYXRpb24NCj4gPiA+ID4g
bm8NCj4gPiA+ID4gd2F5IHRvIGZpdCB0aGlzIGluLg0KPiA+ID4gPiBHdXQgZmVlbGluZywgbGVh
dmUgaXQgb24gYWxsIHRoZSB0aW1lIGFuZCBkcm9wIHRoZSBjb250cm9sDQo+ID4gPiA+IGludGVy
ZmFjZS4NCj4gPiA+IA0KPiA+ID4gSSB3aWxsIHJlbW92ZSB0aGlzIGNvbnRyb2wgYW5kIGxlYXZl
IGl0IG9uIGFsbCB0aGUgdGltZSBhcyB0aGUgSFcNCj4gPiA+IGRlZmF1bHQuDQo+ID4gPiANCj4g
PiANCj4gPiBUaGUgZmlsdGVycyBjb3VsZCBiZSBlbmFibGVkIGZyb20gdGhlIGRldmljZSB0cmVl
LiBBcyBkZWZhdWx0IGl0DQo+ID4gY291bGQNCj4gPiBiZSBkaXNhYmxlZC4NCj4gPiBBcyBhIHNt
YWxsIGRldGFpbCBoZXJlIHRoaXMgaXMgYSBwb3N0IHByb2Nlc3NpbmcgZGlnaXRhbCBmaWx0ZXIN
Cj4gPiB0aGF0DQo+ID4gY291bGQgYmUgZW5hYmxlZC9kaXNhYmxlZCBpbnNpZGUgdGhlIFBBQyBt
b2R1bGUuDQo+ID4gDQo+IA0KPiBTYW1lIHJlYXNvbmluZyBvZiB0aGUgcmVzb2x1dGlvbl9iaXRz
IHBhcmFtZXRlciBhcHBsaWVzIGhlcmUuIEkgd2lsbA0KPiBmaXggdGhlDQo+IGZpbHRlcnMgdG8g
ZW5hYmxlZCwgYXMgdGhlIEhXIGRlZmF1bHQuIElmIHRoZXJlIGlzIGFueSBwYXJ0aWN1bGFyDQo+
IHJlYXNvbiB0bw0KPiBwcmVmZXIgdGhlIGZpbHRlcnMgZml4ZWQgYXMgZGlzYWJsZWQgSSB3aWxs
IGNoYW5nZSB0aGF0Lg0KPiANCklmIHRoZSB1c2VyIGNhbiBjaGFuZ2UgdGhlIG9uL29mZiBmb3Ig
dGhlIGZpbHRlcnMgaXQgZG9lc24ndCBtYXR0ZXINCndoYXQgd2lsbCBiZSB0aGUgZGVmYXVsdCBi
ZWhhdmlvci4gQmVpbmcgYSBzaW5nbGUgY2hhbm5lbCBkZXZpY2UsIHRoZQ0KcHJvYmFiaWxpdHkg
Zm9yIHRoZSB1c2VyIHRvIGNoYW5nZSB0aGUgZmlsdGVyIGJlaGF2aW9yIGR1cmluZyBydW50aW1l
DQppcyBtaW5pbWFsLCB0aGF0IHdhcyB0aGUgbWFpbiByZWFzb24gZm9yIGxldHRpbmcgdGhlIHVz
ZXIgdG8gY2hhbmdlIHRoZQ0KY29uZmlndXJhdGlvbiBmcm9tIHRoZSBkZXZpY2UgdHJlZSBhbmQg
bm90IGhhcmRjb2RlIGl0Lg0KDQo+IC4uLg0KPiA+IFRoYW5rcywNCj4gPiBNYXJpdXMNCj4gDQo+
IFRoYW5rcywNCj4gTWF0dGVvDQoNClRoYW5rcywNCk1hcml1cw0K

