Return-Path: <linux-iio+bounces-5384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B79658D1543
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 09:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B2C1C21C57
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 07:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7497317C;
	Tue, 28 May 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="KpiZ9NXS";
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="KpiZ9NXS"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020002.outbound.protection.outlook.com [52.101.186.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925D4F201;
	Tue, 28 May 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.2
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880995; cv=fail; b=lzL816ZwiaKLmqfFxkBD6SdJCS8019YYgD4mQDxlusm6cy2BTROzBCFJB3PtQTFrOWhzeJmIzQeDR/0hNuU5aCAN9KE81WrYtwRzo2U2Rimo1IE/LZbUmKUeC/G46btOgV1P2dNcH8PjXIVJg4Kf7YXeyT9j6fqB0CDkmR+hnd0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880995; c=relaxed/simple;
	bh=5ZQptkPVXIC/0zHZW97ivuVeKqxmY4QmPsKMLlx5d5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJNbmZt50sDjgvkblprEBvxbsc5vOiS1WShasM3TrJgfdvRwFfYADRUAvnBspQnKyQYAEsGmd4unJgXcL57GlCnLEW+ypuHQpOtLVXslgTr4APIwBEndx9Smk/EEzBGGt77nvKs3mQQR7q/8Jy2C9oaI0DbtJnd2oL463gu0sIY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com; spf=pass smtp.mailfrom=sentec.com; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=KpiZ9NXS; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=KpiZ9NXS; arc=fail smtp.client-ip=52.101.186.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentec.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=EFzZau8KfvqpOghNWwFmUPSPdcESdR300+NZeFdhWen1I/kddgOAH2qq+IlgwhwrzoftDVrZ5jvMR8YmigjTogPld1HdAY6LohI/dQ2mIkBYMIshBPJHOcd1lnOk2tGK51c8IDASSWGcp/flkrEAlltynswRML8MpgrdblnIfxzVrygSxQGgn4eyd2jk8k0ZDxIMOAsm27+D03VXeda5EYoFiyWcD/BnyvuDgjiIM+j4umZG+ZYcH7snNWtBzpzfkD+TvbNye7CJJSqSJOg6fJQBt1JBxrHh9BDY0OQ1dQMid5a5WxHLGEk92PdXhE8w6s11rFPkDErnOFilJ87rbA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZQptkPVXIC/0zHZW97ivuVeKqxmY4QmPsKMLlx5d5Y=;
 b=Lrk2S2HRTLFOQThoBJUxuiTjYhG/BBHEGqmEvVOMTAughgYuVQkFCcdG5+j98SKtXKcTiAjioivc00VARNdMmRhbEJGl16w9dYhz6a2AFU5drUulGqFALKFnWsBSFK/fEgbjio0Yxbc4LBxMljlSKQOu8tWmwqZ1dn6B8HqB9AuhYAaoBV6Nw9pYQRfOQxHjOEq3+kSuf2OeTPfTqJ/JjPGrx5MyFI83zoF5EUXxYJx5gVipK0vVwTSK+4enVU06D9FmpRMXhu1KVo7e+DJY0O/FggUu9gbANmQL8M/lFZgCUFFLdSnD+I2qDf9FaJFxWIhHUgDqjTGqTrOm24An3w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=kernel.org smtp.mailfrom=sentec.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sentec.com;
 dkim=pass (signature was verified) header.d=sentec.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sentec.com] dkim=[1,1,header.d=sentec.com]
 dmarc=[1,1,header.from=sentec.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZQptkPVXIC/0zHZW97ivuVeKqxmY4QmPsKMLlx5d5Y=;
 b=KpiZ9NXSM/qXMJnTAulfprJIZVqyT+0f2BPQQclF7eQU8zYypE1uW5HULlw8LCSstM2eC/JWpAH+huaz8rVUF7yLSeXaN7aLuc5NwcAKfE2ZfCNdYcfOaa6eL/8PmFSlq9w9U1Ii6QKn8PXH50DIM73PKozjfeF5iTG11M04xqg=
Received: from DUZPR01CA0292.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::14) by GVAP278MB0053.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:22::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:23:09 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::54) by DUZPR01CA0292.outlook.office365.com
 (2603:10a6:10:4b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 07:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.74.137.176)
 smtp.mailfrom=sentec.com; dkim=pass (signature was verified)
 header.d=sentec.com;dmarc=pass action=none header.from=sentec.com;
Received-SPF: Pass (protection.outlook.com: domain of sentec.com designates
 13.74.137.176 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.74.137.176; helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Tue, 28 May 2024 07:23:08 +0000
Received: from ZRZP278CU001.outbound.protection.outlook.com (40.93.85.5) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 28 May 2024 07:23:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ3Yf1wd8Gg8LY9vemnW+P79gIb4e7LEjtg3xXm+uTy4Kx6LGrZdBZaB9ej0v3XCoAeF9tJI1GROQabM+/8nniA52CJC+v/Vx4+Kj+dVyPC2N8fw2/nmAYgIWfjHEic+VPJ30u3Eacl6GaMMYsfiXjwaf5S/iUwpLfDc0VhGlHg+GE0UzCfOmtAPp8KtXzuxpb9MwjYITRA5ZB5LO3JL5+OxZlZiwZVpynnJtj+CHAxXkk1nFpS7WbneWACs6MyrJ1uhTfT6dcrfFYXA8MtiVnCCW6IdX6IeuJagB+aYEtNq3mdXLjmXKTZbgJDoIOoMrY/pCde5Zs7VEK6vLgNhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZQptkPVXIC/0zHZW97ivuVeKqxmY4QmPsKMLlx5d5Y=;
 b=ftLLa/G3Fr4UaehUcTA7S5WUnoif830ZjIA6Y0iJ3hrCVpe6bO13a5snQfJy+m2ZBUz0Qw2nCjg02h5MGlW479PnPwWrpOWeSdGi8m7uKfdTboUFWdVrVlOAy3bZwaabpxlFhNbAwOui1w8TemGYh2v5CsPn/NElQADJTZDFRBX7cGjFMOSsMGXGakFTsCxXw42dST9P0r34Rm1H5uWfQ25t6S5/wP6twMguIfz7OFOxpcC+Fg++WrHQTu0/y8XOlKrQ6bV4ZK8yxb8b6i7Hih4id2U0uBMoNgbOYNKNigcUioDHC3RcYZm+hZPGvogFAzM5xUjsCX/tPjAFESU3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sentec.com; dmarc=pass action=none header.from=sentec.com;
 dkim=pass header.d=sentec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZQptkPVXIC/0zHZW97ivuVeKqxmY4QmPsKMLlx5d5Y=;
 b=KpiZ9NXSM/qXMJnTAulfprJIZVqyT+0f2BPQQclF7eQU8zYypE1uW5HULlw8LCSstM2eC/JWpAH+huaz8rVUF7yLSeXaN7aLuc5NwcAKfE2ZfCNdYcfOaa6eL/8PmFSlq9w9U1Ii6QKn8PXH50DIM73PKozjfeF5iTG11M04xqg=
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::13)
 by GV0P278MB1442.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:69::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:23:03 +0000
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f]) by ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f%6]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:23:03 +0000
From: Arthur Becker <arthur.becker@sentec.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Thread-Topic: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Thread-Index: AQHasFNmHVhgVh1W90aWHgpQzkaiXLGsPRnn
Date: Tue, 28 May 2024 07:23:03 +0000
Message-ID: <ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
 <20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
 <e47de936-8cb4-4cef-a346-74835767e203@kernel.org>
In-Reply-To: <e47de936-8cb4-4cef-a346-74835767e203@kernel.org>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sentec.com;
x-ms-traffictypediagnostic:
	ZR1P278MB1117:EE_|GV0P278MB1442:EE_|DU2PEPF00028D10:EE_|GVAP278MB0053:EE_
X-MS-Office365-Filtering-Correlation-Id: cd613d09-d97e-48e9-fcf3-08dc7ee70601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?+J6pMqCAhziDBfG7yv5QMADDr4r7HxIBRS1Z5/NSZzGILRvYGiVjuAGLCG?=
 =?iso-8859-1?Q?FY5CZH1TCh44EJyltfAD5TvRaIHN0y0AK1fmFGubRYEZtr+YiYkT1OItTQ?=
 =?iso-8859-1?Q?598r89C4+OuPiZkR37AjLZg/DG/AIaMXsbX6MKBQcjAQiULrD+EqnwwKXu?=
 =?iso-8859-1?Q?NUPRfNBpYcK1eoueWubrFSUk9XJPSqZonXS51mc8mbD3UYMrWg01TqJ/sJ?=
 =?iso-8859-1?Q?BzbT6tbuuyYXJfBtBdyJZyBrCjBfvqKDcXu+CNolcAXZK9NHiI9F4x2pIL?=
 =?iso-8859-1?Q?gmeGtRIBk3pqOpNO4pnIqtJims91dWLHG0RQ0HRQowvjeu1m7oOtbHDHWy?=
 =?iso-8859-1?Q?FSPMt2aIUj6wx/UMDxseeWjpQSkjohJd3cfe4wOKz0AuggFOOo93jsQIpa?=
 =?iso-8859-1?Q?2gMCMgBeGm0+l2L7gVOvauzY9FQM+xffION/0on9kLCAi6G9T4sUeBZBwd?=
 =?iso-8859-1?Q?Z5kuMRTFHaN1li2wUCe4HVf0Xmr+dtdAYyKmReCT3J3FFPnV3YF1K+acWC?=
 =?iso-8859-1?Q?qygD6epmshkFUuXru9fbnxY/weX/XCscQ2lJUdYTXbGWLq9hks/8MYyPN/?=
 =?iso-8859-1?Q?LTWh0lajlonLysDpDtnxgc0NYlejz+uwA4lV0YMn41NzwjTnTyp68VIBh7?=
 =?iso-8859-1?Q?shb2eM//89oxA83ZXSabTc4dVRgEOx4PKVN/gXg1v9MNMbB/F2rhzICdWA?=
 =?iso-8859-1?Q?6bKz7BlJJpHKYVPZU1+kzHNSsiKMFBGvGJk+xE8K1XoDPb+3S/JVD0y0/x?=
 =?iso-8859-1?Q?aOgenvMzorN/PidZAfhh2izMTTm1IE+IDp02wkJwqGOsWcb80NxBCQeA6c?=
 =?iso-8859-1?Q?NLIeiG5iy3p8ZXom22tSCGr8sIOQxTMFoge0aPKFvImZTstht7Sx/pXOsB?=
 =?iso-8859-1?Q?in1xYW8enBng6ly+7NM55laTRseJV2xyDWXr1phVxhZx8RjjUsKm1O7fAE?=
 =?iso-8859-1?Q?i+LaPtgjgDYAvgpS12AG2tZfcER6zl/o/cAAzMlVzMPVIZEWCMajmaGpow?=
 =?iso-8859-1?Q?ZRFsEMJZi3gT90pPpLS8v1mdTAFMtD5930PASlMTOx9maKJyof/lmn9M57?=
 =?iso-8859-1?Q?d+8mQ4wAhCzDrIZANY0MKa8SgR4OzUS1/eZLZy6yCMYFHhlif6/zqTpHNa?=
 =?iso-8859-1?Q?q7iTouRcTSBBick57lgGF9xc1sfd/vgvftjWTQRpECHmp1s2FHEtyOokdO?=
 =?iso-8859-1?Q?doBeF3XxDI+2REn+HkPDOORpCweOU5X+JZDdKWnMrrWtcXm+3Eo3u+eK0V?=
 =?iso-8859-1?Q?omXIn+iLueYbo1YaP+5sQd5dnQIfHKWm+RQCZOBXCPeTXTKksSpW4aVxqd?=
 =?iso-8859-1?Q?v43ZY2Y4/+PiOR1XPlEdIOSZDkU9fx3B4NimNpCbPe8VB4MaCHKCcSEXHz?=
 =?iso-8859-1?Q?2L2fsjs6dKpjywFjcDNsd9VgrF/+HyKg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1442
X-CodeTwo-MessageID: 677c8e9b-f153-408c-99ea-68e45eba9336.20240528072306@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a259f5e7-14b5-419f-e6f3-08dc7ee70331
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004|35042699013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?GPiYQ/ek6MqEQnb++gYcwNVSL7LTXaBedzNdAOPT1CuZ2tjMQXdyZ/5Uvk?=
 =?iso-8859-1?Q?EvF+tW9fSei8jx0cNEBxhdVT3c/+++818SWOhVfUNAk8QjG5vvtCIaKxkM?=
 =?iso-8859-1?Q?d434UjVwlkbrIU/8QmK/MPa4zzLmERYm+PHflMZJm/blRcjBCZDH2yZ8R7?=
 =?iso-8859-1?Q?ZR/C2iyfkpOoAIxHPIlrA12IPCYxx7OIsdg31qD0GvDhF4jO9GQutq7yHH?=
 =?iso-8859-1?Q?hsRfN0efSwpP9O7NLHq/Ol36U05hX7kJdL5GiDuiZTDOOxyACKKQmVEGyy?=
 =?iso-8859-1?Q?bfCS0kUFT91WCuWwv6wyhfvZs60/uWU+EPu/qifS4k5JyGfhYP+c1k+O2x?=
 =?iso-8859-1?Q?FMhFgLCaNw23liS6g2iDans0wOyDAAbj5BmI3A7BlorM1XivjYUbkQv48F?=
 =?iso-8859-1?Q?B3aGbpCl22j2N3ellVEEnxXUyAj+Zw708Gd7253UHxrgyp4TvBuPW057j8?=
 =?iso-8859-1?Q?YRQyyTZe6A2mqwdn0l1WaOjBFPfKwCuaZkDXTClwsOZZRsvKHlPMW0+sYi?=
 =?iso-8859-1?Q?kMpJzRfZmRze0O856q6AYMhkNQqkPf4AHmbxwuXuWxmMIxYDfMTMzKvLm7?=
 =?iso-8859-1?Q?3tIOJAN+RvojYDJSanVnwMebHp0iNkwpTiGdFNd4rnwKIOBCu/1BUTOd4q?=
 =?iso-8859-1?Q?j832scHDK7yB0MSWj7BsX1eey/FijPIs6eJaDLBMVETu2bT8BaxcpfJ+Q9?=
 =?iso-8859-1?Q?xVRAXCeaA/k/Ciw3UZbIZoZ6PzmqId2QeqkTw1phA43pzi0eQS0N2C8qKV?=
 =?iso-8859-1?Q?Hh7H1gaHCpCfuJIIox+F0fljSY4IwIimezP2GgFZKTIpsaEnOb7hT/eYHj?=
 =?iso-8859-1?Q?gukFzH00iW3x5CmTm7Z7hx3cQDd6EVs8drVi2rtOwQaG0DBRUarL7Qar7k?=
 =?iso-8859-1?Q?1QpnCfv6e11I/CFQmbDpnFTGmB0Ka5HoehOlXgt+1usyMjvFxhYVu954OQ?=
 =?iso-8859-1?Q?/tiWvEZNCfhy63luxU5aX3jyBPWO5Dp+t7CRmVwmurd0+Hj+1kh7JIqjG5?=
 =?iso-8859-1?Q?IMF/zFsYZNtx4wg7nWTkuoXv3AFshV1nPkFrpMZw3D7qU7JxCqelkFYV3q?=
 =?iso-8859-1?Q?RDABDlr/GT2c0BnZlHMf9nSQ4xcNIYZrS254F13FOnD3RBy66sZL3Qq1CR?=
 =?iso-8859-1?Q?a0cdu/4wMa+ChJE2WHbCiq+xKAdJjhufns3dsA9TPwZf8Sx4l2KF/77mhl?=
 =?iso-8859-1?Q?KyZmzMIUUxc0XSk2jk3UjdozxA4SZ+k2EcyCJ+wH9NstHhjwsuE9VMrf/K?=
 =?iso-8859-1?Q?/xzflOTIKrrkJDTY7k/LfAAELdpKbrSgm878Pg2OHfoxiR1Jg+YEwpbJfR?=
 =?iso-8859-1?Q?hm6CPUAG4yTFULPNu9tOwNDsmosq9bxk5JQMaMG92ig7M5Eapfj4+DJ+NC?=
 =?iso-8859-1?Q?HYo2S/V8eZiybRUUjlchIROSoNmbzdfZzKPBJKAFYsFmvbqhdECEeX959M?=
 =?iso-8859-1?Q?iUIDIU7aSSjcFKnK?=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004)(35042699013);DIR:OUT;SFP:1102;
X-OriginatorOrg: sentec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:23:08.2637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd613d09-d97e-48e9-fcf3-08dc7ee70601
X-MS-Exchange-CrossTenant-Id: 0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0053

Thanks for the Review!=0A=
Right, I wasn't sure if and how to add the veml6040 to the veml6075 dt-bind=
ing file.=0A=
I'll modify that the next time I make adjustments to the driver.=0A=
=0A=
Kind regards,=0A=
Arthur=0A=
=0A=
________________________________________=0A=
From: Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent: 27 May 2024 18:31=0A=
To: Arthur Becker; Jonathan Cameron; Lars-Peter Clausen; Rob Herring; Krzys=
ztof Kozlowski; Conor Dooley=0A=
Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vge=
r.kernel.org=0A=
Subject: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040=
 RGBW-LS bindings=0A=
=0A=
On 27/05/2024 17:12, Arthur Becker via B4 Relay wrote:=0A=
> From: Arthur Becker <arthur.becker@sentec.com>=0A=
>=0A=
> Device tree bindings for the vishay VEML6040 RGBW light sensor iio=0A=
> driver=0A=
>=0A=
> Signed-off-by: Arthur Becker <arthur.becker@sentec.com>=0A=
> ---=0A=
> V1 -> V3: Addressed review comments (v1 of the dt-bindings was sent=0A=
> along with v2 of the driver but not in a set)=0A=
=0A=
It's basically the same as veml6075, so should be put there...=0A=
=0A=
Eh,=0A=
=0A=
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=0A=
=0A=
Best regards,=0A=
Krzysztof=0A=
=0A=

