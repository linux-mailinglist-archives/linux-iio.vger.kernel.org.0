Return-Path: <linux-iio+bounces-25593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B35C15541
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 16:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6137A505A3C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DF272E6D;
	Tue, 28 Oct 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hbEpxAl8"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C371170A11;
	Tue, 28 Oct 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663793; cv=fail; b=c8/pxP0I+tJAvVHEVKoQAlNpDn6jVIxxj+B4LfNNNAxM6tj4kHD/LkmJO37tD1eYB3khlBVT3Ux9bOmUxW552c9Fk6QrhPlL+/yehJ7HZVEt8hwhLDc9Q2Lk4nrE2+emH6ZKGv2W8F3cIumJJof0NFgpKswbP+NG1W5ro8mV2D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663793; c=relaxed/simple;
	bh=W7h1xzHerdMxlHUIJYGiADXISB1q3uyUuA/1GMc7Qwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tcpBtXWUurcuzpsTB0aK5Fv5/RzX0Z/WjLh3Qw3ZgnJrSY5aJqlnHFKyQk9N7YivY4ksZahf9O+YKr0XWKvgw0BegGWJ1MMQ0YSnej0nkeU57996Bxymgrv7uRKn6SOIFrh1hBv7qpu6q/F3B52bSxomxi20xwHjzOpGcyzXnlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hbEpxAl8; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dr6EwqA/zUhbYGsLCC8P4E4yFfG6cMjlfFfOmi9Y13gmoV6o0d6ll75gqgiOgvX9A9YHrzM+sX4acvMd/fQpGyDKTpAerfAo838DS4E0G0Ck6U0MWNeFt4bK5hBwlE9skKOR9GEKoN2hqaoU21ZmNrYM0u1ghTlU/jSw4WCXR0bZRLeIC3riBrSLy3CJYakC7CpPNQ5G08fXWbqPYZVI439A3/PWInW5VO/rRJJ4JSbNPhrR/ZvbDt8KGyBlsyn7YeFmUMX2Y4AO7qQAm9CzUeMQXJ3IdWfxbUTkAvAOpS6Z3zdSMEkSUDGLJ+oej3QsN56mtmDAx4dExBUwEwLcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7h1xzHerdMxlHUIJYGiADXISB1q3uyUuA/1GMc7Qwo=;
 b=qASFcx7qk4XSYkDIBD380q3jTFVG/qCS+DMLI591r9YhTJJ+S9ZIQv99tJHdQf26BAhMlqQdrKLkwMvg1gl8VWTDvBIushGfp0a8KmCzW/Mfx13GdU0EVmroRpXEzwc5Um1aTJNe+I4VPDuI4TolV6bVr08tDx2RmoxFNAsAggfrurlSEFug0cFmXnf5D5U32g/fACnDHbufVEwztk6rmu5aX5gFJaqRRkCJ3jPHfrBEUOqrG7Lg9kW9knnrFm18lmw6qDNTVjLi3YChWodh3pt1HltxfHd2uMho2rJavdEP8SAtIx9Vp1SBtJZfOcyTFguT+fWUh1Wi/o/OINCOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7h1xzHerdMxlHUIJYGiADXISB1q3uyUuA/1GMc7Qwo=;
 b=hbEpxAl8C2bjSZ4lnmIyX0RQpavu41d0496kxe1ra08Q5kKQ4DON3dGdwXRQnoY2vU3fVTyiprh+LsME+uuEyh/AxJfJAXs7Yz/kqa5TJxPvU66Ke2Xz4gUmhOVn8r8HCR+J8KKV17zSsEh83SSNub7ZgZpd8F03oY2kfGXyEuwBuLMxjpNqtD6KEbajG3Ba4DbT8AAjojTMUVrTrgsgnIIwiGpW2b22DPk0q3jwWeWBoigOP89RPtjpl2OiPCrZXp0oGvuPNupVgUhw4zwjfN2PfPP/AvOx0pfR/9lU/hRN4I5InSFjYBX3lyQbTqY7Z+63mi6NuX1RydeLuMr5FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB9097.eurprd04.prod.outlook.com (2603:10a6:10:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:03:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 15:03:08 +0000
Date: Tue, 28 Oct 2025 11:02:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v8 6/6] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aQDbI6hving7xzep@lizhi-Precision-Tower-5810>
References: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
 <20251028-i3c_ddr-v8-6-795ded2db8c2@nxp.com>
 <aQDY-9CEOlA74A-N@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQDY-9CEOlA74A-N@smile.fi.intel.com>
X-ClientProxiedBy: PH7PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:510:323::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b73185-17e8-4abe-2bc0-08de16331aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGHg3SHS7X7/19Uml2knUMlaHLeEWtvHcELWRM5BfxviLnyQ1RnwjOEYyTTX?=
 =?us-ascii?Q?6buISDdL3nq4qu/21E640zxES3IeBMwx5GqFE8u15mjhbaanIHXLx0spVh/Z?=
 =?us-ascii?Q?XzsEYp1Yj+YHWKN/PfZ4x89VpgBi3orheoFrT3i/hD42TVyBlDe74VFZLvPG?=
 =?us-ascii?Q?/dXB3roVNcrMse8I34ozbtf3wNgrx4hzuHHMzD+Hu/XL8tbKL2AAFvBlbnt/?=
 =?us-ascii?Q?+a8/BHfju2icWihAZrsGIRc8+QmL6XX0+k7maQ1RcOqdZBp3/DSoTUhs0pom?=
 =?us-ascii?Q?6vpKEFuRzPlB22L6MrzMTg790oVC3nfH3aYMnx7N89GHfcGQqe2LLzWf6vDt?=
 =?us-ascii?Q?wBz3YYo0gh3l/Fa4RIrRanIl40VgqtrbdmTLmFgZ110M7gOdE1ZL3oPl+Lwm?=
 =?us-ascii?Q?nsgI4D/Tw7E6ESG52ISUd7Q0MMePXg47MbuRS2jXRl3utE09AS8WgAuMtNnN?=
 =?us-ascii?Q?Uj6EcXoAFJOWWt9x6ieWJC6Q1jx5QY8sAkqJbmSfuYQEgAF0Pzp6kwJSOdah?=
 =?us-ascii?Q?jNvw77GgpphzRXWDqyqZ+n+8DYaklpa+oixFTVysOHs2RqCgkiNOUxELwPd6?=
 =?us-ascii?Q?Hw+Y+Wzr7SNrV4vzEyRpjp+gYjclm+dHoSLMp/+TDh2RuMk77OyQBYsZ4qGf?=
 =?us-ascii?Q?G1n2JPK8XGFGAUQoNjJ3/KA2Otfu/RHg8DFU7le8OhjV5FO0JG5gHGtUENrf?=
 =?us-ascii?Q?6otKSl1cZaPzwibJ/jfhXSjPu4E+BoTADTIGqA9dCkpoXgOlZ5HQnFEo9joI?=
 =?us-ascii?Q?gAL859JXPuSRFmMIDf4/bMKquTsZgfBb5w1TqEzg81HasFWQu4P0KTCDPKxX?=
 =?us-ascii?Q?xjAJYNMj/gndjM0EY3HRe91NP5Qdy5JlwjEOYj3pkDn/7lPQB6mSmZRBaSGW?=
 =?us-ascii?Q?4dSsG9NpKbm8MJUWHo+qxJum60N/jK/JOLAwP1aDSQTAzIHLFj49deHRBYlm?=
 =?us-ascii?Q?Yr5OzjYWG4s6ytkcwnxdhzxTb+Yphzr0LCFSw+fhrBT9IFAvKZPbYob41Mzw?=
 =?us-ascii?Q?Csm/PWn4RBoEUfnupTV4PW4BJdT9QH+9kq3WCPqqddbbOvjQmODfPgpHrnbk?=
 =?us-ascii?Q?rTFKQemqI3oztH78Rdpejt++AcnJmHAkAGbs/AZtWoRg8/ufwCCZQ+iSxObR?=
 =?us-ascii?Q?+GW06hB1yhUZRLKDexBC6oRdcVJiLAxZpLl4Wh/DOc2389In3xsNlZQLlvcB?=
 =?us-ascii?Q?ZPiENC6/UMy0pQhvMuIbHYwciF+zsM71k0qguWVhSvXqPgZVVn4sZbjy1gxq?=
 =?us-ascii?Q?pF6NhfzBQ5ITyQzRGOUsBUFC+LmZfE3Lr1O6DDO8JvYyJkStWxXOjbDlqKhR?=
 =?us-ascii?Q?YHBe+pBVtuQbnhYpwSSX+VyNSh/aP6OpFKGS09KdMr9IXcD77zvh4ssHBHvJ?=
 =?us-ascii?Q?wJVSMThLm9+Wq1It4Z53j5bI/guUftwQwpqaEGxOX32NQa40s5WkK43pHtat?=
 =?us-ascii?Q?MecC5VsTZX58sH7WUbotVya3mRWYfA/lfXMr3MdmcXomOQX3DI1t5Ex/s/CN?=
 =?us-ascii?Q?h7zjDQR8CZwSTLC8nYJOO9KCqTvr4OIYnTwI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s5+MjBuEOqXjX7ZxPs7lAKr2SvclB0YiVZWpckdaupqvs+CEfcfCLUPmzuZu?=
 =?us-ascii?Q?iH6Wl+5vhYiN7dtf/3OdO698unwu2eaURQeoYfQbxYn171U5mpR3nP5OSG8j?=
 =?us-ascii?Q?YLiV2T1TppznYpEMGYr3gyIqAZWYJw789z3lXWqmpMbEkl9czfqNJqYb3iti?=
 =?us-ascii?Q?Yw7TyW421DfkAZstgk1nbC22/JlKx3NFQF4bE6LWKY53jHwlHTyiuKJoE+mq?=
 =?us-ascii?Q?QegyVxUM5sl0GgNAeShHVQG2uXQ/3Vh4pTpIsVh0FgXHx5P0NB8QwzO0xq41?=
 =?us-ascii?Q?313SAcy/5M4mThE8DFXIZkFqnILaVKbTZGEIjZsCIAmPcmD7DVG0siNw5IB1?=
 =?us-ascii?Q?yYnf6M/Ll2OZefmOwNRPr88ueu3hi0Cez5KLcjh+Vznr3wlqs+yEGxiMOZ/Q?=
 =?us-ascii?Q?ceYLKrEBAZpxwuexjD/NbcBXXMJARfBsuZfl0JSJ1tQN33AJsM2ucaqi8qQ7?=
 =?us-ascii?Q?v8j7D9QxdKS6/MBDvWiIrXoPbY8H8W7aeElZMxPc2yZR35dTkBMbQ2PU46iD?=
 =?us-ascii?Q?4qB6ixhs2wSuuw/iqXcx8+0oC+CwNJ0vKuQaCBiWvGQf1bRZJS8he0MaVFOZ?=
 =?us-ascii?Q?ukGI+ruMpGNrUSKifK1fC+PlF8s/4NpdV/EE4b4abnhjwJojasvCxXtyEzaS?=
 =?us-ascii?Q?7Z6qpeOdwYY2uwGuDOOaiLJr8R1t1bXjGRYBmVxxbU95kthKjpcteTXOO/2j?=
 =?us-ascii?Q?PO006PaMTXSMXJMJG49PJSuqxUUrayHybNyzBqKRjX7R13Cl/zVVMIHCSfOR?=
 =?us-ascii?Q?hwWzdyh1qixZiY3ZJUMkH/VQeyjNZMXuQeJFiGrrJ7x0WKGzRXt9H79uNGGT?=
 =?us-ascii?Q?o3sZMalHvO4F8s47CjaLcvvrUvmDgLobeJSuX2/KGjcNvatI2VUA5z5f5H6D?=
 =?us-ascii?Q?K88E+g0sl6p0klco+dChd2nldgnEe6UfhmS6ocwKziWMGPCY70qennvDA01m?=
 =?us-ascii?Q?xPPCX4tC5mF0ziWZYBQxItaqNnLW6HMHDH7sLx8SjxyldvqBejaWzNW1FJi+?=
 =?us-ascii?Q?GIfJ7x7nIPNGrTOl/ps/z/vUTPnXaeKzxKxS4MZhYhoJi8DY7CdaPy3QNdpL?=
 =?us-ascii?Q?4PlOusOWM2EW4na+Ph9eV9XMj+NIrYJAMYtTcN7DYFBIW9Ga0RJcPoJPMpdB?=
 =?us-ascii?Q?J8MbmKIeY5MDft5camuQfpTFWp1gWmXxvfI97AwR/zzimzI55nVcuGvJBEWK?=
 =?us-ascii?Q?hp4xm1FGU4GB6/lpdFYzhvzkEddb2d8CMKbtn/x42rqXT6j4N4Ac4Vp2VRm3?=
 =?us-ascii?Q?RHjumjT2Sts9jg5FPaM1CW3N1tlshD6PuJbmwcMnigxVG445LD9mqnXOnHwX?=
 =?us-ascii?Q?EMi6xmETA6AXXweWAyJKHptr+dHwiw32n5pmXzZnNYGaXNGkfW+Ab3PR2nMh?=
 =?us-ascii?Q?oPqRMDnZ67Aj2/Gdnp7uxXpu2fsB5soUHgpBwkks4jIOrLDyEana20X19neb?=
 =?us-ascii?Q?mV1YPr62xWifkcKJRbmEt/mtfRtlaCTUhObuOawvrQ+/OeeuagNXXSoK0JlJ?=
 =?us-ascii?Q?pXoSYGUnD7peqDz8IAKoesDIw62IRiuZID6ywrEO4zngOGaZrW4NThE7Cqyf?=
 =?us-ascii?Q?jv6I39s3yurGZ/tc+WST6RMq8Tvx0FAmh01ZFxLf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b73185-17e8-4abe-2bc0-08de16331aa3
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:03:08.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0SlRSCfIm+wy0CkQag1UdZoWcr3hInDgDkcu95IVlorr6giIYApXLJjD+lJmCbli9VimftVabeQvJcw7ijESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9097

On Tue, Oct 28, 2025 at 04:53:47PM +0200, Andy Shevchenko wrote:
> On Tue, Oct 28, 2025 at 10:49:02AM -0400, Frank Li wrote:
> > Add mmc5633 sensor basic support.
> > - Support read 20 bits X/Y/Z magnetic.
> > - Support I3C HDR mode to send start measurememt command.
> > - Support I3C HDR mode to read all sensors data by one command.
>
> Seems you missed my comments against v7
> https://lore.kernel.org/linux-iio/20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com/T/#m377b66850dc0205c3b8723d09c647b545b029fbd

Sorry, I missed it since I am preparing other cleanup patches and have not
checked email before sent-out v8.

Frank

>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

