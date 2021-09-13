Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7E2408B01
	for <lists+linux-iio@lfdr.de>; Mon, 13 Sep 2021 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhIMM0B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Sep 2021 08:26:01 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:19958 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235143AbhIMM0B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Sep 2021 08:26:01 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2021 08:26:01 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DAX5TP002150;
        Mon, 13 Sep 2021 05:19:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=E8knmhx3ORdgjkXTlTEAuqWsRukphaXonlha3ysGQRY=;
 b=oSxgvI5knsbZRlKbZs7BHfxvzewFiQLk8TwuGY+wYhlfUiTZ0/4SP9x8hsdHhS70bF9s
 p5F0sVXdnMvkdPRTI1c2z7Yoxi9gpX7noAe7OhSjvF5h41lYQ5H6XEZRw4vu2hyI+I9t
 OtlJHgINdvMW9PKrEkNZdQenBlk79jjQcNsBhBlSZ+c5en7eVHmNiDd4d2gA7yZvi5ed
 oqX4fXH1mnRYVOOuCJSORkrxsDWfnHHgQQ1ZR9rxDEN7KvlcpjOK4xdEwHV8fA6AgohB
 gK1udgh7UXv5I9/A9hRCgBEblH2rzOCtTNQPxDnJLj2P1QsX/h/ueYzGlGOhqH9vsWO4 oA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx0b-00328301.pphosted.com with ESMTP id 3b24yy81hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 05:19:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfBYOY0ID/nCGAEcvqWdbxPBdQ/HgDqti7e7x4UeAsuzaaEDLDi4jW9dxCieB1NdS9PfUhzl08win+jCbXTlci9ebOqfA8rFb3ZFKXoLKRTqJlrXv1H5UvOHzpEyAzQ2Zmb3sEZ2OGfaCDvkQ8BKKz/IpN+LyWHARklu0UWM3UjpUcPVf7eii3NyNnW7Zs59bcZwSAFPh6LidJ+3fblfqBQIN8QoV3dLFnrenCHtFOMBnry5/L1QZMj2CGqPLG57QnP/AdVgY62MUp74F2sK+6WOYdDTONMPIymaLC6/KqEnKhJn3dA+E6w+sv9vi5kVIOr411AnvvLKdJLeK8IAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E8knmhx3ORdgjkXTlTEAuqWsRukphaXonlha3ysGQRY=;
 b=WV3ZFPeXpyuivhtO4H3r3B/qSFn7MOlqtfbRXQrv4mAzc5xxxLQKRjZOw5KpELS/ye6+CTnILQO3muf7qfqjA0q3GXkgsfBDLlG48p2Q42Ff3ZMjSt8INxJxFTKF8istz5axDjnZ5axuLtwWFBXUUUnhcZSrBUw8T+p/Si6wWBsM2bmL8ATSFJVbV/aM3K5CaK6YzPLyKpKYrSd4K/Q/7c9kT82pLj0OIrzWy8LfMZhbnfaUgjxHLs0izuJtFuC6nnhIMPw973QXSfw30zgzt9AIB/Kbsc2MkraZ3VnGJsBxlBTPrnzGVXQ+V7JQFfH0S6IY7ynJRZXT28jppy1DIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8knmhx3ORdgjkXTlTEAuqWsRukphaXonlha3ysGQRY=;
 b=gnifH8f9NSDsa3KYyBf4qfSXl7XYUyts5gqyPlVJnVdCGwHpNTNecxUkn9bQDcIjRVvz7HGuGPW2hYBGL7USGkjDtEtjegrdobQKNuMo5NopyASRr5yxDH+M9z/qRbKIe/7noGBQ/Ex7rToeB9XZiqnCqJFN/MYZhSAFy42lcyI=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 12:19:10 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::4c7e:597a:c4cc:a3e4]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::4c7e:597a:c4cc:a3e4%7]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 12:19:10 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Mark acpi match table as maybe
 unused
Thread-Topic: [PATCH v2] iio: imu: inv_mpu6050: Mark acpi match table as maybe
 unused
Thread-Index: AQHXqJKbrwyr5OYNn0yUo6YD7QTTNquh4H1F
Date:   Mon, 13 Sep 2021 12:19:10 +0000
Message-ID: <BL0PR12MB5011F73C07A4EB499BCEBCC0C4D99@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210913112913.2148026-1-daniel@0x0f.com>
In-Reply-To: <20210913112913.2148026-1-daniel@0x0f.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 2bae600f-6193-5c73-564a-fd060fda8cf9
authentication-results: 0x0f.com; dkim=none (message not signed)
 header.d=none;0x0f.com; dmarc=none action=none header.from=invensense.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8c44fc5-349f-41b8-0479-08d976b0b12c
x-ms-traffictypediagnostic: MN2PR12MB4406:
x-microsoft-antispam-prvs: <MN2PR12MB44069858D21A6F8F2DA82183C4D99@MN2PR12MB4406.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y44uQl5YU1JSIBk9jM8y6i01xkPzWZjSd4NAgGC0p3I0SSAwE1THwAW+z7qbeht39tVGbvy4yfAobXUOlzI+INiNwpmtroA1hss5I0OZpt/YgcPEVUfTqXHpf94Gf4ujWMfAVTifNiqiyFidQwheiWKAkwBTgZ0tiCHynllQ3CeIwMQZYjJhodDFa5Le26zHcXZ58k12r7J9gJXgxO2VuopW62pEcQU6umBsir1CaC8zq8ZLjmet2c92cD+80bm0v4UqWvkI0HwRn9wfrOdKr3EVYi9DPlDALMIqSV+vpIZ9iefZZL43CM523VIfX6qZb16gl9Ox/y05GEbgtYMt2bsk4jc5+uPfuGMaqs3R9WLcc4lgEaKdxyB0xQGiBJ2NzqDlspEbLho/qubeg3Yjx989YA38tHoRquTF5IjfRmWt3l8koiV7CuZMy3dnYTMGGnBoPoHYazzQRgeEMO4gGyMt3C2zKTz4lqxERiUioLlKmbOZ26k/qYM6CvfZFxgLKjNo/gKxPPInnkdwabc1BBWILmjoU+4UJq2bCY/tLDxDGrKAFlZke+evFqknHXE8V8IZnthLS86R5qrp3nUqM3uSIqLoJRaDxH2CBuSpF0HL9q1FKMjGCwPOkHv2iitnFpPv5yAAiTSrTQBJKMCwerdZmU0YRZhMJhqIEpPufBOl7sFgRKUuOqiz1Iz1H1oME4ZBpvH6ok95dw3MZW5JUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(376002)(366004)(83380400001)(86362001)(33656002)(316002)(110136005)(478600001)(2906002)(38070700005)(122000001)(38100700002)(8936002)(186003)(8676002)(53546011)(7696005)(6506007)(91956017)(66556008)(64756008)(66446008)(71200400001)(5660300002)(9686003)(52536014)(66476007)(66946007)(55016002)(76116006)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: vMo7Puznjt/7yM/J6uT37qXg07j4urQ65qrOU+Om4sqhQAbKyZB80BXC76rAR+VCMWFqrSX/NwfJohOpf8GeEJnTmAjpATbN8p0ssVD8eEcBxvzkypFEM83q4G0ek+5+GVIh58Iy4JYMLRr7Q9fsOh2oq0Lq2Mhk0D1bT8QCNs5qpBC0/bColmEY9GgU2QradiVMPD+ONCS8HruIAoLLdiPs+nsLdRPOg0Oa5lQ4xamlYBLljtLRYbrnc5ki9AwSiTqGEOTEPFegg5Ila4rOK6vZkQQRtVtJteTL59J/b3LuACrjtBrhhcD8nulAkanY9iTqWCxP8Agpmm7NY5LfKKaK5fTlpjcJzCxHfjoL1Zx/E5jL2ksHBdb7ZbVa6LssICC+r4PZnx5Bfx7jpclqXDK2yTRsC21VJxW4X93Bfwf0DKvJUzu3rnv9Q6fcqvisWyYYOuxqjETvy1EAUcOCoy+1bF2EKeHE7mc3dht9n2P4JGIY4SUYNeiBYVBMQWkpMjfzw3dtFVzY0WnfiaRMwIs5/114vFQ4aaUuEwYzGEzqfuJPyHIbTbnHA0Q9bQfMNKq3PvxhE6opnUo7VeKeyhNQVjQDRb3JoyFGV6qehNbzi9pqD81B96bKw3iKHA8xJcdY9fUCYDvJ37+2z5Wzf9vXm10V9J5iyC+qQt5P1S/PuCGiWoafLvKFveX5kMODh6vaOawh6BZgZTvW3j/GEYYWyg/FzLaM7HySKnSBtfOZR/BPvJ7NK03eH0EZFbsCQdXyoW2TlLQ4LWNKeDm1nLRtWnY9lE+kdH9uFzhP4RQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c44fc5-349f-41b8-0479-08d976b0b12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 12:19:10.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOpJj0jCJEIPi+/1pS2iQPRd+hWzOo3N1UIsZbJ4a0tBQ1t5wQLmyzbrMpQJaHIfTSrRzeD83K+yz7e1HNgiAlIU+wsLN3AiXCBLwIM0RcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
X-Proofpoint-GUID: KFwF3auqkwpvT5wQucZHNY6s-Lybk4K6
X-Proofpoint-ORIG-GUID: KFwF3auqkwpvT5wQucZHNY6s-Lybk4K6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_04,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130082
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
looks obviously good to me.=0A=
Thanks for your patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: Daniel Palmer <daniel@0x0f.com>=0A=
Sent: Monday, September 13, 2021 13:29=0A=
To: jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>;=
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>; linux-iio@vger.kernel.o=
rg <linux-iio@vger.kernel.org>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Daniel Pal=
mer <daniel@0x0f.com>=0A=
Subject: [PATCH v2] iio: imu: inv_mpu6050: Mark acpi match table as maybe u=
nused =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
When building kernels without ACPI support the table is declared=0A=
but is not used because ACPI_PTR() turns it into a NULL.=0A=
=0A=
Add the __maybe_unused attribute to stop the compiler whining.=0A=
=0A=
Signed-off-by: Daniel Palmer <daniel@0x0f.com>=0A=
---=0A=
Ignore the first version. I'm an idiot and generated a patch,=0A=
check that it worked, noticed it didn't, fixed it up and then=0A=
forgot to regenerate the patch before sending it.=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 2 +-=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c=0A=
index 95f16951c8f4..3ef17e3f50e2 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
@@ -249,7 +249,7 @@ static const struct of_device_id inv_of_match[] =3D {=
=0A=
=A0};=0A=
=A0MODULE_DEVICE_TABLE(of, inv_of_match);=0A=
=A0=0A=
-static const struct acpi_device_id inv_acpi_match[] =3D {=0A=
+static const struct acpi_device_id __maybe_unused inv_acpi_match[] =3D {=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"INVN6500", INV_MPU6500},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 { },=0A=
=A0};=0A=
-- =0A=
2.33.0=0A=
