Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8F5F2C67
	for <lists+linux-iio@lfdr.de>; Mon,  3 Oct 2022 10:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJCIul (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Oct 2022 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJCIuB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2022 04:50:01 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Oct 2022 01:32:21 PDT
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114BA1EC6C
        for <linux-iio@vger.kernel.org>; Mon,  3 Oct 2022 01:32:20 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 292MB0T8022281;
        Mon, 3 Oct 2022 08:26:40 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2171.outbound.protection.outlook.com [104.47.11.171])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3jxbwyrxbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 08:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa2LmLHOVvfHoT6z2KBlFD6u0aCQlOMsc+i1Sll7dVYTeqPNYuZhq7TuZxU5ZtCm5vzl9n949m8AzvRtScBYE1iqnLCYPfkTtdUwKTd8Cpq4nOeDbWsc+SsWggS3fZVF29GWt7hXpndBwXMUeNrBzQ8RHM/Yc7wvuRc+fcrEQVC7+r3Sn7zwTaff0EViR6nZpczNa40Cx4dNFnbt6G6lhXO8c06NDV1ZdTLh69W3Q7ujKIKasFO41A9opgeC4o54rQdbyuVAtxxwveL2yzNtleQkkiSAhGcOs01R1YBlZl0Ou5kkPIVyA9dhphv4tA+fVrubAGimQEdITNvBE+zSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfLS6wKwM7i7hEsuXqoNT1p9UqzMEgRJhEOoLJSsxAE=;
 b=lqXl+a2dgMsdoWpqQIeaWJkGLaUIUfPqu/xR+Nu6Diuv5yn5hK5VpN8jFF8UYIQvSA09Ur9MtYZmNi/fNex4TSpnyQKFczO+pbr9FuM5Sapp3mG+HU28/90Ef2CF3q1Ucqmx8laMwLgybhv6sf5hPfKK0597fyPge7YYde8k4aQOvlFyFLdUkVq3bQV2ZqccaIktp0AnOh+YkNw/ab/H0d9SUhz8Tf5SS5tUr0ir0I65PIy4zOINaEPjoDrqolH+2OivHY+LJAv9RdEE/tgg8kfHyZruSTp8haP2VKbipKyEsRtmSpZ+hxyS6aVwsJHNqNCRzzylzjVFU1JXmtyYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfLS6wKwM7i7hEsuXqoNT1p9UqzMEgRJhEOoLJSsxAE=;
 b=sGdL2qheGpQw603u0dIzxlFUdB96UBI4LCBkrrett1u2DCDlX+z4Ko2AtV9WfWfZ4jynUXDf2s2ZaBIWBi+24NBANpBE6GwO1QNcSIC3XBXvDpXf8JRjRWl8s2Pjxb3aeh8GXExShOOFtTTavyc2YoYCnHOqdS5kuDkfL7asL7YKF0gN02fnLdun2xV46n0B75esZcMe/5OcJVg8ee2Y43tNzBbm/beGfyROan0sNKLTK+EWi2fxAanQ6BOKf7WJ+zkkx1a3gJm7gEF41m+mnC0Mi7HwYP+zbpGwRI8s838TwGdn6NKDkCRCbhRRwjZzEzkyQgv8F0AZlc8rVYi0kA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB2889.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 08:26:29 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6bd3:d0ae:114a:b17a]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6bd3:d0ae:114a:b17a%9]) with mapi id 15.20.5676.023; Mon, 3 Oct 2022
 08:26:29 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 5/5] iio: imu: inv_mpu: Move exports to IIO_MPU6050
 namespace
Thread-Topic: [PATCH v2 5/5] iio: imu: inv_mpu: Move exports to IIO_MPU6050
 namespace
Thread-Index: AQHY0PeKoM7NVo+AKEm4VPJut4f/0638YSKU
Date:   Mon, 3 Oct 2022 08:26:29 +0000
Message-ID: <FR3P281MB1757475E124729C7D4513DACCE5B9@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20220925155719.3316280-1-jic23@kernel.org>
 <20220925155719.3316280-6-jic23@kernel.org>
In-Reply-To: <20220925155719.3316280-6-jic23@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR0P281MB2889:EE_
x-ms-office365-filtering-correlation-id: 5e7d9ec8-8a5b-4d0d-7de5-08daa518f86e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lEKq6XN2nHPK71KxE6tLjQqC4Wf4KZNZwYWaj5MZZ+5lyGCACde8f586f5H2hctNCWrJID+tXdW01cWVKpicpErZ8lkhEUG21f92N6mmeXe8RfuUdThLHMDd/zs2uroRDT5a569REZ9v9lWUlZ+POinluu4yJNN7L8mnEKK3JOaG8dUGDdd8vxPpvM41X5X40pUuhiQKxJBs0bP+NP86g2VhGId9vNoibCtP9XiMePenZE7H/hKM6LrLl0+BmsiYGkRwja+gSOes6bYOS13p7X/xUBSSIgKsPJsqoaVkkSfX4K3vWf/pvstYpOrlYIBIgHGbyBsvDJz9wCjoOVZE/fksnLgj5qnxYlSFFmrlowNvjb1cNjzblvy6nyJpuUcN5HJrYoAo/rXl/C94CM1y5HLc1rLJD9m3XOuV7I1F/A+oA9kiaXvm6M/t3S9h6UgtpZaMQS7SlEB/R9XOl/JcY9azMpW6IpGbMFT9mAN5ze1lIXrkQNHTOBP/qPJFgTrO2RLPMkYkJ739Hq5EkTTm663UTtSl5so4knEMHj8SzIB4cHjA56rXZwipkC3jjmBZgmEIM7gfcKEe/1+LjNbf3oo3l/M6loBXwQHK2fKmYj8eVN7lYz3uAxMr3jxYsGIQxnaJRyBWl7fUzPCHAcrsmLYs8P7dVx5fmOaXe5qK0J1vte3u0ZJ2PZ3LR7jeClsULWA4sE2KKUSGLInV5ny8jft+PwHhsD1lJxM0C/WrO7N5Qmjn8TPiaR7PIprfdzu3f1UTkGD7pEZTEtsf485wHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(451199015)(110136005)(54906003)(478600001)(86362001)(41300700001)(38100700002)(71200400001)(8936002)(66476007)(91956017)(76116006)(316002)(66446008)(66946007)(66556008)(5660300002)(4326008)(8676002)(64756008)(33656002)(83380400001)(9686003)(38070700005)(26005)(53546011)(7696005)(6506007)(186003)(55016003)(2906002)(122000001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2mS2Zkks+iEaM2z5dkzaEnQ7BR8ovEHOFWqpoSLOkO9BkaRj6Nptls8dLF?=
 =?iso-8859-1?Q?Dpo7epvHBNaFnScykKHzoH3BCvnKewss2Ya6AjXR7nZ29ZA7OrgeMfDE4f?=
 =?iso-8859-1?Q?rfD4hfwgYV0xd3LXG+IHio38NnzXo3BIob/kFQyOxj3KJ43CUJj0k+RDT/?=
 =?iso-8859-1?Q?q4ODDBxXHd5TVJESLDL0nnxUIaTKEOHP9MThR4tAzP8qpLbsxgQw/iCoWb?=
 =?iso-8859-1?Q?aJ4KqpV1MA1MvV7pqhNBf1oGMg6/oYiqIIz6QiHF52hgMJE3bE4JqAdsh1?=
 =?iso-8859-1?Q?5REtJWRH03JVxzEBHe1jbEk/HiyIRz36P/ZsxQ3M+idDxv9wvJ/Sb3B7xf?=
 =?iso-8859-1?Q?bx/B+fWcgx516fqoJHIX33ffhOCnbcCRdjNziTz9HS57pIVn5+7Dz9vAu8?=
 =?iso-8859-1?Q?keWBC3PvRARpRBBXwwq/tW3LVgF3JYy8emEIwKrbcGHSRgamb0a/0xm77t?=
 =?iso-8859-1?Q?SWRFOIcjGd+I7spLDauuugob65L5WktGQ4Ob3/9U2LtdHeWEjtbdrDQTvZ?=
 =?iso-8859-1?Q?0irCAakM5ePO6g0ueMQP0wa1zaw5jdzLQBhMdHooLQVaYrjMSNbBl9C6s9?=
 =?iso-8859-1?Q?tEKHfhPvf2068jt195kFRxN8Bi8JZux80nTc4bKUV4IQggbVbKA0Byuorv?=
 =?iso-8859-1?Q?nZJB5S00mfLbvYfQ4mctkK1T9uvBIWSX7qfJYEf0lPT4OEPYIaUcbpYcIr?=
 =?iso-8859-1?Q?2grVXRvWxbPnA7C7K8K709vnLQgjLD+cYCdE54WmlWdF3sUEXRg4cpZaFa?=
 =?iso-8859-1?Q?nTmXCvnV05YjHdtwRESiM6B1h0sxEmlGu2ueGYPJ3KElIREkFMlBDVjpGM?=
 =?iso-8859-1?Q?sBO+jtGUa29A1/tghWQrgv4E+oJwi/2dWvrRryGm8ZoU9Q8fGm6hLmybs/?=
 =?iso-8859-1?Q?39utIFzVC9CmzhWbGl6oeGyXTG8a40SAzEI+qC6BBWy9boWNmXr3qCQqUr?=
 =?iso-8859-1?Q?0/euPxgJS5CbfvswOgpeuQslC0f3p4rL77aicaeTo9qakTkxeRHtAkFOPZ?=
 =?iso-8859-1?Q?ycetx/DL2fR8ILAl5jmS0iOLtKSaSu6G44gGtkjaZcNiHVmQZwrs2aQSyt?=
 =?iso-8859-1?Q?bJyUG2gza1gbuHtDydVOUQgjiiVndPNlgqczWzdqc2IEnHD3sGmy2B/WeN?=
 =?iso-8859-1?Q?C24suYTDo4FrtitbF76cS8huJQrkE7jGpl7thth3MVsdf/X1B0PhiuIZhW?=
 =?iso-8859-1?Q?QbRo9zWsQe0MWhpcxSf8s2zvVGPhNf8cCUt8XcZ4CZ3LOJGD8Q/2QnmQR9?=
 =?iso-8859-1?Q?lPNf7ALGlY9dQsYOtgjUw9IidcifXFgXlYL5uBS8IjtzEJZPPClasMxUKD?=
 =?iso-8859-1?Q?51XG7pEw13t1h7eTyKuOeKyNML6MZEFKqkOyRMDPiexyfmwbugeu128vUz?=
 =?iso-8859-1?Q?Eetl0+LMfqJk567x9Ca+UGArL5sY8GDaXHQwb9OJkizHF30GfqMxDSPrEE?=
 =?iso-8859-1?Q?gWtrDQxlRNiEtO8E2ybgMXaAj4SIfKTt/qb5TU5TBddFCz4uieoGpWLgI9?=
 =?iso-8859-1?Q?gQR/d+ld2P/cQl5U829S6D6uzgpJmVujqbQw1i/GKAlbQQIGlRKcZghfyd?=
 =?iso-8859-1?Q?pX1IZqRXx5OFRBJQ1y1B/Dx+POsbyY7m6LQtDEl92sQd5uDwCrqvO2FvCW?=
 =?iso-8859-1?Q?fDp4aSYgLH4HIclKgZGv8ct4Y0ESxnj+vws94eu5XQgcz+FReykoP4oA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7d9ec8-8a5b-4d0d-7de5-08daa518f86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 08:26:29.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6YoLKLSCclEJHS4RQwU/ztlCll2R/z+VKXMTpB1bKZqpe1BFVuuXxxEhtRMgXEWu+Gc1uqx9noyjYHnbHn00vyGCye0uQMMW2DoyTrk8yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
looks good for me.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, September 25, 2022 17:57=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc: Rafael J . Wysocki <rafael@kernel.org>; Paul Cercueil <paul@crapouillou=
.net>; Linus Walleij <linus.walleij@linaro.org>; Sean Nyekjaer <sean@geanix=
.com>; Rui Miguel Silva <rui.silva@linaro.org>; Jean-Baptiste Maneyrol <Jea=
n-Baptiste.Maneyrol@tdk.com>; Jonathan Cameron <Jonathan.Cameron@huawei.com=
>=0A=
Subject: [PATCH v2 5/5] iio: imu: inv_mpu: Move exports to IIO_MPU6050 name=
space =0A=
=A0=0A=
[CAUTION] This is EXTERNAL email. Do not click any links or open attachment=
s unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
As these exports are only relevant to core module and users in the=0A=
bus specific modules, move them out of the main kernel namespace.=0A=
=0A=
Includes using EXPORT_NS_GPL_DEV_PM_OPS() and the simplifications that=0A=
brings by allowing the compiler to remove unused struct dev_pm_ops=0A=
and callbacks without needing explicit __maybe_unused markings.=0A=
=0A=
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
Cc: Linus Walleij <linus.walleij@linaro.org>=0A=
=0A=
--=0A=
v2: Switch to more flexible version of EXPORT* macro from Paul.=0A=
Dropped Linus' tag as the new patch is significantly different.=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 17 ++++++++---------=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=A0 |=A0 3 ++-=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=A0 |=A0 3 ++-=0A=
=A03 files changed, 12 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 86fbbe904050..8a129120b73d 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -1653,9 +1653,9 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq=
, const char *name,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 inv_mpu6050_set_power_itg(st, false);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=A0}=0A=
-EXPORT_SYMBOL_GPL(inv_mpu_core_probe);=0A=
+EXPORT_SYMBOL_NS_GPL(inv_mpu_core_probe, IIO_MPU6050);=0A=
=A0=0A=
-static int __maybe_unused inv_mpu_resume(struct device *dev)=0A=
+static int inv_mpu_resume(struct device *dev)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev)=
;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_de=
v);=0A=
@@ -1687,7 +1687,7 @@ static int __maybe_unused inv_mpu_resume(struct devic=
e *dev)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=A0}=0A=
=A0=0A=
-static int __maybe_unused inv_mpu_suspend(struct device *dev)=0A=
+static int inv_mpu_suspend(struct device *dev)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev)=
;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_de=
v);=0A=
@@ -1730,7 +1730,7 @@ static int __maybe_unused inv_mpu_suspend(struct devi=
ce *dev)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=A0}=0A=
=A0=0A=
-static int __maybe_unused inv_mpu_runtime_suspend(struct device *dev)=0A=
+static int inv_mpu_runtime_suspend(struct device *dev)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(dev_get_=
drvdata(dev));=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int sensors;=0A=
@@ -1755,7 +1755,7 @@ static int __maybe_unused inv_mpu_runtime_suspend(str=
uct device *dev)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=A0}=0A=
=A0=0A=
-static int __maybe_unused inv_mpu_runtime_resume(struct device *dev)=0A=
+static int inv_mpu_runtime_resume(struct device *dev)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(dev_get_=
drvdata(dev));=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
@@ -1767,11 +1767,10 @@ static int __maybe_unused inv_mpu_runtime_resume(st=
ruct device *dev)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return inv_mpu6050_set_power_itg(st, true);=0A=
=A0}=0A=
=A0=0A=
-const struct dev_pm_ops inv_mpu_pmops =3D {=0A=
-=A0=A0=A0=A0=A0=A0 SET_SYSTEM_SLEEP_PM_OPS(inv_mpu_suspend, inv_mpu_resume=
)=0A=
-=A0=A0=A0=A0=A0=A0 SET_RUNTIME_PM_OPS(inv_mpu_runtime_suspend, inv_mpu_run=
time_resume, NULL)=0A=
+EXPORT_NS_GPL_DEV_PM_OPS(inv_mpu_pmops, IIO_MPU6050) =3D {=0A=
+=A0=A0=A0=A0=A0=A0 SYSTEM_SLEEP_PM_OPS(inv_mpu_suspend, inv_mpu_resume)=0A=
+=A0=A0=A0=A0=A0=A0 RUNTIME_PM_OPS(inv_mpu_runtime_suspend, inv_mpu_runtime=
_resume, NULL)=0A=
=A0};=0A=
-EXPORT_SYMBOL_GPL(inv_mpu_pmops);=0A=
=A0=0A=
=A0MODULE_AUTHOR("Invensense Corporation");=0A=
=A0MODULE_DESCRIPTION("Invensense device MPU6050 driver");=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c=0A=
index 2aa647704a79..f89164fabf4b 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
@@ -269,7 +269,7 @@ static struct i2c_driver inv_mpu_driver =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .of_match_table =3D inv_of=
_match,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .acpi_match_table =3D inv_=
acpi_match,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =3D=A0=A0=A0=
=A0=A0=A0 "inv-mpu6050-i2c",=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .pm=A0=A0=A0=A0 =3D=A0=A0=A0=A0=
=A0=A0 &inv_mpu_pmops,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .pm=A0=A0=A0=A0 =3D=A0=A0=A0=A0=
=A0=A0 pm_ptr(&inv_mpu_pmops),=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0};=0A=
=A0=0A=
@@ -278,3 +278,4 @@ module_i2c_driver(inv_mpu_driver);=0A=
=A0MODULE_AUTHOR("Invensense Corporation");=0A=
=A0MODULE_DESCRIPTION("Invensense device MPU6050 driver");=0A=
=A0MODULE_LICENSE("GPL");=0A=
+MODULE_IMPORT_NS(IIO_MPU6050);=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_spi.c=0A=
index e6107b0cc38f..89f46c2f213d 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
@@ -154,7 +154,7 @@ static struct spi_driver inv_mpu_driver =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .of_match_table =3D inv_of=
_match,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .acpi_match_table =3D inv_=
acpi_match,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name=A0=A0 =3D=A0=A0=A0=
=A0=A0=A0 "inv-mpu6000-spi",=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .pm=A0=A0=A0=A0 =3D=A0=A0=A0=A0=
=A0=A0 &inv_mpu_pmops,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .pm=A0=A0=A0=A0 =3D=A0=A0=A0=A0=
=A0=A0 pm_ptr(&inv_mpu_pmops),=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0};=0A=
=A0=0A=
@@ -163,3 +163,4 @@ module_spi_driver(inv_mpu_driver);=0A=
=A0MODULE_AUTHOR("Adriana Reus <adriana.reus@intel.com>");=0A=
=A0MODULE_DESCRIPTION("Invensense device MPU6000 driver");=0A=
=A0MODULE_LICENSE("GPL");=0A=
+MODULE_IMPORT_NS(IIO_MPU6050);=0A=
-- =0A=
2.37.2=0A=
