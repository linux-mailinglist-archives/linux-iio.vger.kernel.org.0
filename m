Return-Path: <linux-iio+bounces-22142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0AB158F5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 08:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C848F17D94D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 06:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB61F37C5;
	Wed, 30 Jul 2025 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d0mirNXw"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F751F1905;
	Wed, 30 Jul 2025 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856857; cv=fail; b=Ep3v2PnDuH4qeHn1SeD9PJExwyvbpus/GQfCh911/xj0+TiCXue9ma0Mdmh0QXjgMwv+Mo5wj3Q4+vuVTKPjjzBX3aw+K2nGiTEZy+regIZwFnt3wX8A85TRa6cH+Qsn8HeoPEMJiUsSjKdKgO+nLNPaVU7zoDAAP3RMS1HdkDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856857; c=relaxed/simple;
	bh=mRpbOdqPJPzH64yD4HTZtEwZ0/NflDgjsZNLvCTJ7M0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bJI+uodr5TyA6CwcvUi2syzEM1m3RdvdB7G8IvPa1BbISXkto+ieWUJcq5uvV6KGKq7YwURsajjcBMxRn7pl/xbpsQkbP3eCWeQomMIRVNbWhmITm2nbA3wsw7xJzDgXYF+kVHLyxe4fPG2RIRPwDxzIy3lPRh8wHamWcin0hlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d0mirNXw; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urgQRCC2rsnlmp6ZuOATKFwfGmwfTvkJfklygXNSTYqs8AeIwZVju8277kjRNf7bhJchzeC0IuaasXmS8wgLcj6QOg4U4hlyT4diGimsO9J1GOOQ2FYC4LhXZRKDmf1zySxkIJIMI24fmfNZ2nlAblpmP8EqKfu9sRAMX/7AZeTJQGzI/Cvsfavqc+lQHCgKRozz4+9MOUzVGETcuZl8Obkw0420f8dy9Q5GjXVkhxO40uS8nEedsfQTGLzdj7GSfNtbhx8OeL7on8Hu1yWGQmGtJOR9mr6IpDENHsehLcajk1S6ViyMSzWEnv52bSMQM7T5Fiy1wfnEVj/6RORAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRpbOdqPJPzH64yD4HTZtEwZ0/NflDgjsZNLvCTJ7M0=;
 b=HKt8Av1jWlfmB/nPsZitzTp0B+h1TTs8xUQK46E0AN0FL0fZ6KHJw0Cg2fyY0TCVfJnD3T6q1q9RqaWgvLRO3ziqZcv0Jep2DVJru3+Lm8jh3kTaycu2GKsgBMDg/fCpzJ15V0xR70HCU5kkJxq5WgVIlY4u9GOzVe5OPPO6K8QUCiOkvdT2rFIPxJpOOMKSdMWZA0fqXMS9CJ2A9OQh7kT3tda7byOZ9KuAMR4BLFAX6j1Es4A+7O7EVcRlAFhCYToqWro0GoQefBja76ArStKROz3WBF9IdZsuK+eQKDjE7SO+iAkYYZMnqIeT9NmO5lujEhNHCUbRVdc9VazEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRpbOdqPJPzH64yD4HTZtEwZ0/NflDgjsZNLvCTJ7M0=;
 b=d0mirNXwgUTV8QmKraIJB2KjeF94mG61L9OjwGISIXJHVA+W4lleHA8DcBneEPfSpQtI2LQocMtlDDAZDy5zOTR6DsgSg+N5xSISeBzep1QgLQndgUz7N5/RdhRxTQekM36ss26Vu0ENibY0aEDsO67jcbFp9vbe7UNwZ6VaVdA=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 06:27:31 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 06:27:30 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Jorge Marques <gastmaier@gmail.com>
CC: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, "git (AMD-Xilinx)" <git@amd.com>, "Simek,
 Michal" <michal.simek@amd.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pandey,
 Radhey Shyam" <radhey.shyam.pandey@amd.com>, "Goud, Srinivas"
	<srinivas.goud@amd.com>, "manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Thread-Topic: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Thread-Index:
 AQHb+i+8xK2s1GBMXUK4mOoG9AwzB7Q8c6QAgACdMwCAAK9QQIAAB8qAgAmwZzCAAaGzgIABJMYg
Date: Wed, 30 Jul 2025 06:27:30 +0000
Message-ID:
 <DM4PR12MB6109B8CCEBF5D334662E6CEE8C24A@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
 <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
 <DM4PR12MB61095749195041654F6D560D8C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <3d7w3rczrdics77nt7lig5rsj2bmfubpwzhffarzlxmo5w2g4a@baewpltdovhk>
 <DM4PR12MB610930805348D91ACAE876A18C25A@DM4PR12MB6109.namprd12.prod.outlook.com>
 <5pmqumpue7h4us265co6pya37434t4jvf3b655gtjcohlyhash@3ggx7e2maud6>
In-Reply-To: <5pmqumpue7h4us265co6pya37434t4jvf3b655gtjcohlyhash@3ggx7e2maud6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-30T06:17:15.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|PH7PR12MB6611:EE_
x-ms-office365-filtering-correlation-id: 08aa7e4b-c34c-4d1f-ee1d-08ddcf322988
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmk1YmZ5UnYyVjRiK1JBT21tUkdLbVFNVUc0Vnpud05Say8wdXcyblRtTGdE?=
 =?utf-8?B?OWNCMlBTL0loWG12eVRuSmMvNUlJeXlCZWl0K0puUnoveWk1TlB4MThDMGd5?=
 =?utf-8?B?NU9LY0NrSHU1MStUVkpxc3lXelpFdEFkYmRkUzVoQU9lVTl1blVQaGJ2TUtS?=
 =?utf-8?B?dmJETFVtczg3R05qZnphMjRpSzhXb3c5VFR4NjRrZm9oVmk3YVk4MVBwc2ZW?=
 =?utf-8?B?SG81YzdobDFIdjVWdzJwVkZDRzFudFFvMXpnR1E0anZTVDVEb3dEU1d3WllH?=
 =?utf-8?B?MGs0QUo3T21MdmxhOThCcm9lZHNEbkRFbmRPeDNoRUhqTWM0R2g4WDlWNEJK?=
 =?utf-8?B?STZpUUFxK0I2RGFTZTNEaXBiWi9qdnZKWFpZbzdmM29wajQxV2lWenJsaGdH?=
 =?utf-8?B?Y1Uzc2MyMmIxa1pOMUhrSkNpN1AzdVRvcXU2V3ZuVi9mOXBicHJReGNOb2dF?=
 =?utf-8?B?cWh5c2ZOM1BoRWREWlNuZFJ4VlM4M1NVZFBXSjF0Q0lQZ3Y4YXFzdEt1QVc1?=
 =?utf-8?B?cHlNYnpPclV0enlqY3VXbmpVODYvNUgySVJnM3k0d29NM281S2hLYThZWHhH?=
 =?utf-8?B?MnpBTVV6aW0vaDQ2d0RibExzMXAySEN5aEp2QTI5SFpVeEwyV29zWWM2VjhE?=
 =?utf-8?B?NXl6QU9HT004b0ZBZmczanJLbmYyc1crVmthS1diK25QOHJLcDRqZktXUXFJ?=
 =?utf-8?B?ZFI5WFk2Yk5OTTlENzFEOTh2dDc1dVpPa3p6bnAvdjZwSzlvWXdCS3IxZXRH?=
 =?utf-8?B?R096VldrSkl3M2pKQkJ5K2tva3k2NE5selloVzh2TWhCNEJYWEp5MWYxQXlU?=
 =?utf-8?B?Wk1Md0VsMDFrb09Ld0t0ZlhJc3JSYjkvT0lrbFpMWEhiQk9kYWQ3MXRacGpY?=
 =?utf-8?B?QjF6R1FJUFlXcUJDYUlNNERhWU1OVUxDSSt6OEsxQVgzeU5nOHBpUGl2a0VH?=
 =?utf-8?B?ZWJkT2JCNGVKRWl5MkRaYjhnSlQzZ3lYM2FOaDJoVkh3WE5QQXVUK0cxVnFq?=
 =?utf-8?B?R21HcEh5TFQ4eTA5VFdibkJGSFVIWURaM21IakE5TStHWllsV0c2WURwSDRU?=
 =?utf-8?B?WTFXZjNXck5KUXdnYzZtZk1OYjh1NXRJdm8vYmM1NitHY1VJMGVXQkd1QXEw?=
 =?utf-8?B?RW4xcWFxeUVUTlhZcDc2RHg1R0hKd0laQjF4RkZBTXdBTjFUMHBQbElwOVVI?=
 =?utf-8?B?dDBqaWVVRmtuWjFVa1NVdWFOcmdFeEo5SVlWU2RweEZNRVdSM0VUWnMzMTQx?=
 =?utf-8?B?SkdQeXB1aVBGbHUwSmNsbDBaMXRVL3JYbFNvdGdOQlBIR05Eb2EzSmJ6dTB1?=
 =?utf-8?B?TU1YRmtzZEd1MUY3b2Z2RVBDd1Y2MmdqOFhWL2ZRWCtiMnZjelFiWjBrMlVk?=
 =?utf-8?B?MmZ0MkU3c2VDUlBKYTMwc1dSZlI1QU5mMTJ4MmYvZWdtRTBveTloR2V0Skpq?=
 =?utf-8?B?UFZPS3Aza3VTaDBZVmxmbm9LVnVRQVlWSlZndGwvMzd0UGhyNFJJUUxiTUgx?=
 =?utf-8?B?VFk3U0d2SHdNZ1RCVWhJZGx1OEFuY2lxYzN5THZCd3RvZ1ZzcXFjc2xnUXla?=
 =?utf-8?B?SmNlOUhmQVNWR2VLNFB6VzM1ak5VU2ZsVC80ZmlBVjQybWVGVzRMTnd4N1pU?=
 =?utf-8?B?VjB1UXNHOXQwYzJQVU9zSnIwTjB5U0hIVkZJL3hKNEREOVRRWGZVWTIzY0ZW?=
 =?utf-8?B?aFJZVjZVc0Zta2VMRTBhVGxlOFgvdzRBU2NvRTdzT2Y3bDJwbnRkZ2tKOGQw?=
 =?utf-8?B?eFJuQ1R2L2xTVzFYN3hiM0NtMTF5TVdsaXJqRFo4NllPQ2JBdHJ5NXgyYlZ2?=
 =?utf-8?B?ZjJ4NTJzdTExSXpWTlJCMWZOWmY3L3NGK0piV29YMm9zOSs4eHA0MVFDaWs3?=
 =?utf-8?B?em4ySHd4SDdHLzR2NWxJYkJreGZIVjkwYzN1ZWVURmdzYXBhRTVqSmwyZHJv?=
 =?utf-8?B?b2xoN1l5VVY4WndxWklwSzZidVZ5SzQ5bXNONFpTVlcvaVJic1VJVVN0VlZn?=
 =?utf-8?Q?UbYYxF/xdaOOAeDoxtPDkvDrf7kaPw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXc3Q2c0SjVLa1BDVm1VVUdFZ0J4dDhLSGNVWlNTb1llbmE5U2ZFWHFqM2JT?=
 =?utf-8?B?eHVlNy9tVDJQaUJEMldQSjhvYmtzcUdjdHp5Zm5iZHpoODd1SUxkeGVFejBL?=
 =?utf-8?B?anBlVWZtbDZ1QXJ4cHdqYk9Ga1hyVzE4VEZKcG1hQ0lkZVFFUnZaV0VoMzJx?=
 =?utf-8?B?UG5lRDlPTktNdVErbXlEdXJZM0dDTXNiUTdNQ0ZOeWVvOUtCV0Fxb3N5TllL?=
 =?utf-8?B?eHM1RnY0eXpObGZJaStRMUN4ZG9GN2ExeXB1MDA1eGNiWk1BY3JVazNLa0th?=
 =?utf-8?B?ejBMYnI0b2h2Y05KbTcyNEMvdlNla1RqMmRBdFdKcHJ4RTg1VVhQbTlsMXlB?=
 =?utf-8?B?RTVPaVVEVkdMclpudHJZcWlQVE1hL0hGWjVkQVJ6bVI0VjdLNllMc1U4ZUc4?=
 =?utf-8?B?V3JIblNteTI5YVRvK21PamVoNWNVelptQ2ZwWTRUNVE4dE1TL2x5Qkcvd2tU?=
 =?utf-8?B?OWl2RkZRcU1zdlQwOWlKc1cvVC9oUEdINlJnR01xNzh3ZU9hdWpBQ0oxSzZw?=
 =?utf-8?B?UCtpa2J6OTIvUHlMWGFkNVZXUFJzbS9ZNXk3MkNpRGl2QnRyYTRyZHQ0TDlq?=
 =?utf-8?B?bEZJU1F4eThrSFEvZURLanFkZHVnOFNtbUl1VkRyeC9OR1EvbmlVTWVla0N2?=
 =?utf-8?B?VXpNb1h6a1FadGVsYWd4QkpDbVNTcDdnVWplVjVhTC8xM3lhRjhxVWlEaHl6?=
 =?utf-8?B?MTNjL0hBSWZjWEN0ZTBwZjJ3c0VRcTlXVGFrSk1LVlBrdkdFbmtGTzBqdGRU?=
 =?utf-8?B?V3ZXVGk4QU42aGVXNnFDZ2VMT0FPS3hDQS9UMytGbVJFTFNNWnpEN01xd0Nu?=
 =?utf-8?B?ejZuWnY1R2h0dndZS1RkYjNONVNlOWtDMEVFajFyVjdLSjN3MVpPT1c1UTdn?=
 =?utf-8?B?VUNydG5jU3pNWXZHV09CQWVRNVhueCsycXNVTndiN3BONFNFQXM3UzVTUGZj?=
 =?utf-8?B?eGovaDc5andrYjlqdm9vZjcySzFIVnYrMUwxUElIMGdwUDB4YnNhSEd3dysw?=
 =?utf-8?B?eCtqNkkva3JIQUNjVTNuc01RUDhmQmVqU1V6YjMrWG9oTzlkeDlranVCbWl2?=
 =?utf-8?B?WitnZEJmamNsSjU2ZDIvUkQwQlVkcXRvSi91a0FBY0REWTJlRG1YaUNQQzlq?=
 =?utf-8?B?WGpxQUVqd2pOWVhEWXNnQi9ialdEYm1KbUhtN3c5bjJ3d25VUWdDMitlUktD?=
 =?utf-8?B?cjJNRzIxa1ZBdlZ3TTdoMDRLUDNQVXkyUmtzVEZCaHdOaDBqQitvei90OFhi?=
 =?utf-8?B?a1Njcm1ZN3REVFhFL29QSTFiVWZNTG5tN1RjdUNscjVLdmI4dkRtWEppS3I0?=
 =?utf-8?B?ZTZ1bWNEWG5MRXF6dmFCNy9vbjJJWUNPWlpHVmVhRTkrWnQxRWF5WmRiNnhi?=
 =?utf-8?B?K0RWc1hWQ1h6MDI5QWFnNHZaTGd6VXNuUGE4V2EyTWYyL1Y3MkpBWHB1K2Ev?=
 =?utf-8?B?Z2xPbmI0c3Vyb05pRXRiSUJwNytrY1dmSTBQR3B2Z3JGMFpIVnhORURoaDA2?=
 =?utf-8?B?blN1dGF3bzlzT25EREQwQjd2M2ZBUGZqczQ4ZnJ1a3ZUcHlNVWxtVHp0WVQw?=
 =?utf-8?B?RmU4Y25KQUNtNE5KdE9QUnNvQU9FM0pUaGhLZ3FTaHQwQWFVQWdodVlnMmNW?=
 =?utf-8?B?WlcwalRFN0RPSTJuOVZqL3BTeTFneUd2bTQwL2pxc0FZRS9obHEyVjNKYkl0?=
 =?utf-8?B?R0tTQ1FvTzhiZStIQWhkWEVwMmJvS1VGWFRmdjNTY0RRamhtdXZIRjZTWUtr?=
 =?utf-8?B?NWdET2hMbm04QnBYZHd6cHB2K2RxN3BtUFVCYldrbjlEQ0JBU1gwb1h5UVhw?=
 =?utf-8?B?cUM1RjhzT3Y0VmM4alNoeDNvRlZheEhlVFNRbEJaaC9PaitCbXpiZklQWGRV?=
 =?utf-8?B?YStJWmg1UTI1NXN0c1RhYU16T0Qrc0l4eVphZy92VVlUNHI4bzZLTlFGczFQ?=
 =?utf-8?B?N0dlcmRBajZhQzA0Q3hxM0ZDK2pSSW5JQktwcWRkeWlVMzZ2bys1cnhidElQ?=
 =?utf-8?B?NGs0M2JQSWxHTkY0bEJueFZNTnFRUmJPTzlVdnlPQVJLRUhXcFZVSWppWXM4?=
 =?utf-8?B?V2V2T3I2cElaT29McmxkNmkrVExDQzFQaXU0dkw0VWhjNTRicjFIbHdmUmtJ?=
 =?utf-8?Q?F51Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08aa7e4b-c34c-4d1f-ee1d-08ddcf322988
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 06:27:30.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zx0w6Z/THdcyjLDs3d6dHBbXIjKpCM8CSp9MBaLXQXUsruOAvAEu3pLUEOPel8TXtu0Jg0ftZI3oadkA74VR2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9yZ2UgTWFy
cXVlcyA8Z2FzdG1haWVyQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAyOSwgMjAy
NSA2OjE5IFBNDQo+IFRvOiBHdW50dXBhbGxpLCBNYW5pa2FudGEgPG1hbmlrYW50YS5ndW50dXBh
bGxpQGFtZC5jb20+DQo+IENjOiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+
OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT47IGdpdCAo
QU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPjsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVr
QGFtZC5jb20+OyBsb3JlbnpvQGtlcm5lbC5vcmc7IGppYzIzQGtlcm5lbC5vcmc7DQo+IG51bm8u
c2FAYW5hbG9nLmNvbTsgYW5keUBrZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGFuZGV5LCBSYWRoZXkgU2h5YW0N
Cj4gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT47IEdvdWQsIFNyaW5pdmFzIDxzcmluaXZh
cy5nb3VkQGFtZC5jb20+Ow0KPiBtYW5pb24wNWdrQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBpaW86IGltdTogbHNtNmRzeDogQWRkIHNodXRkb3duIGNhbGxiYWNrIHN1cHBvcnQg
Zm9yIEkzQw0KPiBpbnRlcmZhY2UNCj4NCj4gT24gVHVlLCBKdWwgMjksIDIwMjUgYXQgMTI6MDI6
NTZQTSArMDAwMCwgR3VudHVwYWxsaSwgTWFuaWthbnRhIHdyb3RlOg0KPiA+IFtBTUQgT2ZmaWNp
YWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4NCj4gPiBI
aSBASm9yZ2UgTWFycXVlcywNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IEpvcmdlIE1hcnF1ZXMgPGdhc3RtYWllckBnbWFpbC5jb20+DQo+ID4gPiBT
ZW50OiBUdWVzZGF5LCBKdWx5IDIyLCAyMDI1IDE6MjcgUE0NCj4gPiA+IFRvOiBHdW50dXBhbGxp
LCBNYW5pa2FudGEgPG1hbmlrYW50YS5ndW50dXBhbGxpQGFtZC5jb20+DQo+ID4gPiBDYzogRGF2
aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+ID4g
PiA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFt
ZC5jb20+Ow0KPiA+ID4gU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBsb3Jl
bnpvQGtlcm5lbC5vcmc7DQo+ID4gPiBqaWMyM0BrZXJuZWwub3JnOyBudW5vLnNhQGFuYWxvZy5j
b207IGFuZHlAa2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBQYW5kZXksDQo+ID4gPiBSYWRoZXkgU2h5YW0g
PHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT47IEdvdWQsIFNyaW5pdmFzDQo+ID4gPiA8c3Jp
bml2YXMuZ291ZEBhbWQuY29tPjsgbWFuaW9uMDVna0BnbWFpbC5jb20NCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGlpbzogaW11OiBsc202ZHN4OiBBZGQgc2h1dGRvd24gY2FsbGJhY2sNCj4g
PiA+IHN1cHBvcnQgZm9yIEkzQyBpbnRlcmZhY2UNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIEp1bCAy
MiwgMjAyNSBhdCAwNzozMjo1NEFNICswMDAwLCBHdW50dXBhbGxpLCBNYW5pa2FudGEgd3JvdGU6
DQo+ID4gPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0
aW9uIE9ubHldDQo+ID4gPiA+DQo+ID4gPiA+IEhpIEBEYXZpZCBMZWNobmVyLA0KPiA+ID4gPg0K
PiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogRGF2
aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiA+ID4gPiA+IFNlbnQ6IFR1ZXNk
YXksIEp1bHkgMjIsIDIwMjUgMjozMSBBTQ0KPiA+ID4gPiA+IFRvOiBBbmR5IFNoZXZjaGVua28g
PGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT47IEd1bnR1cGFsbGksDQo+ID4gPiA+ID4gTWFu
aWthbnRhIDxtYW5pa2FudGEuZ3VudHVwYWxsaUBhbWQuY29tPg0KPiA+ID4gPiA+IENjOiBnaXQg
KEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IFNpbWVrLCBNaWNoYWwNCj4gPiA+ID4gPiA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+OyBsb3JlbnpvQGtlcm5lbC5vcmc7IGppYzIzQGtlcm5lbC5vcmc7
DQo+ID4gPiA+ID4gbnVuby5zYUBhbmFsb2cuY29tOyBhbmR5QGtlcm5lbC5vcmc7IGxpbnV4LWlp
b0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgUGFuZGV5LCBSYWRoZXkgU2h5YW0NCj4gPiA+ID4gPiA8cmFkaGV5LnNoeWFtLnBhbmRleUBh
bWQuY29tPjsgR291ZCwgU3Jpbml2YXMNCj4gPiA+ID4gPiA8c3Jpbml2YXMuZ291ZEBhbWQuY29t
PjsgbWFuaW9uMDVna0BnbWFpbC5jb20NCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBp
aW86IGltdTogbHNtNmRzeDogQWRkIHNodXRkb3duIGNhbGxiYWNrDQo+ID4gPiA+ID4gc3VwcG9y
dCBmb3IgSTNDIGludGVyZmFjZQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gNy8yMS8yNSA2OjM4
IEFNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBNb24sIEp1bCAyMSwg
MjAyNSBhdCAwNDozNzo0MVBNICswNTMwLCBNYW5pa2FudGEgR3VudHVwYWxsaSB3cm90ZToNCj4g
PiA+ID4gPiA+PiBBZGQgYSBzaHV0ZG93biBoYW5kbGVyIGZvciB0aGUgU1QgTFNNNkRTeCBJM0Mg
ZHJpdmVyIHRvDQo+ID4gPiA+ID4gPj4gcGVyZm9ybSBhIGhhcmR3YXJlIHJlc2V0IGR1cmluZyBz
eXN0ZW0gc2h1dGRvd24uIFRoaXMgZW5zdXJlcw0KPiA+ID4gPiA+ID4+IHRoZSBzZW5zb3IgaXMg
cGxhY2VkIGluIGEgd2VsbC1kZWZpbmVkIHJlc2V0IHN0YXRlLA0KPiA+ID4gPiA+ID4+IHByZXZl
bnRpbmcgaXNzdWVzIGR1cmluZyBzdWJzZXF1ZW50IHJlYm9vdHMsIHN1Y2ggYXMga2V4ZWMsDQo+
ID4gPiA+ID4gPj4gd2hlcmUgdGhlIGRldmljZSBtYXkgZmFpbCB0byByZXNwb25kIGNvcnJlY3Rs
eSBkdXJpbmcgZW51bWVyYXRpb24uDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRG8geW91IGlt
cGx5IHRoYXQgdG9ucyBvZiBkZXZpY2UgZHJpdmVycyBtaXNzaW5nIHRoaXM/IEkgZG9uJ3QNCj4g
PiA+ID4gPiA+IHRoaW5rIHdlIGhhdmUgZXZlbiA1JSBvZiB0aGUgZHJpdmVycyBpbXBsZW1lbnRp
bmcgdGhlIGZlYXR1cmUuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+IEluIHRoZSBJSU8gZHJpdmVy
cyBJJ3ZlIHdvcmtlZCBvbiwgd2UgYWx3YXlzIGRvIHJlc2V0IGluIHRoZQ0KPiA+ID4gPiA+IHBy
b2JlKCkgZnVuY3Rpb24uIFRoZQ0KPiA+ID4gPiA+IHNodXRkb3duKCkgZnVuY3Rpb24gbWlnaHQg
bm90IHJ1biwgZS5nLiBpZiB0aGUgYm9hcmQgbG9zZXMNCj4gPiA+ID4gPiBwb3dlciwgc28gaXQg
ZG9lc24ndCBmaXggMTAwJSBvZiB0aGUgY2FzZXMuDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rIHlv
dSBmb3IgdGhlIGlucHV0Lg0KPiA+ID4gPg0KPiA+ID4gPiBZb3UncmUgYWJzb2x1dGVseSByaWdo
dCDigJQgc2h1dGRvd24oKSBtYXkgbm90IGNvdmVyIGFsbCBjYXNlcyBsaWtlIHBvd2VyIGxvc3Mu
DQo+ID4gPiBIb3dldmVyLCBpbiBzY2VuYXJpb3Mgc3VjaCBhcyBhIHdhcm0gcmVib290IChrZXhl
YyksIHRoZSBzaXR1YXRpb24gaXMgZGlmZmVyZW50Lg0KPiA+ID4gPg0KPiA+ID4gPiBCZWZvcmUg
dGhlIHByb2JlIGlzIGNhbGxlZCBpbiB0aGUgbmV4dCBib290LCBkZXZpY2UgZW51bWVyYXRpb24N
Cj4gPiA+ID4gdGFrZXMgcGxhY2UuIER1cmluZw0KPiA+ID4gdGhpcyBwcm9jZXNzLCB0aGUgSTND
IGZyYW1ld29yayBjb21wYXJlcyB0aGUgZGV2aWNl4oCZcyBQSUQsIEJDUiwgYW5kDQo+ID4gPiBE
Q1IgdmFsdWVzIGFnYWluc3QgdGhlIG9uZXMgcmVnaXN0ZXJlZCBpbiB0aGUgZHJpdmVyOg0KPiA+
ID4gPg0KPiA+ID4gPiBzdGF0aWMgY29uc3Qgc3RydWN0IGkzY19kZXZpY2VfaWQgc3RfbHNtNmRz
eF9pM2NfaWRzW10gPSB7DQo+ID4gPiA+ICAgICAgICAgSTNDX0RFVklDRSgweDAxMDQsIDB4MDA2
QywgKHZvaWQgKilTVF9MU002RFNPX0lEKSwNCj4gPiA+ID4gICAgICAgICBJM0NfREVWSUNFKDB4
MDEwNCwgMHgwMDZCLCAodm9pZCAqKVNUX0xTTTZEU1JfSUQpLA0KPiA+ID4gPiAgICAgICAgIHsg
fQ0KPiA+ID4gPiB9Ow0KPiA+ID4gPg0KPiA+ID4gPiBPbmx5IGlmIHRoaXMgbWF0Y2hpbmcgc3Vj
Y2VlZHMsIHRoZSBwcm9iZSB3aWxsIGJlIGludm9rZWQuDQo+ID4gPiA+DQo+ID4gPiA+IFNpbmNl
IHRoZSBzZW5zb3IgcmVzZXQgbG9naWMgaXMgcGxhY2VkIGluc2lkZSB0aGUgcHJvYmUsIHRoZQ0K
PiA+ID4gPiBkZXZpY2UgbXVzdCBiZSBpbiBhDQo+ID4gPiByZXNwb25zaXZlIHN0YXRlIGR1cmlu
ZyBlbnVtZXJhdGlvbi4gSW4gdGhlIGNhc2Ugb2Yga2V4ZWMsIHdlDQo+ID4gPiBvYnNlcnZlZCB0
aGF0IHRoZSBzZW5zb3IgZG9lcyBub3QgcmVzcG9uZCBjb3JyZWN0bHkgdW5sZXNzIGl0IGlzIGV4
cGxpY2l0bHkgcmVzZXQNCj4gZHVyaW5nIHNodXRkb3duKCkuDQo+ID4gPiBIZW5jZSwgYWRkaW5n
IHRoZSByZXNldCBpbiBzaHV0ZG93bigpIGFkZHJlc3NlcyB0aGlzIHNwZWNpZmljIGNhc2UNCj4g
PiA+IHdoZXJlIHRoZSBwcm9iZSBpc24ndCByZWFjaGVkIGR1ZSB0byBmYWlsZWQgZW51bWVyYXRp
b24uDQo+ID4gPiA+DQo+ID4gPiBIaSBNYW5pa2FudGEsDQo+ID4gPg0KPiA+ID4gRHVyaW5nIGkz
YyBidXMgaW5pdCwgdGhlIENDQyBSU1REQUEgaXMgZW1pdHRlZCB0byByZXNldCBhbGwgREFzIG9m
DQo+ID4gPiBhbGwgZGV2aWNlcyBpbiB0aGUgYnVzIChkcml2ZXJzL2kzYy9tYXN0ZXIuY0BpM2Nf
bWFzdGVyX2J1c19pbml0IC0+DQo+ID4gPiBpM2NfbWFzdGVyX3JzdGRhYV9sb2NrZWQpLiBJcyB0
aGUgTFNNNkRTWCBub3QgY29tcGxpYW50IHdpdGggdGhhdD8NCj4gPiBMU002RFNYIGlzIGNvbXBs
aWFudCB3aXRoIFJTVERBQSBDQ0MuDQo+ID4NCj4gPiA+DQo+ID4gPiBJIGdldCB5b3VyIHNvbHV0
aW9uIGJ1dCBmaW5kIG9kZCB0byB1c2UgdGhlIHNhbWUgbWV0aG9kIGFzIGluIHRoZSBwcm9iZS4N
Cj4gPiA+IEluIHRoZSBwcm9iZSwgeW91IHdvdWxkLCBpbiBnZW5lcmFsLCByZXNldCB0aGUgZGV2
aWNlIGxvZ2ljLCBidXQNCj4gPiA+IGxlYXZlIHRoZSBpM2MgcGVyaXBoZXJhbCBsb2dpYyBpbnRh
Y3QsIGJlY2F1c2UgeW91IGRvbid0IHdhbnQgdG8NCj4gPiA+IHVuZG8gd2hhdGV2ZXIgdGhlIGNv
bnRyb2xsZXIgaGFzIHNldC11cCBmb3IgdGhlIGN1cnJlbnQgYnVzIGF0dGFjaGVkDQo+ID4gPiBk
ZXZpY2VzIChpYmkgY29uZmlnLCBkYSwgbWF4IGRldmljZXMgc3BlZWQsIGFsbCB0aGUgZ29vZCBp
M2Mgc3R1ZmYpLg0KPiA+ID4gRm9yIHRoaXMgZGV2aWNlLCB0aGUgc3RfbHNtNmRzeF9yZXNldF9k
ZXZpY2Ugc2VlbXMgdG8gZmx1c2ggYSBGSUZPLA0KPiA+ID4gZG8gYSBzb2Z0d2FyZSByZXNldCwg
YW5kIHJlbG9hZCBhIHRyaW1taW5nIHBhcmFtZXRlcjsgd2hpY2ggYXJlDQo+ID4gPiBuZWNlc3Nh
cnkgdG8gc29sdmUgdGhlIGJ1ZyB5b3UgYXJlIG9ic2VydmVkPw0KPiA+IE9ubHkgc29mdHdhcmUg
cmVzZXQgbmVjZXNzYXJ5IHRvIHNvbHZlIHRoZSBidWcuDQo+ID4NCj4gPiA+DQo+ID4gPiBJZiBw
b3NzaWJsZSwgcGxlYXNlIGV4cGxhaW4gYmV0dGVyIHdoeSB0aGUgZGV2aWNlIHdvbid0IGVudW1l
cmF0ZQ0KPiA+ID4gY29ycmVjdGx5IGFmdGVyIGEgcmVib290IHdpdGhvdXQgdGhlIHJlc2V0LiBJ
ZiBpdCBpcyBhIGRldmljZSBidWcsDQo+ID4gPiBleHBsaWNpdGx5IHN0YXRlIHRoYXQgYW5kIHRo
YXQgaXQgaXMgbm90IGNvbXBsaWFudC4gQWxzbywgdGFrZSBhIGxvb2sgYXQgZmlnLjEwMCBvZiB0
aGUNCj4gaTNjIHNwZWMgYmFzaWMgMS4xLjEuDQo+ID4gPg0KPiA+ID4gVGhhbmsgeW91IGZvciBs
b29raW5nIGludG8gdGhpcywgdGhpcyB0eXBlIG9mIGNvcm5lciBjYXNlIGlzIHVzdWFsbHkgb3Zl
cmxvb2tlZC4NCj4gPiBJdCBhcHBlYXJzIHRoYXQgdGhlIHNlbnNvciBkZXZpY2UgaXMgZW50ZXJp
bmcgYSBkZWVwIHNsZWVwIG9yIGxvdy1wb3dlciBzdGF0ZSBhbmQNCj4gaXMgbm90IHJlc3BvbmRp
bmcgdG8gQ0NDIGNvbW1hbmRzLiBIb3dldmVyLCBhZnRlciBhIHNvZnR3YXJlIHJlc2V0LCB0aGUg
c2Vuc29yDQo+IHN0YXJ0cyByZXNwb25kaW5nIHRvIENDQ3MgYXMgZXhwZWN0ZWQuDQo+IEl0IHNo
b3VsZCwgZnJvbSB0aGUgc2lsaWNvbiBwb3YsIGRlZmluaXRlbHkgcmVzcG9uZCB0byBDQ0NzLCBl
dmVuIG9uIGxvdy1wb3dlciBzdGF0ZXMuDQo+IENvdWxkIHlvdSBjb25maXJtIHdpdGggc3RtMzIg
dGhlIGJlaGF2aW91ciB5b3UgYXJlIG9ic2VydmluZz8NCj4gSW5mb3JtIHRoZW0gaWYgaXQgb2Nj
dXJzIHVuZGVyIHVuZGVyIGkyYy9pM2MgZHVhbCBzdXBwb3J0LCBvbmx5IGkzYywgb3IgYm90aC4N
Cj4gSXQgc291bmRzIGEgbGl0dGxlIHRoZSBtZXNzYWdlcyBhcmUgYmVpbmcgZmlsdGVyZWQgYnkg
dGhlIHNwaWtlIGZpbHRlciB3aGVuIGl0IHNob3VsZG4ndD8NCj4gPg0KPiA+IFNoYWxsIHdlIHBy
b2NlZWQgd2l0aCBvbmx5IHRoZSBzb2Z0d2FyZSByZXNldCBjaGFuZ2VzIGFsb25nIHdpdGggYW4g
aW1wcm92ZWQNCj4gZGVzY3JpcHRpb24sIG9yIGRvIHlvdSByZWNvbW1lbmQgYW55IGFkZGl0aW9u
YWwgbW9kaWZpY2F0aW9ucz8NCj4gQ29uZmlybSBpZiB0aGlzIGlzIGEgc2lsaWNvbiBpc3N1ZSBm
aXJzdCwgaWYgc28sIGEgbm90ZSBmcm9tIHN0IHNob3VsZCBiZSBpc3N1ZWQgYWxzby4NCldlIGFy
ZSB1bmFibGUgdG8gdmVyaWZ5IHRoZSBiZWhhdmlvciBvbiBhbnkgc2lsaWNvbiBvdGhlciB0aGFu
IG91cnMuIEl0IHdvdWxkIGJlIGhlbHBmdWwgaWYgc29tZW9uZSB3aXRoIGFjY2VzcyB0byBhIGRp
ZmZlcmVudCBzaWxpY29uIGNvdWxkIGNvbmZpcm0gdGhpcyBiZWhhdmlvci4NCg0KVGhhbmtzLA0K
TWFuaWthbnRhLg0K

