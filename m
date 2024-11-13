Return-Path: <linux-iio+bounces-12211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34C9C79DD
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6278AB43F21
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 16:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6560D1662E4;
	Wed, 13 Nov 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aKrHhScx"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3191632D0;
	Wed, 13 Nov 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513977; cv=fail; b=bN7Jpq4L4PTZGdmEvnphkLUvX8kRn8Zzu0gv6rrf7ajjS7dgYNRSPWd2FpRRcdD3wxDbIkpYnBJgFQR+mRPRNB5+8sqwpGPQay63f/XTl6DjgTof6ezGFNbllLfMgcYyZ/Jw5WYOIFcBcwMcwrs47BLXVmlrfaw8UGHL/465gBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513977; c=relaxed/simple;
	bh=xgMh5Ow4MAANt+x7pQjRGyvIfWQySqtH8BIylWkoCrU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lwQS++mkzzHbdKM/I+euif+XdDZytlwZaZvPkzv1I2w5g1Se0iYCPvCkjAq0ypc942yDgWI2KI7t5TCmES9t+5YRC8WlBKJskXZGbHGw4upvdjIZMJ0bKqrp1IIVM1G0h2FkgOzjAqVp/6ogdL6XKsmI0ImzuqdkICoQbAzJqTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aKrHhScx; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ/xYKH/PV3aA4yk3Qdz/LeLJNMP7a0iWjjeqGlG6G22tNB5V0/VIgd+gU5rbPZwKQReopUbDiqoSnq2gOXbbvrUmaH0y509tBVoz9oQcQP0QBSIrRH8dwU23EdCqF8Hx8TbxL0LeLNy7Q5Ao0V5pX0HgoMMWWyy0vmCVQTYzjlxL5ZhfSqd+fGjVqCbyoG0j6C1PH3m0nNoAR5et4Qy50SUgVpEAc8xN0Fvw1tHWj+H2EhXvRzzegEtgoLORsyTX1M7Lt2sty4TxsUSdeIOg5pBiVULrIvCJiTC3aFalgQ1bv5UcjG0hsyuDO0+QFwydMIyxCBh5Xv0kK7EH1Y6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L704wqlL4YmUm4LsqlOXOJFCTqezjrPsi4Gf73CJntY=;
 b=Ki7247rvjdy2tYC1kX7FIsqqEzD7chLr0uxRQzCU2AHL3m2AFbpT7QJLow/ex7eMMoXmvoGFFaXWmOSaDpYQQaaGVRAZ+8PSDnc/a0DbFEQ+yGWnnkOTQeNZsW+Esvw4Vgaezx7E4vdfJjyozCh5/JlIEa+hgjf/+oxyHnoY4fesMrKCLnIr15Nr6gjUjbkqYDsuAORZ+wYYxxhMcOK/16m6q8QLijF54EmF8/OhiENWshmy6oBttUTg+SPfUNzckTqmFXUnSs6AYpajyOpmH9ovDCFcPZNwEmM78t8HI8Zh6velnSR0f4/QaT/lb6PUO0p6uLJgqYvkGwSjtlcXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L704wqlL4YmUm4LsqlOXOJFCTqezjrPsi4Gf73CJntY=;
 b=aKrHhScxzAk84DYrDnyKip+357UjrvWEPoYvd6f4K6kktu/uq1lc54Xfr7WqLcZu9QbFHM3wNG6EXHGcnWiW+qaSdNRu0+e185HFmHf5MkMjLXmATUqP03Dl8FRgS1oU98wySIDP06RLuvq3kZo9UWyrYpkkhMhh+dNSsKKBX3iS6K8rKGM8jVs6O/L8B2s0wkgdI2XVWMaCJsa+jV0+Z4NuO6yWRb3xYJu2qL4wjuSB6rgYmw7l5wchlfSFC2Ce+DYAJ6cAiazZ5nTGBEJnkRyqW73AYN47cELw5oEWCDPIEsh2R6yVT1pShI3n6O2somllwj5VngPeBrbSqqd5Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBAPR04MB7400.eurprd04.prod.outlook.com (2603:10a6:10:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 16:06:13 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 16:06:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 13 Nov 2024 11:05:57 -0500
Subject: [PATCH 2/2] iio: gyro: Add support for iam20380 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-iam20380-v1-2-cae690c4674d@nxp.com>
References: <20241113-iam20380-v1-0-cae690c4674d@nxp.com>
In-Reply-To: <20241113-iam20380-v1-0-cae690c4674d@nxp.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731513964; l=3891;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wSn8B8m+6BGKzfDd5sU8egsmJ9Wbw+zQUectE0S8luc=;
 b=KbWctX6f4+Vrx6Sa2OZltKGt8WZITlPGTSXQAuCmJQCa1aSTYvS6C+D+fudrx9Z3neCt6inBK
 GjShCtc3seFCQsIhwsx76YaELHZ92eQhZjK3qFLPJlE/c+J8gPb/FXi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBAPR04MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e8f19a-2090-4736-3294-08dd03fd18f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzVNY3o4WWk2eGNtUzV3NzUwcG5RaER2WXpEbnJENEY3L1ozUTM1R3lRbGVt?=
 =?utf-8?B?UHJsaVNoZVZ1NVhwaXlzSFY0NHVua0VmTjg4UGVOYXlFTU53Yks2ZGh5Y1U2?=
 =?utf-8?B?K2F0S2xBZnVFbXpEbStGWnBFTjRXR2xZMFpFVlVBVzl2aWkwWS8rSmlCRDZ5?=
 =?utf-8?B?Rm4vZ0lwcjI4RXNpUk9teWw4cWFFMVJtNStYTjBTM25vU21lR2lscVpuK0xP?=
 =?utf-8?B?bGJ6dkt4MzZHT3Bhcy95VWppYmZNKzJPV2ptZGJxVEhqNDFabHBOVi9xVkUx?=
 =?utf-8?B?eEw2QWM2NEF6dHp0Z3BlSHh4QndCNTRTKzhsRnlJMGROSSs5cUVMNkt6Qlhj?=
 =?utf-8?B?NExGaGV4NkJ2cktwd2p5aWJpUGdPVkNrWnRBSGJ4eVBwaERBZzJMczdCOTdP?=
 =?utf-8?B?ZVVQcXRnZitwOUJzek0xeGN1SW1OcXBXOCtRMG55RjNmTzA4bUszRnNqNVZn?=
 =?utf-8?B?MUp1QnNZRU9teSs4MnY2MjJJbmF5L3VReUNkN2UzZG9tNkVPVWxubXNKRmQ4?=
 =?utf-8?B?a0c0T0JIL0JubzdPK3hTamlHaSs5ZUoreHcrMlM1OW1jUGlva2ZQNmFXVVAy?=
 =?utf-8?B?a2wwTVZqTWc1c0prZWRDSFdwR2JlOU9MeUNzSDhwdkZEcDNyeE9DeWduTDY2?=
 =?utf-8?B?MDRzSzlvVVM4bEpFWmJtOWVxVVFxaitRQ2xLK21teTM1ZEkycFNIZVk3Q1Zz?=
 =?utf-8?B?RlRBYkR0SU1PWUkzOHpBQmpSdVZlMlZ3N09IV1l6S3k2bDlsRzBNS3BQVVRw?=
 =?utf-8?B?b2ZqSEEwRGJqSWxpRFhiVWowQVlXL0xKWDBaeXhKSDJzRjdDcVU1QXdkMFYv?=
 =?utf-8?B?UHluN0huUUU0QUhoWit5eUNybDNJeTljMFY0Ukg2UmtDTUw5M1pTcS9sY3hU?=
 =?utf-8?B?YThWVWNRMWV6UWZiUyt2OVc4WFh1bEZFQkVwWk9UUndhOXE2S1VSZGsvYnJX?=
 =?utf-8?B?QVpIUzc2U2ZuZnB5ZXgrUWsrbHFYVncxZFJzSExySXdvRk0vdmhSbjVheDRT?=
 =?utf-8?B?cVc1MFR2MXdQZE83Vnpod0JHcHJXK0lhZFZlSG9YclVOWEY1S2txeWwxWXI1?=
 =?utf-8?B?WVpCclA0RVlucmloQjhlZ3ZRQ2Z5SFRnZzIxdzFOZWtWU2tzeXd4NFF2NUZS?=
 =?utf-8?B?ak0rTUxkOVZsdHR1TENObjBUMVRKSUZjaGpLSXdjalF0N1VVRFBwdGhxaGFy?=
 =?utf-8?B?bGdSYUk5OVg1Y3RBZ1kzeFdlQThFaGVhZWpYZExmY1lsc2E3KzIxUlk4UC9s?=
 =?utf-8?B?TkNnSzVYRVQyZUl2TWJvTFo2RjJ1T1FLUHRmMCtJbU9qeHA0dmVMS21FWFdS?=
 =?utf-8?B?dFpmRXNpTk9qcmtmK2lwYnRIK3ZNeXF3QmRBeFNaUWMwczdVaitsY1ZLV0sy?=
 =?utf-8?B?NmVSS1VTQURVQUtZYXhhbGxCcVc3Rnc3MEdjeE53cGtGZEhlQkRXQ1NaQXdt?=
 =?utf-8?B?RUVNNHVUNHZqWU1OWHhSZElrV3lZc3ArN3ZZbmd1MVgxVzRDZ2IyR3BMUDdz?=
 =?utf-8?B?NXNMMWJMZVJzTkJYSFMwaWdZbVVVRUdSYUpCczZpNHJVbUVmSWFpaURtcEVM?=
 =?utf-8?B?OFZ5YU5hT1dZclh0ZUFYYkt2ZFZQRElkS1l1LzQ0UldaYVdlTEFoK2oxUGlJ?=
 =?utf-8?B?NXhCQlluaDIwOXpTalh3R2NyUnA3WFRuUW5CMC9VWDU1OThwMXRkMkZWOUY1?=
 =?utf-8?B?Um53QWV3VHJ3QUJOSWtPa0JMbkd5N1JRdUcxazBtWTlSZ3N3VGw2MFdoZGRh?=
 =?utf-8?B?b1kwYk5zeklSbUZrZ1VxL3lpSDFZdExlMjl6UGtzanNKRlBjSHlSd28xUVds?=
 =?utf-8?Q?kLoznN28Zk88YIuafCceUkcGXpA3JFPh02lbY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3I3QW5rdnM2Y3dKRjc3SkhTZitYZzhUS0RPdU5QMkc2eUNXR1JkdVMvemoz?=
 =?utf-8?B?ZzViL0lBR2VCd2wzR0hMU2h2QWxXdlk3MGZYM0IyMUpyQk1WM1R3bUdjSG9R?=
 =?utf-8?B?d2pabzIwRFhUaWZBWlVndDl3bXh5TUVrZzB6QzNsbi9FenZpSmZOLzBLa0xS?=
 =?utf-8?B?UzljYUxMWFNCSnU0UE9pS1padW5SQTlYY2JuYUlmemVnQWdmMENnVlJ0Y2xt?=
 =?utf-8?B?OTJLRVBVSzVGN2NCVGpoWkN1MDNMWlFkdko1SDB1N2REZS8reXRiV3I5WTlu?=
 =?utf-8?B?Qk1vZHpLaFVxYTRWMkFDbHpkTkt3V3RZak54R0E3azBJZ1ZVdlVSZ3Fsb3pX?=
 =?utf-8?B?WUVXc29VeTVnQnJPT3V4MHQvUmE1dDFqNGRiNitobUt6d1FDSVVlZmNnMU42?=
 =?utf-8?B?eXBwSktXdTcxUlBWb2RxRXZ5WUdSVE4rZER0cndZa0NPTU9xTXVaNjlIUGpV?=
 =?utf-8?B?TXRFNWwvSTFJWGk2ekx0MXJKM3FzaFoxNFBxdlNUVXYxUEJLZTBPMWs5bUJY?=
 =?utf-8?B?RndWUURLK0hlc1hIOUFnY1g2M3EzNzNjM2JhaTcyNm84V0NZb28xTmQ3L2Fv?=
 =?utf-8?B?VTE5TTBzUHNxUzZkS2V5TCt4RHNwOXdsMEV3eG9qT1p0Yy9HbkcyQ2tuR3dt?=
 =?utf-8?B?a3pxM1Rqa1RuN2E2R1FkRU83aEZUdktTd2h5b2JMRndUdS9MQm5zRjFuQWlJ?=
 =?utf-8?B?RTRDVW5udmZER3JOeHg2VXltMzlFc1hveW9YYnZNaENWZXlpMXpqRnJYd09x?=
 =?utf-8?B?V1AzV1hISCtyaVF1OVl4UGpEOTBmSDIzYmEwY3hPN1RNcHFlSnNyS0hzSlVU?=
 =?utf-8?B?c2sxVTZ1VWlNQThFdzY3cE5EeEZHZHFrMjRVdlMvRklDamYzUk9oY1JWbWNZ?=
 =?utf-8?B?cUpFTHIyNnEraG81VXBnK3RQYkZqQ3RRZTBibUJQQWkxQ253dVVld0JwL2kx?=
 =?utf-8?B?cDdhV1MxSVp1NFBxSjVISEx5UzNSUzk0TEtPNnI3M0JhazduMWJsWUVkTFZm?=
 =?utf-8?B?UmNQWlZERFh3S2tHZzcveU45Y21LQ0ZpaGZVM255QzIxZ0hXNU5KOTdUZ2t4?=
 =?utf-8?B?c0owK2FGZitERXVOd015aHJwWUx1SUlzNVFNRC94T0ZSeGRCNFlWKzhuSXpY?=
 =?utf-8?B?ZTNFRVVEaXVwdmlCajg2UW5PVDhSVmx4Rk9NVXhrdlNXV2hTU1UxcUFsN3J5?=
 =?utf-8?B?bERkL0RsclJDQVFyeE9pMTMyQklQbFFOUSszSXlhOWZXYjg4RUdSMDZKVC9n?=
 =?utf-8?B?UTVKaWsvVlZJNzZhVDVFUmFBMkpXcHVJVGgzR0xWRjdZSmlkT0txTWV5WjNp?=
 =?utf-8?B?ZUx3MEtST1hTSUpUbkRTTXUxWnMzQUU2Zks0L1hBak5vOTErbFJyeTI3cTF2?=
 =?utf-8?B?VzR6Um9GZWQ3NUt2OE1JS3JPbG5WbHMxZGtwU0k5Y3JTejZIeVJNQ3QwUmUz?=
 =?utf-8?B?a2pPTkdVNEFUckE0dzg3YTJLSUEwZEgzQnhrWEM0aEJFNkM2VlZQeGxQSXZ4?=
 =?utf-8?B?bjlXOW5sUW5PSjVPRmk5SDFmN3R3UnNKM0VCVG5QQ1ZsaXBDNXZPUlVuT1ox?=
 =?utf-8?B?NXM3Q1dTK1FHVmcrWnF0VUViUWlhaFlGUGhyT0pSamxKb1ZoTTNhalFRTXZy?=
 =?utf-8?B?UTBwK296cXB6VE1heFgyT3NJWUZkSS96SkhtRnJnMUMzc3BQM1dwYWJEeWZ0?=
 =?utf-8?B?T1pUSk9UMmFSVlRJSnUwK3F0TkNxSXhsR1FFeHdwMkRhWFRYcEl4OU5MUGRX?=
 =?utf-8?B?YnNtejl4WXUyVGJjSmNnZU92OCszMVdDWFBBWWtoS0J5MTVxbkk4Z3ZBVlR4?=
 =?utf-8?B?d3VoeEp1Nm1nUythTEhsQ1UvUTZnWVY1eHM2bWh6elEzKzRYNVQrblZqeUlr?=
 =?utf-8?B?SVUxZFdEbnRIYVpHMWdlaU5DTkdKN3Z6eUk4L1RFOE8yU1JHUlJQMHUzc0RH?=
 =?utf-8?B?TkgwS3VlSmZ0eTgxSGhIZ0Zrd2tiYUV4Nm5MaXpibFM5RkYwcU5ZTHhhNFRC?=
 =?utf-8?B?WHgwTGZ1RUZiZk45ZVNGbXBKV25SMzYxdWZ0KzBmS0Y2L1JBM3diKzRSN1hL?=
 =?utf-8?B?M1FoNHVLNFRQWkNVa0haUkY0eitCbXZEODE4ZlFaSFhJZXc0b01rbkgxdlpD?=
 =?utf-8?Q?AvnoUah4UvjnDnfssunUqF47E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e8f19a-2090-4736-3294-08dd03fd18f3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 16:06:13.8073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNiJHtVIRvR3P0tdNOxi+opq5EQkVdaHFLI/61e0Oj/oP1j7aop5yq8/gWT504cjtVySSpSdum9+KVg/zMcfQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7400

From: Han Xu <han.xu@nxp.com>

Add support for the Invensense IAM20380 sensor to the MPU6050 driver. It is
similar to the IAM20680. But IAM20380 only supports gyro and WHOAMI
register data is difference.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 25 +++++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 40271352b02cf..f6e41ee14298a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -140,6 +140,23 @@ static const struct inv_mpu6050_chip_config chip_config_6500 = {
 	.user_ctrl = 0,
 };
 
+static const struct inv_mpu6050_chip_config chip_config_6500_gyro = {
+	.clk = INV_CLK_PLL,
+	.fsr = INV_MPU6050_FSR_2000DPS,
+	.lpf = INV_MPU6050_FILTER_20HZ,
+	.divider = INV_MPU6050_FIFO_RATE_TO_DIVIDER(50),
+	.gyro_en = true,
+	.accl_en = false,
+	.temp_en = false,
+	.magn_en = false,
+	.gyro_fifo_enable = false,
+	.accl_fifo_enable = false,
+	.temp_fifo_enable = false,
+	.magn_fifo_enable = false,
+	.accl_fs = INV_MPU6050_FS_02G,
+	.user_ctrl = 0,
+};
+
 /* Indexed by enum inv_devices */
 static const struct inv_mpu6050_hw hw_info[] = {
 	{
@@ -277,6 +294,14 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 		.startup_time = {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_STARTUP_TIME},
 	},
+	{	.whoami = INV_IAM20380_WHOAMI_VALUE,
+		.name = "IAM20380",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6500_gyro,
+		.fifo_size = 512,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+	},
 	{
 		.whoami = INV_IAM20680_WHOAMI_VALUE,
 		.name = "IAM20680",
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 7a5926ba6b97d..62f7d16c2ddcb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -34,6 +34,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
 	case INV_ICM20689:
 	case INV_ICM20600:
 	case INV_ICM20602:
+	case INV_IAM20380:
 	case INV_IAM20680:
 		/* no i2c auxiliary bus on the chip */
 		return false;
@@ -187,6 +188,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"icm20600", INV_ICM20600},
 	{"icm20602", INV_ICM20602},
 	{"icm20690", INV_ICM20690},
+	{"iam20380", INV_IAM20380},
 	{"iam20680", INV_IAM20680},
 	{"iam20680hp", INV_IAM20680HP},
 	{"iam20680ht", INV_IAM20680HT},
@@ -252,6 +254,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20690",
 		.data = (void *)INV_ICM20690
 	},
+	{
+		.compatible = "invensense,iam20380",
+		.data = (void *)INV_IAM20380
+	},
 	{
 		.compatible = "invensense,iam20680",
 		.data = (void *)INV_IAM20680
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index a6862cf426396..211901f8b8eb6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -84,6 +84,7 @@ enum inv_devices {
 	INV_ICM20600,
 	INV_ICM20602,
 	INV_ICM20690,
+	INV_IAM20380,
 	INV_IAM20680,
 	INV_IAM20680HP,
 	INV_IAM20680HT,
@@ -425,6 +426,7 @@ struct inv_mpu6050_state {
 #define INV_ICM20600_WHOAMI_VALUE		0x11
 #define INV_ICM20602_WHOAMI_VALUE		0x12
 #define INV_ICM20690_WHOAMI_VALUE		0x20
+#define INV_IAM20380_WHOAMI_VALUE		0xB5
 #define INV_IAM20680_WHOAMI_VALUE		0xA9
 #define INV_IAM20680HP_WHOAMI_VALUE		0xF8
 #define INV_IAM20680HT_WHOAMI_VALUE		0xFA

-- 
2.34.1


