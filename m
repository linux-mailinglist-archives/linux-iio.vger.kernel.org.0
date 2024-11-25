Return-Path: <linux-iio+bounces-12644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEC59D8997
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112D3B3AC50
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71A184520;
	Mon, 25 Nov 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ePzmS8iw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43CCEAF6;
	Mon, 25 Nov 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544579; cv=none; b=XA7fSBFF5OCc1w8tFj4F3UVPHxi2tfs0Rc3iRgOI+XJhCNXMRkYpiGGcSUF5R78/LZZVDA+rDId91gwcXq6p1kIilrRLBSWBoakNQ9rEfGXK5iyRJpycQYcJC329JMf5HCSlfsmG2lDKM36kNDNMvzf0/6UyCrom7hcK66n4W1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544579; c=relaxed/simple;
	bh=SG0jvqLVog//QTlMMQhzLqPOC5yAbeI7oA5YQ850jqw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=biSEZD2dTWOD5L5jLYgqgmNgHOYv4OneYIGyjHAKvB8ywJuj+sKHnGoG2GejMAfCkHprYuP8eR8SxXDzCb+gGyxnavj3k+dNeKF2HMj0ckF8BbltkdBds4MlGq3pr96mHrMKYnD9NyLoKLMPSgpP45c+MIBTt3KaCX/gUy+tMh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ePzmS8iw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APDrtju014880;
	Mon, 25 Nov 2024 09:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ofJdo
	U+dIwUs841cv12FL6guNefCzeKBMVmj1OZwFts=; b=ePzmS8iwfJ1z1XjF6Asqq
	YNlqcC7PaOil1JVefILKO2oCHdRtEfVFKqxKhWi4Lo381oxE1fuOO7BQtWB1OjCs
	r7Te26TBoV8NLUBrpjulpFBzskWHcE8B4ZVTKhMLyDaA5uRgRtF8OtzFfamceOQ8
	39z+6mToeeBzlP4DzPb9yDhaRSy1So9JtmJ3djwFSvT4NiS8aBE7YoMPyBwn2HSb
	ERpk+MfNKLgGVOdcGmX+8g2nQPkUqWFE+zPWLyWQNGrQFYzs+NxkY2ueDoCZLhoC
	t1yqXDeEQbdjSzUwDPd/3dZhN/xWDi5PWPDUXWSJVDH211ZXT+g0zoUVKZOv2UgQ
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 434pbd1813-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 09:22:43 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4APEMgTb032092
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Nov 2024 09:22:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 25 Nov
 2024 09:22:42 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::e370:92d6:3366:81e5]) by
 ASHBMBX9.ad.analog.com ([fe80::e370:92d6:3366:81e5%20]) with mapi id
 15.02.0986.014; Mon, 25 Nov 2024 09:22:42 -0500
From: "Budai, Robert" <Robert.Budai@analog.com>
To: "Budai, Robert" <Robert.Budai@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        "Miclaus, Antoniu"
	<Antoniu.Miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 0/7] adis16550-v2
Thread-Topic: [PATCH 0/7] adis16550-v2
Thread-Index: AQHbPz7pSPeUMR9QEk6zMP7RDy8im7LH6pGg
Date: Mon, 25 Nov 2024 14:22:41 +0000
Message-ID: <7f065b32ec8043b5bf6d902184f39d96@analog.com>
References: <20241125133520.24328-1-robert.budai@analog.com>
In-Reply-To: <20241125133520.24328-1-robert.budai@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHJi?=
 =?us-ascii?Q?dWRhaVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLWY1ZjA3Y2QzLWFiMjctMTFlZi1iYWU1?=
 =?us-ascii?Q?LWRjMWJhMTgxMTNjZVxhbWUtdGVzdFxmNWYwN2NkNC1hYjI3LTExZWYtYmFl?=
 =?us-ascii?Q?NS1kYzFiYTE4MTEzY2Vib2R5LnR4dCIgc3o9IjQyODIiIHQ9IjEzMzc3MDEw?=
 =?us-ascii?Q?OTYwMjE4NzkxNCIgaD0iRDREYzZIQ0ZhdHNEWDJLaWtYc2YzOE9TdDMwPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?RW9DQUFDS1NtZTRORC9iQWJMcTNkNkczRWtVc3VyZDNvYmNTUlFEQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQVFBQkFBQUFmcHljV2dBQUFBQUFBQUFBQUFBQUFKNEFBQUJo?=
 =?us-ascii?Q?QUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFk?=
 =?us-ascii?Q?QUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxB?=
 =?us-ascii?Q?R01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpR?=
 =?us-ascii?Q?QnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFI?=
 =?us-ascii?Q?QUFjZ0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIv?=
 =?us-ascii?Q?PjwvbWV0YT4=3D?=
x-dg-rorf: true
x-dg-refone: QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0JtQUdFQWJBQnpBR1VBWHdCbUFHOEFjd0JwQUhRQWFRQjJBR1VBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURJQUFBQT0iLz48L21ldGE+
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: Dnl2RKIYo1XTGXrJZpK0YK9yXPBWsfTu
X-Proofpoint-ORIG-GUID: Dnl2RKIYo1XTGXrJZpK0YK9yXPBWsfTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250122

Missed -v2 flag at format-patch command. Should I resend them?

> -----Original Message-----
> From: Robert Budai <robert.budai@analog.com>
> Sent: Monday, November 25, 2024 3:35 PM
> To: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Gradinariu, Ramona <Ramona.Gradinariu@analog.com>; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>; Jonathan Cameron <jic23@kernel.org>; Rob
> Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Cono=
r
> Dooley <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; Budai,
> Robert <Robert.Budai@analog.com>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: [PATCH 0/7] adis16550-v2
>=20
> Version 2 of adding adis16550 and adis16550w device driver for iio.
>=20
> Robert Budai (7):
>   iio: imu: adis: Remove documented not used elements
>   iio: imu: adis: Add custom ops struct
>   iio: imu: adis: Add reset to custom ops
>   iio: imu: adis: Add DIAG_STAT register size
>   dt-bindings: iio: Add adis16550 bindings
>   iio: imu: adis16550: add adis16550 support
>   docs: iio: add documentation for adis16550 driver
>=20
>  .../bindings/iio/imu/adi,adis16550.yaml       |   97 ++
>  Documentation/iio/adis16550.rst               |  389 ++++++
>  Documentation/iio/index.rst                   |    1 +
>  MAINTAINERS                                   |    9 +
>  drivers/iio/imu/Kconfig                       |   13 +
>  drivers/iio/imu/Makefile                      |    1 +
>  drivers/iio/imu/adis.c                        |   31 +-
>  drivers/iio/imu/adis16550.c                   | 1203 +++++++++++++++++
>  include/linux/iio/imu/adis.h                  |   34 +-
>  9 files changed, 1762 insertions(+), 16 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
>  create mode 100644 Documentation/iio/adis16550.rst
>  create mode 100644 drivers/iio/imu/adis16550.c
>=20
> --
> 2.34.1


