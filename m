Return-Path: <linux-iio+bounces-18975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06227AA6E03
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6411E17F273
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2152822E3F9;
	Fri,  2 May 2025 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GE0N+Hws"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69C22CBD9;
	Fri,  2 May 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177865; cv=fail; b=qbdCLD/5Mv0z/HERiHFvtNGtGClGIl9AO43xLgWwCXC732BgEofPT9CifHiAtJ5vZp0pU/2oz4SBgS54Pjo6e85duVCrJNXEpMns9MfBEm4opJzSQ6poD/PY0Se3SUHOX+0AbP6T5yV7EtYRxC1DgNotooKqtt5anrBypTCXGBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177865; c=relaxed/simple;
	bh=QgY7NoSrvhApm+V9OkvtAUrEqi9RXAnzPg0SDLtA4GM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZScavoPaK1832uqRe4tcWSM4DAAmgZL8GlSSSHcd7UnLxiiimaAyvVxIg4Zf4Z5wTgednmzzVszF+nVaOc/04gq+50NxsCDeW9WrWMIj9EXdGxZgO6lObEctfAnkdOk1TIusPLqnGCJQ8jv2N0PW7Jrd+geIOIbZhIkedQfPiho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GE0N+Hws; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P05fBWB19JGgur7zLz/APUg5heC9Gc7GOIxoemMhclJ82NAvZExQgDLWXx/z2uaZckIJDFHFUYb1X9OsmlfOD7r1XWZGGnOpH5qbsFErKjASxNj6O1aPmNMn0AdPQi0AXiKoRkGxGywkiipUJqwupATlayQv2k1rA3/a6AqpNTjhh+lzWPrctUI7oS15yWOJ5VMCjSucjZ78xt6ef/nbNfctM6MKKpmt4smWK3i/9Mtj9kOxUWLqkXfJRnY5BElBduN6kgWpx9BPEDkmLE+W+7X7X86vLU9zTYFWK7BJUiKD4eCd0vRUQeN4kdkUpngaf40g64iluPFBx3lom6KSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgY7NoSrvhApm+V9OkvtAUrEqi9RXAnzPg0SDLtA4GM=;
 b=p3QDLkO5dUMmNqGG34n/Al+8W/2oE0clfKNZk1mABN5KYEcQkF/QMP6C1i8F8T5Vd91QFdWj6tjWMXpcZg7S2NfhitFFjIWzKu4cnJMJmzoIyuomTqiuHmwPpTur47IDhwDuaxh4gncOtN5ZliS2XYMjQ1BETZJTET5j4DEfrgRI6wSj4FkwcRDhLdQQz87G0cd19iiWTVJWwTgDLWnhVP/vWslHz2LMQJ08gqfNdggndv1+ZnvYQ/R8gZcJEKcw7ujOZ+XYgZdyohnYVH+vttavyD5ipwLi5r/UcWDmgs3jEPKV/wbKQNLI0+PwqWaLcgDuOQ22Bc+avQn3exFtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgY7NoSrvhApm+V9OkvtAUrEqi9RXAnzPg0SDLtA4GM=;
 b=GE0N+HwsCFrjXY2H34ldqdKfEEzabfZWoPd/YtFOW02ddOWKt5SJBpptO3/0/bwTRcEBmLxzwH1Rmi/yaXBql6ynpVCq7LEZCP2cp5qATQVK+7EIOodoE6jGLi3q5jq9JXT38tf7+sA2JMqqufyf2c+PXFawuFyk3xqYR17F4YGmpwRK+U4SPp+7BijdJ+FazURmEf2DHK4/0ez8BN6Yy5vzSznDmWBExZjm+JvyZcEMUCjrGkyuqriKNBOHMTKYS1ZqVpPgBG/hkAsVZQ7w3owMgXMFRCia57X3RctO5oCpFZhU0VAlu2R+iri9oIBIA2YqTI/v47DRykqTahPieg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB7147.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 09:24:20 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 09:24:20 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wbg@kernel.org" <wbg@kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
Thread-Topic: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
Thread-Index: AQHbols1IQCg12nyIkObbOMtTeq9k7O/Q0EA
Date: Fri, 2 May 2025 09:24:20 +0000
Message-ID: <8394ef31a75fdf9122331ecb97dd6f986d5026f1.camel@siemens.com>
References: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB7147:EE_
x-ms-office365-filtering-correlation-id: 1c18df67-47fb-4697-fcb8-08dd895b1ecf
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1R4SC9DSkF0eG9BTVBmVTRLZnlzaVRyaFlwTXhlcEtsc0RSQlZvc1ZrMVo0?=
 =?utf-8?B?eHVZeDRCZFdPM1kwQmh6VHJ4QWMzcEMzSStNTFJDMCs3YndTWDlMZTFiTi9O?=
 =?utf-8?B?RGgvVGFZMEJkeWJWc0duZWFrN2tNOVBZWGxXdUVpODM5Ri9RemF5Y0I5WmtD?=
 =?utf-8?B?MUM2Vm1sN1NmY1hYRjgrTUhjd25kUnFBWFQvVWgxRHlkYUlMR21WMzRYWHhv?=
 =?utf-8?B?ZUJWTUhzbS9XTVRyZDBmdzVmME1Zd3U0QWNnSGx0Y2tQeEl2S0l2VnNONzVp?=
 =?utf-8?B?U2UyUHBOUFpqWXNHNWgxZWY4UFRHRlk1dmdka1lwclppR0lRRWg5R1N5d2Zo?=
 =?utf-8?B?M280Y3A4aXlQbU1zeVpya3BXYXRiNEhFK2NOdlRPVFBxdlhNY29ZaXZzNUtl?=
 =?utf-8?B?SlB1b0d2bXQrQXkvK0lvMjJkMUNnSnhPYmw0MW8veTdwMFZUaWJ4ay9mK3lj?=
 =?utf-8?B?dUxla3k2aU5Ga1E2aXdkRzhTZ1dxcUNWSUZwcXNxOFZJeHFJUjhzWnR0V3Vj?=
 =?utf-8?B?RndJN3JPWDNmTVlGZDR0cDB2eXpJdGxvRVJFSEpyeHZTU3BENG9zaVltcnA0?=
 =?utf-8?B?eGNucWdHR0JTektvZG1URy9ST1liK3Z4REZxQ2pvTUFxcGRHWm5VRjdDcjZW?=
 =?utf-8?B?S1B2UWNRZUw0Sk1reHhoemMyTjl2M05PQkw5V1lmdjd1TjJCSmtmZnNXelpy?=
 =?utf-8?B?aHFVNkY0bld3dldDZ2xpU3JsWVZkNEVYNmtjd0hibDlJN2ZGSXptcGpaYlpT?=
 =?utf-8?B?SitSUmE4RURJK2J3YmJIOXFCcEUrUWVNTGZ2WGJwU0Rpd2xMK1RETEZiVmMx?=
 =?utf-8?B?aXpSU3lJa2hodWNBZ2hXNDVqRmhuVTJsSzN6aVNiQklWdW1KTzhCaVFkQmRo?=
 =?utf-8?B?aytYMUZpYmxDR1RHUk1lWEw2OHJ2dzlxUWVnejJQdDNzQ3o5RGtKSzVabkl1?=
 =?utf-8?B?OWZSTWdkV0NnWE5tTHlSRCtnd0NpVXhYdmgyUzRFaWROaGM4bmZxR25SaTQx?=
 =?utf-8?B?eXVxVnZpanMvcjI5eXY0bVVxY1dDME4reVpwYUtJWVdzVnk5Q2xXRjdUbWxz?=
 =?utf-8?B?VTJ6MWxKd1JrZC9WakhCeDNzOTJFUDN5ajN0NzdhMkJnOHhucmhGNmt5citw?=
 =?utf-8?B?TGhGSkszQ2JnbWMwSkp1S01qZWNtc0VGeW5XWlBQUWtmRUJGRmVtSmNES0pB?=
 =?utf-8?B?WERWaHc5Vm9BNGJrMEVhVHZzRGpOcEk1OWZxUHZXWlRXcjN6QldKU1B1bGNk?=
 =?utf-8?B?RXpDNHkyT0Nzd0VBRDhIUU9vUDloM1NzUFJtekVDS1NtMW9kNXFTYmtVdzE3?=
 =?utf-8?B?YkhnSVVLUlVkcFlHVHdieUkvbnBMU0s4TFl6NzB2U2lyM3Q5TU5abDBRZmlh?=
 =?utf-8?B?elBTZzlKUGNZczhWblR0dGhSUkVBWExlNkhVVjhKUTR1UkhINkY3ZEorOWxz?=
 =?utf-8?B?c2o2R25PUjVXdGRpOHVyUGpNZlZKYm1oK1k4b0huWWl0cjM3enVmdzlnWTJt?=
 =?utf-8?B?UDE4RVczb0orODVJdkxHNXprcUZxUnEwRG9lVzlrZzVibEVZcXgwdGttWjMx?=
 =?utf-8?B?Yk5va0VpWGN0Zm5oNHNuVWpUbzBQMjl3SDFmUGdrQngwR1lQTkViR2FKaXZx?=
 =?utf-8?B?UkpIcWV6SndZRGVZeFowbHoyV283K3Avd2JTUXp5cHZEVXc1UERsT3pZSElK?=
 =?utf-8?B?LzVEQXo3TXJ1bFFYQmM5aVBYQ0x6WUZiRGo0SU9WTXE0MEY3UTRFNWt6ZXBR?=
 =?utf-8?B?RzFpV1BITHlFZVRkTG40Wm1ON044UXdaeXllTTNpVmRaK1o2Y3VHbmQ4MU1o?=
 =?utf-8?B?b1BJc1dOOWpOOUVKM1NBV2JTelNVcjFYbEFiL2I3VmJucjBFZHlVMExya3d4?=
 =?utf-8?B?R3ljVDhRYmdlZmJOWmdCbXN1K2NlSTdKbC9OZWdIN1E5T3FnYytSWGdBWU5j?=
 =?utf-8?Q?+GwqQmjnmVQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHdRQU5ORzk1NUpHemh6QXRtdCtyTVhrdUphZVZKWVpDb2hjcERXQ3loUEYz?=
 =?utf-8?B?WWh6WlpTSzdMeFZkNjdQMjlpNXB2NUN4bFN5S1FnUVFMeWsyOTl0NEp2eVZM?=
 =?utf-8?B?NWRrc0I0N3haV2hDQm9LejZXVnUyNlZQWnRIYkFPaFV3WHQ4enRlRk9DS25D?=
 =?utf-8?B?TmJwTXc2TStSYWlHbTBDZG50YlVqMkF6WXB1WlFONElBb3hJRlgzeXYvOXJ5?=
 =?utf-8?B?dXJnRXJIRXdySVBkbno1N20zVm9zUFk3U2phZXEzT3Q4R1VpaTZlc2NLRHNK?=
 =?utf-8?B?Yk4xNHVDNExrVzJkQkQzQXZaWnJjcHlJZFN5SVh3dHQ4eVMzK3lRekJPZHRn?=
 =?utf-8?B?WEhCMGVHOXdnVGpiY2hEREluamEzMkd5aXEwNWFOb1M2RlhXTExYK0t1S3RP?=
 =?utf-8?B?Sm1XY0NBNE54c1JOVm9UUFVRaW9Zc3NScXNVUVl2SU9WWGp6dmsvUmtvc1ll?=
 =?utf-8?B?WExWTituc2JMWDBQcVd0ZjdrY1VUK2F0UGYrWlJRMlRXMUI1d1NJTStPMFRG?=
 =?utf-8?B?UkVFeGExYjU5T2NuY0FkWXJxMEN0Vmo0aTNpQXRsS3FGd1lLQnJiYkRGZVRS?=
 =?utf-8?B?bHVjNXFiYTVCOUxLYlNkK0wrMnNJU2IyYlhMZUo2UjJPc1RQZUFMVmQxZ1Zl?=
 =?utf-8?B?OFBBb2txTjFqVFFRV0lVMU9USVZGYndINDZZR2tKU0oyQ2xzUHZuZDlram91?=
 =?utf-8?B?cmxtZEV2WVdYVmFOZTl0a2V0SjFOcjJ0S1dVY050clBzK0tvcDl2WjJvdWlC?=
 =?utf-8?B?ZVdORlEvMmNFSFVHSG4zMXVadXJBL25GRU1YU0FmdDZ1Y0dsbERyR0NvbmRz?=
 =?utf-8?B?c25oWTljWWE0RCtrcFRRYXpmSkh0VHM2NmRJdEQ4cFJZTVUrZ2dEeEFlbjE3?=
 =?utf-8?B?QlI3c21UVDRQdXVjMTgxZTZZQW1SajhoMzFRaW9xcHBmdHRmU20wTDk3WTZw?=
 =?utf-8?B?WUpoVWlqamY3eXpmNnFjUXJrVU9sS0JTY0U0aHlPSC9zRUlZT1huQXNsTHBk?=
 =?utf-8?B?VURDaitXYnRCeUJBOWozYjVlb0lTL254NWNWSlZyTS9BSWRpMTFkODhsUm5m?=
 =?utf-8?B?YWpWcHVOMWZoTXdqSEx0SkpLMk5xckhBcThRWXdUV0VxNFd2WXJwTjNCeGNi?=
 =?utf-8?B?UDg2dGNBa0NTQVp4eVpBamlvU1FJYURiMURFWDg3Y29vajJmMmNWUUZZazZZ?=
 =?utf-8?B?bFYyWFJYY3FYMkd4OWpVYTNEWHBnSzdaQ0JPK2pEMVpNaVRiWm9VN3krMGNY?=
 =?utf-8?B?L29ocXRjRE44UkkyeGplc1FldmFlaTNuL1A4SVNEalFCUUVvZE1CNmxmM1Jp?=
 =?utf-8?B?Ujg1Q2ZKckJQZmt4WjVGbHVkN2orVkx3dm9KOWNKMlhGWnlES0FTSjBBSzBX?=
 =?utf-8?B?RXorazA1MzAya2F5TW9JcHpkZGMxZHlEM1lyWG44YlQ4V2JjNGdPQi9LSDRE?=
 =?utf-8?B?QmNybVZXZVZPeHpCdkJscURZWW9lWUFKNFdscTBaNUxoU3ZlbHdKWXBKd1A1?=
 =?utf-8?B?YXgrR3hGRUd0bmZ0TWZnVTNlekJySk9LTkl3ZE9GK0ZicjREVGk5cllWTjNR?=
 =?utf-8?B?ZWZ5UUVaV1BpNXlUalBubkFPLzFjRVlsRFlUckw2UDJiZDEwbE9mdjdpcVc5?=
 =?utf-8?B?RzI2VmNFWGYyWmNsQXRUdC9ISlZ1bGtLZWRxb01KbFJodElSbjZRdmNTMW5Q?=
 =?utf-8?B?NUxISHFTNEZYZG5nS0VQajQyN01JMU1QVzVZclljeWR1V2ZsV2w2eThpcFNw?=
 =?utf-8?B?L25XQzJpNnV0S1FtbE0yNTNybis1QnA3blV5eENFRWtNSmUxZEYybjkvOStI?=
 =?utf-8?B?TWh2VDkxWW5FcjJDY1ZoeGpRNFByb25CaWF6Tlh4Q2V6ZVRqTjlZQ3lNajg0?=
 =?utf-8?B?VnQ1RU1BSnlncWVOaG5xMElWVHB6Y3FiMmdZVVhPVUlpN0xBS25SbnFxdzV6?=
 =?utf-8?B?V0lzaTBvWmR1Y0Q5UG1BTkliRE9wQ05mUjIySHhVL0UrV3oyb1N1N1N1cjBo?=
 =?utf-8?B?YlNxMzc3VHpoN0loMU5jeXd2dGpxQlBocWtGU0VXS0s1WmFKTG1CUityRisy?=
 =?utf-8?B?R0FSTk1tRnRyQVU5U3Q1YkM2b1ovZ0ZwejJWMVZqR00xNGF5RTY0bi9RZjY3?=
 =?utf-8?B?ZUFKajBDelcrZ21BNzZtNHdJbWp1S05LUU8yMWQ1c3lGSERjaWM4WXNVbUgz?=
 =?utf-8?B?bUx2Mk5YRHlua0s4aDArMWlCQ3NjNXFnbVNydzVYSGNvNU1McW1jK25CTlZK?=
 =?utf-8?Q?iduGD78CfrkxZE5Ixug8f50L3EMRy2D5siH/up9qzI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD179D3C2520DC41AD8916B891F8106F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c18df67-47fb-4697-fcb8-08dd895b1ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 09:24:20.8003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJEpyBeNKbx2vJvDVYXyY2dQaDmz3B4rP38m5dB5TWStfPJqaVmqIF8jR4wTxCdNgODCQ2hhEe+YAH3wNAe1ZYp9dmhg09Rn/qUl0P4quyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7147

RGVhciBtYWludGFpbmVycywNCg0KT24gTW9uLCAyMDI1LTAzLTMxIGF0IDE4OjM2ICswMjAwLCBB
LiBTdmVyZGxpbiB3cm90ZToNCj4gRnJvbTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIu
c3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+IA0KPiBFbmFibGUvZGlzYWJsZSBzZWVtcyB0byBiZSBy
YWN5IG9uIFNNUCwgY29uc2lkZXIgdGhlIGZvbGxvd2luZyBzY2VuYXJpbzoNCj4gDQo+IENQVTAJ
CQkJCUNQVTENCj4gDQo+IGludGVycnVwdF9jbnRfZW5hYmxlX3dyaXRlKHRydWUpDQo+IHsNCj4g
CWlmIChwcml2LT5lbmFibGVkID09IGVuYWJsZSkNCj4gCQlyZXR1cm4gMDsNCj4gDQo+IAlpZiAo
ZW5hYmxlKSB7DQo+IAkJcHJpdi0+ZW5hYmxlZCA9IHRydWU7DQo+IAkJCQkJaW50ZXJydXB0X2Nu
dF9lbmFibGVfd3JpdGUoZmFsc2UpDQo+IAkJCQkJew0KPiAJCQkJCQlpZiAocHJpdi0+ZW5hYmxl
ZCA9PSBlbmFibGUpDQo+IAkJCQkJCQlyZXR1cm4gMDsNCj4gDQo+IAkJCQkJCWlmIChlbmFibGUp
IHsNCj4gCQkJCQkJCXByaXYtPmVuYWJsZWQgPSB0cnVlOw0KPiAJCQkJCQkJZW5hYmxlX2lycShw
cml2LT5pcnEpOw0KPiAJCQkJCQl9IGVsc2Ugew0KPiAJCQkJCQkJZGlzYWJsZV9pcnEocHJpdi0+
aXJxKQ0KPiAJCQkJCQkJcHJpdi0+ZW5hYmxlZCA9IGZhbHNlOw0KPiAJCQkJCQl9DQo+IAkJZW5h
YmxlX2lycShwcml2LT5pcnEpOw0KPiAJfSBlbHNlIHsNCj4gCQlkaXNhYmxlX2lycShwcml2LT5p
cnEpOw0KPiAJCXByaXYtPmVuYWJsZWQgPSBmYWxzZTsNCj4gCX0NCj4gDQo+IFRoZSBhYm92ZSB3
b3VsZCByZXN1bHQgaW4gcHJpdi0+ZW5hYmxlZCA9PSBmYWxzZSwgYnV0IElSUSBsZWZ0IGVuYWJs
ZWQuDQo+IFByb3RlY3QgYm90aCB3cml0ZSAoYWJvdmUgcmFjZSkgYW5kIHJlYWQgKHRvIHByb3Bh
Z2F0ZSB0aGUgdmFsdWUgb24gU01QKQ0KPiBjYWxsYmFja3Mgd2l0aCBhIG11dGV4Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2ll
bWVucy5jb20+DQoNCkkndmUgbm90aWNlZCB0aGF0IHRoZSBwYXRjaCBoYXMgYmVlbiBtYXJrZWQg
YXMgIkNoYW5nZXMgUmVxdWVzdGVkIiBpbg0KdGhlIHBhdGNod29yaywgY291bGQgaXQgYmUgYSBt
aXN0YWtlPyBCZWNhdXNlIEkgbmV2ZXIgcmVjZWl2ZWQgYW55DQpjaGFuZ2UgcmVxdWVzdC4NCg0K
PiAtLS0NCj4gIGRyaXZlcnMvY291bnRlci9pbnRlcnJ1cHQtY250LmMgfCA5ICsrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY291bnRlci9pbnRlcnJ1cHQtY250LmMgYi9kcml2ZXJzL2NvdW50ZXIvaW50ZXJydXB0
LWNudC5jDQo+IGluZGV4IDk0OTU5OGQ1MTU3NWEuLmQ4Mzg0OGQwZmUyYWYgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvY291bnRlci9pbnRlcnJ1cHQtY250LmMNCj4gKysrIGIvZHJpdmVycy9jb3Vu
dGVyL2ludGVycnVwdC1jbnQuYw0KPiBAQCAtMywxMiArMywxNCBAQA0KPiAgICogQ29weXJpZ2h0
IChjKSAyMDIxIFBlbmd1dHJvbml4LCBPbGVrc2lqIFJlbXBlbCA8a2VybmVsQHBlbmd1dHJvbml4
LmRlPg0KPiAgICovDQo+ICANCj4gKyNpbmNsdWRlIDxsaW51eC9jbGVhbnVwLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvY291bnRlci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9p
cnEuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2RfZGV2aWNldGFibGUuaD4NCj4gICNpbmNsdWRl
IDxsaW51eC9tb2R1bGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tdXRleC5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+
DQo+ICANCj4gQEAgLTE5LDYgKzIxLDcgQEAgc3RydWN0IGludGVycnVwdF9jbnRfcHJpdiB7DQo+
ICAJc3RydWN0IGdwaW9fZGVzYyAqZ3BpbzsNCj4gIAlpbnQgaXJxOw0KPiAgCWJvb2wgZW5hYmxl
ZDsNCj4gKwlzdHJ1Y3QgbXV0ZXggbG9jazsNCj4gIAlzdHJ1Y3QgY291bnRlcl9zaWduYWwgc2ln
bmFsczsNCj4gIAlzdHJ1Y3QgY291bnRlcl9zeW5hcHNlIHN5bmFwc2VzOw0KPiAgCXN0cnVjdCBj
b3VudGVyX2NvdW50IGNudHM7DQo+IEBAIC00MSw2ICs0NCw4IEBAIHN0YXRpYyBpbnQgaW50ZXJy
dXB0X2NudF9lbmFibGVfcmVhZChzdHJ1Y3QgY291bnRlcl9kZXZpY2UgKmNvdW50ZXIsDQo+ICB7
DQo+ICAJc3RydWN0IGludGVycnVwdF9jbnRfcHJpdiAqcHJpdiA9IGNvdW50ZXJfcHJpdihjb3Vu
dGVyKTsNCj4gIA0KPiArCWd1YXJkKG11dGV4KSgmcHJpdi0+bG9jayk7DQo+ICsNCj4gIAkqZW5h
YmxlID0gcHJpdi0+ZW5hYmxlZDsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiBAQCAtNTEsNiArNTYs
OCBAQCBzdGF0aWMgaW50IGludGVycnVwdF9jbnRfZW5hYmxlX3dyaXRlKHN0cnVjdCBjb3VudGVy
X2RldmljZSAqY291bnRlciwNCj4gIHsNCj4gIAlzdHJ1Y3QgaW50ZXJydXB0X2NudF9wcml2ICpw
cml2ID0gY291bnRlcl9wcml2KGNvdW50ZXIpOw0KPiAgDQo+ICsJZ3VhcmQobXV0ZXgpKCZwcml2
LT5sb2NrKTsNCj4gKw0KPiAgCWlmIChwcml2LT5lbmFibGVkID09IGVuYWJsZSkNCj4gIAkJcmV0
dXJuIDA7DQo+ICANCj4gQEAgLTIyNyw2ICsyMzQsOCBAQCBzdGF0aWMgaW50IGludGVycnVwdF9j
bnRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlpZiAocmV0KQ0KPiAg
CQlyZXR1cm4gcmV0Ow0KPiAgDQo+ICsJbXV0ZXhfaW5pdCgmcHJpdi0+bG9jayk7DQo+ICsNCj4g
IAlyZXQgPSBkZXZtX2NvdW50ZXJfYWRkKGRldiwgY291bnRlcik7DQo+ICAJaWYgKHJldCA8IDAp
DQo+ICAJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiRmFpbGVkIHRvIGFkZCBjb3Vu
dGVyXG4iKTsNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVt
ZW5zLmNvbQ0K

