Return-Path: <linux-iio+bounces-6197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3E905364
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 15:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC301F21B2F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6CD1791F4;
	Wed, 12 Jun 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="C9mWILBE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F4178398
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198002; cv=fail; b=tg06Ng+g1U+KVAqKBtuICsYj90BrnWRnoiPqs1zhovyumHW8qAzCraXtS/DEmZhNo7SCY3TbquWid04HLQh/J86VDlBgQgIlqbrCZVGovheyu+MAtJSxeQOhXqvE3ZfHbvRXnu7PcWAah6NmAYEtH2Qr5S7hOyekJxPItKNmMls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198002; c=relaxed/simple;
	bh=dAMr4Ogw3xbXXryZPwe+RFYDSgttBgRI2S6C8KSBddU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DML7vyK1lwL5Y7GQ60Aa4q0hWHKP/c/VTXygjknWZq/RqEQBIY1/l3R4PPDkcoA5ksB4yidProLBRL7DzqotNO4j2YWWM7XVYKtAL2eGeXhgCLfh5Dgo77Ne6JA3SwICYp6ZeeXPX4nLWe2Jf1bs7hvF+RZ3+eYc1+6PuTg/No4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=C9mWILBE; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BMml5Y022473;
	Wed, 12 Jun 2024 12:26:22 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2172.outbound.protection.outlook.com [104.47.7.172])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3ymdnyjyrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 12:26:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igR3CHDfQBsespOAB5y02kYPUL80/JSq/NBvgGnDwA+Nt3fIK71iWf8inPAm1DVR+v/bxfDUw+DaiXR0ELnPeZiyrCVyTF4KznuYh3B3hGZ+QA9BQD7n0g9LTDMiABI70zpTPXJbt9PSCFAy5BSOjCEVVi9W7ju5Eomj69cjAxFY1wDCoBc/wEmAHYhu+PLxfPzuKG5b0+SxW8H4KbRq6nci9yBjiLN6Elgln8tMv+3IfMr5TTQu19fO4s40mISYh8tXN+a36rImw2ui7WlPiH/+gVh1xELecOa3GeOu4VVt0r7X/SKQ+Ko8N6eE6xhZrzdyAyy7s+2ybX3qF4DP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAMr4Ogw3xbXXryZPwe+RFYDSgttBgRI2S6C8KSBddU=;
 b=ONlaAJYYouuib60JEK/M5iLJbZUu7tvYLDY8E/qsvxO62tM0Uy5rqBD8ru+egIc2PRh1ORpXaN3mhzlyNI6AKdfilFw/XTwVNuqRLcQVD1TC5gIZmMVF0JNVRWxR2mWE5103cllNzqsbv60UWBkc6WKHwzE3DUCH8qRIx2t1BFPaGVHhkNC/E/bZADY4oS3NUD/lze2e6RSpeiEoNVcURHHSJWX2l7l07xlzw6vhCdtl7O077IwzFaTzPPuloBcT9MklXXhJRLKbSDdOSSpw8ZrLgzHCp5Ho58/gzRB1rIKLjWwkcwkLUgSHFApnY0EMz8Z3tsGDViue03siicYGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAMr4Ogw3xbXXryZPwe+RFYDSgttBgRI2S6C8KSBddU=;
 b=C9mWILBEH8EXP4wSJKm4w7WmspkStNc04NyrxZiKrnGBwBRWYwCQayYU3jknm5VBmBi3CJkAKScPV0yJQ6L9q0U+S0hHitf8NOC5siPeRZ3lPFLOqIWBb4jh+BIQkvx7a9XML4u7m8lT3pz0rwQrIzEuDqx+xL71fy/Sjn4xoLZPAqtnWwrnjnnFkq/A0UWYZxpVljsLBgfN+ZzlG+uNaE01XrLqh0gnkc2QtZsxZij9qPSYDORDu1JUuATc1hKWSRJRS2fHNRr3qDOtyMoudkMW0QyV0vBSz4Oac5y2BRu9ongds4t9kyyF/1SnpXTS8DVEMeVNVBSegQZN8IqvuA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR6P281MB4537.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:131::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 12:26:17 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 12:26:16 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Sean Nyekjaer <sean@geanix.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: inv_icm42600: icm42670
Thread-Topic: inv_icm42600: icm42670
Thread-Index: AQHavKKKX1XTBHVPBUittfkVUpb3ZbHEC8Lq
Date: Wed, 12 Jun 2024 12:26:15 +0000
Message-ID: 
 <FR3P281MB1757036E338AF80CEF7555ACCEC02@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <7s6uxp3luxdenurhh5kcgsrokiawtrlzn2krqphotoeuir5xol@yqhbztxiv6by>
In-Reply-To: <7s6uxp3luxdenurhh5kcgsrokiawtrlzn2krqphotoeuir5xol@yqhbztxiv6by>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR6P281MB4537:EE_
x-ms-office365-filtering-correlation-id: ce310837-3709-42b8-77db-08dc8adadacf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230032|1800799016|376006|366008|38070700010|3613699004;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?vW/vYxtoFNqKJv0UYei6Vtn9XtNtvd1QDC1gsvSqIPgOQz4PrAKf8vQTHV?=
 =?iso-8859-1?Q?eIz/RgCjOC6QOfbWWwcBKBsR7oo3tvOXF2Ea/fR6mkp4PO8G3xXRjvYuyj?=
 =?iso-8859-1?Q?hwFJFDdVivweqjs6ldrOd8nRm5h49LXNfXUCabeFok8IqLzSHFAQ7Lrqeh?=
 =?iso-8859-1?Q?H8lgTEw8Lql5w5R5Ch5VrEOwphhMENSeru2pfNjEUFODX9bGz/b3svPFLy?=
 =?iso-8859-1?Q?kOfoodPcsi2j/Ui1O6aDWylnERJ1FT5cBgMqF5EeO6cZpZIG9jGhMBN5lX?=
 =?iso-8859-1?Q?2NSDYOzAFkkzuLvST5yOO8xz2x5gBHPnxSbwdAlcwSlot5cUwS8NX6kEh1?=
 =?iso-8859-1?Q?ifaIUlih58X9/wOiMBLpUlFkYkfIeo4e/EbUFUMQF2g5Z85UYAuN2mwb27?=
 =?iso-8859-1?Q?fAc9rgjXU6aqaHmkFEiqzT1VECeaH2IOVC9DeWS7dVWUviUyWFOunYqUaB?=
 =?iso-8859-1?Q?ULN90gzHM2ZhqrXfQPkYk6cIy9ZNnZs2Tivvyvf7SDbomaJS0mY/828PjJ?=
 =?iso-8859-1?Q?r+aiT5zjrNIa1sYBVhpZpIcXcXppk2ZL7t92vmry+WD/5Qs9mD8CA7TZQk?=
 =?iso-8859-1?Q?M69kRvxVi2gvCbVn0PNROkyIRNyH8jHw4dDyAPDjR7/YtyEk5O5sK0e3kr?=
 =?iso-8859-1?Q?fEJB9r858QwwJ3wdXFxpzjx44Pmc40uRRnOBgirp/MFG6JqOfjgXiCiMkK?=
 =?iso-8859-1?Q?elLeuCYSrtjCwPVfBJ6/ZIQcrc3n3qU9FtA+9PJKK0tujAfqw+/0I4NaCa?=
 =?iso-8859-1?Q?VpTs3Ur+eV3JoEMcCBOl0SZ7FJq6wx/1Aid1ejz3pT2Hs4j+XH9HLBwmmi?=
 =?iso-8859-1?Q?r6yvO7TljdRzuJf+29N39DxyB6pTLV9mGf+jJw2ehV1zvqvu3kQLfDKbPt?=
 =?iso-8859-1?Q?sfr1p4pV8iPafGLj+ubHplojEo4lUOyalhMP9xOntrUXRa4pgIu6Kk+6Yq?=
 =?iso-8859-1?Q?O69lX11c3752Elkh1qJGCiOURfVHg//WCZ7k3amj7pnpOyjp5NTO8ogVop?=
 =?iso-8859-1?Q?xWr95plqMfOuccNQswX/s6QNxNyG3H4eyf3lldBqJ3k7g2pz2tXmglg7aE?=
 =?iso-8859-1?Q?UNen34Ce2kifpguJV6d7gPJlVlDned83R0lkyIr9eoIYwRdfhlmQMWc8dJ?=
 =?iso-8859-1?Q?0Ta6Cquat+Wfu6b66ToKoVpQB/67rkUZkl1pELqamwbfBeNXtTugQ655OY?=
 =?iso-8859-1?Q?XuyqKBk1jkTaYwdQOfU5NuH8C72RarrZEF88F0ahuuHfGvK1OxkwrBswmz?=
 =?iso-8859-1?Q?SXSP6u9zywu21KE/8pM+Seax79SDypXUrJjOxGn8NzjEOd9lMXNdgLJT4u?=
 =?iso-8859-1?Q?IfTwzBzQhNy3J+49FWBCDJX5b/PTFJSE+/EPtbe9C7LD8DF5n14C6r4uyt?=
 =?iso-8859-1?Q?ejumJzZAKVxkzD5dR3cHk5NtDnHRqUBEx0F3Hzp6hpYWodPAE5wdkZmGjK?=
 =?iso-8859-1?Q?cH+BADRU94ut11kQjrX0U+/miMgX1DpVp/7D+A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(376006)(366008)(38070700010)(3613699004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?1CSg/XCFMJD5sIdH2MPnYe2XA/KqoNC8XE6Q6WuNvGprE9uxj3Vkwgg4zP?=
 =?iso-8859-1?Q?oCRS6Vy0gFzUsBGkjo+WRFR2QH1S6WiUcO3EIu8deqjr8HTqMxBD1vbA3F?=
 =?iso-8859-1?Q?wH26CMH8zdCKlg+SpsTA7Bz+9fNRWX91fRTU0f6Ftn/mt+fHVjXQIFLGER?=
 =?iso-8859-1?Q?ZO5+p9cDjiEuUHH26S5+sNN5vkI/Nt+qMPZbOjYtMqnVrmFcJU2Ly/5Jl4?=
 =?iso-8859-1?Q?hlmbmdcz5Sc7coPK58Viry008NLvKxowOq9qEdmV6TXGd/tPGwp2aF8WHP?=
 =?iso-8859-1?Q?X5e5XPYxHm6qjy/pyiCtfV6hVN7ERXiMgQeMGl1VfCuvzQM1HFMgifS88/?=
 =?iso-8859-1?Q?IR6lO5LGTM+2VggyxwbkD72pAjrpn7j7i8epUFe+JqsqwvNiq7WFjbvh/n?=
 =?iso-8859-1?Q?JHIFFOk06oCgzATwLPxEGLUfVLGzuopMWr3SIr7iiFcOnKW5zWHXFEZeV2?=
 =?iso-8859-1?Q?adDWNGOtmNW9NZNfSjzVrtGNx0+xXjobsLjn7weJudN5Pso9jAebEPhJl/?=
 =?iso-8859-1?Q?+PQk7gkW9YLU5nR11jhRyoHhte24ZtTbhkeWMugSQrF4+8RM70rInxpXI3?=
 =?iso-8859-1?Q?YNAZ8CUOGn8pjr540IfM/aAAUUMcZTx3g1QOLEbr3qXt7Pch5tzJ09ROxR?=
 =?iso-8859-1?Q?YR0aula5g4sh2e7UdRoiyVLcSgTUbjwWGiPtBdFS3yxDA0EU0j4SP7WAyK?=
 =?iso-8859-1?Q?Q9Xbd9wsmT3Nyh8SElFxyR0S488eGE6Gv97K//CJY5DZ4d4jD9WmMUpy+Q?=
 =?iso-8859-1?Q?ZgjKblda+5hZvpFqyRzw3T9YrmtbZ97Kv3zQTNEnVyiDveUuUr3s6vbO2U?=
 =?iso-8859-1?Q?dileoL60phgBwU+03D6YXGZcN6sAKPbERDsBRNczoJqZbZhLyeioKox5tY?=
 =?iso-8859-1?Q?N7Dl+I+Z5SCIX0yhHP7whyzzMrc6kdxrTPAHKTZKYQa6DUbitw1/pAYa5O?=
 =?iso-8859-1?Q?f0OwyMW4bwdmUnNz866wiPYw7lfX5RZyHeSRykcpEjd51eGrv9YKcvagNk?=
 =?iso-8859-1?Q?m3r/TmDZh9sbhxkomP5WmJo4RSWg6W/fw+jDsH3WkccGDSeGPPFM78Yebd?=
 =?iso-8859-1?Q?6Eit5jEdzE7xd+FvScjl4PbC+NdkLf1553VL8DAAsC1zKL8SFeL3JrCMwr?=
 =?iso-8859-1?Q?yrLWgMi6driRkSOQr6/SF/jzbtIMFLldS4Lfsl7O3pqu+KMU6/X/pYf9vc?=
 =?iso-8859-1?Q?VZd55zeR+AlDWcoHO0QX+VzS1gv03H4GSoHIxZRFUsAqOxSoDiQVesXfYH?=
 =?iso-8859-1?Q?GS0YZgWz5xHIagU2oxccntmQ3j/BMb28vLlN8qNaUaqCB/171q4BEgksU6?=
 =?iso-8859-1?Q?Au3TE+v8DxUaEt4rQUd21uNCh6DNUcXwo7MenMTbPldC4AXKt8DbTohZtA?=
 =?iso-8859-1?Q?1dibXslB/DX2UbkEa05RAZPf2Uo2YWKNzI7S0zwzKHjzSOLMVTAzMCgFbf?=
 =?iso-8859-1?Q?cPZVEZbE1y6sGmh1ssPobwP+pTg2K48fgg3WKnU8A5uV0PLTZ6ldHx3g0n?=
 =?iso-8859-1?Q?Nvpvw0rgKo75zDegRrZeUzithmWY5GULMQE40qkwRvXkBKmbaF4kH0NwPX?=
 =?iso-8859-1?Q?fSEhOq4i3Vd6q0TImTRPJ1XuJ21LkxeXZ7dq6DWgPJvbXX/90BlowA2+nW?=
 =?iso-8859-1?Q?sCMoq7tPdgrz8hYL/CZdv3TOfwdOPUAaJaNhF4eC3H6eRr7tdWvu7UCQCT?=
 =?iso-8859-1?Q?mc3G1Yd/oSRJImu1TWwOLMnMOlWiYbr8Q9m3N9XU6YndvKDb1XQ9skRemX?=
 =?iso-8859-1?Q?iAOg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ce310837-3709-42b8-77db-08dc8adadacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 12:26:15.8195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTMsiANavE7BtwD8rgz1MW2VZuy0Ls1Hu3lqgke/FbbWhPycgplqrur/WxudI0dluR8NADi1CkKyhyPeRYKjbU+h+rAPOxxP5+4h3Uawa2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4537
X-Proofpoint-GUID: kAOBsBQcwknOBY7TGEeZC7Quh54PAH_9
X-Proofpoint-ORIG-GUID: kAOBsBQcwknOBY7TGEeZC7Quh54PAH_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=563
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120090

Hello Sean,=0A=
=0A=
despite its naming, icm42670/icm42607 are completely different chips compar=
ed to traditional icm42600 chips.=0A=
=0A=
The icm42670 open-source Linux driver is currently work-in-progress in our =
side. There is a plan to send it here when it will be ready. I'm sorry ther=
e is no timeframe for the moment. We already have an internal Linux driver =
for our Android solution, but it is not a standard one.=0A=
=0A=
icm42670 is sharing some things from icm42600 like the FIFO, but it's almos=
t all. We are planning to do a driver with a single iio device and multiple=
 buffers, different from what was done for icm42600 (at that time there was=
 no multiple buffers support).=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Sean Nyekjaer <sean@geanix.com>=0A=
Sent:=A0Wednesday, June 12, 2024 10:28=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; INV Git Comm=
it <INV.git-commit@tdk.com>=0A=
Cc:=A0Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org <linux=
-iio@vger.kernel.org>=0A=
Subject:=A0inv_icm42600: icm42670=0A=
=A0=0A=
This Message Is From an Untrusted Sender=0A=
You have not previously corresponded with this sender.=0A=
=A0=0A=
Hi all,=0A=
=0A=
I got a custom board with the TDK icm42670 fitted. We thought is was a=0A=
simple ID add, but I was somewhat wrong.=0A=
Many registers are on different addresses and so on.=0A=
=0A=
I have done some work in the st_lsm6dsx, that includes many different=0A=
imu devices from the same family.=0A=
But the driver is kinda hard to read because of that.=0A=
=0A=
So is it better to do a new driver called icm42670 or should we do the=0A=
same style as the st_lsm6dsx?=0A=
=0A=
@TDK=0A=
Do you have done some work for the icm42670?=0A=
=0A=
/Sean=0A=
=0A=

