Return-Path: <linux-iio+bounces-22106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02CB13CC7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E9C5419BF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CFC26B09F;
	Mon, 28 Jul 2025 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="HHiyHI9c"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C693265CDD;
	Mon, 28 Jul 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711814; cv=fail; b=qZjOkzh9eDqCxEx8NCl3kLd670ifPEixW7Fan6Cfq4cET/t8oI0wqkSWHj0i+71gJgo6h/d8x35pjdnHI1DsBfWCSj+PCO1xCQzdB2H3/kmbAd2F/vEktJ3uoXVwOB/wG2/1ElTtKWTvwFuUswI0DoyvvsW4PkRih5Nm4KayCkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711814; c=relaxed/simple;
	bh=BBF9r5V0Lqx4cHnAFIA39CAaYAsJillhiZVYP9LdZtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CK62AD0lnNZkDHqt7GhHY8l0cTe0vI2Cudlh8dgKT1MpGUslzelLFedcvsOFXT0g071G0Wlbc76VbLUlqtzLg3f5fXYNQ56lenrJLpVBi+iBk82GaXJLqvnzZKFZHpwgPCyKSONknNdKETqe+BeO9967aDha/4BYXi0xsRTJB+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=HHiyHI9c; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a77utbAx9xEv9QrbDs/vb97auznO+803OjOTeqoB1xsLw0mKMGk92mrT5cDg0j3PofeF1fWcYGPe5uIzbtA2LZ7xWtXpXZxrE2MsvfXDbJ4Ykn8jKB3mcyjiGavj7GCCAVKpFTdQBrnzS4G8DmyANSaLW0VxMHaPtahpy9xeSYCv1j9//lbkTKn2CMp2mwfJgdfoWWi9IdXa5dSbkb1kc1tx1easM74ZCTDPT1a05hjaQJOBRxC80ekZqc6AEYi06rc3ElQVqYtGHHPukZdNt6fXDRNLE8CR81DY4R/PkHNrQyt32FGS4I8y0uQquefgLa6x+FvoRzYfWOs2t+FSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku1yn2oWTAoUvctzFCQ7nuucrLmoC8PCJ8hWyAVqXqc=;
 b=jPYJvjdsbGFNh3+UNrm5Lv4PI9Dx3LyuffALyZg1eWZfZZtjU/+eAaizc6+N3nhnsbFahKXvELXhS58Ptvb/YggC56oT/in9ort4yWYh3FtqpdwRiSWSsleFwgo/tqKY70zCiJhDXBzzP0W14N2u49U+PXzK2S3Gp7g8o6XfglaFAwMUJS8N6oeq5tELV7kMGG9CPRLzGwI4N7ujth7iB6HND//dVD8NJBSLlPyYEdtsa6utecS3p3w3tc8yvLWwlYmn3F5zR8PYpb4JftpW9cqi45ge/2ZrCTz8AJ+Dqx5YNvdtJUOnrbaP1i7ENhc5KvvfIR/5HHayG2P6QwE9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku1yn2oWTAoUvctzFCQ7nuucrLmoC8PCJ8hWyAVqXqc=;
 b=HHiyHI9cLOlE0A0kim1x2fSl7co6DcKkxEZW6phIK9nMCVKNeRE3f8uciMs7gFo7aR7lctKfTrEFFg+0AMQii3s3vGFU9QF/lQQ+h1Yu7oU3XUlxDRavp09uSiYFCGKQ9GeK65UGWTukatzUirIyDQFZifdlouUsOT+KbFrjN8OsgyMr2F55SaweQ2zVqtBRqt8DPNMGXCcDRqXsE6lsjP3okhNQ02gyny8TuiWUMQzFv/ZdmXbxILtDra2YJGw5c0ZltiQ0DM0rb4MzQF9qsFptCg7D5tiaIfo/I6+gkP2CTrNgEVrM11+UcqqDWqCX/2UyP6m2dmL/2rGZqWKaLA==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by GV1PR10MB8857.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:10:07 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:10:07 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dima.fedrau@gmail.com" <dima.fedrau@gmail.com>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lorenz
 Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike
 (ME/PJ-SW3)" <Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: AW: [PATCH v3 2/2] iio: imu: smi330: Add driver
Thread-Topic: [PATCH v3 2/2] iio: imu: smi330: Add driver
Thread-Index:
 AQHb7DCnxFfdguezA0CMBsJ2vkpDJrQlVJwAgATVpeCABfU/AIADa+ZQgALjsgCACRRNsIAB/bWAgAYWTeCAABE+AIAADnwQ
Date: Mon, 28 Jul 2025 14:10:07 +0000
Message-ID:
 <AM8PR10MB472114233984CE6270C5D2ADCD5AA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
	<20250703153823.806073-3-Jianping.Shen@de.bosch.com>
	<20250706175328.7207d847@jic23-huawei>
	<AM8PR10MB47217D838CA7DDACBE162D15CD49A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20250713144214.6ee02f59@jic23-huawei>
	<AM8PR10MB4721BAD5BD78B8FD0F5C9798CD57A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20250717150440.5067862b@jic23-huawei>
	<AM8PR10MB4721FB1A78F25B204BE3A26ACD5FA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20250724160759.44d67e88@jic23-huawei>
	<AM8PR10MB472198ADD6F85F71D91DE1F1CD5AA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <20250728140704.2e176f1b@jic23-huawei>
In-Reply-To: <20250728140704.2e176f1b@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|GV1PR10MB8857:EE_
x-ms-office365-filtering-correlation-id: 8122b3ae-b0e0-4926-c39f-08ddcde074f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R8jaepAAQSAwv3UAXmgAdZpfNkKmg0qgVH99pHmSVSAa/5AUK/f8vep4AWDG?=
 =?us-ascii?Q?UMkMuo0tsdzRWhaLm/o+FS55tMkLMmOafhnE2pRlCO7xQYBgRYkFjfwCGwYP?=
 =?us-ascii?Q?2H2C4lJZ4Vj8NN74+tdVPz0OGPDJ0EAfDJYJNSrZV7G4TII+pGalD0Nh3bxU?=
 =?us-ascii?Q?LXtayGz3HgXny7xRYMkVTrnXkrt11Kr+Xjbry5W1RZOe+CgMLs37grsg31q3?=
 =?us-ascii?Q?PafVmV9aSkwHBiljxpsZOtl0CoAxkjh30C4ZbIKfVeZ5v5OpeaWC4G20xHs9?=
 =?us-ascii?Q?LJTU2XR+God2OPoRL0tXCe3Zbhu7hCHY/PyS5I4dXafIu7C09OQlCu2+ulsa?=
 =?us-ascii?Q?aQtRGxL9c4hg0x2hi+l0RvnBFBxZe45lyQ6/X41avXnJHT5AcUzvTk4CO41D?=
 =?us-ascii?Q?KvUPbf6uE8K1PSwDAN7CUyctbQ/MRTfq3hgLwznfiBpVgdgcxW2B697Z8f4c?=
 =?us-ascii?Q?IqD0wLdPYcrMhb6FfEZ+vVKzkXce6dfPqNl37vL+etNnKpv6k19+cLUfdcM+?=
 =?us-ascii?Q?qLdU079VEyyywDGMSl3nb/HzCaBc9nyiDR8bOKj6Ue9a9igfcLIc0UofVoTl?=
 =?us-ascii?Q?Wa/sfPmyQPjdgHfuPzCpSHZ6jI8kiNcvgB1Vq9wmfj8WCMlEvmjsTNuXL0vF?=
 =?us-ascii?Q?lF/Yu1Ml6umAajOqKz0qHeLm4zdFApLAkgZMCOAn2gDMX41wY9yU9ZdLucTE?=
 =?us-ascii?Q?lQLEQYgBgiYDMTPeUpjfhhyIo/PYQqJ7qoZRL8OmheM/zPA5OCL+J++XK+JX?=
 =?us-ascii?Q?wPtEUveF/dYGr7qYlCY0XI03KhcEVsF1WyGx0e7F6+h9a1vuZ1RvvRh+e4K4?=
 =?us-ascii?Q?3AF/zM9tYHOW9ZbTyqVAhtmpbwk425KpVT413uYHmq54gOsaywEpjo3aduWr?=
 =?us-ascii?Q?0i/SJsgX6+v/yir+/4yM4uU1CbER8pxwWlkioasuAoyau27GBDhhRiBpLh9f?=
 =?us-ascii?Q?7GzQiY/CEmQJuWi2MYHzDl4ZYAniSZ+eTRQBciAyxKFXX+Nb22zYwR4btPTU?=
 =?us-ascii?Q?PQlFTqBkYAe0kYFQs1wVyf+kCa6RmcxiiygMI2+UJ6hrliT+FcaCJFfyJVuJ?=
 =?us-ascii?Q?vkITOVyDPr2jHFfhl2Dj2ByTZU+SAJqEd6ilWCBwLSafcpudd2aL20YX2CuL?=
 =?us-ascii?Q?67999MYIUUfmR8epfRzZXGY+xTASBmZNAlJ7JtF9ZI4vmP0KrG8doJ05kWLA?=
 =?us-ascii?Q?gDGjQxaRrszrVDLJ/rC0CCYjDD1ROJ/UGFlXuLqPgBLUJEA4Ec8x4LqKK5TY?=
 =?us-ascii?Q?FyO8M+Ju/TJ1srvewzNxFMCX8Rud3aRqHLO8BFZREdQs2GwYsI+RH6dFL+vD?=
 =?us-ascii?Q?c3x3W+AY3P7rrW3+T2VQnKVkBPvbXfGxO2kZ1h4If+mUtBUHABmwKbMNWqjG?=
 =?us-ascii?Q?0q1Ph6zAY5BeeVDeoKb474CLHLsLa0U7rNfIx+I1aEk68ok1FbeVAgMpeRyr?=
 =?us-ascii?Q?TpxpUwN/W4Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HhCU9MSh4DAZfDwEibTFsGSzsOKctMbJS4/UtWtW005CgmPl7T4pRj3gb/d0?=
 =?us-ascii?Q?pfeeVLPwGmlzXLjlFdW5nxh10e1u7RkTa4/gtXajnMt9OaIDS6QbvRzpFI63?=
 =?us-ascii?Q?HNIs8Jghd+M/DXO9sLDSAsH4YecFNOBCc5os4ytxYUbtJ6HiiXrNp5nEXRdb?=
 =?us-ascii?Q?daO+8o2CEX6IzoWIGN7RCn6pImh5udCB7YG35c+Xoq6HquToT+rvrReg5UpY?=
 =?us-ascii?Q?q5hBk/VZDn6Or5/e/7oVMkEU7Mj8rXQ0zA5u+kmJ+duC2AZhLVLYajgHy6hM?=
 =?us-ascii?Q?cjr8COuv7572vk4GqVpyGfpDaGuBwRgpjuYG7XEn6FOXfmpU/aE3iGZ4qofI?=
 =?us-ascii?Q?XKQeo1mUOSZ8oRVK5XRMGs2CjiNsm5zRJEs00XoU/WGhy4wUkY3+AgVRXvjf?=
 =?us-ascii?Q?/6ChPC8zEch4tSFURovd7KH7+jJOv3Wf/CAE8HFGrnMcnVh0ovefHaFasdGZ?=
 =?us-ascii?Q?lRfdRQh4FCAyCCzNbzG0qcoBgNN+XmsNobvSJA1yMvHYBXFA/vAu+o9AMpZq?=
 =?us-ascii?Q?Ez3zznnFmjGJRzw9ii0kRqofqRC1UiqGq37CZ1h7gg4AuEo7DC9x29zmGm7H?=
 =?us-ascii?Q?LG94z7SA7ygANZ8WF8C0EKm8I+Klim7YBUSe8vsXpskR2i5pvC0R9DHwhNpv?=
 =?us-ascii?Q?icy2PahfmR6rW6HMJUv+WLhlRLkiTNa3dXIx23+k95d8141AxhKBHETmsmed?=
 =?us-ascii?Q?IwbksfOms3TduvClM8OPcL6ztcW7ecdOBQfPqP2GHEXcjXWSRk3zAXuhB9gs?=
 =?us-ascii?Q?3HWhNeHH6twUv3l1tk18Wjt04gawK9ENFvCpLwTJj9+gE7yWVOShyA091Gax?=
 =?us-ascii?Q?NhKDSpMMD55XYOXUR8DaMqGackECr/pmxD8xY/kSuB3M0yGmIE175HmTQwnj?=
 =?us-ascii?Q?pVdCYKpOCBPibu0C2NsbhR8QmMQvCHayVoSr1ABkDPD3K6J62L1uT8SRBi8b?=
 =?us-ascii?Q?eRHK3BE9o3eR02Rz1p01ho9RitDjNjRoB6EBB1pcH2C4YPP3wG+4Fb/P4t9p?=
 =?us-ascii?Q?X9M+cVWopr7wkpF4PHQYSANA80Jtb+/6pb1hkNvGrb8K2PyMUvIfRcy6P+b3?=
 =?us-ascii?Q?gYoRSP6KHHs25T7Bz6CObgbW38cXUe7NvEHQ2v8LBCSDFwI10pfU729pMHsG?=
 =?us-ascii?Q?1zH525w66N4NCMgCo26++HFU2VGllLWaW5EymN3ZVu3hOr6X4QsbZnkCEi43?=
 =?us-ascii?Q?BjrLtb4qayUNHvXknyuuMwHz3F7ieVyBP2xHIMEemznECnXm/ssLjt4azjrD?=
 =?us-ascii?Q?JK8DQNRi8CMs2x2/C2agvVjkqXX7LDEfvBCG6ILqNsoDkt5g3mrAcv+xRmme?=
 =?us-ascii?Q?VKjf95OK+rzn+jqlLp73kZeXILAjouRRIWzhyaLiWsHYL4GLiyrA0c2EzHzA?=
 =?us-ascii?Q?6PleoILtxj28NFI8R7DUMHt9Q1URMlxXlpnGp/vmrEawP8My6X+Z2ppnACsW?=
 =?us-ascii?Q?8l0imWwEiO1BFKHlDioAzEtttcwpUmDqPbBnRFnAdEbaJmwBP+yBT4phfKyP?=
 =?us-ascii?Q?FbUU9ko/pnFw4Kxzhji1SGlyf5qLotrvqJXksdlsnRD++PdG2SYUs/vPus63?=
 =?us-ascii?Q?lUjH+1/GngTTWBrTaMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8122b3ae-b0e0-4926-c39f-08ddcde074f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 14:10:07.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XO4rupayD+I/qcwAOh7EhYrzd0Gdryj6UtW0b31WhWu24Btloze8artlF+COUZ/PY/tIg+4ACU41dV1BGQO8Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8857

Hi Jonathan,

let's take your fix.  You fix is more consistent with the existing code. We=
 already tested on our HW.  Now everything works properly.
When the fix becomes available in "togreg", so that we can continue with ou=
r driver upstreaming.

best Regards
Jianping


>> Hi Jonathan,
>>
>> let's think about a typical IMU, which has 6 2-byte channels (acc x,y,z =
 gyro
>x,y,z)
>>
>> 3 2-byte channel we want, 3 2-byte channels we don't a 4-byte gap and an=
 8-
>byte timestamp struct scan {
>>      u16 wanted[3];
>>      u16 notwanted[3];
>>      ... gap...
>>      aligned_s64 timestamp;
>>
>> Hint: indio_dev->scan_bytes is 24, if we use available_scan_mask with
>> all channels set (ref.
>> https://elix/
>> ir.bootlin.com%2Flinux%2Fv6.15.1%2Fsource%2Fdrivers%2Fiio%2Findustrial
>> io-
>buffer.c%23L975&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7C80
>10a
>>
>2f19e554cacae2b08ddcdd7ad3e%7C0ae51e1907c84e4bbb6d648ee58410f4
>%7C0%7C0
>>
>%7C638893048385267556%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1h
>cGkiOnRydWUs
>>
>IlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3
>D%7
>>
>C0%7C%7C%7C&sdata=3DtkxZ390MWrVRBYHECSugENRULI%2FT8cS%2BUX%2B
>rNNVo6%2F8%
>> 3D&reserved=3D0)
>>
>> Cutting down to the parts that change in_loc only.
>>
>>      for_each_set_bit(out_ind, buffer->scan_mask, masklength) {
>>              in_ind =3D find_next_bit(indio_dev->active_scan_mask,
>>                                     masklength, in_ind + 1);
>>              while (in_ind !=3D out_ind) {
>> ... length is the length of current channel .. We never enter here in th=
e
>example.
>>                      /* Make sure we are aligned */
>>                      in_loc =3D roundup(in_loc, length) + length;
>>
>>                      in_ind =3D find_next_bit(indio_dev->active_scan_mas=
k,
>>                                             masklength, in_ind + 1);
>>              }
>>
>> ... length is the length of the current channel.  Get here on first hit.
>>
>>              in_loc =3D roundup(in_loc, length);
>>
>>              in_loc +=3D length;
>> .. in loc =3D 2 + 2 + 2 =3D 6
>>      }
>>      /* Relies on scan_timestamp being last */
>>      if (buffer->scan_timestamp) {
>>
>> ... length is 8
>>
>>              in_loc =3D roundup(in_loc, length);
>> .. in_loc =3D 8 (should be 16 to match timestamp offset:
>https://elixir.b/
>ootlin.com%2Flinux%2Fv6.15.1%2Fsource%2Finclude%2Flinux%2Fiio%2Fbuff
>er.h%23L37&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7C8010a2f
>19e554cacae2b08ddcdd7ad3e%7C0ae51e1907c84e4bbb6d648ee58410f4%
>7C0%7C0%7C638893048385299918%7CUnknown%7CTWFpbGZsb3d8eyJFb
>XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWF
>pbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DO2F6UcNaE%2BqBUO0T
>%2F6qAe6dEruhkN%2BeVGJzIBbX8Mn0%3D&reserved=3D0)
>>              ret =3D iio_buffer_add_demux(buffer, &p, in_loc, out_loc, l=
ength);
>>
>>      }
>>
>> Best Regards
>Ah. Got it - I foolishly didn't try a big enough example.  Thanks for all =
your work
>chasing this down!  I somewhat surprised we never hit this before :(
>
>Ok, so in that case the fix (to keep in line with existing code approach) =
is to walk
>the gap.  Completely untested, but something like:
>
>diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-=
buffer.c
>index a80f7cc25a27..f58a7ce481f5 100644
>--- a/drivers/iio/industrialio-buffer.c
>+++ b/drivers/iio/industrialio-buffer.c
>@@ -1082,6 +1082,21 @@ static int iio_buffer_update_demux(struct iio_dev
>*indio_dev,
>                out_loc +=3D length;
>                in_loc +=3D length;
>        }
>+       /* Walk remaining bits of active_scan_mask */
>+       in_ind =3D find_next_bit(indio_dev->active_scan_mask, masklength,
>+                              in_ind + 1);
>+       while (in_ind !=3D masklength) {
>+               ret =3D iio_storage_bytes_for_si(indio_dev, in_ind);
>+               if (ret < 0)
>+                       goto error_clear_mux_table;
>+
>+               length =3D ret;
>+               /* Make sure we are aligned */
>+               in_loc =3D roundup(in_loc, length) + length;
>+               in_ind =3D find_next_bit(indio_dev->active_scan_mask,
>+                                      masklength, in_ind + 1);
>+
>+       }
>        /* Relies on scan_timestamp being last */
>        if (buffer->scan_timestamp) {
>                ret =3D iio_storage_bytes_for_timestamp(indio_dev);
>
>Obviously quite a bit more complex than your solution, but consistent with=
 the
>surrounding code.
>
>We could make this more efficient by moving it under the if (buffer-
>>scan_timestamp).
>Could potentially also use a for_each_bit_set_from() but then the code loo=
ks
>quite different to the other cases.
>
>What do you think?
>
>Jonathan
>
>>
>> Jianping Shen
>>
>> >
>> >> Hi Jonathan,
>> >>
>> >> we find out the reason why the timestamp is invalid in the iio buffer=
.
>> >>
>> >> https://e/
>> >>
>lix%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7C8010a2f19e5
>54c
>> >>
>acae2b08ddcdd7ad3e%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C
>0%7C638
>> >>
>893048385320261%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnR
>ydWUsIlY
>> >>
>iOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%
>7
>> >>
>C0%7C%7C%7C&sdata=3DDvB9srb9ft9UZ9sbHqpWWTyAexxKbG93qTajtWhzxN
>o%3D&re
>> >> served=3D0
>> >>
>ir.bootlin.com%2Flinux%2Fv6.15.1%2Fsource%2Fdrivers%2Fiio%2Findustr
>> >> ial
>> >> io-
>>
>>buffer.c%23L1093&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7C
>d
>> >84c
>> >>
>>
>>234178ee4bae6a2a08ddcac3e80a%7C0ae51e1907c84e4bbb6d648ee5841
>0f
>> >4%7C0%7C
>> >>
>>
>>0%7C638889664948004786%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU
>1
>> >hcGkiOnRydWU
>> >>
>>
>>sIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%
>3
>> >D%
>> >>
>>
>>7C0%7C%7C%7C&sdata=3DDAYIrdjPq4RrrvH7tudEjOlAavn%2B2qlpGiRp2UXTh
>2
>> >c%3D&re
>> >> served=3D0
>> >>
>> >> In "iio_buffer_update_demux" to copy the timestamp, the address
>> >> calculation
>> >is the root causes.
>> >>
>> >> 1083  in_loc +=3D length;
>> >> ....
>> >> 1093  in_loc =3D roundup(in_loc, length);
>> >>
>> >> When finish to copy the channel data, in_loc is just incremented
>> >> and used as
>> >address of timestamp. This is correct only when the channel direct
>> >before timestamp is enabled.
>> >>
>> >> If there is a gap between the last enabled channel and timestamp,
>> >> then iio
>> >core will copy the wrong data.
>> >>
>> >> We have a fix to this issue,
>> >>
>> >> 1093 in_loc =3D (indio_dev->scan_bytes / sizeof(int64_t) - 1) *
>> >> length;
>> >
>> >That looks correct, but I'm not seeing why the roundup above doesn't
>> >land us in the same place.  I'm not that keen on handling the
>> >timestamp even more differently to other channels.
>> >
>> >
>> >If we imagine an active scan with
>> >2-byte chanel we want, 2 2-byte channels we don't a 2-byte gap and an
>> >8-byte timestamp struct scan {
>> >    u16 wanted;
>> >    u16 notwanted[2];
>> >    ... gap...
>> >    aligned_s64 timestamp;
>> >
>> >
>> >
>> >Cutting down to the parts that change in_loc only.
>> >
>> >    for_each_set_bit(out_ind, buffer->scan_mask, masklength) {
>> >            in_ind =3D find_next_bit(indio_dev->active_scan_mask,
>> >                                   masklength, in_ind + 1);
>> >            while (in_ind !=3D out_ind) {
>> >... length is the length of current channel .. We never enter here in t=
he
>example.
>> >                    /* Make sure we are aligned */
>> >                    in_loc =3D roundup(in_loc, length) + length;
>> >
>> >                    in_ind =3D find_next_bit(indio_dev->active_scan_mas=
k,
>> >                                           masklength, in_ind + 1);
>> >            }
>> >
>> >... length is the length of the current channel.  Get here on first hit=
.
>> >
>> >            in_loc =3D roundup(in_loc, length);
>> >
>> >            in_loc +=3D length;
>> >.. in loc =3D 2
>> >    }
>> >    /* Relies on scan_timestamp being last */
>> >    if (buffer->scan_timestamp) {
>> >
>> >... length is 8 ...
>> >
>> >            in_loc =3D roundup(in_loc, length);
>> >.. I think in_lock =3D 8?
>> >            ret =3D iio_buffer_add_demux(buffer, &p, in_loc, out_loc, l=
ength);
>> >
>> >    }
>> >
>> >Perhaps you can talk through the example that is failing?
>> >
>> >>
>> >> just not sure, if there will be any side-effects with this fix.
>> >>
>> >> Are you going to fix this finding, or shall we create a new patch for=
 that?
>> >
>> >Fine to send the proposed fix but first we need to step through why
>> >the current code isn't working.
>> >
>> >
>> >Thanks,
>> >
>> >Jonathan
>> >
>> >>
>> >> Best regards
>> >> Jianping Shen
>> >>
>> >>
>> >> >>
>> >> >> >>
>> >> >> >> >> +
>> >> >> >> >> +static irqreturn_t smi330_trigger_handler(int irq, void *p)=
 {
>> >> >> >> >> +      struct iio_poll_func *pf =3D p;
>> >> >> >> >> +      struct iio_dev *indio_dev =3D pf->indio_dev;
>> >> >> >> >> +      struct smi330_data *data =3D iio_priv(indio_dev);
>> >> >> >> >> +      int ret, chan;
>> >> >> >> >> +      int i =3D 0;
>> >> >> >> >> +
>> >> >> >> >> +      ret =3D regmap_bulk_read(data->regmap,
>> >> >SMI330_ACCEL_X_REG, data-
>> >> >> >> >>buf,
>> >> >> >> >> +                             ARRAY_SIZE(smi330_channels));
>> >> >> >> >> +      if (ret)
>> >> >> >> >> +              goto out;
>> >> >> >> >> +
>> >> >> >> >> +      if (*indio_dev->active_scan_mask !=3D
>> >> >> >> >> + SMI330_ALL_CHAN_MSK)
>> >> >{
>> >> >> >> >> +              iio_for_each_active_channel(indio_dev, chan)
>> >> >> >> >> +                      data->buf[i++] =3D data->buf[chan];
>> >> >> >> >
>> >> >> >> >If I follow this correctly you are reading all the channels
>> >> >> >> >and just copying out the ones you want.  Just let the IIO
>> >> >> >> >core do that for you by setting iio_dev-
>> >> >> >> >>available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 }; and
>> >> >> >> >>push the whole
>> >> >> >> >buffer every time.
>> >> >> >>
>> >> >> >> For the most frequent use cases, we define
>> >> >> >> available_scan_masks =3D {
>> >> >> >SMI330_ALL_CHAN_MSK, SMI330_ACC_XYZ_MSK,
>> >> >SMI330_GYRO_XYZ_MSK,
>> >> >> >0 }; and push the whole buffer every time.
>> >> >> >> From the user space we just enable 3 channels gyro_x, gyro_y,
>> >> >> >> and
>> >gyro_z.
>> >> >> >Then we enable buffer and expect that only the gyro values and
>> >> >> >timestamp in iio_buffer. Nevertheless, we have 3 accelerometer
>> >> >> >values and the timestamp in iio_buffer.
>> >> >> >
>> >> >> >> It seems that the iio core does not take care which channel
>> >> >> >> is enabled,  just
>> >> >> >copy the first 3 values (acc x,y,z) into iio_buffer.  Our
>> >> >> >driver code still needs to take care and just copy the enabled
>> >> >> >channel value to
>> >buffer.
>> >> >> >
>> >> >> >Look again at how it works.  If you provide ACC_XYZ_MSK, then
>> >> >> >your driver has to handle it.
>> >> >> >available_scan_masks is saying what your driver supports. The
>> >> >> >driver can check active_scan_mask to find out what is enabled.
>> >> >> >So right option here is only { SMI330_ALL_CHAN_MSK, 0, }  In
>> >> >> >that case the driver never needs to check as there is only one op=
tion.
>> >> >> >
>> >> >> >Then if any subset of channels is enabled the IIO core copy out
>> >> >> >just the data that is relevant.
>> >> >> >
>> >> >> >
>> >> >> >>
>> >> >> >> Another side effect after using available_scan_masks is that
>> >> >> >> the
>> >> >> >active_scan_masks sometimes does not reflect current channel
>> >> >> >activation status.
>> >> >> >>
>> >> >> >> Is some step missing to properly use available_scan_masks ?
>> >> >> >> How can a user
>> >> >> >find out from user space which channel combination is defined
>> >> >> >in available_scan_masks ?
>> >> >> >
>> >> >> >Why would userspace want to?  Userspace requested a subset of
>> >> >> >channels and it gets that subset.  So it if asks for the
>> >> >> >channels that make up SMI330_ACC_XYZ_MSK, if
>> >> >> >available_scan_mask =3D=3D { SMI330_ALL_CHAN_MSK,
>> >> >> >0 } then the IIO core handling selects SMI330_ALL_CHAN_MSK
>> >> >> >(smallest available mask that is superset of what we asked for)
>> >> >> >and sets active_scan_mask to that.  The driver follows what
>> >> >> >active_scan_mask specifies and passes all channel data via the
>> >> >> >iio_push_to_buffers*() call. The demux in the IIO core than
>> >> >> >takes that 'scan' and repacks it so that userspace receives
>> >> >> >just the data it asked for formatting exactly as the driver
>> >> >> >would have done it if you had handled each channels
>> >> >separately in the driver.
>> >> >> >
>> >> >>
>> >> >> Set available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 } and push
>> >> >>the whole buffer. iio_push_to_buffers_with_timestamp (indio_dev,
>> >> >>data->buf, pf- timestamp); We enable the accX, accY, and accZ
>> >> >>data->from
>> >> >>userspace. And expect 3
>> >> >acc values and the timestamp in iio buffer.
>> >> >>
>> >> >> Raw iio buffer data:
>> >> >> 00000000: 3c00 d6ff 7510 0000 6100 f3ff 0000 0000  <...u...a......=
.
>> >> >            ACCX ACCY ACCZ PAD_ TIMESTAMP__________
>> >> >                               4093587712
>> >> >> 00000010: 3f00 d2ff 8910 0000 0300 f6ff 0000 0000  ?..............=
.
>> >> >                               4143907584
>> >> >> 00000020: 4900 dcff 7a10 0000 caff 0100 0000 0000  I...z..........=
.
>> >> >                               So this one looks bad.
>> >> >
>> >> >> 00000030: 4c00 d9ff 7910 0000 2f00 f8ff 0000 0000  L...y.../......=
.
>> >> >                               4177473280
>> >> >
>> >> >> 00000040: 4b00 d9ff 8410 0000 1f00 0800 0000 0000  K..............=
.
>> >> >                               also bad.
>> >> >> 00000050: 4700 daff 7f10 0000 3b00 eeff 0000 0000  G.......;......=
.
>> >> >> 00000060: 3f00 d8ff 8410 0000 0c00 0900 0000 0000  ?..............=
.
>> >> >> 00000070: 4600 d9ff 8010 0000 0e00 0800 0000 0000  F..............=
.
>> >> >> 00000080: 4700 d7ff 7d10 0000 3400 feff 0000 0000  G...}...4......=
.
>> >> >> 00000090: 4b00 d4ff 8010 0000 3e00 1200 0000 0000  K.......>......=
.
>> >> >> 000000a0: 4600 d6ff 8d10 0000 4300 0000 0000 0000  F.......C......=
.
>> >> >> 000000b0: 4900 d6ff 7710 0000 2500 f0ff 0000 0000  I...w...%......=
.
>> >> >>
>> >> >> Converted value
>> >> >I guess this is different data as doesn't seem to line up with the a=
bove?
>> >> >
>> >> >> 0.015625 -0.009277 1.024411 589929
>> >> >> 0.015869 -0.009521 1.040769 4294901719
>> >> >> 0.020508 -0.008301 1.025632 458712
>> >> >> 0.018799 -0.006836 1.032956 851960
>> >> >> 0.019287 -0.009521 1.033201 4294836275
>> >> >> 0.015625 -0.010498 1.031003 4293328982
>> >> >> 0.015137 -0.010498 1.031980 4293853176
>> >> >> 0.015869 -0.009521 1.031492 4293722141
>> >> >> 0.018555 -0.011475 1.033445 4294311886
>> >> >>
>> >> >> The 3 acc values is correct in buffer.  Nevertheless, invalid
>> >> >> timestamp. The
>> >> >timestamp is actually the value of the gyroscope, which directly
>> >> >followed by acc values.
>> >> >> If we enable the gyroX, gyroY, and gyroZ from userspace, then
>> >> >> all the data is
>> >> >correct. Since the gyro values are the last 3 values and flowed by
>timestamp.
>> >> >
>> >> >Ok. That's odd and we should debug that.  This code is used in a
>> >> >lot of drivers so if it is not working correctly we need to figure
>> >> >out why asap and
>> >fix it.
>> >> >
>> >>
>> >>
>> >>
>> >>
>> >> >However, I'm not seeing what looks to be gyro data in bytes 8-15
>> >> >etc It isn't the stable sequence we'd expect for a timestamp
>> >> >though some specific values might be plausible.
>> >> >
>> >> >Looking again at the code, the IIO_DECLARE_BUFFER_WITH_TS() is the
>> >> >wrong size.  That should not include channel space for the timestamp=
.
>> >> >That should make it too big though which shouldn't be a problem.
>> >> >Also wrong type - should be using __le16 not s16 for the buffer
>> >> >elements given your channel declarations.
>> >> >
>> >> >Please could you add a print to your code alongside the
>> >> >iio_push_buffer_with_timestamp() to verify that the value in the
>> >> >pf-
>> >> >>timestamp is reasonable looking for a timestamp.
>> >> >
>> >> >For reference this is the code that handles the timestamp entry
>> >> >creation in the demux tables.
>> >> >https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
>> >>
>>eli%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7C8010a2f19e
>554
>> >>
>>cacae2b08ddcdd7ad3e%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7
>C0%7C6
>> >>
>>38893048385340779%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGki
>OnRydWUs
>> >>
>>IlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%
>> >>
>>3D%7C0%7C%7C%7C&sdata=3D517Jq7JnKUifmv8GPLa8Inc1HJLkKCSdu9c%2F
>einjQi
>> >> >o%3D&reserved=3D0
>> >>
>>
>>>xir.b%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7Cd84c234
>1
>> >78ee4b
>> >>
>>
>>>ae6a2a08ddcac3e80a%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7
>C
>> >0%7C63888
>> >>
>>
>>>9664948038159%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnR
>y
>> >dWUsIlYiOiI
>> >>
>>
>>>wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7
>> >C0%7C%
>> >>
>>
>>>7C%7C&sdata=3D7kNAXwi9fkp5XocdJ2K5W2Cp9%2BQW4Wq6GLr5reGqies%
>3
>> >D&reserved
>> >> >=3D0
>> >>
>>
>>>ootlin.com%2Flinux%2Fv6.15.1%2Fsource%2Fdrivers%2Fiio%2Findustrialio
>> >>-
>> >>
>>
>>>buffer.c%23L1086&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7C
>f
>> >0
>> >>
>>
>>>9eaf03f8e44dd1e6fe08ddc53ae596%7C0ae51e1907c84e4bbb6d648ee58
>4
>> >1
>> >>
>>
>>>0f4%7C0%7C0%7C638883578931715207%7CUnknown%7CTWFpbGZsb3
>d
>> >8
>> >>
>>
>>>eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
>OI
>> >j
>> >>
>>
>>>oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Ds53tTw6o%2F2g
>u
>> >A
>> >> >iH3J9jBRd0%2Bj6UmcmgyhtBCuKK1HE0%3D&reserved=3D0
>> >> >
>> >> >Jonathan
>> >> >
>> >> >
>> >> >>
>> >> >> Conclusion: Setting available_scan_masks =3D {
>> >> >> SMI330_ALL_CHAN_MSK,
>> >> >> 0 },
>> >> >the iio core is able to correct handle the enabled channel data,
>> >> >but not the timestamp.
>> >> >> The working solution for now is that our driver takes care and
>> >> >> just copys the
>> >> >enabled channel value to buffer without using available_scan_masks.
>> >> >>
>> >> >> >So the aim is that userspace never knows anything about this.
>> >> >> >Just set what channels you want and get that data.
>> >> >> >
>> >> >> >Jonathan
>> >> >> >
>> >> >> >
>> >> >> >>
>> >> >> >> >
>> >> >> >> >The handling the core code is reasonably sophisticated and
>> >> >> >> >will use bulk copying where appropriate.
>> >> >> >> >
>> >> >> >> >If there is a strong reason to not use that, add a comment
>> >> >> >> >here so we don't have anyone 'fix' this code in future.
>> >> >> >> >
>> >> >> >> >> +      }
>> >> >> >> >> +
>> >> >> >> >> +      iio_push_to_buffers_with_timestamp(indio_dev,
>> >> >> >> >> + data->buf,
>> >> >> >> >> +pf->timestamp);
>> >> >> >> >> +
>> >> >> >> >> +out:
>> >> >> >> >> +      iio_trigger_notify_done(indio_dev->trig);
>> >> >> >> >> +
>> >> >> >> >> +      return IRQ_HANDLED; }
>> >> >> >>
>> >> >>
>> >>
>> >>
>>
>>


