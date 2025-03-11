Return-Path: <linux-iio+bounces-16734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8037A5C865
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47AA57A9A51
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C125E804;
	Tue, 11 Mar 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="NiPziexP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579525BAAA;
	Tue, 11 Mar 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707783; cv=fail; b=IfUZL9GQ9NVHtSWOnVquEzPwfwUZ8pv/yfHnGcyMW2U/ULpRTRlPcpxByufRXKtSi1ARYZ3UCL9gBx8m5NrJYB3xKnGoWtnpZDjj+Pu1WBkpkk9XEyPeNK2et4BkDBFrBNenJY4TGL3jByKTqpMFTXOubz9qhPphZurJADCbcdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707783; c=relaxed/simple;
	bh=tnAAgYPVDnEOixsaf0YkuSi7L7cYIAgURuLbc9zs27I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q475sNreSWY5BBIRoJ/kBKL5dDj7ZazK1TzbKNNAiqbCOGFJjzVqvwTtY2ux7FfHIPpj9zF9/8Teq3kY7GhzQkua+DhvrR6fh5IfgnFfA96gy92ji47StW9dh+y2WbOJhkfg1/0rWnzZSkYR8os65JlX4btJLXorO25GqwtEhLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=NiPziexP; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ANIEx9000923;
	Tue, 11 Mar 2025 15:32:01 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012049.outbound.protection.outlook.com [40.93.78.49])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 458f8kthes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:32:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJGCOcicM2IX4tlPx/0AiyozFfAar7fYzmiOUHSnsiQTMehrTUj0szcnLAXK/FSqBkQcqsOmBiKxlal4fnMeesB/1CbDk5filuBkce13Kw2G1Vj+CnB5QYm8rP3rAN5eSd5Uk/z+Vu7VUizrY15HvmF5wgipU6VouGl4QNEe1pRWZdtg4GP7E41KJHwphdcGYOI7weuZfqeczwBHT3N5Sl5/AwKO9xnRta1KHgBn+atXpBeEFXjAWjdmQn/ZWIVLhsHMCKQgw/Du408Ouh9XuSSTFhVjmRub23yw291nJbPzVtNbR+MqX0tAaJZTSP6eYk2tyjUh2TIWdnk++BByZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dw2wD5fl4gmKskf0cY3s6HMjqSiXTZKOmJn2txTzinI=;
 b=QKmRO/Hzeu52rxIZ9uBt96k3JJnPSAXfUK9V2GfWsO9KlecUKI8TGxF2yMfXbxUc8cwhws/xhOE+D2cpPTbCBX2NJAKPtEC84nnyt1eoenYS87ZcRd2QQLMlSXy+ROTbj7quXtyM2p70jvrSUCWrT5GhGHSern0sg0UPR2pszocZZcLdSagWMHWRRGwX1INk2agrxDjj7eiG6PAMVojTbGdetOWRHfkCLeIZP+05v5CCieLJFUM+kLZJ+8SlKj0b6YUD7Ojojt60HOQrSWVZnLq6ErQ0atF0DgqqvAwdJ1sRRIYozhrRDpAjwnK21X7yjXdGJjZEORbnbwri2fTBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dw2wD5fl4gmKskf0cY3s6HMjqSiXTZKOmJn2txTzinI=;
 b=NiPziexP+CsOVjrn0hpQbobhCBBHbSZzxFQCqGtoJ0JHG71e0fOWugl3Y4qQsTKErdMdFaoqCl2FDwoJK+1Y4m3x54p/YRUhKezKPpWbkzSaazrGsl0cQSFhju++eXo3acye6AttxsO+6iWscB3614iPftM0Q209GtT1Bizm873emmDivcgJYkukiwerpTfI62ngLQpkdQ4A5qNXqoGt/B79Zd4M1Lyb/DBNaR4Mqb7pcroM37sYfKwbZrM/VaRnB8TM12hCY4X1wqWooQ91HFb2UVr87qlg4N0FVOLJCb2Ra1fPs816dJFptFqdaqVGN+p55SK6jVJ6QQW4O+O6hw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FRYP281MB1898.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:45::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 15:31:45 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:31:45 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol via B4 Relay
	<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionality for
 Wake-on-Motion
Thread-Topic: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionality for
 Wake-on-Motion
Thread-Index: AQHbg9lX2uvVWSTYyEGDMQJusxdmZbNThDYAgBqodzQ=
Date: Tue, 11 Mar 2025 15:31:44 +0000
Message-ID:
 <FR3P281MB17577B5BAF4C31E0C48F8504CED12@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
	<20250220-losd-3-inv-icm42600-add-wom-support-v1-2-9b937f986954@tdk.com>
 <20250222162224.60059025@jic23-huawei>
In-Reply-To: <20250222162224.60059025@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FRYP281MB1898:EE_
x-ms-office365-filtering-correlation-id: df148962-7076-490f-07ae-08dd60b1d49f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZkzxSak/HHcXhD0Dp8wXKBIp21bvlRgLuIXlmJIbmqtEXBEQIQb9WxL+qs?=
 =?iso-8859-1?Q?KuUSU2a3iOspbWDGacW0TrEyNy/Ko++ZBBWdf+t4yDRO3CHriwJId9EyhT?=
 =?iso-8859-1?Q?1TAFkOOACeRDuLh4Nec/uTVfQHPaVeCv7hfYzY8T45rdExpVEfUwGv4pXT?=
 =?iso-8859-1?Q?4JfBwQhm4Zujll4Fw2bs4BGYKrJYzAD/bRV8oCe6PKLmSamhOtLlsIWmIP?=
 =?iso-8859-1?Q?nYNIFTDOYuZsielpMVBkubUYE0vEQEuIWPivMi4RnhEN5aADXAoOfwmnb+?=
 =?iso-8859-1?Q?7bd5+OT+4o3yo1KGE736MHH7yga/0K/kNCHfgd+puuLT3PzXytxQqV/LNy?=
 =?iso-8859-1?Q?ASASsbHBEaPHKApoSvG5PonR4U65WYq2I0xrPbblO0hKQb9IAcvP4i50rd?=
 =?iso-8859-1?Q?qQtH7cnVjwRaPYcqDZao6f4tpbzPrdZECiPPsv0/Sv8zXZO0OdzBKu+R9T?=
 =?iso-8859-1?Q?AvUZqCHWCK6mqMuqmdUhAyIFZmeBBYIvNw8OEeUA9lBaTWiEpk4GtUS35q?=
 =?iso-8859-1?Q?FU/Ief8O9u09K5yYodmgSmpta5YG8sOTHGEHJch5mGDW2qUFj+QkcDGn+m?=
 =?iso-8859-1?Q?VedEBw+rFGTl3Xy4UR3UlGK9LxO08JI0p5nHlqA0YVdvCVwLWh0/4Q5KVx?=
 =?iso-8859-1?Q?Y/A8qVJJRsx7difQZfHoBnC9y4IKShPrk8MuIoZPrfv4bMLlP+Hao1TblP?=
 =?iso-8859-1?Q?a7ZihwhbFPE6UrxV4KWprM6TZfMeXRIRkEehzC58l4HukndY79YKDhQ2i0?=
 =?iso-8859-1?Q?g3SpPZm4SXkrgPG58H1xyml0plA4eJmUQJEp9xCZVKXkHkl3vB73DGLWev?=
 =?iso-8859-1?Q?oPiVl2Epw2azenDohc0xW3wyJZNqpWoDtKKZNY+sCTAQRdD9taLvb4gd5Z?=
 =?iso-8859-1?Q?No3oVnuGbm21njRrFQ4JYz6qU/I/S1XS6M2wzkTanwAIY1PZ3eLoNPbo3v?=
 =?iso-8859-1?Q?u4Seue481DH24bKH/rf4tHso4pITJmbwmZPqiXwojqyDDgQ+LGG2iNOxhQ?=
 =?iso-8859-1?Q?k1rb+Xl2S1AsiGfDCd5Frg8ZIWImJqlL4bAB7AUTpXZwfWDOhmrrQGtNjg?=
 =?iso-8859-1?Q?V7xyCtm2ieEuxkGyo0j9ES/Gi8mLbbVs6AFIQJ9yehh3So7LPoTWIWQd8b?=
 =?iso-8859-1?Q?dc55r68nS8hsOvGbq2YNo/sgx6ZKDV/QaxcqLqYeN/T2m5ZppUCskLEiwC?=
 =?iso-8859-1?Q?NCGBN+9Z036lL+oHA2cR1IYoDRyWSRU9x7eRbbfwvdD6cYZ6HnGYMxR3c4?=
 =?iso-8859-1?Q?wrEL46C1ydQEcg/zSPINYjhVLoEs4KjiI7+U8prn1Uw4zn4jPraP++aa6h?=
 =?iso-8859-1?Q?KleNHIBwWtKppd//QBLM0d4xovazJs/d96t0w4x/hx+8FqexDpT4+bgpI1?=
 =?iso-8859-1?Q?jD221nyZU++bf5uuoXtYWmS3rd4DudABzMG8qCQ92VavwHUZH2XiBgS00y?=
 =?iso-8859-1?Q?M2XXe2LSb/tdEPksHuOV3vc8gylYNj6fZzW/CSotSHy+zJLlABE3ipW6oO?=
 =?iso-8859-1?Q?lC4bQJU/Htm2+zvPZNgCjpdUl2OKo1xhi5Q/nQGhJSYA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3YCiQNw/J5/ayq+VDAvWeHqLC0KKxaUjd67NCoj2t3J24K4b1MFGS8XojY?=
 =?iso-8859-1?Q?8zqjIRty1L3cFFmgd3Cr3nb3O+Q8AJh30VBfcZeVXf7zxGOzjv7it+w36i?=
 =?iso-8859-1?Q?bp7Q1mG9mja6e8Mnv4SAXwyRXiMJ+gcng5tPhsxTn0wkPgNzVzdnDZRgZn?=
 =?iso-8859-1?Q?IBSfMiFgx0qTaELpVRQrHR4fTGjYRq4ZFDR+qDb0432o2f1VQLIiwV8Bwd?=
 =?iso-8859-1?Q?JoVR8RWdB3EBJPE8oYmFwAHNNV7FZm5q9K7P1LfMptZ+DgZiAsAulPhdoi?=
 =?iso-8859-1?Q?efymeuSEpRLP3NtZ9Ai5XECYyg4D2XDBKKK3zbvpc6IzLr9InSljWOxVVf?=
 =?iso-8859-1?Q?A3utfWvPCrA8CQDXNtIYxG/3uKkYtymqV9H7WSs6CLdGiIM4skQLmbgi4U?=
 =?iso-8859-1?Q?SoReDQyUDM/pviSlonDGOfoIRE+Rg1rHFrrnRFgVE9SmPr1YtuSWqO21JA?=
 =?iso-8859-1?Q?x7Cg8EORQLHQK4URDAHJHCCQbvYrZ97vFIsdPic6bQZnAbEE5atwk9tb7Z?=
 =?iso-8859-1?Q?9IGGBudIBn5X+DwzxzLgWDsH5zegTwHgNkqjklZiOQXO+dkjeOrryOlls0?=
 =?iso-8859-1?Q?6lVznggtFIGPlrJjOctfq2P72wPjl2HlOGetRkJuGYGk3xHKVg8o8zM5dx?=
 =?iso-8859-1?Q?dsA9ZrNAzkINeHBI1pPRNU8h0bVbsqGiFP5T+NiGbbYM/o2Ic/171lrz24?=
 =?iso-8859-1?Q?HgtwXBOwfBixrxJoeInpS1XcyvFkl9mwZ6OXVJLbB2fqpzTBARypFZ2tCy?=
 =?iso-8859-1?Q?MM9WhUR+ApA9qXBt+At7pcoNd545vXHUBUND+IrfZkGmOF9qsbNVXL/+Vx?=
 =?iso-8859-1?Q?HJiWWC/uXilbJa+beRaREjN0KhrjEcyn6zJMsKf/oe5HSzqHAMkXHLgRCk?=
 =?iso-8859-1?Q?NwEfzzJHzJJBDOeKUY6l7Qq3dZnmaYbPbVfTHdUlP37hKGN+xQVZnhsk2a?=
 =?iso-8859-1?Q?BaLImv8bytpXaD0t7WHtQVaFGVFF9CjuNQ7HvEDygAE4/S0+Tno/H1+v2O?=
 =?iso-8859-1?Q?dqeYWwlOy+R+hsXEyKIDuXfI4HPDjPp2TprYm9YVywwL1H3PsX7avr0Aox?=
 =?iso-8859-1?Q?rdcw/wquynPAaHaTsHBEIl0eVZo+2AlgwQ8Aw8L2aGL2QjqpyZ2xJS7GwR?=
 =?iso-8859-1?Q?w01gRixV1AxjEqq0BS89lEmw6BBvNbTKdyuIlZBoSXkkVCPfSDieaVmjZI?=
 =?iso-8859-1?Q?K8topOhi113oyEBoJMQPzkojPqmhqo1cUGIHQyDPWZ/+7vp0M9pk5GXekW?=
 =?iso-8859-1?Q?ZQ1uThG7xnWR4iHvtWGKbTIeaii7clj/XlQtkXmuAu18vbEcGtIDudRvRE?=
 =?iso-8859-1?Q?0qa6ITGsg3DvEt7qWObxRv3LiVCrhr4KoNm6o+honrxkSNt6cXgzu3+Pqf?=
 =?iso-8859-1?Q?o46TUEqiulZN5R56/prB2GK8UJfjGsqzfBHvjfuLix9Btbp1d0HdAWrEc4?=
 =?iso-8859-1?Q?Z0DIkeshx142uX8l7MspsTBo043gf2tav1jXAPqh3rNJDcIziX/PEdogk+?=
 =?iso-8859-1?Q?nIreluImQnWss26hxvYJrcy9pphaa2WM5WpnYwPq0EaOELA63HJJfuFeC2?=
 =?iso-8859-1?Q?j0BAzzuL5QvjLU79jpioiYbvqCs0rpCVN/V8eHsOkP+MuMOY8gt/uKDgoh?=
 =?iso-8859-1?Q?KaaYxaS1shwDwdNn7ss21Ehae6uftQhEJ/6vzkLxvG1DnGMTmlsaW3JlwE?=
 =?iso-8859-1?Q?tWuCVNrdPaffnGMfpQPBcaLMmvT+nI9FLqn2NwtOpTC8+Eki6WTHo9OjaB?=
 =?iso-8859-1?Q?fpxA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df148962-7076-490f-07ae-08dd60b1d49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 15:31:44.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVayl7WnB1uSWkPq9C0Z5OrtdOlsACYXYUNZA93EOFG+ES+2/Ru5TySlqkyIhjmOqfWFTsn3weUsXKxozcSN3f1+tFiDqyvHjDpncIi3/nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB1898
X-Authority-Analysis: v=2.4 cv=dtEhC0g4 c=1 sm=1 tr=0 ts=67d05771 cx=c_pps a=kbKyS8rizmOnFcp7qPeTiQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=XwEM8jFBGt80uNHnIO0A:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-ORIG-GUID: 7qBJuxCs_1R8Yx97qFweFWuZjGaOJMAP
X-Proofpoint-GUID: 7qBJuxCs_1R8Yx97qFweFWuZjGaOJMAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110098

Hello Jonathan,=0A=
=0A=
still sorry for not being able to reply in-line.=0A=
=0A=
No problem for all changes, except handling the 2 interrupt lines. Currentl=
y our driver only supports INT1 and cannot work with INT2, and this is not =
related to Wake-on-Motion feature. This is something we could add in anothe=
r series, and I prefer to have a dedicated series for that.=0A=
=0A=
For the mutex rework, I will delete them. This is something we can also do =
in another dedicated patch not inside this series.=0A=
=0A=
Is that OK for you?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Saturday, February 22, 2025 17:22=0A=
To:=A0Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.t=
dk.com@kernel.org>=0A=
Cc:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Peter C=
lausen <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.=
org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH 2/2] iio: imu: inv_icm42600: add wakeup functionality=
 for Wake-on-Motion=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Thu, 20 Feb 2025 21:52:07 +0100=0A=
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com=
@kernel.org> wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> When Wake-on-Motion is on, enable system wakeup and keep chip on for=0A=
> waking up system with interrupt.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
Hi Jean-Baptiste,=0A=
=0A=
A few comments inline.=0A=
=0A=
> ---=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h       |  2 +=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c |  3 +=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c  | 89 +++++++++++++++--=
------=0A=
>  3 files changed, 63 insertions(+), 31 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h=0A=
> index 8dfbeaf1c768d7d25cb58ecf9804446f3cbbd465..baf1dcd714800e84ccd21dc1d=
1e486849c77a9ae 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> @@ -151,6 +151,7 @@ struct inv_icm42600_apex {=0A=
>   *  @map:		regmap pointer.=0A=
>   *  @vdd_supply:	VDD voltage regulator for the chip.=0A=
>   *  @vddio_supply:	I/O voltage regulator for the chip.=0A=
> + *  @irq:		chip irq.=0A=
=0A=
Maybe say a little on what the variable is used for. It's not otherwise=0A=
obvious why we need it.  Also, does this chip really only have one irq line=
?=0A=
Looks like there are two. So the drivers should be fixed to cope with the=
=0A=
only one wired being irq2  unless I've found the wrong datasheet which is=
=0A=
certainly possible.=0A=
=0A=
=0A=
>   *  @orientation:	sensor chip orientation relative to main hardware.=0A=
>   *  @conf:		chip sensors configurations.=0A=
>   *  @suspended:		suspended sensors configuration.=0A=
> @@ -168,6 +169,7 @@ struct inv_icm42600_state {=0A=
>  	struct regmap *map;=0A=
>  	struct regulator *vdd_supply;=0A=
>  	struct regulator *vddio_supply;=0A=
> +	int irq;=0A=
>  	struct iio_mount_matrix orientation;=0A=
>  	struct inv_icm42600_conf conf;=0A=
>  	struct inv_icm42600_suspended suspended;=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> index 8ce2276b3edc61cc1ea26810198dd0057054ec48..4240e8c576f4d07af5434e9a9=
1dfda532f87ffb9 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> @@ -1149,6 +1149,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_=
icm42600_state *st)=0A=
>  	if (ret)=0A=
>  		return ERR_PTR(ret);=0A=
>  =0A=
> +	/* accel events are wakeup capable */=0A=
> +	device_set_wakeup_capable(&indio_dev->dev, true);=0A=
> +=0A=
>  	return indio_dev;=0A=
>  }=0A=
>  =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
> index c0fd2770d66f02d1965fa07f819fd2db9a1d6bd2..f94bda5dc094d6cc85e3facbd=
480b830bfbaa3f9 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> @@ -751,6 +751,7 @@ int inv_icm42600_core_probe(struct regmap *regmap, in=
t chip, int irq,=0A=
>  	mutex_init(&st->lock);=0A=
>  	st->chip =3D chip;=0A=
>  	st->map =3D regmap;=0A=
> +	st->irq =3D irq;=0A=
>  =0A=
>  	ret =3D iio_read_mount_matrix(dev, &st->orientation);=0A=
>  	if (ret) {=0A=
> @@ -829,44 +830,56 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "IIO_=
ICM42600");=0A=
>  static int inv_icm42600_suspend(struct device *dev)=0A=
>  {=0A=
>  	struct inv_icm42600_state *st =3D dev_get_drvdata(dev);=0A=
> +	struct device *accel_dev;=0A=
> +	bool wakeup;=0A=
> +	int accel_conf;=0A=
>  	int ret;=0A=
>  =0A=
> -	mutex_lock(&st->lock);=0A=
> +	guard(mutex)(&st->lock);=0A=
=0A=
As below. Pull these guard changes out as a precursor patch. That will make=
=0A=
it easier to spot the real changes here.=0A=
=0A=
>  =0A=
>  	st->suspended.gyro =3D st->conf.gyro.mode;=0A=
>  	st->suspended.accel =3D st->conf.accel.mode;=0A=
>  	st->suspended.temp =3D st->conf.temp_en;=0A=
> -	if (pm_runtime_suspended(dev)) {=0A=
> -		ret =3D 0;=0A=
> -		goto out_unlock;=0A=
> -	}=0A=
> +	if (pm_runtime_suspended(dev))=0A=
> +		return 0;=0A=
>  =0A=
>  	/* disable FIFO data streaming */=0A=
>  	if (st->fifo.on) {=0A=
>  		ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,=0A=
>  				   INV_ICM42600_FIFO_CONFIG_BYPASS);=0A=
>  		if (ret)=0A=
> -			goto out_unlock;=0A=
> +			return ret;=0A=
>  	}=0A=
>  =0A=
> -	/* disable APEX features */=0A=
> -	if (st->apex.wom.enable) {=0A=
> -		ret =3D inv_icm42600_set_wom(st, false);=0A=
> -		if (ret)=0A=
> -			goto out_unlock;=0A=
> +	/* keep chip on and wake-up capable if APEX and wakeup on */=0A=
> +	accel_dev =3D &st->indio_accel->dev;=0A=
> +	wakeup =3D (st->apex.on && device_may_wakeup(accel_dev)) ? true : false=
;=0A=
> +=0A=
> +	if (!wakeup) {=0A=
> +		/* disable APEX features and accel if wakeup disabled */=0A=
> +		if (st->apex.wom.enable) {=0A=
> +			ret =3D inv_icm42600_set_wom(st, false);=0A=
> +			if (ret)=0A=
> +				return ret;=0A=
> +		}=0A=
> +		accel_conf =3D INV_ICM42600_SENSOR_MODE_OFF;=0A=
> +	} else {=0A=
> +		/* keep accel on and setup irq for wakeup */=0A=
> +		accel_conf =3D st->conf.accel.mode;=0A=
> +		enable_irq_wake(st->irq);=0A=
> +		disable_irq(st->irq);=0A=
>  	}=0A=
>  =0A=
>  	ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,=0A=
> -					 INV_ICM42600_SENSOR_MODE_OFF, false,=0A=
> -					 NULL);=0A=
> +					 accel_conf, false, NULL);=0A=
>  	if (ret)=0A=
> -		goto out_unlock;=0A=
> +		return ret;=0A=
>  =0A=
> -	regulator_disable(st->vddio_supply);=0A=
> +	/* disable vddio regulator if chip is sleeping */=0A=
> +	if (!wakeup)=0A=
> +		regulator_disable(st->vddio_supply);=0A=
>  =0A=
> -out_unlock:=0A=
> -	mutex_unlock(&st->lock);=0A=
> -	return ret;=0A=
> +	return 0;=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> @@ -878,13 +891,25 @@ static int inv_icm42600_resume(struct device *dev)=
=0A=
>  	struct inv_icm42600_state *st =3D dev_get_drvdata(dev);=0A=
>  	struct inv_icm42600_sensor_state *gyro_st =3D iio_priv(st->indio_gyro);=
=0A=
>  	struct inv_icm42600_sensor_state *accel_st =3D iio_priv(st->indio_accel=
);=0A=
> +	struct device *accel_dev;=0A=
> +	bool wakeup;=0A=
>  	int ret;=0A=
>  =0A=
> -	mutex_lock(&st->lock);=0A=
> +	guard(mutex)(&st->lock);=0A=
=0A=
Good change.  But separate patch as not related to most of what is going on=
 here.=0A=
=0A=
=0A=
>  =0A=
> -	ret =3D inv_icm42600_enable_regulator_vddio(st);=0A=
> -	if (ret)=0A=
> -		goto out_unlock;=0A=
> +	/* check wakeup capability */=0A=
> +	accel_dev =3D &st->indio_accel->dev;=0A=
> +	wakeup =3D (st->apex.on && device_may_wakeup(accel_dev)) ? true : false=
;=0A=
> +=0A=
> +	/* restore vddio if cut off or irq state */=0A=
> +	if (!wakeup) {=0A=
> +		ret =3D inv_icm42600_enable_regulator_vddio(st);=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
> +	} else {=0A=
> +		enable_irq(st->irq);=0A=
> +		disable_irq_wake(st->irq);=0A=
> +	}=0A=
>  =0A=
>  	pm_runtime_disable(dev);=0A=
>  	pm_runtime_set_active(dev);=0A=
> @@ -895,13 +920,15 @@ static int inv_icm42600_resume(struct device *dev)=
=0A=
>  					 st->suspended.accel,=0A=
>  					 st->suspended.temp, NULL);=0A=
>  	if (ret)=0A=
> -		goto out_unlock;=0A=
> +		return ret;=0A=
>  =0A=
> -	/* restore APEX features */=0A=
> -	if (st->apex.wom.enable) {=0A=
> -		ret =3D inv_icm42600_set_wom(st, true);=0A=
> -		if (ret)=0A=
> -			goto out_unlock;=0A=
> +	/* restore APEX features if disabled */=0A=
> +	if (!wakeup) {=0A=
> +		if (st->apex.wom.enable) {=0A=
> +			ret =3D inv_icm42600_set_wom(st, true);=0A=
> +			if (ret)=0A=
> +				return ret;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	/* restore FIFO data streaming */=0A=
> @@ -910,11 +937,11 @@ static int inv_icm42600_resume(struct device *dev)=
=0A=
>  		inv_sensors_timestamp_reset(&accel_st->ts);=0A=
>  		ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,=0A=
>  				   INV_ICM42600_FIFO_CONFIG_STREAM);=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
>  	}=0A=
>  =0A=
> -out_unlock:=0A=
> -	mutex_unlock(&st->lock);=0A=
> -	return ret;=0A=
> +	return 0;=0A=
>  }=0A=
>  =0A=
>  /* Runtime suspend will turn off sensors that are enabled by iio devices=
. */=0A=
> =0A=
=0A=

