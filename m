Return-Path: <linux-iio+bounces-22652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3E4B246C5
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761E216463C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C828F2D738D;
	Wed, 13 Aug 2025 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="SERyCndg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909802BD5B0;
	Wed, 13 Aug 2025 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079842; cv=fail; b=a6I7jNx2RD9WU9qzsyqKtmsZiFDCESfQV+QyZp/gbpShCRFRP6fAsYdi/+McmWpsozLlmihywYpukDBdJ2P0H8AF/YF2Sla7un/5iEsmyJj4ZueWdrync1oDK4GladZk/Ilaj9ZUnPke4YvckjQ+k/vSqD3ykvmpS7e+9AfZjtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079842; c=relaxed/simple;
	bh=51EPfkxPHnkdy+r0TgITMMOusypaAgQ/yRAmr8pkFw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FpoYx61cI1PKgR9O9Xh0kGXHrKrHhjW0efBufL+rA/wRChHpU/3+d4wfT1vhs3WuY60Pld5ZXr1raEhFhKfrIg6YmfPIvcfY2JXPZHXgqNT+xzESET9xXNDWvfu2QJk3oUn9UmFHHe6GGib1jMLMvQbvyz6sJKXy7cNPL5tFT88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=SERyCndg; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D9oNsO031005;
	Wed, 13 Aug 2025 10:10:35 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012019.outbound.protection.outlook.com [40.107.149.19])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48dvq0jn4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 10:10:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPS8lIicHrjGhYJc2mEmpMfsaKd4DT7kbK1RbGj6uNjfqV1mxJH7uxuwMs+F8HA+eu5ru3HNzAoaLWLPaxF4MkEGijMFa8eh4RoYTie2flky0q4p8oxfxUtELDLcdKL79I4+bq//FtruRJJ9q8bwM6mlJbPRG0L5WyMciKujU8EOmCYpjAEv8RPSjj898Jz65UYuvCdc2FddHG60LHsvcVh2BHxZn/yNSc22hyxBDrKmryQAN7nR9CBB8r4BtmrOdJhWzQ6AYglF0c+73G5EO+fGDboaiWTBMsDhKImi75wiPZD2Xv9jy5PTGuHqciBYi7UTRVdy0ZFD84NAz37kVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51EPfkxPHnkdy+r0TgITMMOusypaAgQ/yRAmr8pkFw0=;
 b=XP6IdcZMPpFueTJ2d+Tiy0ANSvG+x5PC0Uo4D0DKLDfiz6yw9gxAxlHvOeCKDx58kkWBinjRPKCW2V80G1RHpRfJDUuyaiMD7EJayu+9eRk1nTQHb28fgFUnYGOPVdBqYXdkJCdJ4xI5qCQ6QLvPEPDzpzo4O7azF6dTc4avMOHUaRbW5cdqlf0qyR5o4VhaXAZHDC0azYMFN+TChumjvLiBLnkuQfLBWkxU9IMt8TDLUN90NK4z5XAlNATyX/jJAY6qh1FcJ1ZTPso8z3OiWitTQTnxnAzvEKfPvfRzxDtFwcBLq0NhXk2+EmOJckkILC7H3RgEmSi0ZHeeLoDoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51EPfkxPHnkdy+r0TgITMMOusypaAgQ/yRAmr8pkFw0=;
 b=SERyCndgCzosdDIojHP4E8OYiY1rJQYmyo3+8FlhgYUySf1u2jK8iu2W/trU0VnulNgS1G5mofd6r1bBiQ+BqdrDJeX0NqNqW0UdaCZ/QEfe/G4t+9SjqUHsdwYl0C9y/9N6ZTpRO2PST/Oi5nO3D//bvEgDt52FvdRJ7xKDCvvTYnljUAKoB7GlXGKKMKEdthF9O2YVyf8bg1e2+xT2UaqYb8TiGakNeLi/5SBoQknRz1cVs9vjLi7ot3xzeJuojawwIWsQRyfGxaYWqcbJcs1elHP+R8yHs20RXoGYrX7dEYde9L2/Juza5BugCjbd6QbMGCzUt4GnHWQ4XXlUGA==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR4P281MB4563.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 10:10:30 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 10:10:30 +0000
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
Subject: RE: [PATCH v3 4/8] iio: imu: inv_icm45600: add IMU IIO devices
Thread-Topic: [PATCH v3 4/8] iio: imu: inv_icm45600: add IMU IIO devices
Thread-Index: AQHb9x5gu1Xjz5Fg1E+fVAgvKD4hVrRBfjCAgB8H8IA=
Date: Wed, 13 Aug 2025 10:10:30 +0000
Message-ID:
 <FR2PPF4571F02BC65A770A684C8F2C85C8D8C2AA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
	<20250717-add_newport_driver-v3-4-c6099e02c562@tdk.com>
 <20250724171547.4075f8ad@jic23-huawei>
In-Reply-To: <20250724171547.4075f8ad@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR4P281MB4563:EE_
x-ms-office365-filtering-correlation-id: cd5ed1c5-d165-4ae9-efe0-08ddda51a20a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|19092799006|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkNyWnFLeUExeTQzS3JJeDg3RjR3YVI3L2JBRFQxL2E2MUlLK3NpRVM0d1k0?=
 =?utf-8?B?YzI2VFQrUCszSS83NUlkVW1SbkxSOUtOd3Ewc3pHTmhOTzZRYkVGdHRMMjVi?=
 =?utf-8?B?a2ZDUDlBc2cxOWN1L0p4aEUrLzIzdG13YXFOclpZMENQVHpQcmFacVB0ZEd1?=
 =?utf-8?B?VERzejFjaHVidlFuSG4ya2lGVkhqbFZDVTBXV2xEa3NEbnNyVjB0YUxWMTg2?=
 =?utf-8?B?N0pmQ2tCdjlPb1cwMklxUk1EQm5scXNJeTVmaXBrd2M3ZkhsSmQ1VjREUFZC?=
 =?utf-8?B?LzUzQXdhVlZ1MzlxSnp5YytBMjUyQ2V2NHQvYUsvaExGRGpRZ2lrc1VuWFkv?=
 =?utf-8?B?eG1uKzR2R1FUS3d6Nk8vWVhBTFVzM1VQT1B3M0JKWnRUZEFtblpnUFh5R25l?=
 =?utf-8?B?Z1pDaHNGR2FtdkxQZmZvNVg4QnphZU1pczR5Zk1abVFRNjNsRmFEbm1PL0Fr?=
 =?utf-8?B?MmcxdG0raDVrQlFqTUVvYTVXTUxtWWU5WXNuMXc4cTZZcDVNbHplaUw0VEVp?=
 =?utf-8?B?aXVkK01iWURLMGZNMEtIclBsTWNlLytWNzlYaWFRS1pQZHpuSGc0b2xrNGZX?=
 =?utf-8?B?MVRmRWFpdmZFTnFCZERuU3l5N3pYUXUyU09PWERTK2JZYjFYK004dlRnNmd5?=
 =?utf-8?B?SS9raks3aHdQL2VKN0UrZFlGV3ArNGs2TlFTaFcrbXl4bi94Ykx4RzBXVjhC?=
 =?utf-8?B?dEJkQ2tUOUMrVEF4VUxYc0JqZmZLM3FHdFBzS0QxZWlkcjd6QnIvRTBCMUwr?=
 =?utf-8?B?NG0xU1VZcHV4R3B1SFV6VzlCdTdDM3dHYWVKQW9SMHl3eXM4M1EyMTlHWEZa?=
 =?utf-8?B?amplVTkzaE0wSzkvQjkrREFSOUhhbFZWRk4wbWpqK0tMbGZPOURvMDlIRXhI?=
 =?utf-8?B?TmxUV1FaVFJxai9iRTVWa2lHMnBONkZ0RGphV1czYW5saGZzcWk1bWpxYytw?=
 =?utf-8?B?eXRUUmZ1bzQxdUI1Yzc0MEV5Z3d2MDMrdFk2Q05DTithQUJablpTVkY0VkNO?=
 =?utf-8?B?VmJmOWFiQ1FaZEJMQnpUQlE2R2RwTHRGdUpYVXROZTMrRFltMnZ3ZXhSQzY3?=
 =?utf-8?B?NldweGhqRVdna1ZqTlE2c3ZjTTk5MzZmcHBnSS9PMXU5UCtlYllmbERJRjVj?=
 =?utf-8?B?UDNVOXVEYTU3bjZDb3NjL1pyOG1OeGVRdk93MHlBenVxaUpzdGZsVFFtZ3hh?=
 =?utf-8?B?YzYrRXFKSktIdXlZcTlWNFozNnNXQnJyNmhRUVJCVUFsR1BtQThyYzBFaGxu?=
 =?utf-8?B?bUFQSEVPWHhxWVUvR2VFdDkzN3NiVHZoczNHcU5VeWdaWnZTVndudkw1SHZ1?=
 =?utf-8?B?Sjh0VmcyOERUVDExSVpVaXUyL0ZCL3ZoQTRQcndxdVM5azNUdFJIS0xINzVw?=
 =?utf-8?B?aWdCTVhsR1NLT25wQnNzcWdoQ3dBc3pJQ3NPWklLcTVKK0R2b1FlKzkyUUNY?=
 =?utf-8?B?ZVlHNUcraktzcmwvOTFaSWF4Zm8yUTJrdFVEbkpQL25BUC9qSThwWHA3RXpx?=
 =?utf-8?B?WHlEb3lvdUdqbThrdVRPaXg0M0xMUmNFamxrOXNKNGV5bjVUcUY5VTI0MzN6?=
 =?utf-8?B?T1lKSG91WC9jQ1N6bFBDTWNFZ2pxWG94UmhjOXdWK21BMlU3RE56QytGcitz?=
 =?utf-8?B?cnhlUDI2K2s5RXdJYml0RitxNkJFc0tJa1lJbTFCWTdtM01VQkF1b0h0T1BT?=
 =?utf-8?B?aTFHWVd3ODE3U2ErNngvd0RlWWJ3SXBhRGthVGtFbFg4NFJmRUpscGhmcE1K?=
 =?utf-8?B?dW1vbU1mdkZ0a2R6T3JkS2RvNC9acjhqYkxSLzc4dU1KNk1HY2pIT1NGQ25i?=
 =?utf-8?B?ZXNzRTA4emVlWW9yckxJbDRrd0VpN3M3dzBuTXBRdDEvUnFqaG45Z1RyQVJZ?=
 =?utf-8?B?WnpORUdLRDd4dWZaYXF1d1NZT2ZtaHIwTkw4ekZ6ZWVmQnhKNTJaMndVMWJS?=
 =?utf-8?B?OEVVbitGcGc1Z1VPSXVYNFpGNXk3SitiZmFwNjNya1IvNkhnb2VqTVpqeVB1?=
 =?utf-8?B?T0tObUp3eFl2RWhDeDNLRlRDZVlEN291dmdDb0g0cDFGL0FxSERIdnZHWjNO?=
 =?utf-8?Q?IKHjFu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(19092799006)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFNXR3ZITDFGQXFaZTZCcS9EQWVackpuTEZmMElNUXFsM2ZmSWlDUjNZNWwr?=
 =?utf-8?B?WUQ0eHh4cjBsYXdkZ253NDVQTkplZlptTi82K09SL3BscmFJL2cxRHdwOVBH?=
 =?utf-8?B?ejZpRm9LNU9ySHpuRmovWXZEUmN0bTVOZDc1b1Z0a0JJZ0I3d2pwNVJpaUg5?=
 =?utf-8?B?a01ZbGhtSGswTWpQRzRLMC96V3pseGVEMUNXaUdqYzZhWGpmNkd3ZzBHUXhS?=
 =?utf-8?B?am5XZXV2TXBWaUZ3WDdPNklsdUtydUdBellyd0ZOSzhDOVNqUkRNMk9RTXNT?=
 =?utf-8?B?aVd2WDZiUm94MUxWbVJibDd1WGF3MzlkTUllK0JXWWRFK2xZUTgzdHZsY3lX?=
 =?utf-8?B?VHZTTEFBQmJ5SndiVGpoWXNIU0ZVdTIyZXhRRDQ1cGNIYUpZbWpqdWJmVmRV?=
 =?utf-8?B?WUZiSnQ5TCtwZmlIc1hhNTR1QWsxUExUV2dhd1pQL09TMTNTMmlVVlR4N1Vv?=
 =?utf-8?B?NFRwcDkxQmt3d3ZFbnAxMm11R2hIN2hVUWRuNmtuQjRGNG1Tc2gzdll4RXZZ?=
 =?utf-8?B?Qmd2dWVIbDE0SkpnREZ3N3k4ZTBsN21wUUcvNGExeERXeGR0dFdDUDZOK0lr?=
 =?utf-8?B?RENTZzVNUFZSSllwMk1hNlNZSVI1Z05OTDdDOFFEVi9jOHJOd0NQUGM0Sm9a?=
 =?utf-8?B?Wms5Rnp4SG9vUHJBQjBpY1hiMlZPQi92QmJqbU5TRUJzQXJWd0UzMFMwQzVP?=
 =?utf-8?B?VWsrQ0ZGb3VsZWh1TTNJdnFIZnJCN1ZiRWVFczUrUFp3QlFiYmsyRVlmcDNm?=
 =?utf-8?B?WGlYZzJibkd4TFRvUi9FbGVMQ3J1Z083RW5UczJsdjVtK1FmUTBIUHlLSy9h?=
 =?utf-8?B?dXkvVmM2SlQyR3diRVZqb1NPYi9kd1lCWlVmM0dPSjlBOU1jR2dGVDFJR21z?=
 =?utf-8?B?bm40WEZTR2tlUUdlQ0QvZjMwR0tYdUpjeEcrRGxXc0NTd2dML3pJLzU5ZzR0?=
 =?utf-8?B?L21HWWlnQk9qdXAzaG1xd05mZ2dKR01TSG9Tc2o3TGNBR3c3YlBwY3VVQzFL?=
 =?utf-8?B?Vi8yaG82QW5SOWZsUFYrYkFZcDR2QjdZMmhiUms2MS9BVnRpcmppTXByVTVQ?=
 =?utf-8?B?V3lrY0FBeWZ6UXlzcWpaRG4xclNuWVJnTXlqYnRmb2svZVhFaDlCcWZmNW5w?=
 =?utf-8?B?ZGY0d1phdVY3dE12MUFsMDk4MGxyY2U1Q09hYlVrNythWDdIa0h1cm4yTWRT?=
 =?utf-8?B?OFpnbENobGp1WXQ0TGp5dlFMTURlNWxLc0U5SHU0WDNWaFZ5OUs5NWp5RzZ2?=
 =?utf-8?B?QUV6SzlNZGJiSmwxY1ZQOS9YQ2JsT2Vyem50dkZ0M2dvM2M5ajJrSDVTUXd0?=
 =?utf-8?B?SkpJV0tZQ0VVclNaQysvci9sSSszc2RHRzZWTHBGcEZwSGJLUTZqOFZYREhr?=
 =?utf-8?B?MlpRZ3h1SjNLMmc3dnFTZkNES1l3by9Zb1dsZ0hXQ29QU0dkeFIwdU1mRmZT?=
 =?utf-8?B?dWY0NEUzMTA5dVVhTG1mSWtTd3kzODJuOENYV29oWXlIOVB5bCtwWW5EdWZq?=
 =?utf-8?B?bTU0WnBVcC82UkhOS1RNSzdvQzBtTVlrZVYwRFRzUkc5ZStsZEsyQ3NPZUZN?=
 =?utf-8?B?MDhySmYyaHZKSnBrSzdsZ3I2c3VhVm1zVkNDMm9aU2VaRE9uWGpJdFRaL2FV?=
 =?utf-8?B?TjY1Nm1UVDM0YXlWWUtJUGRoQzBidXBMTlc2UVNmWGk0Z3Y4alZ3YURyYVlo?=
 =?utf-8?B?ck9SaFRFdnlCMm5GaU4yTDA5NFpOa21KZTNxZnRBZzViSDFnOWVuMXR6OEtG?=
 =?utf-8?B?K3N1YkNwcGpFc0V0OGlOeHlCWS9sQXZWU3BudDRrZHNtWWlBcTV0RnVqY21a?=
 =?utf-8?B?L1hmb2VFUTJMODAxNWowT2x2VFhRSE9HQ0Z1TlNQcHRmNy9CcENMb25QNktJ?=
 =?utf-8?B?Unp5QytDeU9yempRcHh5V1V3UlV2a3NxMjYxWEtrZWZ5QXY3dllwVEdQL2FI?=
 =?utf-8?B?a1F3L3RMR0NZaVRlMmpULzNCUzAveEQrVDRvSk1CcEIzM3cvdjIvNmJxSUZY?=
 =?utf-8?B?MEUycGxlcnduWHMyOHNhMFl2Q2x0Ukg1QUF4Yno4TjdrVkVYN1hsRzFQcWNE?=
 =?utf-8?B?aDJZeWVwVUtXVkRhNTN0bFlGRnhlQ1FLVUQ4M1lTK0JpeDNUSGdKMHZnajhI?=
 =?utf-8?B?T2Z0K2R2WHdtK0JTUURza2JNWGZteWpjb1grM1l4a0dBdFpORkI1UFZONFJx?=
 =?utf-8?Q?1X5EsJsKpE/Ck3SEHr4kx0In24bae8t3IT2axsGa1UCA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5ed1c5-d165-4ae9-efe0-08ddda51a20a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 10:10:30.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uw/TdutddT4cVcQ/Ul1Kk/pNKhC9Rvdg58DWVttvwBY94gJvgXelaTskZ6wKCB99S+IeE8o/AMLZAbhviSmADA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4563
X-Proofpoint-GUID: QKQH47qohI1wpoWnLl0LPVzcxGd-4wvE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwOSBTYWx0ZWRfXzMkPvjwA7eXt
 HhCGFPJCVfFt9fhtRDU8bo3naQwyVwxAYiE5/f+VNDvnb3VvuEi7WIIeDy7MuMufRztputva12P
 KsW4Lcxyebn408Qi1WeMny8cWGPVUL/Da7dE+O59YiEB9ljQW2egKpwv2TIw3fH6JJfpJVToosk
 Ov2R8syAv4EgKFtD2Ji2G6+3qnFfVdGJWg4OLULCXJNDXJ+Ico+RquaFTx3ayjONrP75s7Mo6Vq
 g1pgc875dH/tuTfMkAK7EeXv+nWttbG1Rxl9L7DEN5AmLt15it3PxwF3l20ldmTTW3CrhSJMjti
 6j0O+REydoO3aUqUzz/YJmHP2VuRnTeEGznFSpsE+tFY85LtEmLoEgNR1638AHpX7/u0Dw/wpYe
 cEhvP5UJ
X-Proofpoint-ORIG-GUID: QKQH47qohI1wpoWnLl0LPVzcxGd-4wvE
X-Authority-Analysis: v=2.4 cv=AO34vM+d c=1 sm=1 tr=0 ts=689c649b cx=c_pps
 a=/BeNyiip3t3JC1UeaBVfzg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=uhp1bur4MrnXK4z7fgIA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 malwarescore=0 clxscore=1015 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090009

Pg0KPg0KPkZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IA0KPlNlbnQ6
IFRodXJzZGF5LCBKdWx5IDI0LCAyMDI1IDY6MTYgUE0NCj5UbzogUmVtaSBCdWlzc29uIHZpYSBC
NCBSZWxheSA8ZGV2bnVsbCtyZW1pLmJ1aXNzb24udGRrLmNvbUBrZXJuZWwub3JnPg0KPkNjOiBS
ZW1pIEJ1aXNzb24gPFJlbWkuQnVpc3NvbkB0ZGsuY29tPjsgRGF2aWQgTGVjaG5lciA8ZGxlY2hu
ZXJAYmF5bGlicmUuY29tPjsgTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkgU2hl
dmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8
Y29ub3IrZHRAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+U3ViamVj
dDogUmU6IFtQQVRDSCB2MyA0LzhdIGlpbzogaW11OiBpbnZfaWNtNDU2MDA6IGFkZCBJTVUgSUlP
IGRldmljZXMNCj4NCj5PbiBUaHUsIDE3IEp1bCAyMDI1IDEzOjI1OjU2ICswMDAwDQo+UmVtaSBC
dWlzc29uIHZpYSBCNCBSZWxheSA8ZGV2bnVsbCtyZW1pLmJ1aXNzb24udGRrLmNvbUBrZXJuZWwu
b3JnPiB3cm90ZToNCj4NCj4+IEZyb206IFJlbWkgQnVpc3NvbiA8cmVtaS5idWlzc29uQHRkay5j
b20+DQo+PiANCj4+IEFkZCBJSU8gZGV2aWNlcyBmb3IgYWNjZWxlcm9tZXRlciBhbmQgZ3lyb3Nj
b3BlIHNlbnNvcnMNCj4+IHdpdGggZGF0YSBwb2xsaW5nIGludGVyZmFjZSBhbmQgRklGTyBwYXJz
aW5nLg0KPj4gQXR0cmlidXRlczogcmF3LCBzY2FsZSwgc2FtcGxpbmdfZnJlcXVlbmN5LCBjYWxp
YmJpYXMuDQo+PiBUZW1wZXJhdHVyZSBpcyBhdmFpbGFibGUgYXMgYSBwcm9jZXNzZWQgY2hhbm5l
bC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogUmVtaSBCdWlzc29uIDxyZW1pLmJ1aXNzb25AdGRr
LmNvbT4NCj4NCj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAw
L2ludl9pY200NTYwMF9hY2NlbC5jIGIvZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZf
aWNtNDU2MDBfYWNjZWwuYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLmJkNmI4NWUyNWUxNzkyNzQ0NzY5
OTE2ZjZkNTI5NjE1ZjlhY2Y3MjMNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2RyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2FjY2VsLmMNCj4NCj5JZiBwb3NzaWJs
ZSBpdCB3b3VsZCBoYXZlIGJlZW4gYmV0dGVyIHRvIGRvIGFjY2VsIGFuZCBneXJvIGluIGRpZmZl
cmVudCBwYXRjaGVzDQo+KG9yIG1vcmUgbWFuYWdlYWJsZSBzaXplKS4gIE5vdGUgSSBkaWRuJ3Qg
cmVhZCB0aGlzIG9uZSBvbiB0aGUgYXNzdW1wdGlvbiBhbnkNCj5pc3N1ZXMgYXJlIGxpa2VseSB0
byB0aGUgc2FtZSAoYW5kIEknbSBvdXQgb2YgdGltZSBmb3IgdG9kYXkpLg0KVGhhbmtzIGZvciB0
aGUgcmV2aWV3Lg0KWWVzIHRoZSBmaWxlcyBhcmUgc3ltbWV0cmljYWwuDQpJIHdpbGwgc3BsaXQg
dGhlIGd5cm8gYW5kIGFjY2VsIGZpbGVzIGluIGRpZmZlcmVudCBwYXRjaGVzIGZvciB0aGUgbmV4
dCB2ZXJzaW9uLg0KPg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2
MDAvaW52X2ljbTQ1NjAwX2d5cm8uYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52
X2ljbTQ1NjAwX2d5cm8uYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLjQ4MzczYmVmYWZhMGVmZTBlNWRj
YjJjOTdiMmM4MzY0MzZjZTdkNzgNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2RyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2d5cm8uYw0KPj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgaWlvX2NoYW5fc3BlY19leHRfaW5mbyBpbnZfaWNtNDU2MDBfZ3lyb19leHRfaW5m
b3NbXSA9IHsNCj4+ICsJSUlPX01PVU5UX01BVFJJWChJSU9fU0hBUkVEX0JZX0FMTCwgaW52X2lj
bTQ1NjAwX2dldF9tb3VudF9tYXRyaXgpLA0KPj4gKwl7IH0sDQo+DQo+Tm8gY29tbWEgb24gYSB0
ZXJtaW5hdGluZyBlbnRyeSBsaWtlIHRoaXMuIFdlIGRvbid0IHdhbnQgdG8gbWFrZSBpdCBlYXN5
DQo+dG8gcHV0IHRoaW5ncyBhZnRlciBpdC4NCk9LDQo+DQo+PiArfTsNCj4NCj4+ICsvKiBJSU8g
Zm9ybWF0IGludCArIG5hbm8gKi8NCj4+ICtjb25zdCBpbnQgaW52X2ljbTQ1Njg2X2d5cm9fc2Nh
bGVbXVsyXSA9IHsNCj4+ICsJLyogKy8tIDQwMDBkcHMgPT4gMC4wMDIxMzA1MjkgcmFkL3MgKi8N
Cj4+ICsJW0lOVl9JQ000NTY4Nl9HWVJPX0ZTXzQwMDBEUFNdID0gezAsIDIxMzA1Mjl9LA0KPj4g
KwkvKiArLy0gMjAwMGRwcyA9PiAwLjAwMTA2NTI2NCByYWQvcyAqLw0KPj4gKwlbSU5WX0lDTTQ1
Njg2X0dZUk9fRlNfMjAwMERQU10gPSB7MCwgMTA2NTI2NH0sDQo+PiArCS8qICsvLSAxMDAwZHBz
ID0+IDAuMDAwNTMyNjMyIHJhZC9zICovDQo+PiArCVtJTlZfSUNNNDU2ODZfR1lST19GU18xMDAw
RFBTXSA9IHswLCA1MzI2MzJ9LA0KPj4gKwkvKiArLy0gNTAwZHBzID0+IDAuMDAwMjY2MzE2IHJh
ZC9zICovDQo+PiArCVtJTlZfSUNNNDU2ODZfR1lST19GU181MDBEUFNdID0gezAsIDI2NjMxNn0s
DQo+PiArCS8qICsvLSAyNTBkcHMgPT4gMC4wMDAxMzMxNTggcmFkL3MgKi8NCj4+ICsJW0lOVl9J
Q000NTY4Nl9HWVJPX0ZTXzI1MERQU10gPSB7MCwgMTMzMTU4fSwNCj4+ICsJLyogKy8tIDEyNWRw
cyA9PiAwLjAwMDA2NjU3OSByYWQvcyAqLw0KPj4gKwlbSU5WX0lDTTQ1Njg2X0dZUk9fRlNfMTI1
RFBTXSA9IHswLCA2NjU3OX0sDQo+PiArCS8qICsvLSA2Mi41ZHBzID0+IDAuMDAwMDMzMjkwIHJh
ZC9zICovDQo+PiArCVtJTlZfSUNNNDU2ODZfR1lST19GU182Ml81RFBTXSA9IHswLCAzMzI5MH0s
DQo+PiArCS8qICsvLSAzMS4yNWRwcyA9PiAwLjAwMDAxNjY0NSByYWQvcyAqLw0KPj4gKwlbSU5W
X0lDTTQ1Njg2X0dZUk9fRlNfMzFfMjVEUFNdID0gezAsIDE2NjQ1fSwNCj4+ICsJLyogKy8tIDE1
LjYyNWRwcyA9PiAwLjAwMDAwODMyMiByYWQvcyAqLw0KPj4gKwlbSU5WX0lDTTQ1Njg2X0dZUk9f
RlNfMTVfNjI1RFBTXSA9IHswLCA4MzIyfSwNCj4NCj4JW0lOVl9JQ000NTY4Nl9HWVJPX0ZTXzE1
XzYyNURQU10gPSB7IDAsIDgzMjIgfSwNCj5ldGMNCk9rLg0KPg0KPj4gK307DQo+DQo+PiArDQo+
PiArc3RhdGljIGludCBpbnZfaWNtNDU2MDBfZ3lyb193cml0ZV9vZmZzZXQoc3RydWN0IGludl9p
Y200NTYwMF9zdGF0ZSAqc3QsDQo+PiArCQkJCQkgIHN0cnVjdCBpaW9fY2hhbl9zcGVjIGNvbnN0
ICpjaGFuLA0KPj4gKwkJCQkJICBpbnQgdmFsLCBpbnQgdmFsMikNCj4+ICt7DQo+DQo+PiArDQo+
PiArCS8qIGNsYW1wIHZhbHVlIGxpbWl0ZWQgdG8gMTQgYml0cyBzaWduZWQgKi8NCj4NCj5Vc2Ug
Y2xhbXAoKSB0aGVuISA6KQ0KR29vZCBwb2ludCAhDQo+DQo+PiArCWlmIChvZmZzZXQgPCAtODE5
MikNCj4+ICsJCW9mZnNldCA9IC04MTkyOw0KPj4gKwllbHNlIGlmIChvZmZzZXQgPiA4MTkxKQ0K
Pj4gKwkJb2Zmc2V0ID0gODE5MTsNCj4+ICsNCj4+ICsJc3QtPmJ1ZmZlci51MTYgPSBjcHVfdG9f
bGUxNihvZmZzZXQgJiBJTlZfSUNNNDU2MDBfR1lST19PRkZVU0VSX01BU0spOw0KPj4gKw0KPj4g
KwlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGRldik7DQo+PiArCWlmIChyZXQpDQo+
PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwlzY29wZWRfZ3VhcmQobXV0ZXgsICZzdC0+bG9j
aykNCj4+ICsJCXJldCA9IHJlZ21hcF9idWxrX3dyaXRlKHN0LT5tYXAsIHJlZywgJnN0LT5idWZm
ZXIudTE2LCBzaXplb2Yoc3QtPmJ1ZmZlci51MTYpKTsNCj4+ICsNCj4+ICsJcG1fcnVudGltZV9w
dXRfYXV0b3N1c3BlbmQoZGV2KTsNCj4+ICsJcmV0dXJuIHJldDsNCj4+ICt9DQo+DQo+DQo+PiAr
c3RhdGljIGludCBpbnZfaWNtNDU2MDBfZ3lyb19od2ZpZm9fZmx1c2goc3RydWN0IGlpb19kZXYg
KmluZGlvX2RldiwNCj4+ICsJCQkJCSAgdW5zaWduZWQgaW50IGNvdW50KQ0KPj4gK3sNCj4+ICsJ
c3RydWN0IGludl9pY200NTYwMF9zdGF0ZSAqc3QgPSBpaW9fZGV2aWNlX2dldF9kcnZkYXRhKGlu
ZGlvX2Rldik7DQo+PiArCWludCByZXQ7DQo+PiArDQo+PiArCWlmIChjb3VudCA9PSAwKQ0KPj4g
KwkJcmV0dXJuIDA7DQo+PiArDQo+PiArCWd1YXJkKG11dGV4KSgmc3QtPmxvY2spOw0KPj4gKw0K
Pj4gKwlyZXQgPSBpbnZfaWNtNDU2MDBfYnVmZmVyX2h3Zmlmb19mbHVzaChzdCwgY291bnQpOw0K
Pj4gKwlpZiAoIXJldCkNCj4+ICsJCXJldCA9IHN0LT5maWZvLm5iLmd5cm87DQo+SSdkIHByZWZl
ciBrZWVwaW5nIGVycm9ycyBvdXQgb2YgbGluZS4NCj4JaWYgKHJldCkNCj4JCXJldHVybiByZXQ7
DQo+DQo+CXJldHVybiBzdC0+Zmlmby5tYi5neXJvOw0KPg0KPlN1Y2ggZXJyb3IgZm9ybWF0dGlu
ZyBoZWxwcyBhIGJpdCB3aGVuIHBlb3BsZSBhcmUgcmVhZGluZyBhIGxvdCBvZiBjb2RlDQo+YmVj
YXVzZSBpdCBpcyB2ZXJ5IGNvbW1vbi4NCj4NClllcywgYWdyZWVkLg0KPj4gKw0KPj4gKwlyZXR1
cm4gcmV0Ow0KPj4gK30NCj4NCj4+ICtpbnQgaW52X2ljbTQ1NjAwX2d5cm9fcGFyc2VfZmlmbyhz
dHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPj4gK3sNCj4+ICsJc3RydWN0IGludl9pY200NTYw
MF9zdGF0ZSAqc3QgPSBpaW9fZGV2aWNlX2dldF9kcnZkYXRhKGluZGlvX2Rldik7DQo+PiArCXN0
cnVjdCBpbnZfaWNtNDU2MDBfc2Vuc29yX3N0YXRlICpneXJvX3N0ID0gaWlvX3ByaXYoaW5kaW9f
ZGV2KTsNCj4+ICsJc3RydWN0IGludl9zZW5zb3JzX3RpbWVzdGFtcCAqdHMgPSAmZ3lyb19zdC0+
dHM7DQo+PiArCXNzaXplX3QgaSwgc2l6ZTsNCj4+ICsJdW5zaWduZWQgaW50IG5vOw0KPj4gKwlj
b25zdCBzdHJ1Y3QgaW52X2ljbTQ1NjAwX2ZpZm9fc2Vuc29yX2RhdGEgKmFjY2VsLCAqZ3lybzsN
Cj4+ICsJY29uc3QgX19sZTE2ICp0aW1lc3RhbXA7DQo+PiArCWNvbnN0IHM4ICp0ZW1wOw0KPj4g
Kwl1bnNpZ25lZCBpbnQgb2RyOw0KPj4gKwlzNjQgdHNfdmFsOw0KPj4gKwlzdHJ1Y3QgaW52X2lj
bTQ1NjAwX2d5cm9fYnVmZmVyIGJ1ZmZlcjsNCj4NCj5DYW4gd2UgZ2l2ZSBzb21lIHNvcnQgb2Yg
b3JkZXIgdG8gdGhlc2UgbG9jYWwgdmFyaWFibGVzLiBQcmV0dHkgbXVjaCBhbnl0aGluZyBpcw0K
PmZpbmUuIEZhaWxpbmcgYW55dGhpbmcgZWxzZSwgcmV2ZXJzZSB4bWFzIHRyZWUuIE1heWJlIGFs
c28gcHVzaCBhbnkNCj50aGF0IGFyZSBsb2NhbCB0byB0aGUgbG9vcCBpbiB0aGVyZT8NClN1cmUu
DQo+DQo+PiArDQo+PiArCS8qIHBhcnNlIGFsbCBmaWZvIHBhY2tldHMgKi8NCj4+ICsJZm9yIChp
ID0gMCwgbm8gPSAwOyBpIDwgc3QtPmZpZm8uY291bnQ7IGkgKz0gc2l6ZSwgKytubykgew0KPj4g
KwkJc2l6ZSA9IGludl9pY200NTYwMF9maWZvX2RlY29kZV9wYWNrZXQoJnN0LT5maWZvLmRhdGFb
aV0sDQo+PiArCQkJCSZhY2NlbCwgJmd5cm8sICZ0ZW1wLCAmdGltZXN0YW1wLCAmb2RyKTsNCj4+
ICsJCS8qIHF1aXQgaWYgZXJyb3Igb3IgRklGTyBpcyBlbXB0eSAqLw0KPj4gKwkJaWYgKHNpemUg
PD0gMCkNCj4+ICsJCQlyZXR1cm4gc2l6ZTsNCj4+ICsNCj4+ICsJCS8qIHNraXAgcGFja2V0IGlm
IG5vIGd5cm8gZGF0YSBvciBkYXRhIGlzIGludmFsaWQgKi8NCj4+ICsJCWlmIChneXJvID09IE5V
TEwgfHwgIWludl9pY200NTYwMF9maWZvX2lzX2RhdGFfdmFsaWQoZ3lybykpDQo+PiArCQkJY29u
dGludWU7DQo+PiArDQo+PiArCQkvKiB1cGRhdGUgb2RyICovDQo+PiArCQlpZiAob2RyICYgSU5W
X0lDTTQ1NjAwX1NFTlNPUl9HWVJPKQ0KPj4gKwkJCWludl9zZW5zb3JzX3RpbWVzdGFtcF9hcHBs
eV9vZHIodHMsIHN0LT5maWZvLnBlcmlvZCwNCj4+ICsJCQkJCQkJc3QtPmZpZm8ubmIudG90YWws
IG5vKTsNCj4+ICsNCj4+ICsJCS8qIGJ1ZmZlciBpcyBjb3BpZWQgdG8gdXNlcnNwYWNlLCB6ZXJv
aW5nIGl0IHRvIGF2b2lkIGFueSBkYXRhIGxlYWsgKi8NCj4+ICsJCW1lbXNldCgmYnVmZmVyLCAw
LCBzaXplb2YoYnVmZmVyKSk7DQo+V2Ugb25seSBjYXJlIGFib3V0IG5vdCBsZWFraW5nIGRhdGEg
dGhhdCBpcyBzZW5zaXRpdmUuICBOb3Qgc3RhbGUgcmVhZGluZ3Mgb3INCj5zaW1pbGFyIHNvIGNh
biBqdXN0IGRvDQo+CXN0cnVjdCBpbnZfaWNtNDU2MDBfZ3lyb19idWZmZXIgYnVmZmVyID0geyB9
Ow0KPmFib3ZlIGFuZCBza2lwIHRoZSBtZW1zZXQgaGVyZS4NCk9rLg0KPg0KPj4gKwkJbWVtY3B5
KCZidWZmZXIuZ3lybywgZ3lybywgc2l6ZW9mKGJ1ZmZlci5neXJvKSk7DQo+PiArCQkvKiBjb252
ZXJ0IDggYml0cyBGSUZPIHRlbXBlcmF0dXJlIGluIGhpZ2ggcmVzb2x1dGlvbiBmb3JtYXQgKi8N
Cj4+ICsJCWJ1ZmZlci50ZW1wID0gdGVtcCA/ICgqdGVtcCAqIDY0KSA6IDA7DQo+PiArCQl0c192
YWwgPSBpbnZfc2Vuc29yc190aW1lc3RhbXBfcG9wKHRzKTsNCj4+ICsJCWlpb19wdXNoX3RvX2J1
ZmZlcnNfd2l0aF90aW1lc3RhbXAoaW5kaW9fZGV2LCAmYnVmZmVyLCB0c192YWwpOw0KPj4gKwl9
DQo+PiArDQo+PiArCXJldHVybiAwOw0KPj4gK30NCj4+IA0KPg0KPg0K

