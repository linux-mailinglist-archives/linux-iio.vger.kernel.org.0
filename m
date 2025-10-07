Return-Path: <linux-iio+bounces-24825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF57BC1EA2
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 17:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17493ADBDB
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5712E54B6;
	Tue,  7 Oct 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eGd2CC8/"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E149B2E5B0C;
	Tue,  7 Oct 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850574; cv=fail; b=Vtx3PE1q5kmm7cDdKkEJ6dvl7wfAvhFK/OsNK0TQ6YQEOIQBqUaArejxFN0H0ymP1UfdvdNUSOObhNY8qbig7u822idtuHraPz3uo9xAFQT89GmGZlIG4vyqOJH9sFGfyItnMj12D4QeXjNEH+WKwXDAi+ZAqSnlyswFunWANdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850574; c=relaxed/simple;
	bh=qJi9xaVFOFE0ps52evCjiEaC3wuX9Z7sbGxZDDCymlM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sGFKGX2aHe5JmUovIpFlzWhSaCkaXQbKGS/4+p9u23m5fjKp8kp3aF9WHzUp8av9U6iZAnk8ReZqAOZYSakpvCXt5p8rJsTCOgwCkFIyg583vqnz0iiY2Iiic1U78TNsv3HtKGDvHfjoTZzDEVQLFeKdiADczP9hHBzKgqEtuNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eGd2CC8/; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY9+eJgXyL0hqPfr6udFuhJ4JUEuso/BS/IONTRVPxaL/2siymntLk5xMLXsXPAcEdkZQS+IxuvvbqgVX10dLmjuwCTbxEXpROylCSya7tFYBXvuFs7UqPzgVFA3VdNAUkT+HaXjB3OTYnUOMKB9OIlTIgJkQV6fj1mgn15uM3nej/I+DM9ZmJx25iuH+eHV9uNw5vSIp0Gd5GsFq8oY6yHPUbGNVS6cvcePJlqlsY5oOE0yUChVwVY4L8YoiRmh9VOsyLyq6qb7gmFxqxyvDrEOdHkKg0rDSehzJ6Lq01xUoyGAtlwongnbaTxcrXMfKdl/aWE5l7XLIMjGqjcWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmW+Zr2VF7bUYa9194XE3pZUvXT59ae8F3BoukpVsr4=;
 b=ZDHDjs2HfuQhzQQ/LgBXEL49tmI4JHOG9Pm6hw431cFyw617NpXFQE5usrd+NDoQ6HfYTQsO48bB1Je+dtPcKFReetswll83v+mF0Pf3sdCbt1NHsT80ie18ybDLaj9a3GojV2pyg8jNMhwApkJUtlg/Zg7HlEA/e9oI+bmXefHk4CaBBAyQr+dPEsQoAUj3BZw9m7BXqwhk+jcBYQ/fqJ3QHIdjrT7uThyWfAogpqYarCUZvQVO+7ZsoFQkJ3DByOjc8L5dPiSJ/jglVw8k0ZJxXxWjAn6W1d1LCc+qeiDI6UsXTKdIFiXYGMtW2POrkI0cOcDzNvBZU7YE6EqzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmW+Zr2VF7bUYa9194XE3pZUvXT59ae8F3BoukpVsr4=;
 b=eGd2CC8/1S/c0qldu6+BMymDcOnijpaTKzt5ddwIqQCL170kINNNL9YvwiZfdHyEXNkrYlsuIiLTKfU325KV5gzTlaE7QtHF+HUXGVwvkuY16ebkNhFijvOUWn7J4lDkK3VtZn6C6qnonuFZvWtu5bMTgJhnMEfaPRcGeHNVs1uzyp0429quNZKtjcKvKrSN3BpzyLHSVK/c16IzW6PPaLv9RxoHkj0iQyw+nPQCnmOuIo0vJs28XVvuuWUDij0Be9kabzTmeQb8jm3cJesscVsLVo4aZ48/OUVojOAnnmiN/4LsTQY0zyOPlnVAVXiGBX+T+nlJeEe5lFvXvLklUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:22:46 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9182.015; Tue, 7 Oct 2025
 15:22:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 Oct 2025 11:22:15 -0400
Subject: [PATCH v4 1/5] i3c: Add HDR API support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-i3c_ddr-v4-1-3afea5105775@nxp.com>
References: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
In-Reply-To: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759850558; l=10203;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qJi9xaVFOFE0ps52evCjiEaC3wuX9Z7sbGxZDDCymlM=;
 b=iEiBLrJ9kY0RQjzIUvjnlNQtat/LBQPRUfzxWpmltH+NlfleFlKljVJHWe8fXrNAhURteHYX9
 xpaNinitMOACPTyZmbygJHwjOtLqmv31EOQAVZUkOAuvW8L+aK5Xy12
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 05712274-018f-449c-bda4-08de05b55e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTc2YzhSTk11UjdjeVJDZER4YkZaOTVwYXlscmF3SVp2YnhGQkNNNTdVV3pq?=
 =?utf-8?B?OHMwc2djSFk3Z3E1ZHgvK1ZaS2d1L2lIa2JFaVlpUUZpQjJSR3lzSFVEaXRB?=
 =?utf-8?B?cnJHdFBNQzN6TytyZlFFM0NSb1ZkZzhSUlhwYVUwdXpreU92aFV5cU8rUVBK?=
 =?utf-8?B?UnJrOTBIQWRiNXlvY3dNTW45T1ZmbzNjd2dZSDN3RGlKaytNSWQyODRNL2tQ?=
 =?utf-8?B?clczeDVCM1U1QURNWHVOTjBDUFQrOEFxbC81dzJzNEliQXZEajBqWmlqWEd5?=
 =?utf-8?B?a0hyL2tSYzFnU1RtYms1eVZmOVVtcGJ1T0NvM0tBUFRydlE3OHRFUXYzcVRa?=
 =?utf-8?B?UFFsV05OQXBpam5STzdJSVluNjJRQURPeVdLYzY4d2Jtdm5zcmxlZVhidmxn?=
 =?utf-8?B?RVc2SVQ1TWYwc01WQW12amFsdGhaSzBBWHZtVEFRd3lGREk5blhYT1p3NTVy?=
 =?utf-8?B?OFdIZy9ZU0N0ck0wQU84VnVrcGtoaHZSUCtUS3h4OHJEdll5Qm5TL0I5emZW?=
 =?utf-8?B?OXNieDRxZzljcjJQSVdDem9ySGFNYWRNcS93TWlsYzBETEJCU3JlVElBVzkr?=
 =?utf-8?B?bVNtdWMrRzdlVUw5T2NUQ0ZuQ2FmSFpBeEZPM0NnbWFacll6cHhncGxjZnFs?=
 =?utf-8?B?NTY1SFN1L2czNmg4eXNXSVlGQ0lOa0pEMzFVVzVrb2JrVVpqMFBuMEtDcC8x?=
 =?utf-8?B?ZHdkeUxFOUNhTTJxaFRWN1RvMHBKUjBXTHhYTzRHOWFlZjYybFJxNmdicXBW?=
 =?utf-8?B?Rzlua2lYQldVbFZhOE0yc1NnOUdoWmRMdVdDdmI2K0tZOG1QTVFIdTVpUzhD?=
 =?utf-8?B?cVQ4ckdVdzNLYk9MUlh2Wi85KzBnYlIybjEwWVU1TWd2b2FFdDZ1TnBrVW42?=
 =?utf-8?B?cm15by9mTTNZUzdYSExqK1A0a3poV2U0Ny8vY3VveGoxQ2dHdWlwczZjMVE2?=
 =?utf-8?B?ZVl3VnBjeUJUd3hCaUE5UDhmTWE2MzQ5cVRiTm5rbEdGL1l6WG05cFNmcGNM?=
 =?utf-8?B?QkU4OFQxbXBpd1BJc0V3NGZJRC94ZmovZmRJQUgvYTRnNE01WFpJNXh1NDZa?=
 =?utf-8?B?bjRWY1c1OVpwWnJ0TElucGF3R05XQ0hidjlLS0VkdHovdk1KQlc3djMyMDNt?=
 =?utf-8?B?NHQ3dGNocjFQRWJWVGl5dWk4L0tnSXBzeEh5N1E3V1YrVkRDUkttZE9hU01Q?=
 =?utf-8?B?Wi9iYUxGd2ZFbnB5MHZkT1N3YlltQlQyclRFbTh6R1JwaGJYUEg5TnUySldx?=
 =?utf-8?B?MEttNFhPNVlrS2hVVzNYQnVQL0JMMlBBcklHcXdRYUp5clFadjBDUWJjVEpi?=
 =?utf-8?B?V0lIekVHYWIyemxsMnZ2cDg2Ym9wMlU4aENnRFJITkZGLzBjK05lNXVUV1JE?=
 =?utf-8?B?b0JqQ3c0VDNlbE1wQ2Zqb3c3UklEdTRPMU15SnVuQytBTkxKaDlXb014OXNC?=
 =?utf-8?B?OXBUYkR0VmJyRU53K0UvbDRyelFUUXQ0c3JLUU8reHVmU1ZXMDNUMVViUDMz?=
 =?utf-8?B?Y2cweDVmUmViMUsyZ2ZHNHNMaUt1eC9vZjZlK3ArM2FRTjczaXNvSE93cTRZ?=
 =?utf-8?B?NFdMS0kxUFBSMHB5Ly9ibmQ3ZE5rOTZ4QWljajNEVzdob045QnJud1p2K09P?=
 =?utf-8?B?aE43ZnlaQXduVVpUOTJja3RlWGlRVnI3NnVzU1VoaFMzSkZDMXJzRE1hWkJh?=
 =?utf-8?B?NlJRQ0wvTXJpLzlJK2tpUkxEOEhibmlrK2w0MS9PZHZOLzdGVkNUMTQ5V20y?=
 =?utf-8?B?S1hNRWk0UDlnWWtNaktqVHpZaXg1dXlHcTUrWlc0ZkJtK2R4bjFFQVF4Y3pR?=
 =?utf-8?B?UXR0OCtvd1pQT3BPTlZMelJWS2JURUo4REpnWElVcGJNelpWV2JNRmN2N1NZ?=
 =?utf-8?B?OTZtUndpdEpZZTFvS3p6UWRmSnRwYXM3eDBIUEg0YnEzZ292VWYrUFZDSlRt?=
 =?utf-8?B?b2VkM0ZCbVhQYitZb0ZyQUJOQ1JvWnZjMktMQ2QzMTBnVmhISEpESEk3L0Jr?=
 =?utf-8?B?azVhMjU1VWNCL3g5ZUtseWNhRWRoMElobCs0aXRqMTg5S3F5RjdqYTdqcUxC?=
 =?utf-8?Q?EHZUIe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHlGTE1oQ0s5OUM0OXpONmwwbjJRWE9TdUxrbGxoYzJCNkVGaEwwM3JETDZH?=
 =?utf-8?B?QlM1Vld2dlcxeXZtbXkwMlFZUFFUb3AzbjVTZmxhdlFlNlgwengwc3VxemM2?=
 =?utf-8?B?ZnV3UWNvaEpjaVFFTzFPeUZpZHdYTTh4SEUxQ2crNTVTeHdRakl3UDBUR0g0?=
 =?utf-8?B?TktWbVpyVHF2emFvWnN5WXZuRjEyb0o1S3NlZWZpSis4N3NJb2QyTXROVU96?=
 =?utf-8?B?R2I5SE0rY0RTcEliV043aUdRQWVsbU5Edk9NTVhSK0k4THVnQ3YyYjdQS0Fz?=
 =?utf-8?B?MXJ6ZHJWeit4U0FrcEVJTzA4dllNdkFZamoyLzRBTjh1cG5qWFRDZHlmMEJk?=
 =?utf-8?B?MjRCL0swcDVxVjlYeFV0eXBQL1gyN1ZHYW91aE85YStObTkvOHhJRjE2cm0w?=
 =?utf-8?B?WjF3RVJaa0JjR3lndUFkbHpwL2djWW5iRTBHWVZnRmZzSVdsVko2djRtc1B2?=
 =?utf-8?B?Ry9wZTBHMHczejQ0bmdFakg4YTNlYk9rdkRzbUIydmJTUVhMVFhENWx4dHkw?=
 =?utf-8?B?RGYvNys4cFB4STVBOXEwTUFtSFhYSWNiU2dKR0JmWndxQ0JBcmtuczRHdnBj?=
 =?utf-8?B?aU1GK3lIczk4OVM2YThWellmaDNaelA3Y0N4K3g4QWd1MVM3N3oyQXhWTEdL?=
 =?utf-8?B?Mm1Pam9TeGFuSS81U2xKR1RzRUwxYXFWa2VYQVRPWENtMEZVdnhHSmZaVTc0?=
 =?utf-8?B?L2ZvejZFKzJqWVlCOEU5Uzg3QkQ2YkRpQ0dBTFN5Q2F1SzZrU2djVnFjUWI3?=
 =?utf-8?B?WmJXT0cyN0xONmtPTXVFRzI1V3Y5Smo5SEUyUWgyLzhWbHZRVzlEQjhhSHNx?=
 =?utf-8?B?eDNackdTMWJQai9sc3prVEZ2eC9UV2ViWGh3SUprdDNwWVVSd09oYjRzOGJG?=
 =?utf-8?B?cUhYNERjOUxXaDUxaCtjc0dVVWVwM2tabnNzUzlxLzRkcnMvQ2dLWGk0YzZk?=
 =?utf-8?B?aEh2MVVUTDdFaExtNVhXQkJQMm5wdXEzKy9XZWJDMXcrUkdkWjZtenFZNHMw?=
 =?utf-8?B?bjRXYVZFODU4cm1LZXQ2VElBZklzeGpTZlJHd1pNcHQxY2lBTFc2cmhGamFS?=
 =?utf-8?B?T2N1N2ZCRVVkQ1gzMEdaN1FVZDlNSjJ5eHZ5eXU3UlpqQkN4WW9Xc2pqVHo4?=
 =?utf-8?B?djNCblpTODVRQVZvZy9tc3lnRncvZHlEdzZmRENNaUdiS2VTTzdoYkQrRkQ5?=
 =?utf-8?B?WmU3TUkrbE1melFiMTBGWExCSEZkWVZVMmlRKytNb29lUE13YU43Mjd3NDZG?=
 =?utf-8?B?ZWVSc0J6NEthaGNnMDQ0bjRMaVdiM080QVQzblI1eHZlSXBtaGxqbFZnR2Mz?=
 =?utf-8?B?OFIzeDJyUE5kYkVNdVU1ano5SjF6d0lmMXdYdzNjcVFTRWdrT0o1dUU2VFY5?=
 =?utf-8?B?MXZjY0huRVNWdlN0OEtwZnp1TW0rc1dhd05lNDJGYTU4SEloeXYwY05hcWk1?=
 =?utf-8?B?QTJCVDJFMTFIcGQxQWViY3pka0ZpQU5JbWgxdlZ0Q1hTUlRzZmMralJCd1Bz?=
 =?utf-8?B?WEd6SU4wb0gyc201OWhhVVlneXUzcVpEazNpQnZTbExZOFFYVXRuQzJOcGsv?=
 =?utf-8?B?RWI5dldya2xWWEV2TitrdlR2b2VzeXJGdmJkUmpGNTRSdjYxWHhKK1NpdG5W?=
 =?utf-8?B?cE54cEFRVUlRQ1Rhc3VFandvRlFKbE5wTXRkV3ZDRnF5ZW83YmxVMVlZZmFq?=
 =?utf-8?B?MTdUeFpvb3ROUzZaKzZ2ZTNDb05Ga3d3R0Nqc0hjSWVvUy96Z0ZRWFlSamJE?=
 =?utf-8?B?WU9XdXk1MXh5UkFRNjI5MmtmTTZsUW11b2h2TWVpYmpxcEkxcjhwL3AvTmo5?=
 =?utf-8?B?M3pXV2xGbkR2YTN3ei9DL1A2YUdNZzZ4UXdmbWFkb21oV3VaN2JKMVBGZ29E?=
 =?utf-8?B?WjVXVjFEUUwydS9IK0VTMWZjUHE1Mzd2L0tuNEJ2UHRFWEYzbDlURlhyOGJ4?=
 =?utf-8?B?MzZkWmxhclZ3N2VFTVpmeHVjSnFoa2JiZ1JyZk5FZGlTZGNhVHBDTzFjdWM2?=
 =?utf-8?B?NGR0L0tuSkN0Z0RKQUxIQVFsZk1ySDM4cHdSbVhzU2Z5N001aU45VGEvN05Y?=
 =?utf-8?B?bkN3ODlua2JINStNcXlFRmpUSnhMSmdmU2dpV3pMcEIwU1BNOW9IUG1jZFJz?=
 =?utf-8?Q?pz3SHgf7qMKXtt/ZwsOE4zfPV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05712274-018f-449c-bda4-08de05b55e25
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:22:46.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i20BQ1zv7eKfTieyC/I3rbhVpKzbVMzwkvR+TEvmxOi4CyroIgR4XzvILwdhH2VsaxpsFNdwb8AsgYZP/HcPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
Technical Overview.

i3c_xfer will be used for both SDR and HDR.

Rename enum i3c_hdr_mode to i3c_xfer_mode. Previous definition need match
CCC GET_CAP1 bit position. Use 31 as SDR transfer mode.

Add i3c_device_do_xfers() with an xfer mode argument, while keeping
i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
with I3C_SDR for backward compatibility.

Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
'rnw', since HDR mode uses read/write commands instead of the SDR address
bit.

Add .i3c_xfers() callback for master controllers. If not implemented, fall
back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
all controllers switch to .i3c_xfers().

Add 'mode_mask' bitmask to advertise controller capability.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Why not add hdr mode in struct i3c_priv_xfer because mode can't be mixed in
one i3c transfer. for example, can't send a HDR follow one SDR between
START and STOP.

i3c_priv_xfer should be treat as whole i3c transactions. If user want send
HDR follow SDR, should be call i3c_device_do_priv_xfers_mode() twice,
instead put into a big i3c_priv_xfer[n].

change in v4
- Rename enum i3c_hdr_mode to i3c_xfer_mode.

change in v3
- Add Depreciated comment for priv_xfers.

change in v2
- don't use 'priv_' since it is refer to sdr mode transfer in spec.
- add 'mode_mask' indicate controller's capibility.
- add helper function to check master's supported transfer mode.
---
 drivers/i3c/device.c       | 27 ++++++++++++++++++++-------
 drivers/i3c/internals.h    |  6 +++---
 drivers/i3c/master.c       | 19 +++++++++++++++----
 include/linux/i3c/device.h | 34 ++++++++++++++++++++++++++--------
 include/linux/i3c/master.h |  4 ++++
 5 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 2396545763ff853097d9f0173787e087f7a6e688..e6add862645196ad41d0c91d3d7103c877a1ef5a 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -15,12 +15,12 @@
 #include "internals.h"
 
 /**
- * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
- *				specific device
+ * i3c_device_do_xfers() - do I3C transfers directed to a specific device
  *
  * @dev: device with which the transfers should be done
  * @xfers: array of transfers
  * @nxfers: number of transfers
+ * @mode: transfer mode
  *
  * Initiate one or several private SDR transfers with @dev.
  *
@@ -33,9 +33,8 @@
  *   'xfers' some time later. See I3C spec ver 1.1.1 09-Jun-2021. Section:
  *   5.1.2.2.3.
  */
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers)
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
+			int nxfers, enum i3c_xfer_mode mode)
 {
 	int ret, i;
 
@@ -48,12 +47,12 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
 	}
 
 	i3c_bus_normaluse_lock(dev->bus);
-	ret = i3c_dev_do_priv_xfers_locked(dev->desc, xfers, nxfers);
+	ret = i3c_dev_do_xfers_locked(dev->desc, xfers, nxfers, mode);
 	i3c_bus_normaluse_unlock(dev->bus);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
+EXPORT_SYMBOL_GPL(i3c_device_do_xfers);
 
 /**
  * i3c_device_do_setdasa() - do I3C dynamic address assignement with
@@ -260,6 +259,20 @@ i3c_device_match_id(struct i3c_device *i3cdev,
 }
 EXPORT_SYMBOL_GPL(i3c_device_match_id);
 
+/**
+ * i3c_device_get_supported_xfer_mode - Returns the supported transfer mode by
+ *					connected master controller.
+ * @dev: I3C device
+ *
+ * Return: a bit mask, which supported transfer mode, bit position is defined at
+ *	   enum i3c_hdr_mode
+ */
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
+{
+	return i3c_dev_get_master(dev->desc)->this->info.hdr_cap | BIT(I3C_SDR);
+}
+EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
+
 /**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 0d857cc68cc5d473db733b12ffcec0c1c28d9def..f8d68b9d6474cbc56640a643db3c2c4cd95dd26b 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -15,9 +15,9 @@ void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
 
 int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev);
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers);
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev,
+			    struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode);
 int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 2ef898a8fd8065032b68c97c52dcb12e771525a4..f5f44bd4f48391e76ae1c605693ad3959cf59806 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2749,10 +2749,13 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	if (!ops || !ops->bus_init ||
 	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
 		return -EINVAL;
 
+	if (!ops->priv_xfers && !ops->i3c_xfers)
+		return -EINVAL;
+
 	if (ops->request_ibi &&
 	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
 	     !ops->recycle_ibi_slot))
@@ -2942,9 +2945,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
 						dev->boardinfo->init_dyn_addr);
 }
 
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers)
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *master;
 
@@ -2955,9 +2957,18 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 	if (!master || !xfers)
 		return -EINVAL;
 
+	if (mode != I3C_SDR && !(master->this->info.hdr_cap & BIT(mode)))
+		return -EOPNOTSUPP;
+
+	if (master->ops->i3c_xfers)
+		return master->ops->i3c_xfers(dev, xfers, nxfers, mode);
+
 	if (!master->ops->priv_xfers)
 		return -EOPNOTSUPP;
 
+	if (mode != I3C_SDR)
+		return -EINVAL;
+
 	return master->ops->priv_xfers(dev, xfers, nxfers);
 }
 
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..563e63f6dd99a95d66bd80aff0b760c231b487a9 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -39,20 +39,25 @@ enum i3c_error_code {
 };
 
 /**
- * enum i3c_hdr_mode - HDR mode ids
+ * enum i3c_xfer_mode - I3C xfer mode ids
  * @I3C_HDR_DDR: DDR mode
  * @I3C_HDR_TSP: TSP mode
  * @I3C_HDR_TSL: TSL mode
+ * @I3C_SDR: SDR mode (NOT HDR mode)
  */
-enum i3c_hdr_mode {
+enum i3c_xfer_mode {
+	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
 	I3C_HDR_DDR,
 	I3C_HDR_TSP,
 	I3C_HDR_TSL,
+	/* Use for default SDR transfer mode */
+	I3C_SDR = 0x31,
 };
 
 /**
- * struct i3c_priv_xfer - I3C SDR private transfer
+ * struct i3c_xfer - I3C data transfer
  * @rnw: encodes the transfer direction. true for a read, false for a write
+ * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
  * @len: transfer length in bytes of the transfer
  * @actual_len: actual length in bytes are transferred by the controller
  * @data: input/output buffer
@@ -60,8 +65,11 @@ enum i3c_hdr_mode {
  * @data.out: output buffer. Must point to a DMA-able buffer
  * @err: I3C error code
  */
-struct i3c_priv_xfer {
-	u8 rnw;
+struct i3c_xfer {
+	union {
+		u8 rnw;
+		u8 cmd;
+	};
 	u16 len;
 	u16 actual_len;
 	union {
@@ -71,6 +79,9 @@ struct i3c_priv_xfer {
 	enum i3c_error_code err;
 };
 
+/* keep back compatible */
+#define i3c_priv_xfer i3c_xfer
+
 /**
  * enum i3c_dcr - I3C DCR values
  * @I3C_DCR_GENERIC_DEVICE: generic I3C device
@@ -297,9 +308,15 @@ static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 		      i3c_i2c_driver_unregister,	\
 		      __i2cdrv)
 
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers);
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
+			int nxfers, enum i3c_xfer_mode mode);
+
+static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
+					   struct i3c_priv_xfer *xfers,
+					   int nxfers)
+{
+	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);
+}
 
 int i3c_device_do_setdasa(struct i3c_device *dev);
 
@@ -341,5 +358,6 @@ int i3c_device_request_ibi(struct i3c_device *dev,
 void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev);
 
 #endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 043f5c7ff398ff631f1eea6acfc54a2e871016d8..ef1363122066215983d37c8e3ce062f3eefe48ae 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -474,9 +474,13 @@ struct i3c_master_controller_ops {
 				 const struct i3c_ccc_cmd *cmd);
 	int (*send_ccc_cmd)(struct i3c_master_controller *master,
 			    struct i3c_ccc_cmd *cmd);
+	/* Depreciated, please use i3c_xfers() */
 	int (*priv_xfers)(struct i3c_dev_desc *dev,
 			  struct i3c_priv_xfer *xfers,
 			  int nxfers);
+	int (*i3c_xfers)(struct i3c_dev_desc *dev,
+			 struct i3c_priv_xfer *xfers,
+			 int nxfers, enum i3c_xfer_mode mode);
 	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
 	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
 	int (*i2c_xfers)(struct i2c_dev_desc *dev,

-- 
2.34.1


