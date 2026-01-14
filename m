Return-Path: <linux-iio+bounces-27763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E9D1E411
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06B2930BA7CE
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC08393DEB;
	Wed, 14 Jan 2026 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="HcrDTm45"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020129.outbound.protection.outlook.com [52.101.84.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B718393DF2;
	Wed, 14 Jan 2026 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387599; cv=fail; b=VR9bLB2H5K3aIqVS8hEw+PDcXCnsmYn0RZSkK0ychJ64yj/Ehw9h7sN5Iuh1t+ovrn9o95uY5Ce7snW896IAMgoV9zdLP6xqigyl7J2rm2IlRz9Bv35Sltotr7iNTnPTdpeFz0M1YbJRgBGXVd2B7eCrIv1GnrkhlcngG1xozgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387599; c=relaxed/simple;
	bh=ZRIYUujopM7MdcuCjOQHMPWcbV6lQS+Zs763DhULrtI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=RREmM+U281K0iJU0W8WIEE55aRieGGB9vS8E9lpyzIRWqmLjT9TkEhK00og5CJOFS4WKktb7w+19hJVlhNayANUFSKJRKiA+VDiUEJ5osoAPlSX3/TiW7JJvr+ntQYLs56Zu5RV2SSYla7KPcadynqrAgdgRUZUM7MaRH50ojd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=HcrDTm45; arc=fail smtp.client-ip=52.101.84.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDAYxFNhIlqUU8veUuWGbeDRjLOimgKbuBzvs8xGVdvtnACU8PSkc0NqNfmVmJ2td1bu+CkIS/jVnlG8B1PTipkdUhuV4VXsBuPkEWHdK7rZ9ud1bZI8838dr0cdqjX86e2inZTWos7EfAW4/8NRfSuEOxmWmPWgPbdKIwt0CQnXpjhu4jhDV+QLfykdLqjIrEjEPP1KDIxz8AM40mRVav2jpw1NTqv6544r3aM5WbobZr8Eu6A4pkUF3ihQI4D8HPUnMWxMa4Mj/nm3U3h0WruL4xRCNtrh+DuWmYESdXGnBwrJOGRe+YIM+a9aVxn2Tw5f7CYxLBfWR413w0vV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdqcDoDP6nIEY6GJbsTQas8Mm8U8Q5Ec7+Z7tCUHeO0=;
 b=fZgcXcuU+Mb4qbee/JVF1ZPaR3FuttIR4VjEOyLPZlMncMp2XO1VIpnK9bvbG4EbsxMFPLou106rrdR3TDO9cNvv8qEWV0+295nOX3IKP/lhoyw2zQ8/8EYv4PUxSyKv4OozTPk+p9eTDui5EMcivJ8Voj16AhaBvq5A1ZCvXDBNZOZayi/ridWpKvMS/lIN9qyaknjvCgpeWkNI9pWg1Ds82b+/XoC5mdPHDoSprhJEBmTN3xNHrtI4mCImAklNXT9085pFaWuavk5Vfl/ONEZjNRujBgbFyg67ZmM11zcECrcZzRFlVfihiYXz7xxQ06Pc7ywLj7c8JCMMI8NS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdqcDoDP6nIEY6GJbsTQas8Mm8U8Q5Ec7+Z7tCUHeO0=;
 b=HcrDTm45jFswxqrZj6/dDu6T7F4eu5VrBObTUjkX8fJcnk2WXgPNjQqVWD/ASHmYCkwyArEJNj2RgMNly6BYtxZboJNPk72iKxLU5W0ZY2Nm64GmDP1RQZNGGzIYavMMlV0DtZPnhhyRtJeVQ0Os/2XQl+LMZTw+z50asMFRvzK2nMyPdjoi38Jx4xccgpsd0RXRH7613kbqjH0B7EfDUAiOuvTzsx7fxF2560NYzCADTNLjig7f/E8Ov16uNtPx25uERzjpkxG5nYS4NqHtGy3UAcJRgWYJHyWJXtH0mWxLvpWcNjxit3oIXjTAIuFx4j4AGq/LEXwk5N4RXO9FWg==
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
Subject: [PATCH v3 0/4] iio: adc: ad9467: Support alternative backends
Date: Wed, 14 Jan 2026 10:45:49 +0000
Message-Id: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN1zZ2kC/33NwQ6DIAyA4VcxnMdCAXHutPdYdkApk8yJAUO2G
 N99aOJhF9PT3zRfZxIxOIzkWswkYHLR+SGHOBWk7fTwROpMbsIZL4FDSRtJtamlqqgfp3yse9r
 o9oWDoVxYYHWNKE1FMjAGtO6z4fdH7s7FyYfv9ivBut1ZdcQmoIxeBCooBaCV5pa0i7rX59a/y
 QonvmOKAYhDjGeMaV5hHm4l/GPLsvwAsn50ihMBAAA=
X-Change-ID: 20251215-b4-ad9467-optional-backend-23f1099ee4d7
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768387568; l=2186;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=ZRIYUujopM7MdcuCjOQHMPWcbV6lQS+Zs763DhULrtI=;
 b=YZ00rKG8uLDujPDm03/9JOMKBQ9Ke+l6Uekvo9uzg1wC37ttcwnGk/VZiG9cwr8ZLMT5q7WWa
 zHyp8BQW4AeBIE2W+/1GTzN5vvKIGlLF9tYsWi8P8y+erCiYZhnSgKg
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
X-MS-Office365-Filtering-Correlation-Id: b4bd9052-06f6-4cdc-a1f8-08de535a206c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUU5bVN5Z1ZaVXcveExNUjhwSlc3YVNGQ0grdi9sNkRyYVVReG04OEthSEpa?=
 =?utf-8?B?T3hDUmh2b3grM0gxb1VKSTNNZHQxaUEyQmtCRHZ5am9wems1dTVndGtBOWZM?=
 =?utf-8?B?U3hheExyVHc2VE1La3VTeXJNMFVjQW80ZW0wSnZSUnYyeEMrOEs0RFVxaDFH?=
 =?utf-8?B?M1FSTjA2eHhzZkFXS1hQTWs2TEpwSGs1bWNpeWh3RWRwdXlrWHZjK2Z0VmJI?=
 =?utf-8?B?eWVwaTNLdE1PTW9SMFBRRm10eGxCeXNBTldJaDJxNHBiNVQ2UU5TbCtEai8v?=
 =?utf-8?B?YlJYdnR6YkNQUjhUa1cxaDJsZWh5STZzTkRBckNrNWZBUTNBTnRZWTg5Z2RC?=
 =?utf-8?B?TXZiTFAySlRqQ1VONUVaRFNSWDhtakRJWmRmM3JUQ2t4Q1J4YjVpeXVoREZ0?=
 =?utf-8?B?ajdCLzFQS2pVN0JtZG95Ujh1SnNpY3RkazJibFgzMnR2cVZ2S3FXcTJWdU5r?=
 =?utf-8?B?TDNoRi9tMTh5K2FHUFJnUTVkR2gxSnQwb1lWTG9GYlJKY0l3cjRGTU11dnlm?=
 =?utf-8?B?TkN4NXZNS3JnY0ZHNE9xTHdWMG9mUVFxaFdUWnNvbGVkR1dJREQyTG9oZHhB?=
 =?utf-8?B?NFo5TGVaYWppcnZRaFVnVXdUQ3lRMnJ3d3g1ZERuRkM2bU1xTEdVVStFQzFE?=
 =?utf-8?B?MHdtYmVJSG51WjNLR1ZMUFNoYzRiRXJjVVdCSHk4UE9MRFgrczFWQXRnSVRw?=
 =?utf-8?B?WmJCOEpibmx2TTNTUGVNTXdYQWRmQmFqMUkvZHByaEdxTjJRa1V1TnF3S0hr?=
 =?utf-8?B?RkNObnVxa3FBUEtyZmhZNGQvM3Bha1hteGhHNE1IekpxbGxLdXpGVTdLSGpQ?=
 =?utf-8?B?Zkpaekc3Y1lSWlArc0RhTWVZbzBRSEpKZWhJeG1wL1NtQXoyOC9BbWY2eU90?=
 =?utf-8?B?TkZOWm9wVTJTUmZtTG14d3U2dGszdW1wN1RuY2NBUDJnRk9UaXZuZXVjckZt?=
 =?utf-8?B?OVhrNDV2ZHFNQjZRLzNCZnRmR04yNW5ONzFjUk9NV01ISzRmTHJ6SUZqeUI3?=
 =?utf-8?B?eXAvWGpKb1J2QkU1ZWlCUUp5R0k3cGFUTWpIVit1V0tlZU90SENubHZYMXdk?=
 =?utf-8?B?YUF6enNMVFhJbThhQlc2NG5uNDRvaFp2MWF5VG5saUdjeklpVm5vRFM4VDRO?=
 =?utf-8?B?enh3U3FRbk0vRUFESWpzWng3Nmx5TDMwVVd2dWRqZTY4TTNaL3MvYWF2eWEy?=
 =?utf-8?B?T2xBYzJIb1VZT0dWOTNFdkhBaEpma1ZvMWhFN1hsQzl1ZEVDVDk0L2NrVmxO?=
 =?utf-8?B?S3MwNy8yN2hPUEJPV3JVcXZVTVdaZXZnbEdiNWhZUis2Y2VoakNNbFZ0eDJ1?=
 =?utf-8?B?aTVHYWlHcU9QTkFucXllbzd0b0hhVjNzYWFSRUhvblBZN1ZvSGxYeGJPZmEv?=
 =?utf-8?B?SUdxZHJ4SVlDNkVtcVdRMjVPWjVsYjhTS0pQTytSQmdsOUNnZEZKaXJObHg2?=
 =?utf-8?B?NVMzWEVlZXpTS21vTmZGT2J6UDZoUmsya09mNEJoL2h2Q3J5UlVOeS9XSHRJ?=
 =?utf-8?B?V3NHZmQzM2FwSHhacEh4NzJxN24vN1dNNGRvbkpTdTY2WTZzaFUxTExyMlll?=
 =?utf-8?B?ZWhJbkVlRll3OUhQZ0tmOXdpMTBnZ29lS1VxUDdZTUw5MTFhalNNcTdKcmxR?=
 =?utf-8?B?WmxVOGI1YktiVWZ4aVA1eWRzNENLUklLVUF1bFJaR2g3SmxLU0V5TzFMTTdS?=
 =?utf-8?B?L2t2VHl5aDFMMHFjNTIxUnFubklLbVFlb1BabkJVbGRESUJvd08wWHVnVUh2?=
 =?utf-8?B?bXE4bGZnYjh6ZGVIVWpnRkxXVkxSNUZhOHN1RHgvTGhXOVptMnFVdzB2MUhW?=
 =?utf-8?B?ZVE2TTUraFZrb1NCTXlrT1BRRXBSN3dOd2xtajQ5UHdvTkFaSE9YZC8wT0hr?=
 =?utf-8?B?UDFFRWNRWXk1Q1liWXZwNnlmT09sRmRXVVhGMTRCb3BuQXp0NU1tMG91REs0?=
 =?utf-8?B?YU1FNEJ1UmtITi8wVkc2bDA3cjR5TTlIWXQwNTRxTWtzbkdpVVVOcDFzZ3hq?=
 =?utf-8?B?b2hScnVQTnFIY2ozVzJqWVVLc2w2THlDbVl5VUEvVmY2UFVPbEJOenBHQ1p0?=
 =?utf-8?B?dDJiQVBTQUplRTVaa0RYdW4rUCtnc05POVY2ZVJRbFgyVEFzdEJTV1VjZm14?=
 =?utf-8?B?RkxWeW5aMngvRWJQUGlXUU1vYWZqTi9lT3AwRmxmOWhXSUtvZWpuRkNyWjJW?=
 =?utf-8?Q?Cq+zLWAVkhiPLaQLvn6sOnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1hKbzlabjNab1Y3KzJoVllick1zN2dxbUQ2bGY4MWwxSEpNbmxvZ2pZNjhp?=
 =?utf-8?B?L1ZTbUZtOW5ZVnhBdWxFTXdHaTZQS29MK2d0VVRZeFE0azk2RVJEY044UFhS?=
 =?utf-8?B?SmgwRHlCcFlmQkpPUmROTktVRjBmVkQxVVFZZDdZL1RrWFhOUHJITXluc3B4?=
 =?utf-8?B?RVVWWkswVEcvK3lwYUdINFQwR003bktLZkRiVmw1a25kekVuaXp1Q084a0Nw?=
 =?utf-8?B?WDJ3YllBY2dCdk1HUmV5bnIzR3hvZ0ZVdVZHWVN1dW9TYWFoZG0wWkhXUUhr?=
 =?utf-8?B?VXhJbjA2dzA5Y0wvY2E3MGpMRUR2dHJVYy85QktOY3BUb2JFcTVEUkxRdzNw?=
 =?utf-8?B?c08wVW1CbFBUNUpvWmxReDBoMkZGaHVLQU1ZZ2JoR2VPSUhrMTZ0QVFoV2lX?=
 =?utf-8?B?WVQvdGxKL1RPbjBvVlZiYWVWUzZYWXpIWEkxTG5iN2xZejFJK1hsaUVMQWJu?=
 =?utf-8?B?ajFXczBIZFZnSllkVHVZdDAvSXlaMzQ1ZSsyd1AvSW1CWDJqRmtaMUJKOFZJ?=
 =?utf-8?B?allJMEJYZHhyUm10WVBpeE1ZREtpUkVPT3JEaFYwNExrQkNtOXV6dnFkbVBD?=
 =?utf-8?B?M2ZHeEd4ckp6SVZHWnI3Tm9CRjMvQWQwdGdvQWtkeHBQWHBQNGhscVJJN2x2?=
 =?utf-8?B?STBEYUd5VG1rWTI0VUdIcWhpVXVxTXJ3QWNaeEJJZ1Y5M01Ca3FIUnFmQnJ2?=
 =?utf-8?B?bjNxcUhWbHI3WEVPeHk5c0tkeGJvNVcwZFEzVWlXUVFJc0o1dDZuYlNaU01I?=
 =?utf-8?B?QmtMVm9tLzh4UlJjUFJmR3QvK3VOcTV2a1pvV0Nsck5rRTVLdkF1aE5qSmpP?=
 =?utf-8?B?c0tzYTBZS1Q3WVVoTUFVNUU3N1h1UWx5elpEb2xBd3NMMTQvQzB0czZOYkZu?=
 =?utf-8?B?VEN2cW1SeDExRkJoRWVDWWNlaFJ2VGdPWEpJL1NReVNVemQvb2VFSFhjQUVt?=
 =?utf-8?B?dVRybGRpekJkWWNyLzl5bGpKVVNUYjUvdlFjOUFMU3FVRUpRczg3SVZpZVpm?=
 =?utf-8?B?SVVYZmFELzRVcjhjUU9kRnZwQTlkVVl6cjFrNERkQS9VOWV5azY4bEo0eW1D?=
 =?utf-8?B?NjU1Y2E2b1JWdld6VGJuR1JMQ3hPKy84ZTRKdGVwblJMVWdJaXVndGh4TWo3?=
 =?utf-8?B?K3c2bXZNUGorYmprQUVURUgvRmNsU2FVMm13ZlpHRkx6RU5OUGNLcllEOWd1?=
 =?utf-8?B?dEdzV3pZLzlJKytia1FmeDdockdzT3N6ODBQdnNNU1VmejROV0czbDRydzMx?=
 =?utf-8?B?QUxZK2ZQeDlYOGtxM2RNZVFhMlVZNG9xeFg2cFE2OG5wQ0NaU21iL1EvOWRy?=
 =?utf-8?B?dVAxNlNnMmY4TWtMZjRpdlA4ZGdLM0hNbk5tcXhzWEZMMklwckV2TWVKSmZn?=
 =?utf-8?B?UFRZbUxCQm9LMTFacXh3ZFBCMVhwaVBQUERmSHhMaDFvVEtMUncya1V4RDUw?=
 =?utf-8?B?SzV0aVBkSnIxYnFvMmVZL0xBejVWQnR0NlJaYWZQbjJ1L1dibDR6QVRiK1Uz?=
 =?utf-8?B?R3VCZnRPaVFGY0gxNkFWMjg5ZTl5ekF2bDZJeGg1eGtGKzUvNVJ4TzdYZDJF?=
 =?utf-8?B?NXIyNnJ1WXpxSG1nL2lWRXBiOUU0Zm9ndWFKbmF5SjJmdkF6aVErbEVlc1Iw?=
 =?utf-8?B?b3hXQ3ptQm4vcnYyZXBjcFBQZGJDY3RPbEk1dW1wbTBNY1pHanBSVVF3eGxJ?=
 =?utf-8?B?cGVVazhEdzBoNlBhcEFDdnRzS0N1MkNQUTdDaDQydGRic3ZPSkFJQjFKZkZk?=
 =?utf-8?B?Rk0wZVgwZ3ZNcDhzR1YwZXI0dDR4NnhVakJ5bjBQd29jeXpMb0ljUWZCZTFB?=
 =?utf-8?B?VTBRNjRYaU9LaWNoNkRzQmRydTUyS2swY0Z1cVY3V0N1bEZmbU8yS3V6VGVI?=
 =?utf-8?B?OTFkNEpVaFlka0lQZEdyWnExSEV6M2pVQXRWOVRnNHJuVC9jTFI0ZG4xZXZw?=
 =?utf-8?B?Mjlva1hyN2gyVWp3MUFmMDJoWTdQZFlralNOMHdBNldSaGFsME1jOUY0eVV0?=
 =?utf-8?B?K1dhS0t3NWNoVDg0MjJDNnI3TkhTSEdFd0o5SXRGR0xnaFRGOEgxWVc3NE45?=
 =?utf-8?B?OE83aFZCOW1DdGwxakxlWGUxWnAxd09uTVZEVEhoRFh0eG9Gallxa0l5TGRO?=
 =?utf-8?B?ZEM1WlR3eEowZGYraURMVlFlVXM4ckFGeUlOZFVqNFBQM1g3K3VMN3VZcXlD?=
 =?utf-8?B?NHZ4cXdrUWR5dDNPRm54ZUdUT1krSC8vYzRVQ2xnM2lKelkwQWUreVU0ZVpB?=
 =?utf-8?B?OXYvYXpYcGtOdzFlVjMyZ1pZQmwyMk9kQ1R2cUFqTVozRG1CRDF6YXFNeVA2?=
 =?utf-8?B?RC9qelJKZnJidDZHWWp1NlFJMzhDenBKNnQyM1BxanVjUno0UzZaTXBYYmJL?=
 =?utf-8?Q?2w0Wo3owdQPOdbok=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bd9052-06f6-4cdc-a1f8-08de535a206c
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:46:08.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqNqopfqv5SLgJv9HIdPzPIT4PnPMCJaUx8NqfthF1x2cUtoMTLyeWlsgT5KzLylq0RVVlejjgQeJGu4IHKvow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8943

To facilitate backends with different set of features, add support
for defining capabilites provided by the backend. These capabilites
typically extend beyond a single operation and are therefore not
directly linked to if a single function call is implemented or not.
Furthermore, the capabilites determine if a certain set of operations
should be attempted, or skipped by the frontend. This way
the frontend driver can work with a minimalistic set of features and
still have the device in fully functional state.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v3:
- Reduce set of capabilities to only include calibration. The other
  ones propsed in V2 can be seen as subset of calibration, or single
  operation failing with opnotsupported
- Rename backends checking function
- Relocate caps field inside backend struct (pahole)
- Add kernel-docs
- Add capabilites for exisiting backend variants
- Link to v2: https://lore.kernel.org/r/20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com

Changes in v2:
- Added industrialio-backend capabilities feature
- Removed acceptance for fully optional backend, instead require atleast
  minimalistic backend to exist
- Switched to FIELD_MODIFY()
- Fixed kernel test robot reported failure for missing bitfield.h
- Link to v1: https://lore.kernel.org/r/20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com

---
Tomas Melin (4):
      iio: adc: ad9467: include two's complement in default mode
      iio: industrialio-backend: support backend capabilities
      iio: adc: adi-axi-adc: define supported iio-backend capabilities
      iio: adc: ad9467: check for backend capabilities

 drivers/iio/adc/ad9467.c           | 44 ++++++++++++++++++++++++++++++--------
 drivers/iio/adc/adi-axi-adc.c      |  2 ++
 drivers/iio/industrialio-backend.c | 17 +++++++++++++++
 include/linux/iio/backend.h        | 17 +++++++++++++++
 4 files changed, 71 insertions(+), 9 deletions(-)
---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251215-b4-ad9467-optional-backend-23f1099ee4d7

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>


