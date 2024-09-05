Return-Path: <linux-iio+bounces-9178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2559496D2F3
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 11:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D14B21C49
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57B1194AEB;
	Thu,  5 Sep 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="EqV1d4hR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B46193427;
	Thu,  5 Sep 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527821; cv=fail; b=myzJOsRcnOrD8w9B2vLYX7PQpNosNT4rdDA7cqvETfpLVkV3yaUXoQVStMXdzNmSBcKflwf8g2QMToQt9NgTs6aAnAbEzHqgmTsgCSZKEDlSsg+hXWoyOPBqmc99vcyxRbWwv1P/pOwsxzgp2EQZiFHZ6siLrIIlGCIR/1Ju0Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527821; c=relaxed/simple;
	bh=ayC0OmxfpQ5z+W9r1CX6Z07ujPESPRs35Lgp6xgFDfU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eph6uQp+N1G2Akf1xc32IRIwjEQaoDzb7kFsgvQwelKCLF8Oe7dLqGjGT6+zwW03gdb/rOcr+nItJsL+F3e1MbywOdL1RghB+ZNb16/M9bShO52FKLzOe6PAmHV6uDOJZvvilxdiz6rpDHGcyoDcpbBIZYj8gM/7RjGePjoH9rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=EqV1d4hR; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484MwwYI013923;
	Thu, 5 Sep 2024 09:16:30 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012049.outbound.protection.outlook.com [40.93.78.49])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41ec469et2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 09:16:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlHCeBeJk08HUoq2Tp0UNhd6YmX6gCayYGJjKMiO/l4NNbeqeDoyIAiHz8uEDD6RTDC4F4frVj6k6pR3VXYkJ2IAuBjlPKUy46d/vIwJI6gQ1Iwx5/SELs0rSbB7KI9jZ8SqnEkNnNq/8trMnpO9YaXSMraPeDMK+PrmAwQMekoLQ46HEOAYXNfnodudTfg0QpQeStG/UpI58Z+JXj3VurmYlF2RtRViKXbazU+T5vWPBKg2UqlvldhDphzqJoo0ATk4EY0P6MVlRfA22OUl10sBBdSzjOrMt1wa8KI7Sl7gvJ9O7zL6uuUoclpdUvHdeB32efqmbV4UCdbZ/d2udw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaGFzqypUHQhXVdqkEDVeyglch1Vw9scGWgbATS4p48=;
 b=NynHsmI3cfxIEymocIUJHcbQ6I08qcdsR4kX5krviA2xQ6rYgaPLOQ3f7VqBKr0WF7+6o8OY+iBt6OVM0VGjLUYiOZDRphK/yGjvwuVBRh8ZbHJ+LRP4HSmL/Y/Z3wvRJA6JJZk5P1Yc+olFwvw3WE0C5V12G/t+LrGtJiynHlA8lXFPdza2sNaN4O1khkS4uNYpu5pOcSFDksCa7nvr6sEUl+TDaI3KG492PLztVDx0OhbARU5Qdx+WWbgfjRcSvIp184P+hp+IJewnh43OTZ8iZrGA1bmYd75WjbTUDhRN44vl+z0Y2B8dhoI/Tb0F4LUsbwEygoA7QMLfZkE2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaGFzqypUHQhXVdqkEDVeyglch1Vw9scGWgbATS4p48=;
 b=EqV1d4hRv3Pd0go9hm55GU4txgDpPgCwhZDHMwSTuyvoeeaSocXpGIj+NVcj7MN0BE4sORpC7K6T4eG4agfiduDs75Eq+TCENHandRj+vXK8pegirNw7Kh/G87xV1S8ksIL78h5Y4FA+zXgbttJwSr6Zz1qPq4ut9jAi4+2ofh3buz+s2ExcuXWNEk6RmEQM2EMYRkpdLQey0pCob/PVHXDjqCudqFLWw/dl745A7tdCjrQUhMJ67+1PKQ15eq7V2EVplsnlSfol30SN31gAjiRvs2BuK03kku/O25AMfn2KYZKK9Sj2gdhv8Vsq7mIAinciuepVd9mPJM0f+T/0mA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB1795.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:16::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 09:16:23 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:16:22 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_mpu6050: Use
 upper_16_bits()/lower_16_bits() helpers
Thread-Topic: [PATCH v1 1/1] iio: imu: inv_mpu6050: Use
 upper_16_bits()/lower_16_bits() helpers
Thread-Index: AQHa/vq7qAzoHtZQm0iJUW4sCPlMz7JI6hQP
Date: Thu, 5 Sep 2024 09:16:22 +0000
Message-ID:
 <FR3P281MB1757F1ABDB6FC9F2F02C21B4CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240904184543.1219866-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240904184543.1219866-1-andy.shevchenko@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1P281MB1795:EE_
x-ms-office365-filtering-correlation-id: fed6ed8f-aa3a-49ca-8727-08dccd8b68c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lo1ks5GTI1eNTzfvdeyKbbL/l2zfzu0P45muS+1W5b6BneDVkeJpwNWe/h?=
 =?iso-8859-1?Q?6rbe+2qM0YoD9AedUEs2lWx8jjlArRILSkvrlfBm98uscIwdgxAxZjOHu3?=
 =?iso-8859-1?Q?Pzewr//9D1DPfEEPsXp5wNuOW43zU3Yuu8KXqIvBikcUrWRwqbIWpYtPBB?=
 =?iso-8859-1?Q?XyKo+hG/YQ1ggVXE8KE5JxK0puQQ2zt+Fb+/sZ5OPvBmQF7je4RXE8dQH0?=
 =?iso-8859-1?Q?T1xNHu8Fch8PzOq2ovyTaHzWDbOBLtu9eoTc/u1y/EEXkNYZvpz7B8pXof?=
 =?iso-8859-1?Q?sB6+caPQpTSolAjPcJwLn+9WuVpeiWymcPW3J86YQRNtwS6xLO4z419H+j?=
 =?iso-8859-1?Q?GN7bCxWbawiAIXziVV0s0OspNxVBWkZfE97qkYYmiiAgtldlC63nfgAnA9?=
 =?iso-8859-1?Q?rBuD10u/XbpRejumfo8dLqAkmqbV3ZDk8Tw0Nzc63BZ00oSoIkOmAbgBqP?=
 =?iso-8859-1?Q?we0c559fPaiDuGgDKmmcFjXO71yCQuK2QjOBJpaFaTztPHk4jLOZG++Eea?=
 =?iso-8859-1?Q?D+yobSrc/ZuE/wgc42q6BLEF5s9/ItZzrUjciTsnOlJ4/lwoBr5CElgkOq?=
 =?iso-8859-1?Q?bQ/fWXKlDn1Ch8iCnXuftWOB6fVU3y+pPDC/8Kd4lxvvGnJpt6Isr7F2zr?=
 =?iso-8859-1?Q?G6Lfknq2I4hbyv/gjwFkehIPeO5kSHDiJ1Np+jMRvlj/+8cxopq+ibxqIx?=
 =?iso-8859-1?Q?wnsVI+6N4eetlKeL5zTPE43qj99lzlLnJg1pIOT3f9ivia2mHWmyQ+yzuW?=
 =?iso-8859-1?Q?8S5CDW6oUwMVjkPTCPdpfJqRctnRKEdktUlzmP6ZDRntzgtIBXPAzkHE3z?=
 =?iso-8859-1?Q?skF8Wn/RPDC9KhaPPBXj+wz6lOywXFvaXkJcLXdlJPRGXPR9+lRBUXcFSA?=
 =?iso-8859-1?Q?nVgelcgbdsIUveHb/2Cxadr3GMQH0P6Zjd1aeHbcAhXZH/ITNdZbnKGDHG?=
 =?iso-8859-1?Q?9Ssx/QqG9Wd3dcDWhb8aSP7RAZkUWAV7hRvpYWX8GM489H3nY7XcZhjRn+?=
 =?iso-8859-1?Q?9LBLucaGPZ6Jt5TKWnRLRUgL4PA7ZeJvjacIz6rIYhgyA3a1+g2ZE9jL7L?=
 =?iso-8859-1?Q?0kVeKfkMkDJl2zkXFWfXEUAutEoj4dbSTCdLX/d5jrvbTAmDpqf3iBgiws?=
 =?iso-8859-1?Q?p1srMZKh9GRu1RaHNifC0L51yX6YNR5vxU47HxPenAJMScSYC7dI6FAyMf?=
 =?iso-8859-1?Q?iSbXo088VQS8T6wv3o8NgV5ptC2khz1xzfWW/M+4W//rrzhHdHzJ8cTRuz?=
 =?iso-8859-1?Q?RmNmPXI5BYsB0rFTrnWa+Fx6usSap1AzsL0ys9SgSV4p+Ro7txbG1x5gbD?=
 =?iso-8859-1?Q?jEIw7ExRkFzPcAY7dAVOBpsiXXyMWq98Na0o7yCIghhY/OwyL8ZPLgGPSw?=
 =?iso-8859-1?Q?L59Q+6hedyw/mHVJA9P6DMOq0RRXgpHROfocdnvFXIkvBNQHfcyrgZ5v3L?=
 =?iso-8859-1?Q?K7hcytg0Uw4hXMfT81M9CO5SLPEK24OGH9+8o2FCxh4rZJEWlQSZzWJ/5+?=
 =?iso-8859-1?Q?U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7vRw7FOJ3krR7z+TwJPLYwnLQ2vvkNBhK3ktRURTajDvdDFCrBLlwTi/dl?=
 =?iso-8859-1?Q?e9TS9wBE2D7Vly8oC4XF48D6wOA1TBtnkz22ZMgwsYVTN6GKpi7EwDes3Z?=
 =?iso-8859-1?Q?jBGWhy3S9a635kh/mVVtjVEhGJjxwlneivJ61e+rZNSZHfqsPAJDPre8w/?=
 =?iso-8859-1?Q?9Lf5ZSzKgCzno2oF5xa3yfmi56Y+ZpABgYFIeK8QCn3lUMktg5CkP21vAJ?=
 =?iso-8859-1?Q?92b5sTrWoZz6FlaPyVP0aGeVSShm6cZBkizpqk/7hEVrJE8JeOnSlj7/6/?=
 =?iso-8859-1?Q?VfB5jx170yNOfbe1JvEiHiS7+3CusPmDna8XgdrdpPF1CtANMYT6WOs29C?=
 =?iso-8859-1?Q?iUourWYKhwpeJBUGhGr91X1NKScCIzxJM+PHSUG9agujf2Nk0nWOl+C/tL?=
 =?iso-8859-1?Q?YJrx9/3UnIHwnS1kjouf+f9c8GBoz/6xErOZrBEEOImwLYjrcc6ViKRN4a?=
 =?iso-8859-1?Q?vjneHezWgYr6Ugusb36rLlAO3xpI61oKVdoh+3iLy166rVNI+HDhdRiK+K?=
 =?iso-8859-1?Q?oXHC04Z69mesqNLT0hOb8aCJ/74c0bAHw9xzTPNy9uEXbZATdAwu+uERhW?=
 =?iso-8859-1?Q?OIYfXFO4FOJjQeMfurGIdOk9dg6iR3q/vomXJN2FUox3+WAuy54mqtUymk?=
 =?iso-8859-1?Q?BiIDrvmzjJrqJHHk/HY+48TFr/bLmr8WmXtr/P1hBxcIPqn86v0IHXaxf2?=
 =?iso-8859-1?Q?lOfxqzYATjVPgS2H2MtOeoW8gF1RY8K1n45yMb+a5ESdacnlxJrIA10ydx?=
 =?iso-8859-1?Q?r2Xfei6UP5mf/fznO7MnzyHhwnNNWObO1bo7oFAOEN7mrlY/xLGNJvf8yl?=
 =?iso-8859-1?Q?xMpSGd2QZFUYkRVDx5FzBs65vXcLyycPBsPdKhpuffFveMCjPe5GK3rAhk?=
 =?iso-8859-1?Q?cNXwLClRQ8+HP2uRdhEYldH7IQprdG7VkOpGvPIRxOvDeRAip9XhgTyRjt?=
 =?iso-8859-1?Q?IhTqMxYJO9Ji80/YGKCp/nne+h1Toi5b6UKtOksnXmegyb/QLnLHh5uGwS?=
 =?iso-8859-1?Q?tWN/w5gYV4XC1gAMAPMiXxHmwfpqtn4UKHIyvNK3DGM9P10+pS7dOoaAI2?=
 =?iso-8859-1?Q?xuNOXKlRxecEcC+Sh+6aHUEu1iaEbObVU2u6j95TzTToJlsxjDFsPUr+j4?=
 =?iso-8859-1?Q?UkYY7W3CcfjeAEy+dIZlXQryoIUSWBgV/edqjGTvrXA6VO5zuiuyYp5T99?=
 =?iso-8859-1?Q?ZTHYIFwheC8EMYjZOtEIRSe60blrHYgCAjXDDkZSZh3MtCx4s9UI4pJpla?=
 =?iso-8859-1?Q?Mc71XdZYzHZH0jCuHbb/NNfYqgO1XKAQDRnTvpfuE+Ft1mbfL+crXm361U?=
 =?iso-8859-1?Q?/RfyxYq/ZLD5sGMkQUZTMm3UiPPExZMh7oP3fUgCE1JUISJxHTCrISc7B4?=
 =?iso-8859-1?Q?6jO/2fkyI7xSAtvyOr7LLavIhxj/v/GDjK1NWJWmNHQFqxYA05kFwfuf9P?=
 =?iso-8859-1?Q?RxQ+HaTipS11RxhXRpdLT9AAdW9Txk0dkoEwHzlTD/QcE5VRJLwta61upE?=
 =?iso-8859-1?Q?BWxQiJIiAPwBAMdwGGNAynYyIGJ4KcZRmpxA/8FmTap/GEgHMYoBzv+/9f?=
 =?iso-8859-1?Q?FoQGPFIluZDQOR14ztfakkkOKy22NIx6owGbzvaWkV55n7xDl7LkTgNYCi?=
 =?iso-8859-1?Q?v8JcLk76ss0U9lyxP4mFzANIT2zNGqYyY4Qmc778X3X62oHe7lBQPmiw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fed6ed8f-aa3a-49ca-8727-08dccd8b68c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 09:16:22.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTO9RLdkDDDG93RB5yAG1ZHQ5zzNuEU1WCZi8McCFjQ4DyjiwqUsHsHJqEPuQhEpiLQc+Sx2YXPq1YMjUTqgxZHzbfpukkiETRjrIEHJ79I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1795
X-Proofpoint-GUID: F6QHDvgeT6SpIoKRVd9FtOEa9JF_BHsk
X-Proofpoint-ORIG-GUID: F6QHDvgeT6SpIoKRVd9FtOEa9JF_BHsk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409050067

Hello,=0A=
=0A=
looks good for me, nice reading improvement indeed.=0A=
=0A=
Acked-by:=A0Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks for the patch,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
Sent:=A0Wednesday, September 4, 2024 20:45=0A=
To:=A0Andy Shevchenko <andy.shevchenko@gmail.com>; linux-iio@vger.kernel.or=
g <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@v=
ger.kernel.org>=0A=
Cc:=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo=
.de>=0A=
Subject:=A0[PATCH v1 1/1] iio: imu: inv_mpu6050: Use upper_16_bits()/lower_=
16_bits() helpers=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
Use upper_16_bits()/lower_16_bits() helpers instead of open-coding them.=0A=
This is easier to scan quickly compared to bitwise manipulation, and=0A=
it is pleasingly symmetric.=0A=
=0A=
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
---=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_acpi.c=0A=
index f7bce428d9eb..b15d8c94cc11 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c=0A=
@@ -10,6 +10,8 @@=0A=
 #include <linux/i2c.h>=0A=
 #include <linux/dmi.h>=0A=
 #include <linux/acpi.h>=0A=
+#include <linux/wordpart.h>=0A=
+=0A=
 #include "inv_mpu_iio.h"=0A=
 =0A=
 enum inv_mpu_product_name {=0A=
@@ -118,8 +120,8 @@ static int inv_mpu_process_acpi_config(struct i2c_clien=
t *client,=0A=
 		return ret;=0A=
 =0A=
 	acpi_dev_free_resource_list(&resources);=0A=
-	*primary_addr =3D i2c_addr & 0x0000ffff;=0A=
-	*secondary_addr =3D (i2c_addr & 0xffff0000) >> 16;=0A=
+	*primary_addr =3D lower_16_bits(i2c_addr);=0A=
+	*secondary_addr =3D upper_16_bits(i2c_addr);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
-- =0A=
2.46.0=0A=
=0A=
=0A=

