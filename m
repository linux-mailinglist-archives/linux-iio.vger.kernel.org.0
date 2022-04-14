Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD4500E52
	for <lists+linux-iio@lfdr.de>; Thu, 14 Apr 2022 15:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiDNNGP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Apr 2022 09:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiDNNGO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Apr 2022 09:06:14 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DC791AE1
        for <linux-iio@vger.kernel.org>; Thu, 14 Apr 2022 06:03:48 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23ECuHl1023172;
        Thu, 14 Apr 2022 13:03:31 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2172.outbound.protection.outlook.com [104.47.7.172])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3fe8uqrktk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 13:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js/SVwPLibM7Zme4fqENP1YpYxQ6v5bZ9YUCfGdTqPcOrZ1FoQXo9yCpFtX4BPukQ9vKUI7bsDz8cq1esZ8NrQXozrYxegJ5g6xDt4bJwh9Y+4Iq78F3p8R4E+8NPFN/3ht86flPS0sZ49q00U7dCIN5grLd5nz6ZEShrJp8glBbL7OjfVN2zZP498e0kq5Sa5V5RGwjgYX0SijOF4D5WHmfwHTumzpAs4z7R53ilH7/uw/eBY+e+EufSWTjFGVPIgKClHSBY9pg/6dPrZX757EJaT25nACwymVusXVNg8Fr7ZW6vIXGPmtJruel7FJEssLSGVtkET2biLU07zl2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=023VdKF7NWQ0iafxHeLrPaPLuHy5aKxqyP9fFW4CZCU=;
 b=Z1TKwkxsJbx3TK95cOKDkRxU48AZp8Rqw6eJz3tPNZKMfWGTAfqtlcD+MVnIpWk5pmgXEAr1IjgzTxA4tv5hO4PN+4BJm4sgZHxk7I8IUP6xyb5ePXm4I6qAk470WZ71TBx8Yfn58LGhDycZKoesrQgA5GCH6+QLJp1ae1b8x01CFjc8yPKE2Bf7hjlhcNQ5gHl/eGcKnr0f0+ZtglGKJ06wTeG8cbtNHCj+94IQbUOy6l5Ru+j6PXg48lHmZsdm2kMWkeCynh8RtHG5rBWatKElG9Z2xGS1fU2qlrMf6VdGXOdFQ9vARD0D4Aewyw+7LOcIe2a54PImLU6eUDG0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=023VdKF7NWQ0iafxHeLrPaPLuHy5aKxqyP9fFW4CZCU=;
 b=m8T+Z2ViDG/BZxTnimhW8wSrqTFqn35NuKQ8bH26tayk8RWePAD/L/A6BcyzCCTZ+m5TxqRVN1a1pxbvFAhmH2ZA1kZz2yHrdLwpNB3/qv7afePWJnr0L0/h0Nt8kvd9uO09H85g3sHqr7AFfFlsChuGgaqEY4sCDSYgh2CQzjyH2IZioXs1yAa8RlDC8IUSQhBExpGZ+VWwUZmc/lclfsnBX0YsDLESDNqled4WPv/p6L2Gep1EqEVgGDZFFMCGxBkJRiyvvJhvI8G8h3fPexJZbEAalFv7pPiin+BF9/oOEFJ+yYyyD6SdtLlwd3uCikXsqCASs7rwKRjfKjSYgg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FRYP281MB0191.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.6; Thu, 14 Apr 2022 13:03:29 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::24cc:b9c1:6cb0:23b3]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::24cc:b9c1:6cb0:23b3%3]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 13:03:29 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Fawzi Khaber <Fawzi.Khaber@tdk.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: iio: imu new driver
Thread-Topic: iio: imu new driver
Thread-Index: AQHYT+sf/nEc4mRYxEqmVF3LZpkNeqzvQzMAgAAYuK8=
Date:   Thu, 14 Apr 2022 13:03:28 +0000
Message-ID: <FR3P281MB175790BCD24EC802E3B22EC8CEEF9@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <FRYP281MB020540A2361C4DCDB9F315A694EF9@FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM>
 <89c89115-334b-27ae-413c-73b3006d3ffa@metafoo.de>
In-Reply-To: <89c89115-334b-27ae-413c-73b3006d3ffa@metafoo.de>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 9110b792-1118-a490-4855-9a7c9af06b6c
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25737b52-1ed8-4b09-d6ba-08da1e172b93
x-ms-traffictypediagnostic: FRYP281MB0191:EE_
x-microsoft-antispam-prvs: <FRYP281MB0191614EBED030EC27B64D5DCEEF9@FRYP281MB0191.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0alEFd9aax7kcTvuB4EbUtX9TTnQVRrVZrGncpZmoj16QSOFfnM0edl5CntbxMgP39/E12vT/AikFfhKrFv+q5GMj3MCsh2Ef5GwC2TEGMtsa9y/KWhDrU0a8/pxmRoiEsWrNr/m2uMvMtHB9ic2akn9cmkcWo3zsoiZroGxjdQJkKfKCXeTjMN9wPdNaYsWFwjJBzz6IX0XQLd5thysCRZ6JAJN5q+r2y+OXimvffi2ejU/LiUCAyDuGUwFwgVHPAarLWqCOkF8POASyy6bw5JaXCSTID34xIphvBNvg75YCx+WNv4cfaifCjBC9c3z837q6PlXR5tMz0TcgYN5bbblWMsuOUEHkMeAb1I8PIbgqRYaVBWTKr9ZoBIoo+czVRmR7GOP1a0yT4EBRmsoYfqHOWyk+EGuKHsT7w/j9Tdk2U1hYTKwnaiuFzmZhrQGBDUMUDroyzbN2SUBGgDoQm/vtx6YFjCxrR+z0t3rocwpOuBALDdn1IA13YgfJhJBNt6MkSSqVf2haJYTN4/0lki8zV4i1mqt6BhlPKTnEIDR1SAepnY3iRJo9N+5LLDqHU4uLK5F5AGJivdyLrfiFkmIPIM9Mlh/h9cOGaVZNG9nMLRISEDt6bgQwxF8nqmqnf74JooF71yHBr/PbsOtOcEjcTQO9zoxYMdWe21b7rQ0ntQmDJC782bqYFRqscNQMZ8KY1rfz55WHCvu1haKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66556008)(66446008)(8936002)(76116006)(66946007)(52536014)(8676002)(4326008)(64756008)(91956017)(110136005)(5660300002)(9686003)(6506007)(86362001)(71200400001)(33656002)(7696005)(186003)(53546011)(508600001)(2906002)(316002)(83380400001)(38100700002)(122000001)(55016003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mWgtwDf1fxXjOZo5sAv7hbYTTsmBO+lu6377H+4CjOiBS69V21OaihwAh5?=
 =?iso-8859-1?Q?a8bIajHSPv34xzbUlFzpp76j6qUYnHzcg/3MC8UlPv+SeSKX8aNhXPqefd?=
 =?iso-8859-1?Q?+GQPqVZdWWQwKbFc/AeL5bj3N1IkZpshXTMrwuUzR5CMmBZfp1NhEu8Pyh?=
 =?iso-8859-1?Q?315M8w+MvhfWVpHQzQynvQSMv30MIf+n4G9agICRuazpmMREUIXwZkXF0h?=
 =?iso-8859-1?Q?sshXxqOJgAsgsmnVM2Izt5fdTwr1nNuNLa00TaV3hQ23Kt4pER/BBxf//M?=
 =?iso-8859-1?Q?sqkD4GxQhnbpHRQgxrxhfqX3s007tEG2RXI3oNGT6+6j9KPUHDJILSqbgc?=
 =?iso-8859-1?Q?gVXCwfUdSWzZsTALcxvmBIKaCHro9k91pCQtkxNenbALi/RrpjJyXMl58g?=
 =?iso-8859-1?Q?8eoftE4sDyohMC6DyKyLEQ1bE6gB/G2+BtnA2ZU0F6FpiJCG+6zrg8IxGB?=
 =?iso-8859-1?Q?Yql3qj/g4l71VxizVENig9+NtzBOWQ0NlnXLiXup/ksn+Zs8Cd8/hf2TVI?=
 =?iso-8859-1?Q?8WYEhh1r5ji+W4990UmXz+KFfLrpS1YqNrgH7iMH3rXJCB2stCo7XdFtU5?=
 =?iso-8859-1?Q?XBor7YfXt2nETOl1BF9BERI9pGJHTcvThMJdHf80Mehumbo7FOwAK7/ArN?=
 =?iso-8859-1?Q?7Za951sDyzHqog0CCVqAPOzHoEChk/W7TOp8qy9YSTBLVcgtST5TAYvQeA?=
 =?iso-8859-1?Q?wAT3oiY4apRrtoXxec10/gCdFaHoaTLUm2GPIfJr3ZZGvktV0wly1Y7zRH?=
 =?iso-8859-1?Q?6LwNbzYKaveF6k/Ql2f8dNpXyoklHdwAQQNrrqUr+Zca3Doio5CEpK3LHP?=
 =?iso-8859-1?Q?dROWV8QEFiaml5KrI9KTvWyptiyaCbzQdCHJKcG3cDmDX5HZFKQPWh/dGj?=
 =?iso-8859-1?Q?xglkXo/vp6DAuouRighWvA6fk9JYgSVFV2gPaJFZf56em+lZf30MxwCGyo?=
 =?iso-8859-1?Q?D+UzazNlvCR/Mu/H2j3NvVVhHyzXjt70+96cKmdd7gAbErDwCJt96+m9+M?=
 =?iso-8859-1?Q?88EgvelXfLd5hmd7Xr7PIprRpJwY+f+U274734GvMaLJsC9zIZT8hcROKy?=
 =?iso-8859-1?Q?+exROy2n9gBTadwEGPDosORN6SOJyKaYnMd/0456ENi2BKzRkgfgcBbspg?=
 =?iso-8859-1?Q?ieGg/2e9cZMGDaT/qga8XaDceU9Txlt9w+HiOW7OKtKuw7CDXQDbtvVrS2?=
 =?iso-8859-1?Q?oGx+ylkJ4/DAsDhhsIk/jnsaYLn2Zl0nZETSBoskjLB9re9/tdWllAR6Qg?=
 =?iso-8859-1?Q?LKsLhptPzzu9bQ20b4LaeHt8yvWB//lTfOadY8cv1TxU3zh8wf8pNBGPqz?=
 =?iso-8859-1?Q?Q3688wePz5AsVNOxukK8sj2LSMRt13iL2nb25GUHAukjsmOx/sM3ceLtPE?=
 =?iso-8859-1?Q?rtXd8nCUMSPC0jnOLpCMiI1q9EhHdl3Qv//ZlkWZ63m4OHRBLDyNLKbZDL?=
 =?iso-8859-1?Q?uSPP5QDQlPgLXl3nHMzdE0RdS9hrBN9clA7HzGJ1H1MDgPcFybTzMQxAVs?=
 =?iso-8859-1?Q?cdEHh7hiVKW7VLbF3QsKCJTTl56bzxTyzIOZBsN56azEO24n5Eg1oDQp0F?=
 =?iso-8859-1?Q?Syxi+ZBh/Szy4vLV++bdduaPJUeCp9/eMfdiYSsV+XFgdcPvAIDx0Wv4uq?=
 =?iso-8859-1?Q?9f0f7+c3KDGg2kNFqZMQazwp7mDRZTWR5q/glRAhej2lXqWaobKUoQ8aqY?=
 =?iso-8859-1?Q?GFvPjnyrHlr1LaXLGLkwWquRVQFFfZ0qe2xlcRyzAvCvxexbUB1B2g1Gvx?=
 =?iso-8859-1?Q?F/3FlX6gcHWZOntVloRXlliMK2ei5q8Yj93/if1Dub420+ThSiz2VRXybL?=
 =?iso-8859-1?Q?/4NyX+QRmqI8luWw/d6njATqCLmyVi7A+9X+8cG3N5YcJvWZ05WyOcmV3g?=
 =?iso-8859-1?Q?cM?=
x-ms-exchange-antispam-messagedata-1: uUIkDKKpawBd17c51UARtfCcxhjZh/+mQEE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 25737b52-1ed8-4b09-d6ba-08da1e172b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 13:03:28.8974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOPtYP9CD+lCEuraiFlMqdXVGjVpkWRwXTOhS9IRdWMyThFSp3mQfkV35XvJGIIOwSUDoy1MSzMJa57xvuYS+8GmQ+NnAVc6BMB2VHupZFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_04,2022-04-14_01,2022-02-23_01
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
accel and gyro are synchronized and are outputting data inside the same har=
dware FIFO, as inv_icm42600 is doing. The issue is that the sensors have di=
fferent frequencies, using a header for signaling data availability, thus d=
emultiplexing from userspace is not possible in a standard way.=0A=
=0A=
Solution found for inv_icm42600 was to use 2 devices with each one a buffer=
. FIFO is read, data demultiplexed, and sent in each device. Now that we ca=
n have 2 buffers for 1 device, is it simpler to use this solution rather th=
an 2 devices?=0A=
=0A=
Thanks for your advice,=0A=
JB=0A=
=0A=
=0A=
From: Lars-Peter Clausen <lars@metafoo.de>=0A=
Sent: Thursday, April 14, 2022 13:19=0A=
To: Fawzi Khaber <Fawzi.Khaber@tdk.com>; jic23@kernel.org <jic23@kernel.org=
>=0A=
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; linux-iio <lin=
ux-iio@vger.kernel.org>=0A=
Subject: Re: iio: imu new driver =0A=
=A0=0A=
[CAUTION] This is EXTERNAL email. Do not click any links or open attachment=
s unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
On 4/14/22 12:35, Fawzi Khaber wrote:=0A=
> Hello Jonathan,=0A=
> We are currently implementing a new driver for an invensense chip similar=
=A0to=0A=
> iio/imu/inv_icm42600. The chip has 2 sensors a gyroscope and an=0A=
> accelerometer, and we are wandering if it was better the have two=0A=
> IIO devices, one for each sensor, or just one IIO device with two buffers=
.=0A=
=0A=
Are these two completely independent sensors that only sit in the same =0A=
package or do they share a common clock and the data acquisition can be =0A=
synchronized?=0A=
=0A=
If it is the latter the best might be to have a single device with a =0A=
single buffer.=0A=
=0A=
Typical algorithms that process IMU data, like odometry, want to process =
=0A=
the accelerator and gyroscope data jointly. If the data gets =0A=
artificially separated into two buffers it first has to be re-aligned, =0A=
which might be tricky to do.=0A=
=0A=
- Lars=0A=
