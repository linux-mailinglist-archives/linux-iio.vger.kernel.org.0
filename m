Return-Path: <linux-iio+bounces-21854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DECAB0D371
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 09:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407CC1886E79
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 07:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF99628B7F1;
	Tue, 22 Jul 2025 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Ywa9MjQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68B26ACB;
	Tue, 22 Jul 2025 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169580; cv=fail; b=E70jVf9twltEOfwqpJpA7Fy9mSsbPf7P/E5WIkxhQ3v5ZX2dxJ+sKbt8UIHxmhJN+NpzA2in4fCYakwd5KDoBzKLZMJicELXk3deNajD+rFH0IAZ/TWJSlzd06FIwP/vXWjJkDt9WlAq8AZE5Glg749odon6oLzj1uGBeWvLKew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169580; c=relaxed/simple;
	bh=UcFmkmHZxhdYRXFzDr+ZDQXPZel3XlN/++HHEnjne40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HmXlmid8rblzLtCK/FtLq5iab88m9dqZwZgx73EkytSz200rP8qpQqZbdcBw2DEA1RVzUlUrn5ggjKblQx605ffiOlbpkAHwtddRcAOV1D1zeQH9rY0lSNZt0NWXrNaiz+tokoUqPL4yRvHnhJtxBe+KnITrdh3pJQ6cL/PVq+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Ywa9MjQ; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8wdIiZiCD+QpJ2ppRgGgoI7rfH9hw18SaADa4vigU1/51zi55yANZ8uyp5rU05LSlzUmULp5CuNXimh7nhbx46o/IPg4r3MInAgCuOk6L/ftWi0Bq95GaLO6lIUAO8gWIJEi+sYuegYcyOa+HnGV2aD+yTx0ugamW/Y0mD74OILqKtb1OJkW4pK09D7QYWXqxD8SCpgFiVWS15bHTFw8SHInHlHBv48xeyHqhUWsVquDA/pihW6yUAOS765/FiLIHGERCOsuIegyMOyEd9KnJsnbaTZ/Upj7GIR74swB9tXLthc9D0U6JDLzWavv4vLlHwkRfSg/icZylmACKhkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcFmkmHZxhdYRXFzDr+ZDQXPZel3XlN/++HHEnjne40=;
 b=BAT9bZLYvuFC7cWw6zeKB6XRlUz+GY9m4ZoSU85AGxlvnZaXtrYRJiQxp0OvhvboHn8r/sHyaJYzbGqgiDBTqTcfNQcvbs9HV7pEZxCaHShE/GPxuQXzEXecO96AB6HxoAao1tjoxHjxebqVpwacxvw6jOlv1G9Dc9cjwwrJIO2sQWdG2hiSSky0mYDpFk1I3WmSBgJ+Ayoz6UKU5qLOeHvOSv6BzPZGa2+8mM3r60iF+SOZo+sYPDkX8LIYLQXPsl3UeevQD3ZX+FprpMJwvzBNMMiIlhlq+mIcmc0oTB5OgLGOiTTNQCsDhtP+gCOzoN97wA8PivcSfs12q6Tufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcFmkmHZxhdYRXFzDr+ZDQXPZel3XlN/++HHEnjne40=;
 b=5Ywa9MjQgYtsc4k+vESoJ5EsSaMqbHtATzx1OgKg81TwemL4p3vE8twAOCWBacrAnql5TPIljEyf0teC7rVOMdG5bevGdtU8U+y1i8PlAdYq3DYxCZs4Bf/FGifi0fWRj/HidtyxGcjfVsmL0OSdusEj7/qjvcWG20ZxMS7f6UQ=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 07:32:54 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 07:32:54 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, "Goud, Srinivas" <srinivas.goud@amd.com>,
	"manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Thread-Topic: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Thread-Index: AQHb+i+8xK2s1GBMXUK4mOoG9AwzB7Q8c6QAgACdMwCAAK9QQA==
Date: Tue, 22 Jul 2025 07:32:54 +0000
Message-ID:
 <DM4PR12MB61095749195041654F6D560D8C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
 <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
In-Reply-To: <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: dlechner@baylibre.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-22T07:28:48.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|DM4PR12MB6423:EE_
x-ms-office365-filtering-correlation-id: 8f89d8b1-3610-4e52-0dd1-08ddc8f1f8b6
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M09xNkxsZjduc0NFdGc5QUxya09Sa1piVktKaUpibkVxRm1ldTgvZ1d5dTg5?=
 =?utf-8?B?cUlSM0N2eFhRTEJOcUFyZEtpN1dJWmswQk0xMmJaRUNDRUo2RG1NNlI5NWZ0?=
 =?utf-8?B?bVVTZjZsSTk4eDdQaG1iaTE2TEVISDFPYjhzSlRDaDlDZ2FmYXJzeUJSRnRQ?=
 =?utf-8?B?VzB4OWRIbUJPREs5bzBkemdPSUhWZ09TVkJDWmdhY2RsNTE3cm1uWDhqbGp4?=
 =?utf-8?B?UGdPenlWdi9tSXhKZVZ0U2JIeGlzWC9INGV3ZEFSRnhVSTBGazFjanIyclJi?=
 =?utf-8?B?S0w2ZXlST0NCckhkOUh3TUJxNDF1TGdQc1htV3FGc1dOSUkyV1dDc0dtdytZ?=
 =?utf-8?B?WGFYR1RBSHNOU2pVQkNsM0IwajVKSktUQXA4SFpEdUh4c2tTWmZBS1FKdGsx?=
 =?utf-8?B?WnV1bUtNMFI0NWh3WEdVL085M1QzSGxGemhVbUIwQ1o4T3JOQzlzUlVOME5C?=
 =?utf-8?B?YXFtSnFGd1hyQlhBRnR0YnNhTnA5dUdiaUNZZktJOEN4N2d1R3FqNWNWTDA5?=
 =?utf-8?B?VVF4YW5JR0ZKTUlPNktBSzZQY2FVZmlBT3l6QW5ucFBBRXNpUVlVNy92U0lR?=
 =?utf-8?B?RWtuUU1lcldzNi9RT3dJZ3ZneEtNMml4cGJpTnJtSStwWDA0Yk1DOXlIR2pw?=
 =?utf-8?B?bUE3QnNENDc0dHY3UHdNNUVxcFRZSGc4clJHb29KSUV4MGZKTzVES2FlVjBv?=
 =?utf-8?B?VDhxbHcxZktsTmpYQk9ETGNSeG52R0JTSmJ1VFY4Tnp2UHE3WFdVVnNtbm9o?=
 =?utf-8?B?ZjBIc2F5WkRoQ0FPZmdvdlpaR1pXZGdpQXJSQThRV2xXYWZZRmlwWGsrcVlE?=
 =?utf-8?B?Yi9UWExRR1ZPYk5BSEhrY0pWVFNSeHZIbk1hRlFCWlNxaVBLNWl6cjRLdi9u?=
 =?utf-8?B?dE1VTEh6R3VpYVpmLzlxdmNEUm9pckVMVVRKNXg0aVZxWHJZVHdidTRzV2p2?=
 =?utf-8?B?TFJIaG5JT2IrbGJnYlU2cmMwRTBYdjhnbms3UTd4RCtKVWEwUUNkeVFZVHhk?=
 =?utf-8?B?QndweTEvZloyQ2JBSmlJUlJUa0xxODRjNGc1VmRVd1JHWjd5VG1VTWFyei95?=
 =?utf-8?B?Z1lNcEhFSUdDQk8vc0Mzd2ZQck9zdmRRbHhidjJXd2ZNZVFNc085MDg0WjZP?=
 =?utf-8?B?UVh2ZVJreVQ0MzFJOGNVMVZ0MHFpVDJWTlppYmh2NUgwRksvMXh1Y3QvSHN5?=
 =?utf-8?B?MHZwMGtsSEttUzdNRUIrenNTTXROOVFGQ29WT2U2UitDOGJCWmxWYUh1Y05W?=
 =?utf-8?B?NjNiblFQNGhDaUh5bGthZU11NXZHT1E4NkVCbE40ZnEwZnh6TUhFUEpIWkU4?=
 =?utf-8?B?cDFXN2VJU1VNcXVWcFM4ZmRjK0hRV1E0ZlJ3bWJ3dGZHRFgvWElIVUN3Slpz?=
 =?utf-8?B?OUxTLzB4U2thbC9JSmR1eTVHRHBSeklZeWVkZU0wN3RUMGNuaW9JVUR1T0VY?=
 =?utf-8?B?NG5ScDVjQkZsYzJzSngvKysvNEE0SUNsTU1YaXJHRnpOb3BkMnEwdU5Oek83?=
 =?utf-8?B?OXdtNG9ydUpIREVSTDk0QjFDbzBpeG1QS0YxVzhkbUJCK1lLM0ZCR3hwcGJu?=
 =?utf-8?B?clZEdDJFa3Jmd0I5RU90YWdYZVBIUk5kWGhaQ2prNmFCU0E1Ynd3WUVXbUND?=
 =?utf-8?B?aUpWeGJlOENNQThiMkNWMlh6ODY1YU82REJYZVdMMEdqblRlYm5RS3UyVTJM?=
 =?utf-8?B?YUozVDBmbW9Pc1dJZ3p5RVhuWmNxczBRWlg3ZFBsczdpRHIrdTFnNXJpY2Zu?=
 =?utf-8?B?a3I0Qmh3bkRleVh5bWNJL2U0Zkc3SVRMcGhva2wwbEN4Y1FBU2wvdmt5YXM5?=
 =?utf-8?B?cVFnOHRzRStRdkpEMlFYZWhZU0U0Z0pjdUN5S2dnQ1Z5RjZxNVJMMXNvcHV2?=
 =?utf-8?B?N2JhZFdBckZmYVVFblhYMjN5TWtXVFlCR0VsVWFVZFFpdWxxUFo4MkpqN1Zh?=
 =?utf-8?B?VyszYTRLOXYwemJmWHRUQ2I4V2tjbDJsUTlJc1pxak9CLzd6MCtUS0M1UGl5?=
 =?utf-8?B?eGhSRkxxcjFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGpUYnRUck5DV0NnSS92ZGppb1A3Q2RGWTRpVWtBNy9POU1ZNUQ1TVE4S1N0?=
 =?utf-8?B?Tzh1Q1Bnbk9DS0IyOGoxOFhFZVlYa2h5VUE2NmRITVBUMzNvd3pOckFRTlVw?=
 =?utf-8?B?L3BpU05zRWxwdDNDeEw3NnFjV21ZSFhQR3dnTlFxVlhDMFNqTFFRcjVTekV3?=
 =?utf-8?B?OG4xQ1p5Q2FMa1UzUERQREdBL3pLeTZFNnN5Wmd6UlUxVjA5dm8xZUNDSThi?=
 =?utf-8?B?b3dlbG56MzBBaXYzT3JmWXFoUVRrTndwVjFkNnZoTEJmZG5FTWJzYmMxNHoz?=
 =?utf-8?B?UWxaMlBDU2JqZnZKbjVoTmRkdFdPUW5DUFYxLzJ3MXp5Znh6cUg4T0I0QnRU?=
 =?utf-8?B?S1pFQmZnQmFYTmtJdVdBSlJ3SDJZWnhtNExOTGp5WG9ZQXN6N2VzYU9lWWMx?=
 =?utf-8?B?SnlPNFVIbEh3NU0zbkZCK0xHdkw0NFY3eUxnYzZDLys0ZHBtRERsTlA5MHg3?=
 =?utf-8?B?NWxFa0lNUXFEVytVVlNoOWl0by9GYktPcUVMOVIrU3hKUTBRR2pnN0w0WVpY?=
 =?utf-8?B?Mkl1WXZEb3NHVWM2ZDlNQmRGVTcrNFlKUFgxclJjdEZJYlpuVzVMNCtHOXox?=
 =?utf-8?B?RlpTQjV6UkR3elBQWm5oTElUdng5RENGdXBldFVTN1FqMGpvUzFFSFZ3dzdw?=
 =?utf-8?B?eGZaYWRVaHdac3lEZkhTTStjMjYydklsUmczRm1wUTNxLzFrdDdjcVNiRk9l?=
 =?utf-8?B?SFMvVndYQUFyd3Q5MVBjMzhTcEZldkFoVkN5bkR5OC9tbHlnN2N5R3NSVzZn?=
 =?utf-8?B?aHE0MnN5cnExeHNjb1hvTkxMOXQ3MmdXb1NqYUFLdi9PWG5YRURVVkJxcnJp?=
 =?utf-8?B?RWw4bVJ6NHZ6VUJhQ1dmNEVxOTNRNFAzcHpnZTlGZFNLRmIzaTUxTlZWTFJ3?=
 =?utf-8?B?MEpUTnJlSDFuNm5HQlJBSHN5L0NLZTlMY2xrRHZvSk1NQ0tZQWxPSGRpNlp3?=
 =?utf-8?B?VDdqN0htdlFsL0svRi9VTjNWN1FNclBJSWxwdlN0MVJKOWQ4Z0lZYUhzR3Zm?=
 =?utf-8?B?enVXbXgwNk9uc0d0eGFsRmhoZEp5T1RtMk80WTUvMW1HdXdWQ0dFekZQcGQw?=
 =?utf-8?B?NWJNRmRXWURBUzVGbDYzOWN2cmcwTHd6WDAxNnY5ZEpyWG84OHV5K3l0cmFj?=
 =?utf-8?B?SHBGLzZBVkxYWnI2b3FWSkU1ekR3TnRnUnJiR0RYZnZZRnUrQUl0enNRVVpy?=
 =?utf-8?B?bWdDVVBjOFVRS09oZzVIY3hlVEdZc2pXTnBtUEFXVHF6aktmcjVsODN4dDQ5?=
 =?utf-8?B?U3RJTEkybk53N011YXdSOEdUb05lVW54b3Yyamtyd0hYRUZoQ2NTdU9ITXl2?=
 =?utf-8?B?cU5paUwrRFB4eUtrSDBJeEczWGRlMGp2dkFBd3h4RWNWQ1F3T3RZQ3c4NnNB?=
 =?utf-8?B?TTVSTkQvQlk4dGxJeFhYNmt1YlFHZDViUVIyZHU2UEZkUDJvTWY5b0lmWlBx?=
 =?utf-8?B?b0FsV1ZsOGRUY1VGNXZTRHVTNVFiQ0haNWVSY25pSldFYTZ0QWJ5SDJCWVQr?=
 =?utf-8?B?RGJXVGxGZ3dWSUFXMU1QZCtqYXJjUXNKcmJTUXdiSlZ1dHJiREFpZlZyWUp5?=
 =?utf-8?B?cmsrdkIwYWJHMkhienArK3RNMkRJOERqM29nWUw0WjFrdjZUL2ZCeEJxTUF2?=
 =?utf-8?B?RW9saUFNVTBISnBEK0d1UW03cGQwYTZ6NTVhNXRBZGw3aE9Od1c0OVVLK1Av?=
 =?utf-8?B?RDVraUpmMDNWRUZ1QkRKZ0FHTkJFNklwYjc3SWthWXRRazdYZ3BCa24yVmhJ?=
 =?utf-8?B?em1SOXZFNHQ2cTYzclhvVHk4TFhzN1NuN0NhaTVuTzR2Q1N0VUN1dkNzZ2RW?=
 =?utf-8?B?bDU4ZGdPdDVuNWd3K0pMSlhLSmtjcCtGVXB4UHNQNG1tblZxNG9DMHlETDhx?=
 =?utf-8?B?bkF4SGJJNFNsb2wyTGhRQ2laT1ZRTUdhT3Z6Q0MyZ3hTZ1gydkNhdWR5eHh4?=
 =?utf-8?B?ekFCN1BITnRSWTVlUklCaGdnNFMvTVp4K0s2dC8wYjNEU1VoQjQvc1BmOWd5?=
 =?utf-8?B?SVpTYjloUHNCUHZZcSsxeEk3SXN4UkdMQm82NkFWVWg2Zjk3a1R6K1pXK1d0?=
 =?utf-8?B?cGZra2p2eUZuNllXQUlNalp4TVZJOS9ZMlJJbFFDYTBvdjBuUTF4UXNhendU?=
 =?utf-8?Q?JEiI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f89d8b1-3610-4e52-0dd1-08ddc8f1f8b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 07:32:54.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nK5CeR4KRKg+qyVUkwa4z0hRnWSB1SIdul6tWQBJxQddIamb3Qog+4kQyU99IEVZxXmDFhyr5ZFHM3qGji1HHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQERhdmlkIExlY2huZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdWx5IDIyLCAyMDI1IDI6MzEgQU0NCj4gVG86IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5
LnNoZXZjaGVua29AaW50ZWwuY29tPjsgR3VudHVwYWxsaSwgTWFuaWthbnRhDQo+IDxtYW5pa2Fu
dGEuZ3VudHVwYWxsaUBhbWQuY29tPg0KPiBDYzogZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5j
b20+OyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+IGxvcmVuem9Aa2Vy
bmVsLm9yZzsgamljMjNAa2VybmVsLm9yZzsgbnVuby5zYUBhbmFsb2cuY29tOyBhbmR5QGtlcm5l
bC5vcmc7DQo+IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IFBhbmRleSwgUmFkaGV5IFNoeWFtDQo+IDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFt
ZC5jb20+OyBHb3VkLCBTcmluaXZhcyA8c3Jpbml2YXMuZ291ZEBhbWQuY29tPjsNCj4gbWFuaW9u
MDVna0BnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaWlvOiBpbXU6IGxzbTZkc3g6
IEFkZCBzaHV0ZG93biBjYWxsYmFjayBzdXBwb3J0IGZvciBJM0MNCj4gaW50ZXJmYWNlDQo+DQo+
IE9uIDcvMjEvMjUgNjozOCBBTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+IE9uIE1vbiwg
SnVsIDIxLCAyMDI1IGF0IDA0OjM3OjQxUE0gKzA1MzAsIE1hbmlrYW50YSBHdW50dXBhbGxpIHdy
b3RlOg0KPiA+PiBBZGQgYSBzaHV0ZG93biBoYW5kbGVyIGZvciB0aGUgU1QgTFNNNkRTeCBJM0Mg
ZHJpdmVyIHRvIHBlcmZvcm0gYQ0KPiA+PiBoYXJkd2FyZSByZXNldCBkdXJpbmcgc3lzdGVtIHNo
dXRkb3duLiBUaGlzIGVuc3VyZXMgdGhlIHNlbnNvciBpcw0KPiA+PiBwbGFjZWQgaW4gYSB3ZWxs
LWRlZmluZWQgcmVzZXQgc3RhdGUsIHByZXZlbnRpbmcgaXNzdWVzIGR1cmluZw0KPiA+PiBzdWJz
ZXF1ZW50IHJlYm9vdHMsIHN1Y2ggYXMga2V4ZWMsIHdoZXJlIHRoZSBkZXZpY2UgbWF5IGZhaWwg
dG8NCj4gPj4gcmVzcG9uZCBjb3JyZWN0bHkgZHVyaW5nIGVudW1lcmF0aW9uLg0KPiA+DQo+ID4g
RG8geW91IGltcGx5IHRoYXQgdG9ucyBvZiBkZXZpY2UgZHJpdmVycyBtaXNzaW5nIHRoaXM/IEkg
ZG9uJ3QgdGhpbmsNCj4gPiB3ZSBoYXZlIGV2ZW4gNSUgb2YgdGhlIGRyaXZlcnMgaW1wbGVtZW50
aW5nIHRoZSBmZWF0dXJlLg0KPiA+DQo+IEluIHRoZSBJSU8gZHJpdmVycyBJJ3ZlIHdvcmtlZCBv
biwgd2UgYWx3YXlzIGRvIHJlc2V0IGluIHRoZSBwcm9iZSgpIGZ1bmN0aW9uLiBUaGUNCj4gc2h1
dGRvd24oKSBmdW5jdGlvbiBtaWdodCBub3QgcnVuLCBlLmcuIGlmIHRoZSBib2FyZCBsb3NlcyBw
b3dlciwgc28gaXQgZG9lc24ndCBmaXgNCj4gMTAwJSBvZiB0aGUgY2FzZXMuDQoNClRoYW5rIHlv
dSBmb3IgdGhlIGlucHV0Lg0KDQpZb3UncmUgYWJzb2x1dGVseSByaWdodCDigJQgc2h1dGRvd24o
KSBtYXkgbm90IGNvdmVyIGFsbCBjYXNlcyBsaWtlIHBvd2VyIGxvc3MuIEhvd2V2ZXIsIGluIHNj
ZW5hcmlvcyBzdWNoIGFzIGEgd2FybSByZWJvb3QgKGtleGVjKSwgdGhlIHNpdHVhdGlvbiBpcyBk
aWZmZXJlbnQuDQoNCkJlZm9yZSB0aGUgcHJvYmUgaXMgY2FsbGVkIGluIHRoZSBuZXh0IGJvb3Qs
IGRldmljZSBlbnVtZXJhdGlvbiB0YWtlcyBwbGFjZS4gRHVyaW5nIHRoaXMgcHJvY2VzcywgdGhl
IEkzQyBmcmFtZXdvcmsgY29tcGFyZXMgdGhlIGRldmljZeKAmXMgUElELCBCQ1IsIGFuZCBEQ1Ig
dmFsdWVzIGFnYWluc3QgdGhlIG9uZXMgcmVnaXN0ZXJlZCBpbiB0aGUgZHJpdmVyOg0KDQpzdGF0
aWMgY29uc3Qgc3RydWN0IGkzY19kZXZpY2VfaWQgc3RfbHNtNmRzeF9pM2NfaWRzW10gPSB7DQog
ICAgICAgIEkzQ19ERVZJQ0UoMHgwMTA0LCAweDAwNkMsICh2b2lkICopU1RfTFNNNkRTT19JRCks
DQogICAgICAgIEkzQ19ERVZJQ0UoMHgwMTA0LCAweDAwNkIsICh2b2lkICopU1RfTFNNNkRTUl9J
RCksDQogICAgICAgIHsgfQ0KfTsNCg0KT25seSBpZiB0aGlzIG1hdGNoaW5nIHN1Y2NlZWRzLCB0
aGUgcHJvYmUgd2lsbCBiZSBpbnZva2VkLg0KDQpTaW5jZSB0aGUgc2Vuc29yIHJlc2V0IGxvZ2lj
IGlzIHBsYWNlZCBpbnNpZGUgdGhlIHByb2JlLCB0aGUgZGV2aWNlIG11c3QgYmUgaW4gYSByZXNw
b25zaXZlIHN0YXRlIGR1cmluZyBlbnVtZXJhdGlvbi4gSW4gdGhlIGNhc2Ugb2Yga2V4ZWMsIHdl
IG9ic2VydmVkIHRoYXQgdGhlIHNlbnNvciBkb2VzIG5vdCByZXNwb25kIGNvcnJlY3RseSB1bmxl
c3MgaXQgaXMgZXhwbGljaXRseSByZXNldCBkdXJpbmcgc2h1dGRvd24oKS4gSGVuY2UsIGFkZGlu
ZyB0aGUgcmVzZXQgaW4gc2h1dGRvd24oKSBhZGRyZXNzZXMgdGhpcyBzcGVjaWZpYyBjYXNlIHdo
ZXJlIHRoZSBwcm9iZSBpc24ndCByZWFjaGVkIGR1ZSB0byBmYWlsZWQgZW51bWVyYXRpb24uDQoN
ClRoYW5rcywNCk1hbmlrYW50YS4NCg==

