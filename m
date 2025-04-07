Return-Path: <linux-iio+bounces-17733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E92A7D734
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 10:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA4F188C1AF
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 08:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572992248A1;
	Mon,  7 Apr 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EbME2Rmi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7F10FD;
	Mon,  7 Apr 2025 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013249; cv=fail; b=mF9ZNmsoQ3yD/LkLpHFleeqalqmOAJAvvDf5yz13xWWb6A3Q/F9U/QVb2hKwFx7LPhqZRbKIQvUCgasxWl2t4WgM0+0Z5m7tRLn8a4EpJmUBBKFFwt79iaEXNzjCjZaWS+GzsAyyFu96ZbgoSegqZV8c3T97RiGC+Fg3ZHaZ2fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013249; c=relaxed/simple;
	bh=0NXjtFz+PXnpFcySSQvo11SiWyWZtq21X0dvZHk8/sI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmQMDgnG1ZFCCal0goQ6jZdNCt253DVMi45D3ydkGbB+i+y/vSR+dOKvwRWZWek7o46DJnFujgjm65IdoA/7F3gAqOjSREU8vZSrlUCXMPGxzifHC9lhs2qFe7NnfQ3znv6lyJG9I2ElhhtGuSTmiskGlbHv/is67S6TS3HW/AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EbME2Rmi; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5377lTDx011706;
	Mon, 7 Apr 2025 04:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0NXjt
	Fz+PXnpFcySSQvo11SiWyWZtq21X0dvZHk8/sI=; b=EbME2RmifrnRvcwzR8x7c
	7X2uDpQm7IfDdVFiQnnHZfqYUduii1DtSezKFx6Yy3VzUZVL29rSZ8vzuzSkm4Tq
	lIaKu/xOB7LSz9WJwUZnPEZGSCJuWkp54OIS8daRqbakO+JxxCOa9tAbV7902BJa
	3PEidS8EDxmnBuoAd8QPDwztrBISCjP55M+WU2pndeQwbkz0Xvly5RmI+9JuvJaJ
	hBZ/iW9rN1iwVbrTU9qG4X/fdNl5fvfbIGbt9aOgAPSWsKlwgruyN1YZV15cNhz3
	m4d/3DLpRPzrzSOwVTjaAp549SOZ+bRAfH34ztGDJTlHQmc4HdvY4l9M1mVioIXR
	g==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45upjhkt4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 04:07:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJTbRde5JtwISFL0OssAMV04rFfztnkrOv+2kLh3ZpRo/9FxB7el6jroTC3ohQPQivpcceWtSztaYfA5movjmbmh68J55h0iyu3NX9gNgUIhggrh4KWsBeZTF6ILinFb4VqVu3lcdlSBt7+uMeB1lcvi9Zft5QA1sbUYZ72lZqid/ovKolEdqwoAfISYORrm5p00iyRTVQ4X7LpsyCnQ4XgNosM0VOsi5aTPH8wKF5lQdYUtujCxesK+vWuOVsAJiVHnF3bHX+e4HEUUkeyOUAgHstpOfNbWix7m4CwEk9t7swfQZMMt/ZliJLbrwXBTXy4Cj1PdwgfeCI/i4REe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NXjtFz+PXnpFcySSQvo11SiWyWZtq21X0dvZHk8/sI=;
 b=qWln4Srih4jWLDR5JVo4C2aRRN4I5h8N3SQplGQySJFNyKfJxM00RGYLGMwJ7Gz6X1GQs9iNvB5Qj3LwHkiRhrXXKNNNm6Kecji6utyBDftgO2/jh/mSCkUBMqxIyUVuO1zwSmARKwRhHsdQJ54cI6KrICpPeB24fKnS84jcKevYU7qXBfkntxisd9UWfAnmYsrwJ4v1JVUEzoNCqSxQeCzS+Ph44Gu81icuybIAozIF78uOrEICmRWu3wRttSSmLtnn+BpO6AyfwTydi6JJMnaeeOSD5dgASn3bYf5WR6ldOv3yxj90kekhMpx3EeRef4aRxkI83da/wBFMcTFw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by CH1PR03MB8141.namprd03.prod.outlook.com (2603:10b6:610:2b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 08:07:08 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 08:07:08 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Topic: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Index: AQHbpFodVQ0K5gQpPUCv8ilGKsClk7OVQjGAgAKc51A=
Date: Mon, 7 Apr 2025 08:07:08 +0000
Message-ID:
 <PH0PR03MB714102E85132F30477EE7680F9AA2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
	<20250403-togreg-v3-3-d4b06a4af5a9@analog.com>
 <20250405171155.091edbae@jic23-huawei>
In-Reply-To: <20250405171155.091edbae@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|CH1PR03MB8141:EE_
x-ms-office365-filtering-correlation-id: bde5b188-d151-4544-9175-08dd75ab3172
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXZTdTBoWmhPQjZzVkNLcWswN0plc0lWNmx6TmIxcTNnZWYyQ0ZDRVI1NDRh?=
 =?utf-8?B?MS9MNDM3Q0VrY1d3S0FJUUtXM2ptcmpEYktPVW5YM2Y2dGpmbDI4M0diYWVE?=
 =?utf-8?B?ZkJGYzM1NGlSbUlMVEczNEtaMEM2RkJBTHBQSmxiVyt4NGU4SDZ3THlXWFls?=
 =?utf-8?B?cjB6YnNrSmdpTVdEaFVyLzl3VzYrcHJYL3RQSmpUNytGdElnYUFRWHlmYlI3?=
 =?utf-8?B?c3NxNy9tcFhqV0tHb1JDL01ZK2lWaUovb0tSSmpaai9GOCtTYXBrQVFvYThX?=
 =?utf-8?B?YTFuWHMxTlkzR0VQUENKZzFNeHpmMXVnU1ZNVENWOFJzRFF4UHU4ajV0eGhR?=
 =?utf-8?B?NER6MTBCeklZT2d5MDlXMnEyUmJpa011Ry8wUCtGLzJsN0g5MEtyNUI4YVJR?=
 =?utf-8?B?a0ljcENsZUMzMzg5MmVKT0lWV2YySFZ4T0tsRklsN1ZpUUdkcDMrdWhHNFUx?=
 =?utf-8?B?ZXlEeDdDeXh2cFVrZUN5WkQ3TFlYaVlaNlFFcDVhMjlSdUxERXhRS0U3bElo?=
 =?utf-8?B?Z21Va1JrVnF3UUE1MTZWYXdld0xkcmFYWkowMWJOZzZTcVIyN0FaQk5qKzZJ?=
 =?utf-8?B?dGRDekNzdHhScEtQYUxLSkw2eG9EN1RlK0tKeDBjeGlkWmRLU0N5anBsUWNm?=
 =?utf-8?B?bGp6OW41V0ZFYzEzczJMMGs4OVU5ZEdaMEJsNTFzNDhPS2sxTENOZDFmOEhZ?=
 =?utf-8?B?OVBNU0NaY2cwTmRjczVESzVhUWwxYTFIdlEzNVJBWVNZODU4b3F4SFhmKy85?=
 =?utf-8?B?RFVNQnA4azJQbW1yNFNIamIrZC9IcFc3c0NVTEI4bXM2S1NKb2l6eHlvejdN?=
 =?utf-8?B?SDVrakorQzJKQXgya0RWT2F5RVNBemZSR25mcTd0VWpIRVVBa0srMFNHU0Mx?=
 =?utf-8?B?TkZ2TUlucithZ2czWGFrcGdCdGtiSmE4bWpoSmpDVWFncUNuN2hIVHgrS3hM?=
 =?utf-8?B?YVhxZlcyRTZrWnNnNDZNZ1dsbWw0YmNiNUZmV2RkL2lFSWpnK21HdEdVZkcv?=
 =?utf-8?B?OS8zR2RYdXZaRVRZQ1o4eGZPQThESWFvT2g3aFhKRHlYeHpJWFdGbnlmTzQ2?=
 =?utf-8?B?WXlKMG9vQmt5Ty8vRXE1Y2JkdW5HN0RhcWVPMklxZ085L2lrNnU3NWxmZ1NZ?=
 =?utf-8?B?U0JaU1hYY3IxeThHbVdXN3IyNXZHeitSRURwQVR0UlhLQldvbTB6NjBjYzFr?=
 =?utf-8?B?YXpKWXBoZG5Kam55d1BoQlpyemJudG92Um9iWERDcnlWUVBtUGcyNVF2b05o?=
 =?utf-8?B?ZExaSnhnS2ttd21LeWxndmQvK3VIUGpQTGFnNXZVMkpUM3owZytSQjVDeE51?=
 =?utf-8?B?b0JaRTFJN1FEU3E4OEdTUG5QeGZIU1l1Sy9rcEYxOEZFVExEQndaL0pvU08z?=
 =?utf-8?B?bWtqWXNUNi9icWozT0ZNY3VFNkN2ZlBKL3crbW9hckdXTWNRT1ljN1RTV3dG?=
 =?utf-8?B?L3R4UDludWtMSjQzYW5Ud0JCMG9URmd0d2ZmNlBBdTJTTTYvVEYvRlNiVmlL?=
 =?utf-8?B?YXN4TzI2UkNndmVCSkxxZXIzK0wzcndKN0JLVzN3VmcwOXgvNTNIc2JkV3d5?=
 =?utf-8?B?UFJYUWRlYm9OZk05THdxemt5eGZaQnBCdUQ1OTlTZ3d5cjcwWUZ0QlBsTmxz?=
 =?utf-8?B?dE1Oa3YvK3RRS2dreDZVbmxueE41NUtNcFUvY3ZlVCs0UDJDaTM1SVFaeXZu?=
 =?utf-8?B?aXdURVZBaHZJOHE3ZmRjc1BQVmk1L0pWV0NhQjlOS2MwSUhMY0R4eHErMnNm?=
 =?utf-8?B?YjRwdlFSc2ZyRkNNVDQ2NWpjajNGT0tHcVRLdUVmMExCT1o4bTJIWnVKVlpp?=
 =?utf-8?B?RmN2R1hZejBKMU82c3Q2a0hKeVdWWnZJbitEdmExeW1qd3B3NlB6VlBBVFRF?=
 =?utf-8?B?V01WQVVqd3N2YlZXWkxCQ3R0N2J1M2haOWc4TUFDTlhVcWIyOUdjS0N5Smhy?=
 =?utf-8?B?bERnZlVIYXQ2S1dNZlZ2TGZhQnRQK0lCUW9jcXVFOHRQZ04zOW1KaFdmVlE5?=
 =?utf-8?Q?ktlRi2pSwNXTRMgC8WHuOOauIIjmNo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXJaUnh1ZXU4RlF3YVUzdTdnbnBxcFozcDBNOVRrMWhWL21ZS3V5b0JkNGEz?=
 =?utf-8?B?aDVvaWcxaElIc2I5NVU5S1E5V2ZWeXJTd3VKaUxzczZXSEdnN0xRa2kxbThQ?=
 =?utf-8?B?NWg3T0hKaTBTWjJsdlRtRHF5YXNqa0M5NmU3ZWp4ajZrNkwzV1pNdzJvczFa?=
 =?utf-8?B?bGIvWlhPUGRyZ2R2NytSODZ1aVprTVkvWmU1VmJQeFA3Mys3a1ZMcXVObFJV?=
 =?utf-8?B?YmJMUFZiUVhoUyszSmpSM3FiL0h5anZ3OUk0ZHFoUFJXeVZJSExWTFg4bGRp?=
 =?utf-8?B?cmVDUXNBWTZKc2tMOTBqWUlMdXoyY0kreWdsVmFFdUhXczNseDlrRjB5bkxu?=
 =?utf-8?B?cWJuM21GUENHVnFhWHFMaG8vK3hQeTdaS0ZlZlliWHozWENTMzMxSkpnUjRY?=
 =?utf-8?B?OVBBNkdSc0Mwdlpxc3NmdVFFbE8zUnBCbXZXcDhGdTV2QnRLYld3ZC93SmZN?=
 =?utf-8?B?dEdDK1p5cFE2SWJ6aGFxR0QySXpYNFpXNnJJZzNaMGQ0Rlk4ZlFhLytZMngx?=
 =?utf-8?B?QU5naUsxd0hYalBzbXF3enpnRmJmNUd2KzYxc1FTbEtJUjJXUE03cFZYZkVk?=
 =?utf-8?B?YzZad0R5OHhrbE1acnFMMmZoSTRqYjA1Mnc1YmY2Wm8yc1k0QjMrcUdFNkV4?=
 =?utf-8?B?a0hVMmdadGx4TVB4U2NSL0lwVEErRHRDZ2ltNXdVTm9RSXc3L2hLeWxoK013?=
 =?utf-8?B?Ym1FbmdXNC9EUXpvemo3K2hMa085WkFtaGVEMXh1Q2IzSUswV2J1WXo2aUFx?=
 =?utf-8?B?ZWpsV012TE92SHNBNFhMZ1RSWGRCdGlaS0FPODEyZURvU2djM2xuK2RyRXpX?=
 =?utf-8?B?WUZnTUpaQU1YRVJjN0wwZ0pJcmdTSFYrZkpTbC9SMTN4QnpueGtHdXBWS2gx?=
 =?utf-8?B?dE01d0hpQVpCMFNJWEhxZzlPSVlmeUsvZ0x3RnpoOGhRVzhQQTZuc2QzeU1j?=
 =?utf-8?B?Y0Q5N3VCcGE4SU5iREE4VHViMFZ5ZGJvQnVwYUFuSGhLSnNaUllCUC9xRktE?=
 =?utf-8?B?NEhhaU81RGIvRUh2cHJpZklnZE5Rbmd6ZzJJY2drTWhhRFVVWXlZaGpQYUV4?=
 =?utf-8?B?WExMUjY2NzRJRDVwdFhqNW9mNkRDMk1BbzU5ZjZ4Zmc5ZktKcHRjZ0NReERM?=
 =?utf-8?B?V0R6NE9odXdYYlJuL1NNMUJpSXk4Vi9CS0hiOVRFK0NpMytRU00vYTNzY1dT?=
 =?utf-8?B?OC82S3NDM1J5a09STTJldE5uL0ZBdTAyTFE1SVdwOWpaTXc5OTZJQXhtNkpM?=
 =?utf-8?B?YnBOMDlFZTFOVWVVWUVuMzM5T2o3VXdjckVmejA0TW1SeDNERnA0SWZUU2t0?=
 =?utf-8?B?MXl0dVR2NUUrYVJCNTZta29VNE1TNzFWZ083TTJDd2hwNXVjakZuYkNLdWJI?=
 =?utf-8?B?UjFXTWR6MDQ2ZkprYU5wVlVORlR5QkpXek9uMTNzSXVpUmFKZVZjd0ZBOGlx?=
 =?utf-8?B?UzN5UzVCZWNsb0ZhU1kvdWhyaEdkMmEzS1ZBcTVsMTNLb3FYRThES0FzbVdI?=
 =?utf-8?B?eVM0Y2N2Z0xPbGxvZlZkT3hjT1NLR1Z2Z2VTRXhmeVZqa3BPcTlPRVpBeUNS?=
 =?utf-8?B?V0R4T21sL1ZIWm9kZW9tM0pyQXNmZzM1Z2J5MEJqSS9aeFVTL0hpTXlTRkox?=
 =?utf-8?B?VVBWTWt3WGFNTFJSejNDTGRTeEFiSzRzU3RmaGx6Y2RwRDA3MjNpbzJiNitR?=
 =?utf-8?B?UjdpTTNjQVY5blByN01Nci96Uzk5RVBuQithN3RQSlo2L01CTnpkdng2RXhy?=
 =?utf-8?B?d2hqSHJUaGN1SjRvTVRLUmwzZlNqVEZ0NTlDbldYTmdjTWVnV1JqT1QwZkpU?=
 =?utf-8?B?T0ZjU2VjNDZyZVJlMThJUWtQbWhmWi8xMmxPRmxpR2oxVW5xNE5XRXEweWsw?=
 =?utf-8?B?a3kwWHRIUURNc21ZTHBtREdxVEd5N09DbXViNWpkbGFXMmJaUitvOHphN2g1?=
 =?utf-8?B?bXp1MFR6TmpDNkpDeFVoY2FvZUlId3JvbVF1UkdLMyt5ZXc4R0puQUpxZTRK?=
 =?utf-8?B?akNDTFNqSEVVNDFGYXdBQ1JxM3U4SmZqRTlVOTFQVVVXbTU3dW5QRVZ3VXpj?=
 =?utf-8?B?MDhnbCtzbFYrZVZBeXY3S0dGYXEvbHFEbk1VaWx4ZFYyQkFCMVZPeHdGcXNF?=
 =?utf-8?Q?Lex0M+6MbM7p5XLBmQA2F4Lji?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde5b188-d151-4544-9175-08dd75ab3172
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 08:07:08.5366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb+0TUVeLSp7MA2BUxxIcHeMtl6jo6W6iFd4SV+UY6V0hjzzwH713RugflwZoxCnW2eLggyKVksdJI1adSwiVMRZSL/FJ0uWDJ6FD96GGE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR03MB8141
X-Proofpoint-GUID: rqPe6xr4s8RDIOVAIIJWh0wfUHBZ-qSh
X-Authority-Analysis: v=2.4 cv=T4+MT+KQ c=1 sm=1 tr=0 ts=67f387af cx=c_pps a=ZuQraZtzrhlqXEa35WAx3g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=HeZXJEnYFMCuh-TCqK0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rqPe6xr4s8RDIOVAIIJWh0wfUHBZ-qSh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070057

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBBcHJpbCA2LCAyMDI1IDEyOjEy
IEFNDQo+IFRvOiBQYWxsZXIsIEtpbSBTZWVyIDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29tPg0K
PiBDYzogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBIZW5uZXJpY2gsIE1p
Y2hhZWwNCj4gPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3Jn
PjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgbGludXgtDQo+IGlpb0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy8zXSBpaW86IGRhYzogYWQz
NTMwcjogQWRkIGRyaXZlciBmb3IgQUQzNTMwUiBhbmQNCj4gQUQzNTMxUg0KPiANCj4gW0V4dGVy
bmFsXQ0KPiANCj4gT24gVGh1LCAzIEFwciAyMDI1IDEzOjMzOjU3ICswODAwDQo+IEtpbSBTZWVy
IFBhbGxlciA8a2ltc2Vlci5wYWxsZXJAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBLaW0s
DQo+ID4gVGhlIEFEMzUzMC9BRDM1MzBSICg4LWNoYW5uZWwpIGFuZCBBRDM1MzEvQUQzNTMxUiAo
NC1jaGFubmVsKSBhcmUNCj4gPiBsb3ctcG93ZXIsIDE2LWJpdCwgYnVmZmVyZWQgdm9sdGFnZSBv
dXRwdXQgREFDcyB3aXRoIHNvZnR3YXJlLQ0KPiA+IHByb2dyYW1tYWJsZSBnYWluIGNvbnRyb2xz
LCBwcm92aWRpbmcgZnVsbC1zY2FsZSBvdXRwdXQgc3BhbnMgb2YgMi41Vg0KPiA+IG9yIDVWIGZv
ciByZWZlcmVuY2Ugdm9sdGFnZXMgb2YgMi41Vi4gVGhlc2UgZGV2aWNlcyBvcGVyYXRlIGZyb20g
YQ0KPiA+IHNpbmdsZSAyLjdWIHRvIDUuNVYgc3VwcGx5IGFuZCBhcmUgZ3VhcmFudGVlZCBtb25v
dG9uaWMgYnkgZGVzaWduLiBUaGUgIlIiDQo+ID4gdmFyaWFudHMgaW5jbHVkZSBhIDIuNVYsIDVw
cG0vwrBDIGludGVybmFsIHJlZmVyZW5jZSwgd2hpY2ggaXMgZGlzYWJsZWQNCj4gPiBieSBkZWZh
dWx0Lg0KPiANCj4gDQo+IEFzIGJlbG93LiBHaXZlbiB0aGUgYmluZGluZ3MgcHJvdmlkZSBmb3Ig
dXNlIHdpdGggYW4gZXh0ZXJuYWwgQURDIHRvIHJlYWQgYQ0KPiB3aWRlIHJhbmdlIG9mIHNpZ25h
bHMsIGlmIGludGVudCBpcyBub3QgdG8gcHJvdmlkZSB0aGF0IHN1cHBvcnQgJ3lldCcNCj4gKHdo
aWNoIGlzIGZpbmUpIHRoZW4gYWRkIGEgcGFyYWdyYXBoIGhlcmUgdG8gc2F5IHRoYXQuDQo+IA0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2ltIFNlZXIgUGFsbGVyIDxraW1zZWVyLnBhbGxlckBh
bmFsb2cuY29tPg0KPiANCj4gDQo+IEEgZmV3IGFkZGl0aW9uYWwgY29tbWVudHMgZnJvbSBtZSBp
bmxpbmUuICBQYXJ0aWN1bGFyIGZ1biBpcyB0aGUgbG9uZyBydW5uaW5nDQo+IFNQSSByZWdtYXAg
RE1BIHNhZmV0eSBhc3N1bXB0aW9ucyBxdWVzdGlvbi4NCj4gRm9yIG5vdyBJIHRoaW5rIHdlIGhh
dmUgdG8gYXNzdW1lIGJ1bGsgcmVhZC93cml0ZSBzdGlsbCBuZWVkIGEgRE1BIHNhZmUNCj4gYnVm
ZmVyLg0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2Rh
Yy9hZDM1MzByLmMgYi9kcml2ZXJzL2lpby9kYWMvYWQzNTMwci5jIG5ldw0KPiA+IGZpbGUgbW9k
ZSAxMDA2NDQgaW5kZXgNCj4gPg0KPiAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwLi40Yjc1N2UxOWYwYzgzNDk5OTlmNzJlDQo+IDUzYWJiMQ0KPiA+IGE0ZjQ4M2E0NGVi
Mg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL2lpby9kYWMvYWQzNTMwci5j
DQo+ID4gQEAgLTAsMCArMSw1MTQgQEANCj4gDQo+ID4gKw0KPiA+ICsjZGVmaW5lIEFEMzUzMFJf
SU5URVJGQUNFX0NPTkZJR19BCQkweDAwDQo+ID4gKyNkZWZpbmUgQUQzNTMwUl9PVVRQVVRfT1BF
UkFUSU5HX01PREVfMAkJMHgyMA0KPiA+ICsjZGVmaW5lIEFEMzUzMFJfT1VUUFVUX09QRVJBVElO
R19NT0RFXzEJCTB4MjENCj4gPiArI2RlZmluZSBBRDM1MzBSX09VVFBVVF9DT05UUk9MXzAJCTB4
MkENCj4gPiArI2RlZmluZSBBRDM1MzBSX1JFRkVSRU5DRV9DT05UUk9MXzAJCTB4M0MNCj4gPiAr
I2RlZmluZSBBRDM1MzBSX1NXX0xEQUNfVFJJR19BCQkJMHhFNQ0KPiA+ICsjZGVmaW5lIEFEMzUz
MFJfSU5QVVRfQ0goYykJCQkoMiAqIChjKSArIDB4RUIpDQo+ID4gKw0KPiA+ICsjZGVmaW5lIEFE
MzUzMVJfU1dfTERBQ19UUklHX0EJCQkweEREDQo+ID4gKyNkZWZpbmUgQUQzNTMxUl9JTlBVVF9D
SChjKQkJCSgyICogKGMpICsgMHhFMykNCj4gDQo+IEknZCBhZGQgYSBkZWZpbmUgZm9yIHRoZSBm
aXJzdCBjaGFubmVsIGFuZCB0aGVuIGp1c3QgaGF2ZSB0aGUgcmVzdCBvZiB0aGlzIGluIHRoZQ0K
PiBkZXZpY2Ugc3BlY2lmaWMgZnVuY3Rpb24gdGhhdCB1c2VzIGl0Lg0KPiANCj4gPiArDQo+ID4g
KyNkZWZpbmUgQUQzNTMwUl9TV19MREFDX1RSSUdfTUFTSwkJQklUKDcpDQo+ID4gKyNkZWZpbmUg
QUQzNTMwUl9PVVRQVVRfQ09OVFJPTF9NQVNLCQlCSVQoMikNCj4gPiArI2RlZmluZSBBRDM1MzBS
X1JFRkVSRU5DRV9DT05UUk9MX01BU0sJCUJJVCgwKQ0KPiA+ICsjZGVmaW5lIEFEMzUzMFJfUkVH
X1ZBTF9NQVNLCQkJR0VOTUFTSygxNSwgMCkNCj4gPiArDQo+ID4gKyNkZWZpbmUgQUQzNTMwUl9T
V19SRVNFVAkJCShCSVQoNykgfCBCSVQoMCkpDQo+ID4gKyNkZWZpbmUgQUQzNTMwUl9NQVhfQ0hB
Tk5FTFMJCQk4DQo+ID4gKyNkZWZpbmUgQUQzNTMxUl9NQVhfQ0hBTk5FTFMJCQk0DQo+ID4gKyNk
ZWZpbmUgQUQzNTMwUl9DSChjKQkJCQkoYykNCj4gDQo+IFRoaXMgc2VlbXMgYSBsaXR0bGUgdW5u
ZWNlc3NhcnkuLi4NCj4gR2l2ZW4gaXQgaXMgb25seSBjYWxsZWQgaW4gZGV2aWNlIHNwZWNpZmlj
IGZ1bmN0aW9ucyBJJ2QganVzdCBlbmNvZGUgdGhhdCB0aGVyZS4NCj4gDQo+ID4gKyNkZWZpbmUg
QUQzNTMwUl8zMktPSE1fUE9XRVJET1dOX01PREUJCTMNCj4gPiArI2RlZmluZSBBRDM1MzBSX0lO
VEVSTkFMX1ZSRUZfTVYJCTI1MDANCj4gPiArI2RlZmluZSBBRDM1MzBSX0xEQUNfUFVMU0VfVVMJ
CQkxMDANCj4gDQo+ID4gK3N0YXRpYyBpbnQgYWQzNTMwcl9kYWNfd3JpdGUoc3RydWN0IGFkMzUz
MHJfc3RhdGUgKnN0LCB1bnNpZ25lZCBpbnQgY2hhbiwNCj4gPiArCQkJICAgICB1bnNpZ25lZCBp
bnQgdmFsKQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsJX19iZTE2IHJlZ192YWw7DQo+
ID4gKw0KPiA+ICsJZ3VhcmQobXV0ZXgpKCZzdC0+bG9jayk7DQo+ID4gKwlyZWdfdmFsID0gY3B1
X3RvX2JlMTYodmFsKTsNCj4gPiArDQo+ID4gKwlyZXQgPSByZWdtYXBfYnVsa193cml0ZShzdC0+
cmVnbWFwLCBzdC0+Y2hpcF9pbmZvLQ0KPiA+aW5wdXRfY2hfcmVnKGNoYW4pLA0KPiA+ICsJCQkJ
JnJlZ192YWwsIHNpemVvZihyZWdfdmFsKSk7DQo+IA0KPiBBcyBiZWxvdy4gcmVnbWFwX2J1bGtf
d3JpdGUoKSBzaG91bGRuJ3QgYXNzdW1lIHRoZSBidWZmZXIgaXMgYm91bmNlZCBzbw0KPiBuZWVk
cyBhIERNQSBzYWZlIGJ1ZmZlci4NCj4gDQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiBy
ZXQ7DQo+ID4gKw0KPiA+ICsJaWYgKHN0LT5sZGFjX2dwaW8pDQo+ID4gKwkJcmV0dXJuIGFkMzUz
MHJfdHJpZ2dlcl9od19sZGFjKHN0LT5sZGFjX2dwaW8pOw0KPiA+ICsNCj4gPiArCXJldHVybiBy
ZWdtYXBfdXBkYXRlX2JpdHMoc3QtPnJlZ21hcCwgc3QtPmNoaXBfaW5mby0NCj4gPnN3X2xkYWNf
dHJpZ19yZWcsDQo+ID4gKwkJCQkgIEFEMzUzMFJfU1dfTERBQ19UUklHX01BU0ssDQo+ID4gKw0K
PiBGSUVMRF9QUkVQKEFEMzUzMFJfU1dfTERBQ19UUklHX01BU0ssIDEpKTsgfQ0KPiA+ICsNCj4g
PiArc3RhdGljIGludCBhZDM1MzByX3JlYWRfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYs
DQo+ID4gKwkJCSAgICBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBjb25zdCAqY2hhbiwNCj4gPiArCQkJ
ICAgIGludCAqdmFsLCBpbnQgKnZhbDIsIGxvbmcgaW5mbykgew0KPiA+ICsJc3RydWN0IGFkMzUz
MHJfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiArCWludCByZXQ7DQo+ID4g
KwlfX2JlMTYgcmVnX3ZhbDsNCj4gPiArDQo+ID4gKwlzd2l0Y2ggKGluZm8pIHsNCj4gPiArCWNh
c2UgSUlPX0NIQU5fSU5GT19SQVc6DQo+ID4gKwkJcmV0ID0gcmVnbWFwX2J1bGtfcmVhZChzdC0+
cmVnbWFwLA0KPiA+ICsJCQkJICAgICAgIHN0LT5jaGlwX2luZm8tPmlucHV0X2NoX3JlZyhjaGFu
LQ0KPiA+Y2hhbm5lbCksDQo+ID4gKwkJCQkgICAgICAgJnJlZ192YWwsIHNpemVvZihyZWdfdmFs
KSk7DQo+IA0KPiBTbyB0aGlzIHJ1bnMgaW50byB0aGUgb2xkIHF1ZXN0aW9uIG9mIHdoZXRoZXIg
d2UgbmVlZCBhIERNQSBzYWZlIGJ1ZmZlciBmb3IgYQ0KPiByZWdtYXBfYnVsa19yZWFkIHdoZW4g
dGhlIGJ1cyBpcyBTUEkuICBJbiBwcmFjdGljZSB3ZSBwcm9iYWJseSBkb24ndCBiZWNhdXNlDQo+
IG9mIGludGVybmFsIGRldGFpbHMgb2YgdGhlIHJlZ21hcCBidXQgSSBiZWxpZXZlIG5vdGhpbmcg
aGFzIGNoYW5nZWQgb24gdGhlDQo+IGd1aWRhbmNlIHRvIG5vdCBhc3N1bWUgdGhhdCBpbiBkcml2
ZXJzLiAgU28gdGhpcyByZWd2YWwgc2hvdWxkIGJlIERNQSBzYWZlLg0KPiBFYXNpZXN0IG9wdGlv
biBpcyBhDQo+IF9fYmUxNiB2YWwgX19hbGlnbmVkKElJT19ETUFfTUlOQUxJR04pIGF0IHRoZW4g
ZW5kIG9mIHRoZSBzdCBzdHJ1Y3R1cmUNCj4gdGhvdWdoIHdlIHdpbGwgYWxzbyBuZWVkIHRvIHRh
a2UgYSBtdXRleCB0byBwcmV2ZW50IG11bHRpcGxlIHVzZXMgb2YgdGhhdA0KPiBidWZmZXIuDQo+
IA0KPiBNYXliZSB3ZSBzaG91bGQgcmV2aXNpdCB0aGlzIHdpdGggTWFyay4gSSBjaGVja2VkIGJy
aWVmbHkgYW5kICd0aGluaycNCj4gdGhlcmUgaXMgYWx3YXlzIGEgY29weS4NCj4gDQo+ID4gKwkJ
aWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkJKnZhbCA9IEZJRUxE
X0dFVChBRDM1MzBSX1JFR19WQUxfTUFTSywNCj4gYmUxNl90b19jcHUocmVnX3ZhbCkpOw0KPiA+
ICsNCj4gPiArCQlyZXR1cm4gSUlPX1ZBTF9JTlQ7DQo+ID4gKwljYXNlIElJT19DSEFOX0lORk9f
U0NBTEU6DQo+ID4gKwkJKnZhbCA9IHN0LT52cmVmX212Ow0KPiA+ICsJCSp2YWwyID0gMTY7DQo+
ID4gKw0KPiA+ICsJCXJldHVybiBJSU9fVkFMX0ZSQUNUSU9OQUxfTE9HMjsNCj4gPiArCWRlZmF1
bHQ6DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gK30NCj4gDQo+ID4gKw0K
PiA+ICsjZGVmaW5lIEFEMzUzMFJfQ0hBTl9FWFRfSU5GTyhfbmFtZSwgX3doYXQsIF9zaGFyZWQs
IF9yZWFkLCBfd3JpdGUpIHsNCj4gCVwNCj4gPiArCS5uYW1lID0gKF9uYW1lKSwJCQkJCQlcDQo+
ID4gKwkucmVhZCA9IChfcmVhZCksCQkJCQkJXA0KPiA+ICsJLndyaXRlID0gKF93cml0ZSksCQkJ
CQkJXA0KPiA+ICsJLnByaXZhdGUgPSAoX3doYXQpLAkJCQkJCVwNCj4gPiArCS5zaGFyZWQgPSAo
X3NoYXJlZCksCQkJCQkJXA0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IGlpb19jaGFuX3NwZWNfZXh0X2luZm8gYWQzNTMwcl9leHRfaW5mb1tdID0gew0KPiA+ICsJQUQz
NTMwUl9DSEFOX0VYVF9JTkZPKCJwb3dlcmRvd24iLCAwLCBJSU9fU0VQQVJBVEUsDQo+ID4gKwkJ
CSAgICAgIGFkMzUzMHJfZ2V0X2RhY19wb3dlcmRvd24sDQo+ID4gKwkJCSAgICAgIGFkMzUzMHJf
c2V0X2RhY19wb3dlcmRvd24pLA0KPiBBcyB0aGVyZSBpcyBvbmx5IG9uZSBkb24ndCB1c2UgYSBt
YWNyby4NCj4gDQo+IA0KPiAJew0KPiAJCS5uYW1lID0gInBvd2VyZG93biIsDQo+IAkJLnNoYXJl
ZCA9IElJT19TRVBBUkFURSwNCj4gCQkucmVhZCA9IC4uLg0KPiAJCS53cml0ZT0gLi4uDQo+IAl9
LA0KPiANCj4gPiArCUlJT19FTlVNKCJwb3dlcmRvd25fbW9kZSIsIElJT19TRVBBUkFURSwNCj4g
JmFkMzUzMHJfcG93ZXJkb3duX21vZGVfZW51bSksDQo+ID4gKwlJSU9fRU5VTV9BVkFJTEFCTEUo
InBvd2VyZG93bl9tb2RlIiwgSUlPX1NIQVJFRF9CWV9UWVBFLA0KPiA+ICsJCQkgICAmYWQzNTMw
cl9wb3dlcmRvd25fbW9kZV9lbnVtKSwNCj4gPiArCXsgfSwNCj4gPiArfTsNCj4gPiArDQo+ID4g
KyNkZWZpbmUgQUQzNTMwUl9DSEFOKF9jaGFuKSB7DQo+IAlcDQo+ID4gKwkudHlwZSA9IElJT19W
T0xUQUdFLAkJCQkJCVwNCj4gPiArCS5pbmRleGVkID0gMSwJCQkJCQkJXA0KPiA+ICsJLmNoYW5u
ZWwgPSBfY2hhbiwJCQkJCQlcDQo+ID4gKwkub3V0cHV0ID0gMSwJCQkJCQkJXA0KPiA+ICsJLmlu
Zm9fbWFza19zZXBhcmF0ZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1JBVykgfA0KPiAJXA0KPiA+ICsJ
CQkgICAgICBCSVQoSUlPX0NIQU5fSU5GT19TQ0FMRSksCQkJXA0KPiA+ICsJLmV4dF9pbmZvID0g
YWQzNTMwcl9leHRfaW5mbywJCQkJCVwNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBpaW9fY2hhbl9zcGVjIGFkMzUzMHJfY2hhbm5lbHNbXSA9IHsNCj4gDQo+IEhtbS4g
WW91IG9ubHkgaGF2ZSBvdXRwdXQgY2hhbm5lbHMgYnV0IHdlIGhhdmUgdGhlIHN0dWZmIHRvIHJl
YWQgdGhlIG11eA0KPiB2YWx1ZSBvbiBhIHBpbi4gIChOdW5vIG1lbnRpb25lZCB0aGlzIGFzIHdl
bGwpLg0KPiBJZiB0aGF0IGlzIGVuYWJsZWQgSSdkIGV4cGVjdCB0byBzZWUgYWxsIHRoZSBpbnB1
dCBjaGFubmVscyB0byByZWZsZWN0IHdoYXQgd2UNCj4gbWlnaHQgcmVhZCBieSBwdXR0aW5nIGl0
IG9uIHRoYXQgcGluIGFuZCByZWFkaW5nIGl0IHdpdGggYW4gQURDIHdlIGFyZQ0KPiBjb25zdW1l
ci4NCj4gDQo+IEknbSBmaW5lIGlmIHdlIG1ha2UgdGhhdCBhIGpvYiBmb3IgYW5vdGhlciBkYXkg
dGhvdWdoIGp1c3Qgc3RhdGUgdGhhdCByZWFsbHkNCj4gY2xlYXJseSBpbiB0aGUgcGF0Y2ggZGVz
Y3JpcHRpb24uDQoNClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLiBJIGFncmVlIHRvIG5vdCBz
dXBwb3J0IHRoaXMgZm9yIG5vdywgYXMgSSBuZWVkIHRvDQpmdXJ0aGVyIHVuZGVyc3RhbmQgdGhl
IGltcGxlbWVudGF0aW9uIG9uIG15IGVuZC4gSSdsbCBzdGF0ZSB0aGlzIGxpbWl0YXRpb24NCmlu
IHRoZSBwYXRjaCBkZXNjcmlwdGlvbi4NCg0KPiA+ICsJQUQzNTMwUl9DSEFOKDApLA0KPiA+ICsJ
QUQzNTMwUl9DSEFOKDEpLA0KPiA+ICsJQUQzNTMwUl9DSEFOKDIpLA0KPiA+ICsJQUQzNTMwUl9D
SEFOKDMpLA0KPiA+ICsJQUQzNTMwUl9DSEFOKDQpLA0KPiA+ICsJQUQzNTMwUl9DSEFOKDUpLA0K
PiA+ICsJQUQzNTMwUl9DSEFOKDYpLA0KPiA+ICsJQUQzNTMwUl9DSEFOKDcpLA0KPiA+ICt9Ow0K
PiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjIGFkMzUzMXJfY2hh
bm5lbHNbXSA9IHsNCj4gPiArCUFEMzUzMFJfQ0hBTigwKSwNCj4gPiArCUFEMzUzMFJfQ0hBTigx
KSwNCj4gPiArCUFEMzUzMFJfQ0hBTigyKSwNCj4gPiArCUFEMzUzMFJfQ0hBTigzKSwNCj4gPiAr
fTsNCg0K

