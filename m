Return-Path: <linux-iio+bounces-12337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968E89CFA24
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 23:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3821F28360
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 22:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F3F1925A4;
	Fri, 15 Nov 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U0JXOKlE"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE4191F9E;
	Fri, 15 Nov 2024 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710269; cv=fail; b=dBfLy2X4a2eeveQknsmfEU5cssoSWZ/3aAbenPK5BlahR0Z0GUWUrBx5HKJixwxfLRnmwj3QXvaCug8k77v5RLgd5LVuHZTu67s9d2IhsJpPzC0xR2BOjT0qdipRv2/gdyDNe0EgkiIwZUa3uZ+cLx50fzS1NB4RRXv1YiPSk0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710269; c=relaxed/simple;
	bh=FDDrqPlnyl/sdvCPbVvgQp8p9sp4AIhD9RaXQeXf3/Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Mj+mbHQfhzEJpPEH3LGE+MKj2x9iTCyLpsE7l57CUkMuOV89yja8jT5hcJi03ZJwgsz1xQDnNj1qitQ/aVWXeEwbl/tO+1er3hYrgj/tEe6H+FanurjcOY1n3mxpFco0D/MOSCxYRq8/0Yyop/YFdfk7u6apz81LT8KKNqd7c2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U0JXOKlE; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAv25ank1tDZre9N9C0dOHw5KyOhue875/cHnFApCC9iP6yuoykw1R+65mfrWGJxiSvcMTkVSF3xkNTXuGAAkexxSqAzd3l/hacLQYjwyyMx0SxpWjK6+gM0yrkHAYSWGkKjQdMMdg0hIT+HCn7mIx6VL+InsdbmyF1bXtd9JEKTd/j2vmT785d1SABhBCVwnP6ZfvexLLZyXjM6fuVPRjmV4bYQO/e8RG33/zujAKwUv1I3U1nLkx7ji/x2yQHVnKbGIoTOmc37GeH6brg9QJHACFJujAQalhqXmdcoaRzc6tHOd5aLdeY8/dZrPfkDRzpnp2iqpQWw6z2t8hsEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU2SqsMj5xP7YYeKSVmX3Kxay8BL1maRjECnNSuk2lA=;
 b=TQWHltsJbn1vYjnQXpVwyUxxVYbaL4Ndx3oUY6m/iNc6v8m7YS6txnlhQNqc99m0pPuBdG5qssZ13Sm1O/dXfP4j46+OsHcOaSJaT8rHt+5yMTyVTdi/a5lYC1Iu5k2ySSybTlrORCsF3fg8aAODvHdykTMpUMf15Y27bweF9b48mdQ4+oaIbI4WgKHLOEIOP9e9YIrzHyq7QtDR740ZuUlyFh1kX4gxyIujNkju1tloV8L2uMjq/1yfN/d/maLGn5p5zrWPsl3PXmCtekmjStpfiYgOv56hen8tEJNPvyQIdKXxXFO01v4bqvULWNT6TaOp+K/hCgtmxq4MrPhAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU2SqsMj5xP7YYeKSVmX3Kxay8BL1maRjECnNSuk2lA=;
 b=U0JXOKlE96OxR56y+kw5UaxszYN6A8bw9MwtD8V2vpvmMLMtvOJ667Deyf/pXFxnFwfGyfvDE5kdRH0kkMLOuGVxsigFcfr45UYoEWJloAgv0gjHwCnTW91BwqPSaAvGN4P9NEPIiMupUvsk1aKtv0b1rtWpH4I041c8yOt+e76gbGOiKFSLK+vheLJP2neZB44vCJHrPcD2K6PeIMpuyCP70ihEpvzUKg+eQ6XS0qI8VoaG6wV/149GJh2ZoCF9TBlr0L+9en5+QjcZEmmbnI6PE64eqSNh7mXH80mbKZsXzZDRltRhDQ9ns/kcfGGJHfrZHWd+19fEW4NhsjRIUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 22:37:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 22:37:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 15 Nov 2024 17:37:23 -0500
Subject: [PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-iam20380-v2-2-d8d9dc6891f5@nxp.com>
References: <20241115-iam20380-v2-0-d8d9dc6891f5@nxp.com>
In-Reply-To: <20241115-iam20380-v2-0-d8d9dc6891f5@nxp.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731710256; l=5654;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CMmtuhdRuMMh3YhsOTZ5BJ35QqXyp4F+xikGDKq82Rw=;
 b=2mWb6W1YhTMlhzpoD332q0oRLDCVma56oN0R5W/gexegqaQD2fMNdwtVzm5sAi+XTYujD/k1X
 ZSYIdNMMTfFB2IXPMTTxQXW+ohu2fIoll2YOqas/aVMe5TPBMPOBAuQ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8a6445-7441-4ee9-0adb-08dd05c62029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2g4RjF5d0kvMllrck56eEV1dFVhamp0NWx6ZkJvdTBRTk9LU2grUEFwTDlK?=
 =?utf-8?B?bXhzbzJtWXBRdWQyNE1vbG9sb2hOR1pNbHNzVTd2WHcwR2FXN0M2cnZmTk9m?=
 =?utf-8?B?SDQ2S09EdVcyT2NNc2gvWVJMckhSZ01FUElMSzJnZWlROVBNMkJ1UU04eTF0?=
 =?utf-8?B?Q1lGRkY3VlFIcll1bEVpZS8xY1NVT3hTNG5UbjFRdHNUZUpNcW8xRGtablpu?=
 =?utf-8?B?eU40eGVTZ0RtS0x5S2Y0UHhHVDhkVW5iZWJnSEMzNWlRazFaTXJWTGE2d1dP?=
 =?utf-8?B?OXY2d08zclNONEZqeStPMkZVa1dPZlY4eDRqUzdRdGJuU2pTRXE1QzJ4cjZH?=
 =?utf-8?B?UVBqbUo3NEh1U05XYi90cVNCVjVnd3J6RlVkdXZJaWNVdE5uUnlnRy9HMnpK?=
 =?utf-8?B?Y0VlUDJsaGVaVEdQWWdRTCtLTVhGcmt6bXcya01ncU1BVVY2SDZiUnJ4aVZV?=
 =?utf-8?B?UDJoeEZxWlN4ZVRKVTBkS29xVFROWU8vZUZGWkhVZG9oQjJyaFMwc1VjS0lK?=
 =?utf-8?B?RkhPeWo3Skk4OGYwbnRMVTJtS0pibU9nVHRSVk0wZXVKQzFzUVFkMjd5R2tn?=
 =?utf-8?B?ZlB2MHhWdnRXUFJZSFJVZTNJNGF6S1pLc09qTk1tRmxDREF6SU4yb1dSdkVZ?=
 =?utf-8?B?OEJ4dEYwV05wNWp3WmJkQ0RVUUFFdnQzdURtSzJvUmR1WHMycFZPdldaYWxS?=
 =?utf-8?B?akRiYkVoTEswQ1lPOUJ0cDVpYVRlck1BaUpMaitSamtVemN1UlRWTFZhUWcx?=
 =?utf-8?B?bThFNXprMkk0WHVJRDVBRzQ2eVlJQWwvN1FOY1ZkTVlRbFMwRzhCRVNxTFBJ?=
 =?utf-8?B?RURLOVphVi93Ym9BY3piRmh2bHNmV1RSbnViSHd6ajVKaVF0YXhJVEpoOGFH?=
 =?utf-8?B?SDgxQ0J4aFZZeHJUOXR4NnZRcTg0Zm9rUEE0amFZbEJ0ZHl1U0FqSjJHL3c4?=
 =?utf-8?B?cHBGN1RYRkFqdnhPYVFaVVNReXM1TlVzZVMxajFYSVFVcldsTEJYN0pNdC84?=
 =?utf-8?B?bkZGTXg4eXFsYndDSmZPT2c5cUV3Z3RTa1ZSL0FoTnFheHRzM0wvN3JDeUZW?=
 =?utf-8?B?TURiMnZ1OFI4blpubGFZTDlxa0Ztek5NMG51OVhkRHJrcE9RK05jNjZqM1hw?=
 =?utf-8?B?RHI0WFIzUU55aTZwMGRhZERxYXF2N0ZudzVpTHdJdm5QN0NTVjE0OHV4eW03?=
 =?utf-8?B?SUtTVjlsOVlFSDlzYW42N0taeXREUVJKeFBZcnUzTjhYVkJlTjlpN3BOdzgw?=
 =?utf-8?B?MFNrSTlLdTJ5ZGY2RVROUUlVUmFOaUE4K0VZV2N4Z2F6ZEdoWU1Qb3pzcWx5?=
 =?utf-8?B?SVpDQ0RUd2lpNE5pM2diSVlVaFlodDhZajBWZGR6eWlwVThqejRaNld4NFhn?=
 =?utf-8?B?WmlVQm1vcW1jc2k3NGh6akFFbXJCVUk1MHdRb0V3blpsTitRVEJjUFVKbEIr?=
 =?utf-8?B?MkRhWlYyeUJxd1FLajIyVWU1U3JGSE1BelBpZHZ3RkJpYUk0QkJyUGttVW55?=
 =?utf-8?B?QVgrWEt3ZHRMZmE1R2w3TTJLMVlaSDU4dXFVcnM1L1JPUlRjNHRoUVlwdGFK?=
 =?utf-8?B?WnJuRElyYVY2NzJJcTBDRllSSjdPbzlIVkZjRDlaQ3ZtR0REcEhEbDNWeHJR?=
 =?utf-8?B?WTBQQmowRm0xenpydmFXYWtaZHRaRDhLS0s0UnB1WllMR0swWDQ3WjhocXUv?=
 =?utf-8?B?cjM4OW82cmFWTHRpR2xlQTVuK3dkZ3JsOWtBUDdYV3laTTRGNUprV1BmRmhO?=
 =?utf-8?B?OGtRZnBQMmE3aWVDVTJLVzdtNFRZdE1IT09CbEVMYXJTUXJxQmZzUHV0Q2dX?=
 =?utf-8?Q?43hKBcEzmaWpL8tw//F+1kPS5whFAexsb8CgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkRSOUxpN0UzSWNPb3BMYjVwK3VmME9lSDc2ZXVMYU9LempoaDVwSWVXd29U?=
 =?utf-8?B?TUV2WUlTaTduNXpCdkhJMUJVVExxRGROK2NDYVZTcVpjWjhwMG1WakltZVVU?=
 =?utf-8?B?aDd5S0tMd2IxWjVCVWZmaGV5OVpLdlVFck5mSVFVVWhSaFd4WUtTNjVhMzYv?=
 =?utf-8?B?WklhVHFVcGpKd3dPUHBaRU1VUEU1U3BTZXdlZlQrTWx1UWlXYm81M2NxM3Vl?=
 =?utf-8?B?T2sydGJYaGRQamZuUnV3VWRwRW5scXVURXJkcTBMbFdSem5MOXdJS2lyUFlj?=
 =?utf-8?B?WXlLczY4K3g4TVVnNU9FTUgwMU50Rk9EWVhqVy8vTmJCczFHSFk4c3JCeTkx?=
 =?utf-8?B?L0U3S0I3eTF3bkFSU1lGY2pwc2ZPcUdSMS83Y3ZmMUNpZGFoaEZUYlNIZjhW?=
 =?utf-8?B?Mnd5VmdCL0dvdW5ZNXNEcmEybXkyYzBqWVprUE5jVFM0SWtkT09CQXlhbWhV?=
 =?utf-8?B?dVRlYXJuZXJlZElhbFdCSDZ6NU5EL1VtNXBuSlA5VGoxbXczME1CQ1doTDRt?=
 =?utf-8?B?UE5UajJBSldaNmtqNFdtcWdueStVNUtiUGF1UjVDck1FWU52cmI1NTdPc2la?=
 =?utf-8?B?R054SXRBNXg5cjRRdGxzdSt0ajdZOXk3Zk9XMzQvRHJ0NERhR3NxTXdIdVNK?=
 =?utf-8?B?Y09HQS9SWmQ4TkRCQTBudHJXQ0RFUU9BcFJ6K0hUeTlqVlZZZTB6amFVQXZR?=
 =?utf-8?B?MFNXNTFVN2xMRGZ5Q2s0b1hjTnJuOTZZQ1hyQ3paeUprdjhyd2tIaFR5UXl5?=
 =?utf-8?B?alhFQlYrNjN0UXkvWnNLZlc4ZGxlZE9TblA2U1E0Y3paZ244Tld5NFJHUzZO?=
 =?utf-8?B?Q3dlY0dyVC9aU0dzT0ZvWTMvRTNTS1lCNkRwUTZWQlEvT0lUTU5NbXNSNFh5?=
 =?utf-8?B?TG1FT1BvakhjN1RUYkhkUHBPYTVUR0dFRkRuV1RtbXZtZGxWdEloa1ZMNDd5?=
 =?utf-8?B?YWpBOHpIWm9wZzB2SDQranBzUXJjcVh6ZWxkMFZDOXF6MkRBaXJBYU93VEtN?=
 =?utf-8?B?Vk1VUkVzS3dINlR0QXlQTUtERVFmU0s1RzNwS0Mrc3k1Nmo4NlYrYWszTzhx?=
 =?utf-8?B?eGtkenZnVjYyUTltdnNvODM3TDVXc0RKTWp4TFpZSjZ0QUpLOWE0NWp6NmpB?=
 =?utf-8?B?NTlwVHZ2NVRoTEtPNlp6TnlxWnJHVmF2MGZESE9ZdEF6djJrNm1MSEhDS0p0?=
 =?utf-8?B?WklIdmhuck95bklqY2xoaERsMklyVXdRZlA3Vy9MT1hZc0RwZlY1cVhWaW1V?=
 =?utf-8?B?bmJqMThOZlVodW91ZlJEeWc4dk9IVDN6Q2RDVms3NU8rQi9DTm13a2poN05u?=
 =?utf-8?B?UkhpM3NwemZ2RVpqTWRpSVdvb25GVGtxVW9DNkZwMkdxYVRFeFQ2UUNwOWhB?=
 =?utf-8?B?VEhDS1J2Y3o4R2dIbDZITHRmWTBiUEhneHJ2NktIZlBvdXdadUhpbktwcHh3?=
 =?utf-8?B?b2JuRERCRDBmWVRFUTU4YW9GSFZKYWlrMlloMzdIZHg1TnRIMWk1Q3FGbnFj?=
 =?utf-8?B?MGI4WTNabFZaNUlFN3c4MjJ1MmF2dVlMNTR2bkhqWTBlVVp0d1EyWGthR3do?=
 =?utf-8?B?K0FlRlNidGlLSkVBWml3WEZEUWVXS2RZVno5OFpjL3hCY3hFK05zOGtJRFlG?=
 =?utf-8?B?SXRkbWpGTjJhSlhSRDUwZnROeG95YmFITEYzNG41Z01EMThpU0ZYNmNGOVkv?=
 =?utf-8?B?Tjh4ZUpVZkdHOXVZSjYwaHVpT2MyQXBNUlZta1RFZUo4czNvQktCa1F3eXk3?=
 =?utf-8?B?eStUblVYeEZKb095SlJEMlhkV1hmWHFoK3pkVEcvdFRSYzZHajUzWWQ5eHNE?=
 =?utf-8?B?Rnd3VjNUdG9rMmVTY1VSR2UrZ2hpa01uc3lXV3gzSnNSeE9sL0ZWM0pMOHNV?=
 =?utf-8?B?QXpNU1NZL1d4NU4zZVRPTWsxbVlJdzRHR1JNb05adjN3N3RiQWxtWmR5UXNP?=
 =?utf-8?B?eDZwckdHSCs4V1E1YzZ6OFNtODBCZE5QeHptU2FUckNLN1RJUHR2UFlhTTVY?=
 =?utf-8?B?a2o2UjZXWTd4YkpjZ0FBN1RzaEZSZlZ0eDdmSExJVTRYZk5uZjV4UERyTlBm?=
 =?utf-8?B?TVdpa2F6WDRJZzFkdW9Ubjg3WWtxSXlVUmVJOWFldXpiWlpGcW8xK0hUSE9Z?=
 =?utf-8?Q?wcrWDa04XxwX0mn6RfuNLVJiv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8a6445-7441-4ee9-0adb-08dd05c62029
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 22:37:45.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBDhRM5YcKzoQimYB1COWT2kQ/2KoKAfw8gu5+Wou1EP45Xt7V3ud7J62wgMms/yybHS2rW6GTGka8C00P0v8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

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
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  5 +++++
 4 files changed, 38 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 40271352b02cf..a7535cbc214e9 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -277,6 +277,14 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 		.startup_time = {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_STARTUP_TIME},
 	},
+	{	.whoami = INV_IAM20380_WHOAMI_VALUE,
+		.name = "IAM20380",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6500,
+		.fifo_size = 512,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+	},
 	{
 		.whoami = INV_IAM20680_WHOAMI_VALUE,
 		.name = "IAM20680",
@@ -1519,6 +1527,14 @@ static const struct iio_chan_spec inv_mpu6050_channels[] = {
 	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
 };
 
+static const struct iio_chan_spec inv_iam20380_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
+
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
+};
+
 static const struct iio_chan_spec inv_mpu6500_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
 
@@ -1623,6 +1639,10 @@ static const struct iio_chan_spec inv_mpu9250_channels[] = {
 	| BIT(INV_MPU9X50_SCAN_MAGN_Y)		\
 	| BIT(INV_MPU9X50_SCAN_MAGN_Z))
 
+static const unsigned long inv_iam20380_scan_masks[] = {
+	INV_MPU6050_SCAN_MASK_3AXIS_GYRO,
+};
+
 static const unsigned long inv_mpu9x50_scan_masks[] = {
 	/* 3-axis accel */
 	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL,
@@ -2026,6 +2046,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		indio_dev->num_channels = ARRAY_SIZE(inv_mpu9250_channels);
 		indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
 		break;
+	case INV_IAM20380:
+		indio_dev->channels = inv_iam20380_channels;
+		indio_dev->num_channels = ARRAY_SIZE(inv_iam20380_channels);
+		indio_dev->available_scan_masks = inv_iam20380_scan_masks;
+		break;
 	case INV_ICM20600:
 	case INV_ICM20602:
 		indio_dev->channels = inv_mpu6500_channels;
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
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index e6a291fcda958..cd54e9dbf99ce 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -79,6 +79,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"icm20600", INV_ICM20600},
 	{"icm20602", INV_ICM20602},
 	{"icm20690", INV_ICM20690},
+	{"iam20380", INV_IAM20380},
 	{"iam20680", INV_IAM20680},
 	{"iam20680hp", INV_IAM20680HP},
 	{"iam20680ht", INV_IAM20680HT},
@@ -140,6 +141,10 @@ static const struct of_device_id inv_of_match[] = {
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

-- 
2.34.1


