Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2904C82DC8
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2019 10:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfHFIeU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Aug 2019 04:34:20 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:4512 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728056AbfHFIeT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Aug 2019 04:34:19 -0400
X-Greylist: delayed 1743 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Aug 2019 04:34:18 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7685BSh008438;
        Tue, 6 Aug 2019 01:05:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=dQCb0rMLYonc6OQdqqSG6CNyQduZWpPMLVQaswOSvrE=;
 b=yQbVn5Yr7h1lBSS3Xek+MpuXSOhsXxHdhhtZ/cBoaXsmNRABty8JYjoM2PJiqNfDp5JA
 GW8kci9i7R4mz1eoLjpvOeQWdcO0nNY7knzCU4OXmjsskmAkid5QPNQ7bKvyC0DNmFRV
 NTysWjIANoTxZuaqYChNzRlFDEDHr65cVi5Q25xrhB+Qj8XxWg/4CVt/pBqeg5t4Fl3o
 /UIuEV9adiAz0QwyKBl72FCfd4q3b1y4n2u3SQpSTEbYUH4C3LyI9eU6ObMdCIT6ZT/1
 csgQlsGzEiHWJlKwdCMSoM5YXLOBsk4klOLarBFPqDN9lMtBRAUb44Kjx3Ws+H7mvNIu 6g== 
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2054.outbound.protection.outlook.com [104.47.41.54])
        by mx0b-00328301.pphosted.com with ESMTP id 2u5sv9gxqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Aug 2019 01:05:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2FkRC9x4CJc1wT4ScNQLy0iDvxjo2x/5NS3/nXGwrwY5+Hav31Jg02gFsGsSEmqsv0nKw8Nr88rRzbG8eiuYdKjVgY+cYb8Pojus8j3RsmTc9bGWyZ5majOBcnCSGf+cWNeyWWnRay8N6Rf00JMbkgU9Fz3Z5L7xv/nDa/dzxxqQMRvKPi3h6P/VRjgHLlsMB+aIpL0mIFrooKmIkh9eUJ0S3kKW5kEqcPQzCIsD1c3SzPvKS8/xZLLx6n+LVyVOdvB5n5Trx9PjbrdUlHC8UuBruGRmq5dbut9ttRimiz1AgAh5YMozv/pZwufUZWyH2UN/5PyxyezsnKGH18buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQCb0rMLYonc6OQdqqSG6CNyQduZWpPMLVQaswOSvrE=;
 b=mr4ulrE9aOSkrtKAXUfkRegZKzAr51K49PzIlXzWHaA/g1gEW+qrrmHxs4RuobugTxenj6lMUtsigGoRujc1GBOUPvLPFcKgMvcJQabHDmegzjHxmFQNSSwfOQc2r5ZXNqwfL8wVFs7bn/rSwvQN6Ep4sE9fo/vK2Dql6T3C/c/bWc2TiCoqQgGG60R/Pp3GpW9czyaPAfoLj1seK2eXNC9WF5huDR1it+uC1K2aIKFCM2Y33Ca+83OYs1U3g/zyVNV7Xr4TlMVpMYbGbpefhGQyiXiv+IC/d7lTUzW1t5OKOOJTz2q1mrLElmeL40v31jZ55i63zf/VmbPgouIazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=invensense.com;dmarc=pass action=none
 header.from=invensense.com;dkim=pass header.d=invensense.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQCb0rMLYonc6OQdqqSG6CNyQduZWpPMLVQaswOSvrE=;
 b=F7j7pAcp53+vj5YTmQpbIPHD8P9rXiVqFCkxEVQSl1eUH/Kx1fnbdX5KGoQCtB1VzEPNcbmPeiIiwoIHf/MvhwUmE+HVXvYIC6yL9CLgF/z26jUlCpxHoiBtGtrPNcvBwtV4X2NeZtfyePNaEySk0LQwCVat9JmZFDerZJxb/R4=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB3221.namprd12.prod.outlook.com (20.179.92.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 08:05:09 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::9c03:b359:233:42c4]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::9c03:b359:233:42c4%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 08:05:09 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add header include protection
 macro
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: add header include protection
 macro
Thread-Index: AQHVS4jmdphJPlu5nEy8cN0WRDo//Kbsv6kAgAEDrek=
Date:   Tue, 6 Aug 2019 08:05:09 +0000
Message-ID: <BYAPR12MB3366E1F9CA2A951762E4C726C4D50@BYAPR12MB3366.namprd12.prod.outlook.com>
References: <20190805122513.8399-1-jmaneyrol@invensense.com>,<20190805173226.71757a05@archlinux>
In-Reply-To: <20190805173226.71757a05@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 842c3a1a-91c9-46c6-ef2d-08d71a44ccdb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3221;
x-ms-traffictypediagnostic: BYAPR12MB3221:
x-microsoft-antispam-prvs: <BYAPR12MB322115E38EE2E22503DB736CC4D50@BYAPR12MB3221.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(396003)(39850400004)(199004)(189003)(9686003)(68736007)(53936002)(446003)(11346002)(99286004)(6436002)(186003)(486006)(4326008)(55016002)(25786009)(476003)(316002)(66066001)(102836004)(26005)(5660300002)(71190400001)(256004)(5024004)(71200400001)(6916009)(478600001)(14444005)(52536014)(7696005)(74316002)(66446008)(76176011)(2906002)(6116002)(229853002)(8936002)(33656002)(66946007)(66476007)(6246003)(76116006)(86362001)(66556008)(64756008)(3846002)(80792005)(7736002)(53546011)(14454004)(6506007)(81156014)(81166006)(8676002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3221;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qUrZ1yWCyg/9qRQDHWGFQuwfENbarpwwLnCDoZYX9iiEXiUhi635lY8PRx5Ea6YBV5jeZLh8yz2me5djIs7gtQRWLLuIFU2stKNtRygcMKHQH9unNCVfZE/8RXa+qF/ACF8G5VP2g3OyZU8f6K0K1SJPyCO/YkOwIvkr3aNjtByxEyGvM46k3CRz5Dql9OiZVwfT33AObV8LxJHP2pvDnVeIucH4s2VNRff7x7ObSHxtlGyjk5KxPTmXA8YTox/nI2TJJqrc5y2icNN0yTNaSpF3KCbyagyk9pyrpPCTHDMXo3aDR65M/GJ3m1P47xFfWGQOvNDRVZBcfu8lAhlDqnIgQC4oiw1h23/M4cjc0olIwVOeKWiYFJlXLdsZQOCm9q6ndHKEflAxW/lUezSSW22mOWn0hzhpxyAsWlnIE2o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842c3a1a-91c9-46c6-ef2d-08d71a44ccdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 08:05:09.1919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JManeyrol@invensense.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3221
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-06_05:2019-07-31,2019-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908060086
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
this is required for further patches coming soon.=0A=
=0A=
I am planning to add support for full 9-axis on MPU9250, using the chip i2c=
 master to drive the integrated magnetometer and retrieve all data in the M=
PU FIFO. It will be behind a kernel config option to not break existing sup=
port driving the magnetometer from the kernel.=0A=
=0A=
Hope to have this cleaned-up and ready soon.=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <jic23@jic23.retrosnub.co.uk>=0A=
=0A=
Sent: Monday, August 5, 2019 18:32=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add header include protection m=
acro=0A=
=0A=
=A0=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
On Mon, 5 Aug 2019 12:25:43 +0000=0A=
=0A=
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
No problem with adding this,=A0 but why specifically did you do so?=0A=
=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 6 ++++++=0A=
=0A=
>=A0 1 file changed, 6 insertions(+)=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
> index db1c6904388b..e64eb978e810 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
> @@ -2,6 +2,10 @@=0A=
=0A=
>=A0 /*=0A=
=0A=
>=A0 * Copyright (C) 2012 Invensense, Inc.=0A=
=0A=
>=A0 */=0A=
=0A=
> +=0A=
=0A=
> +#ifndef INV_MPU_IIO_H_=0A=
=0A=
> +#define INV_MPU_IIO_H_=0A=
=0A=
> +=0A=
=0A=
>=A0 #include <linux/i2c.h>=0A=
=0A=
>=A0 #include <linux/i2c-mux.h>=0A=
=0A=
>=A0 #include <linux/mutex.h>=0A=
=0A=
> @@ -342,3 +346,5 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client=
 *client);=0A=
=0A=
>=A0 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *nam=
e,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int (*inv_mpu_bus_setup)(str=
uct iio_dev *), int chip_type);=0A=
=0A=
>=A0 extern const struct dev_pm_ops inv_mpu_pmops;=0A=
=0A=
> +=0A=
=0A=
> +#endif=0A=
=0A=
=0A=
=0A=
