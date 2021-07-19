Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0A3CD44B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 14:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhGSLYF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 07:24:05 -0400
Received: from mx0b-00105401.pphosted.com ([67.231.152.184]:22824 "EHLO
        mx0b-00105401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236839AbhGSLYD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 07:24:03 -0400
X-Greylist: delayed 1803 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jul 2021 07:24:03 EDT
Received: from pps.filterd (m0266029.ppops.net [127.0.0.1])
        by mx0a-00105401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JBUkhf021395;
        Mon, 19 Jul 2021 11:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=POD051818;
 bh=k0xXp4ZRXwL+3hnEta1oOFxa3ymJdM7mnmWkfPYGMzc=;
 b=YZBj/DPsYFoJdtmuIB+SZidV4qJr4uUduDdBBnLBhf7jD+VO0pKUwi3oSe9WZ2DkREZ7
 uGEGg9Pv+3ctfzxX8WOjFvvAFXmoxl6DeJ0josAxJD2Mct4hP7XjAMp0dCss4xDn2G2F
 WV3TzlMFjo2ptEZsw1wP9Set9TV84iQSk8F+6HfBCKMTMIDsIWfNyUTDciULlgs1xS6S
 0vGm+EsIsifkblF9bIglgSFlhxO3CSFxJVleo5mEAvdAyeXiJvqtV9JPENtFDgIxS2vr
 gVP4TQaLNzHSC7v0rFgad4CT2LkV3G71NdKsatHWA3vdtWiFL7TrAE0OaAQAKh+9erf7 dw== 
Received: from xmnpv39.utc.com ([167.17.255.19])
        by mx0a-00105401.pphosted.com with ESMTP id 39unm9cfyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 11:34:35 +0000
Received: from qusmna5k.utcapp.com (qusmna5k.utcapp.com [10.161.160.133])
        by xmnpv39.utc.com (8.16.0.27/8.16.0.27) with ESMTPS id 16JBYYTv161309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Jul 2021 11:34:35 GMT
Received: from UUSALE05.utcmail.com (UUSALE05.utcmail.com [10.220.35.15])
        by qusmna5k.utcapp.com (8.16.1.2/8.16.1.2) with ESMTPS id 16JBYYUh018300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 11:34:34 GMT
Received: from uusale2b.utcmail.com (10.220.63.21) by UUSALE05.utcmail.com
 (10.220.35.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 19 Jul
 2021 07:34:34 -0400
Received: from uusale29.utcmail.com (10.220.63.19) by uusale2b.utcmail.com
 (10.220.63.21) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 07:34:34 -0400
Received: from USG02-BN3-obe.outbound.protection.office365.us (23.103.199.148)
 by uusale29.utcmail.com (10.220.63.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 19 Jul 2021 07:34:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=enclBXzb1eRPzfUME2iPjEHKnK5RFr7hKmdSi1UZQvZPOLBKNoe7n7pNsadUNScnkqttVIPWGVNXloa5YuizzvENyWpa8bhmarkH8it+p9TFQnPu7jtz+UWAVA/DJ1EGUYPBJ3c9Xdoec0C+H97My3ifElA+MV7g6XqrdYpHQqO7Px3VPHjpoEMIlIlSaaGheSsJut0YlcsrjCognowfDqVH4SzC1qrdfQv9k/li6aTMzUUoyb8NDfCF+tcxXI0SvxUJd/bHW0hgKXkZJSDKgaLMKf+EyX/xZxBUYxK0gndPVOhNqH1eLQMlQNfBDtZewzre0I2fmgB/4+7NNtfCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0xXp4ZRXwL+3hnEta1oOFxa3ymJdM7mnmWkfPYGMzc=;
 b=AuQTCsqxgIJOv1sF01s6N/5KNlTFQm6LmfwRPefbK9sx91vExa/8mJc2I0Z00hJp793Ha7eRRezmboAtZLkqit38KyskSD45jJXP2al/RoCZks9Qr9nnxrfNjjjBsXkIyFd4KmSfzfave36FRGARBCOGIguHR+nOK8jJRYVdNWOxUIu5RpqJp+3fG9FebiUIG1h6Pjfc+KRfkuO0nZlsKVNvA/M1Vp1MqN+xwXvN4FjaWRAr/2gcozfSoPTWyIhEh/wqyHV2DxfT+14JZvnROdt8ae8odsZztlBnSbxOV8a6fkiBRaIFaJCCB0alfP8bbAVE9DvN/89mPPaXm91B2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=collins.com; dmarc=pass action=none header.from=collins.com;
 dkim=pass header.d=collins.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rtxusers.onmicrosoft.us; s=selector1-rtxusers-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0xXp4ZRXwL+3hnEta1oOFxa3ymJdM7mnmWkfPYGMzc=;
 b=JT2eXwz9fcdbxu4o/KPV4q4J1yb0iRBZYIZ/ACbdGSBt1FgwEX1KPh7VNMCY+ruoJnB1Uq1fNhKp1d9IZ+LAwRgEOfuJKgqfomMij8DXGuYuhJNFcdrNS0a/fzcHex7eI6OWbAmTR/sGxSQfSWIWsPrPGu87i/ypoeRsvC8wvW0=
Received: from BN1P110MB0148.NAMP110.PROD.OUTLOOK.COM (23.103.23.27) by
 BN1P110MB0115.NAMP110.PROD.OUTLOOK.COM (23.103.22.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22; Mon, 19 Jul 2021 11:34:33 +0000
Received: from BN1P110MB0148.NAMP110.PROD.OUTLOOK.COM ([23.103.23.27]) by
 BN1P110MB0148.NAMP110.PROD.OUTLOOK.COM ([23.103.23.27]) with mapi id
 15.20.4331.032; Mon, 19 Jul 2021 11:34:33 +0000
From:   "Anderson, Maury J Collins" <Maury.Anderson@collins.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: potentiometer: max5481: convert probe to
 device-managed
Thread-Topic: [PATCH] iio: potentiometer: max5481: convert probe to
 device-managed
Thread-Index: AQHXe+EkJO36PEJgGkW/TleK9ljyh6tKKzHw
Date:   Mon, 19 Jul 2021 11:34:33 +0000
Message-ID: <BN1P110MB0148698C7F6716431F54E85A9FE19@BN1P110MB0148.NAMP110.PROD.OUTLOOK.COM>
References: <20210624080641.9953-1-aardelean@deviqon.com>
 <20210718152936.3d4194e6@jic23-huawei>
In-Reply-To: <20210718152936.3d4194e6@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=collins.com;
x-originating-ip: [173.22.99.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4405f877-105b-44c7-971b-08d94aa92e16
x-ms-traffictypediagnostic: BN1P110MB0115:
x-microsoft-antispam-prvs: <BN1P110MB0115E059881E9CD7E7BEC0069FE19@BN1P110MB0115.NAMP110.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: THRxa4eWkZtEmEMB20kdWLfnEW7g+RQmUoGwrYD2usbkBthZTpYsqcSm4Xw26iAwQmqtMAnntlm/4fceTYV/C4vvVDCdUJI0BI3bUeNJ+tmnmUvvJDUeUhq0sH8nKr+aoOC/XZUmEdSIXznMCifm+c3iXnzDyAGgkfdMBRnddmHBpeYVRoWa5LPLPNkBAeWJyU6/Bpj29SaHIWyz1UIpzJ8wc0oCrqSw+XUuZm1XR/2HrkKYSFoB66sErMMk11C8nphKF2NKGyOvt1/iVFw46xds/VfT4+2SfxW3o77zqxJEfZHGsbqQLdnReqN8LmLW8c4AqsjHuc/qGk2ADVmdzMkpjK20j2XYIqMZCLaB1Di8zOD3ZPC5yXvKBuwOeIRjG57jCsQlor/k0a3adIPDmoBRS9/VcTtaSB7SCxEEjGjIQ6Zf6W4pqWVntW7wh4hn9nIAaldrbsUBur6IGO/ViSJTDTF/3qsk7lTGLzTjUqeO+9FsMm5nredgIT9oO5+zyEN0FChTfdsyAhZjUj3qNz7HaKFRf55VN0Dr3fj9DEWYfhitaPLR2v8r7QDDs/BD+ASoZhjbNP4aupUt/tacF+b31/BBuGkQW1KbPdxdFl1vEiyxPyyJAm4I48bNwlzA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN1P110MB0148.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(346002)(39860400002)(8936002)(33656002)(38100700002)(956004)(8676002)(64756008)(66556008)(2906002)(5660300002)(76116006)(66476007)(66446008)(66946007)(9686003)(52536014)(122000001)(26005)(316002)(110136005)(4326008)(54906003)(83380400001)(53546011)(55016002)(6506007)(86362001)(7696005)(71200400001)(186003)(478600001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5kQlZAOsYnjgFyOnvkAUHOo+L2M8mYSgX16y+9XnU84fC5scl1PZrfKYjA4ffxmrDQbECnqAiTQSvCzRcigbGx/ZrD0o0B+hE4GpmxtzpaoIQlHnhrnCMRD4XpOM5jLzzmSDR8JRAVSTnfrhyTBHVPYHOpdXcwQ3AA40S/dCIRysNqI7Rdxo6Azbd+8+Un3BGY9nEm8tL/0cKk5gWzUqzbZFwEF/DMLNAQlOcjQr9FXBpHRKMofQPc0TVqRZFyyn+KW7Fs6pb6LyFFG4GeGr3CjZ4bhSYAmLQof/ON/QjoD6OMOh+MPJHVtoNNf5iDd6lJbZq5gAYkApJFu5MEeiF03suExXi5Ji5/w6nTAslRZ1hdLommUJnqDjNy3z9sGihpqTtUzJT0p1nJfDLKg+IFXcFQYFfYCoeqGOsE2ZJtHajdPo4pknt/DEPOPsUPMb8kuaRrRaq/LersPcHbZFJWS9ai4wWOJz7JS40m59TZsMFWu2kYGuXE1/vRCoPhA/7Hb3Lw7ieI5u8Kz0RKfuzVCr+leR6Z4Xgj4qBufUeYwbgs8b36HECgpA87SS2oeV6OzDmoisvt4Oq7fZEF2aNJ2iXNftRsdm4PCmNgmjn6fgxkf+VMWfOximU1cFNZkNTfd4awn2MA1BN7pxaazYgnuM5YuqV56JO5LstO+zYUqnPCNBxnCe6v+IudtycjUlvu9mbjWrzmD/kFTcktLsLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN1P110MB0148.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4405f877-105b-44c7-971b-08d94aa92e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 11:34:33.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7a18110d-ef9b-4274-acef-e62ab0fe28ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1P110MB0115
X-PassedThroughOnPremises: Yes
X-OriginatorOrg: Collins.com
X-Proofpoint-ORIG-GUID: 3H049p0sax8fPdVsVWIKHgm3RnuLUE0F
X-Proofpoint-GUID: 3H049p0sax8fPdVsVWIKHgm3RnuLUE0F
X-Proofpoint-Spam-Details: rule=outbound_default_notspam policy=outbound_default score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107190065
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan and Alex,

This change makes sense to me.  Silly comment on my part.  The intent as I =
recall was that the device would not "jump back to default" when the contro=
lling system went through a reboot phase.

Thank you.

Maury

-----Original Message-----
From: Jonathan Cameron <jic23@kernel.org>=20
Sent: Sunday, July 18, 2021 9:30 AM
To: Alexandru Ardelean <aardelean@deviqon.com>
Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Anderson, Maur=
y J Collins <Maury.Anderson@collins.com>
Subject: Re: [PATCH] iio: potentiometer: max5481: convert probe to device-m=
anaged

On Thu, 24 Jun 2021 11:06:41 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> The change converts the probe function to use the
> devm_iio_device_register() function.
>=20
> Before calling that, we need to register an action to store the wiper bac=
k
> to non-volatile memory when the device is de-registered.
>=20
> We don't need to do this if the probe fails, because the only place where
> the probe can fail now is devm_iio_device_register() and that shouldn't
> create an IIO device (for userspace to poke at) if it fails.
>=20
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Hi Alex,

This one took a little bit of thought because it's a bit unusual in that
that wiper write back isn't technically unwinding anything so doesn't
have an obvious match in probe.  However, as it logically wants to happen
just after we've removed the userspace interfaces, I agree with your
logic that it makes sense to do it with a devm triggered call.

So, on that basis applied.=20

+CC Maury on basis might still be about on that address and want to
express a view on whether this makes sense.

Jonathan

> ---
>  drivers/iio/potentiometer/max5481.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiome=
ter/max5481.c
> index 6e22b538091f..098d144a8fdd 100644
> --- a/drivers/iio/potentiometer/max5481.c
> +++ b/drivers/iio/potentiometer/max5481.c
> @@ -125,6 +125,11 @@ static const struct of_device_id max5481_match[] =3D=
 {
>  };
>  MODULE_DEVICE_TABLE(of, max5481_match);
> =20
> +static void max5481_wiper_save(void *data)
> +{
> +	max5481_write_cmd(data, MAX5481_COPY_AB_TO_NV, 0);
> +}
> +
>  static int max5481_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -136,7 +141,6 @@ static int max5481_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
> =20
> -	spi_set_drvdata(spi, indio_dev);
>  	data =3D iio_priv(indio_dev);
> =20
>  	data->spi =3D spi;
> @@ -158,18 +162,11 @@ static int max5481_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
> =20
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int max5481_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> -	struct max5481_data *data =3D iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> +	ret =3D devm_add_action(&spi->dev, max5481_wiper_save, data);
> +	if (ret < 0)
> +		return ret;
> =20
> -	/* save wiper reg to NV reg */
> -	return max5481_write_cmd(data, MAX5481_COPY_AB_TO_NV, 0);
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
> =20
>  static const struct spi_device_id max5481_id_table[] =3D {
> @@ -187,7 +184,6 @@ static struct spi_driver max5481_driver =3D {
>  		.of_match_table =3D max5481_match,
>  	},
>  	.probe =3D max5481_probe,
> -	.remove =3D max5481_remove,
>  	.id_table =3D max5481_id_table,
>  };
> =20

