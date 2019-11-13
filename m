Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71D0FABD1
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 09:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfKMINJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 03:13:09 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3332 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbfKMINJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 03:13:09 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAD87lLu022604;
        Wed, 13 Nov 2019 03:10:53 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prju0gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 03:10:53 -0500
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAD8AOwL024758;
        Wed, 13 Nov 2019 03:10:52 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2052.outbound.protection.outlook.com [104.47.45.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prju0gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 03:10:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNe5PsgLzVWBBQl1ZLInI9yDR/AOabCvh+VwFBfCU+5e50KC5WmPKSRecY6GU2sTDNw772fsTcaHifah2ezW6bmNVYzv06KS7yYWaYTuLMmVomjvosHylmP+G2cf2N32jMzL6m8E3RvPoDGSwE6o+xHyl9Il7rKo4j2cIK7lAjuQkdLxTMcf2aJA47ulmKCI/ji0ivDtYle2vIDOregXdREne1xcmqBT+5iEr5j00LhglXAuzQ38QXDVo8n2Mw82CfOVq4jH+TCBGSJhrALegcrCA/zXxxb8nseSycI4ildJm4ixxIpFuDf73Ls87OoEmw7wZBWtf1zAW3N1u270qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGDsyqn79GkHKoxSrCavDr1Pv4hkyRtjCfl83OOcR0g=;
 b=nW8fo4N3Vy+uecPvEfsX4GCY3YMsfvPkwA1s88g1ZYAlh1FIgiqmSK1XHyQYkvh70nHAGf6SHfkv/pAYWqtiYybLWk52Ug9nW+BmMPcOHvcC0wsjoKrpH0V1cENoCGGf7MB3nMAon9BH0uBc9jIdr0TRs/jVOHltZmHwkZlxJhUjzI2xC03x13FJ7x4+/YPY1cAX1CGIy6u4+4prjgDMJ8unhqPgGtz+iVDJZneveL7a0SumpYzt/QLBqhMnh+DW1fB1jBjINO0luMGVIrT6AdfnKHmrKpSEUYwfqVbzioiM3EJZWbq11dvNhsFajOoetOgiCeAW7fyMEpPb6VT1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGDsyqn79GkHKoxSrCavDr1Pv4hkyRtjCfl83OOcR0g=;
 b=wJkmsfJfEnvxyWXZH3IGGUxuZ9VJkV3El91V/t1w2EkVPuiSJzliOy3n57twyPBtmMgZUjAUFx4FsrYFH1lWyJmraFtkiEXUjgw51/aJnwkbaLFzlbfEtaMp6U43TCWGcpcL6vS/5hP957ABq9z1HOG7rbVKgvm3PWx1lPAlaEw=
Received: from BY5PR03MB4965.namprd03.prod.outlook.com (52.133.249.215) by
 BY5PR03MB5316.namprd03.prod.outlook.com (10.186.132.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 08:10:51 +0000
Received: from BY5PR03MB4965.namprd03.prod.outlook.com
 ([fe80::c437:442b:4a7b:8121]) by BY5PR03MB4965.namprd03.prod.outlook.com
 ([fe80::c437:442b:4a7b:8121%4]) with mapi id 15.20.2451.018; Wed, 13 Nov 2019
 08:10:51 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
CC:     "Bia, Beniamin" <Beniamin.Bia@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "biabeniamin@outlook.com" <biabeniamin@outlook.com>,
        Jean Delvare <jdelvare@suse.com>
Subject: RE: [PATCH 1/3] iio: Add ADM1177 Hot Swap Controller and Digital
 Power Monitor driver
Thread-Topic: [PATCH 1/3] iio: Add ADM1177 Hot Swap Controller and Digital
 Power Monitor driver
Thread-Index: AQHVmW7fc5smHJ/4gUWJS2j2jDw7xKeHzPmAgAALEgCAAOankA==
Date:   Wed, 13 Nov 2019 08:10:50 +0000
Message-ID: <BY5PR03MB4965158557D9AEA20A48F95F8E760@BY5PR03MB4965.namprd03.prod.outlook.com>
References: <20191112153552.27431-1-beniamin.bia@analog.com>
 <20191112173757.0000075b@huawei.com> <20191112181734.GA30127@roeck-us.net>
In-Reply-To: <20191112181734.GA30127@roeck-us.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0xOTNiNzBjYi0wNWVkLTExZWEtOGY5YS00ODg5?=
 =?us-ascii?Q?ZTc3Y2RkZWZcYW1lLXRlc3RcMTkzYjcwY2QtMDVlZC0xMWVhLThmOWEtNDg4?=
 =?us-ascii?Q?OWU3N2NkZGVmYm9keS50eHQiIHN6PSIyOTk3IiB0PSIxMzIxODEwNjI0ODg4?=
 =?us-ascii?Q?MTQ0OTMiIGg9Ii9nQmlJWEcySlVkbTIxclhQMDJKaGk2RzNyZz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUt3QkFB?=
 =?us-ascii?Q?Q2Q4NjNiK1puVkFiNUwrT1FBWGU4d3ZrdjQ1QUJkN3pBQ0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUE4QVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBWWVqd1pRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFkQUJwQUdVQWNnQXhBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURJ?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e405abf5-b796-4b5f-a311-08d76810ff6a
x-ms-traffictypediagnostic: BY5PR03MB5316:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR03MB5316A5B89ABB5C21A9B8BF718E760@BY5PR03MB5316.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(13464003)(81166006)(66556008)(7696005)(66946007)(476003)(2906002)(76116006)(81156014)(64756008)(8676002)(966005)(7416002)(25786009)(6506007)(256004)(33656002)(478600001)(53546011)(446003)(66476007)(14454004)(14444005)(52536014)(66446008)(8936002)(45080400002)(76176011)(486006)(102836004)(5660300002)(55016002)(186003)(11346002)(71190400001)(99286004)(74316002)(316002)(9686003)(6306002)(26005)(86362001)(305945005)(110136005)(7736002)(229853002)(6116002)(54906003)(4326008)(71200400001)(6246003)(66066001)(3846002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5316;H:BY5PR03MB4965.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TQxzSdSVy+dtFvJWy3S0sVddO0U+lo304c4SzjG4wBapnhOndaOe41OFTvgNyzqoNR0B56fKehP925WQRpclExVHQ9hg5S2w+UHm9fYD2Oth2BVgWp2xrVlGtXCsv2fY+udxC/UgZCAcrV+w0fkxOpoCdXoupL0CLxGeKI/zjRtgWuiqXMA+iIYo9JzK07T3e1MLGYIMh5S9eAoz7vuCaGHT2AvkXpsCO0CJEiULIyEOVjv2AHK3Md/TGEE98KQ13R5vEGrc9161jWso71bdNh015DOV56VWmuZeIqqaDo5txay0lVzKXXbynjGLcUw0N6obrAU73m7slpSc3gQa2lVZQqNAukI62XfPE7NSzB5N1esrnDbnYRb0sUQZ10HSnUmGmtLcWlFO2iOZ3kpBPOSIkDxJAV4+1Cbla/Zth1F9kjWLLjm+DASqcOnQ6/BQBrU9MaSjyEmjXA5FQAwmg6gdLnogRIned6uv9nlIw7c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e405abf5-b796-4b5f-a311-08d76810ff6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 08:10:50.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEY7TtDtrgJ+Xy5zw1RB5HrPcCSGt26HvhBygUS79lIkMAeiTIK09vwCzXmPTM7aQGtALGB+QG+8RsdBq/QNKK3EwgkO/zmUQTu/gmZjwO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5316
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_01:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1011 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911130074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Dienstag, 12. November 2019 20:18
> To: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Bia, Beniamin <Beniamin.Bia@analog.com>; jic23@kernel.org;
> lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> pmeerw@pmeerw.net; gregkh@linuxfoundation.org; linux-
> iio@vger.kernel.org; devel@driverdev.osuosl.org; linux-
> kernel@vger.kernel.org; mark.rutland@arm.com; robh+dt@kernel.org;
> devicetree@vger.kernel.org; paulmck@linux.ibm.com;
> mchehab+samsung@kernel.org; linus.walleij@linaro.org;
> nicolas.ferre@microchip.com; biabeniamin@outlook.com; Jean Delvare
> <jdelvare@suse.com>
> Subject: Re: [PATCH 1/3] iio: Add ADM1177 Hot Swap Controller and Digital
> Power Monitor driver
>=20
> On Tue, Nov 12, 2019 at 05:37:57PM +0000, Jonathan Cameron wrote:
> > On Tue, 12 Nov 2019 17:35:50 +0200
> > Beniamin Bia <beniamin.bia@analog.com> wrote:
> >
> > > From: Michael Hennerich <michael.hennerich@analog.com>
> > >
> > > ADM1177 is a Hot Swap Controller and Digital Power Monitor with Soft
> > > Start Pin.
> > >
> > > Datasheet:
> > > Link:
> > > https://www.analog.com/media/en/technical-documentation/data-
> sheets/
> > > ADM1177.pdf
> > >
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
> > > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> >
> > Hi Beniamin,
> >
> > A couple immediate thoughts.
> >
> > 1. That cc list has some rather non obvious people on it.  Unless somet=
hing
> >    fairly surprising is going on, probably better to cut it back a bit.
> >
> > 2. Why IIO?  Not entirely obvious to me.  From first glance this is def=
initely
> >    doing hardware monitoring.  If there is a reason there should be a c=
lear
> >    statement here on why.
> >
>=20
> I don't see why this is implemented as iio driver. I think it should be
> implemented as hardware monitoring driver.

Totally agree that this driver could have been implemented as HWMON driver.
Well we use this device as USB supply monitor on our embedded portably kits=
, to detect low VBUS or excess current draw.=20

ADALM-PLUTO and ADALM2000:
https://www.analog.com/en/design-center/evaluation-hardware-and-software/ev=
aluation-boards-kits/adalm-pluto.html

https://www.analog.com/en/design-center/evaluation-hardware-and-software/ev=
aluation-boards-kits/ADALM2000.html

The only connectivity to the host PC is via IIO/libiio USB Gadget FS and Et=
hernet backends.

We recommend people to read the IIO attributes whenever they report an issu=
e.
Unless libiio supports directly HWMON or HWMON adds an IIO bridge we would =
prefer this driver being exposed as IIO device, since HWMON users still can=
 use the IIO/HWMON bridge.

-Michael

