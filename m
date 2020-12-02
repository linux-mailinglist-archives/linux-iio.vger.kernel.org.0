Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F632CBE1C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 14:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgLBNVq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 08:21:46 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:61886 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbgLBNVp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 08:21:45 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B2DJ7Hu031387;
        Wed, 2 Dec 2020 05:20:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=Vu7u+T9Qh2HU5GfFPuLlKbn5S3+eTm3NTzaD17nnsTc=;
 b=bpu/u3H/fHx3FZyL6plKYi2Z6rDBwXytOg8DBhMcBTwFG5ftdJAfAdu0NRVsWmTlHiyl
 ynYkeQkG77YzxcTYt3s9omARWZKcYUPc3hxJWeaNHTuLoGeBW38oBvFGwr2lQBnsgHID
 1VKQGcFkYJvVFUJJiH3ezJ0diluNjSzIuaIw3vFqDB6Jusgs4fs4jXef9xZShQHhqUrU
 D5Zx24LyKw1sVInssfR3hkFuurwOHFKf6dXqJxROoX4aP8EpOegfyFMMrlKeCRDfUbjX
 Pw6aTTzGq3m0U/JCo3bYM5vp5/ga3C/dDEf4c2KgAkhQVyyTMXeQvpEUenYAgbsYjELP 8g== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2057.outbound.protection.outlook.com [104.47.36.57])
        by mx0a-00328301.pphosted.com with ESMTP id 355cap8vuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:20:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFJ/nz0c8BOIOQ5+1KkAb2WyKlr+1tILc1evVTp17K4vnKqivU1XlnAIutnoQBzEfji9s8v2z7zKH6SWmuYEWAX8/S30Mb1bxImJ1JVGoABrOfWeZdABFKnlese6bcdQtR7SZcWBFOKmR7jaPRmPBygsX052w5rpF6/K19Iwjek3v8ycTINw+kHfvqikm8+fjb/NBBHmNK9zPnlf3RgUZ+E5rgPpUhwIAraoXQXwXxm87oWeWDfsC3Ah3KdEtqZyh9khdvxmpe6E4WRjdvWlvyztBWCBVwCexVl7qb3YTm+24eM3zdOzKo34ruKNLCUahSw8IbD1FnYZp9CiFglT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu7u+T9Qh2HU5GfFPuLlKbn5S3+eTm3NTzaD17nnsTc=;
 b=EYqKauoxxru0wAohHHHsZLSJHNuO9O0IoMDKrIKuMgHGkE02E3v2DfkY9IZladOV4cbXreRrIAjTLjUw9rUtkLuezsPOJARKBHvq7JGEIeRbDbh+0j8N/q9k6pdRFMpPhUN1Nk1g20N7LtH2hsZ/ofrqMeyTJeN178Osei2a1Vdhv44URIq/h9Il1OuCOATqA1JXBxShvZKXTHfxr1qSx7jINzLJ1BWErzD/qw/Bj1nOkAi60XhyLFfQ0sg/YdtcjIaYBKyazSPsz5UqZPrAUhjwL5IdrhWx5iVXrQnnOBiiBF99uf3yMO6pdPYAoa+etvzwaGBQR7/OtL22BNZIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu7u+T9Qh2HU5GfFPuLlKbn5S3+eTm3NTzaD17nnsTc=;
 b=NFHhcKjAGpXHXdRCOz8z/XIYk8jn9KP7KaP6JuZv/0LLfNtxCgcw2X3z1WKROgs3IVPNNqam73qdvwLh0WouDEbtgvnKDgi+HANrVc0LFlZCz03OoYSmTaU9C/3dPOdsft0m5xLHAsTbh+G11bUd2oHbPHpDNI0rcqxqtvwSBWs=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 2 Dec
 2020 13:20:33 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::79bf:5f72:1126:57f7]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::79bf:5f72:1126:57f7%5]) with mapi id 15.20.3632.018; Wed, 2 Dec 2020
 13:20:33 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,mpu6880
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,mpu6880
Thread-Index: AQHWyJiRE4tWu4K5sUWRD6VUMED3HqnjyirO
Date:   Wed, 2 Dec 2020 13:20:33 +0000
Message-ID: <BL0PR12MB501126BA823EFF8145E0D98BC4F30@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20201202104656.5119-1-stephan@gerhold.net>
In-Reply-To: <20201202104656.5119-1-stephan@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gerhold.net; dkim=none (message not signed)
 header.d=none;gerhold.net; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [2a01:e0a:393:a700:6076:fcf1:88ca:fb96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55acdc5d-6f0a-470a-73c9-08d896c50c82
x-ms-traffictypediagnostic: MN2PR12MB4064:
x-microsoft-antispam-prvs: <MN2PR12MB40644D4FDF425D8A838A0A8DC4F30@MN2PR12MB4064.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIoQhL49sZCTAC6LwKUT2Xixz8D7O1BmfXmqH/TtLrvhQEySECLBJGj1Wdj7IRodtkdQx5+CBTWvAyAXfnNE29gXuHozCQ3bnM4nsbTHHrBNopng4ilLi/0E+55wO3AWBsd779vDNiT5vO/5BcwOvMZC78HHhT/eTqlOn1p4d53VtDO2tp524XWAJccFmvMg+a9Ix3ZQcppwTBSejoMshZw00YWVbCB5UhLY/lavRCtSDMT4pY5wvzVHRUncHh+MLCaOqMSRm6cCUF1YAiCyji6n33kHh3VJF4uwaMPbr6dKtaKrGd4DR1as1ZKnHwb0lOVnwsmsZ9nh6NdI4EdPSOfcb0IkqdEKkhI6QYZ3us++Hx/nGuC8m7biBGu42/RiDs5J7dfN8dmwz7WkT29j6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(39850400004)(136003)(55016002)(66946007)(91956017)(9686003)(64756008)(66556008)(66446008)(86362001)(71200400001)(6506007)(5660300002)(53546011)(52536014)(33656002)(2906002)(76116006)(316002)(66476007)(8936002)(186003)(966005)(4326008)(54906003)(7696005)(478600001)(8676002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?1+eN4s5keLrdm8jsyVmz5ifrd5HqUUgD6DPNlYMpa/O9BrcwpKs9TygoWk?=
 =?iso-8859-1?Q?wdeGxmB8DZ3Vn4dORdSrg0Ig+LxJ8oh+2iQ/4ZkN+VcfBB0JmNjJr6aF1d?=
 =?iso-8859-1?Q?h9L4M5gYFBpXo6IURCdXSt11oSVAhXfVOMon+DH9foLagmvaGEcs1Zrr9T?=
 =?iso-8859-1?Q?gay6E/Idu0s3tlnL+o5F30O7Bbz5bOnc4ygr9Cc5lpyr+uAp2UKQSo9aPq?=
 =?iso-8859-1?Q?SvBBKc+AjUfG1cb5Yhw+nQeRFHalvK12pmZYjvFeUMCNtgQMOTW1Rp77yY?=
 =?iso-8859-1?Q?tyByhRZwMstBhYtInSZ7X/+UWb3Da2rnbVljhSnp8RYVtvNJxttYYBEUj7?=
 =?iso-8859-1?Q?2sBsItLdMlsyOXMr0uR4ROufQbAdIZl+UecxYElVmDV0jCBKrn/Uv+y2tN?=
 =?iso-8859-1?Q?ztp0VDr2ACtalHF88JJbbMo534/qMJXYdiTxIzeJHUzQFtgvfO90bRlnhB?=
 =?iso-8859-1?Q?d048PIfMZTW5bxxhSm8TIPl7Q+Yu/PNtCKblDKNtlIBHUcixtKuTMtDO50?=
 =?iso-8859-1?Q?hhjgULwNRgN/odgHARzlQ7BLGlI6237buFgY+HSnsz7YoFCthnXQ+YVtwb?=
 =?iso-8859-1?Q?jMPoHK+QlL3Wgy8yjFyZUNmRzJGLeyYyvtNTj3U0lP9DdRVyb8dyV9a5bc?=
 =?iso-8859-1?Q?MNEpwJUd183Kmpd9APu+JQAcpvKatJ+7GaJ1fSekQJzvtpKiOz2CCvsdyX?=
 =?iso-8859-1?Q?hxguAdVxy8A23WApMhfBaAN6zgFSuy+6QlT6mNVK70Por2SQ+Xn/SIOh/y?=
 =?iso-8859-1?Q?1q9PA7xEOA+DLF6/Xj2JxGaIx1dif6oqtfGiOyRgBT4q9Rr6YItrV7XFX/?=
 =?iso-8859-1?Q?mZov5c8PfoZ0jbiPjhwY8vZKHJKQDu105YPkHGcIie7kx3A6cDKMnEf9p+?=
 =?iso-8859-1?Q?PMOMFZcL2XuRC15Pwu0Y9CI2Hd7YKTp76yF3IqVSnzUd8zFbyWwPTdAc9H?=
 =?iso-8859-1?Q?Um/jvMSSE6hEoWeoqYxEY18xRjLIrzKxoXL/LeWex44t/SiDmicqOXdd94?=
 =?iso-8859-1?Q?T1QWVB65hfHgnm1o1d5+7sfz2Z23IgqKPFvZsYxob+rppFdAih4MrG9R27?=
 =?iso-8859-1?Q?2WfLf4S/ofRc9h8wAwiOXfM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55acdc5d-6f0a-470a-73c9-08d896c50c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 13:20:33.4359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkkPQ9Qq3jK3vh8aA10Nu2C0V/Vofg6xrwOks+6mNlagwemSv7uJHzJc2ceLmgOow8jg93XH1aJxLU1Rd4DHUwKwrpcwVoGyUqsSJ1SEU1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_06:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020080
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Perfect, thanks.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
From: Stephan Gerhold <stephan@gerhold.net>=0A=
Sent: Wednesday, December 2, 2020 11:46=0A=
To: Jonathan Cameron <jic23@kernel.org>=0A=
Cc: Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pm=
eerw.net>; Rob Herring <robh+dt@kernel.org>; linux-iio@vger.kernel.org <lin=
ux-iio@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel=
.org>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; Stephan Gerhold <=
stephan@gerhold.net>=0A=
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Document invensense=
,mpu6880 =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
MPU-6880 seems to be very similar to MPU-6500 / MPU-6050 and it works=0A=
fine with some minor additions for the mpu6050 driver.=0A=
Add a compatible for it to the binding documentation.=0A=
=0A=
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>=0A=
---=0A=
Note: This applies only on top of the patch for the YAML conversion:=0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_linu=
x-2Diio_20201128173343.390165-2D3-2Djic23-40kernel.org_&d=3DDwIDAg&c=3DWoJW=
tq5JV8YrKnzRxvD8NxmTP_1wxfE0prPmo0NeZwg&r=3D4jiDX_1brsSWfCjfA6Ovj1d4h9MF8q7=
Xk5aBwG28mVk&m=3D7Gw_jalJwa1D4BnMzg_LfHmFCU9XHw85vFukmE0KiPM&s=3Dwl10XQo2t0=
i1smI63VAGI6SEpE9866BnfB1CDdyDRAc&e=3D =0A=
I guess that one will be applied very soon so I think this is easier :)=0A=
=0A=
Changes in v2: None :)=0A=
---=0A=
=A0.../devicetree/bindings/iio/imu/invensense,mpu6050.yaml=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | 1 +=0A=
=A01 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.y=
aml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml=0A=
index 9268b6ca2afe..edbc2921aabd 100644=0A=
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml=0A=
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml=0A=
@@ -25,6 +25,7 @@ properties:=0A=
=A0=A0=A0=A0=A0=A0 - invensense,mpu6050=0A=
=A0=A0=A0=A0=A0=A0 - invensense,mpu6500=0A=
=A0=A0=A0=A0=A0=A0 - invensense,mpu6515=0A=
+=A0=A0=A0=A0=A0 - invensense,mpu6880=0A=
=A0=A0=A0=A0=A0=A0 - invensense,mpu9150=0A=
=A0=A0=A0=A0=A0=A0 - invensense,mpu9250=0A=
=A0=A0=A0=A0=A0=A0 - invensense,mpu9255=0A=
-- =0A=
2.29.2=0A=
