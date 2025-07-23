Return-Path: <linux-iio+bounces-21896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD1BB0EEBC
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 11:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B3854273C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 09:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE642882A8;
	Wed, 23 Jul 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="red6ronA"
X-Original-To: linux-iio@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC70153BE9;
	Wed, 23 Jul 2025 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264016; cv=fail; b=B1XhuO4FpRgpB3nMQ7x8vjSh9agwamk/vNVoiLhwDsIXjIx1i4XEcIbx/BMd9MvZNyrNfDirolMC1XTyDR9I2jfiNQqdNw2Lb+mGoEhrIcRGuuDMm6Ow9r/yGiSOS0uWN+/Uf08jWsI+/KwjMu/i+U0TM0tsBDtvFUQSZ5/Ag44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264016; c=relaxed/simple;
	bh=HVfC2A6qKirJHO1RXncOAXb+j5emkZUYDUKBo+XMTWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jhCHe3MS1ZntSakbJvKU3b2wi2iPWNzV2GOt0J+wpOSw12QkVbfsVxjdVelztmuJT8053UsOH2YTW0DPq1kh4IsHYnREfjkiTTBKkEFHVU/11G0vZ5cbqRdahfNmD0bmnVq0BEyA2OPcN9ektWVcPLSaYhxMU84cm/Y443dRiOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=red6ronA; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fjr4EsWzoCfDrfxMHTjELORDY642jAMTsMZ0Fp4bjOuPdThrVVm1Pmj3ra0e28dPLpodZS3zcWIzOMVyHg+3djr4ZWrNGRKFJePn0EIvePkv9N4UwCs070S778xKMVoSo0mbf+gDOUSFR4t8B7ABt25FqQePeUmOv1rivY4lTZq3Ja12T68d9gf1jDSGLC+bd2UaFRq4+lVU286esJMHpuHkFUQMjdgvJRAe+Kbn1FSFiICnEUMMvk8juqRjhrnuD4n2/5203rIYOabDhcitPfiSq7b3sG7xd/LA3Hxy8A0TshGVUkTN4YjrB28uVGvJdYnAg+H2Ks6QVCKCQnA+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxkIOlY0GeF8ymQLdvGK7dFYkJwyrpxQrBaGmh1uyLA=;
 b=kPuDjTKqp3e+4z7jSvh/S9C5uFFe6URiRhYWMwXMto9kbMvNHqZsZezQfd5Wzc5XSJh9QhEuDVmJ6x8o/jWomzg7Y3JULmn6gGhs9ndsCdFHxJ00umce8gr6jhR8hfOlbtxF2OiB+i3uCrt7MV93xjQBEzrFt69edOEP16afKyeb64SCt39w18T+2huKrBXxPtYTidPg71LsvZbhh9afqFpnw1olAEHYhsd9DR8vKRExOAQVQg0kKMEsTX35hto4FdHVfZ/rpBBgDBooTrAaVfJP6rJnug63HlczPI8w+Z9nJl49bewe61SbmtPhQtRk5rdNZpIUJpXC4EmN8lwdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxkIOlY0GeF8ymQLdvGK7dFYkJwyrpxQrBaGmh1uyLA=;
 b=red6ronANqAsebJmm87xM0THOjeDTZoeE3ZDSirSU5zYsZp8/AkGr/5TGO8Sq5uq2hYgkv4SyM7bp+W4E3azC5cYnShozCk6x90gxOU+K1/xB7KG2kGFCYZp7yoYLzrWP1xaiKxJSlxqejqb33aOWiIFMzmlj9OtnrSEvjWq83Dt0CmJnXjBAP3EEtIwAFF/4gie6SD8RsC98mdgkGPAwgbTHGBaEWpzOpssSiKyh3gPnbzTTK8xLM95nlld1Bh0A1kwdQIwKVxI5WE6EBod9dUbriJKj4yVvWzFa7OG8+y2SUDFBh9O1CS7aVo16XcVzWFoXfwaUjHYwUTWAToK1w==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by PRAPR10MB5273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:293::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 09:46:47 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 09:46:47 +0000
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
 AQHb7DCnxFfdguezA0CMBsJ2vkpDJrQlVJwAgATVpeCABfU/AIADa+ZQgALjsgCACRRNsA==
Date: Wed, 23 Jul 2025 09:46:47 +0000
Message-ID:
 <AM8PR10MB4721FB1A78F25B204BE3A26ACD5FA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
	<20250703153823.806073-3-Jianping.Shen@de.bosch.com>
	<20250706175328.7207d847@jic23-huawei>
	<AM8PR10MB47217D838CA7DDACBE162D15CD49A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20250713144214.6ee02f59@jic23-huawei>
	<AM8PR10MB4721BAD5BD78B8FD0F5C9798CD57A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <20250717150440.5067862b@jic23-huawei>
In-Reply-To: <20250717150440.5067862b@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|PRAPR10MB5273:EE_
x-ms-office365-filtering-correlation-id: 2d36520f-16aa-4f89-0874-08ddc9cdd78b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Cxk++10VN/F/mNF4rC8bo85kpKd4Hd4PF3DZVP5v5vEI+uV/DhGdCbQJ8hdi?=
 =?us-ascii?Q?RD0M32GzV4MUj4a8f30q6DTw7HYtf+oAAGAMLXWMo6eKkFh8UIfz/c7We3AL?=
 =?us-ascii?Q?TFR2X+iSz3OvRFyBIqGLhAZZw8HQmPIA+o46F6roHKIBjX7HSf0SumEpJPLV?=
 =?us-ascii?Q?TI/BI5mwHgL2qP1qOM1Uw8va72II25zyLxyTYgL8cQrnVIdThwqbrOF2IkTY?=
 =?us-ascii?Q?6pJNnm/z3TBc+yYto/I6kq0W2r4e4rbv5nPVloa3f3fl46h4Ga1tE3PJg+HT?=
 =?us-ascii?Q?hYDRKTQ5YNxwobxI5C+py66rNLLojaSQXDdRdc4Envd0o25l0f6jAikDtbL7?=
 =?us-ascii?Q?EEawrG8Xvo448NMAm+ofCVqLpwUZXGIOjzfc637NVohiAc0l/nvpezAHuUe3?=
 =?us-ascii?Q?SCDh8RjLl/un7XaMQlCoc+DTN4Tes+3vVA674xZm8QyhsshbpFQq8umv67e+?=
 =?us-ascii?Q?WVC5mkEVZLxYx0es2TudIeY8eHc6I8p02OslL6BbpZbS3cHVMDHqXHmOyKI4?=
 =?us-ascii?Q?7kYGREKD9gCed7UVaSS32tNepHY3r6Ct/toWv/Jwk9FhELGMXStt/Ye3+udi?=
 =?us-ascii?Q?Btbv5DI5HTvxfuLiDDpfqXNvfLDoDOno6i73PjfBFhYbxeyxQV8C9E0QCGsg?=
 =?us-ascii?Q?5npQliJGsS6XuIMuYjmkpamnhet2h3hBuu5ztZiMIXwE0pflMZoxzRmU+Wmf?=
 =?us-ascii?Q?w8/jwxIp8TKgPVBBkUu9wlNcnXOEfNtg2AyajgkomjG5FDQxTvzyaWo9Pce2?=
 =?us-ascii?Q?A/iTYsnxS3eV1xSkdXuv5RStY/bI/hsjofxhuYXnOHCRJoNgsNm74GoTpXj/?=
 =?us-ascii?Q?Hd0jjM+DU0xhoaeuPKYX2A3sSOAE76T5xwPmARRNMGvkan6IvSkSod5FGA0r?=
 =?us-ascii?Q?5w4F/sXcp7usr5zQdoiAXovhS839IHZvuxy1bu78bkiFUHRR5EbHDBoIg8GS?=
 =?us-ascii?Q?7s+Tv2WljZTiV8IuWASGOlASm2RAg4wfyp0lUhNYi0dZulvCL6TIvzvGK2PC?=
 =?us-ascii?Q?9c0y+dJpgX+tyVUl+jbqA5frDTf0Umf31+2S8wRrLqM6JFbMR3tkC4IR5EjY?=
 =?us-ascii?Q?LPd5orGY2/AULJGnefHFiA9F3bhOBTRjyg5lwJHu9/j77trwKQsLdlo5yrgr?=
 =?us-ascii?Q?t55TlYQYRomkXILRvepWw4bQ9kVfHtY+ws1dAqfFJ9hBzkTyLW+Dx4spD2a0?=
 =?us-ascii?Q?zDFzesa24ybAeWrtBS8WP+TwSTq97Xj7056DfLZ4UyjCPSYyZEIKA+4fNe09?=
 =?us-ascii?Q?q6mByIRArb7FyrmaUnk0ESmP4ijOPXGrDA5rfrFqOSnXEIuDITdds7AWSctd?=
 =?us-ascii?Q?rvyS+Urz7djbbVWNfz6szUUP2HN2t4NgHjkm22JtVGDaRyOW5VdXy+Uv5B2e?=
 =?us-ascii?Q?Yv7+9hSmrA1vgTJmf9dS/LGjvaUmTdC0qUOblgajIndll/7kWE1fM6xGwTyX?=
 =?us-ascii?Q?ZwV9NZFI574=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6O84IhvgrxblYqOL91wgqNOwkIcw0FbrIm4Vu5h4zFqzj2zCPNzIJn8ECV7U?=
 =?us-ascii?Q?V5VmctGmhZSYwPkPAMt9fJFM2Leg7OkLofBJW/WXfWvydua3xP2+9WOytvEY?=
 =?us-ascii?Q?xC4JBTNccMUFlAjxxqjBgl6xc4zp0A22f6p/5FaYWFfScU74eVgoPuudqIqz?=
 =?us-ascii?Q?UNlEQpVCaTnl9GuI19UFYMV54Vbhph0o+hsALyptExm3rUrSfrpfz9o9xWhg?=
 =?us-ascii?Q?+J2JaqeIdL5cEXlnb36x894BmE1qOhTvGKzx4mpcTj6oUEJu8Htd0aDc5DM+?=
 =?us-ascii?Q?WEGQedwXMYfapoAAJOVNaaThmMMsGHpi+88WUcrWeHPVYo+DYMUSso1dWCLZ?=
 =?us-ascii?Q?XmM5cIRgGceuXXxYjOcng+EvS9K1zCaUEjUxO06amy09Iul7kcwSWVIS/a9U?=
 =?us-ascii?Q?R2gMeSD7D5DdRj8kDXYzvy84OfMqthkPFZhPHuA2BjREb8kzyhap2Dew0a4A?=
 =?us-ascii?Q?W1MIP5uX/zPR0hGzIlJn/K3t3z98W+z5WszcRvFg+TZCPNV8L74EseAUaYtv?=
 =?us-ascii?Q?R2ekb3Dz1KU3KGMy5fGEwsqPAV//tm4CzR57UwCU3q3WZrcUPyeieqSPL/JX?=
 =?us-ascii?Q?CGTSL0Skx+ePz4i+CLW7vU/hpP882EBl4q74vLrHTm97KS0TdNbe+kSplZWW?=
 =?us-ascii?Q?rzHeMzPwptnve89BYbi2hv7tFauy0jxu8CXMcRSPIdClRXmVA0oYWpDo2GQA?=
 =?us-ascii?Q?0tEhzzok47hZivHsdxUVNkfNfPADegGhYZ/PSUGhDkzVRgwiO2Lg7YMrRCWK?=
 =?us-ascii?Q?dAnGM+1NdEyADesWYLwVTkhLMXfb8tswEmzpA8Q9quhi2AAkdQwumeKc4Nfh?=
 =?us-ascii?Q?uMfyy46ArZs1yx3M5OtnPfoL7aVW9A592QLFI+nXPjjQxRMFvsJRJiUJ0umE?=
 =?us-ascii?Q?wAaZ52J77q40d+57X7P0wmwXf6fhSpnjdF2VVv/1PS+PFs3Pvily/PxKAEbE?=
 =?us-ascii?Q?KUe4/WWruD9ZznPN/JofETmX4zD5V/W5tp9WzHw9qc0B3LlKz9ycPWrRbII4?=
 =?us-ascii?Q?glx3RCh1OeTHCWFpDZ48HuuC13DQCNiThys6l2JXCa4zgBEBpnsrWvkApMJ9?=
 =?us-ascii?Q?YKWoJHQNH7FqCYAFerjcTCQt1e0rpMHqn8AwujriZrwhjf9UU9sKb7CqVIyC?=
 =?us-ascii?Q?QVTgV7W0fvreGhHSiYv4sl1lfYV/b4rO+Srcvr0V/5T7gfF64aLgm4pTfNXo?=
 =?us-ascii?Q?gCSylm3vX443iPgumjJxpjFnVLChr0l+piUVzSIobJX7UZmuDdJJ0KQyA7fy?=
 =?us-ascii?Q?3qb88paX8JVDpsoqfTT7n2idDvfvlFiYy0Dned6Va8/+XyouHuyrcDxOxryo?=
 =?us-ascii?Q?0llD+tqqCe1G2p1JGRAnTDPudFcPKXz732fPfXejPqKXUhKptQT0UWxL4ybA?=
 =?us-ascii?Q?5V867SFUrvkh5lKlPl46Ny35BihUAm6ozuw4TO1Cdrs+ZyFbmm5qI7J7O3R0?=
 =?us-ascii?Q?D6/D/V8QTJ2FOfFFIBKG+xMPWpxb68PqUiX1Wt8aotFqKZ95LTPJzk8Hispb?=
 =?us-ascii?Q?4+FuWWtKqTTU0g63BEFBwJbyeJjoCq8OFCvc/fZkRrFZxs1C2nRHJUQKI7i6?=
 =?us-ascii?Q?/Jt9seLgRLv+Fg2RsjI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d36520f-16aa-4f89-0874-08ddc9cdd78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 09:46:47.7086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZorJNaV9unwBmWisZAS+FiCv3Sd8AOE66jHEh+AHcfGGlNc4hC9guXIW8hjftEpF/hzftTmerDbpMZqjLCnbCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5273

Hi Jonathan,

we find out the reason why the timestamp is invalid in the iio buffer.

https://elixir.bootlin.com/linux/v6.15.1/source/drivers/iio/industrialio-bu=
ffer.c#L1093

In "iio_buffer_update_demux" to copy the timestamp, the address calculation=
 is the root causes.

1083  in_loc +=3D length;
....
1093  in_loc =3D roundup(in_loc, length);

When finish to copy the channel data, in_loc is just incremented and used a=
s address of timestamp. This is correct only when the channel direct before=
 timestamp is enabled.

If there is a gap between the last enabled channel and timestamp, then iio =
core will copy the wrong data.

We have a fix to this issue,

1093 in_loc =3D (indio_dev->scan_bytes / sizeof(int64_t) - 1) * length;

just not sure, if there will be any side-effects with this fix.

Are you going to fix this finding, or shall we create a new patch for that?

Best regards
Jianping Shen


>>
>> >>
>> >> >> +
>> >> >> +static irqreturn_t smi330_trigger_handler(int irq, void *p) {
>> >> >> +      struct iio_poll_func *pf =3D p;
>> >> >> +      struct iio_dev *indio_dev =3D pf->indio_dev;
>> >> >> +      struct smi330_data *data =3D iio_priv(indio_dev);
>> >> >> +      int ret, chan;
>> >> >> +      int i =3D 0;
>> >> >> +
>> >> >> +      ret =3D regmap_bulk_read(data->regmap,
>SMI330_ACCEL_X_REG, data-
>> >> >>buf,
>> >> >> +                             ARRAY_SIZE(smi330_channels));
>> >> >> +      if (ret)
>> >> >> +              goto out;
>> >> >> +
>> >> >> +      if (*indio_dev->active_scan_mask !=3D SMI330_ALL_CHAN_MSK)
>{
>> >> >> +              iio_for_each_active_channel(indio_dev, chan)
>> >> >> +                      data->buf[i++] =3D data->buf[chan];
>> >> >
>> >> >If I follow this correctly you are reading all the channels and
>> >> >just copying out the ones you want.  Just let the IIO core do that
>> >> >for you by setting iio_dev-
>> >> >>available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 }; and push the
>> >> >>whole
>> >> >buffer every time.
>> >>
>> >> For the most frequent use cases, we define available_scan_masks =3D {
>> >SMI330_ALL_CHAN_MSK, SMI330_ACC_XYZ_MSK,
>SMI330_GYRO_XYZ_MSK,
>> >0 }; and push the whole buffer every time.
>> >> From the user space we just enable 3 channels gyro_x, gyro_y, and gyr=
o_z.
>> >Then we enable buffer and expect that only the gyro values and
>> >timestamp in iio_buffer. Nevertheless, we have 3 accelerometer values
>> >and the timestamp in iio_buffer.
>> >
>> >> It seems that the iio core does not take care which channel is
>> >> enabled,  just
>> >copy the first 3 values (acc x,y,z) into iio_buffer.  Our driver code
>> >still needs to take care and just copy the enabled channel value to buf=
fer.
>> >
>> >Look again at how it works.  If you provide ACC_XYZ_MSK, then your
>> >driver has to handle it.
>> >available_scan_masks is saying what your driver supports. The driver
>> >can check active_scan_mask to find out what is enabled.  So right
>> >option here is only { SMI330_ALL_CHAN_MSK, 0, }  In that case the
>> >driver never needs to check as there is only one option.
>> >
>> >Then if any subset of channels is enabled the IIO core copy out just
>> >the data that is relevant.
>> >
>> >
>> >>
>> >> Another side effect after using available_scan_masks is that the
>> >active_scan_masks sometimes does not reflect current channel
>> >activation status.
>> >>
>> >> Is some step missing to properly use available_scan_masks ?  How
>> >> can a user
>> >find out from user space which channel combination is defined in
>> >available_scan_masks ?
>> >
>> >Why would userspace want to?  Userspace requested a subset of
>> >channels and it gets that subset.  So it if asks for the channels
>> >that make up SMI330_ACC_XYZ_MSK, if available_scan_mask =3D=3D {
>> >SMI330_ALL_CHAN_MSK,
>> >0 } then the IIO core handling selects SMI330_ALL_CHAN_MSK (smallest
>> >available mask that is superset of what we asked for) and sets
>> >active_scan_mask to that.  The driver follows what active_scan_mask
>> >specifies and passes all channel data via the iio_push_to_buffers*()
>> >call. The demux in the IIO core than takes that 'scan' and repacks it
>> >so that userspace receives just the data it asked for formatting
>> >exactly as the driver would have done it if you had handled each channe=
ls
>separately in the driver.
>> >
>>
>> Set available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 } and push the
>> whole buffer. iio_push_to_buffers_with_timestamp (indio_dev, data->buf, =
pf-
>>timestamp); We enable the accX, accY, and accZ from userspace. And expect=
 3
>acc values and the timestamp in iio buffer.
>>
>> Raw iio buffer data:
>> 00000000: 3c00 d6ff 7510 0000 6100 f3ff 0000 0000  <...u...a.......
>            ACCX ACCY ACCZ PAD_ TIMESTAMP__________
>                               4093587712
>> 00000010: 3f00 d2ff 8910 0000 0300 f6ff 0000 0000  ?...............
>                               4143907584
>> 00000020: 4900 dcff 7a10 0000 caff 0100 0000 0000  I...z...........
>                               So this one looks bad.
>
>> 00000030: 4c00 d9ff 7910 0000 2f00 f8ff 0000 0000  L...y.../.......
>                               4177473280
>
>> 00000040: 4b00 d9ff 8410 0000 1f00 0800 0000 0000  K...............
>                               also bad.
>> 00000050: 4700 daff 7f10 0000 3b00 eeff 0000 0000  G.......;.......
>> 00000060: 3f00 d8ff 8410 0000 0c00 0900 0000 0000  ?...............
>> 00000070: 4600 d9ff 8010 0000 0e00 0800 0000 0000  F...............
>> 00000080: 4700 d7ff 7d10 0000 3400 feff 0000 0000  G...}...4.......
>> 00000090: 4b00 d4ff 8010 0000 3e00 1200 0000 0000  K.......>.......
>> 000000a0: 4600 d6ff 8d10 0000 4300 0000 0000 0000  F.......C.......
>> 000000b0: 4900 d6ff 7710 0000 2500 f0ff 0000 0000  I...w...%.......
>>
>> Converted value
>I guess this is different data as doesn't seem to line up with the above?
>
>> 0.015625 -0.009277 1.024411 589929
>> 0.015869 -0.009521 1.040769 4294901719
>> 0.020508 -0.008301 1.025632 458712
>> 0.018799 -0.006836 1.032956 851960
>> 0.019287 -0.009521 1.033201 4294836275
>> 0.015625 -0.010498 1.031003 4293328982
>> 0.015137 -0.010498 1.031980 4293853176
>> 0.015869 -0.009521 1.031492 4293722141
>> 0.018555 -0.011475 1.033445 4294311886
>>
>> The 3 acc values is correct in buffer.  Nevertheless, invalid timestamp.=
 The
>timestamp is actually the value of the gyroscope, which directly followed =
by acc
>values.
>> If we enable the gyroX, gyroY, and gyroZ from userspace, then all the da=
ta is
>correct. Since the gyro values are the last 3 values and flowed by timesta=
mp.
>
>Ok. That's odd and we should debug that.  This code is used in a lot of dr=
ivers
>so if it is not working correctly we need to figure out why asap and fix i=
t.
>




>However, I'm not seeing what looks to be gyro data in bytes 8-15 etc It is=
n't the
>stable sequence we'd expect for a timestamp though some specific values
>might be plausible.
>
>Looking again at the code, the IIO_DECLARE_BUFFER_WITH_TS() is the wrong
>size.  That should not include channel space for the timestamp. That shoul=
d
>make it too big though which shouldn't be a problem.
>Also wrong type - should be using __le16 not s16 for the buffer elements g=
iven
>your channel declarations.
>
>Please could you add a print to your code alongside the
>iio_push_buffer_with_timestamp() to verify that the value in the pf-
>>timestamp is reasonable looking for a timestamp.
>
>For reference this is the code that handles the timestamp entry creation i=
n the
>demux tables.
>https://elixir.b/
>ootlin.com%2Flinux%2Fv6.15.1%2Fsource%2Fdrivers%2Fiio%2Findustrialio-
>buffer.c%23L1086&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7Cf0
>9eaf03f8e44dd1e6fe08ddc53ae596%7C0ae51e1907c84e4bbb6d648ee5841
>0f4%7C0%7C0%7C638883578931715207%7CUnknown%7CTWFpbGZsb3d8
>eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
>oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Ds53tTw6o%2F2guA
>iH3J9jBRd0%2Bj6UmcmgyhtBCuKK1HE0%3D&reserved=3D0
>
>Jonathan
>
>
>>
>> Conclusion: Setting available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 }=
,
>the iio core is able to correct handle the enabled channel data, but not t=
he
>timestamp.
>> The working solution for now is that our driver takes care and just copy=
s the
>enabled channel value to buffer without using available_scan_masks.
>>
>> >So the aim is that userspace never knows anything about this.  Just
>> >set what channels you want and get that data.
>> >
>> >Jonathan
>> >
>> >
>> >>
>> >> >
>> >> >The handling the core code is reasonably sophisticated and will
>> >> >use bulk copying where appropriate.
>> >> >
>> >> >If there is a strong reason to not use that, add a comment here so
>> >> >we don't have anyone 'fix' this code in future.
>> >> >
>> >> >> +      }
>> >> >> +
>> >> >> +      iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
>> >> >> +pf->timestamp);
>> >> >> +
>> >> >> +out:
>> >> >> +      iio_trigger_notify_done(indio_dev->trig);
>> >> >> +
>> >> >> +      return IRQ_HANDLED;
>> >> >> +}
>> >>
>>


