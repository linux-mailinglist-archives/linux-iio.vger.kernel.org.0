Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F373944AA9B
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 10:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244901AbhKIJfs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 04:35:48 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:43848 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241297AbhKIJfr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 04:35:47 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A959pRe007088;
        Tue, 9 Nov 2021 04:33:00 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3c6t7yyc89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 04:33:00 -0500
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.1.2/8.16.1.2) with ESMTP id 1A99WxGW013925;
        Tue, 9 Nov 2021 04:32:59 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3c6t7yyc87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 04:32:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMwk8UwBu9MmyzNquKlrUhBpiaiPavQJTtFko+/XTz6VteSLradvJACG7sY3Re/Do3f2fX3a/zE1udNWSfP+GVcngLDBsboq50vK6aAjfOBgvKxlHLvM6COMtIV8Iw8KY1RpO8mPyukVLV73UL8EfdHA51rtKZMzNicfhq9P0mnWdKFqvUAM4Ta5cSZBgzLsCi2X6isCJg7NSNfyRbhfw6QVJLLoiqIzw8jwQ4okmrqkbTW8+Tn7pgo3SuFBERUvZRSy1cORhymmD90fqJyEqgp7zAz+0a525MZHXaP/PCZI3dlnfjBQUdPviCFTwZHy6fOAhediqEzemTQ4YHR/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur2wHzIha3xMVR5fnFptLP7Z0P7+Jg2Aw7kN178zNNY=;
 b=nVyOOnQD73tzBxFe38Xqig76Btfw+bdrLLayWShcJAZ+ZCH3ozE+CYefAIRZ5zwrfoeNn7T232X3jp9zNLTRoHaXZJuR+mRCkwcQWhUFnkqqOyD8bol/25gniPUl0qHNmpXMatsmWrwd2jy318+6sUVk4UcU74zOqIRlXFEeSrogj4auewEVo6xleLvoHe8SjcG3cVfPWa83Ses5o6B4ON1gsPXc18rQGCja0YxRxCNO7Adblr3sevBHc2j9fYG89v4qQUxCtHARhK0HWEAfeCQCQKWusBtVFKSaslAziTarrj1BwkKCGR/Pd2TVIxztQdAHo3EZRlml6aqymwpWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur2wHzIha3xMVR5fnFptLP7Z0P7+Jg2Aw7kN178zNNY=;
 b=4dauQwK99a+HH8HqtR85x/IMh+lEJ9F0Sj0lYVdxFoQP3059/GEVBwj9o3LSUGijet27PFmEhsnbI5/sA7pIg4/0bVJCExn2gvQcNZEFso9EbpCGVlQIfNTZelEUZ2TlffxQkJJXrvZ4ydG5Wpn/dJqkFAaFADGb5xxDKuvapGM=
Received: from BYAPR03MB4647.namprd03.prod.outlook.com (2603:10b6:a03:12e::16)
 by BYAPR03MB3509.namprd03.prod.outlook.com (2603:10b6:a02:aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Tue, 9 Nov
 2021 09:32:56 +0000
Received: from BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::f81f:4ef7:1c77:aed4]) by BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::f81f:4ef7:1c77:aed4%6]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 09:32:56 +0000
From:   "Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: RE: IIO interrupt mask access
Thread-Topic: IIO interrupt mask access
Thread-Index: AdfUrMxt4cno/gvSRMageMvNb4TpjwACD4AAACPzcQA=
Date:   Tue, 9 Nov 2021 09:32:56 +0000
Message-ID: <BYAPR03MB4647A8F3ED770D90EC57460397929@BYAPR03MB4647.namprd03.prod.outlook.com>
References: <BYAPR03MB4647767659DA0E143F9C919A97919@BYAPR03MB4647.namprd03.prod.outlook.com>
 <20211108152646.00004ecb@Huawei.com>
In-Reply-To: <20211108152646.00004ecb@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2hlZ2JlbGlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lMTczNTNmNy00MTNmLTExZWMtYjZkZS00MTU2NDUwMDAwMzBcYW1lLXRlc3RcZTE3MzUzZjktNDEzZi0xMWVjLWI2ZGUtNDE1NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIyNTI4IiB0PSIxMzI4MDkyMzkxNzMwMzU4NDkiIGg9InpGejdUMEk3aWNmUHlSRlFwYVZwemVTbHMyUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d27624db-9a48-4988-c4cd-08d9a363e9ab
x-ms-traffictypediagnostic: BYAPR03MB3509:
x-microsoft-antispam-prvs: <BYAPR03MB35093FC51B2C9712A24DDA7297929@BYAPR03MB3509.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDRlZ3MqLv22UKCyo47udC5RBL4cwB65Wd3AU+gGGcC7+FOwCuy/gnQcix+qxYDaRuMU5nO2bL7sdXNL5dyFBxlTz4K2IrjfhDQMkHakHcVDPUpXsj9ypO3So9mwjGVzqr+bZQA45wpU/4bjQR/Nxqf8PyYdbqpvIqr+3pS2cIbZw6S4jzKLSZpGfsfXXTgxay3vaoNN5zFyk9ERxW7yta/zg2kDw9u3lol8P1WuHSTfTe4+uNcP/9MXXhC36HmdnIWqauYCnKhLXrFQCoL51iP4flQW9kR1ueLajg8gALX/J7C5KUXUl+yVeSNPKR7ju0aGiCNCh+/McnI8nLd01ZJYPFjvmdVlOZi5VAdYmvPk+N4dympDiDFGFisjJ9aoLZCOZ4qUikrIYPRNcNfGGQmX/ImGwkwoLJUpvo4KvjFkQnNdTmj60YXhCETuzl11RHEN5W9rr0VxeUmN9YuOisBq7ut5mR39bntnafIYOBXmg/N7S7/Y5pStR7TSpg2YxzBdKaFIYcAUnLIV0lrHHIdHmqPp8aN5b6D4AAOlIKC5Jrnrrjjm0M+oq3tgeevSf42w0r2Al3alhBUsvg4FTr9Im+ozqwqMGRhLjR6HHvkj4DrqSG1QP6NHOSymp2yGP3ZzwMnL9+XGdJhjLXQUXbHxpYUFdbc8oEnQ1aNQnsGhOCsC2LXCa4Y6oa4y1KXramF3W/Zk9Hw/UjbW65MoNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4647.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(52536014)(6916009)(508600001)(54906003)(186003)(86362001)(38100700002)(6506007)(4326008)(8936002)(83380400001)(7696005)(33656002)(5660300002)(316002)(2906002)(66556008)(9686003)(66946007)(64756008)(71200400001)(55016002)(26005)(8676002)(53546011)(66446008)(3480700007)(76116006)(66476007)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LOktmKxZ1IxT2jrPW+GJR0Vmd9iIaYb3iPEOp2GZjA52ZiWtGpNjeyg6+yQ3?=
 =?us-ascii?Q?7zmPzDDJLfbHnndPdjXWKB3oF/ikPw2vSILcdhOGIO4IEyxY8y0RZJlSWVjU?=
 =?us-ascii?Q?VKG4k3rEL6+Rppby4TPMh4lKW1u8uIpBDJUiLEiwNN/p6cdo7gPpjXMtI7k1?=
 =?us-ascii?Q?CG6OXcVW2A6qctzgstQoqBGPEPAPWF0OLew5VlFEEpSPQAhpyvP+rzzzxU/q?=
 =?us-ascii?Q?9GJ5ERgd1wGnbUwnWQD1DfgRz8e4WYZdGO2fDvCmD0vy3D/FOslfB6tqRvLs?=
 =?us-ascii?Q?R0mj0r2GsvGFUvGMuTHP+1g2roZTcau2lbnOa1z9s/dMrbbVC84SONJ7zFG6?=
 =?us-ascii?Q?Ay6BK1jjCoWIOExF8T/PQ5xNjMJZWh9tPuI4acwWHwI6pKMPbpySPY59hmhf?=
 =?us-ascii?Q?pErRr1CIZjiZe0cZxyctRcdC13VyYPogrDOIZTglBbND0dJ2NP626NTJcD4n?=
 =?us-ascii?Q?EdH9S8Z+FrcvnpuXSO0j8XrEz0/AjobSsEPM+2cNCXUboqDiMV76hwXoS04i?=
 =?us-ascii?Q?Jp32SvkWgpn1YFTuuWMvU/eJDVcT5RihN7ZjPwjITbbuZP3EMwpbuuVxVJOy?=
 =?us-ascii?Q?0mGDCFx0qA/6tHw48CBU/DLnSy4vzGbRcwO2yT6zKsjB6J2ZEyIOgJ3ejv1K?=
 =?us-ascii?Q?kt9fJUEyyW1QKUsVv+UKzA4v9VhrBleYmXSXd3wyACAW9LCjk3DSF7HN7LmF?=
 =?us-ascii?Q?iQ2gwOoOfN3NYVhLmaOdc0l6jwMO4RfnLBcdt8V1s9mC02GLjT+vC1vaxDft?=
 =?us-ascii?Q?Nau4QXV8h7v8+CN/Gw9ucl8UuPsR4u2lhHNdkAPLl2OFoe9LOYGfkxD4YHOm?=
 =?us-ascii?Q?Slrsj7GsjT47nYi5b+je1U2eMgTrsePyd+Z2sDV/2r5n3MBJYdbyM7YhAVVI?=
 =?us-ascii?Q?cs/RwvGScyLLtXJnY9AQGrHVt/GzdUx4aOlnwNfA2tENe0p2PeKEeAk9+Gzw?=
 =?us-ascii?Q?ivPMg/pJUN71ORfLpbpmFdq1HBwXBn/8fhuUqX07Q/5iKUXHAEUsE/yerWRr?=
 =?us-ascii?Q?in8CvhOhwFAZkiPzdqKC1/JPZU0oadvF2yS0X2dc4nBKtbnEhCeLeS2tGd8s?=
 =?us-ascii?Q?o0cs4ngE9SVbjWitUHsKYqnWldQ7W5t1UTAQwgzRoaN6OpxKk7VGG2PnPgQL?=
 =?us-ascii?Q?cCLzOaOQpdujCH3PecUWl3ZF/3FgKZsRiZY2F3RX+EDxT6HjDvOylF5rV5xi?=
 =?us-ascii?Q?QvaO++p9hfUzTZwWPEhVXS0liKoOt2HnYIZIyJOQvYIOD0PMCFzu2em2LYgy?=
 =?us-ascii?Q?yhK+9XXDg829QdLt39lIiWDR0xCyO92zC+hC3HuEVojUy4/4UL5benJjtYij?=
 =?us-ascii?Q?AdR79USHE05bAX6fAEaFibfFOFhWNt/GO/EjU7lyZTdK9kXYcJaVNBHH4xGa?=
 =?us-ascii?Q?gtLSjtfAqt7e4cLzexqVVOwaPtnNXI527OWNrd5eAvDg84G3oU6I6ZVS+WXU?=
 =?us-ascii?Q?pmcCv4aj6RU5ldwQbaNemd3hCA/eHO1HO9Qgf9Qnub10YrnLuZ5h46DVGdoK?=
 =?us-ascii?Q?jpgNjyZOzqqmDrOkmYf9Lic94A5AuPLhQFF/i19acGstwWmyonHjcJX5naGL?=
 =?us-ascii?Q?Na/QP+VlIqXi5M9wvbDoO6YqND9r+5jmlp0ymjOEVP/kWOn/3wnPkf6/WdEO?=
 =?us-ascii?Q?Bj14E8kUXlvAgL/Anck5TeQftkRCK0GU2kXJUhzHD09W3gVmRlws/b7ORBwn?=
 =?us-ascii?Q?KxLENw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4647.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27624db-9a48-4988-c4cd-08d9a363e9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 09:32:56.6304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8EWNH7SxzaXlnlTX8MKXgOoxRw1yZhcQLgrKej/qg5vb75wi8i+8U4cTerLAHSk0nuE1hopT1V3fUwzJSyLTpLHls053y+DHU+2UaFMUOn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3509
X-Proofpoint-GUID: b4_6X35mlslvCBSv_88GcNjZ_UlD6XFi
X-Proofpoint-ORIG-GUID: botC2ktyev2ylvx_9adsDiFtwz9aTBmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=935 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090056
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thank you Jonathan, it helped.

I was not aware of the IIO event interface, those(ZXI*, ZXV* etc.) were the=
 ones I was worried about.

Regards,
Ciprian=20

-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=20
Sent: Monday, November 8, 2021 5:27 PM
To: Hegbeli, Ciprian <Ciprian.Hegbeli@analog.com>
Cc: linux-iio@vger.kernel.org; jic23@kernel.org
Subject: Re: IIO interrupt mask access

[External]

On Mon, 8 Nov 2021 14:29:10 +0000
"Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com> wrote:

>  for the ADE9078 (High Performance, Polyphase Energy Metering IC)=20
> which has two interrupts with over 30 configurations modes in two 32=20
> bit registers. Some of these flags can also be active at the same time=20
> within the same register for the same interrupt. While handling the=20
> interrupts is fairly straight forward, the challenge is to dynamical=20
> configure them within the IIO framework.

The answer to this is very dependent on what those interrupts mean.

I've taken a very quick look at STATUS0 and STATUS1 definitions to see what=
 we have.

Some of them look like they will map to triggers or possibly internal data =
capture events that we don't expose to userspace as they reflect periodic d=
ata updates (e.g. PWRRDY, DREADY)

Others look like they would be just about internal management of data flow,=
 eg. COH_WFBB_FULL.  You 'might' be able to map the start of a waveform cap=
ture to the trigger interface. A little bit tricky to tell without reading =
a lot more of the datasheet than I have time for today.
PAGE_FULL is something you'd probably not expose to userspace, but handle a=
s a signal to retrieve data from the device and push it to a buffer or simi=
lar.

Others are what we'd map to the IIO events interface, MISMTC, REVRPA, RXIC =
etc Probably the timeout ones as well, though they need some thought.

CF1-4 are something related to calibration frequency.  I'm not sure if you =
would expose these as anything at all from this register.

ERRORX tend to be things you'd leave on and wire up to some logging or simi=
lar, probably rate limited.  CRC stuff is driver internal, userspace doesn'=
t care.

RSTDONE is part of startup sequence, don't expose that to userspace.

So it is very much case by case.   If you want more detailed answers
you should write a short description of the individual interrupt source and=
 how it is used in data capture etc.

Hope that helps a little.

Jonathan
