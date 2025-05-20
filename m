Return-Path: <linux-iio+bounces-19729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D99ABD515
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 12:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBBC8C01F8
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455F7270EB1;
	Tue, 20 May 2025 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gTBy9akY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C526E16E;
	Tue, 20 May 2025 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737128; cv=fail; b=hYIX2oJhYm5Cb0YuB1+J0Xn5Xr8qgYHiHPckkDb7iDL+w4cbbVj63yRrnTQqskfPo/VqJDrxhnb4iMVevZwSvBWMeFd5VQEaOyruxJXhnxS4ajid5MeqVKK5c0iqzhJJNjKmdSkwwmOk5ol20QmWXVRPSE/cR9sVUvtw2CD8GgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737128; c=relaxed/simple;
	bh=fczomMxPqzrgcxC1XW1TaySE07ZeaMNP6ckSkMSSanU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MeQN7fE9usCAYsEkK8y0LbEeRQwhj7Et2PtnJa9qpUlW98ENcVQVB+GRSE8E2puCcmplrn37/NYUuMnWhPd9vxfxhWhfajquLbDyj+C/SBEUVsR7BQ3HuLqCJh9k1m6M1nfz9M/oNjhriNFQATLRkuYcDYKdZtqERgCEF8J91rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gTBy9akY; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KA41kq004076;
	Tue, 20 May 2025 06:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fczom
	MxPqzrgcxC1XW1TaySE07ZeaMNP6ckSkMSSanU=; b=gTBy9akY6gmA4SCqE2Jeb
	pJzhCijUIB+P8wq7x7OIwq150rei9ILrUep0B0VQNPDclxdD9wQ7bmfqkE1pr5uv
	NMr/qIMNCcgOC3oF5ypsdAv3Cz0DSE8CD49exNHIJT4f3Yc9+U+yYarNYMTlrfuE
	WL3gOVUyeiVE4ZsQLpSwGtgl37pMoJLNi94a6cYtqqGANb373tTDdRJ/DlErbMXN
	Ey+TiYIT9pEZQYjTRp4U9xC7VSU6A3CwR2/GKFvRR39HKzfzINStV6rN8k6Qgmxc
	TRySDFL4r9krwxik89BY0W/F46Rc6UcIvDcSsV9hdyfIXhKWSgbPO+UbnZNIvGnM
	g==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46rkya95cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 06:32:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P09Ev1ax8Xg2x1a1K9YDcwQZUt4oXBzXJP7e6Gjs1256oqummqxfHYj8SC3zF7xz/99siAvuOykl2CPXyG47W69RIImxWU/6uAB6s7NQ0qzIdhfWTOOZjzQ/gvkuh0gnj5pPBhpjbqX868HfUOvmXtOSXiVG4983wFb5NsNvoXM/8NRX9ovSGgiSM0uoNf7UzN6lOxw2xRyNQrfa3tWQuE045yzMgT9r9lZNKx9e/DFkHdr1KsWqZI4zQ2EqBTYQ9yNf4jiDSKwnW6LQLOn/3rdA/8h/hOaRx+SEFrSQi/5zMWFvFylfYiyQy0iEBOimWgsu5Wrz7v6uXREfGax2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fczomMxPqzrgcxC1XW1TaySE07ZeaMNP6ckSkMSSanU=;
 b=WVbOyjA94rnHS0Odw+5TWcBiVFynyUc0VD52krwasFF9OnTLeRNTat9ElgukKJoRJo2tdrzuyHQpXsfMnui+uSbSP4vFtZgScbvyLQJJFPfX/fCCTs0p7zY5WkI0mNdNCX0fItag9oFdE/gPCGYzu2rjjlm+GDEawC/RGJhYwA7jBjyzfhwR72nYIO8LvNN1vUT1nrBszcmp+0fWVUmaMr3a/wvhlwfvqLoJNLZiO/v66HNsEIGnrL6J/P8vMzPo9DRmb0Gs0wQqW1PLS3LllW8ZWV6lzfwBEtbfGkj4Y4fvXGGP6+C1spZykUaMwgvbAq7zqGczp94s7+TK82s1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DM4PR03MB6143.namprd03.prod.outlook.com (2603:10b6:5:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 20 May
 2025 10:32:00 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%7]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 10:31:59 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        "jic23@kernel.org"
	<jic23@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 09/10] iio: adc: ad4080: add driver support
Thread-Topic: [PATCH v6 09/10] iio: adc: ad4080: add driver support
Thread-Index: AQHbxjxYGpWw+SSpoE26nlE4iuw7mrPaHy2AgAE44ZA=
Date: Tue, 20 May 2025 10:31:59 +0000
Message-ID:
 <CY4PR03MB3399602CDA166ECCA7D36ED19B9FA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
 <20250516082630.8236-10-antoniu.miclaus@analog.com>
 <9f5dcb2d-3fa9-4e39-9cf9-c5a23847224a@baylibre.com>
In-Reply-To: <9f5dcb2d-3fa9-4e39-9cf9-c5a23847224a@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFoTm1WaE9UY3pOQzB6TlRZMUxURXhaakF0WWpBM1l5MHhOR0Zp?=
 =?utf-8?B?WXpWbU0yUXpNalZjWVcxbExYUmxjM1JjWVRabFlUazNNell0TXpVMk5TMHhN?=
 =?utf-8?B?V1l3TFdJd04yTXRNVFJoWW1NMVpqTmtNekkxWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhORGt6SWlCMFBTSXhNek01TWpJeE1EY3hOamN4TkRjM01UZ2lJR2c5SWps?=
 =?utf-8?B?MWVVOUtPSHAxVERWTVIyUnZVVVIzWWs1eU0wcDVTbXN5YnowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVOW5RMEZCUkVkQ2ExWndZM051WWtGWFJYVmhjSEJOTWxWS2JG?=
 =?utf-8?B?bFROWEZ0YTNwYVVXMVZSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVJMFFXZEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmRsZGtVRGxuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSm9RVWRS?=
 =?utf-8?B?UVdGUlFtWkJTRTFCV2xGQ2RVRklUVUZoVVVJd1FVZHJRV1JuUW14QlJqaEJZ?=
 =?utf-8?B?MEZDZVVGSE9FRmhaMEpzUVVkTlFXUkJRbnBCUmpoQlpFRkNjRUZIVlVGalow?=
 =?utf-8?B?RjRRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQklp?=
 =?utf-8?B?OCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DM4PR03MB6143:EE_
x-ms-office365-filtering-correlation-id: 2d696859-abb9-488f-4ff0-08dd97898d59
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0plTzR0OGdYWWJpdk4yQjRIblN3SWpWVHNHckNHUkJnQVNBMDRLMlpLQW56?=
 =?utf-8?B?U0ZqTjR5V2ZzWGZkTEpMZFY3SEdqM2lQOFhXT05ZWEZDRG9OVFl2MVpmanI0?=
 =?utf-8?B?K1hOY0c3ZWhkSEZJVG9QbmFJLzlqQ2lld2lsR1l6MzlZM0ZtbHljVTQvZWJm?=
 =?utf-8?B?MFFOVE9JaFpvblhON1hlZ24yd3kyb3N3VFpnL2xIdDlNU0FsSUczZjlsdVNY?=
 =?utf-8?B?dXlyS2liL21qT3hxMzRxQVg4ZVgya1c1TEFkV0V4RGg1TGg5YS9yREFjNFJR?=
 =?utf-8?B?L3ZPSm1tN3VFczhEYkF4N1JVaGxoMWJaNHB0YWFIVjN4MUlkNFJyUGkvRUg5?=
 =?utf-8?B?RjBKNk1yQ1VCSm1YdnZpUUZLd1lIRll0dk04NHlHQmQ3WnlYU0pUeHZlZ1Zj?=
 =?utf-8?B?Y1hZNDlCaWhmd0kwV1FONmk0SDdvR1JCNFBaKzRmWHppRjNMci9EbWdweDRS?=
 =?utf-8?B?T0wrWGF4eFc3bWZXZVFpd2JtUjkvUXpQbkhZbzI0M0VKaVpZcGFiYXZJWlVO?=
 =?utf-8?B?c09jcEpxU0FsYlRpLzZYQUdCbUd2UTh3WVU0aEIxK21HSGtCWlN4VEtjT3Bt?=
 =?utf-8?B?QmJxY2Q4OEVnYS9lNWMwZnFzS3FKWXN4QjZzcGducHlvS1BhdXMxQnJQMXU2?=
 =?utf-8?B?Q2pVOWx3c0o2ckpOelhTNjYrUlp6OVhYTjd3aEw3TTg4dGRuS2VzZ1NBWXVQ?=
 =?utf-8?B?ZjhjVjhRV29WSXBqQldQdzNPWm42bDNIWTZJd0w5RVBGNjU4S1h1MkxIOGJM?=
 =?utf-8?B?RVZOVWN0Mjc2TlUrZWFLTGhqSjVrc1RPWmxhMEtXYVpNYmJJLzgwb3AzOFJN?=
 =?utf-8?B?elJYQllyV1FNNlpPT0pVOXNxa0dJZllNMWVDekVGUDh3Wm1WeFdrV2pORk45?=
 =?utf-8?B?clVscy9hQytWNHM2U0JSdWFzL1BOaXJ3OEJPQkwxdDFhOXRSekgrR0xnY0NW?=
 =?utf-8?B?dTVwSVZBajNacE9ZbE53TURBVU81K09pSWlPZUhmcXpEejNlc3NOQlk5ZUpP?=
 =?utf-8?B?Mm9TWnBWQVlNYUJpcHRseXJXbVROdWZDVk56T3Q2ay9Cdm5kT0x4U0lYdmhh?=
 =?utf-8?B?VzFJUTNWRXU3eTZPUW9jNDZ0N2xPOE5PeEpLcG4wUjBPRUd2aDBEVFA5a3Jh?=
 =?utf-8?B?N1E5Q0hieTNaSXFtS2lYQ3EvN1NlekVycHBUbnlWRWF6VTFMc0pHNmhQV095?=
 =?utf-8?B?Y01kVjg2K1pKOEkyWGpPK01GeEM4VThGWk9aL01CV1VDN3RoTUZjaDR1SFY0?=
 =?utf-8?B?V0l1MkZON0FNWDNrNnozeFBadmlBRkY1Rk9XL29hdlNqWTRwMkRLTTZLU0tH?=
 =?utf-8?B?V0dtSHFNWHBuOEZkdHAzVmg4Wk1lUVBXQ051akVHZ3YwWGlrWEc5NHgyc1Rt?=
 =?utf-8?B?ZHQ5SnAxVlltUWc0N3VMTU4xUjl0bXNINkJqMW51emtsYVpyT2JJbktickR5?=
 =?utf-8?B?T3JIWEIycWVUdWZqbE5MeWp2T2FUajZQSGd6M3RpT2U1amM1ZXZZNDVuSWVa?=
 =?utf-8?B?M25ldDM4UnhnbWNSR2NiTGhsNk4yQ0J6aWt6and1R1lqUjFITHNma1dCK1ZB?=
 =?utf-8?B?SzJndkM0bkJjR05RR0I4SmxhUXhzdXphc2hFbjA5dFNUQ21UZjNnYWFRUU9V?=
 =?utf-8?B?VUhrV0REcmdFVkJXR3RIaDNocTVzTVQ2VkVpUHlYNTMxZnF5bVpSWnlwck42?=
 =?utf-8?B?Vm5EcmZqcUlrRW1OamoyTldYamwyV2dGRmxOaXdYMFM3bGw2SVU3cEIrRUI2?=
 =?utf-8?B?bm1kdzd5WjYwckFIanBoWHAxMXh4bmF3eXFFaWRCWjk2WEJuZWN2ZEhiM1Fp?=
 =?utf-8?B?N2dwU05tLzNlRWdzMmIza1doMDhmM2tSVjJpQkhyUThyZ1Zuais4WmV3dXVR?=
 =?utf-8?B?QVJhNzBmeWxZeVpDVVB4MVZyMmlVclZtMmcwNXdvRmYwNjZacmlZWU4vVSt2?=
 =?utf-8?B?MGlWcWM5MFh3eG80Sk0zKzgvdzBIeGVGaDluMTREMG5zV0swckxPRkJBUng5?=
 =?utf-8?Q?4O+X/DZNBUvxbf9eO9oD6B9MqT8Ljw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGF4Mi9xZ3Z0eFRUakZMZ29zS3pvVnkyQ3VNY3h0MFMzR2pCanhXMVBVTDA0?=
 =?utf-8?B?ZTNBSFl0SnI1amYzanhrMGpKOWlKcTN3VjFmU2VsTEsvWWxmYWtxallGVWxz?=
 =?utf-8?B?ZTBZbUJmdkJINTJHNnZsZ1hGUDVGV2tRNStQZEhIdHA1SjdBc1hsa3Z0WW5U?=
 =?utf-8?B?aFFRcENialBIbVU4K1hHamFTSTVnUG1vVi92UW5BaW4rNmtZZWdSSGd0Vk5h?=
 =?utf-8?B?QU81N3l3RXhiOFQ4ME1leFY4eUh3Qkw3U2FOdWZCaW9JVWxnVE94L1BTUTUv?=
 =?utf-8?B?M2lFdndEYmJ6ZnhKMXBZcVlscEpkUTVNNExOaDQxWVNiUW9iMTVjaXcwS09z?=
 =?utf-8?B?TnlYRnAyalpETE5SSmZTMGNIMnZYV0U5aDgvTmlUalNHM3lDSVNaT3RrTmVK?=
 =?utf-8?B?dElneVFsU1p6WVM3QTdIb3k5NEl5ZlpuSHhXK1Q2b0drSGJUQndZSXp6VVlU?=
 =?utf-8?B?RzRhWi9Ia25ONXh5YUxWWTJaS3ZIdHlRTnpBME80eDJRV1JvbWZtcVl6YWx1?=
 =?utf-8?B?aVNrNTlhb1RncmViendubmVxVXhmMjliYzdNR1BVSnorYldnd296VkJ1K1ZF?=
 =?utf-8?B?QTNoTDVlTm9vMll5U3ZVaUZJYTlpYWZRVkFLRnp6ZlVZeG5QWlJrUGRqd3hp?=
 =?utf-8?B?VHdxUytvWk1ORytCTjRpdXNmbUx0SmMzaldUK0ozZldLNTRLSXoycjh6RlQv?=
 =?utf-8?B?bnp3T0NBOXcxUU9JWmsyejNzU3FJR213MnhOb3MxTFQ1ME81RFBRaWJYMk8y?=
 =?utf-8?B?QUlEMytPbm5haHZOY3pzY2xVSzBWWnUxc3VkTlErdHQ3eFF5ZXMzWXJLb0Nx?=
 =?utf-8?B?YkdSZnRyd3l0Vkd5cnNrdFNWYkVzNkZrMWtQSDRNYmhENHN0eGNmZndudXox?=
 =?utf-8?B?bEpIdzArcHF6TERHaTJ0VnVteVJ0M2l6MXZRSG9xbDFJKzB0cmZjS0VWVVNS?=
 =?utf-8?B?ejRxZUpuNFFmT3I3WTBkaHNMSnBSM1dYZmFXK1hqbElOQ3N6emRCVWtsRW5y?=
 =?utf-8?B?TFVnb0MvTlJVMHdENWJFVnAvN0IydThiYVFCL2UwTUN1cWtNaUpLL1ZRZ3ZO?=
 =?utf-8?B?dUJtNVBwZ2hNMk1FbkQ1NnNuT2xrdlJLZXZLVksyY3RXa0duTGZYMUhxa2hN?=
 =?utf-8?B?SEFjRzNNNEp3MUsremhITHoyRVhRL082VCtNMmYwMGhuUDlWWndoUVZFR0RZ?=
 =?utf-8?B?WXYySVNwVUh1aEVsb3hnTFhWaWRjVmZ3NHlZL2NWN1l2bUZZbmxGaEdxVnF3?=
 =?utf-8?B?NnQ4Ym5udTA0S1RJSUJOQVVSTlhKcVF1RjQrVHRsMWoyT2tKWVNUMDRJd3Vw?=
 =?utf-8?B?bzFXalpaOFpnOHVONDR1dHArcVdRT2hhVGlNNkFZZ2xNdm1SY3g3UjkyQkZz?=
 =?utf-8?B?bysrOUFvMzR4cHo4SFErT29jcEZEdytEVnRLVHVtZ3h0MjcxZy85dlM1L3ps?=
 =?utf-8?B?QjVHbUdQenNlMWRhUkdSTXRPZlFyMm5ncytGcE5nV29MSlhlUWczVzVpcGVk?=
 =?utf-8?B?elh0SEhURi9rVlZ5VVRzeWV1RzJYUWV0bGx6V3ZwMS9Ra0o3S1IvNzNjbU5P?=
 =?utf-8?B?WjhzMGk4dnpMNm1KTXpVVUNyeFpXZE5MNWkxbExtRlJ4cFZOOVdsaGg1T3U1?=
 =?utf-8?B?RUNDRE4wY1AwaWhZUUtPSEhhUWdzb2JZdW00M1B1dWVqS05TUVFXaEhvR2F6?=
 =?utf-8?B?SnhKcDd2V092eG1tcGFzTXpaLzVBYm9kK3hTb09rY28vb1VqeUZMWGo2c0JD?=
 =?utf-8?B?T3BNbi9rWjdhSkpNZDJVeXowNExucWZLTzdDODU5NGxKQkEwVjhuUnJPcDFW?=
 =?utf-8?B?Yng3Skd0VE1veGxHM21PbXBVUm1QWFRUaUk1K01ONWdGUGNhUlBCaGIxeGJr?=
 =?utf-8?B?UjlOcExONFdUMk5oUGlwUTFWYS9JdVRhaC9rQ1Z3L0RkNnM1cXh3VldLNFZs?=
 =?utf-8?B?Q2xPMDFOMllVU0tVRlRuZmprTUNDc1NCL3BsTzlsSWo4SVNsKzdrZWlpM2Ew?=
 =?utf-8?B?K29iTlIxWnlLQzRsbWZ2WXY2anFPcHVGb283aTZjUC9waDB3Tm9pL3JsaElR?=
 =?utf-8?B?eHl2aTA4ZEFwbnUyM2FuVjhEMnI3L1FweVpQUEswM3FhWUtMZkhUMi8xemFP?=
 =?utf-8?B?VkhWc1RTRVBGc3pjcDFuYWN5NDhHc3hUTUtWaE12dXVTcTYvZzBBSTFLNFhI?=
 =?utf-8?B?aFE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d696859-abb9-488f-4ff0-08dd97898d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 10:31:59.3712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihKTXZbU4Gc5rNzBW3Ur2hY9PetvW2jGsK4RXrXL0imqfRSG1oHKrNG4VlVBOKdgz1UjjULMGDRFe1zzcl6OP/4+Q67DORCwxGxAam1uDR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6143
X-Authority-Analysis: v=2.4 cv=Er3SrTcA c=1 sm=1 tr=0 ts=682c5a21 cx=c_pps
 a=p6j+uggflNHdUAyuNTtjyw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=LHw_hNEJ-8HdMN5ydh4A:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: FXcyJM2FZZz-a_7JpIlgkwnbt7PvldY3
X-Proofpoint-GUID: FXcyJM2FZZz-a_7JpIlgkwnbt7PvldY3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA4NiBTYWx0ZWRfXxC2SPUXNqXuS
 ct56i+LuFQyXNXiJwFDs9JkqEagkXTvRUObVBi14ey9uoW6L16ytKNqX1imK5cHUn0X1v4Cj7YG
 e+fuNhrF+CdDOVVMGxjF5ATYufXlzQj0ZgXwWaS+w7WxDHimTw4y2EIJvs3KFdsh6SC0iOnqfrZ
 zC4Vcqlhzhv0cyLkycU5IVGtpuHp1R789XJr1AzVR+XStKme3frXNAGXq0q3GUzz9Ztziu1FzGP
 K/Mmh8wvAAbc/5CckVmX/0cqIDi56X0Gd3eZzoI+hBwYl0oLqnFX7SMzfsvYCjm+NcEVwTsgD2W
 1UU6f0lPDC/uUf/sLNhxL/CbYOF+/q1xSsSCV+hrItU0T8UC9GsxMjfiVQuNfyOyePhchguixFE
 fLWkxSc7fxQhoIeSTSP3Rg3gu1r7B5DN16ZSvhApdz2H04FiVNDJKy/jYuC5esYShC0EvpYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200086

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDE5LCAyMDI1IDY6NTEgUE0N
Cj4gVG86IE1pY2xhdXMsIEFudG9uaXUgPEFudG9uaXUuTWljbGF1c0BhbmFsb2cuY29tPjsgamlj
MjNAa2VybmVsLm9yZzsNCj4gcm9iaEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBs
aW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDA5
LzEwXSBpaW86IGFkYzogYWQ0MDgwOiBhZGQgZHJpdmVyIHN1cHBvcnQNCj4gDQo+IFtFeHRlcm5h
bF0NCj4gDQo+IE9uIDUvMTYvMjUgMzoyNiBBTSwgQW50b25pdSBNaWNsYXVzIHdyb3RlOg0KPiA+
IEFkZCBzdXBwb3J0IGZvciBBRDQwODAgaGlnaC1zcGVlZCwgbG93IG5vaXNlLCBsb3cgZGlzdG9y
dGlvbiwNCj4gPiAyMC1iaXQsIEVhc3kgRHJpdmUsIHN1Y2Nlc3NpdmUgYXBwcm94aW1hdGlvbiBy
ZWdpc3RlciAoU0FSKQ0KPiA+IGFuYWxvZy10by1kaWdpdGFsIGNvbnZlcnRlciAoQURDKS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFudG9uaXUgTWljbGF1cyA8YW50b25pdS5taWNsYXVzQGFu
YWxvZy5jb20+DQo+ID4gLS0tDQo+IA0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgaW50IGFk
NDA4MF9wcm9wZXJ0aWVzX3BhcnNlKHN0cnVjdCBhZDQwODBfc3RhdGUgKnN0KQ0KPiA+ICt7DQo+
ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSByZWdtYXBfZ2V0X2RldmljZShzdC0+cmVnbWFwKTsN
Cj4gPiArDQo+ID4gKwlzdC0+bHZkc19jbnZfZW4gPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29s
KGRldiwgImFkaSxsdmRzLWNudi0NCj4gZW5hYmxlIik7DQo+ID4gKw0KPiA+ICsJc3QtPm51bV9s
YW5lcyA9IDE7DQo+ID4gKwlkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAiYWRpLG51bS1s
YW5lcyIsICZzdC0+bnVtX2xhbmVzKTsNCj4gPiArCWlmICghc3QtPm51bV9sYW5lcykNCj4gDQo+
IEVycm9yIGNoZWNraW5nIHNlZW1zIG5vdCBzdHJpY3QgZW5vdWdoLiBBbGxvd2VkIHZhbHVlcyBh
cmUgb25seSAxIGFuZCAyLg0KPiANClNpbmNlIHRoaXMgd2FzIGFscmVhZHkgYXBwbGllZCwgSSB3
aWxsIGFkZCBhIGZvbGxvdy11cCBwYXRjaCBvbiB0aGlzIHRvcGljLg0KPiA+ICsJCXJldHVybiBk
ZXZfZXJyX3Byb2JlKGRldiwgLUVJTlZBTCwNCj4gPiArCQkJCSAgICAgIkludmFsaWQgJ2FkaSxu
dW0tbGFuZXMnIHZhbHVlOiAldSIsDQo+ID4gKwkJCQkgICAgIHN0LT5udW1fbGFuZXMpOw0KPiA+
ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KDQo=

