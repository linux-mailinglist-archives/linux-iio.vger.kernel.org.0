Return-Path: <linux-iio+bounces-13826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 392449FDA0E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 11:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419447A0FE5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5F153598;
	Sat, 28 Dec 2024 10:54:39 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021088.outbound.protection.outlook.com [40.107.57.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD27433A4;
	Sat, 28 Dec 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735383278; cv=fail; b=YBQoS/uY+zfAKZxbTx/yiincC4dUiaupZ47gx0XmyDfoE2gDpkwfeqiAarV3pB4vMbB3w8wgyxE5Ivi2j0+HSu+QYmBB4RJ2UPKmXeFhJ9uUmJQ8ZMQFU07BJKzmSylvSmKgt32wqSvUhv+A2YiTJlIRkbyBOzbBac7hMqE43iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735383278; c=relaxed/simple;
	bh=s/LNJ9G1GlcpXlqXppx8XWnQl0ZBUma3d3088DF89RQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P30Mhcy0Qcz3d3eqYHWmojFTamOvYKBRkWpcKhvCtSdtO+XGHr3MFtxRDSl3Wjndq5gd/5Ins8HTgwAC0L2m4PhyWfMp8p2g0yJMTUL1/At6RUIgozyD6aD87qxMR9a7QmO8FXl5aK8QRS5lnzmzDNJaVYF/ke/0mUE10I+JV/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcP3/j3+lE+tuz4mVKmSGhdKeGq9ASrEG3H3qsW4NO1hNZL0ptTfgEGffbg5Q2I3eInoOXVa1ykk+aLk13STJO07vd2LnSPFmIujbLBkyvint1EQDOiUPOcz/D4XKVtNXKRRvBIoPR4Mb6yKkqXZ+feIA0Nz48zBiZUVGRRxzCCU+EwOHiT/56Gbm37vDmufzNrPphtJQ954tBD5h2xFAQxe6PKubmfVwZrJTlFz8tVL8JcYV6TVElchtUuAQz2KAscldHrIKfHyxW8OSRog9ATguKM2oUHSqPNsS+g5xKDrTMX/YLeC3WMaM0cTclMQaeV/MQfdowEK2n2OyyhGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/LNJ9G1GlcpXlqXppx8XWnQl0ZBUma3d3088DF89RQ=;
 b=LQRKh51XVYdTgiipFzcGpLak41mgYYyXmXGLtXfPXOi/7g2nLOpibU8R1gsiQ8sERKS+Visoj3wpzv+zJYF6QbeblnfjwFNBroevSQ69eqKZFrbxYJ6dm8p4Tu3x4w/hspnFDw/ETkhjANhOeWmki66uLQ0kCdHgKSqEjyMt+4C3HY0/ncuYnmkgj5nqxZ+QEJdhcF4yIMSsWnHTdAqL5fCUpj/lp41cTKQpzW54sxx9mB3qRgk9x3Hqk6ip6HfeF7jxWcImcD9GVJztC2Kk9HC/CCB8Op+pD6XPKElvwJzdrCGPn7P8q99pCS63mv7yIzVvslw/Sp9yH1S/SeOL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by MAYP287MB3887.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:149::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Sat, 28 Dec
 2024 10:54:33 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%4]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:54:33 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Emil
 Gedenryd <emil.gedenryd@axis.com>, Andreas Dannenberg <dannenberg@ti.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Thread-Topic: [PATCH v3] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Thread-Index: AQHbWGDuX+oJMhxVRk2+n9xm6GhD4bL7cayAgAAKz0M=
Date: Sat, 28 Dec 2024 10:54:33 +0000
Message-ID:
 <PN0P287MB2843E7005997F1728B0F9B2CFF0F2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241227131134.10810-1-hardevsinh.palaniya@siliconsignals.io>
 <qgottqtq5lvp6fifi37xzq7supalvm7leue755yjatyun6k5um@pju4v3kqoizq>
In-Reply-To: <qgottqtq5lvp6fifi37xzq7supalvm7leue755yjatyun6k5um@pju4v3kqoizq>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|MAYP287MB3887:EE_
x-ms-office365-filtering-correlation-id: c44ce2db-72e6-4b38-d967-08dd272e0364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?weCWdZcGpCWXBzWUa0tx9uVuOUxU0wavhQE0Dlw2ULRd5u+Ku2V9I14yIk?=
 =?iso-8859-1?Q?FHox7WMH2n2MF6Ce8AAnf4kjHKLTGnTDaYizQecrje3bIMWfpP3dZpOXtG?=
 =?iso-8859-1?Q?Bv61+W3VotRlAGnu9FRBwk4FYcSnN+EKD6ljyQ43WDoXbMimDJHclrAdCp?=
 =?iso-8859-1?Q?bb3JbucIC6qyhSUhW8MbJFSNwskK6bTqwQzNZIulyJ9w/5+1x7dYt4RNe5?=
 =?iso-8859-1?Q?0e7Tck2PGaUg7M+6CR6uqiagOmSXQ4BQUt6LO6T1vvPu0HCOel5ooJ/CGW?=
 =?iso-8859-1?Q?+fBMab7Ooz7zrtxkb5m8RkGkZ15utzB8Ebm/WtH71CuFzSL7KfqmHOdMjq?=
 =?iso-8859-1?Q?CLSGUZRVGeKXo25DJB4xjJQ9q5aaiCQ92O1sN1Zq8yGgVf1nKPLRUHaFAS?=
 =?iso-8859-1?Q?FgD7oBO5DIMhqi2vfIpYfFdW7j7xq0qT2EDcpmBc5aE2lJ7A2zHZ53h/F0?=
 =?iso-8859-1?Q?Gm3wA7tkeECEsT+eL/1E4qtuJ4YuuImBybTZ7cwk9KGUy17g+hRVUHeazx?=
 =?iso-8859-1?Q?iBBOSF3mWqu3fvUMZ+pxhxVxniMYS7UsnOfLbS150WVc6M4HQbHk67nIat?=
 =?iso-8859-1?Q?//AsgTJuAXNSkc8flz96gu/ch3jd2p0yNnJlsZVhjAs1xiA34L4IRmSq4c?=
 =?iso-8859-1?Q?kGSD91wADa0gwEl5nA99VhAttdA3HFwN7mar7O4gnFeiVkSfws7aWueTSu?=
 =?iso-8859-1?Q?D4aHy0EOWXbnsyNWsSXfiZhYqF5RLE+6xkbXehE7KwfJkfraoSNe0UOwGS?=
 =?iso-8859-1?Q?LEmydJ505AQ7eQzaBv5l/yZLTull3c1k1rZp+1Y3eW6nEVMQCr08uBcxsR?=
 =?iso-8859-1?Q?1Mh+of9uCo26l1zJeZsbAagaOhYH2DpLoaBMREdz9MPNfJss6eMbxQgwGs?=
 =?iso-8859-1?Q?aeeUlZDKHonGY/yTxrDjTVRqgynkmpgK/4CslNDJ2Y0ZK/G2byKGtWH8OQ?=
 =?iso-8859-1?Q?lDNoCswxCRpo+Y0gsmZ+5wtBsB1xI6RT5qCuw8v/cHNuUxD3HT0m9efl91?=
 =?iso-8859-1?Q?pq9/xXj5ORcjyjpV47X8kr3ykKMlze0yObAWfRTtTb7Bc9qtyKd1mdwiCl?=
 =?iso-8859-1?Q?scJXpxKfBcDrjV/FOrXPxf5am7RiF2itUrcbx8S/d+zBf22tjJHSnjGp4/?=
 =?iso-8859-1?Q?qMYx/UqGUdYNIYVlc5Tk/PmQQihQ4o1pp5pF42cc/eL85mBfsM+qh+WXs9?=
 =?iso-8859-1?Q?DJ8Ck7XjOOS0nCXC58XHukH023lhvTP8OeKmwhUtA6wIRqZGTVidLjOCQl?=
 =?iso-8859-1?Q?o8ewPQRvmqRsfT/ZB11Fy5/FYcS0mnlJCb1AUojRi8Unq6HgolwvKNmYq/?=
 =?iso-8859-1?Q?DjZo4fgPWD/ijY/un9L5/GOuxt2JIJqgdtzra+LwK2w/2WgT6b1Cmlfko9?=
 =?iso-8859-1?Q?ghHo09WNIwpojCcxcSJoKaOrYXehJTk49uHLZGviDYaIYHedwe06sbJJLV?=
 =?iso-8859-1?Q?AVBPwc+3EVsLu8KIFoRrj00gdHHNTRT5S9yTYw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vVun5qPWJG1Gw9qgTdaeqpHVRgteXCj6zKJBAcqaeXJ1qX7k3esoperG/T?=
 =?iso-8859-1?Q?2QLTtcGarlZbiO+jlKnX6WxpI5IRZA1wnFgqSkss7hObCs9KJAkFmHCmac?=
 =?iso-8859-1?Q?owS1+2VT35DUQUBxUf8Io4jhXh2IwVpFR10dZq+lwK4GriNu5JrhNLgCC+?=
 =?iso-8859-1?Q?weUsEsCMOoPwuShUGVp9L+m57/S+Y8FGjTLv9yUYaplqEKhRgF4AUYtwSC?=
 =?iso-8859-1?Q?qTQZY1ZQ4cStsa92uOifgaj/GzLwrkKssr8tJFIK/vgAOZDhU1WMJ7fhfE?=
 =?iso-8859-1?Q?z1Hcr9/2nsBoW+466CI1W7t6S7m8Oh31jkyrE76wB6O75vrg2H8+i9wMgW?=
 =?iso-8859-1?Q?9BMuBiVNWy7xrAsyasnyDuI7nzMz6nZVF8f5LLXgcSjYadcidGeXciSVCH?=
 =?iso-8859-1?Q?3DRG0Hpig7TPI2jym1nbzWegCtbJOI9AV3V7kMrMQPuc/GD2asriMK/FK9?=
 =?iso-8859-1?Q?n+ASGd9Tnesds9JXMujv8SKB8BorDOQ/MDLedvgx53WpgumtdOvFI4tXL/?=
 =?iso-8859-1?Q?673RMwkyPD7XQkR7RWVcuM16l2cgVzBtEylj8xU6ZqkE249Vgvkl+4qXor?=
 =?iso-8859-1?Q?EHSMAlnjEURDfZrscw+GINgquigpiHH5vQQfoTwWPuaLAOZGkmMsmtru1i?=
 =?iso-8859-1?Q?o7jMZCuRcOY24CnNMJcsLKTXdGL1yCb6Ucrmu/9aILYKRxwKj4WL1N2dzh?=
 =?iso-8859-1?Q?gVdkH+/R6HqlL6y6Tgshtfv0Dk/is7gt6I4Marms4f4tpysWAlzfBazNRm?=
 =?iso-8859-1?Q?3AMrwUMLMP+wYOhd8kNtl+cTCY88zRKafcSlL4/bFiLVlFhNwKPfEpze3k?=
 =?iso-8859-1?Q?ar8Gphqu1yWDljQGAUeRhNgeZ/o9SnsAOBc2kOFScDhqbPaoIdq39PPzD6?=
 =?iso-8859-1?Q?+IO4qfKbMJ39er6BV2GELcsjkavSzxOecec7oIpHZ3ERsOj7Ul457Q3RFB?=
 =?iso-8859-1?Q?MUGQlnTbHOD10S80eL7b/sS1ZOuXZRxij5BAY8+50CEV70RrmkMxsukcQ8?=
 =?iso-8859-1?Q?DtqKbnpA/2k28YtlMV+kaQxLzjPu4I2qNE12nv4QkXUHZw+ThoRUkH4Ozm?=
 =?iso-8859-1?Q?ErOCLSUv2z2zTql/kxmVje/O3Sfammx+jRXZTsctHDE9MZSrfVRw+zHq3f?=
 =?iso-8859-1?Q?hURZrGdcU7d6ATl/w/B/xTFkpbsgzXml+Bl/LLHtpxxStMRm485SsDv5ei?=
 =?iso-8859-1?Q?kVsXS8wGjazf8ShSx5eEWr/dGoH6zd6dE0IC6IsEg1n++GBWPsjy9r4+5e?=
 =?iso-8859-1?Q?RAxvESBkrEAHviWaiZ8uogtBDZ+L0KPToCKNlzzMynMDlUGhSY5ugnryBW?=
 =?iso-8859-1?Q?4RDpwSqiaKP26ZojYSag/0fzf+pMn4uuSoO1pDspHiTyAfoCUkbfm/M5rq?=
 =?iso-8859-1?Q?xZQgZPxP3vKzUhHg5JRTcBJn5IDpC+/ICzVW/4vuSi7JHGg6Nesh5cYMe9?=
 =?iso-8859-1?Q?8NU42XjQWzyLHwqiQZqE1fNrwIRT6vMzO6Stf86oVNW1/y0aCWuICBPb+u?=
 =?iso-8859-1?Q?k7WosScXeE+4SqtR9MBPAtuQSTDv1lC8ot64w3Ojo1cUlp8c94Kb4KWLix?=
 =?iso-8859-1?Q?OZl6p1L2O5qB/35sBHHF4OgGIrKep+jM5y3IrhBuYcHsiNB3DSR4VaJjrj?=
 =?iso-8859-1?Q?gpLAyjbqOANCU5KgA9eZ66k2JFFMoR+KzjBS3iJKb1wTMNKQID6G1pIH5y?=
 =?iso-8859-1?Q?uzLEwMn+ABNIrEa5QAk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c44ce2db-72e6-4b38-d967-08dd272e0364
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2024 10:54:33.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOlO/ofFNCsI8TjLU9FrVa00S+z6E/LuhZDSG1EQ43YL9orp7F7Q50tWBKsrRFkUOSEQGZoWS5ktrc6EFyfEKXzRs/NidJfc4i0QA+YkR+gkKY0pWCu4OmmyMLZoiDOR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3887

Hi Krzysztof,=0A=
=A0=0A=
> On Fri, Dec 27, 2024 at 06:41:32PM +0530, Hardevsinh Palaniya wrote:=0A=
> > Add Support for OPT3004 Digital ambient light sensor (ALS) with=0A=
> > increased angular IR rejection.=0A=
> >=0A=
> > The OPT3004 sensor shares the same functionality and scale range as=0A=
> > the OPT3001. The compatible string is added with fallback support to=0A=
> > ensure compatibility.=0A=
> >=0A=
> > Datasheet: https://www.ti.com/lit/gpn/opt3004=0A=
> > Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.=
io>=0A=
> > ---=0A=
> >=0A=
> > v2 -> v3:=0A=
> >=0A=
> > - Reverse the order of compatible string=0A=
> >=0A=
> > v1 -> v2:=0A=
> >=0A=
> > - Use fallback mechanism for the OPT3004.=0A=
> > - Drop 2/2 patch from the patch series[1] as per feedback.=0A=
> >=0A=
> > Link[1]: https://lore.kernel.org/linux-iio/20241224061321.6048-1-hardev=
sinh.palaniya@siliconsignals.io/T/#t=0A=
>=A0=0A=
>=0A=
> And where is any user of this, the DTS? We don't take bindings just=0A=
> because there is such device out there.=0A=
>=0A=
> I looked and nothing:=0A=
> https://lore.kernel.org/all/?q=3Dti%2Copt3004=0A=
=A0=0A=
I added compatibility for the OPT3004 into the driver. However,=A0=0A=
based on Andy's feedback, it seems there might not be a need=A0=0A=
to include this directly in the driver.=A0=0A=
(Refer to Link [1] from the changelog.)=0A=
=A0=0A=
we could follow a similar approach to how we handled the ADXL346,=0A=
by just adding it to the bindings, since the ADXL346 is similar to the=A0=
=0A=
ADXL345.=0A=
=A0=0A=
If I misunderstood then please let me know.=0A=
=A0=0A=
Best Regards,=0A=
Hardev=0A=

