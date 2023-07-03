Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC9745FAB
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jul 2023 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjGCPUe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jul 2023 11:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCPUd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jul 2023 11:20:33 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF079FD
        for <linux-iio@vger.kernel.org>; Mon,  3 Jul 2023 08:20:30 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3638pVnj011429;
        Mon, 3 Jul 2023 15:20:08 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2168.outbound.protection.outlook.com [104.47.7.168])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3rjagvhap3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 15:20:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PstFpwIlesLAxkqNXObLHLi43S8qh37f84kfz0ZXTRy/PvzAjFGIa9j4/ilfdQ4WeAqSWlHkzXnfBvSw7pZh1SEgiuCjH7bpfa9dblXAaID/pCk9J31mfYhoKHgI1K6+8VJVv/HzZeYVJMy6BqJWC+SCNMjo0l+Q5uy3S1HmB5pFEz1Y/9DBw+GRF+HkcRU1K1daR7iLipB9iykG1m3axTE8dtY5+EeLyDQFPnEinlWoc+ELssUSB+SbRu2TuVdEEzeqyucX7C7jE17BIiDg8bvKI3Q6W6n5sWsk2njsritZJ+h05j/0g4QzFo4sxen5Pss96b2YLjOGMugBpPLbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY6frALCOpzh45oFPRfQfsshwAf9Ct3+0KLdNQQeqi0=;
 b=hWPdQDrw79l70xthWTQpo2WGsozMdoSLhGk9BqW2GkPqt+puOQ3lhRcWmfBHwQO7OT7dcrL7Zh99TuWO1+Oz8M9zUmdbiSZd7VYrUfTjCA4S+w5QRkjYNCAnf8P/fS4+kCX17Qf0X6lasqycBRAc4xK7GMOugcggNulW2GDBataaK/AyW8gCRxbaH1nl8E8WXEEAzOonYmuxBHjRUWOBvd2hpDKTC6mnrmSte2yg0koa11TZE14c9I/2VaWHD1peAkpKn37fL51rQOdha02AYWETs7x4odA1n1VuEe7zg4s7U2TJeedXY7NYzGZQ6xyr/vVDTE/jvPHhohEsEpD/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY6frALCOpzh45oFPRfQfsshwAf9Ct3+0KLdNQQeqi0=;
 b=NzKAhaeJluCOzLFHKmqGHDYsThK2Klwjy85YmRmEgBWpYc3ED8+gLFWyiNLtd1bSg+IZBn2tfH95n3eBX2mxNvFFiF7vNW1Wls0kYvXMCTOCNzwn6UgNKE10F7ttlNForolRL+0iQS4rAthEdxVuuAY16SVOQcnK3r72h05lJNEt+qWNGq/7Gz5TkyDcBkTVS+UzxNYXXq3BEIwvogzkLaIvI390BVIk6fzfZb8bSdYkfrlLkmdqi5sUUKDccHmgVBlDPMlDDP3LDuOpW3b5kORKnGgNndEHcE4ZDbv+OXqh/LHTJYinHdcejwwN8cCT3+quEXdTDEmAyj+h4Fjmyw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR3P281MB1710.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:19:53 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c434:2e16:6b03:478d]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c434:2e16:6b03:478d%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:19:52 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: read the full fifo when processing
 data
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: read the full fifo when
 processing data
Thread-Index: AQHZpaziK6Bw9XjC/UeEkbnbaxfoaK+oOBWq
Date:   Mon, 3 Jul 2023 15:19:52 +0000
Message-ID: <FR3P281MB175727439E7D09F88E44C421CE29A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230623082924.283967-1-inv.git-commit@tdk.com>
In-Reply-To: <20230623082924.283967-1-inv.git-commit@tdk.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR3P281MB1710:EE_
x-ms-office365-filtering-correlation-id: 08cb1523-481e-4757-045f-08db7bd8f2df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OsJQJs5aoDDHqd9DeU8gbNUvEI2HnCi8+3lIRx08hWJlUFfVXyneYQlTDuQNTZwwZ1a5rxsLJz00BLtb/iJY6cQ28bdu2/spGIpfIePaZWwk8GkPtDG8vEMmfSv4bBQQ9BObBqWWlkDGR7sMeyL8tLS5op4Kq7Ugpmeomi/sMIczfb7gUCCJPFqvhEeMdS9um507Zwx6ON+BO6ru3AdLExRJUB8gbPxMG8R90r5Rwhdwi9StLNlMtAk96KYj7djf2Mgd4s7kj7bbvGoKmifZo/+1+nVJ+sDozCUTQTtPF8usHp3HrbnXqKPrV1jFSxgDa404e+FUu7b5ol+hCU/b/FIw1L/lkTEr9viKCBI0jPb9yACds04n3tYazCubg1yNHm3rtWw4esI5zhJCnMNjINAmayxqdeQP9CWaXsuTKp8O86K3n/6h/cDxurOR749w2BLTB2JZzpxUzx2fjd9zww7bzqwv/KfPEsvrnZClFuIjkLB3GhitbYzTi1q6FVpXObyJ/KOwNk1xE4dCBbmtFiqqldTLrB2YnAWgEVGavK1Be/dRgYoTikTp5FxnVnAcsitWzcsOKSQ+sK9POL/8e1QhcvKPYbsrgON5drVny6f1lYeGFopb6rcXaAPinbqCmDCHnoa4JSdttwhiWb8y2pDpXxkhwMjb3pM0CTpj6QA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(26005)(478600001)(71200400001)(9686003)(6506007)(86362001)(186003)(54906003)(38100700002)(66446008)(6916009)(64756008)(66946007)(66556008)(4326008)(66476007)(83380400001)(91956017)(7696005)(53546011)(76116006)(316002)(122000001)(5660300002)(8676002)(8936002)(52536014)(38070700005)(41300700001)(2906002)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tldJ2bxNnGQBYSN0mLDXjW+WqasDwLt7faDihWnvRfqo66MEX7lJ42HXQs?=
 =?iso-8859-1?Q?GZE8ape2shHVBngQ6JKF6SsI1kq9FSrxlg6MMAKL7EXVa2j/arBkozPNTP?=
 =?iso-8859-1?Q?EvNKBk4cVGuqaZpdM3BbdMqHt4OnfstGf9R2H7zp2Hk7+CkGt+556UHg9Z?=
 =?iso-8859-1?Q?aMkT7qe0pSezJYI+V7IqXRz5b1b64kV2gzuJY1OWWKYyYoIkefnIxMyaOb?=
 =?iso-8859-1?Q?3svXop4E0t2ZSSg/UXgJKE1GnZFQeISUWd4hSlue/Yp2EB3m5ASQskqDbM?=
 =?iso-8859-1?Q?LLaOCPPvQeD+sNLGXcohBAVqWg/xptLe5vrEfJUsj6jkk7UPjiORfxCpGI?=
 =?iso-8859-1?Q?4qhCzgavo5wv34uqJy8aA6qRtEN1C0MZ2YQ/D93NvnNzGMXnbfvE7zgqlN?=
 =?iso-8859-1?Q?VO+U++QIbOPJp0xPfNqDV3HKjodptSazLf5p8cM25oNr9nuA/XShdsV6iD?=
 =?iso-8859-1?Q?LV9K7SntYMXFrFXxUw1Gm5q+BQE9MlNPLQYBpJ5q9nIRGcq7ikQuvRXKzk?=
 =?iso-8859-1?Q?I9YHNg/Sv4ByAbeKrr747PZa5h/2rdMHy3oNm2mOE28ZPmhxH7rSaznJCh?=
 =?iso-8859-1?Q?Ox8qQ0FQszTOe3Z2I+Fa4/90l4KWFdgYmbDIUavKbEhOjZaXdPnXwGzEau?=
 =?iso-8859-1?Q?XOy/ywjDtQCsmZEavAxv/feFD0926wdVQfIdDE89poEmw/6dyKIdWyRe8o?=
 =?iso-8859-1?Q?t8cOKx9ny7gUOArhxCiWrCLzeAhyyYNLqCqxhBjYVGAy6Ie7uYzzz8cc/G?=
 =?iso-8859-1?Q?dSGE5rU5p/gWwCV0wOcqfq1g5yYdBidvTYtkfolbW4AeUMerApnfx07P1o?=
 =?iso-8859-1?Q?gofm4apgi4u+UlwHIZbHfNdGjdH1r/OlpvQxXzGbs8cmH9HQzJVt7wlXiP?=
 =?iso-8859-1?Q?TJp2l+C6Dmt5bG1hDHhHr24FB1tNQO6+ekyeMkEaQ3TinA50FJFlxyJRPs?=
 =?iso-8859-1?Q?ktth/Qf7wRdsz3okkaSNaC2iVMVddvlOPCsdJ+JY0FdoVIMscy+2cmAo0t?=
 =?iso-8859-1?Q?XGbM1UWJypIG2h3KcS7MSQl8VIhAl2ypobfecpO1uSh3QVVzPbo+u78HRt?=
 =?iso-8859-1?Q?zhxT/dW5r8LvGY+cuTtxH7zTlLS1DkOjISxaBwl8VykjWHkKFE5haDn8w2?=
 =?iso-8859-1?Q?Sl+BobbXlqIo1Ego1YgXn7QM4XykP2hicrNzo1kk5R6tf2VTzuXxTjSPRz?=
 =?iso-8859-1?Q?ILCJp9kfFbdg2kFICHF5e3VWBgxGC+DHV4AhNZu2/DFwOZ1zUWQ1Bn+CtL?=
 =?iso-8859-1?Q?I1UR7hT0fdLmKEsV9yBT5wAqkxBMEV2Qh77YjBoVnw3KghMCp/mpgUDjNe?=
 =?iso-8859-1?Q?ri+PAxz9+GJ/naOPCODgd8TDbBo/9UzerBEaBRQLlo4aw2z1/TerBpQo8o?=
 =?iso-8859-1?Q?hnsogIyO5VBskIOdG8PVBWgIKaRIXwNeyO6BRGEIezl9AlDKjohO13bDMy?=
 =?iso-8859-1?Q?PoUJS/ARYpyNNIYLwENBKgJg8/oY+OGpyUIj6KZ5nYtyJePhZayWJerzQ4?=
 =?iso-8859-1?Q?cj53aoQDkdENNnqOIQgsGpGg0TOMjllKftSC+QW7bRtco0HvPRIASKdCIH?=
 =?iso-8859-1?Q?jDvaA/Lyi0z69orSkxOdaNGcdFrMx/a0GPS3v+7qv0uSZXLOqnykG15U2U?=
 =?iso-8859-1?Q?44bx8Xi998VqSOOTS45wMk8vC4tWhsSFJr37hZTNhmSJXfoZMCPcQP+g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cb1523-481e-4757-045f-08db7bd8f2df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 15:19:52.0611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sb921/G8Ls9fDXwOIXvwMDec8mqkA+xRIrHRCkVNqCrU2SxGQmqLXX9cPv/4kMBXVnktDE6hKp+K4c2+AWXeMrHW5tyx9Okg6ocrIeBWCNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
any news about this patch?=0A=
=0A=
Thanks for your feedback,=0A=
JB=0A=
=0A=
=0A=
From: INV Git Commit <INV.git-commit@tdk.com>=0A=
Sent: Friday, June 23, 2023 10:29=0A=
To: jic23@kernel.org <jic23@kernel.org>=0A=
Cc: lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio=
@vger.kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=
=0A=
Subject: [PATCH] iio: imu: inv_mpu6050: read the full fifo when processing =
data =0A=
=A0=0A=
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
When processing data read the full fifo data in 1 time. If there=0A=
are several samples in the FIFO, it means we are experiencing=0A=
system delay. In this case, it is better to read all data with 1=0A=
bus access than to add additional latency by doing several ones.=0A=
=0A=
This requires to use a bigger buffer depending on chip FIFO size=0A=
and do an additional local data copy before sending. But the cost=0A=
is minimal and behavior is still better like this under system=0A=
heavy load.=0A=
=0A=
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |=A0 3 +++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 |=A0 4 ++--=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 19 +++++++++++++------=0A=
=A03 files changed, 18 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 13086b569b90..29f906c884bd 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -1345,6 +1345,9 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
0_state *st)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 st->reg =3D hw_info[st->chip_type].reg;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&st->chip_config, hw_info[st->chip_type].co=
nfig,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(st->chip_config));=0A=
+=A0=A0=A0=A0=A0=A0 st->data =3D devm_kzalloc(regmap_get_device(st->map), s=
t->hw->fifo_size, GFP_KERNEL);=0A=
+=A0=A0=A0=A0=A0=A0 if (st->data =3D=3D NULL)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /* check chip self-identification */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_read(st->map, INV_MPU6050_REG_WH=
OAMI, &regval);=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
index a51d103a57ca..ed5a96e78df0 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
@@ -179,7 +179,7 @@ struct inv_mpu6050_hw {=0A=
=A0 *=A0 @magn_raw_to_gauss:=A0=A0=A0=A0=A0=A0=A0 coefficient to convert ma=
g raw value to Gauss.=0A=
=A0 *=A0 @magn_orient:=A0=A0=A0=A0=A0=A0 magnetometer sensor chip orientati=
on if available.=0A=
=A0 *=A0 @suspended_sensors:=A0=A0=A0=A0=A0=A0=A0 sensors mask of sensors t=
urned off for suspend=0A=
- *=A0 @data:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma safe buffer used for =
bulk reads.=0A=
+ *=A0 @data:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 read buffer used for bulk=
 reads.=0A=
=A0 */=0A=
=A0struct inv_mpu6050_state {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
@@ -203,7 +203,7 @@ struct inv_mpu6050_state {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s32 magn_raw_to_gauss[3];=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix magn_orient;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int suspended_sensors;=0A=
-=A0=A0=A0=A0=A0=A0 u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(IIO_DMA=
_MINALIGN);=0A=
+=A0=A0=A0=A0=A0=A0 u8 *data;=0A=
=A0};=0A=
=A0=0A=
=A0/*register and associated bit definition*/=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_ring.c=0A=
index d83f61a99504..66d4ba088e70 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
@@ -52,6 +52,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 u16 fifo_count;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 u32 fifo_period;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s64 timestamp;=0A=
+=A0=A0=A0=A0=A0=A0 u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int int_status;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 size_t i, nb;=0A=
=A0=0A=
@@ -105,24 +106,30 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto flush_fifo;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 /* compute and process all complete datum */=0A=
+=A0=A0=A0=A0=A0=A0 /* compute and process only all complete datum */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 nb =3D fifo_count / bytes_per_datum;=0A=
+=A0=A0=A0=A0=A0=A0 fifo_count =3D nb * bytes_per_datum;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /* Each FIFO data contains all sensors, so same nu=
mber for FIFO and sensor data */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 fifo_period =3D NSEC_PER_SEC / INV_MPU6050_DIVIDER=
_TO_FIFO_RATE(st->chip_config.divider);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_interrupt(&st->timestamp, fi=
fo_period, nb, nb, pf->timestamp);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 inv_sensors_timestamp_apply_odr(&st->timestamp, fi=
fo_period, nb, 0);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* clear internal data buffer for avoiding kernel data =
leak */=0A=
+=A0=A0=A0=A0=A0=A0 memset(data, 0, sizeof(data));=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* read all data once and process every samples */=0A=
+=A0=A0=A0=A0=A0=A0 result =3D regmap_noinc_read(st->map, st->reg->fifo_r_w=
, st->data, fifo_count);=0A=
+=A0=A0=A0=A0=A0=A0 if (result)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto flush_fifo;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < nb; ++i) {=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_noinc_read(st=
->map, st->reg->fifo_r_w,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->data, bytes_per_dat=
um);=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto fl=
ush_fifo;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* skip first samples if n=
eeded */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st->skip_samples) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
->skip_samples--;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 co=
ntinue;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(data, &st->data[i * byte=
s_per_datum], bytes_per_datum);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 timestamp =3D inv_sensors_=
timestamp_pop(&st->timestamp);=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timest=
amp(indio_dev, st->data, timestamp);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timest=
amp(indio_dev, data, timestamp);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
=A0end_session:=0A=
-- =0A=
2.34.1=0A=
