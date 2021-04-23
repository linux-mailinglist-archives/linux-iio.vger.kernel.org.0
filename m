Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4F36908E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 12:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhDWKsh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 06:48:37 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:34678 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhDWKsh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 06:48:37 -0400
X-Greylist: delayed 2011 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 06:48:37 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NACNcs003175;
        Fri, 23 Apr 2021 03:14:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=Rppvfr4Kph1CDHM82WwlGyBym3vzZoTvgCXRUA3f45I=;
 b=xuzagHdb99PFiWFqA/QSCYCmP2gAiMN8+jRRgvGJc4/W+Ip2dlipX8/+qv1Slz0sML3D
 xeaF+S+1TRrcuucwUUhnYyJM90iW+yvQ4WOtmMd0Q7XkVD0ET3SIpA+E27gHnJNT55cz
 KBWqM05ufCY+R9uvzgwrg4WPMk6ZmqjzZEl61hjPkMi3eL+fhf2IOWH2oxmqEVKpLa0Z
 uRQbUCiZ3TsuKWzaO4eInWo9FwPYOXyQIZLRvlbPer+l0IZxgsqh+7yWOt9ff9v6kOuo
 RbRhtHRVyevFEhkSA4W0FfrlxdB5hOHcpkCNQTO3Dkk2rE7Sq3adpAi7NLbcnMyqE/P6 pA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00328301.pphosted.com with ESMTP id 383b1p8g1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 03:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjYGbf1zujHatI8ghwu63apmDbdb1F+4+lt4kHWW2yAXoRGwg6hglES5HkHER/oh08Sm1YONlQ/lrvm7CF0qaXJGSZlNuZ8BkPvcgCWbrOl99Zsm/o6zvfX0qVFcSJC8MBO2WGpvHrPOew45PuNjuNGl7c0In3Vp+586gcQSuyhnyr9oiZIwIOnvJzyQSbMMp89fPFlH/c4xIatVk0YPyWWTLn8PZCFenJKmCZXrior0jt2H9wtWJ8OFxxM6nC/bc4xmcEK/Dx/4EaaroUCHGx82ShDOhNBFDu9euzzpGyeNnopFiZMZOtkmSCgbY0nHiSfHT1yce1zmKail8vXlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rppvfr4Kph1CDHM82WwlGyBym3vzZoTvgCXRUA3f45I=;
 b=nSFt0nE6Mbh4nSHK0DKCSZWIEjS9JomYwWJufDNBIJ4VeZiNmQXD7jessQ5vu/cNksA3oVak43trJ4Sh6DUFK9GrTNcpFZCt7/FyGvkROJIkZrJTyDQSBhZiR3rWghIr8VT7oUenAlpsiAUZdMz3ejOsmbr3p1SsNeShy6dngZrvTzDzAwetgi50860WMdTc3tx/mH/ov+2Q+giCD+Ihonv6AhuopDGxgYAltUk7f0rB3j9BIsdEE2q74XPd+HOJwSixCwyp0bU4K5hzIrwMncup+NSu3jjA0eU5iw5SxlDt6voP/TaShWCYspSd/+N+L6QpNN/ySK1lQp+acNcbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rppvfr4Kph1CDHM82WwlGyBym3vzZoTvgCXRUA3f45I=;
 b=dJkA2FBxjB8BC8H8LVxOXlHvNuxUhspGdYbL04zKKoAtz34ZBjHPwBp53JZmklDmuso4RA4OvUaPUVS82dlFgWujgW90GHAGopMvdCieRhT9Zv0i8OPvZyvEyfIlCR1mUmRgy/gQxR/03ZZ4QRJgbZzyYC2fGwbnZOH9DtVz/xI=
Received: from DM6PR12MB5022.namprd12.prod.outlook.com (2603:10b6:5:20e::20)
 by DM6PR12MB3660.namprd12.prod.outlook.com (2603:10b6:5:1c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Fri, 23 Apr
 2021 10:14:13 +0000
Received: from DM6PR12MB5022.namprd12.prod.outlook.com
 ([fe80::1d0c:502e:9b77:72e0]) by DM6PR12MB5022.namprd12.prod.outlook.com
 ([fe80::1d0c:502e:9b77:72e0%3]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 10:14:13 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: gyro: mpu3050: Fix reported temperature value
Thread-Topic: [PATCH v3] iio: gyro: mpu3050: Fix reported temperature value
Thread-Index: AQHXN+XK9vVdDaBpkE6NR7jI8nyNw6rB2HVZ
Date:   Fri, 23 Apr 2021 10:14:13 +0000
Message-ID: <BL0PR12MB5011563BCD5E11683D51F34EC4459@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210423020959.5023-1-digetx@gmail.com>
In-Reply-To: <20210423020959.5023-1-digetx@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e35b44e-6101-407a-da3f-08d906408b32
x-ms-traffictypediagnostic: DM6PR12MB3660:
x-microsoft-antispam-prvs: <DM6PR12MB3660AA4965313CF668AD9304C4459@DM6PR12MB3660.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xof5uranXd1ROPRD20/mfdyplPTQ6ePL4rZBZr/JahHIAihaOH/302s+C3p11uh9UkRj7pNreoU/2aujTJ/3vhXr7aeuSIGOQy++QXgfoOKv5/7hsk0Jur2PP4yQo8hXS1/bAxb8Bo4qh3MbUKxI55JNVZYGL9W3ae0G/CeoE0/fR60MHomYX52Em+D76zu0PHV3kXsveHy4aUQLq1f6v0H7RcdoCSUuWPC0F5qmd4UiqcKQj5aykVNtZ1MIKB8lHL8MP9nMbrvRx2uPd0ZVtmJDTOW3FPgfjV82wlZSfvY1Piyih+TQO59phFYE10H6+sYjBAx24VH6fdSLGGRmMYiIKZI2sLuotYfoL2nSTv3mPHC23j31OOsoRfFZdQI6eElu+7oFjz8knTZ0qs0rCkGwn7M20OcJA3HrSS7h7cqtUVWF6zqxhpO1s8HvHLA0WPSjpn/TkaCqMvF/P9IcjWKGI93fd/P3mH3vmUXcZZ4ppt5sDSKehDTkmFHAZWydL2Yaf/L/nEzHLcH9wbZa0t2dlylpmzqo1F/Lv9tuLgK36ufMpObpi+qBmWPdKRNGw0plL4db2p7kGWbKTkJI2IWPitnf9cdHdSHja92qEXm/oWlpwvre4ALFi2mUinMuy2jbOouu6m3hBBZxA6az+Ivw/17UIDGR/X/caU5kvuiaTLZn3C/2dZL1lKOxdait
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5022.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(396003)(39850400004)(186003)(4326008)(6512007)(122000001)(53546011)(83380400001)(5660300002)(38100700002)(26005)(478600001)(91956017)(52536014)(2906002)(64756008)(6506007)(966005)(54906003)(66946007)(66556008)(316002)(33656002)(71200400001)(66446008)(8676002)(9686003)(86362001)(66476007)(8936002)(76116006)(6486002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?y/PhZgFhOQlaf2BgDW7QLQov8aPX+0UJun89y+BorkjLkOzjaq6SL6YWfP?=
 =?iso-8859-1?Q?LPZffRxbkTQogQ+ag/rselC0YhgoNGz4TZ8sWE/g6y4P3kVofOyr8Qy+2Y?=
 =?iso-8859-1?Q?hR1aKGpcgs8fpgFbAV9JacQxmP4WmckjdyzwL9GX5j6VytG+fMuFwWqeqQ?=
 =?iso-8859-1?Q?Rjr5HVVP61NXCVrxfw4ymhJR1z5V56XcUA0Cfy4f7KdVCWV2iRAx3/cU+2?=
 =?iso-8859-1?Q?ckul9PnNybD6ul2uMdbwiljz+PxL1V4lmd9KbSuy70WCiw/6SruTCvV9Eo?=
 =?iso-8859-1?Q?acKQSLl5+woyv2uZVLj3XKbhvEqC/yQbuR7dP56ppNyWMXN2iTOuRHxIlZ?=
 =?iso-8859-1?Q?+LmVdtfWzzCMZTV6VGlof0HhiH3kxofTsg+eEqp0ZlgwjWNIg/ZfxWWCVz?=
 =?iso-8859-1?Q?tA/btrXm0jvEF60JSr3nSW/KOBgS6UZeDXiICO6zL/r1tB1D97l1okZ2TO?=
 =?iso-8859-1?Q?fQZp5IJpICNYFJzHt/dMrdKcVUef3yEGeDU58XgbDwI8Bn2VVfdE2g3L7m?=
 =?iso-8859-1?Q?OHm95RqGk+rZ4JPuoKXFWG5mL1atcQc87OW6qZq35YA/17kegPhMIieBNT?=
 =?iso-8859-1?Q?Oc/+CRRBYEiG1WQUm/AetACOkBQ7DEyqbkP1Kxfu5sLbOCnyte6yFCH9oC?=
 =?iso-8859-1?Q?DFvjOfydXaL099IikGep1n/ydFyYsODf12+hHxwkmP3gr4iDGr3e7WtdGI?=
 =?iso-8859-1?Q?TPSK+GPGjKC0DyVDusKYSvkVkggEL+XVAkRlDRZrY5xK0JKcV4Wu5xfd6U?=
 =?iso-8859-1?Q?TM+MoJ/aCFjbpP5LDQb5uZKUvmb3IfnDRihphzGDyzMKF2zlnakrPQ/HoG?=
 =?iso-8859-1?Q?bAEIfdiHC9I14NdJBsl+lgvNr9y0QR27/sNRs/Flc8h43cdKBRZi341/PJ?=
 =?iso-8859-1?Q?n1FJ89dyCqwRAuCIdcd2j519nHkrrruYmDH0BaGVFFhCHfAL90Dn+ui+F+?=
 =?iso-8859-1?Q?i7uf5+JtU4xF0nE3AiMiekaGWTT/aC+TonycOqs8+i7qBGZHcv3qvOOZY/?=
 =?iso-8859-1?Q?s+2XVT+qAKYSXliwLc8urM0IIWjHkwes1OAR+yhFKD1gig5oodYAJl7/qF?=
 =?iso-8859-1?Q?NQS+/K3Ma+ZVE98iCWw9/tMN/Y4u7RvFHtYx/C1pHy4zO5BH2vGnBDoXN5?=
 =?iso-8859-1?Q?hyCanrIaiLrXVbMBn8vyLvqNcotGH8fPD69uil5isZR2IzFkkzujn0vW0P?=
 =?iso-8859-1?Q?gIzI1qMvoSx5Sqtw1NwO/Jp5Sd+FtB1BmBeDQhSlyGrIKBqJL0HSrg8gqm?=
 =?iso-8859-1?Q?oVooLli5l+wYLfp5P3NfKEODznjhUrY23Zh+UVeN+eRysw9WYuMn/nFxRQ?=
 =?iso-8859-1?Q?3qXTYiVbcRzbUi6Z+J/WBS8uqeEhfurXZTUl6J/jhtW+w6o=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e35b44e-6101-407a-da3f-08d906408b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 10:14:13.0295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NN9VtyINunW5tL7oQcOdn+dffg7BaLxn3wZfnGIdJQjT9SiccHL29cXus7ON5IrkX0OGtUYMK6yFWY+QBM39ZQon8L2uRLBHrBmhzjvH5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3660
X-Proofpoint-GUID: jhXENSCwo-cXMFwbX98AoeFHoZKxqZX6
X-Proofpoint-ORIG-GUID: jhXENSCwo-cXMFwbX98AoeFHoZKxqZX6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_03:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230063
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
thanks for this work.=0A=
=0A=
Temperature value should obviously be 16 bits signed, thanks for the fix. B=
y looking at our internal datasheets, I can confirm the values for MPU-30x0=
 family (div by 280 and 23000 offset LSB).=0A=
=0A=
I'm sorry I don't have access to these more than 1 decade old chips, so I c=
annot test on my side. But there is no reason it wouldn't be OK.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: Dmitry Osipenko <digetx@gmail.com>=0A=
Sent: Friday, April 23, 2021 04:09=0A=
To: Linus Walleij <linus.walleij@linaro.org>; Jonathan Cameron <jic23@kerne=
l.org>; Lars-Peter Clausen <lars@metafoo.de>; Andy Shevchenko <andy.shevche=
nko@gmail.com>; Maxim Schwalm <maxim.schwalm@gmail.com>; Svyatoslav Ryhel <=
clamor95@gmail.com>=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vge=
r.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject: [PATCH v3] iio: gyro: mpu3050: Fix reported temperature value =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
The raw temperature value is a 16-bit signed integer. The sign casting=0A=
is missing in the code, which results in a wrong temperature reported=0A=
by userspace tools, fix it.=0A=
=0A=
Cc: stable@vger.kernel.org=0A=
Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")=0A=
Datasheet: https://urldefense.com/v3/__https://www.cdiweb.com/datasheets/in=
vensense/mpu-3000a.pdf__;!!As-oOPDlYaQ!RejqeP2WMYRtGXwerukURT11pBrLee8OdIBx=
dEPzcNdqyuOVrDeorUdlv7_pvdRarvk$ =0A=
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T=0A=
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Asus TF201=0A=
Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>=0A=
Reviewed-by: Andy Shevchenko <Andy.Shevchenko@gmail.com>=0A=
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>=0A=
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>=0A=
---=0A=
=0A=
v3: - Improved comment in the code, saying that the temperature range=0A=
=A0=A0=A0=A0=A0 corresponds to the "best fit straight line" range where tem=
perature=0A=
=A0=A0=A0=A0=A0 is reported reliably, i.e. in accordance to the linear equa=
tion.=0A=
=0A=
v2: - Replaced "signed 16bit integer" wording with "16-bit signed integer",=
=0A=
=A0=A0=A0=A0=A0 replaced "Link" tag with the "Datasheet" and added "Fixes" =
tag as was=0A=
=A0=A0=A0=A0=A0 suggested by Andy Shevchenko.=0A=
=0A=
=A0=A0=A0 - Added r-b from Andy Shevchenko and Linus Walleij.=0A=
=0A=
=A0drivers/iio/gyro/mpu3050-core.c | 13 +++++++++++--=0A=
=A01 file changed, 11 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-cor=
e.c=0A=
index ac90be03332a..f17a93519535 100644=0A=
--- a/drivers/iio/gyro/mpu3050-core.c=0A=
+++ b/drivers/iio/gyro/mpu3050-core.c=0A=
@@ -272,7 +272,16 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case IIO_CHAN_INFO_OFFSET:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 switch (chan->type) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case IIO_TEMP:=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* The =
temperature scaling is (x+23000)/280 Celsius */=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Th=
e temperature scaling is (x+23000)/280 Celsius=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * fo=
r the "best fit straight line" temperature range=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * of=
 -30C..85C.=A0 The 23000 includes room temperature=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * of=
fset of +35C, 280 is the precision scale and x is=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * th=
e 16-bit signed integer reported by hardware.=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Te=
mperature value itself represents temperature of=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * th=
e sensor die.=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *v=
al =3D 23000;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn IIO_VAL_INT;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default:=0A=
@@ -329,7 +338,7 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 goto out_read_raw_unlock;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=
=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =
=3D be16_to_cpu(raw_val);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =
=3D (s16)be16_to_cpu(raw_val);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
t =3D IIO_VAL_INT;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 go=
to out_read_raw_unlock;=0A=
-- =0A=
2.30.2=0A=
