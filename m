Return-Path: <linux-iio+bounces-20892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3AEAE371D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 09:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB78168AFC
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 07:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAC61F4C8A;
	Mon, 23 Jun 2025 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="jesn+3Mb"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6414D2A0;
	Mon, 23 Jun 2025 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664280; cv=fail; b=CB1oQClTIDuGkbjGhMCHGRbAjB1CeGkx2aeMUgbCuvWCk4ASltDDCYiJF6D3QZjHvPjsop6oP5oH3+M2q2t+8wk0wG1nMXMw0oY6lXslP6ih2M4kAYyhYZmXJ0rt3nepbJkvu7mDDYmNVBGckcHnyByThUEI3Y7mnnbelVbqyF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664280; c=relaxed/simple;
	bh=MRPI2mFA8J2mcFizVcH79NBVNVTV6vx7qocbXaIAixc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6vH/7q1iPrOwXx8w5qEke36Quq3pKhsXMjNNOTLK+/azgc0er8HHvciDGjV1YgKnFGqsXU+3Zk5wxtweSweJy4GjwGw3YEpNKgL0Iw8yMlIk4tWM/P8arqay66qsoAF5XFpksNnt1FoQJ1KsHLrZFsQxdjnvYjUe+LIXgI/SOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=in.bosch.com; spf=pass smtp.mailfrom=in.bosch.com; dkim=pass (2048-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b=jesn+3Mb; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=in.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D14Zd5pMFMjOsJtQZfy35LYrOIsd1O8dRa3TFWAsuw/rx9VTkQfDWHftdhMuKPw2I+CFfc4gYl9YuzVPec9AZjTGZNzHckpGbGo7glKlcQZgI2m5JMQpCMiGNfGSCWBTtsDoCBW6f3fhEy6vlF6FCbMdp1pSa5x5Xw6hWnz7QoL2FD82VcpRksf1Nz1EDpZLdIqubWUrYQ3tP119r1+vGwnXnr5tGlHhxER50/FWo/swCMXWzJaivUWmYfkjDoJIR7dsvsDWEptJXlRQqSbZgWXIhYb68zIjzDGxDrSUMrvdyotcO7fuFS/T+pylyy+RuQa1D9QJqrSk2xHsmCY8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqE6/+Jv69d/NGle32DZnanoW4Sgj/4t+r7w4UoLrug=;
 b=CV3gApU6E/hTtAUF0j7F6ZB1ic3z2wOHyn1XqGmExd+rmIZYPYgGlP8AC+bY/lguuOG/5fGMBeec7z5HFxfzn/Jh6XF4hCYa1oRKAfFa4R1QKATGU03YVg6DJBZTVZT+5d6WgGWz2hBFHo+PwLEFBimeHjskO62spmXGQ8k7DhDPzfHSSKtBXNZRlsv7rQS0qa6eAnAyxYZS+HqISxAJztoRXlNPWriG49zOhB+1CXZa0MZmUJy0vPFEky5XkUrW/JTqTTL4XME/9aeApk8fdf+I+e3Li1aWnU2dep5JuiqJsirfR8w8lZhLgvls8wQAUww5zeVktuxSyWT5s1GlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in.bosch.com; dmarc=pass action=none header.from=in.bosch.com;
 dkim=pass header.d=in.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqE6/+Jv69d/NGle32DZnanoW4Sgj/4t+r7w4UoLrug=;
 b=jesn+3MbNnuj3wDZbpqZ83h2lS7bo4fJ/32dDRg0JKE33faFQOPypCgj62zkw7ZUQ8I/2UGexzskmPJ+mbTqMkdJh4In3t19g5GVGQyHXbxRJQgQn/ZsJ/HrknEQcrj5b+/tmBqe9djnaCHPhRpzFzY6FBym2ILq1Q3F8TqFIVilpowSWgbTXpcmBE/JtvBTAJQRQqRDgjUqgGT4fvgGS20MfcCX6wLFtcUcywK4is3d5xmn0pZ4l+KzedcUFb3E5Q8Oy8Ocf80yE+jagn9Wov/mhiayaed38DZi46ByxHIOAwnY2GQsNE5EgojAPvvAXlc5B31m8omJ8Q2WdreD7Q==
Received: from DB9PR10MB6451.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d8::6)
 by DB9PR10MB7316.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:460::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 07:37:52 +0000
Received: from DB9PR10MB6451.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6cc3:bfe2:b280:7c01]) by DB9PR10MB6451.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6cc3:bfe2:b280:7c01%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 07:37:51 +0000
From: "Mereena Mathai Liquancin (MS/EHM4-BST)"
	<liquancin.mereenamathai@in.bosch.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>, "dlechner@baylibre.com"
	<dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>, "vassilisamir@gmail.com"
	<vassilisamir@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "javier.carrasco.cruz@gmail.com"
	<javier.carrasco.cruz@gmail.com>, "ZHANG Xu (BST/ESA2)"
	<Xu.Zhang@cn.bosch.com>, "BIAN Maoting (BST/ESA2)"
	<Maoting.Bian@cn.bosch.com>
Subject: RE: [PATCH v1 0/2] Add BMP390 IIO driver, device tree bindings and
 support
Thread-Topic: [PATCH v1 0/2] Add BMP390 IIO driver, device tree bindings and
 support
Thread-Index: AQHb4Z+X6bx3zTVAQk+lrebmlSOxKLQQV5QAgAAHoSA=
Date: Mon, 23 Jun 2025 07:37:51 +0000
Message-ID:
 <DB9PR10MB64516B74B8FE3077E1CCE622C079A@DB9PR10MB6451.EURPRD10.PROD.OUTLOOK.COM>
References: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
 <aFj9FGSpJyZjL_bj@smile.fi.intel.com>
In-Reply-To: <aFj9FGSpJyZjL_bj@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB6451:EE_|DB9PR10MB7316:EE_
x-ms-office365-filtering-correlation-id: e01d77eb-eb71-4f79-d585-08ddb228dc31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?s6yBO2gp9nU8YHSdcs+tyon71v5xSpRCnOmJIafOxfZJGnOb5bZ9hU6Tao3H?=
 =?us-ascii?Q?3sTe6hC3t60Z/yeDgGRl8OdmLLusaNM0JKo2V64vaac9XVJVMfEFK2iY4597?=
 =?us-ascii?Q?U6w+sItpXgaB7tAW0Dg9zJgiWr98hrxh05RBSUsVDpmndzDzHUw71nvWUfM6?=
 =?us-ascii?Q?Kia1KiriIF8wGDgOp939O7bjTfQl6MKoGkyofrXr20opouBbfv+Vg34bAB3H?=
 =?us-ascii?Q?c2WLkn2Zt1+JXv1tONFge0MJg0jVBHvkd3XfwIv6VwIXy9MkBh2aY2h1HQyp?=
 =?us-ascii?Q?t99OmCT5+ARjOjEWzIpFykGTa2RblX2yFMr0YBb271956kfVj4GK18vP6OQ7?=
 =?us-ascii?Q?dX+KcSm3LX35geQOp/9+FXiBvWLZzs3VJlIry8P4XQXVcjLDv7wa8r7zE/OH?=
 =?us-ascii?Q?oaORH9m2MLAJRz5ZHkAmGQ0VBvJfH9mNXlY78yk06xrUy1pameRFOXiCnQZ1?=
 =?us-ascii?Q?h62t5n8kAhe2XqhpVfZclI1duxexvpcp5+mVs1RAtjATjBrNUzxhSSNzCqT7?=
 =?us-ascii?Q?LAAaPdghE9oE6CuPWkUi0p72+sN1idfAYBRP+8dqR/Ee93nEvWyrXZqhZzyD?=
 =?us-ascii?Q?y1kmerNODAO4C+H5Q0M55YEJ78U1pErR0O21hDIrDGV6Z1RsmJnZzFXYVn+i?=
 =?us-ascii?Q?dJG+L85cbdRKuG68b9bvjUXSKjcWPT27dNMNVsP2DIu4YoKzuqzek3xLwxSv?=
 =?us-ascii?Q?3vGFyoqcwAOP9kLxI2cOA6UmC0p1JGdRdgWS+rijlZJNCmms+gyNXdK8jj8P?=
 =?us-ascii?Q?QtjZPBI0S5if2BtrpjRe5Unl48try56ox2kCl4FlAkKo0vDpG2H4xM6Xzdov?=
 =?us-ascii?Q?lDparIh03MwZUX7dguYUXhripmAIb0ap5KS3Pk6PcC3jZqopsDjHcNkZuZjN?=
 =?us-ascii?Q?WGBzou6RD7VLFes/5FIYZLAz2rvE2OYL7j6I/c6gdUFZRGjgnKEMAa/NjQ0m?=
 =?us-ascii?Q?U2J0vrmMly/wqxabSj40W8Kr7IBrk8NmRATAuWt/ql42XotRfX2sscla4b9e?=
 =?us-ascii?Q?vT3DJrtroHC+xDX7IX4h0FmNZsutBg0kJd+EHVAXBjLZydal1C9DzAwE2SHx?=
 =?us-ascii?Q?eIEvTozPADxd+RYY0PKmSOuFTMJp2LLGcCRJha+94dUJw7wJ5zHzw37ZehLR?=
 =?us-ascii?Q?Zde1kU6CH7mNlBsOl1W1pQsqvV+457wQ42Sq6K/eRbn69YKgxBSChX15X2p0?=
 =?us-ascii?Q?9Hx03Wk/iXUMRDRZ9O3dlWUhO3rZ+65YOP8bWM6U8HwzLMrQx9Oz9csXJMym?=
 =?us-ascii?Q?bGJaWyyjYB2HzYIq2AOr1X1y27i1T1ZqIxqvO3vyvXNzOuvyJxn6+dS3cHUE?=
 =?us-ascii?Q?evVfbX9+uCDpzijLCKCGlSxgUs7nzslvLrfMIroqlREvIm/XSjwoRiwx/xy5?=
 =?us-ascii?Q?o2zt6bRTWnyyjj77AwXK3N1OPxOYknI6Kn0KqAqX8l+OIacLWF8CIfa90ULC?=
 =?us-ascii?Q?JcejYcJ1nQM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB6451.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0MQ2IxAtTpMMacaxVgSt4lvfctG6wEonadxcBtoYIbrenAt6yt9lEnFxJ5KW?=
 =?us-ascii?Q?0wO8OiopQQ9WUVsEsMUwTQKfF+k+fdxjwONs7AJAyTPeilWWqVNnXaYDiHrr?=
 =?us-ascii?Q?j8tMkYWI0+/bV/RDfQe5m/2G9EIxsOkWCStiOmJWSKZnH6D3RaWvjwbT93iO?=
 =?us-ascii?Q?Gc//SRO8yoghBE0sQGLDqkN5GcZFAJhbxYTwlk69cnL5XGR/qTiGn7hyXOql?=
 =?us-ascii?Q?RZ2i0M9vdcySVQ8CLrc3O5GaSeTSVePKKT3WVEC4k+bEieWrrGm+D/XDRzRu?=
 =?us-ascii?Q?nqSGNfNGoo3eUFI1PVoUIbQUG7hVM47wK4BGemeWsH67frtRblqRmHpsd/KS?=
 =?us-ascii?Q?MuGO4QBodw0ufXXYcAuJmrhIZTkQEtYfCJLbozW6/U/UJihghw6X7mb4yEBZ?=
 =?us-ascii?Q?vPe9QGraPwV7k966tr9tsHVvjoHutSVJhxHLZb5t4uyYwtqJ/UDSsIbhyayt?=
 =?us-ascii?Q?22QYV/6ibWCCYxSSfKVlSDjow51dybcKIht19hsAIq+1AW6f/wxvOWwIU9sY?=
 =?us-ascii?Q?Anr7UYQP/q4PPSdxgk2s/Q9PSGMpMWLKVR4v05WHVMZrt5juquUodqK2gotV?=
 =?us-ascii?Q?q+HO/tK2kbWgc0baglRJY2r7P4brfZxRg+X7r6+vqhOt2uKpuTL0D+w5Z7a7?=
 =?us-ascii?Q?CE1hPMoqjEOsriqBqIIUhPk9aHQUQiQBpm3Kp/7j3lokpKd7h3zgDJ2b7C2o?=
 =?us-ascii?Q?VUUPBcfl53/eBD6U3XwPiLdYad2iLlEcaI/bFX/TikxQkrle89uQaEEw4yUb?=
 =?us-ascii?Q?YB0h50UNKOMP3JBLPxj69IJiv/eA2wyRza2EosedBMtRm0lCNAaZFUorGFmi?=
 =?us-ascii?Q?jZAJbBg2M2e6I1mL88r49zE/mg4UAR0/NKAlhyWxY2vI+e34rq3hTOhzUOaK?=
 =?us-ascii?Q?LnPoynu2ZNjoJt22kSepjARLvvskhffiYK1+L1u7OZgVTqBw+yzK43rHaudC?=
 =?us-ascii?Q?Xqil+xGmFL67x9gF+V/1VDO3TevYeyIVFuBmLCizrFDvsmE+n84g/eN/vVEm?=
 =?us-ascii?Q?yRNBI0zyz9Wf6O+LViX9lBVdQakxDZGwaxxyGuh54TG2o4lUsCtivOB9GfM7?=
 =?us-ascii?Q?9wgN2+ug5c5v0BQ072Ab08DEBiEYpJ+t2d2y+VRqcaBPMBLQkbt1Hct+0x+q?=
 =?us-ascii?Q?TgEguD314BaPI4l634SxunkqrbJ0FhvhEchGna1QTip5KzX9yrKgkaOjRc0R?=
 =?us-ascii?Q?0D7eyu74sgZ2s9Un+BlTkCKOuQNuNDCu132PeUV7Ui6ujoD+wE1zYHV9F3Mh?=
 =?us-ascii?Q?QlnW8A/gI3NAbmHvZ7wT6Rgcz6CmLPTEcoN1hmBzMesfnUDfFZiTAvIso2yS?=
 =?us-ascii?Q?WebU6pvJpUosHhkAU9ghl6TF+oh7PAaE2lIgTzE24ZpJlb3lU1WCPn6eys4G?=
 =?us-ascii?Q?RM63jumkDxZtcDXIJt42If60/JWafUOGYaU+NwV/VA/mYsWNcPhHN2X8Dyo9?=
 =?us-ascii?Q?s/IOOHoOU0xDRqb0YYJWWQl4qrGvaXQlbLqkjj5UuEEbHW5+8swS7GFGQaEX?=
 =?us-ascii?Q?pk+Hy0B67EdZnrpRM5ZlOAiglBZgkqmQlzIpKE+87W+kVdDWszUBwqJWEFdA?=
 =?us-ascii?Q?kT1yDsN25/R+kB/Aq60=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB6451.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e01d77eb-eb71-4f79-d585-08ddb228dc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 07:37:51.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOpeLif1SPKheYCimpPHnD3clGlrZ+r3LkJuOpJqLsyVFQ+W/2lU1Iytvlzk9zDAvfATiQMQzGzPzIDVALUiiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7316

Hi All,

I apologize for submitting such a large code patch earlier. I am currently =
reworking the driver to simplify the implementation and make the code easie=
r to review and maintain.

Regarding the BMP2 and BMP3 devices, there are significant differences at t=
he register level, so direct reuse of code is not feasible. However, I will=
 carefully consider all the valuable feedback provided by the team to ensur=
e the next version addresses the concerns raised.

I also plan to remove some unnecessary device tree nodes and redundant logi=
c to streamline the driver further.

Thank you for taking the time to verify and review the patch. I appreciate =
the constructive comments and will incorporate them into the revised submis=
sion.

Best regards,

Liquancin Mereena Mathai

BST Projects (MS/EHM3-BST)
Bosch Global Software Technologies Private Limited
(CIN: U72400KA1997PTC023164) | KGISL Infrastructures Private Ltd - SEZ Keer=
anatham Village | Coimbatore | Tamil Nadu - 641035 | INDIA | www.bosch-soft=
waretechnologies.com
Liquancin.MereenaMathai@in.bosch.com

Registered Office: Bosch Global Software Technologies Private Limited - (CI=
N: U72400KA1997PTC023164)
(Formerly known as Robert Bosch Engineering and Business Solutions Pvt. Ltd=
.)
123, Industrial Layout, Hosur Road, Koramangala, Bengaluru - 560095, India
Managing Director: Mr. Dattatri Salagame

-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@intel.com>=20
Sent: Monday, June 23, 2025 12:37 PM
To: Mereena Mathai Liquancin (MS/EHM4-BST) <liquancin.mereenamathai@in.bosc=
h.com>
Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; jic23@kernel.o=
rg; dlechner@baylibre.com; nuno.sa@analog.com; andy@kernel.org; vassilisami=
r@gmail.com; marcelo.schmitt1@gmail.com; javier.carrasco.cruz@gmail.com; ZH=
ANG Xu (BST/ESA2) <Xu.Zhang@cn.bosch.com>; BIAN Maoting (BST/ESA2) <Maoting=
.Bian@cn.bosch.com>
Subject: Re: [PATCH v1 0/2] Add BMP390 IIO driver, device tree bindings and=
 support

On Fri, Jun 20, 2025 at 10:24:53AM +0530, liquancin.mereenamathai@in.bosch.=
com wrote:
> From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
>=20
> This patch series adds support for the Bosch BMP390 pressure sensor to=20
> the Linux IIO subsystem. It includes the main driver implementation as=20
> well as the necessary device tree bindings for integration on supported p=
latforms.
>=20
> Patch 1 adds the IIO driver for the BMP390 pressure sensor.
> Patch 2 introduces the device tree bindings documentation.

>  16 files changed, 7296 insertions(+)

You are kidding me.
Please, take your time to start with something really basic.
Also, can you explain how this driver is not duplicate of the (any of the) =
existing ones in IIO?


--
With Best Regards,
Andy Shevchenko



