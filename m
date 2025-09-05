Return-Path: <linux-iio+bounces-23729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C637B44D8C
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264B07BCFB2
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 05:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E10123B618;
	Fri,  5 Sep 2025 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5GkIKjgG"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF155B21A;
	Fri,  5 Sep 2025 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050166; cv=fail; b=SHXpq/fxRJiBjIgWxhhwy3+ghAZ9ql2B5DT5HxUYkIj0TBXZb1JTKdQtnGiO/bolT5UXzIF97a121lWTXwtOiV4En4OW36kbU9OKbJoFgrBwIlDOf1HDkzFWjgFWA24zzihO/iCr90HXDxumHi3x+4+dibyZgwWauElqDwWkGwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050166; c=relaxed/simple;
	bh=hebzVbooimS7RCBjSXevcswsMyjZEMdJZmTe0/Mvu9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nq2JJ6Mr/RbQHKi5wWFs9gricnhJcpj8fV3bUMHWzsNoKS/ucF/y//WF/f5IERIE0Pr683eBglIKUbF5MUL9YSzmIT4Sa1apdJaOslLWo1Bd7GkE9vf6pjfyY5Q9o+GDjtdoDQqglx0KrzLz/8MQ+8reqn1YD+SpbedmtQYoEtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5GkIKjgG; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUKxPkrxuD4Wj85egtJbGk7VgRfYPBvMRz02/r/LrDal1xsmbCXB9g1/0cLbExpFmf70KJz0yY78Ft31Q5DDne1kjVy9cCyxgIGkQGaQTEfwrUmqfgVGkvEvsuV5kkIj1n8rxAqzUEV3nzUER6YTDqTumQqbhnmof+3/ZHGA/WUR5PdOJhdzx8B7BQRtMEZ3a1xVZHXdu/et714iJcE4q55jeoeZlEbfiV3XvySI/UnMy40LpxroW1YOJxBZui/QoFRnq4G+Bw1G2sHvPDGpzdf0I4AE6bUohSH/5WvdhHa/b2z0/fJFiVVfcWzPNf4x6qYwejjrtO89D0IhjcqzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hebzVbooimS7RCBjSXevcswsMyjZEMdJZmTe0/Mvu9k=;
 b=C1XVXrRRToossd8Jb8CQTEvPNbyHhJOyz6N7BTSy/6mFPTbsYyC8ooypVKOVbB7oj0sTLYrihVXkOW5f6jINCjfbLO82FnKUcFjHhcy6ho7xAG/+QXJ8O5DRs9zYpzwWD4JISNNeboPmTDB+ur68YVrkxqkJ36pHHbQFPZ7Flyh4KLPCNcGTombUz7uQh33RVlzd1+9KQ3UfpEYIpj5713y/3TMOedJVK3qdmfcVwJ3GmIDZQLQqIf67xeoklcWi5O3K+9JAcfIuG1ScqzAhmRjqPK/J6Zu+227G1jw/E1podhSwuc9vWUliiUxWymayQosShMd6J95E9I4hhaBmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hebzVbooimS7RCBjSXevcswsMyjZEMdJZmTe0/Mvu9k=;
 b=5GkIKjgGjMJwNgsZ6zxbBhlEWauDXoJPl7cnUClXJ1rzyIHDYT38sqgEpSlci50k65Cqrc1oqTh2tEotafGy5yJEI/+DG6omQaYsG6PirumtOkiZIehjaniu1BQC8fnTzGOR/v03ZCZKWQFaJtsm8zEJ4TUDpGkHNqov/8KITWk=
Received: from IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 05:29:20 +0000
Received: from IA1PR12MB6092.namprd12.prod.outlook.com
 ([fe80::6501:100:1d7:8136]) by IA1PR12MB6092.namprd12.prod.outlook.com
 ([fe80::6501:100:1d7:8136%3]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 05:29:19 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Jorge Marques <gastmaier@gmail.com>, "mario.tesi@st.com"
	<mario.tesi@st.com>
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
 AQHb+i+8xK2s1GBMXUK4mOoG9AwzB7Q8c6QAgACdMwCAAK9QQIAAB8qAgAmwZzCAAaGzgIABJMYggDoMRIA=
Date: Fri, 5 Sep 2025 05:29:18 +0000
Message-ID:
 <IA1PR12MB6092EC3ADBEC4032CF52000E8C03A@IA1PR12MB6092.namprd12.prod.outlook.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
 <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
 <DM4PR12MB61095749195041654F6D560D8C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <3d7w3rczrdics77nt7lig5rsj2bmfubpwzhffarzlxmo5w2g4a@baewpltdovhk>
 <DM4PR12MB610930805348D91ACAE876A18C25A@DM4PR12MB6109.namprd12.prod.outlook.com>
 <5pmqumpue7h4us265co6pya37434t4jvf3b655gtjcohlyhash@3ggx7e2maud6>
 <DM4PR12MB6109B8CCEBF5D334662E6CEE8C24A@DM4PR12MB6109.namprd12.prod.outlook.com>
In-Reply-To:
 <DM4PR12MB6109B8CCEBF5D334662E6CEE8C24A@DM4PR12MB6109.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mario.tesi@st.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-05T04:44:25.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6092:EE_|CYYPR12MB8923:EE_
x-ms-office365-filtering-correlation-id: ef424609-5f41-4ae1-d385-08ddec3d2984
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UzhLSk1wbUZSY3Y5aWtPUWQvaXdjRFRyMFMwbXNDc011a0RxRmFLNW9IbG5C?=
 =?utf-8?B?ZkRaUzNtN1Y5UnowempEeTU0NDBlaWdjRHdhWmN5NVFyMjh5MkpOc2RkY2NS?=
 =?utf-8?B?VklSbUdOYTAzalZJNHEyYU9qczBLWkFZc2k1UUVqRVpMbUh3d0h2dW1Gb3Vt?=
 =?utf-8?B?RWJRck5DV2tWWjVoWVFDSUhnc3RDVVdTa1krQXJ4bk1VTXU1SDFNR1ZYSkxw?=
 =?utf-8?B?ZmlldXE3eTFqd29veVd3MVBrS1psZUhCU21XSlA2YkxVa2dFSW1yWElRUS8z?=
 =?utf-8?B?YUo4OXR0RHZuS0V6M1hCN2lvcEI5NjVHS1V3TzY2bEJMankxSXc2U2R1aEpF?=
 =?utf-8?B?MlBRWHUxYWlWd1VyOXg4ajR0SlIrb2lCdy91VERROTZPWUlIOFYya0FpOThk?=
 =?utf-8?B?K1hmdDZmcHdlZ2hidGlvbXBZc3YzRXVRcHEzQWFyeVA0cnJycUxYM2poc245?=
 =?utf-8?B?MjllUnNpNjNRdWIrL0hldWF4NEx2TFZKL2JHYndKdy83QnlKdnkwc1lFRTZq?=
 =?utf-8?B?OFoyL2V3a0RXU0pSSU1HU1ljSWo0TGtQMTY1a0trTGtjek02eVJremJudExh?=
 =?utf-8?B?YktlbXZwS3FFeitQdEl2QlYzU0VqL0QzSDhKTTNlcEFBU3lTNDc4ZGpFTUdm?=
 =?utf-8?B?NU9hYTQ4K0tiRkR4VVRYdHFXeDZYRTZ4L0xpQlNMck5IUUJUVlcxS0tmdHo4?=
 =?utf-8?B?NzY1ZjVLcXpQcVFKK29VUFNwcStDSUZpUDlFWVJzKzBZRWpRN0ZTVFU5YU1K?=
 =?utf-8?B?VFJaSlA2cWtEbUhyNjZYWFZIbk1nSG10V204czV5MTRGeC8wdEdTOU41OEVR?=
 =?utf-8?B?SG00UGMydyt2cVFROUZ5aUpKRFBTNjBXd0Rqb0Q5Mm1HWGpnUkFxMVR3NjU3?=
 =?utf-8?B?TGdueE1TVlVqeUhUTVdIaFc3YlJ1M3UvaHM5dkFrbzgzS21nNXc0R3RNMXM1?=
 =?utf-8?B?QUFBL3B0RWFlSzZWSGxMemlmeTRxdGpyT1BFSlgva0xFWGNUVzlXamN5aVdl?=
 =?utf-8?B?T1d1Qm9IMDJkRk1aMWdpblJPQmU1azU3ai9vR1pLeC9JYWFiWFp1dVVtRm90?=
 =?utf-8?B?VEFCWi9xeTRneU9XVU9xNjlkdHkwRWN3dzUrcUZuVEY5SDVZSnZSOG9QVVFH?=
 =?utf-8?B?U0NOVmxIcngxY3B1UkxQTzhjUG5FUHpER040SVphTEVnR3IwZFdnN0tNRlFO?=
 =?utf-8?B?ajQ5bFhBWm1NWjhGNWFOamR0cDljUU5MSU4xRWF4OElabkhVNVgvakt5UXl2?=
 =?utf-8?B?RjFXajFMdzB3Vkk1dHBHbmkwc1pjRW4vcW5ENlFOSUJSbDhGblc0YnkwWXRy?=
 =?utf-8?B?ZlJ6T0tITzY1Y0pYQzNNYUFnT0xlaFRrRzZIbVpFTlpuSEhYK1JUVFlOdjhE?=
 =?utf-8?B?ZDhvZHMzajc1NTZ0bWwwSVB0cXdySTlsRVRVQVhYbUh2QS9tRjRWTFJBd04y?=
 =?utf-8?B?SXNqSzRjNjI5ZVBncHdwSWg1ZTY4RUhnRXErcUtQVlNsUzVwdVd6c1B2U0pi?=
 =?utf-8?B?c3NJWWpjVzUzRjIveStpQThnUlNuZWJSQ3pMNU1LZkRUdjhFc1VqL0pqRURw?=
 =?utf-8?B?ZHIreVduNVYwVk56dDNtRGR1bTFBOXBBMTBFK0JTeHZMenQ1R0M2NkFjSndW?=
 =?utf-8?B?dW1WTUEvbGxrMXRLZDgvMlN5a0lyY3BBV3JwVmVnZTJJYjBjVmIyKzQ3R1Ji?=
 =?utf-8?B?TnQxZFFpTnNkb202SG5rYjU2cHNnci95RVQvWEE3bFhQVXl4Y3JzNTBBWXZG?=
 =?utf-8?B?ZkphN3h6ZkN1N24walpvTE1wVThwUmpXWFpWQnRTQlNxSVQ3eUZxSVNsSXBZ?=
 =?utf-8?B?NjRXc3NoZlBJcHV5YnZURkEvWWc5K09zbmVRb1czck40Z2x0V0JOWERpY2t6?=
 =?utf-8?B?OHk2RFhSeEVDTzhDL0toMUhXSlBlQXRRR1AzOERtWGhqcHB3eTJXVWgraDJ4?=
 =?utf-8?B?VXFkUUJvaGt3Z2huWlpVeGpxdkNPalJZd2tLbHp3WDJoUWd4Uk1LRm5Wb3Qx?=
 =?utf-8?B?aDNZQ2M0UU9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6092.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZitOMHpQQWVxVEprTWo3eERIQ2dyL2licXZNaXV2Q3pHYnhwMTJlcFl5SmU1?=
 =?utf-8?B?cEFnWlpSbmRUaFFFMUF5amh4R2kzdXZVYTFVSjRBMlJvNnFNM3Y4aHRkY2cw?=
 =?utf-8?B?clpSakxJMDBNVGg4ZVA2ZDFMdTlFV25ZQlBlTjVQdnc0dE5HOEZRVlYxWjhN?=
 =?utf-8?B?bmJJSnlvZGo0OE5PT3lzVGJ2SXVldFlpTXJiM2NqQnlienR3VS9uUVhKS2FH?=
 =?utf-8?B?eUtyaHgwK0lHSlRPMUcwdWczU2tkY3lSRFZUM3F0cDQ3eGdocTBVUHUrNmVu?=
 =?utf-8?B?RHNPcERrVHhEQzNMbllRNEl4VCswVVFJcVlMRnAzbUZTR1BXNWUrNzVyV0tp?=
 =?utf-8?B?Umh4TTVjdW9tdzJwbmxWUThSNEM3NW1KMnUrL0xZSTB1d1NGS0J0ZmR5YW5t?=
 =?utf-8?B?TTNqdnRxaDlyUGN5NGNRWTc2NktMRVM1bCtIVUtLSjhkMHV0TURlVDN6b1dJ?=
 =?utf-8?B?RTBkTVRNMzdWU3JDTEp6dHd1RW05bFRZV280MzEwWWVaR3F1djhJalM2VnhB?=
 =?utf-8?B?RVZjeDBmUDRmK3N3YTRNaGZFUTVKVlRUM09wVVJwU0tZM2xNWW1hdUphT3ZL?=
 =?utf-8?B?S3lweVM1c0JUekMwaUt6SVdhK2UwcFhURThmdWREWGVTVFQ3NU16ZldqTjlm?=
 =?utf-8?B?WmN6a0pZeDMxaHNOV0dabVNCMVh6azRPSVNaelp4Zk5aQXA2UllqbDVlVnI5?=
 =?utf-8?B?ZmRmYW14RnJIM085OFJWblU0RklSUDgyOTQ2Sk91TnVDRFoza29nRlRjSWJo?=
 =?utf-8?B?UnhLdFhUQmlPZ3ZVaHBSWWZOcVFCY1dIYnJ0WXdjOGh2blRkREZMa0Q4cktL?=
 =?utf-8?B?eFAyL1lhSUVxTEtVUmo5MURNUmVYeDdwZnVqMzlBS3FVdHFsUWRvb3NpY09z?=
 =?utf-8?B?RlpTaXJlU0NWU1RZOThMNnIxdjc2R2VMNldBZG1ESnN0MFM2TXQxMmFWUE5H?=
 =?utf-8?B?cmJDb0l3Q2tJdVR1Y1B5ZlBldHE3bjFyQ2pjSFNjK2RvendNS3dBajR0QWp1?=
 =?utf-8?B?ZmRsRllyTzg4cVdPSEI5eDQ1TFA2SzhjcHo5eS92N0dMa1lhK3NIVXZycDJZ?=
 =?utf-8?B?RHhNSFZydnRtVkYzQU9JRi9aZ0Y3czhBMUJPVUhYa2xNeFk4OXRZMGpkMDli?=
 =?utf-8?B?Z2Iyek0rU0R6QXBXSUlWdWc5OGJoOS9IRkNjR0lFQXU3VUFaMW9ZWWxZNzh2?=
 =?utf-8?B?MmxhWGVYNU5lOTZPWEFPT0Z0TTFOL1BRT05tSHhwRlJoQU5HUFpTSlNTQ1hr?=
 =?utf-8?B?dUFkeFo2VWdOMThha0tNakF2dWp6ZHgrNGw4eW95RHMySEcxbzhGNUk0dy9t?=
 =?utf-8?B?alYzWEZuaThPMXNRMGR6RHE4MXBMQWJPbGZ4ZC9JdDZWZVpIeG5uWVBtUDF1?=
 =?utf-8?B?czhIMVRwQW9BaFFONWFIMGwyS241ZVFwRk5zNkhXZ0xOK1RRWE9rY3lkWGxo?=
 =?utf-8?B?VzJMMDdxU1dicmVZV0ZmeTMreWE1QW9HL1VNcXZYU0orcEZucjB1MmpaRE5t?=
 =?utf-8?B?MFgyRHNIaVQ2L0tuMzZiSXNpU0pDMS9zKzNSYVA0eEVPWjh5b3BoaHliVjY4?=
 =?utf-8?B?TzZ1RWdwaDJTMUYwMVM5dlYxMlQ5N0EreFFJSHRFSTJpdnFBRVM5MjFBRW1T?=
 =?utf-8?B?VmpCaUdVQWlxSndCU21jbTRUa2g4QXdlMEd2c0dJenNuRk4yRGVDYjYrWFIv?=
 =?utf-8?B?bUdlaEtYRk4vM0tnV0R4cmVUQ0lLQnZzQ2RyTHIzM3Y4VnZmUUs1OTM4dGxs?=
 =?utf-8?B?aG1qVEJQNVBoSDRSbENKU3ExUVBKaTh3TEJLV1FxY2JEZUtnaUZHSnBGSHBw?=
 =?utf-8?B?V1YwcGJDWHVuU0hGYUkxTGFJRXF4eFBtMTB3MGlnV3hnYk9Od0V2UU83RkpD?=
 =?utf-8?B?clc3aGVFcTN1cUJvWDBwczE2UjZScVFGY0dxUlNPUERvN3VPTW5NcWdjM2pZ?=
 =?utf-8?B?MWFIZER3dXBuNkh6QUNGTUMxQXgrdjFTdEp0Yk4wdlRUdUw4QWpXTDllWGx1?=
 =?utf-8?B?d2p6bUhZVHNxVXNXYzlMZ0c5RjNqb0F4NUJlelRuK0p2OTlHTzBGd3Z0Q2Nj?=
 =?utf-8?B?NGUya05GZVcxMEhBYUJ2VU9NT0tRT3pWSUxMWDJET2pqVDRDZkY4bUpTUjhu?=
 =?utf-8?Q?mJ2I=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6092.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef424609-5f41-4ae1-d385-08ddec3d2984
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 05:29:18.9822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ub0uwNcBWGh/yjkRbPQgCZHrr5wqNbYfLtFduNyWUghVO3jkhF/m6ZeY4GQEH6xkbHq1anr9hUi//OJjs3hC8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923

W1B1YmxpY10NCg0KKyBAbWFyaW8udGVzaUBzdC5jb20NCg0KSGkgQG1hcmlvLnRlc2ksDQpXZSBh
cmUgb2JzZXJ2aW5nIGFuIGVudW1lcmF0aW9uIGlzc3VlIHdpdGggdGhlIExTTTZEU1ggc2Vuc29y
IG9uIEkzQywNCnNpbmNlIGVudW1lcmF0aW9uIG9jY3VycyBvbmx5IHRoZXJlLiBEdXJpbmcgYSBr
ZXhlYyByZWJvb3QsIHRoZSBMU002RFNYDQpkb2VzIG5vdCByZXNwb25kIHRvIENDQyBjb21tYW5k
cyBkdXJpbmcgZW51bWVyYXRpb24uDQpBZGRpbmcgYSBzb2Z0d2FyZSByZXNldCBpbiBzaHV0ZG93
bigpIHJlc29sdmVzIHRoaXMgYW5kIGFsbG93cyBlbnVtZXJhdGlvbiB0byBzdWNjZWVkLg0KDQpD
b3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gdGhpcyBiZWhhdmlvciBvZiB0aGUgTFNNNkRTWCBvbiBJ
M0MgZnJvbSB5b3VyIHNpZGUgPw0KWW91ciBjb25maXJtYXRpb24gd2lsbCBoZWxwIHVzIGRlY2lk
ZSB3aGV0aGVyIHRvIHByb2NlZWQgd2l0aCBqdXN0IHRoZSBzb2Z0d2FyZQ0KcmVzZXQgaW4gdGhl
IGRyaXZlciBvciBjb25zaWRlciBhZGRpdGlvbmFsIHN0ZXBzLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEd1bnR1cGFsbGksIE1hbmlrYW50YSA8bWFuaWthbnRhLmd1
bnR1cGFsbGlAYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDMwLCAyMDI1IDExOjU4
IEFNDQo+IFRvOiBKb3JnZSBNYXJxdWVzIDxnYXN0bWFpZXJAZ21haWwuY29tPg0KPiBDYzogRGF2
aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+IDxh
bmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+OyBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNv
bT47IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbG9yZW56b0BrZXJu
ZWwub3JnOyBqaWMyM0BrZXJuZWwub3JnOw0KPiBudW5vLnNhQGFuYWxvZy5jb207IGFuZHlAa2Vy
bmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IFBhbmRleSwgUmFkaGV5IFNoeWFtDQo+IDxyYWRoZXkuc2h5YW0ucGFuZGV5
QGFtZC5jb20+OyBHb3VkLCBTcmluaXZhcyA8c3Jpbml2YXMuZ291ZEBhbWQuY29tPjsNCj4gbWFu
aW9uMDVna0BnbWFpbC5jb20NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gaWlvOiBpbXU6IGxzbTZk
c3g6IEFkZCBzaHV0ZG93biBjYWxsYmFjayBzdXBwb3J0IGZvciBJM0MNCj4gaW50ZXJmYWNlDQo+
DQo+DQo+IEhpLA0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
Sm9yZ2UgTWFycXVlcyA8Z2FzdG1haWVyQGdtYWlsLmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBK
dWx5IDI5LCAyMDI1IDY6MTkgUE0NCj4gPiBUbzogR3VudHVwYWxsaSwgTWFuaWthbnRhIDxtYW5p
a2FudGEuZ3VudHVwYWxsaUBhbWQuY29tPg0KPiA+IENjOiBEYXZpZCBMZWNobmVyIDxkbGVjaG5l
ckBiYXlsaWJyZS5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4gPiA8YW5kcml5LnNoZXZjaGVua29A
aW50ZWwuY29tPjsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBTaW1laywNCj4gPiBN
aWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbG9yZW56b0BrZXJuZWwub3JnOyBqaWMyM0Br
ZXJuZWwub3JnOw0KPiA+IG51bm8uc2FAYW5hbG9nLmNvbTsgYW5keUBrZXJuZWwub3JnOyBsaW51
eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBQYW5kZXksIFJhZGhleSBTaHlhbQ0KPiA+IDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+
OyBHb3VkLCBTcmluaXZhcyA8c3Jpbml2YXMuZ291ZEBhbWQuY29tPjsNCj4gPiBtYW5pb24wNWdr
QGdtYWlsLmNvbQ0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlpbzogaW11OiBsc202ZHN4OiBB
ZGQgc2h1dGRvd24gY2FsbGJhY2sgc3VwcG9ydA0KPiA+IGZvciBJM0MgaW50ZXJmYWNlDQo+ID4N
Cj4gPiBPbiBUdWUsIEp1bCAyOSwgMjAyNSBhdCAxMjowMjo1NlBNICswMDAwLCBHdW50dXBhbGxp
LCBNYW5pa2FudGEgd3JvdGU6DQo+ID4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIElu
dGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+ID4NCj4gPiA+IEhpIEBKb3JnZSBNYXJxdWVz
LA0KPiA+ID4NCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJv
bTogSm9yZ2UgTWFycXVlcyA8Z2FzdG1haWVyQGdtYWlsLmNvbT4NCj4gPiA+ID4gU2VudDogVHVl
c2RheSwgSnVseSAyMiwgMjAyNSAxOjI3IFBNDQo+ID4gPiA+IFRvOiBHdW50dXBhbGxpLCBNYW5p
a2FudGEgPG1hbmlrYW50YS5ndW50dXBhbGxpQGFtZC5jb20+DQo+ID4gPiA+IENjOiBEYXZpZCBM
ZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4gPiA+ID4g
PGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT47IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQu
Y29tPjsNCj4gPiA+ID4gU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBsb3Jl
bnpvQGtlcm5lbC5vcmc7DQo+ID4gPiA+IGppYzIzQGtlcm5lbC5vcmc7IG51bm8uc2FAYW5hbG9n
LmNvbTsgYW5keUBrZXJuZWwub3JnOw0KPiA+ID4gPiBsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
OyBsaW51eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGFuZGV5LA0KPiA+ID4gPiBSYWRoZXkg
U2h5YW0gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT47IEdvdWQsIFNyaW5pdmFzDQo+ID4g
PiA+IDxzcmluaXZhcy5nb3VkQGFtZC5jb20+OyBtYW5pb24wNWdrQGdtYWlsLmNvbQ0KPiA+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBpaW86IGltdTogbHNtNmRzeDogQWRkIHNodXRkb3duIGNh
bGxiYWNrDQo+ID4gPiA+IHN1cHBvcnQgZm9yIEkzQyBpbnRlcmZhY2UNCj4gPiA+ID4NCj4gPiA+
ID4gT24gVHVlLCBKdWwgMjIsIDIwMjUgYXQgMDc6MzI6NTRBTSArMDAwMCwgR3VudHVwYWxsaSwg
TWFuaWthbnRhIHdyb3RlOg0KPiA+ID4gPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQg
SW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBIaSBARGF2
aWQgTGVjaG5lciwNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+ID4gPiA+IEZyb206IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJl
LmNvbT4NCj4gPiA+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjIsIDIwMjUgMjozMSBBTQ0K
PiA+ID4gPiA+ID4gVG86IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwu
Y29tPjsgR3VudHVwYWxsaSwNCj4gPiA+ID4gPiA+IE1hbmlrYW50YSA8bWFuaWthbnRhLmd1bnR1
cGFsbGlAYW1kLmNvbT4NCj4gPiA+ID4gPiA+IENjOiBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1k
LmNvbT47IFNpbWVrLCBNaWNoYWwNCj4gPiA+ID4gPiA+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47
IGxvcmVuem9Aa2VybmVsLm9yZzsgamljMjNAa2VybmVsLm9yZzsNCj4gPiA+ID4gPiA+IG51bm8u
c2FAYW5hbG9nLmNvbTsgYW5keUBrZXJuZWwub3JnOw0KPiA+ID4gPiA+ID4gbGludXgtaWlvQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gPiA+
IFBhbmRleSwgUmFkaGV5IFNoeWFtIDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+OyBHb3Vk
LA0KPiA+ID4gPiA+ID4gU3Jpbml2YXMgPHNyaW5pdmFzLmdvdWRAYW1kLmNvbT47IG1hbmlvbjA1
Z2tAZ21haWwuY29tDQo+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpaW86IGltdTog
bHNtNmRzeDogQWRkIHNodXRkb3duIGNhbGxiYWNrDQo+ID4gPiA+ID4gPiBzdXBwb3J0IGZvciBJ
M0MgaW50ZXJmYWNlDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gNy8yMS8yNSA2OjM4IEFN
LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDIxLCAy
MDI1IGF0IDA0OjM3OjQxUE0gKzA1MzAsIE1hbmlrYW50YSBHdW50dXBhbGxpDQo+IHdyb3RlOg0K
PiA+ID4gPiA+ID4gPj4gQWRkIGEgc2h1dGRvd24gaGFuZGxlciBmb3IgdGhlIFNUIExTTTZEU3gg
STNDIGRyaXZlciB0bw0KPiA+ID4gPiA+ID4gPj4gcGVyZm9ybSBhIGhhcmR3YXJlIHJlc2V0IGR1
cmluZyBzeXN0ZW0gc2h1dGRvd24uIFRoaXMNCj4gPiA+ID4gPiA+ID4+IGVuc3VyZXMgdGhlIHNl
bnNvciBpcyBwbGFjZWQgaW4gYSB3ZWxsLWRlZmluZWQgcmVzZXQgc3RhdGUsDQo+ID4gPiA+ID4g
PiA+PiBwcmV2ZW50aW5nIGlzc3VlcyBkdXJpbmcgc3Vic2VxdWVudCByZWJvb3RzLCBzdWNoIGFz
IGtleGVjLA0KPiA+ID4gPiA+ID4gPj4gd2hlcmUgdGhlIGRldmljZSBtYXkgZmFpbCB0byByZXNw
b25kIGNvcnJlY3RseSBkdXJpbmcgZW51bWVyYXRpb24uDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+IERvIHlvdSBpbXBseSB0aGF0IHRvbnMgb2YgZGV2aWNlIGRyaXZlcnMgbWlzc2luZyB0
aGlzPyBJDQo+ID4gPiA+ID4gPiA+IGRvbid0IHRoaW5rIHdlIGhhdmUgZXZlbiA1JSBvZiB0aGUg
ZHJpdmVycyBpbXBsZW1lbnRpbmcgdGhlIGZlYXR1cmUuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBJbiB0aGUgSUlPIGRyaXZlcnMgSSd2ZSB3b3JrZWQgb24sIHdlIGFsd2F5cyBkbyByZXNl
dCBpbiB0aGUNCj4gPiA+ID4gPiA+IHByb2JlKCkgZnVuY3Rpb24uIFRoZQ0KPiA+ID4gPiA+ID4g
c2h1dGRvd24oKSBmdW5jdGlvbiBtaWdodCBub3QgcnVuLCBlLmcuIGlmIHRoZSBib2FyZCBsb3Nl
cw0KPiA+ID4gPiA+ID4gcG93ZXIsIHNvIGl0IGRvZXNuJ3QgZml4IDEwMCUgb2YgdGhlIGNhc2Vz
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmsgeW91IGZvciB0aGUgaW5wdXQuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBZb3UncmUgYWJzb2x1dGVseSByaWdodCDigJQgc2h1dGRvd24oKSBtYXkg
bm90IGNvdmVyIGFsbCBjYXNlcyBsaWtlIHBvd2VyDQo+IGxvc3MuDQo+ID4gPiA+IEhvd2V2ZXIs
IGluIHNjZW5hcmlvcyBzdWNoIGFzIGEgd2FybSByZWJvb3QgKGtleGVjKSwgdGhlIHNpdHVhdGlv
biBpcyBkaWZmZXJlbnQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBCZWZvcmUgdGhlIHByb2JlIGlz
IGNhbGxlZCBpbiB0aGUgbmV4dCBib290LCBkZXZpY2UgZW51bWVyYXRpb24NCj4gPiA+ID4gPiB0
YWtlcyBwbGFjZS4gRHVyaW5nDQo+ID4gPiA+IHRoaXMgcHJvY2VzcywgdGhlIEkzQyBmcmFtZXdv
cmsgY29tcGFyZXMgdGhlIGRldmljZeKAmXMgUElELCBCQ1IsDQo+ID4gPiA+IGFuZCBEQ1IgdmFs
dWVzIGFnYWluc3QgdGhlIG9uZXMgcmVnaXN0ZXJlZCBpbiB0aGUgZHJpdmVyOg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gc3RhdGljIGNvbnN0IHN0cnVjdCBpM2NfZGV2aWNlX2lkIHN0X2xzbTZkc3hf
aTNjX2lkc1tdID0gew0KPiA+ID4gPiA+ICAgICAgICAgSTNDX0RFVklDRSgweDAxMDQsIDB4MDA2
QywgKHZvaWQgKilTVF9MU002RFNPX0lEKSwNCj4gPiA+ID4gPiAgICAgICAgIEkzQ19ERVZJQ0Uo
MHgwMTA0LCAweDAwNkIsICh2b2lkICopU1RfTFNNNkRTUl9JRCksDQo+ID4gPiA+ID4gICAgICAg
ICB7IH0NCj4gPiA+ID4gPiB9Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT25seSBpZiB0aGlzIG1h
dGNoaW5nIHN1Y2NlZWRzLCB0aGUgcHJvYmUgd2lsbCBiZSBpbnZva2VkLg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gU2luY2UgdGhlIHNlbnNvciByZXNldCBsb2dpYyBpcyBwbGFjZWQgaW5zaWRlIHRo
ZSBwcm9iZSwgdGhlDQo+ID4gPiA+ID4gZGV2aWNlIG11c3QgYmUgaW4gYQ0KPiA+ID4gPiByZXNw
b25zaXZlIHN0YXRlIGR1cmluZyBlbnVtZXJhdGlvbi4gSW4gdGhlIGNhc2Ugb2Yga2V4ZWMsIHdl
DQo+ID4gPiA+IG9ic2VydmVkIHRoYXQgdGhlIHNlbnNvciBkb2VzIG5vdCByZXNwb25kIGNvcnJl
Y3RseSB1bmxlc3MgaXQgaXMNCj4gPiA+ID4gZXhwbGljaXRseSByZXNldA0KPiA+IGR1cmluZyBz
aHV0ZG93bigpLg0KPiA+ID4gPiBIZW5jZSwgYWRkaW5nIHRoZSByZXNldCBpbiBzaHV0ZG93bigp
IGFkZHJlc3NlcyB0aGlzIHNwZWNpZmljIGNhc2UNCj4gPiA+ID4gd2hlcmUgdGhlIHByb2JlIGlz
bid0IHJlYWNoZWQgZHVlIHRvIGZhaWxlZCBlbnVtZXJhdGlvbi4NCj4gPiA+ID4gPg0KPiA+ID4g
PiBIaSBNYW5pa2FudGEsDQo+ID4gPiA+DQo+ID4gPiA+IER1cmluZyBpM2MgYnVzIGluaXQsIHRo
ZSBDQ0MgUlNUREFBIGlzIGVtaXR0ZWQgdG8gcmVzZXQgYWxsIERBcyBvZg0KPiA+ID4gPiBhbGwg
ZGV2aWNlcyBpbiB0aGUgYnVzIChkcml2ZXJzL2kzYy9tYXN0ZXIuY0BpM2NfbWFzdGVyX2J1c19p
bml0DQo+ID4gPiA+IC0+IGkzY19tYXN0ZXJfcnN0ZGFhX2xvY2tlZCkuIElzIHRoZSBMU002RFNY
IG5vdCBjb21wbGlhbnQgd2l0aCB0aGF0Pw0KPiA+ID4gTFNNNkRTWCBpcyBjb21wbGlhbnQgd2l0
aCBSU1REQUEgQ0NDLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSSBnZXQgeW91ciBzb2x1dGlv
biBidXQgZmluZCBvZGQgdG8gdXNlIHRoZSBzYW1lIG1ldGhvZCBhcyBpbiB0aGUgcHJvYmUuDQo+
ID4gPiA+IEluIHRoZSBwcm9iZSwgeW91IHdvdWxkLCBpbiBnZW5lcmFsLCByZXNldCB0aGUgZGV2
aWNlIGxvZ2ljLCBidXQNCj4gPiA+ID4gbGVhdmUgdGhlIGkzYyBwZXJpcGhlcmFsIGxvZ2ljIGlu
dGFjdCwgYmVjYXVzZSB5b3UgZG9uJ3Qgd2FudCB0bw0KPiA+ID4gPiB1bmRvIHdoYXRldmVyIHRo
ZSBjb250cm9sbGVyIGhhcyBzZXQtdXAgZm9yIHRoZSBjdXJyZW50IGJ1cw0KPiA+ID4gPiBhdHRh
Y2hlZCBkZXZpY2VzIChpYmkgY29uZmlnLCBkYSwgbWF4IGRldmljZXMgc3BlZWQsIGFsbCB0aGUg
Z29vZCBpM2Mgc3R1ZmYpLg0KPiA+ID4gPiBGb3IgdGhpcyBkZXZpY2UsIHRoZSBzdF9sc202ZHN4
X3Jlc2V0X2RldmljZSBzZWVtcyB0byBmbHVzaCBhDQo+ID4gPiA+IEZJRk8sIGRvIGEgc29mdHdh
cmUgcmVzZXQsIGFuZCByZWxvYWQgYSB0cmltbWluZyBwYXJhbWV0ZXI7IHdoaWNoDQo+ID4gPiA+
IGFyZSBuZWNlc3NhcnkgdG8gc29sdmUgdGhlIGJ1ZyB5b3UgYXJlIG9ic2VydmVkPw0KPiA+ID4g
T25seSBzb2Z0d2FyZSByZXNldCBuZWNlc3NhcnkgdG8gc29sdmUgdGhlIGJ1Zy4NCj4gPiA+DQo+
ID4gPiA+DQo+ID4gPiA+IElmIHBvc3NpYmxlLCBwbGVhc2UgZXhwbGFpbiBiZXR0ZXIgd2h5IHRo
ZSBkZXZpY2Ugd29uJ3QgZW51bWVyYXRlDQo+ID4gPiA+IGNvcnJlY3RseSBhZnRlciBhIHJlYm9v
dCB3aXRob3V0IHRoZSByZXNldC4gSWYgaXQgaXMgYSBkZXZpY2UgYnVnLA0KPiA+ID4gPiBleHBs
aWNpdGx5IHN0YXRlIHRoYXQgYW5kIHRoYXQgaXQgaXMgbm90IGNvbXBsaWFudC4gQWxzbywgdGFr
ZSBhDQo+ID4gPiA+IGxvb2sgYXQgZmlnLjEwMCBvZiB0aGUNCj4gPiBpM2Mgc3BlYyBiYXNpYyAx
LjEuMS4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmsgeW91IGZvciBsb29raW5nIGludG8gdGhpcywg
dGhpcyB0eXBlIG9mIGNvcm5lciBjYXNlIGlzIHVzdWFsbHkgb3Zlcmxvb2tlZC4NCj4gPiA+IEl0
IGFwcGVhcnMgdGhhdCB0aGUgc2Vuc29yIGRldmljZSBpcyBlbnRlcmluZyBhIGRlZXAgc2xlZXAg
b3INCj4gPiA+IGxvdy1wb3dlciBzdGF0ZSBhbmQNCj4gPiBpcyBub3QgcmVzcG9uZGluZyB0byBD
Q0MgY29tbWFuZHMuIEhvd2V2ZXIsIGFmdGVyIGEgc29mdHdhcmUgcmVzZXQsDQo+ID4gdGhlIHNl
bnNvciBzdGFydHMgcmVzcG9uZGluZyB0byBDQ0NzIGFzIGV4cGVjdGVkLg0KPiA+IEl0IHNob3Vs
ZCwgZnJvbSB0aGUgc2lsaWNvbiBwb3YsIGRlZmluaXRlbHkgcmVzcG9uZCB0byBDQ0NzLCBldmVu
IG9uIGxvdy1wb3dlcg0KPiBzdGF0ZXMuDQo+ID4gQ291bGQgeW91IGNvbmZpcm0gd2l0aCBzdG0z
MiB0aGUgYmVoYXZpb3VyIHlvdSBhcmUgb2JzZXJ2aW5nPw0KPiA+IEluZm9ybSB0aGVtIGlmIGl0
IG9jY3VycyB1bmRlciB1bmRlciBpMmMvaTNjIGR1YWwgc3VwcG9ydCwgb25seSBpM2MsIG9yIGJv
dGguDQo+ID4gSXQgc291bmRzIGEgbGl0dGxlIHRoZSBtZXNzYWdlcyBhcmUgYmVpbmcgZmlsdGVy
ZWQgYnkgdGhlIHNwaWtlIGZpbHRlciB3aGVuIGl0DQo+IHNob3VsZG4ndD8NCj4gPiA+DQo+ID4g
PiBTaGFsbCB3ZSBwcm9jZWVkIHdpdGggb25seSB0aGUgc29mdHdhcmUgcmVzZXQgY2hhbmdlcyBh
bG9uZyB3aXRoIGFuDQo+ID4gPiBpbXByb3ZlZA0KPiA+IGRlc2NyaXB0aW9uLCBvciBkbyB5b3Ug
cmVjb21tZW5kIGFueSBhZGRpdGlvbmFsIG1vZGlmaWNhdGlvbnM/DQo+ID4gQ29uZmlybSBpZiB0
aGlzIGlzIGEgc2lsaWNvbiBpc3N1ZSBmaXJzdCwgaWYgc28sIGEgbm90ZSBmcm9tIHN0IHNob3Vs
ZCBiZSBpc3N1ZWQgYWxzby4NCj4gV2UgYXJlIHVuYWJsZSB0byB2ZXJpZnkgdGhlIGJlaGF2aW9y
IG9uIGFueSBzaWxpY29uIG90aGVyIHRoYW4gb3Vycy4gSXQgd291bGQgYmUNCj4gaGVscGZ1bCBp
ZiBzb21lb25lIHdpdGggYWNjZXNzIHRvIGEgZGlmZmVyZW50IHNpbGljb24gY291bGQgY29uZmly
bSB0aGlzIGJlaGF2aW9yLg0KPg0KDQpUaGFua3MsDQpNYW5pa2FudGEuDQoNCg==

