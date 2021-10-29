Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7712043F857
	for <lists+linux-iio@lfdr.de>; Fri, 29 Oct 2021 10:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhJ2ICx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Oct 2021 04:02:53 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:13120 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232236AbhJ2ICt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Oct 2021 04:02:49 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SLACm9028729;
        Fri, 29 Oct 2021 04:00:07 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0b-00128a01.pphosted.com with ESMTP id 3byeneg8cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 04:00:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUAhOz1mqBHOyfBnNn/iC6i7lTDtp+jroSwP38Vz9lM8YJHrZHNVgfGXBRAtq9UwBRfkx1bFOdTdVY5QXeqICjH1lT9r9teC0cLA0C4EJWtrG+bagKR0jC2tzLJeOjfpVqcneikZdQhXwg1HAlStQqfQWBq/hWFNdCdKx+IgIcyO4Gr6h7pEn7Xms8JqaS9XASY0JaGKShDbXMUlQIzZt6G3hFIKQhH3/Jmiqy74QIaZ9Y/QSmcexJP73Dr4dIUbmvXdnlR2uMF+kSg4UcK1yNnnf1+kZVOvO5AvELYBIIwI0cBSBSIcXGyMOK1klpckeLO0S7aAYibJVzDE+YbPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyBiHG8CYzoTxu63A+yApkn4T1WNG4YkPHYpTRqqiOE=;
 b=GcLkhYgsP6fxrFDkceCCfolGuhHgZrnepnYQmzj1tkwiZjACB5OpdJ/LdTNxogrCUxJXDU92FU0xiyLX6hMBAQqXvR0hoyDg2F8gEpDsuR5rXVuoQ8iVMAN6id77S8JJb3VMtvv2pMTGtFCUj3AwpqLotN1KhbqJMer1koI8/B6QmwDb6tm3hL5JLlz2dOl+RlqdON2vAtTdN3acDJMqmN7g4q/gqxUGe9QhL0Lr7tyoPYpWju1Ua9QizlbEabJXaTXou6FAMxEp/stAs25+3GdaUMGxoIkg1D+QhSUE9eZO1yGkzYjMMH1aSK1YPibhexuKr24VItzdvhC3FLN0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyBiHG8CYzoTxu63A+yApkn4T1WNG4YkPHYpTRqqiOE=;
 b=YaXzDELXoJY+tJrNL/qUTu2xYqN0b68TueXmc+9AJ4tEJTcqxtjtALGQxInfWaZSo/Te3aRjnxfl6WyvzymS1TyqNRqI0UOaYhJQsRyE8/TBflCBY0LDtQl3JQy/twYvuyuCBAib5MtpMAckZksK7UxA8G3M/EGPHlwKLSo/emA=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6349.namprd03.prod.outlook.com (2603:10b6:510:b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 08:00:06 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73%8]) with mapi id 15.20.4628.022; Fri, 29 Oct 2021
 08:00:05 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
CC:     "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] iio: add adddac subdirectory
Thread-Topic: [PATCH v2 1/3] iio: add adddac subdirectory
Thread-Index: AQHXzAOuUV1Gpl5ibEu2jF5UTbWmrqvpm2hw
Date:   Fri, 29 Oct 2021 08:00:05 +0000
Message-ID: <PH0PR03MB63660FDDC3504DD4ABD1D76999879@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211028134849.3664969-1-demonsingur@gmail.com>
 <20211028135608.3666940-1-demonsingur@gmail.com>
In-Reply-To: <20211028135608.3666940-1-demonsingur@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMzhkOWE5MmQtMzg4ZS0xMWVjLThiOTUtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDM4ZDlhOTJlLTM4OGUtMTFlYy04Yjk1LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTM3OCIgdD0iMTMyNzk5NjgwMD?=
 =?iso-8859-1?Q?QzNDA0MzYzIiBoPSJBRlZYeHJWM1hzMWR2N0k0UVlTMmxoU3MwRUk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJMekVYN21zelhBYnZWQWg2WlVTT3V1OVVDSHBsUkk2NERBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2912ee60-49a0-41a1-b6d7-08d99ab21eac
x-ms-traffictypediagnostic: PH0PR03MB6349:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-microsoft-antispam-prvs: <PH0PR03MB63499089B22B53578F64183A99879@PH0PR03MB6349.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qZ4kqLUsNprZTxwcTaNTLNe4b+0QzAAeIXxg/8Ic8a/LntG0n9PmiPcGLQJfIzjdTdlL76YfT/NyLbNy03KSx+RWSe70rxnWM3MP0VUwIQdhzCKG47dcoHwZ1Ll9V9ELbku9LP3XVTbM3s4AaH9EaEoXyypZMtnpl6ZY5sUUb+IrJJtRm+oJav45kwIkRIi+nMEoIp/Tr74jNmX2g8+lywetJqX7q4h6JqiIo4vDEY7DSaAN60XjX7QoJIUIaLXhH2cJ5bZDv4wzw66DRczq+HAcjn7/m3YYYL+IQZJeitPlJTqXdWlvn/i3piz/MBbJdPIQ4M14MqFb5zJ67CVOkmH4Wqr9Vk+KE7eh/JwGn9gc9Ndx3S5J/Ou8xo5TnHrozhLS8TVVWemts8OBFSHwmY+MQTKiPXYD4R7Pn+STlm3X1KLLvzYLBUwdyx12avR2dDD0Op8jfV1QrLa4EdLcGnzXMDfzDYaQ0rlwrzljzI7lKhzAz8+oKjgbEIc+UTDpB0L7mSwa9jjB0J/IVOuCo1/t4BJrfTsn40FaQh+nZQJo0m1kbKEHumeB0Gb8bNHYqMgMX60Lxd9z1/U9abxNwCdTGqSB9t/Ubwx70nuGasfL8Pjc+rGMnbpSVu1eygOPfWYLufs7+E4XCALXH9Q73LbiB2EvGghDBjf696SSVOxeZMsLCEU6UHvdBRdFyPCC7LGbq7GX6CfOxHq90mUY9fpMN1Eb8l8wXL2im+xXmNXxy1iq2SjU6kGcUaEuNjV5djbvCQAi+QJ1RbY+Cxm/q0tEbWjbeCPGnfiWL2oQp5xC5Wva2xLMF/fF0Q+nMd6m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(71200400001)(83380400001)(26005)(6506007)(2906002)(38070700005)(7696005)(86362001)(52536014)(66946007)(508600001)(186003)(6916009)(8936002)(66476007)(66556008)(64756008)(55016002)(66446008)(122000001)(38100700002)(4326008)(76116006)(966005)(54906003)(5660300002)(316002)(8676002)(9686003)(49343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QxlSgLXvP+5mL0lpIGkk5Pj94oW/AJ3vRTdolmrUtidus7g0Dn6knG+ahs?=
 =?iso-8859-1?Q?Sw1j4slMpkUJ1QlypUebNtFjTKjKdZq4z3T4XiMxIs/84jJs8S3x2lYS79?=
 =?iso-8859-1?Q?Vo4Xq5tHb50Lz7ay+7GPolvSGsKLIP3UXFhalwlcNx9rZHVjKcs0qmSN+c?=
 =?iso-8859-1?Q?lTLc4YHC9/m0HKAYPG/PNcslHEO/b7NmSzVMNrb1MDy5RS3s7/flFeneh+?=
 =?iso-8859-1?Q?87Yr0MnZkZqvHoWSlun/8b7aCqpgjW77huDEbAEB7kn9cIC/Zt/00HXRGu?=
 =?iso-8859-1?Q?O1+tioj096Q+OcmuN3xtC8u6ugTVh4lHPjharKkGFqZ4aAE7PUzUaAv/8X?=
 =?iso-8859-1?Q?n3phQnszYMVDOKfHaAQYQC4MRu18lnGChzTOyv2lFcDudasXDuAzMjpull?=
 =?iso-8859-1?Q?Tv2ow4ONkk1L4ZCCxTZq2cAD2mzKumha3fbXZj3uSm03sDLZklH21gfNQQ?=
 =?iso-8859-1?Q?iQYZxwgD23ZM9w02NTbl/PhBWUHksvcs3y62Xf+Rj5TKzARscsOrTdjQ0W?=
 =?iso-8859-1?Q?Uu7/5IW8NAopHZmrWVDVyFCfI/R0LJQzbznyHtJThrOhb9Sd16L4Lt/7hT?=
 =?iso-8859-1?Q?RCHUIkFknyPs7AXgkGhdpbXRM6/All1QZvTxjRedG+yoI1sPlvculXY/fW?=
 =?iso-8859-1?Q?XL399tnDq6ttJJK3Nol6n0ISEWp8/SOju37HuQMlF4e+V37d6qla/82NLw?=
 =?iso-8859-1?Q?B96x/+WqV3lKGC6MNS8FLBU9IRm6pwuZmrd7D1985y3EMfPnAd2hJN0Qlx?=
 =?iso-8859-1?Q?FdLBZ6wFq6oqOWTOCMwyQ0DGEuAoM8Gn1hv+nyHvUiSaNJTgGJeT1uNl2u?=
 =?iso-8859-1?Q?xDNDKDJuy8Nr5CGuPpqrhVbrCU4eFIwvJgWqKe9NggIWqQDBeKZQGw5th2?=
 =?iso-8859-1?Q?y0wSVfPHovqVjU7cRaJmivTCTp8I40dFDP538vBetcpLHf+fEAZ7KhUzFW?=
 =?iso-8859-1?Q?Cg8/kXCZWQiKSAc9XJJRn1Pes8QujPcE0r9zWPIrYOKg9JCspWlt+oCGrR?=
 =?iso-8859-1?Q?H7CKzMGGSAJxghPnCt5P3QdAJomecOLIqcuSLaEvLI9M3nDX3nZTGDCpjn?=
 =?iso-8859-1?Q?6GwFEydmgKxlujv5CUGFKwSe1qEzYhkqGWfFRkjuUFUiYezDbg7bE8vLmp?=
 =?iso-8859-1?Q?5PfPVfYKNiD5xgBz3YS8LjfPFQbZhouQtLS+IwEyrX+W3idPjU/A00L7qT?=
 =?iso-8859-1?Q?Yw8yMK6h65aL27fNlO+SoXMeENV1pPOirT+ishhIn5dXj54hEBL+55qhTn?=
 =?iso-8859-1?Q?FwO+Kz3Psiar29Zkz/0kBTUlnPFoOKq0FuWBP9NwMCGOM2EShqsQF2WTq4?=
 =?iso-8859-1?Q?13+JZQHPWr4WxuNXMAPQ1WCQ11k3IsBKPM/TYqY4oV3BTjxHadm5crpVcg?=
 =?iso-8859-1?Q?O/kAiKdty02da0zyVc6NoJKK1zvShNZEbAnajphIcn4SYWXIxDuwUhC+O3?=
 =?iso-8859-1?Q?Jk2b4RvA2U8dHIoR2He4X/SA/JXG8Vs3W1DCqQG02KGEda+OWpQlEDTr3Y?=
 =?iso-8859-1?Q?V76UCeWGRDimQ7uBun90bshslg4oJqVndsF1p+ZFii7gnuBQGOfVbSovHW?=
 =?iso-8859-1?Q?PBhXb5SFfYUkCBAFSHms/EPL1kGFFyhkAdySw/6H/II5qFMVhEEQrtFVko?=
 =?iso-8859-1?Q?Mn9x+3CV25JfrYfTp7PW9IRFi4pj1/9cNqZJVuSTFgAE2bmg+Ig52fKQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2912ee60-49a0-41a1-b6d7-08d99ab21eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 08:00:05.7544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QR9Hy4FfzowxlRCP0DKmydb8MB5KErqh9cyGP3lp1+6JEGzGFKewKZT1eabun138Drv2jXvNWQw7it+RbrefxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6349
X-Proofpoint-GUID: q24RX4CcPC3Yrtavo6ZF4eb_zuPYj2Gf
X-Proofpoint-ORIG-GUID: q24RX4CcPC3Yrtavo6ZF4eb_zuPYj2Gf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=907 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290045
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

> -----Original Message-----
> From: Cosmin Tanislav <demonsingur@gmail.com>
> Sent: Thursday, October 28, 2021 3:56 PM
> Cc: demonsingur@gmail.com; Tanislav, Cosmin
> <Cosmin.Tanislav@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>; linux-
> iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2 1/3] iio: add adddac subdirectory
>=20
> [External]
>=20
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
>=20
> For IIO devices that expose both ADC and DAC functionality.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---

One thing here that I'm not too sure is the naming of the directory.
I'm starting to see in ADI more and more of this highly integrated devices.=
.. For
example this one [1], is something we have someone already working one
and it has ADCs, DAC, amplifiers. So, I'm just wondering if now
it's not the time where we just have a generic enough place for these kind
of "combo" devices? Being that said, I have no idea about what name we coul=
d
give :)

[1]: https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7293.pdf
- Nuno S=E1


