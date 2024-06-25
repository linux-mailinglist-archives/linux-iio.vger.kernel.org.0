Return-Path: <linux-iio+bounces-6905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8524F916D4F
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A865D1C21227
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A3A16F0F6;
	Tue, 25 Jun 2024 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NOOiN7tc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB791CABB;
	Tue, 25 Jun 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330141; cv=fail; b=NUf6HzaMh144zKwJmHR+Mio/2woYUxl2xnDm3atxIs/nYFO1NbD6JI+uFx0jJIvH26ybUpGUnmghYq1tTwtWBIZBK/8x1ekAb2aBd1d5l9W/s+65yNi89KRRJM0WtNdbOkwjIse4RGZ/GtDDeEv5B0gSFNrzDvSdF3jAQY8GmyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330141; c=relaxed/simple;
	bh=awmx351aMtYCtIYQV7NnF8b8tPPdKp0Ap5eYGl5UflA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUEyW//e/apGcGeLHfzIdquMDgMTxtLCpuvtYC6lZMf3ZIKOMx4v6xyNAUaF2i7CfI31na1wPHEEEW1P0aPtADkXjCWpQ4Rh9zEEzrtNyhNfq0+Egt9sgWGFmyRWM/O28gqFMW3tz5/n/9yIbk8KVnwFHGZ7T1Tx1LSxo0i9ZcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NOOiN7tc; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PF63tB011744;
	Tue, 25 Jun 2024 11:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=awmx3
	51aMtYCtIYQV7NnF8b8tPPdKp0Ap5eYGl5UflA=; b=NOOiN7tcDd3HkSGsMI6Me
	OLdnLPceHKV3fyIjvWDmEgO9Taq/UIqVEkwaZfPLs1PjPTxCqZKLIYxXm7ZnN0Ui
	JuxEt5WYgE9yQULyppee6WXVZmedwIGMOZpHxd6HXmMs2j2HXG4t2q6TPMlUUK8M
	djTqvwl27dxRF1nBA5P6e0OHbTSYTtRkENem+tlEa/KP3WWzWW2LR1YJ06BN5LKD
	Gcp31efRN4S0esQINfBEayHud/KKaC2R07dPmGmuPoqWSt6n8tgozQu65s4t2q6c
	M9eJoBgfcRtsJQ5qyx+E/gvjI+nG10ON3elmu5va7KvMPKpD5SLQTTJEKjGUt35r
	A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yyum197da-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 11:41:51 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1JuFBODRzCaIKXIWJOpQZoOiWSs4Rim5ciT/k4wkIMzsyjokuBJuhgKnGZD+265ACo4UbkyQxJcuKD1tKGRWhLsAmDYF0oYHqpIXCvIH6NGeQQL8xC8qdV4q/eNi6pHg9QJN5JGwGyP0vjENTT2+7x9D00dtR36NHEoj7dLoOElPcs06hfLNCyGgQhl6D2UwcohRpArNCsmhHIfAQLZZ0d4jVEmKdek+Ng5ZSzX9H4OPy/0gbLgCmtLcy3nlDBeHAEVDAn+FAXgitMIv6O5ZAJ0N7ZlYM/OLB7xCW9WLsOgSWCwv3mGvTnaqvTwyYe2YyjALatuX6zTII7/oITlXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awmx351aMtYCtIYQV7NnF8b8tPPdKp0Ap5eYGl5UflA=;
 b=gbPc+YY4vVyK+XteDi9Gw+gnOEGK32EFXs626xSkiaeQoFtYskPk4TvzHaaHDVHKw5y5+GemR/h7C5xK/YoL98LcyYrG+DqzXOVxe96oMS9U8H9CQcbDrpBC+msO4eZnnSeCDp/i61BuvsTeKiHCHRuSRIFW274xwj0aZtaZhQDXl8i4KcVL4kiKdlwUXvbomSOj/DL5GEn4U0EE66dax/I81cQtjWdW4mmSoJ5LN2KVNCBDa7uosRXi4n9vMKoquT3fqUdgTMsNp2LIsfwPxF3ZoW61O2SfNxOgnBeNuWzcH8X2oE5qmRyyghI+l8vUftfTBm5QfYbNqLiUYMBCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by BY5PR03MB4936.namprd03.prod.outlook.com (2603:10b6:a03:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:41:49 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:41:48 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: David Lechner <dlechner@baylibre.com>, Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
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
Subject: RE: [PATCH v4 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Topic: [PATCH v4 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Index: AQHawhTjPN73V4dX9kiEjAqlsQvQP7HPX+QAgAepP/CAAB9/AIABeLuw
Date: Tue, 25 Jun 2024 15:41:48 +0000
Message-ID: 
 <PH0PR03MB71413895929382E4CA72FA9EF9D52@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
 <20240619064904.73832-4-kimseer.paller@analog.com>
 <20240619-left-usable-316cbe62468a@spud>
 <PH0PR03MB7141FB5DFBCA46C727FA9605F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
 <1cbb4395-cc9e-4e49-9188-c09aeefff956@baylibre.com>
In-Reply-To: <1cbb4395-cc9e-4e49-9188-c09aeefff956@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAyWkRJMFlUUXdPQzB6TXpBNUxURXhaV1l0WVdGbU5TMW1PR1Uw?=
 =?utf-8?B?TTJJek0yUTJObVZjWVcxbExYUmxjM1JjTm1ReU5HRTBNR0V0TXpNd09TMHhN?=
 =?utf-8?B?V1ZtTFdGaFpqVXRaamhsTkROaU16TmtOalpsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNakEyTkNJZ2REMGlNVE16TmpNNE1ETTNNRFl4TnpFek5Ea3pJaUJvUFNJ?=
 =?utf-8?B?elltVlphWEpHV1N0VVVUaHJjekpTTTJwVlUxZFpVekYxYmtFOUlpQnBaRDBp?=
 =?utf-8?B?SWlCaWJEMGlNQ0lnWW04OUlqRWlJR05wUFNKalFVRkJRVVZTU0ZVeFVsTlNW?=
 =?utf-8?B?VVpPUTJkVlFVRkZiME5CUVVKV1VHOXpka1p6Wm1GQlZtSnJSME5hVTFwNVNE?=
 =?utf-8?B?bFdkVkZaU214S2JrbG1NRVJCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|BY5PR03MB4936:EE_
x-ms-office365-filtering-correlation-id: bb87a625-17f8-49be-4646-08dc952d5382
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aXA2a2JSbElYc0ZQWEJ3d042ZEdSQzQ5WXVPMzZsUWVUbTZ1S2tTcHVSRURp?=
 =?utf-8?B?K084R1hjVXhIS285RFcxdnFUYWVlVDBMWFA2WCtZM0FmbWhqVkV3N3dTamlM?=
 =?utf-8?B?YnVnbEFBYlNKWDFyQjNOL0R6RURyWkE5ay85SXFyM2FsWldPWUVhM214Z0M5?=
 =?utf-8?B?LzhIaG52dzZYeW0yUjdhNGhrY20wU25OQTUrUmNyVjlaa0VrU1RoVW1rRmZE?=
 =?utf-8?B?MXZzYnV4U2NFVFpyUlZMNUx3UVk0eFlwWEwyT1kxWGI1MFhoSzQ3UmxoRDBG?=
 =?utf-8?B?R1JVd2tESUlQMmdGenNpSFJrLzAybzRuMDRMbEs5clVuNVJ2VFNMTWFNVUlC?=
 =?utf-8?B?WHFjRUlPZ1MzZ3BqUWY2SHhKcGlyYURMdHJ3dkNBOGdjbnU2dm4wSnh1UEo0?=
 =?utf-8?B?RVVJaFViQVRMZGRodDROeHRpOXZac3RRRFFqbVhUcm1iaDRjNkJzVnphK3hN?=
 =?utf-8?B?TkMzdDlIZ1AySVJBczR2L2Jra05SMFk2NjJXNnhhOHFFcjA0VjU2bFlKU25G?=
 =?utf-8?B?K3kwQlluanNYN21Gb3dMV3g1RVMrbEFCbmtlbEtPTHdBeG8zYXpVSEp0V1Fa?=
 =?utf-8?B?L08xaDQvb01nU3JCTHVlLzRsQW53TC9pcnlhYUZINVJKc08zaVdWcUlscGdL?=
 =?utf-8?B?a2RwblZJY1EyQ2tNK0RjV3hPbEsrQVU4NDRXbVNrVm9ZUCtpY3lRLzkxZXhY?=
 =?utf-8?B?QmVyTFhzM0kvVnVZYlR2dy8yOWpGakhSMWswaFROdGhpYUpRMlkrVG5FcU5s?=
 =?utf-8?B?Y2ZYOHQ4NkxQVTErckQ4OEhPdGVQbGFCeklLZEdBcElIdVJKYWcwR2VKTVZL?=
 =?utf-8?B?N3IwNDZBaEs1UENXbEJnK1FHQU1iVlZGajA3dndGYWlXZncycklPY0tPYk15?=
 =?utf-8?B?enZ6aHdhV0dTT05mTlVMZGpBcTNua2IvVEtXVDE1RDJkNHNFNjRHVzVPeTRh?=
 =?utf-8?B?ZXN4ZERNaFJhaU0wZjgvcVVPcHhhRSsramdHK0xaZ3FGd0tyOHIvc042UDBt?=
 =?utf-8?B?K1JPT1B6VlZXMHhVOTF5OStuVHYvM1dSUjFOaXpBOExLb3ZQMUFDdUV3Q3VG?=
 =?utf-8?B?S2cwem1haTQ2bGFvL0tBMkh3NTBQQnE2L1hnNUZKUjF2Q3J3bFo2SFBhdHZK?=
 =?utf-8?B?REJpOUdMZy9zdzg2TlpvZGVLblB4N3NpWDlhL0VEay9rb1BtYXZxUnVScFl4?=
 =?utf-8?B?YzdURGhycTVVa2V0eVFGM1l0S1BvSTFJUE9oRTFjRHo0N2lNS21LV1BGYnFt?=
 =?utf-8?B?VHhEa2FYRmtKc3RDckxnZG9pUXJMY1hpZzgxbUdlMmdpMXZpMW5Kd0VxVGdw?=
 =?utf-8?B?Zm1CcjZ4TUNONXpQa2FTSXhsZ3dGUjI0Q1psNU14M0V2K3J4dFhmZEpqRHdX?=
 =?utf-8?B?QU56ZTdVcHgvc3BZNGpma2krME45ZTU0ajRQcTZuMjQreVNrYTlsNmFPc2ZY?=
 =?utf-8?B?UndyTE5wTUo5cWJTT0syN0F1OGU5Y01pKzhMS25Bb013Y3dCMHlZU2pGYkRP?=
 =?utf-8?B?aUJ6WDNWeitmWDhVdTh3ZXFWWEtJUEVzVHFwaDR2NzNvVnlFakVSM0VpSWxo?=
 =?utf-8?B?aGIzdmwrYTk3djhhQ0NrU0cvTjJjdzFqRXl4RkF6SjFRMWtNMkdCc2lXTnJN?=
 =?utf-8?B?MVJ5VTRsK3FQdHJnZ2hjQWVtUUEwSngxbnJmazJDTnZkMW9GMHBob2FvVHF3?=
 =?utf-8?B?NlJTVGFmTklrVFY1bWM3YUZJUjJXTUpXRFhwVXFoQUo1UnloVlkxbzVWQ2ZX?=
 =?utf-8?B?Mm9wMm9DL1d5MjBZZExWWUVyUExGa21LL1JaeUlFYUxWQk5mZlBUT1ZvbE10?=
 =?utf-8?B?ODVCckFoZ3l3WXNPek44NUg1ZGhBMnlKUUFNTWVvMnlwcFI5aUtRaTBKSTN2?=
 =?utf-8?B?bzRrOFFqYkRlV1VFa1lScFczV3JZamZTZUx1eDh4T3Q4TlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UjFhQnNQRzVHRUo3YlVSUTY4cDlKWWl6Z29lQmsyYkZISTBObFYwTlY2Rksr?=
 =?utf-8?B?eU9ldkczaXBRWUowUmt1bTVrUnJOTjR1RHlWcmdsVnF1dThjd0tsOUJzenZG?=
 =?utf-8?B?VXlzdzBjWDZETTRVRzYyN1JvcmtlN29LWjVZWVJUZ1dRZ1ZDY3pia1lGdmxX?=
 =?utf-8?B?anVIazZhWEdaVEFVVWZlVW9Kd0tERnNEYnNpWHBKdjZPcC9Gb25nQjhxN1FS?=
 =?utf-8?B?UjJORzhrdlkvRlRUR05jMDRXQ3pEWnNWR29HOWJoWStIUlc5ZytUbys2VTFu?=
 =?utf-8?B?K2lNVHpzR2VrRUVNeU1qNnpXQklyNVlManhJOFZzVCtZYVlVdkl2UGR3MjFq?=
 =?utf-8?B?RldnRU5JNytYNkJCcmpiYUx6QXpjaCtsSFhieVBSeFJGMDFEaVVzZ3JiWDJW?=
 =?utf-8?B?dGZRbUtLUGRJM214b3RyVXhNOEpSc25UcEdGMWRIV1c2UmxqRUdrWE1Mek9m?=
 =?utf-8?B?dkt1eGt6cWFzR2JqWEdQK3k1Qkw1Y01kbks0aTJJUTlPSjlPeksrOGd0aWRm?=
 =?utf-8?B?TC9sTDYzS0tKbmMvdThvNG9QWjR4K0FlUXB1SENwd3dDWWNHdXFnSm1qUi9Y?=
 =?utf-8?B?ajZsRDRnYzE3MlVqd2JHK29VWkxRZmFDaGZrSlNxcFM5V24wRGxkbnBqdlFy?=
 =?utf-8?B?VC9qc3Q0L3cvV0JON29SMnZOUERwNlIxbWRtMVVmZnVxUlBTZHRTTS9OTGht?=
 =?utf-8?B?czNRQ0l1M1VnTzc1d2JCNnV4Ri9rSTNrb09sY1BwQTRvdHpYVkNOdFdONEZj?=
 =?utf-8?B?NEtrMllJcm52a3c4TW9OajBmVVhYNE0vbDhwbjNsN0NRRHZNaERyYXY2VFVV?=
 =?utf-8?B?VTM0eTQzekljdit4L2tZTThkRFdnbWZFUlZ6RldHd21XY2JCNDlwL05qZVda?=
 =?utf-8?B?UXZGZUZlS1FEM2l1YTdMb0VINDArdlc1Y2VVY29sS0tTbW9hbWx4Rk9yYlJz?=
 =?utf-8?B?akZYMy9KWURVdnZ2cllyZWF4UFRGVGp1MXlnR0h1Uk9PNXlsbFVrTm1yOHlO?=
 =?utf-8?B?eTN2cmVZN2NEMG4wa3ZaN21jbzcwS3RHOFdPcTE1VXR6b3hpaGdWMXFncnVs?=
 =?utf-8?B?YWM5VThUT1o5RUkyNVdKaytTRmZFVjZFWnpXODVNVzAvSG9qZldaUHBMMm5G?=
 =?utf-8?B?anNuV2FHZHEzTTQ3R1VZV2E5QzJuWjBRWXk2NE90TTViZzdoOUxsUW96c2ZC?=
 =?utf-8?B?TUEzem9GSXlBUlNkamJiQUpiZ3c2bVZNU0lxbVVNNHp3WjdkdGRpUW92QVhF?=
 =?utf-8?B?aEtWWGpGbFVrWFZ3R05WUWxLWjlMQ0VzSm9jRmhtNUpDZU9FVi9LdkNicUdR?=
 =?utf-8?B?NmhzU0tYL1E1K3ZFSHIvaXdMeHhESzloVjFWd2ZyYWxEclZpeFhGczVYVnRy?=
 =?utf-8?B?WGJqcXFSZDBueHdoZ2pKM1hVOWxXVmpBNlJVS2xaN3lSY1VkYUkzNENxeTNQ?=
 =?utf-8?B?UmVWdzY2U3p3YTdQbGxTTTcwaWYrWmhHK2oveFFOR3lHVk9iaUcraTNwRFZQ?=
 =?utf-8?B?SE8vOFN1cXVDVCtKbE1mMkx3K3ZTcU5NWXo3ck82UFdlVkdVU2JnUXBnd2lo?=
 =?utf-8?B?WHN6WGxKTWdDVDRGVUl5OUFpYmd4M251eEk1RGRBck9YSDZyTXpwTUlTU3ZW?=
 =?utf-8?B?VHVLUmJndktTaXBnazgzRmJQSDVwZ2FzemxoRnJPNGUwM3BmUmYvMG1OUDBP?=
 =?utf-8?B?aitxYnk2VlRyekl1d05peTFjLzFObHRqZmZQSzQveEl4UjVCTWZqaTgvUCtz?=
 =?utf-8?B?L2UrbW9NOW9CSDN4bFBGb3FUeDc5RzJ2OEd5YU44bmRsYlhUekc1enplUmtN?=
 =?utf-8?B?MUphSlN6U3NvUG9zblF3Q0c3WjAzYjBRcVZMK1h5SG5OWjRGRktDQjd0NzBv?=
 =?utf-8?B?ZEhnWXBqdlZESm52K3lKRDQyR0kwbW1jS0NrcjBKalU4V3VhdWV2ZTNDOEY0?=
 =?utf-8?B?cDFGdUxLNGlsYzhzQzhuQ29DTmNkN3VaN3M0MmlCMHNyMWsvakY0QU53c1d0?=
 =?utf-8?B?TUg4UmRjSFFvWElKejVZMmJxbTdmMUNZWWNVNTF3YVZ4SVFoZnpSdEx4M3NB?=
 =?utf-8?B?cmRIMFJBNlYxZGprZ0kvMnlWdEs4SjZ2YnlqeTAvbnJNVk1sM0VTcnYvVWll?=
 =?utf-8?Q?iQ6+8RkJuschQXVwq2V57ZfgH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb87a625-17f8-49be-4646-08dc952d5382
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 15:41:48.6551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ao434ydg3sJ/g5Mo75mAJoS0c/XKkN+ZLRJXX6GGTq6qFOXVrfWhaNwiWmjEoVhylOtG5dJsRfvtcTXjKO7joo4jQXsUuxdgn2DS37aj8Ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4936
X-Proofpoint-GUID: 9zUmSjX9FhT4VdDuGoByYpzs0cA5JHkD
X-Proofpoint-ORIG-GUID: 9zUmSjX9FhT4VdDuGoByYpzs0cA5JHkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_10,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406250116

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDI1LCAyMDI0IDEy
OjQ5IEFNDQo+IFRvOiBQYWxsZXIsIEtpbSBTZWVyIDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29t
PjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vckBrZXJuZWwub3JnPg0KPiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBM
YXJzLVBldGVyDQo+IENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IExpYW0gR2lyZHdvb2QgPGxn
aXJkd29vZEBnbWFpbC5jb20+OyBNYXJrDQo+IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBE
aW1pdHJpIEZlZHJhdSA8ZGltYS5mZWRyYXVAZ21haWwuY29tPjsNCj4gS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
DQo+IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IEhlbm5lcmljaCwgTWljaGFl
bA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IE51bm8gU8OhIDxub25hbWUubnVu
b0BnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy81XSBkdC1iaW5kaW5nczog
aWlvOiBkYWM6IEFkZCBhZGksbHRjMjY2NC55YW1sDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiAN
Cj4gPj4+ICsgIGFkaSxtYW51YWwtc3Bhbi1vcGVyYXRpb24tY29uZmlnOg0KPiA+Pj4gKyAgICBk
ZXNjcmlwdGlvbjoNCj4gPj4+ICsgICAgICBUaGlzIHByb3BlcnR5IG11c3QgbWltaWMgdGhlIE1T
UEFOIHBpbiBjb25maWd1cmF0aW9ucy4gQnkgdHlpbmcgdGhlDQo+ID4+IE1TUEFODQo+ID4+PiAr
ICAgICAgcGlucyAoTVNQMiwgTVNQMSBhbmQgTVNQMCkgdG8gR05EIGFuZC9vciBWQ0MsIGFueSBv
dXRwdXQgcmFuZ2UNCj4gY2FuDQo+ID4+IGJlDQo+ID4+PiArICAgICAgaGFyZHdhcmUtY29uZmln
dXJlZCB3aXRoIGRpZmZlcmVudCBtaWQtc2NhbGUgb3IgemVyby1zY2FsZSByZXNldA0KPiBvcHRp
b25zLg0KPiA+Pj4gKyAgICAgIFRoZSBoYXJkd2FyZSBjb25maWd1cmF0aW9uIGlzIGxhdGNoZWQg
ZHVyaW5nIHBvd2VyIG9uIHJlc2V0IGZvcg0KPiBwcm9wZXINCj4gPj4+ICsgICAgICBvcGVyYXRp
b24uDQo+ID4+PiArICAgICAgICAwIC0gTVBTMj1HTkQsIE1QUzE9R05ELCBNU1AwPUdORCAoKy0x
MFYsIHJlc2V0IHRvIDBWKQ0KPiA+Pj4gKyAgICAgICAgMSAtIE1QUzI9R05ELCBNUFMxPUdORCwg
TVNQMD1WQ0MgKCstNVYsIHJlc2V0IHRvIDBWKQ0KPiA+Pj4gKyAgICAgICAgMiAtIE1QUzI9R05E
LCBNUFMxPVZDQywgTVNQMD1HTkQgKCstMi41ViwgcmVzZXQgdG8gMFYpDQo+ID4+PiArICAgICAg
ICAzIC0gTVBTMj1HTkQsIE1QUzE9VkNDLCBNU1AwPVZDQyAoMFYgdG8gMTAsIHJlc2V0IHRvIDBW
KQ0KPiA+Pj4gKyAgICAgICAgNCAtIE1QUzI9VkNDLCBNUFMxPUdORCwgTVNQMD1HTkQgKDBWIHRv
IDEwViwgcmVzZXQgdG8gNVYpDQo+ID4+PiArICAgICAgICA1IC0gTVBTMj1WQ0MsIE1QUzE9R05E
LCBNU1AwPVZDQyAoMFYgdG8gNVYsIHJlc2V0IHRvIDBWKQ0KPiA+Pj4gKyAgICAgICAgNiAtIE1Q
UzI9VkNDLCBNUFMxPVZDQywgTVNQMD1HTkQgKDBWIHRvIDVWLCByZXNldCB0byAyLjVWKQ0KPiA+
Pj4gKyAgICAgICAgNyAtIE1QUzI9VkNDLCBNUFMxPVZDQywgTVNQMD1WQ0MgKDBWIHRvIDVWLCBy
ZXNldCB0byAwViwgZW5hYmxlcw0KPiA+PiBTb2Z0U3BhbikNCj4gPj4+ICsgICAgJHJlZjogL3Nj
aGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4+PiArICAgIGVudW06IFsw
LCAxLCAyLCAzLCA0LCA1LCA2LCA3XQ0KPiA+Pg0KPiA+PiBDYW4geW91IGV4cGxhaW4gd2h5IHRo
aXMgcHJvcGVydHkgaXMgcmVxdWlyZWQsIHdoZW4gYmVsb3cgdGhlcmUncyBvbmUgdGhhdA0KPiBz
ZXRzDQo+ID4+IHRoZSByYW5nZXMgaW4gbWljcm92b2x0cz8gSXNuJ3QgdGhlIG9ubHkgbmV3IGlu
Zm9ybWF0aW9uIHRoYXQgdGhpcyBwcm92aWRlcw0KPiB0aGUNCj4gPj4gcmVzZXQgdmFsdWVzIChp
biBhIGZldyBjYXNlcyB0aGF0IGl0IGlzIG5vdCAwKS4NCj4gPj4gV2hhdCBhbSBJIG1pc3Npbmc/
DQo+ID4NCj4gPiBGb3Igc3BlY2lmeWluZyBvdXRwdXQgcmFuZ2UgYW5kIHJlc2V0IG9wdGlvbnMg
d2l0aG91dCByZWx5aW5nIG9uIHNvZnR3YXJlDQo+IGluaXRpYWxpemF0aW9uDQo+ID4gcm91dGlu
ZXMsIGFuZCBhbHNvIGZvciBlbmFibGluZyB0aGUgc29mdHNwYW4gZmVhdHVyZSwgSSB0aGluayB0
aGlzIHByb3BlcnR5DQo+IHNlZW1zIGVzc2VudGlhbC4NCj4gDQo+IFNvIGluIG90aGVyIHdvcmRz
LCB0aGlzIGRlc2NyaWJlcyBob3cgdGhlIE1TUCBwaW5zIGFyZSBoYXJkd2lyZWQgYW5kDQo+IHRo
ZSBwZXItY2hhbm5lbCBhZGksb3V0cHV0LXJhbmdlLW1pY3Jvdm9sdCBpcyBvbmx5IHBlcm1pc3Np
YmxlIGlmDQo+IA0KPiAJIGFkaSxtYW51YWwtc3Bhbi1vcGVyYXRpb24tY29uZmlnID0gPDc+Ow0K
PiANCj4gKG9yIG9taXR0ZWQgc2luY2UgNyBpcyB0aGUgZGVmYXVsdCkNCj4gDQo+IGJlY2F1c2Ug
aW4gdGhhdCBjYXNlIGVhY2ggaW5kaXZpZHVhbCBwaW4gY291bGQgaGF2ZSBhIGRpZmZlcmVudA0K
PiByZXF1aXJlZCByYW5nZSBiYXNlZCBvbiB3aGF0IGlzIHdpcmUgdXAgdG8gaXQ/DQo+IA0KPiBC
dXQgaWYgYWRpLG1hbnVhbC1zcGFuLW9wZXJhdGlvbi1jb25maWcgaXMgYW55dGhpbmcgb3RoZXIg
dGhhbiA3LA0KPiB0aGVuIGFkaSxvdXRwdXQtcmFuZ2UtbWljcm92b2x0IHNob3VsZCBiZSBub3Qg
YWxsb3dlZCBzaW5jZSBhbGwNCj4gY2hhbm5lbHMgd2lsbCBoYXZlIHRoZSBzYW1lIHJhbmdlIGJl
Y2F1c2Ugb2YgdGhlIGhhcmQtd2lyZWQgcGlucy4NCj4gDQo+IGNvcnJlY3Q/DQoNClRoYXQncyBj
b3JyZWN0Lg0KIA0KPiBUaGUgZGVzY3JpcHRpb24gY291bGQgcHJvYmFibHkganVzdCBiZSBzaW1w
bGlmaWVkIHRvIHNheSB0aGF0DQo+IHRoaXMgZGVzY3JpYmVzIGhvdyB0aGUgMyBwaW5zIGFyZSBo
YXJkd2lyZWQgYW5kIHRvIHNlZSBUYWJsZSA0DQo+IGluIHRoZSBkYXRhc2hlZXQgdG8gdW5kZXJz
dGFuZCB0aGUgYWN0dWFsIGltcGxpY2F0aW9ucyByYXRoZXINCj4gdGhhbiByZXByb2R1Y2luZyB0
aGF0IHRhYmxlIGhlcmUuDQo+IA0KPiBCdXQgSSBkbyBhZ3JlZSB0aGF0IHdlIG5lZWQgYm90aCBw
cm9wZXJ0aWVzLiBJIHRoaW5rIHdlIGFyZQ0KPiBqdXN0IG1pc3Npbmc6DQo+IA0KPiAtIGlmOg0K
PiAgICAgcHJvcGVydGllczoNCj4gICAgICAgYWRpLG1hbnVhbC1zcGFuLW9wZXJhdGlvbi1jb25m
aWc6DQo+ICAgICAgICAgY29uc3Q6IDcNCj4gICB0aGVuOg0KPiAgICAgcGF0dGVyblByb3BlcnRp
ZXM6DQo+ICAgICAgICJeY2hhbm5lbEBbMC0zXSQiOg0KPiAgICAgICAgYWRpLG91dHB1dC1yYW5n
ZS1taWNyb3ZvbHQ6IGZhbHNlDQo+IA0KPiAobm90IHRlc3RlZCAtIG1heSBuZWVkIHR3byBpZnMs
IG9uZSB3aXRoDQo+IA0KPiAtIGlmOg0KPiAgICAgcmVxdWlyZWQ6DQo+ICAgICAgIC0gYWRpLG1h
bnVhbC1zcGFuLW9wZXJhdGlvbi1jb25maWcNCj4gICAgIHByb3BlcnRpZXM6DQo+ICAgICAgIGFk
aSxtYW51YWwtc3Bhbi1vcGVyYXRpb24tY29uZmlnOg0KPiAgICAgICAgIGNvbnN0OiA3DQo+IA0K
PiBhbmQgb25lIHdpdGgNCj4gDQo+IC0gaWY6DQo+ICAgICBub3Q6DQo+ICAgICAgIHJlcXVpcmVk
Og0KPiAgICAgICAgIC0gYWRpLG1hbnVhbC1zcGFuLW9wZXJhdGlvbi1jb25maWcNCj4gDQo+IHRv
IG1ha2UgaXQgd29yayBwcm9wZXJseSkNCj4gDQo+ID4NCj4gPj4+ICsgICAgZGVmYXVsdDogNw0K
PiA+Pj4gKw0KPiA+Pj4gKyAgaW8tY2hhbm5lbHM6DQo+ID4+PiArICAgIGRlc2NyaXB0aW9uOg0K
PiA+Pj4gKyAgICAgIEFEQyBjaGFubmVsIHRvIG1vbml0b3Igdm9sdGFnZXMgYW5kIHRlbXBlcmF0
dXJlIGF0IHRoZSBNVVhPVVQNCj4gcGluLg0KPiA+Pj4gKyAgICBtYXhJdGVtczogMQ0KPiA+Pj4g
Kw0KPiA+Pj4gKyAgJyNhZGRyZXNzLWNlbGxzJzoNCj4gPj4+ICsgICAgY29uc3Q6IDENCj4gPj4+
ICsNCj4gPj4+ICsgICcjc2l6ZS1jZWxscyc6DQo+ID4+PiArICAgIGNvbnN0OiAwDQo+ID4+PiAr
DQo+ID4+PiArcGF0dGVyblByb3BlcnRpZXM6DQo+ID4+PiArICAiXmNoYW5uZWxAWzAtM10kIjoN
Cj4gPj4+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4+PiArICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVz
OiBmYWxzZQ0KPiA+Pj4gKw0KPiA+Pj4gKyAgICBwcm9wZXJ0aWVzOg0KPiA+Pj4gKyAgICAgIHJl
ZzoNCj4gPj4+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBUaGUgY2hhbm5lbCBudW1iZXIgcmVwcmVz
ZW50aW5nIHRoZSBEQUMgb3V0cHV0DQo+IGNoYW5uZWwuDQo+ID4+PiArICAgICAgICBtYXhpbXVt
OiAzDQo+ID4+PiArDQo+ID4+PiArICAgICAgYWRpLHRvZ2dsZS1tb2RlOg0KPiA+Pj4gKyAgICAg
ICAgZGVzY3JpcHRpb246DQo+ID4+PiArICAgICAgICAgIFNldCB0aGUgY2hhbm5lbCBhcyBhIHRv
Z2dsZSBlbmFibGVkIGNoYW5uZWwuIFRvZ2dsZSBvcGVyYXRpb24NCj4gZW5hYmxlcw0KPiA+Pj4g
KyAgICAgICAgICBmYXN0IHN3aXRjaGluZyBvZiBhIERBQyBvdXRwdXQgYmV0d2VlbiB0d28gZGlm
ZmVyZW50IERBQyBjb2Rlcw0KPiA+PiB3aXRob3V0DQo+ID4+PiArICAgICAgICAgIGFueSBTUEkg
dHJhbnNhY3Rpb24uDQo+ID4+PiArICAgICAgICB0eXBlOiBib29sZWFuDQo+ID4+PiArDQo+ID4+
PiArICAgICAgYWRpLG91dHB1dC1yYW5nZS1taWNyb3ZvbHQ6DQo+ID4+PiArICAgICAgICBkZXNj
cmlwdGlvbjogU3BlY2lmeSB0aGUgY2hhbm5lbCBvdXRwdXQgZnVsbCBzY2FsZSByYW5nZS4NCj4g
Pj4+ICsgICAgICAgIG9uZU9mOg0KPiA+Pj4gKyAgICAgICAgICAtIGl0ZW1zOg0KPiA+Pj4gKyAg
ICAgICAgICAgICAgLSBjb25zdDogMA0KPiA+Pj4gKyAgICAgICAgICAgICAgLSBlbnVtOiBbNTAw
MDAwMCwgMTAwMDAwMDBdDQo+ID4+PiArICAgICAgICAgIC0gaXRlbXM6DQo+ID4+PiArICAgICAg
ICAgICAgICAtIGNvbnN0OiAtNTAwMDAwMA0KPiA+Pj4gKyAgICAgICAgICAgICAgLSBjb25zdDog
NTAwMDAwMA0KPiA+Pj4gKyAgICAgICAgICAtIGl0ZW1zOg0KPiA+Pj4gKyAgICAgICAgICAgICAg
LSBjb25zdDogLTEwMDAwMDAwDQo+ID4+PiArICAgICAgICAgICAgICAtIGNvbnN0OiAxMDAwMDAw
MA0KPiA+Pj4gKyAgICAgICAgICAtIGl0ZW1zOg0KPiA+Pj4gKyAgICAgICAgICAgICAgLSBjb25z
dDogLTI1MDAwMDANCj4gPj4+ICsgICAgICAgICAgICAgIC0gY29uc3Q6IDI1MDAwMDANCj4gPj4+
ICsNCj4gPj4+ICsgICAgcmVxdWlyZWQ6DQo+ID4+PiArICAgICAgLSByZWcNCj4gPj4+ICsgICAg
ICAtIGFkaSxvdXRwdXQtcmFuZ2UtbWljcm92b2x0DQo+IA0KPiBBbmQgYWRpLG91dHB1dC1yYW5n
ZS1taWNyb3ZvbHQgc2hvdWxkIG5vdCBiZSByZXF1aXJlZC4gV2hlbiBTb2Z0U3Bhbg0KPiBpcyBu
b3QgYXZhaWxhYmxlIChiZWNhdXNlIE1TUCAhPSAweDcpLCB0aGVuIHRoZSByYW5nZSBpcyBkZXRl
cm1pbmVkDQo+IGJ5IGFkaSxtYW51YWwtc3Bhbi1vcGVyYXRpb24tY29uZmlnLg0KPiANCj4gQW5k
IGV2ZW4gd2hlbiBhZGksbWFudWFsLXNwYW4tb3BlcmF0aW9uLWNvbmZpZyA9IDw3PiwgdGhlcmUg
aXMgc3RpbGwNCj4gYSBkZWZhdWx0IHJhbmdlLCBzbyBhZGksb3V0cHV0LXJhbmdlLW1pY3Jvdm9s
dCBzaG91bGQgc3RpbGwgbm90IGJlDQo+IHJlcXVpcmVkIGluIHRoYXQgY2FzZS4NCg0KVGhpcyBt
YWtlcyBzZW5zZSBob3cgdGhpcyBvcGVyYXRlcy4gQXBwcmVjaWF0ZSB0aGUgZGV0YWlsZWQgZmVl
ZGJhY2suDQoNCg==

