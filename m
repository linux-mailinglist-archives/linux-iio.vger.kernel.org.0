Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F44D4C11
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 16:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbiCJOVm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 09:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245049AbiCJOUV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 09:20:21 -0500
X-Greylist: delayed 1194 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 06:18:28 PST
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51762AD104;
        Thu, 10 Mar 2022 06:18:27 -0800 (PST)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 22A8PqOn030696;
        Thu, 10 Mar 2022 13:58:06 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2173.outbound.protection.outlook.com [104.47.7.173])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3ekx7wv3m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 13:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4rZn2fcHJTzXNaof/fCOpem2MfWf/ics6722o/5OtxwCsvGzSilIXRmRiaLEtlicaEa9rny37GSgJzzcPPuWGu43pxfZjJC9MCQv9yujYXcWaQXtp8E0EsTtjTRv6KXfnIeqMBSH74W0YsGSOat59uv1t4M1iW/mAuuq/qxcZbMBKLufu7utBEQ6nqWqp9oHDT49OaZcXxfCPAjfvGtTyF8HjBsqMveNS0SVlDGZNqUQsYCioo/A7d0dATHdovqW5Ko1EBo6OGMitK/2WIAzUWTS311oZyFlqotbP/yWv9NaDejL2n0SBVGo2lGXmE0aLAEWljydpo6o/DLkGHlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J1y/+s0xZl71sDIHvYUWldrZNf4IQ5VLIh0PeD8Eb0=;
 b=QGgZQXL4urlHeuwXd5iITjTjIvjyBWC5xZfBFcB05HCjBX540kl7eVlCglgyV2Cs39MTBajZO2ljcYEcG6adS/++cUW/I365dNIUTiO+RGUW30GQACK+5vCY4A26TugABeBOJv4gyGY0O0/SzBweFg6FUqIncpxHZAwTr5/0V5BQShJD6I/LLGnLy1ewlvjjz/AMlQpTrq5eeSD0nLnjAH73sEIw8CbtIBobVDk7lzMT/WDsuDki4r1EboxDCUv8EuSolBVsOG8/XCsDSM7kfRjt9Z9vqo5LuwBYzIwUOd0KAk8NyUR33n1Bi5hzyfjmu3UiW5/YLMdFIWCnrt6otg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J1y/+s0xZl71sDIHvYUWldrZNf4IQ5VLIh0PeD8Eb0=;
 b=iCJnRolI+K5o8I7OOP+DCr2mWuvSELtbWpEXnZejnpmGZxHjGXtd10/dpQKxkRNTlosQ3mRvMBVyYq721ShFuIuUKlvP1BpF7X2DewbdMyHz+r8CtDMSXPNSarelJdu7HCSG+wS9Th3odz2goZ4lQ91luRzRbrm7qDlThoRfbm+RoUgvU3wCc3UV0HbfOqESqad7hQTBU1MV2WSK27LG+867bkIP2yLtpXB0VYtJf5eYs9rWUDwPMCrX10oxOJsJcphc8Lq3vNTo3EsLH2eVtigTy6xtyY6N0JUEcgZbQnFBjJAEFMvz7vlWRpeU+Zd/eWXBpr2dBeLfcn0aVpgNsw==
Received: from FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:34::10)
 by FRYP281MB0941.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:72::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.7; Thu, 10 Mar
 2022 13:58:03 +0000
Received: from FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d9b4:af3c:b98f:27c9]) by FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d9b4:af3c:b98f:27c9%7]) with mapi id 15.20.5061.018; Thu, 10 Mar 2022
 13:58:03 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     "michael.srba@seznam.cz" <michael.srba@seznam.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: Add support for ICM-20608-D
Thread-Topic: [PATCH 2/2] iio: imu: inv_mpu6050: Add support for ICM-20608-D
Thread-Index: AQHYNITEmoYezx8gQUKC5cBMrab61Ky4pHDx
Date:   Thu, 10 Mar 2022 13:58:02 +0000
Message-ID: <FR3P281MB05376BFB1C5DF7C5DD5DEA5BCE0B9@FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM>
References: <20220310133938.2495-1-michael.srba@seznam.cz>
 <20220310133938.2495-3-michael.srba@seznam.cz>
In-Reply-To: <20220310133938.2495-3-michael.srba@seznam.cz>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 5c3f47d3-6209-08ea-a43c-fadb22ecc9d5
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07103349-8a26-4627-8faa-08da029dfed3
x-ms-traffictypediagnostic: FRYP281MB0941:EE_
x-microsoft-antispam-prvs: <FRYP281MB09415348FE30851419D43CDDCE0B9@FRYP281MB0941.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vDJLyZQzjOyjrO51R5EfYQxWrrmeVZCnXbOd55oq3dT38PeMZ+RJ66ZoyeH+40NcIICdL14gM0TQnB9jFFSUOB4CfMeq/QSu3wQm340Sz0K15Cace32q9lKEqEVB3uXgiV3V8HXqJGy/hJZBSAKg36jEb+ztjT8wHVO53V764SlNCTjnxTvIzPcQhB77zk0GeulwmL7Q9JMs6z+bdMbyR95geSjrC/AnAN81WJ0unNdP0gFELCxi+8N5ZowDoHa0Ho6YfDKHIrOVPN26iDz6s0UoWBfoCAmShdOZU1k6H7p9z5vUlGzRJQS3ldPfOGMS4tZCOxBfkEM/9Fw4xrHdLobHq/0QVlcmWDjhAcalD5XjUjsL0rmZB9IGFLSQvlCHA04T/fDWNIDeUsej9dCIZ11LBAJ3VjhN0CZgkLXVD86/+nyS69hXl1Lk43MvK60UlGkfo+qJcgkacyV5vA0slBSLv9HsXMg5dMUQigWyusAwE+UYNHCG2kEXZ0b4JP2mdfYmqNhuYV7tXqvgXNakWi7tGtDxawBnT7bE/xEsU4vKDbkqToa6fXc9IsL4vhrbB/0ncfnfq4fnPV9xJcrHcfc6Q/eAeKESwwmn7lWbZj1mesXgLxxP5lLHjUAGkNsRFSTmh1MBC0au7cwCjBz7HvNzS13lVHcVT4eK5nt3qDlfqxOGrqVIRltPt1qHHE9i9N/Qo0kSqVa0rnH6w+HAIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(316002)(508600001)(64756008)(4326008)(2906002)(38070700005)(9686003)(122000001)(8936002)(110136005)(5660300002)(38100700002)(7696005)(54906003)(71200400001)(6506007)(55016003)(53546011)(52536014)(91956017)(66556008)(66446008)(76116006)(66476007)(66946007)(26005)(186003)(83380400001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A8uwkRBKNSo+9dTf36o3cKCRFLjI35zvnOeER1vaq74WU0JfKlnvQ3/Zu/?=
 =?iso-8859-1?Q?Hz2cDRtSoClCtlzXGIMmGFY7H5Ly1wi8Q82PK5v7XvDSz/qonUoBqSb3e5?=
 =?iso-8859-1?Q?pd+PB75X2xiybHyIn+rxoXErmD+/j8A/s7eNqsnxs6UFmloQWhLAaSf3mt?=
 =?iso-8859-1?Q?+5FnzuXeJdeE+YHBSvfXUOhfhme932GNDSa6Aa9mQ+Y8TcWE5cWbbh8/Uv?=
 =?iso-8859-1?Q?daiDg44h65cM7JmUmZh6HrwjtaSiTI2ugMWhTxntzNjRAonAxqdDTn3mRZ?=
 =?iso-8859-1?Q?s+DKjZlUSO+yWGdIr7K25R6E/glWY9rjllg3dnqfNvNhVYij2WSpHsaFSo?=
 =?iso-8859-1?Q?ScwdJ2zXlDMIG0m0LrnklbB5lriRhI+++e2lSSQNEsJ/U5rk87YQqkA8+u?=
 =?iso-8859-1?Q?p8yjLiMzTvzRq0vqv+6hdigwHsoBnzIEqpbjamEJBq+bucY8/mAp+eJ+n9?=
 =?iso-8859-1?Q?XsNm/nO11Xp5mBeqi3VDPgSpapUt2azcVnqY5QMIE1bvJwQWW4FKcQPS34?=
 =?iso-8859-1?Q?rCxWYWqMCg/+QRZByTrCo8SdgBg7Pyarl9vQLAPzs+MqdYAiFvPHndlvlN?=
 =?iso-8859-1?Q?9W7TSnUFEf6ChwI03GN3ZcUc4197praKVcp5+c5uKn6k5Ohbiy1p0n5EHQ?=
 =?iso-8859-1?Q?O58/J2v+qkzMv3e3ifoSbZCZ7JOd8efKhSHsI7olifxWBW8PjffCFOYf5b?=
 =?iso-8859-1?Q?nsgG/DdDupqPlpNImoVxCl0vhJlc5U2TvRBFSRMDPcedeY+KhWgZZu02vC?=
 =?iso-8859-1?Q?qPKon6Ue5UelxR1q4PdOdTsqwnjX85yVRBFS+QZ7dnvdAHbweiIzhytzF9?=
 =?iso-8859-1?Q?PZI1K+qLfpDvoCsITmBldnr2ClQ432GfF9qvBwPHivVkVqeLZOZRN2cD7+?=
 =?iso-8859-1?Q?jQPHf9eiYe1Vo1ljPeyp6YonbVfEzslBULQWnvIHcxYy0N/XCDOtxCZQSy?=
 =?iso-8859-1?Q?t6R5TJAcSH0YUeex7/tkHET5Sg7T7VTA+GznqoFxNMw6dcdV5aFQtb2R9F?=
 =?iso-8859-1?Q?3iPFaplzfWHI55aAhriqSGfWzVKU13lqfZ6eB3yOD3Sln2KH0SB+1m0brF?=
 =?iso-8859-1?Q?22UHCcjcjT62+UQItZ8dueO3tCxM3v/q6/TkiYNIBZgz1pIV3F16r+cQ2J?=
 =?iso-8859-1?Q?w2f3EIoEspiWhR/xcbhzXtR7i0uEMClb11AyJgDIZNR+6BNKMpPRyOUn5r?=
 =?iso-8859-1?Q?20fcz3IaipdiyXg4Up6keBVDe/qJFrStq/ALQdQXRz0dCLFEPrBEue5u9k?=
 =?iso-8859-1?Q?O700dojdWX7z93D8cnpS0fuioj7RJNzoY1TuKEmbKuEUeW6SSvS5Q6uGwv?=
 =?iso-8859-1?Q?4hyEinLluwkP8fIDKFbd4XPM5gHwmQM5gAWr0RJ8lj2h+PeOF1jzDJU15V?=
 =?iso-8859-1?Q?cf+FwNp3izNUC1Sz7GL/4tR30htmG/PCguLuPOPiHQ0TsfUnZtcMIt9PVx?=
 =?iso-8859-1?Q?I7jdMNfL9WqPRq+ir6v+tZsJweX68ekpdF4OsPj4W10jI8CMg2YNeIr2P/?=
 =?iso-8859-1?Q?/KQQTChCmqUefgZ15vlWZzz/ROy/4XZegd4499tqekDg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 07103349-8a26-4627-8faa-08da029dfed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 13:58:02.9902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JUG+Qw30MPgQOJkN4IJuKppFsBPoYvRKoErpuuUsyzl/1vLX0S+AqxFjPHlxjdKKQTuQqAoxr8QzYWulxj0vHkDE78gjcybRRS0RtRSRBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_03,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
you're all right, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
=0A=
From: michael.srba@seznam.cz <michael.srba@seznam.cz>=0A=
Sent: Thursday, March 10, 2022 14:39=0A=
To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.d=
e>; Rob Herring <robh+dt@kernel.org>=0A=
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>; linux-iio@vger.kerne=
l.org <linux-iio@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@v=
ger.kernel.org>; Michael Srba <Michael.Srba@seznam.cz>=0A=
Subject: [PATCH 2/2] iio: imu: inv_mpu6050: Add support for ICM-20608-D =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
From: Michael Srba <Michael.Srba@seznam.cz>=0A=
=0A=
The difference between the ICM-20608-D and the other ICM-20608=0A=
variants is the addition of a DMP (Digital Motion Processor) core.=0A=
This difference is deemed substantial enough to change the WHOAMI=0A=
register value.=0A=
Since this driver doesn't currently acknowledge the exisence of=0A=
something like a DMP core, simply copy ICM-20608 except for the=0A=
aforementioned WHOAMI register.=0A=
=0A=
Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/Kconfig=A0=A0=A0=A0=A0=A0=A0 | 4 ++--=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 +++++++++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=A0 | 6 ++++++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 | 2 ++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=A0 | 5 +++++=0A=
=A05 files changed, 24 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6=
050/Kconfig=0A=
index 9c625517173a..3636b1bc90f1 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/Kconfig=0A=
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig=0A=
@@ -16,7 +16,7 @@ config INV_MPU6050_I2C=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 select REGMAP_I2C=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 help=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver supports the Invensense MPU6050/=
9150,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/6880/9250/9255, ICM20608/20609/20689=
, ICM20602/ICM20690=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20=
689, ICM20602/ICM20690=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 and IAM20680 motion tracking devices over I2=
C.=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver can be built as a module. The mo=
dule will be called=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv-mpu6050-i2c.=0A=
@@ -28,7 +28,7 @@ config INV_MPU6050_SPI=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 select REGMAP_SPI=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 help=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver supports the Invensense MPU6000,=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/6880/9250/9255, ICM20608/20609/20689=
, ICM20602/ICM20690=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20=
689, ICM20602/ICM20690=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 and IAM20680 motion tracking devices over SP=
I.=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver can be built as a module. The mo=
dule will be called=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv-mpu6050-spi.=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 597768c29a72..86fbbe904050 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -217,6 +217,15 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TE=
MP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU=
6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM20608D_WHOAM=
I_VALUE,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "ICM20608D",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .reg =3D &reg_set_6500,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6500,=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 512,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_ICM20608_TEMP_OF=
FSET, INV_ICM20608_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .startup_time =3D {INV_MPU6500_=
GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_ICM20609_W=
HOAMI_VALUE,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "ICM20609",=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c=0A=
index fe03707ec2d3..ed52b27409ac 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
@@ -29,6 +29,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 switch (st->chip_type) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20608:=0A=
+=A0=A0=A0=A0=A0=A0 case INV_ICM20608D:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20609:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20689:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20602:=0A=
@@ -182,6 +183,7 @@ static const struct i2c_device_id inv_mpu_id[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu9250", INV_MPU9250},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu9255", INV_MPU9255},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20608", INV_ICM20608},=0A=
+=A0=A0=A0=A0=A0=A0 {"icm20608d", INV_ICM20608D},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20609", INV_ICM20609},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20689", INV_ICM20689},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20602", INV_ICM20602},=0A=
@@ -225,6 +227,10 @@ static const struct of_device_id inv_of_match[] =3D {=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,icm20608",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM2=
0608=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,icm=
20608d",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM20608D=
=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,icm20609",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM2=
0609=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
index c6aa36ee966a..8e14f20b1314 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
@@ -76,6 +76,7 @@ enum inv_devices {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU9250,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU9255,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM20608,=0A=
+=A0=A0=A0=A0=A0=A0 INV_ICM20608D,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM20609,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM20689,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM20602,=0A=
@@ -394,6 +395,7 @@ struct inv_mpu6050_state {=0A=
=A0#define INV_MPU9255_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x73=0A=
=A0#define INV_MPU6515_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x74=0A=
=A0#define INV_ICM20608_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0xAF=0A=
+#define INV_ICM20608D_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0xA=
E=0A=
=A0#define INV_ICM20609_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0xA6=0A=
=A0#define INV_ICM20689_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0x98=0A=
=A0#define INV_ICM20602_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0x12=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_spi.c=0A=
index 6800356b25fb..ce8ab6db2bf2 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
@@ -74,6 +74,7 @@ static const struct spi_device_id inv_mpu_id[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu9250", INV_MPU9250},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu9255", INV_MPU9255},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20608", INV_ICM20608},=0A=
+=A0=A0=A0=A0=A0=A0 {"icm20608d", INV_ICM20608D},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20609", INV_ICM20609},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20689", INV_ICM20689},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20602", INV_ICM20602},=0A=
@@ -113,6 +114,10 @@ static const struct of_device_id inv_of_match[] =3D {=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,icm20608",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM2=
0608=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,icm=
20608d",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM20608D=
=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,icm20609",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_ICM2=
0609=0A=
-- =0A=
2.34.1=0A=
