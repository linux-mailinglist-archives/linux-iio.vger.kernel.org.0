Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B051F4B5E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2019 13:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfKHMXJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Nov 2019 07:23:09 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:39966 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732087AbfKHMXJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Nov 2019 07:23:09 -0500
X-Greylist: delayed 649 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 07:23:08 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA8C8T02007914;
        Fri, 8 Nov 2019 04:11:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=wkI8cH/jniv5ALj2FXj1K1Gx5TA77V/F3NP+QuIDmwc=;
 b=KxGr5TAcL9Vou3gPWV6NkqchrvfVNa7YPqofRSbhM2uE/ECLf6y4pQjs9zJJUGW/GPzv
 JYRYpiWSKOgfl5Nt9fRbJLxlLt4RB/wEgPZDwBrE4K+dFB1CnwFup4Cm+uA2+hd76rpT
 JJOnZ9LvQY/rzD+s1Ne4HbmJxIMCI9j2RERD1Y6jmexXf63up62MdHliAiCf+77tcqni
 762wbl7ClBrw0mB1NBpNItaRR7DR1laKp95TKeaYAcyO5skLb/mCUV54cilUEzNM/Cup
 EZn9gNViGiINiMWsXkA9EdlsG1GDJKTp+s6uSZv8TUu6fq5xzx2pzWs3ll7NkxkOdFLq 9Q== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by mx0b-00328301.pphosted.com with ESMTP id 2w50g1g5x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 04:11:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/bnMkK4jF9L3DILPOkqD9Bz+mRXUDDhnVOFqzB1cEnuBX2KCgkXXKsgewECvyd9lddXvoOLcDy4mqmSRLvrf+U+EWqptUFtmKt1rFRdW79MBJOZT6QUT+/X22cOpWxQ+89jL7bwylZrcAWe/z/LtJHUScR/zIqUmYBS32T/gMqJdkGz/MvifB/lK8MrGEGa7jnYuc1199IETHD43cjEvr6xPfH5JWWYsVFeycNrNl+LMmzkRRpdAJ4EiRHQq+yvaKyt3bgqyb6rcLrrqmVKo53kY+J/1GnSiVpvgNLosf/UUiFa2wW6wxwNkrmOYfwku6F8dnbd1hTDhwZFHhTgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkI8cH/jniv5ALj2FXj1K1Gx5TA77V/F3NP+QuIDmwc=;
 b=QdKu/TLwcyT4Hkey3hC5aOusyhQ3VPLBLMOplnNQYKBhz+yOiB4CA+357w7igYjUVj1apUPPhFyaueobbhwuSqymWpB33x3ly7lsGfzbxOTtC6+L1zI7dwQjD5bJzt46Mqr5AVRGQjTtfuwb0FlfzJv3EIs2KZDFJ8qAyXYrdSAm/1CwzNhRtjsAlD35k2hcPiG/08YLqvPa/fEEy4rZwrikR+3PejbQKcsukxjo72LLTX44NK1AvRAvR4laqXdwfgCNsAgnRfN5YzWuPl2s4z5Y2iJGq06/L67eP19uMBKwjUvJ5Ob6dulstc0pdXWIloMkJeaNl+9Omofx2LFkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkI8cH/jniv5ALj2FXj1K1Gx5TA77V/F3NP+QuIDmwc=;
 b=DaqaOGMUnD71m8KCYH0Cc0rRJ41YKg7/uyBDPkilCWOA7qZU0HAFHFNM+ExWG2RtkmSgbxgpbZVcwbwAghE1bTtJgqDPUDw+D2gqpt0n8NvNPounujJg3o4DJoK/Z9XSEm4umYfgAYcRa9WGKO8x238M50cmuJg2113KHfveQEk=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3871.namprd12.prod.outlook.com (10.255.238.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 12:11:46 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 12:11:46 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imo: mpu6050: add vdd-supply
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: imo: mpu6050: add vdd-supply
Thread-Index: AQHVlZuj3hjZAXfriEOOlDXmX+bcQ6eBL+la
Date:   Fri, 8 Nov 2019 12:11:46 +0000
Message-ID: <MN2PR12MB33733917812945D0293D9D27C47B0@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20191107184342.20361-1-stephan@gerhold.net>
In-Reply-To: <20191107184342.20361-1-stephan@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27f4ff27-4062-4b00-db6a-08d76444d38c
x-ms-traffictypediagnostic: MN2PR12MB3871:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR12MB38719631BEA0881C5626663AC47B0@MN2PR12MB3871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39850400004)(366004)(189003)(199004)(6306002)(11346002)(91956017)(76116006)(86362001)(3846002)(66446008)(64756008)(66476007)(71190400001)(71200400001)(6116002)(229853002)(8676002)(186003)(6436002)(66946007)(66556008)(7696005)(52536014)(76176011)(81156014)(81166006)(2906002)(53546011)(6506007)(6246003)(26005)(102836004)(316002)(8936002)(80792005)(66066001)(110136005)(54906003)(5660300002)(99286004)(256004)(7416002)(7736002)(14454004)(74316002)(966005)(478600001)(4326008)(55016002)(9686003)(446003)(486006)(33656002)(476003)(5024004)(305945005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3871;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qs/1/3C0lNDMG7fvLGDphMWlT5jzW+2B2EeW2T9npxwsTD7uAQjeEmjyUM7uqKNjpKWwo9COZVNoNKaTtbKsWh/cYXeMi6/BniayE6aOvAo2IF0CIin+4CclRcIjpHDjXal0mmSzW+coJw29ACE8DOfOhiRsJu/MV96Zju27XBik/GlomuRb/xbZOwt24bRTgJywRfRwcY1CF96Mt/4FwVv+dlkNwi+ut4zi0SLUXsmJ7y31NSQ/TqyZK9U2cKaV26hXsZkwaf9NyjMHHZc4sN/IXeT1HtG7s6xXjiPhNOrqlqXH5spYoyxOb3i/IuVKPXVtlbHpjyBsmAGYdG39jfz8PgLsGxf04jAu9Fsjucl7P6DVl4QbGc8J7RA6pyUDm9TqZQstGUeFRUlanQ38ExufCe8EDMvAwIt/+R+RTAj0i2QgiJ07uwbRZQpcKEz4ahLJf3Cqo8wxWJRkUOWOeENeb/Rh4A/y8m4poVHHg0k=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f4ff27-4062-4b00-db6a-08d76444d38c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 12:11:46.4362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qnhqEprJJcer3KI429k0r6Cl+zz1Vu8WqKA9kxHCCwaKIeE7PT9rW5T5wcy8kqglQDEvNAjlLBO9nqPJ8QHj2OoakKWAuDOYNMPRX8Lo0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_03:2019-11-08,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080120
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Stephan Gerhold <stephan@gerhold.net>=0A=
=0A=
Sent: Thursday, November 7, 2019 19:43=0A=
=0A=
To: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Cc: Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>;=
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Rob Herring <robh+dt@kernel.or=
g>; Mark Rutland <mark.rutland@arm.com>; Linus Walleij <linus.walleij@linar=
o.org>; Brian Masney <masneyb@onstation.org>;=0A=
 Jonathan Marek <jonathan@marek.ca>; Jean-Baptiste Maneyrol <JManeyrol@inve=
nsense.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicet=
ree@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.=
org <linux-kernel@vger.kernel.org>;=0A=
 Stephan Gerhold <stephan@gerhold.net>=0A=
=0A=
Subject: [PATCH v2 1/2] dt-bindings: iio: imo: mpu6050: add vdd-supply=0A=
=0A=
=A0=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
inv_mpu6050 now supports an additional vdd-supply; document it.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>=0A=
=0A=
=0A=
=0A=
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>=0A=
=0A=
=0A=
=0A=
---=0A=
=0A=
=0A=
=0A=
Changes in v2:=0A=
=0A=
=0A=
=0A=
=A0 - Add Reviewed-by from Linus Walleij=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
v1: =0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_linu=
x-2Diio_20191106183536.123070-2D1-2Dstephan-40gerhold.net_&d=3DDwIDAg&c=3DW=
oJWtq5JV8YrKnzRxvD8NxmTP_1wxfE0prPmo0NeZwg&r=3D4jiDX_1brsSWfCjfA6Ovj1d4h9MF=
8q7Xk5aBwG28mVk&m=3DO82MQPnLTvlD0nxDzFW1KS3aZpWiI3qYUZwJUy_qqxc&s=3Dddvzqy0=
PywWDCnge7xbJIhpqN9NltbLrzi4EBVdeA_o&e=3D=0A=
=0A=
=0A=
=0A=
=0A=
---=0A=
=0A=
=0A=
=0A=
=A0Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +=0A=
=0A=
=0A=
=0A=
=A01 file changed, 1 insertion(+)=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Do=
cumentation/devicetree/bindings/iio/imu/inv_mpu6050.txt=0A=
=0A=
=0A=
=0A=
index 268bf7568e19..c5ee8a20af9f 100644=0A=
=0A=
=0A=
=0A=
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt=0A=
=0A=
=0A=
=0A=
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt=0A=
=0A=
=0A=
=0A=
@@ -21,6 +21,7 @@ Required properties:=0A=
=0A=
=0A=
=0A=
=A0=A0 bindings.=0A=
=0A=
=0A=
=0A=
=A0=0A=
=0A=
=0A=
=0A=
=A0Optional properties:=0A=
=0A=
=0A=
=0A=
+ - vdd-supply: regulator phandle for VDD supply=0A=
=0A=
=0A=
=0A=
=A0 - vddio-supply: regulator phandle for VDDIO supply=0A=
=0A=
=0A=
=0A=
=A0 - mount-matrix: an optional 3x3 mounting rotation matrix=0A=
=0A=
=0A=
=0A=
=A0 - i2c-gate node.=A0 These devices also support an auxiliary i2c bus.=A0=
 This is=0A=
=0A=
=0A=
=0A=
-- =0A=
=0A=
=0A=
=0A=
2.23.0=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
