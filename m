Return-Path: <linux-iio+bounces-12014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE2F9C123A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 00:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DA6285101
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 23:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F92621A4CB;
	Thu,  7 Nov 2024 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TjEZaFC/"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EB21A4B7;
	Thu,  7 Nov 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020609; cv=fail; b=GnxMjarAB0C8Yypi7EA9S8xZdUPhgtXffgokAixidRfVbRGsNauK5wQYHFi+apgY5K5l/+Da+UVxuaWBGyGJBieypCqbNhpfgOSNKapEAIWo36p+mh67V8X97U7qZBUvHEyJkLUvquUkDoMc2z3WP3wK0iyLDSgP38thpyqK9UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020609; c=relaxed/simple;
	bh=674fGre16wsgmxYfHmqsN6VLMJ4S2VE2ToXL1V2Wrqc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=q5nojzzvZUQsXlzP9yfGMkn4sM+fm9DRMeHJ9qWOPKMuwuOW8iFITl3PHYzJORRHtgk+phc3GPqirCp6hvic35njV6PGkRpbyTh1aFGdsZwJ1VqB75NPjNP+4tO6H+dReqaJtSk5v0CaMiutfKf3WFzFJa4S8pD3dhdcuDi99HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TjEZaFC/; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5OGkipijqm7W1UY1p5rSBdLqP7bwcOmzUftK72rGFNvBE6nq4G9HlYIYcNwSBClqO+t8VvJR0XJ+RbZFdBdf1imZnLkg9kyTbzJokVWh2fgwXcveYOVUx40SnwYZXln1JHPgniFMKXpQW5B73CTi9wb4Wxa+cBY+oPuOY4sbKDJHvGtDICoNDblPJkG96VGZAk+5tPCQXK5vDCcvc5Q1QE8OqUszu/3OLq+K2nBoVniimMtvoJbpa1P7TBGAskVvSreHyku5lkp8SBPoOn2CD6CuAjoR8gW9EJre56i2c4DyoHVrMRjUi+2lu1eEY4FISWjIfm8yFUOUOwLxLbDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6awtrZQU6LkJHPear9BLzG6arSog9kzzlZX/iwhrU9E=;
 b=hTUq7XjvIXxiJKwO6IFHegEHFrB+uWBvzpdkT2Z2xVPzo0gcl4gkxbx2nnGE9oSpWxFt3wUnqlDSh6d9v6NlMl5guoCMb8+iRped/8E2S7FyAp6Ct1JkPFYAXIBSPWXBmGtJh+hl0aQLFAQCipzOLYwBClBNu3ARcGiiLvOJKNo8BHI6NPh1Xu2ZtMZmXy0uSDp+bCVZYlPiEYEw5BWb0DtuI26bzjqghxsLIYw+gd8SoKsDryECxwMyDGLErvbyk4fge5oe4ueYJzY/rlOmBFiEfndZWZ7LgVL5WS89TWrz7LNxf+HjtWPNLQoVDn+y9oc5T2r20JbfaCVuZEJ/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6awtrZQU6LkJHPear9BLzG6arSog9kzzlZX/iwhrU9E=;
 b=TjEZaFC/V2t1hNtuYURL0qji8obqaLDnsanKgSUfvPgNZU2vEho3Ld2GjbsxjN1c21+xGvFHUeCUpZQalbzKLsAXD1vrblbn8qmmKk99TjMXN/ZFuZwcFq+PeWhmg9qaoiXU2U5xvS7MI6qx8rEzZJwYBh8LiiXgs4OIzGFVBStQb+ZP5cep5dkn6JGgpmN3Ou/SntqKzjTy0XdDGRY/ayeQZz5w0mAYg+ksyVs7x2drqkBCBs40qXgOuWjqdxYyT891g//BpZV/0vsqViao44M7WoJx6vh5yTUR1boXEsESL4eEqUYH51RSOmSr19tQnh6veZboqOl2wjXZSlv53w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 23:03:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 23:03:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Nov 2024 18:02:29 -0500
Subject: [PATCH 3/3] arm64: dts: imx93-9x9-qsb: add temp-sensor nxp,p3t1085
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-p3t1085-v1-3-9a76cb85673f@nxp.com>
References: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
In-Reply-To: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731020590; l=721;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=674fGre16wsgmxYfHmqsN6VLMJ4S2VE2ToXL1V2Wrqc=;
 b=F6UCABJm42SDK0mHrxxijQdpJmGfVWQT7mmiogWp9Wcpp5wIYWvE6Q4BYy3Ddm40xoaYEx4bX
 lXPo+0QpuHlARl/2wkJALuGxUF7/KgNQlIOPHc44xYBn4FtlG9W+u3i
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0c9ced-5be3-4ef7-0c1a-08dcff8062c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cThnWnVLSmF5TmpraWRIZ3RlaCtDcWw0d2RlQWF1VkJHWEl2T3VhU2lEeW0w?=
 =?utf-8?B?bk1QM05ZSzVBZnIraGxETHp4Mk1QOGNEZktQSFFNOGFFV2FkTitPTkxaRXVl?=
 =?utf-8?B?K21JbWNvK3hYL1ZheFFURUVlYlQzTmtzOTkxWHlJa3RRM0w3Y01uSCtjUmZS?=
 =?utf-8?B?RkRYTlRqVjNKRU5WZ2FNc2RQYnNwSW9vVGVlZlpldnVla2FzaFR5UERjWkF5?=
 =?utf-8?B?ZTRYclhkZ25UeGJCY3Z5TGFnSWFGcklRbDJZWWR0QmtvNXBsVXdkQ1NyRFJ1?=
 =?utf-8?B?MGk5cHZTRXh5TDR1WUR3Y1U2dGhwN3U2cEwwU2p6ZUNaRXNqemZ2eXBVMCtx?=
 =?utf-8?B?N1N5QWE2aFM5THFEUUtVbjlzeklBVHVCSnozVWl4WnZBbG85cC8zQThEZVg1?=
 =?utf-8?B?SGVXUmpzSHRKWithY3hRUTdhUlhPZFdxais2MlRUZzlDcDZCeWU3bDY1aEp1?=
 =?utf-8?B?YmV1UkxReUJBREZ0TGxzWHJUa3VCVjg4RDZtL05JV1VRS0taZVNjWEkxNWxK?=
 =?utf-8?B?QWFrTDBubTFFazNWL0tLVEozaEN0T3RuVk04SXdjL2ZBcmg5M0ptZTgrZGFx?=
 =?utf-8?B?NkJaeW1tVnBBd1RMYzQ4ais5eXlFMi9VVFlyNU0vQTc3dzJSeGdYdEpGN0Zk?=
 =?utf-8?B?VFVHZC83UFJOR04wejFsK3V6dm1VTVQyb0dYNFM4ek1ZMXhjNnBvMnJJWlVS?=
 =?utf-8?B?RHhDdVd4Uk9nT2NMaTBpbG1ES1BLNjlwamxLRElORHRDV3dEYVEzMjFaRXRl?=
 =?utf-8?B?em83aG5uTjBCK2FHKzQ5cmtUUmhPMDd1NDgrdmhmK29UQjdmZWFoYm9QWUNU?=
 =?utf-8?B?TGV6YzdENlBkbDJjcmtJbHEweG5PSmZ4MnJEQUlMVWhOeGNPSVl0bTJhRHlV?=
 =?utf-8?B?TUhvOW4xdXRwWXg2djY3UkJrUjN2aEtqaU5vZEV1aytTYU1zVkY1UnNCdkpQ?=
 =?utf-8?B?SDh2RndyUXB2NFVEaFozdFF4M2twSlU1UDB5b0dUYVEyL09vZjM1aS8rTWVr?=
 =?utf-8?B?QzA4RjByd1FqRmlyU1JVSGtMbFhwYVJNNkZvM3hFZWVoUngrbmNSV214NDNR?=
 =?utf-8?B?L0NmNUM5WHk5WVFEWTUvdXNYVGNPcmhPWno4cDY2SUJHOWluWGZnZ25MQk93?=
 =?utf-8?B?a05pQUVQVEhway9ZMlQ4QjR5bjl3UTlXaVBwRGEzVHk1c3hMRGJlZ0lBZm1i?=
 =?utf-8?B?Sm1Ebms3bnhjSmZPT3dDelY5dDBiSjZVRm5hNEZsTDNyT3RHNHpvV2FLYnJV?=
 =?utf-8?B?RTNoN0w2RXloOGh0YVZoOUhpcXIycnFWYWhXMlRwazhSTTZBYzgzTEZORnFJ?=
 =?utf-8?B?R0pyWDFrOUkxUUVSQ2t0czdYd1NRMjd2UEpQaDJtcFVMcnZXVzlyV24wQnAv?=
 =?utf-8?B?bEo3VE03NURic3BMbUIvME5kcmpQUE9tbndwRmdtN0JET1lEbStqcmN5ckp5?=
 =?utf-8?B?ZFdlNDdlSTRoYVZhc1RhaDVNbXRYazVVM3FDeDFoWWg2TWRVOS93TWUySTkr?=
 =?utf-8?B?cm4wallnMXIzejZubGRaOWZaSyt5bE1wd3ZGRlY3RG9DWE5UZEJnZW13UDY4?=
 =?utf-8?B?QmVsUk9CMjNiM29YUTBpNUVXNG5hTEg0T2hxSDBqdmJjWG1NUSs2anhZZlYw?=
 =?utf-8?B?TDVIL215RkJZeFFoNWtMZ2pVWnFqMGdzK3NmSlFGVjNjWis5VUZqUmhXSFZK?=
 =?utf-8?B?QlhxTlF4eVBwRHN1T2wyOFZOeW1MQWdsL3FNOFdybjZ4Tm1EWnhleFUyTyty?=
 =?utf-8?B?enBnek40M1JEQjM1Rk1sSFBQMGpjSWVlVDB5QmxxRXZPOFdjVjh5Sk03dnZi?=
 =?utf-8?Q?LVy8+5UWn5DF70+052q881gJ9sxgiSvicrg4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFJzVVVaWW50UVhWb1RacjJ6aG9NVEZPQTFSbkxSdW1kL3lvTFR5VjErSlNt?=
 =?utf-8?B?NVNnS0FuSGttT1Y1LzdGT28vbmYxRDZYRzdHdm90T2ZabnpHUk1oOWtSa1JP?=
 =?utf-8?B?TTQydlJLKzVaS1pJdmpCM3JlSjBrcHRXNTdPNWV2SGt4emZYYk5OWFQ2MGFD?=
 =?utf-8?B?ODdrY3VHZVJqLzZER0xZMnNnTTVxcHgyRVF2UDlmTjlIV2lBOGQzeDJTY0lm?=
 =?utf-8?B?KzMrS2dZdGllbWVxMEcvNGdKVVVlNml3ZlExNTRaWFdVa2NqM1RmSXduUTBl?=
 =?utf-8?B?MmpTN1ByeUMzZ3BJOHBUU0tHTUE1MTN3S0d4MFVZM3EvbGFqMmptYW5MSlF0?=
 =?utf-8?B?bWtZcmI1ZVNiM3FsVHA1RStVWHRYQmp5K0lSeWR1cmtRR05IbkdLRjhISFhj?=
 =?utf-8?B?aHpSRkpWYXkvWG1iNDhTTW9JeTMxcGkrUTkyWHZkaWl5TThjQXlBV1l2Zm9E?=
 =?utf-8?B?c1FZT0VNZVIyblpaZjdTVWduYUJLV1A1OXUwc0NVSGh4RmhiOEdERUdIWHp4?=
 =?utf-8?B?NlRhb0lKNzNhMmR1NFNGN2pRUndNVlorUDd0VmcxcFhYUlBCcGhHTzdEUE5q?=
 =?utf-8?B?ZzZjcERRZlB2V0RQQ05tQTBJazZGbmhWcXoyeTliRGtGL2Jneit2czRDUXBX?=
 =?utf-8?B?Z1dRSkRaZFc4b0tSVWV1bmsyaURJcW1Ob2hLcjlKalJFOUg0TW5ZY0poWXlw?=
 =?utf-8?B?SW5MbDk1QVdZUC9ZdmIrdDYzVUJ1a2xkNitFL3lXaG5kUGhGTlp4REd6aFIz?=
 =?utf-8?B?TVN1cS83UlBXamwzOWpjaUh1bmR0T0t4YWxQdjg5ZmZxYlliNlMvemlEdzRz?=
 =?utf-8?B?Y0JienhWazlpYnRFS2xJZFo0NDlPQm1hcVVCMUJMYXBmL1R0RWR4aml6U054?=
 =?utf-8?B?d3lDNkNYT3RTaGFadDNic2U4T1NoNmpHVzFCVEVVVDNVY1NTZ1V5bHpnWEJP?=
 =?utf-8?B?OGd3V1ZOdHh0QXU1cjF6aVVHV3dlVHRob0RsNjVRcXcvTUZaK2FkbUhZV3Rt?=
 =?utf-8?B?YjZJTWtqdkQ3eHl1b0RBTWJQRm5STzhBVlhtTWZsRlBmbHAwWTcxN251VDhz?=
 =?utf-8?B?dFFmVDVFUFc5ekhWNm1JQjF3dG1ZWVZkMytsSjVqUVpqeWFOdjQ5bTl3OVZL?=
 =?utf-8?B?azNnVDh4YU5QMk9ua0V4RXlnN2sxcE00NlVCTXBzdWJleU9vNUZnY0k3U3Uw?=
 =?utf-8?B?RitWVHpmV3MwREhrZjB5aHBLTURjQWZHYm1HcUt0cXIzMmN0MHJZRHJBRzhm?=
 =?utf-8?B?bHpzMG5iclMvNFpINXpJeGV5dHRhdW1LQjFNR0szU3ZvQTFLTzJiVktJNGN5?=
 =?utf-8?B?akZORldJWXh3M3BzdzQ3L2JENVgycWhzNi9MUnZtOTZVUFNBc0ZuS0pMSFFa?=
 =?utf-8?B?eDlnaHYwUVB5TS96dU1POUZJbnFyZXhFVTRYZ2o2V1lQdUp4a1J1TkRmVVIw?=
 =?utf-8?B?QWxJWDN2U0xhWUtCaC9YWnMzZTQzWFJUaHJPdFMySnRZTkt4NE4wRVB5dkJk?=
 =?utf-8?B?YXpTTEpnWEFDdjZ1NWxxM1M4SWY3YVFIVEJhYTRVR3JSeFZDTHRDN0E3UjBB?=
 =?utf-8?B?T0RydkVLdWlzaUZUODEvVXNtamkrbEJ3dTM0dk1RZlFQd0NLaFA1THA4K1Fu?=
 =?utf-8?B?d1ZSd0tBYU9GcTRBTFRTOHAyYVU0dldVNTRPT1JocDlKb3lYVG0zVHpSa3Jw?=
 =?utf-8?B?N1R5UjFKUlg0M2phN0lNYlB4ZjRJQmNMWUpNY21BOGZ5Tm5NdzVJK2dqWmx2?=
 =?utf-8?B?bERxTDU4VFBhR3o1WElTaFVBcWdRcC9OSVNEL2dxek92U2dJUndtQWVQb0VQ?=
 =?utf-8?B?OWxWZWZiaHJJNDNEcmN0a1NCd080Tm1ZRGtCV1phY0crN0pNcWxYSWY5UEZ6?=
 =?utf-8?B?WjJ6RUM1bE9WU05iWUUwWHVuK3VXdGRrMVVqMGNBN09makx0c1VqdHBwQVZT?=
 =?utf-8?B?ck05a25nVXF0MXBXeHdNSW51Qkg2bFlNcVNOQ3VSK0VDVHFRL0xRL3BWQ2U3?=
 =?utf-8?B?SmxLR3d6cVp4a3pjQTlFQ25tZENKVjRhSW5QaStsQTFhMHFmS1FGVjVPWHJL?=
 =?utf-8?B?ajNNd21uSDZYdElTUC9DQ2YxYjFMYTZBQjd5SHJ2elVjT0l5QmI5VDJoNnpQ?=
 =?utf-8?Q?7CIKksFZiw9UnEU6mcg9PQ8J9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0c9ced-5be3-4ef7-0c1a-08dcff8062c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 23:03:25.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1L9Cx8zZTBYUC97hhi0JtGOjo7Drma1jzCDLx+h2rl5oJ07MbY7NAIp3Ela874qDwJKN3nz0oHCxIV7ytAvMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851

Add temp-sensor nxp,p3t1085 for imx93-9x9-qsb boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index 20ec5b3c21f42..36f2995acbe29 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -221,6 +221,11 @@ wm8962: audio-codec@1a {
 		>;
 	};
 
+	p3t1085: temperature-sensor@48 {
+		compatible = "nxp,p3t1085";
+		reg = <0x48>;
+	};
+
 	ptn5110: tcpc@50 {
 		compatible = "nxp,ptn5110", "tcpci";
 		reg = <0x50>;

-- 
2.34.1


