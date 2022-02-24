Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEDC4C2E79
	for <lists+linux-iio@lfdr.de>; Thu, 24 Feb 2022 15:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbiBXOcW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Feb 2022 09:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiBXOcU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Feb 2022 09:32:20 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A8241326
        for <linux-iio@vger.kernel.org>; Thu, 24 Feb 2022 06:31:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K450oD7xWwoPnPYT2hM5OkwMnR72JaMM9ZT9PbetUNlsrKtStnQka/UYXjVbhxe4wlQD6f4kkL3m+hdnkZz5SO8gyQDaTYRJq5OQHd9U7IG9ZV6Rkk9g9n/RNUehzpTDOogDEGHA6wkAsMAW9M91VKvd4lsLEh4yXj+khKOogl6GVgBkAUbu13PWnf7d45Ay3oaiX7cH1iQV0ixXDkh16BgQ7Yas2rBq6KRsY1gl6pcuswGCPl+STGbIVYQDyAjR2kZG3xlejbkWKhVzQKrCyKNPIvSJ7ISptb1ictsdHapHRBhJnPRx8GybZwCz9f1+i1gmOsHWlxqf6048HmYEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzxJxpAZo2amNn1nyhJDU414B5FAr3wu5d5lR60dAwY=;
 b=n/qWL+vUPTkWlXVbCbVaFZBhxYcGRBlaLzgbkpMiZB+6l1WAZv9WmcIz2jfdTBgTUhU3M6Su56e4Wb5Gv0qkh3uOmTMKLT3XZVznZ/z3QQZpYtol2YZArzTkLjFuPNcuQelpWLDkwtHajwiVYmgLv+d2uQng5ElSlXsLCzx4xmukGQiREQvZymI3Hko3fgo+egaJPLmIaqr5p86ADcJefWjSqZRnLAcUyJsz/VZ+kVLCQ5BsNlmuOSipGlLuO+Nkxhe4ALX0gp0TKspdFd50jaVgVFk7zwnjFf+vD0xvAMYhir45H/3uhKUe8XWG1xKAsDL/hN9UrMQbVuvpijn2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzxJxpAZo2amNn1nyhJDU414B5FAr3wu5d5lR60dAwY=;
 b=rUJzq76U4moxLpsEBu4v50elvi2ZdoMGUfC4N6aiJvYYTCcvBXI3NuOQ7JMkGi7Trydr7iRRvbT1oCVtRCveI8g/DETDkFMX6gHzefE4V5Y8b6KROxPRFlwM0cDCsiVPXhjTu0zql+ECxvPU+/CxtxjpqbfBkvktEE4X3nBQiwo=
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27)
 by AM6PR04MB4904.eurprd04.prod.outlook.com (2603:10a6:20b:c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Thu, 24 Feb
 2022 14:31:46 +0000
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::f468:5bbf:f34c:668]) by VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::f468:5bbf:f34c:668%6]) with mapi id 15.20.5017.023; Thu, 24 Feb 2022
 14:31:46 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        dl-linux-imx <linux-imx@nxp.com>, Wolfram Sang <wsa@kernel.org>
Subject: RE: [PATCH] iio: accel: mma8452: remove the reset operation during
 driver probe
Thread-Topic: [PATCH] iio: accel: mma8452: remove the reset operation during
 driver probe
Thread-Index: AQHYJ6hClmYnFKRpxkqcnCLeaYH3M6yfx1WAgAL+joA=
Date:   Thu, 24 Feb 2022 14:31:46 +0000
Message-ID: <VI1PR04MB401628231C1D06E318820D26903D9@VI1PR04MB4016.eurprd04.prod.outlook.com>
References: <1645505151-5789-1-git-send-email-haibo.chen@nxp.com>
 <20220222164331.00002d18@Huawei.com>
In-Reply-To: <20220222164331.00002d18@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6a1e77b-31ac-467a-c6ef-08d9f7a262c9
x-ms-traffictypediagnostic: AM6PR04MB4904:EE_
x-microsoft-antispam-prvs: <AM6PR04MB4904F1F522488C6A83295761903D9@AM6PR04MB4904.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJF5zvINEl3EB36Kh4gpbyrpD7hNfXkGSmzxEXTlElMR3HylzvvxpQwxjj8nsa9g+GY/C1hJ5ec8rpzJ/ZlHke9ky/eSZc+w+6I+KBjqZdEzPUGliwDC7YNVP+FntcjJrH0uokv/Nvd/MyTl/BCRP5dB9JwNsRiEhQu42BhapzebWPnKmS2GV/1zhYZ5wXmeOI/uTKoZSkDYRtFBxDUn4Hd0x4d9eEVWwalzYtlNXTYJie49QEc6RRLw4aC8Z89IAzx+6YjudR7m9tkJVI7a+J807iiJUYJJ61kWesS3/rKtNFq/pSA98ztr2lYRCKrOA5C5HakX9o9wv7+qwJkns9eyc1ld5XH9EIYrhNJSWinwzlRySyFx/N8aM1DGJIXa2DtAK2w2vMp8qETbqcXg97/Mx5BHj6EJWbn43kEruhGe9OwlR8RKQl+wyteL9g7qy9Qza8FFX0uz7MD6aQtf3PVvBE4T1HHySO7ayPhfUf2vSXNJ9A+4ka2nst7jIuvRJJPRibuJEM3HqQqXM6gcn7nQERoAdyoVt+Y5wkaXTd2zJYqQ2vZTV6Zz2Ey4IO5w/tWFbVw6VDD98SthYgaw7ZXRiAmOjqFifkjInZZYrtIq+64bHmsFW4rLJylFfqIW3AnsRMxMu7xd1dJVPkcUlHsPB64PFAM/iO9twV/pX2t8SoxDscIXW30eLE/ZILgE8kx/tsIqb6t8U2tD0NfQSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(54906003)(2906002)(86362001)(508600001)(33656002)(9686003)(8936002)(99936003)(316002)(5660300002)(6506007)(66556008)(53546011)(6916009)(66946007)(76116006)(122000001)(4326008)(38100700002)(7696005)(186003)(26005)(71200400001)(66476007)(55016003)(8676002)(64756008)(66446008)(52536014)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTRBMmk0cEFlRG10TVZBK1o0YmxWK3hIcDBYWW5WdmdYdnMvYlB6cnB1NGxo?=
 =?utf-8?B?azY4c0ZleXpKRzlFSisyanNaUStFZ1BPUEpmZkNsYTdUM2hSR053TzEvVi8z?=
 =?utf-8?B?UUQrSVNrS3JhbEJtU3JKUDJZOWdxN0dRZTlxR0c4TXlJZHhPZS8rdkZ3V2Z4?=
 =?utf-8?B?ZUpuV1RNcStZYnV3RXpFbVBLNHN4NmgrSE52RDFUQTQ3T2NvSWc1Lzh0TWUw?=
 =?utf-8?B?d0xEZitVWElabVpBYU1uQ0hqUmdBZ2RKY29TR0dzS25xMzdobmt6UUFVZ1hK?=
 =?utf-8?B?RlBCMGlyNmZrYVRtdXJGSWIzdFBYV25XZ2NvWjE2TXk2TXpJcmx0UmlTa2NS?=
 =?utf-8?B?cEJnRVBVN0VFY3A3d083TXd1U0tzaU05clJYTHdHN3BDenZza3AyRGMxeURM?=
 =?utf-8?B?UzVWblFsS0M4S3JrdjUrbVpvR1k3L1FsQ0hOeE1SdWRIMGJoZjRURUVpTGFZ?=
 =?utf-8?B?ZmxNUlhuYS9pb3JsZnZmMXVlTnNIb2lYS21jaUhpNC8vQXV5am9WdnUxWDAz?=
 =?utf-8?B?RVZnRE45K0dmalNucU1sRlgybFZLWUxkaVZEVGxoMGZWQkFJV3lkZHZGYzI5?=
 =?utf-8?B?cTdvRkJ5eGlraWpwRTVpK2duV0hRZVoyR2pHYUpCd1VLUWcybFRmVHpyZnd5?=
 =?utf-8?B?dnJVeW91ZDJ0b1NhK3JyRndiblhMbkxiME5XWU1BNHpwMzNMWHMrVFFHbWo4?=
 =?utf-8?B?Zkk0S3UrQlV2bUd4STFoRTN5bGJOUXhaS1FZc2dxZUY3eGN0MmFHb3FJMkxl?=
 =?utf-8?B?TW5OR094MER4bnQ4OEJHY3dJcVJVM0g3dCs3bTF6UzhxR1NFVEkya3ZyRmZx?=
 =?utf-8?B?SitkcWtWc2dybGxYNktpR25icDhZQTJIQnEzaGlXNWVRNzBsSENiRS93d2c5?=
 =?utf-8?B?czdLMmJNbUlzK3A0dmlXazROQy9NTnpjRFp6dnRGY2JqUmVnalR3cmoxK3ln?=
 =?utf-8?B?Q2VqcVVDUmRvNjNDcFA0bmdRVFNxdjNxQ3hhSVJXR2daQVZmQmUvSStVQXl4?=
 =?utf-8?B?TDUyNHVpNERnSTRJRTNTR05kelZPRXJGQWkwR3BpNVpXcFQ0cXk3OUJjY2gx?=
 =?utf-8?B?enFUSEcraG9EaWlpQTVWUkova3N6cFZwajMzT29xUVBzbi9Od0NiaExzSWti?=
 =?utf-8?B?SmJOT3R6SUxoblVyR0d4alZqcDBXZlNYVTNIa20vY2lRMWpZTUJFRTNBZUVE?=
 =?utf-8?B?Z0Y5RzdaQnRJbUYyMUFRNTNOelVNck9VY2hPVDRIT2p5VjNlNmwxMUptMkl1?=
 =?utf-8?B?YUV1a2s2MTVNODJJWmYwN00xOTh0YXg4Y2Rpa201TWV1T3czOG9zYkhHQmFR?=
 =?utf-8?B?Sy9DT2pxREgvWERpcFh1VVJsd2lCRnVUY3piZEhERUpaYXJJMlh1MElhVmVY?=
 =?utf-8?B?R2RING9oaHJhREVwREhnYTRFWXVxaEptRTJudWp0UHIwd3JyUUhUTExFNmNh?=
 =?utf-8?B?bGJ4TXBmNThUTTN3b2dzQWtrWGN4cVYyZGxCd3ZGTDc1alBpSEtpTlFvTUFL?=
 =?utf-8?B?QjhWQXFiZzdMYUN2VWRXdkhQRXlnOVhzWjJDTHVoSjRZUmNzbTUvUDhPSkpu?=
 =?utf-8?B?VlNmU1dpSnpQUUNJM2ZrbWpwdXl2S1dKUmZNYXJVc0QzZU1UazMra0ZTalIv?=
 =?utf-8?B?cWF1ZnF0Ri8wR1hiS0U4Zi9ienE3WEJxbUZkYWtTNGFWYmh2SFJyT1pBa1ZO?=
 =?utf-8?B?ZVNINnpPVHlGTVJSODVmVE81QkVlVm9KcjdYekNxRkp1TWJ3WUNZdzF0R2ph?=
 =?utf-8?B?ejE5Mk45dUZsT01xUWo3V25idDhyejBVZzY4Y0pqSVcrejM2Q0lHVmpYcUM3?=
 =?utf-8?B?bkFqRVR4QlRFMFp4UWVvRTlaTWpzVnIwVUlxdnFCREk5c3hJTFpDMURYSmcw?=
 =?utf-8?B?eTRKTm5OUG1HNzgxcUlsWnlpS082bU16ZW0xcTB3aXFXcnk2NUhxSTVsWWVq?=
 =?utf-8?B?K3FnbHZYOVA1dnNYY01WYmxaNWVCN0JKM3YyZXk0SkRxWVN0cG5HR01XRHFC?=
 =?utf-8?B?NHhLb2MwQTdmVXlTMGl2T3drUThtUFM5QzJIVk9hWlFRWHJab2ozdzYvVkJm?=
 =?utf-8?B?RDc1ejZvMVAzTm5uK0F2dkRBL3lDUHBReFRnMjdqU2dUK0E5UUJvcitpUi8v?=
 =?utf-8?B?VllPVi9BaVJVWU5lOVZ2TXpRakEvemV3TWk0VzBxdmxIbnYxK1doV2tDd0Fj?=
 =?utf-8?Q?/TMNfZfcvErm+DYHsBcf0q8=3D?=
Content-Type: multipart/signed;
        micalg=SHA1;
        protocol="application/x-pkcs7-signature";
        boundary="----=_NextPart_000_039B_01D829CE.4CBB1340"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a1e77b-31ac-467a-c6ef-08d9f7a262c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 14:31:46.2539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYwPCQnnZGAMLIOGH11nU6PlAMtqWfq0jH+d8C+SiBiRDXGek59qSYflMiI25x0sCR4Gnk37viNEU8vI/NvCaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4904
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

------=_NextPart_000_039B_01D829CE.4CBB1340
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Jonathan Cameron [mailto:Jonathan.Cameron@Huawei.com]
> Sent: 2022=E5=B9=B42=E6=9C=8823=E6=97=A5 0:44
> To: Bough Chen <haibo.chen@nxp.com>
> Cc: jic23@kernel.org; lars@metafoo.de; linux-iio@vger.kernel.org;
> pmeerw@pmeerw.net; dl-linux-imx <linux-imx@nxp.com>; Wolfram Sang
> <wsa@kernel.org>
> Subject: Re: [PATCH] iio: accel: mma8452: remove the reset operation
> during driver probe
>=20
> On Tue, 22 Feb 2022 12:45:51 +0800
> <haibo.chen@nxp.com> wrote:
>=20
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > Though Sensor Datasheet define this reset bit in it's CTRL_REG2
> > register, but seems the actual hardware behavior do not align with =
the
> > doc expect. Once the reset bit is set, sensor can=E2=80=99t give =
back an I2C
> > ack, which will cause the probe fail. So just remove this reset
> > operation.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>=20
> Hi Haibo,
>=20
> I'm not really that keen to remove reset on probe as it's normally a =
good
> way to ensure we get a device into a sane state as we have no idea =
what has
> run before we load the driver.
>=20
> Wolfram is there a standard way to work around missing ACK in cases =
like
> this?  Would just ignoring the return value be fine or are their i2c =
masters
> that will get stuck if they don't get the expected ack?

Currently, i2c masters will not get stuck. Only the sensor driver probe =
failed.
Let me do more test about this, currently I find this issue on =
fxls8471/mma8452, and this driver cover many sensors
Not sure whether other sensors has the same behavior.


Best Regards
Haibo chen
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/accel/mma8452.c | 28 ----------------------------
> >  1 file changed, 28 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma8452.c =
b/drivers/iio/accel/mma8452.c
> > index 0016bb947c10..ec9e26fdfb2a 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -1481,30 +1481,6 @@ static void mma8452_trigger_cleanup(struct
> iio_dev *indio_dev)
> >  		iio_trigger_unregister(indio_dev->trig);
> >  }
> >
> > -static int mma8452_reset(struct i2c_client *client) -{
> > -	int i;
> > -	int ret;
> > -
> > -	ret =3D i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
> > -					MMA8452_CTRL_REG2_RST);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	for (i =3D 0; i < 10; i++) {
> > -		usleep_range(100, 200);
> > -		ret =3D i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG2);
> > -		if (ret =3D=3D -EIO)
> > -			continue; /* I2C comm reset */
> > -		if (ret < 0)
> > -			return ret;
> > -		if (!(ret & MMA8452_CTRL_REG2_RST))
> > -			return 0;
> > -	}
> > -
> > -	return -ETIMEDOUT;
> > -}
> > -
> >  static const struct of_device_id mma8452_dt_ids[] =3D {
> >  	{ .compatible =3D "fsl,mma8451", .data =3D
> &mma_chip_info_table[mma8451] },
> >  	{ .compatible =3D "fsl,mma8452", .data =3D
> &mma_chip_info_table[mma8452]
> > }, @@ -1591,10 +1567,6 @@ static int mma8452_probe(struct i2c_client
> *client,
> >  	indio_dev->num_channels =3D data->chip_info->num_channels;
> >  	indio_dev->available_scan_masks =3D mma8452_scan_masks;
> >
> > -	ret =3D mma8452_reset(client);
> > -	if (ret < 0)
> > -		goto disable_regulators;
> > -
> >  	data->data_cfg =3D MMA8452_DATA_CFG_FS_2G;
> >  	ret =3D i2c_smbus_write_byte_data(client, MMA8452_DATA_CFG,
> >  					data->data_cfg);


------=_NextPart_000_039B_01D829CE.4CBB1340
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
MjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIw
S2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhw
LERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlz
dHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VD
QTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCC
ARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVy
cHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9i
YXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0B
AQsFAAOCAQEAJpGYHveFzmgLQ4J62fcmPkd4wJ8urL46itMWCgyLBPRARYB9oArCqPd4j0Yl0RmS
F1oNZgVDYQTy2aLoe+YGm23TkdJsTx1ExTxtv+njRnvvlSXMMULlOIt25/Vj+vTZ/wjFDq6PJOSZ
MSQHaVHSUrkLBT1H0pBmCA1Ecjuo7gUpG5T2NqD5KJP083pJZ+nogA9TVC9Ob+jNx0d/UR7UgRLf
KOxBG05AakTa4luadPIRktiULtjzG20WDhvAIg4M9w1+9SV+LpvvqBtkovpCfj9Rf4pNRV1CjjTY
AFIH0s3Q11HnFd1UNHKUvpp7/SrTyxaCXBO68U5aJz4zDjwIPzCCB+swggbToAMCAQICEy0ABsdV
/0AV+3f0TucAAAAGx1UwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MjIwMTMw
MTRaFw0yMzA5MjIwMTMwMTRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
MjkzNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6VTRRCbJgUEuoR2bppNZQc3ghr
l0pDEZjK8uaayFYadelTc6iWe8EBLWrrOWd17yNeXc054yw+Yu8eI1IWMEE/mo5l93Kw+BkuCUda
vpqZUMOvaPDKkHNPBNPJ6AP+vmZW8p/46dxo6Nx6xGzkpbUZ1Ju1a9LuxeFQBNNvV54wYbFmoKJF
eQQ3RZdEafNucOw8ukTyWurcC8fPUQwqE1sFRdtjLeJWZBtrvNim4oikb5UFxcmoaQkJ/sqoJGZL
+bR3ZZx3101+Y7RJp56hfqT1eqkJkc7OTz+tsZx3p1a6r266NCB/RBIGVD2cFmhUs2Uitp/oB+9k
BhycuX8wowECAwEAAaOCBAowggQGMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwQQYDVR0RBDowOKAiBgorBgEEAYI3FAIDoBQM
EmhhaWJvLmNoZW5AbnhwLmNvbYESaGFpYm8uY2hlbkBueHAuY29tMB0GA1UdDgQWBBQY587dMxoS
HzI5SkUyoLrumaVa5jAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAsjJuJnMzvA59CAlY
87eQCOafWbMF4HfC4oobtAqboB48BtCZ5dOeo+X4XQRaSmTwFJ2hZjX614KFnRGXLk/nDIY4pp8+
fqfgHKUdY1ceVqs+Kjtabk3gY8zq7PtFUsAkwp4OW23kwphh7Awx1tf3XRZeOqwiVuk5V57GT8Tu
dKNiOZqut3mrcdZINNUsqjt7ZA82r4ov5MbEBHeWVjo7CeWbgZFZhKhMKC9+2DKEUkdDJUcDYqxz
+Rh+6B+dgxeYkTGIqHELhkMjMCC5SwRNHfCxXCI+qRy4zIAo2K3V96zs3ungqiFZuFrpatfSBfAL
d86AIrOgsHhvOB0UU1W//zGCBLMwggSvAgEBMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlz
ZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0ABsdWyH4wxYEw
yQ4AAAAGx1YwCQYFKw4DAhoFAKCCArkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIwMjI0MTQzMTQzWjAjBgkqhkiG9w0BCQQxFgQUhqkgOS8FMbEMfqTNF0tjC4cX
bLUwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsGAQQBgjcQBDGB0TCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMIHhBgsqhkiG9w0BCRACCzGB0aCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMA0GCSqGSIb3DQEBAQUABIIBAIVl
khzj/UvKiBOOu63nTNlc/xdPloPXkAksiwO8YQn1JAR9q1wD28ALLA2UV8ipQM0InS4dK92QfMK1
5qqA0E0DhuNvsxsSLRR+uPXYDO0HokNm0FgAdd5K78APgL8QuQXNyrxjxl94M4G4TwQlPfUuzC8R
VxeL3/r83w5zerVAKqs+ox3a92pMQDRkb/2u9OheLjPw/CMEnv0Px46emfyWR6tEsGo8d7CAJ0vC
xsKk1PjUZ4tLEqgiWibhiVCHwUmbcTLvnTW17aMxEFSKfpxLDhcGM2R7iwZeaQFr14onp8TXHyVh
XG4EWAuyV6bik7lFWczsPHsRTDiTfv5tJZ4AAAAAAAA=

------=_NextPart_000_039B_01D829CE.4CBB1340--
