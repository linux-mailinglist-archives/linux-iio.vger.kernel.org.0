Return-Path: <linux-iio+bounces-21192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654DAAEFF88
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 18:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647DD3B0C13
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65B9271452;
	Tue,  1 Jul 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="rK5p5+UM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B085E279DBD;
	Tue,  1 Jul 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386826; cv=fail; b=PSCH+i4LOG3ugIAVsIV8PEZKFP2WqxDesU7jOsaWBn4HDQZbqZZuFLCgudUEqic1gsvhv01njauMmyOuEEII3elK9ig0VfVcyZcXBfJEI6e/TeehcD9RbJRIDfYTqO/8RUkj3G76OmXRpP/QMZqrlbPcCy5rmH1Xsn1Ue0QO83s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386826; c=relaxed/simple;
	bh=GeQdFaZJNlf5LSIgww2uFwoKdtWjIITotRrymIvQFFk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gs/vV5mRwY5tQGeEdg/8E9bPqTorUOrc2wHUTfy/l0mD1Mx29t77CH8smrhgk8ArAOu00erhuUEiuhsdfiX65jtVloTQ7ryeumczRhHWb5Q5gC6sIn2bdbqmNgnNrXC3vo4wF2/g1BrGVPckRKQkkMiB5nWFcMeg2Uz1wFcuO8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=rK5p5+UM; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561Fnd71025050;
	Tue, 1 Jul 2025 16:20:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47j9rnaamb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 16:20:06 +0000 (GMT)
Received: from m0233779.ppops.net (m0233779.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 561GK5XU008625;
	Tue, 1 Jul 2025 16:20:05 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010050.outbound.protection.outlook.com [52.101.171.50])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47j9rnaama-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 16:20:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=un+rDOgnqflmIE1sm4GQUXnGoKK4dRPR9x+2qNN5CyOyZtcLYx5gwdt7P9hoTllBFo3liWbzwiK0W4At1g8Yrmtl+j3cMcVCOBE15KRqZLg++D5knRlI6hS2Trm5/W5hFqmbFfB04ok1kzq+A4ck1OdDNJdqIEfQFYIcvXArdKeazrbRJ+vKNEl1v9+VXMbM037vMpoTy9VxZu3k34mwPI9foVnnbaDKr05jyopLEMQ8QiYbjJyMrluJRk1SyDRH7IZx+4g3TG0TYDVA8ChwlV/+5xnZFGWQVDvTjIDopxZDN8Dr1qPwcwRlTH37aTPIrITxhZSNuWIM1lLiAJouhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23j8yKQJ0z+EbHJEi3LaEMCy7jTJIC0SAFwodS74TBg=;
 b=TfM8Ir8plF3h+vSGVXhlWynC80zQqJ657TUc5glOo4tQDeZ8QQO55iN6rZS33CPigJBcv4im7QvVbP5ugjXj4Ze13pi7AnPpbhwV4sjB0Xaf6o9WxzulUssdDGgR2/lNH2t4i/kUTbDK/j8zVxKgPUFj+X3tFneLq6WdWQkvuBrHW578shzSyIcwX228pwJVd2M4lHGZDOUJt9543LU+6wchtUNt/akn6IhpIgT7tHQ/8lyEggyDKOYCG38YRGCYTvZIi+ABSsf4FGMv+R5rm1gBah0C8pkGY3i5PDMu/GDbb7JuvXOTSb0lNjptq6FdtBNgxRcJZZ1lbHG01K3Frw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23j8yKQJ0z+EbHJEi3LaEMCy7jTJIC0SAFwodS74TBg=;
 b=rK5p5+UMXpTdGK0i1BY2aU3uzfA58QHyPy/kfyDQL4QVnX5MfZhEuLdU08ptRwhvwYixnDUJxtAmdedJ+0eSMn1IPhKBeD708n0WUybqotkKQuOo4Srcn8Wm+XX4kLNzvXuiVjHBTHb8KEQmmihD85BRbeYBxS6iMsiS+p1jeGGFOD84KW1j57negb5C+2nu9efs8b/J30gu2ZIMMKCzKFvTT2Pl6m9ceizO3HGceeUbvdYxDucG0U01PGIpZS2LFlp6y1YLLrRNopj5yMEhAT0/ZhxCvcik2E3VcPzgoH4y5f7FPXxBB/w8JUfxqnJNRRYFyrm/vBNKWfkOZ6OmLw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR1PPF2A6D5529D.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18::f22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 1 Jul
 2025 16:19:51 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%7]) with mapi id 15.20.8880.026; Tue, 1 Jul 2025
 16:19:51 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
        "jic23@kernel.org"
	<jic23@kernel.org>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
        "nuno.sa@analog.com"
	<nuno.sa@analog.com>,
        "andy@kernel.org" <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Replace scnprintf with
 sysfs_emit
Thread-Topic: [PATCH v2] iio: imu: inv_mpu6050: Replace scnprintf with
 sysfs_emit
Thread-Index: AQHb6p+BjAdyAi8gUkC6SpMBA4KuMbQdbtvW
Date: Tue, 1 Jul 2025 16:19:51 +0000
Message-ID:
 <FR3P281MB1757C8DF7E1968A6F00C9E99CE41A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250701154720.54276-1-chelsyratnawat2001@gmail.com>
In-Reply-To: <20250701154720.54276-1-chelsyratnawat2001@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR1PPF2A6D5529D:EE_
x-ms-office365-filtering-correlation-id: 11a81a4a-dfa2-47a2-4f43-08ddb8bb1b60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|19092799006|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?H5+6vIuvkoF9JFtJH+bc8IuNl4Z9Cmtn8kAsWGvdDtj+z7IoSJmTIYTvuV?=
 =?iso-8859-1?Q?XhLaP2e8Km+PnOphawTDUFQoZVVRIAuA3AmT8hO11zhrGoqlD7Piw3vm2U?=
 =?iso-8859-1?Q?ftGyUS/2isfF7qv2c/gL9cHzOqKDxBvXPX+v0IsgaV1Dmdt8Iu6Qsdc7D+?=
 =?iso-8859-1?Q?xTCEV6n2MzgTZgEWIn3otr0XFdV1Q8t3+KxuwTva84ydtnWGnQcTjVdOZl?=
 =?iso-8859-1?Q?A1njaOqpxE8+VRx/fvF5OJCVn2qxeAAsb0Jt0/fIWyc3UirR9Gfesw9Lm3?=
 =?iso-8859-1?Q?74trpOc6KVZNm6FIkBqYq5GnnQMeaYnpSBU0ljYTS95ZFzdRASgly6GJ5C?=
 =?iso-8859-1?Q?+V7HJlvNvHwEu9hxOba/71BVklyjV24P1K81oZR3Av5RmwoDsN2geHJPop?=
 =?iso-8859-1?Q?nvUdPSq76fwVvk1o6Mvh1d6JhTxPNooQfCiqFzx1BolBbfSzOo/BCYmFez?=
 =?iso-8859-1?Q?i8la05grbSqrM5JsFQuxnx7EGFm4vERO/rtglwCl8xXS/WptD3XOENKxkr?=
 =?iso-8859-1?Q?ngMuLcstXesqRfminRtuos21syqPtdr1ka9YFPnPXcy3LXMQ5fkM1FpzIO?=
 =?iso-8859-1?Q?rmAEld3A+FXDC1uXdtijbQxj3ILMCyjVpXgvt+xZEdOi+rYhqlERRsVceu?=
 =?iso-8859-1?Q?c9ZDlOweCfgafxXCOtmazloDrSId4uZ2KQqGF4+4jU/fRPu2/JwWv4Gwv9?=
 =?iso-8859-1?Q?5dQTerMhYZw5eFQyGzvwP0qEGbnT7KIiE3KGdNoO61uUieawPwP2SYFoaY?=
 =?iso-8859-1?Q?vIoLonzQPHcLNIrJYlA0tpwrI0pP5zeykPCwdnOFeqTbjy8+R5uQpFx+0j?=
 =?iso-8859-1?Q?NVNDanpA2q6JBLKjRYBQm3J0ynrypXRPHqQgwz6sjUsyBwO2ZAlWMRVEVr?=
 =?iso-8859-1?Q?BNCI0ZR/FKezfMEu31qlJZfvUKl12Ew8flDl2nRu09wOP30/57JZ6OAowa?=
 =?iso-8859-1?Q?2sNEG9SGMBx06HUKiTsg0I9ixGj3/lsTLl0fQ/D3f6nJBdOmhReq/QUD7g?=
 =?iso-8859-1?Q?vlk41o+9QyDAHNr+6klezkuNhs94/bDqcvCSFhqgDjUgqklMdj/x0zOBse?=
 =?iso-8859-1?Q?dVsDdUw07OKkEqq+TJe5ngB0IZIbKRWSGdj1W9XbTJfqiOLTsaaB/x2nEd?=
 =?iso-8859-1?Q?dd38IVMUYMt0IBCsToHoR3xS2k6w0JYzD3UffREyAN7DSKfn1eQsv7GDVt?=
 =?iso-8859-1?Q?/UjV85xc4iAaCMflrwRUJAEQR+v6cFygZGXxTB3B462beYb/HlwN82ywzv?=
 =?iso-8859-1?Q?bYY1GpHIjJFU/JaRtGgTI/Iib4Ev2LKZkmRKu8rorbzoC0s4wcgvUhYW11?=
 =?iso-8859-1?Q?DVYyovSSpYF0w/AQFoVhJgMsnqWz98ekpLkt8OineBbxc5AMtCoJ6iM3LH?=
 =?iso-8859-1?Q?aQSnFVc9dlbfC8onJ4Eyhg7hspcl1QJvS7fKpbZGVQSMcfdmAZ+3HrSF55?=
 =?iso-8859-1?Q?abSKmeoeYS6mr1nuqRfggqapC6Y8SZ8kbF6+MFBkGU2cgkqD1PHZ9eXq2S?=
 =?iso-8859-1?Q?7LwanTYigaNn38OYiwEHCQZfhdqQuLPibq3Pc9rNYkutGWDbE8SzGqRw6J?=
 =?iso-8859-1?Q?XiwxUWaN2tU5YNXJa/mGZYtHoS3f?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(19092799006)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?y4a+EXKjRPcREakkLFrpVXZ/2rQoQnqZm1zwhqvRUzV7G6Z0xHKjPbNy8u?=
 =?iso-8859-1?Q?tWpF8CHjW8IOIfK7d5t/A5+BtE9ghofPm/jtSygF2ECg77RWvwZasq8yg2?=
 =?iso-8859-1?Q?J9AoAW9ucxbjghPGttK/VcMlUa0YulsrLqqqrWkkKrkB3c/sr7cCTjKzUJ?=
 =?iso-8859-1?Q?9UjBBf5nUzD+Up+1woRAhugrvPSmkGgaPc44DYKGgT2ulxy33j+TdCZQ17?=
 =?iso-8859-1?Q?fKqAmo583egUcS4EGd4+lZPIR/IWWdxe9CkiYocrZVyQfa1fwO6t0d+KMS?=
 =?iso-8859-1?Q?U1ASCXpX/0AtROmw9GulYDNJpTQXvKBG4fULzqtxqGrgZN8vcbhuj5H8LN?=
 =?iso-8859-1?Q?+nz2ltRq+YJdQiWWRFpMN2HBJGfLkhD/CtUPGeGqTin/AYwCXV8ApsdH6g?=
 =?iso-8859-1?Q?AT9M7rxgyjxNVLv5csfto3s0JIF1VfFjdxdqEAtzd3vWU9OrlqjXudA55y?=
 =?iso-8859-1?Q?YEY1XOwHjPTy+oY2ekPby3eF4tZEX2KiIKMvST2g/3PMnA/OPkRmtXuNXl?=
 =?iso-8859-1?Q?ABwWO/BHKoL42v4edwRe3cr/Bi76SYUbqmAejdwYyOVZupzMlBxx+pJHnK?=
 =?iso-8859-1?Q?tCxIcMkPt/Vs9U/g1vzfRFrdK/brrq4GjjEz88arB8pmPq6Rv0VDQMziQV?=
 =?iso-8859-1?Q?7/XncsKABs+Di9ZcOvXJcfrVC5C+c/uR40mc5yatde42F/4BCJoo4viyeq?=
 =?iso-8859-1?Q?ekA3h9XmpZ/7Tz9pRp/dO69ivCONO6HTjdAp1GgYx7PfLwLYNaCu4ScSrB?=
 =?iso-8859-1?Q?1owpiXZ+f/WE/Aty2vMOoBv9MvCvu+8G/TU4jUXI1GskvUsv6EMy5tn3er?=
 =?iso-8859-1?Q?jJvxoBRziw/yjcvDLnfYO05pavLWr4XvjbttOvuGBk0+mrM9jmGlmB4P+8?=
 =?iso-8859-1?Q?ls1I9Y72V4uGxhZCB3b9g8PeszbczAyaJ5dT3yLnAm3WxE2W7nPJSrtinW?=
 =?iso-8859-1?Q?Jzebfs13xGOFFL583h/0Y/nxkzScOVkZpuYURXFwzUP3rzM7QZ/9vl2f37?=
 =?iso-8859-1?Q?4HIV52rNOgKDv6J3bU4i082UKt+AmtbPXxCDx6jeWiVrD35Z69UustyGWE?=
 =?iso-8859-1?Q?3UIlDr2Uv7YtR98mBI1N22+MR7tUqdDDm2jJbAI8G6hOAundJzwyzExATf?=
 =?iso-8859-1?Q?nk/fnRcpS+MhPE1U5jZc7w1suMC+IUQkyy21tGKHLlhUuxGKRVBPLGu8xk?=
 =?iso-8859-1?Q?8MLTgCKql61A5cBZypAsNmw2cY/maxXv9tCb7lwDTooGD5udukEIfjfM7/?=
 =?iso-8859-1?Q?NeH5WjYTigSFaYlWx8/KQvU1qOCse+Zs/qLa5XaReKRmcB0i7nUWupmCOJ?=
 =?iso-8859-1?Q?ZT6TTp5yfAEk5x/wEKTfxV0ynxJ2Uz8LFel5IGH3gqZfbW4C9CcTb8hPBZ?=
 =?iso-8859-1?Q?vWYBPbEv8Zb42qd11nr56j1PkPkd/IDWjR1itiLpcTjWupNvC46lthp5GX?=
 =?iso-8859-1?Q?jXaG/8dLbiefUlHCRU8yve2wD1ZR7iZVWUPq5LkadhhnSFuveMiMM/AzS8?=
 =?iso-8859-1?Q?IWFpOe1VUb/Tt7urd+Dz0+o0ynV6V0lON5+viljB9KPQVN//6ozyzY0FYd?=
 =?iso-8859-1?Q?S+C6triB/UmbLQRS9KiSCGYJH6/CPQcF4trVybUMTqSm05KZt/YdXBTGQM?=
 =?iso-8859-1?Q?mB0XZ9yiPRDRE8Mz9SqelechK/Vh7I2nkCBqisDv71GlPWrz9TEYc4K/hW?=
 =?iso-8859-1?Q?OOQdTllTVC4dV+zUg+nRVtwHY/QNAmmcHluMhOkPS5DGhBSxVS2/Ymzova?=
 =?iso-8859-1?Q?SjGg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a81a4a-dfa2-47a2-4f43-08ddb8bb1b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 16:19:51.4054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhG93YpBRxkH4Z4G1XvjEKcFMqq4IfyK5LKmcN9oXuJYh45i45aKYEXAP3txjnsFJ3ZRyDRu3D0ncH73HaOFw8qYmMw1UvJNQGgNdtMfLrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR1PPF2A6D5529D
X-Proofpoint-ORIG-GUID: tBLyMMIS6BViRnP0ZCLhzIj-7AdfATt2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDExMCBTYWx0ZWRfX1lK+jacRqxdz
 Oe/yDJuRyALGr+4BQmia92I2nOqd/d9f8iY8Dh5aoeEjMFfJcJRr5rDZbMOpsy7xKyueGpEIwO3
 xBuglt5uU1YNExmZD8f5qmnjoROD/mlwao56TWl3roKPZetHFMv/2IXIIhYY1yONPWt5/Oc7iC6
 Z8cq+dWgCFlCH1UrUNSZQVR4yfSCCfnRwDAPtrhmjkzUybBDkVYk+EOOhMyZNHJ6D3J5+xmRCi3
 6qjEf44u4VoFq391ljfjHnI7uwaek/HpTpfm7ZNiOQcwMgbxASBioxV9VbUwNLtMFftnt0fL+n7
 KBvRie7Eso1h/iibtVAor69w9rW6WTg+3Tq6nXuiD774DBjSUkSODmNginN63Jv4D80aEXvgQzl
 gAchrw9+9Uq9AkcIqE85Ntu666ezs58khJOj/QzTowrb9+RXoGH4r4g1c9df3PNoMP1MR+8y
X-Authority-Analysis: v=2.4 cv=RbiQC0tv c=1 sm=1 tr=0 ts=68640ab6 cx=c_pps
 a=6YOXPGT372WtIGhNe+ZDKQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=pGLkceISAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=OTbX5mDpsYW3-AC98pQA:9 a=wPNLvfGTeEIA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: SESdSepRK0CTK4M8B_67kZ5lUaZMwzLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010110

>=0A=
>________________________________________=0A=
>From:=A0Chelsy Ratnawat <chelsyratnawat2001@gmail.com>=0A=
>Sent:=A0Tuesday, July 1, 2025 17:47=0A=
>To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@kerne=
l.org <jic23@kernel.org>=0A=
>Cc:=A0dlechner@baylibre.com <dlechner@baylibre.com>; nuno.sa@analog.com <n=
uno.sa@analog.com>; andy@kernel.org <andy@kernel.org>; linux-iio@vger.kerne=
l.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kern=
el@vger.kernel.org>; Chelsy Ratnawat <chelsyratnawat2001@gmail.com>=0A=
>Subject:=A0[PATCH v2] iio: imu: inv_mpu6050: Replace scnprintf with sysfs_=
emit=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>Documentation/filesystems/sysfs.rst mentions that show() should only=0A=
>use sysfs_emit() or sysfs_emit_at() when formating the value to be=0A=
>returned to user space. So replace scnprintf() with sysfs_emit().=0A=
>=0A=
>Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>=0A=
>---=0A=
> drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 ++---=0A=
> 1 file changed, 2 insertions(+), 3 deletions(-)=0A=
>=0A=
>diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_core.c=0A=
>index b8656c02354a..39eb516acc73 100644=0A=
>--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
>+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
>@@ -1382,7 +1382,7 @@ inv_fifo_rate_show(struct device *dev, struct device=
_attribute *attr,=0A=
> 	fifo_rate =3D INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);=
=0A=
> 	mutex_unlock(&st->lock);=0A=
> =0A=
>-	return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_rate);=0A=
>+	return sysfs_emit(buf, "%u\n", fifo_rate);=0A=
> }=0A=
> =0A=
> /*=0A=
>@@ -1409,8 +1409,7 @@ static ssize_t inv_attr_show(struct device *dev, str=
uct device_attribute *attr,=0A=
> 	case ATTR_ACCL_MATRIX:=0A=
> 		m =3D st->plat_data.orientation;=0A=
> =0A=
>-		return scnprintf(buf, PAGE_SIZE,=0A=
>-			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",=0A=
>+		return sysfs_emit(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",=0A=
> 			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);=0A=
> 	default:=0A=
> 		return -EINVAL;=0A=
>-- =0A=
>2.47.1=0A=
>=0A=
>=0A=
=0A=
Hello Chelsy,=0A=
=0A=
thanks for the patch, it is all good for me.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=

