Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B258D51838D
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 13:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiECL5X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 07:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiECL5X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 07:57:23 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F302559F
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 04:53:50 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MhBha013127;
        Tue, 3 May 2022 11:53:39 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2170.outbound.protection.outlook.com [104.47.7.170])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3frufwhfx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 11:53:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fitRGtvOSliRzGGUGhr7j88SpohPWTRCR8PizsYW5RolqToTaQcXriudnlHYAG1x/2Re+D458Vxh9UX1ocusNnk47xHoQnC82pwkNMSceh82WiXGF9coCS3+B6wBNUtn+9D3wok4koYaYYV1JSyh4+fUSct77nUK/YZTmnWveemJTR2eAclMNZDHNXhn3YnOFxEha9qQjZNXF6/RP+SwuKjZaJEHq3ZbGtpkrFJtZRg6p0Kf2a8TwW4F35FhMaWOaaiG+1MYxW/9DIbpKTHal7pMQaHISVuBZrjveStwj3Y2uOqnnYvDEJe+wGLUSHR3S4zR5gIiYeWDXo6I3fi5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOHXNEshf9ONspUDkgYwX/g6dlpmhbF+BT107eGKzGw=;
 b=PGpx2/SIgz1iWaVQD15bHUPESn0FHi/fkvdpJhNek+voe3K4W8xC0Rbc77gOE4599jdlUYHRwo+eGWpXiLGpelghYk5yFUqdD7kOSPwR/wlUkksOIg0Y7fD0bVsaQDUmvptEklbSdea1YJG5CMmr+DJEr4N4umFEMzO/Y646c/LKUKzMeYLkgL3lmtISqvU/HcNIbJbsvIhh+g1vdKDxZrPoUfmMw/Sxij/z1g/VB+EzHF9E/rHE3VmJ2t71RuBEv1GdAQwQIUuXAtRdBGTY7gZN5BAysFgOjFf9q2csW9uLHD55uYTwSeqQ9l3wsnodsLiSewsAktIpZrPwB2KxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOHXNEshf9ONspUDkgYwX/g6dlpmhbF+BT107eGKzGw=;
 b=BlZPAUITysLo/lgfjXDPB5mn8jbfNxPiYZgaIuI4AwMDToQniivaiGpwV06INO4d73okfPJKuq0neyeFhWG06a9wzq6E987IxyGpA0bxBntuU5LWYZs+P2IE8wAVXg8ANSZzWD+f2gewZ/8IyfxFY3bsPhtsMmU20dxQqvYPVr9IR2GLufErZ6YiEUv06dmp6F3SJfx7eCQ0ZmG7jfTHvLYEKXvlOSAazc2GlceKjldK0pfNmyW+MHF07WvxfqsegPR2aKkeCkx1albNgBldkLzPp7BhHfQmQj0SOyLVje7qtzbKW0Jk51F8Ael4F6sFZwJx8taIblb7hP7BPtf9vQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB0356.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 11:53:36 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d8c3:e47a:8c09:c8a8]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d8c3:e47a:8c09:c8a8%6]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 11:53:36 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 77/92] iio: imu_icm42600: Fix alignment for DMA safety
Thread-Topic: [PATCH 77/92] iio: imu_icm42600: Fix alignment for DMA safety
Thread-Index: AQHYXsy5xjiQD3ek00yytuH17ZzBSa0NBccI
Date:   Tue, 3 May 2022 11:53:36 +0000
Message-ID: <FR3P281MB1757E9E785E848A1171CE9F0CEC09@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-78-jic23@kernel.org>
In-Reply-To: <20220503085935.1533814-78-jic23@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 255a6ec0-37c6-b151-9c92-b96b3d404c31
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2008f86-6c60-46a3-02d6-08da2cfb8e8d
x-ms-traffictypediagnostic: FR2P281MB0356:EE_
x-microsoft-antispam-prvs: <FR2P281MB0356094041CBAB38CE5F2429CEC09@FR2P281MB0356.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lre1yDgoZzCu7Uh4plzjbeaGE98AIs4Vqkw+TgPzsAbW/dfjHnmx1quF0PB8o/vAxgJGNVaJBRnaucVLKbEGU79Tlk6SqpMMm+yx6mwer9w/JX4zA9u6DLYWmKJNTADMMWnRzGoJ58sToHmUy6CFq97SqtXMFrocCKsqFNObgia6oEN7y9b7bsrZaK6MHzwpQoZqY9mUMEsFzq2C6ID+iVikft/sHRzrlKPr+939sCMBoFB9T06aq098d02a3+UDjcthTgVtW3c875aL0JOSJwxseU0Z82oGvOtuzKPVBdD30n7D/niViPQk0A4n8l92tvU1P5snYhS7df3P9+r007qPFSqEIYbKPztx6QOckTFdLRblPnty44qxG42zXmsf9JZfmBC+L2Su9kDPaIqIcHwoCAltnr08xSkzfcDqu1fApQnj6+chqQRUUVUt719JYV04feAkOa44gi9JJRAl2OMsDNHQ9AslcSprTr8BMPJE5/4j1BnbrI4LkmNgukU+SwsP7no/eMPUu+KpSjw5Gu3CaeixRng84ncmfdq0CBUNYbLNxFhr8LZwlLXdQoGceiHllxEHcFbAUVwei7gYHsVMNsqOFnfPV6hhwKH5RlT/pLcW7UVlxULbgXhT4TXxCtWiCSJL/yYp2WI8jGdc+4Qz4hdmrVdH7oC7HM3UaS/mGaLu7EOSpePuBmbSNwOfr/82CweYKrc9J6H2IWqFCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(66946007)(5660300002)(508600001)(8676002)(2906002)(38070700005)(38100700002)(76116006)(91956017)(66556008)(66476007)(66446008)(64756008)(52536014)(8936002)(7696005)(55016003)(122000001)(186003)(71200400001)(86362001)(66574015)(83380400001)(110136005)(316002)(9686003)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kg+siS/JxzsTB4dtcMT9qC8cYWuM441nIFtPTZ4gduTtx3sbAxlj4CNZo7?=
 =?iso-8859-1?Q?v2Wf4nNfamcXEwQ3tduO0Qeck3JB31FmR+Dz+Ciy1SqtJw51BXOoFCnE5w?=
 =?iso-8859-1?Q?rZ29b85naFFj3Tirchu/gpQn3oOA+lQ3CtJ9Z7Mnoz9vWIIp69rcUeJmA5?=
 =?iso-8859-1?Q?5SdDMTCVY9/HaXVqcJNvZgVaoNytCLu3OmudPVMZAeFhgDUnkpV50JWJnk?=
 =?iso-8859-1?Q?cwhFrXr3CFwdYEccqpNvfDgx4VH0R+c0i2Cl/U4uRf6o+l3tVa2M30UXAl?=
 =?iso-8859-1?Q?m2CuPOkAgkg7qj4XwNoF696LCJ29pgnXKb33SJiQ4pGIzNAlXP7Kep8uH8?=
 =?iso-8859-1?Q?yvPtE6XQHGnwcHs6ixk/VBExbpn2SMSYpjC77Y0gp9BZrGfVFa4HxNJOwM?=
 =?iso-8859-1?Q?2Nb1WBj5piy+k7yvvRdoLZkgQfuAiOU0TVWzUvw4x9rQctdE6R0UXtTk9G?=
 =?iso-8859-1?Q?Mps11VrI84TTvq8ULl6ptJkhGs6uTZZwargJ/ZjdeDvGpOUnMptv97ap3O?=
 =?iso-8859-1?Q?0cZC/urpoPH3ujUfUnwaoOWXeynyTB0OpBFMNwd3aixPsywb64u6wmY3KR?=
 =?iso-8859-1?Q?+g3eeGMpmFJZKV0HMSw6ycKoUjcG2Y+Gm4oqOqY+wfQpA3ps7X1+JdQX4Q?=
 =?iso-8859-1?Q?qJwkwz0w8S20HxfjTWYD6FeNtAZy09oAVVEQxhOxhweEwQmSbnXq+yX8vJ?=
 =?iso-8859-1?Q?MNVUzNjpVXVUhMZ54+UYkAAp+01IrcTTfPJ9/FPLpQABOsJX6UjdGVLYDv?=
 =?iso-8859-1?Q?UE3tNKmeja49A3jnFSQsYZDJSwH7VA4J/ooLpDSABolrzH0l75tc+++aHl?=
 =?iso-8859-1?Q?2T+9sLZoSATNNeRztqlmFb5uA9rsjfVcfACyLGI5r7FntoY7vLW/sHNJzQ?=
 =?iso-8859-1?Q?3gKS8xXSrQoW8s2p6AZIYZbocX3F0hRQqvy6pEZIfRrn0wTEJuK6kfm5D6?=
 =?iso-8859-1?Q?jg89GnxYr9VqgU2vsmeDt10Gh+mo9CiLyahqnofs3CY+/dYV+ZftOaHn/4?=
 =?iso-8859-1?Q?3x7a3VjhFcp2XmTTk29XgYtqcqyvw0VboDNas+SkPRb4Ad+xph/bVMMdo6?=
 =?iso-8859-1?Q?0GH72en+0OfneQyP4OaYlJuqBX3dph+PrBH4ayhjNOgbH/x+wiEu59b2CU?=
 =?iso-8859-1?Q?Gj2ZolE6v1XcdjJdu5zUpCBIIEPI2/HMarPUK7PLM26I/TeLvoap/vFIh6?=
 =?iso-8859-1?Q?9oKOLCIga9v6D8QDLV5XWfZb5mRSK8obVEX9JSsxexjAKgiYTP51qas/t0?=
 =?iso-8859-1?Q?QMPsThaXUhgvZMYBlGB8I6NVw3UlzYrAs0ji02RW6QPK6S3CY1BpPib5Fp?=
 =?iso-8859-1?Q?/CUl9momMMfuWycd8SMArDeUknbHPA3gxqulDT7P9zP2NmyQ9d0N/5ZxL7?=
 =?iso-8859-1?Q?NkeuW6zg/j1wuIwG1gghXwKaO10/sQ2j482bFspCsMFbJf1w9RpYAprdei?=
 =?iso-8859-1?Q?NraOxTypbdQOlDPhi6rTbO++/LAUtidDrknBHzEjstemf4/yKTUOvJlHc9?=
 =?iso-8859-1?Q?Le9tNjwPIdlKGE+gu/eYhUZ2uzyUR25aUJmjuv0KCjnHp6PtNt7CkaV15O?=
 =?iso-8859-1?Q?SGgs8FwN/y8t97oGwgYDUo5cf7uIUSuHrgYXjZLW/MVGisIQFjHS9O5sVn?=
 =?iso-8859-1?Q?23A6g6GnRPCLJC7plFUj5YKKFyP9nkJWyDJZIFYnBEm+gN5YzB87Qfr+sk?=
 =?iso-8859-1?Q?AeoLTM/7Y++GjPTRrBK4mY09j7um7EAkw5ZjhjQSNnEhXyVRwpQ3H753Zp?=
 =?iso-8859-1?Q?FwMtLGoL/hklCF7nA+i+hE9Xf4ef/DLAWSChnqOgiTxflrgzCs/11O7pXs?=
 =?iso-8859-1?Q?4ItYuUF7ESUPcYwXTFARD+nzuls1PQ88a+aNRArnrY2+Hkfo0e3Fymz2lV?=
 =?iso-8859-1?Q?7v?=
x-ms-exchange-antispam-messagedata-1: vmsXgdE3tygjipIXulicLp03Vt51Lndl8Z0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f2008f86-6c60-46a3-02d6-08da2cfb8e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 11:53:36.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8Zmw0DJyXCqflZXIogKs3YaZmVzP7Cy0IhnSDNeYDvYI8cN/qbqflSljTr53IDCMDkYg0FwPxwPnSBcdBXr/M0qDdARcoF5xCLFgioRQYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_03,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Tuesday, May 3, 2022 10:59=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc: Akinobu Mita <akinobu.mita@gmail.com>; Alexandru Lazar <alazar@startmai=
l.com>; Alexandru Tachici <alexandru.tachici@analog.com>; Antoniu Miclaus <=
antoniu.miclaus@analog.com>; Charles-Antoine Couret <charles-antoine.couret=
@essensium.com>; Cosmin Tanislav <cosmin.tanislav@analog.com>; Cristian Pop=
 <cristian.pop@analog.com>; David Lechner <david@lechnology.com>; Ivan Mikh=
aylov <i.mikhaylov@yadro.com>; Jacopo Mondi <jacopo+renesas@jmondi.org>; Je=
an-Baptiste Maneyrol <jmaneyrol@invensense.com>; Lars-Peter Clausen <lars@m=
etafoo.de>; Marcelo Schmitt <marcelo.schmitt1@gmail.com>; M=E5rten Lindahl =
<martenli@axis.com>; Matt Ranostay <mranostay@gmail.com>; Michael Hennerich=
 <michael.hennerich@analog.com>; Michael Welling <mwelling@ieee.org>; Mugil=
raj Dhavachelvan <dmugil2000@gmail.com>; Navin Sankar Velliangiri <navin@li=
numiz.com>; Nuno S=E1 <nuno.sa@analog.com>; Paul Cercueil <paul@crapouillou=
.net>; Phil Reid <preid@electromag.com.au>; Puranjay Mohan <puranjay12@gmai=
l.com>; Ricardo Ribalda <ribalda@kernel.org>; Robert Jones <rjones@gatework=
s.com>; Rui Miguel Silva <rui.silva@linaro.org>; Sean Nyekjaer <sean.nyekja=
er@prevas.dk>; Tomas Melin <tomas.melin@vaisala.com>; Tomislav Denis <tomis=
lav.denis@avl.com>; Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>; Jo=
nathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Subject: [PATCH 77/92] iio: imu_icm42600: Fix alignment for DMA safety =0A=
=A0=0A=
[CAUTION] This is EXTERNAL email. Do not click any links or open attachment=
s unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
Partial fix for this driver as a second instance was introduced in=0A=
a later patch.=0A=
=0A=
____cacheline_aligned is an insufficient guarantee for non-coherent DMA=0A=
on platforms with 128 byte cachelines above L1.=A0 Switch to the updated=0A=
IIO_ALIGN definition.=0A=
=0A=
Fixes: a095fadb443b ("iio: imu: inv_icm42600: add gyroscope IIO device")=0A=
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
---=0A=
=A0drivers/iio/imu/inv_icm42600/inv_icm42600.h | 2 +-=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/=
inv_icm42600/inv_icm42600.h=0A=
index c0f5059b13b3..5b3740cb364f 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
@@ -140,7 +140,7 @@ struct inv_icm42600_state {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_suspended suspended;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_gyro;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_accel;=0A=
-=A0=A0=A0=A0=A0=A0 uint8_t buffer[2] ____cacheline_aligned;=0A=
+=A0=A0=A0=A0=A0=A0 uint8_t buffer[2] __aligned(IIO_ALIGN);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_fifo fifo;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t gyro;=0A=
-- =0A=
2.36.0=0A=
