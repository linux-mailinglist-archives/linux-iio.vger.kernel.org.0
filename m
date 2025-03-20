Return-Path: <linux-iio+bounces-17133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21899A69D60
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 01:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F807A40D2
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 00:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32B71B423C;
	Thu, 20 Mar 2025 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Zk/XSt6i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E935F42A87;
	Thu, 20 Mar 2025 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742431981; cv=fail; b=RGw+BRxUrhuyI7vH/PXibz+fmwegHZ/kzhim+AeXtFJIzZQRlCg20coZW8TPe/KcpNfDfZXGlRFVWvjyosU9xRTJpKK5xcBZqY08zrWQYsobNPGDdjNn9FogK1VkO0j+GVsBacd/mpu8tqpKSmSLdlKCfl3WthoO2VvUjwX1CBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742431981; c=relaxed/simple;
	bh=xCZUSL0sh/HuiSQs3hjIS0fJxw6opUqI8lWR9mvBoEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qgyv/Wp16KQSE4ivLmlxBoPYciXLtEurlrAUgO1aduITiCHcz33/0bmOkbPkN1a+q/pxHPGDmSXaZhT+3XCjr1q/57Wzqol6f3f++x+/iVz1oowwlorB2mu3DlFLJYcwYkDnMFp6Yrxu4xCJWdL4H6zI/zHz2FK7sbdGnPeTXug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Zk/XSt6i; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JKmXXh020581;
	Wed, 19 Mar 2025 20:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xCZUS
	L0sh/HuiSQs3hjIS0fJxw6opUqI8lWR9mvBoEU=; b=Zk/XSt6ivmqNw+F6Et7DD
	9yHXYfalBY+pGZdJ3Ap3BRV3J3paHiGXJNv05l9XXx+LdJzO02CSIlxsAYuL1VTN
	ySCHFLAJV/m8R+qYQXaQ6fcf0HdYVL4TijGMIbklHlDQ5+prA8d1J+OsOaD0guRi
	tg0iv4wqACx4WmU2c9jsj77IltFSZDd9rpqVndZcaRX69F+vQZ2ASa8T5IzZvqC2
	Tnn0OXLeTs8fyVR79SnRmJzRQhUPOOqcKNn0rQc2fgfDkxZsSyjkzygwTjpzzwl0
	7RqNLsZApSAuGsOg8DDiiwjhqRPoTmcEL7ZMfwPFNo44U+xpOPjHPJcsSJqzd9ij
	w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45g117a1wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 20:52:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXdx9wfJ4aqUHiaTYAOn7/sL+Px/IockaDRLfZFLCzwGvAWF1irt5lwhiJJVUNH7iiOOJfmreYMaLkZGzL9vFhMU5rhbgJEfe8ZJwz1Rm9la4ljxYY0uINSyypTrqky9ONvFKX4MU/ehQYUtRElQK5fmj3TsfhZNz5HVnEQk7euGyEuPvzrqTZKfXgzUo4rg0DDsBXASbplbpDrgLDDZZ1OhP+RbwssoFLUpR+1PR/NecM84lKnweE3K6kxbrEKCO2YugYaGY53BRimXo1jMUXhpuR7M3E/dLFZd3+18W7LNRB06SzXnmx7TP8VB45gUFYb4PUUjhrzYaw9EtEK/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCZUSL0sh/HuiSQs3hjIS0fJxw6opUqI8lWR9mvBoEU=;
 b=sPvy30aI4YOU1PKCXzWA1J6YbFL1TDl/gzEqKOAN/95ORZgsKI3vzMVMjP9ya+uHtuUuNPYsf0G4Z+FD8V5DaRQiVjbYmfD1UtSdXPx7kotVSTwyqF+vrdSzeB9D40oT+KzFl9AfoT+7/brePoWsmh/f+9Zc9WG9wM7L9MAlZhVsZUmqRunMEMM93tpAnF9oewBpdP6vphC7ux4hcg52Lbt6IODWl372m7nZOIFz1xsgphe2ogUfXB5TgyiLUinY/VYYCkdtWpmjLhqz9VcIulxVsGswaDPiHhMD5AjayTSV3qliJu5G0FOEbU+g1QXwafhrnA8G2/G5Xb1Az5qVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by DM6PR03MB5291.namprd03.prod.outlook.com (2603:10b6:5:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 00:52:30 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 00:52:30 +0000
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
Subject: RE: [PATCH 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Thread-Topic: [PATCH 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Thread-Index: AQHbmIHR8yAnTDuO906F/hkMnqNS27N6HRmAgAEQj5A=
Date: Thu, 20 Mar 2025 00:52:30 +0000
Message-ID:
 <PH0PR03MB7141297885946A5A77204567F9D82@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250319-togreg-v1-0-d8244a502f2c@analog.com>
 <20250319-togreg-v1-3-d8244a502f2c@analog.com>
 <20250319-opalescent-just-boa-fecdc0@krzk-bin>
In-Reply-To: <20250319-opalescent-just-boa-fecdc0@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|DM6PR03MB5291:EE_
x-ms-office365-filtering-correlation-id: 3310006f-fb8b-4e7a-a968-08dd67497e41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RE5SRWs0L20wYXZXeTYxZ1lmMGtTdS94V0lBbkxNMWxaOGhvZTlicVVZR3Vv?=
 =?utf-8?B?MVZKZVFCSGhzRVhjWUN2QWVMVFdlUEd6SGp3NnFRUzFQanNtSlFYL0lHZWpZ?=
 =?utf-8?B?UGs0QjcvZEEvZnVaMVBlNmxHb1lvZVltaGVQS0lEdjVBMUpVcXVuYnJ6OUxX?=
 =?utf-8?B?RTBLYVZYMEthMzBEVGQ5NUVqZVROQUxpZnRPbTN1SG43eHB4QVBYZ24vd0hN?=
 =?utf-8?B?UGg0QWVYMTZnajF6b3gwckEzaUJTYzY0eUViM2s2TVNScnhDYncrMGpSdWQ5?=
 =?utf-8?B?QWQvdG90VmNoeGIwWGxWY2YzdWE0L25zT3IvTmkrT3hMVFNNck9lZVJDbUYz?=
 =?utf-8?B?dzZ4RGEyUjUzc3BUVXNJTEorbXMydDhjTzcvVExaUGtXMVBadFBEd1gwdEYy?=
 =?utf-8?B?YWhzbTBTd25ZOGxTclJrQ3Zjb1VadGRUaDJUMFpQQ242SGlYZzRNMEZmMFdV?=
 =?utf-8?B?Z1ptUlFWclFFQng3U2JzL094elpTaHFJWmhXWjhvTU1aUTY4OW5aYVBMRWdD?=
 =?utf-8?B?aUM4UE13VndzVlNTRWQ4VjUwWjRWNWFhMzhBMStSWm5JcVNZOXZ1VGFOUjV1?=
 =?utf-8?B?SmFMR3V2RmxOdnpBeXlFcFhiQzRGdXRFVTg4MXc0MUwwUDF6aStra2R1KzFP?=
 =?utf-8?B?VnNuVGhFajRwdFdRb3FXVlFobWNOdDRlYTlCTUZCZnBjWXZvL2ZrUzAwY2Rw?=
 =?utf-8?B?anpWVGY3QWdqQy95YkZRT3RmSnJOYmQ5YUJIMFNkckdYTlhBWDBzc0V1OWdG?=
 =?utf-8?B?cjZ1c1NqVDh3MmtGRXhQRTd6eUVpSkROTmVSQlpadTdLdHJwTjVEc1ZOUDh5?=
 =?utf-8?B?TDZnNVIzeWFLVGM0eGxkRUEzTjFWZUx0TXk0aytPTDJ0amNyb1lUcTFuQVFH?=
 =?utf-8?B?UGpOaEdiWEhYNjBCc0hUd25GMDZONVZjZkdiUU5IaTVKdzdCd1VvYy9uNm41?=
 =?utf-8?B?RWplU21GMUJEL2pDMlpTZzl0ZTNTTEFaV1c0T3o0VlB4RHhKdmpVQWMwSHZS?=
 =?utf-8?B?TWJmZXFaZ0VONEYxSzAzSjVuYmY0aG4vOGc1S1VOVFZTVFpUUk5HVnVidEZZ?=
 =?utf-8?B?ZVN4YjgvYnFnVUJFWXRkOU9WNDlxNTFtM3dVZ1VQd1g1UDZJcElwV0RpeDNP?=
 =?utf-8?B?aHZ0czByczFzU0tVWFpjR2E3UkRmRlQwbEtmQXJjc1grNTFDR2QxdGdCSjhX?=
 =?utf-8?B?aThPUnNRaTRPMUEwSGV0N3gycFN5OWt2ajZRNUtMSktXWmI3bWNKMG9RZFla?=
 =?utf-8?B?YU10c1dMdVUrSDVNWWJ1bkxVNGNTMkxSenNtSm5rOFZMc0wrNUNLK2FoV1Vw?=
 =?utf-8?B?eWk4STVRNWkwbU5GbjFoc0NYelpmTEpER0ZvYS9OaU5qRnpOVkhPRnBEck40?=
 =?utf-8?B?U1FUYnRaQVVPL0o5emNIMVNrRFEzeUxLc2hJMkFGa0t6TmljVWgzQitVNmRW?=
 =?utf-8?B?czd4UUxIZ3BOWGt6R2lYQnBLam0vWFVDaDFSZStvY0lQYitlbXByZW1iMHkr?=
 =?utf-8?B?a0xYc1VRZEhScWtkZzB0VFBwcWh1VFJ4QVY1M3RyczZBVU9yNm1lL2U0bTUx?=
 =?utf-8?B?b3JacEx1Nmo0cnRxOEZoOEFYejZYK0FPZHUyaGh1amdCQnkycTZlKzhZSE9O?=
 =?utf-8?B?NHJhK3dLaXdjbzlwT04yVCs5MlRuWEJDUGJYS1pzS3EraUxSN1p3Vmk2SGd6?=
 =?utf-8?B?amhkYWh4UlN4RUhOZ3dFK2RWNkFYMEtWMjZ0V0svdUhaemxKRlNNRkt5Z2pr?=
 =?utf-8?B?QUgzWURTcSt1Q2FsY1MxMFlhQWpZakFTbDJNVFNoUjlwL2xaOUZ2U0tVaVZJ?=
 =?utf-8?B?cSszd2p4THlyTHlaVnJKUDlNMkc5K2ltS01WdzJFbkFRZjErN3VwUktsckk2?=
 =?utf-8?B?WlRndzI5enF6RmREd01lZXpORWI0STM1U3ZOQ1E1R3FZdTl0V0RKSGJMYnkr?=
 =?utf-8?Q?lIXdSlse0ijydLz3+QoOL9SYppzPHVmO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUFMQ05BN1V6S2N0T2o2aGdzdzlBeGhaellqd0Njb2ZYT0E5dmVQaTJ6RFM2?=
 =?utf-8?B?eSttWWh3NGI2YnVJMTZsYlFvVEhSS2thVEFFRllHbHR4bm9Kb2xWRDlUTi9L?=
 =?utf-8?B?cTd6ZXM1YjFEcDJMcERWV0svRSt3U2tVamNRb05oOWNFUGdENSsxTlcwcUpZ?=
 =?utf-8?B?bzJ4SnNLVFluOTk5S3h1anBVdGV2bWN4RzBGdnNmL1Vkc3d2Y2t1azFVdjBi?=
 =?utf-8?B?MXd1WCtEZzcwL3hSRTZ4RlBYb0cxejhJc1lFMElmYks4OExhbThaRTIzU05n?=
 =?utf-8?B?cUI0MVZJcU1RZmxPS0s3ZjE1ZEdJcVZKWm1jbk9LcW04ampHWXVqeno1T3ly?=
 =?utf-8?B?cWNhajNqeUJZTm1leGdVbkN1ZEM1NHBpTVVWSG01ZUlQNkpKUkJXNGhNL2Y2?=
 =?utf-8?B?MkRvVnlrYS9RdCtmajA5OFFvOXB3Mk5IdDJ0cnZMR0I3T0NLWWQ0TTNhbU9t?=
 =?utf-8?B?cVNBdmYzVjlheEZ4SWhwT2VSd3VVajJXTW51MmpRbTJkem8rZncyKzBpOWpO?=
 =?utf-8?B?czBIOXExRHV0U0dXWmM3VTVtMkZidWtDZXNoUHNOekRabnhlVnZiV0dqRHdX?=
 =?utf-8?B?bmloM0dick1xYzNIWXVPaG5kVW9WbXRJcld3YzRRclg3WWljcEZRSnR5L21Q?=
 =?utf-8?B?c0hBd1Ezbi93UE1BdEpsazYzUEpnamc3L1ZsWnNoZCszYjE3bW1MZmE2T1FD?=
 =?utf-8?B?M1pGbzNXaG5qSDY5Mk0wMUU4NkpOTllBNmhESmN3ZS9YS3QzQmp2WFJIeDBF?=
 =?utf-8?B?WHB0cGxrZzhWU3d3UnBRc0w5QStjY3hvRzRHakpjeHdGNk9rb0ZhNWtNUW5L?=
 =?utf-8?B?cDdJSW9TclUwZXlMVXR1dHIyazNOeVg4T24rbE5EWVo3QVh2MlhXQ2J1RDRk?=
 =?utf-8?B?NmRCaWREaHRZNUJKMWFabFcrWFpjYkY4cGt5amhHUG1FT1ZKUkJTbVlzTWFI?=
 =?utf-8?B?eG5JSFY5a0VsSTY4VUY5NnpydWhRNHArM0ZXU0NZaGZlQlBlYVJUSE1xOFV6?=
 =?utf-8?B?NnFSbGVTN3k0Qld4TWtiTkgzWU10U3ptZHlJMGFnblkxNThvN083ejYvZ2Iv?=
 =?utf-8?B?YjRjM3o4L216Yk8wZmIyblg1L3BMazdDdlJYS0Ribnc3cDd4TG9CVGFxSzRo?=
 =?utf-8?B?QjV0SXowN21zVVJ0QlhZaXJNODcwbk1pd1BTN2ZEc09FMmd0NjZtQUlDZlBu?=
 =?utf-8?B?RjVKQUFhQVROWTdHQ0RXK21vczluZ2w4SDBpT1JlT2xQRTIxOWFiK3YyRVhs?=
 =?utf-8?B?MWZvb0U0Z0pDbDVDUjJUdk5XN1VKYXNGV29GSU1ydHNkaTJ3QTFJUVpkKzlK?=
 =?utf-8?B?Nlc1bmpUTmRZeDRUd1J3d2IrZHRpTkdGd3JyWENrRUYrSXlGcVFvZVp4d1E5?=
 =?utf-8?B?Y0RKV2ZHK2U1UXg0L1VHWS9JbGhmMnNoR3NCN0p0UVJpOG55b0xObzFlS2Q0?=
 =?utf-8?B?dFV3Q29FUEs2UXRRVmFKV281NU5CRlJXeHptMUFvbWd1NEJtUHl0UW1Rdnk4?=
 =?utf-8?B?aUN6NHh0VXhrZGVHSlNIcEpWbm12eGhkcmtKendJcklVQUdudHJ3OFBMUUdm?=
 =?utf-8?B?V0hjR3d2WGY5ZmU1SFlqSlBIQWxGQWpOU3ZmUkd1Q0Zyc1RLN1FBN0doRDBi?=
 =?utf-8?B?UjJGdnc1clMzT1c0QUhLSC9JRDN5YzBBelBReFJKMnVyci9ndDM5UUtpbnVa?=
 =?utf-8?B?bUlrWHc5MW5VYmxaUGtHQ0ViM0pMWnFqS1NJUTRWL0pjSXlSeEc0dWwxY0Zo?=
 =?utf-8?B?MGYwa3BWQlNaU243NnJlL29SZUhBbnBMbVM3R3ExT3J0TVRML1VQRm9zd29G?=
 =?utf-8?B?RFQ2QmlrRTVJemFoNW80dVEzY1loOXAxZUpOQnZ4ckZzeTcrVkoxcWZIU2dk?=
 =?utf-8?B?aStaNHNnSkpvM3BERXcxa1NJblZjbGlINVJlelVLaUM3cEhLdllVTFJIU0do?=
 =?utf-8?B?ZGxnemFxdStGUkxSeWw2WDJHYmk4YW8wK2RPeXdpb2RjbE1jM3kwdzdpanp4?=
 =?utf-8?B?NXR5THJkNmRSdTFGZjZBQThQbmdma3pUb3lNN2cvSFFTUlZ5Vmd4d0pPcUhx?=
 =?utf-8?B?SHpLdktNYk9odEk3U3hhUFRQamplUHRPRFhyMElDdUU1WmhFdGZ0QWtiTmlj?=
 =?utf-8?Q?BxdtUZ5cUdvmZTpiYFenG/eVY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3310006f-fb8b-4e7a-a968-08dd67497e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 00:52:30.4457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEMuySCSJfARk2joU6XBEB8vVksA/pSVv1hc+jsd2blLpCdNPnAU+XAJXV/yqBrpALYJQlYrmyccKVW3eFBZcryJ2OThY98LMMy+NrH8eHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5291
X-Authority-Analysis: v=2.4 cv=d9v1yQjE c=1 sm=1 tr=0 ts=67db66d0 cx=c_pps a=ga136hzsjl6Lb4dqulp3IQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=GrruxrVxdQvD-3H2dT0A:9 a=QEXdDO2ut3YA:10 a=Qzt0FRFQUfIA:10
X-Proofpoint-ORIG-GUID: gYH1Hg2Q43rWA29490BqUTz8IGbPfPKf
X-Proofpoint-GUID: gYH1Hg2Q43rWA29490BqUTz8IGbPfPKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_08,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=757
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200004

DQo+ID4gKyAgYWRpLGRvdWJsZS1vdXRwdXQtcmFuZ2U6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoN
Cj4gPiArICAgICAgQ29uZmlndXJlIHRoZSBvdXRwdXQgcmFuZ2UgZm9yIGFsbCBjaGFubmVscy4g
SWYgdGhlIHByb3BlcnR5IGlzIHByZXNlbnQsDQo+ID4gKyAgICAgIHRoZSBvdXRwdXQgd2lsbCBy
YW5nZSBmcm9tIDBWIHRvIDJWcmVmLiBJZiB0aGUgcHJvcGVydHkgaXMgbm90DQo+ID4gKyAgICAg
IHByZXNlbnQsIHRoZSBvdXRwdXQgd2lsbCByYW5nZSBmcm9tIDBWIHRvIFZyZWYuDQo+IA0KPiBZ
b3UgYWxyZWFkeSBoYXZlIGFkaSxyYW5nZS1kb3VibGUuIEl0J3Mgbm90IHVzIHdobyBzaG91bGQg
ZmluZCBpdCwgYnV0DQo+IHlvdS4gWW91IGhhdmUganVzdCBBREkgYmluZGluZ3MgdG8gbG9vayBh
dC4gV2UgaGF2ZSBhbGwgYmluZGluZ3MuDQoNCkFwb2xvZ2llcywgSSdsbCB0YWtlIG5vdGUgb2Yg
dGhpcy4gVGhhbmtzDQo=

