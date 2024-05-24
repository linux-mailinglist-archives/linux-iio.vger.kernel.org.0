Return-Path: <linux-iio+bounces-5247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D72298CE0FF
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 08:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0411C20BF8
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 06:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1B128363;
	Fri, 24 May 2024 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FxZ/mbgV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637317578;
	Fri, 24 May 2024 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716532110; cv=fail; b=Jq2tGX4HMULZ8NEOmEJhr8y7/AOYy4BQqzAQqr8+6bg5TF2E9CY2TT0ZyMJeVzpsVkG8ZDAWQLYzW6x67jKiB89B7YmQe9b3KcNU+cwwdYIuReKBFvQoHWMwIpjXyFtiF9D0exnq2jsr1p0Hu/0IcU9qrYtjm9J07L9+Z/6a6Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716532110; c=relaxed/simple;
	bh=ar0HalOKcv8hrv4iZN5kdbqPVliXTswzH7GXUeNlbaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q5ZGjdV0bVOcnNxhYQSg0BP/xG6NnBZ5dsDtf3mGtII8vNfiRpHaCN432q+CXumM2F4DBD1luuANOmo3r4DGtG9k488DfFYmskIaCQz6yBxoGHAF/bDt9pY8h/nDEaoHIGrbqaoOv0tuHs6dPjafqPyHLJlBJNF2G+fvLV5ibQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FxZ/mbgV; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O5P522020210;
	Fri, 24 May 2024 02:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ar0Ha
	lOKcv8hrv4iZN5kdbqPVliXTswzH7GXUeNlbaA=; b=FxZ/mbgV/e4eYpAVQSd2f
	U/OXcEK0la+h+Vz/Ax6liMZPAE5naz7wDEBnWgQfbMeP3Ki7qj+8GCdwvO0dtbrc
	Obdp+LuL6qRpaIUcwfJ7OKwu2McnyTVd/sJPgERvhCFf6HmnjtxjAozNqxIvDwgN
	i7R4Q9eA3rUgpfNcVTIh64gO2v/R2TY7JIdWXd/y+JvlJv7/EcKAbnOr/7ofuO7K
	2Z0+m0lwRz+hX8Y9DladZR8Z2xZ7lTQk78hBT6SF39vpW9wL6qhNIFqCzIahmkkH
	Hg6jCxvK2d0O9a1evrBrtvsDtkLfkvoKkVcTvtV3Bkj8qH9r84U/tSQ8V4O9WAB8
	Q==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yaaaqaa3u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 02:28:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH1QnUgTTFmBYPl7H12w7OdpKfdyWjWb7OPIiJSD3oaMRY7PlrBzNWrTBu6yELKcnCjpw8SzDdjWfCL8BRDauH7y0K4JIYfqif3Lt1jXWDbv7TNVt04yVl1v6SnabWBmBbTc3PNUuYqpHeZ7HnjQKulHmQHphLwOcVRazo0xvWjPJ+RwP+ensxOAu3ml6MujO/d09En9EeszJLW6pFBtS+pqBHKHonLKdYrlq/0a26N6F6jRszDGCfpwdWYiHNlQkHa3OyOtnaYKtyX5LCTI7zJ/3wBxTfH9JGvsPzpTFFAgdhKKIgFQ18HCujSuBvG32z9u9zdf3Cbrmdnx3QfFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar0HalOKcv8hrv4iZN5kdbqPVliXTswzH7GXUeNlbaA=;
 b=fB8HDC+075i7YD16f6iTUlIM3in68Lnb6qnetYLyUoTDUwQXrwUpbE8HcDCYVNglrDMHkrxVdgq4zMjDnoVm4l8ABtmVUbBjVnu5smmAWzY2V6XRe4T/zhN3huIDNhZyG0j+8ZPWncr4u5CkmDvXObf30/06IxZo0rylVifb1qvKRpaGn3eO/X3lQJ+EOSnfkfV3HO3p5GRMmyww3JY/cs55pl3+YMZqc74qShkxuSwSYyqlpyBZ+xFITzX5gTgDQIKuKoLS7i39sJWvMIMNpvHXPcSVtGe750UAiCRKL0bbHv85LF+n9Apcf1hasjAxGmDOKBUQ5d4McLq3GrsKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by PH0PR03MB6265.namprd03.prod.outlook.com (2603:10b6:510:e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 24 May
 2024 06:28:04 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.7611.025; Fri, 24 May 2024
 06:28:03 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
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
Subject: RE: [PATCH v2 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Topic: [PATCH v2 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Index: AQHarNwB1BGhGf2xpUujcoBBr3SELbGl7NDg
Date: Fri, 24 May 2024 06:28:03 +0000
Message-ID: 
 <PH0PR03MB71411D6F23D918723B9A5DA7F9F52@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
 <20240523031909.19427-4-kimseer.paller@analog.com>
 <d1c3dd0c-9f24-4d0f-b15a-b727522a9662@kernel.org>
In-Reply-To: <d1c3dd0c-9f24-4d0f-b15a-b727522a9662@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFqTW1SaFl6YzBaUzB4T1RrMkxURXhaV1l0WVdGbU1TMHhORGMx?=
 =?utf-8?B?TldJek5XUmtZemhjWVcxbExYUmxjM1JjWXpKa1lXTTNOVEF0TVRrNU5pMHhN?=
 =?utf-8?B?V1ZtTFdGaFpqRXRNVFEzTlRWaU16VmtaR000WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STJNVFl5SWlCMFBTSXhNek0yTVRBd05UWTNPVE0yT1RRek9ESWlJR2c5SWpa?=
 =?utf-8?B?aFowOVNlbm8xVnpSQ1pHNVVURm93VFVOUFJtTTFXRnBFUlQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTNWdlNuVkdiell6WVVGYWEzUnRNQ3RZUjJsQlpH?=
 =?utf-8?B?MVRNbUpVTldOaFNVSXdSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQk0weG9VMlpuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|PH0PR03MB6265:EE_
x-ms-office365-filtering-correlation-id: c1a0e915-edbc-475c-faab-08dc7bbaaac6
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UURsSnZod3VROStsWXBBZkVlRGpVOTkrS0FYMDdwTnc4aUMzdDJ3Qi9GdGtU?=
 =?utf-8?B?TjNUNnd5VjdPQW03NlBvRHBNVmJYaWovdEp4ZWhHRnp3Y1BvV2tNRVkveFdn?=
 =?utf-8?B?aFdlUERvZ1dnQzg5QVNiSEJYeVEyQTJRTkc0dUJINWVkT3JVSnpwRE41b0F2?=
 =?utf-8?B?dlZ1ckpYaE1xaVdPTzFEMlF3ekdsR0R1bG84Mk9DUGtUZmNLQ3doQWhqdWJq?=
 =?utf-8?B?Yk5MRFMwRFRmdEppRG9GL0lQbWhkWWRhTU50djljRm93aS93a20vUTZVMkIy?=
 =?utf-8?B?elpyK1dLQjk0VmtxcnErc09QTmZyMk83dkRJM09JdFR4UCsvZ0h0OERLdDFD?=
 =?utf-8?B?MlNwQzRoTURNYWVBMnpZbWtjbDlmWjlRMU9nc29vaDMybVE0M1RYeFUxZk9i?=
 =?utf-8?B?cjZST0E5OWoweGY2S2RxcitLYjJqT2wyYUxNOEVWclIyc2VITkZPcmlGS0c4?=
 =?utf-8?B?L0laWnFubllLZkd1ejRLTCtmS1QyOEhvb3RSWDFDYzh4MkZBV3kvcGdLY3dC?=
 =?utf-8?B?OHJHWW9OcVhmeU5HdTcvbnV2VFAxTzAvb3RKYmh1bHpqMEo2WHpaOUZ3QjZT?=
 =?utf-8?B?cmsyS3M0bzJiUkdKTUtiL3dmZzJIZkE3aU5jNmxXQU9kMnI0WmpaMUZhczBC?=
 =?utf-8?B?SmFlN0M1YTUrRy83cGxGRUtnQXpUUWRHSXhyTStRaHNzajE4ZEdzZHNWM2Fo?=
 =?utf-8?B?RzlES0w5OWV0QkszTHo5VDFwRmM4TmJzalEwR1Izay9kWXF3TFpBRWh4cFRF?=
 =?utf-8?B?WmdRV1lEZlRmMkN5WVM2UW9CWEF2Zmwra1lVemtSRTYwdGdENFpSa3V3T3R4?=
 =?utf-8?B?ZlB3ZjBZL1Urcis2V0RMc2laNmEreDZEWGhiOW8rcCtSZGpkU251Q0YzSkpS?=
 =?utf-8?B?emJxR0VNTXQ5NHh4VWlkYTFrZ1JsZC9mQmNVU1ZWZGNJd3JZYWJyVjRQendW?=
 =?utf-8?B?OXY1Qk93Tis1dHhYaGJwcnF6S25uRkRvODB2RkNtaEtxclBRTXdPZWR6WS9X?=
 =?utf-8?B?OGNGTWhrakVnaXJwK2hDckpMcEFpOURIU2dKTUNNUWMwdjFQWW92b2NRYXQy?=
 =?utf-8?B?M3NtSVhpWUd5QmZQUTU5Q1VaVVg1Yzh4OWlsa2RtODh2Z3docTY5SjhISW1z?=
 =?utf-8?B?Sk9SU2hta3EzTm1iNmcyWlAyZUE0T2UzUFZtcFVocG9vdjZLT1dTd05FUGpH?=
 =?utf-8?B?cG91NHc0TFpodC9uSDYzNElpemtmRnVCNWlsMjBnV244VlkvYzFBMEVZV0dU?=
 =?utf-8?B?UzNHY01YOW5NYk5sRmxWQ3R0SUJJWnR1UFAzZnFzazh2bk1NTVNBVlNCNHoz?=
 =?utf-8?B?WnAxMGxWNjRrdjdaUnY2RktGYythU3ZGTWxlLzJZWUpqRUxiRjlJZzNxaW50?=
 =?utf-8?B?aTZKVDhSVlNGVUxXVXltUVVGaUtkQzFzK2RqU2hndzZLckhOZkNFS2tnYWpE?=
 =?utf-8?B?Y2JpWlhZL0RpdFVXMU1UZ1Z2REw2aU9yaUJUUUVwQVdZZ0ZjZDJJMFEvNk0y?=
 =?utf-8?B?WXBLOGV0TVdJUktOYWx1eTRhYzBzTmd2OFZVd3VWbmNCbGlta2R4QnpOYThF?=
 =?utf-8?B?US9Pa2tRRVlKMnc3N09NVnI1ekQ0Rno4Q1NpRUVMYzZIc253YzdOaEt0b0Ex?=
 =?utf-8?B?OUtoRmJydTlPMGx5K001UDZUSzJPbGoxT1hGSG1vNEl4enpSNWR5bzhONnNF?=
 =?utf-8?B?eXRQZXh5YXZjQ1RlWGZxQmpRTFlwQmtpOU0xMWl3YkJ4SkVVbTg0ZFRJallt?=
 =?utf-8?B?T0dJNUtmazVkekdURW5obEVFWEtWbUdrQ0NCQnE5aEl3S0JrZ01KSHhsWDd1?=
 =?utf-8?B?VENrTDd5c3Q2RHZiK1YwQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OGROMXd4UHBoK1BGVDVvNi9yRGppZnp6YVlGeTVWbHBvR25KSUdGVFIxOGVG?=
 =?utf-8?B?QituSGY4akRkODRXZXlGTmZCTUpiRU5KTjVYYWljUG9mbk5hRmE0eCt4VkI2?=
 =?utf-8?B?U2UwZU9leUJZSFlzQ1VOM09mM2MzdC94cTk2c0kyL3M5dmZsenRWb2FJYjZQ?=
 =?utf-8?B?SUQzK3h2RUFtVFlkYWpnWU5ZeGRPSlNQRS9lZml4Z1VKTVViS1VqYXhZYWFN?=
 =?utf-8?B?MGNBd0kza0hWSzl0VlBTeWVqN1ZTRWlFUVRvS1h4Qzk0MmtGV0dhWUNwMDhQ?=
 =?utf-8?B?ek44ajV0WHkzZTN4d3B0ZDByTG9pclB4QWtNZFdETjFpbFd3cFNYS3QvOEpu?=
 =?utf-8?B?L0E1WVVCOEtRTkRySzlqY2VmSDdOb1NYZGdWcTBUOFBDMDJqZlNEbm9LRjlv?=
 =?utf-8?B?a0hWa0VnOUNJanI4NXRkdDRZclVmdFJ4V1hOYzNxSFA3alFBSnNUSXYwM0hw?=
 =?utf-8?B?L0FEYjhrUlVLazdwREpQOUhKemJhdFQ5R284QVB0Z0k4ZFFJY09hNnZQUWM1?=
 =?utf-8?B?U2dpSXBOa3ZVNmhYVW8wcWNhWEMxY1VWRUpjaGswMFhFQmJGNi9SbnZ6TnZn?=
 =?utf-8?B?UHgxMHlRRmNRb0QwYVA2cjFXWVFNdjB2S00vQW5lbThQaHJxUWZHME12Qm5V?=
 =?utf-8?B?QkdiTGtjc0t0MWJ0dkJYenNEYkE2VXZYRWlsd3REb1JKN2xFVW1sb0RmT25T?=
 =?utf-8?B?ZmRFVUM2SFhNYTBCcEJUN3ZHVTZjbWF0VnFWeWhqR2Q0MW9uVktQMi9yeGw4?=
 =?utf-8?B?VEg0KzlnTWxRTUlHRkRRbTZIME00SzJCK2pMNHNMWit5YUFqckZjWnREV2FW?=
 =?utf-8?B?eC9KK2d5Vnp1dGpmejVKSVJRUWpsa2EzV3AvSnNlZWkrYzFHRFlwMndONDNX?=
 =?utf-8?B?NnZwU0Nndkc5RENVemtYOGE5dHE3RkQzdDBRbWc3TVJGQ0xYTjhESEJlOUtL?=
 =?utf-8?B?ZEZ5NTFYWm9sajFuZzc2SElHSUFnS3ZjYmRudkVrNFhreUtRQWJtTWk2MnB6?=
 =?utf-8?B?MTJ5QTdvcnBETkd5THhObmN4d3B0aUdUUHluR3htbEh6eEh4TFhLck5UQW4x?=
 =?utf-8?B?YVNYUWdpUzIxSFBha3g0bDVzTWx0QjBKZU8xSUkyUmk2U0g5QW1WYzhYcW41?=
 =?utf-8?B?azJQRTYzNzJKaFNmcFRYSTFERGpQZXZpTUlTcVhVWmh0RVRpUk5QckxzUlNi?=
 =?utf-8?B?UjFCUnNiLzlnWXpEODRIOExLWmFlUzU5ME55VTN6ME1EZzVuTDdiREo4RTB0?=
 =?utf-8?B?dk1sbkVlUU8yT3cwSTA4TGl3bmcyZDRDanFLUzZFMm9HSFVDazhKU2prY3Ix?=
 =?utf-8?B?MFRSTTJTK1JUbjFzTWxmTEZKcFR1bXlKSm1rbnIxK3B6bUVBODZhQThCelpu?=
 =?utf-8?B?d3h0d0NQa256eWQ2cDhUZVE5S3BJZ1lKMVkrcWxtSFZZeDZGTU1KSzIwRFVW?=
 =?utf-8?B?dmpvRjlPSnhJbDNOWEVoVU41Uis2QWRwcDJIM1NMaTZBNy9NQzFjMTBKbGtt?=
 =?utf-8?B?Wmx0MGxlZ0VBbEgxRndqbUFia3htcUdqV1c5OFhjRHZmQk02cDFiUnQrWG1y?=
 =?utf-8?B?eld0M2YrSHR0Y1VNRFlUR0tuamR2UnpSTHd5UXdwczQ1L1U4dlUyUEIyU1hj?=
 =?utf-8?B?OU1RRzlCUjFZSGtkVkdXaXltS2pKVzhSeE5UcXpNVTlwYldlNmY5aWFocEY3?=
 =?utf-8?B?RHhvVlhWV1VYYzRtbCtTcVU1VTUwdEtPV2RXQ2hMNVNtNFcwcDVaejlqKzZX?=
 =?utf-8?B?ZGkwdlN5VFFWNWFJK2UzTVhnVlF5ZHl1L280TDVXbHRWRVFWTndMMitQRVNr?=
 =?utf-8?B?VUkwb0VRK3puSXJUSkhxdFdpM21ZVDVTV3NDMCtJZCt6Y0krSDdHa0ZKTWVJ?=
 =?utf-8?B?OW5iTndZZWI3V3VBc0JmaTk5a0Fuai83Yno0TVVXWnlEL0JFQ2NBMWlOcnFw?=
 =?utf-8?B?OE5IYm9BV2Zlc2JBTlA1WDlTNWwySmU4Sngwemx5bnFOREk3cVJmd0VhNmx4?=
 =?utf-8?B?Mk5Qc0FUcXFaMGl6VUhPejJtaWRjbWN0bTEvakttQkZuaEFIYWppUW1aQTRi?=
 =?utf-8?B?dzN0ZFo0UldpK0tNMVhLN2Q0MFpzM0ppOE1EYWVuelMxaDF4ZFdJbXJKNWhE?=
 =?utf-8?Q?TkcTgvFyLC+PdnVsoxWpIiOze?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a0e915-edbc-475c-faab-08dc7bbaaac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 06:28:03.8561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2mbX2H9yo6QKnXCfQK7kN0c73evUU0cQfUeBo5iAEzJF8MML+xgbDEVfVGZ1BFa8ASYCrPeqhrsNFbHg5LUkD+71XEPrKf305iWTP01lQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6265
X-Proofpoint-GUID: x_5qlZeqpHqSFPLr_UoR803WjQDQ1gaM
X-Proofpoint-ORIG-GUID: x_5qlZeqpHqSFPLr_UoR803WjQDQ1gaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_01,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240044

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE1heSAyMywgMjAyNCAyOjQw
IFBNDQo+IFRvOiBQYWxsZXIsIEtpbSBTZWVyIDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29tPjsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPjsgRGF2aWQgTGVjaG5lcg0KPiA8ZGxlY2huZXJAYmF5bGlicmUuY29t
PjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBMaWFtDQo+IEdpcmR3b29k
IDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPjsN
Cj4gRGltaXRyaSBGZWRyYXUgPGRpbWEuZmVkcmF1QGdtYWlsLmNvbT47IEtyenlzenRvZiBLb3ps
b3dza2kNCj4gPGtyemsrZHRAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBIZW5uZXJpY2gsIE1p
Y2hhZWwNCj4gPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBOdW5vIFPDoSA8bm9uYW1l
Lm51bm9AZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvNV0gZHQtYmluZGlu
Z3M6IGlpbzogZGFjOiBBZGQgYWRpLGx0YzI2NjQueWFtbA0KPiANCj4gW0V4dGVybmFsXQ0KPiAN
Cj4gT24gMjMvMDUvMjAyNCAwNToxOSwgS2ltIFNlZXIgUGFsbGVyIHdyb3RlOg0KPiA+IEFkZCBk
b2N1bWVudGF0aW9uIGZvciBsdGMyNjY0Lg0KPiA+DQo+IA0KPiANCj4gPiArDQo+ID4gKyAgcmVm
LXN1cHBseToNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBSZWZlcmVuY2UgSW5w
dXQvT3V0cHV0LiBUaGUgdm9sdGFnZSBhdCB0aGUgUkVGIHBpbiBzZXRzIHRoZSBmdWxsLXNjYWxl
DQo+ID4gKyAgICAgIHJhbmdlIG9mIGFsbCBjaGFubmVscy4gSWYgbm90IHByb3ZpZGVkIHRoZSBp
bnRlcm5hbCByZWZlcmVuY2UgaXMgdXNlZCBhbmQNCj4gPiArICAgICAgYWxzbyBwcm92aWRlZCBv
biB0aGUgVlJFRiBwaW4uDQo+ID4gKw0KPiA+ICsgIGNsci1ncGlvczoNCj4gPiArICAgIGRlc2Ny
aXB0aW9uOg0KPiA+ICsgICAgICBBY3RpdmUtbG93IEFzeW5jaHJvbm91cyBDbGVhciBJbnB1dC4g
QSBsb2dpYyBsb3cgYXQgdGhpcyBsZXZlbC10cmlnZ2VyZWQNCj4gPiArICAgICAgaW5wdXQgY2xl
YXJzIHRoZSBwYXJ0IHRvIHRoZSByZXNldCBjb2RlIGFuZCByYW5nZSBkZXRlcm1pbmVkIGJ5IHRo
ZQ0KPiA+ICsgICAgICBoYXJkd2lyZWQgb3B0aW9uIGNob3NlbiB1c2luZyB0aGUgTVNQQU4gcGlu
cy4gVGhlIGNvbnRyb2wgcmVnaXN0ZXJzIGFyZQ0KPiA+ICsgICAgICBjbGVhcmVkIHRvIHplcm8u
DQo+IA0KPiBTbyB0aGlzIGlzIGEgcmVzZXQgZ3Bpbz8NCg0KWWVzLCB0aGlzIGlzIGEgcmVzZXQg
Z3Bpby4NCg0KS2ltDQoNCj4gDQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBh
ZGksbWFudWFsLXNwYW4tb3BlcmF0aW9uLWNvbmZpZzoNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0K
PiA+ICsgICAgICBUaGlzIHByb3BlcnR5IG11c3QgbWltaWMgdGhlIE1TUEFOIHBpbiBjb25maWd1
cmF0aW9ucy4gQnkgdHlpbmcgdGhlDQo+IE1TUEFODQo+ID4gKyAgICAgIHBpbnMgKE1TUDIsIE1T
UDEgYW5kIE1TUDApIHRvIEdORCBhbmQvb3IgVkNDLCBhbnkgb3V0cHV0IHJhbmdlIGNhbg0KPiBi
ZQ0KPiA+ICsgICAgICBoYXJkd2FyZS1jb25maWd1cmVkIHdpdGggZGlmZmVyZW50IG1pZC1zY2Fs
ZSBvciB6ZXJvLXNjYWxlIHJlc2V0IG9wdGlvbnMuDQo+ID4gKyAgICAgIFRoZSBoYXJkd2FyZSBj
b25maWd1cmF0aW9uIGlzIGxhdGNoZWQgZHVyaW5nIHBvd2VyIG9uIHJlc2V0IGZvciBwcm9wZXIN
Cj4gPiArICAgICAgb3BlcmF0aW9uLg0KPiA+ICsgICAgICAgIDAgLSBNUFMyPUdORCwgTVBTMT1H
TkQsIE1TUDA9R05EDQo+ID4gKyAgICAgICAgMSAtIE1QUzI9R05ELCBNUFMxPUdORCwgTVNQMD1W
Q0MNCj4gPiArICAgICAgICAyIC0gTVBTMj1HTkQsIE1QUzE9VkNDLCBNU1AwPUdORA0KPiA+ICsg
ICAgICAgIDMgLSBNUFMyPUdORCwgTVBTMT1WQ0MsIE1TUDA9VkNDDQo+ID4gKyAgICAgICAgNCAt
IE1QUzI9VkNDLCBNUFMxPUdORCwgTVNQMD1HTkQNCj4gPiArICAgICAgICA1IC0gTVBTMj1WQ0Ms
IE1QUzE9R05ELCBNU1AwPVZDQw0KPiA+ICsgICAgICAgIDYgLSBNUFMyPVZDQywgTVBTMT1WQ0Ms
IE1TUDA9R05EDQo+ID4gKyAgICAgICAgNyAtIE1QUzI9VkNDLCBNUFMxPVZDQywgTVNQMD1WQ0Mg
KGVuYWJsZXMgU29mdFNwYW4gZmVhdHVyZSkNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVz
LnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZW51bTogWzAsIDEsIDIsIDMsIDQs
IDUsIDYsIDddDQo+ID4gKyAgICBkZWZhdWx0OiA3DQo+ID4gKw0KPiA+ICsgIGlvLWNoYW5uZWxz
Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIEFuYWxvZyBtdWx0aXBsZXhlciBv
dXRwdXQuIFZPVVQwLVZPVVQzLCBNVVhJTjAtTVVYSU4zLCBSRUZMTywNCj4gUkVGLCBWKywgVi0s
DQo+IA0KPiBUaGF0J3Mgbm90IG91dHB1dCBidXQgaW5wdXQuDQo+IA0KPiA+ICsgICAgICBhbmQg
YSB0ZW1wZXJhdHVyZSBtb25pdG9yIG91dHB1dCBjYW4gYmUgaW50ZXJuYWxseSByb3V0ZWQgdG8g
dGhlDQo+IE1VWE9VVCBwaW4uDQo+IA0KPiBOZWVkcyBtYXhJdGVtcw0KPiANCj4gPiArDQo+ID4g
KyAgJyNhZGRyZXNzLWNlbGxzJzoNCj4gPiArICAgIGNvbnN0OiAxDQo+ID4gKw0KPiA+ICsgICcj
c2l6ZS1jZWxscyc6DQo+ID4gKyAgICBjb25zdDogMA0KPiA+ICsNCj4gDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

