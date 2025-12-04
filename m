Return-Path: <linux-iio+bounces-26722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336AECA2BB8
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 09:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F1113064781
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048632548A;
	Thu,  4 Dec 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="MmzGd7K5"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023109.outbound.protection.outlook.com [40.107.159.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592CA3246F5;
	Thu,  4 Dec 2025 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835290; cv=fail; b=e6UMAKRt1xyPnTKPns6sMurBn9O2IAod+e8N9UyeZlMgT8qnzn8K85TP+a9o/tws+6N6ocxM3E9DyoaUgN9GNbq+2a7RjCS9HUMh0juzVo57lF/w20pXIGoTg7F4EVjbwOATZ5YgSi5+3RUK0dSUZ58LyMWAnRj/zq/XqzMFAxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835290; c=relaxed/simple;
	bh=GSoctgP37SYJXl7fNaUeVCpESa30AMTRWDINUPp7Cxk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DmstaBGDHFnmBNXmRFwSEPTaQ5huHrva0+auKNo1svifQXYHpgbFMOnenzBbx2kl6B82abgeIg9H3W3KAu2iejIj6in41YCX7EmgTznkvKP1RrzPnCp6TYPCUTJ6baH3payNFs0BPZGCNyryPJAtPme6FP5wqLpQieycBMA3LKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=MmzGd7K5; arc=fail smtp.client-ip=40.107.159.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5uWzdNlIE+gZCgz3MNBUtoQUmwtb292SZvJaNfqH1wQQ8+j/GT++pwluuyT8qKgqwJKK+7RfB1uh9UoYvjKHlkMAYw0XqUfvrmm3g//WT7B8M3unnZOj84YVcQNrjWmLwGXCd3MszD2nXLSrVN3BxqHmAtfBpgfYJakObWH/ELX8KhVlVnLmUyJRaLSBWIKP6rJXZVxKbmMwYn8hz5w3yElLpGvTfmo0sVVAnFxehNY0o2BNov8anmvKAaFtgCSF5/SBDRT2AYnimfL9lo51KYY4ixZE/tRym1AFnqwnC5EEXfDHqtV6oXKTrDSpdSsylqqapfPxtD4msi64sPpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0AmTcYhqcrcyzXo9BMETfYqdx5v6MseFUVgrucmW8s=;
 b=Qf10sdZiNrA3PDqtHjAaXQb+ilyk6/4XZFAyTt5YVyZlWL4SiE2YYDODEeVhD15clxcEpX5OcOkG30MyAQc0Bi6CgIyqMGzodh77+FyeZM9bxZqMzjTLNjkjoLK2gP9KBjKwb4JxDJ9ex4mwWO4cB71+Vtin5qqZR545F2AMVWftF39w75bTAmGtKrfkhCdEdvVp+IvS/UyjaLvvYi52hLIQ0evEUV7G4LQoD6xGdcdCpmgRF8PiBRPm9IL1IBbafyQReDpLIelGUeKnlVXKpyFgU7GUVGWbzxyHZaNuj/5QO+9umnFD6ZQ0TUeRX472RAEy9WPA9YBBfN6hT8AU7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0AmTcYhqcrcyzXo9BMETfYqdx5v6MseFUVgrucmW8s=;
 b=MmzGd7K5oryyYWFb7+kP1IXEyY9qWkLc2imOt1alFTneCqJShi0omg3soCY0bAghd7e/wOW/4VkpH0QrmDPD5ti9SVYZluQJUjx4CLa+YYaL7hbXFSp+YYv080cr7d25K/LNAYD7QepM4S5MHAsDdR/BnUf4o0GFnVgz+DYW6Es7beJYijTtFqGMdM7Tq+d8IDl/LaEYaiJLic9gAuMWVtZlZcCFjekPLThae+m0uTXIBDOajiM05aGmPnVTtFAVRX5DsO0qfnpmCsJaf1+vqILQNm57q/Ap/JCEWzRJL7IWHmt6V51OOdR+ai9IYii4aMb+JPU5ptbXsKjPN3UzuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VE1PR06MB7024.eurprd06.prod.outlook.com (2603:10a6:800:1a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 08:01:17 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 08:01:17 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v2 0/2] iio: adc: ad9467: add support for ad9211
Date: Thu, 04 Dec 2025 08:01:02 +0000
Message-Id: <20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8/MWkC/22MQQ7CIBBFr9LMWgxDRYor72G6IDC1k2hpwBBNw
 93Frl38xfvJextkSkwZLt0GiQpnjksDdejAz265k+DQGJRUGpXshQuhzSpEMVgTvO31CQcNTVg
 TTfzeY7ex8cz5FdNnbxf8vX8zBYUUaCRZQ+cwIV6L4+we7ujjE8Za6xdltqCipgAAAA==
X-Change-ID: 20251203-add-ad9211-897dc9354185
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764835276; l=1234;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=GSoctgP37SYJXl7fNaUeVCpESa30AMTRWDINUPp7Cxk=;
 b=dr6ztSRVKIn+8T2xivDT2BjQ79llZcJOuMO4RUbC4sa5ZhfpZagIwNAG8dypXs6uTjND9zS2+
 o6cmB18z7s5CBQAiEE3AQIPrRGSsAp4DjE26CQahZY1HbVa4vmkwbWs
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV2PEPF00003857.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:17) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VE1PR06MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 4188edbb-ea22-4c76-a248-08de330b4d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEs1NnlrbDRSbENhV01aMmdWNU44cDNvdUxQTEM0MGgyYnhxckZlSCtBeFBO?=
 =?utf-8?B?Qm5CdnlDQ21kZTE3anlRdlVsOXVKQUNUcE5GYUpxaVRhZWNwcTNmNjN6QitB?=
 =?utf-8?B?c29abHRGdWhlQTBQR1poRElYVXphcTBYVUJuZ2VFOEtwaURxN0szVkoxeWg2?=
 =?utf-8?B?eEg2akViU1dZclJOSEhZQUpxNGJoTHpyVWNDT1BlcEl0UFlmTm82eHZWSFNk?=
 =?utf-8?B?QTdDYmxaWXRqdFQ3VmU5LzM4NVBEcFFXVGZVaWFabUs4OUNreXdpSGZXb0NL?=
 =?utf-8?B?TmN2T3MrZ1VQdUVMVnp5Sit4VFZyVVpwcXpuZUhFSUl1MVFhUEYzcCtvYVI5?=
 =?utf-8?B?VER2RndtdUJFY0pnOHZlYkY4d2RFLzl4V2tpSVNjRDUrWVVoK1k3RWhyZHBV?=
 =?utf-8?B?RW14bDAzRGF5b0tsSVliMTUxUGp2Y2dwS09icWdvOG0vaUJNbytrZDBuK2ZV?=
 =?utf-8?B?SHlESjJQc1hyS1pETXNkWGJwMHZmRlgwZUFMQmdqK3loME5PSFJkZjJtNHFM?=
 =?utf-8?B?cGRIZHN4M1pMZmZaMjlGemNIU2JNRnh1Q1BLT2pZcS9sdXN5d1U1K3hLQXN3?=
 =?utf-8?B?dW1XdXhhT2VqK21wYUVJQ3pWYVFDYkhwMnZkd2h6Z2lua1hYWSszQUg3RzhG?=
 =?utf-8?B?MTQ2ZHpWaEZ3MWJrYmRjWjFqcGtZUlVzOW54NHdWK3gremlTKzNJclUyd2Ru?=
 =?utf-8?B?K3M3WVNlY3BCeWg3MDR3aGZoMjcya3pFcTZRQ203cnBQcm9aU1RsdnNNNkky?=
 =?utf-8?B?OWlwNmQ3QWpyTWpFYzJ3cmJYazVLb1dTK0lqeDRodkdoV2trQjJuNVJvaVVZ?=
 =?utf-8?B?bi9naHFhc04wdXVWSUVhTVQ3cUVxYjdGVDg0djdhd3V2MlIxd1BCZHNZbTBh?=
 =?utf-8?B?U0F4R3FlbXZPeVNxRURMKzl0bEI2RjF3SHBrT2xLVi9jczFyUDlreDhVM2FF?=
 =?utf-8?B?bGxmQU1jM2ZnU245Nm5MT084ZTE0ZGliQUlNOE5vVUx1M3FxM29BdGlVQUc4?=
 =?utf-8?B?ZytaTHZnWWNSZXlaZTVqTWlsYk1UZjEyWnhmVldDOTZyTU1mM0RSVi9HbTBL?=
 =?utf-8?B?VUU4Tm5tdGV6dnhYMmU3RnFwb0t6Q3JLS0ExeXZsalFMaEl5blFLZmxWMWxO?=
 =?utf-8?B?TGU0c0xmZmt1QkpFL1dRRHk3OGd2MHRndFB6VW5UVUhsYnRaU1VicW12Znl6?=
 =?utf-8?B?TDVQSVdRcHh5ZTJpb1hrYVJSTmhyT3BqOFFVbzUvNFlPUHlsZ2puUWY0QXBJ?=
 =?utf-8?B?ejM2MG9VT3N5MHVrUlZQMjFqNjJRM1NndXpkSDdPRXI5TkRmZXkyQ0xTelpG?=
 =?utf-8?B?aTUrZE5HUFVsWEhPWWNTaGdUbFVjQngvMUZoNEJaVUdkblc0dCtzRThNNzJZ?=
 =?utf-8?B?eFVCSlBxWTVkcHg4M01DS2t1RlBFcHFrTDFFQURPZ3prb2FuRmlaN2Y5YnlO?=
 =?utf-8?B?a1gvYVBObVZHY1RHMDJpSEhvMU93Y2hjUHFxd0thZjZycEhzNDkzR1NYc09C?=
 =?utf-8?B?UXVoWEVyVkVsT1pvM3p4RERaY00rYWd3dVJoNkFSbVNBZmgrWk1oL0tpVHZ4?=
 =?utf-8?B?L2pibE5xOUhGaDZYUjh4TWpueGlVUVoyQkRwbmRqL1M3SkplYXptZ3BFRGs2?=
 =?utf-8?B?cmZ5K1lxcEJLRWdiR2NkamNENC83RlVXcGh5Q3loWVdiUjhOdFJkOXQ1SFcw?=
 =?utf-8?B?M1NMWDRsMXdPK1FwTGg3VVRiY3RuMEd6RFY5cFhKU2RDY0JiVFlsc1IyNmEx?=
 =?utf-8?B?Z3A4anhuS29NbG9rS0VRSisrVXZ3Um9YNXY2d2NyUEs2ZGRGWktNalJPNzRB?=
 =?utf-8?B?a2tacDR5R0hESXpsUDgwSmpnbENnSU8vdjUwUVZoby9EQThCTWlOaGhLOXdh?=
 =?utf-8?B?ZFdKRldJNjlvbEdVTlQyZHQ3TVpLZ0RIMnUvVTczbVB6eEdTQlVESWpkQ0hv?=
 =?utf-8?B?dHhjeTNPVU5VSFpFL0tMTUhqZ3lxMnFYVnJnYVRCUC9MaFVZdEhyUEJZcmJ0?=
 =?utf-8?B?N0xua2YzNzhYK0lmVXZrblNBOVB2S1lIQXhKYlB2TmVqMjdlcmdSNUMzMnZM?=
 =?utf-8?Q?oWZ4rx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWFqSXlSQVJjUWJOYkdraGpzaitaY2haR2dkRlRCRnJ0ZkVlOGhBOUwweFgz?=
 =?utf-8?B?TVBhRGFsUk5Jb1Znc3lQNFgyVEZxYWR3OWNLVXJDTEhRLzh6Q253OUFBWWhr?=
 =?utf-8?B?Mk9FRFA1ZkI3Y1BpNXRaSDM1WjJmRms5SEJpNy9GV3BaRnJGODlSb25qRDhy?=
 =?utf-8?B?NlR3ejdPdlpQTjBscXdsbGVNWXVyMlBIajBKRnY4eVBrcjhQUUEyMEk1OVRn?=
 =?utf-8?B?U0FDSzhiV0x3aWxJM0JtVGJBZ3Q4SkpaMTdYZGtnK29pc3RVclpqSkdTUUs1?=
 =?utf-8?B?azYzOFRKajNWQTRBSDdrT1hCUmM1eVpXdlpBcTFFT2tIRnVvcjhhZHJLODgw?=
 =?utf-8?B?aEVLdHQ3VWFuQzh6djg3akdZZklUNS95bEtaSmtCV0krSTZMMFlCRDVDVlpB?=
 =?utf-8?B?THovK3EwV1c1NVQwaXhJUExkaitWVVRmMHJ4MjhkaXF2bFNteGYvV3hDQTUw?=
 =?utf-8?B?NklyZnk4WnRwdVFvYjV5OEdWa1J2bHN4cmx5Vm5QSkVaMkxNazZMaU5MZEdq?=
 =?utf-8?B?ZUd2NEVHQ0pjUGh4YXhNSzhQK0NzY0xod0VKOWpGOG8vMWVMOUJHaHRKbzZr?=
 =?utf-8?B?VThaQ1F5VkJIS0loWUZXRjk3M2hjdGlvRCtkcy9wM2N2akpUcytzMVZ6L2F3?=
 =?utf-8?B?NmhDTEFXbG1VTEMwR2hBWGNlWFRXTldLb2Qza2xaMC9NY2tzbGQ0Qm41Sm92?=
 =?utf-8?B?L0lZWnZPQTYvRG5oWk9FeWpBR21Lb2pRMWdVQzhKR1l2a2w2eGF6RGxNcExG?=
 =?utf-8?B?VGptWitTcTZNRWlPaGQwTmMyaXZYMnlDcGJSZ201U205WEpvZzlvUzJYUDk5?=
 =?utf-8?B?cENxNVJnd3RWNzJCRDVIUGRHQVNvNlh4QW1IMDE2anUzU0dIbmYxdTRIdnkz?=
 =?utf-8?B?dHo4d1p2a3ZPV0pYdmN0eUpydStMMHNEblRFREUvRG5VSkxtYnBCcnBXOStN?=
 =?utf-8?B?U2JqdDlpN0Juc3EvNjNQWUxoNHA4NC9zT3VhNVZPWmJ4R0NRVm1HaFQ0YldD?=
 =?utf-8?B?VFFqbGRUK1R6bExIUzJOYVVWSHNEQTUrZDVaYVRzRTM5MXNFSEtGWWk4MDVL?=
 =?utf-8?B?NDFxdlkyc1BMRUNoTE5CYWpwdkFsaVppT0V5QS9OQXMreVdKQmhCczltUERE?=
 =?utf-8?B?b3oyLzdLT1NZeFVlWmZBMnowOUI5V0RqdEtTaEpMWG5wSi91SjA1NGdrOHln?=
 =?utf-8?B?a0ZSbDZQMmxMb1E2QlZjMmQwUU5aY0RKaVkxd1VVc2xEcWxKdnNJTHN6T3NR?=
 =?utf-8?B?bnJXbkV0QnYxMTAvdmdOUUQwZlZWMVVQYUx6c0tMYVA3NjFTRW9mMnNQNmRS?=
 =?utf-8?B?Q3p2MmF4OWFDb3ZNQ3NKZFJJcE1CbnJsTi9GMjZRa3E0TlppVHBNZll0MGdD?=
 =?utf-8?B?UXRVdWdSM0E4RTg2RTNrM1VldHp6Q1lhNDhyOHBkd25wYS94OWVxMkxFOGRr?=
 =?utf-8?B?RWw1ejB4bmcxejR6M1NDeXVyNytVNmdLLzFBNDFMalBUSmc0YTZYVnFYUXVG?=
 =?utf-8?B?ajlzT2c5dGV4NGxhRWZFVS80UDhqS0NvY1NYK0F4bk15R2FoRUFYaGFiVEZV?=
 =?utf-8?B?YlZJd2ZidC9ONGpmbUJPeUMzU3pxMlRmNkZQcUErUHdMTXAxQ0JZcU42S1p5?=
 =?utf-8?B?QWN1UW9JTjFQaFovU1l1akYvdkpQamRMNjF6Um94d2hERDJJdkdNUDBJc0Zk?=
 =?utf-8?B?dmVxV0lIN0pENEVsZHBUNmxRNnlPWkNNMmJPUGR1enZNVnRULzAvMkxjd24y?=
 =?utf-8?B?TVlYeStMa1pFZFJOY3RUdGZzZGRtL253bWdvVlpuZHhCWGtudmZwQ1QyUXZs?=
 =?utf-8?B?M2U5dm9IODVoUTE1YTBFZjR4Y2JHVzZjek1sRzVsSGtmY1F0WS81MjNzL1Ur?=
 =?utf-8?B?OEEwZ1hFT2FxalBnVWl4RjlDeS96dE1VQ21tLy9lMXhzYXBTOUc4UDVTenlz?=
 =?utf-8?B?ZHFSNGFmbHpsY2gyQ241YXpjU0FHNjdrdVBLK1FBRHNoOFpVMDFwM2NtcExv?=
 =?utf-8?B?Mmlxb21ZczNqWHpEWTR3WTh2cHdzMzZRWVg4ZHBtQy9oT3NmK3FJaXRXTVdN?=
 =?utf-8?B?T1ZNU3NJWk9tNWpsWW5xQ1N5a2xyNkg2Q2treVZlKzR3TGJrKzdpTUVJUWRE?=
 =?utf-8?B?VGo4WUNTd0ExL0xqS09UazhDLytPNjZGL1hvVkYzUTJ2OTBabk9sMTNHTTN2?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4188edbb-ea22-4c76-a248-08de330b4d74
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 08:01:17.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGuBQCykVu7cznsr65Oqx2aORpdatnfZkW4LaZ8+ncNDHPCORk5Idh3fDH4ygoYywfV6ZhNTsZ8uWwQQ6VQ01Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7024

This series adds support for the ad9211, a variant of the already
supported devices.

Example usage:

$ cat name 
ad9211
$ cat in_voltage_scale_available 
0.957031 0.976562 0.996093 1.015625 1.035156 1.054687 1.074218
1.093750 1.113281 1.132812 1.152343 1.162109 1.171875 1.181640
1.191406 1.201171 1.220703 1.240234 1.259765 1.279296 1.298828
1.318359 1.337890 1.357421 1.376953 1.396484 1.416015 1.425781
1.435546 1.445312 1.455078 1.464843

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v2:
- Use HZ_PER_MHZ
- Update commit message texts.
- Link to v1: https://lore.kernel.org/r/20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com

---
Tomas Melin (2):
      dt-bindings: adc: ad9467: add support for ad9211
      iio: adc: ad9467: add support for ad9211

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |  2 +
 drivers/iio/adc/ad9467.c                           | 43 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251203-add-ad9211-897dc9354185

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>


