Return-Path: <linux-iio+bounces-12218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE8C9C7A5D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 18:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABD91F26C01
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E38204092;
	Wed, 13 Nov 2024 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FYgt1R3y"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E6204001;
	Wed, 13 Nov 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520514; cv=fail; b=p9cPj7kKbLqdWxYGzV474dlH0HKH9vN0+9/0FL+lPl3vgk6Av3ZEdRJNA3vTWeeUh28SoqO3gcuEj63Cu2XGdsA23dNqQHpoNvHyyDgYLayELhAIDVpK9pPzf8uG3bza4Upt0FJDkNxFG3VN3cFM1jzg9QgFfHVCz8nXHU34Yvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520514; c=relaxed/simple;
	bh=7/2wRa3n5CBWkt6bMkDSJRlp1PjVLsjIYahkqDJh+I4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nUicKV3bQAHRPBYQuyfNuYT12yscWL35Pd/Vl250JGVDNWeF3uv/jFojSWCQHKo8rg66o9gG3r1t2qed2W3I2NdaXWaVMUzUDb6exOewGpQWLH588kgDRwJ2HjKFBEWaB5xcceXlKYqEnknztyYy1Z17QAOOl4WDQ10cbL6nnfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FYgt1R3y; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XH/rH0q0PVRO+rCy8tIpHdlEgsvZxW1VlI0OKNnr+YGJNrJi6VP8EAdHhhzU/6c7TdzcN6a6txnLyH5ihAFL3hGCfZZri2iKsfCN89LJ5skG5DfNNjXd4XytJnOMle4JMWqzNYZRIwo33MQKJKXe0HfDEm/hgrSXlRysDPzEMRwWZlC6OSWzRxQjTvTwZ5NPt63XCt5m4rwzjMlnQyVTK2ElGvAHbXQ9pn8EyB1yDiUpbVzdRVid7oAiVrg1yoabKFp9+fim2JDtQMQczt9m4929Coh8Ej73hf8gdfKMiDHsqD0votqYGKZeboCozGP7MZDcXXJl6FvSLU4Gn4VR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0u3yXU+87xe0r3eWOM2iIaTyB3qz+j+auxb314LVEo=;
 b=e1tpFJBfSKcJrKoW9tyGbKIzKG3M3PKKxaA8n1eJbkZWCjEaU095z427vE2uCJpsSrylpgFB6ZrRnyHROrl/J+badNpGQbj1/e7aYQpxIiMIVovRgQdVVf+yFpydDFvAYIeQQTLafl2QwDXGJxvfAQ62gUUCKxVEoUYVmwpCJzgeTNBL61QimwIQbD8/5ugU7Fsc601SzEmmvwGTuVfS/Tdtxe0ovmMS278hetCTJEYm5DE4oF6MXcTsknpJPlzNbExM9N6tx0nmCaVfyTmbxJtC4Ka5x2Jlt72+Ub8On5hoecbRep/1fS6UdNZM3njK7mM+cftPBuvNOyqCysy84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0u3yXU+87xe0r3eWOM2iIaTyB3qz+j+auxb314LVEo=;
 b=FYgt1R3y8lVxZSNpEOfUhELDzWXPprBf8DB6G8fiUsgzZ0+ISByW89Wa2AkzIi47ABrsmEukpYmz84SW4Cj+JydhOZvZrabYmnaYIv+c76CCy7ZJx+OYzF+BmQSnCjLOd1h2RUWAL4rIq9IzScOg+Sd6oPuNXA33ar3HZlIzba0boxwf6ZiiJDGuEmf3+KT+8JsIEBd4oqc/oxsPdhALsKbS/qSNkF419KaZ/pixGOBg42llJ10pBchmCvROnuIrIyK1BzQE6ZFWzh+zr9wl7DV7wQDgfPd2Q0mwcgEiQZsqc+LlfcOLWQr7r8pOzZbpDlFo1unn2/CPOchig2H2gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 17:55:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 17:55:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 13 Nov 2024 12:54:41 -0500
Subject: [PATCH 3/4] iio: accel: fxls8962af: add fxls8974cf support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-fxls-v1-3-5e48ff1b1fb8@nxp.com>
References: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
In-Reply-To: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731520491; l=2456;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=E66YWas5Sj7BQ4tT26bgS8Wmo9L9GqNR5+YF5ZSo02M=;
 b=nkumHMYOHT29li46WPffg62boSHizUmIq8gxGggoTADHATKchmZNCN6mmxn1AW/QzPydPePr8
 Lfv8TsOKMbPAHI2maFvyqa4IXV5TpP27F3vOPaKRfp+E4Jrzv6MiwdG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3e1bf6-1aa2-4452-81b1-08dd040c4e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3JwSEhMb0dENjFGQlJwV1NkRktnWURLa2E3TytyS3V6d094Zm8yWkJZNlJ5?=
 =?utf-8?B?WHFkT1RVdEcwdUpRaTg0V1cwUWpPdjJCWThLblJ0NjkrYkpXRnQzbFZSYjRF?=
 =?utf-8?B?TU5XS2NlUmZnTVV2R0JiUG5WbVI3TUpZUmVoeVBYTmlzbjg5azB2ZnJpMUJG?=
 =?utf-8?B?dUhXV3gyRUVLSG5TbllONE10Y2F4c3ZBZnlpVTU2Um1ZbWJPRHV4RXQzWXh2?=
 =?utf-8?B?b3dIdm9GN29nVGNWNDZsaE5WQU5HYytmWEVScUdPSC9nWU9uak8xQjFPUFVi?=
 =?utf-8?B?L0tjSmYzQXpkTUdaNzkvOUNBWG92S2dLOWc4bi9tQTFBRU5DdVo2K3J1LzZL?=
 =?utf-8?B?QnFFVVBMQmdnU3VqQ0o5ZzNLQko3S29vbTN2UmIzZmQxU0lUajY4eWQ2R1Fy?=
 =?utf-8?B?bFFWSU1HSjhIdlRFaStwU1NJQWF6ZFdYWHNaTjNYcldZWlR5RVYrekYydnVU?=
 =?utf-8?B?aS95dUprQytkbW00YnptMnVFcVg1KzlqclVsMGtnckRNbjRJa25maFY4Mzhs?=
 =?utf-8?B?dXpWZE9ob24yL3lIVHFkUnFJTUVEV2gvL2RDL09aQlRoaERSTVR5OU50UXlj?=
 =?utf-8?B?U0xyQXhzUUZKY25BQ1prWDNOMDUxNW82dFpDRWJBMUhCZEN2cE02Vzg4V0Rq?=
 =?utf-8?B?NzFoeUFvRDRnTXoxN2ZNSm9Nam1SNUh5SzRVUklSVE0vN1MwUU9xUmFreXdo?=
 =?utf-8?B?UWRqU05VUkdnQnQycmVSVXBMK2QvWjY2UkFlSkVMVDRwT0dpekdzMS9jSDlR?=
 =?utf-8?B?SitZUWF1UWhiS0JiL3llRnpTNElhWW5nLzI5WDRHNlVEdnJ3cmlRcm5aMEZX?=
 =?utf-8?B?b2pKdlNVTWFDZmQ1MmxMRW9OYklhV0gxUGpBUHFsMnNxMjFBOWR4a3hROXla?=
 =?utf-8?B?d1ZyUXdrMmNTdHJDR1JFUVdYZUNSenJIZENrdURvOWNZTXl0NGtrTW10eVcw?=
 =?utf-8?B?YlFvZDdHTHVCUE9mVER6UzZIdjM1K0FTTWgzUXpHUVVuNkduaFUvUzNhNWts?=
 =?utf-8?B?S0grMUI3eVdlNWdVREEwczY4NHhIZ0JGMGFyRjNTL3BXVmNJNVlBT1luaE0z?=
 =?utf-8?B?WTY2R0NKOUR0cXpDd1dkZUpEMjJRMGIyZ0xmeW5zdWFLVy9lMnBTRG9xYkph?=
 =?utf-8?B?a3NjbzhQakxOTmljQ01xQ1B6bHZJYnhHZ0V4WVA3bFR2b3NSS0JPZUttU3Y4?=
 =?utf-8?B?MEJWUlMyRDBaZ3FEb0U0ZFh3dW0zd1hoejJjdzFZTUE1QW1uU3NDcFlFc0R3?=
 =?utf-8?B?SlBQZEszblhVNUozVGROSFJuL09xUkZyNGFjNUE5c0R3Sk1WNnFTVWlEdXQw?=
 =?utf-8?B?WkU3NGlrem1uVEpyT29zZ0Vmb2UzK1AzRWphdHlpd3l4VVl0MXU2Yi9BNHNM?=
 =?utf-8?B?MUlHSmx1QjNVa010US9mZ0swN0kwbER3ZlF5Q3VYc0wvdjNHb1pnU0pTQU1U?=
 =?utf-8?B?KzR6NC9ZSWlid2h0Tk9SWmRxQ2hIUEhGbW1mKzdHczZod29vdlovTG1udjFu?=
 =?utf-8?B?bmRoa3lNcXhkbkRabHRabWhYWitSZGp4SGpuallOMER0UGpHcFllMENnWmd4?=
 =?utf-8?B?N3lqdUxvTTdjNm1MSmQ0SGpZcXEzeEd4dVhCVHRQYTRLMnlmcVY1VG9WQkg2?=
 =?utf-8?B?ck5kMlBtN2RxakE3OGtzendxUUFkeFdmMy9ZTCszSklwcmd0ZGQ2OWNFNS9y?=
 =?utf-8?B?QVZVcVk0TnFXUXM5bDYyM0NCdHhadm9PaUQ5S1N3ZVRxbGVIbXpSWlR0bldy?=
 =?utf-8?B?TUdKTmt6QjhUT2c0NFBodFU3YzY1OFJuTXBKeHJYbGQyRDVONmt1cFdrYXF1?=
 =?utf-8?Q?jOilb87W6hxrxMq3Kq2cOMjEUz+HNExHeElj4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWVZRmNjMHNPbGRheXFUN29JdzRJU0hsQ3VUMEtnUVJsc1BCWGpUSjVWNXhi?=
 =?utf-8?B?RmlNS0tBVmdKdjVqMGtpbS8vRDgyaGlDTkgzZmRsV3lwVUtSZjN4RlEvN2JY?=
 =?utf-8?B?czlTSnAwZUtkTmlvRjRGKzI0emNzUVg2OWxoeDRRNVQ1WW1LcktRNHhMKzZC?=
 =?utf-8?B?OE5kKzVBUnE0TjY2RjJtRUlZU3llaXB1bnZpV2xSeXk2aWtrczVOVDdYRmMx?=
 =?utf-8?B?ZXRBb1ozQ1dzUDdCTGVSMWJXVmx0bDBpZjZqY3NNWkovN24vdGRVMXZoYzEw?=
 =?utf-8?B?Sm40Y09Jd1J5U0lhUzZIZWdpNktGdHhRM1JENnpqMm9JdVZiYVFkNmdJQnVB?=
 =?utf-8?B?S0V1R1JXSnJQbWVjRzdMWGVjN09sR0ozeXJSWlVDTE83blZXWTZxelNKTHJi?=
 =?utf-8?B?UzN0ajlUUFFLSXdKWFpSWWlnYUpreEZSc0hRUnVrSkt3VHFQODdlc1UxRitG?=
 =?utf-8?B?MmVrUElXSHdFbW4zRVdDOFJxdmZrVERqSEZRUkRSOWlGdEIwcXJIcTRvWFc0?=
 =?utf-8?B?cUFndk5hdEdwd3lrR2JwOTVySmROQ01KcGJqMWRHRUIzR0taaDBqcmJGdmhC?=
 =?utf-8?B?MU16bjhyK1RyVG51WnBXRk5Lem56c0tJdEE3aXZrQXkzaC82RTlLR1ptbWta?=
 =?utf-8?B?K1l0cEJiSElDWmd1TkZTNHZzZ3pxeXkzNnRaZ0JzRjMzWDYvRnhLejVVUEZ5?=
 =?utf-8?B?SmFWTkdub2Mrd3UzU1BZS0JkY0NVbkNSVk5XR3ZkTUJDTWMyZTdmZ1Y3bXJC?=
 =?utf-8?B?TjRINTJHbnN0RzZIZWtDdU1vTCtLZHFZV3d2NjdhQ3o5ZGFpYUtRMzQxUWEr?=
 =?utf-8?B?N2lYcFRyTDJ4WTNlL005S2kxclQ0RXBmVmJjd3ZlM0dreExETnViMlJvZk9V?=
 =?utf-8?B?cm8zL2dmajltUFhjMVhrR1AvYWFpdGo5WWthWUVUS0VLQ2kyZG9KbFg4b3dQ?=
 =?utf-8?B?QmRHektNUy9idmhvK00wVGV2aTVDZnRnNlp2TjV6Y1Ftdjg4c21oZWwxTW9E?=
 =?utf-8?B?cE9NZyt4L2ZvdUs4T0NDWVd6bkZOcU9QaDcwZndjeFFpWURrYlBYazFWdDJI?=
 =?utf-8?B?ZFkzWTY1Mit1YlMzVTZndll3T2FoTnJiZmMwUW10Ky91RDBCdVI4MHlDenc5?=
 =?utf-8?B?L0tCeDFBN2ZpaFNlcXVSS1k5YkVFSGR5ZVZ4bFVHZFJ4aTVUU0tQQVhyNXZt?=
 =?utf-8?B?T2w4emZ6OXlMWDlHZTFBaWw4bHltSnd2dGhRZmdIVjJqNno3Q0lVd0pjYzRB?=
 =?utf-8?B?MzBoTjY4Vld3cnN2S1pVMHNJRXQ1ODNESys4elk1N0hXSUlUbThXRnI3LzFl?=
 =?utf-8?B?QzR4ZXREQ1JobUROeGlVUE44K0JiUFJhQ1pBZVF3cVd0bExOUW91QXR0RnMy?=
 =?utf-8?B?Q25reDlnR2lBbkg3TDUzMmpiMmg2NFhMbFZrdEd0VnhXUXJ4aHZGb2pBRTF5?=
 =?utf-8?B?M1RBZ0NJZHB4UVJSVVl2ZmhYYWFJR0N0WEtYeUFYcTB5VkYydmQwcVVQZkdl?=
 =?utf-8?B?SUlUV1dxakQ2Z2N3ZU4ydFhmYWdJb1daT29IUTMxMkJWYUJvb1VHZkUyQ2w5?=
 =?utf-8?B?ZloyWVMyTTVPSno0MWFkSlNFWjMra3BOb3dKajVXWnhrbHM2cWh3UHVBTUFE?=
 =?utf-8?B?RjBCU3ZHVUZqQ0kvWlN4Q1llTmJvNUcxWHl6cmtIVUFsZlRlSW5WY29RK08x?=
 =?utf-8?B?NEczckhTUkliejd2NkxSNXprMXY2Y3JrbkVjMEdZYjFJVUhlS3kzOW9meGZQ?=
 =?utf-8?B?MCtMVDY2OHN1MFdYN256Q0xWK2JOaVF1SXF0UDdycnBUMHVlWnJLaGR0dzlz?=
 =?utf-8?B?TjQxN3JxNllHeUZCbldDeWgxMWVTNTRxRFF3dk5yR205SEFDa3FrbGxDdWIr?=
 =?utf-8?B?K1o3YmptSCszSk5qWExVcHduMjRGTFZHUUNOMEZzNVZCbnl5RXB0MTVoeUp4?=
 =?utf-8?B?R0dUNU8zcmFMb0tSS0RmWjRmSEdBNVdkR1Y5RitoZGtOS1hWRFhobjkrZnh2?=
 =?utf-8?B?QnRNZ3R0L3JTOStPR0ZycGtrUVIyamtmcG5tbWlmQ0RYK1NUYWM2U2hpTVhi?=
 =?utf-8?B?V1NQYmFkWEdhYnZRY3dvU25mNzhHVXJIOUpCY3UrVWwrcms4UHhzTURYSWFU?=
 =?utf-8?Q?YZ8EeoxirLa3lwe60phVVDscX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3e1bf6-1aa2-4452-81b1-08dd040c4e10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 17:55:05.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnUc+RvvWYc/+4sokDG00G3RL3Rf9JmQkKTKnsvSRh2xs/noneQVm9DInU0iputCXCpvxJhDn1upaLfdONaqnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656

From: Haibo Chen <haibo.chen@nxp.com>

fxls8974cf is similar with fxls8962af, the only difference is the device id
change to 0x86.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++++
 drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
 drivers/iio/accel/fxls8962af.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index f07fba17048e7..b5607e753a7db 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -129,6 +129,7 @@
 
 #define FXLS8962AF_DEVICE_ID			0x62
 #define FXLS8964AF_DEVICE_ID			0x84
+#define FXLS8974CF_DEVICE_ID			0x86
 
 /* Raw temp channel offset */
 #define FXLS8962AF_TEMP_CENTER_VAL		25
@@ -766,6 +767,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
 		.channels = fxls8962af_channels,
 		.num_channels = ARRAY_SIZE(fxls8962af_channels),
 	},
+	[fxls8974cf] = {
+		.chip_id = FXLS8974CF_DEVICE_ID,
+		.name = "fxls8974cf",
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+	},
 };
 
 static const struct iio_info fxls8962af_info = {
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index 1601246733083..ebdf6926db0a7 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
 static const struct i2c_device_id fxls8962af_id[] = {
 	{ "fxls8962af", fxls8962af },
 	{ "fxls8964af", fxls8964af },
+	{ "fxls8974cf", fxls8974cf },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
@@ -37,6 +38,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
 static const struct of_device_id fxls8962af_of_match[] = {
 	{ .compatible = "nxp,fxls8962af" },
 	{ .compatible = "nxp,fxls8964af" },
+	{ .compatible = "nxp,fxls8974cf" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
index 6eaa2803b26f0..733b69e01e1cc 100644
--- a/drivers/iio/accel/fxls8962af.h
+++ b/drivers/iio/accel/fxls8962af.h
@@ -11,6 +11,7 @@ struct device;
 enum {
 	fxls8962af,
 	fxls8964af,
+	fxls8974cf,
 };
 
 int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);

-- 
2.34.1


