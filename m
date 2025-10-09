Return-Path: <linux-iio+bounces-24869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8C1BC778C
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 07:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262DD3E5E64
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E226159E;
	Thu,  9 Oct 2025 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WB1QZjov"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F3AD4B;
	Thu,  9 Oct 2025 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989382; cv=fail; b=bUkfrmRA+KLOS7d9V/eXz+ryGTBUjpLt25qTxYYqeq6lirDIJNdddWeVSuFshRPWvDR5wwCa+fDHRU5mU1C5Uy9UhxaincqmLO9ThRLbpc4z6rHx25dr78qtyKWdXKrjeiJ4xYajUrpGn1w9szkx8NYML+cQ+Sp5wlZjYod4w4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989382; c=relaxed/simple;
	bh=sKNgy2o+wyOM3V9b/JhRdnryyZHfQ2mwYWL1LatPNH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pAZpZ7/SPvriAOhPPHry6UMZg0bIO0EP56C2WX1fkci/DXFcWHu9/1zxVCdJIQVJAKnHN8ACWG1PYf1Zzp9f1ogUMIlAiYiRIn3Kq6bnv9mkugL72FD5BbCOqEv8plo6nCiNgmPq1QlOdnkUoVV1jhFTLXFy7hVWF9CoypxDqng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WB1QZjov; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trmfjzBdDvOquUHzqvLpiPbQtZDBVYHGAxQT0B4qpixy29PRWZCFgzQOwZzuHIkkBCVlW9Xy9KAbJXzwAeZ/HAoGZu9mT8//Ik2pB/rQQc4CCRk1uWT23kmlMbOFWqxiRuVDX78dxq9Xrv+FOmzqJSm8RjJKsv2kQ/fcHb1rU+OD8Y3B9+mRsZLJ53ba2ohfbZuXqMQSjJyBmN9ojosZdXhR4cHrVEKjW3+GZw+zc0zkA2DRZ3HFEDuQkT7Y7TmOSM4bDXGrkqWHIVosBNsmKnitn2TrsGHdWRKJ8xT3Lfo40YKM/iYE0UfCNgQZ8UN2WLJfxlZAO3+ErHuld/ahHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+k79itz3tDhGo/7dUYnzAWBIGLDbSBM3c01ONkRmbI=;
 b=Bee6NWKkxZYaF1HjrpzHbb4K5UeYM2BrJd14GFhoMEeOVzre7BFLISi+aJo7pTjqyHskI4VZmSNwxIU8syHGTZlvayS1meEdLklkZ9zTJ7/Y012fHQ+SN2AkzXSUBMkQeqNPqVS794HYdQaWLcG5BDeDbaNm+UZhLQnZ3pw1ClUdJ3KcOrd4rvwbbvy0QxS7VC3HRxfnz7LFwhKC8TVqwKB+T7hdAz/8gATGYQar5qYAFTPyoWEX3iVR2AELP1UB37tpyRykXLshyxTUJV84HjrsQ8YtvDPN9vTe04IqDSzqhILhps1dzaqBQ9x24Q1ExZ/UXaOOklr59iW0vKe6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+k79itz3tDhGo/7dUYnzAWBIGLDbSBM3c01ONkRmbI=;
 b=WB1QZjovyX5MB8WpJP/lBuiX+tblHyTukN2Ak8hVjuzQaZ3YEaoy0LVOSNrp0YLV5wco10PuS84OUm6XCcq8T++ppY29Ty9vvEVtIrHjLUzt0+t7sauZ0GeODg3ofoKVAARrr4xg4p4rHS4CD9AyYjMeCjCWxY5GkWF86rpkt4Sf49HW1Bajjpst+dmrh0Z0pKJUZrqddPv3GKePuoTGwh8BPm3q98Y1zlryFSIXHlt6fvPm03TMAk2cC3JN7yj9bl3Vzwd97Dd7NYZnif7CV4oJeuVSgsUJKFFFkE3kLEMCOgDiBmTn0VtVqh6ZzteniczLfvKWGlvtbA6SrZPChQ==
Received: from AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9)
 by GV1PR04MB10821.eurprd04.prod.outlook.com (2603:10a6:150:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 05:56:14 +0000
Received: from AS4PR04MB9362.eurprd04.prod.outlook.com
 ([fe80::e196:11a8:211:feaa]) by AS4PR04MB9362.eurprd04.prod.outlook.com
 ([fe80::e196:11a8:211:feaa%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 05:56:14 +0000
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "peterz@infradead.org"
	<peterz@infradead.org>, "jstephan@baylibre.com" <jstephan@baylibre.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, Vikash Bansal
	<vikash.bansal@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, Shashank
 Rebbapragada <shashank.rebbapragada@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 0/2] iio: temperature: Add support for NXP
 P3T175x temperature sensors
Thread-Topic: [EXT] Re: [PATCH v4 0/2] iio: temperature: Add support for NXP
 P3T175x temperature sensors
Thread-Index: AQHcODtVgQkUhqSthkK52FB0icuPUrS4SikAgAEHzXA=
Date: Thu, 9 Oct 2025 05:56:14 +0000
Message-ID:
 <AS4PR04MB9362FDA1FE35AD06C99B85E3FBEEA@AS4PR04MB9362.eurprd04.prod.outlook.com>
References: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
 <96f5443f-5b40-4d05-b350-78d55a1d841d@roeck-us.net>
In-Reply-To: <96f5443f-5b40-4d05-b350-78d55a1d841d@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9362:EE_|GV1PR04MB10821:EE_
x-ms-office365-filtering-correlation-id: 8fc7935e-406c-4b97-e17b-08de06f88e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|38070700021|921020|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bBb7E6qr4kDvBfMSg0EiRR5klAasVQEIC84bFCpK+RWjyYKjq58pv97WdhyG?=
 =?us-ascii?Q?iA99xhVr8iqMKhPO8ckXzebJbK+N6C/zIBfCNm0jR1jqrqrOkPDsHlTJ4yaT?=
 =?us-ascii?Q?r8e2BhC6nsmzA1ActZ7Ms/i5i6HYDvFTS1KWkYqxPXRQHWFp/5HnS8SFm87f?=
 =?us-ascii?Q?xDe04+4vnVBD8msr22Ov6Nk9KACxNgvHh8Qgg3SggaqR4j4iP4gfHwmw1/fS?=
 =?us-ascii?Q?uGru1xFGLo1IwdXPz6gaLh3LbcdXjLxNLaHotS0pBA8RmzZogbG+TqL1K2CG?=
 =?us-ascii?Q?JHsbbGBDHo4w2cD3JfRem40vun5nHJ2sBHzW+wz35ZGWv6Mg1t2h6EhupIGy?=
 =?us-ascii?Q?nACf0xYZJDoIcrmUYS4g/m30qZeqPWc6jRC/e4qc9A82OeE9HpH91CKPfGMw?=
 =?us-ascii?Q?PSYX3Vao7SNwPQJj8OwoRuoyMORBZaG4gSA462rI177J6xgbjY2AirchhB3H?=
 =?us-ascii?Q?j1ggbnALZJPHrWETkZN2Ui5oNsT9VMWNSFZ0jMi1UbOnxcemhJ2iNpIDClrw?=
 =?us-ascii?Q?1F7cwrbMFClWsRCEQ9xtAe4ASGRwP0Xej8CKqJv3EKaregZJeVzBECQOOAda?=
 =?us-ascii?Q?KawmSvzb599ySzAZiz02lPvbeAGZYU4wVnmgcXVRJh4PVGFW537TVRjDhPLV?=
 =?us-ascii?Q?FJki/keFyC1ArrKjq6VmCIxLSgnleFUMldqTNpGzpl8thH26cedXdHzs+X38?=
 =?us-ascii?Q?xyY/SjUqIg17qtW+T6KBXicqrIxvuiAe2MGuCFEgu99JUFjd0FnABYlzrhlw?=
 =?us-ascii?Q?lo/vXynUIZ37QvGAym9SUeCSOP+OgGlg4XCE1PB6j3aP/KBm5FGJJTkwhRps?=
 =?us-ascii?Q?SJJc2d4r+/ObJqiER2MPaYKdpQGSF8Fd2cwd9U/ALFDvDrUSDV++FKmp7kZb?=
 =?us-ascii?Q?1hQr/4bh1Oreh9OCwVy/rOBBt8YjJHb2br3EWagAHwaFDP58QvvKCdTF46aH?=
 =?us-ascii?Q?l5w25ys3ZHT2bgFzWt/Wd/LzC9F8EPNMQ7XlszCyVnoOwJiWQUv453fdS0Tr?=
 =?us-ascii?Q?rYpJC0huWMWywPNyREBYh0bBtXKxfGbpQ8eq2Fi4cKkfnR3M38n78CL7yIBR?=
 =?us-ascii?Q?mDpNI5lh/F2MnHKzlI1u4NKIF77rngXwXIXEVK7qx4+tqkJAWdyrf9AjrQux?=
 =?us-ascii?Q?FYjcvtLR+mfrbkc9wfdsX0uMeoDVzjIXh4wlqC4xUgykiD38PqxtbwQGBW0V?=
 =?us-ascii?Q?4ea7q+3OM85WXl0oIRqtjajCFPjj0L/Qqq009cOwVWdwxZnOnp+psdw4aDH2?=
 =?us-ascii?Q?ZxVRsT9uv8SB4JI7D2ipp94f7/bHp39YLGTu3ZOSsttqZzyBpSATpcZeBKHE?=
 =?us-ascii?Q?/caaYqdSQ60sNX/DZbE1LUX1ebgmvdqhMZF8zPs3d1IyHqE5YR27rOh4Pg8N?=
 =?us-ascii?Q?U4tbfYpNWC+90Y+Nrwaga7Xf3br7dF8L6p1XpvgxgbZgFc/if9wiDAej/eK4?=
 =?us-ascii?Q?5dzSze/uhfEhkYCTZG6gd0cnQ7tZtoDdwggaqCxrYkHjBrnnTJJ8X2SR4tha?=
 =?us-ascii?Q?vFTL32K6Qcm3TEIfE1OaxTNwzBRsM4s8uDanDN1tmUJm+B8WplZwRObj1g?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9362.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700021)(921020)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wq6YvQhEh9R6S+pXwhc1R0enMb7PMsNLqT4yPKfji2KtGfvTW1111EByPR0b?=
 =?us-ascii?Q?ZFm3JWam/Rd1+s8/IO4VUgZMRBWVkK4YZ4FW8iD7ZGlma9v04gA+Ydw3cfUs?=
 =?us-ascii?Q?bUqfjYYe9La8BKhiqNWaYv57rBQ2/EEGU9+ogNSXIoNaYZGGGWutj2ezpA8C?=
 =?us-ascii?Q?Qj94jK2Xnm8bt+Nv+wlSjwVtWLBVLNV8IVNedKd72rDGfiLgVxOVOwU9G331?=
 =?us-ascii?Q?GczahoM3nF7vHPvdgSPJ0cwCNAVHaAWvZmoa1780kiRIxsMZB6y3V+B35oZ+?=
 =?us-ascii?Q?A9lsNbxzPp5m4Zd/j6f4Aln2O59XkBWoXXBA3ICAh7y0xQ2p5GaBwziDiIni?=
 =?us-ascii?Q?1g2KhHRCfkk14uvVrQdV7BJ34DbTEikLdM+OoT4hPA0Gp+VNK3ZJMjSpLN9d?=
 =?us-ascii?Q?JAHq5muvOkw69ouQfPCmV215enMFpxB3JpE/UZCnZw2s1HwYpOm9v1ZFbK4q?=
 =?us-ascii?Q?0CkaRIFYbiOdPB7dIFp6Wa9lPdGTxd8Q8gHxF/CNrimn3WzH7RAplAUWO+yK?=
 =?us-ascii?Q?wCG2nwgB7TzIWiRhySkS/Z1UOReC+r+OtBwXeud9u8gwc583g0IhxtNWe8BP?=
 =?us-ascii?Q?c8M3xPtx0il6wGrmdOH4zVuKsfKdg7RYrGciLN4m9i78usjfmePCs0Jbe+Xz?=
 =?us-ascii?Q?zLSxL9Vt+X+bziAB1NS+Bxp1RenqWabOc/BjO0app1F4sdjc0ZqP7+qruQr5?=
 =?us-ascii?Q?3zdo7gYMmjq7qVIHpzy4QTTB47qS23RI0pxNCKFqyw6mIsryk1wlG/USYtRM?=
 =?us-ascii?Q?X+HEb0zWwqhCfxEH4mQbePrFVG7VlURE8WgMz9Y9EtZeCVFdI+lp9j0laM28?=
 =?us-ascii?Q?rIYF+O6WtRNEHCZ83QbXpjctad7pGAOAwxr5Ue+FnDMGQfuh0utkKu6e6GuJ?=
 =?us-ascii?Q?9KrxiWBF0YU45Huf6FZjHzoMZj88TZ3YxokJzkDw2qOL0SM/oa2LQQtjdOpz?=
 =?us-ascii?Q?+T5DX5f8E40llOZNlJgEHynX/HoCZmkHY2kru2OfGyfs+KFfmap69qczZOkS?=
 =?us-ascii?Q?mNS5TIJx+R1eKXX8qrGYqDnsp47tP4LH7bvXqy3cuyPa3WaquLB3gnVKrZE3?=
 =?us-ascii?Q?xkPEsWTMG6RFNUArg8Nm7nA/NF/ga4aWqwNvJD/Vn37CjI4mn908QmZjPjx8?=
 =?us-ascii?Q?2T6iVxqGJfYPqdplaC9MXRTMpTF8d8e13rxyZOJzFC4+E2+j+K+5VnAN1ilX?=
 =?us-ascii?Q?w/jpwTEXukVIWuPx1UYoQ+1EqiNROJBJpfsV2S3IW/JkYp2YDjejxuM8cE0n?=
 =?us-ascii?Q?b9Grcb1J2wZpVkdVkDPogOs0o+swx0ZAf319IJ01bkfodAMUeYyVuvpGoDVz?=
 =?us-ascii?Q?xJ0Q8KARplB6HDz917R4sV5snv8Wn8ZLpxFx5i622WKHXFCjA+e2GbbzydWS?=
 =?us-ascii?Q?morrE1c6rhrqsQV9coq4wbnMuJvLLPvf7W3T4Bn5JVblCRx4THO/YHTG/eA0?=
 =?us-ascii?Q?MQWhQ+L4nEcwIavzIIxrZWVg7NfT56s9lOi2p7xC10txMcSh0qxeZK2lRqh7?=
 =?us-ascii?Q?IWztQhCGxYn/ozHUuoKbGLo3SvHCf5/z00SSQJKojFwMXRVWgOINDnFM3Zk4?=
 =?us-ascii?Q?k0bf/fdw1HWcRGUST+G3xty3xOvHFT7XZDRGNmYZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9362.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc7935e-406c-4b97-e17b-08de06f88e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 05:56:14.5895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4jQNn7mYgusS32b0r9jBx/IF8R+hODK4JhjaZggcXHSA839uh02xvfaeBPzkVOazbcDNMCNvjw+RwXp/SMLuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10821


> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Wednesday, October 8, 2025 7:41 PM
> To: Lakshay Piplani <lakshay.piplani@nxp.com>; linux-kernel@vger.kernel.o=
rg;
> linux-iio@vger.kernel.org; jic23@kernel.org; dlechner@baylibre.com;
> nuno.sa@analog.com; andy@kernel.org; marcelo.schmitt1@gmail.com;
> gregkh@linuxfoundation.org; viro@zeniv.linux.org.uk; peterz@infradead.org=
;
> jstephan@baylibre.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; devicetree@vger.kernel.org
> Cc: jdelvare@suse.com; Vikash Bansal <vikash.bansal@nxp.com>; Priyanka
> Jain <priyanka.jain@nxp.com>; Shashank Rebbapragada
> <shashank.rebbapragada@nxp.com>
> Subject: [EXT] Re: [PATCH v4 0/2] iio: temperature: Add support for NXP
> P3T175x temperature sensors
>=20
> [You don't often get email from linux@roeck-us.net. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 10/8/25 03:07, Lakshay Piplani wrote:
> > This patch adds support for the P3T1750/P3T1755 temperature sensors
> under the IIO subsystem.
> >
> > P3T1750/P3T1755 support two operational modes:
> > 1. Comparator Mode
> > 2. Interrupt (Latched) Mode
> >
> > The HWMON subsystem is more suitable for implementing drivers for
> comparator mode operations.
> > Reason:
> >    - Temperature thresholds can be polled and exposed via sysfs.
> >    - Register reads do not clear status, allowing safe alarm state deri=
vation.
> >    - Matches existing drivers under hwmon.
> >
> > The IIO subsystem is more suitable for implementing drivers for interru=
pt
> (latched) mode operations.
> > Reason:
> >    - Interrupt mode uses edge-triggered ALERT/IBI signal interrupts, wh=
ich
> can be pushed to user space using iio_push_event.
> >    - IIO's event API (IIO_EV_TYPE_THRESH) supports timestamped
> rising/falling edge events.
> >    - I3C IBI integration maps naturally to IIO's event push model.
> >    - No persistent alarm bits are available; so polling in HWMON may re=
sult in
> missing events.
> >
>=20
> This is just wrong. Interrupt support can just as well be implemented in =
a
> hwmon driver.
>=20
> Guenter

Hi Guenter,

Thanks - agreed, hwmon drivers can support interrupts.
The distinction I meant to highlight is about semantic alignment.
Both P3T1750 and P3T1755 does not provide alarm/status bits. In TM=3D1 (int=
errupt mode), the alert is latched
but cleared on register read, with no way to query alarm state afterward.

HWMON typically polls alarm flags via IRQs, expecting them to remain assert=
ed during threshold violations.
Without persistent bits, supporting interrupts in hwmon would require emula=
ting state in software, which diverges
from its ABI and could mislead userspace expecting stable *_alarm files.
IIO's event API, being edge-triggered and timestamped, aligns more naturall=
y with
this transient behavior and with I3C IBI signaling.

I'll reword the cover letter to clarify that this is a design choice based =
on ABI semantics, not a limitation of hwmon.
Thanks again for the review.

Best regards,
Lakshay


