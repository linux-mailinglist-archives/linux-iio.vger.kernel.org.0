Return-Path: <linux-iio+bounces-7287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F8927025
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B6D284A35
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 07:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB48E187552;
	Thu,  4 Jul 2024 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JzIy5qn5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6959CA64;
	Thu,  4 Jul 2024 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076500; cv=fail; b=u0l9OjD9n4x7ubU8R5m8n65nx4JgZ2Qb5V6UsZd7NQpMVw33jiJDak1353XbBaBBtcXnKJcXh0+5u8/wvr/FjP07g2kD0dGm8quduMuscsUPoqOalzjqOsJFpZSK0o8/43dBw9QP508HnRltnQ5fKr0qu4wfc1utfr4QIL9KsHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076500; c=relaxed/simple;
	bh=tZxwCCNmxHalbLWgU+F9EJmEk5DC+LNuvD5C7/ekhyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iiQ+uQ1pD1z2SFFPbUhZ6SIO2EgorPOH56ujFa/6WhEOs/br+LBcPrxRqF1gosOCtJFOWP00pmJgc/iHOhM9+Gg48LyUB7CRhH7bWeX+ZMdFbCXy25rxBwq44RY/OHI6CBEtx5fNaQ49dWhwNIlCgT7KVM5FbRT0QJajX5hRzmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JzIy5qn5; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4640nQgn032056;
	Thu, 4 Jul 2024 03:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tZxwC
	CNmxHalbLWgU+F9EJmEk5DC+LNuvD5C7/ekhyY=; b=JzIy5qn5KxjiCEiZ3itp+
	DOMLXjIT6VlJXepMCYNf33JtYcs43yzPybkzO/vMu4zkQIuGY5ty/1IK02cKIJCH
	v3AvGUMZi2jMFlD267YuBzFaoBmViCAXG1wSBh8LbQ/wGOuSKzRDsLSBtqN//+if
	WJ7qSaxIYP7Xom25qxFAy23eFKgjcdDUtBdqH58UhW8a+pFoU7ta93STA5Lm4AT/
	hXNRREUz6EhR5Isr/C2UJ/RMCkeGPE+f3FEL0azS9uHa6OTOHGP+YynkfSywKEtu
	sfHt0gL8f6a1vOVcGRzHR4+tGhDkpdda47kD9cbCPXy7o+yCqAhqQbO4gZkFH/D+
	w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 405a7ma5ke-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 03:01:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAu/WgDCmaHf6VrfkONbSnxsy3UiY2tRGF7R+I3CnPdKbWpBqHTah7WpvZTou2D+XmJ7MVC2HJjwJYdfyWZKYcbq1tHOUWkVzVyOzaMQ63n7aowU5H15zW2qEHz2CNbapO8j4rJIvMPcWEs925r7g+Ursnc50vLzJSWkkPLfoYDAVPJBH3fdd5sohfHOQ6A81B8pxl+CYAUYyeENxYw+5h7cZf3SwGKhaXPKJTGtWaGQIOom6I+9QedIDd7ACZ6vwzU66axjGTo8+A5VjEF7j4weCanvCurV3Uk/uN4UlnJFX9FsHE0PxpwhxyG2RvO2U9VobociNNUV8+lUQHRhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZxwCCNmxHalbLWgU+F9EJmEk5DC+LNuvD5C7/ekhyY=;
 b=DBRIPJiR47ieUwqnvUrFV0XanG9lXlz0JBQNNJK1uGCMPjZ0ZWJQDnlLLaRoNLYCVb5MOb0wE4CIgEJ3VI6argHKovSZTahxCnf4n01k0SInO0RMk8n13UWTQe7UAo6nuVu2dcoaj+ALYNq/x+kPWFdAaoGCQ6wQRte1CZxAziVg1L9zBDMMsUl4ad9RjWEtenxq3MY+3lcdHwmZkFFrT2mDWbNC6NhNkCiM5YYRIaNHXFpdJd7IaN8gopWVsYKB8f7U5YfBt0aHyIjJyGVPCZYh0+Ef1TrJhhwGb5dTdTV+iWhdxuuU+B7FRobfapM49fNbVo3ERHDQBoDqRTQ8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by BN9PR03MB6156.namprd03.prod.outlook.com (2603:10b6:408:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 07:01:07 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7719.029; Thu, 4 Jul 2024
 07:01:07 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri
 Fedrau <dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v5 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Topic: [PATCH v5 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Index: AQHazCwcEXgGXk1JKUunDqCkQHNHm7Hjkt6AgAKTpIA=
Date: Thu, 4 Jul 2024 07:01:07 +0000
Message-ID: 
 <PH0PR03MB71417A3455B24590982C0716F9DE2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
 <20240702030025.57078-5-kimseer.paller@analog.com>
 <bba8a12a-9d1e-467b-a7c1-8a027d5c2f89@baylibre.com>
In-Reply-To: <bba8a12a-9d1e-467b-a7c1-8a027d5c2f89@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB5WlRoaE1UQmtZUzB6T1dRekxURXhaV1l0WVdGbU5pMDRORE5o?=
 =?utf-8?B?TldKallUZ3pNVFJjWVcxbExYUmxjM1JjTW1VNFlURXdaR010TXpsa015MHhN?=
 =?utf-8?B?V1ZtTFdGaFpqWXRPRFF6WVRWaVkyRTRNekUwWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNREUyT0NJZ2REMGlNVE16TmpRMU5UQXdOall6TmprMk9USTJJaUJvUFNK?=
 =?utf-8?B?RWVHa3hlVXRhU201bWFrNUhTR3RPWVM5cFVWWlVWMUZQZW04OUlpQnBaRDBp?=
 =?utf-8?B?SWlCaWJEMGlNQ0lnWW04OUlqRWlJR05wUFNKalFVRkJRVVZTU0ZVeFVsTlNW?=
 =?utf-8?B?VVpPUTJkVlFVRkZiME5CUVVGbGFuVlFkek00TTJGQllqSmxZVmxWVWxWamRV?=
 =?utf-8?B?RjJXalZ3YUZKR1VuazBRVVJCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|BN9PR03MB6156:EE_
x-ms-office365-filtering-correlation-id: 43c7a7d4-e626-458e-4d00-08dc9bf71449
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bkJPOC93WUNlanlFMUZud3VnbjFKcHRJWEVsNHpxdWJmLzgvd2JZNXpiZFk3?=
 =?utf-8?B?OE9sWnBNQnNSd25ZN2NHTXgrNGNYNTBZYTR3NzVGTWg1ZDhKTEhDWTVoYm83?=
 =?utf-8?B?c3hPdVRhNFhCQ1B2NktxMituYWI5MEpINVplVHBrSm9yQ213TW9RZ0loQnZD?=
 =?utf-8?B?Y2xkbVdiSkRrcElqdngyb2lFSDZocThlMm9iT3NyL0RVb2UyMzYyMFB5RGJo?=
 =?utf-8?B?ZUZid3ZOQmhUOEE2UVZQbU5VUExDa3BMV281NitWa3hxMncvc3hBRUFVbmE2?=
 =?utf-8?B?WjhNRXVESmtuMW5tTU9SdjBDeVpJaWMwOERLdXF6OTNIYXorSlJ3eE9tZ2Rs?=
 =?utf-8?B?SVcxbkMzd045Q2tabFpsK1Y5SDY1N0VkVUpqTWhjajZ0eEJ5dTZMQTlOVTdv?=
 =?utf-8?B?TTRzY1VMb3A5M0VmUHArRW5xM2taSWlCajAzODZ1VENQaWpRK2xxT0RMek83?=
 =?utf-8?B?cmxEdFFuRCtWZ090MFZYbjNIUzJZUlpVUHUzWEhyTlNkcUhEak1zdzZUeUJS?=
 =?utf-8?B?OG56RFNtNjE5N1dScWM2c3lIQjJKc0NaUG0rTFYvd3Z6VFh5U0FCbTdHYk5p?=
 =?utf-8?B?WS9OR1lqZVpsUEp5Q3hnaksza05FRmtzR1VNODV2WWR1VW9EYVIrU0pKS1gx?=
 =?utf-8?B?a21XdVdIL1ROM2hjVyt2dE5uNURsSXF3b0htTkVubzVna3AyaEhjcHJKS1N2?=
 =?utf-8?B?MHpwSWQ2bVJyTmVWc05VK1E5NVVqb1NiVEFzaUFCbkVMWUZkYmc3TldiOWI3?=
 =?utf-8?B?TFN3Z2FXYVFDVlVmSWFGL0FsY2kxOTZTWUtka1JmWnNYT1RJZkZMdUlxaU1G?=
 =?utf-8?B?OGhYRVU0bTVpbHcveXY0WUtZOENtN3poVFNJK2xWQ2JJREdYS2ZPTGQ0VE9l?=
 =?utf-8?B?WTRHUERZRHR4bzk3SGhFbmxLRTBKUmNtdHVXSklNSkpJbWZOS0tMQmJxZXkw?=
 =?utf-8?B?QU01NDdQQ29zNGl4ZSs1SEZ4T2dGUE5OWCt3dW16bjBNL3lpeEhUUW9qcmNW?=
 =?utf-8?B?SnlIbUduV0tBY1Z3QnVhY29hdzE1SStTeitJdENmZUx3RHNJU1UxN3dOYXJV?=
 =?utf-8?B?RWo0QUtCYmdUd3FmN0hBQ1F2RUc4MUtNWnR3NE10QXVsZ2M2K1BwM21BWnpR?=
 =?utf-8?B?cVJuaGp4REhFNWhWLzg1dHAySXdGNzdoVDBxRDkwdkowTEd4UjhzMkdoMVJX?=
 =?utf-8?B?SkF0YVR1VSt5UGsrRXpEOU9VS01JSk1JS2F0S3dJbXJ0UGQrM3ovVXV5Z2RB?=
 =?utf-8?B?dFV0UHp2KzhrbzdIVms4V2tYOWRzNkNVLzA0VUlZVVY4aXMvZ2ltNm8vWXMv?=
 =?utf-8?B?UnNZM01zeXV1eDNhM24rZFprQmF4OWJaRVQ5N2xqdWsraHFvMlppdnpUNzZs?=
 =?utf-8?B?b2tPcEhYK1EyOVhwT2kxS3VkbkpGcDRiR1pvcHNPdW1JSTFwWXBLc1JuMkMv?=
 =?utf-8?B?U285ZDlzN2gzZ0lNWXVZMnk0OHgxWitDdE4xVGx4NHN4WXJEOThQKzRadVJ3?=
 =?utf-8?B?M0tQeDUzVkZNNXJuNXhSdW52WkVBaFNxalk3QmJsTHljTmtHRkpFOStHcWJQ?=
 =?utf-8?B?RHI3Vy83R0FzQUluTm1meUVmV2JzUmd0eWZhSGZvZHZkVU5CYTFaVXU2UVVS?=
 =?utf-8?B?Y2RrQzJUcVQ3VFg4dllPekNXTDBpQzBwWWxYWXN3dzVmN3FXMnZ6cFhiZ05j?=
 =?utf-8?B?a1M4L2VkdUFUR3QyYkl2bGxzRmxnVEJScE1XZnpKa1M3c2hTSnJrUE5qY3Vx?=
 =?utf-8?B?Y3I3RGEyQUFFdC9XTlltdFduZFdRaERpL2tZUWhhYTF5YWJWdzFxeUNGZkJ4?=
 =?utf-8?B?L3NGZUFEN3BKODgxeU43NTZucVQrTEphQTNCYXJDbnZlSmkzS1R1cWtmZjU1?=
 =?utf-8?B?Rnp5eXlQMW5YcTVYN0tFSGEwbjlRVVVQMTFrZlp6WTN4SVE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ME95K0VLQ3pBekYwRzEzUGlTZmZORkhMWmdvOEM5ZmtoVW9hTnVPcVZWeEky?=
 =?utf-8?B?K3lpZ2NrODQ1NEN3RW1QVmRMMEx3UXlaVW1NUmdBSnU0N01icHM0TmVMQzFs?=
 =?utf-8?B?N2JOeXNNK05lZmVTc0VSZ3VycmxtNHhmZU9zK1Z1eTNXVnpKTVR1T1lJR01j?=
 =?utf-8?B?WTBkN2N1ZzFIY1kza2VTaG11WkcvbjdIcWVmUzdlOWVMVnFOL3I2VlY0U3Ro?=
 =?utf-8?B?a2xJK0hCSWh4dXZaV2FHNVVwTVpIQnNsRzNoWHpJVzNzc28zUEZnb1hJREpM?=
 =?utf-8?B?ZkExeitnOW9GdGtwRzdraUtNSElXZ0laWlFUdG1RWk5TYVRXK20vTmQyYnA2?=
 =?utf-8?B?ektIRjc4Vm1wcFVtQ0lCUG1WR3NSY1dyZVJpL0xGOEsxdjlQZDNuZS93aTk0?=
 =?utf-8?B?Ky90RjEvYWhYU2NEVUNqYjMycE5CY0g1T2MxM014b0YzOHA4Y2RORU5TZWdp?=
 =?utf-8?B?TkJhZ29JVDhianRCNUFqakFMdlRtcXVhMENmV3B1NFk5OEFTYTM4dWI0U2ZQ?=
 =?utf-8?B?MXoxSmZQbDlRL0djdzVQdnEzTXBIQndoNGhPdUdjazFva08zQXp4bnh5T1Uv?=
 =?utf-8?B?emZma1VVSGVNT3ZuY1ZjSDNCTmM1Mm11LzVjL3phaEZhdjNSNENucHNRcHFO?=
 =?utf-8?B?ZGZ3enlKY2hGS1M5QkhOeHdvWUNtTHFKSWdGZkhWWEtIbHNOM2ZLaUtsanVJ?=
 =?utf-8?B?T3VzbVNuVjVvT3NUMGJqd1VOTk1EdmNONHhRMWhYQmxDSUFkRndSbGR2Y0o2?=
 =?utf-8?B?M3l1YktRSTdWdldrNUhiMUVaSXlMSEJNU01nNndueVhyTWtqd3Y5SXZFS1Fj?=
 =?utf-8?B?bGlwdlZZdHVXWFVsU2Q1OVE4ZjJZdWF5L3dqbWFIbWNFdWYyYU1CT0tlMzl4?=
 =?utf-8?B?K2FiekpENU1QWlNadkx5d3h4Wlc4ZUtkbjM5THdVZitoejZCNHB0SXFxOCtV?=
 =?utf-8?B?UkVIbkFKZFJjVlUyUExvVUJ1THVOZkxueWVqSUEyTVMzMFVKUk12TGVYNTZF?=
 =?utf-8?B?QUJWbnFJcHExN1krQS9OazJ1MHRkdFFvRG9GYlVnT0w1bWdmYUVldDNraUdL?=
 =?utf-8?B?MEgrYS9QeGhHRHB0U1MzZWZ2czJqa0xwWGVnVldWTkYxSkR3VThHTWUyc0RD?=
 =?utf-8?B?cXJZZ1MrMEd0dFE2SGxNbWxVT3J5ZHdRQ0ZMdzhDYmM5RldqelFudXBUOUYr?=
 =?utf-8?B?MnY5QUFiU21CZ1I0RWlXa1NZazUxdlgvWjZGcktaekZYbG8wOXlud3pwUVJY?=
 =?utf-8?B?bjR0ZU9KS3ZXeTUzS2t3b3huK09obUtsUTFHWldDKzlTRzJWVkl2bFZPZ1Z0?=
 =?utf-8?B?RXhXODZtT2R2YVZ5WEt1WFBvUUc5dlRYNVpUNWtubXI0cHl0eW1WSHo1WTRs?=
 =?utf-8?B?eVgxNW5INVhFNWNTVkJ5ZFZDaUlSTkQzTlIxTjlueEpFellVOFE1SVYvLzdL?=
 =?utf-8?B?TzFWelAvdGFwMFpld0FzSHlPa21lMHdmM1BadWFsS1h1M3YxVzg2R0F6M0hh?=
 =?utf-8?B?bExoSjJjZGZGVFA1ckFPOHNaS2FlZGxnYzNzSE9VaFJmMklkUkFGNG1PODNi?=
 =?utf-8?B?bkpHUkRndHRPZXNHdGRjMXFtL1dmVDBFNjNGNlRzYUZaQlh0NzVpYmZab1l4?=
 =?utf-8?B?amV4K3ZsNitYRjhBUXhkL2EyWWxKejZ5aHFHNG9LeWRwSFVncmlpd2d3WXdG?=
 =?utf-8?B?a004SWg5ODF4WDRnUXozTE9zaDZsTEx6R1dYamZiWWVWc0ZNUmFSNldpcU84?=
 =?utf-8?B?c1NEbzlKdUpYQUxQcGphcXhpeGh6bHFCbG11dmYyMldYMGpRbXhCc1lyRUNV?=
 =?utf-8?B?Z08zWkw2N2xUTFRHUWJjd1luTmdIZkhlM0lSeEVBdXIxWldybVhiU3EwNTlM?=
 =?utf-8?B?K3UrWnVhQ2RhNllXRUlrc2pOSGh2K21aemtCZjNLWUU0Y3g1UzZCUmdDeUo0?=
 =?utf-8?B?ZTBPSTh2OGY0UWFWK0NDaGxBSG9zbFBLa3VJTGk5MXhYcDR6bExtazFySHAz?=
 =?utf-8?B?SXV4NkFNYVhSRTNWU3RWNXMrbitMNjZ2UndiN05nUGRkOTgyQ0FjTjdrS0cr?=
 =?utf-8?B?Z2hGazlZb0YvUExsd0oxU1A2a2JGWUpXc3JSaEY3azNFK1p5TlRLS1ZCS2hK?=
 =?utf-8?Q?/gflGSMQxNegFnrrIOrgfjrs4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c7a7d4-e626-458e-4d00-08dc9bf71449
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 07:01:07.9200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vs6kc5/K3l7NcZY57zgGgZIxC4y294wN5JDw7htS8nyq2WdhYZ5mrACLIawjUMgwMM7UVnfWr7XaVWwZ21UdFgtvernWaBOS2MFt7BFkhpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6156
X-Proofpoint-ORIG-GUID: FuLZ5kh80c1Y_QCbka3ne6kyDpEvWqh8
X-Proofpoint-GUID: FuLZ5kh80c1Y_QCbka3ne6kyDpEvWqh8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040049

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDIsIDIwMjQgMTE6
MzYgUE0NCj4gVG86IFBhbGxlciwgS2ltIFNlZXIgPEtpbVNlZXIuUGFsbGVyQGFuYWxvZy5jb20+
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVs
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEpvbmF0aGFuIENhbWVyb24g
PGppYzIzQGtlcm5lbC5vcmc+OyBMYXJzLVBldGVyIENsYXVzZW4NCj4gPGxhcnNAbWV0YWZvby5k
ZT47IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+OyBNYXJrIEJyb3duDQo+IDxi
cm9vbmllQGtlcm5lbC5vcmc+OyBEaW1pdHJpIEZlZHJhdSA8ZGltYS5mZWRyYXVAZ21haWwuY29t
PjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz47IENvbm9yDQo+IERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9y
Zz47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47
IE51bm8gU8OhIDxub25hbWUubnVub0BnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djUgNC82XSBkdC1iaW5kaW5nczogaWlvOiBkYWM6IEFkZCBhZGksbHRjMjY2NC55YW1sDQo+IA0K
PiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiA3LzEvMjQgMTA6MDAgUE0sIEtpbSBTZWVyIFBhbGxlciB3
cm90ZToNCj4gPiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgbHRjMjY2NC4NCj4gPg0KPiANCj4gLi4u
DQo+IA0KPiA+ICsgIGFkaSxtYW51YWwtc3Bhbi1vcGVyYXRpb24tY29uZmlnOg0KPiA+ICsgICAg
ZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFRoaXMgcHJvcGVydHkgbXVzdCBtaW1pYyB0aGUgTVNQ
QU4gcGluIGNvbmZpZ3VyYXRpb25zLiBCeSB0eWluZyB0aGUNCj4gTVNQQU4NCj4gPiArICAgICAg
cGlucyAoTVNQMiwgTVNQMSBhbmQgTVNQMCkgdG8gR05EIGFuZC9vciBWQ0MsIGFueSBvdXRwdXQg
cmFuZ2UgY2FuDQo+IGJlDQo+ID4gKyAgICAgIGhhcmR3YXJlLWNvbmZpZ3VyZWQgd2l0aCBkaWZm
ZXJlbnQgbWlkLXNjYWxlIG9yIHplcm8tc2NhbGUgcmVzZXQNCj4gb3B0aW9ucy4NCj4gPiArICAg
ICAgVGhlIGhhcmR3YXJlIGNvbmZpZ3VyYXRpb24gaXMgbGF0Y2hlZCBkdXJpbmcgcG93ZXIgb24g
cmVzZXQgZm9yIHByb3Blcg0KPiA+ICsgICAgICBvcGVyYXRpb24uDQo+ID4gKyAgICAgICAgMCAt
IE1QUzI9R05ELCBNUFMxPUdORCwgTVNQMD1HTkQgKCstMTBWLCByZXNldCB0byAwVikNCj4gPiAr
ICAgICAgICAxIC0gTVBTMj1HTkQsIE1QUzE9R05ELCBNU1AwPVZDQyAoKy01ViwgcmVzZXQgdG8g
MFYpDQo+ID4gKyAgICAgICAgMiAtIE1QUzI9R05ELCBNUFMxPVZDQywgTVNQMD1HTkQgKCstMi41
ViwgcmVzZXQgdG8gMFYpDQo+ID4gKyAgICAgICAgMyAtIE1QUzI9R05ELCBNUFMxPVZDQywgTVNQ
MD1WQ0MgKDBWIHRvIDEwLCByZXNldCB0byAwVikNCj4gPiArICAgICAgICA0IC0gTVBTMj1WQ0Ms
IE1QUzE9R05ELCBNU1AwPUdORCAoMFYgdG8gMTBWLCByZXNldCB0byA1VikNCj4gPiArICAgICAg
ICA1IC0gTVBTMj1WQ0MsIE1QUzE9R05ELCBNU1AwPVZDQyAoMFYgdG8gNVYsIHJlc2V0IHRvIDBW
KQ0KPiA+ICsgICAgICAgIDYgLSBNUFMyPVZDQywgTVBTMT1WQ0MsIE1TUDA9R05EICgwViB0byA1
ViwgcmVzZXQgdG8gMi41VikNCj4gPiArICAgICAgICA3IC0gTVBTMj1WQ0MsIE1QUzE9VkNDLCBN
U1AwPVZDQyAoMFYgdG8gNVYsIHJlc2V0IHRvIDBWLCBlbmFibGVzDQo+IFNvZnRTcGFuKQ0KPiA+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4g
KyAgICBlbnVtOiBbMCwgMSwgMiwgMywgNCwgNSwgNiwgN10NCj4gPiArICAgIGRlZmF1bHQ6IDcN
Cj4gPiArDQo+ID4gKyAgaW8tY2hhbm5lbHM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiAr
ICAgICAgQURDIGNoYW5uZWwgdG8gbW9uaXRvciB2b2x0YWdlcyBhbmQgdGVtcGVyYXR1cmUgYXQg
dGhlIE1VWE9VVCBwaW4uDQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICAnI2Fk
ZHJlc3MtY2VsbHMnOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgJyNzaXplLWNl
bGxzJzoNCj4gPiArICAgIGNvbnN0OiAwDQo+ID4gKw0KPiA+ICtwYXR0ZXJuUHJvcGVydGllczoN
Cj4gPiArICAiXmNoYW5uZWxAWzAtM10kIjoNCj4gPiArICAgICRyZWY6IGRhYy55YW1sDQo+ID4g
KyAgICB0eXBlOiBvYmplY3QNCj4gPiArICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0K
PiA+ICsNCj4gPiArICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgIHJlZzoNCj4gPiArICAgICAg
ICBkZXNjcmlwdGlvbjogVGhlIGNoYW5uZWwgbnVtYmVyIHJlcHJlc2VudGluZyB0aGUgREFDIG91
dHB1dCBjaGFubmVsLg0KPiA+ICsgICAgICAgIG1heGltdW06IDMNCj4gPiArDQo+ID4gKyAgICAg
IGFkaSx0b2dnbGUtbW9kZToNCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAg
ICAgIFNldCB0aGUgY2hhbm5lbCBhcyBhIHRvZ2dsZSBlbmFibGVkIGNoYW5uZWwuIFRvZ2dsZSBv
cGVyYXRpb24gZW5hYmxlcw0KPiA+ICsgICAgICAgICAgZmFzdCBzd2l0Y2hpbmcgb2YgYSBEQUMg
b3V0cHV0IGJldHdlZW4gdHdvIGRpZmZlcmVudCBEQUMgY29kZXMNCj4gd2l0aG91dA0KPiA+ICsg
ICAgICAgICAgYW55IFNQSSB0cmFuc2FjdGlvbi4NCj4gPiArICAgICAgICB0eXBlOiBib29sZWFu
DQo+ID4gKw0KPiA+ICsgICAgICBvdXRwdXQtcmFuZ2UtbWljcm92b2x0Og0KPiANCj4gQ291bGQg
YmUgaGVscGZ1bCB0byBhZGQgYSBkZXNjcmlwdGlvbiB0aGF0IHNheXMgdGhpcyBwcm9wZXJ0eSBp
cyBvbmx5IGFsbG93ZWQNCj4gd2hlbg0KPiBTb2Z0U3BhbiBpcyBlbmFibGVkIHJhdGhlciB0aGFu
IHJlcXVpcmluZyBwZW9wbGUgdG8gcmVhc29uIHRocm91Z2ggdGhlIGxvZ2ljLg0KPiANCj4gPiAr
ICAgICAgICBvbmVPZjoNCj4gPiArICAgICAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAg
ICAgLSBjb25zdDogMA0KPiA+ICsgICAgICAgICAgICAgIC0gZW51bTogWzUwMDAwMDAsIDEwMDAw
MDAwXQ0KPiA+ICsgICAgICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgICAgICAtIGNvbnN0
OiAtNTAwMDAwMA0KPiA+ICsgICAgICAgICAgICAgIC0gY29uc3Q6IDUwMDAwMDANCj4gPiArICAg
ICAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAgICAgLSBjb25zdDogLTEwMDAwMDAwDQo+
ID4gKyAgICAgICAgICAgICAgLSBjb25zdDogMTAwMDAwMDANCj4gPiArICAgICAgICAgIC0gaXRl
bXM6DQo+ID4gKyAgICAgICAgICAgICAgLSBjb25zdDogLTI1MDAwMDANCj4gPiArICAgICAgICAg
ICAgICAtIGNvbnN0OiAyNTAwMDAwDQo+IA0KPiAgICAgICAgICAgIGRlZmF1bHQ6IFswLCA1MDAw
MDAwXQ0KDQpBZGRpbmcgYSBkZWZhdWx0IHZhbHVlIGRpcmVjdGx5IHdpdGhpbiB0aGUgc2NoZW1h
IGNhdXNlcyB2YWxpZGF0aW9uIGVycm9yLg0KR2l2ZW4gdGhpcywgaXMgaXQgYWNjZXB0YWJsZSBk
b2N1bWVudGluZyB0aGUgaW50ZW5kZWQgZGVmYXVsdCB2YWx1ZSB3aXRoaW4gdGhlIGRlc2NyaXB0
aW9uPw0KDQo+IA0KPiA+ICsNCj4gPiArICAgIHJlcXVpcmVkOg0KPiA+ICsgICAgICAtIHJlZw0K
PiA+ICsNCj4gPiArICAgIGFsbE9mOg0KPiA+ICsgICAgICAtIGlmOg0KPiA+ICsgICAgICAgICAg
cHJvcGVydGllczoNCj4gPiArICAgICAgICAgICAgYWRpLG1hbnVhbC1zcGFuLW9wZXJhdGlvbi1j
b25maWc6DQo+ID4gKyAgICAgICAgICAgICAgY29uc3Q6IDcNCj4gPiArICAgICAgICB0aGVuOg0K
PiA+ICsgICAgICAgICAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgICAgICJeY2hh
bm5lbEBbMC0zXSQiOg0KPiA+ICsgICAgICAgICAgICAgIHJlcXVpcmVkOiBbb3V0cHV0LXJhbmdl
LW1pY3Jvdm9sdF0NCj4gDQo+IA0KPiBUaGlzIGxvZ2ljIGRvZXNuJ3QgbG9vayByaWdodCB0byBt
ZS4gSWYgYWRpLG1hbnVhbC1zcGFuLW9wZXJhdGlvbi1jb25maWcNCj4gaXMgbm90IDcsIHRoZW4g
U29mdFNwYW4gaXMgZGlzYWJsZWQsIHNvIHdlIHNob3VsZCBoYXZlOg0KPiANCj4gICAgIG91dHB1
dC1yYW5nZS1taWNyb3ZvbHQ6IGZhbHNlDQo+IA0KPiBJbiB0aGF0IGNhc2Ugc2luY2UgaW5kaXZp
ZHVhbCBjaGFubmVscyBjYW4ndCBoYXZlIGEgcGVyLWNoYW5uZWwNCj4gY29uZmlndXJhdGlvbiBi
ZWNhdXNlIFNvZnRTcGFuIGlzIG5vdCBlbmFibGVkICh1bmxlc3MgSSBhbSBtaXN1bmRlcnN0YW5k
aW5nDQo+IHRoZSBkYXRhc2hlZXQ/KS4NCj4gDQo+IEFsc28sIG91dHB1dC1yYW5nZS1taWNyb3Zv
bHQgc2hvdWxkIG5ldmVyIGJlIHJlcXVpcmVkLCBldmVuIHdoZW4NCj4gYWRpLG1hbnVhbC1zcGFu
LW9wZXJhdGlvbi1jb25maWcgaXMgNyBiZWNhdXNlIHRoZXJlIGlzIGFscmVhZHkgYSBkZWZhdWx0
DQo+IHZhbHVlIHJhbmdlICgwViB0byA1Vikgc3BlY2lmaWVkIGJ5IHRoZSBhZGksbWFudWFsLXNw
YW4tb3BlcmF0aW9uLWNvbmZpZw0KPiBwcm9wZXJ0eS4NCj4gDQo+IEkgdGhpbmsgdGhlIGNvcnJl
Y3QgbG9naWMgd291bGQgYmU6DQo+IA0KPiAgICAgLSBpZjoNCj4gICAgICAgICBub3Q6DQo+ICAg
ICAgICAgICBwcm9wZXJ0aWVzOg0KPiAgICAgICAgICAgICBhZGksbWFudWFsLXNwYW4tb3BlcmF0
aW9uLWNvbmZpZzoNCj4gICAgICAgICAgICAgICBjb25zdDogNw0KPiAgICAgICAgIHRoZW46DQo+
ICAgICAgICAgICBwYXR0ZXJuUHJvcGVydGllczoNCj4gICAgICAgICAgICAgIl5jaGFubmVsQFsw
LTNdJCI6DQo+ICAgICAgICAgICAgICAgcHJvcGVydGllczoNCj4gICAgICAgICAgICAgICAgIG91
dHB1dC1yYW5nZS1taWNyb3ZvbHQ6IGZhbHNlDQoNCg==

