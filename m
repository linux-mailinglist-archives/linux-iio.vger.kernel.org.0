Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BAD1F15BC
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgFHJnn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 05:43:43 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:44428 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729267AbgFHJnl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 05:43:41 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0589fnVV018109;
        Mon, 8 Jun 2020 02:43:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=7Xp59EillFziqSzF90Ti21mAHFqq/4a0vl+kbjJ7Epo=;
 b=uKbycgzWDs63cY/Q7pE++UlUBTFZcLXLebEr+Cg/u/fQ5liLhVjQ7NF6gI3AG9VWHEuG
 Kjs5mPNHLzjndk3wTVfwtgBDj//04IwnIwlIQxU7nD2jnEYIgjxOoP81VsvRjaB8nGes
 +8K5la/RGYAwdaRnbrq1MfEHwo6eXvZfBRd4JXM2Bt0/kBfhfARRSz6B5HV+z4HpM4oF
 tt87bjZ7r7ifJsh7ws+9Cx9IKZ9XfHUAhcpO3ROj4MXCAAM1yzwi6hlL6NoOpY9pOcIH
 LbUtuQrbviIt9ckPaCDjfuPKwnbWTyKD4ba0+Vdp0zPjOjFUEEuXSUjdNN0SfhPFCpuX OA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-00328301.pphosted.com with ESMTP id 31g8cf0nc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 02:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z58GYhK9LRPd2trQgY3NYN/3ecPJb0T8ZBYlDKIKgKjhCjL5LAYFueUzNgWLajNOwkbD+tt8RUgkGUY0Ncie2V0+Uj/uhbDS+c2/HnRNyvN6r3vUX/HBKEUNxiDb2Cta6f5uev1Ju8Jn/1c0qBse34dkPgJauFoMPHl7hr0P8T10zfDG1GaCXu0wQfCDHGySlatH8jPsmiTVAYpWkZMKbiC7hEaBOI8XGwCnjiim23+Wu3BKr4MB1XGpIR6JHWTRy+0GAzwLopFO0yQxjduoiqQ73TxGqETaQ98lsMxl2CJDRJYVkFFSQPBPtKz82pyo2BxnPvyYn4bB5PvWZ1/8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xp59EillFziqSzF90Ti21mAHFqq/4a0vl+kbjJ7Epo=;
 b=alDRxjMHkeThZtwCiZsAj7pMRnqWdhtkIAQiWYiIQJkidgvDRFs87XwuK6jpcjTUaMsHLdT6NfbeTZrVKg4eADrBBHzDZXMKOqtr6VDHnhcg0wxmX8ONy/wcP+pWkuiEZu4np43T96lZNE+7XybkQfEnwOxvju8nbfhvdQH2Xccpj4DTTyNy9lpzyic8GcRPyp+UEBIJaOiDc1snn6d8jjWLY62mDLHA0UGeJ8kdIfg4nCj76neoIb8kxyBDO00SP7QpqkOY2cHKR73nmhW6u8w9DtO5N81UCeFFkGwXnIm+/jsKKMbMecq68wI7UePpHOXtm2tbaZzWfsWduUwVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xp59EillFziqSzF90Ti21mAHFqq/4a0vl+kbjJ7Epo=;
 b=EaZPzrbHVIvCO1zeY9lURbVSDbuNAR+m3F98GYjzKi3HmcnzGytPjNVJ/KXmEEoqt075ilmR7c6LlR8pvhHWJhVAEr9tIhc/33kVR6KrKIe5dmy129MR8C1JE9YY4ru8YbUxwSZ9uKQg/CjDarIAucS06zOMDbfEuwF9TemJccs=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3104.namprd12.prod.outlook.com (2603:10b6:208:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 09:43:26 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 09:43:26 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: make iio_device_get_drvdata take a const struct
 iio_dev *.
Thread-Topic: [PATCH] iio: make iio_device_get_drvdata take a const struct
 iio_dev *.
Thread-Index: AQHWL5kGzMujMIcNe06JKEbf7GmNBajFAVMCgAa73ACAAtWiXw==
Date:   Mon, 8 Jun 2020 09:43:26 +0000
Message-ID: <MN2PR12MB442273119FE72643B435CCA6C4850@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200521175322.247947-1-jic23@kernel.org>
        <SA0PR12MB44290C81C03F7DAEE315DBFBC48B0@SA0PR12MB4429.namprd12.prod.outlook.com>,<20200606152430.023c9ef6@archlinux>
In-Reply-To: <20200606152430.023c9ef6@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30f9540a-1b23-4307-7284-08d80b9064cb
x-ms-traffictypediagnostic: MN2PR12MB3104:
x-microsoft-antispam-prvs: <MN2PR12MB3104306B0AF71B2CFC716CE7C4850@MN2PR12MB3104.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PhjbyThtwtkh5viX/K+ZiSCFOTdJWUhKyZcccuMYLt/n4UBY1Sg+RFY4khs3uHYYrZ7m5Zu7dv90jRaGS93imlRRJ/CO9etoIRk6l3OJcwqiuYh89ZI3MkdierxJg3DzfD6ExldLKOECqQoJfhSqDTYl0z6z7otUDr5NoRLLUwSaGdvP+iv+FVGvf/zglK6YJZ/CMpzXQvPaaJIVo9V2YrBUEp9nZLjpOEIfKihN4tGhX17KxB45P5SlcA/nM8XTqZeqmlQ0yqJwjkdPDkkMfrHAcOKBVp4IHmyd47PO2Dpo3HakF0GYSkEwPcA8e9UxKUQlD+oC0dwYoLJ0cuhJMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(39850400004)(396003)(376002)(136003)(316002)(91956017)(2906002)(86362001)(76116006)(66446008)(54906003)(478600001)(71200400001)(83380400001)(66476007)(64756008)(66946007)(66556008)(8676002)(33656002)(55016002)(52536014)(7696005)(6506007)(186003)(4326008)(26005)(53546011)(6916009)(5660300002)(9686003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: I4XPiZae75RpSHsdgykNoqLIDlHzm9O+Tr5t4n5LuBtEvTIduUpg42kcwdQDADWrFMPBrFtZ2u1dB+AUXieDPLTrP27FKCeq04nuJ6juwLnwbEkTac++L7S3xpUzanW+Ykq2jzxIbw/y8YVLIPNFM7tiiJq4qe8WQuprRKJNzfwaAJk52d5LXQDtykQJtEfOQjq9oLtzQ2NRnFQtNwL9QQmtLFKajDzbOHxZC5U+Uik4KmEvnd9ItzZXSNlqrvYGBTuGBMD118VCG9JfuEP5DNLu4FwcHBMppbTg9YHMQOJ+JHXuEM0RwZ/3Ng8+mmwUEIE9rwQlKADAXS7+WVopDt0iIbp0kJpNZ1u5+csFuJKMPEpsrSTHX4cN7/+ABCitqvm2mUlLgapDENhT1bHUzg9KOoLalZm/UhmkIaiOCqM6Hb0UgdE9jmKsSjfQ7J1rLTE16/IuwZPoMpO7aSe6vgIKLZiBgO4rpYbSl0A6ovc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f9540a-1b23-4307-7284-08d80b9064cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 09:43:26.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MB2WdSP1hN+ULGhdpFn+tppaA4GKCDk/bV8G4q/E7hyQL1KKAHoES9y4Uv+YmwPX9WKjVSa5wgps109FJA4HpP+djYSPaly8DQG71bV1eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3104
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_07:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 cotscore=-2147483648 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
thanks a lot, but I'm currently not able to find this patch in iio git repo=
sitory, neither in testing or fixes-togreg branches.=0A=
=0A=
Is there something I am missing or I just have to wait more ?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Saturday, June 6, 2020 16:24=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jonathan Cameron=
 <Jonathan.Cameron@huawei.com>=0A=
Subject: Re: [PATCH] iio: make iio_device_get_drvdata take a const struct i=
io_dev *. =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Tue, 2 Jun 2020 07:39:52 +0000=0A=
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:=0A=
=0A=
> Hi Jonathan,=0A=
> =0A=
> simple and perfect.=0A=
> =0A=
> Thanks,=0A=
> JB=0A=
> =0A=
> Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Applied.=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
> =0A=
> ________________________________=0A=
> From: jic23@kernel.org <jic23@kernel.org>=0A=
> Sent: Thursday, May 21, 2020 19:53=0A=
> To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Jean-Baptiste Maneyro=
l <JManeyrol@invensense.com>=0A=
> Subject: [PATCH] iio: make iio_device_get_drvdata take a const struct iio=
_dev *.=0A=
> =0A=
>=A0 CAUTION: This email originated from outside of the organization. Pleas=
e make sure the sender is who they say they are and do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.=0A=
> =0A=
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
> =0A=
> As this just calls dev_get_drvdata underneath which is happy with=0A=
> a const struct device * we should change and avoid potentially=0A=
> casting away a const in order to then put it back again.=0A=
> =0A=
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
> Cc: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
> ---=0A=
>=A0 include/linux/iio/iio.h | 2 +-=0A=
>=A0 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h=0A=
> index a1be82e74c93..e846a0a7001e 100644=0A=
> --- a/include/linux/iio/iio.h=0A=
> +++ b/include/linux/iio/iio.h=0A=
> @@ -669,7 +669,7 @@ static inline void iio_device_set_drvdata(struct iio_=
dev *indio_dev, void *data)=0A=
>=A0=A0 *=0A=
>=A0=A0 * Returns the data previously set with iio_device_set_drvdata()=0A=
>=A0=A0 */=0A=
> -static inline void *iio_device_get_drvdata(struct iio_dev *indio_dev)=0A=
> +static inline void *iio_device_get_drvdata(const struct iio_dev *indio_d=
ev)=0A=
>=A0 {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0 return dev_get_drvdata(&indio_dev->dev);=0A=
>=A0 }=0A=
> --=0A=
> 2.26.2=0A=
> =0A=
