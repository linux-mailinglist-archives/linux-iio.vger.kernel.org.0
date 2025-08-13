Return-Path: <linux-iio+bounces-22651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29BCB246BF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CEE16C1C6
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64D2D738D;
	Wed, 13 Aug 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="txjF07SU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28A28F4;
	Wed, 13 Aug 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079709; cv=fail; b=WoubgwOGvo0sNzpZO0u77NyQScaEVpCliQMoWoaLLK4PzZx7P/dUe2P5t19J0B5SU2Ku9KrsrAByu95Nu6mxF6ADW9kRJXQsk5huF5fW1ZACPawVOtZJd0wxbIdtOxpvkKeGpcyWb57gy0nEcADYZyVv5ypP71y+70OjMAA/TBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079709; c=relaxed/simple;
	bh=TaRTNSGqS1879iiuwvyGvy++MWzyqjNbZwumR3fSXz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g3bw45xUNhMmHFVzvVLXzoEc0Xp6g2Whv5XXptQ4d70mAlFGcAiGnAf51egez5/xEdlyvAkAdqsPwz79HwK71ABHhV9v9eDHr2Pks9RWHtZsTkePaKq76N0fn4+h8cW0OLc8F4srp25NwoapfS8CU+4bqlAG9VPFP0GsjNRvir0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=txjF07SU; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D9on2J031513;
	Wed, 13 Aug 2025 10:08:17 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012004.outbound.protection.outlook.com [40.107.149.4])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48dvq0jn3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 10:08:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf7yCLADThBlyG6pseC5/F72K7jtv4Zbu0XeUwGYymlM5fuAdqrBn9sUkeWtEdLLD8mReqhdG4R6TMVcDIB6DhhFBBqtVpKz7zRAFmfR5cVHuZaiGVADoYhQD+YJ8ABNKeDCs/Mppej0+Obaz6jS8DlBY+9VlqsDuCyh04v3Ixoos+AtZNcyLnvFI9U1XDbHjUtM4JIqGTxwd0pAJLBB8jk5MapNM30vw50Aso/cryFvzpXpfWLCoskdCsNGk4+gjOG7vOu2lkSees9mdqmN8QIphKT8xCA6+iD1BuATr/qsqb/JcE1fmR9hlJjyCb0wFHx1R7zezDEMeFLq9hF9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaRTNSGqS1879iiuwvyGvy++MWzyqjNbZwumR3fSXz0=;
 b=RhaZ2gFJl5iKYgaWCbjJkIADPTdL+tGmJC85sRM9YwqnOlDw98EoDAbSZQEZNYH0HVm4r+b/8qEg8kLaLpNphqTZIWutVOiYAE7wO70d8uRiN20K/pG3I3FAZ664NhEWK0+f1XiFqYiBiUTOdg/HHG/UkLJrFU9HK2/i+QSerMJS/CwUMciuvu8+5BzesX+zffYFuHa1dNYaArLUTNEp03hPPB5L67uGA0ihREN4zuLTiercqCbNwiMVM7NE4CN/rWW+dNSWibkC2fJ88NcqicFQhx2ah1WqBhUt0ovfgeSwnTxXISiCsYi3Df6NPfl/HbzDEt5OuL+O7sI/RI2MRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaRTNSGqS1879iiuwvyGvy++MWzyqjNbZwumR3fSXz0=;
 b=txjF07SUX0wxlh6YZlRoEoFoqOZLrB2s4oDfRleQwuBdsRgn00F5w3feqNA6Hi6ZclgVhTID8bSzF3WyB9n+QgIqqEBVZLSH4S2EAm+HV7OgH5Ccj7kI3CzTG45kCZHjbJ8LIUslFYcU+iLgWBYbXpSgcjkTGF4S+qwvXhAvnkcmm4ai4ezaes8AdKDPcPV7Hlz4ly+SkmfQBmrqEs4Yjp6A5BoEmGJHq6KTpcyCOfgI3iX9RRzgY3aanfA/D9Ev8GbcWC9BZ/3HPdWtDVwnwE+7Ln/pivzXo87m9MKcHGdtOLDCHUcIkAn/ZYUdBnFgjb8hvLTAky0WzT9WbWIjLA==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR4P281MB4563.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 10:08:11 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 10:08:11 +0000
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
Subject: RE: [PATCH v3 3/8] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Topic: [PATCH v3 3/8] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Index: AQHb9x5kRXUz0zglXUuEFnEerxJbWLRBe1uAgB8Ka3A=
Date: Wed, 13 Aug 2025 10:08:11 +0000
Message-ID:
 <FR2PPF4571F02BC17D1C2EFD573E55F9C428C2AA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
	<20250717-add_newport_driver-v3-3-c6099e02c562@tdk.com>
 <20250724170539.13cface5@jic23-huawei>
In-Reply-To: <20250724170539.13cface5@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR4P281MB4563:EE_
x-ms-office365-filtering-correlation-id: cf1bf75c-3129-4d58-79c7-08ddda514f47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|19092799006|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1BQUjdtdndTOGdTdkN0dmJOV1FFZEtGWWhadDg5QWhQZ0syOEsxVjY5U3JO?=
 =?utf-8?B?K2tiQ1dCaTNUdTJjL0x1dGFTRFQ2NkkxR1NvaGtXbTk3TXBRQ3R5RnFKYXBE?=
 =?utf-8?B?TFM5WHFBVHZGaElHUHN2VU01WFBubjVsMDRBTUFMTWFqRzhyOXg0bFRLTWg5?=
 =?utf-8?B?WHYzdGxudURWS1g1Yk56Umdyck8zU3o2VWxWNEZYRGt5ZGJtanJQZWpONzdi?=
 =?utf-8?B?M25wT0FGeGVlcFZLWVVmSzNMVVhrc2JCOTBibitPOGlEOHJoRHdtNWhMYWlD?=
 =?utf-8?B?QU8rcllmdzNFYXJFNjB4YTUyYVIycGN1WTlkMFdaVEk5WHMyTzhlYmk0S0Nu?=
 =?utf-8?B?V1pFYkozcVY5NndKRFZhdnQzMjkvYWxsVC9MeGlGY2M0RitPQWszZFlwalVG?=
 =?utf-8?B?MmRpa1M1dEFiUHlOY0dCYjJxZ2lGd0N4bGU2WlA5QUFMVXlSNkRGaVozNFpt?=
 =?utf-8?B?eElzeFpTdFZzN0tCbFREendtcUUyWXRMSWkya0xUYUFNcTErTjZ3Yml0QlBo?=
 =?utf-8?B?dTJ6TWJxQ2NVZ1MwR1RNVndzKzVzTmhnV3NjWkp5MFJkT3ZIMEdSSVcyMVNl?=
 =?utf-8?B?Zk5BU3orZWFoWXE5TWczM25HWk81NGpWcFZkb002bHdBNDk3b1Rjd2VvbEsw?=
 =?utf-8?B?a3lmek1wclprbXJRNWtCYWd5OEtnK1lOUVlWVm5sQVdma2xXWUxYUkM4c3Jj?=
 =?utf-8?B?N1lmdksrYkExT0dmUzQ3TXUzZHdjLzNMUTdUbWdvZjFoSENITjdsUTBxd00y?=
 =?utf-8?B?M0NIQXhBcjFuWWVYbkVTbUMvNFR2Qk1vd0x3Y2Fwbk9GdWxiZEZMS3VPSkFG?=
 =?utf-8?B?MWpTdzUzTmhYNlpuSENKN1NuaFYySkEwT3dnTXFXamRaQk1rTERVeGtPL01E?=
 =?utf-8?B?cUFzQmE4MlJoeDc0VFMzWW9RR1htSmxxOTVBeFJXUHN0V3RzaFdTT1Ric0l2?=
 =?utf-8?B?dHpCUDFkVkF1Sml5K1FUUmNIWXZ0aWlPc2xWcCtmcmhMODN4OCs3YjByeHRt?=
 =?utf-8?B?blNtanIzdC80T2w4UnNpaDFmcGRHVkptdEtYZ1lNTThoaDlXV1RPcmROMEx2?=
 =?utf-8?B?ZFJ3K0V1azg1azJhc2dHTEFQVit1TWE1eXBlK2RXK2hEMEVtZzF5TzdkY3o4?=
 =?utf-8?B?UHkwUnh0Q05uTi9iSG9pNyt0VWRnV2syMXVGQ2pDS1pvV1M4UE5MeUZxQmlr?=
 =?utf-8?B?VWVFN2owWnRyOTZKb1Z5ZEdxVUpGQktmcnpJQURyeFhUeWtSczhlQTJ5NlI0?=
 =?utf-8?B?eEFFYlJTbXNsdjQ1TzlvUTFmeURHeTVFMUIxV0kxNEpJQ1UrNkd6YjY5MGNp?=
 =?utf-8?B?ZS91WnllOUJOVnByTFNJa1h6TVR0ZUhVRUZJVTc4cmJ1cGNWa3lLcis0Z1pY?=
 =?utf-8?B?dU9jQlZwc3A0RjVKM2dZWEp2eHpLMGpiQkhvdTNvNjNOSzdBbzR3MUlHYTAv?=
 =?utf-8?B?SlBoajZ3TEp0UU5YMkRiSzhaU2c5cTZsZHBoa3d5M05LOVFyd2piOC8ySlg3?=
 =?utf-8?B?SjZsWDFuVy8zcDQ1RXorUjMyemoxSmNsTVJ4bGZQSjJLR0lHZlVaZEZiaVUy?=
 =?utf-8?B?dUxHUWJVYzVPWEJtNEN5S2NhOFpWbGhRTC9ER05pZjRxQXNKKzBWdGtheVNB?=
 =?utf-8?B?YzV4Mk9rL2tweE8xOHh0SGhOTTRUZnRlWk5SSFIzVlMxZzRyU3ZOUUtvZnZw?=
 =?utf-8?B?WlZmRmxEWUZSdXBaVmhBYzhqenBwNlV4UUVvOU5KKytpWlpPckxWRi9TVXhD?=
 =?utf-8?B?VWZWQW8xNS9iYTArekRPR2lrMStFQjBEK05aQk5EZXRvdWo0NlJiSmxDL3FT?=
 =?utf-8?B?ZGhMZHBhRTNSbTh6ejJVUDNFZXprOUJnaWlXdnkvYVQzakhWTW9URzJsd3Iy?=
 =?utf-8?B?WDNONDQyYzhWZE05RENKcWhzdWJUank0bVA3M3hpYVVIYlVia0tORkF3elJk?=
 =?utf-8?B?WE15Ymw1b0NLcDA0UU9CQ3NNR0U4TFRLT0IwcG1qVk5wK243b0xwK2tYVDcv?=
 =?utf-8?B?ME1XV085aDIzRWpWYnRjdFlNcFN5aU8rOFY2WCtBYk9qNTdRMXlCWkpaaXVa?=
 =?utf-8?Q?homU90?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(19092799006)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHhMem1ndVNBSHJtazhtVU82TXRDd3YrYnhRMEIzdUVWNUQzazdyK1ZLNFpZ?=
 =?utf-8?B?TGZlanRjbTVsVlZ0aG5ONmJIRnNZUFlsZk51NFgvaHRrOXJPYmVsZVFEcHla?=
 =?utf-8?B?Wk5JYWdEWEVyOWtlbFNreVVyN1NPbTVIK1NNdUpiU0RYcmxMM3EzNE1yYWVk?=
 =?utf-8?B?aU9oM2k4ajlMalh3Wm4xRWpDbjVPSnVsQ3VGR0VKTmF6YjRmS1dMRW1pek5v?=
 =?utf-8?B?dk83cFB1cFBBUXoyRjc5NTFHYTZ1b05nWlU1OUhCbStKa2xlMW9kUGphREVF?=
 =?utf-8?B?NWZUQ0tUY29jS0lLQUx4aEx6cUNPQnA1L0dSMW1BalB6NFE3cVZWNkY5aUJN?=
 =?utf-8?B?cmVwL1dvMW4xN1IvaE1Pa3dMQUxsMkhKNkVFYzl3SVRMWmk3dUFvZ1pKdytx?=
 =?utf-8?B?YWpxZGNMaG8rMHgvMkc3RndlbjlhSExsMVpYbkVYMzJ5ZXhkNWljZVhLczNM?=
 =?utf-8?B?U3RKVVF6RjVNTE05K0V1cnRvTVlRTm1tWkVIWDY4LzBpL0JYajJoWVQvZVFS?=
 =?utf-8?B?blFxN3o4R3pHdkplMXI5Z3hHTlZuaC8reUR5VG51bEhZTWpPWFlubjFWampJ?=
 =?utf-8?B?MkFjd3N3VFk5Z3BrWVNkV1N4UUU2WE5NNWxkQjBVYmlVMXVESVBMa3BEL1E2?=
 =?utf-8?B?c0Y3SnR5NHJ4V1VkWFpaOWV3MlRxN2dEM2hQME84MlBJbXlHM09EdGN6VzRB?=
 =?utf-8?B?c2kwanp5ZXpJVThhMkFGa1FDTU82c0ppSWJQQUpvYlQwNGN6TUE0TXhRdGdy?=
 =?utf-8?B?ZVZ1M0dwZVRSWTh3Y3k5SlJWdGNUanRTcmc1Qk5GSkF0Q3N5REo3Q3VBOGcv?=
 =?utf-8?B?Q2Z3OVNZZFpuWktFQWJ2clFzUVpGejZwekFVU2NzTXBtWkFYWU5DN2cwaDJn?=
 =?utf-8?B?ZzZNSFowREdWRXlZRkhYYWM2Z1FIMHBFa1NQUjZKbnhaeGRBRlNtZ3MrcmtC?=
 =?utf-8?B?T2ZibVQ2VndibHNVcGJaQmtVcFRMTmlSMW9xMkhTZzNGR3JxK2RCU1lFS2dO?=
 =?utf-8?B?a2paVmxjKzRVY2xSblFYUGFDWDJTN0l6eTZZa1JuUnA5WGN5QkxGT1JlWlpK?=
 =?utf-8?B?L0lXRzhFWmp5SUxNcVRnempTYk4zOGR1ejVPTXNpNVRqZXBxa05vVzlSdkQw?=
 =?utf-8?B?cHBDWkFBN2E0dzVZSWh3R1FrekxheXZpY1N4Qnp6b20xNmJ3UjMrMUh2MFk4?=
 =?utf-8?B?OEFFdk0yaTZscGlNTnpDUzJxdWJWOTRHem9JSk1Rd2NDa2hNOXFpdmp6MWdL?=
 =?utf-8?B?eTgvME4zb1J3bjFlRjZmUFpvbXhkYi9wVWF2M0g2WHZ4YWwwaHVnRCttd1hh?=
 =?utf-8?B?T1E2dnRTQVQ4a1lkQXAyano3ZklQSHlCTkJlUEtNYWF4RGhmMG92QnhlNUxI?=
 =?utf-8?B?RklJdVI1SXdWaEhXbVdzZ2RSYkxoaDNnS0xKckRMNmR1czQ5amd4UCs1cWNE?=
 =?utf-8?B?aWdHWWd0a0o4VnRMQXpjNEcybTVqNGRMTE9QRGpMdnBiaE0vY1llQUo2alY1?=
 =?utf-8?B?Qk9UZDFoUFhLZ0hiM3I5N2VUR2tkVjNHc1M1cFc2Zy9xSXJ5RE1PSGxjdkpO?=
 =?utf-8?B?bzg4UzAzRGpsQUM5MTh2N0FCTkVmV2RocVJySkNZQzhrb3FKNUdZN2pKeE1O?=
 =?utf-8?B?OGdFcW9UL3ZVU0E4WlplTU1uN1NwV3dQUDNlQXdKNys5SEdXaGJnMnZZVjhx?=
 =?utf-8?B?VGZiRG41NU0xN3lrbXJVSjQyQkxIK0JQMXQ1OG9TQU5HSTNuK2phUUF1VkFS?=
 =?utf-8?B?OFE4NkFzYVJIT1lYejgyMFlwRWhGTm0rT0xISGlSaFZhb3ZtYkkzL0Q3dHpC?=
 =?utf-8?B?bHpvdXZOWlRrQTRDbmpLMS85cWpDMDUyWmNubUYxMWlmU2h5SGNoWUxpMUZu?=
 =?utf-8?B?S3JrZlEydXQyUWR2WSs3L25CVDJ2S0Nrd1U3Z3Z6emx2TkhJR08yZEQ0ZzFj?=
 =?utf-8?B?Nmt0b1lhOVRrQXdLRUhYZG9hbmdCZ2ozSXd2bWsydzl5OW9wR3JMMHhJVHcr?=
 =?utf-8?B?Tm1yQkdiQXZVSEFZK1VMUS81RTJQUnlwMnZWaTFCdnZiTHJYM1NRcGY0Q1l2?=
 =?utf-8?B?MVU1YVJQd09kdnM1SnpqUGdCZXhNRzZRSmNIZjhaTjJoOEQvdjh4SjYrd2ZE?=
 =?utf-8?B?d24yWnR2dk00YTNZSnE2d3lHSFAzZnhsNllQS1BuUzhUd1FwdTZSbGZ4Q0lj?=
 =?utf-8?Q?Xf0f1Vr3R/jzGVg8cK7Xy6ympy9vDVEGPaksC751lV6P?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1bf75c-3129-4d58-79c7-08ddda514f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 10:08:11.3700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvNYOU0jsPli//xuzPnOLhXVFnmFQjYXLjvrZIomDyhWKh2pLK9TDGqZWsIqyRC21I6IiNJ3qiMVa6TMkojgYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4563
X-Proofpoint-GUID: IEVv8bqVAZqIHCVutqTBYxA3cmFFADuQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwOSBTYWx0ZWRfXxbjeXZd0Z9Pu
 xjeNZS1DRcfvKupLhB1Bt+eY7EwLy4I501WpQW9vDyB3VOpNQ+eWDnSQB0K23m4QGSK/h1/YJiA
 z7X/6cSQYaBYUUxPIoVGaWCI0TgMyxMAYDfWFA1SF1m/mV9kKHR62ZhMx0bS4rhgndLCOgxiW1L
 5BzhxevZiHGrtIufMxXSLGmSa2Ly24/fZdItveeivDq6S5YAgb2UBvZceV6mpflMCn2IQmx7X+0
 bRmuj69Hnxo/g8Rtd9yYmq1XIlqSbnC+JGZ4iSDmuO1pfFLWGU9Hu+faIlCqlz1lHArt37RVEzb
 aLuO4VbC6N2NSPKor3NxkejeGJKFMlKyKNNmgNtUTfU9z2H0CuERl55hd/8tA8pxKZ4gkdSC1Go
 RVZzcKlv
X-Proofpoint-ORIG-GUID: IEVv8bqVAZqIHCVutqTBYxA3cmFFADuQ
X-Authority-Analysis: v=2.4 cv=AO34vM+d c=1 sm=1 tr=0 ts=689c6411 cx=c_pps
 a=BpQ3W2qCDJd+yYDy+CeV7Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=efLMQ4SIDJokG4EvQH8A:9 a=QEXdDO2ut3YA:10
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
IFRodXJzZGF5LCBKdWx5IDI0LCAyMDI1IDY6MDYgUE0NCj5UbzogUmVtaSBCdWlzc29uIHZpYSBC
NCBSZWxheSA8ZGV2bnVsbCtyZW1pLmJ1aXNzb24udGRrLmNvbUBrZXJuZWwub3JnPg0KPkNjOiBS
ZW1pIEJ1aXNzb24gPFJlbWkuQnVpc3NvbkB0ZGsuY29tPjsgRGF2aWQgTGVjaG5lciA8ZGxlY2hu
ZXJAYmF5bGlicmUuY29tPjsgTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkgU2hl
dmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8
Y29ub3IrZHRAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+U3ViamVj
dDogUmU6IFtQQVRDSCB2MyAzLzhdIGlpbzogaW11OiBpbnZfaWNtNDU2MDA6IGFkZCBidWZmZXIg
c3VwcG9ydCBpbiBpaW8gZGV2aWNlcw0KPg0KPk9uIFRodSwgMTcgSnVsIDIwMjUgMTM6MjU6NTUg
KzAwMDANCj5SZW1pIEJ1aXNzb24gdmlhIEI0IFJlbGF5IDxkZXZudWxsK3JlbWkuYnVpc3Nvbi50
ZGsuY29tQGtlcm5lbC5vcmc+IHdyb3RlOg0KPg0KPj4gRnJvbTogUmVtaSBCdWlzc29uIDxyZW1p
LmJ1aXNzb25AdGRrLmNvbT4NCj4+IA0KPj4gQWRkIEZJRk8gY29udHJvbCBmdW5jdGlvbnMuDQo+
PiBTdXBwb3J0IGh3ZmlmbyB3YXRlcm1hcmsgYnkgbXVsdGlwbGV4aW5nIGd5cm8gYW5kIGFjY2Vs
IHNldHRpbmdzLg0KPj4gU3VwcG9ydCBod2ZpZm8gZmx1c2guDQo+PiANCj4+IFNpZ25lZC1vZmYt
Ynk6IFJlbWkgQnVpc3NvbiA8cmVtaS5idWlzc29uQHRkay5jb20+DQo+QSBmZXcgbWlub3IgdGhp
bmdzIGlubGluZS4NCj4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAv
TWFrZWZpbGUgICAgICAgICAgICAgIHwgICAxICsNCj4+ICBkcml2ZXJzL2lpby9pbXUvaW52X2lj
bTQ1NjAwL2ludl9pY200NTYwMC5oICAgICAgICB8ICAgNyArDQo+PiAgZHJpdmVycy9paW8vaW11
L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDBfYnVmZmVyLmMgfCA1MTQgKysrKysrKysrKysrKysr
KysrKysrDQo+PiAgZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDBfYnVm
ZmVyLmggfCAgOTkgKysrKw0KPj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2lj
bTQ1NjAwX2NvcmUuYyAgIHwgMTM3ICsrKysrLQ0KPj4gIDUgZmlsZXMgY2hhbmdlZCwgNzU3IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDU2MDAvTWFrZWZpbGUgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1
NjAwL01ha2VmaWxlDQo+PiBpbmRleCA0ZjQ0MmI2MTg5NmU5MTY0N2M3OTQ3YTA0NDk0OTc5MmJh
ZTA2YTMwLi4xOWM1MjFmZmJhMTdiMGQxMDhhOGVjYjQ1ZWNkZWEzNWRmZjZmZDE4IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9NYWtlZmlsZQ0KPj4gKysrIGIv
ZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9NYWtlZmlsZQ0KPj4gQEAgLTIsMyArMiw0IEBA
DQo+PiAgDQo+PiAgb2JqLSQoQ09ORklHX0lOVl9JQ000NTYwMCkgKz0gaW52LWljbTQ1NjAwLm8N
Cj4+ICBpbnYtaWNtNDU2MDAteSArPSBpbnZfaWNtNDU2MDBfY29yZS5vDQo+PiAraW52LWljbTQ1
NjAwLXkgKz0gaW52X2ljbTQ1NjAwX2J1ZmZlci5vDQo+PiBcIE5vIG5ld2xpbmUgYXQgZW5kIG9m
IGZpbGUNCj4NCj5GaXggdGhpcyBieSBhZGRpbmcgb25lLg0KT2suDQo+DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDAuaCBiL2RyaXZlcnMv
aWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwLmgNCj4+IGluZGV4IDU5YWVkNTliOTRj
YTJkNDcwOWIwYzk4NmRkZWRhODBiMzMwNjRmOTAuLjU2MjVjNDM3YjZmNTQzMzZmNmU2NTJjMmFl
MmU0ZWE4Zjg4ZTIzOTYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1
NjAwL2ludl9pY200NTYwMC5oDQo+PiArKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAw
L2ludl9pY200NTYwMC5oDQo+DQo+PiAgDQo+PiArI2RlZmluZSBJTlZfSUNNNDU2MDBfU0VOU09S
X0NPTkZfS0VFUF9WQUxVRVMge1U4X01BWCwgVThfTUFYLCBVOF9NQVgsIFU4X01BWCwgfQ0KPj4g
Kw0KPj4gIHN0cnVjdCBpbnZfaWNtNDU2MDBfY29uZiB7DQo+PiAgCXN0cnVjdCBpbnZfaWNtNDU2
MDBfc2Vuc29yX2NvbmYgZ3lybzsNCj4+ICAJc3RydWN0IGludl9pY200NTYwMF9zZW5zb3JfY29u
ZiBhY2NlbDsNCj4+IEBAIC0xMjcsNiArMTMyLDcgQEAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBpbnZf
aWNtNDU2MDBfY2hpcF9pbmZvIGludl9pY200NTY4OV9jaGlwX2luZm87DQo+PiAgICogIEBpbmRp
b19neXJvOglneXJvc2NvcGUgSUlPIGRldmljZS4NCj4+ICAgKiAgQGluZGlvX2FjY2VsOglhY2Nl
bGVyb21ldGVyIElJTyBkZXZpY2UuDQo+PiAgICogIEB0aW1lc3RhbXA6CQlpbnRlcnJ1cHQgdGlt
ZXN0YW1wcy4NCj4+ICsgKiAgQGZpZm86CQlGSUZPIG1hbmFnZW1lbnQgc3RydWN0dXJlLg0KPj4g
ICAqICBAYnVmZmVyOgkJZGF0YSB0cmFuc2ZlciBidWZmZXIgYWxpZ25lZCBmb3IgRE1BLg0KPj4g
ICAqLw0KPj4gIHN0cnVjdCBpbnZfaWNtNDU2MDBfc3RhdGUgew0KPj4gQEAgLTE0Myw2ICsxNDks
NyBAQCBzdHJ1Y3QgaW52X2ljbTQ1NjAwX3N0YXRlIHsNCj4+ICAJCXM2NCBneXJvOw0KPj4gIAkJ
czY0IGFjY2VsOw0KPj4gIAl9IHRpbWVzdGFtcDsNCj4+ICsJc3RydWN0IGludl9pY200NTYwMF9m
aWZvIGZpZm87DQo+DQo+SGF2aW5nIHRoYXQgOCB0aG91c2FuZCBlbGVtZW50IGJ1ZmZlciBpbiBo
ZXJlIHNlZW0gdW53aXNlLiAgTm9ybWFsbHkgSSBlbmNvdXJhZ2UgcHV0dGluZw0KPmV2ZXJ5dGhp
bmcgcG9zc2libGUgaW4gaGVyZSwgYnV0IHRoaXMgbWF5YmUgYSBjYXNlIHdoZXJlIGEga3phbGxv
YygpIGZvciB0aGF0IGJ1ZmZlciBpcw0KPmdvaW5nIHRvIHdhc3RlZCBsZXNzIHNwYWNlLg0KU2Vl
bXMgZmluZSwgSSdsbCBpbXBsZW1lbnQgaXQgdXNpbmcgZGV2bV9remFsbG9jLg0KPg0KPj4gIAl1
bmlvbiB7DQo+PiAgCQl1OCBidWZmWzJdOw0KPj4gIAkJX19sZTE2IHUxNjsNCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQ1NjAwL2ludl9pY200NTYwMF9idWZmZXIuYyBi
L2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2MDAvaW52X2ljbTQ1NjAwX2J1ZmZlci5jDQo+PiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMC4uYjM3NjA3ZTUyNzIxMDk3ZGFmNjM2MmJhYzIwMDAxYjBkNDIxMGY0Yg0K
Pj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9p
bnZfaWNtNDU2MDBfYnVmZmVyLmMNCj4+IEBAIC0wLDAgKzEsNTE0IEBADQo+DQo+Pg0KPj4gK3Zv
aWQgaW52X2ljbTQ1NjAwX2J1ZmZlcl91cGRhdGVfZmlmb19wZXJpb2Qoc3RydWN0IGludl9pY200
NTYwMF9zdGF0ZSAqc3QpDQo+PiArew0KPj4gKwl1MzIgcGVyaW9kX2d5cm8sIHBlcmlvZF9hY2Nl
bCwgcGVyaW9kOw0KPj4gKw0KPj4gKwlpZiAoc3QtPmZpZm8uZW4gJiBJTlZfSUNNNDU2MDBfU0VO
U09SX0dZUk8pDQo+PiArCQlwZXJpb2RfZ3lybyA9IGludl9pY200NTYwMF9vZHJfdG9fcGVyaW9k
KHN0LT5jb25mLmd5cm8ub2RyKTsNCj4+ICsJZWxzZQ0KPj4gKwkJcGVyaW9kX2d5cm8gPSBVMzJf
TUFYOw0KPj4gKw0KPj4gKwlpZiAoc3QtPmZpZm8uZW4gJiBJTlZfSUNNNDU2MDBfU0VOU09SX0FD
Q0VMKQ0KPj4gKwkJcGVyaW9kX2FjY2VsID0gaW52X2ljbTQ1NjAwX29kcl90b19wZXJpb2Qoc3Qt
PmNvbmYuYWNjZWwub2RyKTsNCj4+ICsJZWxzZQ0KPj4gKwkJcGVyaW9kX2FjY2VsID0gVTMyX01B
WDsNCj4+ICsNCj4+ICsJaWYgKHBlcmlvZF9neXJvIDw9IHBlcmlvZF9hY2NlbCkNCj4+ICsJCXBl
cmlvZCA9IHBlcmlvZF9neXJvOw0KPg0KPglzdC0+Zmlmby5wZXJpb2QgPSBtaW4ocGVyaW9kX2d5
cm8sIHBlcmlvZF9hY2NlbCk7DQpPay4NCj4NCj4+ICsJZWxzZQ0KPj4gKwkJcGVyaW9kID0gcGVy
aW9kX2FjY2VsOw0KPj4gKw0KPj4gKwlzdC0+Zmlmby5wZXJpb2QgPSBwZXJpb2Q7DQo+PiArfQ0K
Pg0KPj4gKw0KPj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgaW52X2ljbTQ1NjAwX3dtX3RydW5jYXRl
KHVuc2lnbmVkIGludCB3YXRlcm1hcmssIHNpemVfdCBwYWNrZXRfc2l6ZSwNCj4+ICsJCQkJCSAg
ICAgdW5zaWduZWQgaW50IGZpZm9fcGVyaW9kKQ0KPj4gK3sNCj4+ICsJc2l6ZV90IHdhdGVybWFy
a19tYXgsIGdyYWNlX3NhbXBsZXM7DQo+PiArDQo+PiArCS8qIEtlZXAgMjBtcyBmb3IgcHJvY2Vz
c2luZyBGSUZPLiAqLw0KPj4gKwlncmFjZV9zYW1wbGVzID0gKDIwVSAqIDEwMDAwMDBVKSAvIGZp
Zm9fcGVyaW9kOw0KPg0KPkknbW5vdCBzdXJlIHdoYXQgdGhlIG11bHRpcGxlciBoZXJlIGlzIGJ1
dCBtYXliZSAyMFUgKiBNSUNSTw0KZmlmb19wZXJpb2QgaXMgaW4gbnMsIGFuZCB0aGUgZ3JhY2Ug
aXMgaW4gbXMuDQpTbyBJJ20gbm90IHN1cmUgdXNpbmcgTUlDUk8gd2lsbCBlYXNlIHRoZSB1bmRl
cnN0YW5kaW5nIGhlcmUuDQpJIGNvdWxkIGV2ZXR1YWxseSB1c2UgTUVHQS4NCkkgd2lsbCBpbXBy
b3ZlIHRoZSBhYm92ZSBjb21tZW50IGFueXdheS4NCg0KPj4gKwlpZiAoZ3JhY2Vfc2FtcGxlcyA8
IDEpDQo+PiArCQlncmFjZV9zYW1wbGVzID0gMTsNCj4+ICsNCj4+ICsJd2F0ZXJtYXJrX21heCA9
IElOVl9JQ000NTYwMF9GSUZPX1NJWkVfTUFYIC8gcGFja2V0X3NpemU7DQo+PiArCXdhdGVybWFy
a19tYXggLT0gZ3JhY2Vfc2FtcGxlczsNCj4+ICsNCj4+ICsJaWYgKHdhdGVybWFyayA+IHdhdGVy
bWFya19tYXgpDQo+PiArCQl3YXRlcm1hcmsgPSB3YXRlcm1hcmtfbWF4Ow0KPg0KPm1pbj8NClll
cyENCj4NCj4+ICsNCj4+ICsJcmV0dXJuIHdhdGVybWFyazsNCj4+ICt9DQo+DQo+DQo+DQo=

