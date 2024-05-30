Return-Path: <linux-iio+bounces-5484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509828D47F6
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 11:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AAD1C21838
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E8815444F;
	Thu, 30 May 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="2b6QKzoV";
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="2b6QKzoV"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021011.outbound.protection.outlook.com [52.101.186.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF26F301;
	Thu, 30 May 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.11
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059640; cv=fail; b=dZ6FuYQ+yuwM9HQG55vrc1/MAmgbiKBMRqaSBzWpTSlJqevPvFLrksantWR8Ez9jMV/9ndLdArWpOPzVYGgUrrF0HtkkTijze9s1Bg5t9drJ3OTFRGt/cNTV1I/Mmy9HfMCFXftZbvsHypbX4Wz3OK+cr1FcR1PDcaCtHan6ELg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059640; c=relaxed/simple;
	bh=jC9/lvyNpqarj+9sm1AIrlfJ0UhUWK6dVG6aAQUOJMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MwEEdNvmWAYXaXbBeRuD+RtJEyPpyx20qloKi8+WlkHmCbdIBOinxz47K4YprIDWX6JSHWv+hrX3ezGOco+utuu66+tMBG3341e+at+9P3flQhgA/sxPnqcvPZifpw7Aw0O/2T/FJRAEUH1uLQkiDI0rXVqjs3YBv7e3BgLE1m8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com; spf=pass smtp.mailfrom=sentec.com; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=2b6QKzoV; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=2b6QKzoV; arc=fail smtp.client-ip=52.101.186.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentec.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=mwzmyguTDO0eM8hnnvwU2Ny0Bqv9FH4h9An165npAWW+0x/g0bBhpZ+xJ8rLU9BMe5aG21FbwyHYJrd9J6MkvaFDBAmtsQ/OVmiL2fvXdA7p8u+8mFNi3BfyM1boXL08ifBRD+9RJTkbj7ToWHHJ+RarCRaHy5Ebe90C7JUAdsAi2nwDRazN7rTI56NzEwZvtcSQlKy/V9CMIYOkCiBF/C9Wj/Sbpc3dtJaqKGUr6kAB8H7N9BpH3kjWDnNl35HeDi+lDv+wgr0d9Yi0U7iuf5zH6NxI+gvo0N2vNhPW50OApu33UiMzwFCY7htuleYT/HLlriUYGbNJePajscgPoQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC9/lvyNpqarj+9sm1AIrlfJ0UhUWK6dVG6aAQUOJMU=;
 b=Uxm5wWkUES5De61VZhfYtokLBxLFNeIo1KZR9GaxIJLJPQwTnSzilFfJh7a0s0JTrXHmGShqdWOA+2w0LulPtj2KazUKuXsjcdOc1UlLAZHvqF2faJzOEo6XmOljVxXfWO7t8WrtaN++Go1j81axOr3RCOsJZn3InplRlwRwxZGQMzZ/JtBvS9/yNzrZcErfQmId9A2FJcvHOKBhE1blxNkefV3+tgg/AHLf1O4B9RQc7KQGFIgF19ruDRffOkCz5apEbPz2rcREsJvm3UGqCRXLVzCwQ2/Y6J2OjubddzsFURSH0ycDOz3Q0FfBH2WC7weqSR456OYKYG4PX+45lA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=kernel.org smtp.mailfrom=sentec.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sentec.com;
 dkim=pass (signature was verified) header.d=sentec.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sentec.com] dkim=[1,1,header.d=sentec.com]
 dmarc=[1,1,header.from=sentec.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC9/lvyNpqarj+9sm1AIrlfJ0UhUWK6dVG6aAQUOJMU=;
 b=2b6QKzoVIX9yqXU7QqrlnxFfACrz/S9Gbf/n84dfeUoMjC9Aa+HH+ZfBP1mvhywqr5FGxjJnoW8vX1KJxSKk8peMuc4vEovjXpqxqqljo8fjPhQ9EKgeqXyU0xjeEwNVj4AVeKYNEvsudtcmm54/+qmTD5KnGGhQL5cgvOwJ82Y=
Received: from AM6P192CA0041.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::18)
 by ZR0P278MB0776.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:00:34 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:209:82:cafe::e8) by AM6P192CA0041.outlook.office365.com
 (2603:10a6:209:82::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 09:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=sentec.com; dkim=pass (signature was verified)
 header.d=sentec.com;dmarc=pass action=none header.from=sentec.com;
Received-SPF: Pass (protection.outlook.com: domain of sentec.com designates
 52.138.216.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.138.216.130; helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 09:00:33 +0000
Received: from ZRAP278CU002.outbound.protection.outlook.com (40.93.85.1) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 30 May 2024 09:00:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsoNDfLyvuU2Fs1aMPCk/K6nAHZr2y7XdVPYGD4J9ZYLzDf+tGeNyxf3jy2BW/5bnSgvemp+B4hISiz0ITTBGR8KZMY+AQsKc3x3hCW0f7E/nF9jnsnzht1K6vSTSqaE5eSKgJUrJ1U5cCQqGsyVECWmMQBVUdnsS1nSxa2Iu+gSdDlsCldZntJdYLgHzhrabq8IkfSqO05XMln72Znr0Qn2pQPD/YdCF2OUQLFfVvoqWh9yZ2aNBN393q6iEIoeS12IFdV6517shmUF7JyALUXFIfRgcEV+fYxN0lK0zXV2MX5voo5mWRMK8avLuCQP0V4AFjsVG8avX25WAkz+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC9/lvyNpqarj+9sm1AIrlfJ0UhUWK6dVG6aAQUOJMU=;
 b=VTcpFVGuDPs6i2skAh6Za6tJNTQ0XWfdyyJX7bzrfS6LwFYet6H3m5hHuR/FERNzL4EQZaUmuh/yWnexWr8v/LIkE2LDNn9+mKNozRiZ29DnGojhhhPYXNSfVZLeVnu2w05yxvpWnzQz9IZ3wZgTK78e+m1JeEBMr7fMLF/fLIT1oZdpn1yp55Dcw8u7vNJo8UYgIDfvqCoYv+lboOr5MOTHDHR0vIVPtuZurRNJ6LJLqBGp4FNafquHIZ5mxcG4fNjlHWX3z2OEPS2NZ3wgTKl9kTfN7XcYxkPDS5E9+JcKLE6ItV76Oclm+OoVboJnm3oZPCtODkebeQ4apZ/neg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sentec.com; dmarc=pass action=none header.from=sentec.com;
 dkim=pass header.d=sentec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC9/lvyNpqarj+9sm1AIrlfJ0UhUWK6dVG6aAQUOJMU=;
 b=2b6QKzoVIX9yqXU7QqrlnxFfACrz/S9Gbf/n84dfeUoMjC9Aa+HH+ZfBP1mvhywqr5FGxjJnoW8vX1KJxSKk8peMuc4vEovjXpqxqqljo8fjPhQ9EKgeqXyU0xjeEwNVj4AVeKYNEvsudtcmm54/+qmTD5KnGGhQL5cgvOwJ82Y=
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::13)
 by ZR1P278MB1592.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:00:30 +0000
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f]) by ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 09:00:30 +0000
From: Arthur Becker <arthur.becker@sentec.com>
To: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Thread-Topic: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Thread-Index: AQHasFNmHVhgVh1W90aWHgpQzkaiXLGsPRnngAB73wCAAsClxQ==
Date: Thu, 30 May 2024 09:00:30 +0000
Message-ID: <ZR1P278MB11174B67019F7ABDB7F7B1B881F32@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
 <20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
 <e47de936-8cb4-4cef-a346-74835767e203@kernel.org>
 <ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
 <20240528143914.GA139191-robh@kernel.org>
In-Reply-To: <20240528143914.GA139191-robh@kernel.org>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sentec.com;
x-ms-traffictypediagnostic:
	ZR1P278MB1117:EE_|ZR1P278MB1592:EE_|AM1PEPF000252DD:EE_|ZR0P278MB0776:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f9ec39-e50b-4dd3-010b-08dc8086f707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?736myLD/sqalCAkviiRnukGt0r3Erb62+EXdrv25DC44QnSBh6MXjwGTgZ?=
 =?iso-8859-1?Q?uzSU4cdw6CN/H24hTMyHPe4rX1JwwnJncJ8e858rJu5k9FNhFse6epJq3I?=
 =?iso-8859-1?Q?7U1Iw/G/judHEdV3Fy9+1roVtYmqTeYDAnlPX/Cq0oU3xLF9mkTLNdmws6?=
 =?iso-8859-1?Q?MLcOpzuA+Poqwz8xfgUi39KQz0FCKLs3jvoH27uisjsr3sdsZAzbxx2st8?=
 =?iso-8859-1?Q?EnHdAS0O02Zm6WK0z68zRyURWEE7YWt+3LB7XfRFiz0FxvnGScK0CeTP99?=
 =?iso-8859-1?Q?aNcjreczxw5PW5IKKN6aZmRRMcEYHvvtna4WuRSNeLrLfk+rpBhqnfZVRY?=
 =?iso-8859-1?Q?zFnataxiycXPpkDfwZzHEQyBqtTMi8OySfHi8q85UY5ZlHtFgnmkw6NVLV?=
 =?iso-8859-1?Q?lEERhncbjqCDGdyoXNYIKEJdWhSwfTzbZceprCUv60L/DeLKq0lsZLhRES?=
 =?iso-8859-1?Q?2Uig3aX1Apd+1wLEy0ua9+AAgxyugfVoEIHAg5Jqu8wcqVfm4MG9leidBU?=
 =?iso-8859-1?Q?uCL3f4gFrIK6188vmWaSH/H9rFrefjurZ/4lZPnuic9ei7vaKt1SZPA2Qc?=
 =?iso-8859-1?Q?/6mBGvhVdwKon8a0EJGbiu+Bs8ctzY/88zHfL7IuHqlT1mFc3+y3+Mjuc9?=
 =?iso-8859-1?Q?KTvuQ39g7IvlJNEnGhlhUYDYPfMPghscou5EfjV9DxCRLOPB2G/qjVWDCJ?=
 =?iso-8859-1?Q?zfgXf1DXbIqoVJiEJe1tERzLtCHE4m8nN889++YS5t3Kxv7ac6M4yU5hH4?=
 =?iso-8859-1?Q?DybUwowmgprvgWz1W3PUjp0zBlVoJLIaA1HVejE4dXIW5MaCmA5ak7vYUz?=
 =?iso-8859-1?Q?DGE8lhROwjg6Xwj6FJQUMdsmliIm1OLXngX5nkDA7R92g23MlCXZSIvXFn?=
 =?iso-8859-1?Q?w2Zawql280HvWMQBCfoqW46Nj33e8FnxcApANr2RIvGy3Y+bVNKRN25vui?=
 =?iso-8859-1?Q?mSTwEJNMIUklgzcQfMqfY9ugdWumj4MnxgY0hrjDxh/bFDvHRAEKxGRglG?=
 =?iso-8859-1?Q?TC996mEQykZJpQxBk1r734rk98GbIIEd0tw4qJI1zPs9Ce5xggI1siRomv?=
 =?iso-8859-1?Q?1F7EDf0GXionaeQWYcTPANbpp+tlgkkNVfDcXpPzW2bkmooubKH5ARzPjV?=
 =?iso-8859-1?Q?N/Nh8YJ2+N22mLjDw9iPmb2inmvHQ1o/isuNnBGsQgh0BXMpDix6PvnHq9?=
 =?iso-8859-1?Q?2/zDDPgVrINrd9QINuUCEtZHvjuWtP1gOBG8kf1sdQVtP42Ua6TeL+nnrH?=
 =?iso-8859-1?Q?qfclPyVy5mKlerG6C6YBN0utW4SpxcyK2CkOgiuCzVzhuJNUlSJB5xqWaP?=
 =?iso-8859-1?Q?ehvJiiNuH7G9K3O6DcndIJlN//44vCCHMMv0PDqsZ7zxy4SMyHg4v6X/Ck?=
 =?iso-8859-1?Q?o8V8wt6+yj4e9GX0IIsyI235r1+lzUNA=3D=3D?=
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
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1592
X-CodeTwo-MessageID: 05976a12-f7fb-471b-97e7-87e50561931d.20240530090032@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5dc865f4-047e-4b6b-e224-08dc8086f518
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|35042699013|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?i3qLSVmvBmtPBK8el6Tis6t8KLjsv3aHUwW22rd6cT6PdYddvuCP7jchN4?=
 =?iso-8859-1?Q?b1SJeL52hFtr4hH03Gn6zBPMGg6B/PQ/IE7jhXCKX+aHRi+egkqBGlDnzM?=
 =?iso-8859-1?Q?4NGpdPCb19SE5AHxS7fZ4h57qyNw81ofCW65Ed/J5AwK02NLdWYJNE0eTt?=
 =?iso-8859-1?Q?cehyXhA3WjU0pAKfaroXLrVCaiurN3yIlF8exnkDVPrM6Ctyznro4sR2po?=
 =?iso-8859-1?Q?28wnzOg719iXETxoNEc1iQYgTRBl66NPvzBUIlZrasxZo8P2/BK+gKDaMS?=
 =?iso-8859-1?Q?MDjrD/DOoZBYxdoYctpjzVJtl7zHeYaacQ2WsG0lyqYfRQvF63DRYQfn6f?=
 =?iso-8859-1?Q?AqE/DtTkoYg9+lGO/2Zls0U8qD3fLTx61W0eZwlmeRPC58hIWYw2SnfFB7?=
 =?iso-8859-1?Q?QxGFLY3e5ilPKXl7+L7rJWMe7tiqx2J/Sx+rEPS8fRgyGEQ1U1F7uQaict?=
 =?iso-8859-1?Q?1TIK6PnHXkaRpmEKAokgwDClzARUKU5Ue+oPW4Wa4vOPlgcg0qWnx2LNA+?=
 =?iso-8859-1?Q?slL3B3c24WCL+5L+dvAeRhiF9x4drdnytn073hf+1PbL0vONThiZO6TC5m?=
 =?iso-8859-1?Q?fpDdPzdO1RvVtFQgD9hOZEEQTrF8j3/ktQwdklmj8b3nF3XqqY7LLuIE5P?=
 =?iso-8859-1?Q?ne7Z0+Z7DSM7xP9w/i9kv6dSGZO/ti/WxbXz7KInTI7dvmWPOXt7CV2ObL?=
 =?iso-8859-1?Q?4s+D1ebXMynCPUOigZFecKrqadYZjXXDfJSnXhmAkKmmUz1CODoWexW0qs?=
 =?iso-8859-1?Q?tUHMc7uNlWqGK5SAkWRTJ5DBxjiNvNzkFVDyfG/z67KJ9bnfoFrkjRM99u?=
 =?iso-8859-1?Q?710BxNPzM34TAjclroeYxPFmvI44Qm5JOMnrHY/ofEN1T5JX6GzWxSp/nH?=
 =?iso-8859-1?Q?xhaUe/k14KsGKZLzuEMcF/3eASLnVtZOel+SWcnPYXpBt+VongibpsXaxs?=
 =?iso-8859-1?Q?W4NsdgoYUJ4O0KnBCYf+fPJCS5wl0UqEUa3N38BFDRmRI3RzYrX4d+yEMF?=
 =?iso-8859-1?Q?kEZzIvcY1mlc7F9kT5Iq29478uxNf20C7HUI2NkxaXXkPNR8UeJB6bD0Vj?=
 =?iso-8859-1?Q?v/eGcn6tx2mVBtNiMkLJnWT6ITl25vyvOk8tBZjWKpL9Kg33y2JvH/m1to?=
 =?iso-8859-1?Q?67x5nOFdNI+7w4ysTXwZsmM6mWPl4zmp5vXUEjP3s4qtW7EFn15/BHczZt?=
 =?iso-8859-1?Q?PYiimfCaKFtJ6q3yDXB9sgd9Hdt13+uyyiiuwheiYtS+4g2nWYQjg6iHzB?=
 =?iso-8859-1?Q?OUhV781tpKj998s98Jho1Js2H3K5gcDFl/+T9igko5j+sU+pbWvDQePys8?=
 =?iso-8859-1?Q?YwG1OWJf8hVLGHlbHFeBfL2wj18sLdXIMrsSgTap+Sh4MZcZHl5rF5sqCx?=
 =?iso-8859-1?Q?kGYk0T/sK4h2Sds9AhsNNPr/0cSJYrlVCb8D3+guW7H/AtHc/UHztHRdnp?=
 =?iso-8859-1?Q?Vrdv8UlbaHKo3Fhw?=
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(35042699013)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: sentec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:00:33.6453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f9ec39-e50b-4dd3-010b-08dc8086f707
X-MS-Exchange-CrossTenant-Id: 0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0776

>On Tue, May 28, 2024 at 07:23:03AM +0000, Arthur Becker wrote:=0A=
>> Thanks for the Review!=0A=
>> Right, I wasn't sure if and how to add the veml6040 to the veml6075 dt-b=
inding file.=0A=
>> I'll modify that the next time I make adjustments to the driver.=0A=
>=0A=
>Please don't top post, quote replies correctly, and fix your mail setup=0A=
>to not add 'EXTERNAL' to the subject.=0A=
>=0A=
>Rob=0A=
=0A=
Hello Rob,=0A=
=0A=
Sorry about that, I'll keep that in mind in the future. Having to work with=
 oulook can be a bit frustrating.=0A=
=0A=
Kind Regards,=0A=
Arthur=

