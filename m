Return-Path: <linux-iio+bounces-5675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22AF8D8217
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 14:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67815284C4D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 12:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D713D12D1E7;
	Mon,  3 Jun 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="X2RRG2Rr";
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="X2RRG2Rr"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021010.outbound.protection.outlook.com [52.101.186.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E412C481;
	Mon,  3 Jun 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.10
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417147; cv=fail; b=QSpXGK1bk1hsklj9+1kI/MKmSlrBlqvgLg3gDUVD6aA4J919al4lUdnKpJ6gAeERK9TU92R98TQU6Tswh/TYgNleAnhTmyGAaVmNNm0C3Cp5i13WsMdKHPA9eXAlYHFF+1iESKR1CYMOhXUJAw0QDc/DrCCUJTf8R1pJmEU6Zbw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417147; c=relaxed/simple;
	bh=JXPCt3CFd3MDMF1VRKXDgCvP7ol8bauIRVdZWd5salw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=alWwkStbm8s4p+q6w9EiL0xzAXJWSwFUtc/5GF1meCurczDbr+9c6+AzWNzBqKFwVR07v48qQNhASdhY6mNcwgn6gxjiLMf1CGIbEVL2d7sgy24IJjkardHUiFd3zGTM3k3+GdH0qRggCNozFUNXDMsC3MYD92cayAdiLPxdrWU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com; spf=pass smtp.mailfrom=sentec.com; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=X2RRG2Rr; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=X2RRG2Rr; arc=fail smtp.client-ip=52.101.186.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentec.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=IRFIOJVF6JbVvq52DK1vkUQHei0/7/hYQCcRcm9RUhy404o1hDPNGblEh83v/RLIopQjmdDxsF2H0Fx0sFWhmmAwL5aq1tttjxHEnkeGO1ywEzseb2SF/uIJ8ntjTqnjSMpLcCUT+Gl3SevC2X6oaoqPaN9WcWCUZ/55LDXwcl7aJoYwNVTOdBohP6dpIpQcoSn3sZvXGtcUrZYedRtlI4RWTh6Zx8hDfDW8vIap7tqxS6Choy9R+RNxkvnQCD9+KRkNxSbU5MIxFJVfIxEW0KeTTqwMrgl/zi1BOkyiW/wqPw6wZhqhAYS3XuCB0K1HsKmrwUVSM6SQJREKX4+wmw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLUSf/8nxA9DzQJxWSME9uFdY11WwyTRs28O/xNlNi8=;
 b=G3hW5VSByqt/4o2EySFOxdQIk7OLiQN/roGHbAhle8I+RRGEr07XUVcGPFALXOFXH9uceQ0YGezT05f+2sfSSXGW8Bdz2VdDFyqgGwUV6aaJO5LAzzaa8s7R92gYOrYm3EEDDOZLCX7IMrnxDY0yc42xICRBhkoIovsxHPu28eKQeW6gxZylMo6PL2jDGCd/AS1F4osYhBvm4DPB8q3cG6fuksY2YAvwrp8iJRlL/sj1j+M4keHYRU0KuQWyblcsZwFOhjZMcBXvVp/QCOPs2mk7XMtV360viKnNU5owIJ1egsV+gDvq/7QB1t28c8GdTBvYqEEaRtecDfcxKIK0/g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=kernel.org smtp.mailfrom=sentec.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sentec.com;
 dkim=pass (signature was verified) header.d=sentec.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sentec.com] dkim=[1,1,header.d=sentec.com]
 dmarc=[1,1,header.from=sentec.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLUSf/8nxA9DzQJxWSME9uFdY11WwyTRs28O/xNlNi8=;
 b=X2RRG2Rrp3uRM59oT2zVuxklIkoKMefsJ6gLirFsaSlV3GCBB8DdpZCH8+QZob9KIcQ1UAk29cWXUAVqpFCtIK7efo6FnR8Lugmt/jMB+hLQzPtnKVr2tjAdyewMsuXJ40h4nZvcOu8rwS6VO8hA+ajgBcfVaTTyg8svwHUfxDc=
Received: from AS8PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:20b:127::20)
 by ZR1P278MB1659.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 12:19:02 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:127:cafe::54) by AS8PR04CA0135.outlook.office365.com
 (2603:10a6:20b:127::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Mon, 3 Jun 2024 12:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=sentec.com; dkim=pass (signature was verified)
 header.d=sentec.com;dmarc=pass action=none header.from=sentec.com;
Received-SPF: Pass (protection.outlook.com: domain of sentec.com designates
 52.138.216.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.138.216.130; helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 12:19:01 +0000
Received: from ZRAP278CU002.outbound.protection.outlook.com (40.93.85.1) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 03 Jun 2024 12:18:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5SdpeJ4YTf85kwxI1eOEp4Uw1QC+zefxu+GEhpGRw2T6zzEHSs0B7kkBfP/wAeyUbuZZA6RqyYN+or7bd/45/SEYxhQUlza1ZMMpmaZvnPKlxqhu3/bA8b9brM1tbOh0Yf4+r6G/4anZG4qDwMHQa2I4hgGcJnijjBwn7k4qoaCXjmA2Y7HftH5ERK7fOtijf9HssikwIRzKtLxul7g1VSa5q2PnxE5R+BSPgOVTzEmAVysdDcPK/lawKpdqmHN9qPvHAnjA9938wchkGKkTf5jzOFEJEXH/Bv6DnTpGtqgKnHBmTj1rmyb/so4DBJyzOk4CCpOzdNlGpgexsprfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLUSf/8nxA9DzQJxWSME9uFdY11WwyTRs28O/xNlNi8=;
 b=WTYGH8GXJrbtCml6Ru1ZWLKwe7XsKZHV81oC89qEEsUh8+xL+o7ifZzxw87ViEbPUeZPRvbLqfcZ1fpq6iJlGP7TniMqxpKiVbFW/GidzIV+k07ke4k1e5/6PrDcjpvaqNHipITVUVKv5L6J8RE4ONI/Al87zydBl0ysHCLUKJmfPK7okSv1akdGsTsPTGCseT7lypr5YrtNqPxDnQhIOaDXfqDj0whJ+IFN6I3KkrQWv1x+/gcHHVWUcEqMskURGFM3vtTAAA3lP04dssbVXgIn4a8AreYPyr+AWBIsx9gMYDENSrOM2Pc2PXSg1DvJ13d7X8QwBABD3++qzjDw8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sentec.com; dmarc=pass action=none header.from=sentec.com;
 dkim=pass header.d=sentec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLUSf/8nxA9DzQJxWSME9uFdY11WwyTRs28O/xNlNi8=;
 b=X2RRG2Rrp3uRM59oT2zVuxklIkoKMefsJ6gLirFsaSlV3GCBB8DdpZCH8+QZob9KIcQ1UAk29cWXUAVqpFCtIK7efo6FnR8Lugmt/jMB+hLQzPtnKVr2tjAdyewMsuXJ40h4nZvcOu8rwS6VO8hA+ajgBcfVaTTyg8svwHUfxDc=
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::13)
 by ZRAP278MB0159.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:29::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 12:18:58 +0000
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f]) by ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 12:18:58 +0000
From: Arthur Becker <arthur.becker@sentec.com>
To: Jonathan Cameron <jic23@kernel.org>, Arthur Becker via B4 Relay
	<devnull+arthur.becker.sentec.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: light: driver for Vishay VEML6040
Thread-Topic: [PATCH v3 1/2] iio: light: driver for Vishay VEML6040
Thread-Index: AQHatbA1bd7ZOnV2z0CXec3QsFCsOg==
Date: Mon, 3 Jun 2024 12:18:58 +0000
Message-ID: <ZR1P278MB111719C989666990EB0B4D5E81FF2@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
	<20240527-veml6040-v3-1-6f3bbfd42960@sentec.com>
 <20240602142205.520c2635@jic23-huawei>
In-Reply-To: <20240602142205.520c2635@jic23-huawei>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sentec.com;
x-ms-traffictypediagnostic:
	ZR1P278MB1117:EE_|ZRAP278MB0159:EE_|AMS0EPF00000195:EE_|ZR1P278MB1659:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ee956d-06be-4f66-0414-08dc83c75a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?n43yRivs7bfH++exO1XFuP3OpHLbs2q8+uaYY39Micjd/E2oVluBCKe/FB?=
 =?iso-8859-1?Q?PARq1G+K9Uuvusf1bu1CvhpxuC6wgBbI8YFUoHtf4xlwEIZLd1i34VWWtD?=
 =?iso-8859-1?Q?cw+a6dx5I8x8vGhM3UR8afmWUsjxdzCq17zRLhfOi6nXcLIywz5WHkzukF?=
 =?iso-8859-1?Q?xHhSHJUMUTbzxWdDuGhPT7C0TCYj5vske+oHSLYcz5uN00z9kQ9Snzys0C?=
 =?iso-8859-1?Q?Poi6kLgai10+tXVi0tdJ8okX6driDSmsj+4jwd9bbR5lacEWcf0Q8jnJMD?=
 =?iso-8859-1?Q?Zj9hgkfxZG2QfUsPPSi7lPBIwo8IknNz0aSCWF3RH1Ri596rSdLTz0Ewm+?=
 =?iso-8859-1?Q?HV10JuUaKDEYzFImKcSdTWZZ7uFYSm4Nv8mEys+B2eOPcrb9Gx50AtDS3e?=
 =?iso-8859-1?Q?x4ewM+2/jKAhkQpN82/1gaeTKTujjelAygEzBBW+XAy0dfkgzmuXFPBg56?=
 =?iso-8859-1?Q?23CcEVPln/r23piWVQZc3CDjrRaFdLf4LdrpvLTTy3Oh+IptzTSo9ebgie?=
 =?iso-8859-1?Q?Z55cOfvVSmuMTlB33H0vEp1VcBsRmMCFyY2e1cSg65HOhQm1gcaacB8ZZh?=
 =?iso-8859-1?Q?NlBdeJXjdzJ5lB4bSuT78/ONODO2jzuuAD3V0Gb3ayMywHH0He3WW07cKm?=
 =?iso-8859-1?Q?AT5RHaKA3aJyyPNF4ab8YMXZT6K6huJZDktHKc9A1XfLfoVJkJBq/eilXf?=
 =?iso-8859-1?Q?WLue46wd9ZHxincKrGf245uWbztRnlyGs3riQvrfUEV3tRZe78NtyslbAK?=
 =?iso-8859-1?Q?dflpxbSW8+u6N8SsGId3SKXg1gAGkCBlHI0CdPNncmWekk6fZ/R+aRwXOi?=
 =?iso-8859-1?Q?E06mcOC3b38bGq/qLaLBrYKm/c4vrR9mGCyd8WS9E3FiMjWUCZhqe+OfFh?=
 =?iso-8859-1?Q?jhtQxGIHPqJy1+zLBA89ry9muY2hsrL1J+2t6CLhqg28yV7dkZ64UO75a9?=
 =?iso-8859-1?Q?Rdbmy3ChKvj1ZtbiDHFiKmTyUdsay2MAapevWww5zegWTXGbxV8SplJTFu?=
 =?iso-8859-1?Q?d85xRerofUS/jAsF27E1MyMRN4oT6dToQaf/y70ZGdgiqNw7zhl4hXfNsR?=
 =?iso-8859-1?Q?qGFWwZ2qze8fcb/jDV4a/SRDwVDb9yRzuRF577Z5gV11Ap2bQVAjpN4Xrs?=
 =?iso-8859-1?Q?ylsbEPeXsNKSMk2oYYAvCdzGGUBfw6Cz/xFpD4rtoV78HUpFmcbG2HFbDA?=
 =?iso-8859-1?Q?PAzqQxKvcpwvBNOjmy9qxxixrhe6TIdk9AjFsW9V8wdWEJARDabEArW56B?=
 =?iso-8859-1?Q?7IajiqIWF5naczA6bF3qCgjs0ld/W5xatsz47C7kV+CR0ZNSFQ18cR5UIL?=
 =?iso-8859-1?Q?I9CevFaNAAtjGtKE14MVqqux15i6ps2raJOs24wbOP932oAKf65XDw8V63?=
 =?iso-8859-1?Q?1Y/XHBv/Nwbj2xnRR9FdzLQKKZUeKCeg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0159
X-CodeTwo-MessageID: 47a286c8-77a8-417c-8a88-701c5a61d771.20240603121859@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	18691523-5e34-4a09-7e5b-08dc83c7584f
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|35042699013|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?M0cUh3sBo7GXpS6Wxyf19eS5q7Wup+7xiVITcLREOAEjo9rPScqAoHNLpj?=
 =?iso-8859-1?Q?k8xSAzq9SrdngKV8rgIsddVHn5pAMGaWBnApGMh01gZ97Tyy8qhqwPvvA+?=
 =?iso-8859-1?Q?vWuIZ8gnFD/5mJ63LwGrrZIrIMH20NcQNIO1VovnDeOEsm1BMaBNHcrSsY?=
 =?iso-8859-1?Q?1D0jWMY0Hpy9L7lwjWfSpqMNWZLcYJ/RHmstwuUmfWSxVyO/QaZ+Fmyt08?=
 =?iso-8859-1?Q?Of1RzlmAl6sAdqyRCyDvIAvKLz3Xlss8KG8UYWNH7tCdhh1FFRea97DVw3?=
 =?iso-8859-1?Q?9VN1W+CT/6ciiOWn0viup6WwJe783rWuuT7RPbYAxgZwI/z3VnIg9qzU9H?=
 =?iso-8859-1?Q?TbjlT46I9fLpy7gNEqmeVsUekejgF1QMVI22Ub/2E+jLRaRz473vCe4+Hw?=
 =?iso-8859-1?Q?KxYx5Z5qw74a+JzfI4fJOPRMn23EFNRRbSTcqQq95rwi/GPDZ4u6VGeNro?=
 =?iso-8859-1?Q?WnZlAwOx4fMgNtBSJgLrFlrpZU5afPxj4rC11RV/gwGmtQC5se6JGheIPW?=
 =?iso-8859-1?Q?0edN+Aak6SU6cZF0xb1JfqmpXcYwN1q1sqDNkiSxSQFpqUszYCiL/MuQmL?=
 =?iso-8859-1?Q?cHcQVAuof05zPtVKSDer4zj+S7UC8WXBUoBtyjwiWGm2KTL+FZHNEP6OnA?=
 =?iso-8859-1?Q?U6qr42qRy4epsTGv4SOWteYpdeFWJ8Bw6j5RUomqc6n/TiliBKv9KsaKYH?=
 =?iso-8859-1?Q?gArXSQal2UB5wdhYVXBwnaIpGBA9J8bSb6ymRNnHj6NqrsqsA9UoMHdF+V?=
 =?iso-8859-1?Q?FLaDd5VIW/pqyFP4ALB2iMvkSIYV0QZfWd2tymUIVacxhDxP1JO16/270B?=
 =?iso-8859-1?Q?7RMPvqjK0B9cnzBuT92sO/PgcYQwSnKd/PSnTmz60PwfxbogHcq2FEy3+1?=
 =?iso-8859-1?Q?3zm3WDKJqtxuCyYOOMAZm+mVPMau3vM56Wvol8CF2sPYmG0KdMqPI81pwO?=
 =?iso-8859-1?Q?waFJXbmpdSjfVp+pr6DfQzoBJXBVQEB4eV+nzEfvHUv+xrtwqXQnmPsXmK?=
 =?iso-8859-1?Q?3Jbszg1h66ska7NBb6X/K3QtKYevPYym0qyLtxmnaDLncFBjif1Nzv2InE?=
 =?iso-8859-1?Q?IvrKo1vABMK4F1p2quzwjEAesW/pks79EC1L2j86IB8yZ/lJbts3vTs6cY?=
 =?iso-8859-1?Q?7j1Nfr7t5n9BzsOmrTZofQF+1yNDaYnuuqCSqYE4Eqp9YCNdkNczTzGs+p?=
 =?iso-8859-1?Q?vdYFUuzvI+Wz39lY4M/CdnXbkT/mITRtIVKnlLXl8sZmfa3zipVDybvOqn?=
 =?iso-8859-1?Q?PpYMJKXWB7oUuOLP/Pes9Y7ni6/TSD2NFa+7ZMHeOXm8/B5Xi0BagWt1q5?=
 =?iso-8859-1?Q?yarNoqjsrCNuIKFvm5LQ6IRuJHIaDE1h1OOZZosBt4i+SH+t+MIbAaOM0H?=
 =?iso-8859-1?Q?YbRbqEULh3WuvEd6XL8L0Rx6V6z7kvUYsdM2NNnxjeWroN5Fg9mi53BSGs?=
 =?iso-8859-1?Q?wcZGQN54py5Yejmq?=
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(82310400017)(35042699013)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: sentec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 12:19:01.2155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ee956d-06be-4f66-0414-08dc83c75a44
X-MS-Exchange-CrossTenant-Id: 0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1659

From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: 02 June 2024 15:22=0A=
To: Arthur Becker via B4 Relay=0A=
Cc: Arthur Becker; Lars-Peter Clausen; Rob Herring; Krzysztof Kozlowski; Co=
nor Dooley; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; device=
tree@vger.kernel.org=0A=
Subject: [EXTERNAL]Re: [PATCH v3 1/2] iio: light: driver for Vishay VEML604=
0=0A=
=0A=
> Hi Arthur,=0A=
> =0A=
> A few really trivial things inline. I'd have just tidied them up whilst=
=0A=
> applying, but I think you are doing a v4 anyway to merge the bindings=0A=
> so I'll leave the requested tweaks to you.=0A=
> =0A=
> Jonathan=0A=
=0A=
Hi Jonathan,=0A=
=0A=
Thanks for the feedback!=0A=
Small question about that comment:=0A=
=0A=
> > +=0A=
> > +     ret =3D devm_regulator_get_enable(dev, "vdd");=0A=
> > +     if (ret)=0A=
> > +             return ret;=0A=
> > +=0A=
> > +     int init_config =3D=0A=
>=0A=
> Generally we are still sticking to traditional C rules so keep the=0A=
> local variable definition at the top of the file.=0A=
> The only common exception is when cleanup.h functionality is involved and=
=0A=
> we want to ensure ordering by moving the variable definitions into the co=
de.=0A=
=0A=
Do you mean at the start of the function, or rather a #define at the top of=
 the=0A=
file after the masks and register definitions?=0A=
The use of 'FIELD_PREP' discards the 'static const int' option to initialis=
e the=0A=
variable at the top of the file.=0A=
=0A=
Kind regards,=0A=
Arthur=0A=
=0A=
>=0A=
> > +             FIELD_PREP(VEML6040_CONF_IT_MSK, VEML6040_CONF_IT_40_MS) =
|=0A=
> > +             FIELD_PREP(VEML6040_CONF_AF_MSK, 0) |=0A=
> > +             FIELD_PREP(VEML6040_CONF_SD_MSK, 0);=0A=
> > +=0A=
> > +     ret =3D regmap_write(regmap, VEML6040_CONF_REG, init_config);=0A=
> > +     if (ret)=0A=
> > +             return dev_err_probe(dev, ret,=0A=
> > +                                  "Could not set initial config\n");=
=0A=
> > +=0A=
=0A=
=0A=

