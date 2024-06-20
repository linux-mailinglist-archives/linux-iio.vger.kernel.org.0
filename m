Return-Path: <linux-iio+bounces-6606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F990FA71
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 02:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3619D1C20FF4
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F75684;
	Thu, 20 Jun 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T65jtjFO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1C5661;
	Thu, 20 Jun 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844638; cv=fail; b=qdpMFumY8D2njOMeTeCErYcQrRqCu2VCPJBPo9J1WkaaJ2DhPUERBtrjKJqzd+bCIbX+bYk4UaHbvXcNVOtJviZcNSO+ncxyQdyKKDRB4tN48+HW0kycU2Ayj0NPtQW0eYqnXjLzes3en7milUdG8HShkyblS/3aMFOTMmpV0XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844638; c=relaxed/simple;
	bh=lMRJE39TA42EjezSZokbR6sB4e9XoSQ2cDDXsuQXhH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fWTIqYMp6opWDrH0pHO5S3OFGCjf5WBDqMzUpVH3QuYYkRIUR1cMB4D7IBcodH7Y4NRVbTHF3acoZ0ZBOs0F1qoTbaTDyrFYLpFJoT9vGN3XjXaB4oJKFv6vVpDfg+eXmSDYL4fhib9clEGRvlyrY1k3mM0yOlh6J3TBtT4XFgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T65jtjFO; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JGgAcA008607;
	Wed, 19 Jun 2024 20:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lMRJE
	39TA42EjezSZokbR6sB4e9XoSQ2cDDXsuQXhH0=; b=T65jtjFOexfufEtU//SLN
	u5ZtlHPrta9bJfstIbrCHJFoVc+8FXF5fm010LUAueFBVxAQnFruSuVmIu7zxxNL
	FaLDM9hQZUZp0l5knI+qFamdxuvZhVaZQfmzWwOSObmaEK/hFuesw1x5H+MRK9yU
	EURwS0eBQqaY3dIgmxB8mju+vJeSKifNM9zLFDUZWNykrBJgOWVzaCBaKG3fg39O
	QjOp0SgC+wP7Jj1E0N+tb+UAj7ZL7zBV3B4kk+x+q9zaLsURYfYxzqORK3tXNcWE
	dxydPpJCzu7jL2NTwRJipOovdV0xSKm1AGgyTBclyvEPcLMxIV4qNOkHN4QOvqsp
	A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yuj8q4c5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 20:00:16 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmnJmSiHePMHWOpW2ADv359eNpeIzsDIzYxUJMRJvyFyLne2IysaL95bF1ku7xhP5g95vcAX83kHr5uCbm7A/YpLhsTwTnrAF331QqcXg+To9Ou4yJysGqpvYjnAbB0mJueULZOlFq8MyY+aoObvxC/brcroAk7WF3naqhM61uVzsxTMHWstyPup0H83cQB3gsE311T1gXDWXTGyiZ5+vBGSbBBxfiaOY6u60FQwBh7BuZqT7N15IyyiIqO/4PBBYg6zTkBqliYn5vgAvl9AZLqprhmOaflskFDB2kiE8A56GTFGnrHaxQdXz7R+rxxLT6g3HAuR1UMDSnH364A0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMRJE39TA42EjezSZokbR6sB4e9XoSQ2cDDXsuQXhH0=;
 b=VKFRp7etBTcUpZn73exFSD2Rm8YAQa/K5/ZU/3+WnpwxITUiNA9loF76SjwfhXnPgfN33S7GQmOkiOiLO7LZnzsmByNSZU3DHf27HlYs/DxRtHVStjSCr2DFkcXGtyEr1GQVhHie76Fad2STnn54/mI4osnmzTDFXHSSJuh+izg0t5UuOrHF7H/LoEXzK0MD/zwQI53h+yBP42gGk23nUuKaE6FOuPKORFdxYgX6ekWWxJyt7fZHzUlZSKvK30VOKPgItPWu3gXYlaGuRLPp9im3ENKgukTbhUTQnKT0DfNvoP4PVHrsFtCSIYv0oGxFu9nZDU4B8YPQkpZ4HkwbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by DM4PR03MB6175.namprd03.prod.outlook.com (2603:10b6:5:39b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 00:00:14 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 00:00:14 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v4 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Thread-Topic: [PATCH v4 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Thread-Index: AQHawhTsMjsHSZC/C02q3o5Sui8RBrHO90xw
Date: Thu, 20 Jun 2024 00:00:00 +0000
Message-ID: 
 <PH0PR03MB7141F8D056FCAC6CEFEB8142F9CF2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
 <20240619064904.73832-6-kimseer.paller@analog.com>
In-Reply-To: <20240619064904.73832-6-kimseer.paller@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB3TlRRME1UaG1OeTB5WlRNeUxURXhaV1l0WVdGbU5TMW1PR1Uw?=
 =?utf-8?B?TTJJek0yUTJObVZjWVcxbExYUmxjM1JjTURVME5ERTRaamt0TW1Vek1pMHhN?=
 =?utf-8?B?V1ZtTFdGaFpqVXRaamhsTkROaU16TmtOalpsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNekl3T0NJZ2REMGlNVE16TmpNeU56RXpPRFkyTXpBd056YzJJaUJvUFNJ?=
 =?utf-8?B?MFdGVlFhVkpYTjJKb2QzZG5NMmxvYjI1amVXcEpLMjl0TlRROUlpQnBaRDBp?=
 =?utf-8?B?SWlCaWJEMGlNQ0lnWW04OUlqRWlJR05wUFNKalFVRkJRVVZTU0ZVeFVsTlNW?=
 =?utf-8?B?VVpPUTJkVlFVRkZiME5CUVVKdlZGWXZTVkJ6VEdGQlYxVjVSelo1UzJ3MU4w?=
 =?utf-8?B?OWFWRWxpY2tseFdHNXpORVJCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|DM4PR03MB6175:EE_
x-ms-office365-filtering-correlation-id: 5f8737dd-a509-44c7-f247-08dc90bbf5ff
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|366013|376011|7416011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cDhQMjEzVjlRRHd0Z0NVenlYVTFDOFdzM3BPM2kxakRlNXRMRjh1TWhQRm9C?=
 =?utf-8?B?ckY1MXZVRGpkb0d0bC9EaXAvQWdCbktPQzNRN1RwbStTZjZrMnRiNVFQTjll?=
 =?utf-8?B?bkxUOFh4K3JEbG1vL2V6NmRITzVGN0VLVDVDeWh2RmkyaUxSbERHbmJ1QTNa?=
 =?utf-8?B?a3I0aWJ2V3N3djI2RDVEc0k3QVhUc21WeVV2elAzNkFkQXpHQVQ0KzhRL1dp?=
 =?utf-8?B?WWltem0vaWMvL0YwTCtOcjZXOC91ME4yczUwSm1iNnBrdkd5akJJblA2am1Y?=
 =?utf-8?B?UGVMR1VYdTFSbnVod0RlY0FsUVR0OStoQjk2ZFVxM3ZTY2NDWGlPbXdMWXE5?=
 =?utf-8?B?R3BvamNLdEwyaTBVc0tRVm8yamdRYUxNMmhGbVlpM1hNTTlNaUxmT3JlZ21m?=
 =?utf-8?B?R1JyM2hCWmh0Q09Ya1R6OGxoaU9LMFpzZzZuSXMzZUdlT1hlcVpNTTIwU2RG?=
 =?utf-8?B?RlBSWjkxTWEzSlM0blZ3VUo2UTkxQmRMS2poS2ZiQTh0K0FuNlZSb1FzV1FI?=
 =?utf-8?B?UWdjUjNaK1hES2VyQzVTZDhEaVhEbHkyTHI3MWdpcXZ5ejBkYVJGRXhEU2xj?=
 =?utf-8?B?SDJ6UFQzd2hUZ0RZRDB0NjF1MjRzc3JDdzE1WlNHV0RUSkQ3Unk4K0RWSUQ4?=
 =?utf-8?B?NEtBN3dSblVwbWRyWU82NWkza29tVjh0Y1dIY3JxLzdTckRzZmtIVjFVcmgr?=
 =?utf-8?B?UFhjUzBvOCt3R29keXdQWVJadTg0bkFFZlNqVURuQ3B1Yk5CRDVwQ3dtTm03?=
 =?utf-8?B?LzV1L1lqSERyQnlXVUw0bnJEcGlwNXUrVEhDcWdqRG1mTnp2TUJjTjR5TVlp?=
 =?utf-8?B?T3lmNlNGNDZFVG1xVWpDWi80WndlaDEweXJja3NtQkJZUkNRb3pzcUNJWnZn?=
 =?utf-8?B?RUpKUlRyWkpLeXlSd29ocTVjOHp4RFBoSGRtTGE2RE5pNkczL2JGU2VCTzdZ?=
 =?utf-8?B?eDRmQnY2c3VsUWNyT1hrdGZWWmptTTNRVmx0b3FsTk9FTmtLNXQxWXV4czB6?=
 =?utf-8?B?RmZCdzV1aUc1VTcrRVlkQllkc3hzVUZMa2tYS2IxcTRtZlV0K2h1ajZFZHJq?=
 =?utf-8?B?aFByVHI1Q1FYMmM1R3A2NnR5N3Y2VEt1Rk9pSThQemc3bkJUUnRsamMzaHhQ?=
 =?utf-8?B?WjkyZ2cwUUozSVB0eHdDU25RTWtFMkFPTnZSL3IrMjNlSVVnSkpQOGs5ZHhF?=
 =?utf-8?B?OUNOVTZQYUlydXZuVVRRdFd2YXovTFpSNzVoQ1pJV3Fnb1Q5cEc4NFlGWTNv?=
 =?utf-8?B?cGxpS1VSRGdWajZCc2ZJeUszU3oyMXFuMTJXWUh1MjlMUUFzb2FzbHZXN0wz?=
 =?utf-8?B?Z3FxQU0zSWJ0cXhocXlidFU5eWMwRzVacUhpcGp1d0JJa0tudzVwNXFQd2JY?=
 =?utf-8?B?dXFVZ0JjMndNSXEvUnQwS3ZsRkEwR3hseWt2d3BrNkhwb0JQVitsMWtpU0U1?=
 =?utf-8?B?QzdJeE1mTmZTT09DNVljOEtqWEJlY3hTd3hOdGpKUEQwdHhPOVg1UmFaQ1g4?=
 =?utf-8?B?MnZNZTlneHpSY0UxN29OOGpVU3hpbDQrVEZVS2docC9VT2NHcHFuK25yNFR0?=
 =?utf-8?B?UFl2d0V3YUVadzkzYlY3N0VyWXdJN01vYlpBekx2Vk93M09rMEQwakUwQlJw?=
 =?utf-8?B?QkZ3aWhQdlVrRkU0dXQrQTZCN0VEQ2FYNFBKcVdJWjhaekZ3S2RINytVMi9H?=
 =?utf-8?B?bHZrbW5PV2ttYksvMW80V3pnRCtoS2FPMlQ2TTd1eThjUXpQbFhXRksvcTBz?=
 =?utf-8?Q?7mYSPhMPpHRrjlJCopOdqa6BugAe6XaSdUlOBy9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b2xHdkJLUjlGMXUwSkM1bklXdFdWNnBsMlRMck03UjBXQmVGODVNMDZIVDJi?=
 =?utf-8?B?UWtObG91NnJsdVM0L0l4WXF2R0EvTHRVVVJnQUxKeFk1bVRQcXNpSkxic01Q?=
 =?utf-8?B?ai9mbSs0cTZlSk0xWHFYQU10NmpWVUtvVnh2S0o4bklEUGR1a2VpNWk0cnZq?=
 =?utf-8?B?YlRQZEhTNjJ1aVRBODFJcEhuSVR2R3ZkUHNSc1VFVnY1RTlUSUc3WDNlR0R3?=
 =?utf-8?B?TjNaUE5DdXhCaEhZaTNiWGNYbXBZSk13T3dKWDVhWk9ta0dBRmxTYjF0UlEr?=
 =?utf-8?B?M0dnTGFiS3krdGJVNnpaeDlVcTJpTnRiRkg3WVZuMFRQNFBsWE5wUTl3azNr?=
 =?utf-8?B?MTZFYzF2STVabFU3Sk9OQzNJM0RrZFlISEVLNDBMdmVndGtOL0ZvM01JYzFN?=
 =?utf-8?B?Z1RSWG5kbk90dWhTcGpLMGd4RWZnMzhPUEJmY01EdTR1b09NNlZoYmFhckhN?=
 =?utf-8?B?L3RUQkw4bEgyOXVCeFdDbUs4WVh2QXMrOXN3d0dzaW5WaldoMlZSNkFjenhB?=
 =?utf-8?B?MVJBVm04ZUVQc3RaM3hHRmdTaXZhTmZjNktzUlNnQzNYQmFoNzBuWk1CWUlv?=
 =?utf-8?B?MitLT1BGZmFWWWVOL3VOUVFBYzBOL01LWFNjeUdvMUk5dEdTWUc2L2NPQTd1?=
 =?utf-8?B?YVFONjllK2c0aDRUSzltWTdwSUN2UStlM2tGOFB5czVoNnd3anR0ZEkrWDZm?=
 =?utf-8?B?OS9GTzVIMHRvYXZrUk5SNWs0NTlSamdtdzRNZWRQQlU3LzZ4T2N2WFBsV0Yx?=
 =?utf-8?B?V1lHUHZMZkd0MTBwTTQ2YjRxUUhjUS9ESUZsYk5OcmJ4dFdMTkpJYUpSeWxL?=
 =?utf-8?B?OFpKbWFBY2xXY0F5d3k3bWJZWjBTMFN4OVRhNzNpRzBBQ1hBWWVHM24zZXJK?=
 =?utf-8?B?a0Fqa2RzMVhteElHZUFrZmt2WVFZK1NVZ2FGMFB0cURITG40UlM3OTZDWjVI?=
 =?utf-8?B?WTlmNHNwK2FOS053V29vU29XU0R5OUdoc2ZmcTB1TzZMcXpDWDhGd0Jqa0dN?=
 =?utf-8?B?TDM3SVp2MFNpZ1hsbXE3M0tXakF6Ukxlc0x1VWxielBxOVlpNkZJVEZoSmwv?=
 =?utf-8?B?Z1N0a1lFa0I2Sjk4empPQ1crdzBhR2pDWEZaTzkydFFKNkE4N3pnbks1RzRG?=
 =?utf-8?B?Zm14VmhIcDl3alpWU1FOUG40MFRmWGJ3b2hMZ0d4L2JhWitRWHlqeE5pa1ZS?=
 =?utf-8?B?d24rTUVVTG8xc0s5cjZnWlljTjQwNmNZbWFpMWh0cWF1bDBaY2JML2hpdDc1?=
 =?utf-8?B?TWVkOWxBSC9nZE9rVFlzK3lDamhrOFNOOWIvMGZjcUFvbkdIKzFiUGlIZlpS?=
 =?utf-8?B?MTlrWURqbTVjSmdndDR3ZnlQeFR3RFZGSHlsMWp6enl0NTBXNkFscmN1REVT?=
 =?utf-8?B?RDE1YnFoMmI5NS9uakhjQUFqSSsrNTI2c3g1SUxhUjVQTXB3WTh3YjRzY3pv?=
 =?utf-8?B?VmZNaGRpdFVLTjlEWS9pSXR6MnEvQlhNQ05pZlY1bDB5Q2tvT3VXNXlvM0p5?=
 =?utf-8?B?WDVIaVBHMkdMdGdIcGhEcWwyZDlWNFJHRTJtSHJrRmVTbGpWTmxCZmJ6Ty9n?=
 =?utf-8?B?UU0zcHcvTEFKcXhpclNKRjBTQ2NET2MxSVZDZ09QM0JUbndRTVZMR0ozOFpl?=
 =?utf-8?B?RnJibVg0SFg0aFMxNksyWDk1clpJRkMwOTllbE1hMnFxZzhxSlQ5UzhKc0J2?=
 =?utf-8?B?Yjd5eVpwc3NlcWRSMlBCY3dpbzRVeVdRNytRNnFxQVVkSkFtdll5Z2FsbGNw?=
 =?utf-8?B?dW1Ia3pMU1cybEJEbE9CdHdwdGYwaExOYmJJT3VJTVcvME5qcit6cG04VXk5?=
 =?utf-8?B?UnpzbnpWZEZVTGhLeUhnSGNBRHhobU00U2h4MkU0cWc1VXB1L25BY1RtTVdm?=
 =?utf-8?B?c0Mzb0VTQjVBRVBtaHBpUjlrV3J6N2VPOUdrK2htQTZVSUFmT0U4bUZGOVFC?=
 =?utf-8?B?OGw3SXloOUVTbG1RL2llelNRY1RNbzl2WXhURjB5MDc5ZGdSQ2pwc1llNlVu?=
 =?utf-8?B?cXJlM3ZmbnpRT2ZYb1ZJYWlTNkNDM0puZmNRcVVDaEhMY0krMlRCQXNFSHFw?=
 =?utf-8?B?UGt1YWpnVnJBMkpsTzdRcWF0ZldzSGZNdzBvdzEvYVIyNHppenRETEh5QW02?=
 =?utf-8?B?VG9YdXZEanVhSjUyRnI5YXQvc3JUbENxTmhRRHJjRkFWYVZkNWZqNFVxc2NQ?=
 =?utf-8?B?N3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8737dd-a509-44c7-f247-08dc90bbf5ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 00:00:13.7511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yxf6FTv1kmEHRLiRWV+wIlUAwSK67RTcgarKWBjgV/FYA7kuUaX7DluqhDCc27CNTwuLwsLv0DwA7WM5tNxCUYVaAgj8xXf++SRT50dPMmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6175
X-Proofpoint-GUID: Y7qvlixcj0_Sxk6XQ3RvxjRMTS4vTFCo
X-Proofpoint-ORIG-GUID: Y7qvlixcj0_Sxk6XQ3RvxjRMTS4vTFCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190180

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2ltIFNlZXIgUGFsbGVy
IDxraW1zZWVyLnBhbGxlckBhbmFsb2cuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMTks
IDIwMjQgMjo0OSBQTQ0KPiBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
aWlvQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBEYXZpZCBMZWNobmVyDQo+IDxk
bGVjaG5lckBiYXlsaWJyZS5jb20+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5k
ZT47IExpYW0NCj4gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+OyBNYXJrIEJyb3duIDxi
cm9vbmllQGtlcm5lbC5vcmc+Ow0KPiBEaW1pdHJpIEZlZHJhdSA8ZGltYS5mZWRyYXVAZ21haWwu
Y29tPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJuZWwub3JnPjsgUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IENvbm9yIERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVs
Lm9yZz47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNv
bT47IE51bm8gU8OhIDxub25hbWUubnVub0BnbWFpbC5jb20+Ow0KPiBQYWxsZXIsIEtpbSBTZWVy
IDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQgNS81XSBp
aW86IGRhYzogbHRjMjY2NDogQWRkIGRyaXZlciBmb3IgTFRDMjY2NCBhbmQgTFRDMjY3Mg0KPiAN
Cj4gTFRDMjY2NCA0IGNoYW5uZWwsIDEyLS8xNi1CaXQgVm9sdGFnZSBPdXRwdXQgU29mdFNwYW4g
REFDDQo+IExUQzI2NzIgNSBjaGFubmVsLCAxMi0vMTYtQml0IEN1cnJlbnQgT3V0cHV0IFNvZnRz
cGFuIERBQw0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBNaWNoYWVsIEhlbm5lcmljaCA8bWljaGFl
bC5oZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBIZW5uZXJp
Y2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtpbSBT
ZWVyIFBhbGxlciA8a2ltc2Vlci5wYWxsZXJAYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICBNQUlOVEFJ
TkVSUyAgICAgICAgICAgICAgIHwgICAxICsNCj4gIGRyaXZlcnMvaWlvL2RhYy9LY29uZmlnICAg
fCAgMTEgKw0KPiAgZHJpdmVycy9paW8vZGFjL01ha2VmaWxlICB8ICAgMSArDQo+ICBkcml2ZXJz
L2lpby9kYWMvbHRjMjY2NC5jIHwgNzU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDc2OCBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9paW8vZGFjL2x0YzI2NjQuYw0KPiANCj4gZGlmZiAtLWdpdCBh
L01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggZjRhNWI1YmM4Y2NjLi43YTAyZDlh
MTk2ZmIgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+
IEBAIC0xMzA4Miw2ICsxMzA4Miw3IEBAIFM6CVN1cHBvcnRlZA0KPiAgVzoJaHR0cHM6Ly9lei5h
bmFsb2cuY29tL2xpbnV4LXNvZnR3YXJlLWRyaXZlcnMNCj4gIEY6CURvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2FkaSxsdGMyNjY0LnlhbWwNCj4gIEY6CURvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2FkaSxsdGMyNjcyLnlhbWwNCj4gK0Y6
CWRyaXZlcnMvaWlvL2RhYy9sdGMyNjY0LmMNCj4gDQo+ICBMVEMyNjg4IElJTyBEQUMgRFJJVkVS
DQo+ICBNOglOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vZGFjL0tjb25maWcgYi9kcml2ZXJzL2lpby9kYWMvS2NvbmZpZyBpbmRleA0KPiBm
YjQ4ZGRkYmNjMjAuLjNhNzY5MWRiMzk5OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vZGFj
L0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9paW8vZGFjL0tjb25maWcNCj4gQEAgLTM3MSw2ICsz
NzEsMTcgQEAgY29uZmlnIExUQzI2MzINCj4gIAkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMg
YSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KPiAgCSAgbW9kdWxlIHdpbGwgYmUgY2FsbGVk
IGx0YzI2MzIuDQo+IA0KPiArY29uZmlnIExUQzI2NjQNCj4gKwl0cmlzdGF0ZSAiQW5hbG9nIERl
dmljZXMgTFRDMjY2NCBhbmQgTFRDMjY3MiBEQUMgU1BJIGRyaXZlciINCj4gKwlkZXBlbmRzIG9u
IFNQSQ0KPiArCXNlbGVjdCBSRUdNQVANCj4gKwloZWxwDQo+ICsJICBTYXkgeWVzIGhlcmUgdG8g
YnVpbGQgc3VwcG9ydCBmb3IgQW5hbG9nIERldmljZXMNCj4gKwkgIExUQzI2NjQgYW5kIExUQzI2
NzIgY29udmVydGVycyAoREFDKS4NCj4gKw0KPiArCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBh
cyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlDQo+ICsJICBtb2R1bGUgd2lsbCBiZSBjYWxs
ZWQgbHRjMjY2NC4NCj4gKw0KPiAgY29uZmlnIE02MjMzMg0KPiAgCXRyaXN0YXRlICJNaXRzdWJp
c2hpIE02MjMzMiBEQUMgZHJpdmVyIg0KPiAgCWRlcGVuZHMgb24gSTJDDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lpby9kYWMvTWFrZWZpbGUgYi9kcml2ZXJzL2lpby9kYWMvTWFrZWZpbGUgaW5k
ZXgNCj4gODQzMmE4MWExOWRjLi4yY2YxNDhmMTYzMDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aWlvL2RhYy9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL2lpby9kYWMvTWFrZWZpbGUNCj4gQEAg
LTM3LDYgKzM3LDcgQEAgb2JqLSQoQ09ORklHX0RTNDQyNCkgKz0gZHM0NDI0Lm8NCj4gIG9iai0k
KENPTkZJR19MUEMxOFhYX0RBQykgKz0gbHBjMTh4eF9kYWMubw0KPiAgb2JqLSQoQ09ORklHX0xU
QzE2NjApICs9IGx0YzE2NjAubw0KPiAgb2JqLSQoQ09ORklHX0xUQzI2MzIpICs9IGx0YzI2MzIu
bw0KPiArb2JqLSQoQ09ORklHX0xUQzI2NjQpICs9IGx0YzI2NjQubw0KPiAgb2JqLSQoQ09ORklH
X0xUQzI2ODgpICs9IGx0YzI2ODgubw0KPiAgb2JqLSQoQ09ORklHX002MjMzMikgKz0gbTYyMzMy
Lm8NCj4gIG9iai0kKENPTkZJR19NQVg1MTcpICs9IG1heDUxNy5vDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9kYWMvbHRjMjY2NC5jIGIvZHJpdmVycy9paW8vZGFjL2x0YzI2NjQuYyBuZXcg
ZmlsZSBtb2RlDQo+IDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwMDAuLjliNzNiOWM2YTdhNw0KPiAt
LS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2RhYy9sdGMyNjY0LmMNCj4gQEAgLTAs
MCArMSw3NTUgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICsv
Kg0KPiArICogTFRDMjY2NCA0IGNoYW5uZWwsIDEyLS8xNi1CaXQgVm9sdGFnZSBPdXRwdXQgU29m
dFNwYW4gREFDIGRyaXZlcg0KPiArICogTFRDMjY3MiA1IGNoYW5uZWwsIDEyLS8xNi1CaXQgQ3Vy
cmVudCBPdXRwdXQgU29mdHNwYW4gREFDIGRyaXZlcg0KPiArICoNCj4gKyAqIENvcHlyaWdodCAy
MDI0IEFuYWxvZyBEZXZpY2VzIEluYy4NCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgv
Yml0ZmllbGQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9jbGVhbnVwLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9tYXRoNjQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2RfZGV2aWNldGFibGUuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC9tdXRleC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+DQo+ICsjaW5jbHVk
ZSA8bGludXgvcmVnbWFwLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVy
Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc3BpL3NwaS5oPg0KPiArDQo+ICsjZGVmaW5lIExUQzI2
NjRfQ01EX1dSSVRFX04obikJCSgweDAwICsgKG4pKQ0KPiArI2RlZmluZSBMVEMyNjY0X0NNRF9V
UERBVEVfTihuKQkJKDB4MTAgKyAobikpDQo+ICsjZGVmaW5lIExUQzI2NjRfQ01EX1dSSVRFX05f
VVBEQVRFX0FMTAkweDIwDQo+ICsjZGVmaW5lIExUQzI2NjRfQ01EX1dSSVRFX05fVVBEQVRFX04o
bikJKDB4MzAgKyAobikpDQo+ICsjZGVmaW5lIExUQzI2NjRfQ01EX1BPV0VSX0RPV05fTihuKQko
MHg0MCArIChuKSkNCj4gKyNkZWZpbmUgTFRDMjY2NF9DTURfUE9XRVJfRE9XTl9BTEwJMHg1MA0K
PiArI2RlZmluZSBMVEMyNjY0X0NNRF9TUEFOX04obikJCSgweDYwICsgKG4pKQ0KPiArI2RlZmlu
ZSBMVEMyNjY0X0NNRF9DT05GSUcJCTB4NzANCj4gKyNkZWZpbmUgTFRDMjY2NF9DTURfTVVYCQkJ
MHhCMA0KPiArI2RlZmluZSBMVEMyNjY0X0NNRF9UT0dHTEVfU0VMCQkweEMwDQo+ICsjZGVmaW5l
IExUQzI2NjRfQ01EX0dMT0JBTF9UT0dHTEUJMHhEMA0KPiArI2RlZmluZSBMVEMyNjY0X0NNRF9O
T19PUEVSQVRJT04JMHhGMA0KPiArI2RlZmluZSBMVEMyNjY0X1JFRl9ESVNBQkxFCQkweDAwMDEN
Cj4gKyNkZWZpbmUgTFRDMjY2NF9NU1BBTl9TT0ZUU1BBTgkJNw0KPiArDQo+ICsjZGVmaW5lIExU
QzI2NzJfTUFYX0NIQU5ORUwJCTUNCj4gKyNkZWZpbmUgTFRDMjY3Ml9NQVhfU1BBTgkJNw0KPiAr
I2RlZmluZSBMVEMyNjcyX1NDQUxFX01VTFRJUExJRVIobikJKDUwICogQklUKG4pKQ0KPiArDQo+
ICtlbnVtIGx0YzI2NjRfaWRzIHsNCj4gKwlMVEMyNjY0LA0KPiArCUxUQzI2NzIsDQo+ICt9Ow0K
PiArDQo+ICtlbnVtIHsNCj4gKwlMVEMyNjY0X1NQQU5fUkFOR0VfMFZfNVYsDQo+ICsJTFRDMjY2
NF9TUEFOX1JBTkdFXzBWXzEwViwNCj4gKwlMVEMyNjY0X1NQQU5fUkFOR0VfTTVWXzVWLA0KPiAr
CUxUQzI2NjRfU1BBTl9SQU5HRV9NMTBWXzEwViwNCj4gKwlMVEMyNjY0X1NQQU5fUkFOR0VfTTJW
NV8yVjUsDQo+ICt9Ow0KPiArDQo+ICtlbnVtIHsNCj4gKwlMVEMyNjY0X0lOUFVUX0EsDQo+ICsJ
TFRDMjY2NF9JTlBVVF9CLA0KPiArCUxUQzI2NjRfSU5QVVRfQl9BVkFJTCwNCj4gKwlMVEMyNjY0
X1BPV0VSRE9XTiwNCj4gKwlMVEMyNjY0X1BPV0VSRE9XTl9NT0RFLA0KPiArCUxUQzI2NjRfVE9H
R0xFX0VOLA0KPiArCUxUQzI2NjRfR0xPQkFMX1RPR0dMRSwNCj4gK307DQo+ICsNCj4gK3N0YXRp
YyBjb25zdCB1MTYgbHRjMjY2NF9tc3Bhbl9sdXRbOF1bMl0gPSB7DQo+ICsJeyBMVEMyNjY0X1NQ
QU5fUkFOR0VfTTEwVl8xMFYsIDMyNzY4IH0sIC8qIE1QUzI9MCwgTVBTMT0wLA0KPiBNU1AwPTAg
KDApKi8NCj4gKwl7IExUQzI2NjRfU1BBTl9SQU5HRV9NNVZfNVYsIDMyNzY4IH0sIC8qIE1QUzI9
MCwgTVBTMT0wLA0KPiBNU1AwPTEgKDEpKi8NCj4gKwl7IExUQzI2NjRfU1BBTl9SQU5HRV9NMlY1
XzJWNSwgMzI3NjggfSwgLyogTVBTMj0wLCBNUFMxPTEsDQo+IE1TUDA9MCAoMikqLw0KPiArCXsg
TFRDMjY2NF9TUEFOX1JBTkdFXzBWXzEwViwgMCB9LCAvKiBNUFMyPTAsIE1QUzE9MSwgTVNQMD0x
DQo+ICgzKSovDQo+ICsJeyBMVEMyNjY0X1NQQU5fUkFOR0VfMFZfMTBWLCAzMjc2OCB9LCAvKiBN
UFMyPTEsIE1QUzE9MCwNCj4gTVNQMD0wICg0KSovDQo+ICsJeyBMVEMyNjY0X1NQQU5fUkFOR0Vf
MFZfNVYsIDAgfSwgLyogTVBTMj0xLCBNUFMxPTAsIE1TUDA9MQ0KPiAoNSkqLw0KPiArCXsgTFRD
MjY2NF9TUEFOX1JBTkdFXzBWXzVWLCAzMjc2OCB9LCAvKiBNUFMyPTEsIE1QUzE9MSwNCj4gTVNQ
MD0wICg2KSovDQo+ICsJeyBMVEMyNjY0X1NQQU5fUkFOR0VfMFZfNVYsIDAgfSAvKiBNUFMyPTEs
IE1QUzE9MSwgTVNQMD0xDQo+ICg3KSovIH07DQo+ICsNCj4gK3N0cnVjdCBsdGMyNjY0X3N0YXRl
Ow0KPiArDQo+ICtzdHJ1Y3QgbHRjMjY2NF9jaGlwX2luZm8gew0KPiArCWVudW0gbHRjMjY2NF9p
ZHMgaWQ7DQoNCkFwb2xvZ2llcyBmb3IgdGhlIG92ZXJzaWdodCwgZm9yZ290IHRvIHJlbW92ZSBi
b3RoIHRoZSBpZCBmaWVsZCBhbmQgdGhlDQpjb3JyZXNwb25kaW5nIGVudW0gaWQuDQoNCj4gKwlj
b25zdCBjaGFyICpuYW1lOw0KPiArCWludCAoKnNjYWxlX2dldCkoY29uc3Qgc3RydWN0IGx0YzI2
NjRfc3RhdGUgKnN0LCBpbnQgYyk7DQo+ICsJaW50ICgqb2Zmc2V0X2dldCkoY29uc3Qgc3RydWN0
IGx0YzI2NjRfc3RhdGUgKnN0LCBpbnQgYyk7DQo+ICsJaW50IG1lYXN1cmVtZW50X3R5cGU7DQo+
ICsJdW5zaWduZWQgaW50IG51bV9jaGFubmVsczsNCj4gKwljb25zdCBzdHJ1Y3QgaWlvX2NoYW5f
c3BlYyAqaWlvX2NoYW47DQo+ICsJY29uc3QgaW50ICgqc3Bhbl9oZWxwZXIpWzJdOw0KPiArCXVu
c2lnbmVkIGludCBudW1fc3BhbjsNCj4gKwl1bnNpZ25lZCBpbnQgaW50ZXJuYWxfdnJlZl9tdjsN
Cj4gKwlib29sIG1hbnVhbF9zcGFuX3N1cHBvcnQ7DQo+ICsJYm9vbCByZnNhZGpfc3VwcG9ydDsN
Cg0K

