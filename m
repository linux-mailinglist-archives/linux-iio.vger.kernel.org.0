Return-Path: <linux-iio+bounces-5450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE98D3A33
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29141F2886C
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77E17F368;
	Wed, 29 May 2024 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PzzwPbDK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34F17B4FD;
	Wed, 29 May 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994902; cv=fail; b=IhAiGJgRbY0F3NRHUBSwVC/C0AEx7MrP5fW82dNVdAFkewurkIg8nRWLI6W0bDgIG8Ps7kwyirzvCaBL50KB9XvV2s2KdNp6tJZk2sl4OVAmZSBhq4d+oG3sduE6sJAxMSBe7+d0EEpt56l47bg9IhBpdTXD2jxWnnl5XOs520Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994902; c=relaxed/simple;
	bh=l43uUy4lL38jQUgiK8lFhom1JOd4nl4XBj266kG+Geo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYEXb9uAnHCaGjBhnG7ltBgRT3XHANGyx7FKb25H8geV63tzhXxaJ9x8b392o1TMO8m0U9Tl80yYZezxhEU/9k9JPLL1Rqlrjyk3aoTqyBlu88gKUk9zoBZOvzLpYF9lDPfPMBPafr12ayQg2UmBzulGqNV2HXFdAUYP6DTTeHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PzzwPbDK; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TCdOZF016234;
	Wed, 29 May 2024 11:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QvuYJ
	ETYxxPkzEiecl8CG8W0Rp2CA/Ajkyy46sphypM=; b=PzzwPbDKBSDLqS6ucmuPO
	do8VeIqyrGhNsAoEnJGM5Beg+Rk/oJQkGq/C6zTJx+JlqWsXsx/y/vNIUNGTzz0I
	0n+a5k+TY7PoPBuy0xVVtL6aD/+DndL32wiKKZzMweRhDPI+4Z0rMOA1tJ3WVfvh
	KDdRLzlewlMSwQV9KIHv/36dsJV8n0Av1TECpkrZ8cEhEMY8IjCmjs/ia4w8awKV
	Hlp1c1ky2uD85VY20Yi2jqOc7rlDMcL5xwMvDSO6n6guMssAAvRCEggxj3dWLrqY
	eWDT4hJuEO5llpvRLOHHKEa6WaV59KZwnsGo4Pq/WZbWlJACLw4efszzZEKeWI0Y
	Q==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ybvu24bck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 11:01:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQhQ1Xu760O0skcUIGycZJIKeThKWRrhFsIqZXnplchTQFFdGaU0qZbB1ai4Gwkhne3vBvhTLlYMZ+jdn1yegND+QiD1xxLQ/jYKdA09Z+lsDQYU8A1T/TPJshLApnuZG2d6ue76uTOtdz3KcbDOD5i9ZibbXRYq61/uK+LeYi/JslXYpbBLoFfFc+Qeb8SfCEfxojR+XuUlPsNgMFRFcYIGID79rAjMjDniTtYYPT6L+nx2KYc9mXG3lhXfGXKfWnx4t2Qv/UiEmOjJjd9eKsFQXwHaltThUmQaqp9+0DlBNcY1jXa8EYs1GjYCwqsEkS4yS/AgePa5OFgKQNFQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvuYJETYxxPkzEiecl8CG8W0Rp2CA/Ajkyy46sphypM=;
 b=cuz2264Xmdxhws3bFxJmJfLiVP+O1Vd3XMlQFmOWYIFT0kfSIB71P7zCmZFfk2qk1E8l3rkihjo8BJbON2kGosusAkd3pZrw8lJn0xZsAGWMBwpuaKgT5y//e99csyYTdAAWggYo4k+GXnWRLmoxV2blWao178aW06HQ9LnEOe1t1aK9SkWSYdlSwWAWarvlKDLe3UMz204zMfV7omhWuLtnEdPjnGktFfE2TnQJ9wMPUzPmSUBSfHUgjzefI1/W5XnxC6F0/eT7hLaWf6yhgnrpdjZqTY/A5OnVpzvsvKWCXXw6GieTncz1QbFUPnMX6PP19i22els2IKF8qGwwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB4320.namprd03.prod.outlook.com (2603:10b6:805:fd::16)
 by SN7PR03MB7086.namprd03.prod.outlook.com (2603:10b6:806:354::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Wed, 29 May
 2024 15:01:06 +0000
Received: from SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f]) by SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 15:01:06 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        Marius
 Cristea <marius.cristea@microchip.com>,
        "Schmitt, Marcelo"
	<Marcelo.Schmitt@analog.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Ivan
 Mikhaylov <fr0st61te@gmail.com>,
        Marcus Folkesson
	<marcus.folkesson@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: iio: adc: add support for ad777x family
Thread-Topic: [PATCH] drivers: iio: adc: add support for ad777x family
Thread-Index: AQHarD+43ERipWM1gkKh9ZW8mJCjp7GjTUqAgAsEBnA=
Date: Wed, 29 May 2024 15:01:06 +0000
Message-ID: 
 <SN6PR03MB432071701D6A19C3B4C0C33FF3F22@SN6PR03MB4320.namprd03.prod.outlook.com>
References: <20240522120005.18197-1-ramona.nechita@analog.com>
 <Zk3-qxCb0zfR440Q@smile.fi.intel.com>
In-Reply-To: <Zk3-qxCb0zfR440Q@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccm5lY2hpdGFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy00NDk4ZTRjZS0xZGNjLTExZWYtYmIwYy0wMGUw?=
 =?us-ascii?Q?MjIzZWY3NGRcYW1lLXRlc3RcNDQ5OGU0ZDAtMWRjYy0xMWVmLWJiMGMtMDBl?=
 =?us-ascii?Q?MDIyM2VmNzRkYm9keS50eHQiIHN6PSI3NTk2IiB0PSIxMzM2MTQ2ODQ2NDM2?=
 =?us-ascii?Q?OTk3OTQiIGg9ImcrRFdKVUV1K1RNZkk0TFB1K2hjb0tzVDdHST0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QlNyUFlHMmJIYUFTcmVyREdPVEU5V0t0NnNNWTVNVDFZREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBM0xoU2ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4320:EE_|SN7PR03MB7086:EE_
x-ms-office365-filtering-correlation-id: c8f38b10-4293-4ba3-43df-08dc7ff02abd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?jyVhrVj2EdDBpdxW7QbhJ/t4jOL6dQAQENCJqWT65R5Yp1XtG6bXN/cyaJL3?=
 =?us-ascii?Q?nSG6PEO9klvApm3eDWKZYSE0NjWdjwUyn/YyDSkntKgx6fyMervJPV862CoU?=
 =?us-ascii?Q?/nQGpwwUZDYuugFE7x7ilRLNYorvmUWddBtXcL2uz5kK0JUkPzO9vs4YZNjB?=
 =?us-ascii?Q?B/mEGUzBfI23jTpPVAlb4HQInF0RyPbSP85KP70O52aV4gMo+cOR6fnEWjhH?=
 =?us-ascii?Q?Ase1YSCPaut+aNVaqGuU8IKkMJZiIMAmJR9j2LUBlLFJwqsJRkwT099WUpfa?=
 =?us-ascii?Q?T5WuOAQ5Kg1WhaszBjdX1yDiAZxyAD72hWYMRnoOI4WikLK70Bz3BNBVQ1N6?=
 =?us-ascii?Q?oL4H3z7SHia/sR2YcgL7Y3BaeJa3L3dav+pHXZzjqBsw6HFw9AVqgUpcsX+5?=
 =?us-ascii?Q?ydbdU6J58CbWekV7arSbprzWx8g5i+HrlkUcHL8lFanvIDkMkUnzwqM4b1/j?=
 =?us-ascii?Q?KCustb6nGOIpZhNGA+FqiOFEsKowgMKfQaqKRul5ngmrBYFyF0hRQGRSSUIG?=
 =?us-ascii?Q?YAFoD38MmF6CperD20rbRttObWMn1bOtFMAscA0ET5qu1n+faakc6f+C44ZW?=
 =?us-ascii?Q?B3C/x+FaohMgLD8W1azQde1ggFwpwhLIE0AnooPhzn1F+v1yXRhOnLGG0EZ/?=
 =?us-ascii?Q?ZyPFXGupEa5dn5t+j+RfLV83PbXZEvVgChkGWLMSop3xNhlO50y8m5yS4+RL?=
 =?us-ascii?Q?eKiQPvNAtW/AKagza7giSXpZvk/LYiQKJkcKNmBd5jTJUqzunCiIQeO9W9fW?=
 =?us-ascii?Q?S4ASQ6H60xOZs1r1sVAPPVyMYnnou4PCWaTmRmvEknBUNg2v/kVdXK/LnD21?=
 =?us-ascii?Q?oBq5uozM6iNZ1ykgxGiwkCw/+LDM2stbY2uOakaaDFFClBItCrIKFYYv2abE?=
 =?us-ascii?Q?dbGPruAnPyH2Cm2lStDq2Dnw5B98LrvJ+MfuYWUQDrFVpZ9CgRc4jMWBpIWh?=
 =?us-ascii?Q?PuZ40b74yf8xOUMAF2F4MOO2u9jGbE94fhbwQO6rLbJSwRu0WKxzEspRodHL?=
 =?us-ascii?Q?QFTBRDqVPam8KKZqEOlQVrxGPN5kVPOLFKZpTElEa2iXc62teoxqTK3PRrde?=
 =?us-ascii?Q?JyfX7JIwORbdvo3MHwlLMahElGI6tpmtDnnKS+ymmm9v4dV7BEsOlobhqAAN?=
 =?us-ascii?Q?V7LPaEEdx/XyP3Q4L8IG4SQWYgTMSQ98lZiQRr6VgvKNvWURrMTAwOQ4ADGI?=
 =?us-ascii?Q?vikQ5TGlvTzElrlXbj9gqjb7oQ0O/TS3Rz3Xv/CO/Jgz4IGSecCJ07a8Aa/e?=
 =?us-ascii?Q?3aVUPNLSE4Q3565kVCRjpSc8fjz0bmEKINdWqyrxkFIJBY4LzOU7uURT0Hpm?=
 =?us-ascii?Q?2xxoPPXpbE05yRMnQfc8TbWWw1PIxzcyoIgm/F3FT1mUKg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB4320.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?gV1CUSwNN6z3xLCbQJxC2WkqWTxhCBvcMAjpKf3Ht5dFj4XcF/u4mUW+2ZRH?=
 =?us-ascii?Q?qUlAjbT6RRkMTqs46HapZOr9c75oudqyQCxEmzc4JimCGxYAmMbCv7vt7lPb?=
 =?us-ascii?Q?zONxym+cdZXy2PBozjzWbhYKpS9Ch0Q2j1MHTQgOHV5A3OK87lOIzyuUquhf?=
 =?us-ascii?Q?uCrXkQkC+OJ23Z0kFxepAB0I7yt8IHnY+FBlpwNjaHfDvJYgESLmWuoPV+7s?=
 =?us-ascii?Q?71+KCRBqXpFy2UnQjN/Uj4nzy8kYPBtt7aKaLtB2Lf270qALZhRMvjA3RzPa?=
 =?us-ascii?Q?Y/MJ18wR3QC0pnv15y3EkXvtRpg7apBuzbDB4RfAj9CX01L/0OGKGfd/Usdw?=
 =?us-ascii?Q?qECEbmKPxYS+UnuEo1F7UbGCopG/BPOKE/bK4QpOg956RiqNXuCM+qA+9pge?=
 =?us-ascii?Q?jOycPyg13Dd4GmqSYj84Ag88raqz2i2BIxHGZ5ARhSysHVn0nCpw/Nt1VD9O?=
 =?us-ascii?Q?Vh051nr42zSA4mbiF46BWhHBo7megxSZDmkVDitwcxWMHJV3uL2DZVO2iBNT?=
 =?us-ascii?Q?VV7ljaOIHgfE22arP9/L9ptiikL3pxQJo45mw6dfFz9oGLNxuU4MXmH2RTa9?=
 =?us-ascii?Q?MWFTpL9emwt5pvbxVFAlazZQIFOUqXggM4IrvCsdQcV0bbkCJvsbDgSaTD6V?=
 =?us-ascii?Q?qKefULvKkKLJZWqtUYmryOK3NV8QaFvFsf+ykn2vDmZ7B8IwYBzEWnRN0nQP?=
 =?us-ascii?Q?OmGTvqO3Usar23OwlRDmUGbAGJmX8s1Q/DbHURS+CK1T2JoaDi2lZsvYCLe/?=
 =?us-ascii?Q?7q64h5kMTy90QNr94x3oZzzZ5+k7SXjMUDSgJ49LuAhqDoT5c7kZ9kosurRG?=
 =?us-ascii?Q?FF9h1h4fA+lv58YK1dQMPP/QTkafDhkZCwrskIRIUTkNcA6q33XHzKsl2Kj5?=
 =?us-ascii?Q?SQFoLpKMOiTOWr2QOk5FNV6jskiOCdElkeuu07FIRes0NbMO/7sQN4XkeaYq?=
 =?us-ascii?Q?sCQC+D7HMfw/25rgpLOBul+yP0ADx58mBbN02tBZNraZtnwkY/WsfgtYSYSe?=
 =?us-ascii?Q?L7kwcTyXoUZrB3+T7n/kz5yD5xS4NBc0n03tW4JeHZv6dVvpR1uNcW4g+8wl?=
 =?us-ascii?Q?lMNsgLyLvo/cbGkvIgbQE3iVpykuQ089DxWGAlP83gGphd2yQfuK/eKbLrJi?=
 =?us-ascii?Q?fwJquj2VAwgXYf2uLdkUNJHF2l7LE5wxNUEdJxgoqAe5dgsfpsSXzoZihGmx?=
 =?us-ascii?Q?JgJw+MrjbcLmoQVCu68hg7ImZNTbmKtNshpl5eqvJ4Rp3Ugzn+fJyNDLzFZ8?=
 =?us-ascii?Q?M3dEfzHMoQjXr5jta4psci7C+x+4RX1XKkTfzXEqoABE+HbCZGSDo6PXHeWd?=
 =?us-ascii?Q?cEI76Mp1F2OAbym9fdLkAUhqYRkDtR3A0Bw/CE2boeGmNp7DRMTazdrn81bq?=
 =?us-ascii?Q?RBhY2XA6KketlTAw5r6JEolArsn1YBIHGqTwROIaf+4WUaeIZTB5yNp7+SXh?=
 =?us-ascii?Q?ytZZ7m4lzovje1LT7dvKIuj0RAPwnvNgMFtJzhcs0cqCWwI8vQA77omrfA2b?=
 =?us-ascii?Q?rEHswhz5H7Btvg/kyx9jt3dFY7/kLaA+Odyx+FE7TtCXQ3yvd1NESoL0C2/k?=
 =?us-ascii?Q?irVybltmNmMlvMxC8AF8PZrK0Hk+/eIJcvy0Agf3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f38b10-4293-4ba3-43df-08dc7ff02abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 15:01:06.5176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA1eQwo0jno8HbPd8ZkpZknhQO72t/mpr2ywYeLtOQvlzQYUeJjvhqKjOjxu8tTV8NKrCbeRkMq61X4AJzx4YyUMfQwzakczntRx2Q77OV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7086
X-Proofpoint-GUID: 2OwRLKIVvF017WC59Bnsj78Dj_JpLaSE
X-Proofpoint-ORIG-GUID: 2OwRLKIVvF017WC59Bnsj78Dj_JpLaSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_11,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405290103

Hello,=20

Thank you for the review. I implemented most of your comments, excepting so=
me things that were slightly unclear to me or I had a different explanation=
. I left a couple of comments below, and I will send a new patch in a separ=
ate email.

>On Wed, May 22, 2024 at 02:59:53PM +0300, ranechita wrote:
>> Added support for ad7770,ad7771,ad7779 ADCs. The data is streamed only=20
>> on the spi-mode, without using the data lines.
>
>> ---
>
>Please, explain here, in the comment area, why any existing driver can not=
 be reused (extended) for these ADCs.
>
>...
>
>> +#include <linux/gpio.h>
>
>This header must not be in the new code.
>
>...
>
>> +#define AD777X_SINC3_MAXFREQ			16000
>> +#define AD777X_SINC5_MAXFREQ			128000
>
>HZ_PER_KHZ ? You will need units.h.
>
>...
>
>> +#define DEC3					1000
>> +#define DEC6					1000000
>
>NIH some of units.h constants. Use them.
>
>...
>
>
>> +	/*
>> +	 * DMA (thus cache coherency maintenance) requires the
>> +	 * transfer buffers to live in their own cache lines.
>> +	 */
>> +	u8			reg_rx_buf[3] ____cacheline_aligned;
>> +	u8			reg_tx_buf[3];
>
>> +	u8			spidata_rx[32];
>> +	u8			spidata_tx[32];
>
>These will not be cache aligned. Is it a problem?

No, it should be fine without the alignment.

> ------
>
>> +{
>> +	int ret;
>> +	u8 regval, data;
>> +
>> +	ret =3D ad777x_spi_read(st, reg, &data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regval =3D data;
>> +	regval &=3D ~mask;
>> +	regval |=3D val;
>> +
>> +	if (regval !=3D data) {
>> +		ret =3D ad777x_spi_write(st, reg, regval);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>
>This all can be written as
>
>	if (regval !=3D data)
>		return ad777x_spi_write(st, reg, regval);
>
>	return 0;
>
>...or...
>
>	if (regval =3D=3D data)
>		return 0;
>
>	return ad777x_spi_write(st, reg, regval);
>
>(I prefer the latter as it shows better the flow)
>
>> +}
>
>No mutex no nothing for RMW op like this?
>
>Btw, can't you use regmap for IO?

Unfortunately, I don't think regmap could be used, because of the crc and t=
he fact that data is shifted out on the SPI SDO line in the interrupt. I co=
nsider perhaps adding regmap to the mix might complicate things a bit.=20

>
>...
>
>> +	if (st->filter_enabled =3D=3D AD777X_SINC3 &&
>> +	    sampling_freq > AD777X_SINC3_MAXFREQ) {
>> +		return -EINVAL;
>> +	} else if (st->filter_enabled =3D=3D AD777X_SINC5 &&
>
>Redundant 'else'
>
>> +		   sampling_freq > AD777X_SINC5_MAXFREQ) {
>
>Broken indentation.
>
>> +		return -EINVAL;
>> +	}
>
>Unneeded {}.
>
>...
>
>> +	ret =3D ad777x_spi_write(st, AD777X_REG_SRC_N_LSB, lsb);
>> +	if (ret)
>> +		return ret;
>> +	ret =3D ad777x_spi_write(st, AD777X_REG_SRC_N_MSB, msb);
>> +	if (ret)
>> +		return ret;
>
>Can you use 16-bit writes?
>Same Q to all similar LSB/MSB write groups.

I cannot do 16-bit writes due to how the spi functions on the chip and beca=
use the registers for MSB/LSB are at different addresses.

>--------
>> +static void ad777x_clk_disable(void *data) {
>> +	clk_disable_unprepare(data);
>> +}
>
>See below.
>
>...
>
>> +	st->mclk =3D devm_clk_get(&spi->dev, "mclk");
>> +	if (IS_ERR(st->mclk))
>> +		return PTR_ERR(st->mclk);
>> +
>> +	ret =3D clk_prepare_enable(st->mclk);
>> +	if (ret < 0)
>> +		return ret;
>
>> +	ret =3D devm_add_action_or_reset(&spi->dev,
>> +				       ad777x_clk_disable,
>> +				       st->mclk);
>> +	if (ret)
>> +		return ret;
>
>So, what's wrong with the _enabled() API?

Sorry, I am not sure what you mean here by _enabled() API, is there a diffe=
rent mechanism that can be used for this type of operations?

Best Regards,
Ramona=20

