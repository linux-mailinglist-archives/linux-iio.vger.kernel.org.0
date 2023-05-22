Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6581F70B94C
	for <lists+linux-iio@lfdr.de>; Mon, 22 May 2023 11:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjEVJqT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 May 2023 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEVJqS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 May 2023 05:46:18 -0400
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB0B4
        for <linux-iio@vger.kernel.org>; Mon, 22 May 2023 02:46:14 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M92VnH024194;
        Mon, 22 May 2023 09:45:49 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2176.outbound.protection.outlook.com [104.47.7.176])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qpqjgh369-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 09:45:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih4LWgUbwEjM/Pgkq3bOH25LM2sjhtHW98yTkBjKs0QtdgGxwJvq6bT9LQvQPWt+2M31T4sSFD//Iu+uPjLyCj5N5VOiYVgYZz8YVGHb7CyXdVajKJZOYp0OhN//6vp3zB2tPTjLrO3nkyJlo1pPkv4nMVW6GTAZ7/5KJF/EuMPQaTaQo7FM0br3NYXpb3BAXOUO78mQq1DcrT4gpUn4H+PLHwzjTkcNwqvFGPAN3yhLVZ0J2EsuMKNdgNjWVTVJaAnVwniPGt614vWfFts42UC75lmemdFWVOftUlOi38n2XvjwJGU+vzK9dqgmqjYOUiwHS/tXrbmg6rBPfteS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxWO47Xej3R/pghmphxBbnE3gQ0PXJv7KGIufxJO51M=;
 b=IhHcuhTMxKud0Zy0mxSccI9YIzavTYWZsp22lhmeuSq8du3D7l3koEp97DWjxXu7QWAw1HQRzDN5y6HCujpAGYQOLKuOCTrKsCLnQUpfSDgSgschMScw0JSmzrNaEljxCDjG867i5CtVLkdeO4Dqiicl5lEcpH52z3KdQuYmbHxhki9jDxdF1V9TA4jCbywLSWNJmrdLVME60v3KsF46dVi7cTkDAKK63dh/8fWO1XZnFuqgDtRaT/XfCjE7fvmP3dEXBYFnax/sooyZ85+v8Z9LCSo4YVgeyyv9KsTSopa4T3OdEQPE0b3N5clxLtJ8RdJ019BK0IeRs3VWsdlI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxWO47Xej3R/pghmphxBbnE3gQ0PXJv7KGIufxJO51M=;
 b=MWBuwEvCva/VCbt7ILrF+bnYGOlNCjF4ItUJc+KIgfbidrBSBZjqqTs3BUhwkm+WkqiNbQr0cbNfA3KB2lXx0vVHGW77tFx8bwoxIccoorlqJuBvzwP9TG+cjns0EcMEqhWtwxNBMN56TdFijHMRgk4mNX9ghguEcwSUIjAsl2Dx7P0s89246On110RjvKb0JE0isMXFkAlujb2YVHs0yxQMzgLd0vV6z2wUq+LHJfLPK60FQSA2oHwEhIkSV1Nk+GvaMOK0E8Ux3R0L8f1RPqFpHNP+ugIwlQ8ZXEPm+5dx57uUcW14W3snhvPYpOBuJcNUhMNdqIfTPeoXDix9uw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB1856.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:45:44 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:45:42 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: avoid frequent timestamp
 jitter
Thread-Topic: [PATCH v2] iio: imu: inv_icm42600: avoid frequent timestamp
 jitter
Thread-Index: AQHZhxUL7w+pjxiT4UyveIOq7nMJ3a9jYWMAgAK0Qsk=
Date:   Mon, 22 May 2023 09:45:42 +0000
Message-ID: <FR3P281MB17572FDDA12912158360C5E7CE439@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230515100645.61172-1-inv.git-commit@tdk.com>
 <20230520172606.3ecffe45@jic23-huawei>
In-Reply-To: <20230520172606.3ecffe45@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB1856:EE_
x-ms-office365-filtering-correlation-id: 1606cffc-ddff-403e-7d90-08db5aa94f24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5TjpL30GA0ZkIvpW4pxkuCD8ii8a+vNKi1BGD5UoZNuFIgmtfmbxnrwAcUWmSfg6Jqje4pp3r4TtAnHT0mRifIRPYwENEkb3ZVkRJf+fctxL5soiPTL3Cdgd/vhRPy4HTHMdnItW95mzzm1jZ8BpmH+pL2T97m+1agOYBtT9aHNnY/KBCEEPk94NMhpaBvV3QNEi01mxEnhGWUqvROzLZIV6zgzbA46kUJs01cXfkhEt43Fo9tMIrMHQG1KCwzLcR5667wHqpHRQPLp/bKJUYv5mJbv/YxcHsosbdbQNSlDzks0mwXIEGchnmdjuh1aNywB2jc+aAxmJiT7yCfD0p5CwYw/NAXUDCKH5Uv8keRJHykfuApmlFY5pK0Ls/Gikn47nJwpVf6kYltTKDBKupMKhleR5tj66Uaj4bQsC0aFWzY4KfrfhZIl7L3dqR9+wjQH+UMJHp6hCQ7448OY/wj5sma+/QhwU714MA8igcnxw45tWs81TMqsu+isVFr/GcloDdtsX5/ED6QVd5xVFgfzdiLSMWIhRHgj8rfFOd1MXYAAwuSVejeOiAzTO+x8kuDAw+2jGZYkdZmIt/A6mVXfyh6e2BYz0p3JY3HB4YVSJJGEkDcOAxgJyvJFpmQc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(478600001)(66556008)(6506007)(26005)(53546011)(9686003)(71200400001)(66476007)(66446008)(64756008)(4326008)(6916009)(316002)(41300700001)(91956017)(76116006)(66946007)(54906003)(7696005)(52536014)(8676002)(8936002)(5660300002)(86362001)(55016003)(33656002)(2906002)(83380400001)(122000001)(38070700005)(38100700002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Fch5T5ChdGx/HxC+NjZSG4boDtldWVfqgU/SuVnoYoa3tn4+Tr/Zo6W+ck?=
 =?iso-8859-1?Q?l3zg9dAp6BlYEb3X3Ruxi9jP274eil5UesPurMkBG2wKGv11el1W42KZks?=
 =?iso-8859-1?Q?h/fJrNCR+vLIUFsKfuL7Y21s60vO3RlLkv78SZFqAfsBJ/6ZmGSBYvR2Bj?=
 =?iso-8859-1?Q?tvzSCK3uRlW4iDGkZwD01ZrB9FMXFtIwpT8pnEtLXTvDH7vZP1YKlKX0uU?=
 =?iso-8859-1?Q?uoJTLWXmxc2KPQC5UyfSeDj+SvC9yeKqc5K9JCWQyJC9HjLq0X18O9TCG2?=
 =?iso-8859-1?Q?XQkbxcTN/uCqMLITunVSH1//IfhJKUuQJKfoewfLMmRtv4REDcdgnGZ/yT?=
 =?iso-8859-1?Q?F4D93rYYepOgeBKJLzEcBZJt2qqsLhIsSiHFDG7oVHC1xZt8Nb/YanDg02?=
 =?iso-8859-1?Q?tPYB3bgOIcj435aa45SmRwlVC1R5wUg8JvV0rJxdAnFInfLc/MFCD34qaQ?=
 =?iso-8859-1?Q?TzepI1cwp+2Sn6HY5ruV2vziJZYyxNNK/OKvF0fByNWWzVMT0OjPF/tFlG?=
 =?iso-8859-1?Q?TUvcJHnvurYIzx1bbPWeOCF4+3hdXnM9d5vIXXWhazAyg2n/GSR+TrzNvl?=
 =?iso-8859-1?Q?GuN17GWSynlMkCYnjy11gC+AN10kVpCFKrCLHOLQPR6x248zEHVO4axaqn?=
 =?iso-8859-1?Q?gVHNVz56GNYHcQL5IkhFjhRerW4DSFJq/IpZq7S1zADlYgchpKnIGB/GiB?=
 =?iso-8859-1?Q?Qd0G34/vpTtEkkU/ZUCYb454J8Je7FL1zNv1gkcwDARPM1Ig5eKCVt74Mg?=
 =?iso-8859-1?Q?7gzJFnoDQET/ESmZQhJcW8DdKqyz/OWQuUHr+2JTZaS0Y+44sOaMtxT16T?=
 =?iso-8859-1?Q?e58SeOgNWW8ljJ/kFfanezj/gYBVGAlZCbTM5PFmIYRmvdmhtCbtrVgGhR?=
 =?iso-8859-1?Q?PIluH6i7GN7u6Pp+9w70g07qScgVfq6aj53VfnHy7AFL14HkOihAacwU65?=
 =?iso-8859-1?Q?CBhb8lzGZTAFrEYRxZEkeWMPx+fcTKolNjUfoCSLGzCA+Q/nKJvoPmrY5D?=
 =?iso-8859-1?Q?iyHVK0IulfHrw5cBzYjgbktkk0/SDy57ctwcnhwls9Hk41O2zRGqh4YQLy?=
 =?iso-8859-1?Q?g13bKQXM2/HS3kmeYMV3xqYotDPLjpK4H5vXQwqVhV4L/mxlA2nWsiETL2?=
 =?iso-8859-1?Q?ZGfr94voBI5K1yWzy/ygYBBraT2JGy+2NS6/O5o5VcbiILGycKAsaEWn5U?=
 =?iso-8859-1?Q?FDW2UzAR8RapC41EKhzkNGmcpuXmDA/McpuPyQCftKD4O0BflE9FSzJopn?=
 =?iso-8859-1?Q?2M74Cd8vlPKJs4LyGMnnvLaaSaRT2y6rT6z13+SD0rzf3Jb/0WJQfq+BfW?=
 =?iso-8859-1?Q?D8GIrA8g59e4mDOl8rK/6oxUBcAxryDr+ROjMq4SFBsGsSawQpbUWiQe+y?=
 =?iso-8859-1?Q?yRpIs5OW+YUfQd78QPJaRsM1cQI45JCx39p54QaeT7/31g2BNT8pcYbx85?=
 =?iso-8859-1?Q?8G7n4zoOOgpujG+YlI9P+H2dwMZfqYW6BTawxkXJaBoYi3RyaZ7/Cfk+db?=
 =?iso-8859-1?Q?PESCcChwGvvGE+IkMQ8sUwPh6dI3I37yzW8HhNpyhDjhe/ZJaYbruBPxAY?=
 =?iso-8859-1?Q?TYHaafs/f2EKd0w9fYuuVFMcOtT3BvOQYHLJSy0bIx7oC1Ft2xIn/XbJ5v?=
 =?iso-8859-1?Q?m8NTcsqDMnZuV+eo5i89vs4zNHpJKDskJwfj7S44bGQIOzVyhG3maw/A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1606cffc-ddff-403e-7d90-08db5aa94f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 09:45:42.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ov9mT85A9C4SzFfE7WLZ2JJE6cq7q78Sc1FikXMDBUWjsTcQr1xrJLRcBVgaFe1vLrwIDHO5JdHhyJ43JLul/q3qPwTWQXzEAgFf0a0eTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
kernel test robot reported an issue with the patch v2.=A0A direct 64 bits d=
ivision was done without using div_* operators.=0A=
=0A=
I just sent a patch v3 that is fixing the issue (tested on my side by compi=
ling on PARISC architecture as done by kernel test robot).=0A=
=0A=
Thanks and sorry for the error,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Saturday, May 20, 2023 18:26=0A=
To: INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; lars@metafoo.de =
<lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=
=0A=
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: avoid frequent timestamp ji=
tter =0A=
=A0=0A=
[CAUTION] This is an EXTERNAL email. Do not click links or open attachments=
 unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
On Mon, 15 May 2023 10:06:45 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> We are currently synchronizing every time the data timestamp with=0A=
> the IT timestamp, leading to system jitter jamming timestamps.=0A=
> To fix that and keep it simple, let's just synchronize when the=0A=
> delta is bigger than the acceptable jitter, and keep=0A=
> synchronization at the jitter value.=0A=
> =0A=
> The result is much stable timestamps reflecting better the real=0A=
> physical value. Example @50Hz delta timestamp,=0A=
> * before: 20.123ms, 19.721ms, 20.023ms, 20.353ms, 19.821ms, ...=0A=
> * after: 20.173ms, 20.173ms, 20.173ms, 20.40ms, 20.173ms, ...=0A=
> =0A=
> Refactorize code and delete the unnecessary handling of multiple=0A=
> FIFO data.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Applied to the togreg branch of iio.git and pushed out as testing for 0day=
=0A=
to poke at it.=0A=
=0A=
Jonathan=0A=
=0A=
> ---=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_timestamp.c | 49 ++++++++++---------=
=0A=
>=A0 1 file changed, 26 insertions(+), 23 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/driv=
ers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c=0A=
> index 7f2dc41f807b..af2e59fb7258 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c=0A=
> @@ -93,8 +93,8 @@ static bool inv_validate_period(uint32_t period, uint32=
_t mult)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
>=A0 }=0A=
>=A0 =0A=
> -static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t mult, uint32_t period)=0A=
> +static bool inv_update_chip_period(struct inv_icm42600_timestamp *ts,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 uint32_t mult, uint32_t period)=0A=
>=A0 {=0A=
>=A0=A0=A0=A0=A0=A0=A0 uint32_t new_chip_period;=0A=
>=A0 =0A=
> @@ -104,10 +104,31 @@ static bool inv_compute_chip_period(struct inv_icm4=
2600_timestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* update chip internal period estimation */=0A=
>=A0=A0=A0=A0=A0=A0=A0 new_chip_period =3D period / mult;=0A=
>=A0=A0=A0=A0=A0=A0=A0 inv_update_acc(&ts->chip_period, new_chip_period);=
=0A=
> +=A0=A0=A0=A0 ts->period =3D ts->mult * ts->chip_period.val;=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 return true;=0A=
>=A0 }=0A=
>=A0 =0A=
> +static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)=0A=
> +{=0A=
> +=A0=A0=A0=A0 int64_t delta, jitter;=0A=
> +=A0=A0=A0=A0 int64_t adjust;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* delta time between last sample and last interrupt */=0A=
> +=A0=A0=A0=A0 delta =3D ts->it.lo - ts->timestamp;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* adjust timestamp while respecting jitter */=0A=
> +=A0=A0=A0=A0 jitter =3D ((int64_t)ts->period * INV_ICM42600_TIMESTAMP_JI=
TTER) / 100;=0A=
> +=A0=A0=A0=A0 if (delta > jitter)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adjust =3D jitter;=0A=
> +=A0=A0=A0=A0 else if (delta < -jitter)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adjust =3D -jitter;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adjust =3D 0;=0A=
> +=0A=
> +=A0=A0=A0=A0 ts->timestamp +=3D adjust;=0A=
> +}=0A=
> +=0A=
>=A0 void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *t=
s,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t fifo_period, size_t fifo_n=
b,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t sensor_nb, int64_t timestamp=
)=0A=
> @@ -116,7 +137,6 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm4=
2600_timestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0 int64_t delta, interval;=0A=
>=A0=A0=A0=A0=A0=A0=A0 const uint32_t fifo_mult =3D fifo_period / INV_ICM42=
600_TIMESTAMP_PERIOD;=0A=
>=A0=A0=A0=A0=A0=A0=A0 uint32_t period =3D ts->period;=0A=
> -=A0=A0=A0=A0 int32_t m;=0A=
>=A0=A0=A0=A0=A0=A0=A0 bool valid =3D false;=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 if (fifo_nb =3D=3D 0)=0A=
> @@ -130,10 +150,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm=
42600_timestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (it->lo !=3D 0) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute period: delta tim=
e divided by number of samples */=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D div_s64(delta, fi=
fo_nb);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 valid =3D inv_compute_chip_period(t=
s, fifo_mult, period);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* update sensor period if chip int=
ernal period is updated */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (valid)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts->period =
=3D ts->mult * ts->chip_period.val;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 valid =3D inv_update_chip_period(ts=
, fifo_mult, period);=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 /* no previous data, compute theoritical value from =
interrupt */=0A=
> @@ -145,22 +162,8 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm=
42600_timestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 /* if interrupt interval is valid, sync with interru=
pt timestamp */=0A=
> -=A0=A0=A0=A0 if (valid) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute measured fifo_period */=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_period =3D fifo_mult * ts->chi=
p_period.val;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* delta time between last sample a=
nd last interrupt */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D it->lo - ts->timestamp;=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* if there are multiple samples, g=
o back to first one */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 while (delta >=3D (fifo_period * 3 =
/ 2))=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta -=3D =
fifo_period;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute maximal adjustment value=
 */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m =3D INV_ICM42600_TIMESTAMP_MAX_PE=
RIOD(ts->period) - ts->period;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (delta > m)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D m=
;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (delta < -m)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 delta =3D -=
m;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts->timestamp +=3D delta;=0A=
> -=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0 if (valid)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_align_timestamp_it(ts);=0A=
>=A0 }=0A=
>=A0 =0A=
>=A0 void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *t=
s,=0A=
