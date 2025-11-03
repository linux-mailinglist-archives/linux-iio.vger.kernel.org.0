Return-Path: <linux-iio+bounces-25857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F241C2D0E3
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914423B99FC
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AF53148B9;
	Mon,  3 Nov 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UlrmpZgM"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA930B528;
	Mon,  3 Nov 2025 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185457; cv=fail; b=jqBoSlNdsdf2zik2vy8xQuzRefeDS9hh6FPljp6xeaeV5oh+rxTQPHNPdYG4BKgqz8vNqNR6NWf7KNmz6QB5dcsu9AdjvXHhu/W5w6je1SfGSigUJzsyDmDiCz4JhZ9hNIFy6D/Y0kx5PONJ9QuhUuapqSnrg7kBwUvz/GPxKg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185457; c=relaxed/simple;
	bh=HI5Kz2zEmf4qknBZmMR29Hkt+zoAceOMVtA9i8JWz/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=arhDcscH770s2umBEsCYoivyY0YYNKGHEntm4s0oGUY1+Lm7dGzX2sCqG+8HtDKaK9oAuR0jA4+GbAupJshlgSPm5S6iJ1YsmHBNMZtrDVVbC2zqR0EgV7eLTQSq70JQJGA3gURdHfXB20JraeTkRmoTc8nNAx6d5ZSHimhGOoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UlrmpZgM; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtdaLBXYH6FKMFPx2Bfj/t2WgNM+Ydd51H138dOfScsiKdNYA6XC/TUgrfIG8RB62F+/Wp2jpZfdSbiug5IZFn83IIO/CEA38v9nHWEEDa3vWO+Pp9V8pIlm+6MvPKAQ9H2d5ppQtz5LComEuQgUgUC1HjitKkucVficvaa/nLfSRvpVXksteXXSBfAWwgp1vaAFF3GdRT77L4bPs7oc3lbhb5SSrwNlfNCb/SFCwk6Hzsyee3D6+8qCknIR6y2FXFs1UkWmlwkq2SYfsivoT/WriKpalCHtP0+M1eQiwMfzOBDMDBm17LduUKysUVAPB8kRXMBuoZUraTtSP7Ktkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQG3er+hRfOerBekXYkAGWCk1m8kEH48FHw2xOl9g00=;
 b=S6iurcNZkPk3BMWcTlo71hrVsMJvG/wGWXa895RZ4I3zHVKS/IupBjfmxVRVTUlgYdfRWw/zD0gSDbendvD3WbX18pWEnuwx26QuvegtwDBJ5ugNkYla50iYA52qKIyoRTMC3q5rwElbvmCKwZ10yCktayT7WxzyOkGGtZSqlWQ6dn4tqiw7JnDPUqRcJrvLIb2g0Gv9ovvSHI9ULUzYOGgIO9WL4Ua5CL0mClc/n9iLb4FfKgM1whriVxcxEbpDt0tS7gjl+XXq1hs2prMXPcNS1S7B4zHAekm63EbwifWb6uUwNtu+wcTmCPXjB4up+AuCXLzyz1t1DWlSq6sqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQG3er+hRfOerBekXYkAGWCk1m8kEH48FHw2xOl9g00=;
 b=UlrmpZgMx00I1Bg69AAoqtqMrogDsyO4Va/jLxeTTnfA6E8LVXyNR2cLloqCOjSZvWcQeSu+Gxa9lgK5y3AtjOjow5I01WyIz0cFQBophJcsPNJz4bgzTrXCwIDfX4bJ8TMNLLjRAJz3DbwnOeO3wksL1kq/is3g7smVmx/x9/zf6AFJulzmqI5v4eB8xuTsKtODecl4XlznzCNk2RJCfaaEo2tcrYX10oetnFNis6qQN6PF5XR8xpyXOmhV58HVdXJZHhbxpUjhG6dmHXswPJrTPOEp81COui5AlECKxzxa3jPZmnK4TcyIOGU2uvToffTMKuovbr6lcy6FA2UIyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8259.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:57:32 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:57:32 +0000
Date: Mon, 3 Nov 2025 10:57:22 -0500
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
	devicetree@vger.kernel.org, linux@roeck-us.net,
	Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v9 6/6] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aQjQ4jsG6Gc2u3n+@lizhi-Precision-Tower-5810>
References: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
 <20251031-i3c_ddr-v9-6-f1e523ebaf78@nxp.com>
 <aQhkRmtJMoB7vv8U@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQhkRmtJMoB7vv8U@smile.fi.intel.com>
X-ClientProxiedBy: BYAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::15) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f15fe4-d95f-4346-91db-08de1af1b29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLPxMmADbsOKQrv85ORRhHQfa+XKZvKKfR/WZDiGo+VTdkjbUeUKXyGfUbBQ?=
 =?us-ascii?Q?zFVwt4dKYFp/PLZMYR9/GoIUIym7Db9iDhXj0o9kUEH/iRv9qYFWibF0jRNz?=
 =?us-ascii?Q?loshku1Z45T1qq5VH5V036ZzqOAaPw4HEpjWo4rnveNJejF1uSxr/j0FrIsc?=
 =?us-ascii?Q?8zkOl6C3QBc0CSjj3vqnM35ACbvrW6TU5wZHP6xRshtTX5lwaV+y7GT26l5q?=
 =?us-ascii?Q?6FI+eoFS5KMSiHCQmXf500lsiEbodhT9XwRW+yEPpNrMHYPIVbeJ1xtx0vi0?=
 =?us-ascii?Q?w3dKueLVOLWyYtp/ckBC6+PLOrFkqHKpB4zOnUUDXQoJRDNXiTdpgaRd4EQt?=
 =?us-ascii?Q?dMqSSsWvJhKROasK/2Rh5QdLl07xwk19WXQ9t4zLpI3LOG/Ol519ug9pfKzq?=
 =?us-ascii?Q?jES2S8ziED1pY8LBqfEZJvvzmi4sxUds0c4x/KImiDr45dR537aQ1I4L5XhE?=
 =?us-ascii?Q?ACWUs9s1VNqVCWc83KdMQjfWPo/bo+9dA4EUPNK7CpqH2qtzgahmY7mudvtc?=
 =?us-ascii?Q?bMsDlZqFFJaq87awN6uqysL0KxNXRktj4D2L0Bulh+5jsodCY5Su+ProcQc/?=
 =?us-ascii?Q?h9mwuZWIINmpT9OMhh+RLzd/mqAj7VjG2OfIJ1ihKEhs/V1JkTFUdE678gR0?=
 =?us-ascii?Q?8GNZKnGz1hbiK3wl0d2BH3wgZ/godIXvo+RRU8Apx97755vlNQGztRHnBRfA?=
 =?us-ascii?Q?CNgbTQ3iTon1WTRObTbaId5Zo+lgmGSDci2oXjqx1rlXcfIvbxhqSE9UMEWZ?=
 =?us-ascii?Q?Opy1ox+xw1a7O3ndk3WWt8+qXSK4M4OSqF+1m6+cMLRQDO+oO5Izu31xlT5P?=
 =?us-ascii?Q?/lU7SkIxJZ4f1nrY14v0Svhpw84ZIXyunbuNHY6cKNhLkwXNk+CA6/SDiNnX?=
 =?us-ascii?Q?eNQt/3Hxw02LFo9kqoQ40MfiqIZHNGewHJM3Cf656nz6Pe83L55BMGWF8ZHY?=
 =?us-ascii?Q?LNv5r5pMnGW4CDSFvwiPrpoBPA0Cc4b5ZmZ2iKq2MsdcxG4QQbwhy1iTz9qs?=
 =?us-ascii?Q?hY+q/ddrDllpaKeyJXbW6O+ZFSo87Cbki8ZMgU/CyCPFw1gCiBvFonAf3Prz?=
 =?us-ascii?Q?+rHuCqL0xomfUH2LFQCiaEq07Gg2AVnHTJ7uRR314yLiNSXyDLbH+5CjhVuA?=
 =?us-ascii?Q?VXTxMZzXGNR3S35KProd900DIMudSni6Jpm1YA/C/0bYLbs9qD/dE12fQNd+?=
 =?us-ascii?Q?2z6zrE9bxDgBmzg1qmAUPAxnky+I03qQ1hwW+SBuswewh+LRK9TioHWBThOU?=
 =?us-ascii?Q?bGCCOYP+p6Ub3Rb7E3m1NekGPamck+2aET/DOnx0Rs85gm2pUTtFuP8XKbD1?=
 =?us-ascii?Q?sA2IqZSmC8Yeiima4gDtcxSFiJY3ScNssjpNg67r3rtKlNCCQYFxo4PR7V3t?=
 =?us-ascii?Q?l8+p+wMDCz7angzO+TYeHllku838d+I47lkFcUOfG8JDlysB2BwThmB7YpaO?=
 =?us-ascii?Q?xMg4sFFIGrs107U7c/IUn9VHt0GkcBE9JXNCAfGZv2r32uo3fBmlFGzE7IyR?=
 =?us-ascii?Q?QJ2cf9TBQgG2yygsTEx+IksRQ0En2Z6qPybe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rHd8NEgjBPcEQPFX3xa0MxWoVOLe05SkTpeb9NmbtnqbaR7WxsxW/z6G2jBo?=
 =?us-ascii?Q?SqzxTAe1Jl40xWV49LEvJHGTVIhDe67I90vEOJRulimLlmLODKuhA4si6pAc?=
 =?us-ascii?Q?Vk97AuU2IqLevsbLCh28CPQyd1MVCaLrmOP8LR6yOQsT5B4lpyb5JftO+tjN?=
 =?us-ascii?Q?fk0PUdBmX7stvavDielZdg3rtPpNZtDkn0JsbkmLFYDv8W36vJKDZACDWpqh?=
 =?us-ascii?Q?3hKFKYiPxYs3j694pK0qdM3HcTdW4ZxU4xahAV3fqWDSmFiicMTaHF2IQf9Q?=
 =?us-ascii?Q?tjIJ38E1dgAHkS/uzfXxPuJ92J3ER/wb/VyNtBxPzCeJXGvfqKTIm6GSmg/U?=
 =?us-ascii?Q?2WJfRkc/4EevGA7d4Yd6zUhQWCJbkO+fKwyaEGM4NULUromChkRTOkcsEgG4?=
 =?us-ascii?Q?wbkLzZyR4VFAXxBdU2DlDBipeTvPX/0h8g58w6C7eQlMZskOWQSUhU8UFSV7?=
 =?us-ascii?Q?e+RvjO1nKOGIu3M7BeYXH1GXsK5mXl4GiByVhlVD95+70sufPzyh0yR2QiIW?=
 =?us-ascii?Q?6fKQjk9CKbuwpmkrwMhUTg7K1BHip1Q7+jUe1ebQuqk6YmDE/9wTSCQ54vaX?=
 =?us-ascii?Q?q39JFqjOz9bNDrokLw07uPLL6vRfoyJxPKpBOgYzfIjRmuLXnCgtQoVF05hu?=
 =?us-ascii?Q?cwSQAW9Rkn9QRoxeXoRqWnMHunXcFTVnBMWEYvWhx9DTqC8gIYvpYWdL1fyj?=
 =?us-ascii?Q?uvduiA+ypFYgxfXC58Y9m8ga1fJEeuNlC/7rOwgcIZ7xTo08uOSh47DJbKTn?=
 =?us-ascii?Q?FDRovK4P/xgeW/F9fZwbZRtnr2uanoGQj0fVpUSAAX1Z44/JtTGLXonbYzb6?=
 =?us-ascii?Q?mEYJz0nGJF9kkUgH2TZWYAn5q/dKTHQtm3ELcqpyfl9MtSML7MVQf9KL3nIe?=
 =?us-ascii?Q?M4hZtoOG9Suhokf4AGlEYOlBWlUVr9p4/cqPnXQYgmiVx37Up1rYrpnNgciN?=
 =?us-ascii?Q?yP6PSvTov1PIUOeDPuH+nDe8SayTzbSEdHtLUYyfVYCkrvFyG2k85+8AeCb5?=
 =?us-ascii?Q?0hMl8fKN8XIgg3565BBRn/OLkdDOBzQc3TFr988+JEPATgQjKxpjNqohMo0H?=
 =?us-ascii?Q?oJvfeDOmuwlIoST2i4NpkcrzoMO2vFMkikHjTzrqOfl4vJR0ktoKKCXgjaVy?=
 =?us-ascii?Q?9gA+eWWVdbJ1qepkSmvaVTQrOXTOuJ9k1k52rg9xr5/N+xx4U39QKx/zBPGg?=
 =?us-ascii?Q?Gomprttcuovt65mDGSZxNLGL1CUrnZd9ytkUO3ZVh+DDmxBvL+d4O8RJsTf9?=
 =?us-ascii?Q?Z8OZyTUCLhbGSHkSTP0v6VCQUm1rNaUg97AhbAKGagX0qhweKPKEI19tzjIq?=
 =?us-ascii?Q?8DRn1U9f8jrOEpTVaIl6tbgNeHcDtCyZq2iXhCiDUepMnHxgB2gaqwGnX+jJ?=
 =?us-ascii?Q?XDWe/WDMTnCPOF+fEONEudHfU8I1TXM6P+oDc5wi5a6w8ehROmQpeuq04DL+?=
 =?us-ascii?Q?97xp/h7kq3/tbc2+Z9SrTzCYMSH9kon1kdQC2U8q1OuJCxFnqNDPt3rI5blM?=
 =?us-ascii?Q?cz3iuJESWKSd/UpWJQKO4GMhWNd4O8/DxNHCHcqgE0HvLxPndrr6RrW4/XCK?=
 =?us-ascii?Q?2ac6bqHOrIZBj46tSbP7i8NXDDb+CF1nEm62YDbH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f15fe4-d95f-4346-91db-08de1af1b29c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:57:32.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfZuFOQ5AD/lHBeN9uWEDWnQMS61R8dJ+uqOqMK+3Nyzl7xlAV6/2olL3rT2IbXqmYeEv8yYwQpeUFli28pgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8259

On Mon, Nov 03, 2025 at 10:13:58AM +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 12:39:18PM -0400, Frank Li wrote:
> > Add mmc5633 sensor basic support.
> > - Support read 20 bits X/Y/Z magnetic.
> > - Support I3C HDR mode to send start measurememt command.
> > - Support I3C HDR mode to read all sensors data by one command.
>
> ...
>
> > - 1 -> ARRAY_SIZE()
>
> Maybe I missed the answer, but why are the arrays to begin with?
>

I3C/I2C transfer API required pass down one array. Keep the same coding
style with existed one, like

source/drivers/base/regmap/regmap-i3c.c


> ...
>
> > +#define MMC5633_REG_YOUT_H	0x03
> > +#define MMC5633_REG_ZOUT_L	0x04
> > +#define MMC5633_REG_ZOUT_H	0x05
> > +#define MMC5633_REG_XOUT_2	0x06
> > +#define MMC5633_REG_YOUT_2	0x07
> > +#define MMC5633_REG_ZOUT_2	0x08
> > +#define MMC5633_REG_TOUT	0x09
>
> Are those _L, _H, _2 come from the datasheet

I will align datasheet, which use 0, 1, 2.

>
>
> > +	ret = regmap_attach_dev(dev, regmap, &mmc5633_regmap_config);
> > +	if (ret)
> > +		return ret;
>
> Why?

I double check code, it should already called in __regmap_init(). It should
be reduntant.

Frank
>
> ...
>
> > +	ret = regmap_attach_dev(dev, regmap, &mmc5633_regmap_config);
> > +	if (ret)
> > +		return ret;
>
>
> Ditto.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

