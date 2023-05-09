Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66276FC486
	for <lists+linux-iio@lfdr.de>; Tue,  9 May 2023 13:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjEILFS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 May 2023 07:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjEILFQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2023 07:05:16 -0400
X-Greylist: delayed 2236 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 04:05:14 PDT
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D079E50;
        Tue,  9 May 2023 04:05:14 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3498YITL025917;
        Tue, 9 May 2023 10:27:37 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2168.outbound.protection.outlook.com [104.47.11.168])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qf7b50njn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 10:27:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5DyE2XZHRF2ae7dOrf509ZVZb9tC7fPsy1b7Jy39arMWUQaCds7WX2Z0x7N3UMz16bQAVsOSg4+YdOLhVglBo99uoFQRRLbwl8RNizzpNfjWPNQLFs1VfPpo9mfXj0FkrWEijXtml9p4KA6CHdCJkBGML+UjBz8vUROyCkCFTYEq27RjzTR0Y1wX0y+H7NEE8aYMXLW8Ha2UdETVPj2XNsC3qMUkiIELu7mEL2KTEfhlSaI7DGsM3YAe1vykKKQrcHMmP7xIR7M2llYjzV13ZzYc3DdBCpaeSnR9Av9Ynds/dY/pfXJRCaeXQzpf/Ew6LUEMsy1J6F9MZXYqbtKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg8TO8qXYjlTedm6vK8JuXuX7eLTsCDGe3I1gPAlSzY=;
 b=hNmbAxYa/zB+J9Zt0ou0jDneC44wJma8FouhVB37Fq+RPKu2GL+N+zLdRQDpJq3xWblP0M6Hu+YJLVJVMCkPmwZJfRuz0KVRfQcBfrvb2TcJId/clD+gGJ8qUZd4pxRhdViGwTLdUf+AEKxY7OnomC80tlLWPks63DOVGh7pMNJtDW40FRq8Ybl1wT46IkGdWUp7+aQoBLidbAc4200qlO9kskGkghcUg1XeWVxEW2B1Tq3frkBvSPuyaCD+pX25VRWmXph/ix+4QnmuvHm+uVf4LEvqdFnUye5nTTcNsEHwyzB6G5ud8ghiko661nlG43wR6uXI5RW6FuaMvPL0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg8TO8qXYjlTedm6vK8JuXuX7eLTsCDGe3I1gPAlSzY=;
 b=IJ7aVN5J5GbGgJgqRh9eR+YeC65tgw62z73i8hk4/Xe0MXGq1RP+MTztal1Q8a2spvQZLQO3flX0bCu38mqh2q2qnqGrJHbhmnn/D0/MUt+Pe9V1UNeuPWlC9PnQYkM/Pe0cuhgUfZTtUgQ4RLM3iDFsatpPc0KnODCZL8ztwOmfqetn+E1ToLVx+9uBHCP/0cGjEHYz9XDCTq9QlyIkUDvyZ8VZtUwqfJORyiodC0UpbXTPzFQUgvWlgqOo7TcB0e4OGfjcszEH64bFZJdSLDgCIfhNm+Mm6fdvflvddcc73SlNQA278BuWB8T6O0tkySaidiv9kln8ve+VnSN4WA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB3079.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:60::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 10:27:32 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc%6]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 10:27:32 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        INV Git Commit <INV.git-commit@tdk.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp reset
Thread-Topic: [PATCH] iio: imu: inv_icm42600: fix timestamp reset
Thread-Index: AQHZfgAaewgg5p4Thk6BwgASZcf20K9NkAWAgAQ1Ko4=
Date:   Tue, 9 May 2023 10:27:31 +0000
Message-ID: <FR3P281MB175745F6D7149F6D9F488496CE769@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230503204410.165035-1-inv.git-commit@tdk.com>
 <20230506191017.659b5196@jic23-huawei>
In-Reply-To: <20230506191017.659b5196@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1P281MB3079:EE_
x-ms-office365-filtering-correlation-id: 9f93c7d0-66d8-4b28-10bd-08db5077ff6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q6rL4de27VcHBWvJw6ZkiLHZe7GNjLaZ6rVnuoflFWhtAUsB28hwudEUi6JkTgwPgykFwDaRIfQmA/P3EoSdjmQeeYDpbpz6/G3YOeSKrcs/+UK85FkHhQlmUetGjR6j1qGfh/QQcdaMkWA0tWYYPOuQoDagIbUexlxCKeGTJMz791ZkbX6qvDeCQvqqja1he5hNHwgkU7mosBbsczvGflOOA00CBAYId85gj5sCv76Rzz4Y+uDz7vebpmHZ9R8GguknwrZV38893vGmSc4WgPwBNlUP1hoSs08QYKo7gzoymYqJBdlI7EufHj0GcEjMpKtQE4nhk9rQGbpjJ98tuA+X8iP2A+xeE4pYkkFAzePEyumjFK0X8N6ga7/i/GOf9t4w4UMa0FI4hpI8l8bkMWuHrjCoDRvgpw+dU38RS2psgFB9INRSd+c5r9GFRTXqbQBrUsNlmQtcZndJGVGlzI/20xwdKnn7HQBGltm0bjXluoHnBjgYCFaXdaQ9vyTZq2AtHCv0wINrpPUyO+dJ3TEcEaN3iRNDmrakj3+Si/fuoInOwmdVXzBZsf+Zvwu5YGePg8YR9QqePHejYl6hns5r/ceQ6P+9HWfadm8OFMwyv1Mx/SLFwX96p2Hrlm1O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(76116006)(66946007)(66446008)(478600001)(66476007)(64756008)(66556008)(6636002)(4326008)(7696005)(316002)(91956017)(110136005)(54906003)(86362001)(33656002)(71200400001)(83380400001)(53546011)(9686003)(6506007)(8936002)(5660300002)(52536014)(8676002)(41300700001)(55016003)(2906002)(186003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZEZwBNcL/28sqnJO851++iOMTV6HreITGKKd2/FFNUozlDv/d8MtRpiefI?=
 =?iso-8859-1?Q?UVGrNE//phINSryPFe+nCyUWR++7edPQWaVpZ300OqOfCaA2f1Z0fnLTzT?=
 =?iso-8859-1?Q?wXO97EA1G82WWgbUAsd6GzRRQbobrL9Y/WatOTNq43C3sbOu15mSAqzGK/?=
 =?iso-8859-1?Q?MOP5kSkaJAo+FFD2c+ZyVzNqXo+Qk/p5zD1gGCyldbaxCwIV0DvcIDHlKY?=
 =?iso-8859-1?Q?R2JF4Lb5pibwijLc/A5wUtwLhqIrgaGc4ddG1Hf/shbZR8SqVF7zWpxDLG?=
 =?iso-8859-1?Q?ZJb/vnc/IuKmK8j1yUYjxA4XRhoqbhQ9o6IrK7qJSRzV/xKFJl+HhqUXxk?=
 =?iso-8859-1?Q?GarV61O0vwpKA8Iar/ApKSqUortvq8KZcYQPC4+AHX6mBCakOyPbseQGkw?=
 =?iso-8859-1?Q?uQgdwjNf3VW65qEVjPoVuiK+svEE3GMnNcgElJCDVCCfQWEhCc6nnW2LZx?=
 =?iso-8859-1?Q?PewyfiK9XWoDR3AQ/CENmMWYBCOR1+rgDMIeEH2Mf2hvNwOWC7gu81RIc2?=
 =?iso-8859-1?Q?sMkdoluk2HK8zoERKoRRmg6+6a13+4GGCnzH0CmJkIk9guih0HPc1hM1e9?=
 =?iso-8859-1?Q?yXtdnAlShxVMY9o8TqzMdTcuEYXVkU8Gg/hs0cxapn+gNExVCg4QSK1NDo?=
 =?iso-8859-1?Q?69vNGXWpB5uEcuiB06f7y2S/LYtJb7KuJ6f437tG9FrkoF5OPd3+UXcOET?=
 =?iso-8859-1?Q?Of1l0lxNRB1NV1CA/RtdhPrtMtnfwHGSlkdNlcB8blKi+gATLO7GbAA+Tk?=
 =?iso-8859-1?Q?7Vlk8c1Yh5vWKZ27yZEZI2qCWXgfjSveKWFznEcuqF6XXzOGZylRPtbrly?=
 =?iso-8859-1?Q?SvfUChyAL15N6lBHd4nEy59JwatN5xXq7cjYuicGLGzKssO9/HMoj3xgV/?=
 =?iso-8859-1?Q?KL8H62U2J+Ak0dLfL0Ddrfkvi5ZzMgDRy2k+3k5AKTA1XdIoPzXEL/oO91?=
 =?iso-8859-1?Q?W3rnS730B2ePugG34APEQmhHVN84iv2V5YkWaKmHmG3wTOE+UObxElDFq3?=
 =?iso-8859-1?Q?XiKTPM7zNz3D34yK64KW8vYhUMZS7H2H4+K3MEm7ueDNXX5Isxbi0BLFFp?=
 =?iso-8859-1?Q?t1n6vtMeDWbbAHrmjHTd9zLhmIDfprTF6BnTE9NhYdiI2w3vZMRoO6acbT?=
 =?iso-8859-1?Q?UHvHwtcMITTb+Ae7sUoO8PBA9+f8nJFGQLRDs8vZKiPNwK1rgDXckO3Rmg?=
 =?iso-8859-1?Q?lgP/BautCgOQzkgR47kqsMVInP3slnEGh/rxwdc6tPrZ3MrRUS8ncuU0nH?=
 =?iso-8859-1?Q?LbsTdi/xoeEG71PLfz2uiWhQkZHV65k+FhM/c1zKuuybzdBjcyKcbtD3Tp?=
 =?iso-8859-1?Q?v6Fb6XFaseT8XCsRLVUkFbVb+Ipx1226KhzB+LS5OFWoh8QRTustsvJDWc?=
 =?iso-8859-1?Q?AHd0SVFM7Tk2R7UBOr6kBEM+VjG11aRKx3/owq13b9UwrAPCoYjUZRzdAk?=
 =?iso-8859-1?Q?afVhYhMD2WanrTXcpp5lfVTOl7bp8bH8HbR2V5fwly3TQ7VHnbgG6XInJ6?=
 =?iso-8859-1?Q?8OaGFNAsZeqTYApKhn0NcctllAxAVpmpToW9/b1ZkZLyZ4ZQITazS4SKmc?=
 =?iso-8859-1?Q?6w+Ulg12UaHhCU7BbMMeSeNiichtnuZvgamhZlToskDSzAvnaKXx7iD/iN?=
 =?iso-8859-1?Q?3Dg1dKfKKHKivqt15C3pfJ4IbUHWzbbvvoC3EyXcsVnjjnOGJQ9GBrnJuD?=
 =?iso-8859-1?Q?YubX3uGotEbjnWS0EfDkKe0R2ocSBmyrWJT5K4R2dHCqWF0su8yLXkJ0nB?=
 =?iso-8859-1?Q?dXHQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f93c7d0-66d8-4b28-10bd-08db5077ff6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 10:27:31.9534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jlD7SoGrES05EN/LSgc2Oc/7iaOobqQ/NqGpde5fhjbssMwOw04uYgsIeV2zHRfEjwR2GxUPuSQHYI6SODzcJpZYsrKh+meuw6vNmIg06w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_06,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
the signed off is for the email address we are using for sending email to t=
he mailing list.=0A=
=0A=
We cannot use our personal email address, so we are obliged to use a dedica=
ted service account for sending email with the git send-email tool.=0A=
=0A=
Should I delete the signed-off corresponding to that email address?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Saturday, May 6, 2023 20:10=0A=
To: INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; lars@metafoo.de =
<lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>;=
 stable@vger.kernel.org <stable@vger.kernel.org>=0A=
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp reset =0A=
=A0=0A=
[CAUTION] This is an EXTERNAL email. Do not click links or open attachments=
 unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
On Wed,=A0 3 May 2023 20:44:10 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Timestamp reset is not done in the correct place. It must be done=0A=
> before enabling buffer. The reason is that interrupt timestamping=0A=
> is always happening when the chip is on, even if the=0A=
> corresponding sensor is off. When the sensor restarts, timestamp=0A=
> is wrong if you don't do a reset first.=0A=
> =0A=
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> Signed-off-by: <inv.git-commit@tdk.com>=0A=
=0A=
What's this sign off?=A0 =0A=
=0A=
> Cc: <stable@vger.kernel.org>=0A=
=0A=
Otherwise patch looks fine.=0A=
=0A=
Jonathan=0A=
=0A=
> ---=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 10 +++++-----=0A=
>=A0 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> index 99576b2c171f..32d7f8364230 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> @@ -275,9 +275,14 @@ static int inv_icm42600_buffer_preenable(struct iio_=
dev *indio_dev)=0A=
>=A0 {=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drv=
data(indio_dev);=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_timestamp *ts =3D iio_priv(indio_dev);=
=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
>=A0 =0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=A0=A0=A0=A0 inv_icm42600_timestamp_reset(ts);=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=0A=
>=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
>=A0 }=0A=
>=A0 =0A=
> @@ -375,7 +380,6 @@ static int inv_icm42600_buffer_postdisable(struct iio=
_dev *indio_dev)=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int sensor;=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int *watermark;=0A=
> -=A0=A0=A0=A0 struct inv_icm42600_timestamp *ts;=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM4260=
0_SENSOR_CONF_INIT;=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int sleep_temp =3D 0;=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int sleep_sensor =3D 0;=0A=
> @@ -385,11 +389,9 @@ static int inv_icm42600_buffer_postdisable(struct ii=
o_dev *indio_dev)=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (indio_dev =3D=3D st->indio_gyro) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sensor =3D INV_ICM42600_SENS=
OR_GYRO;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D &st->fifo.wate=
rmark.gyro;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D iio_priv(st->indio_gyro);=0A=
>=A0=A0=A0=A0=A0=A0=A0 } else if (indio_dev =3D=3D st->indio_accel) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sensor =3D INV_ICM42600_SENS=
OR_ACCEL;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D &st->fifo.wate=
rmark.accel;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts =3D iio_priv(st->indio_accel);=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
> @@ -417,8 +419,6 @@ static int inv_icm42600_buffer_postdisable(struct iio=
_dev *indio_dev)=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (!st->fifo.on)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_tem=
p_conf(st, false, &sleep_temp);=0A=
>=A0 =0A=
> -=A0=A0=A0=A0 inv_icm42600_timestamp_reset(ts);=0A=
> -=0A=
>=A0 out_unlock:=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
>=A0 =0A=
