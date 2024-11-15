Return-Path: <linux-iio+bounces-12333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B29CF627
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 21:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2B8B382E0
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019D1F585C;
	Fri, 15 Nov 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b7m2oISB"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699018BBB4;
	Fri, 15 Nov 2024 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702270; cv=fail; b=pgkZGf29YypLSSABmHlLtmR6x/IBns0W5ZzFqe11VHttnOF+/Nn1dFROAqedFxz2SgwgURlLnoUoswLs7ZrJ98MGpgTk3LbBrO+NpHK5j5jm51SN2+Qs3Y+SGWODuZktD8Dd0x5KryqqEe3aAoOFBD6aBupK93c5yyOAQUofQyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702270; c=relaxed/simple;
	bh=84MTZfWTMic2XVsdnlPrZ05JkbZyiSvFDqgoi2DhG1k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V5puFJzuCAJQVCIXAnMkKFoE62/Et8qA56lxJfpwKPT7qW/vRQPHmwOH5Xc8XShaV5+7eIcHOR78JaKRor4KrMxQpW5xXMDsERX+yHYskH8LyBHK3uyeA0cziJiUD9Qh5fc4b7/e+BKVdYvFhFXgVDWiEBgdcNi/Ot7t85SW0yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b7m2oISB; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFBKX8IB0ILNHswbwHLZYDnxXKFw3IbP/OH5Ldo8EIKMAfS+VAs8FS/f3YeKGhw+eFixETTIK5NoO8EWkpe23XfxnIfoOSxmauico6GPJtXCuVp01tNT/zsxl6NgUdSWT/MmsXc07I+SjMvdjuzmjOycjo0HazyQhn187gipF4jpWQjGTc1iPpfjsPAEln1bzY1SaHMc8TOqQpPEv93vOHQhuODyeXd1Ap47agQ50198IQMf9GadsUok6pSvSQMRs2feVyGsymK5J5kjeZjKTLF4jJsqE8ezoR25oSyIJqMnXHSCXr+Tr5RXZqRsvdDfUDMFf6/Pdh/YbEAjsl5IzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwtZw6HmnwhigUkuCooLfaqkLXVWtIQD82ziIoqUq3k=;
 b=nlN5xS1W/vAqmN4EJJnrJQc44Ba7+obyN6HBtY9K1nRr0AJMK4v8lUx258dvl4+6unIO7OEfisCIydyD+HMdGgCY2P6RZYzd5asNBCNuqexmciQHRtMX9fFysmK7YTwbkA4o9gxEnSRdFPKC9ftMkfNgnd2vl5Sy16oMi+1CsHjvxcYCsyKC+ug/OSAWIYaW0hyPTDolp1EArX4h5dVkMBJVOFE5IuoQCFB/WDq3WuU+9xVHwOSyJLlce7kp04vP4rNnLUzFt47+nnkLfXzC9MOeQPky0PvDSif91gz0vSyAMdtuEtpCskDo+JTGsb6Spjr2w+daO7fMy4QhjWO2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwtZw6HmnwhigUkuCooLfaqkLXVWtIQD82ziIoqUq3k=;
 b=b7m2oISBu6ae2BHncHrl989kv17lYjXVf/OtEvzfeYiPGT/f6g/mJgEdHBAtQEFOqRQyI2t+oh8Aqg/4KJLljsSeP5B/Q3P5Q3q8fjDsxo3EpKck1qBu22xBqGEB/N6ZhYnh9Z7jBpitKGFR7GnM2LugylFLs9gT9z+ujtNJr8YolMGGxV6kdLiqjo89F1wopoyLefsrII+qXDFT/z9SFhN5VrpIsUO4M0m7cS3WfIiiwlujI5OsAheEl6WdgzNe5013Skh2yNiPHWa3SqRMrM2O4g5C/2udKup9SdVYsPPDD9ShFrFeiKCYtSve2vqPRW6MJFVT2LQQIo7Syj/kKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8231.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 20:24:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 20:24:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 15 Nov 2024 15:23:59 -0500
Subject: [PATCH v2 3/4] iio: accel: fxls8962af: add fxls8974cf support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-fxls-v2-3-95f3df9228ed@nxp.com>
References: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
In-Reply-To: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731702250; l=2203;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9ByT1xnywtbuXkHRk/zAK6676kDTZKvd9DfDVoZTI98=;
 b=oimrAguPjDiczhkN0dxcJ9lWePJrGjRSMdrylJrPTWjh9c7GrjFn6Q+/rHCoXh00LQ8veGVIC
 un2MKpFrziFBzzF2noqXhQRUDQZHxmblFBhiFRHCGyNwLkBV1cVkynD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2bb63a-f222-4195-c0bb-08dd05b37e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzNGUVJOYU9yb3ZOOTVORVJUM09YQ3pOaXN5Vnhjc0x6OUlkNkJvalB6Y0RQ?=
 =?utf-8?B?eFdoSmsvSXdHem9sckJBbkpFMTRiYUlqZVNpTXp4VEY2S1JDV2xIVnp6UWtP?=
 =?utf-8?B?b2NQUzlGRDV5cGdiTnhTcDhrbE9QWjU3eGRNemtkR2d2WGJ6em5ZMFZqODRY?=
 =?utf-8?B?OExhbWlVWkVRcjdtZUR2dHBNd3IzOGQ5U3A3aWlUMTg3dXQ1bnBtMHJjOHpQ?=
 =?utf-8?B?VmRwUW9WOUhvUjdLUkxXdy9zWVdxMFRseFZnSyt6Qlp1SlNuNzh4NVlBTVdk?=
 =?utf-8?B?S2gzMTFJNksxcGMwUmFtUm9aZ2NHdUxWcHVzR3kwUmQwM1BBRVRZU3IzOGow?=
 =?utf-8?B?MlFwMEF2QmM3Uy9QbU1mc3dUa2FEVFJWYnlaSTJzWEoybjE0c081L3BaVGNW?=
 =?utf-8?B?Y2lUSkxvWG16cHpHM3dxOE9PWTNYNWdhMUdIUWduN01YN0ZCQ0svS3BZdlY2?=
 =?utf-8?B?d2Y1ZjVRb3hUNGU4RnpQdFo2MVBrOWJjYzRFOEtDRXVPeE5GOG9KNThDODdO?=
 =?utf-8?B?dVlueXZSQ0FoeTh6ZkdGR0pTQzNlYURCRkV3aE1KWm95djFFcUhuTDV6M29h?=
 =?utf-8?B?VVlmUHNRQ0p6TjZFNUl0TGNzSzJnd2FtcU5lVlJ3Ny82NUJFSCtpaW9ZMmVh?=
 =?utf-8?B?d1cwWnlhbXVrRVFzeFd0VWxSZHlQZG9uU1VZeDRVWDE1V1dNdlFzZFVuRHhD?=
 =?utf-8?B?Z0RqV3pzTDRqbW91VC9hUWZEeGZ0bFEyUUxMSGhCbXdEOG01ckdWU1ZVYmlk?=
 =?utf-8?B?alFRRzJDNGtMUktMR3ZJWXhZZmlWNjJmTU1neVc0QkU5L0ZScEZQRzJEc1FF?=
 =?utf-8?B?VHFUZGE2Y0s0N2YxcjJxMFBpaDdHSUJUaEhrVmlDNHhUcXBZMHBHTHlwVW5y?=
 =?utf-8?B?ekpLVFdZL0FUbytKZHRXMjMveDI0SDNjMktORHQ5WHBmMUhFNmRTRXBnQlg0?=
 =?utf-8?B?cWJNSExzcDI4cVdkcWFlN2dSSVJJek5VUWxvTURmYzUwWWZQZHNtYTd2aW5a?=
 =?utf-8?B?YnZPYXZpYVhISkwyYWM0VDZLK2ZlSXdWZlBIWkJZR2xibnlDS092cVo0UHhZ?=
 =?utf-8?B?akRCdUJtbWJGRVJpTm8zUGJQQS92TTU0dkZUSXJtYmsvcE5OcDRHYVBNZ0JG?=
 =?utf-8?B?bkdHeVlzSFNoUll5NXpaYUdyL3h0TnQ0NWZNQzBMMTMvRk1oWlRtMjF3VnpL?=
 =?utf-8?B?emh5cEVUVnA5cE5KT0U5MWpLdzZqYS9OakFycmgrK1VwRkJRRnlDdDJJQ2ZP?=
 =?utf-8?B?Q2thMm15ZzVwd2ZkWlRRaFduUHRBRnVCVi9CeFYvbk9YTG4xWjh6ZFRKYkpu?=
 =?utf-8?B?a3dleUVtVDdxUUYvWU1uQTI3MkxXUmQ2aTh4M01GaWh3eng2MlZVYkNtdHVr?=
 =?utf-8?B?a0ExZGNVSW1QcWdaZmhma2V4RHNNNmF6QW5QRk1yM1pkSExGRGdRK3diQ2w4?=
 =?utf-8?B?RUZXeTg4N2lTQWc5REVudTRpeXZ3eklmaWx0OG4wZmtxc282NTVzemdBOFd2?=
 =?utf-8?B?RFFqS3Z3VFAyS3VkR3ZaelBZOUhxMkpGbHdjbDd0T29vU1E1RkExZ1VDaDRn?=
 =?utf-8?B?RzVCcklDSlF3RDBWZ3RncTVpOWRzRVI1ODh2QThJZENBMzE2QlE1RG1NT1Y0?=
 =?utf-8?B?TzBVM2o4L2xMSndjZHBpd2VqQ0duaDlSbXJVSGlTK09PakhFUEZmdGRpZU9S?=
 =?utf-8?B?VFU0STVxSVdYS1YwVmt0VGRoS3M4MTd5QTYyWFVlRUUyZjNBVFlBeXpubkZn?=
 =?utf-8?B?OXp5TklOemQyUGFVejR2eS9OUjdhMVJqbzZnaDRDbElsWFlPS0hEemNxZXRD?=
 =?utf-8?Q?iNG0P465Puw/nHhmsbl3DyK7tqeeSMd6IOj/M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHNFdTQ3SjA3V3ZLb0V2bG5INWFRZ05aa3BWcDNhVXV6a0NwNEo2OHdkZEhH?=
 =?utf-8?B?c29pd2NkUWd0L2I5VjBPamo3QnJLM2xBd1ZaVDdRZ1NtSXkyNkdTaC9aYmFa?=
 =?utf-8?B?anZFcVZkbjdUMDJzTVV0c095MlE2V3BvbjJEdG4xSlpJLy9xbmpGbUEzV2JS?=
 =?utf-8?B?SThuZEdtaDgxK3B1ejVTZitFczJmODZaM05TUk9tTWpaZjRya1l5eUJidzdQ?=
 =?utf-8?B?Vkg5ZnNWY0dlZmZlR1ZkaFdQWkgwVTVKYkZncWd0RHhrclBZSUs4QWFwQVFD?=
 =?utf-8?B?eFVOUm9UMEQ0Vm1qY0thRHpXRFFsL1JFVjdaLzNualYvZHE0eFA2bWsyM2dL?=
 =?utf-8?B?NVpTWk44SitJVzBGZThqNC90Y2xIQWxzMFlzU0F4OXZFQWRSeWd3MWhiU1RP?=
 =?utf-8?B?c3E2MjRSU1lySVIzVWsvVnVEWWMwR2FnbHF2ZnRvYTY5T1hjV2tFVmo1NHRi?=
 =?utf-8?B?K3g0WGxUa0licnRBVVBxMnNqMWF0RXJjbjlMbS9waWtaK2JvejQvbTNJeUpp?=
 =?utf-8?B?WkdiOUJnb05YSmVXakNOMDZLNFBheXdjeUc0TGIvaWtmU1ZPUlNTL0ZHQTZL?=
 =?utf-8?B?VnpudlF5clRBS0wxblo5QjdXb3RadzNjOEhSeVQ2WnF0bEV1aEpkVXFRdVhZ?=
 =?utf-8?B?Q2ZYMkJRSlBuanBJU3Vrd0duTm5tV1NZcmdyV3VzaUxIazdoMG5BVUlxM1Vr?=
 =?utf-8?B?L1pmSzJUVjRZcjV4N0NHSkRYaU1IVER0ZDRzM3BOdDlxZ05oQWZlVlFQbjcr?=
 =?utf-8?B?Z0xGR1V4U1Z5VmM4dVpmQkNrWmhMV0hjNlMyRitLTHZvNDZTeEg2V3hXTkhs?=
 =?utf-8?B?WW1nWEtEd2FrNkhXSFBlcTNmQkNwQkoxdm9mWTBjSlhNVTE4bVhtLzVOQXVJ?=
 =?utf-8?B?UW9nak1TdmlnMGMwN2RYbVZYNXoxcVdXQk0wVkI2V21kSWtEeXVIek1jMzBD?=
 =?utf-8?B?Z1htaDVWUnV3eFNwa1M3cFJKNXRUb1FReFNjbHd6QjhXeEpnckVGdFIzbHQ3?=
 =?utf-8?B?NHRFQ0EyVVJTUFlBZU1nak1MeVdOU2RReUlJMnRpR2FtcmhDOTlPZk1IcEoz?=
 =?utf-8?B?YUFKanQvdGN5OXFLVDBONGN5dm5nYkpjVUpYbitnZWlLWFh2dkR1anpJNE1a?=
 =?utf-8?B?NERRUmdMekxQMmVKOGY3YmFXTWpwY1ZidjFWb0dOUkdCakcrZ3Y5V2tEWE16?=
 =?utf-8?B?N01ObHl4Zzc3T0YxeTZreWJObTZUWUdxamh3ejRhVHhSb2JTalArUldFeGJU?=
 =?utf-8?B?ZTFJTVRiV2xOVVp5OEdYL3F1bUZLSmRKZ3hvWkFLbjNrTFNpQ3k0UkpPSGZC?=
 =?utf-8?B?cXo5UExwSFJkQ1dmT0pkWmUwYXZNcEIvcFM2YWE3TTBvQjVRZ1pxSjBQZFli?=
 =?utf-8?B?cDRwY1JzSkxaVFV6clJhRkI5K3NJanBRS1RsOE1DemxEZWlHd29scVptOVo3?=
 =?utf-8?B?V2JMWE9CUk43ZXlOeDNUWEJRKzQvZisvbW1BUGh2RnUraGJwaS9oVlNrZThU?=
 =?utf-8?B?L2FleGc2TGJ1ZmdvNjNoZUlVMkZnQnNaeGZDYWlyWEJHM2V5V1ErZkVlNHBo?=
 =?utf-8?B?Qjk0a2oycDdCZmhJTG9SeW4vZjdEejBkbUFjUlZmYnJZckRoUk5UUVRERVZ4?=
 =?utf-8?B?b0ZGV0NZcnZ6N1RCb2tVeEFzK2V6KzlyZEc0ZkVRV0E2SWYwZlYxMG5XNVBu?=
 =?utf-8?B?cjJwYmdhZm1iQ1ZNekd1VnVadUNmTmxQYzFYT0RwVlZxMU1GSXg0Wk9obHlE?=
 =?utf-8?B?bXFWczB6Qklhd0xZZTZhcEVNcnU1c3Y0emhKNWwwbWFieC9mbUFDVktBYjNZ?=
 =?utf-8?B?cHViYWwyNG90ajNkdDFUMEdYL3BvNFJaR09CWXg5WTUzY3E4OU1LTEdQOGpD?=
 =?utf-8?B?UHFaQkJjZzMxcHdGVmdyTFB4Rmptb1ZnSWcrdXZ1Q1BYMEtra3RkSnRxOUFl?=
 =?utf-8?B?dGRSMDVXZjVwWWs5RGlmUDdGWFZIeFIxUm9pQzNnbWVHRTZFS3RvUHh1TFJR?=
 =?utf-8?B?VVhpWStSbTY3b240N3p5WGF6Znc3TDFPTlNyTjdpU1dSQ0dZN0pNYkJpemp5?=
 =?utf-8?B?T05yMzd3YTZGdzA5NkpNdStDblUrYm9BSndpQ3lBUVlDSGNYTEw0YkpFeDBS?=
 =?utf-8?Q?rm2JvPBAjRqUFrjWHP9a5/2HN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2bb63a-f222-4195-c0bb-08dd05b37e8a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:24:23.8091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgBjbSw5gur2R+sK+5FlHuRxShWXHaM54xbJdP1rroXKor32DJ0z3k9BS1P3caJTGcAQhacwqqsg7aUgoEussw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8231

From: Haibo Chen <haibo.chen@nxp.com>

fxls8974cf is similar with fxls8962af, the only difference is the device id
change to 0x86.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++++
 drivers/iio/accel/fxls8962af-i2c.c  | 1 +
 drivers/iio/accel/fxls8962af.h      | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index f07fba17048e7..b5607e753a7db 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -129,6 +129,7 @@
 
 #define FXLS8962AF_DEVICE_ID			0x62
 #define FXLS8964AF_DEVICE_ID			0x84
+#define FXLS8974CF_DEVICE_ID			0x86
 
 /* Raw temp channel offset */
 #define FXLS8962AF_TEMP_CENTER_VAL		25
@@ -766,6 +767,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
 		.channels = fxls8962af_channels,
 		.num_channels = ARRAY_SIZE(fxls8962af_channels),
 	},
+	[fxls8974cf] = {
+		.chip_id = FXLS8974CF_DEVICE_ID,
+		.name = "fxls8974cf",
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+	},
 };
 
 static const struct iio_info fxls8962af_info = {
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index 1601246733083..687eb49035111 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
 static const struct i2c_device_id fxls8962af_id[] = {
 	{ "fxls8962af", fxls8962af },
 	{ "fxls8964af", fxls8964af },
+	{ "fxls8974cf", fxls8974cf },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
index 6eaa2803b26f0..733b69e01e1cc 100644
--- a/drivers/iio/accel/fxls8962af.h
+++ b/drivers/iio/accel/fxls8962af.h
@@ -11,6 +11,7 @@ struct device;
 enum {
 	fxls8962af,
 	fxls8964af,
+	fxls8974cf,
 };
 
 int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);

-- 
2.34.1


