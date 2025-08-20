Return-Path: <linux-iio+bounces-23042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E142B2DAEC
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A07BABC2
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254882D239F;
	Wed, 20 Aug 2025 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zi04BiHa"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31172E1C61;
	Wed, 20 Aug 2025 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689312; cv=fail; b=QyWFmmnXIemB59gRppsx/Ya8FYNAq2hesssXb88dqgrsxep8i7zemQnyoh42Cpmfj9Cc5ygqoTyd0K0Qg4AW9+uvvH5VMw3kKd7aZRbYwUAgl5SxYMP7+H6ON97iqGvTOooCa7srU+XdBe8RfXVHg1eLquDekHoWOKIndDAFm9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689312; c=relaxed/simple;
	bh=2A+l1DQmTAPcYpE+9LVqhNOg0TpgIAm+wPbhzB4MzkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HO0mbE2Y+Ct3DFCjLsYA0KNYhj0hU1oPoxZjtwhY5bT9wjmcFcadyBUS7H9i/kwIoNb/TYMtf9zDp4Cd9Ca3Esj4jXuT5KdTfZx9+cYwO7xOht6qkuWOIPkXSzmp9nrL0JvKYoGCfKS5YK7pwXexTofaAqzV7nhLkO5BqMxAQC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zi04BiHa; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkP0adZkZ8a9ShUDSEQMnxpfFtc6QQscvjRCbxFZOvOxxRF+gLnBvcufXdQ0AxGxSUCndz4VL7A7RUcE6XGInHAuOH0cFQu+b5pNc61VBzfydfuc7T9SHgO4sGpNu+RJ5qgNAPmq74bg9tubuL8RPuk+Opd1KRALJUh64TNS0VASUGrC3NQw59FfAqIYNyS41wD6BXfN+1azUb7vOwU45W2X7kU6xC7YC/Cz69bTr0pc6+rVABtBLoKt90U0nAj8eGT/5eJkTY+wtP3hA5RWqFC8PoIt9p9Jzd2Ub68hATgReUxsZE0wzeFHzObeYDBLDA1VdAy8HGRK6rr56og43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A+l1DQmTAPcYpE+9LVqhNOg0TpgIAm+wPbhzB4MzkE=;
 b=Wh9MgTjDZ2d+ynnd7dNQRBFcXWQOK5UgqNQ0unizb+BDOtX/btbABY8PxFqyNaKjyfgkcQ+t1o43QN4bztPWS4CAs6bjIrXiv4bciLshYifvUa+Rb5YVYivXE5MsKd1YVrpl/bgzycroOUEQntDw9ka0W0sGLDfUpG4UMjXnpkgV75+NSGo8pvPqwuLX86uu8kvxGTpgRT4OF7YFEDXN72XWLI1qur6G+q1bGGy/N7Ys0TB5r6EtJKhtuoUikVpUxFg6arcJBs7EQ4NOVOfJs7gFkXv1LHjF2DYxePqyNM5F+egmG5htSQ/QTKfKMk0hDaA9l1bFUrpaxzZ1hHXhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A+l1DQmTAPcYpE+9LVqhNOg0TpgIAm+wPbhzB4MzkE=;
 b=Zi04BiHavpHgxM2ewPPokl/FRb0o4e1Mp5kAiCp4Vnx01ld9EPvxe4KWcyi40tLTmWp0ex1hAy1x15bmxI13xfLvxywWoMoefXetYBlC1T5ZJEIivCowclMiUASVeZM+DXArsGn5vH1Xe5uCFC0eBmZ/QqZNYU0Vdvf7BcVcqf8=
Received: from MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:28:27 +0000
Received: from MN2PR12MB4223.namprd12.prod.outlook.com
 ([fe80::76e1:d6f4:2e56:e813]) by MN2PR12MB4223.namprd12.prod.outlook.com
 ([fe80::76e1:d6f4:2e56:e813%7]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 11:28:27 +0000
From: "O'Griofa, Conall" <conall.ogriofa@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Anand Ashok Dumbre
	<anand.ashok.dumbre@xilinx.com>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
	<michal.simek@amd.com>, Andy Shevchenko <andy@kernel.org>, Manish Narani
	<manish.narani@xilinx.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: xilinx-ams: Unmask interrupts after updating alarms
Thread-Topic: [PATCH] iio: xilinx-ams: Unmask interrupts after updating alarms
Thread-Index: AQHcEcWLmGqES2BloEmxNP4Fq3rKBQ==
Date: Wed, 20 Aug 2025 11:28:27 +0000
Message-ID:
 <MN2PR12MB42237EC0AA00D05DE52F8C988B33A@MN2PR12MB4223.namprd12.prod.outlook.com>
References: <20250715002847.2035228-1-sean.anderson@linux.dev>
In-Reply-To: <20250715002847.2035228-1-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=99ee8c49-3bb6-4779-8ed4-ba35ff339302;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2025-08-20T11:26:05Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4223:EE_|SJ2PR12MB9244:EE_
x-ms-office365-filtering-correlation-id: 607c4946-9d6c-4fbd-48a2-08dddfdcaeb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1lLckNhcm11azE0YlRIT2tKN1ZrTnZIZ0pXM2F4Q0x5Q3c1UHMwOEtMeEY1?=
 =?utf-8?B?UjlYZjVGeVc4bjRNLzZCVyszRkdZaExOYjAxRjd1M0pPK05xWnEreklrOVpJ?=
 =?utf-8?B?bkFENzBBem05bW5mNXNmMTZ0UDRNQlZRQ0UzM0Y4RnZyS1lRNStTZ3I3VDZZ?=
 =?utf-8?B?Q3JLalhpUEhIcVdaZHNSSUhueGs0YmhTNll4MTZHU20rYUlEdXRiMzdUVDFl?=
 =?utf-8?B?bXczWDR4SUhqQTE5NEtIRDdHcFNYUWhyN1NpKzNNL0N4SGVVV3drN1dlaXdv?=
 =?utf-8?B?ekY2ZUtya1JteGVlckJjWHF3OGVMeDB1TzNIWGhBK2g5aEM0ZTQrY3dZR2pt?=
 =?utf-8?B?bjV3a2RNT3Jmd0RDalVJS3ZPczhOVVVnSkpWbXVkdXV4Wk45UnRvbGNVYjZT?=
 =?utf-8?B?Tk5uQ0h6WnhBK3ROUkdjU29LUnZsRXBTVE00Qkova1hTTDl5eitzYkR0OTdi?=
 =?utf-8?B?R3pmZHViREZHZmZ5d2pLYXNNaE84K1NsQks4MG5sNGwzdkt2M29Bdzc5aFpw?=
 =?utf-8?B?eUsvNmw4aUVNMS8zYk10bXpRQlRCNXJ5TVNrdHJoakNSd0R6TlJqalZyTTVv?=
 =?utf-8?B?a0xlQmJaeGRoUHVZSUtTZC9xZy9qcUYyWkJ5SkhaS21pc1dtWERUbVZoZVJM?=
 =?utf-8?B?VGNxWlpFWnZsOG5GUWNZd0I1WkZxR0ZGSThGZFdBRzlOSWRCWnF1ZlMvTm9T?=
 =?utf-8?B?a3NRbko3WUU2NVZOM1ZSWklaaU1talR0bHpRSExiRGFvWlZwblhWZTN3WEFj?=
 =?utf-8?B?c2ZDdW9GTDBmQ1VyL0VWdkVFLzdmV1g4YWdRL0M5b05zWnJtQ3h0dDZyT3Vz?=
 =?utf-8?B?S3Zkbm9HclpWMGJsdHdwQjJ3RUZuZDBNS0QvamtGbi90S2ZCeE1zaWJSc1M2?=
 =?utf-8?B?TmFIdFFUMGtXeE1BUUdPQzh5dUg1elF3d3pOcG9oSDBuQ1kxa1l2RmhpSzRz?=
 =?utf-8?B?V0wwL2dHOExuQ3NObjNYV0g3SnlRMGEwWHMxU2oxSTRNSUlYQXF3UHFmR3dv?=
 =?utf-8?B?VDBXbFdySWU3NTBnMnpscnh0OTNTUExmaEpqczNJZmFSMnorUmNaV0JGYXJr?=
 =?utf-8?B?ajVJUXpBdHJ1dEVyUVQxZGNwSFI4dys0aHJqV3N3K0dGcTB5ak5lVXYrdWZt?=
 =?utf-8?B?ekJHYVBCNjFkeFNQSHh6ZTNmNytCa2VDejYxbktBYTdHK0JZVXRWNjFKSDJJ?=
 =?utf-8?B?V2c4N2E4bHlrU3JEY2QyMm9sVVNIWkVqR0YwNFRhYldJelErdHFIOWxvbmM0?=
 =?utf-8?B?OGtMSUJTUkIxVDNZdlNkb1ZtbkZ1RFNRM2VUcmJWWExnRFRUWXd3YWZXT0dz?=
 =?utf-8?B?Y1dRVWVqV0pnWEx4cllRM0FtV0dSbVRWUzRBNks4ZmZrOHIyUnRjZDFuNEh6?=
 =?utf-8?B?UDYyWUREU0FrRkhIWnBmSVVod2UzemZEY1VOTURvK3FrRFpYTGxIM1F0M3Vm?=
 =?utf-8?B?SkJOK29oeXdJdGs1K1Y3WStlazFNa1JyMzlMRGVKU25wbS9PdkNlb3ZGdExH?=
 =?utf-8?B?UUtYd0NVM2J1dXhlTitOQzlPaHhldkN0aEdwZ2xLVk80UC9tYkNPWndkTXox?=
 =?utf-8?B?TGZQdkpUVXJxQ0dldmt4RkhLVlltWWJwVHpIWVBQZitvNWRXQ3pSaTdVTjA3?=
 =?utf-8?B?VE9yREQ3bWZ0U3RudGsxT0RpL1dDM0hLQ1E2UGI3dmovalY1WU8xdVhwN2Zt?=
 =?utf-8?B?dW9xZzBEOFZhai9NVHN0Nlg4amFNMWwzdy80MWI2ai9pYmh6cFFJbXlIMXU1?=
 =?utf-8?B?U00yaGF2aStJdFJQSTZKdXgycHNkVzVOYjVHcG9UOXVZaWFQdXJzaldnc2dN?=
 =?utf-8?B?N3YvbGY0Vnk0TVN3bm1jV2xzMklPVXNFR1NSV3JCR3pmblViMU1YSFhaVlpk?=
 =?utf-8?B?OXVRK0ZSTGVJR05FajlxYUJ3Ty9uT1FLaG5WVFBab2p4Z0FYdHNETU1ydDNK?=
 =?utf-8?B?d2VxUHpyV2RGTCt0MnA0aHhORlNybFl4TmFEekZiVDhMYjNpUzhySDlxN1VO?=
 =?utf-8?B?NWU5dFBRdENBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4223.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUtaakExaElXbXhkZkFwZmEzZnk2SFhpSlJUTVNOS3p5b08rUHA3Nk9VN3Va?=
 =?utf-8?B?UEVRV2RsYmhrMnltR0NmcUpWK0FBKys3UHZDZCtBTXVneVE3dWMvK1VaVEJR?=
 =?utf-8?B?YTl0bXZqK0RQeGM3ZHJva3NjZFRKd29ZaHR5Njg1SkVFTGJTd0RoVlVvRFlh?=
 =?utf-8?B?NmkzVWRZUTRKM3VDbXkxWXVpR3lGMjgyeGZHNGR4WnU2ekRLZ3RhYkMwUE9a?=
 =?utf-8?B?bnRTdnlMTStuNk8reHZXVFg3Z24wM1k4NnVBMDRMdW5jVFQxeWF0VGNnK3Rx?=
 =?utf-8?B?bTE1TXNocXlYSHZDZkZBTkFMQ01sdWpQRWtDR0VDUGUxZzRNTGd4eVVNUW1K?=
 =?utf-8?B?cWYzTUtPallJZTRyZzlOZFdoOE5STUptem1xdyt4ci9iZnc4QktFSlN4M2VX?=
 =?utf-8?B?Qy85QnJ2V3dxUUc3bjVJOEpFNlFWZFhXcEFDdk4wcEhkaGVFUVRZYXhxNUIx?=
 =?utf-8?B?eER1aUFzMHlNZ2p2NjlzOUxTeUdJZkFqdmRQYTlKUnVHR29VZkYrN0dRYndt?=
 =?utf-8?B?aWdqVTJhM3VYRWJYaTU2SkkxRVVvUGNxT21MU2V1SmpERGFicjFqbnUySmF3?=
 =?utf-8?B?ZEpWSm1CNFBhSmNYbFZXTG51Ny9qREZBRXdySlFuSHJMZThEclZmTHdsS1gr?=
 =?utf-8?B?MWJxME9wTXI2cDQ3YmhuR0pLYi8veGV1M2RnSG5YRXNENTEwZ1cvUkU0bTdk?=
 =?utf-8?B?TWFpdjZEaGtTNHZhbFJ3SktWMW05dWdtODJZdEI3aExpSExsYTU4MTdjR2sv?=
 =?utf-8?B?MjBTRHIzQmVFSTZLbDQrTUV5WkVYQWNQOFNnbWxKUWUrMHZ1M0NrOUJZcytI?=
 =?utf-8?B?dDA2enJwc1hWL1ZrMm9zczRXVWkyd2RQZXZqSitHOG1RbVY4QlFqTVdaU0Zs?=
 =?utf-8?B?L1VNUzJ0eEo4REplV3cxYUs2MS9DMzJqYnB0STliVEdwWTRRUzBxWWEzT1M4?=
 =?utf-8?B?MHN6bVVkZVdlQkVlRG02RW9VTzIySHF5MFhtc2lRWHB3WGlPM2JOUWtvRkIz?=
 =?utf-8?B?YnJSRzlSVVUrdXpzUEt1bE0rUHZqcVJacXZIeU5HallWY2I0Z3dBdkRHdzcy?=
 =?utf-8?B?TzJwd2NIbzV4TW8wLzZaMHBHZUtpaUg5MjgwN2pRMmpJM01hR3htQThFUWpu?=
 =?utf-8?B?dWVjVWt0bVREU0QrT0tYYmFRU1Y3Njc2MndTd3BFeXduR3d6VUhpT01pY254?=
 =?utf-8?B?L0xVYzgwUkVBZGhWK1lyZmpsN2xzTExBUWExdnVEaHB0ajZFZURjcEl1LzVH?=
 =?utf-8?B?SEp4aGpGQldiVU9mNDdmaWt5M0hnVjk2MEt6RER4ZnRlQjZmRTlkVXliM0NV?=
 =?utf-8?B?UnVGUmI0WmdiL3FjWGxRaThKeHVJSlRaV0NwTGUxaitOYnpQQ2pINzdybFpE?=
 =?utf-8?B?bWJCVGNTendTT21MT2xyeUNuY3F2Q1dpSVBSTGtBUGIycXp2bDgxNGwxS0tI?=
 =?utf-8?B?eStZd3I0WEFaeTd1b2FqSGQydUxyK3Ztdm9SNEorWjdydVhRTTVZL3lnZHh2?=
 =?utf-8?B?MytiVUlvcjRaU2UrZWs2YjlxWUdxa2szY1ZvSGsycDA1b3dzbWc0S3BXNGNM?=
 =?utf-8?B?QXE4K1RQa1JacFRGWW9ObU9hdUJwcENhZlVxV2QvV0FXMnkrYXlHZHFRbUdL?=
 =?utf-8?B?MjMvZGh0U2t1YzI4d0wzYXRkZ3Y5N2VITmlKZUd5KzhUMk93Ry9wTTVNUU9r?=
 =?utf-8?B?OUhyNCtiMjNEb2xiU1hDMTlxaC93b1RObjBrNEx4elM5bCszNS9TcUQ1WkU1?=
 =?utf-8?B?UHkxV0piWkVyRGN4dWlUTDlyR1phRzVOM1kxSUVaRVhBMTMxTitxVW1aN0JN?=
 =?utf-8?B?Vy9CMlZYTldlVjlCbVNPZ25YMHBOL2xCL3YzdzJsU0NHNnFPVFN5THBmdmtB?=
 =?utf-8?B?R0lLQnRWTnFHQWswdXRpWTNSWXNZWU1OT1RHQXc4N29mbW5YMFlST0R4b3hq?=
 =?utf-8?B?bVRLY3ludVYvQjRlTWwyRk96bElqSzZZMEtJb1RZQjc1cUdjdkxsODF6Qndy?=
 =?utf-8?B?V0hWc1ZERExrY0dNZFVlcHpseURwbVI2WHBjMXA2eVR3eHJ1NG5uZlR5ODlx?=
 =?utf-8?B?T2ZRM0IwVEVFS2MzRU5TY2gxOHhra1FkQzRKQ2ZtTUljYmgrWjR3UU55SExP?=
 =?utf-8?Q?JKmA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4223.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607c4946-9d6c-4fbd-48a2-08dddfdcaeb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 11:28:27.2939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXiXSLvhKxayYiRVRhv+3j1bUj0GjIKqI71S2h7/byx/1VsJ2nS8cHPBknf9VtUU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244

SGksDQoNCkxvb2tzIGdvb2QsIHRoYW5rIHlvdSBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIHN1Ym1p
dCB0aGlzIHBhdGNoLg0KDQpDaGVlcnMsDQpDb25hbGwuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogU2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+
DQo+IFNlbnQ6IDE1IEp1bHkgMjAyNSAwMToyOQ0KPiBUbzogQW5hbmQgQXNob2sgRHVtYnJlIDxh
bmFuZC5hc2hvay5kdW1icmVAeGlsaW54LmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGppYzIz
QGtlcm5lbC5vcmc+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+IENjOiBEYXZpZCBMZWNo
bmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29t
PjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBTaW1laywgTWljaGFs
IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwu
b3JnPjsgTWFuaXNoIE5hcmFuaQ0KPiA8bWFuaXNoLm5hcmFuaUB4aWxpbnguY29tPjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2VhbiBBbmRlcnNvbg0KPiA8c2Vhbi5hbmRlcnNvbkBs
aW51eC5kZXY+DQo+IFN1YmplY3Q6IFtQQVRDSF0gaWlvOiB4aWxpbngtYW1zOiBVbm1hc2sgaW50
ZXJydXB0cyBhZnRlciB1cGRhdGluZyBhbGFybXMNCj4gDQo+IFRvIGNvbnZlcnQgbGV2ZWwtdHJp
Z2dlcmVkIGFsYXJtcyBpbnRvIGVkZ2UtdHJpZ2dlcmVkIElJTyBldmVudHMsIGFsYXJtcyBhcmUg
bWFza2VkDQo+IHdoZW4gdGhleSBhcmUgdHJpZ2dlcmVkLiBUbyBlbnN1cmUgd2UgY2F0Y2ggc3Vi
c2VxdWVudCBhbGFybXMsIHdlIHRoZW4NCj4gcGVyaW9kaWNhbGx5IHBvbGwgdG8gc2VlIGlmIHRo
ZSBhbGFybSBpcyBzdGlsbCBhY3RpdmUuDQo+IElmIGl0IGlzbid0LCB3ZSB1bm1hc2sgaXQuIEFj
dGl2ZSBidXQgbWFza2VkIGFsYXJtcyBhcmUgc3RvcmVkIGluDQo+IGN1cnJlbnRfbWFza2VkX2Fs
YXJtLg0KPiANCj4gSWYgYW4gYWN0aXZlIGFsYXJtIGlzIGRpc2FibGVkLCBpdCB3aWxsIHJlbWFp
biBzZXQgaW4gY3VycmVudF9tYXNrZWRfYWxhcm0gdW50aWwNCj4gYW1zX3VubWFza193b3JrZXIg
Y2xlYXJzIGl0LiBJZiB0aGUgYWxhcm0gaXMgcmUtZW5hYmxlZCBiZWZvcmUNCj4gYW1zX3VubWFz
a193b3JrZXIgcnVucywgdGhlbiBpdCB3aWxsIG5ldmVyIGJlIGNsZWFyZWQgZnJvbQ0KPiBjdXJy
ZW50X21hc2tlZF9hbGFybS4gVGhpcyB3aWxsIHByZXZlbnQgdGhlIGFsYXJtIGV2ZW50IGZyb20g
YmVpbmcgcHVzaGVkIGV2ZW4gaWYNCj4gdGhlIGFsYXJtIGlzIHN0aWxsIGFjdGl2ZS4NCj4gDQo+
IEZpeCB0aGlzIGJ5IHJlY2FsY3VsYXRpbmcgY3VycmVudF9tYXNrZWRfYWxhcm0gaW1tZWRpYXRl
bHkgd2hlbiBlbmFibGluZyBvcg0KPiBkaXNhYmxpbmcgYWxhcm1zLg0KPiANCj4gRml4ZXM6IGQ1
YzcwNjI3YTc5NCAoImlpbzogYWRjOiBBZGQgWGlsaW54IEFNUyBkcml2ZXIiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gLS0tDQo+
IA0KPiAgZHJpdmVycy9paW8vYWRjL3hpbGlueC1hbXMuYyB8IDQ1ICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyks
IDIwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy94aWxp
bngtYW1zLmMgYi9kcml2ZXJzL2lpby9hZGMveGlsaW54LWFtcy5jIGluZGV4DQo+IDc2ZGQwMzQz
ZjVmNy4uMTgwZDQxNDA5OTNkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMveGlsaW54
LWFtcy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMNCj4gQEAgLTM4OSw2
ICszODksMjkgQEAgc3RhdGljIHZvaWQgYW1zX3VwZGF0ZV9wbF9hbGFybShzdHJ1Y3QgYW1zICph
bXMsDQo+IHVuc2lnbmVkIGxvbmcgYWxhcm1fbWFzaykNCj4gIAlhbXNfcGxfdXBkYXRlX3JlZyhh
bXMsIEFNU19SRUdfQ09ORklHMywNCj4gQU1TX1JFR0NGRzNfQUxBUk1fTUFTSywgY2ZnKTsgIH0N
Cj4gDQo+ICtzdGF0aWMgdm9pZCBhbXNfdW5tYXNrKHN0cnVjdCBhbXMgKmFtcykgew0KPiArCXVu
c2lnbmVkIGludCBzdGF0dXMsIHVubWFzazsNCj4gKw0KPiArCXN0YXR1cyA9IHJlYWRsKGFtcy0+
YmFzZSArIEFNU19JU1JfMCk7DQo+ICsNCj4gKwkvKiBDbGVhciB0aG9zZSBiaXRzIHdoaWNoIGFy
ZSBub3QgYWN0aXZlIGFueW1vcmUgKi8NCj4gKwl1bm1hc2sgPSAoYW1zLT5jdXJyZW50X21hc2tl
ZF9hbGFybSBeIHN0YXR1cykgJg0KPiArYW1zLT5jdXJyZW50X21hc2tlZF9hbGFybTsNCj4gKw0K
PiArCS8qIENsZWFyIHN0YXR1cyBvZiBkaXNhYmxlZCBhbGFybSAqLw0KPiArCXVubWFzayB8PSBh
bXMtPmludHJfbWFzazsNCj4gKw0KPiArCWFtcy0+Y3VycmVudF9tYXNrZWRfYWxhcm0gJj0gc3Rh
dHVzOw0KPiArDQo+ICsJLyogQWxzbyBjbGVhciB0aG9zZSB3aGljaCBhcmUgbWFza2VkIG91dCBh
bnl3YXkgKi8NCj4gKwlhbXMtPmN1cnJlbnRfbWFza2VkX2FsYXJtICY9IH5hbXMtPmludHJfbWFz
azsNCj4gKw0KPiArCS8qIENsZWFyIHRoZSBpbnRlcnJ1cHRzIGJlZm9yZSB3ZSB1bm1hc2sgdGhl
bSAqLw0KPiArCXdyaXRlbCh1bm1hc2ssIGFtcy0+YmFzZSArIEFNU19JU1JfMCk7DQo+ICsNCj4g
KwlhbXNfdXBkYXRlX2ludHJtYXNrKGFtcywgfkFNU19BTEFSTV9NQVNLLA0KPiB+QU1TX0FMQVJN
X01BU0spOyB9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIGFtc191cGRhdGVfYWxhcm0oc3RydWN0IGFt
cyAqYW1zLCB1bnNpZ25lZCBsb25nIGFsYXJtX21hc2spICB7DQo+ICAJdW5zaWduZWQgbG9uZyBm
bGFnczsNCj4gQEAgLTQwMSw2ICs0MjQsNyBAQCBzdGF0aWMgdm9pZCBhbXNfdXBkYXRlX2FsYXJt
KHN0cnVjdCBhbXMgKmFtcywgdW5zaWduZWQNCj4gbG9uZyBhbGFybV9tYXNrKQ0KPiANCj4gIAlz
cGluX2xvY2tfaXJxc2F2ZSgmYW1zLT5pbnRyX2xvY2ssIGZsYWdzKTsNCj4gIAlhbXNfdXBkYXRl
X2ludHJtYXNrKGFtcywgQU1TX0lTUjBfQUxBUk1fTUFTSywgfmFsYXJtX21hc2spOw0KPiArCWFt
c191bm1hc2soYW1zKTsNCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhbXMtPmludHJfbG9j
aywgZmxhZ3MpOyAgfQ0KPiANCj4gQEAgLTEwMzUsMjggKzEwNTksOSBAQCBzdGF0aWMgdm9pZCBh
bXNfaGFuZGxlX2V2ZW50cyhzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LCB1bnNpZ25lZCBs
b25nIGV2ZW50cykgIHN0YXRpYyB2b2lkIGFtc191bm1hc2tfd29ya2VyKHN0cnVjdA0KPiB3b3Jr
X3N0cnVjdCAqd29yaykgIHsNCj4gIAlzdHJ1Y3QgYW1zICphbXMgPSBjb250YWluZXJfb2Yod29y
aywgc3RydWN0IGFtcywgYW1zX3VubWFza193b3JrLndvcmspOw0KPiAtCXVuc2lnbmVkIGludCBz
dGF0dXMsIHVubWFzazsNCj4gDQo+ICAJc3Bpbl9sb2NrX2lycSgmYW1zLT5pbnRyX2xvY2spOw0K
PiAtDQo+IC0Jc3RhdHVzID0gcmVhZGwoYW1zLT5iYXNlICsgQU1TX0lTUl8wKTsNCj4gLQ0KPiAt
CS8qIENsZWFyIHRob3NlIGJpdHMgd2hpY2ggYXJlIG5vdCBhY3RpdmUgYW55bW9yZSAqLw0KPiAt
CXVubWFzayA9IChhbXMtPmN1cnJlbnRfbWFza2VkX2FsYXJtIF4gc3RhdHVzKSAmIGFtcy0NCj4g
PmN1cnJlbnRfbWFza2VkX2FsYXJtOw0KPiAtDQo+IC0JLyogQ2xlYXIgc3RhdHVzIG9mIGRpc2Fi
bGVkIGFsYXJtICovDQo+IC0JdW5tYXNrIHw9IGFtcy0+aW50cl9tYXNrOw0KPiAtDQo+IC0JYW1z
LT5jdXJyZW50X21hc2tlZF9hbGFybSAmPSBzdGF0dXM7DQo+IC0NCj4gLQkvKiBBbHNvIGNsZWFy
IHRob3NlIHdoaWNoIGFyZSBtYXNrZWQgb3V0IGFueXdheSAqLw0KPiAtCWFtcy0+Y3VycmVudF9t
YXNrZWRfYWxhcm0gJj0gfmFtcy0+aW50cl9tYXNrOw0KPiAtDQo+IC0JLyogQ2xlYXIgdGhlIGlu
dGVycnVwdHMgYmVmb3JlIHdlIHVubWFzayB0aGVtICovDQo+IC0Jd3JpdGVsKHVubWFzaywgYW1z
LT5iYXNlICsgQU1TX0lTUl8wKTsNCj4gLQ0KPiAtCWFtc191cGRhdGVfaW50cm1hc2soYW1zLCB+
QU1TX0FMQVJNX01BU0ssDQo+IH5BTVNfQUxBUk1fTUFTSyk7DQo+IC0NCj4gKwlhbXNfdW5tYXNr
KGFtcyk7DQo+ICAJc3Bpbl91bmxvY2tfaXJxKCZhbXMtPmludHJfbG9jayk7DQo+IA0KPiAgCS8q
IElmIHN0aWxsIHBlbmRpbmcgc29tZSBhbGFybSByZS10cmlnZ2VyIHRoZSB0aW1lciAqLw0KPiAt
LQ0KPiAyLjM1LjEuMTMyMC5nYzQ1MjY5NTM4Ny5kaXJ0eQ0KDQpSZXZpZXdlZC1ieTogTydHcmlv
ZmEsIENvbmFsbCA8Y29uYWxsLm9ncmlvZmFAYW1kLmNvbT4NCg==

