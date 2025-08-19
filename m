Return-Path: <linux-iio+bounces-23000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB7BB2C833
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1F5167544
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851227F018;
	Tue, 19 Aug 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oGDilV6f"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF22797B5;
	Tue, 19 Aug 2025 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616223; cv=fail; b=tZ8XPISbjwYomdaxTreDQC6cD+cp1zQI+cKjRKOfonvehAlekM3ji7cAxCB6kjqXclU7N1zUYcbybc3nEJkcekW8phTjHZOfyQvnif6jotauecH2e1bJFfxlJJCIMpehM0V74Pu7yUzpjhI+Vujq8aZ5pakoUxxuJoA2LplKY5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616223; c=relaxed/simple;
	bh=k38dEU36uAQ2QHdsRcR19es7+YCtJGQk1dst0oz0pco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YDHO2wga1xYT878NwRoozqqm5eLRorz/04PJy8Ne8nUKyveT93QkQpKUxIaRMf30LvKE1FjjDiZE2f1Pje3pz1KDUYCoz5xHWVFey3wshXEYcmI84nzr5ScKPN+UOblPj8P6hppnmrBNFyP/e9aTH2qTLqPGoTQHFZyf2tQ6JUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oGDilV6f; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBBDsj6ymq+6yk3V3nuDioi8Kht+r04RXOH40awzEedkST8nUf6UXrjUzABsOsGJhEmsoQcg8EABngVMV0QtvvcGQektRrJt1B5GDgfSqLL7Vr+ZtARoTfBVF2o4ykXN3EMnxtLcRAvW6tXQy/WphXKdgYBGRQTlwklYoRPzpmb26yEMKl0J+2ov7Fu1mcVNzm4CXLkfa+TuM5pq1xrqXf6+dmhpuOOUtrJ/7uzW58a6RH/wDAEpyRDGPxKSAfuMsunyBzDvoqr8kmpU9MkygVc17sXWGOtgbAwN5KWq9BQ+0E39IZxpcN8U1Nx00/1qmbxqwI5QpD7v+QuhlbPEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVXA3Kl7v914g49l8KxgyN21uNA8RghoGseL8TrFCjo=;
 b=m/WXy/8PavrnOT5A/GHTNkB7TRyfEnZvq+AWigjqdPYggMejnfA6bmdv8EK9dYGccZaBhW/UFkVLW6ixpAkhfBCdcqpaF1/BtjxCikzUOBTxZJgT52lDT5/82BjjIYrXACv0lco2AgFXxaJVcMMvGgiDtIJdcWzuxfBbg3ZOB10r3pGT6MBrVY1yta7pwYyVw6/HByNLoKdsPU/eWBY0iB3SLF1mlyJ3xoug03t07E6GVDtLrbNICZ0qDcCgOV/X4JI7v0Y9oL62IZxiwv/n8+5w0sFxsgukKFjEmQtIUzJ1FZkFSx7gyzG/djZCXpQfry/veHpFE6c/1mr+fYtaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVXA3Kl7v914g49l8KxgyN21uNA8RghoGseL8TrFCjo=;
 b=oGDilV6fz1Xbs+SXj4rFoUGa5JYJgRHKvpZdFq9C7fme7lDA7J3CSwXiDzsgPGS7O5ewyQMMlN+7sv+Ya95SoHezOCIG/3LioBrqCUTxQy0zi9yK2JBx8PGTmynCE93nLMG5XLrC5cNNhbrQePCiFJRVM9i9NnVpEfArIJ5n+a0=
Received: from BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8)
 by MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 15:10:16 +0000
Received: from BY5PR12MB4212.namprd12.prod.outlook.com
 ([fe80::c03b:dbbb:7472:fb15]) by BY5PR12MB4212.namprd12.prod.outlook.com
 ([fe80::c03b:dbbb:7472:fb15%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 15:10:16 +0000
From: "O'Griofa, Conall" <conall.ogriofa@amd.com>
To: "Erim, Salih" <Salih.Erim@amd.com>, "Erim, Salih" <Salih.Erim@amd.com>,
	"jic23@kernel.org" <jic23@kernel.org>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
Thread-Topic: [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
Thread-Index: AQHcERqvGY44VKDuf0SuYOy609Pw77RqFGpw
Date: Tue, 19 Aug 2025 15:10:15 +0000
Message-ID:
 <BY5PR12MB4212A540F9799D6F326003388B30A@BY5PR12MB4212.namprd12.prod.outlook.com>
References: <20250819150448.1979170-1-salih.erim@amd.com>
In-Reply-To: <20250819150448.1979170-1-salih.erim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-19T15:09:51.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4212:EE_|MW4PR12MB7030:EE_
x-ms-office365-filtering-correlation-id: 0db61388-be50-4a5d-b639-08dddf3280e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pLgh6y25B75yrqQm5ZacoAfa2Q1Yxlz+7bNQmv4YJ7RjvmFOKiWSbDwnwwO8?=
 =?us-ascii?Q?UR44zmF/MbrDgHzqTZZuW/I66g7qrZI+xF+WePZwrbvhOU7L3EUAQzFPkK3n?=
 =?us-ascii?Q?X3R02yzJTf4hs3KTd4Z+70/W5IWSFtA2zTM1cjLuer4agHj86XEDqFuhCpZQ?=
 =?us-ascii?Q?yPwjMYg4t8zmCawsHE6jba/KSX2+PgbHbkYELI8QBshvrv9MVriZhNxiXITo?=
 =?us-ascii?Q?vqKhcOiilJfjX8u9vhqAQEKgT4jGsXz8uXBBKt5atgvbop3NQ1T1rwduGvOV?=
 =?us-ascii?Q?qOTrHMitmqCpEbNxu8kuz7bHgfy04gnLVaYPHF3vcEXvU8wH+6NW+SJDEGlk?=
 =?us-ascii?Q?RW2/sBnJa3HVLzXENbpoxoG0KWoOjbAdyIc4sNj0eS7ezvjT6nBMpSwZlSF8?=
 =?us-ascii?Q?zry9GrxaT+ZWXSxhzeNp8RsjXNua7E5MImQQliFjPrADtGgDR5WmD+6bzGya?=
 =?us-ascii?Q?sjv2jtVfr8+SZCUPGywQHoOME9WLPvioBTxNHOsB9fr7BQcZeD9dPWU/mNEL?=
 =?us-ascii?Q?mD/uj40Ba3gjWYyAtDQn+q260HH8QFcRTqJcpNmLjQxbY9mdg/fdXWy40zJ3?=
 =?us-ascii?Q?YmJ0E6o2oB4FdLf+UaEKv90iBembGiTVVShO/hgdPVkJpvDgLRI7f2pYobkk?=
 =?us-ascii?Q?fEWb5CFUiWcdVxrWLJ5j720lfHB4TT6hm/EYNY4Ywgh7b6HPXFVLjOHN//ND?=
 =?us-ascii?Q?Hi4r0xMglkFOlg6QR7p7Ge1gXJXHd56NE+XztpQFpzNAXkLa8qEVmjYByDbo?=
 =?us-ascii?Q?BpWCVUmvEanVeoFyFphHC+34HIsrlyO1FW3Lawaaqrsj5/PCGddjSDlTUjQE?=
 =?us-ascii?Q?+9SpqMNFAB/9qNkPNP3T4aJ4CQ2+Bqu1PJUq+1J8ZnCnNSgxQJsxHyBPz6NQ?=
 =?us-ascii?Q?kQIz5PazyrqqTP5weNEiMrTm8VGyT17KYskDHp3Lt6ActRUbTNN6MbdL+NmR?=
 =?us-ascii?Q?r6xsoYDe/QLiwsm8746rMQykO+fZKYS1k1/jeKJLrhN+aVev5xUm4WgHxCR7?=
 =?us-ascii?Q?RRF4Qfw4f26jKVSFxGEFYcWvCvWVd75DPcm1hdNe/NINAimlnWpT5z+XTcbO?=
 =?us-ascii?Q?VlAFn2MyULEqPEkBPf+poYWJKRVNuZ6krZ7WVIfsW2iFana2KkvY5j2ayAza?=
 =?us-ascii?Q?FIwjv/gwlRS9o9osEEJrMfNgRoXAJY+e3Nk+6gPzFMZsDnTyt15T0aau790r?=
 =?us-ascii?Q?WTqaaaQ4R+jGnNgFqVJjndMR0+gZmChJ9VcjnNDNTYKGXLtK0IHYjSqxlrta?=
 =?us-ascii?Q?glDV2Aehl6VGKhbRLvghr42+4wGVHPc7scIUhcv8ljNJZQcCkcnCPoRZL1wr?=
 =?us-ascii?Q?ENISTelzCoFqh9+0gQtevtJaEX9syqGb/6eNP2P7IPV0/43E6x+TuuZSarvS?=
 =?us-ascii?Q?1BtQ4yaSP7eCSXIHTQGi8WYra3iKH99/el5/O+KbzFar7bDpd82CNC/ananm?=
 =?us-ascii?Q?OEpJmjub9AM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4212.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DUZ4q+w+lnsX/HGXDSdV8NMklF/JeYxD2zbMGlrQPS/kByXZpgVGgsiANqYL?=
 =?us-ascii?Q?4XAsvhFtTWJM9yuXfTqGPqiVrAod/h9hSPB29d7FhvHAcFmKJ/WQehguvNBz?=
 =?us-ascii?Q?bezaLHfNbZEPE6gZ8jSbpfLc22vhGgysKB6+UKmSxVJ2KZiawZm4Eguf5lr3?=
 =?us-ascii?Q?5oBQvaq13eJq38I4nwI0+jSsLAguU2rrhsHqN5IOKDheirqU0w98N3ieMf9J?=
 =?us-ascii?Q?MDUClC4V5ALzSLqYJn0llaWQ1KMRMH2iIVaIeZ+xtWuDctMDLobM/o7CRkZ0?=
 =?us-ascii?Q?BRZFVsv49vcSAxA7DV3OPl6RhFbd7yoRsDjXj8K7H925ArUyFmBOx52tyHAG?=
 =?us-ascii?Q?meFB1pVy3ENnGHbrlxmjZs8HwZ2p13RAfQOywDNxqpk1Xqisof3E3WaJmtRd?=
 =?us-ascii?Q?fjycGKfMEKfGHFrq6UWIvkKYHdkNeJ5vYrTY+0toqNZJjnpSKCxPSUAZWIhb?=
 =?us-ascii?Q?5MRFJAH2wWK8sAICNbsT+VFmOX62ZAEWMazci2hq9jAqWbk165kXaFeoJjS2?=
 =?us-ascii?Q?GJfDmPS5mH4VddPxFgUc0U5qjHtzYaTl9mWqL1h6WWeZf9hS7Mfk/LdIKD4B?=
 =?us-ascii?Q?t0TroN0B9pzoH0cXx996oAQCHNVO9xH1gQht5PDizhHKRJxo0XBynJYDgJln?=
 =?us-ascii?Q?pEzR/cAbzNhf3MZSbsQtoIVtbCSXva5nir99Vek+KXeXH5M33aFihijkMo0q?=
 =?us-ascii?Q?URcTnuUZKQ/izGtTekxX8dNfmNPjaxtN+Bwz0g74wlbMMymnAqomZpF787V8?=
 =?us-ascii?Q?Z+NgzXQ3kUmFAxsrMAAGIATWXUOXO6MI9JwdS794vf4XopPv4HL1BN2DFLx5?=
 =?us-ascii?Q?/tatygHt8/BOlvg4jqsz2LDNfWmhBfqdCsuBRsNVp2lU3sSL+Jt3u3fsqCg7?=
 =?us-ascii?Q?5mBpIEUTJekLjhdds4bkaF6yHhoQXKHZgaGBc9KhbRt4Ppg1rwsiTrRw0ijH?=
 =?us-ascii?Q?eHSXEOvrG2JfIoHlfrCIl9YM/sLHCYOuDx9D1id/cab3UfMOGqDAEX8cxviz?=
 =?us-ascii?Q?s2bmHwhMfB2rFJALsEZtxS8O/PmQMA5kP+RGwXSz5Qy4H/MAvxtQ9PzV82Kr?=
 =?us-ascii?Q?S1JWtRSkXqch7w2dY27N2HmicWONhGRJz3TddTBCQhIV5NMa6ghCzzuyiJNQ?=
 =?us-ascii?Q?ryzUZ2o6KPFFq72ClvwwQetinX2Yk+cmqqdNF44GxjcwQ36YN/ApV5h5QWcd?=
 =?us-ascii?Q?hTPaZNOk28igm2sQ4ObYd+G1uqmsrZAjkB7kpgW04+VRgvl2fE5MFCBLidjo?=
 =?us-ascii?Q?RHspLNL+M4Z2WjjJo5DMrHSg2pxVOmXnIsLs1zhzTDLnJOE4GL1MLFlQCup3?=
 =?us-ascii?Q?qBDn/424MmSLZE1nYmN6Ls5oL2EKcHN2E02sFtE6Cr5SKp6GSsct/zQesTlv?=
 =?us-ascii?Q?4++ZgLCCRRovaJ0YqUMex+ktFMosLpbasDs6jcwxpK78Q+nLmwUmUcroYsQ6?=
 =?us-ascii?Q?O6k7ujIFKYLerbUZaYnvxCLoVzqbM2qKnCrxWCp2nyOCDc1TGgqkrMuvNFJ4?=
 =?us-ascii?Q?UBAh00pNsL7s1m8OpM45gYwya5Edlh4Ln11q/JdWG+Jc7px5xUSflkG649z4?=
 =?us-ascii?Q?zfqJ2Ie5MC7wux04xHE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db61388-be50-4a5d-b639-08dddf3280e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 15:10:15.7144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMRMZrbgJ/GMb6bsUwAILTREWKCZAN2oc1m1Vc3ZWiKH7dp3Qpgvcp5cNx+QUt00
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: O'Griofa, Conall <conall.ogriofa@amd.com>

> -----Original Message-----
> From: Salih Erim <salih.erim@amd.com>
> Sent: 19 August 2025 16:05
> To: Erim, Salih <Salih.Erim@amd.com>; O'Griofa, Conall
> <conall.ogriofa@amd.com>; jic23@kernel.org
> Cc: dlechner@baylibre.com; nuno.sa@analog.com; andy@kernel.org; Simek,
> Michal <michal.simek@amd.com>; linux-iio@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
>
> Removes Anand Ashok from maintainers and adds Salih and Conall as new
> maintainers.
>
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml | 3 ++-
>  MAINTAINERS                                                    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.ya=
ml
> b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> index a403392fb263..3ae1a0bab38f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Xilinx Zynq Ultrascale AMS controller
>
>  maintainers:
> -  - Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> +  - Salih Erim <salih.erim@amd.com>
> +  - Conall O'Griofa <conall.ogriofa@amd.com>
>
>  description: |
>    The AMS (Analog Monitoring System) includes an ADC as well as on-chip
> sensors diff --git a/MAINTAINERS b/MAINTAINERS index
> daf520a13bdf..b4b27a31a782 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27537,7 +27537,8 @@ F:    include/uapi/linux/dqblk_xfs.h
>  F:   include/uapi/linux/fsmap.h
>
>  XILINX AMS DRIVER
> -M:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> +M:   Salih Erim <salih.erim@amd.com>
> +M:   Conall O'Griofa <conall.ogriofa@amd.com>
>  L:   linux-iio@vger.kernel.org
>  S:   Maintained
>  F:   Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> --
> 2.34.1


