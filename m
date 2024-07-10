Return-Path: <linux-iio+bounces-7491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6189E92D5A8
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2024 18:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE4328A43C
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2024 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F7194AE6;
	Wed, 10 Jul 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nPHRB55f";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jQo2j8fY"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE61194AE0;
	Wed, 10 Jul 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627316; cv=fail; b=WesRS+H01w/2pWXg9mPahocslgKANsv5RQLu82vS9cIvkdOZhQD3K6VGt7/yujFUb4QlguNz1R9S8gRZG1UIwdH74e2dTYKZ9YV5XIHLHCqyMgnnYIY8DIiHDXrSxXedmsX1XImHdbH+wA9yEzGLsMHMy9Qv0qQhgl1xmFDMLyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627316; c=relaxed/simple;
	bh=Nq7MDzL9Awp9bMDYRzhpBhLPNsjOfbBkDsCVDLOH9jU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U2OcRusumDG6vNRjUkfunSFvdVPjU0Mpq/5XIH2JQTPRoXZaGWDSMBX2AgEtwVgIvU0NBVLeQPN+GVpQhzz2UetcVPaJjvQASsooxRDX07zo54vCZ1GmvFp+Nbgn5G0veWjE0Ae3iy1u0f7YliB4A5aBB3WC5SAr9NriuciQdFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nPHRB55f; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jQo2j8fY; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720627314; x=1752163314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Nq7MDzL9Awp9bMDYRzhpBhLPNsjOfbBkDsCVDLOH9jU=;
  b=nPHRB55fiIfFVNFCZL3INpKFJWLVaPBmwCdMExdwHD/Y7XP0X1bt1AVX
   DwQaQE2GUjYU9kQmfHnNT/7BQ7Q4POFnerQKR+6JyrW779wgleUXEVTmv
   2kH3kuaCoslfCd/JBeh3fnZtNnVZbXQPbQe9s7V9/2goKTFrlS46Ln+sv
   TMFeaWRu5fmNtJqdV/XAuZtYBts75fn0ZHVFTGE8Ofx3BcNEameABQHgK
   5b4QmIC6wRoCQU78CuRa+ksZqLGKmrZj+KMxprbNM60SUKJTpJIerDfFV
   cDfAwTuzFNdwkiv7Wgl5Cm3fVxRHBLoUHQ8IWecl8zDiDS26sWk/UYmtL
   Q==;
X-CSE-ConnectionGUID: C3dXfkczRtGcnit5DyhpWA==
X-CSE-MsgGUID: DLuJGRG7TsuXAWsU86+LgA==
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29713512"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2024 09:01:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jul 2024 09:01:27 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jul 2024 09:01:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIzEg3c4X+ZjtMuP4gQ2r/ziW5qEf/C1/fA+KSqJQiGffXm8toX1mthVzNrBhxrG5ay8eXnZkkDcNitxUfSEyrHhwFJpmXTNS4AhmF/mD6GWh7FjJXhb6NJdllyyonvE96JLPjdbuW5MTzcCQFAN8rpcvCiUabbAYr1muXW7vtGkoivgDVQthRvF8egXgLBTjZUVk6KEaowuHZNGxzLnQJPVqFnRn0ToI9h7GkZK/5Q1q6Y5JzwS5pYLlVzMs9Gq2J7DfIYf7JiBkqig1wmsoG+6xbaFaQfkKKzU5q2eYiknnWWS3fCivMthT+r6A0znBI/CzhkywokxxYImT1f4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nq7MDzL9Awp9bMDYRzhpBhLPNsjOfbBkDsCVDLOH9jU=;
 b=kpVT3AzC92qqqUS8cVmRSau4QOsBdCiwoliFgNNY5jm1vLiaST9NGk+etG1p3ZWv8w34FN5PDiVGPS3xvwwWbUefgK/HIVB1CUzKazW7E0lNGhj0mhYwbp0uc8nhH7kfbMVpourNgqxpiltL4GSbYq5o26MOLcCvKymNCgT3xx23sLoHtLHrtJXDrWaNVaTR6eYldcxshd3XJ4YF5O21jS5xRR+bMjJGWJ2Zh9EZ0T8IXlg59LJPpx8/NCATKHudRYdz1JZK1LOeq5niIkPvWcsRa6THAMzJelYgoLGJewnluTOGETE79BeX9+YtBBaNDTcUnEftGRugwubQwFIxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq7MDzL9Awp9bMDYRzhpBhLPNsjOfbBkDsCVDLOH9jU=;
 b=jQo2j8fYQqJ4Vb0ps528m6JdjePpOKOJLjSdVrglktceSI6+LCPh4SwdogHJhHpIKTpddRAReLIZJi2ENkVvP2YgIkbreFYh9iW/XtXZMWIj9d702uSDwi4gnmNSgPR+Aj/FfsI2d1uyzzEj9WpEDfSHJ3m4XNVHfoikjtZFW5oWYO6s1CA///lxKbegBdve2KebjxLn5ZD3RpK3cKTUbAept95hDA5k2e6XhymXhALBfn2PEWvAT3wVAJeOK08SW4hZZ0m0k8GP+JQ9OULTyPfrX+fe2CAdsKcacK/E6HU+kcnb1aqeEafxhyMy2rvbXWjFS6qCkt6BmwzWbxM8mg==
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (2603:10b6:805:c6::10)
 by SJ1PR11MB6108.namprd11.prod.outlook.com (2603:10b6:a03:489::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 16:01:22 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 16:01:22 +0000
From: <Marius.Cristea@microchip.com>
To: <jic23@kernel.org>, <matteomartelli3@gmail.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Thread-Topic: [PATCH v2 2/2] iio: adc: add support for pac1921
Thread-Index: AQHazjmP/m+FUirFLUmAMKoURJhChrHrYYoAgAF6owCAA0wuAA==
Date: Wed, 10 Jul 2024 16:01:22 +0000
Message-ID: <88a54c736e0c39ead34dbde53c813526484d767d.camel@microchip.com>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
	 <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
	 <20240707160442.6bab64c9@jic23-huawei>
	 <668bec2a8b23a_6e037017@njaxe.notmuch>
In-Reply-To: <668bec2a8b23a_6e037017@njaxe.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3167:EE_|SJ1PR11MB6108:EE_
x-ms-office365-filtering-correlation-id: 55cce8a7-5b49-44c3-a2fe-08dca0f98b23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RU5vc2pYSlErRUVWYXl1UHJzcWQyU3dHclBvQ1grZGFMcm9DY3J3V1NYdysx?=
 =?utf-8?B?YVNwVnNuWnlyYlpQZVZ0MnZtREdXbVBUUzBBdlBiWTlMb1RscnVzd2RVUEtT?=
 =?utf-8?B?K1lmZzdudnkxSFJhUWpqcHAzMnRwUXpxVTlzVTRMLzlGN0l4MzZCRytCVlIv?=
 =?utf-8?B?NGJnckNOTnZZVk5hRzdNdmhKb3psZzJxSHhDelU4SDR3Q0ZjMFdFeWs3NUFl?=
 =?utf-8?B?LzM4bW03L0xOMWlYTzRsYmc1MS9lK2I5V0hRSjByaWpKajVSQzVIYU1JUzJO?=
 =?utf-8?B?OXpwUUJtazgyemRvVVh1bDQvSDI2c2ltaW9TRE9MVHRZdTN1bGhIZUhPR2FS?=
 =?utf-8?B?cStCenRiWTA1WFM3OVNrUVZBS0FIRDBpcWdBUzZGT3J6MkZTNExXR2VGWlRK?=
 =?utf-8?B?eDhuMEhsK0RDbktDeWMzcDN0VU5KODFwT3FJUGNHMGFoV0NYVGtXdmx0OWhx?=
 =?utf-8?B?NVdoWUIwb1BYdkd6SDI1UGZkTEFJZnlXc2hDL2J1MUp0aldxdmx0azFNRkJq?=
 =?utf-8?B?b0N5N1A2N3NITHhvWjRQTEZSWGI2NFlVcDJEUTVQVmhIMDA2T1ZqV2RRTEVH?=
 =?utf-8?B?cmI1c3ZBbS9HdHMxQUtvaHQ0YWx3d0V0M0FaVFpCTG51SEM2ZVM0MWJ3SzMv?=
 =?utf-8?B?Mk0xcjYyYmJFeTlyb0tWR245aDljeHZSSjNtaStZSUhWWGF4ekF6WkVmbHIy?=
 =?utf-8?B?dkJnQ1IxYkF0b01Tc2gvS21wM1h3T0pXMTFuZnpybzA0UStKZmR3YldKT0JM?=
 =?utf-8?B?cmNBN0pmc0hJc0VjWWpNR3VsMkZnaElFYW9VY0k2VlNGWHlyUDZrZml1bk54?=
 =?utf-8?B?bngwcUdRb1kxcFhHZDZxUEl3bWxOdUFKNktuejcrbFYwc09hTDhXb1pRMmtm?=
 =?utf-8?B?NzZIaUxIV0UwdHNUR1YxVGU4NzEwaDJ2aXZ1YlQwWFl0RnV4bVcwS0FNbE1w?=
 =?utf-8?B?cXFFOE9ucGdQY1QxWGliNWpZMzlPMUFqVk5DNmRPRG1QMnVXL1liNWUyQklE?=
 =?utf-8?B?Z1NwekdHc3VZdlZKcStDUGFOczVoRDFOMko4R21PVXJzVy9mMjYraWhKNmk3?=
 =?utf-8?B?aUZMTExpWGtTNllMcXIwZ1pYbmpTZUpLZ2RUVDAzbEhybDU5SjYvbENuN0RL?=
 =?utf-8?B?RTNVazl0a0FlajFTZzlSTXVDaTNuOGhubk1wNUZ5eFlrRVYvOTd3MWJQNDlu?=
 =?utf-8?B?QUV0cmkrbi9xd2RDRHZsWGZzZ09ocU91a2NyUGVRUTViWG96ZkNlcU96SkRx?=
 =?utf-8?B?L3JnZ3BxRS8vRkNiMjd2WG5wZlFpVXBVaUFoZ3EvY0lPVlYyU3RBZEFRVEhJ?=
 =?utf-8?B?eUl0WVM4VlJnV3Q2YVFCYjRJSlNsd2pKSFdmN1l5bTFxWUU5c2dsY3NRWWRU?=
 =?utf-8?B?bnpOZEhCc0l5RE1jUC9WaGI3QS9ad050enNwY0VFMzc5VStVbmdtQ2g3eE1s?=
 =?utf-8?B?UWRjbUxCN09lRlpUT2ZreFd4RWxWWlZheDRQdzhqTnVaeGQyZ0RDcWZRZURk?=
 =?utf-8?B?ZjYrZUJ0Z0NsdjBTcnVmZTBzV2craEtGOTJPZllUbWpBeHZCS3ZxQXE5QnpP?=
 =?utf-8?B?MXlYSXFlQXBHMmVCbW02UmJ2QTh5N3FwWUlFcmVreVAvWTRPNUNZS3ErcHVq?=
 =?utf-8?B?ZnFzb3hFM2NxL2hzekpYNzF2bjBOUVFkUzJrUHBtMmJEaDROMlFDMDJ4Z0lS?=
 =?utf-8?B?bEg5b3JRQmwvaDJVeHA1eFdnMldEUHRxKy9Qc2cyRktudUR1YkxNUEcyMUc2?=
 =?utf-8?B?bDlQOGFYb0xub0JHdWZlSEVuYkxQTU96M2FuVzhuaXBxckFUL01yNHhsaE8r?=
 =?utf-8?B?R2I2SFQrd0JjaUdSektud2Q3RStNck95YzBRRTlhMTlycEU5Rmg4c3dxMlNp?=
 =?utf-8?B?b3g5ZjZoU0VQTUw3ODZ0TnNPNGhmNytSRjFHa0ZWMzdVTFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDN5UmxPRGpUc0g4cm03RllQREMyVTdiU2ErSlc3dzNwVXU0ZXE1NFc3dzZG?=
 =?utf-8?B?UFY2bWg5bGcwcGYrdm1GQkZhY01HeWxZRE5LUTRiRW9CUWJPWFdlZnNudDZz?=
 =?utf-8?B?WUppQ1psaU85b1lWUEtrY0wwNkdwMzRkaGNxaG5NRk9BVDhaVVYwalZhdVVn?=
 =?utf-8?B?UzRUWm1sOElFS0VOU3ZkWnM2a01TaGhuYWFOOTMrSHNtS2RkcCt6ZE1OTWdR?=
 =?utf-8?B?QzJBUjNMQ3N3c2Y3UC8vSGpRYWFHd0lIRGU1Z05ZYllOS2Z5Q0hyMXY5QmIv?=
 =?utf-8?B?ME9ZUXRwNklUcTBRNm1nUldhMy9ucjFTZk1nR3FkaTdiR1ZKMXNiK2dJWkds?=
 =?utf-8?B?ZGVUWG1VN04zd3VDaHNoeURNb200UnlnNmZqU2k1ZnJuODJnbmlOcHhBckNY?=
 =?utf-8?B?TWN4NG5mak1VenNzSG9ZbFpybjMzVGZUb2FYUUU1bWVoOUQ5dktQeFMyN3g0?=
 =?utf-8?B?MkZzbUpFeHNNekpUR0FyTEdLd2szaUNhSUpTc3l5MEY1SG54blFnY0ZpVE9H?=
 =?utf-8?B?ZTJjdE5sRWpaSFR5RDhZeUdlN3p6b1ZQaW1MUE9LNnY5L2VsTllZNngyMnVM?=
 =?utf-8?B?UEh4RVhYbFFxWDEybTZpOGVHb1cwenBrYitEYWRRZTJPNm1KdCtBWmVwR3Vn?=
 =?utf-8?B?NlBrT0N1RHBNaXI1elpaNGF3Wk5qbHZkRDhKYU1DTmtpbHFyOWxMc0NjR3Rv?=
 =?utf-8?B?Y1IxMHdyNUppNThXcGc2SHZWQlR4aG8yRnNKc2dXVmorREdIRDYzM3FldnJk?=
 =?utf-8?B?WHhjRUJ4MlpRQXVLMWV4NHM4M1NjSEN5TjgrTFpMWWkvc3NlRE9FcXRtakVN?=
 =?utf-8?B?Y0VSdVFGU0p6UzFtbE5wTkZjREsrczFlNVVqWDFCTzkvWG9PYXB1RjRadHVO?=
 =?utf-8?B?RnBRaE1xRVdVdXEyNjhuZGZEOE1YelVUMEhxKzFTaElCeEdYdEpoKzJyTDVp?=
 =?utf-8?B?dnZJai95QlczTnJ1L3g0Q0R6K3dvWXdwcURhMm4zK1pOM0RiUXBxZmxsbjFM?=
 =?utf-8?B?MEpsbEFMVXBsUENUZGJXVXpzd0k3SnQrZjllc3hSU2FJUGgxamJ1UU4rQmVH?=
 =?utf-8?B?T1dPYWYyMTZRblFWZUd1OXgwTEpITEp6OWcvVFA0b1QwNzd5MElXdStzTmFR?=
 =?utf-8?B?VGY4aG1rWmpVakY5dkJJRHhFQmM0UW9xTzlONVREWGtsOHVlUFd3UjRYNy9X?=
 =?utf-8?B?cy9aanlNeGpUQWRLT0ZUMDd2YVlsYlo2UmdoQ1k2VnRROC9zSFJTY1IwWjVL?=
 =?utf-8?B?bHZ1N1FqSGYyWkUzSmsrRVBYTjNIQW1tOE1DNHhtZWZtdTRkYUNhb3RLYmd5?=
 =?utf-8?B?WFNUekxzNS9sU01vU3dXVzhwZm5kZ0pBUkg2WHZCd0x6dW5RNG5YVjVjaWdS?=
 =?utf-8?B?akQ3VG1qeHlGcEtTMmZ2OWh6a280QWpUdDJnODFNbjV4VThWemU4LzlQR0l5?=
 =?utf-8?B?Wi9iWTNvZ0dDNHIyaG1JSzJ3Mm5ESG03R3JxR0dkTWhPMTJSZU4reG1Wc3ND?=
 =?utf-8?B?M0tZUlEyRUx5MDZiUkpYY090Tm1sV3RjbDlXYlZjbHhRNTU3QmtwMGZZVUZx?=
 =?utf-8?B?UnBaR0xQT1drOXBEWWw4NVFOOGVhRnF4alZDNVF1eU5hcGQ2NFBHcWxmdmk4?=
 =?utf-8?B?czg3UW54bXNCaDRJWC9yZnJ0UDkrWks3RVl3TUFuUjVwdjBHQ0RFTDBXUDhP?=
 =?utf-8?B?OW52S01MMk9JeHV6RDBDVlg1cTMrTUFBL0l3UW1hTnIyU0dzM0RjUnQ4U3ls?=
 =?utf-8?B?ODFaRCtyOG5yaUlTZU5MWEJWZE1NYWs5NGR6WUhNTmkyczlDT1oyWWdCQmdO?=
 =?utf-8?B?ZStGQnFZWVJ5Sk4vOThrSVFHdSttN21nTkQyMUd5bnE3d1F0SHJrMUJ4QzVY?=
 =?utf-8?B?SVlhTjRTcjJDRGIzdVp5VmoyQlRYSXhrUmNlYkpWZWFLMVZoRDV0akpubmtr?=
 =?utf-8?B?cDNTamtLR0grempMcStxK0JLZnRNUWg4TG1aYVpvRm5GQnZrT1Y0RDJCdlhv?=
 =?utf-8?B?eHlZQjU2VUZWVEh0RENEd2dpa1FtRlJ0dzBhcy9MWlFUU2dGUjY3eWZzeXJ3?=
 =?utf-8?B?M2ZPKzhZcVk5THlLdGZ6c1hEb0VJRkhyVXVRc0hibXZTK2dodlhkaldvSFp1?=
 =?utf-8?B?WXhrRHZ1Wm9rOGNtUEh2YldHUUN2akQrQ3pxQ0R4ZHgrK2ZHU3FmSW15N0xW?=
 =?utf-8?Q?8N/UpyKBth1syfW2GUJAD5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E2BBD2591561B41BD2E4CD9928EF0B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cce8a7-5b49-44c3-a2fe-08dca0f98b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 16:01:22.0829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQFeNcmLEcLKu+zFImCZ2rKt20P78pq2WxwjGiFxrwK1jdtvhiPIikDB1MrbWMrfWLvxQxy5w01w8BbedR3eNCvos01kZM5YSbWy71QJvbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6108

SGkgTWF0dGVvLA0KDQpPbiBNb24sIDIwMjQtMDctMDggYXQgMTU6MzkgKzAyMDAsIE1hdHRlbyBN
YXJ0ZWxsaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiA+IA0KPiANCg0KDQo+IEkgdGhpbmsgdGhhdCB0aGUgT1VUIHBpbiBtaWdodCBub3QgYmUg
dXNlZCBhdCBhbGwgaW4gbWFueSB1c2UgY2FzZXMNCj4gc28gSSB3b3VsZA0KPiBsZWF2ZSB0aGUg
T1VUIHBpbiBzZXR0aW5nIGFzIGZpeGVkIGZvciBub3cgYW5kIG1heWJlIGV4dGVuZCBpdCBpbiB0
aGUNCj4gZnV0dXJlDQo+IHdoZW4gbW9yZSB1c2UgY2FzZXMgYXJpc2UuIEkgYW0gb3BlbiB0byBy
ZWNvbnNpZGVyIHRoaXMgdGhvdWdoLg0KPiANCg0KVGhlIE9VVCBmdW5jdGlvbmFsaXR5IGNvdWxk
IGJlIHNldCBmcm9tIHRoZSBkZXZpY2UgdHJlZS4NCg0KPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiDC
oC4uLi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvLWFkYy1wYWMxOTIxwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgIDQ1ICsNCj4gPiA+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqDCoCA3ICsNCj4gPiA+IMKgZHJpdmVycy9paW8vYWRjL0tjb25maWfCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMTAgKw0KPiA+
ID4gwqBkcml2ZXJzL2lpby9hZGMvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgMSArDQo+ID4gPiDCoGRyaXZlcnMvaWlv
L2FkYy9wYWMxOTIxLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDEwMzgNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gPiDCoDUgZmls
ZXMgY2hhbmdlZCwgMTEwMSBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tYWRjLXBhYzE5MjENCj4g
PiA+IGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlvLWFkYy1wYWMxOTIx
DQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi40
YTMyZTJkNDIwN2INCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWlpby1hZGMtcGFjMTkyMQ0KPiA+IFF1aXRlIGEgYml0
IG9mIGN1c3RvbSBBQkkgaW4gaGVyZS4NCj4gPiANCj4gPiBSdWxlIG9mIHRodW1iIGlzIHRoYXQg
Y3VzdG9tIEFCSSBpcyBtb3JlIG9yIGxlc3MgcG9pbnRsZXNzIEFCSSBmb3INCj4gPiA5OSUgb2Yg
dXNlcnMNCj4gPiBiZWNhdXNlIHN0YW5kYXJkIHVzZXJzcGFjZSB3b24ndCB1c2UgaXQuwqAgU28g
a2VlcCB0aGF0IGluIG1pbmQgd2hlbg0KPiA+IGRlZmluaW5nIGl0Lg0KPiA+IA0KPiA+ID4gQEAg
LTAsMCArMSw0NSBAQA0KPiA+ID4gK1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4g
PiA+IC9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2VYL3Jlc29sdXRpb25fYml0cw0KPiA+
ID4gK0tlcm5lbFZlcnNpb246wqDCoMKgwqAgNi4xMA0KPiA+ID4gK0NvbnRhY3Q6wqDCoCBsaW51
eC1paW9Admdlci5rZXJuZWwub3JnDQo+ID4gPiArRGVzY3JpcHRpb246DQo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqAgQURDIG1lYXN1cmVtZW50IHJlc29sdXRpb24uIENhbiBiZSBlaXRoZXIg
MTEgYml0cyBvcg0KPiA+ID4gMTQgYml0cw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIChk
ZWZhdWx0KS4gVGhlIGRyaXZlciBzZXRzIHRoZSBzYW1lIHJlc29sdXRpb24gZm9yDQo+ID4gPiBi
b3RoIFZCVVMgYW5kDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgVlNFTlNFIG1lYXN1cmVt
ZW50cyBldmVuIGlmIHRoZSBoYXJkd2FyZSBjb3VsZCBiZQ0KPiA+ID4gY29uZmlndXJlZCB0bw0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIG1lYXN1cmUgVkJVUyBhbmQgVlNFTlNFIHdpdGgg
ZGlmZmVyZW50IHJlc29sdXRpb25zLg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIFRoaXMg
YXR0cmlidXRlIGFmZmVjdHMgdGhlIGludGVncmF0aW9uIHRpbWU6IHdpdGggMTQNCj4gPiA+IGJp
dHMNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXNvbHV0aW9uIHRoZSBpbnRlZ3JhdGlv
biB0aW1lIGlzIGluY3JlYXNlZCBieSBhDQo+ID4gPiBmYWN0b3Igb2YNCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoCAxLjkgKHRoZSBkcml2ZXIgY29uc2lkZXJzIGEgZmFjdG9yIG9mIDIpLiBT
ZWUgVGFibGUNCj4gPiA+IDQtNSBpbg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIGRldmlj
ZSBkYXRhc2hlZXQgZm9yIGRldGFpbHMuDQo+ID4gDQo+ID4gSXMgdGhlIGludGVncmF0aW9uIHRp
bWUgZXZlciBoaWdoIGVub3VnaCB0aGF0IGl0IG1hdHRlcnM/DQo+ID4gUGVvcGxlIHRlbmQgbm90
IHRvIGRvIHBvd2VyIG1lYXN1cmVtZW50ICdxdWlja2x5Jy4NCj4gPiANCj4gPiBJZiB3ZSBhcmUg
ZG9pbmcgaXQgcXVpY2tseSB0aGVuIHlvdSdsbCBwcm9iYWJseSB3YW50IHRvIGJlDQo+ID4gcHJv
dmlkaW5nIGJ1ZmZlcmVkDQo+ID4gc3VwcG9ydCBhbmQgdGhhdCBkb2VzIGFsbG93IHlvdSB0byAn
cmVhZCcgdGhlIHJlc29sdXRpb24gZm9yIGEgcGFydA0KPiA+IHdoZXJlDQo+ID4gaXQgY2hhbmdl
cyBmb3Igc29tZSBvdGhlciByZWFzb24uwqDCoCBJIGhhdmVuJ3QgeWV0IHVuZGVyc3Rvb2QgdGhp
cw0KPiA+IGNhc2UuDQo+IA0KPiBJIHdpbGwgcmVtb3ZlIHRoaXMgY29udHJvbCBhbmQgZml4IHRo
ZSByZXNvbHV0aW9uIGJpdHMgdG8gMTQgKGhpZ2hlc3QNCj4gdmFsdWUpLA0KPiBzYW1lIGFzIHRo
ZSBIVyBkZWZhdWx0Lg0KDQpUaGUgcmVzb2x1dGlvbiBjb3VsZCBiZSBzZXQgZnJvbSB0aGUgZGV2
aWNlIHRyZWUuIEFzIGRlZmF1bHQgaXQgY291bGQNCmJlIDE0IGJpdHMgbGlrZSBpbnRvIHRoZSBo
YXJkd2FyZS4gVGhlIHVzZXIgY291bGQgYWRkDQoibWljcm9jaGlwLGxvd19yZXNvbHV0aW9uX3Zv
bHRhZ2UiIGludG8gdGhlIGRldmljZSB0cmVlIGluIG9yZGVyIHRvIHVzZQ0Kb25seSAxMSBiaXRz
IGZvciB2b2x0YWdlIHNhbXBsZXMuDQoNCj4gDQo+ID4gPiArDQo+ID4gPiArV2hhdDrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoA0KPiA+ID4gL3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmlj
ZVgvcmVzb2x1dGlvbl9iaXRzX2F2YWlsYWJsZQ0KPiA+ID4gK0tlcm5lbFZlcnNpb246wqDCoMKg
wqAgNi4xMA0KPiA+ID4gK0NvbnRhY3Q6wqDCoCBsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+
ID4gPiArRGVzY3JpcHRpb246DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgTGlzdCBhbGwg
cG9zc2libGUgQURDIG1lYXN1cmVtZW50IHJlc29sdXRpb25zOiAiMTENCj4gPiA+IDE0Ig0KPiA+
ID4gKw0KPiA+ID4gK1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiA+IC9zeXMv
YnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2VYL2ludGVncmF0aW9uX3NhbXBsZXMNCj4gPiA+ICtL
ZXJuZWxWZXJzaW9uOsKgwqDCoMKgIDYuMTANCj4gPiA+ICtDb250YWN0OsKgwqAgbGludXgtaWlv
QHZnZXIua2VybmVsLm9yZw0KPiA+ID4gK0Rlc2NyaXB0aW9uOg0KPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgIE51bWJlciBvZiBzYW1wbGVzIHRha2VuIGR1cmluZyBhIGZ1bGwgaW50ZWdyYXRp
b24NCj4gPiA+IHBlcmlvZC4gQ2FuIGJlDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0
IHRvIGFueSBwb3dlciBvZiAyIHZhbHVlIGZyb20gMSAoZGVmYXVsdCkgdG8gMjA0OC4NCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBUaGlzIGF0dHJpYnV0ZSBhZmZlY3RzIHRoZSBpbnRlZ3Jh
dGlvbiB0aW1lOiBoaWdoZXINCj4gPiA+IHRoZSBudW1iZXINCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoCBvZiBzYW1wbGVzLCBsb25nZXIgdGhlIGludGVncmF0aW9uIHRpbWUuIFNlZSBUYWJs
ZSA0LQ0KPiA+ID4gNSBpbiBkZXZpY2UNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRh
c2hlZXQgZm9yIGRldGFpbHMuDQo+ID4gDQo+ID4gU291bmRzIGxpa2Ugb3ZlcnNhbXBsaW5nX3Jh
dGlvIHdoaWNoIGlzIHN0YW5kYXJkcyBBQkkuIFNvIHVzZSB0aGF0DQo+ID4gb3IgZXhwbGFpbg0K
PiA+IHdoeSB5b3UgY2FuJ3QgaGVyZS4NCj4gDQo+IEkgYW0gbm90IHN1cmUgdGhhdCB0aGlzIGlz
IGFuIG92ZXJzYW1wbGluZyByYXRpbyBidXQgY29ycmVjdCBtZSBpZiBJDQo+IGFtIHdyb25nOg0K
PiBnZW5lcmFsbHkgYnkgaW5jcmVhc2luZyB0aGUgb3ZlcnNhbXBsaW5nIHlvdSB3b3VsZCBoYXZl
IGFkZGl0aW9uYWwNCj4gc2FtcGxlcyBpbiBhDQo+IGZpeGVkIHRpbWUgcGVyaW9kLCB3aGlsZSBp
biB0aGlzIGNhc2UgYnkgaW5jcmVhc2luZyB0aGUgbnVtYmVyIG9mDQo+IHNhbXBsZXMgeW91DQo+
IHdvdWxkIHN0aWxsIGhhdmUgdGhlIHNhbWUgbnVtYmVyIG9mIHNhbXBsZXMgaW4gYSBmaXhlZCB0
aW1lIHBlcmlvZCwNCj4gYnV0IHlvdQ0KPiB3b3VsZCBoYXZlIGEgbG9uZ2VyIGludGVncmF0aW9u
IHBlcmlvZC4gU28gbWF5YmUgdGhlIGNvbW1lbnQgaXMgbm90DQo+IHZlcnkNCj4gY2xlYXIgc2lu
Y2UgdGhpcyBwYXJhbWV0ZXIgYWN0dWFsbHkgbWVhbnMgInRoZSBudW1iZXIgb2Ygc2FtcGxlcw0K
PiByZXF1aXJlZCB0bw0KPiBjb21wbGV0ZSB0aGUgaW50ZWdyYXRpb24gcGVyaW9kIi4NCj4gDQo+
IEluaXRpYWxseSBJIHRob3VnaHQgdG8gbGV0IHRoZSB1c2VyIGVkaXQgdGhpcyBieSB3cml0aW5n
IHRoZQ0KPiBpbnRlZ3JhdGlvbl90aW1lDQo+IGNvbnRyb2wgKHdoaWNoIGlzIGN1cnJlbnRseSBy
ZWFkLW9ubHkpLCBidXQgc2luY2UgdGhlIGludGVncmF0aW9uDQo+IHBlcmlvZA0KPiBkZXBlbmRz
IGFsc28gb24gdGhlIHJlc29sdXRpb24gYW5kIHdoZXRoZXIgZmlsdGVycyBhcmUgZW5hYmxlZCBv
cg0KPiBub3QsIGl0IHdvdWxkDQo+IGhhdmUgaW50cm9kdWNlZCBzb21lIGNvbmZ1c2lvbjogd2hh
dCBwYXJhbWV0ZXIgaXMgYmVpbmcgY2hhbmdlZCB1cG9uDQo+IGludGVncmV0aW9uX3RpbWUgd3Jp
dGU/IE1heWJlIGFmdGVyIHJlbW92aW5nIHJlc29sdXRpb24gYW5kIGZpbHRlcg0KPiBjb250cm9s
cw0KPiB0aGVyZSB3b3VsZCBiZSBubyBzdWNoIGNvbmZ1c2lvbiBhbnltb3JlLg0KPiANCj4gPiA+
ICsNCj4gPiA+ICtXaGF0OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4gPiAvc3lzL2J1
cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlWC9pbnRlZ3JhdGlvbl9zYW1wbGVzX2F2YWlsYWJsZQ0K
PiA+ID4gK0tlcm5lbFZlcnNpb246wqDCoMKgwqAgNi4xMA0KPiA+ID4gK0NvbnRhY3Q6wqDCoCBs
aW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+ID4gPiArRGVzY3JpcHRpb246DQo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqAgTGlzdCBhbGwgcG9zc2libGUgbnVtYmVycyBvZiBpbnRlZ3JhdGlv
biBzYW1wbGVzOg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgICIxIDIgNCA4IDE2IDMyIDY0
IDEyOCAyNTYgNTEyIDEwMjQgMjA0OCINCj4gPiA+ICsNCj4gPiA+ICtXaGF0OsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2VzL2ZpbHRlcnNf
ZW4NCj4gPiA+ICtLZXJuZWxWZXJzaW9uOsKgwqDCoMKgIDYuMTANCj4gPiA+ICtDb250YWN0OsKg
wqAgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gK0Rlc2NyaXB0aW9uOg0KPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgIEF0dHJpYnV0ZSB0byBlbmFibGUvZGlzYWJsZSBBREMgcG9z
dCBmaWx0ZXJzLiBFbmFibGVkDQo+ID4gPiBieQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
IGRlZmF1bHQuDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgVGhpcyBhdHRyaWJ1dGUgYWZm
ZWN0cyB0aGUgaW50ZWdyYXRpb24gdGltZTogd2l0aA0KPiA+ID4gZmlsdGVycw0KPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIGVuYWJsZWQgdGhlIGludGVncmF0aW9uIHRpbWUgaXMgaW5jcmVh
c2VkIGJ5IDUwJS4gU2VlDQo+ID4gPiBUYWJsZSA0LTUNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpbiBkZXZpY2UgZGF0YXNoZWV0IGZvciBkZXRhaWxzLg0KPiA+IA0KPiA+IERvIHdlIGhh
dmUgYW55IGlkZWEgd2hhdCB0aGlzIGZpbHRlciBpcz8gRGF0YXNoZWV0IHNlZW1zIHZlcnkgdmFn
dWUNCj4gPiBpbmRlZWQgYW5kIGZyb20NCj4gPiBhIGNvbnRyb2wgcG9pbnQgb2YgdmlldyB0aGF0
IG1ha2VzIHRoaXMgbGFyZ2VseSB1c2VsZXNzLiBIb3cgZG9lcw0KPiA+IHVzZXJzcGFjZSBrbm93
DQo+ID4gd2hldGhlciB0byB0dXJuIGl0IG9uPw0KPiA+IA0KPiA+IFdlIGhhdmUgYW4gZXhpc3Rp
bmcgZmlsdGVyIEFCSSBidXQgd2l0aCBzbyBsaXR0bGUgaW5mb3JtYXRpb24gbm8NCj4gPiB3YXkg
dG8gZml0IHRoaXMgaW4uDQo+ID4gR3V0IGZlZWxpbmcsIGxlYXZlIGl0IG9uIGFsbCB0aGUgdGlt
ZSBhbmQgZHJvcCB0aGUgY29udHJvbA0KPiA+IGludGVyZmFjZS4NCj4gDQo+IEkgd2lsbCByZW1v
dmUgdGhpcyBjb250cm9sIGFuZCBsZWF2ZSBpdCBvbiBhbGwgdGhlIHRpbWUgYXMgdGhlIEhXDQo+
IGRlZmF1bHQuDQo+IA0KDQpUaGUgZmlsdGVycyBjb3VsZCBiZSBlbmFibGVkIGZyb20gdGhlIGRl
dmljZSB0cmVlLiBBcyBkZWZhdWx0IGl0IGNvdWxkDQpiZSBkaXNhYmxlZC4NCkFzIGEgc21hbGwg
ZGV0YWlsIGhlcmUgdGhpcyBpcyBhIHBvc3QgcHJvY2Vzc2luZyBkaWdpdGFsIGZpbHRlciB0aGF0
DQpjb3VsZCBiZSBlbmFibGVkL2Rpc2FibGVkIGluc2lkZSB0aGUgUEFDIG1vZHVsZS4NCg0KDQoN
Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZyBiL2RyaXZlcnMvaWlv
L2FkYy9LY29uZmlnDQo+ID4gPiBpbmRleCBmNjBmZTg1YTMwZDUuLmI1NmU0OTRkYTk3MCAxMDA2
NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9LY29uZmlnDQo+ID4gPiArKysgYi9kcml2
ZXJzL2lpby9hZGMvS2NvbmZpZw0KPiA+ID4gQEAgLTk5MSw2ICs5OTEsMTYgQEAgY29uZmlnIE5Q
Q01fQURDDQo+ID4gPiDCoMKgwqDCoMKgIFRoaXMgZHJpdmVyIGNhbiBhbHNvIGJlIGJ1aWx0IGFz
IGEgbW9kdWxlLiBJZiBzbywgdGhlDQo+ID4gPiBtb2R1bGUNCj4gPiA+IMKgwqDCoMKgwqAgd2ls
bCBiZSBjYWxsZWQgbnBjbV9hZGMuDQo+ID4gPiANCj4gPiA+ICtjb25maWcgUEFDMTkyMQ0KPiA+
ID4gK8KgwqAgdHJpc3RhdGUgIk1pY3JvY2hpcCBUZWNobm9sb2d5IFBBQzE5MjEgZHJpdmVyIg0K
PiA+ID4gK8KgwqAgZGVwZW5kcyBvbiBJMkMNCj4gPiANCj4gPiANCj4gDQoNCj4gVGhhbmtzIGFn
YWluLA0KPiBNYXR0ZW8NCg0KDQpUaGFua3MsDQpNYXJpdXMNCg==

