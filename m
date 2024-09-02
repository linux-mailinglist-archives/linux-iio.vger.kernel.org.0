Return-Path: <linux-iio+bounces-8976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82389684F0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7692890FE
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F238E185924;
	Mon,  2 Sep 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="ICpLD+yQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0B18455E;
	Mon,  2 Sep 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273495; cv=fail; b=U61/NQRMnqqJtPUJDlhxeewUqFYGgKN6XXKfFgdJebkDp25882snexomnSFXkoQTLfl8tDfOiqKjXMF7GIlzsBuYuIKwjwAzD8czSQ44qvZIiswuLaD3fcRyfRSJxQZcQmOfN6JviJG4J3nhY+NKjSBkclK1YqfdM2Ti/28l2kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273495; c=relaxed/simple;
	bh=77/Zzau9nlN9s/EjQKL38Qsw4wT6xmViPMwliTlomJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WEFlx0JC3I1YFRQTwL2q7Zf1z9RrciXlOpNbqS7pYZpMreer/+JY2mC/cKs9/Dx69jpp8Qekz4Br8kBdyI/wpImJ8B1Nzxc/1doO5+Y/YqWiQWB5fhROFi05mTAHiRwznhpHEzcl2j9V8V/29/nm54emAP7eARRt0UTEdvvpJIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=ICpLD+yQ; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 481Mjolt022496;
	Mon, 2 Sep 2024 09:51:58 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010000.outbound.protection.outlook.com [40.93.77.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41bvhk14ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 09:51:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY1a4eywfFUDE9o/owpWNfKaOgGIu9msZGE/dCzpezViKpstgTBflyxGVyW1Eldh74aK4hKwDQN4PkFtQBbBeyHdjnYBRQNsqBAn7NEsvB+ZkXIb/af18Iv0tWgt9+2RfA6iL42sVOp+cuYQjr5iSWlWxjAwukRw5DwAxNRNAu+jT8mwqx1datpYeVqR1rjEs00yzntoVIC1ljt+xQuzl8iq+aHOMQy7ix7YdxCchXXp8EEpvufdSmtsg0DHo7PPF5YYCuVyIhyZeR1kw3s3uiTFSvuGx1nz5/AmqELrqnmoMcNwObsx7gTdlZ6A65nmqzFnCwDjzF5HJO7ZJLE1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77/Zzau9nlN9s/EjQKL38Qsw4wT6xmViPMwliTlomJo=;
 b=fReclcvXkk0eC0dvQ0pLFPGTaz64K2iVmVkrjeEleLvFtbjveU6Vpdu6suwRw8qCEv+2XRJXSI58q+e2qPDo2gXwnFQt9es6fx4WUPdjz2xlgy0ANRaiSiv2kX1AnPdssKT00kZ0vBC9DD5YU65OuqLFz49wZ5PMlbf/lCGpUIJljGi4fwrqJ72iIRf2PnmfgEVxoKoW4Ww1RhaXpjWyppaz/CGfNPeR6Nrjtkpitc0ZnLVIKOv3uo6Q8S2WDOQKPgt+erwUxAqCQ1ZE6pd8dcqusVrOviSHzrBPfQ5pbSdwjNEKLHfasUF3MMOU4+0U1/8elxtKaQusl3GW2hxg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77/Zzau9nlN9s/EjQKL38Qsw4wT6xmViPMwliTlomJo=;
 b=ICpLD+yQvAOtSrQLDyYZVxnWxI/nR0S1DqeHyDZN7Yawl2rzdEWWZro28tWwoYiEd5Ol2tgvPaH57mrWSZfbqxfnfScUxHubfMTlqCRRozu1bDL0BtSLxX4RamCuviIe21F0X46ohblYr3zwZvHxIzHPmsdWRtaOwVXeATQC+ZYaDitF9C6DPsW9WZvlF1IwTKmuG5uKp/9MZrU3exAHuIfOtSQeWu5oclNL6EzjDJkMY/QUfNFWES6Lf2QJbQ+ljHV+AJmY8bmJhexHd7mC6CI008NelFnlUIesglamCUzE/dFP6VTSqfmg0I8XnbgZdpr5DEL/bxAPNtDPyITpiA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB2116.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 09:51:50 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 09:51:50 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: gyeyoung <gye976@gmail.com>, Jonathan Cameron <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Remove duplicate code between
 labels
Thread-Topic: [PATCH v2] iio: imu: inv_mpu6050: Remove duplicate code between
 labels
Thread-Index: AQHa/Ge6DdRk9WE/nECUfjBCIJGKC7JC+PcAgADD+YCAAISoRg==
Date: Mon, 2 Sep 2024 09:51:49 +0000
Message-ID:
 <FR3P281MB17577DB7CBA7F68A3DB2D4B4CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240901120839.9274-1-gye976@gmail.com>
 <20240901151150.77074133@jic23-huawei>
 <CAKbEzntnDGXFCgpscGSg-E-1VraE9J+kTwOsCocmu9N5Agxt-Q@mail.gmail.com>
In-Reply-To:
 <CAKbEzntnDGXFCgpscGSg-E-1VraE9J+kTwOsCocmu9N5Agxt-Q@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1P281MB2116:EE_
x-ms-office365-filtering-correlation-id: 11997a3d-14d4-49d8-e266-08dccb34dd4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QnQwZFgwc1lWQWpteW56cWtjMkdjSjdCUS9ORytPU1Z0N0dveTY1bkVOaUhH?=
 =?utf-8?B?bFFwd2ZicEJoRUJLcTN0OHhmS05mcjhVb0ZvcVA4bmp6YWNpcDJSdHNpbFJQ?=
 =?utf-8?B?TFpEalQ3MFhMRTVtR2V3WHNqUmk3S0hSNitONzV6akFuc3YrL1VZdmZkVkVB?=
 =?utf-8?B?MzhHSmNYUnl0WVh4dUpzZHhSR1V6ZzZmTDBad1NGcTRkUHBZSXNCd3p1S09T?=
 =?utf-8?B?SlhpOS85T0RHMEI4aGpFZUNnbnpPTjIvdlAvREZFTDJHeE5OZHVaZWtYNDM3?=
 =?utf-8?B?UjR4M0xSTkc2TGMraTNqWTFzREphUEc2bXoveStPYitLWEdUQ1pyaG1BODJE?=
 =?utf-8?B?V21vQU9PNDZTbUdWZlNqM3BlOVhUSmVBT2I0SHlJWHpJOFNQMVZyVHFOS0dF?=
 =?utf-8?B?cUlQc0szdTZ2UUE1Ukxna29aOG1uMGN5SWJibXV5SlMzTFczWjBBSEhsVWxu?=
 =?utf-8?B?WUo2NU9XL1owdWRPSGZBYjR3dVQ1OExqN0F2akpLYVhrVXF3MDdhUU00WEx4?=
 =?utf-8?B?RllJYnlZN2ZweEhZcFVYTGR6cVNYQWJSRzhwZVJ1azA5M2FiK3ZrOFdUcC9G?=
 =?utf-8?B?MGhHTTQzYng4NU9MMHhJZlA0c2hzSk9ZT3p6L1M3SUZXSnRFYzNTSkpMOEJI?=
 =?utf-8?B?UWlKY2ZiZnA1QnRwUitRQkNvb3V0NXY1Z3kwWHdmVk0vUUZ0aW9SczVzeDdm?=
 =?utf-8?B?NnlYQWxRYWlhZExkQUJQL3ZQNFRhemdReXgwaUxYMnpyRU1waitiRnJTTFZx?=
 =?utf-8?B?cXNXdi9nM2RwLzdqVWtNejBmUElSVytXZW1rRXp2RytVc1VTbFRsTW15RUp1?=
 =?utf-8?B?bm12czRTOCtkVG1yZktvU2YwMkFKNkdzTE50VFp6MnNkUDF6QWxEbGYreCtS?=
 =?utf-8?B?M1JIVno2QktrWCtINVRHdmM0VThoa1FDK0ZZNUdrK2EzVlJSSVFVOE1STEJw?=
 =?utf-8?B?T0s3dmF1OUh6NVk5MUc3ejYwQ0cwbUVLeEt4YU83aEhYRjVmVC9nTk02VzFR?=
 =?utf-8?B?bVF5UlFjS0xLdVk3aW5CaHlVRTlycHlQRVYyTklzZFQ3cnRYblZmWjlOdFd3?=
 =?utf-8?B?N0x0VHZQWExqUGtkUjVvSldReWx6WVkvV3UvUjFwY2NkTVBKU2dQSTFBMXZE?=
 =?utf-8?B?NzA3MHU1Q3VwRFJudWJtVnZPUUV4dU0wUVBFVkYrdUw5bUIxQnpGRE4xVlp4?=
 =?utf-8?B?UlI1L1EvSVpuOGdzYkQvRm16clBUZjVucFUxVGNyMmR6MmxPQUJUMTRwY0hJ?=
 =?utf-8?B?OWc5cER6TTFqUmd6OWoxVkt2aG5EdzVQRUs3VVAzbERFV0ZoOGo0bjQ4SXU1?=
 =?utf-8?B?VXJsa2lDSmMwUFE5TUI0TjUvZ2hPeXpsUHpscGhLVHphWTVHOTRVdExYd1A4?=
 =?utf-8?B?L0dHbXhZNERScFYzMFp5SXByUFc1T0htcHRUSHdpR09UeDQ5MlVWRkdLdmFL?=
 =?utf-8?B?U2NoaW50V1FTaVNKblpvaEE2Mm5iS3BRZnBMczdDa291UjlkZmRHTGpSc3c4?=
 =?utf-8?B?ZGhyUXFEM01XQjJGeGJWYm84VWNrUGdJdTRVUnpyZks4MkJEZDg2aGQ1Z0Z6?=
 =?utf-8?B?NTVDcFVrdzc3cEs5MFd0cURibVU4RDVEc282Y0VZKzFsR28zU0FJZ3A3Z1Mr?=
 =?utf-8?B?VHpJQTVlSXRYaXgyZEdVUTAyZkpza01JeXpPMEVCcktPM1JZeUZaM2JoaWZj?=
 =?utf-8?B?WGxhOWx1RkY2bU5DcDgyVFgzTjZncEthQVBkeWhxdDBVdjBTYWlRam1NUUtG?=
 =?utf-8?B?dlhrUTRSYkRId3ZKbGFad2J0K3lzZ2U2VmxYT3ZoNzBvYU9HcGJTSE9Ba2ZY?=
 =?utf-8?B?OHlpb3BKbkRPSDN3dzJkaU9QUzROYmNvVkdNRFFvSXdrYzVGemRGOTJydDhX?=
 =?utf-8?B?bFRrNHg0aGVtaFE1T1lNUHNVZ3E1M0lMYTR0M0t2L0tjUWpOZk14QzRRdUJZ?=
 =?utf-8?Q?XwEAZdcQv2Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEplOEpHRndaZGltaVdGRXdtbDJFUUZYbUlOdG5iRThneGVFYWZBUHdHR0tj?=
 =?utf-8?B?d3B1WnIzQmdBNWRuemxuVGQ2cUtaZ1ovUkFxcE1IQXBMZHhremlVOFlVLzVs?=
 =?utf-8?B?dVhZcG9Ga3N5eWRDdTh1a0hXNm95Nko3WlVBZEFPdkVKbjhFQjhHeTJNUUZC?=
 =?utf-8?B?MXc3WTZXODFHV045QXRlYWp4Z2pXYXBmbHBMMWpXQjFYT0UrNE0wczNnbkRS?=
 =?utf-8?B?NVBSTjJpTjg4dUFkZ0pnbkVpdWJkRy9VbVlBMmUzTFhtbnZaTkVNSXV6R3Fq?=
 =?utf-8?B?SG5VNExhb21BY2V0T016a1JEckI4S0Y3MGEzbEkyVWNFdDZESVhjOStGZExU?=
 =?utf-8?B?d2pXVWlqNGtJSEI4a2RlQ0xCWWNlN2VDU1N5S3FtWmlqNC9IQ0Q4ZVJJV2la?=
 =?utf-8?B?VCt4a3MrVHB4VGhUZmdFdXJrS2d6dEhzaDVBcnQ1S0dnQngxcGlhSjVXSVY3?=
 =?utf-8?B?dDlHUlZnV2hHa0NwbU5ZSW9VVlVsUExWY2pwZHB3bzlNMGlBNnVhcGpFeS9D?=
 =?utf-8?B?K25lOERZeWpTZkZlQU1CYlNZWFVYWUIzdS8wdXFHSjczOVZqdXhoUFlIR0tx?=
 =?utf-8?B?RkNkWFlxeTMzWXM1Y0krMDI5eEhUejExeG80WHhqZTNSNkZ4SXdkbVdSN1g4?=
 =?utf-8?B?ajdJd1gySmp6TmJ4cHlzRitDTkpxU3lGc21adVJJeFJQNmozdWl2NXVPWWRC?=
 =?utf-8?B?TmFWMWRGYkxDM2l2cjhUMTRWaWlqcDkxMmY5RVlNWUNsdlBnZ2hJU0YyblNS?=
 =?utf-8?B?bDFDSXlrbStaZXdZeFZ1Z2U2dXZpNTdLZzdrWlZjUHBSVzI1bG1YT2d6dk4v?=
 =?utf-8?B?eXdmTXdUc01wSUwzUGxCa0cxYjA0TjRod2wzbGV5dS9TNkdKbHNGN29GRmtT?=
 =?utf-8?B?dHZGU0ZqZjYvZUZzQjU1TlZONDlUYlpYTkhDMU5MVERQL0Fsd2lyOWlDOU9U?=
 =?utf-8?B?Tlg5bEg3ZU9qd0Rvdk0vRzVwRUtGVXJGSFVDbElsZEdBY0ZFRUtnMFU0c20y?=
 =?utf-8?B?UFc2Z0VpSmpQVzVHRWNTT3d2TEJLeFRYMEhRb0JzZExtcG41UndZNzBEcDA3?=
 =?utf-8?B?N0FrajZiUU5MY04xNHdnVEdEYzhRMUxLWUs2Q1Azb2VkWEJXaGdFc0k1c2FU?=
 =?utf-8?B?RlJ0dzRPWlN4bm43bzVQdXRrRXZaMTFGcllpMDF0VStVRGxGcEtJK2g5ZWNV?=
 =?utf-8?B?MlBad293U1UrMUcwcmtzNHhpa1FOY3p3cHNMenMreklwTEVETm5pb2V6M21M?=
 =?utf-8?B?ZElRL0ZmdjNDd1kwd0dESVVvaGg2SkgvSHZ5aG5XUndNMjk5QXpQRmZUUVkw?=
 =?utf-8?B?MXNMSG9aYUczbmlRTkNGK29ncjhtS2grNDhTT3JCcXJleGVwYVNQZHErbHBN?=
 =?utf-8?B?eVBDc3YvNjJoRFlwdkpyOVczbFJOc253ckdqWUYzQXIyeXBOY1lUQVpLME1t?=
 =?utf-8?B?OGEvRjkyeTE5cDZoY1NxbkFYYjJlSFlwVE1FcGdTdzN0MHJrUGRNeVI4aDFx?=
 =?utf-8?B?T1RwYWNaSTNwakx2c2R5a0lwZkFuT01EdERIS3UzZlNGbGpRdVdpMkY0TWcx?=
 =?utf-8?B?NzUveFlERWh4dEMzalpjdWEzMmpTWFJGSnR1WlpJL08rb28wL2ZSNXJHeGk4?=
 =?utf-8?B?OVRGbFBHdnh1THJUbmNDMUdlSGs4SkN6MUowTWJyY1lIaUFMUlJSS2FnY05o?=
 =?utf-8?B?YUVMTE5XQ3haMm5rYzR2bnFQZVBoajdmZWI5dDlIazVnTEEyWllkSTU5UXIx?=
 =?utf-8?B?b2J3S3hQMnd0SWl4L0RzbnVrbEF3akhaTmFCaW1Ma0NubXBIV2l1cTljL3g2?=
 =?utf-8?B?YzloUy9zUkxqTllTazZyNjZZRDhyUDNoZkkwQ2hZblpHNDRlWVJLbmMzVU9l?=
 =?utf-8?B?WEgvRldFdkpQenF3dWtaMWJZbWxkWiswbTFMQUNuL2J6eUhhWkhkYmcxbllQ?=
 =?utf-8?B?UGt0NG82TlZsZUhGRVh3NXQ3RS8yc2FCRmFiTS9obzRRanpZY3FkTXhtc0dH?=
 =?utf-8?B?QnBzZTZQZWNQdTF1MVZPQVAxU1FTbzdyaDBCODFkdGVKdVRyUk8wa1lqRHNq?=
 =?utf-8?B?SEJ0RlhuU3NUcDI2S2U5N2FkZ3lwekdabEcxUm5pOW4zcWFxdmVqa2VGVXB6?=
 =?utf-8?B?YVRBV2lvcGlyQmZ6T04yZG0wdDUzOUFET1YxVDF3VkZXbUdqQWJwZGRVY3Ft?=
 =?utf-8?B?NXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11997a3d-14d4-49d8-e266-08dccb34dd4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 09:51:49.0691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Ujm9Qa/kk0eS+H5HTbqrXz91lRHPTmarpoovHIhGitpb+siXVKo2nUR9Ma5jcAcqB7ERVWt/ebY7x6qEhLXZBif57K7lryL9WXzfPpKT34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2116
X-Proofpoint-GUID: QMl0AOes0VeWH8vKNt686QCMFYUy244C
X-Proofpoint-ORIG-GUID: QMl0AOes0VeWH8vKNt686QCMFYUy244C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-02_02,2024-09-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020080

SGVsbG8sCgp0aGFua3MgZm9yIHRoZSBwYXRjaCwgYnV0IGJld2FyZSB0aGF0IHRoaXMgbW9kaWZp
Y2F0aW9uIGlzIGJyZWFraW5nIHRoZSBjb2RlIQoKWW91IGFyZSBkZWxldGluZyB0aGUgbm9ybWFs
IGZ1bmN0aW9uIHBhdGggcmV0dXJuIElSUV9IQU5ETEVEICh3aXRob3V0IHRoZSBnb3RvIGVuZF9z
ZXNzaW9uKS4gV2l0aCB0aGlzIHBhdGNoLCB0aGUgcmVzZXQgZmlmbyBmdW5jdGlvbiBjb2RlIGlu
dl9yZXNldF9maWZvKCkgd2lsbCBiZSBjYWxsZWQgZXZlbiBpZiB0aGUgSVJRIGhhbmRsZXIgaXMg
ZnVuY3Rpb25pbmcgY29ycmVjdGx5LgoKVGhpcyBpcyBhIG5vIGdvIGZvciBtZSwgSSBkb24ndCB0
aGluayB3ZSBjYW4gZWFzaWx5IGNoYW5nZSB0aGVzZSAyIGxhYmVscyBhbnl3YXkuCgpCZXN0IHJl
Z2FyZHMsCkpCCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyb206
wqBneWV5b3VuZyA8Z3llOTc2QGdtYWlsLmNvbT4KU2VudDrCoE1vbmRheSwgU2VwdGVtYmVyIDIs
IDIwMjQgMDM6NTMKVG86wqBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPgpDYzrC
oGxhcnNAbWV0YWZvby5kZSA8bGFyc0BtZXRhZm9vLmRlPjsgSmVhbi1CYXB0aXN0ZSBNYW5leXJv
bCA8SmVhbi1CYXB0aXN0ZS5NYW5leXJvbEB0ZGsuY29tPjsgbGludXgtaWlvQHZnZXIua2VybmVs
Lm9yZyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+ClN1YmplY3Q6wqBSZTogW1BBVENI
IHYyXSBpaW86IGltdTogaW52X21wdTYwNTA6IFJlbW92ZSBkdXBsaWNhdGUgY29kZSBiZXR3ZWVu
IGxhYmVscwrCoApUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBVbnRydXN0ZWQgU2VuZGVyCllvdSBo
YXZlIG5vdCBwcmV2aW91c2x5IGNvcnJlc3BvbmRlZCB3aXRoIHRoaXMgc2VuZGVyLgrCoApPbiBT
dW4sIFNlcCAxLCAyMDI0IGF0IDExOjEx4oCvUE0gSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBTdW4sICAxIFNlcCAyMDI0IDIxOjA4OjM5ICswOTAwCj4g
R3lleW91bmcgQmFlayA8Z3llOTc2QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiA+ICdmbHVzaF9maWZv
JyBsYWJlbCBwZXJmb3JtcyBzYW1lIHRhc2sgYXMgJ2VuZHNlc3Npb24nIGxhYmVsCj4gPiBpbW1l
ZGlhdGVseSBhZnRlciBjYWxsaW5nICdlbnZfcmVzZXRfZmlmbycgZnVuY3Rpb24uCj4gPiBTbyBp
IHJlbW92ZSB0aGF0IGR1cGxpY2F0aW9uLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEd5ZXlvdW5n
IEJhZWsgPGd5ZTk3NkBnbWFpbC5jb20+Cj4KPiBPay4gVGhpcyBkb2Vzbid0IGdyZWF0bHkgYWZm
ZWN0IHJlYWRhYmlsaXR5IGFuZCB0aGUgY29kZQo+IGVuZHMgdXAgYSBiaXQgc2hvcnRlci4KPgo+
IEFwcGxpZWQKPgo+IEpvbmF0aGFuCj4KClRoYW5rIHlvdSBmb3IgYXBwcm92aW5nIGl0LgoKLUd5
ZXlvdW5nCg==

