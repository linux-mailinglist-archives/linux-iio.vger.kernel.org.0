Return-Path: <linux-iio+bounces-27761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A938D1E33D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B17CF3042B40
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D4439446A;
	Wed, 14 Jan 2026 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="A+eeDsr/"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020129.outbound.protection.outlook.com [52.101.84.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A24393DD4;
	Wed, 14 Jan 2026 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387589; cv=fail; b=XDIHOv6ob9tQRAdkt7lqAfS0ZpcVXhKkd8teFbYQ9H2YYf6MXJuUT0m0S2fz6yJW1RHRuUPgdGb/23u9Lkqdp8zpHB/eWNRM9ozzncAy0y3jYcn9E+Y0mK8SSOwZYmZL8E8DeCYgTH9MfnpEhL5nZ6pWQ5I1lCH+06vOFLTJAuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387589; c=relaxed/simple;
	bh=/HZcbYWB6bVqFAEBi9w2CKjjxMUaYMBIN7m23Qdpml4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EV65f2qRFde3mOVEmiKJJaN6ySc3jkJMMtxP0VGrWRGJmhFqsEpCJlMt2/Rtp6HLSx8R1z2B7EphrowoKC11h/L8j/JTJfZLicpMnlkU2ZpbOAKkrmDPCJ2S/V+1EoY/7NcaybLHdhBoYET/ZZivBNaR93DRs7NVObkflbiZpeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=A+eeDsr/; arc=fail smtp.client-ip=52.101.84.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXDlC/eu1S9V/6aKpNy3knTjghSa7mOdpgFe0cNlu8KiH+vMt+E6q4fGRB0T1+Ebvn9Pi7BLsnZ1uPICIEHJLVyJLJKEnA4e417mK97ZI16m4wzwqG0nygEMNl6dquihDwkLPZBLB0Hat8idZDzYVH2a6WE8pozUiM8MiYFbjX2b3jeMl0HGsuNLzUa1xZOWLXXZ0zHYVMPmPvFPhM5P7b9wKrLhFawtFYuz+7B5+3puM2AXg7XpWgl6h5bc9wRC41FZyd8gkjYx6PJeo6+kOyrZNBSHlkjoLDlvMZIQRv4Ww84gEkVmxyrjygI4Srlph+h6uN7+yUGdzuo1RCmdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3hWUH6oSfe72vLouICPe7yktgYiEa5cEzjUuBzsZRU=;
 b=ilNSo50mjn71WwjR0sXro/XkautcVkBZmVsL37ySu6iopceO2LHEh//Vei0bVQtHIcUISCBjWW81i31PmyxpI63PBSUeSCw+DW4Bv0pLvbFsySl/D7rDmp0rEZNJqOMBdczENEL5+I5JEBTs3t1+ng2qQzKZb1wnCAFrrB3VFHiTHLZdU6B5LrnqVouORPuJ2XNeiMnY6JlGqoYCK1tTnyi/gnuh7ybmByma5eB6ApNWcnIC2cDE2gpjXRslqJ4eu3sQtP2UIidMJMEdQwY/gf6lghlIJs6OILaMxWmI2SQvz6XMjo1A9xtNfG8dhKx+mvptsTfyfBtLHsAGSa2qEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3hWUH6oSfe72vLouICPe7yktgYiEa5cEzjUuBzsZRU=;
 b=A+eeDsr/yRwpkwTCZ0v3oQ34I+tl3Jcy2XnWatkcM9XD1xiyxhDaV62unpqm8sYUs6PqFCjiHysNTvPDnb65/hFj39G9dnNNVDjNJhbKwE0y1mrr5ZjtNOhCzp/Be5E2ympFSM9MAiojr1J0FNjYmkMMy0PKGlZvXQ8zvWMSX6THajb2oZK6RovnlsR7WfGBICpZS5r2uLW7eCnlCpeoR4HMuBR+lmU8qE9mXJ44QOxyObEhRrDz+dUyyf9vKH8v5gp7rlCpa2vE+/8muefYrDXgqSA4RjQz98wXT/1yMVMqnMfPfYgMfXCNV4PsQ/bGYGvRXQRDEoosZLEUHiehpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS5PR06MB8943.eurprd06.prod.outlook.com (2603:10a6:20b:655::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:46:09 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:46:09 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 14 Jan 2026 10:45:50 +0000
Subject: [PATCH v3 1/4] iio: adc: ad9467: include two's complement in
 default mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260114-b4-ad9467-optional-backend-v3-1-d2c84979d010@vaisala.com>
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
In-Reply-To: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768387568; l=4993;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=/HZcbYWB6bVqFAEBi9w2CKjjxMUaYMBIN7m23Qdpml4=;
 b=UKdTP+wqsHIrVC9ZA9Ay4HMjPpGcro4sTB+QMoOE+QXDqsSwZTE5WGnI1+OXIeMT3MhhcHuDk
 owmA7KnT45+Cov1ZvuHYE1sBFQLvZFKox+HN47FdfPO8FfUeXHVur/3
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVZP280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::13) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS5PR06MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f92c264-bd34-4d21-d2a2-08de535a20c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUNwcXlUK0ZjbmZ5K2dVZDdyZmFSOHdMbUxsOGE0V3dZMHQ3YWZVcDRSbmow?=
 =?utf-8?B?ejN0S0hUclNkVk5IYStCQ1NFRStxNkdnWi84czNhSG1zSU4zbnpOZUk5VGp6?=
 =?utf-8?B?NVZCS1UxelVSeDAyb3lYbmR1aTloRUNYZzJobm96c1RtNzEwT01UQ1l6WWY0?=
 =?utf-8?B?T2IvR1lWemthZ0F1aW9IRkNoSlArTE5oZGpXMVUvSDV1ekh6SFJLZFhFZWEr?=
 =?utf-8?B?MWx5eHJUTDltVjFJWHJGQk1HOFVKNVRwL0k2b2pOOVVGZldITWpSSy92WnNz?=
 =?utf-8?B?bWVjNkN3T2ZpR0syRVBlRmw1cjNmdEN4L1ZOT3JoY29WeE9QRzR6WlBmclBp?=
 =?utf-8?B?QW8reFV1Vi9mT1hyUGN5VG9VUHNRRFNibHU1M3NpQmkrc3ZtQlBYME5lQ2dJ?=
 =?utf-8?B?WnVCOFhNOEV6dldQMC9hTGxFenRMY2ZCVEExSVJDeVZTSVhSZHcvTXVaazVN?=
 =?utf-8?B?RUJQK1Y5TmRQeWpRTkFCTlJxcHhISWhScGNkL1ZEQzBaaFBLbzNSLzcvVFoz?=
 =?utf-8?B?NkNLaWZWZDhWTmFVR0Vib011Q0l4UExoVzREa2trckZTUU92R2FOMUwwSUxN?=
 =?utf-8?B?OFoybjZvOXEyTkhCaEx2Wm5sRmpBdDlhdGFKbnU4ZUpHMXEwWHhXNkt3K3V6?=
 =?utf-8?B?ZGswOXRQQ0Z5TlhPQTRRUzhMUWhMbzc5c3RqckVhb0Z5QXFxM3NwMkRoRmZP?=
 =?utf-8?B?N0g2a09yMzhzSUhJQlVuOU5paG9ITHZwT1dxbis4a2tZb0lkMFZoUGM4c1ZH?=
 =?utf-8?B?UGxadnBjdWVReUZVMzFvWFB0cys4bkEydFRJU0l2YWxBTEZQSlhEa2IyaUhz?=
 =?utf-8?B?TW1CY2VMbmRicTFlWWhHUjl4Rkg3VGJDUGQ3UlRTUXQ4cmRaWlIwSkNkU3Fu?=
 =?utf-8?B?YmNyQmRzNU9TRmp2T1ptdHJZa1oydm1CRTlBWFFSY3hTUzZSVko0Zk9IMWd2?=
 =?utf-8?B?WkNNcWdoTkFpYzRXR3RhWWMyZWVKbmVvNldzeFRnWnJwUEZTb2thTlFHRC83?=
 =?utf-8?B?UVlWeUR4bXFPWFpBSHlLbkZOM1dhaThIOGdqcTJNVUdQTVlUcUQ4UjBpZitl?=
 =?utf-8?B?eWN3cVEvZFBRbUpMTlNIMG1BTjJYVjZxL094S08xZ2F3R2ZSb0R1WW5LRVhj?=
 =?utf-8?B?YkFWVi9qYmI5eFQ2WFg0R0EvbFk4QkNkS2pNQm9tTTJ2V0lYRUlnSG51eFRu?=
 =?utf-8?B?STlSeHowNm84VHZhM0FVdDc2YTAwdFVYZEFNN2Z3VFNTazFvZlh2THpySVdh?=
 =?utf-8?B?azMvdlkvOFNoKzdQY0FJMi9KZzhXM0VMWjZ3WWxzZDBzeGZTNE00U2dvRDJH?=
 =?utf-8?B?WVFLcTNLRzVxMGl2NDdleEdBZnVNaVFpWVM2SmdxcGV6alpwL3dxM0IrTFpX?=
 =?utf-8?B?VnVjWi9ZZnNmdG5JVjlkZmxBNWNEMmt2OUFWUzZ4ZDhuRWluS3FVc0JPZXJX?=
 =?utf-8?B?YnJDSDZQdUxYVzhsdFJuUDlUSHNlK0l2aERrSDNPdEFhODlBaXB0RStPOUU5?=
 =?utf-8?B?NCtrYld6OEowTVo0c21nMTRMdnZqRHNsdUNzMFd1Z3c3Uzh2V0dKWk1XN0wz?=
 =?utf-8?B?aDVwNGthU3A4eGk5L1lOZkpQYVF0cXl2R1JjQmd3aEFnNktBOWQ1QkJmWFhv?=
 =?utf-8?B?RDhUMGNBaW5oY2NRUjg3OThwRkRlRlZEdzJnQW8vMVN4clZGdTFUMFAzZ3E1?=
 =?utf-8?B?a0pGdmxmNjNGdVJvU0lWRnZMWjF4Z3ZnbnZWbDhYOTMvTTlxUWVuZzdVU1Y4?=
 =?utf-8?B?WnJzNHNORWVQTzBXMGNmUDBYVkhvZUljc3Vad0dodGhXVW5WVWhlY1RLdkZK?=
 =?utf-8?B?Z282QmtlbmZVNUliK0t1VTVaRzZKZkNGMTlVME5lQmg2NEUzekdFUEg4aEhm?=
 =?utf-8?B?bUtkM2JyeTJIWEJUdU1PNTUyL0FubXJ2ZmhiSEV4QVlTZnFKRlVYRUVnSXpz?=
 =?utf-8?B?K05aUFpHZnRhUkdDZnlYMkVGczZRL2JJMDVHMFp1RDJqNDRLZy8xZ3hkdG8w?=
 =?utf-8?B?WjZHMENNcjBtZGdYVUltYTBsL3lVWHN0eDFIbnZ3R2ZIaWZldE5ocHlSTFE1?=
 =?utf-8?B?RHAwVGt2YUd2ckRDL3UzNjc5cXltSEZGeXJrTkxQKzFWQXV3WUVWblErSU9G?=
 =?utf-8?B?ZUdFcXdTaUlpc1o5MjEwT0NXdWduV0Q5dEFpaEJSTnZJQUFwRUQyTjV1SnBG?=
 =?utf-8?Q?8zmnZ195OVyj3+SX0+pXlGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2t1d0ZDVkw5VTlIRWN4aEY2QUkyVURiazJYelltaGJwUWZBU09PbHh3akhl?=
 =?utf-8?B?OUhmallDVkptTVNNdG9Xcm9pemppRnlySWhlNkRWLzUyODFHQjhnRTNTQnp4?=
 =?utf-8?B?cGI1NndXUysrUUJ4aTZ3Nzdja3NYZGtXUEtQOWs3T2lHUS9ZOUxoUlBHQlQ2?=
 =?utf-8?B?SVE5Y1E3dHRGLzQ4WkVRblptYmhlNEZuNURDNWgvT20yaWhvVmwzYjJhWHJ1?=
 =?utf-8?B?V2MwSTF4Ylc2NktIN0pnd1VTd3ZMRUZ4bGo4c05NdkwwT015RDVaY2hUakov?=
 =?utf-8?B?eFdGN003Q1p5ZmRlbGt3OFhORzlWSHpsR1VQeW5wa3cyTmVlbmgyZTN2ZlYy?=
 =?utf-8?B?OUI0UTB2b0JsN3ZhSm5nWjhhNFFYaFJRNWE0RHVqMUJQbHhkSEdYS1RlSE0r?=
 =?utf-8?B?RENMOXpnMG5BR3BqQUg3WUlpTEpxQzkybUd5MDBuOGM1WWJyc1lpUjVtZDhG?=
 =?utf-8?B?QUg4QVM2NG1oc2xCTFJnajJDeTVGYzdUSURPSWxDcGRmcmhYRTBMSXM3WHY4?=
 =?utf-8?B?TVNJc20zT0FETHdIM3k0ZkV1RFUvN3JaWndrenB1Ulh3bnAyZ1FTZEFuSFAx?=
 =?utf-8?B?RS9ZVTh2TFpNbWFDRyt0NXdzZnhMai9MQU56MXlXUTduVHdEaGJoNDJ6bThp?=
 =?utf-8?B?VXc2ZjBpeFRLZjBaYStjUVVTeVNaUWk5bjBnSWJPNW5vTVh4cUNteU5HbHVy?=
 =?utf-8?B?L3daL2RualhZV2h6M3QrdTlKWmJSc2NLTVozL1FtMjBYZjdON21TR096S3Nr?=
 =?utf-8?B?YVJGeTU2czhxUlVqS1ZnQkNFN0NBUEg2Qnh5UjJIUTNlaWk4MXVkMDZ5bWoy?=
 =?utf-8?B?K3pqR1diZkxmRzFNelVhVXRNUlh0azkra09Yb0lnc3VLb3Fzdi81RzhaL2Y5?=
 =?utf-8?B?Nld3STRPV1pDaW8rcXgwK3NrekhkODBJd3dXSG8wMG54TE9IMVQvL3VFdGpp?=
 =?utf-8?B?aVk4bE9PYmRidUNNRnlwM0xPNStyVmRxa0xGcjc2bXhaZUdtL2laSVdaSmlt?=
 =?utf-8?B?cjQ4c1NrZndGZTVxdjh2Zk1kQXFIOForbEd2c0J0YWlKVkovWkNIQkFmQUln?=
 =?utf-8?B?cXhKWkwvOTlLT3A0NFppdXpxRVBwRGlaRDZFeVBYQ2dFa0Q3R3Noem1QK050?=
 =?utf-8?B?SHVmUjA0MDJjTFlJeEZGeHpZckxzSlBYeGZpUHRKcW5BY2pTZW9CWDRPSmVL?=
 =?utf-8?B?WW0rZTdVZUhiZlZWWEQrZDA2RDkzYnhNZlRnL0dWN28yNWZVSlNFNHlmVUhD?=
 =?utf-8?B?cksyaW51cm80MUxBSlRmNHV5MTIzaWlLaU1IbWdtVGlrdjh1YTV5L2tvQXNF?=
 =?utf-8?B?cUM2aFY4ZXFCWldEZ0kzaXB0YmxuaFErbGI4ZkhnZlluYmxubEFsZktYdit3?=
 =?utf-8?B?UjZJRjErWVl3cDMvbUlDL0xiN0k4cG41STZ2TCtRWWtwc0VTU3dQRjJTM21K?=
 =?utf-8?B?dzl1VDZHVlZnT09vZTRJUUVqWWprSDBETHNvQjBSSEVGNFlHWlRteUUrYThN?=
 =?utf-8?B?SlJVNnk1VjZxemhMNGRzNFVOMDRzRi9qZXpGdHluNFdRL0hBakpvRXJwbmhE?=
 =?utf-8?B?SEpJeDNuaTA3UnV1dldmam5mNjJoNzZTaHpLSy9PSlVGa3UrNmxSVVFmQUtJ?=
 =?utf-8?B?SVIvTWtqbWhkczdDOThQRkRIRjdQSkFkMDdVT0txTXQwejZvMWVtWjhuNDZR?=
 =?utf-8?B?LzMzQmM4cExhd3NFcnlCZEdXSEFlRW9xWnNaWjN3YVBHNDUxZWQ5c3hLVW5O?=
 =?utf-8?B?eXJlQkxKVnhnUkNwaUp6TzNNdTZrNmFHNmpOVnNVT2grZm5SM1hWSzh4SHho?=
 =?utf-8?B?RGFXWVZldERmYTRVbWptaXgwM0wzaVVpMWh5YjNlWGFVQWFJTzFCSktIZFRZ?=
 =?utf-8?B?WVBBOUFod2RucTZ0bGhhMVNiVE8rQWNWRTY1RDNJRHVxZ1o0dkNlWE9GbzFj?=
 =?utf-8?B?U1ZKNU9TUjVYc3prYnJSME0zYUFYRUczdjNnQzRsUjBoamtSTHo4S0cvVHdy?=
 =?utf-8?B?aEMvT0Iybmg4b0FLMEZWSTA3ZVpqOGkrUWdqT0JhK205NWxMYTV2ejFreE1K?=
 =?utf-8?B?Z2hMMlNtTy83YWJCeE9jRlUzcWE3Rk9KVmJac2ZFaGpUViszQ1Bxa3hHUTc3?=
 =?utf-8?B?NmZwQ0xZcVlqMkhYTStqOEpCYnRKVFZDVVUvdkFCalM3dWFRWE1PNHcwenRz?=
 =?utf-8?B?TDYxRlFBY2lNL1VOM0wzd0tSQS82Y3FIWW8xbW96ZjBPZzZUTjBud2Z3Q0w1?=
 =?utf-8?B?dkl3KzVmZURMSysxV084UWZITFBtbXdCL1cwQnJyRVlaRW9RY0FEd1NzUmZU?=
 =?utf-8?B?Z1VFTkhrY1VxeVhyNStzbDdVb0d1MTRhOGJzRkdWRElFR3d6VVZQdlNZL0hG?=
 =?utf-8?Q?bSHyCzYCAcZdLA9o=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f92c264-bd34-4d21-d2a2-08de535a20c6
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:46:09.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZtwEx1EOeCcjYgVPX7crsxTq2ddMxZfTAzFiBcnwmtfmse8aKCBlagMVLI8kFpjpbdDhUvOx8wbr7IbOOPmPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8943

All supported drivers currently implicitly use two's complement mode.
Make this clear by declaring two's complement in the default
output mode. Calibration mode uses offset binary, so change the output
mode only when running the calibration or other test mode.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 59c3fa3bcc9b0b8b36b78c3b54fd7977cae23496..9cfe66425d4e91e215cccc40e24a92c5e99e9b87 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -5,6 +5,7 @@
  * Copyright 2012-2020 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
@@ -72,6 +73,7 @@
 #define AN877_ADC_OUTPUT_MODE_OFFSET_BINARY	0x0
 #define AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT	0x1
 #define AN877_ADC_OUTPUT_MODE_GRAY_CODE		0x2
+#define AN877_ADC_OUTPUT_MODE_MASK		GENMASK(1, 0)
 
 /* AN877_ADC_REG_OUTPUT_PHASE */
 #define AN877_ADC_OUTPUT_EVEN_ODD_MODE_EN	0x20
@@ -85,7 +87,7 @@
  */
 
 #define CHIPID_AD9211			0x06
-#define AD9211_DEF_OUTPUT_MODE		0x00
+#define AD9211_DEF_OUTPUT_MODE		0x01
 #define AD9211_REG_VREF_MASK		GENMASK(4, 0)
 
 /*
@@ -93,7 +95,7 @@
  */
 
 #define CHIPID_AD9265			0x64
-#define AD9265_DEF_OUTPUT_MODE		0x40
+#define AD9265_DEF_OUTPUT_MODE		0x41
 #define AD9265_REG_VREF_MASK		0xC0
 
 /*
@@ -101,7 +103,7 @@
  */
 
 #define CHIPID_AD9434			0x6A
-#define AD9434_DEF_OUTPUT_MODE		0x00
+#define AD9434_DEF_OUTPUT_MODE		0x01
 #define AD9434_REG_VREF_MASK		0xC0
 
 /*
@@ -109,7 +111,7 @@
  */
 
 #define CHIPID_AD9467			0x50
-#define AD9467_DEF_OUTPUT_MODE		0x08
+#define AD9467_DEF_OUTPUT_MODE		0x09
 #define AD9467_REG_VREF_MASK		0x0F
 
 /*
@@ -117,6 +119,7 @@
  */
 
 #define CHIPID_AD9643			0x82
+#define AD9643_DEF_OUTPUT_MODE		0x01
 #define AD9643_REG_VREF_MASK		0x1F
 
 /*
@@ -124,6 +127,7 @@
  */
 
 #define CHIPID_AD9652                   0xC1
+#define AD9652_DEF_OUTPUT_MODE		0x01
 #define AD9652_REG_VREF_MASK            0xC0
 
 /*
@@ -131,6 +135,7 @@
  */
 
 #define CHIPID_AD9649			0x6F
+#define AD9649_DEF_OUTPUT_MODE		0x01
 #define AD9649_TEST_POINTS		8
 
 #define AD9647_MAX_TEST_POINTS		32
@@ -461,6 +466,7 @@ static const struct ad9467_chip_info ad9643_chip_tbl = {
 	.test_mask = BIT(AN877_ADC_TESTMODE_RAMP) |
 		GENMASK(AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY, AN877_ADC_TESTMODE_OFF),
 	.test_mask_len = AN877_ADC_TESTMODE_RAMP + 1,
+	.default_output_mode = AD9643_DEF_OUTPUT_MODE,
 	.vref_mask = AD9643_REG_VREF_MASK,
 	.has_dco = true,
 	.has_dco_invert = true,
@@ -479,6 +485,7 @@ static const struct ad9467_chip_info ad9649_chip_tbl = {
 	.test_mask = GENMASK(AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY,
 			     AN877_ADC_TESTMODE_OFF),
 	.test_mask_len = AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY + 1,
+	.default_output_mode = AD9649_DEF_OUTPUT_MODE,
 	.has_dco = true,
 	.has_dco_invert = true,
 	.dco_en = AN877_ADC_DCO_DELAY_ENABLE,
@@ -496,6 +503,7 @@ static const struct ad9467_chip_info ad9652_chip_tbl = {
 	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
 			     AN877_ADC_TESTMODE_OFF),
 	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
+	.default_output_mode = AD9652_DEF_OUTPUT_MODE,
 	.vref_mask = AD9652_REG_VREF_MASK,
 	.has_dco = true,
 };
@@ -671,10 +679,14 @@ static int ad9467_backend_testmode_off(struct ad9467_state *st,
 
 static int ad9647_calibrate_prepare(struct ad9467_state *st)
 {
+	unsigned int cmode;
 	unsigned int c;
 	int ret;
 
-	ret = ad9467_outputmode_set(st, st->info->default_output_mode);
+	cmode = st->info->default_output_mode;
+	FIELD_MODIFY(AN877_ADC_OUTPUT_MODE_MASK, &cmode,
+		     AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
+	ret = ad9467_outputmode_set(st, cmode);
 	if (ret)
 		return ret;
 
@@ -778,7 +790,7 @@ static int ad9647_calibrate_stop(struct ad9467_state *st)
 			return ret;
 	}
 
-	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+	mode = st->info->default_output_mode;
 	return ad9467_outputmode_set(st, mode);
 }
 
@@ -1174,12 +1186,17 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
 		if (ret)
 			return ret;
 
-		out_mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+		out_mode = st->info->default_output_mode;
 		ret = ad9467_outputmode_set(st, out_mode);
 		if (ret)
 			return ret;
 	} else {
-		ret = ad9467_outputmode_set(st, st->info->default_output_mode);
+		unsigned int cmode;
+
+		cmode = st->info->default_output_mode;
+		FIELD_MODIFY(AN877_ADC_OUTPUT_MODE_MASK, &cmode,
+			     AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
+		ret = ad9467_outputmode_set(st, cmode);
 		if (ret)
 			return ret;
 

-- 
2.47.3


