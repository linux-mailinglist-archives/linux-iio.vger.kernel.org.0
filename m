Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F1D39B357
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhFDG7l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 02:59:41 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:12464 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhFDG7k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2021 02:59:40 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1546sMpL029704;
        Thu, 3 Jun 2021 23:57:30 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-0064b401.pphosted.com with ESMTP id 38y48j8ec9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 23:57:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezCUe3VOXZbqUB4NCUFclPgyG2IZjN0HVuTbZfmP21Ait915rFGPpIqlbyPP4jtkp7PZnwH+UEmtUii7+1OeoeErIsfpo5FtJorqjGr0/yAM14ETS7ov4pPaojnXwmpGu6Y13J5O9vhego+rutcOLAiuFlkICRsKW1NAUA5rSIJ4icS3w/xUtVaRSlevFK64nNQoM3vW61mdVHzVGSVqDycAcHSiKIufNvVaiw+NP9AKf6kVhclB60cUjD/im0GjArjYLCEloJWiAqajfvyvsM/lt7ERAXYKEtK95ygMN+qR/5At2V0onH1rXB8un5+arzxXyACY0wSJ5no879b/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC1u5LYU+wc8X1Rpc1p7FWWJuC/qhdcHdpkjYCca0kU=;
 b=K6Lt+NWvj2q71V4zuki5jrYkV+ZtNgiXZkoIc5X2Z9kacoUqgk0HwAJfXUAgdQ1JpbdWzJd9taidgC2cTdOUzhKDyEHeKsJbqp+6Xgby5MPRn72nao00xa7ZNO01ZfPGgDfEC7UvkdW42vDZqnZQh3esaZJRcfCINfmq+S4t54/kWfLJuVIYABEOLXsr4/8I8VbJiQZtLyXSVYCHY+QN0S4HSnD8jCImtOQtzW8tMUDj5uPeGvvRvCo3PmlNOqmAx/N1zt3lopLzBvwe7pMjkffID1NsMjLnTbb9Tv43AZo1yqQGdSAQK/Ox4NpcsycjdzZu4+eZlUi1IAGu64ezxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC1u5LYU+wc8X1Rpc1p7FWWJuC/qhdcHdpkjYCca0kU=;
 b=L3cLoAPilfvKxvCqWMDCaderM18yLBJN6ri+TN6sdX1xqwBusrnRMK+3m2favC0fXi0Ea5ve33PPTvnR36D35UqjwgVBXMrFozHkFaMw1gKEQD1zQUUgSuhJzGQFVh00FoiWdMUAdI6TrDd0hf6gYt9BO0eeP1/HBv0nPNCFRjk=
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Fri, 4 Jun
 2021 06:43:20 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49%9]) with mapi id 15.20.4173.030; Fri, 4 Jun 2021
 06:43:20 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Topic: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Index: AQHXVsiLZJqFig5jYEW95MUVkHO9fqsCeyaAgACcmKCAAEwegIAACGBA
Date:   Fri, 4 Jun 2021 06:43:20 +0000
Message-ID: <PH0PR11MB519190E44082ED1B0B0D4C90F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20210601092805.18385-1-Meng.Li@windriver.com>
 <20210603172025.314b5ced@jic23-huawei>
 <PH0PR11MB5191C26AA8B6D2B855E19D67F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20210604061319.pbj5ptnhxfsz4cec@pengutronix.de>
In-Reply-To: <20210604061319.pbj5ptnhxfsz4cec@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ab2f66c-93e0-4d61-48af-08d927240b1b
x-ms-traffictypediagnostic: PH0PR11MB4822:
x-microsoft-antispam-prvs: <PH0PR11MB48229E43D03ABB6FE8268D08F13B9@PH0PR11MB4822.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vaxOQVDhiKZevufEvYJ9teqYuNL39y94W9LviwKr1Ep9Mrg1tKYwRgBC2VR0BXlnjsNVMmXQU31lmqLPG0jJCH/ILLA8cEDqkINd5nVYU7Py2BvvybwhxeC+hlv8tnpINHG3MZhWo+YKYy8Obo0m2JlXqLrRHiZy3A1lNgar7jkfkb0RjQRO6/nyHqEStvsmPqpueCylHmxsdkTIa/l4VEZ3/cHCtNco6F2FAmCHlg8eGkMTk+ZjhFzxMFwVxjzs8ty/f4yB/L6k9ULWaL8FgdA0jLDmzAvDroZtsyrZERRNUM6TErsRs+UjomH8YWD0m/4cA/eZpBBj95XsazJtjpubkAFLSWtkQFCeAA+4VEBKpqbUM5JUuh4Y0GgAhNnbMGrh/zAoRefVusLE+QH/xN1QEhXh9nFRF6mwRQoSJ5f/JukogOU7/yPVuBYPsgi7dXEgP0GnhPrmfdb2AlI5wr41MxuGuZWqTcu9WLgXDqcV4dNdFqy83HAuODTV97Pte+ULQzJLGOO+6yFdc/lvvoXYKobZx3roz8CiESidNB2LdgYP67hGIh25gfAnBIeT+QCaUReEHr5zhnKAnFIo0YeT5jRBhTKKasW0T6izUc0uOgT/o8CRGCTouqGSZW9d3W/ejkoLh+bpzwk66oK5Wd+7z8aMOVL9l3Yv9D3F1QgLQfzmLhWB3PcwItmDbb99EnIMbqhhooVAP5eTVxQ/T0bDVb7sDIkf03xZIMDbQF8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(52536014)(7696005)(5660300002)(33656002)(4326008)(71200400001)(122000001)(9686003)(55016002)(6916009)(8676002)(8936002)(38100700002)(86362001)(478600001)(76116006)(66446008)(66476007)(66556008)(186003)(26005)(6506007)(966005)(2906002)(53546011)(64756008)(66574015)(54906003)(83380400001)(316002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?HL+cTKag34yYJDP7xX43iuaJnfHSI96xGeB8otuHtq0Rhl18sIItwUlQEz?=
 =?iso-8859-1?Q?V2VBZRE9prQ0WQ7K9+CU3rRC01pI/aEaMwuePnxJ/4tghFaEd95TOKgEht?=
 =?iso-8859-1?Q?70wrpj0hHLPfgMwR6EQHsguR64YttzRcslsyQlPrAFNi2ivGy4hDsy80O+?=
 =?iso-8859-1?Q?GdusOr+GugTaWuPwdO4NIpkfdlIaTX6rFz7drm4Sx6uDk86ruuxuAr1rfP?=
 =?iso-8859-1?Q?1ixg72gOPFSENWOxaG2UnSV9Jkl4+OrQanEW4+KuwCqV+asWYMlwQpaF4h?=
 =?iso-8859-1?Q?IPL19BbKqzKlp47SI/RB3DBgZhcUgFxE6B8IwaHZE9fP/ejLCWI4AJsXb2?=
 =?iso-8859-1?Q?olz0NwPIWmps+5hM0Aj4RD34MABuUcEaY/Qu6/3Wy23ngQ8VPuMkG/61Lg?=
 =?iso-8859-1?Q?iIX46fovSjosH8rOcr+vRDylweC8PHU+JTa1h8Ii2bbDoRXLBCxVs+1jpq?=
 =?iso-8859-1?Q?nqeGs3u0DrhqHLfmKCJysw67vrAcKRC8ppfAgvPSlALsWfksWvNyxpQ+PI?=
 =?iso-8859-1?Q?8UrTgQcZ2J3bulCN05g9cIQMNWMupXj50+yzP+jCvYJIsKdy2NDyjxeap0?=
 =?iso-8859-1?Q?uAVbcXlOb51+Xdy/rvr0k0Pu0p/8ACqKkAz5A1evKmnQvQSWaLxORG31xA?=
 =?iso-8859-1?Q?hpIrraim5sagIM+xZ2jDLqi+lF9Cgme6FDfyK1PdSb/jkJbKVFFFzjxRbX?=
 =?iso-8859-1?Q?/1QdohNgAyjg1jvVaeximBZmOAHvNwA4Vf0HigfVIXK/EPR9znKONPRs1l?=
 =?iso-8859-1?Q?UJXQv0qI9nRuYRW+WqB5uJW1snNxofFNM0OOSMlPNJ30aazLGBeSJpomEk?=
 =?iso-8859-1?Q?JZnXeKHldP16pUusiF+6TMP8NM8Kwqhv79Roh9FFUuGk/3aCyOx/LJ0Q57?=
 =?iso-8859-1?Q?I3rbYP34FIaRssxffyIutY+1fZvzkMndvH5cqmioM//BsQYIhY3JgBjcB3?=
 =?iso-8859-1?Q?t1JRkrqj6++CjHs2EGCVZ03zYTviC+T9vEp2hAiF08TiC57PdYhuv8vi4Z?=
 =?iso-8859-1?Q?zicWKQIVK2PB3YOwn12UtGh8yl+U/9bzSpZJXId0QX5UsQ155BWZG0Ll3D?=
 =?iso-8859-1?Q?BX46PKKGVEogYL5SpnC8tClIBokhU5ai2TETXVEDDYVgZ4xckvhdcgjSbw?=
 =?iso-8859-1?Q?49SGq9COQAlIKJgDY9HyfOgQWNETI2XfxUoJrKbC1FFJwuhNygPhu2FY1S?=
 =?iso-8859-1?Q?i2SQczkPNS4VCc9vBKeS6D1jslBOE81AnlYhY6RGDo7sQYJtB1vI/Ct4s8?=
 =?iso-8859-1?Q?geTkdhr47gFyTYOmf1CobAQDpyhkf0A8nU5yJj/EBMUdGUrUnXmWp4Cily?=
 =?iso-8859-1?Q?ZWXqv8rNjosKPqHU3JbfUV3W8wHIcUvfN8olTigzWVK6xvCShdSA9Drir4?=
 =?iso-8859-1?Q?JBk8i2ip9/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab2f66c-93e0-4d61-48af-08d927240b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 06:43:20.5839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOYZLTac7Olu1hYgdqAyZzO41XyvASwC6A/fF5BKs4z7IXf656ENa0nsUc1M6l1zqMRkVZHSFk4SJr1lWS9AyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-Proofpoint-GUID: RNVGk2vFE3tYT3I90KlcAZ9EZCWhdrpP
X-Proofpoint-ORIG-GUID: RNVGk2vFE3tYT3I90KlcAZ9EZCWhdrpP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_04:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Friday, June 4, 2021 2:13 PM
> To: Li, Meng <Meng.Li@windriver.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; lars@metafoo.de;
> Michael.Hennerich@analog.com; pmeerw@pmeerw.net; linux-
> kernel@vger.kernel.org; linux-iio@vger.kernel.org
> Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading =
the adc
> conversion value
>=20
> Hello,
>=20
> On Fri, Jun 04, 2021 at 02:16:39AM +0000, Li, Meng wrote:
> >
> >
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Friday, June 4, 2021 12:20 AM
> > > To: Li, Meng <Meng.Li@windriver.com>
> > > Cc: lars@metafoo.de; Michael.Hennerich@analog.com;
> > > pmeerw@pmeerw.net; u.kleine-koenig@pengutronix.de; linux-
> > > kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > > Subject: Re: [PATCH] driver: adc: ltc2497: return directly after
> > > reading the adc conversion value
> > >
> > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > >
> > > On Tue,  1 Jun 2021 17:28:05 +0800
> > > Meng.Li@windriver.com wrote:
> > >
> > > > From: Meng Li <Meng.Li@windriver.com>
> > > >
> > > > When read adc conversion value with below command:
> > > > cat /sys/.../iio:device0/in_voltage0-voltage1_raw
> > > > There is an error reported as below:
> > > > ltc2497 0-0014: i2c transfer failed: -EREMOTEIO This i2c transfer
> > > > issue is introduced by commit 69548b7c2c4f ("iio:
> > > > adc: ltc2497: split protocol independent part in a separate module"=
).
> > > > When extract the common code into ltc2497-core.c, it change the
> > > > code logic of function ltc2497core_read(). With wrong reading
> > > > sequence, the action of enable adc channel is sent to chip again
> > > > during adc channel is in conversion status. In this way, there is
> > > > no ack from chip, and then cause i2c transfer failed.
> > > > In order to keep the code logic is the same with original ideal,
> > > > it is need to return direct after reading the adc conversion value.
>=20
> As background about the choice of the .result_and_measure callback:
> A difference between the ltc2497 (i2c) and ltc2496 (spi) is that for the =
latter
> reading the result of the last conversion and starting a new is a single =
bus
> operation and the one cannot be done without the other.
>=20
> > > > v2:
> > > > According to ltc2497 datasheet, the max value of conversion time
> > > > is
> > > > 149.9 ms. So, add 20% to the 150msecs so that there is enough time
> > > > for data conversion.
> > >
> > > Version change logs go below the --- as we don't want to preserve
> > > them forever in the git history.
> > >
> > > I may have lost track of the discussion, but I thought the idea was
> > > that perhaps the longer time period would remove the need for the ear=
ly
> return?
> > >
> >
> > No!
> > I think the ret is essential.
>=20
> I'd like to understand why. Currently ltc2497core_read() looks as follows
> (simplified by dropping error handling, and unrolling the result_and_meas=
ure
> callback for the i2c case):
>=20
> 	ltc2497core_wait_conv()
>=20
> 	// result_and_measure(address, NULL)
> 	i2c_smbus_write_byte(client, LTC2497_ENABLE | address);
>=20
> 	msleep_interruptible(LTC2497_CONVERSION_TIME_MS)
>=20
> 	// result_and_measure(address, val);
> 	i2c_master_recv(client, &buf, 3);
> 	i2c_smbus_write_byte(client, LTC2497_ENABLE | address);
>=20
>=20
> With the early return you suggest to introduce with your patch you save t=
he
> last i2c_smbus_write_byte call. The data sheet indeed claims to start a n=
ew
> conversion at the stop condition.
>=20
> So either the reading of the conversion result and programming of the
> (maybe) new address has to be done in a single i2c transfer, or we have t=
o do
> something like your patch.
>=20
> What I don't like about your approach is that it changes the semantic of =
the
> callback to result_*or*_measure which is something the spi variant cannot
> implement. With the current use of the function this is fine, however if =
at
> some time in the future we implement a bulk conversion shortcut this hurt=
s.
>=20
> So I suggest to do:
>=20
> ---->8----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Date: Fri, 4 Jun 2021 08:02:44 +0200
> Subject: [PATCH] iio: ltc2497: Fix reading conversion results
>=20
> After the result of the previous conversion is read the chip automaticall=
y
> starts a new conversion and doesn't accept new i2c transfers until this
> conversion is completed which makes the function return failure.
>=20
> So add an early return iff the programming of the new address isn't neede=
d.
> Note this will not fix the problem in general, but all cases that are cur=
rently
> used. Once this changes we get the failure back, but this can be addresse=
d
> when the need arises.
>=20
> Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent part =
in a
> separate module ")
> Reported-by: Meng Li <Meng.Li@windriver.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/iio/adc/ltc2497.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -41,6 +41,19 @@ static int ltc2497_result_and_measure(struct
> ltc2497core_driverdata *ddata,
>  		}
>=20
>  		*val =3D (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> +
> +		/*
> +		 * The part started a new conversion at the end of the above
> i2c
> +		 * transfer, so if the address didn't change since the last call
> +		 * everything is fine and we can return early.
> +		 * If not (which should only happen when some sort of bulk
> +		 * conversion is implemented) we have to program the new
> +		 * address. Note that this probably fails as the conversion
> that
> +		 * was triggered above is like not complete yet and the two
> +		 * operations have to be done in a single transfer.
> +		 */
> +		if (ddata->addr_prev =3D=3D address)
> +			return 0;
>  	}
>=20
>  	ret =3D i2c_smbus_write_byte(st->client,
>=20
> Compared to Meng Li's patch this doesn't introduce reporting of bogus
> conversion results once we implement bulk conversion.
>=20

Ok!
Understand.
I agree you to push patch to upstream and it is more reasonable that the  o=
riginal author to fix this issue.

Thanks,
Limeng

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
