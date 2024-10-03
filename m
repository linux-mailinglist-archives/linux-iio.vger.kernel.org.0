Return-Path: <linux-iio+bounces-10021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8079198ECA6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 12:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB601F217AA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD2F1494A3;
	Thu,  3 Oct 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="acwLsrUv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865112F5B3;
	Thu,  3 Oct 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949830; cv=fail; b=P4HPrN2+oPE3x35Qn9oCTuRDflxcywARxvKdMR8nLq/T0RdC8Ret/1FIW+DfG4xTHE1k6fdR1v4RhAWnuHxAbtgJM9K/jKOz5+cMO1pvPIWuME5AuyXTW6d6QGGahLW5zbGxG2Z4pluexk7txSkq+FCIKrA7XxWuahZtuqN6XNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949830; c=relaxed/simple;
	bh=Vzw76ue7/vuTcr5WHKn/4yJr/iV8ZJDAMZK/rOjdvRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QE0PFKc09nv3AlnCabRp3JHJX5WqHn381h8glbWZlHOoQS9Rk4Kf6WmT+g5HzpohCuBAsyVHVSPtzy9iQ5M+5j3sXK0cvLVze+uD95hTeDn8ECLDj7QH9ZODp1ohOY8KEmI4HchrRgAjP1DYbl3gczUhb7fwfA7NWuGH+oFHBCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=acwLsrUv; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492L54Br013875;
	Thu, 3 Oct 2024 10:03:20 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazlp17012050.outbound.protection.outlook.com [40.93.78.50])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41x8603hvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 10:03:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvcgWfvRD+Dgbdq0SurJKjF2P3rfmd+o8sliwK3Lu72kzqS+IXWNLEndB1wlcVsd1U0sxlla6mocKYuqvY8I59LhvJtYRXslcq2dkGyBf7RkX0CAq8tRQ7TgRl+VkXxGL++1iEidzxNEpg6gAnfPba6vZtKf/OKlvwCJwKB53pocW+aaaZ7J2Kg7NG5OwgoaY1+zU6y/KJ5z3GqMtq5N+XXBHDqRJtOF3O86vQVGsXfN0ZOzyPFUtfzMxJ6oNZmenXCLoIuuXWby3ML7QjiO5ZBK/63iFMgoR6Hr34ggDrxWN0yPx/kIei5+XGrRJfC6qMua+r41xRKBzxiXOhhj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzw76ue7/vuTcr5WHKn/4yJr/iV8ZJDAMZK/rOjdvRI=;
 b=JWfMidP4B1DMqpPoAEFni6BLaCj4Jc0fP+UUSJTlJBJHOyBG9frCRBp3ttRWhsQmkaDPchWVMMrwXs0yFv1SCqyIW56uLYDSDbIXmfbWb2jrSNZDibrHj4zoun3UMqGYFZGjL6CPftnCsLvEbUXrLRbczApUn8kGFEZpXoDQWHCbrZRzwr+KTnktMqoiOuxcEcYKd5sGdBlH+23p0SmbWC2U6cBTvJJPJmzdZhR0jJiXtZtr5hRgcjCi7KtY8sknZTVlMhMRuH+glo4G7iOBIxc2Z0pIUBb74kKodBOX/2txAEZrFYP4g+TbTf26aBmMQlJFoTavaMT5Y1ZipwlGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzw76ue7/vuTcr5WHKn/4yJr/iV8ZJDAMZK/rOjdvRI=;
 b=acwLsrUvwePdsJ2w7/iS8P4Xn8ZxO+akM91hTmq008/DDohrITRxXMBn/5LgSsmHGOnsicuXMaIlVi6ltGcEhI/t9yGg3TY95tTnneRH3fSTQYx6dM83/cjEv95zswEk+FIuCLUd80DcuuLoDKX/CO0EjWI1qN/5/HMDyq/6ORDutRhKBBX0bwDkqyWX1YwjfXXfFF26T7OFZkPIvbs84jcy/UkH2vVydnumUjulCn+frmqxq6/ZY/SNQ5suCPCTxt8Or5M/0JwMOh4MvTdXPuD1yzJvfT/UAL2dvKcCyfhZv8NIpLpTTe0FbimR70M49hhM0NpOvkrIhmykaGL/2w==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR3PPFAF653D402.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::180) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 10:03:16 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 10:03:13 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] MAINTAINERS: iio: migrate invensense email address to
 tdk domain
Thread-Topic: [PATCH 1/3] MAINTAINERS: iio: migrate invensense email address
 to tdk domain
Thread-Index: AQHbFWcw5EzX7ero20u5ra4h2G70GbJ0pY+AgAAZquI=
Date: Thu, 3 Oct 2024 10:03:12 +0000
Message-ID:
 <FR3P281MB1757F280DAA6B8F4A5A44D51CE712@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com>
 <20241003-invn-maintainers-email-update-v1-1-7e4062ad68cf@tdk.com>
 <b8a359d7-5043-475f-95c2-0bad2a9f6f92@kernel.org>
In-Reply-To: <b8a359d7-5043-475f-95c2-0bad2a9f6f92@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR3PPFAF653D402:EE_
x-ms-office365-filtering-correlation-id: b60b2bab-f609-428a-b38c-08dce3929769
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?YF/sGU2nTmrg0N3NRpGJ6DlCPJzMutd5tajcJwmvnBbyrrWuIatVI7DVYP?=
 =?iso-8859-1?Q?phIRgWUNGe31MlrSeuJTxB4W4J5zGMUN2N/yY5bBReG/mxGO6pOpWiCUAi?=
 =?iso-8859-1?Q?0gZKoR9V3GGeIhygyRTNPu9Zsj7H5bGTOkHzFtTUxx9yT1foebl1khVrAk?=
 =?iso-8859-1?Q?r8zdMC64ddqIxqE2yGE0t/Zf3ilHunT2Ls/Uy1CsKUcjkmoWWzKCLPpyit?=
 =?iso-8859-1?Q?2vvxhreP10redgo6fY7PVoh+IjCwsSxtTVJmW7w8eOygvfQEl+gtS1k3gr?=
 =?iso-8859-1?Q?lAOQwlxKfrfZetp29fOIzFku+Vj/++2Y/svYgBBT71el/j2xhUj4eZo2bS?=
 =?iso-8859-1?Q?47ljILzzxaCDh3yk7Y2STLJ77bPOLeId153PTSHERWt1WJ8nfrnY1Bep7u?=
 =?iso-8859-1?Q?NQySrKJtBgI1DdvQzQhWoQZnHM6BnAAuWN7nFvqycvW0SuDYwmUH3Zzx2b?=
 =?iso-8859-1?Q?wEA5PPThBjWwMnamAsloruSlRruuBAR8ca2/XfXWprJp2Lxd60VTDZDEak?=
 =?iso-8859-1?Q?sRpMkYc62NUvwcm1WDI8tCyrOY2JEM6NYi8rFpooqcNb4uz+IZSuvUyxMe?=
 =?iso-8859-1?Q?abkctSNi6/1qE+LI/XWmzTNa4mr3MJR579y1vtUqzCOSDETYYTWyNgeXH4?=
 =?iso-8859-1?Q?rNI9Ki/eqN8WVD/NpBVE/05qCsagVsg/xHL/0SPOAKxyLVGBHgDIJOPU+K?=
 =?iso-8859-1?Q?juWjU1BeEbkuFkeONiDQ7Obglodpa+qFzozgFJ4HXpXzy/uccDxh/zzhmp?=
 =?iso-8859-1?Q?Opz0nmPhAxfL+zrwxWe3sRDGNOnN5kqLP5dRFX7JYi48VAbiTdTq5y1Neg?=
 =?iso-8859-1?Q?sKWbgD5VJfg/HlgtU15kUr4IY+kcXQ/Oi0mU9PreGMG8JHoxql9dnskiI/?=
 =?iso-8859-1?Q?Cjy+Jlpoiu7o+v3UmEVx5ghTQHJNqcwwkYg72a+yGEDKRGQWsts50iEajm?=
 =?iso-8859-1?Q?gSC7KbBZFK+U5PcZcphvjwWkGxEB5QZBtLajDe8w4fmwGHEPGU47n0pPUL?=
 =?iso-8859-1?Q?nkU5rYsVrW2Shp5xsBATFq6+Liup+OSJOX/CDl9lH9qnGJB7E72Lkj7Oct?=
 =?iso-8859-1?Q?MzgASmvb5fkm63OXeZS4sRrYX8CmQulFx5xxsusXa+n8XJcne5Oh6+te7y?=
 =?iso-8859-1?Q?OVvZFn+vCvlPg/lF6k6bQ2yr5oLoFs0+ZHZ/dvP/nYV0giA63ezD/O9qH9?=
 =?iso-8859-1?Q?ndAp+meritT7KOJk2TkH2NjC1TVmukoIatDWklWT9jXgYtw+JLemBvndNl?=
 =?iso-8859-1?Q?75S8bEbGhx7ywHb/up4jgT3tOObA0zforoP2bbqW9iiz0Nm6MT8QI4U798?=
 =?iso-8859-1?Q?U9iRfYQBxvedRrH8lo/+qTgV5A60KTZep28ljIPfOSzIy4EfuuIqExMcp6?=
 =?iso-8859-1?Q?5vhOyDDkY7drlQYv0UCgrCCOgyzi3LJQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JEiV8gQTF4JPqVn1jDQDhGPXPOGQywnk1KQzmsbxUvMe3UU5DTT/vxdAv1?=
 =?iso-8859-1?Q?5/LQqQAAo20m7+DuBrD6piXVldFxqMsK+ua/6hrmqyYlK3xh/xBcTb9WKE?=
 =?iso-8859-1?Q?sRq7sUJ3waJdqkeQqs0NZYAa1sRgNoriuilBcIQvBA1swCNJY3b4KKV9iF?=
 =?iso-8859-1?Q?atQvpyt+AseH5BXQqkxllGr6Kg7BhNcjy3QtaBvzHZGklUN8ULEIPtiTP7?=
 =?iso-8859-1?Q?qxzS6Gw+FLibYtc+xOqcprdyw6tKgeaqiewaZrcnxk/+H5BRBUX6YJb7Sa?=
 =?iso-8859-1?Q?bRvDFTu0YG6xmDCGicZDoIRjlTgRYlqeFz/3ko74s2Ccs4hvppgPfDJeoD?=
 =?iso-8859-1?Q?Wpmbn9gC5MDT28q0hi8GNZKy2mFYB5tcJQ72sJJIY6BVq3wOgUD7eUYlHJ?=
 =?iso-8859-1?Q?SGsBmDVfuvjfXKRIcTAY7SaSnkL7coww23XP/fbO0JKjzUVFGtOSmr9QYk?=
 =?iso-8859-1?Q?wb/fjwiUNfQsXxdi/I8CwVzDwj73u6MZkl5W+KkAE/gPxnRJPVN2/Guu2s?=
 =?iso-8859-1?Q?kkVhkHuM1k53TSWSyp5o4aMNlgD8tg+ueU/wPILMKCfhzrvLg1u6hufHs6?=
 =?iso-8859-1?Q?P9dNXtWMKqbNM28mvusryQDNZVM54VcKtn2FXht9JkWG/K5JP9hWTU6H1Y?=
 =?iso-8859-1?Q?X+ZNOIyzGiO9OlU7QqS7iF3cYVdMI0LmwXQAYiDGudYNPxCzd3uDZFaqxe?=
 =?iso-8859-1?Q?dq1KGNcKwA6zARYcDDHxbycYO7Hr69FSwYLSTDp8K0S/aVYezlFY0UnU/n?=
 =?iso-8859-1?Q?i4SSur2bGF2IcoaOJlE7kq8LWgb0sYb19Qtt1OKVhimKEfGLLoq9G2WBWK?=
 =?iso-8859-1?Q?yEIimj1HcZNbFAcyvB5hCA5SREkFAX/8nyT09zv5WYdf5Hmy/PbTwhEltu?=
 =?iso-8859-1?Q?Tnd1kC8TuaVVdnGU8ahkJkGTI8qUKdfiB757UytA2uWysyRCJpW199R4Pz?=
 =?iso-8859-1?Q?LRfVLUjODfCXjcldMWkH6mx0Xx9VHlxRuUUMPrQaidNyA0F+yBxS6CKwBv?=
 =?iso-8859-1?Q?rZf5B/0m6NEM5/F3HEPWocKnwr8i27LEAwOJKTDmBw9tQz3nQxyG/2lIZT?=
 =?iso-8859-1?Q?TiwDR13pESBUcUJ9iFLko8cIPnk5rFaT7LvJ53lcbLGvxHPfUIw79e3oIo?=
 =?iso-8859-1?Q?VTWZFh5UkPBZN43eFOTTX8WQSzepY0HmltiTxQQ1qcx6P8ALjGM9nnGZwX?=
 =?iso-8859-1?Q?p/ZVYK0unvhGoYJNt2+YXbWToNf2M6QzOFxgIJT88zZe7A/rPEYX3Aj++7?=
 =?iso-8859-1?Q?vHD77DKyfy9syoAbFZV+bzw2gnuu9rf7HqpE4snnutWTuki6uej6jUz8kL?=
 =?iso-8859-1?Q?LLFXHtHz2tPQiTEo+dRHscjOLb50qssM6ykYlXflFHFaLx38sheKsDoE2Z?=
 =?iso-8859-1?Q?y10hUHP7mLhxqXnCTvqikic7lrz6wRoyuBIqyIQUPlUJmuATg45GQY97pq?=
 =?iso-8859-1?Q?93DH4ocvnHZKNGsBeE5wVdI1OXw/FzzkqKdFeo4lrGw0ua0Q7Xr4B9FLUu?=
 =?iso-8859-1?Q?gvaRlor/vIbJvye/eRnOTrPzM7ENFf0Or5mxB11Y/FHniitwPp8mfN/JTD?=
 =?iso-8859-1?Q?Kbp7+uz+eo6BwDi15Swnd1CYJodG1BV5Mk6jZtXy0U+35XHHWm+NivEn0h?=
 =?iso-8859-1?Q?8a6XEmsGMS2+gBIn21dVFmzikUnToGdbLi4J11QZthfoufi7lW3c834A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b60b2bab-f609-428a-b38c-08dce3929769
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 10:03:12.4424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjDG7KVxZgDYc5rqQMf2GEVVSrOi1OgmdzemSoIhnNOTzvN8HJCdRu7VzFhGbSn4rCA8dfgis2CE4ZIRsNSlHT8kDuTYYxQ1+GW3U/7p24U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPFAF653D402
X-Proofpoint-ORIG-GUID: JV22OoEKkPjzm6UZqBiqH2Z9h7gotAGx
X-Proofpoint-GUID: JV22OoEKkPjzm6UZqBiqH2Z9h7gotAGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410030072

Hello Krzysztof,=0A=
=0A=
this is strange because I run b4 prep --check and was expecting it to run c=
heckpatch on the patches.=0A=
=0A=
I am having trailing whitespaces errors, but not on the part I changed. It =
looks like these "spaces" that aren't even displayed correctly in an editor=
 are introduced by git.=0A=
=0A=
Do you have any idea on this kind of issues?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent:=A0Thursday, October 3, 2024 09:45=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Jonathan Cam=
eron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring =
<robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <=
conor+dt@kernel.org>=0A=
Cc:=A0linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-ii=
o@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vger.kernel.org <=
devicetree@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH 1/3] MAINTAINERS: iio: migrate invensense email addre=
ss to tdk domain=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On 03/10/2024 09:37, Jean-Baptiste Maneyrol via B4 Relay wrote:=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> InvenSense is part of TDK group. Update email address to use the=0A=
> TDK domain.=0A=
=0A=
Please run scripts/checkpatch.pl and fix reported warnings. Then please=0A=
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.=0A=
Some warnings can be ignored, especially from --strict run, but the code=0A=
here looks like it needs a fix. Feel free to get in touch if the warning=0A=
is not clear.=0A=
=0A=
Best regards,=0A=
Krzysztof=0A=
=0A=

