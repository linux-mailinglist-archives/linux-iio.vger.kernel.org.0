Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E85183EB
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiECMJp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 08:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiECMJm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 08:09:42 -0400
X-Greylist: delayed 649 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 05:06:10 PDT
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE6637A14
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 05:06:09 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242LWc9N014910;
        Tue, 3 May 2022 11:55:10 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3frxfjse1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 11:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJH+qkj0S98ycKyPPVCoNZz4/9YTVrLt38bvgZl8Srm5a3dVAbPXP14/i92RJGM30WKt9/BqxYgKCVGU1+zY6/NrFuYdKbas25KXlqaxy+3P+2WQXSucyL6RbHUGBmMH3CHjkMzm5emxlbyPG0Hmp1uZ/UP4VKhhntfU+bivkPjuKKiRlGcR/HMJqWk1b9K+Szao0DBnv4W3ikNYBKWIU6wsllUsoizH5ObOddQoUGoonnzWoNf8axsMHSy01L5bw3Z8QxbEicciLj2s/p3Oh5Hm0xmKciDwIZ3tNjJr6S0IFgK8TMqlQ9CS98FLBM7NVeWoUKszR9oKI9Ault3YJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpCOlxYMlUixYr7+T+McFGdguJDlb9F69YDNv9eQQiw=;
 b=BTXaTXDG9f9FJERYe8gQWu1Xvvg+4UuZzi2JM1S3XlH6J7Kfk0g7v4am+r9xUOT7p0CDATe3G1nywZGWvCSNit9rejG72T1zEBhFUTy2CSWbqSTytvPVZgMdGYP6GrVfBR/CYJnrO2Osmu+xTEDkG0cojvMMk7nAKPly/98SyVu2DSE85WUu8GbQhmQR8YwMHoyMKHGbN65QWFfptm3BZk6+NIjyTOPqkDj2PNL6z8J718nis0Qej9A5u/kHqZF1IuCBlZQcYWuhzpz3cYz+ukU8CKz+SMdPdyLs9DYV8NpHU7phIU4Qm9WI+w6LDACEA6Szi2aB7EF7Wqi7YbCo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpCOlxYMlUixYr7+T+McFGdguJDlb9F69YDNv9eQQiw=;
 b=NK79VzH2MslKUGqsxhw+4vIjSSIlr7K1bKjKreL6aqyhn5I/yhfb2EzJAEbNjKqAvLjBkwTkn0rmF5YzIXXwtYs1LQaQnoXSVDVJr7cCTLLovyeTrzHjd1SkZ1hXxuNmsv62hhy3faDyVtLVozJ7RvAxVLzCNjSMF4r9nMQJ9Nr989Y1hT02gmgjWX/EOt+nVCk9HxMvylbTzX07YipWCCUSmIQWC245Qtsy0eJH9ldIJFfeg0rZkItYzgHLkkT/Mn9MuYSs2IDcaw0xMcaqwBlu3bfu76OgdIr8mFkl6rMIIf7jVZQpRq11mN1ceUUGrHT3R81KUpTM6AlC7Z+JgA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB1808.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6; Tue, 3 May
 2022 11:55:07 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d8c3:e47a:8c09:c8a8]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d8c3:e47a:8c09:c8a8%6]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 11:55:07 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 78/92] iio: imu: icm42600: Fix alignment for DMA safety in
 buffer code.
Thread-Topic: [PATCH 78/92] iio: imu: icm42600: Fix alignment for DMA safety
 in buffer code.
Thread-Index: AQHYXsy9aSO890ZU20K+APPNrDyPaK0NC0JN
Date:   Tue, 3 May 2022 11:55:07 +0000
Message-ID: <FR3P281MB17573BBB2251A41C2DC1ECBACEC09@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-79-jic23@kernel.org>
In-Reply-To: <20220503085935.1533814-79-jic23@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 6b22cdfa-ba76-0b3d-7790-c33f2039404b
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c272719-ce61-4928-110f-08da2cfbc4df
x-ms-traffictypediagnostic: FR0P281MB1808:EE_
x-microsoft-antispam-prvs: <FR0P281MB1808C5B6C34F5985F5955774CEC09@FR0P281MB1808.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t2fz8hmo86/SB484eFuWq0QeTQ4DT5wjAWpNRCMUq97Aghd109qBgiXJjVma6RBxf/M4A64tT+alXpVMmkO5MN70InC91NupCiKfhIgqRK0vBu2d2R+YTUNA7G6YesTJo81sj5e3ah3hir/6wjZB8H1ydICEt6THFhHz11oG/DiVoIUZ7DsqcU1qXrtBC7BFAYvVO5RA6S0F3A1+ROcD+fh6CgOcx3x53hKESHcdvzzGqpABFx5axrijJJ2GhN5kq+GgpJnywx3mwiT6E3yEGfCOfdjjTG/KP6Xwkk7LE+KgvoVKZHSv3mryBYLFGbxhClV+KD1yEgBxjrrnmi2X/GOIXUXy0jKfzqIYkkm93WLw2l06P5UamxXyQkuIWELyJ0nGZjLWhkx7cFz3Jw5BMkEbgz7f5a3eNumbdqqwkEe4nOPWMudXsUFrdXBfyM1fRgt6EL/gtNFEE7ClNRxZcccHuiYuX122baCE19LjTTCuHLKbwXZsIx4LmYNIq7eHYbcYG1nhGUDAv/UrE2/0p6xSzgqhRAP8+24low7j8WaHImSB/MzzY4lqgVrMzPBRvDPjWWud4kj5I/q6f40MGo2kKebFcGU0LL2/DndHTTJY+39qSIlqOin5rQYuRKJnhE+fgeAWLtOgI+oB8q8R4TIB/vOo7UzjtabL8JnWK8N5Xhf6W8EaaEI8tgaKALrIZ+DeSy6XiHKjdbB2Le2Tpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(66556008)(8676002)(508600001)(83380400001)(186003)(66476007)(66446008)(76116006)(66946007)(66574015)(5660300002)(52536014)(7696005)(8936002)(91956017)(33656002)(38100700002)(86362001)(38070700005)(55016003)(71200400001)(110136005)(2906002)(9686003)(6506007)(53546011)(122000001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Fih5o7njvN8U72zMOM1TGvqamxx2071QNM1sXsePLwBy4uhlUaIqv5PMyI?=
 =?iso-8859-1?Q?Ud4iw8kBz3rd6oz8ipFxVylP24QqClufEsaPa2b2lNTVzlVCRXuaUrGnSo?=
 =?iso-8859-1?Q?dn9raN9HtioieTYjpOx0R1edLJX7Gt3zTaYD+RyW71HVoJwMAxgERQ0hAD?=
 =?iso-8859-1?Q?7qJr8YGUZ4J2eL9xbYUsQdZDpUeFfrQU7HbchzfOKpKzrpv5G1aLCX3sAS?=
 =?iso-8859-1?Q?EWSkm2uRBUD8Gb0zxSswVQbR90JdkctltY/WCc+vVGq8q8fMMYVny/8zNs?=
 =?iso-8859-1?Q?QqDIEDx4z2fcZIMFM7KPL3dyltkJErX457TizTMuGdndSL2coMntnjg/DK?=
 =?iso-8859-1?Q?OZLh54LrAu1AXM0VrptQmjsIjpPiSBN7R60PnxdCLftsrag/Ml/VgASFPA?=
 =?iso-8859-1?Q?T8iCNSK7f2cdMalxhbNa55YXbXf0O12pQy0S4yBrEii8cwSAvbcMOUucwS?=
 =?iso-8859-1?Q?907QLVLSVjtO4u1y3ZLYp8lBqDjNaVEfGt9K5D++f14qHcmxAKM4b/oycn?=
 =?iso-8859-1?Q?OKmD36s/9kvSN5TfM14CRmkHZRS/k9WTGZ2GS8ff57+GnY/RIfbwOacClq?=
 =?iso-8859-1?Q?Z2S58SDOYFyxVx0U6tPRdilLyNV6ANekZAHusA+nwCZZ2EHpkV9NsZwrh1?=
 =?iso-8859-1?Q?dzK/VNboEorCyxrR8n8ZNCTB1E5ukJHLR380O9A/pdwt8tAlaxK2f3/WmA?=
 =?iso-8859-1?Q?/HSc6LfckhVogOKi+StRLIbM7l8xCKRQTLPPlfskDn04XxVBXL/f3f2FcT?=
 =?iso-8859-1?Q?XrsncC7fHU/4TmTgYymdxr0xnTK3yN6Iw7doJ3fUDVjv0oHvxLInJtU+mg?=
 =?iso-8859-1?Q?MZXv2YRc98ves5M9oM2LzmlYocGYodo5uLTxUZg5bjdtzjMTmEq4mK6CIO?=
 =?iso-8859-1?Q?fhSYD5U9lt+UaMqYd6bqhJ/oIlkoWmcysbIfmFUTifk3IJEhTOM4JrpBEb?=
 =?iso-8859-1?Q?tJmMo2ZBhfQ3/SZ5J+i28B3g7yhAZKTXUv6W45UG6dbVGk5coMGiwSiIID?=
 =?iso-8859-1?Q?JpLzwN5PahtXCE5dB9aFnn7xmNBpLlez4n6kAUqXOC7YjxHY6pzL64ibgo?=
 =?iso-8859-1?Q?PrlXoxJkB5EFclJ91c2KCkwFVoN7P8hTdNj7ZOwym9fQjFEtwrSdLNKKT/?=
 =?iso-8859-1?Q?xLQWsoDWMDpC+boJ1eFG4h1E7xTLxHpC19j44gKXyxlNIiVtVtKapIA8EI?=
 =?iso-8859-1?Q?yAqSYH1bOMWVVB/zV4dJUBLz0Ef+2jIDzHPuW6xf7W9A5iJE33zeB2TPsA?=
 =?iso-8859-1?Q?uh+W36Cf7ajGsUyJOEpnpRLJSzLInqhDsSNqrqvBi00ZTh8KNmQ51ACiha?=
 =?iso-8859-1?Q?cARKy5nKua98aw3c8HsDBkTF2qeSyKUZ0ty+cIiwRD1BaK0CP99v04ac0n?=
 =?iso-8859-1?Q?92MywE9eZhFORyfojZ4wX3KIpmOTcZq9SDqOofNGuSxaMrLxABnINRXQWr?=
 =?iso-8859-1?Q?EwAek84x6M0phJUrk755dVj4R5BI2Svvn3SOtdYnzcjiFpQLX2r3wRy556?=
 =?iso-8859-1?Q?kTP12PR/MSeTHfCmR+Us8hsu2l7Xucy+exCyct3+UgBmqDuiy0GJ5GroPK?=
 =?iso-8859-1?Q?aAgVYZOUaj/bugokogAI0Yvn75HMUtgzTR0/+2aKndKyzi/Xp5PmbPrZ8e?=
 =?iso-8859-1?Q?+bWr/cFQnbY+vek27/6kyTLolHCznkkuL4sEJc+eSHqarH8Vonz6G5iiWx?=
 =?iso-8859-1?Q?JUy4CJ2stYiNOOUG9UmnjwSSABqyqTqjJj58m/0nidDNSbZ14cf7PpVPqy?=
 =?iso-8859-1?Q?FPYl65sKuvFvB4ShAcjtBTfnr9coYWgYRilPRSjoHTSqEI5LL5XjWTsxZ2?=
 =?iso-8859-1?Q?riUR4MyrAgnxCOd9S06eQI5YRGNX5JoCqJKlsRTnSGhVeiFJEZWadRwo3X?=
 =?iso-8859-1?Q?fF?=
x-ms-exchange-antispam-messagedata-1: GRExfTWF+tTuyZHDTobjydxH+40pD6ZvOYA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c272719-ce61-4928-110f-08da2cfbc4df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 11:55:07.7400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7geBn24BX1Bj9IXQQKnky0NjWXquraxOMxBAH9OGLESnovBsJzb7c/U8BuBgpQAZjHMMur+/sO9CVOeBwPu5n46PCgnh7SBQpBox0NDBHiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1808
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
Subject: [PATCH 78/92] iio: imu: icm42600: Fix alignment for DMA safety in =
buffer code. =0A=
=A0=0A=
[CAUTION] This is EXTERNAL email. Do not click any links or open attachment=
s unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
Second fix for this driver due to different introducing patches.=0A=
=0A=
____cacheline_aligned is an insufficient guarantee for non-coherent DMA=0A=
on platforms with 128 byte cachelines above L1.=A0 Switch to the updated=0A=
IIO_ALIGN definition.=0A=
=0A=
Fixes: 7f85e42a6c54 ("iio: imu: inv_icm42600: add buffer support in iio dev=
ices")=0A=
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
---=0A=
=A0drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h | 2 +-=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_buffer.h=0A=
index de2a3949dcc7..56545638bfcd 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h=0A=
@@ -39,7 +39,7 @@ struct inv_icm42600_fifo {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t accel;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t total;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 } nb;=0A=
-=A0=A0=A0=A0=A0=A0 uint8_t data[2080] ____cacheline_aligned;=0A=
+=A0=A0=A0=A0=A0=A0 uint8_t data[2080] __aligned(IIO_ALIGN);=0A=
=A0};=0A=
=A0=0A=
=A0/* FIFO data packet */=0A=
-- =0A=
2.36.0=0A=
