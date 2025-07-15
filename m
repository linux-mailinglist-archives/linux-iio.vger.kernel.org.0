Return-Path: <linux-iio+bounces-21673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88DB055C2
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 11:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763863A5A1F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2366A2D4B5B;
	Tue, 15 Jul 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="OX0zUZjo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E81B6CE4;
	Tue, 15 Jul 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570273; cv=fail; b=XaPXRqu32xDAoqIzBNKQygWRRhcwDm3qcWhFc8v4zjHPYYcQcvOfYDfidb0X+kEB9HyAUpVRszF7Kwsjib61NobMNcuZFu7qS5ABvqasXTZ3R3UWKN//IL2VgBR8W/2YotQUACoIqOV/yEXTNcOTwJj/LIGsmbIN60Cxp/xstDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570273; c=relaxed/simple;
	bh=NIw9P1Xlrk6OoKk+PUypS57WZExwX1WV74s5nUVdO/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ax//62LIzjVZEwvq4vZPGz/4Y9lepPLibrUvrPR77szwfC3eHPrcxOxP5K7U8cI5Qj8UntOIoJXDwFt3b7OCGcj/vtYxf6tpITv6wzT/V/B2FkzPTiuE3zVOwMCMILcOZiZHcWlX9TAU2ZHo8YwhBX4IN7IkUpcA9QFlZuwLZFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=OX0zUZjo; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EMgIeu000387;
	Tue, 15 Jul 2025 09:04:12 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010017.outbound.protection.outlook.com [52.101.171.17])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47uh2mhyjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 09:04:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNvCtNDqc9aEUrAvPHlDtbzEk5Au2/bbV2wlZLIz9pffnIVKTj+wSGyXW3pXEg9vAd6p1y6wsEaealUBIRrfwWXMuevSdDquXpnZm70bhgquAFPl+fJezmYxqABI0pkASIC+UTxpB7mHk6AZUZL9GWBVhRPLcm4RCdI+X6Md4dUdJK1RdyUucTGlmtWeovK83NuRPZvmCe+C7NjYWJ/0DSlYAx+hgz0VCtipKU2e4Q9WxI0Kb5BORUiYANMB16ALimu3FerXHFn+msXJQUgpNI9ANDR/No+RPERvWG2/f5bQog3Jup8M1ph3T+hZqOjN3V+xFoDRWu/Q2KY8PTHCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIw9P1Xlrk6OoKk+PUypS57WZExwX1WV74s5nUVdO/w=;
 b=tqJMUUo2pG/g4KAoSBLqHZf+ypQ2rsE0XsrCzZTe2xdag4mF0Nt0UlknsGuSgs4zsBSr2t1D47SV3sNpOVjEHUVdMbeVbqUGKCjoTfK1IZqh8uXF5IOasSYb8vM83vt9UUN0A5Z6hBlda4xGEZ6bJegInrfioZBjgW/7rNYk3+GrERigcbPGviR2YB4Sl6UbZP0mwL1aNkHIZcVimWviFG1xard4MmumN4Enamt4/JNyRNPX5LHtgh0zbHgkx8TYhqskvKZYQtNqgso1wlqz9/MwT88uEifyNHS4u3gHqEWv3Sqc+QUlnNFD6CZ0E1yQsVqlZr3Y1yx8s+p90UESkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIw9P1Xlrk6OoKk+PUypS57WZExwX1WV74s5nUVdO/w=;
 b=OX0zUZjoG45WBf9GTBmSjT+6VrDFoG5obC+xaRcrgTijwGxtXJ05G9bPmB1fBteJJEC/NilW/JZeHQdBtKdaBdS/68rfYUbRJ2Iir6hcjeOfIVQqFuN19LK3iLeOESx41ScI+1Ox3CzT6SjuqtxRBxmFO6Px29gLM+3L7Yc72N+4/xihbaDSvkUEPFCUPLvL0s+m9Mg5sSqcAYI1/EPBdPpdWECM/nkzcYC/AufvG0yJ83l3e8pCPgLcehrbSVwCq+ROWGbxsiaobnZPP9KVktxbYoA6cLXAVwaiONsRyPUh1menOLpeq+N16OoJCSRKB0bY+Kw0ht5vUeWZkZxCNw==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR4P281MB3592.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:03:57 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:03:57 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Sean Nyekjaer <sean@geanix.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] iio: imu: new inv_icm45600 driver
Thread-Topic: [PATCH v2 0/8] iio: imu: new inv_icm45600 driver
Thread-Index: AQHb8XjE+A+r5xX6XEG+/ZdMyoUNvrQxjJyAgAFdc7A=
Date: Tue, 15 Jul 2025 09:03:57 +0000
Message-ID:
 <FR2PPF4571F02BC629C0221E1A77EE838B68C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <zkxaafrvyizbnxtuuj7jwh26jdat7tbvsnnxpnfz7fnmqjuycy@qqr6fzb46kvg>
In-Reply-To: <zkxaafrvyizbnxtuuj7jwh26jdat7tbvsnnxpnfz7fnmqjuycy@qqr6fzb46kvg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR4P281MB3592:EE_
x-ms-office365-filtering-correlation-id: 4092f162-9e1c-484f-5ce6-08ddc37e8825
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|19092799006|1800799024|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?OS9yUUs5SGM2NzVNVmhiTGdnRFhtek5iY3g0TzhZVU9tVDBJYXR4ZVlUZUgw?=
 =?utf-8?B?MFhBKzV0TXNLZXhGS1g4eXN0anFac1dHMTdSQUJ3c3BvUjROSXBqc2pvT0p2?=
 =?utf-8?B?ZDRPaFphR29rVWNRVlN5OVVYVkh5SWpkeTZoYnZUR3VlOStUS2FCUDRHaDBm?=
 =?utf-8?B?ejVNcWVndzE5QzRMNEVQN0RzTjE3RXdNZlZrRlQ2OFJ3YkRQdmhxcWQzVGVR?=
 =?utf-8?B?R3R2SGdTTE1Ib0lUUHdQUk9PQ3pTQ0k2eUtPN2FzSzlSSXFLczVWajZMMUZ2?=
 =?utf-8?B?VWlmWkEyZFd3TUdiSGI3SmQ2ODlaUmhDcDMwV0QrL08wV2RQV3VoWHlHd01w?=
 =?utf-8?B?em5TdWxIRWxTM2RpbXY5cGhlK3RNMXlRalNDeDVJRXVaZXp6K3MrUkRhQkFK?=
 =?utf-8?B?elp4TEJIYklzSWpBcTRwTmIxenZ4YlZxdjliOXJ6dCtCTnp4QXJyYjlvZXlQ?=
 =?utf-8?B?Q09XMVNDa2pqL2lKWFdaWWs5dHNsT3dpMEo2TnNhTEsxTS9ISEVldHIreXRJ?=
 =?utf-8?B?MjlLK3R5NGFRLzBVc1dTbW9ValBVc0NGZFpIVXBtTGJKbWVrRklwak00VlJX?=
 =?utf-8?B?aC9IdUdhZUlSTTdIVXJMd3ZEVklRUEZJRjFBZXBpTlExNXAySjV0VStNZmdS?=
 =?utf-8?B?MHNUaDBBeGorbVpvYmJrcTh3dTU2MStLQW9GaWhFQXlLRDUrREo4TGdEdjB3?=
 =?utf-8?B?bmthMEdSclBnZ0pacGZ3aGtSNndrVWNQc0xrUnBTVVJDUU55S0p5K3RzQmpI?=
 =?utf-8?B?YmdaWG1NVFhwZU1NSk53MEFxSjRKamRsSXJnY0J4U0VCdlJOWFJMejR5ekpt?=
 =?utf-8?B?N2EvMHVWa3pkSU8xdDY5clpOUzNxR2kyZWFyVURvQVpqeDBkTm9oNTlETnJJ?=
 =?utf-8?B?ejkzMVl6N2txdWk4UnRBeS82a1kvOTNYblB1SjduQkcwT09COC90UC9yVXda?=
 =?utf-8?B?NnUrQlo0M3g3VkNkS3NzcjMxWlhvMWhPVGxoVmtEeHNMbHFRS0MvbVVrMnRH?=
 =?utf-8?B?Mzd6UDYxZnlmVXcwMFdTYzFYTi9VM05MWVIzbmhubzdsamRwQlM4V2VsYUpk?=
 =?utf-8?B?a0JNZHNiRWZWRHl2cVp3R3VtY3JwanQyQWgybVVFbU1FMGRhcUcyZWpsZ0RR?=
 =?utf-8?B?Y1Nra0NhQ1dCaXFKVGhtcVVMeXpJOVJSbGx6MkVqN1ZZTDNDWHcyY2k0dDBV?=
 =?utf-8?B?Y2ppOFZzalNxRkl1RDBUQXVYK0IzRENGSi95SjY2VlBHSG1oWWVJSFBPaHgv?=
 =?utf-8?B?a09mQ0xDaWV2cjhuRy9kNkJsOXlpZVl5eStCRkJhajhTWG1tdUlvUWNyaU9w?=
 =?utf-8?B?d0NsZlBjZHhSSkpUTGpNbTBscDlTK05yQ0JSMWhjZ0szOGI0TEZ6emt4cWpy?=
 =?utf-8?B?UXM1ckF1YjBqdlFSby9qbk85MTVGcWVFeHE5ODE5RmVVZ210b3h5YXBFSXZj?=
 =?utf-8?B?Z1JSZm4yTXVDV3ZycVZyUnUzNEZwV2hLQ1B3T3NkWmxCY0drQmNvaERhbCs0?=
 =?utf-8?B?cmU1YXVsLy91Z0doU2dKOFhQdzdhKzgyL2lQeGZWZGlnNks3YU1WdHZhOEMr?=
 =?utf-8?B?aXhOSGpmRDhyazMycGh5eGRHTUxJQUhNZlZBZ2tvd29UQjNiaFJaREEyWU5H?=
 =?utf-8?B?ZStXTjRGU0pob01NaUw4Uzlhc1pyMmFrTlYxSlZjUjlWcG84ZEJkR0RVNGVq?=
 =?utf-8?B?Kzd6ZFFQaTZrWHhrNWgzcE5xeXlKUVpTZzdJS3BjRS9rN0I1WVZPWTRma0oz?=
 =?utf-8?B?MWV5SzZ0TlBEOFVvZWN6QmVDOS9FVkFhd29RdExNcXJxOGk5aUIvTG5OTWEw?=
 =?utf-8?B?SEE3VldEZHF5LzRrVXg5aUpGdk9EMTdSWVUvVk1KRTdoTGl1WXRTMlpsV1oy?=
 =?utf-8?B?L0orT3huV1QyUnRFTzNwVmVQRmlOZWMvL1pjT081QUY3dUp1Rk5veTE5R2Nt?=
 =?utf-8?B?VzdrSXh6UjF4SGVwcHpUdytXamRnRTRIelArd2xGNzd1V3NvcXBWRmxEcjJJ?=
 =?utf-8?B?Sk9scG85TnNtOFU5aXhaaUlMM0lrNGhxVmZEc1BmMFIwVUZOK3pxZGhBWWlH?=
 =?utf-8?Q?/Xt3aW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(19092799006)(1800799024)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akV0Zk5zeWRmcnpCdHBBb2J3Y1FkaXZvUGxpaVdVcnd3M2crdWg5UHUyelF2?=
 =?utf-8?B?WVJUS2pFdUlranNwa0V4a3daN1YvQk1sVlFqc3o5KzhhNko1Mm1MUyt3czdj?=
 =?utf-8?B?WURlT0JYOFZZRXBGaDNMSzJ4VjVYT0RBdjZjSjZyOGFQM0d3N2pJUjRwUEV4?=
 =?utf-8?B?KzF5Uk5HbWw5MUZXdEdpSitkWXF6T3daWkd0UjE5Rk5GVDluZkZWTlhyV0No?=
 =?utf-8?B?VW4wYWl3eUJwT25hVVFONUJnVGdPSm1Xb0U4TkRsNUpqY2MzV2ZqcVFrNjJM?=
 =?utf-8?B?d2VVVktBYmszNy9RVjFRejdRVkVxL3hUUFZrU242Q2JVNFltYk9Ecm9kM0wy?=
 =?utf-8?B?dm5kZGlzR0VGdnNHb1JNenk3ZDcxbHF0TGM2aS9jbm9yaHk5WHhwemN4VVZD?=
 =?utf-8?B?ZllVSnNrS2FqRGFVUk5aenV4aHZWakNtWmwwNkM4algzMnBnSDAyanZwem9M?=
 =?utf-8?B?VDE5c1g3a1V2NWF4bFl3RHVMcGJFWmxiNUkxZUhKT1FvdVpldmpac3dlZlpI?=
 =?utf-8?B?RnViWEJBMlVCcmlPNDdkS1RtSHFBdDJKNWVwc3R0QWgxUm5EdmZaZWFNdzJ4?=
 =?utf-8?B?UEU0YnlVZW9mMXlEaXJ3VFF3OFJtaC83TkZvck1sSExIUXZwS2FGNGpxbVNv?=
 =?utf-8?B?UFE4WnkxMm92UGJnQTdFVUNOeDRBZm13amczNU9vaEZVVXZ4QXU3WHVLK0hi?=
 =?utf-8?B?cEtTdFdjdmdCTDl5RjZxc2hXc1lDQlJvbTkxckp4MmlLcDN0eExGVGg0Q2hx?=
 =?utf-8?B?eExiYmcrQW1RTkI4NnhLVkJGTEhZOG0vd1dQWlN5Qnl6U0JiS2ViSzFHQm11?=
 =?utf-8?B?OUd3Ym9MakhTWHFVcnIvRzdWZC95dElEU1NFNEpuaXllbS90V3lRNW9yUWo0?=
 =?utf-8?B?WUh0b252bWpxbjZhMFNpdW9ua3JMNFdFZDdEU3BZanpvSFFuMjJ5K2ptbjFw?=
 =?utf-8?B?Tkpzc2xpcXphb2pJSGRsRDdOSExXUk1TWkFHUFI1eFhTcm5vTGRpNTJRRXVz?=
 =?utf-8?B?NlUxUFNESFN2ZDZENHlWRTRBdDRjRkJDSkhXenRXVUhIeTlYWlJlN0pVYnpL?=
 =?utf-8?B?UzdhRWJDcVU4UGQvSk1zaDVlSkg0dklJZnlLKzNjMG5HcVhMVjgwS0NHdkp0?=
 =?utf-8?B?N2l6TUk3cDladWhGMVVDRE9DU08wVXplWWxOenJpVC96VWlyTjFLbS9wL1U5?=
 =?utf-8?B?cGVEUXpTcG40ZzJNQUM5cmtFYVlmVUZIajA3bWFnVGRrTFovVlVlTXFwQmJz?=
 =?utf-8?B?d3JlczFKT05URmJkYm43bkkwaEFMRFVlLzZiQnppK1hpQ3lMUk5nVWxOVEVh?=
 =?utf-8?B?Yi80NWZkR2V1VDB6cnppak9YM1NZS29sUkdPUE01eW91QXEya3VuR2lnMEx5?=
 =?utf-8?B?RllzR2pkcWRkYkxRYml1NlA4V1JYTTYveGRNUVE4NkFkM1dYbjNhSHpiQkFm?=
 =?utf-8?B?b2xoWDNxRHlMRHZ0T2RMRi9TUUcvbjJIU3ErUXgwUWRkVXV6SDlmc0M4VU0w?=
 =?utf-8?B?cFB1bE1vNkc2alRzYm9CYWhTaTNNWjFua1Z4NjBiQkFEcFZPOHlWM0ZNVWJV?=
 =?utf-8?B?L1hHdXVsZXhoai90aEhQaXZ0VnFrc3NTeUVKZ21BR08yZ2RwY2xZY0NpYUNJ?=
 =?utf-8?B?VkswQ0ZGeFFqODFCZjFGWEdlZlFScnI1UmQ5OWZZenk1WVhNMmV5Nm5qVzRk?=
 =?utf-8?B?SVV0czcwWWFwUzFrdStqb0ZEZERON2dsTVJqQXVCNDcvcXhGVzRSVWFNaDZ6?=
 =?utf-8?B?L3Z4K3Q2MGJqaUhNT1dncmJaS2l1WDNCZTAwb0VZMEgxbFRSSWl0OEhnQVNX?=
 =?utf-8?B?d1kwNy9VREFPTlM2M0IxN3h2anR6R0pGRG1YbG5RTEQxUjltejk1QlRxVHAv?=
 =?utf-8?B?QWFqQlFjblRUMkJ6dHRYNERKdjZ6VElLbHZaRDNOY0xRZ2k5WU11WXc0SVZP?=
 =?utf-8?B?Z2REWmRmWjZFUE1yRThYdnNkTUxGajk4YjQrWFNqaDZOS2R6ZEs5VDFNSHpL?=
 =?utf-8?B?cjNaSDBzY2FCWElDdjlyVUZHS2VFemR3YWFwOVp4ZnQ1cFZvWFdpUG9OTFBG?=
 =?utf-8?B?Ym95eGlkUm4yUkE1MHB1RVB3OXRnMUNMejBhWDVNZi9GcjhYeHRURGZEZVlH?=
 =?utf-8?Q?11D7SYLPy8EdxDuHpfEscaMxz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4092f162-9e1c-484f-5ce6-08ddc37e8825
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 09:03:57.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/S/1dUddlnf1kBy00nziE1WYZpr2nAAIJC46RGfS9Zwzn2kA2PyVwKFz8Cl4hY8waZh8efvce+TTU9Sw8IFIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3592
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MSBTYWx0ZWRfX1FE3KN+7VG5/
 2/wwPQ4DZ6/2BmKUuHTXx2xyr7J9r94dFs0Q4Dl+n55+fiLpldlJRN8BOs8hEw4gNcbjw4OCxNc
 Wo/7xywPknDDV5Gd9aSaHXht9J08ryvyfVPQyCUMAgqg5F/iBB+cclKRyFpWSNP/m/rFnDXGboJ
 +s3wVpg3byyefRBpHfQvgo5JZxb2g6Z3CA/YVBYoFhRpGDsAk8M0wSlr2caCfAaCetQY4NGS3r8
 LOU2XYf3K+aDcbpgRM/5vx6F17ws0RVpfVXxtxy9m1JgK8oCxFLZGQr9Qkaxo4jNVopGmeexcy9
 k9505o6XYro7A87VRvCVd10jIyMZiAYZkR970bZXNxc0qwOB/+/KO2zSok/wTd54hCStHa267Zj
 4LBuI30VNYQGF+QpBygTn2e038HCj+674n6J8rILCvMAEFAVBiEBwMp5klBEb9PaNwLUJrQG
X-Proofpoint-GUID: WAJffjRdGJ5R9Rolkf6-b78b3rybQgm0
X-Proofpoint-ORIG-GUID: WAJffjRdGJ5R9Rolkf6-b78b3rybQgm0
X-Authority-Analysis: v=2.4 cv=MdZsu4/f c=1 sm=1 tr=0 ts=6876198c cx=c_pps
 a=dfAUXwOpf9cMAsegl1et7Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=ilKATfAMAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=5Owm8ZPqQ4NOF4ecPNgA:9 a=QEXdDO2ut3YA:10
 a=73awMTU50e6eLoBjGbzZ:22 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=852 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150081

Pj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIgDQo+PlRoaXMgbWVzc2Fn
ZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4gDQo+Pg0KPj4NCj4+T24gVGh1
LCBKdWwgMTAsIDIwMjUgYXQgMDg6NTc6NTVBTSArMDEwMCwgUmVtaSBCdWlzc29uIHZpYSBCNCBS
ZWxheSB3cm90ZToNCj4+PiBUaGlzIHNlcmllcyBhZGQgYSBuZXcgZHJpdmVyIGZvciBtYW5hZ2lu
ZyBJbnZlblNlbnNlIElDTS00NTZ4eCA2LWF4aXMgSU1Vcy4NCj4+PiBUaGlzIG5leHQgZ2VuZXJh
dGlvbiBvZiBjaGlwcyBpbmNsdWRlcyBuZXcgZ2VuZXJhdGlvbnMgb2YgMy1heGlzIGd5cm9zY29w
ZQ0KPj4+IGFuZCAzLWF4aXMgYWNjZWxlcm9tZXRlciwgc3VwcG9ydCBvZiBJM0MgaW4gYWRkaXRp
b24gdG8gSTJDIGFuZCBTUEksIGFuZA0KPj4+IGludGVsbGlnZW50IE1vdGlvblRyYWNraW5nIGZl
YXR1cmVzIGxpa2UgcGVkb21ldGVyLCB0aWx0IGRldGVjdGlvbiwgYW5kDQo+Pj4gdGFwIGRldGVj
dGlvbi4NCj4+PiANCj4+PiBUaGlzIHNlcmllcyBpcyBkZWxpdmVyaW5nIGEgZHJpdmVyIHN1cHBv
cnRpbmcgZ3lyb3Njb3BlLCBhY2NlbGVyb21ldGVyIGFuZA0KPj4+IHRlbXBlcmF0dXJlIGRhdGEs
IHdpdGggcG9sbGluZyBhbmQgYnVmZmVyaW5nIHVzaW5nIGh3ZmlmbyBhbmQgd2F0ZXJtYXJrLA0K
Pj4+IG9uIEkyQywgU1BJIGFuZCBJM0MgYnVzc2VzLg0KPj4+IA0KPj4+IEd5cm9zY29wZSBhbmQg
YWNjZWxlcm9tZXRlciBzZW5zb3JzIGFyZSBjb21wbGV0ZWx5IGluZGVwZW5kZW50IGFuZCBjYW4g
aGF2ZQ0KPj4+IGRpZmZlcmVudCBPRFJzLiBTaW5jZSB0aGVyZSBpcyBvbmx5IGEgc2luZ2xlIEZJ
Rk8gYSBzcGVjaWZpYyB2YWx1ZSBpcyB1c2VkIHRvDQo+Pj4gbWFyayBpbnZhbGlkIGRhdGEuIEZv
ciBrZWVwaW5nIHRoZSBkZXZpY2Ugc3RhbmRhcmQgd2UgYXJlIGRlLW11bHRpcGxleGluZyBkYXRh
DQo+DQo+DQo+RnJvbTogU2VhbiBOeWVramFlciA8c2VhbkBnZWFuaXguY29tPiANCj5TZW50OiBN
b25kYXksIEp1bHkgMTQsIDIwMjUgMjowNyBQTQ0KPlRvOiBSZW1pIEJ1aXNzb24gPFJlbWkuQnVp
c3NvbkB0ZGsuY29tPg0KPkNjOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsg
RGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgTnVubyBTw6EgPG51bm8uc2FA
YW5hbG9nLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVs
Lm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzhdIGlpbzogaW11OiBuZXcg
aW52X2ljbTQ1NjAwIGRyaXZlcg0KPg0KPk9uIFRodSwgSnVsIDEwLCAyMDI1IGF0IDA4OjU3OjU1
QU0gKzAxMDAsIFJlbWkgQnVpc3NvbiB2aWEgQjQgUmVsYXkgd3JvdGU6DQo+PiBUaGlzIHNlcmll
cyBhZGQgYSBuZXcgZHJpdmVyIGZvciBtYW5hZ2luZyBJbnZlblNlbnNlIElDTS00NTZ4eCA2LWF4
aXMgSU1Vcy4NCj4+IFRoaXMgbmV4dCBnZW5lcmF0aW9uIG9mIGNoaXBzIGluY2x1ZGVzIG5ldyBn
ZW5lcmF0aW9ucyBvZiAzLWF4aXMgZ3lyb3Njb3BlDQo+PiBhbmQgMy1heGlzIGFjY2VsZXJvbWV0
ZXIsIHN1cHBvcnQgb2YgSTNDIGluIGFkZGl0aW9uIHRvIEkyQyBhbmQgU1BJLCBhbmQNCj4+IGlu
dGVsbGlnZW50IE1vdGlvblRyYWNraW5nIGZlYXR1cmVzIGxpa2UgcGVkb21ldGVyLCB0aWx0IGRl
dGVjdGlvbiwgYW5kDQo+PiB0YXAgZGV0ZWN0aW9uLg0KPj4gDQo+PiBUaGlzIHNlcmllcyBpcyBk
ZWxpdmVyaW5nIGEgZHJpdmVyIHN1cHBvcnRpbmcgZ3lyb3Njb3BlLCBhY2NlbGVyb21ldGVyIGFu
ZA0KPj4gdGVtcGVyYXR1cmUgZGF0YSwgd2l0aCBwb2xsaW5nIGFuZCBidWZmZXJpbmcgdXNpbmcg
aHdmaWZvIGFuZCB3YXRlcm1hcmssDQo+PiBvbiBJMkMsIFNQSSBhbmQgSTNDIGJ1c3Nlcy4NCj4+
IA0KPj4gR3lyb3Njb3BlIGFuZCBhY2NlbGVyb21ldGVyIHNlbnNvcnMgYXJlIGNvbXBsZXRlbHkg
aW5kZXBlbmRlbnQgYW5kIGNhbiBoYXZlDQo+PiBkaWZmZXJlbnQgT0RScy4gU2luY2UgdGhlcmUg
aXMgb25seSBhIHNpbmdsZSBGSUZPIGEgc3BlY2lmaWMgdmFsdWUgaXMgdXNlZCB0bw0KPj4gbWFy
ayBpbnZhbGlkIGRhdGEuIEZvciBrZWVwaW5nIHRoZSBkZXZpY2Ugc3RhbmRhcmQgd2UgYXJlIGRl
LW11bHRpcGxleGluZyBkYXRhDQo+PiBmcm9tIHRoZSBGSUZPIHRvIDIgSUlPIGRldmljZXMgd2l0
aCAyIGJ1ZmZlcnMsIDEgZm9yIHRoZSBhY2NlbGVyb21ldGVyIGFuZCAxDQo+PiBmb3IgdGhlIGd5
cm9zY29wZS4gVGhpcyBhcmNoaXRlY3R1cmUgYWxzbyBlbmFibGVzIHRvIGVhc2lseSB0dXJuIGVh
Y2ggc2Vuc29yDQo+PiBvbi9vZmYgd2l0aG91dCBpbXBhY3RpbmcgdGhlIG90aGVyLiBUaGUgZGV2
aWNlIGludGVycnVwdCBpcyB1c2VkIHRvIHJlYWQgdGhlDQo+PiBGSUZPIGFuZCBsYXVuY2ggcGFy
c2luZyBvZiBhY2NlbGVyb21ldGVyIGFuZCBneXJvc2NvcGUgZGF0YS4gVGhpcyBkcml2ZXINCj4+
IHJlbGllcyBvbiB0aGUgY29tbW9uIEludmVuc2Vuc2UgdGltZXN0YW1waW5nIG1lY2hhbmlzbSB0
byBoYW5kbGUgY29ycmVjdGx5DQo+PiBGSUZPIHdhdGVybWFyayBhbmQgZHluYW1pYyBjaGFuZ2Vz
IG9mIHNldHRpbmdzLg0KPj4gDQo+PiBUaGUgc3RydWN0dXJlIG9mIHRoZSBkcml2ZXIgaXMgcXVp
dGUgc2ltaWxhciB0byB0aGUgaW52X2ljbTQyNjAwIGRyaXZlciwNCj4+IGhvd2V2ZXIgdGhlcmUg
YXJlIHNpZ25pZmljYW50IHJlYXNvbnMgZm9yIGFkZGluZyBhIGRpZmZlcmVudCBkcml2ZXIgZm9y
DQo+PiBpbnZfaWNtNDU2MDAsIHN1Y2ggYXM6DQo+PiAtIEEgY29tcGxldGVseSBkaWZmZXJlbnQg
cmVnaXN0ZXIgbWFwLg0KVHJ1ZSwgYnV0IGljbTQ1NjAwIGFuZCBpY200MjY3MCBhcmUgbW9yZSBz
aW1pbGFyIHJlZ2FyZGluZyBpbmRpcmVjdCBhY2Nlc3MNCmFuZCBGSUZPIG1hbmFnZW1lbnQuDQo+
QXQgb25lIHBvaW50IHdlIGFza2VkIFRESy9JbnZlbnNlIGZvciBhIGRyaXZlciBmb3IgaWNtNDI2
NzAuIEl0IGFsc28NCj5oYXZlIGEgY29tcGxldGVseSBkaWZmZXJlbnQgcmVnaXN0ZXIgbWFwLi4u
IEdycnIgOlMNCj4NCj5Bbnlob3csIHNob3VsZCB3ZSBjb21iaW5lIHRoZXNlIGRyaXZlcnMgaW4g
aW52X2ljbTQyNjAwPyBMaWtlDQo+c3RfbHNtNmRzeD8NCkkgZG9uJ3QgYmVsaWV2ZSBzbyBmb3Ig
aWNtNDI2MDAgYW5kIGljbTQ1NjAwLCBiZWNhdXNlIG9mIHRoZSBleHBvc2VkIHJlYXNvbnMsDQp0
aGV5IHdvbid0IHNoYXJlIG11Y2ggaW4gdGhlIGVuZC4NCkhvd2V2ZXIsIG5ldyBwYXJ0cyBsaWtl
IGljbTU2NjAwIG1pZ2h0IHNoYXJlIHRoZSBzYW1lIGRyaXZlciB0aGFuIGljbTQ1NjAwLg0KKGV2
ZW4gd2l0aCBkaWZmZXJlbnQgbWVtb3J5IG1hcHMgOiggKQ0KPg0KPi9TZWFuDQo+DQo+PiAtIERp
ZmZlcmVudCBGSUZPIG1hbmFnZW1lbnQsIGJhc2VkIG9uIG51bWJlciBvZiBzYW1wbGVzIGluc3Rl
YWQgb2YgYnl0ZXMuDQo+PiAtIERpZmZlcmVudCBpbmRpcmVjdCByZWdpc3RlciBhY2Nlc3MgbWVj
aGFuaXNtLg0KPj4NCg==

