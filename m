Return-Path: <linux-iio+bounces-24627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE9EBB0912
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 15:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D81717FDA1
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A612FC010;
	Wed,  1 Oct 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="dlVQKdxA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB12F6581;
	Wed,  1 Oct 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326586; cv=fail; b=Zw72YJjIKU392H1xUst4q7Hj+3D4lc4gyoTAMVVC99fegED3is85HXaAnu2x6PMpz2+MPiu3RX5r/ph61h3wXpBLPLcZ50TXn0hOBwoJbqnHehI2H5za8s79DlIwn2n8q0Ohu6jEuon1i9ZjQllhoQulyTXb6F0q1+hQLsx1FLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326586; c=relaxed/simple;
	bh=pIrxkuL3JIyYlGp8+mior41UMwPefbWphLGiatjvS2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LDzz6vFh/4+nyyyZBmcyvXJk8xw3HZT7OtgkoFRY7HmuUw82KIRJ7kP2MRPHDiwdmWaEyJ7rCUYB7rMxJgZUd1iFovTxKh+oz/ipOObfQSdW20eCS5fY+obT6Tf2RxahkzurSqws6E31u3jDm2ZqxDw4t2A1dIaDqOch3pYxauA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=dlVQKdxA; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UMwm0L016727;
	Wed, 1 Oct 2025 12:07:46 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012032.outbound.protection.outlook.com [40.107.149.32])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 49e69yb0t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 12:07:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZJlipUEJqYRIqa9QAtlDAsXk890MBOUEvgHP5vIC9Tj7KiCElwIPoYIAXx5rSgtLdPcgCvNk4Dqz0+E4Rwdr0Beu9uNtVQKbrVLuh13c9E48Df5PITPE4+Ij9mHGjPuvpc3WJycEGJYhS91Ki/JFORx4nK5scY+VTPEtMpBLoLWSsCWmiQMkiybACrMXTarlQ3WPC6ad6UaHZoZlq2UgthZzyGNBG3XBKxPyEoig/sZ1QWdHcWucmffgh9t2vnJqYH//dUm54ZjDT9gyl/1QV8gfYVFRub3Dz2WM9c2riAgjEjwRGT3EQa7t/rW8kaKyt/Jrh0lrVXB97Y9f7d4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIrxkuL3JIyYlGp8+mior41UMwPefbWphLGiatjvS2k=;
 b=eROUcLuI04W/1lmfu+1usINdoMF+mitEWbBj+7NAFQ8uwWCauygb7nkdFpH+A7Ep8uLr7+PsTd+96xz5lvbcqCa74Mb5Bm5hf20lFwphyvsF+klR0ldrwZCWz4w+dw8NgbyseiPZiq3CIgNlLg4wfxiR5ZF1ySM1wKVmw3QNrZbGWdbHtkIzLO7w9mfxLpvo0MXv4MEdp/6YTMMs4DRqsFr5Ty7V0VmVRAkw4NwNXJj5Y/GZ4WgQ/XHg3aGQ3euMEVj5sK8eEMGj7UBhKaGqKlTAG75ih3St6bvmafLKLJNzNABoDPljExq1fLYJ6OwyQQSwSSym529RmGfntpo7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIrxkuL3JIyYlGp8+mior41UMwPefbWphLGiatjvS2k=;
 b=dlVQKdxAe1u+R5gh4JRP76+b+3vQP8r+X1HERYcg3pTlHJ+VmitVKOHQBS66iQV6NqhSyWcVQgH8AXF2/6JJZC0keNqu0XRqhsJSiHpnXMhtLAX6B7Xrhcwaq2b30Aq1VqE4pPVOkMArObw/jQpAyNWjWOteVfHsGJYFsod/NWVWnxGyVMsTDr1DZx6wBTE19jUt9LJT8N0uAsLFeFGSN6oYCMxhPy9iYNgMih5QpbprJKTzENF97uYJ68f1RUDWjU0/7KplQIETzqF7eB+5YWptcDxl7Du4x5A9iPFw9Cy8c3uWNwoK/Za1uoBzPbwOuuw0+J4Yp7BnlgaxzULkiA==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BEVP281MB3524.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 12:07:40 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c8a5:5cca:6c1b:3aac]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c8a5:5cca:6c1b:3aac%5]) with mapi id 15.20.9137.012; Wed, 1 Oct 2025
 12:07:40 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Remi Buisson via B4 Relay
	<devnull+remi.buisson.tdk.com@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 3/9] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Topic: [PATCH v6 3/9] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Index: AQHcLTUBnm/i7NtBpkOdA84QhkqKurSoTgwAgAS5QSA=
Date: Wed, 1 Oct 2025 12:07:40 +0000
Message-ID:
 <FR2PPF4571F02BC2026559022A8291EC5DD8CE6A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
	<20250924-add_newport_driver-v6-3-76687b9d8a6e@tdk.com>
 <20250928094524.52d492a9@jic23-huawei>
In-Reply-To: <20250928094524.52d492a9@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BEVP281MB3524:EE_
x-ms-office365-filtering-correlation-id: 22f4c7b8-d529-4303-e8ae-08de00e31e7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|19092799006|7416014|376014|1800799024|366016|38070700021|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmhRays4UE1wSC9oRjVSWUxrUkxEVXpPOEMvbFl5a1dJWHRJMmRSVnQ2SUda?=
 =?utf-8?B?c3drVkZVcWg4dDZ0UXVMdnltQk9iYThlZmp1UEROOWdZZXV2UnpTc2lMSEkx?=
 =?utf-8?B?TTdBWG9zcWRWVFZMOGl3UU5FeHhmTHN5aTlGb1pISTQ0YUEyWWpCWGpzdnhH?=
 =?utf-8?B?dTRJZVJzcUlxNERCaWQ0TEtmdGkrZWdGdFoxc1U5c1B0Yk5vaDgzMk83aGNn?=
 =?utf-8?B?UWNLbDV5dmFMeTM3ZldFR2Y1aGhGTEcwZ1JwcTBNMHN0dlY2MVh4MXVobnJR?=
 =?utf-8?B?Uk5ZQ2F5V2ZSU3ZRZUtrTXlHQ0Rqa21aN3lab0g2RDViWGY3dkhJQ3l6R2Ru?=
 =?utf-8?B?RXNPVUMxOG10UThIc0prY2ZTN3BRRDBKNjd2Nk5FR3M0N2ZVbTJ1bEhFSmp2?=
 =?utf-8?B?bWFaVHUxNmlEOHFieEdFSjhRR3g5eDlnbGpzYXREc1FTblFyeDhicjNNVklv?=
 =?utf-8?B?SzV4d3NyKzBlZXk0M3JSNWpEZFNHdnZmbXNwS3RzclpBQ1MvZ0lQdUNLdnNW?=
 =?utf-8?B?UHdkMUt1WFpiNVc2dTlYQ3V0YTUwZXcrd0hiTURraXZxMDQxU1JqSmN1YWk0?=
 =?utf-8?B?STZnU01nSWRQM2YxdnFmYUtGYlQ4VVIxUWlCa25RYTFMM3k4YXZoRWFNS3B2?=
 =?utf-8?B?K1RNZWY2UnVlRWliZHZvcE8rVE5raUxjODkyQkUxRDlXcWtSa25FazVGeExX?=
 =?utf-8?B?K3VUa1lCdTYxbTRTcXRSNkpxV1g5VlhJNnBmc05kM2dXc2ViQkVhMklnOUFD?=
 =?utf-8?B?cys4QlZYM0wrVUFJRmNqU2tqT3c5Wjc2N0ZRNVVnd2FDY2tQMjBtK0JaaFhC?=
 =?utf-8?B?dEdTb3FxNkNTZ2xZZzRxRGxmUmp4OFV1VVo2TGlMbktuUGNzcDlSc1Q4bHYx?=
 =?utf-8?B?VjVyVGZYMWVqb2M3eklOMEI3VlpuMytaZmxyWnBFT2VNSFVPNlovemRXY3N2?=
 =?utf-8?B?djVuRmFuRjd3dGhnTnNiWlViODVFVy9kczFsclVEWDBtVzR2WUZWZ3ZRSDFF?=
 =?utf-8?B?YjJGY3JNYmJBMWxjUDVjcW5sU1NaSmJJbk5xMW1IdUNQaEc0dTljaDZCQ2pD?=
 =?utf-8?B?QktCWkhRc1J2SEdiYmxqbTkxM0FHRHJyUldaV2h2dktXNWpsbHRXblR2ekxC?=
 =?utf-8?B?TEhiOGZ2ODNvdUVTaWxXcmhaUDJaMDhXeUFWeGlxOStvbmNGckNDamRUNkc4?=
 =?utf-8?B?YXVndnkvdUQyUmxNME9SMlM1QjRGVVRUYUl0S2tOKzJRazAzWjVSeVNyYnJo?=
 =?utf-8?B?aVhOSjgzRlJIY0swS1dmY0J6MWJIZ3VwRm1qR3U3WkJSeDVtcUw1SkRIRjJ6?=
 =?utf-8?B?RzhRSjJ0eTF1Zlc1eTZZNkVUVDhuL2IrVzVvWjl4b1pseFZWSmlQRm1xWXUy?=
 =?utf-8?B?V01PTlU2bVZDVldVVlRscUZUU252Q1R2TS8zL1pOdWl0RjQ5czEyMlIvOERI?=
 =?utf-8?B?Sm53UkhIV1BMZFIzZTN5em8yN01wRHdTYXYzdmVsSk55RkQwcG1TM283RGJ6?=
 =?utf-8?B?QWE5emxxVGZLZCsrMDFVOHhHcGVObHRTeHBhMXNkNDZzd0Y4YTFtY3NzQmEz?=
 =?utf-8?B?VTdhTHBXWmFsdy9nODdaY2d0Z2NHRnJpVDRuN1VxcG9FWVdlM29hbTVBcEZ2?=
 =?utf-8?B?ZGNCUkgxaE5WUU1kckQxdDhTQjZCTjk0eEJDdllMbk85dmJCWGIzK29VbmJt?=
 =?utf-8?B?ZllPTi96VVFzTXZScE41TUxHZHNXN0llSFdXY3F0Rk9WWGhrVnJ5d3BHd2E2?=
 =?utf-8?B?dUNZZ3dnMk44eVJ2WjRqM2NDanBCaXY3WTVqV1NwTU1DZWZBbitDbkw4K2RD?=
 =?utf-8?B?STlvcjFxUnhJWmdsbXhwSllxSGxYSmY2bkVHNjAvZ2Z3WXI1WkhqZGZJUGwx?=
 =?utf-8?B?MUFmZHJHMHZ5WS81L2E5Mlh6TGoxbU5yb1RvTko2MTdYZ0hFejBNWWN4dnY1?=
 =?utf-8?B?R0VhdVpYNnRFK21EUy9nbGtyUlZpaHVjS2h5a3R1SEtGVGpjVjZtSnNzM1Ry?=
 =?utf-8?B?TWhXYVlIMFpvWFFmdXlGTlZHWE9LUEZXV015NUJtRmsxTmtqR0xkdlN2REFU?=
 =?utf-8?B?WTVXTEZVMTgxZ2thazZKNndjTW9hUm5KNmxGZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(7416014)(376014)(1800799024)(366016)(38070700021)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1Q2aVBBZ1NzYTBqaS8yWHBZa25ydGg4b05udG56YjZZRWlkVGpRMm5LUVV1?=
 =?utf-8?B?d0s1alpEV0NWS1FDTkNydHFEblVtN1Q3UmRhd25LOVk1YzdOSUxBcEQ3aE1k?=
 =?utf-8?B?WEVwTTBNbWdiYjF5M0dXdjdYOHgwcEtuTEUrdkpPQ28vamxreDEyN1BlZ3Jx?=
 =?utf-8?B?S3NFSXRocnRmWWx2U3dXWTdMZ3pnWEtGaUJseEp2dHYwNG5VNjZPRm43bjVv?=
 =?utf-8?B?ajV5ZEliUVo2ZGJhcncwNG1CT3VZYXdhMXpQd1UrVjFFcVEveUtCS3BSUThL?=
 =?utf-8?B?QVdTaVFESnBUWUFHOHJVZThhRGFMbXNIbVBVNERnZSt6bWp0VEcwa3dPMzg0?=
 =?utf-8?B?Yk5USkIrMmlXMXc1MVRad3FyV0xxWkdvdi9TalEwS0s5a3VpbFFHb0lTTm90?=
 =?utf-8?B?SHdtSzhvQmthQWRiZVZ6S2c5ZGY2cDUzVmo1bFVPdG9RdlJsTFZjNEJqSkMz?=
 =?utf-8?B?Uzg3bnQwbWVPSWNmc3RZYlMzT3FsNEttTnZ5KzZhTnlvSGM5aDFjOXlTM20y?=
 =?utf-8?B?NWhCZ0VjRHR5UXI1MVVaYnRFNWtjRlozbXFXcXoxS24vOHo5eXQwTWdEcWNZ?=
 =?utf-8?B?ZnczWnQ0Vk1SM3ZOYm5hUXd6c3FNUTZ0NnpsTW1LTU5UYUNpZEd6emtFMWdD?=
 =?utf-8?B?TDY3bVFjR1I3NUJIZEM0SHNoODJacHJpclBBN04wVTVNU3hiQU45MVA1bkV4?=
 =?utf-8?B?bWE1bVQ2TTV5RFJkZGFwY0RrMFJaZnVVQXptNnpzdTlZdk1NR3d1OTVWUnVB?=
 =?utf-8?B?SkhOSysyUlpsd0ltZ2tIZ0lDZlE0Ly92c2ZIT04rZ2JZZ1VFNnY4NTRmSjVC?=
 =?utf-8?B?YWZFZTgwZDlXeE9pUWZDT2pXR1ZNRUlRYmZScnR4blJZL3BzMmVKbzViTzYz?=
 =?utf-8?B?VG1hSDNXRS9BeWlQZTBwbmpjUWdzTEE0Vzd1N1pVQytNL1VEcUk5VDh2dGp4?=
 =?utf-8?B?eitCbi9FRWsxaDNmN2Y4dUpNMllOOFdqbVdxUmZzNGMwRiszZEI5bjVNbGJM?=
 =?utf-8?B?YThnZ29LM3pJRVE3eXJwOVBHcU5xQmJEQVl6eGxzQ2lIUGU3L0p6NmFScFQz?=
 =?utf-8?B?d3pDS2pTTi9GdVhaMjQ0b0RoNExtT2FqR1dKcTdPZlBJTEJieDZxOUdmZGtj?=
 =?utf-8?B?SHBuU3duUHQ5cTNDYSswSS9iK3RBdHUxMWhYRTFvV2ZxRGZkQWlNN1RlazNr?=
 =?utf-8?B?M0hrQVVEa1FHdk1PNVU1Y0d3c2hneHBVTXJXNktiYW9oSnlydDZ3VXpzbzBZ?=
 =?utf-8?B?QUVCd1dJSDZPVUV0RmpDdFk5bGlQdXBjR2ZBaXJYYlFJMDZxU2ZFcjlXR3pT?=
 =?utf-8?B?eVRVaU56QjA5OEg5YUxDUkZnLzlHMEdFNzIySTVQOTZWTldlMnIxRGl0blNO?=
 =?utf-8?B?NjN6eTVJMVN3R3JFdVdRQlRJUDRINmRpaWJFRXFCN2szckxmMTRWQXhwRFZa?=
 =?utf-8?B?ZDd4OUFod2NpV0xaaVJOOGZ1Z3lLQVlRNkJFK2NQMElGRFVDSll5NVYzTjJU?=
 =?utf-8?B?WVllTGFQQng4MXdKcVZwVFFVSVNYVFZsenQwUXVpYjVReU9oenoxQ0xOU3Av?=
 =?utf-8?B?dVBqMmIxVm1kSzJkazZsV1pNNG9SR3dXd2paYlV3Wk96T0xPSGJ1YS9SS3Zl?=
 =?utf-8?B?dzN3SVAzUkFXWkxxa212VXQyNXd2cGErT1ZyMVRBaWR5blYxNTBQNnNPUVhw?=
 =?utf-8?B?N3RZZU91bWNyQ2lBZ3pFWVlGcVVXYlh4dXV6VTlSL09VbDNVenkya0tYd040?=
 =?utf-8?B?TVZIb0dVckY1VXFGYldZUWNNREx6YkJDQnl4QVI2YTVDeGFVeHk4WUh5ekN4?=
 =?utf-8?B?emVrZXQzZkRjTW51bTA4WW5kUWRNei9SSkhuVXlwNS95MHk0cWdLNjVXemdz?=
 =?utf-8?B?VklicWZjWEJMK1ZWelVaMmVBMlhuTFdNbHZKTlA2QkFLeHdmM1hQZG5kdFFO?=
 =?utf-8?B?L3JiRmdyTFZYaEo0UGVIV1g1aWNzUjZqYkdkRUNNZnUrRERFVEYzM3FPSzl4?=
 =?utf-8?B?ZEUvcG1iV3NlbmZLUWVBa0N2d0ZNdVNpUVVTamIrS2N0QkFFSXNMeGNqN2lI?=
 =?utf-8?B?ZUtoRXAvM3FRRlp1dFdjS3lrS3puSnRYMmF3YktwMTdyY20rZ2JnWm5SaDNt?=
 =?utf-8?B?U0tLYUpmemdMRnRhUzJYKzhhQytTOU5tQjVLMUxONmh5Umh5d3VpSWcvYzNt?=
 =?utf-8?Q?7ovgUPVQOJ2oMaU/w0FjwJbDDOusnkyZI7dOGYEDjNTU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f4c7b8-d529-4303-e8ae-08de00e31e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 12:07:40.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9eYig50ivZkFFl1E4Bbjj1TOa6gh2qyw8ldpnwTKZAvpN3OMhsHMmgE5m+jOJ7HIdyyF4qkMrrpdz9GYc4Lsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3524
X-Authority-Analysis: v=2.4 cv=XPw9iAhE c=1 sm=1 tr=0 ts=68dd1992 cx=c_pps
 a=2XmeY+fgDybwNESE/WdNKw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=Uwzcpa5oeQwA:10
 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=hLjU2gp4ZcMEkgPgI50A:9 a=QEXdDO2ut3YA:10 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: tQSl8RgqdIpVO8zrC_E2nnVPsY14zYP3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMSBTYWx0ZWRfXyTCg4qoqwLkr
 gMcybLrjNlTI83+7zr8wlfntDsmvJPubQ3dGJke+Sw9kOVBrhXRH3u4lEmH5E76+igcLdtJHsYP
 tBDpgbDJRXwiizZkjHPM7/Lcj/QygZnhG+AjPUo6FKaOdWHi15MLOdLSANFW5hKLz2w51wqJUek
 yyTC5KHcnGC0yr1lCEK2nTjUImHAs3VKX19bZujzxRSOsjaraOBwVS85jN2wKAOWLLqb1gmiyyc
 8d/fwh/cpIYylJPTwzhWGolDlbow3YrlR5NBwxtvo4mg8tTEuGhF9tHjKmNnrLI3qnKqRi5S1ot
 yzeiAbZgRCtOFBWxwatCZADmhKk4FTMenHiUatDGPUvqexwUC3C5ZEnVkiSUySDDxCP2ByWoP/P
 bhh3T9XBqYfGS9zNfQOq8qtLwVDkLQ==
X-Proofpoint-GUID: tQSl8RgqdIpVO8zrC_E2nnVPsY14zYP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270011

Pg0KPg0KPkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KPlNlbnQ6
IFN1bmRheSwgU2VwdGVtYmVyIDI4LCAyMDI1IDEwOjQ1IEFNDQo+VG86IFJlbWkgQnVpc3NvbiB2
aWEgQjQgUmVsYXkgPGRldm51bGwrcmVtaS5idWlzc29uLnRkay5jb21Aa2VybmVsLm9yZz4NCj5D
YzogUmVtaSBCdWlzc29uIDxSZW1pLkJ1aXNzb25AdGRrLmNvbT47IERhdmlkIExlY2huZXIgPGRs
ZWNobmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5
IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29s
ZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPlN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMy85XSBpaW86IGltdTogaW52X2ljbTQ1NjAwOiBhZGQgYnVm
ZmVyIHN1cHBvcnQgaW4gaWlvIGRldmljZXMNCj4NCj5PbiBXZWQsIDI0IFNlcCAyMDI1IDA5OjIz
OjU2ICswMDAwDQo+UmVtaSBCdWlzc29uIHZpYSBCNCBSZWxheSA8ZGV2bnVsbCtyZW1pLmJ1aXNz
b24udGRrLmNvbUBrZXJuZWwub3JnPiB3cm90ZToNCj4NCj4+IEZyb206IFJlbWkgQnVpc3NvbiA8
cmVtaS5idWlzc29uQHRkay5jb20+DQo+PiANCj4+IEFkZCBGSUZPIGNvbnRyb2wgZnVuY3Rpb25z
Lg0KPj4gU3VwcG9ydCBod2ZpZm8gd2F0ZXJtYXJrIGJ5IG11bHRpcGxleGluZyBneXJvIGFuZCBh
Y2NlbCBzZXR0aW5ncy4NCj4+IFN1cHBvcnQgaHdmaWZvIGZsdXNoLg0KPj4gDQo+PiBTaWduZWQt
b2ZmLWJ5OiBSZW1pIEJ1aXNzb24gPHJlbWkuYnVpc3NvbkB0ZGsuY29tPg0KPkhpIFJlbWksDQo+
DQo+QSBmZXcgdHJpdmlhbCB0aGluZ3MgaW4gaGVyZSBhcyB3ZWxsLg0KPg0KPkpvbmF0aGFuDQpU
aGFua3MgYWdhaW4gZm9yIHRoZSByZXZpZXcgIQ0KUmVtaQ0KPg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwLmggYi9kcml2ZXJzL2lpby9p
bXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMC5oDQo+PiBpbmRleCA1ZjYzN2UyZjJlYzhmMTUz
NzQ1OTQ1OWRiYjdlOGE3OTZkMGVmN2E2Li5hYWM4Y2Q4NTJjMTJjZmJhNTMzMWYyYjdjMWZmYmJi
MmVkMjNkMWM3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9p
bnZfaWNtNDU2MDAuaA0KPj4gKysrIGIvZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZf
aWNtNDU2MDAuaA0KPj4gQEAgLTUsNiArNSw3IEBADQo+PiAgI2RlZmluZSBJTlZfSUNNNDU2MDBf
SF8NCj4+ICANCj4+ICAjaW5jbHVkZSA8bGludXgvYml0cy5oPg0KPj4gKyNpbmNsdWRlIDxsaW51
eC9saW1pdHMuaD4NCj4NCj5XaHkgdGhpcyBpbiB0aGUgaGVhZGVyPyAgU2hvdWxkIGJlIG9ubHkg
bmVlZGVkIGluIHNvbWUgb2YgdGhlIGMgZmlsZXMgSSB0aGluaw0KPnNvIHB1c2ggdGhlIGluY2x1
ZGUgZG93biB0aGVyZS4NClRoaXMgaXMgYmVjYXVzZSB0aGUgYmVsb3cgbGluZSB1c2VzIFU4X01B
WDoNCiNkZWZpbmUgSU5WX0lDTTQ1NjAwX1NFTlNPUl9DT05GX0tFRVBfVkFMVUVTIHsgVThfTUFY
LCBVOF9NQVgsIFU4X01BWCwgVThfTUFYIH0NClNvIEkgZ3Vlc3MgdGhlIGhlYWRlciBmcm9tIHdo
ZXJlIGl0IGNvbWVzIGZyb20gc2hvdWxkIGJlIGluY2x1ZGVkLg0KUGxlYXNlIGNvcnJlY3QgaWYg
SSBtaXNzIHNvbWV0aGluZy4NCj4NCi4uLg0KPg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlv
L2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2J1ZmZlci5oIGIvZHJpdmVycy9paW8vaW11
L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDBfYnVmZmVyLmgNCj4+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLi4w
YzhjYWE4Mjg3ZGQ0MzczY2YxMWJiNmM3YjkxM2E2YzQ5ZTllZWU1DQo+PiAtLS0gL2Rldi9udWxs
DQo+PiArKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9idWZm
ZXIuaA0KPg0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIHN0cnVjdCBpbnZfaWNtNDU2MDBfZmlmbyAt
IEZJRk8gc3RhdGUgdmFyaWFibGVzDQo+PiArICogQG9uOgkJcmVmZXJlbmNlIGNvdW50ZXIgZm9y
IEZJRk8gb24uDQo+PiArICogQGVuOgkJYml0cyBmaWVsZCBvZiBJTlZfSUNNNDU2MDBfU0VOU09S
XyogZm9yIEZJRk8gRU4gYml0cy4NCj4+ICsgKiBAcGVyaW9kOglGSUZPIGludGVybmFsIHBlcmlv
ZC4NCj4+ICsgKiBAd2F0ZXJtYXJrOgl3YXRlcm1hcmsgY29uZmlndXJhdGlvbiB2YWx1ZXMgZm9y
IGFjY2VsIGFuZCBneXJvLg0KPkdpdmVuIHRoZSBjb250ZW50cyBvZiB0aGlzIHRvIG1lIGxvb2sg
bGlrZSB0aGluZ3MgdG8gYWxzbyBkb2N1bWVudC5lDQo+ICogQHdhdGVybWFyay5neXJvOgkuLi4u
DQo+ZXRjIGFzIHdlbGwgd291bGQgYmUgZ29vZCB0byBhZGQNCj4NCj4+ICsgKiBAY291bnQ6CW51
bWJlciBvZiBieXRlcyBpbiB0aGUgRklGTyBkYXRhIGJ1ZmZlci4NCj4+ICsgKiBAbmI6CQlneXJv
LCBhY2NlbCBhbmQgdG90YWwgc2FtcGxlcyBpbiB0aGUgRklGTyBkYXRhIGJ1ZmZlci4NCj4NCj5U
aGlzIGlzIG1vcmUgb2J2aW91cy4gIENoZWNrIGlmIHRoZSBrZXJuZWwtZG9jIHNjcmlwdCBtaW5k
cyB0aGVzZSBzdWJmaWVsZHMgbm90DQo+YmVpbmcgZGVmaW5lZC4gIElmIGl0IGRvZXMsIGFkZCBh
IHRoZSB0cml2aWFsIGRvY3VtZW50YXRpb24ganVzdCB0byBzcXVhc2ggd2FybmluZ3MNCj5hbmQg
bWFrZSBpdCBlYXNpZXIgdG8gc3BvdCByZWFsIGlzc3Vlcy4NCg0KV2l0aCBteSBzZXR1cCAiLi9z
Y3JpcHRzL2tlcm5lbC1kb2MucHkgLXYgLW5vbmUgZHJpdmVycy9paW8vaW11L2ludl9pY200NTYw
MC8qIiBkb2VzIG5vdCBjYXRjaCBhbnl0aGluZywgZXZlbiB3aXRoIC1XYWxsLg0KSSdsbCBkZXRh
aWwgdGhlIGd5cm8vYWNjZWwgd2F0ZXJtYXJrIGNvbW1lbnQgYW55d2F5Lg0KDQo=

