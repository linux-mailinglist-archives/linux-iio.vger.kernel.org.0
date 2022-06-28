Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1E55D90C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245245AbiF1I22 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 04:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbiF1I2K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 04:28:10 -0400
X-Greylist: delayed 1396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 01:28:06 PDT
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B2719B
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 01:28:06 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S7oUrk011702;
        Tue, 28 Jun 2022 08:04:27 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3gwrqxhybr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 08:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJoz/NnaiFSQJKWgy5quD39OKFc0VzxT8eZUd7U8mGtk+57LCeLMDatIfOcP2nqfkwpn4u4VbfvTOtpEHIjdPbBtCK9vzs2Hgu9nIcm6aI/iDk7wxbE86AZMBxcmjpMGvfZXbIw6Nt0RpByd9gyLmF28jDAwWXfYLWp9TxilGcf7/2q1rTsAcbQZjIFAd7aTxk8Xj5K8MF6ivMdaSOZikILAPIkwCjdHxqTKQbDs3kLDoxGxTyyZOyBisKSb6ikDLptKjmv16luPqEOj1mFqWDItGrCoBSIlBtbjcf3HVyHvyzQJgBUPds8fuKIDneo4lyWCiKjIWIv3gZ7UjeLyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8WeyQT+ymaXrhIZx51aiVO4/R63x7BbqVaUd4H54dE=;
 b=HskxyAWWiuYYFMzMvRuw8aAZUCxb/kUEb7uMDkc90dqFpiMsW9Od0hscR7KaGikdGT6nPUZfSMGNvOFF/ea/DeR5BbFn3zqdQz+IhiJ1FLpn0HLyH1lJYRfzlIG07eW4twfzv8LHkXTDc2H8esvpLBM58P9We6bKkb8pG0Zu+gSIlZW9L3huK7pg6i/CmwEqmTOl4PFCwSvWxsC8CAiGv2Aa9OWEmr39kKhEUfkgmh9jYk1IkaZV15wkHE9hOMvSSpy+POeyMkXsBSfkNKAJU/pbvY+evDmJ5eW5MOhRK2kyEFnO0/Ci+vlhZwm1bXQ8MhY7b9We2wreD6P6X4PUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8WeyQT+ymaXrhIZx51aiVO4/R63x7BbqVaUd4H54dE=;
 b=dLM6wIs7Ad46cmKtkqM+uwjDKDWN3uxzdCvL/VfKRMd3scSRYfkCmura0SEvikl2irCLNtl2k/9ZUbyHzaAF1/0REEbE4oik035MJN66e3qCDA+IFZfcvQArQz+nc7t0MP779ost/Di804WGygTos3T9xwjogvAE92AwmnXAg0Ll8ebPYz1NSOhACM3RVvFTYvjQzTEnjqqhUvGEapvWZglKpt+L0ce7Zv46QIiupCI4a5FyBDKt8013aNl3915nr/k+g91v6ScU6exFq9WQvG+LLTlRYU0+8qC3zUKAq5rysBW1gYRlvhp08LFNYyCg61WeDxjfGPlHkRrqVtuFMA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE0P281MB0084.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 28 Jun
 2022 08:04:22 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cd7b:c669:352c:794b]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cd7b:c669:352c:794b%7]) with mapi id 15.20.5395.013; Tue, 28 Jun 2022
 08:04:22 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Fawzi Khaber <Fawzi.Khaber@tdk.com>
Subject: Re: [PATCH] iio: fix iio_format_avail_range() printing for none
 IIO_VAL_INT
Thread-Topic: [PATCH] iio: fix iio_format_avail_range() printing for none
 IIO_VAL_INT
Thread-Index: AQHYilz5kgKs7rkvaUmLXV8gK9cwGa1jz5wAgACmBpY=
Date:   Tue, 28 Jun 2022 08:04:22 +0000
Message-ID: <FR3P281MB17575557B80A58F95ED87018CEB89@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20220627193402.21553-1-jmaneyrol@invensense.com>
 <fde8b70b-a8c8-3e70-b55d-beede2bd7040@metafoo.de>
In-Reply-To: <fde8b70b-a8c8-3e70-b55d-beede2bd7040@metafoo.de>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 935a61ca-14cc-30a0-a0ae-aa4521feebea
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0b1d193-966e-44d0-3b20-08da58dccfd6
x-ms-traffictypediagnostic: BE0P281MB0084:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iL+zLRUpAHvzckaAjTlkpQQKbREu2akNKBnEmLWG+/TF1WoLfiBbQImqumZ2wfb/ntwxb0H7lCmKUKpYEpboDgPQDpu7fCXi5Z2Gry2Otb3Y5DWb9Dca37DXlgqvs/MQsldF5a3i0F2QliEc71QsiHSv0cgOu7NUlAuUsIychsiWBikkb5M2NxmQ/ogzW4ouYy4ZpmAutB6sBxYsffBR2ltee+dAgEAwropUFD/jhPAgQnlpXIDV6ci17RPRItXVrn2R7HWuPkoxUZhP6PQzqF4p56bcPKugqVZccetYFn9/L59V+yApADxdshcgquwj9fE7qyF4JKM0WaAog/SSK5gE6Cc9hsGM/w8t6zxp/SUp9GeyEuxvatXPa7pDfdAWTnQPMfLCAOscF8kaTIMIDTMTNZN5IXES0CEt5XMIk7Y85DCZU74Jtvx1mjJYbWytYTPla7idbaow2am47ZqVN/p0reJ1nUSuX1cquEZTsj8qDXBCT8PsuaNb57a/nV9VDe7/hQ4FdoGQDvGmCZsCSIieGuZgEKwtI1JihDmcv7BthknG2P3VByTtwWAaknNO0q32PbdAvUv71nbm2EHTa0v2z3jN2PmYRPG3AqIrd/JLt9nLUT48oX74ZZM3UbiTk7bIikfE+C6HCN3GZQRUMwZuszq/EoYPPGsLL57Ozqhokt/gcAaFno3R5h7lDwtBseWG8LEwxpGfiXHAgx5tAqYBAMVX5Ev6rZlJQ+h3Iz4xBMJYKkHu3gF9SQ0ffRosqDJU4q0LFGk52wGBJYcPpfMdX3wxxzmrLWJiNYo8BOE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(71200400001)(4326008)(54906003)(8676002)(41300700001)(33656002)(110136005)(38070700005)(9686003)(64756008)(7696005)(86362001)(53546011)(66946007)(66556008)(66476007)(316002)(5660300002)(186003)(66446008)(26005)(91956017)(38100700002)(76116006)(52536014)(2906002)(55016003)(83380400001)(478600001)(8936002)(122000001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8Dei6BWi9bg3LP3lKEdfM7CzXvINSrOw2tNRsx4unbMoOCHB+rrHaCxB81?=
 =?iso-8859-1?Q?PNTqWNJPZDy/KKnkJgkr3GhVkpgvWAWz9Umg9PLynYRj4flW3WXqfPmbu1?=
 =?iso-8859-1?Q?xYah/kxUivv6c+VQyPjODQSeJhoL8ZlGpN95KZAlqPv8y4S/rx3JlNP4B4?=
 =?iso-8859-1?Q?Ali1Xy0AYXpqNkOy0z3a74vTnMQawaz8o8bJCyUVXn+ak3Q95iKnVgT5bY?=
 =?iso-8859-1?Q?CK23ZkWkohqp47Hb6oYBAJLJN86a0zb8z4HCVg3VkgkgCcIbF8UioKekjZ?=
 =?iso-8859-1?Q?aRdDg4e/1boYHnGH/PRDbLlQGKcIlwo7podiPIKeZo2qLmEAyeCSr4QIWO?=
 =?iso-8859-1?Q?VyQKSlFY0PIOu6bMt1OtGeTmLpa+yuzW2/eB61Dday4O2p7G9x9nE8o58X?=
 =?iso-8859-1?Q?cmxr894We8kyWcimDNi4kNzbF8Jc2kHqW2qUWgxrRJajAA5tlAqOqGFgCS?=
 =?iso-8859-1?Q?J46XcjAYzFxghbobeAnQDNETEO/l5GR5aVtE+CBzZRoETPpyHQb3tWc7D0?=
 =?iso-8859-1?Q?+iJIsrM8L66fBLKd9kFnkx0cZ489IppEtysOpHVVmoHqKrlc50ulwndILH?=
 =?iso-8859-1?Q?Sza9UCDpvW6jwqdNdjxlJHXSYR1tMgP+rnhdZBK8ueGt8WAIakJJwSKLio?=
 =?iso-8859-1?Q?MyhENOpWnmR34H+Pn80LekOlMp8Gr7ZoePn/SWakksxXrHSUsVMJgGw9Lc?=
 =?iso-8859-1?Q?JuOjIvLitOc7t3f/pjIt4VgfIvMqUF8+TNF7lAZgOeRS9Xz9fPcC7HYd0v?=
 =?iso-8859-1?Q?5lpgXq0Fk+G4vGUr5C+FyDDkbx3IMKXLXNUlS3PBR8t6/0z3BgUVqyC2SS?=
 =?iso-8859-1?Q?Bps/oR91GHYVaVgxMHDz0Ek3QZa2IpyRR+4kwmUGPOUNPRlwsgrWHXVrDb?=
 =?iso-8859-1?Q?8XTDyz2qJAI8xKcKDYTwTZMxkcUR3LkwjshiqaxKyBNqhKpoE+mjpTBdC1?=
 =?iso-8859-1?Q?1mddEve0PU4A8yc1Df/f9E8DcQk4w6SN9sXRIhvVoksWoy+h2vyJaAGDoq?=
 =?iso-8859-1?Q?OA2T9OpJcy6qeASjWHzy8hc2C8uswfS4c6ykf+085OikISME2TgbHBpeZT?=
 =?iso-8859-1?Q?qJMCbO+Ka9jpPu0bN/2ukJHdWuzln2X2xGter057uwABw5lrqJUsTTqgFr?=
 =?iso-8859-1?Q?vVuxDWNdqICp1Wrw0MVdduZZx0VNS2E2Xy+8LLfNH2dI4PlLrWhiNe0d7b?=
 =?iso-8859-1?Q?LuHscvPrhmPGwXe856eDZUIc59/I4FRUVtYz4ICXAVLCz1TnXvh9mT8sGg?=
 =?iso-8859-1?Q?oi6r+G9UD7/REAiMnkX8fwOz5kxIFvYdPjuKF+LCZ5TDukbvaLx+b1YnnR?=
 =?iso-8859-1?Q?wUWBKm2hv49M7kKVUkNjuis8agFT7QdQBJJqgxCWmqnDd9y+4/j4/OqT13?=
 =?iso-8859-1?Q?UrNN2a+sLj/vSSIE6WLbfJZcYyvjy/kfwBlKn8Ej/x3W3UNld6+J5LBcql?=
 =?iso-8859-1?Q?j2gNNXGt4IOHT08cihIhH36g1aDAK8Eo7e+3v9NJUWDG4AW0orsytOT+wL?=
 =?iso-8859-1?Q?x+NBj9eOnZtipSsEfszQIpLCf1B9TQw5mLzpthmjp5YFZxqPQKm/govcT+?=
 =?iso-8859-1?Q?LusXruFTIo5ps56YzaZFU6Ka7WlAwrgE+OyThewVroBaOzPRqTejAPxXaY?=
 =?iso-8859-1?Q?jCe8alIYR9PA6OEnePVN/dTz8qO+ui/dNzblkk54PcdGnxLNEjj/gF8A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b1d193-966e-44d0-3b20-08da58dccfd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:04:22.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TT233IjTDMwW1BhyArMxjJ6uSNFarE35OJtgYrH5sUHXYpD/TCYP7rKKg+drUwBR5Pe7BWR/bqNBbRtM01BCbI1sqPAQGWdKwBB6WoXH4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_09,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lars,=0A=
=0A=
iio-test-format.c is for testing iio_format_value() function, not iio_forma=
t_avail_range(). And the problem with this function is that it is only a st=
atic helper in industrialio_core.c. The main function is iio_read_channel_i=
nfo_avail(), which doesn't look to be easily testable.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: Lars-Peter Clausen <lars@metafoo.de>=0A=
Sent: Tuesday, June 28, 2022 00:06=0A=
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>; jic23@kernel.org <ji=
c23@kernel.org>=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Fawzi Khaber <Fa=
wzi.Khaber@tdk.com>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com=
>=0A=
Subject: Re: [PATCH] iio: fix iio_format_avail_range() printing for none II=
O_VAL_INT =0A=
=A0=0A=
[CAUTION] This is EXTERNAL email. Do not click any links or open attachment=
s unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
On 6/27/22 21:34, Jean-Baptiste Maneyrol wrote:=0A=
> From: Fawzi Khaber <fawzi.khaber@tdk.com>=0A=
>=0A=
> iio_format_avail_range() should print range as follow [min, step, max], s=
o=0A=
> the function was previously calling iio_format_list() with length =3D 3,=
=0A=
> length variable refers to the array size of values not the number of=0A=
> elements. In case of non IIO_VAL_INT values each element has integer part=
=0A=
> and decimal part. With length =3D 3 this would cause premature end of loo=
p=0A=
> and result in printing only one element.=0A=
>=0A=
> Signed-off-by: Fawzi Khaber <fawzi.khaber@tdk.com>=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> ---=0A=
>=A0=A0 drivers/iio/industrialio-core.c | 18 +++++++++++++++++-=0A=
>=A0=A0 1 file changed, 17 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c=0A=
> index 358b909298c0..0f4dbda3b9d3 100644=0A=
> --- a/drivers/iio/industrialio-core.c=0A=
> +++ b/drivers/iio/industrialio-core.c=0A=
> @@ -812,7 +812,23 @@ static ssize_t iio_format_avail_list(char *buf, cons=
t int *vals,=0A=
>=A0=A0 =0A=
>=A0=A0 static ssize_t iio_format_avail_range(char *buf, const int *vals, i=
nt type)=0A=
>=A0=A0 {=0A=
> -=A0=A0=A0=A0 return iio_format_list(buf, vals, type, 3, "[", "]");=0A=
> +=A0=A0=A0=A0 int length;=0A=
> +=0A=
> +=A0=A0=A0=A0 /*=0A=
> +=A0=A0=A0=A0=A0 * length refers to the array size , not the number of el=
ements.=0A=
> +=A0=A0=A0=A0=A0 * The purpose is to print the range [min , step ,max] so=
 length should=0A=
> +=A0=A0=A0=A0=A0 * be 3 in case of int, and 6 for other types.=0A=
> +=A0=A0=A0=A0=A0 */=0A=
> +=A0=A0=A0=A0 switch (type) {=0A=
> +=A0=A0=A0=A0 case IIO_VAL_INT:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 length =3D 3;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 default:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 length =3D 6;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 return iio_format_list(buf, vals, type, length, "[", "]");=
=0A=
>=A0=A0 }=0A=
>=A0=A0 =0A=
>=A0=A0 static ssize_t iio_read_channel_info_avail(struct device *dev,=0A=
=0A=
Change looks good! Lets also add a unit test for this in iio-test-format.c=
=0A=
