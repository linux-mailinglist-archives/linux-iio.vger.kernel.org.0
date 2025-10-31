Return-Path: <linux-iio+bounces-25730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C1C2482F
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 11:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F04D94EEE33
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C188334C09;
	Fri, 31 Oct 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="inY1G39w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE752356A4;
	Fri, 31 Oct 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907010; cv=fail; b=Ayy2OBPSNhB/DEF9s8Sr1Q4cI3SeTloI2QQUy+cWHPcNytVc8VzOwrLCHxCUHbc6/uukvDEYv921gfAf6Zvu6XOP+SMg2IOg97eul3qEHelidBkIt4mNGVPbN1Sbeph9CuDgjP/MaA521xQ2rrI8/+swAsx5bAdqO0jkIseuouM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907010; c=relaxed/simple;
	bh=ERaw94WGcBayvMYStuomyUB4gkjtbDfjG+/2SqNj61M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IX/mVEpeTrShlMrjg0jcCZoaq4w86Cmr0LcZ/tXceljorEFepBl2nQz4l9Ii1jwKWIvN9n9u2ArMnoSx5qlV+yR5Yu0R16wLih+m+S3pYb/R23J81tnh7bkeAMPTfo9hfTlildLFFug+4TIRqgZf6UFzHiA+1RRD+sxwd332K/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=inY1G39w; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UMFiGo2547824;
	Fri, 31 Oct 2025 09:56:50 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010006.outbound.protection.outlook.com [52.101.169.6])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4a349sjem3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 09:56:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLYi+xKThdUEY3P5xgIXsd0Hk5usci+s2ncTqnr9+zpEvS1+xyB8NGjLBmwJgoxTbEEnc+l7sUbf6tNuMxG3xk0aQAbehdGjnIg3acwqhEw/BJSnx/gP3nf87K0SiyWexJWDZMMICF3WhGNJmIQ3thHnvZCEiOKr3SxgT/WIVbnZsV2CHVBYsA31123fdrsnZDi5OWwhSx1k1A3C6351llAVJr4veF2GDOUhdcO5mSyZKivQkCPnZrjg0APw2soXRDTjd4qB61YbBuxH4uFCqjET429ST3anNUSt1KWtMefNolz08XpZFZX0HA7Ab255HPG6K0ooA1zAnqtO9ynDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERaw94WGcBayvMYStuomyUB4gkjtbDfjG+/2SqNj61M=;
 b=OnW0SjyEC3jsF/FYPdTzeI7tXjJ8d8aqa/I63yd5nKX07SGEH6aB8WOKuOYwgWwBMEQcQwLRuYfyjXhW2a1rrQL847o0Dy/sUs0/kgmXeVqInxkFv1zk+Ed5sHTmaQoS/NOo5bUO4EjOH92j39fG1Aq22K/jXejU9M0MXgUuH5xxSe6MEP8iMVKTYvX0PLDQEDczl0HqsUc/lpwQ4eaF0PFzdUELmcUUHw2riUn5AGpWq2SifTUGaDZPCXdomuUMCljiqyU2tZGjtZGYCDJs8qB1UdLwp8dwrbqvuBIX7z/eeLT0rrA8PFcc6Ww5O1jtc3FpJRIRfU+tLTT67pYz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERaw94WGcBayvMYStuomyUB4gkjtbDfjG+/2SqNj61M=;
 b=inY1G39wZF2eo5X0vFfqDDyCo1RcGNHEVs0AcQd/rMUiORrJr/kphdl0uc6ip7DULY4VtrsqK1YvwcYdFtbMY3UXfK3JMPiIYLuypB9GI8+heNy8PIL5R1K2cSFJIvcVm0aoTsMYQeTZrlsJWsYvQhMUExorKEM4Gn+yRARGN3EEQolwNezEHhVesEa1tnBFphrdx8OzGqyD0LNc/nrTF3ILYxDSneRWgOPrTBJ2BVM8cnHApi/oqydmq3UpjlFIAGxCtKGPwfKQda+C8dEtEEForGTAZGBsMFiNbuGkDLnNpGXeAt7wRlGDNaowjx4DEOLwp/zu1lKeTUjTJMJpBw==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BE1P281MB2404.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:56:45 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::495:8823:ba38:6fd4]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::495:8823:ba38:6fd4%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:56:45 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Dan Carpenter
	<dan.carpenter@linaro.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] iio: imu: inv_icm45600: Add a missing return
 statement in probe()
Thread-Topic: [PATCH next] iio: imu: inv_icm45600: Add a missing return
 statement in probe()
Thread-Index: AQHcQ0NgmaHifEj6H02N/ifkvp2AGLTWFAOAgAXp6SA=
Date: Fri, 31 Oct 2025 09:56:45 +0000
Message-ID:
 <FR2PPF4571F02BCBB9894C421F5472EDE968CF8A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <aPi5vEp75jH0imQc@stanley.mountain>
 <20251027142331.29725dfe@jic23-huawei>
In-Reply-To: <20251027142331.29725dfe@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BE1P281MB2404:EE_
x-ms-office365-filtering-correlation-id: 4b73abcc-c727-4298-f447-08de1863cd2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzIzOWFyMnBBLzhlNFQzcWNhS3haaTRLMkdNOUkwYS85bFdoMWxDbStueFlE?=
 =?utf-8?B?dzBqM0NmaG0xZEJ2OHZLRXJ4OWlSVFU4UVZzNERkcENhWVVTakhGR1U0UC81?=
 =?utf-8?B?dFRST0lwbTlMa213WGQ3b2hHc1RLTjR4V0w2QWFzcjc2T3VzekJYQmpnd2lD?=
 =?utf-8?B?Z0Q4a2JJWDEvR2N6b0VIZGsyRlZCS0tvNU0rd3gxMHBFZGNzYUNSb2gzaGZE?=
 =?utf-8?B?ZFBUclFkdHRid2E3L2d3ODVKZ2gwV1NtbHcvays3L1VwckNmY05DbXBUUVhZ?=
 =?utf-8?B?cnBCV1l1eTBjbmJLTWRvZlROWHVreHZXM2pOWk9XZk8wNVhjazlaNWhSYkxB?=
 =?utf-8?B?dHJMekRoTnNOWTF1RFphQzg2eHVKTmZTcVFFZ0JOUDhQYWR1ZUdtbXVMc1RY?=
 =?utf-8?B?WnBpOGJsYW1QZWFrTFZDZG1sYVV1clZpWTNCVFpjQjRUVm91M0NEYUdqZDdt?=
 =?utf-8?B?cE1KQms5VUUwVEJXbEdNOXdpWjBNdmo2b2dYZFBRM01KdnJiOHUrUUNrdE4r?=
 =?utf-8?B?SEpoN1JjbGNLREpkbjd6MjcyRXVMMEZrN3dqZytxUU14N3ZKUWN3N1VHRndG?=
 =?utf-8?B?MVB5bHhMNDVnOXRyWVJsdHdiLzhJWXlCQmtXOXM4eGFTNzhTbFdnMVZQVzkz?=
 =?utf-8?B?K0VpcE5rVmJ6MTRuZ2xzU2dmRVREbi9XWEJ2UCtTOHNDb3dyMmNsSFhBS3BP?=
 =?utf-8?B?MDBRS1FmeitxR3FFMUV1MG9XVzc4bGx1SjBvR0kvamNiN0Z5dnVtYXVFRXhM?=
 =?utf-8?B?R2g1WlduOWVpVVc2dzlQTjNYdjhRLzA4bk9rdHJkQUowM0pYRFRyTjZOeHFI?=
 =?utf-8?B?SHFVQXRzNEJsWWNkaU4rMGN6NFpodzhIU05BZVZyUHNkSU1xV21uQkErWWxP?=
 =?utf-8?B?ZEIrMVZYZUFqeUtaQmt1NW4yQXJ0d1NEa0Z4eDRnVTBleWNQU255OE4rK1hY?=
 =?utf-8?B?VFJWeFJEQk5TNDdwbkIySHBIeXBHMTZsZmVDSlhKNE1PVE5mVEhBWGZ3VE1z?=
 =?utf-8?B?UWJoSHpreWhORVBuVlBiajFFUGNzM0lDZ1hEZDQxVy9LTzdEOEMrYStmUDlz?=
 =?utf-8?B?dll6a1BLdU45L0loRXh5WkhzQnI4eFU4TmI1bXVqM05UVjdZUlRzRWxac3JF?=
 =?utf-8?B?Nkg4akRHYURLSjBJdnZDc0NKSVUxbDUybUxNNWZjdWMyeTZRQ3N5VWJVS1VD?=
 =?utf-8?B?WTE2UnpVcExHVHhnK0ZISFUrVElJU0ZRRFpVMlhQa1JLbkYvd01DYU5EdmxO?=
 =?utf-8?B?ZG9yZGY4VlY4UHZNMUVuZ0x3OXZrK3BUZU1tTWRKWWlvbVNEdHdxVVVYcWFS?=
 =?utf-8?B?d2ZVOEc4YjdZR2pwRnk3K1hkOVNCRklmM0lUb1Zpbm1TYnZMRmg1TjZMOTdw?=
 =?utf-8?B?Sk9KL0V4blNsZjgzczNzL1dBT3ZGcU9CbEJ1Nm41VGI3NStZSy90OE9RVFRD?=
 =?utf-8?B?WmlEUTNncXlUaDg3Vklmd3A3UWcwYWlrUzJveGxSa0I5alR0U2NZOEpndUVB?=
 =?utf-8?B?a01sVW9oQ2psN042TTdXY1VIM2xWNjRzMllMYjZVMkk1WVgxMWNONDJvczZT?=
 =?utf-8?B?cVBCTUs1bmtaZklxMVl1WkNZTUc2T0UwdEJ2UWlqTUVOSktqQ0ptOWMrdkhi?=
 =?utf-8?B?Rm8yUk5sQ1NVSEh6WHY1ZlNSd1ZrcVZXUStQcHNIc3V6TFB6OU81aUM3ZGlR?=
 =?utf-8?B?NzB1T1kvTElPa3RZTU1Hc2pYOS9Wb1pYb3hpMHRSZERkZ255c09oTGU2dFRY?=
 =?utf-8?B?Y2I5aUdubk9LS1lJOEZlc2cxc2xpamdYck1Uc3NSV3N1bUVOM2lsYys0NjEv?=
 =?utf-8?B?U09lTlVLQ2tIaDBhNmNZdVZEd0ZONDYvNlVDVGtpYTY5NVJEN3NsTXoweE5F?=
 =?utf-8?B?QnVDbFYxdWpuTGt0a0JrMXJnQUZGUlBiSkI4Mzk2YXlKMmQ5RGQwL1pYUmdI?=
 =?utf-8?B?ckt1ZzVmOUhGLy9UTzJTcmxJdEFNOTg1VEoyOUM4OFdyTXNzVVZtVU5yS2FN?=
 =?utf-8?B?NVQ3UXNtRnFTUzlqaHdEVkYyRE9EVU5EMnRJZFBqOXVNaG92aVR5Y2JnODNE?=
 =?utf-8?B?ejRIaWVnME43djkvMUVrT0ZHZWVCUjliRGN6QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R25OODdoZjdQc2NubnlUWjhtdGg3NzFWQmpIdGc3aHNKMkJUTGhucmpLRzh2?=
 =?utf-8?B?OW1ReHRYbFR1S0dzME9FSUljVjhsYlNiNXZ6WGN5OHg5N1JpSHVoMlBUaElt?=
 =?utf-8?B?azAyS2ViVWNoSkpNdDhHRFdISWttcFVaTkljQnlBNkFnQmJrU2txTTMvSE9N?=
 =?utf-8?B?d2xLNW9CUjhzMlVGeU1sZGY5WnVSaGh3d3VLYVpsZGJ0MEYxS3lmMlh2R3o2?=
 =?utf-8?B?TnNrNDlJNHk2YXZTdEVzR0RBTWFVVmlUVTllMkdUYjFraWRHVm02UFNRV1Rj?=
 =?utf-8?B?bGNvdG8vTFJHb25ObTZvMFZaME9XL0RkbzFMcFN1Q3dKV0p6MjYwRGJiQVg3?=
 =?utf-8?B?RGYyVVNyN2RFdy9VSHV3cytrMTd0TzBZT3doTTJFY05nSFE0a25DMWd5M0Ny?=
 =?utf-8?B?NERpcjQyY2ROcG1YY0JUZlBiVkRBMTdGakJyeG13SVlNQWF4ckJsS3kvOUZI?=
 =?utf-8?B?SWpiRTU2UHZwaUVtR0xwYlBwRVpPSVYvRExVQ3dENHpwK2QzdFptc2Y5UlUx?=
 =?utf-8?B?Y3J1YjRDd0VVSHl0elhoQ1I2WTQ5TUV1VXA3VGFyaEIzRjNSeE5FeXlrbkR5?=
 =?utf-8?B?bHZndG9YU0F6bDQ5b29LcUNWU1Z0bTVtYTg3cXFJY2pJNlcwR1ZINnFmczk5?=
 =?utf-8?B?bDFXdytSRFdSdU44L05zY28wTFM3azZycitYaEROK2xJK3BpVzVuN3dHc2tT?=
 =?utf-8?B?TU16VDFzclJvMUQ5dHlXbzNqUjZjVnZTelFhcDNmMkJ0dFNocjg2ZFlSYlpH?=
 =?utf-8?B?c1Y2V3NSL3ZtNEl5dnpIM2J3N01JL0tJMXpWWFpneXprc056WjBuRmE4RHNm?=
 =?utf-8?B?SGdUOVAyUklEQTYwKzVtdmtrMU1vSG51ZFNFU2VJODk0UGRVd0lkOWpNa3hM?=
 =?utf-8?B?Q2tVbHFHVjBib3Bzd240RFhuZEEySFNHS0dFd2tDRFRFcE96MzBUYWRnY3gy?=
 =?utf-8?B?M2RCTWthSFk4SDlPQ2tQT1VBRjVYWTNkVm0ycGhNZHV1Y3lCekVJdnFEWnVR?=
 =?utf-8?B?MTNBNEY3VGRZVnlEb3M0dE9ZSjRmR1A2cXZNY0pESHFkWndOejJVazRrT3Ux?=
 =?utf-8?B?WlZhdC9wQmorN0pSUzBwQzZMeDNVdGQzK1BNalA3ZlJNa3pEU0dOWXozYUQz?=
 =?utf-8?B?d2hJZHhFU2NIbjdFN0pRdTdzdTVyajR6UTYzRFhFUHVXOVBHbmNmb21Xa3cw?=
 =?utf-8?B?WWczaXVKSEl1SUdTV1JCQWpFOTBjOTRxNXNialBLYUZCNVU5ZUlUL2xka2Jl?=
 =?utf-8?B?enhUbVpETkVCWWorMFZpVCtPWTFiMUxmZ0ZUMWFmYW00YVNqTERQV0dqa2Qv?=
 =?utf-8?B?UExWVFkrak5vQ293MW1Dams2QVhmZ1dPZmNjMHd0cVVCaXhWQ0N4ejRWOXc1?=
 =?utf-8?B?UTZ4QzNhSzZqSVF3R1E4d0ZVUTh3cXJ6bVFlb3NwWllhaURTbUVVNkhGMUV0?=
 =?utf-8?B?bjRlOGovdDNRNENBMUU5ZEJQQ0tYZEs5TFpnOVVTbm1WaDFMWDEyMTR3OUs2?=
 =?utf-8?B?Sncrbm85U2ZLRWNNZXdZZGRDTUdKM2tXcmtoZHNTZWRXaENVb3E0b29WWnRG?=
 =?utf-8?B?c2hHa2N1dUpLRlVvRWpEOXNES2ljZFZTRjBRYU8zUlppbjhGWFZJN2NKMGp5?=
 =?utf-8?B?Q3hreGQweVg5Zm13bWdMZmtjbWdkK0cvQSs3bWJmSFNJMk9Sb0hNUkJxc1J5?=
 =?utf-8?B?ckk2OHg3bW9KOVAvaHl2SVh6WnIwTG9yeVpPeVdQK3pvUFgra3FRUXpHL2FB?=
 =?utf-8?B?TDJ4TzJuclh3NUxvOHBFd0I3dUp6ZmpTV0RUS21oWTVMODJ5bGJEMWxaQjdB?=
 =?utf-8?B?RWNCQUJvazBzMlJHeHBOZlhib1p1N0crL0xlaG9OcndSVHZmYnRQdUt5dExZ?=
 =?utf-8?B?V092ZTNnS3BMNUUrMUNNYVRqaTd2cXpFczRtWFJkQzlya2M4TnloU21zVDhK?=
 =?utf-8?B?KzVqdDVYZ3cxWHBwL0RNRUVEa29SSUtsc2VCN1FJRWt0aHZqSHBJL1c3Y0tq?=
 =?utf-8?B?eW50U0NURmYyVGtPNDdoS0pTcFJqNExvMThMMHBWZm1uMU5sQi9WejVIcGhQ?=
 =?utf-8?B?bkdFRlRLTzZEWWxTVWtBaEg1RzFLb1dRQVhtK3lCd2VaemU0eWZKakxCa21Y?=
 =?utf-8?Q?XC8XeVPSlpebwzuRYDzU4Do6B?=
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
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b73abcc-c727-4298-f447-08de1863cd2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 09:56:45.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNLW3PDKk6ZFRxsn0e7hEPk4avkaVNdXGKCre7lJSggbzJ8C8hO6ZG5uAO5Z03TiLmXhRIPrEWtWR3wuzgFtlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2404
X-Authority-Analysis: v=2.4 cv=NPTYOk6g c=1 sm=1 tr=0 ts=690487e2 cx=c_pps
 a=lH9RSMgsdOorYAAtB2SoXg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=lZrNiNJjaYuX0-grFw0A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: w9YPU2ZNh1wVrXPXpp5HpNypl5qOcA93
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5MCBTYWx0ZWRfX9aEuiUwufDLU
 LAPV2nY6rdsKwEUW72G7WIc2ObB0swKP3tMwtreZ3IraWz0Ntj6+hJ9/kZlqNMOBQBUhAXakgAi
 wvtoqDvSjye4PH/ye/1bBJntEg+wFiXPCS7Z9WV/rFt8fSKi1IX+XVzLoGEXNVtc2K4691VS8uB
 RS3rsuZf4TGcsQ1meolP5N/b/4qjG/aG82JPVS2UrAvDKWxQxtl39TxuizBq1VJS+mOdX1VBDgM
 v3EnhOiWeeZHhtZO4IN+Y54DtaErx3LWA8jqiik8Go4wFmQQ63HJoh3kmJN8UFYclWFX3Oij0vm
 70o159QSePyfWpjsa4ot3R0E1w7LBZPNjaL3YqoX2zY/Emng6HI+bS7YB0UX3XOf1fL4ONMsuNm
 kk0Mxyq/CEK2aZ55OKFINWWYQliPPg==
X-Proofpoint-GUID: w9YPU2ZNh1wVrXPXpp5HpNypl5qOcA93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011 spamscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310090

Pg0KPg0KPkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KPlNlbnQ6
IE1vbmRheSwgT2N0b2JlciAyNywgMjAyNSAzOjI0IFBNDQo+VG86IERhbiBDYXJwZW50ZXIgPGRh
bi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj5DYzogUmVtaSBCdWlzc29uIDxSZW1pLkJ1aXNzb25A
dGRrLmNvbT47IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8Oh
IDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIG5l
eHRdIGlpbzogaW11OiBpbnZfaWNtNDU2MDA6IEFkZCBhIG1pc3NpbmcgcmV0dXJuIHN0YXRlbWVu
dCBpbiBwcm9iZSgpDQo+DQo+T24gV2VkLCAyMiBPY3QgMjAyNSAxNDrigIowMjrigIoyMCArMDMw
MCBEYW4gQ2FycGVudGVyIDxkYW4u4oCKY2FycGVudGVyQOKAimxpbmFyby7igIpvcmc+IHdyb3Rl
OiA+IFRoZSBpbnRlbnRpb24gaGVyZSB3YXMgY2xlYXJseSB0byByZXR1cm4gLUVOT0RFViBidXQg
dGhlIHJldHVybiBzdGF0ZW1lbnQgPiB3YXMgbWlzc2luZy4gSXQgd291bGQgcmVzdWx0IGluIGFu
IG9mZiBieSBvbmUgcmVhZCBpbiBpM2NfY2hpcF9pbmZvW10NCj5PbiBXZWQsIDIyIE9jdCAyMDI1
IDE0OjAyOjIwICswMzAwDQo+RGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3Jn
PiB3cm90ZToNCj4NCj4+IFRoZSBpbnRlbnRpb24gaGVyZSB3YXMgY2xlYXJseSB0byByZXR1cm4g
LUVOT0RFViBidXQgdGhlIHJldHVybiBzdGF0ZW1lbnQNCj4+IHdhcyBtaXNzaW5nLiAgSXQgd291
bGQgcmVzdWx0IGluIGFuIG9mZiBieSBvbmUgcmVhZCBpbiBpM2NfY2hpcF9pbmZvW10gb24NCj4+
IHRoZSBuZXh0IGxpbmUuICBBZGQgdGhlIHJldHVybiBzdGF0ZW1lbnQuDQo+PiANCj4+IEZpeGVz
OiAxYmVmMjRlOTAwN2UgKCJpaW86IGltdTogaW52X2ljbTQ1NjAwOiBhZGQgSTNDIGRyaXZlciBm
b3IgaW52X2ljbTQ1NjAwIGRyaXZlciIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2lpby9pbXUv
aW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9pM2MuYyB8IDMgKystDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDBfaTNjLmMgYi9kcml2ZXJz
L2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9pM2MuYw0KPj4gaW5kZXggYjVkZjA2
Yjk3ZDQ0Li45MjQ3ZWFlOWIzZTIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52
X2ljbTQ1NjAwL2ludl9pY200NTYwMF9pM2MuYw0KPj4gKysrIGIvZHJpdmVycy9paW8vaW11L2lu
dl9pY200NTYwMC9pbnZfaWNtNDU2MDBfaTNjLmMNCj4+IEBAIC01Nyw3ICs1Nyw4IEBAIHN0YXRp
YyBpbnQgaW52X2ljbTQ1NjAwX2kzY19wcm9iZShzdHJ1Y3QgaTNjX2RldmljZSAqaTNjZGV2KQ0K
Pj4gIAl9DQo+PiAgDQo+PiAgCWlmIChjaGlwID09IG5iX2NoaXApDQo+PiAtCQlkZXZfZXJyX3By
b2JlKCZpM2NkZXYtPmRldiwgLUVOT0RFViwgIkZhaWxlZCB0byBtYXRjaCBwYXJ0IGlkICVkXG4i
LCB3aG9hbWkpOw0KPj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJmkzY2Rldi0+ZGV2LCAtRU5P
REVWLA0KPj4gKwkJCQkgICAgICJGYWlsZWQgdG8gbWF0Y2ggcGFydCBpZCAlZFxuIiwgd2hvYW1p
KTsNCj4+ICANCj4+ICAJcmV0dXJuIGludl9pY200NTYwMF9jb3JlX3Byb2JlKHJlZ21hcCwgaTNj
X2NoaXBfaW5mb1tjaGlwXSwgZmFsc2UsIE5VTEwpOw0KPj4gIH0NCj4NCj5JJ20gZ29pbmcgdG8g
YXBwbHkgdGhpcyBidXQgdGhlIHJlc3VsdGluZyBjb2RlIGlzIHN0aWxsIHdyb25nIChldmVuIGlm
IG5vdA0KPmEgdHJ1ZSBidWcgYWZ0ZXIgdGhpcyBmaXgpLg0KPg0KPkEgaGFyZCBJRCBtYXRjaCBs
aWtlIHRoaXMgYnJlYWtzIHVzZSBvZiBkdCBmYWxsYmFjayBjb21wYXRpYmxlcy4NCj5XaGF0IHRo
aXMgc2hvdWxkIGRvIGlzICdnaXZlIGl0IGEgZ28nIG9uIG1hdGNoaW5nLCBidXQgaWYgdGhlcmUg
bm8gbWF0Y2ggaXQgc2hvdWxkDQo+Y2Fycnkgb24gYXMgaWYgdGhlIG1hdGNoIHdhcyB0byB3aGF0
ZXZlciB0aGUgY29tcGF0aWJsZSB0aGF0IHdhcyBzdXBwbGllZCB3YXMuDQo+V2hlbiB0aGF0IGhh
cHBlbnMgYSBkZXZfaW5mbygpIGlzIGFwcHJvcHJpYXRlIGJ1dCBub3QgZXJyb3Igb3V0IGFzIHRo
aXMgZG9lcy4NCj4NCj5SZW1pLCBpZiBwb3NzaWJsZSBjb3VsZCB5b3UgbG9vayBhdCBhZGRpbmcg
c3VjaCBhIHBhdGNoIG9uIHRvcCBvZiB0aGlzPw0KPg0KPlRoYW5rcywNCj4NCj5Kb25hdGhhbg0K
Pg0KVGhhbmtzIEpvbmF0aGFuLCB0aGUgZml4IGlzIGNvcnJlY3QuDQpUaGUgcHJvYmxlbSBpcyB0
aGF0IEkzQyBkb24ndCBzcGVjaWZ5IGFueSBkZXZpY2UgaW4gdGhlIGRldmljZSB0cmVlLA0KYW5k
IHRoZXNlIHNlbnNvcnMgY2Fubm90IGJlIGlkZW50aWZpZWQgYnkgdGhlaXIgSTNDIElEcyBuZWl0
aGVyLg0KU28sIHRoZSBkcml2ZXIgY2Fubm90IGZhbGxiYWNrcyB0byBhbnkgY29tcGF0aWJsZSBk
ZXZpY2UsIG90aGVyIHRoYW4gcGlja2luZyBvbmUsIG1vcmUgb3IgbGVzcywgYXQgcmFuZG9tLg0K
RG8geW91IHNlZSBhbnkgd2F5IHRvIHdvcmsgYXJvdW5kIHRoaXMgbGltaXRhdGlvbj8NCg==

