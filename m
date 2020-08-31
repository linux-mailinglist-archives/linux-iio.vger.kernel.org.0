Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96D32575E2
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgHaIzg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 04:55:36 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:48960
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgHaIzc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 04:55:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxsK09w86oyJDtpWVukZpBQsgcu9T3ALYtxUDKBXx2TEnZiWQIZUEZYp5ity0VSeP1F5u8bhxSfNTYj2Hm/6tybYbCLiddgC1yU5u9givMIyavjL2vKaKW1NkR8Lu6Vhc8iZfS19YHqd5+8+UZcKnjTr4wv0J+yb3riu8jdrVDujEiPh62idwLyTL0oQNS58LNNCJNEZoAwvAG+ZCO9k44G2JZKLNtUVRDRCHur7KBxTpw9kYxbIfamp86fhzOJLPCBVh7ax6MAhM00J51Zv4jdr4SJ/nCtkb+ERK79unDNsCjV0ni0h1RSA2xTqkYAWafhbQ6ZrGONQTF+zhgy3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMmVtI61DcrAFt5yYGJgeCH7YY4lZsfM3Oagm8qpTWI=;
 b=lj1dFxuTcFWwyfokqC5NbFCnyNru4H0fq3jCiOQRvHNck5K9/naB0CNYFOLV9cyKJ9lJus554JNxBxbn0OFX/cbyEAV35FLVgNP/YpMpk5vnCAu47yEznZYD8ay6HSCkuJ6j7/KzsLOl9VDzZTTziig2zOkLwHBceL7rC1x3evXCXbgDghTUUfME1ot2g1ebtw7F1Rz5QANysf6FpSzooT+9hkFUo56iiGuL93uYtfrHqKFiroDK7EqpruOqIRxhh6QmsLwPdWFRprngOewKkPEpzTxV1+BW7WpuuVSNI7X2JwY1jGl7qIO3W57yhLg7uxFv6CDT8e1HOphEb4tV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMmVtI61DcrAFt5yYGJgeCH7YY4lZsfM3Oagm8qpTWI=;
 b=kmysz6TSoqkLbdPXKOEi5IInxAMujaI+HbeHd26V6C1o/WZZnDPglkHDu+yzY44Ie38pf/rmKJBctUtK/vwYX6V6Yex3XkpD6O4VPKudlBqnJILVRzL0HiOOqjHngsikgMwviu5CPdxuxnS9KB2kwAjwsqckZiiW6G9yEfTC9a4=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BY5PR02MB6946.namprd02.prod.outlook.com (2603:10b6:a03:239::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 08:55:26 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::80e5:d8d9:6bff:8a96]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::80e5:d8d9:6bff:8a96%5]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 08:55:26 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Michal Simek <michals@xilinx.com>, git <git@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: core: Fix IIO_VAL_FRACTIONAL calculation for
 negative values
Thread-Topic: [PATCH v2] iio: core: Fix IIO_VAL_FRACTIONAL calculation for
 negative values
Thread-Index: AQHWe9Uy2J6wql2dV0mNnaIWIGIkoqlPN8YAgAK0ytA=
Date:   Mon, 31 Aug 2020 08:55:26 +0000
Message-ID: <BY5PR02MB6916B943FBBFD6B1733E5C1EA9510@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <1598465676-28912-1-git-send-email-anand.ashok.dumbre@xilinx.com>
 <20200829161900.713541cd@archlinux>
In-Reply-To: <20200829161900.713541cd@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [37.228.255.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64250474-ebde-4071-9799-08d84d8b9ad5
x-ms-traffictypediagnostic: BY5PR02MB6946:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB694629AAA1D2EC9D3DFFC515A9510@BY5PR02MB6946.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V0bq/6V4ZCvZSZhXlrbuG7Aqzz0yyn+gUMZGqNYb5/9e6n42NrYrJT/Uoq+O/k8iJybDa+wd5uk55/VnFWILxjcax1hfLVW6rHJSz7T4XkH5VotNvfOhe/EAFZNkj7dxrVKx0kIkrT26SAwlL3/5hMSsR+e34tDV+jTHitUuluXNtT+cn2w9niH+6wuxAi0Cw3ICxiwFRIGDJFpV03y+jaD0CCU6/VoaCIxPhEKw0JkZuVvGJ5lPyD+ULCioLdu7rec2Nr9JPUMRQyRmO4PASNHWss/bydErIaTa0zQjq59nxaXG69Qw3PlUpXEbaukiZUA02QccqF9lECXQbjsfsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(366004)(396003)(376002)(346002)(66556008)(7696005)(8676002)(66946007)(478600001)(66446008)(53546011)(6506007)(64756008)(8936002)(66476007)(55016002)(26005)(83380400001)(186003)(316002)(76116006)(86362001)(5660300002)(52536014)(54906003)(33656002)(71200400001)(4326008)(9686003)(2906002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: c0DjG4sfJIQlRZOZnYYSH3p0fdWj7L2cIPXgOgg/eV5+U+eY0OkJI2X5lPCjs06zgsW/CLLlnJkpVsZ7jolCYJ7y4ZTtH8hEaWpVqKCan6yF2yYysSPUGiswPGHK+GYUTCnKapSrFboHforNX29UoioE0rBqJyQpFCjDxK/DbWI/HyzF2/paj8lpIYVQro06sECxH5DCvQRbTgH8dHftaDQHiPhlB7G5oeGsL9nKJk67+N1Lj7eCB4Ih+v8ePdYsZ2PbC4KSC6J4cUJxU0aweIaVU09cnpThiUuBiNSDLZQeeK7Aji5vEQk+CMnBadgDC4OQVa0c0QGjShjyu6LM6FRljdM0Ff8xiVCRCz21WXAItVDHpzsgWo4/RviPfF4vycPAC54DY1c6UV9oRTnThX3/e7lsi4O8ZvQYoA7cWMZLRJTSpfWrjxRQaUTJ5mkt/lAsfIgA/XskICeQcBTi50bqkwXefaMjWT4I5lmUN0ZOK9jaLS3VnuYl3xdOAWyFSBS5jBEGbHV9T+iI72KOX+ArM7TDZ5qsB17cPgQ+UE8/9LxZ32PP4cZuEKGUIh6Y02/qEqfXskwgWWfWmD9MGCmXSrfpvunqKe9Bgj+vCVo+bZuETp01hihDMl6YroSWPcP9nLVtrgiWiDUJqV2qsw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64250474-ebde-4071-9799-08d84d8b9ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 08:55:26.4933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9eBWr94FM96X06gtC3TEje3DXGtk1K3mzXmXKzSCg8UgcSWFeNKP7T8XeZFtSmS5Wedmib+fwTTQ9EwYDXNTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6946
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

I encountered this when I was developing a new driver.
If you look at the function where this is used, all other IIO_VAL_MICRO and=
 NANO
have this fix added at some point.

Thanks,
Anand

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, August 29, 2020 4:19 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; Michal
> Simek <michals@xilinx.com>; git <git@xilinx.com>; linux-
> iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Subject: Re: [PATCH v2] iio: core: Fix IIO_VAL_FRACTIONAL calculation for
> negative values
>=20
> On Wed, 26 Aug 2020 11:14:36 -0700
> Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:
>=20
> > Fixes IIO_VAL_FRACTIONAL for case when the result is negative and
> > exponent is 0.
> >
> > example: if the result is -0.75, tmp0 will be 0 and tmp1 =3D 75 This
> > causes the output to lose sign because of %d in snprintf which works
> > for tmp0 <=3D -1.
> >
> > Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
>=20
> Looks good.  Just one last thing.
>=20
> Is this actually hit in an existing driver?  I'm just wondering how far b=
ack we
> need to push it in stable etc.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> > changes since v1:
> > 	Changed -%d to -0 to make the fix clearer.
> > 	Removed the email footer.
> > 	Updated the commit description with an example
> > --
> >  drivers/iio/industrialio-core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c
> > b/drivers/iio/industrialio-core.c index cdcd16f1..a239fa2 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -592,6 +592,7 @@ static ssize_t __iio_format_value(char *buf,
> > size_t len, unsigned int type,  {
> >  	unsigned long long tmp;
> >  	int tmp0, tmp1;
> > +	s64 tmp2;
> >  	bool scale_db =3D false;
> >
> >  	switch (type) {
> > @@ -614,10 +615,13 @@ static ssize_t __iio_format_value(char *buf,
> size_t len, unsigned int type,
> >  		else
> >  			return scnprintf(buf, len, "%d.%09u", vals[0], vals[1]);
> >  	case IIO_VAL_FRACTIONAL:
> > -		tmp =3D div_s64((s64)vals[0] * 1000000000LL, vals[1]);
> > +		tmp2 =3D div_s64((s64)vals[0] * 1000000000LL, vals[1]);
> >  		tmp1 =3D vals[1];
> >  		tmp0 =3D (int)div_s64_rem(tmp, 1000000000, &tmp1);
> > -		return scnprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> > +		if ((tmp2 < 0) && (tmp0 =3D=3D 0))
> > +			return snprintf(buf, len, "-0.%09u", abs(tmp1));
> > +		else
> > +			return snprintf(buf, len, "%d.%09u", tmp0,
> abs(tmp1));
> >  	case IIO_VAL_FRACTIONAL_LOG2:
> >  		tmp =3D shift_right((s64)vals[0] * 1000000000LL, vals[1]);
> >  		tmp0 =3D (int)div_s64_rem(tmp, 1000000000LL, &tmp1);

