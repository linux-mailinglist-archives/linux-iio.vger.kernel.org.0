Return-Path: <linux-iio+bounces-8964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A596847B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863451F21E4B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BB113D250;
	Mon,  2 Sep 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="pHYiYdXq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE513CFB7
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272405; cv=fail; b=RNWgxoOSfhMA+RNgcB1WDEstTZhQme9L7o7Ah4TBbRETfBCTC/rww8sSY9QcvAZXFpA/1+U2vgPS8F11vwXOrSQw0tRyWaYvDnADFOOgfhMKSmFSD+P25MH0Z6OepSMPWollY2R0dBE6vfwiB44KaasYkoxKrtx118qNLYuAvvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272405; c=relaxed/simple;
	bh=eHxh26/pZbCMEq05j4FrakoCs2t/cIJf8p8UNzHe19Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P8jsGmsO+rZqaPB3sp6aGStcF8anspArzC7k9ywVU3X0UcSA7goz8HXpelKS35JxejcLOR2KAQCqrFBfZc7ncAtzPNNUdGquntce6iSwkGXZa7y+5+hqruYAbQEklXfzZGWoZAISGAI/wiXf2gao2cPHEShNEa65uIsnLP8vAy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=pHYiYdXq; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 481NIdII012792;
	Mon, 2 Sep 2024 10:19:58 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazlp17010002.outbound.protection.outlook.com [40.93.78.2])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41bshyh7ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 10:19:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysoeXcAIEltZsfmnnY9rKqP15UA6eYBWIDlvOpevqEdYfdJ5a2DlOeEjBqiLQkngHR+b8U9ocRvikjFCIdSwYMGObYf+C1x0KP5CSjYbMxDCdGprsIDqupueUrL8irfV8OQfjey9/+GNP16c1UE2LIAd5Nm+BT7nmahYp4Vc5UQ3KPzTm734++YXa5M2QMppNczH4KyjQD5MaY8Mw55ehz/kS1t/CTR8Hy5aiROymJ8YZYuFzGEUXSCrufSUFaLqXun0OMf7W8kfwrhOETrZxYA3hVK27G9BA4vI8YD4lbrVdKA3uZGNT34Vsk0NYX5zJRT7SapOvZZRVkkUava0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHxh26/pZbCMEq05j4FrakoCs2t/cIJf8p8UNzHe19Q=;
 b=GdUspjq2jvVK8i9HgPazpPjayw1yTWzUALmuaINs3ZXxNuCKy/AuwEnA50SoBVCs+IozJa5ho2l+rAdrHQeAUoE+9xTSBS0kJ5krO1rTmWAC8+GFaP4RaH7xSw+Hebm+uVf3FBWZKUQYmcd9Aw7PNVxRQmLyvgEPUFvR9Dp+InU6GGZI0GtjHchkefl0wYmS1KgPoT4oG7CKY+6XY0y/16ZDbTcED08QDPclQ7cIA9dSvvnvi7hIBz/tLdEwnEL1TghiSZ8doo/kKLaqwYwJjIXqQyhaYNsqcY3+rBaQvk7wdce8jBuPvo+hhSs9hHr0vm1DvgkJTJdvoA12gcii8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHxh26/pZbCMEq05j4FrakoCs2t/cIJf8p8UNzHe19Q=;
 b=pHYiYdXqel6NTjc58tuwPfcxqZZ9vQ/ry/YD2JH26ITgiviKJY0geRjZMNgVoHNRjsAYZa+X5EZg/1TSMMPMPDr6sctMyJC70IXKTBT9yDNQv2EeEyrH/NTm2lkQHZXrr/+NlT5mkCtMyMwB+4Xhl3UwqGmobCwTsuf5hjChaYcnvQBiYOYO9Ae4P60LcEYbAcS2NgAzQDMbhS/rDbUkLpfcJw9b1NbqkriJOZlziUnBSTIOdKuZQPYAbw71TzANKuH21L7sHYXT7ZWCjilJDacgklA3N7P470DvmWuFPgke88SGLnh7N41M/2M5xxMJYdED5ixyF9SZ80oUHJqDWg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR3P281MB3039.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:19:52 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 10:19:52 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Revert patch 1908f13c4682 ("iio: imu: inv_mpu6060: Remove duplicata
 code between labels")
Thread-Topic: Revert patch 1908f13c4682 ("iio: imu: inv_mpu6060: Remove
 duplicata code between labels")
Thread-Index: AQHa/SGPt/hvIb/9xk2tkDWafCVApw==
Date: Mon, 2 Sep 2024 10:19:52 +0000
Message-ID:
 <FR3P281MB1757E9B87D66EAB2512027E0CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR3P281MB3039:EE_
x-ms-office365-filtering-correlation-id: 2cdf7254-3c69-4332-2d70-08dccb38c87f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?oCFy3zdukXPcn3AEODuyeWWKrj9zqG57B0wMz7n90vjCgpPZKBIYHGAXc6?=
 =?iso-8859-1?Q?OzREhp85uY8SBR/8SAfFWLC6eO7r1kAXZ+mIj6Iv1m+ytJMVqPzBeILh0g?=
 =?iso-8859-1?Q?tgyUGjfwCZ/NkIoEsZrF3bF+OYEKc6kQYghmoylODLPkPk+iOBfbXDEKDO?=
 =?iso-8859-1?Q?KnUuXFMhxOxeeBjYP/nT5U1K/VCjEzbWr6CSPUbLlckC1f97/Sa4gOlhKN?=
 =?iso-8859-1?Q?Si1NN04LgoA9hwg2ZtPKjnoxMOWKZY79UMVyrqMA3aaKS73MQiGaUcm29o?=
 =?iso-8859-1?Q?gJDxBc7PS7htXN7Z2AvlsFQT3Nrl6fX3d+Kz+cVzKKhRoKCi+Mbz0HH3Pb?=
 =?iso-8859-1?Q?b7AbgGWccyGzD5ak+SPFJ1NNljHBWV/aNszqWyBRZvISds1HF7zLuBJfjN?=
 =?iso-8859-1?Q?gBVYCXo3ZovdthlgjeBJcXLvffWVvb9ijoL3tFyBi+9Z/Yo1BzYTvuZUCt?=
 =?iso-8859-1?Q?1cE6pjaMknRW1yMzJg1AFdotJ2MMjpliJLqacsJI7KuED/qaqSrB+17dEe?=
 =?iso-8859-1?Q?fp5UIriY+bM0tRB5Bsfg0rbtoG1cUDh7/vnRubS9j35cNXM9rUMfhyMwOq?=
 =?iso-8859-1?Q?bzKOAK8v1olIyS/M7mM5WwjvugDKUPNTwjUh4C8RFTTd2AY8NC6Xyjw+on?=
 =?iso-8859-1?Q?vnkvYKPDyM/XmMu9Z6GsJHP2++K9QIRo0PXOD3ftdGuZlHeddFY9ScQmSN?=
 =?iso-8859-1?Q?Q8Cl5CMMX6bXzyVzVKdw2jagraKwejKuf/DltzeWgv5GXwQr121H2QwrH/?=
 =?iso-8859-1?Q?ks2bokrXQFsxiOy+VeTf0mql+IkhOZbjPBJVSTqxVoTci97+xjm9lwrB2i?=
 =?iso-8859-1?Q?bd4YAydWPlZVaQq5qc7HzLOyk2QDa86QnXjNQDvlpyp/xV9GsNF2mMl45Y?=
 =?iso-8859-1?Q?7UbtmYeMZkZS/30W3mixjhzC0+rHLLmQXlCb0I5aTXkRszRnLlK38I38El?=
 =?iso-8859-1?Q?ZQhYY0IWmQhyOc9iaEWsX6i4LXPGKwo/GqJYe9o/+MXxX90paaDnU2F4/Q?=
 =?iso-8859-1?Q?tK5gDVsqAiYi6nnXXF+ZIiOSHuHi1GqyCTRO7GoNDhtjDZiJrlzbA+lMRk?=
 =?iso-8859-1?Q?QPJBoqbMvqcEodoWRhslVNT77uGWGxoPXZg+1uMd27MBoRt7MaLua21vc+?=
 =?iso-8859-1?Q?l9yhmycr0TRsJ12rn+MrbklaO1Lyy6ugERHt3yTTTfI0pDMFdjCnC8Z5EN?=
 =?iso-8859-1?Q?bKZuxqwtCsNm0cN0ZoU7GkbgSwKzhkO3gFTdNBGD6XfjCsokN2f0g7Fj9J?=
 =?iso-8859-1?Q?TnAKQ2zyeZPtIir8Nckf9R07JGu9dG0yNSsfWd4HMHtXmTa9pi1QBzJB/Z?=
 =?iso-8859-1?Q?AGK4WpjJfJhCj5cyaPQ8u3Qu0VrtWqmgDSHCqBbw5d5lcttt7rRNl3WFkL?=
 =?iso-8859-1?Q?E+laOZk905HvfK//dCyaHBbIxEaE3c4NB0v9Jr1qhcoWknVpVIXpcUA5Rn?=
 =?iso-8859-1?Q?UJTmv839P1RbJ1LCuyN/9QWADALgHXpDyyv08M+hxoluef8Q4DkWjkWsTF?=
 =?iso-8859-1?Q?s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NgYX4UFrhxJHuknIBWtSyJgO7i4ZSudSzpjWLK0IlFwdNP2fcYhQL1SJLh?=
 =?iso-8859-1?Q?cmOadxRwksnsnhTGhJvqhPSz5pbEagMMHaUzYCuPvk4wfTif4ZCPmdtJ3J?=
 =?iso-8859-1?Q?hNwrT/Jj7UY5o1FaQlt+8BAsrO6bg6qK96s2W/DzpDSwpbPoAIFUYkmUGR?=
 =?iso-8859-1?Q?I/pF2lMjZ5qm5fi2J8EMPU9NqNfOyz2m+IxiO9yJMHLzKrnWuNjC9LKvHl?=
 =?iso-8859-1?Q?6y+//TDs7EZLvI7nlKPDoW9FxVkCzHktZH23uDiX9jAGs8fTmPLGH9Z7mn?=
 =?iso-8859-1?Q?q/taOwqVcgDF9F/7us3EAKp1tuWazcinJKnsHIkNQtvOhOWVnRpJsUaqKY?=
 =?iso-8859-1?Q?MI7L40pcuFulny6/lW87LOvuKCAq2vjOS9WTi8+3xAiiffIqjFYZBZsXDq?=
 =?iso-8859-1?Q?J7LRe7dDxgry/M77MMDz33UtUA4AjrhQXoBAkt9Di6v4V7a9xdI9WidyEA?=
 =?iso-8859-1?Q?MzzqmzlyKP+5hpvmCFyzTW+t7lhLtUiI05z6miy6O+nMe7FwlK5+SW6CBm?=
 =?iso-8859-1?Q?uRr5uUUYOHLlcqA+ZkeWPA5xyNf1TLwQWgGQqjFqC/J2ak6D26irIPNZnc?=
 =?iso-8859-1?Q?/yguB6/Gf1uRQ39iBqTMbYGsz233es9fQ2VzsYXoQfXqSJiRaGW1hXFDUA?=
 =?iso-8859-1?Q?MQO1OpftfSusL7DfAsCo9+s4sjk4NovS01guBef+OAHZacJAtsgz1SCPlU?=
 =?iso-8859-1?Q?g/blnVI2OX2Bg7L107nzUH8H+7LOPK39Ob1ujSz3qQCQuUA3abZL1+ZAuD?=
 =?iso-8859-1?Q?PENUVgG68j26hZjazWnQB5cv2RB/FkUq6R51IAAjE5g/EkS6c5d7pWzIVW?=
 =?iso-8859-1?Q?+kFlvr8i3PpQnofnHtEtvjOmv9ldv4YKFrlUOQ92FNI2bdTRY0+2JTpS+g?=
 =?iso-8859-1?Q?ev1NZoeKa1ap3S7fRhMYJOI2nP8lBjoJDhFwuGZ5GrBUgSQ/e5jFn1YLEn?=
 =?iso-8859-1?Q?rTwXooVelt7BmaJ0O83zgVF8Q6TKD2sm7x/ziCHUgU66QqkeBGkmpAnRax?=
 =?iso-8859-1?Q?0NWZ94VrOi/K2kVBVPN33yKSrxUPDBUazctYRDjbYi56x9pYpX+GKoZCWV?=
 =?iso-8859-1?Q?lShSUqMVmavxYTUZjJyuzO7dwD00kZPxTzJG1qCeqFyxvQGA5/48zKetrS?=
 =?iso-8859-1?Q?/a2b7iSX7uwgginaavvmq5bAIvzg6zBmcHxdl9VkEkbKzLZ7k2/NDN0Zky?=
 =?iso-8859-1?Q?YpXm2+Bwd3i/3bsMwamAUfy1wa5eo7jmtHIOJtskEjnqF5RUZDBZgPkHaS?=
 =?iso-8859-1?Q?BARczCkjULAaRAZN+bMPnwAbS+ACJjIuAzJiVusvDYklsVM/vsMZm0x8Rp?=
 =?iso-8859-1?Q?ZzzbqxVwI2u5rPTbZfl+rxU0RlOH6//7AMLCMsSCfwhqthD9QRgT+Tji7T?=
 =?iso-8859-1?Q?9LbErdvQG8vHritB/vEZ216qCWFJWdmr1Iqd2rX4xQE9z8WmKGCnFPmrcK?=
 =?iso-8859-1?Q?+HzGNGawbtJUFxhSQgb0Xhg56/STESsk07RNpsqx/EPxTxHgtmZfyIRCeB?=
 =?iso-8859-1?Q?3AlBrUHhGVLrUo0TYMtrhIaqPSUUqu/TgIAgw1uXVbBmVPF9lCjvrC3KZv?=
 =?iso-8859-1?Q?mWAq1OAftuztjU0JoXEJwc5c3rRvA05ZK08rfKE4pTnx0aWoLhLwlHySSs?=
 =?iso-8859-1?Q?7/0+qFfd2PZMJ550vyGkddc7GQS/5dmCeAopNzUa0K0Nl602Bbv+vek1zC?=
 =?iso-8859-1?Q?1TvHjcKpstbCWnQZX280vqswBOqsrjbsLkKsEV9fOyH3Tb8YU6EKf+tYnx?=
 =?iso-8859-1?Q?4xgQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdf7254-3c69-4332-2d70-08dccb38c87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 10:19:52.2009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g08ZuuOAKDna53SO0wLsMOx3TWdlqYHK6K3CyR9/1aTPjbE8dndy33g2xv5F6AoUuj9y2aZJbpMSK/EcXQqDhhVGfpCIN9kih3R8tTdRVEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3039
X-Proofpoint-GUID: Rod0O7pHewvd2mBbq4yoquaPXBiVeioy
X-Proofpoint-ORIG-GUID: Rod0O7pHewvd2mBbq4yoquaPXBiVeioy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-02_02,2024-09-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=621 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409020084

Hello Jonathan,=0A=
=0A=
accepted patch 1908f13c4682 ("iio: imu: inv_mpu6050: Remove duplicata code =
between labels") is breaking inv_mpu6050 interrupt handling, forcing call o=
f inv_reset_fifo() for each interrupt processing.=0A=
=0A=
Can you revert it inside testing branch? Is there a specific standardize wa=
y of asking to revert patch or is it OK like this?=0A=
=0A=
Thanks.=0A=
=0A=
Best regards,=0A=
JB=

