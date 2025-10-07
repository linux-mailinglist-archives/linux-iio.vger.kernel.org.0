Return-Path: <linux-iio+bounces-24839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35156BC29A1
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 22:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE3F5350850
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 20:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DD1253B40;
	Tue,  7 Oct 2025 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LnvPUc/o"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06623C512;
	Tue,  7 Oct 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867629; cv=fail; b=YHyG30dwU1qY1tXKhk1230uSo6Hr5mw9bc0nuzrLNFTrnC18sKkORWbAdz3FCjRBVl4WObCdzVZF887d3zdwHeRHJ2FOJK0qFgNSfZAeJ7xK9hTt9V/8v+GpVk4fzK5b2fqnt+eC7t0TT5nUalSCoPIeR+D1jZeNbGzmBHQUlkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867629; c=relaxed/simple;
	bh=GonrF7xXq/NBENSVkVqI32qPT3KoP3ONBxKZ91a29lw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZRuVUMWaJFSELukNTHcexdzv0PU0zP7V8HwSXS/Qjr6n9X+b8PgTVQuPyte97gyNcaX0LcGz8gVfiiByK7NZqaKFdcvccgNEhp0XwvAgBgEvs/mCGN3vNtkUrJpKXPjdZiO5DgKoTr5ovQYpJndZqz8Zlz6Q3o/HqjlqSz/nB0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LnvPUc/o; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3rGOobNQi4dBh2j4rG3sMgSlkxKgSo0GouBtzAV58aRVVXY/MEdatFyaW6bOP7rT9Sd2MfiOo2z73939Z2h+hMOdcofy7V2oiSrlni9D+dPvhm+T/n04djrU16NxjrMMCesZbQNHwsVTC4pqu/WIvE3AEqon3qvCJQb12pMrVuzbDBGgILm/ZkI9/kiByyMsIR+1k+UUy1w+v/ux1ne5JfLHjimInLYYxc+6nYe+qGSv/cZHREDbH/xGp9hokvQs6xYGFzSWCK8OVrd+HIY8YArMI+wQjtt8n/R10I2ug44EDaPFiNH5jrPhjUMdMwM6VJ1Y09JPNiUy/CCQW0reQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EETPHlYxu/a4U13DvTn3DOpboUJqgR5EGs46++4fTeE=;
 b=y/2EVSxJVAK66WcpCd70fJFUJBRXoHtBrWAjREkqhMBF/yhzG52nXP9n0ffHUJNrpb4XmQPfu5hexViC8eC1LDaBIYg6Fm5RjhdthoLhQI2QMMQfdzmYbXtHXIWstmrwp08s+loBXUXK/qcq+MojcP7zBh+EisSkHrW9Gc+bboZy3mhkXhk/E6Fki+v9rXVMwf3g9MpsfgkIIUGMHN0ZAy5BdjuJmAPsfwpeQ25+5n94OAD/pdSeHqqlsQ1nAElB8z/8DhdD+D5STdl8tXJFZjiVEech8Ww4k3eoVjpCyGa/SSVVh7diXwvjF4iqZgzL6bFr3gxBnr3KGIt/eqv0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EETPHlYxu/a4U13DvTn3DOpboUJqgR5EGs46++4fTeE=;
 b=LnvPUc/oHHLrdtV0gFRm2blmmjLGjRfevmoFqcn3HJE8O1BfXbgKNMu+liIigzEAuxdi8lYRzmzjdA0qF7qxC7OwyEqZ7IbmMLcolrgIUUDuC3yO+4vMXmYqINVeZ6Bxa4Cf3gaqHlW6vvDKAv2EfaE6cUthi/NxVmUb30azntkuipvqnJ95yOBl62/bepDr89nqP/Z4UtYehCSU/VI5xm2xtjspLxYrZhQSZhw1yRNKJM3+Rc9gqeVk8O0HVwFVc7FeAp9OX8w4zU/1ymqnj6iilwe+YwoagD0VhnW/c/9fAgMgozasNqL44CwY9iyDiFEfYCaFk0X4kFhBzvjh7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9424.eurprd04.prod.outlook.com (2603:10a6:102:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:07:02 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:07:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 Oct 2025 16:06:17 -0400
Subject: [PATCH v5 5/5] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-i3c_ddr-v5-5-444184f7725e@nxp.com>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
In-Reply-To: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Carlos Song <carlos.song@nxp.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759867595; l=18088;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GonrF7xXq/NBENSVkVqI32qPT3KoP3ONBxKZ91a29lw=;
 b=D0X4f33UigW8jmS6jMSXWLcIV8RrATKfuijtQTGsDa3dhJDlNqaBST1rtAznHOIRo98Ng4xfU
 yufWFOnvcyhAV/wFOCDMjXVzwBimR7IkYNqAYeEffSZDPgH59fSe0Ly
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:a03:117::22) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: ef70cfbe-2045-4fad-abe5-08de05dd142e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dE12YmhpU2syTnk1Qk1Yb2NMbExHUVlZQmtGSHRIZE4vWUIyZ3F4YVhrVVIv?=
 =?utf-8?B?ZFJkMUJwbnMxZEVPZW1kekZ5bUEyQlNCK0s4MkM5SE84dEVuQWFwaDlsckN1?=
 =?utf-8?B?OTBBOERSc1lxSlAvUEhGTEZvazM5OVJnQ1VlODMwV3IxSktQaE1FOUdrR2pu?=
 =?utf-8?B?WVZnMDYvaC9paDJQMmhFTDkyaFRIVmRoS0Z3VDBQQ2dQc21rdGJwYWVNdlNj?=
 =?utf-8?B?Y3UxTG9td3VTb2VaNzR2WW5NUUlwQ1NKemVndHI5TUpMWnRYVTdCNHR1SU80?=
 =?utf-8?B?WFFEakcwL3V1Q3FxcmlHZWttVTh5UkNEenFjbHc2WWhEZ0g4Q2ZkWGRnNFM5?=
 =?utf-8?B?c1Q1NEY2VnJTSVZlL0RmY1M3QlRQQ054ZHdyODh6MUdPeGs3ZUFrNlcrdU1B?=
 =?utf-8?B?S21jZGdoazRFSkI3TUNDcWNnOUlkMVk3LzZtQ2VHbnp1MUN1enRzd05xVTNE?=
 =?utf-8?B?TzJLSWVVM2g5WE02a1F1U0ptTmViRXIxcGVrekc3MFlXVWI0cjNrdENiWG9I?=
 =?utf-8?B?elFkeVppVTRtNEdXa0N0ZXZIeGVLczlmTmsxSE1uUTg2T2doT1JTZVpRc0Fj?=
 =?utf-8?B?OGVsemJONGJiUjlTeXh5azhBYnF3R0p0cXJaNy9xemUxbWFwUTlDUVlNZ3Fx?=
 =?utf-8?B?di9sQVJ6VGk4RzVEOHM5WUdqZkFUeThDOE1mdXlUWHA3S2V5bGZuS0FhQzcv?=
 =?utf-8?B?bEEvQ2VEdW1wVFg4UnBxbGptYUZKSm1iQ29henFQR2JHSklqWlNrc1R3R1p0?=
 =?utf-8?B?VTJyYzQ3MHYyRnk5S24venR2ZWNQV3pRbmpBdERObGJiaGxmeHlmVk9EUDlo?=
 =?utf-8?B?M2xlSDV0SDZjSnVYajZLWURoR1BYL0F4NzV5TnNJVGFBQ3RNZTV1WUZvVThs?=
 =?utf-8?B?SUliY3FmbnB4bUJzZjZCczAydThGczBlTmdrOERDbFdIQTNiUStPd09OSFNS?=
 =?utf-8?B?SjlzVXdxT2JNVFF3Nmc3TzJBYjhXclpzTDk4TEhTTmNYdDhyNkszZS91Kzkw?=
 =?utf-8?B?UFRJdEZ3dDMzNVRiOFVDOGVST1dqRXZEOFR6VEtqK3VENHI0UTFiRUVUQWZo?=
 =?utf-8?B?NXNFR3VUeU5tUmRhYTc1S1d5OHJuRkRCWXRxanZGWnVWVCswWmx4Rno4Y2xk?=
 =?utf-8?B?NEw2ZlQ1VEhDUzVjSUowWmVROW5wN05iYnJKeVBKd2VCY2tIcmRlTGRhYUw0?=
 =?utf-8?B?QkZHdUc4SThnOWtmUWNGbjg5U2pCZmFGdExBT2dKNU4rQVB4RUNNU1pWKzF4?=
 =?utf-8?B?NnlmeHZrcExpU1FId2NBNXV0cEN6ZGZWSFJtVkNnRFgrd012L1V2MGhLME96?=
 =?utf-8?B?NXU5andlVkR4am13Z3lHSHBESy9PNkFSRVpucDBPN3dOdGxkSFRFY0ZKVUNl?=
 =?utf-8?B?K0NKZGlwSkJpQ3hkaVUzbkpYbTdWWFVqQlU3dlJtYUZJd2Y5RzA2VlJkeDJP?=
 =?utf-8?B?d09QWGtWOXV2OG9wUGpZbyt2ZHZwY2YyK3h5cnIwMXBSNmVIbFJxR3M3MEVt?=
 =?utf-8?B?emU2dVZvSVZJaitjamQ2T1hxSVR4TU1jSVdsVjFPamtCVHhldVdnbmxPRFhr?=
 =?utf-8?B?Q3B1Y1M4M0tFREZ5c3I4OUlLNFI4UmhDcE4yNlQzaHJPOUpuMlZMZlVIa1Ev?=
 =?utf-8?B?R1Bkd1Q2THFPN29lL1lSWUNQV3BkNkpaaUpaR2VyV2hHSkoyaXR3VWhVN1d0?=
 =?utf-8?B?SWpNaldBNUJvajFsZjdQcitRWHJReEt6eXI2bjB0bmJ3c1czRjBUWFhmQURF?=
 =?utf-8?B?T2VJM3RhbDdMUlR5QlRaWVNpTlhGQmxtT2lXdXZrY1M0TXZzOFRmUTVtcUx4?=
 =?utf-8?B?WndnNFNtWFV4RDltVmsvNDF3S1ZQVTEybjE1ZnVtN0hhQXZlZkV2VXBlMGxn?=
 =?utf-8?B?NVo2WmZoN1RSdDc2UnUwRnEyUkRsanZ2Y1ZzVWxVRlVQdmg3MkxjQU9hMzFC?=
 =?utf-8?B?UFl6dGozZWs5SjMwNmYxcWZvaWZMQWJ5Zkk3d3hjaXdkNzJLdkNiUzh4ZHZn?=
 =?utf-8?B?eVA3R3U4Lzl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blYvSjlUSWJ6N1RQQXM0Y3pLdXJobTBnSUNCbXpvZlBhMndseXJwVCtDVVZy?=
 =?utf-8?B?TjE5ZTlta2s1b0c2alN0Mk51c2VIaDlzb2VCTXlSakJMYzFxTlZQREx0dXpC?=
 =?utf-8?B?ZWViakZBRXZYOGJRR1kzTXpjUkNoaDhYSUhiTUZDRmhSRjgydmRzNUtoTzlw?=
 =?utf-8?B?T3ZyZnFTQ29sdno5aW9wY0xRTVNjcGpXcWlkY1R5TStTK3B1TlZ2Q3RyZFA1?=
 =?utf-8?B?eWplcDBVMUl3SXRxYk1kUkUycWp1Q0ZuSS9oaUM5R21ZNmlNNGRsMnJIMjF0?=
 =?utf-8?B?d1Y1L202WitqOFl3MXFNZmpMa3JpWXZFOU5meC9ieUZ0b2E2Z0lHMjJIZkxP?=
 =?utf-8?B?SzRhcEVGMk9CU2hFVi9TbENDaXZJcUpGTkFuTGVDeXRxR1hBT2NHbmR5aWtn?=
 =?utf-8?B?QWVkTU9CcHVocVNZRUFKSEpGWVFQa2ZpQTh6bE0yUnpyRWtCd2lzYWhUbEVU?=
 =?utf-8?B?NldmTzd2a0JwSmJqc1BqcmMzQ24rekZPNWR6VVpkM09PZm1SNTdKQi9YK0hp?=
 =?utf-8?B?V1FVV09GaVArakdZZnJpTXV2cjJXTDJCOVMrVklCQ0c5SlBnSUcxc3RvdjFJ?=
 =?utf-8?B?V0VOSUhxc3VJc2VjUjV0Y1ZrZXNjV1ZZZHRGcHcxL1BOTThwOExDVTlGVER3?=
 =?utf-8?B?RmlLWUJJYVQxM3luK0trcFdYQmUreVdLWncrTkpMbnlsMTRibDMzQW9yZ3g5?=
 =?utf-8?B?RjB6a2l1STl5Uy9pVmpOM21UQWJrdHJHQ2xNTnZvUC8xTWFjM1didTAxRmRQ?=
 =?utf-8?B?QnpGdTVqSXgrNFpxNVR4MkpiOHF5MnZxZDc1dlVXbjRkR0ZBalBBRHl0M3E4?=
 =?utf-8?B?cTNPemhocXQwRklZckRSWElqdUdnMC9xd2dZWU9lcGUrVkU1aG54Z3NrZ25r?=
 =?utf-8?B?eGpoYWtjU1BWaDZpeWFBWTZETFU1RlZXOGszV1NkNktNMUxScUJtRmpDcnhh?=
 =?utf-8?B?TC81eC9KT0F1Kzd0NkIySDNYVHJtdEFSZ3V3eDVKVTZxdDZwamc4VTRhMGRt?=
 =?utf-8?B?aE5tdWp0Q1FWQ01rV0ZSSTFiU0RiclZaeS9NdGdxbE85ZnFtazlQQytlNFhP?=
 =?utf-8?B?dFZXUG1KdlpZcFQrREdvaFZMQWh6Y21FSkRROHYzMktQWTlOZnVPV0FZN2Y2?=
 =?utf-8?B?NzFhaTYyWS94aTB4NE9WZ0dBUHRuU2ZUeE1YSVVyNy8vUVY4eXZPQXZuaWVX?=
 =?utf-8?B?blp3M1RQTW5KNmIwa3dYMlZQb1Z6NkFqTGZUeE4vM0cyc00rSkxYVVA3cFpm?=
 =?utf-8?B?NFRDMEhCaTM3NC9IbEg3Wkp5V25RU0ovNEdDS3VncVR1RFNDRnZXUFR3UUtw?=
 =?utf-8?B?YzMxWTZkRWQrcUoyRnV4a0RWTmxOaHFOeU9hV1JWR2J5L2JXTExTQ25kME1z?=
 =?utf-8?B?MWxUN29Gb2k3bm05Uno1enNwVnRCTnJSY1BTelBab2Z1cFp2ZDZjUDBTVkl5?=
 =?utf-8?B?bUJTTlYvNWlsRmdsdkE0QjFrVXdDOWVDdTlaeGR1MjltdFYvNHd2c2xjZmtw?=
 =?utf-8?B?cCs1YWZtWENHQ0hYRFRnbHFCSXRCZjZUeHYrRkxIclJ5OEJIdHVmWk52dnhh?=
 =?utf-8?B?V2ZNYWpLbUVwWm9jUnY2RkJMSGtQcmZxSjNBZXJnblp5TmprTE1hNlFaS0ND?=
 =?utf-8?B?Y1huS0pleFVUaVZZblI2UzJ2QnRWbHpuUTgwTW5wTk0zdHBsSTVHRElnZ21x?=
 =?utf-8?B?WWtVY09pTHROVzlEZjdweUI2NjdiZUp1YjNGRStNSkE0bEFIc1lScTA3RVV2?=
 =?utf-8?B?cFZEV1NkYjFGSG5UMUxEVU9KeHJXZ09paE5vQ01PeDZwc3pYeFNydHkyMVBG?=
 =?utf-8?B?eVdVL3cra1hKRzE0YzZYcFVNVVdvUGFad0k3bkIwUlpUSlVoaGJ3ZFo4Mk1I?=
 =?utf-8?B?YVBMSExXSG1RN3VJVXh5eW5TRVdlVFFoZlI5dUNOWk9oVVJQU3gwbVB2a2t4?=
 =?utf-8?B?L3BlWUlpKy9JVng2QjBrZWl3Q1djSS9JNkxYeTEwQjlxYUNCVGJ3enlRRGdJ?=
 =?utf-8?B?QTF4K3pnaHlqazh0bUpzUUlNOTkvM09ta2ljQnJ2Rnk2dEZBaG5tVGFqeGF6?=
 =?utf-8?B?RkxTZ1BxcWExdHpJZ0VXZ0h2Z0lTb0N2a05jQzBGY1Q5S0wySjFTbDVqOUtL?=
 =?utf-8?Q?vZJigMbr+sb352EYHvJk2BRZK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef70cfbe-2045-4fad-abe5-08de05dd142e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:07:02.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Om3Ff7YQME/SNvgGqL7oLPLR8MsbGEDMJArIH0y3lvrs0opLdFpLKl0goyMFSV7ORFrIOc8aBn4GxjXybYHMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9424

Add mmc5633 sensor basic support.
- Support read 20 bits X/Y/Z magnetic.
- Support I3C HDR mode to send start measurememt command.
- Support I3C HDR mode to read all sensors data by one command.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in V4
- use { 1, 2000 }
- Add _US for timeout
- Use GEN_MASK for MMC5633_CTRL1_BW_MASK
- Use { } for terminator.
- remove !!
- fix mix tab and space
- add mmc5603 (merge https://lore.kernel.org/all/20251003000731.22927-1-fluturel.adrian@gmail.com/)
- add tempature measure support

Change in v3
- remove mmc5633_hw_set
- make -> Make
- change indention for mmc5633_samp_freq
- use u8 arrary to handle dword data
- get_unaligned_be16() to get raw data
- add helper function to check if i3c support hdr
- use read_avail() callback

change in v2
- new patch
---
 drivers/iio/magnetometer/Kconfig   |  12 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mmc5633.c | 579 +++++++++++++++++++++++++++++++++++++
 3 files changed, 592 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 81b812a29044e2b0b9ff84889c21aa3ebc20be35..cfb74a4a083630678a1db1132a14264de451a31a 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -139,6 +139,18 @@ config MMC35240
 	  To compile this driver as a module, choose M here: the module
 	  will be called mmc35240.
 
+config MMC5633
+	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
+	select REGMAP_I2C
+	select REGMAP_I3C
+	depends on I2C || I3C
+	help
+	  Say yes here to build support for the MEMSIC MMC5633 3-axis
+	  magnetic sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mmc5633
+
 config IIO_ST_MAGN_3AXIS
 	tristate "STMicroelectronics magnetometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index dfe970fcacb8664b293af84893f7d3e3e8d7bf7e..5bd227f8c1204bdd8b8a43da180833eedca1457b 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
+obj-$(CONFIG_MMC5633)	+= mmc5633.o
 
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
 st_magn-y := st_magn_core.o
diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
new file mode 100644
index 0000000000000000000000000000000000000000..9b04cba6dbf633b7e0d136629a5aebffd072a68d
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,579 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMC5633 - MEMSIC 3-axis Magnetic Sensor
+ *
+ * Copyright (c) 2015, Intel Corporation.
+ * Copyright (c) 2025, NXP
+ *
+ * IIO driver for MMC5633, base on mmc35240.c
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/unaligned.h>
+
+#define MMC5633_REG_XOUT_L	0x00
+#define MMC5633_REG_XOUT_H	0x01
+#define MMC5633_REG_YOUT_L	0x02
+#define MMC5633_REG_YOUT_H	0x03
+#define MMC5633_REG_ZOUT_L	0x04
+#define MMC5633_REG_ZOUT_H	0x05
+#define MMC5633_REG_XOUT_2	0x06
+#define MMC5633_REG_YOUT_2	0x07
+#define MMC5633_REG_ZOUT_2	0x08
+#define MMC5633_REG_TOUT	0x09
+
+#define MMC5633_REG_STATUS1	0x18
+#define MMC5633_REG_STATUS0	0x19
+#define MMC5633_REG_CTRL0	0x1b
+#define MMC5633_REG_CTRL1	0x1c
+#define MMC5633_REG_CTRL2	0x1d
+
+#define MMC5633_REG_ID		0x39
+
+#define MMC5633_STATUS1_MEAS_T_DONE_BIT	BIT(7)
+#define MMC5633_STATUS1_MEAS_M_DONE_BIT	BIT(6)
+
+#define MMC5633_CTRL0_CMM_FREQ_EN	BIT(7)
+#define MMC5633_CTRL0_AUTO_ST_EN	BIT(6)
+#define MMC5633_CTRL0_AUTO_SR_EN	BIT(5)
+#define MMC5633_CTRL0_RESET		BIT(4)
+#define MMC5633_CTRL0_SET		BIT(3)
+#define MMC5633_CTRL0_MEAS_T		BIT(1)
+#define MMC5633_CTRL0_MEAS_M		BIT(0)
+
+#define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
+
+#define MMC5633_WAIT_SET_RESET_US	1000
+
+#define MMC5633_HDR_CTRL0_MEAS_M	0x01
+#define MMC5633_HDR_CTRL0_MEAS_T	0x03
+#define MMC5633_HDR_CTRL0_SET		0X05
+#define MMC5633_HDR_CTRL0_RESET		0x07
+
+enum mmc5633_axis {
+	MMC5633_AXIS_X,
+	MMC5633_AXIS_Y,
+	MMC5633_AXIS_Z,
+	MMC5633_TEMPERATURE,
+};
+
+struct mmc5633_data {
+	struct device *dev;
+	struct i3c_device *i3cdev;
+	struct mutex mutex; /* protect to finish one whole measurement */
+	struct regmap *regmap;
+};
+
+static const struct {
+	int val;
+	int val2;
+} mmc5633_samp_freq[] = {
+	{ 1, 200000 },
+	{ 2, 0 },
+	{ 3, 500000 },
+	{ 6, 600000 },
+};
+
+#define MMC5633_CHANNEL(_axis) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _axis, \
+	.address = MMC5633_AXIS_ ## _axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				    BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mmc5633_channels[] = {
+	MMC5633_CHANNEL(X),
+	MMC5633_CHANNEL(Y),
+	MMC5633_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.address = MMC5633_TEMPERATURE,
+	},
+};
+
+static int mmc5633_get_samp_freq_index(struct mmc5633_data *data,
+				       int val, int val2)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)
+		if (mmc5633_samp_freq[i].val == val &&
+		    mmc5633_samp_freq[i].val2 == val2)
+			return i;
+	return -EINVAL;
+}
+
+static int mmc5633_init(struct mmc5633_data *data)
+{
+	unsigned int reg_id, ret;
+
+	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret,
+				     "Error reading product id\n");
+
+	/*
+	 * Make sure we restore sensor characteristics, by doing
+	 * a SET/RESET sequence, the axis polarity being naturally
+	 * aligned after RESET.
+	 */
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_SET);
+	if (ret < 0)
+		return ret;
+
+	fsleep(MMC5633_WAIT_SET_RESET_US);
+
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
+	if (ret < 0)
+		return ret;
+
+	/* set default sampling frequency */
+	return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+				  MMC5633_CTRL1_BW_MASK,
+				  FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
+}
+
+static int mmc5633_take_measurement(struct mmc5633_data *data, int address)
+{
+	unsigned int reg_status;
+	int ret;
+	int val;
+
+	val = (address == MMC5633_TEMPERATURE) ? MMC5633_CTRL0_MEAS_T : MMC5633_CTRL0_MEAS_M;
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, val);
+	if (ret < 0)
+		return ret;
+
+	val = (address == MMC5633_TEMPERATURE) ?
+	      MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
+				       reg_status & val, 10000, 10000 * 100);
+	if (ret) {
+		dev_err(data->dev, "data not ready\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static bool mmc5633_is_support_hdr(struct mmc5633_data *data)
+{
+	if (!data->i3cdev)
+		return false;
+
+	return i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR);
+}
+
+static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
+{
+	u8 data_cmd[2], status[2];
+	int ret, val, ready;
+
+	if (mmc5633_is_support_hdr(data)) {
+		struct i3c_xfer xfers_wr_cmd[] = {
+			{
+				.cmd = 0x3b,
+				.len = 2,
+				.data.out = data_cmd,
+			}
+		};
+
+		struct i3c_xfer xfers_rd_sta_cmd[] = {
+			{
+				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
+				.len = 2,
+				.data.in = status,
+			},
+		};
+
+		struct i3c_xfer xfers_rd_data_cmd[] = {
+			{
+				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
+				.len = sz,
+				.data.in = buf,
+			},
+		};
+
+		data_cmd[0] = 0;
+		data_cmd[1] = (address == MMC5633_TEMPERATURE) ?
+			      MMC5633_HDR_CTRL0_MEAS_T : MMC5633_HDR_CTRL0_MEAS_M;
+
+		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd, 1, I3C_HDR_DDR);
+		if (ret < 0)
+			return ret;
+
+		ready = (address == MMC5633_TEMPERATURE) ?
+			MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+		ret = read_poll_timeout(i3c_device_do_xfers, val,
+					val ||
+					status[0] & ready,
+					10000, 10000 * 100, 0,
+					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);
+
+		if (ret || val) {
+			dev_err(data->dev, "data not ready\n");
+			return ret ? ret : -EIO;
+		}
+
+		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd, 1, I3C_HDR_DDR);
+	}
+
+	/* Fallback to use SDR/I2C mode */
+	ret = mmc5633_take_measurement(data, address);
+	if (ret < 0)
+		return ret;
+
+	if (address == MMC5633_TEMPERATURE)
+		/*
+		 * Put tempeature to last byte of buff to align HDR case.
+		 * I3C will early terminate data read if previous data is not
+		 * available.
+		 */
+		return regmap_bulk_read(data->regmap, MMC5633_REG_TOUT, buf + sz - 1, 1);
+
+	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
+}
+
+#define MMC5633_ALL_SIZE (3 * 3 + 1) /* each channel have 3 byte and TEMP */
+
+static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
+{
+	if (index == MMC5633_TEMPERATURE) {
+		*val = buf[MMC5633_ALL_SIZE - 1];
+		return 0;
+	}
+	/*
+	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
+	 */
+	*val = get_unaligned_be16(buf + 2 * index) << 4;
+	*val |= buf[index + 6] >> 4;
+
+	return 0;
+}
+
+static int mmc5633_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	char buf[MMC5633_ALL_SIZE];
+	unsigned int reg;
+	int ret, i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &data->mutex) {
+			ret = mmc5633_read_measurement(data, chan->address, buf, MMC5633_ALL_SIZE);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = mmc5633_get_raw(data, chan->address, buf, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_MAGN) {
+			*val = 0;
+			*val2 = 62500;
+		} else {
+			*val = 0;
+			*val2 = 800000000; /* 0.8C */
+		}
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			*val = -75;
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
+			if (ret < 0)
+				return ret;
+		}
+
+		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);
+		if (i >= ARRAY_SIZE(mmc5633_samp_freq))
+			return -EINVAL;
+
+		*val = mmc5633_samp_freq[i].val;
+		*val2 = mmc5633_samp_freq[i].val2;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	int i, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		i = mmc5633_get_samp_freq_index(data, val, val2);
+		if (i < 0)
+			return -EINVAL;
+
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+						 MMC5633_CTRL1_BW_MASK,
+						 FIELD_PREP(MMC5633_CTRL1_BW_MASK, i));
+			if (ret)
+				return ret;
+		};
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals,
+			      int *type,
+			      int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)mmc5633_samp_freq;
+		*length = ARRAY_SIZE(mmc5633_samp_freq) * 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mmc5633_info = {
+	.read_raw	= mmc5633_read_raw,
+	.write_raw	= mmc5633_write_raw,
+	.read_avail	= mmc5633_read_avail,
+};
+
+static bool mmc5633_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_XOUT_L:
+	case MMC5633_REG_XOUT_H:
+	case MMC5633_REG_YOUT_L:
+	case MMC5633_REG_YOUT_H:
+	case MMC5633_REG_ZOUT_L:
+	case MMC5633_REG_ZOUT_H:
+	case MMC5633_REG_XOUT_2:
+	case MMC5633_REG_YOUT_2:
+	case MMC5633_REG_ZOUT_2:
+	case MMC5633_REG_TOUT:
+	case MMC5633_REG_STATUS1:
+	case MMC5633_REG_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct reg_default mmc5633_reg_defaults[] = {
+	{ MMC5633_REG_CTRL0,  0x00 },
+	{ MMC5633_REG_CTRL1,  0x00 },
+};
+
+static const struct regmap_config mmc5633_regmap_config = {
+	.name = "mmc5633_regmap",
+
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = MMC5633_REG_ID,
+	.cache_type = REGCACHE_MAPLE,
+
+	.writeable_reg = mmc5633_is_writeable_reg,
+	.readable_reg = mmc5633_is_readable_reg,
+	.volatile_reg = mmc5633_is_volatile_reg,
+
+	.reg_defaults = mmc5633_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(mmc5633_reg_defaults),
+};
+
+static int mmc5633_common_probe(struct device *dev, struct regmap *regmap,
+				char *name, struct i3c_device *i3cdev)
+{
+	struct mmc5633_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, indio_dev);
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = regmap;
+	data->i3cdev = i3cdev;
+	data->dev = dev;
+
+	ret = devm_mutex_init(dev, &data->mutex);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &mmc5633_info;
+	indio_dev->name = name;
+	indio_dev->channels = mmc5633_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mmc5633_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = mmc5633_init(data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mmc5633 chip init failed\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int mmc5633_suspend(struct device *dev)
+{
+	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
+
+	regcache_cache_only(data->regmap, true);
+
+	return 0;
+}
+
+static int mmc5633_resume(struct device *dev)
+{
+	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	regcache_mark_dirty(data->regmap);
+	ret = regcache_sync_region(data->regmap, MMC5633_REG_CTRL0,
+				   MMC5633_REG_CTRL1);
+	if (ret < 0)
+		dev_err(dev, "Failed to restore control registers\n");
+
+	regcache_cache_only(data->regmap, false);
+
+	return 0;
+}
+
+static int mmc5633_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return mmc5633_common_probe(dev, regmap, client->name, NULL);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend,
+				mmc5633_resume);
+
+static const struct of_device_id mmc5633_of_match[] = {
+	{ .compatible = "memsic,mmc5603", },
+	{ .compatible = "memsic,mmc5633", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc5633_of_match);
+
+static const struct i2c_device_id mmc5633_i2c_id[] = {
+	{ "mmc5603" },
+	{ "mmc5633" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
+
+static const struct acpi_device_id mmc5633_acpi_match[] = {
+	{ "MMC5603", 0 },
+	{ "mmc5633", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, mmc5633_acpi_match);
+
+static struct i2c_driver mmc5633_i2c_driver = {
+	.driver = {
+		.name = "mmc5633_i2c",
+		.of_match_table = mmc5633_of_match,
+		.acpi_match_table = mmc5633_acpi_match,
+		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
+	},
+	.probe = mmc5633_i2c_probe,
+	.id_table =  mmc5633_i2c_id,
+};
+
+static const struct i3c_device_id mmc5633_i3c_ids[] = {
+	I3C_DEVICE(0x0251, 0x0000, NULL),
+	{ }
+};
+MODULE_DEVICE_TABLE(i3c, mmc5633_i3c_ids);
+
+static int mmc5633_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return mmc5633_common_probe(dev, regmap, "mmc5633_i3c", i3cdev);
+}
+
+static struct i3c_driver mmc5633_i3c_driver = {
+	.driver = {
+		.name = "mmc5633_i3c",
+	},
+	.probe = mmc5633_i3c_probe,
+	.id_table = mmc5633_i3c_ids,
+};
+
+module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
+
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


