Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DF22435B6
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 10:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHMIEr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 04:04:47 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:29370 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgHMIEq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 04:04:46 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 07D7uES0012591;
        Thu, 13 Aug 2020 01:04:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=0T6ScFGZJquDGNXVoTyK8o0aeMmiyPboQoBzjWN/BIE=;
 b=UhwAC7eUp1ccZ/9gBgbqAx/aMCuV/21H/wwHd4yT603jw4t156KMIxRjqsmcQ3/p57aF
 nZ6jMKeN3W1Aw7VCYftsMQBzkMBpo2NSxeDOsc+wGfMSbF65YO3GgICb6yavs4zA5YKy
 HdgAlGz1K6laEqV9zKO4nDbtGkV/U1DNtqu2DTsgHeUuwicwsdhsiz/5fgiIvb7unhat
 EySDF0tUSGF6BtT1ZOccW1OgADd+hFxNyD/toVevyQVfvbqmlr7vqkjPpsD6/xJljHDV
 pJNTqiy51eEHSENEP9wg4l3zukeTA4+TOfdwToUrxjoT1hBZ0uBdqAg2CSEte/ab2I/W JQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-00328301.pphosted.com with ESMTP id 32vc63rfpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 01:04:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4Z1LPSM2dgSF7EJ6lGHKUKAk1LcQRj11fUcRmhtxz+I2ITkgQgq21vfJD6DAML6cVg5d0iPuA0iUdck3DcMx5TboNmomUHpLPIce/NogIz2OjS/fQOYNxdB4N5ZdHHtaVLzcs5EaubKdD3b47GgiVPms/Re9UaampvZ9NCVSJdQitG/C04AGqLHoQg+CDyt0+aq9djc5aKK35mYufj/AWy1J4M2kXIlTQowPKr6RNiZ8dtveIo/gmw0zQNm3xgleXDd++D/Hwy59tZisHFCX2FXUGQI6hd33mEbYFBfAPgHVnNbJI9R9i+V4t414tlsptvyINbd+R6Ggfev6jru3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T6ScFGZJquDGNXVoTyK8o0aeMmiyPboQoBzjWN/BIE=;
 b=I5okiefCwQQdyikNTXMciCo6diT+ONJek71zouPlquiML6mMIjpeclXvptanJfz0I1r4kMw0wnDiKZZyUKcDb7VhX+P/u8+/md8YSKw7NbNhtBHARfW3ZylLHBXlY6zK8y1LtHZVUhRfLEqxJ8CZ91Q3kt3usx6PFq9wMwHQI7CEkVh43A9hr0XN6+FbCNeyDXP7ZZ4hdVjiigG3Jc7fnpVpGagHtKkT76+XCCX/SPdZrXkV0tydfwZURuLCCHOpluMOx4b21JRZan7e6bcDDoKRDxFNfgu+gfiAB8WiDckEVfpJTu1lG2pIv895mW3JyF3UDHDPp4poSktf8iE1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T6ScFGZJquDGNXVoTyK8o0aeMmiyPboQoBzjWN/BIE=;
 b=KCkoWCBtidybWCJIxWzbgbs75C5GIMXq5S5tOiX7qyL6CCJQ7Ac2Cn0OwgJ7S3kVn317+Rd+CYhWWXx2QTd4yKV+vHTSv2QA1RBVl1PrJo79xt41Psujah0Fbn+ch+DPVi6dj17Xx1HVUR4aJpJt6h9VbK5xlAE/s4lXU5h10UY=
Received: from MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 by MN2PR12MB3901.namprd12.prod.outlook.com (2603:10b6:208:16c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Thu, 13 Aug
 2020 08:04:07 +0000
Received: from MN2PR12MB4390.namprd12.prod.outlook.com
 ([fe80::2c88:e0b6:478:a6e8]) by MN2PR12MB4390.namprd12.prod.outlook.com
 ([fe80::2c88:e0b6:478:a6e8%5]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 08:04:06 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "trix@redhat.com" <trix@redhat.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        Lee Jones <lee.jones@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: check for temp_fifo_enable
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: check for temp_fifo_enable
Thread-Index: AQHWbmYc4AO8xECcpUKzCKFLtz5s/qkw/HaAgAS0usg=
Date:   Thu, 13 Aug 2020 08:04:06 +0000
Message-ID: <MN2PR12MB43905A48FB51A0B33198CC56C4430@MN2PR12MB4390.namprd12.prod.outlook.com>
References: <20200809155936.16898-1-trix@redhat.com>,<CAHp75VdEBjxYS_4g2j=ofjFWuGyTK5Me=9mMNcy5ienUUs67Ag@mail.gmail.com>
In-Reply-To: <CAHp75VdEBjxYS_4g2j=ofjFWuGyTK5Me=9mMNcy5ienUUs67Ag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [2a01:e0a:393:a700:a0a4:9403:1f03:6e16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb7bcae4-5e28-4d99-50cb-08d83f5f73c5
x-ms-traffictypediagnostic: MN2PR12MB3901:
x-microsoft-antispam-prvs: <MN2PR12MB39013BA755931508A274050BC4430@MN2PR12MB3901.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: chfSRGlv3mr8L2Ha/oKISyuo5xr810P3OqNquQM6uYpCmOr7lxe8CmnXfxP55Co5AHCv8rD7RTLwXtry0eENcT1Pe2sAr6cMa/AbuKI5BeOHkfvL//NT6aooJXwFhmE4hPICPi+mAUadC2n7FvhF8rUUwiQJIqc9zV3cR/WhsbByCiuFt8MbH284N46JMLIEpFrRphNtnbdMnAE6MupYci2I2ixTbIbzHxP8yM8S5SlXjjn6GNCo4a1l4Rbssn6aj7E39crGQF0WaEajheaMp9rN3Nk3OXHFZ2WBjsHE2/RjkzxEhRiQl/DsppGZuPcp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(396003)(39850400004)(366004)(7416002)(9686003)(186003)(86362001)(6506007)(71200400001)(8676002)(7696005)(8936002)(4326008)(53546011)(5660300002)(91956017)(66574015)(83380400001)(478600001)(2906002)(33656002)(76116006)(52536014)(54906003)(110136005)(316002)(64756008)(66476007)(66446008)(66556008)(66946007)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 65n80ZC1ePfuCzKA+/OBitQ55gllygaKuPjImy088y/qgpt3T6p/WUsi3rNPc74m5vkjFmDb107mIWvlOsHOR3A/1AokwJ3KEfdeglGFihoGXBDXIeCtmLjOo0VjmCgXRLTiyJPmf6EDu2v8rPNnsc7IM2VYZdiRsyLgylXTT00ozB2YNWr6CpIk1q4DtphdWHzQzIPNufc9bLPqd7b6GlgeJ3gyYLdjK+HwFui6PtnnGgXNy6CxJu8/FhbOEQne1ft88xC9JyF7EkApJ885PpgwmEWOpRTtdJMQFkQv0uzM6nqH4tgGn48f3+CbL4UcIaPfQ2l11LNSI0vIxitWK6/7vLP5fd7wnt0DcZdT4gXfsdCP1dUXObOI/oVOOyjhh50hHe9nfRzMirAALqc871rh5c4m65qScTWHismlYlqdLBELHzPTmK55AwQoTwDiqJ9BsT2IZsnovZaa0D740LbmDpk/5a9us/Fc+885ZDhJWxNL3gU6Job5PauPG20p59wChjVTASGqm68kh/jpgAEVzj3dwpV3elpSnCrV27YvhiNWv2WCkLd0oIUsVkS3XSCfxFz7b8sRmUEVVfE2oPK0JJMN8NY2txq5RnCViIcnLC6NSbplhHAXXo2LELtGMTk/6fC+BM5kB7BGG/ZILqEwjYyvlb8XshZfuWqF5rUiNZabgiIXX1zwEDUbrYGFmNkO/GE67e9yItgwGPo4yA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7bcae4-5e28-4d99-50cb-08d83f5f73c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 08:04:06.7339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKK0WNxv4T4hS5Cn6oZRqwJaJj0baWwfflm5Z9NHyghG2STKpG9Rha+BE7ACI+acsXW8mWqGpX7pqn5anQbX3UplipeEiPatqzOgBErPI7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_05:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130059
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
this is a case that should never be happening since available scan mask onl=
y advertise Accel + Temp, Gyro + Temp, or Accel + Gyro + Temp.=0A=
More than that, temperature sensor is not working when MEMS engine is off. =
(it's only purpose it to measure temperature of the MEMS to do data tempera=
ture compensation).=0A=
=0A=
So I think we can let this check as it is currently, since this is not a su=
pported configuration.=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
=0A=
From: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
Sent: Monday, August 10, 2020 10:02=0A=
To: trix@redhat.com <trix@redhat.com>=0A=
Cc: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; =
Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald <pmeerw@pmeerw.net>; J=
ean-Baptiste Maneyrol <JManeyrol@invensense.com>; Micha=B3 Miros=B3aw <mirq=
-linux@rere.qmqm.pl>; Lee Jones <lee.jones@linaro.org>; linux-iio <linux-ii=
o@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org=
>=0A=
Subject: Re: [PATCH] iio: imu: inv_mpu6050: check for temp_fifo_enable =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Sun, Aug 9, 2020 at 7:00 PM <trix@redhat.com> wrote:=0A=
>=0A=
> From: Tom Rix <trix@redhat.com>=0A=
>=0A=
> clang static analysis reports this problem=0A=
>=0A=
> inv_mpu_ring.c:181:18: warning: Division by zero=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 nb =3D fifo_count / bytes_per_datum;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ~~~~~~~~~~~^~~~~~~~~~~~~~~~~=0A=
>=0A=
> This is a false positive.=0A=
> Dividing by 0 is protected by this check=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 if (!(st->chip_config.accl_fifo_enable |=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.gyro_fifo=
_enable |=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.magn_fifo=
_enable))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum =3D 0;=0A=
>=0A=
> But there is another fifo, temp_fifo=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.temp_fifo_enable)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_=
MPU6050_BYTES_PER_TEMP_SENSOR;=0A=
>=0A=
> Which would be skipped if it was the only enabled fifo.=0A=
> So add to the check.=0A=
>=0A=
=0A=
> Fixes: 2e4c0a5e2576 ("iio: imu: inv_mpu6050: add fifo temperature data su=
pport")=0A=
>=0A=
> Signed-off-by: Tom Rix <trix@redhat.com>=0A=
=0A=
There shouldn't be a blank line in between.=0A=
=0A=
Other than that,=0A=
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
=0A=
=0A=
=0A=
> ---=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 1 +=0A=
>=A0 1 file changed, 1 insertion(+)=0A=
>=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_ring.c=0A=
> index b533fa2dad0a..5240a400dcb4 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> @@ -141,6 +141,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 if (!(st->chip_config.accl_fifo_enable |=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.gyro_fifo=
_enable |=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.temp_fifo_ena=
ble |=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.magn_fifo=
_enable))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum =3D 0;=0A=
> --=0A=
> 2.18.1=0A=
>=0A=
=0A=
=0A=
--=0A=
With Best Regards,=0A=
Andy Shevchenko=
