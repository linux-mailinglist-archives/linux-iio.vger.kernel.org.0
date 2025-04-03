Return-Path: <linux-iio+bounces-17581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FF1A79C6F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 08:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95343B27A2
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 06:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A784224B0E;
	Thu,  3 Apr 2025 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OM+d9FmH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0AA7081A;
	Thu,  3 Apr 2025 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743663581; cv=fail; b=E7DxibcejhvKl4L0A1DhZyxiKmyGYrAVR9Qjq4/Ng3Ku0wgbNGLG26aJbyCrrC+1snvZ5ZfevbHkWAtHR7a58rJQ22SeL8NW8jef1MRoJ265AjCeDkXKOd6sMOKOiG5Um/UYxtWIpOlJntBT4K2ty8kwYIH/cs7APVRjHfk3Mu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743663581; c=relaxed/simple;
	bh=piDLey359jA6zw0nuawrswoFO3Y3y2Kz2IS3qI/oXRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QrzSTeji9/JyS9m87/5jI/JusDKmu73W7azCku5rhlL29gkO1kkmzFCfsBSJRa1DyI/RxXDnZVP+kbyRu1AFZh9p6bnepeKHFsQO9Lra2egnRalFmt4RBmTGcjJH0pDLOY4xfsvBh1+FI8tIQUiQWBYFa+2JMonkKzxJBRBo5hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OM+d9FmH; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5336mO7W023310;
	Thu, 3 Apr 2025 02:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=piDLe
	y359jA6zw0nuawrswoFO3Y3y2Kz2IS3qI/oXRg=; b=OM+d9FmHnTIRQoUsPYb75
	k+X1QuCRO0whsrSaiAmPF0y561yeSuh1nVAGJPwP6CeLPmj+f65I/jlQ6smUsceo
	3TNfdIzaCoZ2stwUAzK22SA5I1oQB2Na7UpBiHvklB0hMqm0nUM0qBRp2BIr6y/3
	OcwdnmK4J4ECtz9LiV6ShK//SlHSTAmEf27YM/UaJzRM9zBd8dKF9/xlYtgCaBd1
	89EHKVcW3aMFAtKW5Am48EPJzVpiZl/TPSNrUeqmy46972L19989m3OauiWh6yvs
	bJSAehMxkJ9swmIIdogBnv1VtO3yXKSMCLH0wcXlwQWExRSxo5cFXhDyWqLTixsp
	Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45rcrwm8he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 02:59:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHVr2Bj0L+gyl6Fphnj1kve51QdkQLtH1ugH7viKTp1jl+ktUC4rgZ8TKDL5GCmIyuX1Gtz6qirtoWTUzvvXCj3Y+B3NoZUkJ66Y1PmZrw2W8MEpGR5fAJRebgr93hrfU2BTpkYHd26J1WfncWliU9kydNJe5tZM2NsEBiSAA/HRHBDUMLbajwb5KdEKaNP/Nls7sQsvy6GN8ZhR13eHvnauAj1wt5gjh1BIWA8rz7SFTrrtedJHZMyn/J2f4uJtyhPN3BWFaZHiMkGr+WsmWLhK4siluhyKLDmy01wTBU+oU6Gw11gaf3UfjPDqjEirkDQhZ+RhATWbNwiH17VZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piDLey359jA6zw0nuawrswoFO3Y3y2Kz2IS3qI/oXRg=;
 b=CHFXQV6VLkusuU5UO0ohKjeNyMa5eOVXecaGS4yMhef2LXdxET+egvMKMEFgqW/RGZH7ymdESPmkHvBQoAEVQtKy3GH8X8t3kNqA5hXr6l4+ee7X5+HQRWZnswglGLEKKqWYSAsnTAn6UDE33lDjw+TgWUl6AID9YeraPD1ZnnSe/YqUxHIPwbeycx6ah9ioCpzGnu6XP7+g2wIs7EsaYvoH02UPaT9mrEHiXcOQ/jfjIiWg6e8xqYHODd8zXe4E2VtqLvCRV5YIal7jTaJeCPsakNfJYT4CV8idZQXI7aDdR/pCvG3jOKRpSjWX3RRojy/sMJnnB6rQdlNEXzhHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by LV8PR03MB8139.namprd03.prod.outlook.com (2603:10b6:408:295::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 06:59:23 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 06:59:23 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Thread-Topic: [PATCH v3 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Thread-Index: AQHbpFob7Hc6S0T3qEa/cXOHdHkI6bORfuaAgAAEA3A=
Date: Thu, 3 Apr 2025 06:59:23 +0000
Message-ID:
 <PH0PR03MB7141FEBAD45D612440B85698F9AE2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
 <20250403-togreg-v3-2-d4b06a4af5a9@analog.com>
 <20250403-ebony-coua-of-tornado-71d4ad@krzk-bin>
In-Reply-To: <20250403-ebony-coua-of-tornado-71d4ad@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|LV8PR03MB8139:EE_
x-ms-office365-filtering-correlation-id: 61516c7c-b445-4f7a-54a1-08dd727d10aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVNUS0tFQmowYVVJVDl3U0c2VmlHSWZWdGF4VnhwdDNidjRNRk03RFBSejkv?=
 =?utf-8?B?eFJ5SUh5RFBuc3ZvZ0VmM3NrK0hLSlFXOEJhZEpjY0phclFLNFhlZUtnRXZB?=
 =?utf-8?B?M041K3p2QjRWbGJtVzNKbXdWT0treDNhbDhoR1ZNZ002RVJ0bWJEQUswVEZI?=
 =?utf-8?B?NDRCaXVkeG8xeVlMdGh6N1VscnRkeUowOFRHL2ZOWVZESFlQZU51SGYyRDZD?=
 =?utf-8?B?V1psSC9nKzBpVWJGQU5PSGtZMUorYzF5L3dIRCtpUVMvSXdlcGFmb3orbmt4?=
 =?utf-8?B?Y0JZQ3ZHSVA1eFM3WDJ1aFhBUTBoU2l1U2FVZDAzMXJKRGkvcUswSmNITXd0?=
 =?utf-8?B?RjRYYkc3UTVvd2VQOGQ5Y3RzdjNHZUZzV081aWFad3U0ZlNrZ0svN2hlSDNF?=
 =?utf-8?B?SDNuaU9xR0F1UTc0S1g3KysrS2N2end2RFB4eVdXbkJlQzcxWXIyUFhHUUNY?=
 =?utf-8?B?SHZQRTVidEFQd1Uwa2cyK2NOWG15VlRxd1NBYTh5ZFlJcnhYeDdkTFh2bFlJ?=
 =?utf-8?B?Ujd2OHFYR3FoN01xNVpIKzU1Skdsd1R1emd4R1lWTEQ3NmxHeVMwTEFZOEFk?=
 =?utf-8?B?WHpYYUNxcVFqN2x0TkpBa0RzZkc3dkgzT1B4YnJXZ2s1YzFWMVE0b3NrdW9k?=
 =?utf-8?B?VlJPWk1PVVFiR3FHT0pVcHJ3a3BrN1BVMVBxdVhEUUt4ZTNZc1FVMGhzQXhj?=
 =?utf-8?B?MVFJNEZFOEw3dy9GZEp4emp5WkJCcmYyamVZZU5TWmtyQUZFVjUrMTdTNlRw?=
 =?utf-8?B?YkFCTVVSVi96U2lCSkJtTkJoTU5JNUg2MmgvaHljOWgzYTN6N1lhL0N0RURq?=
 =?utf-8?B?a3BvL0JWVkFyZTgzR253SExqOWI4aHNjN2o0d3dXanpxaDVYck90eVI1OUNW?=
 =?utf-8?B?amgraUVsTFIxQ1lqNEpVQ3k5VkNLSWpIUFNNbmxlalA1YjFKQUZyd3VqVnFq?=
 =?utf-8?B?MGpyV0M4VnpxdVUyZ3cwYjMxK1RSa1pKSFJtTC8rTS8yODkydFIrbysxdjhY?=
 =?utf-8?B?aHBSdm9rUThRUDRpWU5IOWYvRVBlNjBheWVvZnFobjQ2VTdNTTdHWkF2NXF3?=
 =?utf-8?B?OUZTMTBmaHlIVUhMUThvZmFLSFFCL21oaDBpM29TdEtSeGJvZmlQOW05bnNE?=
 =?utf-8?B?V3dXY2JUOHNDci96Vm5sc2NFN1prbjdTM3NyaXZEWHE2Y2QvWm40SzJkTDhH?=
 =?utf-8?B?N2VOZ3MrZmZSdUFyN3YrOHRGOWFFa1NwNWx1Q1dqMkpJSlZqRHh6UGhaRXcz?=
 =?utf-8?B?UVRTazBrUEZybWhxMGt1Uk5XMzNiTHFxT1gzZ2J6WlJRV0tEeE9rcC9KL0R6?=
 =?utf-8?B?dFB3c0dFbUdKamU2d2JESzBEbE9FTUp4U1krL04vVnR4a1VzVGlvVENscVdW?=
 =?utf-8?B?TnNiVjRFL0ZrYVMzQS9xTWV4S0VMS3hJVWlZQkdkUE5mNXhvVzQzbXVwM2dS?=
 =?utf-8?B?YXEzSzI2ZXcwbjZ2SW1MRHNqZHl2aVc3VjIxSnNkTHovWnJXU3NTVGd3WHdq?=
 =?utf-8?B?ekpzZW4wdWtsWFMzRng0TWRQNllCRFQzREFjUUlsc0JMZjVOYVZOVnV4Q1BC?=
 =?utf-8?B?b0dLTS9qOWUxM0o3VkdpOEM4WW82YWNOUGtvSDd2YktOUE1ZY1dHUDUvNU9r?=
 =?utf-8?B?OGpvWXp1VWRlOEFoSno1S003RXFmczhVU0EwMGtFazZGZnArcE5ma0E5TUtl?=
 =?utf-8?B?WXdnc09hN0w5Zm9rTTJyZXYzM1VxQXp1RnVHNHJiblR2dGV3Z3ZrcDF6ZEgr?=
 =?utf-8?B?VDJaZFBDbG5wUjliUGdpc2tqZUhQNm5rQUlmeGVqLytDZnd5Z3M3cndZa1RE?=
 =?utf-8?B?RDlKM2FSbHVhVnNoMnRidGMzbWhGREo1VVVHWWVBbmwvY1pscWFGbWNob0d5?=
 =?utf-8?B?TFRSZ3pQSWhZYUdIWFhPQlhUN0tSMFdrOU1oYlF0UlhHY1RzM3NyaTViUmRS?=
 =?utf-8?Q?hCKv5L1KasUXNN44mqeYylFNSjcGHQqt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEdCTUtQd1hhN1h6OFVJcmpHcnBRWEtUU1JXOExHcWFLSHdrNlk0amdXL2I5?=
 =?utf-8?B?Yi9QTkgwMUk1R2YvdEs0dHB3T1ZMOUR0RWRjZldheTl2Rk9sZWxkNUh2K2pW?=
 =?utf-8?B?bmkvQ3V1RU84RUtDL3RpNUIxS1V4STdKMWVRYmNSNVMvUzh6Qy9OSE1HZHFJ?=
 =?utf-8?B?MURoWkNWTHhwRUttK25VbnVKOUNvUHNvNDhWa3ZlRlBJRTUxUlR0aUI2UWRB?=
 =?utf-8?B?NitlbzQrMVBOb2t5QTBoVFFydEpkNXdwYloxWE1NdkkyeDNCclhNZjlKOHkv?=
 =?utf-8?B?bkNrcHpOWHkwbkJCTXRVTExZa1BkZmVwd3dEWUFDN2d6MWxaL3Ayb1RmOS9l?=
 =?utf-8?B?QXVCMCt5OHdjcFI3L3N1dFFxdGM0VEZ5SEVkZVpuRHVHKzJDdVJ6MGNtaitT?=
 =?utf-8?B?cFk4dHVuMnFmeW1Gb1FMbjdPYUFnWWpONE5wS0NvUWJHWVpTNGorMDdURG9F?=
 =?utf-8?B?U2hCL3c3NmpkVVZxWmhxa2U1WUVkak1IbDkwLzFmbEpCTUY0bU5CbVJGKy9D?=
 =?utf-8?B?Umk0WWtuakNuNVpsUG00S20wKzJ3cVFKQ1M4aFdLdU1TZncrKzJJVWV6YUw5?=
 =?utf-8?B?Q1lUTFd1eHpQMUljQm5weVZFaHNYV1l5OXZNTkttb2NIQmlnb2RPc1FiQmdp?=
 =?utf-8?B?d3FkcjRFd1RwKzdvcVZyYTBkZHJWd0g3VVBkUlRkdFlsSGlxS0huWURwZ1JM?=
 =?utf-8?B?d2VqMUlrZkZ0bStHb2dCb3VvZ08rVjVCYmxVaDllbU9GaXFRMmtHZzVZSnlq?=
 =?utf-8?B?VzFPNzA3UTdCemVNUWpGcFBtU1QwTGJvTkJ3eFVGaXJPVEhqOXpBaHgxMnJW?=
 =?utf-8?B?ZWdBcDhEL0J6QVpUa2QzRy9EaHR5SlVjZDJUdGxjb1hkWWdFZG5uNS9QdzYx?=
 =?utf-8?B?Q3RHZ2JTNEJXa1JoZE4rZ3NwbkJSdGoxU01kN0hJellsY1Z4NnZJWWtkOThV?=
 =?utf-8?B?UFZqZTJKOWpvQWJodDhiOUV4WUl0eFdLcDUwVEkvNFFQOW05VnVMNjNQczRo?=
 =?utf-8?B?V0FaYW1hU3N1czZNY21OdU5uSkV3TnlTNDQ5K0J5TVRuNmFhdHRrRXFwZkdL?=
 =?utf-8?B?Q3Qrd0E3eGJ5dE9YSldJU3VkeE55dHo3UVpybEdqYk5HT05OVXVsOFVLcUJr?=
 =?utf-8?B?ZytnSzNPUHJuczhyZ0hKMTd1WnVZazRuZkhGYTg1Y1RZRWhidE16Z1R3dnhB?=
 =?utf-8?B?RzFranRMYVlBc3FOUWtuUjRvZ1g1dk9MSk52WFdYSEpWZjk5aEtRSWFaZ0JT?=
 =?utf-8?B?eVpPZU40NlAvNW4vRDFLbzRNUUpPK3dZYUtiR3J0Uk9Zd20vTUZPeUcvU0Fs?=
 =?utf-8?B?WGEzOEFTQWlmem9yNjc1THB0MDVzQ1hvdHFFcTlnY2l4czAyRWFGdFd6WGF6?=
 =?utf-8?B?eXdMQ3h6UGhEYW9VeWJmWGlzZ21nMS82ZjBpcEdIck4vMnhiWlgzM0xVMjBN?=
 =?utf-8?B?VVJiS2hGQ1BZTkNsNTBtZmg0VmVvd2l6Y0kxU2tINFQvWWVNTENVM2JRbmlQ?=
 =?utf-8?B?T0x1aHkrekZWQTI1ak1za2RBWFYxYjROaEFiMWRLV0dsODBkSlZGRGNpTGo4?=
 =?utf-8?B?VnpabEdQdy9wTVNQeWJuS1lBcnBMdWpobGhDSUNjdmg5MkpOV1YwSFRJMGty?=
 =?utf-8?B?Wi9rVGVYb0FZZm1nUlVlNFMwZUo2TEpkcWNxVysvMWZQY3dZNlFqWno5L1B5?=
 =?utf-8?B?VndyUzVyN1huUWpOTzk4dWJKWDdjSXowOG9XT0owVDFEZkxXYVZrdDdmN3JU?=
 =?utf-8?B?SGxxQllyNEVuNkxXcCsrMDY3Z3V2cVVxOWNualVVcHlzYnlMOGloWEhjejJO?=
 =?utf-8?B?VWJFR2ovVHpoLy9PTG1wNnhLY1l4dU91VklVNGdwUVhIVnhGS0prME9tVitI?=
 =?utf-8?B?L1FSN0VpRXhBOEVJTWs0cmVCWlJqWDVKV0hMK3dLOE1kYjREK0lGSXFhY2N5?=
 =?utf-8?B?ZHJVNUhwbE10WnE4UDBlbzFLMUgwbVRxakc0NTMySGNDSFBRaXR6eXFraDFl?=
 =?utf-8?B?dkprVHFPZkpxRUNhTnR0bXFvaEN1UWFId2o1eDgxWnF2aGs2U3NyYlNtSkNm?=
 =?utf-8?B?OXRzMTZBa1lJNmhZN2g3dzhIclRSbWFzcHRUMjhndndhdG53cjcvUnIweUto?=
 =?utf-8?Q?QF/avLUln/rUqKmkzrfRrLR7W?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61516c7c-b445-4f7a-54a1-08dd727d10aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 06:59:23.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20ssNCAthk1i8M/S6Hx51qKffxroZBRrEyJPO+bPN/RAaE0ALStYuCTRX/Hajz49ZhTlEjbaOwPnJKsWCspyw3RXbeIZ93IP9Zm94STEMl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8139
X-Proofpoint-GUID: Q9nbd5CN9fUIWRqf7USkwk6BJwO-nJBx
X-Proofpoint-ORIG-GUID: Q9nbd5CN9fUIWRqf7USkwk6BJwO-nJBx
X-Authority-Analysis: v=2.4 cv=Aszu3P9P c=1 sm=1 tr=0 ts=67ee31ce cx=c_pps a=U0KzkmEawxegXmCr7eTojA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=iaTKId3JprsDQznB3a8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030033

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMywgMjAyNSAy
OjQ0IFBNDQo+IFRvOiBQYWxsZXIsIEtpbSBTZWVyIDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29t
Pg0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIg
Q2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNoLCBNaWNoYWVsIDxNaWNoYWVs
Lkhlbm5lcmljaEBhbmFsb2cuY29tPjsNCj4gUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47DQo+IENvbm9yIERvb2xl
eSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvM10gZHQtYmluZGluZ3M6IGlpbzogZGFjOiBBZGQg
YWRpLGFkMzUzMHIueWFtbA0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24gVGh1LCBBcHIgMDMs
IDIwMjUgYXQgMDE6MzM6NTZQTSArMDgwMCwgS2ltIFNlZXIgUGFsbGVyIHdyb3RlOg0KPiA+IERv
Y3VtZW50IHRoZSBBRDM1MzAvQUQzNTMwUiAoOC1jaGFubmVsKSBhbmQgQUQzNTMxL0FEMzUzMVIg
KDQtDQo+IGNoYW5uZWwpDQo+ID4gbG93LXBvd2VyLCAxNi1iaXQsIGJ1ZmZlcmVkIHZvbHRhZ2Ug
b3V0cHV0IERBQ3Mgd2l0aCBzb2Z0d2FyZS0NCj4gPiBwcm9ncmFtbWFibGUgZ2FpbiBjb250cm9s
cy4gVGhleSBwcm92aWRlIGZ1bGwtc2NhbGUgb3V0cHV0IHNwYW5zIG9mDQo+ID4gMi41ViBvciA1
ViBmb3IgcmVmZXJlbmNlIHZvbHRhZ2VzIG9mIDIuNVYuIFRoZXNlIGRldmljZXMgb3BlcmF0ZSBv
biBhDQo+ID4gc2luZ2xlIDIuN1YgdG8gNS41ViBzdXBwbHkgYW5kIGFyZSBndWFyYW50ZWVkIHRv
IGJlIG1vbm90b25pYyBieSBkZXNpZ24uDQo+ID4gVGhlICJSIiB2YXJpYW50cyBpbmNsdWRlIGEg
Mi41ViwgNXBwbS/CsEMgaW50ZXJuYWwgcmVmZXJlbmNlLCB3aGljaCBpcw0KPiA+IGRpc2FibGVk
IGJ5IGRlZmF1bHQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLaW0gU2VlciBQYWxsZXIgPGtp
bXNlZXIucGFsbGVyQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9kYWMvYWRpLGFkMzUzMHIueWFtbCAgIHwgOTkNCj4gKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICA3ICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTA2IGluc2VydGlvbnMoKykN
Cj4gDQo+IFlvdSBnb3QgcmVwb3J0IGFib3V0IGVycm9yIGluIHYyLCB3aGljaCB5b3UgZGlkIG5v
dCByZXNwb25kIHRvLg0KPiANCj4gWW91IHNlbmQgdjMuLi4gd2l0aCBzYW1lIGVycm9yLiBJIGRv
bid0IHVuZGVyc3RhbmQgdGhpcy4NCg0KSSdtIG5vdCBzdXJlLCBidXQgYmFzZWQgb24gdGhlIGlu
Zm9ybWF0aW9uIHByb3ZpZGVkLCB0aGUgZXJyb3JzIG1pZ2h0IGJlDQp1bnJlbGF0ZWQgdG8gdGhl
IGRyaXZlciwgb3IgSSBtaWdodCBoYXZlIG1pc3NlZCBzb21ldGhpbmcuDQoNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

