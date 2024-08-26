Return-Path: <linux-iio+bounces-8781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF8295ED3D
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 11:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A4C28195D
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF54146A6C;
	Mon, 26 Aug 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="RqUV3+kf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072AB143C70;
	Mon, 26 Aug 2024 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664670; cv=fail; b=RW5VzcWB+ZqVCK5g2JDQfsDS6WsHMLFP4Qst7yVljQ3sDkG/8h0FUxPZVJBHNDS5JPbIX3T1SSHi/S90XmR6Xe50y9FpMbZlb3WRAU3978df/eMHRZvY+ELDAoZe/qJCDZEz+4xXeL2g5HXUTBB6by/IJqxFX7UgiSbk5ZlVOj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664670; c=relaxed/simple;
	bh=C/+FPygf4aXaZ8hS5KKZ8UcwhENppnF9AZMM6199ga4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JhEt5FX+kd2blAFItowxRq51qw1vHx1CFzdhLXlr7bu/HJFh/FnkDR2cHF4LaWtJ+6WglcZI3QayeWtFkc1gbeaBF7115zQbF+lM3FZtGllBkNINvqLl5/SD8OJeiZph9qZT0LLsMuiDWllt498+c48btOet/ajRyL0tECJZ6m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=RqUV3+kf; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PNJLpK031307;
	Mon, 26 Aug 2024 08:22:18 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazlp17012054.outbound.protection.outlook.com [40.93.78.54])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41797q91p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 08:22:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3NbeqsCyNrsIdkdAokZvLIRL0fB/9+dXmx5xiJzDOIHB4WlXRvEFkDtsfmESvUCyjEtBe4VAKku0GIVxB/k0gTfyHbsQ8Tr3qTjJkGOMOzdQRmWfU7/Hwwd9Tw1DIjXkkUjr6auMOMZn7w1KF0jO1u8qmri5xJWvvM5om7Um2RLboBD+2YUWMKe61RGYxzNtRg3N3ufPxHD3EqWR6a5l20O0+kDsbTmTUMryNjcq9JZDapSoOGYLNsZ7I0K7AsgybSUywNQNpjHgGtIIxlP1zfZhmQsaOYzeTvMMSrtWb2tW06eJQQV6owHT2OKzFCdCkgLMHzoBg5FpFRKMdAiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tItzovgHkdDYbV2euvqdpD/qj22GdOehP4XlgRLu9w0=;
 b=rqte66noHUgykBFS9IigJtydIEuk/AMic7ezPH7A/+zuYPDV28+499AKzweFyXxkpjkSWnL6qOhm8p72l9wMOrUx96F07qWPjZQ+r8MQqvnp/UgtsR8SA3AgpR1Wdb/d6X87WfDs8111cikouUQcr02yMsrVO6ySfEXMu7wkKQzk3xU/FLNMWEk8fTwY/EZ6VYkTtOLd1CNaLe5Wm4P6J9/qwugBsEpZDec8zoQ4wMhVckCkyHFTk1mhKObqE1+bF0nEUF2oZVwxpyz0GcvJXmEEs0qYUoZHtWdKnOaFw7gEx+OQzzbg5/xlnPWdwNB7U2MKbFHtTVZGtsvX+KS2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tItzovgHkdDYbV2euvqdpD/qj22GdOehP4XlgRLu9w0=;
 b=RqUV3+kfFdNHn5JYFHovmK5IU0j1uQfx4jnbcFDGEV1WsIwE/3hNBazJAWWa2Xn9+FJgJkLXNCsWjkWiKoYpX+6PWgi/JcSROaEA1qL9ngNuiqBzoPjgcjlVI86TzN0pnMItL+69vj+9BfqlVMLq38KvCmm4QwvQwm4HgD/ymprinMMkkix7WipqnnuBhgBgzzUMt+AYZvVbdnismpCAa226VyXHFKb55zg4RlJo6ASIZeKyb2NCtyC/o+j42V9cepE2KV5AABaVW3xQ7w/GTTd6biJ02DC+d0Npv5yNepb9y7pE8WJ3HtYZifAut2HmtkfgqtPtJUVBA3Oo/HGGdw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEYP281MB4282.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 08:22:12 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:22:12 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jason Liu <jasonliu10041728@gmail.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de"
	<lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Thread-Topic: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Thread-Index: AQHa9rmgqTimB9qMZ0ezhD6k7oXBDbI5M8nJ
Date: Mon, 26 Aug 2024 08:22:11 +0000
Message-ID:
 <FR3P281MB1757A595F22A1F9AE50B76B1CE8B2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240825063938.56319-1-jasonliu10041728@gmail.com>
In-Reply-To: <20240825063938.56319-1-jasonliu10041728@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEYP281MB4282:EE_
x-ms-office365-filtering-correlation-id: 9134d3e4-9ff0-4ff4-9633-08dcc5a82f5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zD9uIUBA03J35uLZloCDOnHWbOI7w/UfUX1B+50BR8s+2J8+RX4x7Hl58O?=
 =?iso-8859-1?Q?/Ke2UvTDNJdVHHBsG11G6GRgerrVhv/jwrItlCEfmEmn8YVUrqMMR5cDG1?=
 =?iso-8859-1?Q?vicIlWjvPKnah0OC8/d7Die/DLjKqd/HPzS9gOlcpTtGguFgJBRjm4BFMI?=
 =?iso-8859-1?Q?4ar4iASq8piyDWser6JAJiifuEI1XO34Th+NP9e/XbYycmMHKLrZCMnU8+?=
 =?iso-8859-1?Q?0NXuvgIM0IquGzyiQ0tO8lxzJooAUbhmPv2x/9L9wlTvs/HcKeMYHvyuNM?=
 =?iso-8859-1?Q?lk5k3646A7ZhEbhQDni+Yovp+ABS8E9D3X3mlqlr2IwQuctaFNDYnAqbeH?=
 =?iso-8859-1?Q?qqMphoj1SRFHF0RK3gFyg/7RxjkgLT/gNqtM1yzqjK/ync7OaesNgYE5zC?=
 =?iso-8859-1?Q?iCge5Puckg0cAnAJEWatr70clnad97XTmpKAFH3N5IbAMlUIJg0+OZewLX?=
 =?iso-8859-1?Q?ITH9P4r51zn7PcyzL6QLPeGoMcJJ/iZqJkqKifM1iJdE3eSd/gYjiDN3jf?=
 =?iso-8859-1?Q?b8zF0N1t6DW+4SjUEQ5+1urKGb3rkL6ghc8XWu/CcTIZfst5HjsUtqytC+?=
 =?iso-8859-1?Q?YQCf9uv97S4+iMeZzWrqUVp4bSckjNwE54Dw82uQndG0BSmdAc5kamU3IU?=
 =?iso-8859-1?Q?0zyZBAXuax5lLpfwWCerLmw+6nCj3IED9YYq5dtW6Hk7clyFtRM8e3KIxa?=
 =?iso-8859-1?Q?yr3Va6Drjmi4eQ+/7QBACTMvAGc1wiiex01GIXGkqKTso5QKBnwNNTj2/e?=
 =?iso-8859-1?Q?2aBXTDmFmazsw0ugQsrHT9atWBuNxECIrwEZJqUcFuJ2NkL8gPL2DF14or?=
 =?iso-8859-1?Q?v2kXq5fuFrQsL10xexX0D7RGKdSD+hth/uu6WMwCHX8rHcbwDNP/nTNj96?=
 =?iso-8859-1?Q?9OsU8RWLLs5pLnJtF2um7yqLepgQT3Il93LGmj2SF1MNmo1dqFzhkhqRrW?=
 =?iso-8859-1?Q?VkfqOHXRNrNgi773vG5y3WwBt3Qo72E0e7YmeHcZwMKeFeh9YK0uuXxarg?=
 =?iso-8859-1?Q?STDo+XbUoW1gOrM7/0Ih2mh9j1cDlzZHkLIXGUA0vb8BQs1kGEIkRup26Y?=
 =?iso-8859-1?Q?FdbW8gqObRtL3XzDz2uBul3fPbiFFVo6ZydqF+g2cBdWwa34rxDB06GuGw?=
 =?iso-8859-1?Q?RRlbdWLwYV3FeSv9CwviUFFOxWW/8l6p/QRE64G5KPccVUH5ZgtaOW22Fe?=
 =?iso-8859-1?Q?88KKUbf/uZpwH4F1qyXF7K9BxFHPDPBWasx9vKafdTzh2H3qgrStcFSgEq?=
 =?iso-8859-1?Q?W91Y+wVmH3PEf2VcWth24oEmWJRD9finsdT9s4UJDcimfr0jqdv7PPF/5w?=
 =?iso-8859-1?Q?3n9mFJlrrHvunDJ3MOQjgON3/PuQ6t/K566o76ukyr0ORBd31ww03f2ieL?=
 =?iso-8859-1?Q?pwv0BcUdaUk3j8REPagBEvMcJ4duDc9LrQ4Aq/IDFV/tuNYs7N+mFQZCKu?=
 =?iso-8859-1?Q?ha4Dj5pGcZQFhZF7afR+8zVuV4FDX91HeUBc/rny/8xLpU1tEuNUI/Wp0J?=
 =?iso-8859-1?Q?Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?y/d5Djce5tnxBSPjNtjk9DfwJxCulKRJk7igCdNnfGilsgJNZUtQ1ZCSzH?=
 =?iso-8859-1?Q?99XxdkKLQX3fKA6hFSNuHe6jJAsrHixT5nm4Jugywv70WEVoPubgRq69VA?=
 =?iso-8859-1?Q?H0EfBEh5HSYDaV+Vf4JitrZlcGDlUfdqmz/R6sxHZxzqjZdG0zlW5oggFX?=
 =?iso-8859-1?Q?BGseCNJvh2GoSaf3SwmcqW5I/xZMeQkkbIZ7CMBvc0BFCm/0lGVKvtFW2R?=
 =?iso-8859-1?Q?3a52jwxC+B796KWFNHVVUg72Nn1PBCsXRd8IZ7eP3n6O9yAu2HalF9tKAM?=
 =?iso-8859-1?Q?v/uRkAOjPuWwYT80xhdnzsbW4Pj/nQNwuGfS5UwuljksFnF4utmVSkKNy6?=
 =?iso-8859-1?Q?GciL+NudgM1GbWuMz46sCGpOaP5UTWq/KPBahXynfq++TA0lm774RGmX9P?=
 =?iso-8859-1?Q?7H2sSGjRUuOp1B7Zew7fWhIC9SbgRZxL4uou3fPVb4KzW6ehYBk7P/x539?=
 =?iso-8859-1?Q?q0hCaHZuLD8oB5y4tzcm3SIiA9uc3eLjWnCh7MlyYjsdnIdqS9dFHqtojl?=
 =?iso-8859-1?Q?0txhUEBGkPPzGUwIclg5MrY4J1MnKOpI7aahZnbaMVG/NpOfXXfWoDwy2q?=
 =?iso-8859-1?Q?JWEL3yAviAaBeonErdEkxCqsGnoACIiyqGxXBhPesNEuryrRKa3GyDUkKO?=
 =?iso-8859-1?Q?xQCFqD40f+2oA2i2IWgWDRlNkmWvJ5CCEKBVmLoyAmRMsI7HOgUPt+Hbl2?=
 =?iso-8859-1?Q?23H7F79qt2MenJuPPcWlEidtnxXhcpRXlHajayQPlURlxGXXddsZ1T2WF4?=
 =?iso-8859-1?Q?XQm2lhO3eAmaJiWhWRA7e6FhLT2Lh/O7mACZpNuE5BXAtKxTtYdVkLdqCq?=
 =?iso-8859-1?Q?05FaSlHNKWoPhq8yyLz3t9UiA7UxSuVD3QM2Up6clVCAtrHuoRye2dQx76?=
 =?iso-8859-1?Q?DwQS52feb8b+GBu5oAsBNAIdllFBA28lUh1AWKjPanOyt223AgSlCdMqlu?=
 =?iso-8859-1?Q?pt3cvC6Hlt+6nyt0S1M4NYSTOL+e7Fv1HlD4F2ood7bh6IRwmisVH7NAvF?=
 =?iso-8859-1?Q?Fxj19u/Zt4vYV77H//56TV5HcB66piHmuJtdGi4cWsvtHDFVUL8zESZDrl?=
 =?iso-8859-1?Q?cf8zmaewDEBPi/4wvdzySFIhNF8n9+X5cO4BOLint91H1OY542f2+e0m6O?=
 =?iso-8859-1?Q?GMXVzg/QqlRTPpQ5N7ENyI2QdJS34L4jXjLGuEdfO/jpo2sNE/6p8WLNtv?=
 =?iso-8859-1?Q?1MJ61524atnyu14/C/BUwqTDZa6RSu1G5To4Lsxgw1xHHrXNVW0m+hLGU7?=
 =?iso-8859-1?Q?R8VGf1JtHO0xtsFEqjgPOFactK4gStI2ZKgZjTIw5HuYy9UvT1lwLxDwdN?=
 =?iso-8859-1?Q?PtGaOhHGGst6LC9zlHznW/gZzOuHwvs4SrroYLIzL7J1gcLQggE3J3g/ai?=
 =?iso-8859-1?Q?fW73B2/q2olt982UCbQ8UnvqtzV1mQNAL3HucKYMoYXRp/JhLaPhL7lHFm?=
 =?iso-8859-1?Q?8uPe3D7iJlslxfBX7PebFUO5nM6I7OGCUuT3pDtJJzdbKTjRpLdLAnUWfo?=
 =?iso-8859-1?Q?bmRy2XCX2s7asQ0ESIiQDFDDudxVD3rU1x960s6NtQFJq/4umf1zUntZwN?=
 =?iso-8859-1?Q?YNQak9DsIOTiByLPiT6+GPNB9DGx2aUtfCoAplY9ZJElo8dLxcnJFU75bC?=
 =?iso-8859-1?Q?og0qDi6F263A6ltaTbaThl/BYvPiMyRcw0A+HYOhTVR9obF2Oj3NZrfg?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9134d3e4-9ff0-4ff4-9633-08dcc5a82f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 08:22:11.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaJpwi5JPZ76wdU/8omJq6ZiLEq5CyhCtbg2DMNN0OyomFk8YZg01G40bAA7IbT3Mmqmn0wmx87wnfN37HJjsxYGVeVx5XZEwDgcK90u8Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB4282
X-Proofpoint-GUID: lAHpj-fnk1kAHzk3ThfJLjOm5gzag4KP
X-Proofpoint-ORIG-GUID: lAHpj-fnk1kAHzk3ThfJLjOm5gzag4KP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_05,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408260065

Hello,=0A=
=0A=
I was believing that id tables weren't required anymore when using of table=
s.=0A=
=0A=
Jonathan,=0A=
can you help on this subject?=0A=
=0A=
If we have to add id tables, then we need to add all supported chips (missi=
ng here icm42686 and icm42688).=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jason Liu <jasonliu10041728@gmail.com>=0A=
Sent:=A0Sunday, August 25, 2024 08:39=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Cc:=A0jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de=
>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger=
.kernel.org <linux-kernel@vger.kernel.org>; Jason Liu <jasonliu10041728@gma=
il.com>=0A=
Subject:=A0[PATCH] iio/inv_icm42600: add inv_icm42600 id_table=0A=
=A0=0A=
This Message Is From an Untrusted Sender=0A=
You have not previously corresponded with this sender.=0A=
=A0=0A=
Add the id_table of inv_icm42600, so the device can probe correctly.=0A=
=0A=
Signed-off-by: Jason Liu <jasonliu10041728@gmail.com>=0A=
---=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 15 +++++++++++++++=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 15 +++++++++++++++=0A=
 2 files changed, 30 insertions(+)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_i2c.c=0A=
index ebb31b385881..8cc550b8cfc3 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
@@ -71,6 +71,20 @@ static int inv_icm42600_probe(struct i2c_client *client)=
=0A=
 				       inv_icm42600_i2c_bus_setup);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * device id table is used to identify what device can be=0A=
+ * supported by this driver=0A=
+ */=0A=
+static const struct i2c_device_id inv_icm42600_id[] =3D {=0A=
+	{"icm42600", INV_CHIP_ICM42600},=0A=
+	{"icm42602", INV_CHIP_ICM42602},=0A=
+	{"icm42605", INV_CHIP_ICM42605},=0A=
+	{"icm42622", INV_CHIP_ICM42622},=0A=
+	{"icm42631", INV_CHIP_ICM42631},=0A=
+	{}=0A=
+};=0A=
+MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);=0A=
+=0A=
 static const struct of_device_id inv_icm42600_of_matches[] =3D {=0A=
 	{=0A=
 		.compatible =3D "invensense,icm42600",=0A=
@@ -104,6 +118,7 @@ static struct i2c_driver inv_icm42600_driver =3D {=0A=
 		.of_match_table =3D inv_icm42600_of_matches,=0A=
 		.pm =3D pm_ptr(&inv_icm42600_pm_ops),=0A=
 	},=0A=
+	.id_table =3D inv_icm42600_id,=0A=
 	.probe =3D inv_icm42600_probe,=0A=
 };=0A=
 module_i2c_driver(inv_icm42600_driver);=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_spi.c=0A=
index eae5ff7a3cc1..5fe078ddc8a1 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
@@ -67,6 +67,20 @@ static int inv_icm42600_probe(struct spi_device *spi)=0A=
 				       inv_icm42600_spi_bus_setup);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * device id table is used to identify what device can be=0A=
+ * supported by this driver=0A=
+ */=0A=
+static const struct spi_device_id inv_icm42600_id[] =3D {=0A=
+	{"icm42600", INV_CHIP_ICM42600},=0A=
+	{"icm42602", INV_CHIP_ICM42602},=0A=
+	{"icm42605", INV_CHIP_ICM42605},=0A=
+	{"icm42622", INV_CHIP_ICM42622},=0A=
+	{"icm42631", INV_CHIP_ICM42631},=0A=
+	{}=0A=
+};=0A=
+MODULE_DEVICE_TABLE(spi, inv_icm42600_id);=0A=
+=0A=
 static const struct of_device_id inv_icm42600_of_matches[] =3D {=0A=
 	{=0A=
 		.compatible =3D "invensense,icm42600",=0A=
@@ -100,6 +114,7 @@ static struct spi_driver inv_icm42600_driver =3D {=0A=
 		.of_match_table =3D inv_icm42600_of_matches,=0A=
 		.pm =3D pm_ptr(&inv_icm42600_pm_ops),=0A=
 	},=0A=
+	.id_table =3D inv_icm42600_id,=0A=
 	.probe =3D inv_icm42600_probe,=0A=
 };=0A=
 module_spi_driver(inv_icm42600_driver);=0A=
-- =0A=
2.25.1=0A=
=0A=

