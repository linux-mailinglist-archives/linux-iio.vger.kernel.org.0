Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397513497B8
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 18:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCYRSN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 13:18:13 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:25276 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhCYRRs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 13:17:48 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 13:17:48 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12PH8NUw012501;
        Thu, 25 Mar 2021 10:10:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=sQ8zVwK4YGxWALKXCz83Ebs5cQCI8Ap30T/A9RwE86k=;
 b=nxJUJaSSB1IXE0Fz+D+k9snhMPUMu9AigSpCoJLPfbP5ZlFPwvDNmFEQaQoZqzNj13/X
 Hle8/qq2jrS8ERa6MMKD+CgRu4Sk9WBVORd+GmAkbP4ETaohpH4MeyaAGAYQLMZnOQhO
 pMW3iuRQmxohMIrot7s2RerlONINKWXmliLxf7Lu09+0AjZ72j9TbKXfM4s2PcF3HB11
 1lPksD9JbR231zT+5M55yBbgbMDlbRN7HvAkdYD/8iHWIhWvICas10fwtq/0pimhjly7
 MevmaEWECllsKAyphl7PNodVEUUqRTgEpxujEIoWRHWt4Mzq0m5EQRFHFBL5DRx3pwm8 wg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0b-00328301.pphosted.com with ESMTP id 37dd0nbckt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 10:10:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaFtJH1umpTDKH26YTDiYKZc5OnDtuZtZQj4Q6JEnQ8JyQX8OPX42a5U11OrzwxI0O66/iDrbEh1oAGnbhY7B2aCYzKLKfGMqg4REUAfzMWC3crisTdH4avLJeBd8p8ZVzeK9fhBKhvUpuA3oTRXS6jmK6lxZHxQX1QxJ/x4C+rza9AsCKVtR2lCqc83ae65WoOjpUo+aQLWzGQICKOY5nnc7dB2D5diJk60LqXKI++ncges2bOkQ7aRcb+ar76Oh0xJyw0DQ5RfmNyD4hy9oJGkAUD1NVftvy2o8HMLjabgK2eEUvxhBpnh7Kivsq2nO+6yXGgcb1y311ECcXOZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ8zVwK4YGxWALKXCz83Ebs5cQCI8Ap30T/A9RwE86k=;
 b=lXBD1yVc0KnTV+HWfOMWkB51ble0UIAzR+icxQN2N5r3ruI9ggDBGaGupLls1sUUIDZTD9wmEjeIqnvTcVLoEeMmy0xJOGjGmUJtzyJQ/JcOEo/Z4R72yRqiCq8aQ3qgqxO9AAA2wftDXmNd1/cGOxsnPDBdaa95c4xm0ByB1XZx44gpUmyqQiAS6mAKhEwDxxQpzupegRXsq+0skjoV1oS/28qlsq8oEvNrGwgfB33gDsMTx4pLlhJBkJXhyaqp4aKKRupnFwmeOR/y0tHqzVTi3XrZAIzw1zn1LecRFDCmav722SpmecQ7z1UyXBNvMEu/68J6atcuCrGGL5gfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ8zVwK4YGxWALKXCz83Ebs5cQCI8Ap30T/A9RwE86k=;
 b=IoIRIdUtRSADIEvMZAHxqbK1ADjjEMEbj87DEEO79vUwalJm2BUSSMPUe9jHh33H7bsyw6XYAn2eTGTPwZ/5yQvmNO3lhSDjs56TV58fItEURtar1+iVosKMr2KvvnvFG7bVeNFDj5qsS0O/4YbMpJZy4dp3B/GGL8q8KgkoX38=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Thu, 25 Mar
 2021 17:10:40 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::a408:8724:ea62:dd38]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::a408:8724:ea62:dd38%4]) with mapi id 15.20.3977.024; Thu, 25 Mar 2021
 17:10:40 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: inv_mpu6050: Remove superfluous indio_dev->modes
 assignment
Thread-Topic: [PATCH 1/2] iio: inv_mpu6050: Remove superfluous
 indio_dev->modes assignment
Thread-Index: AQHXIXhPwqHls4Pu90miUl/QqwAio6qU8Hsj
Date:   Thu, 25 Mar 2021 17:10:40 +0000
Message-ID: <BL0PR12MB5011182CF745D0F2637E7A02C4629@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210325131046.13383-1-lars@metafoo.de>
In-Reply-To: <20210325131046.13383-1-lars@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f58bb58f-288a-4349-025c-08d8efb0eadc
x-ms-traffictypediagnostic: MN2PR12MB4487:
x-microsoft-antispam-prvs: <MN2PR12MB4487A34D62E83F3FF7DF31CEC4629@MN2PR12MB4487.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tirjf3gBUmss2rD0qUJIMJasZjPrRvjRwT8QvpIBWPpLwFGkrh5MB3Hs6IoFV8Y2ssKcHiIRfpzYFXB2La5wwc8hOxE6I9ZscDW5m6j5yxdWosnawHlxucUk/Izne7mGYVEb/MfHDg/oG5r22HIyl2hnuYxh8Zj1xTVN70AmiTFzn/ggQd9EJK9I3cMGUThwP0CmtX7oFBLjBAryv6a/ddpmtA4wngvwIdbShfZm11SQ5dwc1pz5WjjZYe1aR58Tpvg8HN2dWymWshOEukcjrF3VKXyd1qZ0RSIQNSkb2E/DBfocY3ui7PGQl5VRjCpnRtEsu2pbyCbph7mzscbqqNQmIXDTitmbWIte44EWab9WwtkAIpidzzJtvrWDHjKoefRh0mNz4NWGQDfdLvPN6sc+behkbqS6MGiejjvEv2QyMRpa0mzcfuO0mwH9Mf45FmpDRuM6s9NtmNbP8CDMFXhVAkIZSxjGW9A9lMbbuECpbDC9qhi4B++jd5N5sIRS2rlIP+iSRACysF72w1DTUIhoSwRGF/DpU5qXeYxiy90a+iMlddKSnxfxdLK70XWRJP0HgDqnLwPkY1Mh1Lg9GYJw61nWYvEncK37S6Vjar9CmbD6YZKmXFdDwEk8/MmiRtlnka3exov6VhSEWow39JG/6qvPUVzs4iyigNyCZKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(39850400004)(136003)(376002)(478600001)(9686003)(64756008)(66556008)(66476007)(7696005)(66446008)(91956017)(76116006)(66946007)(4326008)(71200400001)(55016002)(86362001)(83380400001)(54906003)(110136005)(316002)(8936002)(8676002)(33656002)(26005)(6506007)(186003)(5660300002)(38100700001)(53546011)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?tlTN53s/Z+hDHstggYYq5a+pS8sg4mT3lMqO+vZye+T3ifxZXy6qDWfqrH?=
 =?iso-8859-1?Q?EQV9F+NfQuDqDqGVt7aXd4AyDJkwWt4PE5bY1vQ+l1NbDNyYh4JQ23urUo?=
 =?iso-8859-1?Q?mMbT81jimJEMc2zqH/0LCq0nHB0puAd3bv52qoWz3p+Tkv/0sRUvXdx48c?=
 =?iso-8859-1?Q?DD8RNhGLcWVqEXF/XoCqNxIBm7s/WFAgvCq2klxQrizy2eIA0UNIekrnP6?=
 =?iso-8859-1?Q?Dqr5C0wVsOFfM4uYFyO5u6zYrVV7OFRJzUm3Xgcukr9bLZK+NUBe0pcHWV?=
 =?iso-8859-1?Q?f2Mo+IxiKZjRJyVgcn/byLNnhFJjoQp6QuPorRp6ofLAmfXeuTPJWEKqHd?=
 =?iso-8859-1?Q?Eo6igFRsOkihEdh0/9rNDq+1tBFt2kQ9PtyNEn/yqj8K+RpK6+NTxUZEdR?=
 =?iso-8859-1?Q?YbOWjgGJaCc+N0YNXW800vETb4iZrSv94pHJKJmpBTr17rsug4Wnh8s/PF?=
 =?iso-8859-1?Q?PsQ3XCFFFiCDaqR7aGl0DudF3JrdOyMww8D1hSmdIBruvqAac93dk5scru?=
 =?iso-8859-1?Q?yJj1UBxjXm3Hv4vbg4HAOjbSFZ/E2UzdixyyZg6yM7eJUJPuCUOciwQX9a?=
 =?iso-8859-1?Q?qRQwaxJiN4W74qTwKDCAAcCB5oCHRupmv3blBwLrLszPCfQS5SIohX5SEM?=
 =?iso-8859-1?Q?fmO3BHgd5adlwztqpLORCoiBuPlw3+E+NM6YIylsL3wvll1ah4q1FDiwSH?=
 =?iso-8859-1?Q?aXGA2hRjS+av2jg8SCaan2fb7Rg72vvJkn+eEOQzZaQKoIyTAzl72WLGdC?=
 =?iso-8859-1?Q?vu8bD2H3x0eevDkq6qyjvEZfQWuO9ugzc7MqFk96bTClAmTz9T0u1R/2jS?=
 =?iso-8859-1?Q?ABBvDk+30QpDmSzKbYI4XHuqCz87AC3yx5NBSsbPG9HhRsf3jd6U0FsJ27?=
 =?iso-8859-1?Q?g7jI9IWWluliEyGgIYSc8M6KcA+LZZ+g+lVRWbEjYWG6Esf7zzz/8a0hca?=
 =?iso-8859-1?Q?Qc3IQMnzE35owbOQ9YupjV78PXc4i68QCBwJmhJci3NI8roEUozgQZ/Z2B?=
 =?iso-8859-1?Q?hUdT0zS/HDECu72aiGtzStkWrOpEhS0fDkBWTUBNw+6MlaP5tVXdK0+Gfa?=
 =?iso-8859-1?Q?G9NZPB8jlOQMbpWMw5LvSCdAFHZ+D3o+FSteeFdcpgbOrHlX0gCTkSfGQU?=
 =?iso-8859-1?Q?Wf+56DwkcvxgSSQv6i1Ah3XdJ0woFS94/Y6Gh7lSGYI4cE+RZA0FDoZfcZ?=
 =?iso-8859-1?Q?vxWC9jCj+q3TAoONK3ZmuU2TqQObEDH3HvbQ4Km/vne5/NG1LtjzicqWrE?=
 =?iso-8859-1?Q?olI4C3RyM9hTrudX3/IHGgKpS1fyeUm4Yy51E7YmmARwiERkfiijg/kRcg?=
 =?iso-8859-1?Q?KximQ3jfwlxCDnTviDLHbyZ5BY83LxatTOQAQQ7fKhK36jw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58bb58f-288a-4349-025c-08d8efb0eadc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 17:10:40.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjWbZV4WQKbEcuNKc6b8tZtXwi5iGwE1tfwXRVHFB6PmHnyrP6JjnZK1h+QBqjMksGe4ndxLHIShgm6wNVPjEmLXqUKFpKlqaYXzY+onHFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_05:2021-03-24,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250124
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
thanks for the patch,=0A=
JB=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
From: Lars-Peter Clausen <lars@metafoo.de>=0A=
Sent: Thursday, March 25, 2021 14:10=0A=
To: Jonathan Cameron <jic23@kernel.org>=0A=
Cc: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; Linus Walleij <linus=
.walleij@linaro.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=
; Lars-Peter Clausen <lars@metafoo.de>=0A=
Subject: [PATCH 1/2] iio: inv_mpu6050: Remove superfluous indio_dev->modes =
assignment =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
The inv_mpu6050 driver manually assigns the indio_dev->modes property. But=
=0A=
this is not necessary since it will be setup in iio_trigger_buffer_setup().=
=0A=
=0A=
Remove the manual assignment.=0A=
=0A=
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 1 -=0A=
=A01 file changed, 1 deletion(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 453c51c79655..99ee0a218875 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -1591,7 +1591,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq=
, const char *name,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->info =3D &mpu_info;=0A=
-=A0=A0=A0=A0=A0=A0 indio_dev->modes =3D INDIO_BUFFER_TRIGGERED;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 result =3D devm_iio_triggered_buffer_setup(dev, in=
dio_dev,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ii=
o_pollfunc_store_time,=0A=
-- =0A=
2.20.1=0A=
