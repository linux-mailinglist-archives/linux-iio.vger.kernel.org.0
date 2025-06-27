Return-Path: <linux-iio+bounces-21000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395A6AEBD05
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC0916E4E4
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 16:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F81C1741;
	Fri, 27 Jun 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="nmWQ68w5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7CB1A9B3D;
	Fri, 27 Jun 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041282; cv=fail; b=Md7WIAnqJSPRUkVAP6F0mxKE3OiqsqcBOHpKs4LX2Q5B/RdS3ie1fpoDSNf0QUYZxZOVyvHndo2uWPylolu81iRBQxw5K4tv2clm5hWLB+ANUf6Mb1semlOqNm15h0hMotgPk45V6r5Wg7yYoR8vu/kn7mm+W0UTIxWNs4aji5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041282; c=relaxed/simple;
	bh=NyItOHb2HehSaIMZ8yRkK2vWSRNxLPsCswMhy1bcJfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NAZ2i4aek94XWZ/CX6EYcHT7u8WpcFx4qfwmGVXni1hn2XGEHbwcPqA/1SoDStU8nkH5fuU0mhu7j+t3dbrwcYQFHg+tsIi9Y8ixUiCmRiOg5S4S/W/wZE+roMcaoDAz3U3sGxOtcOwM4+zJ686zJA2s3ZYjOHs/ZdbePciiknI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=nmWQ68w5; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55REcuBS016881;
	Fri, 27 Jun 2025 15:27:10 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010028.outbound.protection.outlook.com [52.101.169.28])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47h94hrv0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 15:27:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcLqtnHpWwY1OCHD4tCfDkrxPlOLd/tT5/WkOVNmEat6FaEOdiLIt2D4CQM326CxwryUSbx2NsP1djiNjQvdiuZGD1MKYFk6lWGyN+wgg3CiMQuPUTyuPoKnGOQs1C1lf+i1K+5qEN/v8szPJe58NhtVx0Ub6ul8JERM2gkKsHJSo/hotsm+xIboEVH/r/bhfKqyFnejhivcLU3Mx6Lx2l+gY7F+AaUlp5mmutFKhXAEDGN8o97GKT7XWK9q9aYgGupJZd/QvbsvmvM/BBvBKS3oQZ5vWW/4WDoed6iX4zJNLobGnkyavH9gOgYI5r4652IAJbhYTLV2OHooPucMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyItOHb2HehSaIMZ8yRkK2vWSRNxLPsCswMhy1bcJfc=;
 b=EIIr4NxRrpQj+l7Bnb8wLWe4/aIyRhtn5OWXygmtrF30iUs5eBjBu7ch5J8ixLMmDdOlxbjETKYvj7j5Ku2D7ptJlZSIeY6A4/YPlh7qlfig+rA9lGUCOl1qeKyqQXglE8ewhL0CfSKrr2bnOdTCOMcAoj6T4ZAtF9tPewT+9KWsESTS1z/NLlJUNU/bGvWhMCUnaJ/TynPevMerHn8Vx+xJkSZAgirQVXvAEhU5Apl2IE7zPI2T+IXpXnioGfdE5DOM95jTaXj/+NwIqfXTQG35BN61dlnevFt8xj08Isi5Z0sm8bO3Hz6oOXtQsSjtSbUO9eRGiUHSw7QqfqRuug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyItOHb2HehSaIMZ8yRkK2vWSRNxLPsCswMhy1bcJfc=;
 b=nmWQ68w56pPgOite0egljqMYyoc/TYm3iuAmNZLCCUmkGuoKQSYmm4Xipl9ecvGiAHMoWhAymzXpMyyDUNwJDUjK1KuJFI56HE08xEplgSn/wj/aR12nbp1Qe90sX/LkuAQ4+hhzQrfheYqZG8kiKZ/FL7lcQlgGg8G0OZoqZ6frQDpBdDpg0ECX/ip8VrAp2TkR2tLcMID+nzW7Hv9BMMIemG4ZjmtYrFnVHo/6+KpTFh91iwEhfdnL470NdzNICeGUPRozLGuSMIyAfq0sYbtEOUdVv62dyiNausDooG5gTJ0GZROCdzyD7y2Z+D0inP7/kdn0ErIwoMzIUN3Uyg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB0266.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Fri, 27 Jun
 2025 15:27:04 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 15:27:03 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] iio: imu: inv_icm42600: move structure DMA buffers
 at the end
Thread-Topic: [PATCH v5 1/3] iio: imu: inv_icm42600: move structure DMA
 buffers at the end
Thread-Index: AQHb5D4xIaA8BNRtnkaK0s1ff0xtPbQRT6yAgACsDjaAA9GkAIABV1q8
Date: Fri, 27 Jun 2025 15:27:03 +0000
Message-ID:
 <FR3P281MB175744F24BDD93870BB32ED0CE45A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
	<20250623-losd-3-inv-icm42600-add-wom-support-v5-1-4b3b33e028fe@tdk.com>
	<CAMknhBEpkWrZdWSrhQS6E1GnENCipf+LxNNSNUyZrm8Gme2f_Q@mail.gmail.com>
	<FR3P281MB175703F651131703019D7295CE78A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <20250626194838.55c5eca4@jic23-huawei>
In-Reply-To: <20250626194838.55c5eca4@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB0266:EE_
x-ms-office365-filtering-correlation-id: 0ca0b518-6347-49af-98b8-08ddb58f11bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjQxeHByUzFCb1o4TlFlYTBFUkIvYjAzWHFkQ21KMnVFN0orYS9LZkkzNlhN?=
 =?utf-8?B?d0o5Wm83NEhkOFQ4S3N1UlVtN1Ivd1FaMFJaQ0owZTZFUGlITkVmdVBrRmpM?=
 =?utf-8?B?d3kzbXoxQXZDY05oa25zcDEvSE9ZN2J0WFdlYVZYVmZlTXR4ankyZ1gyTVJO?=
 =?utf-8?B?bDBYQm1IMjZPN0xRbGRnaU1XM0NFNE1TRktCT3BnMFpIYTFBNzA1TmxyaWZs?=
 =?utf-8?B?eXh1cllGNTdwdlVPU2RFYnRGUHNDeTh0K1gzaTArbU50ZHlxZWVqcGlxMnZ6?=
 =?utf-8?B?dElWYlBMQ1VVWmMyMjJYTHlLZFd1Q25JckdWcDkrNTQxRDBwdk1QblVoeDJm?=
 =?utf-8?B?L1JJRVZNUW92YTIzVHJxdGZLSkpSOWltR0xZVVd3b09rOGNJbDNXRThGNkRX?=
 =?utf-8?B?Ylp3aGhwL1BjdGJla1J2WjFIUExlditMenZ4aWhXR0N3cUtHclFndkZMV2JE?=
 =?utf-8?B?T29WdWdvdnh1bjVUMitYY1FWOHRMS0kwYXRSVlpOdm81L1p3bms0MnFZY1pJ?=
 =?utf-8?B?Ni9wa3RCODhTeTBiSmJoNVp4d2ZUYTdzU1VITERJajVxSlE4bVgzRk42RHgx?=
 =?utf-8?B?Y05pUk9mUHk0QUpiWE5qMXRFcUJVUmpmUkp2alNnMHB1WlNBN3ErbzliNW9T?=
 =?utf-8?B?allRMU5TeE0yYXhVUVBsUndWVGV6bkRrVXdvN1hGSVJKNTU3VXdlRE5Oc0M0?=
 =?utf-8?B?QU85NEpqWEhLTTk3dFBhaXE0L2VVajFFeUdFVWUwZkpETWYrVEljQkk0MVht?=
 =?utf-8?B?blloOHhqMnYyUXlybU8zTWJOTk9kSFpVZ3dpNUdXRDJVQUE2T3c3aUtINGgx?=
 =?utf-8?B?c3hDR3VSL2J6djhKVGVDaWtlcVZFbThYTG1kZ1NTRVI4cW9LZlpQdjB2TWxv?=
 =?utf-8?B?UjMvVTBiQ0xsRzBLTEFxZ3Evd0ZyUHV2SXhHWk1temFhN01SRWNxWXU0YTU1?=
 =?utf-8?B?RVZIWDkwUU5CMHBFY2lVUEdpa3hMcTZJWCs0MGJNM2t1Q3ZubU1HcTBVdWNL?=
 =?utf-8?B?eEpKZEdrMWd5TDk5UEdpbkNtTkQ5Umt6anl6cmVDeWFoMXVsbWd5S3Izd3p2?=
 =?utf-8?B?RWlqdllKb09adXRjS2YvYmorWk10QUxHalQ0NFRIemJSL1dhQ1dSRXdFVFF1?=
 =?utf-8?B?elY5eGNGZUsrYmhlZ2ZaWjEzM3MyREtCbURkUEtzV24wMWNwUGRrYWE1ZEJN?=
 =?utf-8?B?ZEcrS3VGT3pNZlFPdXAvMEcwSCtSb2lzUE5sYTNqcTNJbzhYeVpQeFdUVW9Q?=
 =?utf-8?B?elFsZkIvN1Q4V1VBZDFaUGFORDZPN3RVK0Flc2ZRNWU0Yi9ZSVMzQlQya2Zs?=
 =?utf-8?B?TlU3bnR0YXFteWhRdDBsQ3FhaUEyOVRUdXV6ZVpJZWNlYTBjQU5nVHE0eklL?=
 =?utf-8?B?TUxBVW1EN1Z0SW5VUVN3aHJpblM5eEgvSElUaTkzTDVGaHNzMzJDYU5tNHF1?=
 =?utf-8?B?VDdyYWlPZm1pTmRNNk1tT0l2Mk9ZNlY1SWs0Umxob1R6c0tuN0dYWkNzQndG?=
 =?utf-8?B?NGg1NWZUNnhPTS9wME5kQTdTYW9WK01PeWVqUzVDRkRUSGNqVE85aTc2YVZr?=
 =?utf-8?B?aVBoYitjdS9qRllJclkvcWVrN2FwbmcxTnFsN1NKSHoxTk9KWmRJQUxYTlpx?=
 =?utf-8?B?MHpULzI3OWI0c1N6RWhvLzZlOE5ON0ZtV0hHNkcxT0d2eVlFczIwa2N4Q3dl?=
 =?utf-8?B?TVFKMXFhYncyWncveDR6Mm81SkIzRDRjSFpwMGZwcExtd2gxbW01TnVlWklT?=
 =?utf-8?B?OXltSXVTTVhNSFBYNlNlc014UVRYWVgybGJYdmtzRmdJVWN6QWw0cHJQckg1?=
 =?utf-8?B?NllFQ0pOaW9nek9FYlIrYVNDSnlZbGxBUzNDWEdXblF5RHlXdk1hZ0M4TGkr?=
 =?utf-8?B?cUN1a1VFZzNOSXNtS09GeDkvdXdxem94bUYyQk1lcGdaS1lmTUtMQ3M3SEVa?=
 =?utf-8?B?L3NGQzBqT3gycUo5VzZDTytHQUdFRFVzNVdWTktBOEd1ZGRQbVRZQVE2em9K?=
 =?utf-8?B?ak54dVNxNlN2Y3Z4VHlPcUxUdlJRWlVLTEJwSVJERE5WRlZ3aGhqVHQ5MGdI?=
 =?utf-8?Q?Ca3YnY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzZWT016VVJWMFZ5WXlnUXZPS2RjNEF0NnNXV2hVL2FUUC9kT1pSNnlXTTh0?=
 =?utf-8?B?YitsQWorcUcxQndQbUtKV0dma3lkWFh6TUZqdmp3alNLV25xL1JLd1NEV0pD?=
 =?utf-8?B?VU5nSVlKMjZtTUt6eXd4REc3Rnh4R2dSMFFuK2tGbGJNTWlWaWFKekQ1OTdj?=
 =?utf-8?B?REQ2dWJIZVhkSFZKTk1iSGt3dzcvM0VVaGxZeXZTQ29hbTFyMmh5eTZ4amxs?=
 =?utf-8?B?N201dHVMQ3FZbldNbzdxUzJjTkNvS1NyNlN4TW1NeHBvV2tXZVRjNFFQcHli?=
 =?utf-8?B?ZWttdHQzV21kRVFlZG1DUHFCSHRwOURSZ0hQWm9aUFJOTVF6dmY5TXJXYktZ?=
 =?utf-8?B?TnYvbk5ZSnlpNnVCaVpia2VTVUlSV1czNCtwa3JYQnR4SnRwS2o3eFFzRlJ2?=
 =?utf-8?B?MEQwdUpuSG5aaytnc3BFaXlBT01XakhaczR2d0gxL1V0TUkwc2xNRVdJYm1F?=
 =?utf-8?B?d0JjM3Bnd3dqUDdFMEtrMlEyank0bGZUTHI2MHZpL3NhZWhvQXpTZlVEZGJn?=
 =?utf-8?B?VElKejVTR09RMGlQYXZwUGVwRjNBTzBvUXlyV0xtb21ZZTJwZWhiN2Rmd0NH?=
 =?utf-8?B?TnhHM01Jd3VsbzI5T1h0c3Y1Y2RldXFRWHNQbkpzTVVSbmtqeTYvSlg4SWZT?=
 =?utf-8?B?dGNqeDBBa1Z3R01FamxGbVRmQmIrSDZRVHpwS3RXWEFHd0daRjlXOXRjcndX?=
 =?utf-8?B?dFNZL0tDY2diODBDMS9ZMmpYUmhDM3VRazFwTmU5cm4ydFNHVVU0K0hBOVYr?=
 =?utf-8?B?Q245Vnc0T2VSejU3ZE95cGZ5c05EU0FzUkEvSjVKUTAzRExmWUpyNGNyNFVw?=
 =?utf-8?B?MndJODBXM1pjQTBacStuTnpnZnNxKytxSE4xWHo2bTBsSnkrbGhsZ3NRN0Ur?=
 =?utf-8?B?Qk9GQ1U1WjVNNVJ6a1BNbmFOQXF0VlZEbTdEYUJVU3dsbFRlR3hJS2ZXTjRU?=
 =?utf-8?B?ZU5KbUc5c0UzYU1uY052bEtlRmNER0s5Mm4ybDZUVks4bHRoV05oL2krbEVx?=
 =?utf-8?B?Sk55VVhUNHBMWkF4blQ4MU45a2hjN2YySzhZU2xFa1hKR1hocW5KSVJKSGRR?=
 =?utf-8?B?TkJWak0yYWlIZ2FJNWpYZ211bFNhbXZVVFR0NzY2QzR4aFQyOGQxVVBEMXFj?=
 =?utf-8?B?M000UXRJcVFvQmNVSTVBRXArMGZzTGE2QjIvekc4QUhXdENVTUtnYU5FcHdE?=
 =?utf-8?B?d1dKOG5ZV0htQXhxS1YxQnp0SW4xb1ZGclJHTHNaWWRZa3pGUWtTVDE1RVVm?=
 =?utf-8?B?T2NVVmtEbm4wMUhzSWdpRnBqMWJCL21UdEZLMHpkQTlJTUVkbjVRYkZQMVBL?=
 =?utf-8?B?YSttdlJqb0ZRaUFldVdDY2d5K0J0U2xoZVVCeU1aT1Fqa0doaHRYaW5HNlVM?=
 =?utf-8?B?SkRwR2J1MTJOY0RtbTh1ZHlwUE5NVG85U094RUFwcVhiRmxYc0dpZTZlRFdH?=
 =?utf-8?B?NFRRc1dKWFlqTUhXRkdZV2R5TlRNem83SUVOQjFCaTdYWm5PWEJGbUhVQ3pW?=
 =?utf-8?B?aTdRTmZkdWVvQmpIVTN6ekZabU9RSTVCRDZmUm95V1V5ejNvNmRpN1k0c3la?=
 =?utf-8?B?NGE3dlVBR1dPeVRYK2M0MEZ0ZitxZnVRV09zVWlxK0VCWFA4THJzSWQzc3Nm?=
 =?utf-8?B?aWVBZGc4djNtRGV6THJFSXQ3SDd2aW8vWG96VDJtSGNqTDNnRzg3cEVqZ1Ir?=
 =?utf-8?B?RE5vaGdhUGdZV1dqMmlOVktmSWRlck10dnlpK2hlbTF1RTY1enpycklWNHQ3?=
 =?utf-8?B?SHlTRFowN0JnOW5QKzg3TWdxSmJWamVKK3ZqK2hDNFppRCtyQWZsU09jNEE1?=
 =?utf-8?B?UE9oVzV3eUM4azEzTDNxQ21LOFo4MEc5NEFoaHlScDFIblJkb1hOdE02Rlp5?=
 =?utf-8?B?WXhPZGpaYk05L2ZQTG9BYXo3aUkrN0lkOWg5bjVlUEtXakNocFcvTm9qVUtx?=
 =?utf-8?B?U0FOT3FndFliZytTbnhGSjhKdW1mR0F1T3UyWXNFUFdnRll6NkFMTkljUWZS?=
 =?utf-8?B?R3ZlaHFKRGdNai8xYnpOTHNSWjVLVk4vd3E1Wm1OTHAvc0wxNnowSGNZby9Z?=
 =?utf-8?B?d2dGTDhJVXU5cHVCS0FFS0ZQY3JWLzJZL1ZhbWF5MUV1US8yUkFtWHBDd2Zl?=
 =?utf-8?B?QWwyMm5YU29QcW9LUGVRZDRTV2xJMWVyb3UwcXNrT2FsL1RybndMNWJzRTNF?=
 =?utf-8?B?YVQ3NUVuTE8xdWlmYVZxUStqN2FtS1pnd1VJMHRHc0d2YWhWazZ6akZ1N0VI?=
 =?utf-8?B?UU5OZ2Q2RHJkS2hGRTlZaEpLNEhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca0b518-6347-49af-98b8-08ddb58f11bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 15:27:03.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJ5aaHqPgQ0EaaFroUZ25ikFbZddrAASiDKBcGjKM0cnMApgidBwqQ2pjuiwZFmlF2bycw/PWp2NuhNmgf9WcrvQf5Sfy/ZGXF/uNwwUAAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0266
X-Authority-Analysis: v=2.4 cv=Qvde3Uyd c=1 sm=1 tr=0 ts=685eb84d cx=c_pps
 a=iNhj4pivxDa0F4Kb9nHthA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=5oJRwxC-VJ8zwEdryuYA:9 a=QEXdDO2ut3YA:10 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: Rx5H7dxf3TCh-qtxYNlmtlBag1B0EF5f
X-Proofpoint-GUID: Rx5H7dxf3TCh-qtxYNlmtlBag1B0EF5f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyNSBTYWx0ZWRfXypcgGZJRZrFD
 Kdw84ccPtgvilfIG6DLZ37TBkEC4JYruiuSMxwUQzBw1u9mxR2rYcftf25V5wrnWC/xKpc85a2G
 vb1gmwFZ3XN71uJstIk8QPA3FtJp6vPUGFEcWF9RLPFz9VkRECh3gmd8rxUnmRp8CBZ67+STaN8
 bKyvd9+3rdEf9EF/AwLLrYHXwInFrR91da7A1QqR0TsSpAeL1XnAoNqdeNEzxgNHwyc4yuqTnjN
 2ujL1c0AkliG4ln5FXRVdQxsfGQBYV7c5Ry02gZ9LS/wz8XhzW79RA27HWYoajLjtNGrWRtD+Oo
 TnadN8DGlv/yjiioeMqA3BGdiRKwIuxcfVNIdpy1ggiJrfB7jNdbQRlOABNg8MC9sHBR02UvNDD
 0Bu1+WDrYnfaSqpnkbhnAD3fWxdjvbuYY1TKmYsr6GOk7f++eBf2aJ3Z8382r+FTOVhDK3mD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270125

Pgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+RnJvbTrCoEpvbmF0
aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+Cj5TZW50OsKgVGh1cnNkYXksIEp1bmUgMjYs
IDIwMjUgMjA6NDgKPlRvOsKgSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8SmVhbi1CYXB0aXN0ZS5N
YW5leXJvbEB0ZGsuY29tPgo+Q2M6wqBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5j
b20+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IE51bm8gU8OhIDxudW5v
LnNhQGFuYWxvZy5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47IGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPgo+U3Vi
amVjdDrCoFJlOiBbUEFUQ0ggdjUgMS8zXSBpaW86IGltdTogaW52X2ljbTQyNjAwOiBtb3ZlIHN0
cnVjdHVyZSBETUEgYnVmZmVycyBhdCB0aGUgZW5kCj7CoAo+VGhpcyBNZXNzYWdlIElzIEZyb20g
YW4gRXh0ZXJuYWwgU2VuZGVyCj5UaGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBv
cmdhbml6YXRpb24uCj7CoAo+T24gVHVlLCAyNCBKdW4gMjAyNSAwODo0MzozNyArMDAwMAo+SmVh
bi1CYXB0aXN0ZSBNYW5leXJvbCA8SmVhbi1CYXB0aXN0ZS5NYW5leXJvbEB0ZGsuY29tPiB3cm90
ZToKPgo+PiA+Cj4+ID5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+
ID5Gcm9tOsKgRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPgo+PiA+U2VudDrC
oFR1ZXNkYXksIEp1bmUgMjQsIDIwMjUgMDA6MTMKPj4gPlRvOsKgSmVhbi1CYXB0aXN0ZSBNYW5l
eXJvbCA8SmVhbi1CYXB0aXN0ZS5NYW5leXJvbEB0ZGsuY29tPgo+PiA+Q2M6wqBKb25hdGhhbiBD
YW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFm
b28uZGU+OyBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPjsgQW5keSBTaGV2Y2hlbmtvIDxh
bmR5QGtlcm5lbC5vcmc+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnIDxsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz4KPj4gPlN1YmplY3Q6wqBSZTogW1BBVENIIHY1IDEvM10gaWlvOiBp
bXU6IGludl9pY200MjYwMDogbW92ZSBzdHJ1Y3R1cmUgRE1BIGJ1ZmZlcnMgYXQgdGhlIGVuZAo+
PiA+wqAKPj4gPlRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcgo+PiA+VGhp
cyBtZXNzYWdlIGNhbWUgZnJvbSBvdXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLgo+PiA+wqAKPj4g
Pk9uIE1vbiwgSnVuIDIzLCAyMDI1IGF0IDY6NTbigK9BTSBKZWFuLUJhcHRpc3RlIE1hbmV5cm9s
IHZpYSBCNCBSZWxheQo+PiA+PGRldm51bGwramVhbi1iYXB0aXN0ZS5tYW5leXJvbC50ZGsuY29t
QGtlcm5lbC5vcmc+IHdyb3RlOiAgCj4+ID4+Cj4+ID4+IEZyb206IEplYW4tQmFwdGlzdGUgTWFu
ZXlyb2wgPGplYW4tYmFwdGlzdGUubWFuZXlyb2xAdGRrLmNvbT4KPj4gPj4KPj4gPj4gTW92ZSBE
TUEgYnVmZmVycyBhdCB0aGUgZW5kIG9mIHRoZSBzdHJ1Y3R1cmUgdG8gYXZvaWQgb3ZlcmZsb3cK
Pj4gPj4gYnVncyB3aXRoIHVuZXhwZWN0ZWQgZWZmZWN0LiAgCj4+ID4KPj4gPklmIHRoZXJlIGlz
IGFuIG92ZXJmbG93IGJ1Zywgd2Ugc2hvdWxkIGZpeCB0aGF0IHJhdGhlciB0aGFuIGhpZGluZyBp
dC4KPj4gPgo+PiA+SWYgSSBtaXN1bmRlcnN0b29kIHRoZSBwcm9ibGVtIGFuZCB0aW1lc3RhbXAg
YW5kIGZpZm8gc2hvdWxkIG5vdCBiZSBpbgo+PiA+dGhlIERNQSBhbGlnbmVkIGFyZWEgYW5kIHRo
ZXJlIGlzIGEgcHJvYmxlbSB3aXRoIERNQSBjYWNoZSB3cml0aW5nCj4+ID5vdmVyIHRoZW0sIHRo
ZW4gSSB0aGluayB3ZSBzaG91bGQgcmV3b3JkIHRoZSBjb21taXQgbWVzc2FnZS4KPj4gPiAgCj4+
IEhlbGxvIERhdmlkLAo+PiAKPj4gdGhpcyBjaGFuZ2Ugd2FzIGFza2VkIGJ5IEpvbmF0aGFuIHNv
IHRoYXQgcG90ZW50aWFsIERNQSBvdmVyZmxvdyB3b3VsZCBiZSBtb3JlCj4+IGVhc2lseSBjYXVn
aHQgYnkgd3JpdGluZyBvdXRzaWRlIG9mIHRoZSBzdHJ1Y3R1cmUgcmF0aGVyIHRoYW4gd3JpdGlu
ZyBpbnNpZGUKPj4gYW5kIGRvIHVuZXhwZWN0ZWQgYmVoYXZpb3IuCj4+IAo+PiA+Pgo+PiA+PiBz
dHJ1Y3QgaW52X2ljbTQyNjAwX2ZpZm8gaGFzIGEgRE1BIGJ1ZmZlciBhdCB0aGUgZW5kLgo+PiA+
Pgo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxqZWFuLWJhcHRp
c3RlLm1hbmV5cm9sQHRkay5jb20+Cj4+ID4+IC0tLQo+PiA+PiAgZHJpdmVycy9paW8vaW11L2lu
dl9pY200MjYwMC9pbnZfaWNtNDI2MDAuaCB8IDggKysrKy0tLS0KPj4gPj4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+ID4+Cj4+ID4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMC5oIGIvZHJpdmVy
cy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDAuaAo+PiA+PiBpbmRleCA1NWVkMWRk
YWE4Y2I1ZGQ0MTBkMTdkYjM4NjZmYTBmMjJmMThlOWQyLi45YjJjY2UxNzI2NzBjNTUxM2YxOGQ1
OTc5YTVmZjU2M2U5YWY0Y2IzIDEwMDY0NAo+PiA+PiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52
X2ljbTQyNjAwL2ludl9pY200MjYwMC5oCj4+ID4+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZf
aWNtNDI2MDAvaW52X2ljbTQyNjAwLmgKPj4gPj4gQEAgLTE0OCw5ICsxNDgsOSBAQCBzdHJ1Y3Qg
aW52X2ljbTQyNjAwX3N1c3BlbmRlZCB7Cj4+ID4+ICAgKiAgQHN1c3BlbmRlZDogICAgICAgICAg
ICAgICAgc3VzcGVuZGVkIHNlbnNvcnMgY29uZmlndXJhdGlvbi4KPj4gPj4gICAqICBAaW5kaW9f
Z3lybzogICAgICAgZ3lyb3Njb3BlIElJTyBkZXZpY2UuCj4+ID4+ICAgKiAgQGluZGlvX2FjY2Vs
OiAgICAgIGFjY2VsZXJvbWV0ZXIgSUlPIGRldmljZS4KPj4gPj4gLSAqICBAYnVmZmVyOiAgICAg
ICAgICAgZGF0YSB0cmFuc2ZlciBidWZmZXIgYWxpZ25lZCBmb3IgRE1BLgo+PiA+PiAtICogIEBm
aWZvOiAgICAgICAgICAgICBGSUZPIG1hbmFnZW1lbnQgc3RydWN0dXJlLgo+PiA+PiAgICogIEB0
aW1lc3RhbXA6ICAgICAgICAgICAgICAgIGludGVycnVwdCB0aW1lc3RhbXBzLgo+PiA+PiArICog
IEBmaWZvOiAgICAgICAgICAgICBGSUZPIG1hbmFnZW1lbnQgc3RydWN0dXJlLgo+PiA+PiArICog
IEBidWZmZXI6ICAgICAgICAgICBkYXRhIHRyYW5zZmVyIGJ1ZmZlciBhbGlnbmVkIGZvciBETUEu
Cj4+ID4+ICAgKi8KPj4gPj4gIHN0cnVjdCBpbnZfaWNtNDI2MDBfc3RhdGUgewo+PiA+PiAgICAg
ICAgIHN0cnVjdCBtdXRleCBsb2NrOwo+PiA+PiBAQCAtMTY0LDEyICsxNjQsMTIgQEAgc3RydWN0
IGludl9pY200MjYwMF9zdGF0ZSB7Cj4+ID4+ICAgICAgICAgc3RydWN0IGludl9pY200MjYwMF9z
dXNwZW5kZWQgc3VzcGVuZGVkOwo+PiA+PiAgICAgICAgIHN0cnVjdCBpaW9fZGV2ICppbmRpb19n
eXJvOwo+PiA+PiAgICAgICAgIHN0cnVjdCBpaW9fZGV2ICppbmRpb19hY2NlbDsKPj4gPj4gLSAg
ICAgICB1OCBidWZmZXJbMl0gX19hbGlnbmVkKElJT19ETUFfTUlOQUxJR04pOwo+PiA+PiAtICAg
ICAgIHN0cnVjdCBpbnZfaWNtNDI2MDBfZmlmbyBmaWZvOwo+PiA+PiAgICAgICAgIHN0cnVjdCB7
Cj4+ID4+ICAgICAgICAgICAgICAgICBzNjQgZ3lybzsKPj4gPj4gICAgICAgICAgICAgICAgIHM2
NCBhY2NlbDsKPj4gPj4gICAgICAgICB9IHRpbWVzdGFtcDsKPj4gPj4gKyAgICAgICBzdHJ1Y3Qg
aW52X2ljbTQyNjAwX2ZpZm8gZmlmbzsgIAo+PiA+Cj4+ID5JIGRpZG4ndCBsb29rIGF0IGhvdyB0
aGUgZHJpdmVycyB1c2UgdGltZXN0YW1wIGFuZCBmaWZvLCBidXQgaWYgdGhleQo+PiA+YXJlIHBh
c3NlZCBhcyBhIGJ1ZmZlciB0byBTUEksIHRoZW4gdGhleSBuZWVkIHRvIHN0YXkgaW4gdGhlIERN
QQo+PiA+YWxpZ25lZCBhcmVhIG9mIHRoZSBzdHJ1Y3QuICAKPj4gCj4+IHN0cnVjdCBpbnZfaWNt
NDI2MDBfZmlmbyBoYXMgYSBidWZmZXIgYXQgaXRzIGVuZCB0aGF0IGlzIHBhc3NlZCB0byBTUEku
Cj4+IFNhbWUgdGhpbmdzIGZvciBidWZmZXIgYmVsb3cuIFRoYXQncyB3aHkgYm90aCBidWZmZXJz
IGFyZSBETUEKPj4gYWxpZ25lZC4KPgo+SXQncyBhIHRpbnkgYml0IGVzb3RlcmljIHRoYXQgdGhp
cyBpcyByZWx5aW5nIG9uIHN0cnVjdHVyZSBhbGlnbm1lbnQgcnVsZXMKPnRoYXQgc2F5cyAoaWly
YykgdGhlIHN0cnVjdHVyZSBlbGVtZW50IHdpbGwgYmUgYWxpZ25lZCB0byBtYXhpbXVtIG9mIGl0
J3MKPmVsZW1lbnRzIGFuZCB0aGVyZSBpcyB0YWlsIHBhZGRpbmcgdG8gdGhhdCBzaXplIGFzIHdl
bGwuICBUaHVzIHRoZSB3aG9sZQo+c3RydWN0IGludl9pY200MjYwMCBpcyBfX2FsaWduZWQoSUlP
X0RNQV9NSU5BTElHTikgYW5kIHRoZSBidWZmZXIgaW4gdGhlcmUKPmlzIGl0c2VsZiBhZnRlciBw
YWRkaW5nIHRvIGVuc3VyZSB0aGF0IGl0IGlzIF9fYWxpZ25lZChJSU9fRE1BX01JTkFMSUdOKQo+
Cj4KPkFueWhvdywgYWxsIEkgdGhpbmsgdGhpcyBhY3R1YWxseSBkb2VzIGlzIGF2b2lkIG9uZSBs
b3Qgb2YgcGFkZGluZwo+KGFzIHdlbGwgYXMgbWFraW5nIGl0IHNsaWdodGx5IGVhc2llciB0byBy
ZWFzb24gYWJvdXQhKQo+Cj5vdXRlciBzdHJ1Y3Qgewo+c3R1ZmYKPnBhZGRpbmcgdG8gYWxpZ24g
IzEKPmZpZm8gewo+CXN0dWZmCj4JcGFkZGluZyB0byBhbGlnbgo+CWJ1ZmZlcgo+CXBhZGRpbmcg
dG8gZmlsbCB1cCBhbGlnbgo+fQo+c3RydWN0IHRpbWVzdGFtcDsKPi8vL3RoaXMgYml0IHdpbGwg
Z28gYXdheSBhcyBpdCBjYW4gZml0IGluIHRoZSBwYWRkaW5nICMxIChwcm9iYWJseSkKPlBhZGRp
bmcgdG8gYWxpZ24KPi8vLy8KPnU4IGJ1ZmZlclsyXSBfX2FpbGduZWQoSUlPX0RNQV9NSU5BTElH
TikKPgo+CgpIZWxsbyBEYXZpZCBhbmQgSm9uYXRoYW4sCgp3aGF0IHNob3VsZCBJIGNoYW5nZWQg
Zm9yIHRoaXMgcGF0Y2g/IFJld3JpdGUgdGhlIGNvbW1pdCBtZXNzYWdlPwoKVGhhbmtzIGZvciB5
b3VyIGZlZWRiYWNrLApKQgoKPgkKPj4gCj4+ID4gIAo+PiA+PiArICAgICAgIHU4IGJ1ZmZlclsy
XSBfX2FsaWduZWQoSUlPX0RNQV9NSU5BTElHTik7Cj4+ID4+ICB9Owo+PiA+Pgo+PiA+Pgo+PiA+
Pgo+PiA+PiAtLQo+PiA+PiAyLjQ5LjAKPj4gPj4KPj4gPj4gIAo+PiA+ICAKPj4gCj4+IFRoYW5r
cywKPj4gSkIKPgo+

