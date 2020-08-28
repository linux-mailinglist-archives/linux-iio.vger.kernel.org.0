Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82362554E8
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 09:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgH1HLN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 03:11:13 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:33768 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbgH1HLM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 03:11:12 -0400
X-Greylist: delayed 2064 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2020 03:11:10 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 07S6STNB000878;
        Thu, 27 Aug 2020 23:36:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=s3oNc/aroHRT0LGnJ6MatEAtknT0o3rAkQWAPHki2hM=;
 b=ag/+CjI3qGXmaV3HPJkJSZ1MgRj3K6OLzEu0bnelboHntV7rhcnpMf5sQRA5gVSZxJHt
 Xs3C0MF33IxQ76/ZxMB3XOd26t87Ct29gFOG/z4Da8JGMgVTg2qITwsuU+chThF43V/t
 pr9YU5jQE2U3+hZw2YBXy6h/9yYEciPnF2X6seaEQ4iyYK/pKXChgq0s8D93SquLjYcX
 rn+/McX7PUA+cHvxfwUfcFph7n+C4wJTxdZezQ9yTCNBZ5Bewbf6RNXbupdZJ18kmzkf
 ARTtsgxaWcklDgEFOmODjd0YckVNbIYajXwuARwnTcnX+WQdb769SbAubnnflExxvqLK pw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-00328301.pphosted.com with ESMTP id 33512u9c8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 23:36:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFQG+z3S0xOfyhe+7eMLPVKVu4M5rs4w6yzdvXImpp77Bdf4SwOg5BLBoMTLOSJwTTLAHzDy51G5O4B30Me8nmOIbqd7ClCMxldKWVWUx3CfNRstjwS4wdszrGYiabdPFsQm75xYRQP8uHIjw3bVxMPnTLsv2uEBAIWUXzxtSSwxPj25L1r4wQ89BAozvEEXe37qOABtDVir0J9mSOTSHZNtqa5tMhaB3P8HbDeS5xX1B+LMD3/u4NGK1E3/RwyKIMIV1PmDOHpDhue1Bz1pOjRJW/tbmCBczCmAcwsUwYH4tfqr7RmK1khdHExhctSna7sKcYNwLaMn8uDpBkYQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3oNc/aroHRT0LGnJ6MatEAtknT0o3rAkQWAPHki2hM=;
 b=j0bAcb7akqGMd5WkMVKZwSzyIbYA6+Bnd3TEQlv0xn4TJc2CbB8ASeNdt7oxgfSJge6NVZjhcKIjmC0uzFa2ym+a/fpP5PawN/zlhXrSxpQRJqywNUvRELm3rl72jiAQYPopD+6k0jCZIZu8RsAIDNKWAViTmIwk6vwWKfT5InyABe/85PgziiAbsQ4IMpMawZbX2aol+DzJX57fRZt9O4iWtfFtQY2CBEZHwn1LDkosqhFE7QzF3jZ0CLH1goSSI4bUTJTrqlJX2pL+gjJCko/MWMNmPSamUTRD6ei3qfeiLPvwnY4QY2V554LPme9KyAP4TmkKoE59JAfhsfnHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3oNc/aroHRT0LGnJ6MatEAtknT0o3rAkQWAPHki2hM=;
 b=K0OybrXNcBWDbGUZCmA7ZEf9guopG6XijiJ5mRIPAAEMpXov9Bmj5xh+p9XsSUFlXqicoZrWR5S3Xj56EWHQ6TXmYDV0qZcUPoCaSU+3EpLIBi+2M93BbG6yzIcHG85eRxPiXkXwVKVMhIXdQkezBbDPaV7V3qH7U0V4QYSPi1k=
Received: from MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 06:36:03 +0000
Received: from MN2PR12MB4390.namprd12.prod.outlook.com
 ([fe80::88ac:4a48:bb2a:51b7]) by MN2PR12MB4390.namprd12.prod.outlook.com
 ([fe80::88ac:4a48:bb2a:51b7%9]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 06:36:02 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 13/18] iio: imu: inv_mpu6050: Simplify with
 dev_err_probe()
Thread-Topic: [PATCH v2 13/18] iio: imu: inv_mpu6050: Simplify with
 dev_err_probe()
Thread-Index: AQHWfKhP9EoLl2DH4kG3ErVWqrVkfKlNELaV
Date:   Fri, 28 Aug 2020 06:36:02 +0000
Message-ID: <MN2PR12MB439074B42FE1114B62189130C4520@MN2PR12MB4390.namprd12.prod.outlook.com>
References: <20200827192642.1725-1-krzk@kernel.org>,<20200827192642.1725-13-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-13-krzk@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [2a01:e0a:393:a700:8116:36f6:f0c8:916f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c529cfe-f087-4ab0-b116-08d84b1ca25a
x-ms-traffictypediagnostic: MN2PR12MB4205:
x-microsoft-antispam-prvs: <MN2PR12MB42054E7302A8B7C168CC4A0FC4520@MN2PR12MB4205.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMeFDUcupaFrahFRQmZRXxmZyi0g4ecjwzKuWhGUa33/c1Vrst6MTaXM8czHRSn8f3CeODfjGJt0FdtykYgdKUnT/jumjrYrU1WAtmE4BTQkWDGS9OIecasUjU1SYJke1CrmrFKo8cn32x6ljtlECB6xZerZJKNYaQjmyxEyy4gTATSznvB9SHCJNhX8t4vjHsqJC3OG3iF66yNg/Sk8zxlUW555wVWax5bHkS0y6hTKKBz8crC1n10nOYTYXRCorckGTWb1x98HkwEQOxChhg8834YSmGWFp7aqqHHKTwTvBMcZYJkDCs+vRA7j/U/cdsnuKb+qxEF7/Pdxp8HCAHQfAFbNG3IhLZfc9ElC2X5FxW/bCDTGr4hmn6x59dB6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39850400004)(366004)(136003)(396003)(7696005)(2906002)(33656002)(86362001)(71200400001)(52536014)(5660300002)(83380400001)(110136005)(7416002)(8936002)(64756008)(55016002)(9686003)(186003)(478600001)(8676002)(316002)(66446008)(76116006)(53546011)(66476007)(66556008)(66946007)(91956017)(6506007)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cCZkIEut8EQUM5+mzAVAIQObSeOPcb3mmweEqv5nymqe0UopRbW5x0g+HrSfM5L3SN9gZ+Nm1rqKKw/yRINRFbDpnDgBnoLJOj3dupI2kH1hMPwCv7pFlD5lyBQ0GcMAttfwWUX0gkeET6x0kz45ffGXBq7rWZDXPdTeSd5tezYcPKuVQ1UejqFCMjuAXrBvLJY0ZygbSyWnFtk1WeGiKVOkfKtmgKnthAOKUQXutltQsF2N3PC8izTHvhzj5j05bKZX4mlEAOtFPm10dtASjghqA8Z68LhE91moZBm9SKtPjwQIbDOUo/eP+U/gpfn61RMs6y44JVFuBWdpJkLqNQh8qlAbnw7qFzQBHzxqYIsS9K3tEDp0JzXa7pU5Vh89gRxDq3P4TZp+ji8Y79ZOLaUs32YkAWmCTqtghlE1YigoEdsbp8Zq9FdZ4s+QhrIuKgTyBkgVvNmnJtDCT1zf97+KPYPTOqakaaFOJqbeRQiPO/rgLbyu27ikjogpvtc2Mauiw5nT6dA41alM8PwjoVVKSHdzROCW6bkWqZI0IwI6sitTATkOu0pI+VJ2uhYbeGvzsg/RQzImacXCM5+iZC4i9W0pvFtDWvr1ybyKi7B3tsBs66lvozRa+7N+eK4gtOj/BCPYwA0PpOgYrpt8+osO6QCbVP/NJawcbcfkwA5Z6uUXxbdEyiGy9LzmeizX9YPgAabeJvP86sAMmN5/Tw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c529cfe-f087-4ab0-b116-08d84b1ca25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 06:36:02.4390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGmIj4EPrsJmTxyinPjmc6sYmo35TCcJ/ItiWZli9WxNiSmzr9gdnqUkhmLW20lGlWlSrcwU5o4+esuLKWPO9OzYfmGQ5KR68z+i94pgFb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_03:2020-08-27,2020-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280050
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

thanks for the patch.

Best regards,
JB

Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

________________________________________
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Krzysztof Kozlowski <krzk@kernel.org>
Sent: Thursday, August 27, 2020 21:26
To: Jonathan Cameron; Hartmut Knaack; Lars-Peter Clausen; Peter Meerwald-St=
adler; Peter Rosin; Kukjin Kim; Krzysztof Kozlowski; Michael Hennerich; Kev=
in Hilman; Neil Armstrong; Jerome Brunet; Martin Blumenstingl; Marek Vasut;=
 Maxime Coquelin; Alexandre Torgue; Beniamin Bia; Tomasz Duszynski; Linus W=
alleij; Andy Shevchenko; linux-iio@vger.kernel.org; linux-kernel@vger.kerne=
l.org; linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.=
org; linux-amlogic@lists.infradead.org; linux-stm32@st-md-mailman.stormrepl=
y.com
Subject: [PATCH v2 13/18] iio: imu: inv_mpu6050: Simplify with dev_err_prob=
e()

 CAUTION: This email originated from outside of the organization. Please ma=
ke sure the sender is who they say they are and do not click links or open =
attachments unless you recognize the sender and know the content is safe.

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 3fee3947f772..18a1898e3e34 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1475,22 +1475,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
rq, const char *name,
        }

        st->vdd_supply =3D devm_regulator_get(dev, "vdd");
-       if (IS_ERR(st->vdd_supply)) {
-               if (PTR_ERR(st->vdd_supply) !=3D -EPROBE_DEFER)
-                       dev_err(dev, "Failed to get vdd regulator %d\n",
-                               (int)PTR_ERR(st->vdd_supply));
-
-               return PTR_ERR(st->vdd_supply);
-       }
+       if (IS_ERR(st->vdd_supply))
+               return dev_err_probe(dev, PTR_ERR(st->vdd_supply),
+                                    "Failed to get vdd regulator\n");

        st->vddio_supply =3D devm_regulator_get(dev, "vddio");
-       if (IS_ERR(st->vddio_supply)) {
-               if (PTR_ERR(st->vddio_supply) !=3D -EPROBE_DEFER)
-                       dev_err(dev, "Failed to get vddio regulator %d\n",
-                               (int)PTR_ERR(st->vddio_supply));
-
-               return PTR_ERR(st->vddio_supply);
-       }
+       if (IS_ERR(st->vddio_supply))
+               return dev_err_probe(dev, PTR_ERR(st->vddio_supply),
+                                    "Failed to get vddio regulator\n");

        result =3D regulator_enable(st->vdd_supply);
        if (result) {
--
2.17.1

