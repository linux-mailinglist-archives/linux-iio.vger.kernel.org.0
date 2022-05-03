Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1A518402
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiECMRj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiECMRi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 08:17:38 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B532EEB
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 05:14:03 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2434ccGM000876;
        Tue, 3 May 2022 11:56:10 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2172.outbound.protection.outlook.com [104.47.7.172])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3frxfjse2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 11:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7Rti5iN3ESe2WMPRRBNRq/vZ7VtdgAKicZbLEKokXtwBkBFKLL8vTmohJolorNbe0jl6TQhIQErbU1vuAdbDS3485Mv1olRdFjMMgiLjew5Hi7Ew5ku1JtnzaN8EkUwccKgjECA1jgLtvjPbE81aMKJeZm6wKsNja4LKWcvdaOl5MyBZQWuMhCm70AVit91k+fcKOU5i91PP2SXhdTsr1G6ct+H7iiJi7IkUapNljlnoWBPNkxbKECkvZp1ooMGEQoiYJAczK3PY/df0+S4ZB5PDsgFTtxQNUMkom++A0vHo3gt3A+qvl19Gj0rew7AftT2Ylz0HKFa5dr5bfo69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BI5pvx1TYH2oINIgmV1sN13WL5kSxrYODtxRs1M3Cec=;
 b=hIiJC3gqjP+VqqChGJxvgGEB8YN3Og6gGB887bSiRkfzyunHxsxVVwFR7+WRRHuJ2tgiQTctnQ/I3xY1iTvXARkM9RBL11o+X9sTroqcmfmHyI7ng1h5hd4SLSslMC57jBVM3ZFdbPHkM1GV7VvoHeioBWHznuLYhLmwfvHQf1xsyw8+fRmoPvxzExwcskhqeHaebKzhgEr/s5O3mnJ/Jbafm4LtmGdieEaIcxqgqpPOhxTYr34/6YZeWchrpLtghYArR/6YHYDGAU5Psq3rBfB++r5DZaluzqkTZ6EG8z1E6J3jTjO6wJOHz2XngN+A5s4p82hoe1Q87QbXF/yCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI5pvx1TYH2oINIgmV1sN13WL5kSxrYODtxRs1M3Cec=;
 b=BvUcisXDTo/BK1nTzXtYdhy6YWNlm4zyQdoq0Zj6HxqmqP05jqvORNAbo4bkvjmflY/33Bnl0XaF6mY7A8of4BBUOhlfn8fr37vrKy9GWd3Z1R91CfBNhanzCddZl3IKLtU4/un86LcZ53m48y0sG20ohzcfScQSTDuNl6NdDihI0tG3gcYRaJj37QB2KI4MF9YFT6ehXB5TeinlPYMrRtKws6a3HBOt5bMoU/N/BbZpFXDB5Q0noh8Jn1CMkMuAQKcQrekPNgKGuOoPu5wWJvX/NnyflhKSfIpe6n0d027Uddh6nlmvzB6bEhZPVAOdR7ei4AypRuBNBb1Z8NHLLQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB1604.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6; Tue, 3 May
 2022 11:56:07 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d8c3:e47a:8c09:c8a8]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d8c3:e47a:8c09:c8a8%6]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 11:56:07 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 79/92] iio: imu: mpu6050: Fix alignment for DMA safety
Thread-Topic: [PATCH 79/92] iio: imu: mpu6050: Fix alignment for DMA safety
Thread-Index: AQHYXszD2xpm+6eYTUCmQdROsIV2X60NC7Ev
Date:   Tue, 3 May 2022 11:56:07 +0000
Message-ID: <FR3P281MB17570583D9C12654D7FCC28DCEC09@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-80-jic23@kernel.org>
In-Reply-To: <20220503085935.1533814-80-jic23@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 13f890b1-5f4e-2ca2-45a1-04ed2166b3cf
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a08e7dd7-40c5-4be9-25df-08da2cfbe879
x-ms-traffictypediagnostic: BE1P281MB1604:EE_
x-microsoft-antispam-prvs: <BE1P281MB160451ACBBA6944DAD6152A3CEC09@BE1P281MB1604.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uIJkSRnv9llk2rWWrob99KV8W8oW/jlwYxBpkY3INMYvvX0uMITv61P2zjo0KYT/7Z98hqVGfQyaDr4m9DIG8OQSDQhtmoA4sYMJ70UgfwusUBgCqMePawfP1UTosHR7qH6OxjrlOMPOWlMf/OqPxmvdXOj6KWVnmzSJGNafnO0ok0Bp6qV0GkgIfZqOQTeCNVgQw07y/+Y2FUWq6ta2wWo+mSpDMF+14kpyeUZemUfqmPi3Ymi8lwXaqjFB59eti7Qr0fo8wuKZEhUBoOUJSEDE0IEeqsacHC7Ezxq72KcH4f26ZTt1Hxf8iuaxgfcPJnEKnPTxyYP9nONBadiZneTtEAYihas0a4niLZs7zKHCIo3n/5KoBksK34JCVQzB0Fr7csqSUJ/sR0zMpyvlU0JoBjFjRXhZ9HO0NwEil5HuB6Nu3FyLFVxdp/yveQfMay3539aUJbZmKH/PATWROmnSVrIxDkVuS9VmJ6gpTpOrwQm1Il2NU2f0E0N/AkUE19BGilPvtxMEavGKahySRq/x48r0SXF77U15KThhPO0aPDTNi0QipVzHVFH4YnKkBzSk3y6AXghVHIPpVPttmDG9pkXVjyW+TFbWf3br9xSgWCEYEK/4NZ+1nVrTqU+w8q3wd6neOjYrumeU+c8HjiIkajtDS/QqS/BrBkl75tHEx58Z38tjioJL19ltJ6zdE3AJhgmrp8bRqpNdnnq4mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66476007)(52536014)(66946007)(66556008)(76116006)(55016003)(64756008)(8676002)(66446008)(5660300002)(91956017)(508600001)(33656002)(316002)(2906002)(110136005)(6506007)(9686003)(7696005)(53546011)(186003)(83380400001)(86362001)(71200400001)(66574015)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T8dxxjgzVYGImcvK5/ZqgMz1wJ0jMipb0t0lkOGBmjhn5zoFhJvPFzB1sz?=
 =?iso-8859-1?Q?AQjWGBXBKDrHXnbfWLVSPw3fjcyZhgy7mTlqmQhTRTItS0cnKb7mPIIKVU?=
 =?iso-8859-1?Q?X9LiQlF1Sio+a0rV1jinm168qQ5dUGAFsu86iNH2smvUNbO6TOPIgyGRkv?=
 =?iso-8859-1?Q?IwAk0ST8qn+SS9P4ctXNvuwhEPDwbop0QRZWrCxWCyFZOHVWxI0MM7sTSP?=
 =?iso-8859-1?Q?WathRK/wI4B26nGo0mFQejVIZKg5A7gMixtjdd3Cdqaa5slH3gkUTvyIM/?=
 =?iso-8859-1?Q?hU+IcQ00QdcZmejRw3bhmTdb041kOgGuoPhfuPtYg4IOULs6V/xiIgIP6I?=
 =?iso-8859-1?Q?j2zjdw0+S8VQoDheFPw5aplDPNVWva3EHkP/d+hI3xsVmIzv73NVrDD+sH?=
 =?iso-8859-1?Q?0o/XNEZ2Ucnmbe2LT6gZfNspra/dVwPHV5fhRj+TOKCewY6+zPRIYknt1I?=
 =?iso-8859-1?Q?CINcoIgodCJUhBRcPNKnGylpoZf2E2G/cMTK/L+Rg/QUxXmFTJKhy95+2c?=
 =?iso-8859-1?Q?9/GF9k6icWnK5qL09PDbSRguF5VRkM3/Zd+D6Wf9bZyXvYIs0ccvzX3c7v?=
 =?iso-8859-1?Q?rfX1+YVSjxZv2dZnTx8mqLPyVxBAJCTJCg7jFq0HfXL4fvXobXUHINnpp6?=
 =?iso-8859-1?Q?xer0Rgtz9sXMINB+fNRUf79DBVq6o/lRRbD4CY+1nFO8HzIIgPTLckbQT5?=
 =?iso-8859-1?Q?spuWEnX8pZ7GhsOxZaEygTgIIRXZvw6qg0xYuGzkPzlBZbi3WWqLhQW4O7?=
 =?iso-8859-1?Q?oL60hclASvFFORZuGM6zs9DmwSenBYIfeYm+TbFc7fpoIjgkDmi+N0DT5M?=
 =?iso-8859-1?Q?pYBsvqXJ2uY7w0WDBMNqEmerJcCRmhCUHD7zP+RaGuImBYCaXwwRv5dHlc?=
 =?iso-8859-1?Q?/HUxjpfi9bHZQmjLcQRCvPIaPfJ8AvVJ9WEwtDaL1uHfEATcwd0M1DwzHX?=
 =?iso-8859-1?Q?gK6aZUTtjLVHSgAk0C+GK44HZ+XeINRm2qD/kuMu5GcCFtKGj+eAE4BQK1?=
 =?iso-8859-1?Q?+iY0qbs+ei8kDx9gkTG5Hkh0DvJRA6bc0Jk4RNBBQ+mtqCSJLQNgT5YZ0+?=
 =?iso-8859-1?Q?NjQzDGX2v5v1vkG6UfPCN+J5gZ1FNoH2zFQul+76Uhd3XtFqRkdSTv0aUa?=
 =?iso-8859-1?Q?uz5kH1fxGebgUCNlu7hbUeq8FZGYQgsFklVVu84ObFkgDI2U5gUIJFNFvz?=
 =?iso-8859-1?Q?+ADD4QgymbBWJzI8gFJiA/qtWSFWgWqFwm5SCB75iCDKt21CKsDPEr4u2w?=
 =?iso-8859-1?Q?NLlrYAL1bFX65jMELpIohbxXix2BqS0EfDNPygRLp/b836GWcOeQZzpUkO?=
 =?iso-8859-1?Q?Ggdmt44h+SDj7s5EahJPTdsCSil01Z4QQ7DGlqwcqQR4n1+M/ZqZsM//Cr?=
 =?iso-8859-1?Q?wwjYdubHrQGRJGWg58jZ65h73+lZ2HwsmA7oSu7I8bdmlEHIQlxuA8U/Nt?=
 =?iso-8859-1?Q?vBz0crhzOnqnqvctsILPffs8CCf3Xpl1D+yt2NivFXSHKem4wy+OsulvS9?=
 =?iso-8859-1?Q?L+qhJ14EKmEgOCBzxG2YpZCnlMa+QTMck+xKDP7pUBhj9GcSqhyEbi51U/?=
 =?iso-8859-1?Q?34I8cGYNN9j8Ek9s3SSWX0/PZmg9ArtsX9rRPcdKts1mUGMvMNYGMx5lBr?=
 =?iso-8859-1?Q?eIJnqyjwoZhDz7IB04NC5ZDCUBmrEa4Y1lRL9M/WTP01VzRQFoUZQg6bEj?=
 =?iso-8859-1?Q?JENSejBpp9ImU05haValAqe79X/v6pMKNz7/nL+xDmhXQNleoQkiw3Hr4/?=
 =?iso-8859-1?Q?uq0R49jCdX9QRpB41tzj7O4O+vVOeIK0sBHSkfxcccemT2/z8veNoX4mkp?=
 =?iso-8859-1?Q?bCftZO1jY1PA8uhEMuTbuOcpTEl7yjrr98zel52Vg5Lhy6aUfAYVoyeCR0?=
 =?iso-8859-1?Q?eB?=
x-ms-exchange-antispam-messagedata-1: cmgSYZVjjMDEX/YGcj6DE8NADZZOi6+Sa3c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a08e7dd7-40c5-4be9-25df-08da2cfbe879
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 11:56:07.4701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGhP8XyVxIdJAznl6uUYRDL7K1tGqZ9UxWRyDSYQo8lLlzU/C+dFm/3Wv1tXGmEZkV5Smhy/urCO65KIqq5Y8njcnCXM+hHU+la4cwc2RxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1604
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
Subject: [PATCH 79/92] iio: imu: mpu6050: Fix alignment for DMA safety =0A=
=A0=0A=
[CAUTION] This is EXTERNAL email. Do not click any links or open attachment=
s unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
____cacheline_aligned is an insufficient guarantee for non-coherent DMA=0A=
on platforms with 128 byte cachelines above L1.=A0 Switch to the updated=0A=
IIO_ALIGN definition.=0A=
=0A=
Fixes: 6b0cc5dce072 ("iio:imu:inv_mpu6050 Fix dma and ts alignment and data=
 leak issues.")=0A=
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 2 +-=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
index c6aa36ee966a..18bd1a50463c 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
@@ -203,7 +203,7 @@ struct inv_mpu6050_state {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s32 magn_raw_to_gauss[3];=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix magn_orient;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int suspended_sensors;=0A=
-=A0=A0=A0=A0=A0=A0 u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] ____cacheline_ali=
gned;=0A=
+=A0=A0=A0=A0=A0=A0 u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(IIO_ALI=
GN);=0A=
=A0};=0A=
=A0=0A=
=A0/*register and associated bit definition*/=0A=
-- =0A=
2.36.0=0A=
