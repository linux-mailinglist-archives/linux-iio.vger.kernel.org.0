Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0738D1955CA
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 11:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0K4m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 06:56:42 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:13070 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgC0K4m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 06:56:42 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RAtstL031717;
        Fri, 27 Mar 2020 03:56:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=RpOxYwDXicCrU5+AlZmZl4QIIcTM49hKOgNKxaO8xhU=;
 b=X75R6UCDVjiRqXkfyINg99NmnSegPBe+Ku/u1aCmR3h+/nRJwregl243Erge72e2//d4
 NNFyuTVOTJxbl8ohHrkobX7BnsN1Dtd2LDAT5l/JQU5qlmCB+thQTy1ZD+n9190xnYdR
 BgSgYJEG2Hqhx7k0Jg2qkyt3cL9xahBE3gcZ6kLiKYDXnRdpUOmN28HUJPSDtA8W4OoG
 KUxONMZjbQTbcb7+ikK++y4B4D1XaFCjvLAra0oapZuhn7hUQPt3alWDNFMM2/I4gGlD
 /JcXmZf5PghseBKgGf5UMB8bo0QHVVtJAHqrSV8fOaAwwUIZAtt8lGnvB7oDoQuJa1l6 NQ== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0a-00328301.pphosted.com with ESMTP id 2yxuxdt6qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 03:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIAM5O6qKR+jvk64Li+K1VoKTHZqLEX/ltwJu7mY4cWW3j47r3tBRlWGrzxL6ge7RbNto6dzhoBrisqKX9zp00jqIpCCu1uAISVpbfuJu/RW/kjI43KS2HcgS+pgDvDPg9RQ6a99FL+shhMPRZBaLJkqWiNH5Wa/W1DO1l8/5xR7r6q/GnT9eknO6cuFaNKfU5JslBddEb50Jqv9nBU3ikUI4v389tsVbbxEXB9X4g5Ed3ABwvekF0lOZG76wcvQH0pSWJ3m9AG5drYXdZrAnwL9PaGVyOtpJkVtAIAgXURGWlO/q+Tj0qRTGasJpZGJJkv1oBiPhBLni1QbtJ04qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpOxYwDXicCrU5+AlZmZl4QIIcTM49hKOgNKxaO8xhU=;
 b=gF0VytvU8iozYZLzAdogiFS3tXe/BXKpbY6zniI5DGEWLh9O7CitXZC7RtKUvA1J9wEZQVJnewNFS6Po/VyQMhq1cUuk+OOHQMeXwqV2DCZSBxyijLNr7gFBjLFtdHfQc7mFs4I9lSRKe6NtUEk1iuDgULsDN2vy/jTYL1x31Mpz9Ly6sD9O0Jd38fCHnrYZaBxj6SZqqCxdNw8zGNocpI6cbFi73FtKDvlqclnBo20BFY9xXLuT8dCkPVcK1YksNTe73wwHnVdwYYa4uh0PsQ8iMkcw8I43DQnLF7fy7fjuUf1/RR6sFR/Dvq7BGSltn8tlpCW09CqPTMVavtg6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpOxYwDXicCrU5+AlZmZl4QIIcTM49hKOgNKxaO8xhU=;
 b=ZgOrDaBOW1NDyym/4Re9zcJWGWMWTl6ixJI8yOnSZzo33d67XxULxSugSwQlSdsY86sUEOSANtD4HsvkYsWueKeRHkicQZv0/4cYf19ABGXMyqNDxU4dOGjefMTkvleu20UZmK4JR7gt+4P0/Du3hZ/1GWh/8BaebO9rBnaCaqU=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3549.namprd12.prod.outlook.com (2603:10b6:208:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 27 Mar
 2020 10:56:34 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 10:56:34 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w interface
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w
 interface
Thread-Index: AQHV/bS2NtvR2YaS+UCRrBJpOPlDy6hPtZkAgAALrTuAA6FNAIAAFsWAgAjXRDs=
Date:   Fri, 27 Mar 2020 10:56:33 +0000
Message-ID: <MN2PR12MB4422EA3CFA8DCFC397502B02C4CC0@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <5e730c2f.1c69fb81.9eda3.5c70@mx.google.com>
 <CAHp75Vf+SA7ptRQRxvMtVfN0MzQeQ_AgzAP7fc3eaT5nmsxo_g@mail.gmail.com>
 <MN2PR12MB4422876C03060876ACBB4414C4F40@MN2PR12MB4422.namprd12.prod.outlook.com>
 <20200321183154.128d8920@archlinux>,<CAHp75VcUtMZDMqizhW=oayvbGcMTZ9M0s=7L0TngkdXz=M49uQ@mail.gmail.com>
In-Reply-To: <CAHp75VcUtMZDMqizhW=oayvbGcMTZ9M0s=7L0TngkdXz=M49uQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8bde5f9-458d-4d30-3968-08d7d23d83d8
x-ms-traffictypediagnostic: MN2PR12MB3549:
x-microsoft-antispam-prvs: <MN2PR12MB35499676F5EE2CF03CCDBC76C4CC0@MN2PR12MB3549.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39850400004)(366004)(136003)(346002)(26005)(52536014)(66446008)(64756008)(5660300002)(478600001)(8936002)(71200400001)(86362001)(66556008)(66476007)(91956017)(76116006)(2906002)(66946007)(4326008)(33656002)(186003)(8676002)(55016002)(81156014)(81166006)(54906003)(7696005)(110136005)(6506007)(53546011)(316002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3549;H:MN2PR12MB4422.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ViXF65aAym7tnCMmUA+pHos13c9r4XxFcCMdRi87E0zsEKYVBFZz6ozYlStfI9Ww/0W6+6kBk+zyQCsu6yDq/lC2aomrNT/D/l0HMzOGDEg6/JX9szquYF2reIuFeulVMOtipq7kyx63x3mt0E6StpYAHoM3imNpye9XyhzyR9J/mW9bV+E6t21X/KJCZnyTJmppbsmRGtp5kTTLSoQSiWrmMLiKBO+o9dhMAb+6pJ6VF0UXG3gd3AUl8A6uu9UPlrRKsYnmK0lkDRApd+2rtvjzoNx3Bs1DzCrtj9bXCM4GKTJ/djeT0MIBuY1agT+9EtmhADWD5dhZ8Ccq1nmSzXePUIfC3TTC578p4Ya/RyzcHMCHSN4ao8vQ1HEN3ZvRZpLlZi4p7DsSLdGRFLG+4s6qNAie2Vv6+eWlna+ee56SGMAxahjAvALgrzplENQK
x-ms-exchange-antispam-messagedata: qrJTlhMMlaGOl+ai8d0SfB1L97G06aEo4ZLAGEH21uKHk28VO6B4LzL2ukI4HR0Ihge+qD/kZ//wvpOg87jkkaQXOu1YtIgcCFP2vyFFGH2ga4s2xDXIr7KMmB/wQ3Mq/nDCnzstuWg+L5tV0PgF5w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bde5f9-458d-4d30-3968-08d7d23d83d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 10:56:34.1953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OJdw8Prirh9WDo1DrzgSLu79QNMwBzU6/663+dbHOnZt1IFeHh1rUDsXzyMp54SUPkdRChfR5l090yMzQrjLLj6jCuP2XGm6ATTooIRX7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3549
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_03:2020-03-27,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxlogscore=860 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270100
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
this is quite useful for me for debugging and testing. So I am in favor.=0A=
=0A=
Just one comment, I think it is safer here to lock the mutex to ensure this=
 doesn't happen in the middle of an interrupt or anything else.=0A=
I am waiting for V2.=0A=
=0A=
Thanks for the patch,=0A=
JB=0A=
=0A=
=0A=
=0A=
From: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
=0A=
Sent: Saturday, March 21, 2020 20:53=0A=
=0A=
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>=0A=
=0A=
Cc: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; Rohit Sarkar <rohits=
arkar5398@gmail.com>; linux-iio <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w interf=
ace=0A=
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
On Sat, Mar 21, 2020 at 8:31 PM Jonathan Cameron=0A=
=0A=
<jic23@jic23.retrosnub.co.uk> wrote:=0A=
=0A=
> On Thu, 19 Mar 2020 11:08:44 +0000=0A=
=0A=
> Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> > iio debugfs register interface is quite handy because we can read a sin=
gle register and write a value.=0A=
=0A=
> >=0A=
=0A=
> > regmap debugfs is only a dump of all registers, as far as I know (may h=
ave missed something).=0A=
=0A=
>=0A=
=0A=
> So this is something Mark has discussed before around regmap=0A=
=0A=
> and more generally IIRC.=A0 The issue is that a write=0A=
=0A=
> interface does make it somewhat easy to do really nasty things=0A=
=0A=
> in some drivers that use regmap (to the extent of setting boards=0A=
=0A=
> on fire etc).=A0 For IIO we are much safer - the worst you can do=0A=
=0A=
> is break the IIO driver.=0A=
=0A=
=0A=
=0A=
Sometimes IIO driver provides a sensor data about platform facilities,=0A=
=0A=
such as temperature of the die / chip or battery voltage threshold.=0A=
=0A=
=0A=
=0A=
> I've never been that fussed myself about the debugfs interfaces=0A=
=0A=
> as it's easy to hack them in when needed for actual debugging, but=0A=
=0A=
> have taken the view that if someone has enough of a usecase to=0A=
=0A=
> want to add them to a particular driver, then it's up to them.=0A=
=0A=
=0A=
=0A=
Good to know your p.o.v.!=0A=
=0A=
=0A=
=0A=
-- =0A=
=0A=
With Best Regards,=0A=
=0A=
Andy Shevchenko=0A=
=0A=
