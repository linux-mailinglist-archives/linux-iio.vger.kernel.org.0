Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26987722F46
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jun 2023 21:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjFETIU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jun 2023 15:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjFETIS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jun 2023 15:08:18 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4E183
        for <linux-iio@vger.kernel.org>; Mon,  5 Jun 2023 12:08:06 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3559989b029593;
        Mon, 5 Jun 2023 19:07:44 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2174.outbound.protection.outlook.com [104.47.7.174])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qyuvwsdw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 19:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcDdN4vIX4X9meosgUv8AHsPl2GzXfNGUABzNwpKQDJ8hIoNP+1mQyx8VZWB6tLtYiwyvRKepC/lG0onSc29jYH+EM7UO1/DAbcIuxKROKfAahp5oBGffvwbjJ+VkfA2gQeAIS7KfvEYBmz15bq/2L4zpoHaL75ItFP0b6BO3+7zfpWBhi5smx36n6ZCrxpgKF6QwgUZqWUPzrRNAMkcaLShDdvR7IJg1dzUXymeyivO6JJ1aWlxFTI/JjqL4KuYDI7t51JVahs1OZn05n/Rdrnha7XuLqvfcCC/iAtNGAVYjiLO0cofqtZLhcIjoxu108Im/LJEq9dFwFiPtWq+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bzivIkt381dPNEFAKp+/NYybHqDBW4vkulGiz5ilPY=;
 b=Q4tyAbT54jmRFVT4RcA+14JDxMKqpoVbwPlcaIqu8yaRQBLGeTS7tTtAcV9/rnB8Fh0WtWbSMvrcy3sjzdwa0O9B5jui6dq1X3kJPDEf8RoNgO2XnrDtZsWzbZgKa3RFFl7Yq9k4cUV0/1QbrGWCSkng6XhKe6Gbl/C6TQ6vbfu72QWdDgyRWpJxJRVKYBiYOzOQFnugFu5v6SQKO4hh43rS0HlYQEW+ef7zFCPR+0ByMvySKMFjPeY9+aiCf4MPX56G4M14/s8e4Uo4DwdbuG2gO6ZkmmuOtT9xKqait6MbpvUBI8/Tl9wgd+NJh724DVgPf7oB7U0e58NIu5XdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bzivIkt381dPNEFAKp+/NYybHqDBW4vkulGiz5ilPY=;
 b=Uipj8IYi02KjMKwvXe+ubsBmWk9t3d3F4ULj491npgKkuvzi0Nkaihfpm6ciWE12V9aDQJ17iG7HHwzpLREm7cEE4xspq0Zomcv+XDfA2fecHk7SJmZzk0/3FocPBkpEwWUfgN2e+a1UemCTD0yr1q/7fqboifppU4/bLI/bTkqkUdFJYjjpImyl+6NGfI4KpjmRJ6Ip/j4rnqsbYuk258uJekJCMmUgHuyen20T6wK2IHdpkyfAqrvEGK+33Ur7EsFm1G9ukHL/rENse+CnEAaF4B4nypjWVKBvMKYgJGx4WNWTkiYt9YMuftXkIsCp42Tpr+Fmgg94EGbpetAy1A==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FRYP281MB0143.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 19:07:38 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c434:2e16:6b03:478d]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c434:2e16:6b03:478d%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 19:07:38 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        INV Git Commit <INV.git-commit@tdk.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 2/4] iio: move inv_icm42600 timestamp module in common
Thread-Topic: [PATCH 2/4] iio: move inv_icm42600 timestamp module in common
Thread-Index: AQHZk8vLXshAC0YkUkWtW/fl4IETb696f3aAgAIaZOA=
Date:   Mon, 5 Jun 2023 19:07:38 +0000
Message-ID: <FR3P281MB1757824DF1984104059CA9D0CE4DA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
        <20230531142513.48507-3-inv.git-commit@tdk.com>
 <20230604115843.5f887bb4@jic23-huawei>
In-Reply-To: <20230604115843.5f887bb4@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FRYP281MB0143:EE_
x-ms-office365-filtering-correlation-id: 753e9b57-5225-41b2-feca-08db65f82128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qw3TDCpVwfgABpxsvBwlJWxSDsZxpozevIvgfurTawlvsDzOB3lHxonkpSDypJVJxatn5T+XrZfEOeAmc69p01J93k1c7Q9fM7IumxeQT8FLUMtsWGA9PuevGWkHE7CAcj4CAlr/YvpvDKsyTJDtkduUBdUt0MdmqGjXkwjbjPZGg7kzsyN7HX1zUP6sam/wyCq0ZzjGPtOjUBeL2lniGkRI+otpGugQb0udhzlTH9cM3SMrGiDQmxd6LI2U4fY4iFV9YITYcHtiOOy7uOlLPsafxctWah9hC2DjOoyk6J4t/17O0wzOxhEaaaDeIDojKMC08szDCAMDmSm4KM/BiWr1aL3JZmBCDh7WoNSGykheXhUicPLFyJ9pECtJB/tgtClvYf760Yxu6RnCMpX9PM2NBgWPXvR92gi9aPh6W+X3q8NJH6/RO9EppBRmPr2TLoGX18x3iFAfFuwknSMKjiHk++Cq2sm4Z5nfA2r/oxhpvJRyOpXeHqfP9sXtvUxaTvRCWl2MlCqHx7JME6+PrpdDBMWYSafgH4gThG+vwKT58GTPpBlb49OvYhhSdmnmvF13S3eIcxHrNP9Lp7uj1T4s2ubhtTMsLdQZmI9ET4HIxmxNuSdw44TL/Np6v0hQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(2906002)(38070700005)(33656002)(86362001)(5660300002)(52536014)(55016003)(83380400001)(71200400001)(7696005)(186003)(6506007)(9686003)(53546011)(91956017)(478600001)(110136005)(54906003)(76116006)(66446008)(66476007)(64756008)(66556008)(316002)(38100700002)(6636002)(4326008)(66946007)(122000001)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?C9XhFPbs5pcTiFLOeG+OfMhyUOCIqKHbl4cx7d8ocOL2zlKFBvg89j1oyc?=
 =?iso-8859-1?Q?a6srXqg09R31BTa55LH3Rm7RQBMgeS0jtywEFNl8tByliLyKeKAi6B/cMq?=
 =?iso-8859-1?Q?sEGhwJpDE/zD7CJ1jau4Bp++mQEEpY8+STCfNfAgwxiWu83nfxfrQvLiXp?=
 =?iso-8859-1?Q?6O2GxEkrOx/leM3MJt+nIH5dUrQthjzRyvQiChRSYfC19mNFoBeimrV7Qt?=
 =?iso-8859-1?Q?RPMJsIMzhZAtJSfrq9u+NwLReOEZPnNbbVOKOIfrm32Kj3gCtfjd5F/B0k?=
 =?iso-8859-1?Q?pmfyL13oAkz4pZoNP8wqTcujhISaJTCigw61IEK340rzsZVEIlUEw4H6Ly?=
 =?iso-8859-1?Q?9zvTb6DzKNFJXkSEaq2eMhAqKBPfbBL0SflaOhTfCqHteN5hfJzKQhqB+R?=
 =?iso-8859-1?Q?mMeXef4WklzL6MbsRb/mQYkh0wBISFr4lgxWLpNm6biv3QwhzDeJzJpIHa?=
 =?iso-8859-1?Q?xr1N5gqD+lvk3z2bs43gVuP5szkQhe58yLdUJpOPmzlJZ6hgyrWuKAJvE1?=
 =?iso-8859-1?Q?Jp6rH2ln5TzNeU+hIxkelrC7kthFENMhKI2LpjKSIfgcltj9Y8h2bUOH2Q?=
 =?iso-8859-1?Q?BSyTt9bg+xwQ49jJzuOQWdDBoso5HF87XxZ06sCMr3JntHjEX92VgRKZ3X?=
 =?iso-8859-1?Q?ZBIo4T+ZVbeo1h3HiUf8Nk4aejtCDeX1X0qGX+G8ngKhFkWzVL+aCtBlZQ?=
 =?iso-8859-1?Q?oL+ouPpKvYpuebhfEyIu8qBmV6vBas0ggSg8WytlSk7Y/4CFlQZedqZC3z?=
 =?iso-8859-1?Q?N/V0XOl2WmRhGcSSSNRWYyrXErl6Ya+Yk1pMEpwoXwp/5p7eIMhsPPOsw3?=
 =?iso-8859-1?Q?CJQCIx0haztJ8nWU9yy3WYzZ5t8B4KwqvZWo0vEZfr9erVA8s+P8DUTgBy?=
 =?iso-8859-1?Q?68euVhZahC1efp3Bt/X4By8uCXcBH8oWJWgU/DxHFGqgIt1rJ5+osfRy7i?=
 =?iso-8859-1?Q?w8vY0EEFhcng5ui3YsZXPfL+rP0QJDCpfZjwnftvcEWnLeeeMbgy93KlBD?=
 =?iso-8859-1?Q?xU0Zj+Xlo/AepWsTcRoEhEpG9hV9ZxYyDtZY1p5ZhyKlxB+7Eu+vn2xUhi?=
 =?iso-8859-1?Q?k7padFNCJ6fXpAcQYeiHSpm9nJj/v2Wr7F5pW5Osl1H2JqjFOmy43W5c/H?=
 =?iso-8859-1?Q?ao4xFVpi7ugOt7rGgMwbymJrohH9OHGWAbrCTSzUyLLGmG7cuOE6f09H1D?=
 =?iso-8859-1?Q?t5INZLiPXFBq5wdlmfvbX1lQv8epUXloIZZjRSsdRGH4GYmYm76RulsImq?=
 =?iso-8859-1?Q?jZB4OCzaj9mrRDSppwZTfJx1Ro9sRcydQqwRo3zDGL45F7uGKN3nlmZLm5?=
 =?iso-8859-1?Q?4MXqZ/VfOC7Pjhx2DbOuziDtzUB1Dy7NcBjqEIhDNeJgW4nvZ8gnOpIrQ5?=
 =?iso-8859-1?Q?Gj2F27KEbGAJAWWtGODsfkL43CktHgaiKxxPFAK8jgIkJojkwChVndY6RD?=
 =?iso-8859-1?Q?7CGMk0w5Di3iKeUwAMpOzETPyO8XvMlC0jekanBRR6difinZvcel5mfDnR?=
 =?iso-8859-1?Q?J4oNdCv1oqou67VSi+0HK4Y+rdEwHWdmwl3+AbTqPhZKpIddWnX10oHnI+?=
 =?iso-8859-1?Q?VNT+/wOVd07JkTXiPfVVdPkIv3eGOnWByvD2F6K1PhEUwx/pXfMZ1EwGN0?=
 =?iso-8859-1?Q?bst+jpNNHlYVXDzjdgUvzVoHZQBCe4paWaD0QSffEf6DzVjYqaz7/mTR+E?=
 =?iso-8859-1?Q?b55X/vOrevTOBJ3LjVX9oPwDxIDueeucaS6e+RJkpC574a44+WBl/MOqgI?=
 =?iso-8859-1?Q?soIg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 753e9b57-5225-41b2-feca-08db65f82128
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 19:07:38.5285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXWQNy1STLvJKl/qUzA/7RZpNLiOlEJrFyjrr7gYq0/CRXZtSlII1ima0EvPWXbYwDl9dagadLW3GszO/UZEEyr0TL9wRyf994k1ny11Y3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
currently only IMU drivers will be using this timestamp module. But we have=
 other new chips (pressure sensor for example) that could use it in the fut=
ure.=0A=
=0A=
So I prefer keeping this module more general to avoid being obliged to move=
 it in the future.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, June 4, 2023 12:58=0A=
To: INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; lars@metafoo.de =
<lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=
=0A=
Subject: Re: [PATCH 2/4] iio: move inv_icm42600 timestamp module in common =
=0A=
=A0=0A=
[CAUTION] This is an EXTERNAL email. Do not click links or open attachments=
 unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
On Wed, 31 May 2023 14:25:11 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Create new inv_sensors common modules and move inv_icm42600=0A=
> timestamp module inside.=0A=
> Modify inv_icm42600 driver to use timestamp module.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
Hi Jean-Baptiste,=0A=
=0A=
Any plan to use this outside of IMU drivers?=A0 If not I'd be tempted=0A=
to keep it more local.=0A=
=0A=
drivers/iio/imu/inv_common/ or similar and avoid the global=0A=
header by using a "../inv_common/" include path.=0A=
=0A=
Changes themselves look fine to me.=0A=
=0A=
Jonathan=0A=
=0A=
> ---=0A=
>=A0 drivers/iio/common/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +=0A=
>=A0 drivers/iio/common/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +=0A=
>=A0 drivers/iio/common/inv_sensors/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0 7 +++++++=0A=
>=A0 drivers/iio/common/inv_sensors/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0 6 ++++++=0A=
>=A0 .../inv_sensors}/inv_icm42600_timestamp.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 | 12 ++++++++++--=0A=
>=A0 drivers/iio/imu/inv_icm42600/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 1 +=0A=
>=A0 drivers/iio/imu/inv_icm42600/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0 1 -=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=A0=A0=A0 |=A0 2 +-=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=A0=A0 |=A0 2 +-=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=A0=A0=A0=A0 |=A0 3 ++=
-=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=A0=A0=A0=A0 |=A0 2 +-=
=0A=
>=A0 .../linux/iio/common}/inv_icm42600_timestamp.h=A0=A0=A0=A0=A0=A0 |=A0 =
0=0A=
>=A0 12 files changed, 31 insertions(+), 7 deletions(-)=0A=
>=A0 create mode 100644 drivers/iio/common/inv_sensors/Kconfig=0A=
>=A0 create mode 100644 drivers/iio/common/inv_sensors/Makefile=0A=
>=A0 rename drivers/iio/{imu/inv_icm42600 =3D> common/inv_sensors}/inv_icm4=
2600_timestamp.c (91%)=0A=
>=A0 rename {drivers/iio/imu/inv_icm42600 =3D> include/linux/iio/common}/in=
v_icm42600_timestamp.h (100%)=0A=
> =0A=
> diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig=0A=
> index 0334b4954773..1ccb5ccf3706 100644=0A=
> --- a/drivers/iio/common/Kconfig=0A=
> +++ b/drivers/iio/common/Kconfig=0A=
> @@ -5,6 +5,7 @@=0A=
>=A0 =0A=
>=A0 source "drivers/iio/common/cros_ec_sensors/Kconfig"=0A=
>=A0 source "drivers/iio/common/hid-sensors/Kconfig"=0A=
> +source "drivers/iio/common/inv_sensors/Kconfig"=0A=
>=A0 source "drivers/iio/common/ms_sensors/Kconfig"=0A=
>=A0 source "drivers/iio/common/scmi_sensors/Kconfig"=0A=
>=A0 source "drivers/iio/common/ssp_sensors/Kconfig"=0A=
> diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile=0A=
> index fad40e1e1718..d3e952239a62 100644=0A=
> --- a/drivers/iio/common/Makefile=0A=
> +++ b/drivers/iio/common/Makefile=0A=
> @@ -10,6 +10,7 @@=0A=
>=A0 # When adding new entries keep the list in alphabetical order=0A=
>=A0 obj-y +=3D cros_ec_sensors/=0A=
>=A0 obj-y +=3D hid-sensors/=0A=
> +obj-y +=3D inv_sensors/=0A=
>=A0 obj-y +=3D ms_sensors/=0A=
>=A0 obj-y +=3D scmi_sensors/=0A=
>=A0 obj-y +=3D ssp_sensors/=0A=
> diff --git a/drivers/iio/common/inv_sensors/Kconfig b/drivers/iio/common/=
inv_sensors/Kconfig=0A=
> new file mode 100644=0A=
> index 000000000000..28815fb43157=0A=
> --- /dev/null=0A=
> +++ b/drivers/iio/common/inv_sensors/Kconfig=0A=
> @@ -0,0 +1,7 @@=0A=
> +# SPDX-License-Identifier: GPL-2.0-only=0A=
> +#=0A=
> +# TDK-InvenSense sensors common library=0A=
> +#=0A=
> +=0A=
> +config IIO_INV_SENSORS_TIMESTAMP=0A=
> +=A0=A0=A0=A0 tristate=0A=
> diff --git a/drivers/iio/common/inv_sensors/Makefile b/drivers/iio/common=
/inv_sensors/Makefile=0A=
> new file mode 100644=0A=
> index 000000000000..93bddb9356b8=0A=
> --- /dev/null=0A=
> +++ b/drivers/iio/common/inv_sensors/Makefile=0A=
> @@ -0,0 +1,6 @@=0A=
> +# SPDX-License-Identifier: GPL-2.0=0A=
> +#=0A=
> +# Makefile for TDK-InvenSense sensors module.=0A=
> +#=0A=
> +=0A=
> +obj-$(CONFIG_IIO_INV_SENSORS_TIMESTAMP) +=3D inv_icm42600_timestamp.o=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/driv=
ers/iio/common/inv_sensors/inv_icm42600_timestamp.c=0A=
> similarity index 91%=0A=
> rename from drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c=0A=
> rename to drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c=0A=
> index ceae8ccb1747..411f561e1a24 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c=0A=
> +++ b/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c=0A=
> @@ -5,9 +5,9 @@=0A=
>=A0 =0A=
>=A0 #include <linux/kernel.h>=0A=
>=A0 #include <linux/math64.h>=0A=
> +#include <linux/module.h>=0A=
>=A0 #include <linux/errno.h>=0A=
> -=0A=
> -#include "inv_icm42600_timestamp.h"=0A=
> +#include <linux/iio/common/inv_icm42600_timestamp.h>=0A=
>=A0 =0A=
>=A0 /* internal chip period is 32kHz, 31250ns */=0A=
>=A0 #define INV_ICM42600_TIMESTAMP_PERIOD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 31250=0A=
> @@ -54,6 +54,7 @@ void inv_icm42600_timestamp_init(struct inv_icm42600_ti=
mestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* use theoretical value for chip period */=0A=
>=A0=A0=A0=A0=A0=A0=A0 inv_update_acc(&ts->chip_period, INV_ICM42600_TIMEST=
AMP_PERIOD);=0A=
>=A0 }=0A=
> +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_init, IIO_INV_SENSORS_TIMEST=
AMP);=0A=
>=A0 =0A=
>=A0 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *t=
s,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t period, bool fifo)=0A=
> @@ -66,6 +67,7 @@ int inv_icm42600_timestamp_update_odr(struct inv_icm426=
00_timestamp *ts,=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
>=A0 }=0A=
> +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_update_odr, IIO_INV_SENSORS_=
TIMESTAMP);=0A=
>=A0 =0A=
>=A0 static bool inv_validate_period(uint32_t period, uint32_t mult)=0A=
>=A0 {=0A=
> @@ -153,6 +155,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm4=
2600_timestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (valid)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_align_timestamp_it(ts);=
=0A=
>=A0 }=0A=
> +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_interrupt, IIO_INV_SENSORS_T=
IMESTAMP);=0A=
>=A0 =0A=
>=A0 void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *t=
s,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t fifo_period, size_t fifo_n=
b,=0A=
> @@ -184,3 +187,8 @@ void inv_icm42600_timestamp_apply_odr(struct inv_icm4=
2600_timestamp *ts,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ts->timestamp =3D ts->it.up =
- interval;=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0 }=0A=
> +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_apply_odr, IIO_INV_SENSORS_T=
IMESTAMP);=0A=
> +=0A=
> +MODULE_AUTHOR("InvenSense, Inc.");=0A=
> +MODULE_DESCRIPTION("InvenSense sensors timestamp module");=0A=
> +MODULE_LICENSE("GPL");=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_i=
cm42600/Kconfig=0A=
> index 50cbcfcb6cf1..f56b0816cc4d 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/Kconfig=0A=
> +++ b/drivers/iio/imu/inv_icm42600/Kconfig=0A=
> @@ -3,6 +3,7 @@=0A=
>=A0 config INV_ICM42600=0A=
>=A0=A0=A0=A0=A0=A0=A0 tristate=0A=
>=A0=A0=A0=A0=A0=A0=A0 select IIO_BUFFER=0A=
> +=A0=A0=A0=A0 select IIO_INV_SENSORS_TIMESTAMP=0A=
>=A0 =0A=
>=A0 config INV_ICM42600_I2C=0A=
>=A0=A0=A0=A0=A0=A0=A0 tristate "InvenSense ICM-426xx I2C driver"=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_=
icm42600/Makefile=0A=
> index 291714d9aa54..0f49f6df3647 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/Makefile=0A=
> +++ b/drivers/iio/imu/inv_icm42600/Makefile=0A=
> @@ -6,7 +6,6 @@ inv-icm42600-y +=3D inv_icm42600_gyro.o=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_accel.o=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_temp.o=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_buffer.o=0A=
> -inv-icm42600-y +=3D inv_icm42600_timestamp.o=0A=
>=A0 =0A=
>=A0 obj-$(CONFIG_INV_ICM42600_I2C) +=3D inv-icm42600-i2c.o=0A=
>=A0 inv-icm42600-i2c-y +=3D inv_icm42600_i2c.o=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> index c3f433ad3af6..1015de636a94 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> @@ -12,12 +12,12 @@=0A=
>=A0 #include <linux/math64.h>=0A=
>=A0 #include <linux/iio/iio.h>=0A=
>=A0 #include <linux/iio/buffer.h>=0A=
> +#include <linux/iio/common/inv_icm42600_timestamp.h>=0A=
>=A0 #include <linux/iio/kfifo_buf.h>=0A=
>=A0 =0A=
>=A0 #include "inv_icm42600.h"=0A=
>=A0 #include "inv_icm42600_temp.h"=0A=
>=A0 #include "inv_icm42600_buffer.h"=0A=
> -#include "inv_icm42600_timestamp.h"=0A=
>=A0 =0A=
>=A0 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> index 32d7f8364230..4a39d31e911f 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> @@ -11,9 +11,9 @@=0A=
>=A0 #include <linux/delay.h>=0A=
>=A0 #include <linux/iio/iio.h>=0A=
>=A0 #include <linux/iio/buffer.h>=0A=
> +#include <linux/iio/common/inv_icm42600_timestamp.h>=0A=
>=A0 =0A=
>=A0 #include "inv_icm42600.h"=0A=
> -#include "inv_icm42600_timestamp.h"=0A=
>=A0 #include "inv_icm42600_buffer.h"=0A=
>=A0 =0A=
>=A0 /* FIFO header: 1 byte */=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
> index c34735b05830..f3e379f9733d 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> @@ -16,10 +16,10 @@=0A=
>=A0 #include <linux/property.h>=0A=
>=A0 #include <linux/regmap.h>=0A=
>=A0 #include <linux/iio/iio.h>=0A=
> +#include <linux/iio/common/inv_icm42600_timestamp.h>=0A=
>=A0 =0A=
>=A0 #include "inv_icm42600.h"=0A=
>=A0 #include "inv_icm42600_buffer.h"=0A=
> -#include "inv_icm42600_timestamp.h"=0A=
>=A0 =0A=
>=A0 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] =3D =
{=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=0A=
> @@ -799,3 +799,4 @@ EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42600_pm_ops, IIO_ICM=
42600) =3D {=0A=
>=A0 MODULE_AUTHOR("InvenSense, Inc.");=0A=
>=A0 MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");=0A=
>=A0 MODULE_LICENSE("GPL");=0A=
> +MODULE_IMPORT_NS(IIO_INV_SENSORS_TIMESTAMP);=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
> index 9d94a8518e3c..6caea7b8a344 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
> @@ -12,12 +12,12 @@=0A=
>=A0 #include <linux/math64.h>=0A=
>=A0 #include <linux/iio/iio.h>=0A=
>=A0 #include <linux/iio/buffer.h>=0A=
> +#include <linux/iio/common/inv_icm42600_timestamp.h>=0A=
>=A0 #include <linux/iio/kfifo_buf.h>=0A=
>=A0 =0A=
>=A0 #include "inv_icm42600.h"=0A=
>=A0 #include "inv_icm42600_temp.h"=0A=
>=A0 #include "inv_icm42600_buffer.h"=0A=
> -#include "inv_icm42600_timestamp.h"=0A=
>=A0 =0A=
>=A0 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/incl=
ude/linux/iio/common/inv_icm42600_timestamp.h=0A=
> similarity index 100%=0A=
> rename from drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h=0A=
> rename to include/linux/iio/common/inv_icm42600_timestamp.h=0A=
