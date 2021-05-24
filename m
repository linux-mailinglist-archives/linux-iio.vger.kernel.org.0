Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEE438DF69
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 04:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhEXCzZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 22:55:25 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:64836 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231833AbhEXCzZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 22:55:25 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14O2rc5S016218;
        Mon, 24 May 2021 02:53:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx0a-0064b401.pphosted.com with ESMTP id 38qk95rdhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 02:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNYbCK7Z8hYv7LBjYYtc2v+Qrof4GeevUaYsuY2AgDZAXxBVu2eDUrUpDfN+Xs3g++SRz2RGglUqIUBxdMAAgENxxYnFB8cic241R99Wqj+YbW8YFr0hD5q70SfTqogI/MJa9zlX7zvD6HaCIh3A1oSZTpcTM38U4rxsqNxXjZnwbhV7B60SY40aMi/wdai0HvdIcnpkIDTEmhA9qn2EowqCIaNTvy0VFDGazZdzxS4Gs9G763WMNyQ2Z8zE7D1/x75UKfAV/ZtD7RHfdt0tLwKjSXYkzCrsLVsjtQMdRKIaszWICA0wSk7lbfP3tpnRQw4jOhG0kETBahXmKs2org==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3THc0f5JyRrPt7VPiVDW37TCWSAXSEX/86YYMxsI5Fs=;
 b=l8PlXh41oDvpSt54oPaLlZxHkWhLJcGvBC1s3Y9JWnu2EiMDV5k2Ef0CU5TaWBSvyT358MArr6WMAubaLzmVhJh0BFGb1TAXox1GiY26GUDKc6Hz36R1vFuizuL39EcDNqyCEWpZMhLaPB8N7XhpPCVcmkdEtI9I4fAC26Om39u2YBHDJVUEboGVzgRFNuXoPfNC4jTuMMG+8sqP7puoSW8wvHD088w8i3KuZgi3jMBo75QrHbzoilbKllq6cR3CZue9MvHTdkL1unVaGUCGDnoAeaMxq+6tiqkmNwgFAgA3cn0wy25MhhUoqdsjj/Ak83366IKnI6yxN43FreQnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3THc0f5JyRrPt7VPiVDW37TCWSAXSEX/86YYMxsI5Fs=;
 b=OyQNMUf9oD5/ryW28Hjrg14ojRD7kKvnBaUqbtk5uewkzRA2LFDjoyO64L5a9+BL91xdq8qFAQfZ7IRu0ltc8yEQR0pGj1dQ/aM+GiWUbJxDbBeN2TuPdEpFCIpE/8DGmUSNJrwE0iy3AyJLMxZxfaDB5NRlrXpYAGjuEo5Crlg=
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 02:53:36 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49%9]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 02:53:36 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Topic: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Index: AQHXRutZA2KT9UoVoUu9pd++4IrNe6rqkr4AgAdvZIA=
Date:   Mon, 24 May 2021 02:53:36 +0000
Message-ID: <PH0PR11MB51913E1982E3208302CE29CCF1269@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20210512045725.23390-1-Meng.Li@windriver.com>
 <20210519092104.pntanimcjg6s6fca@pengutronix.de>
In-Reply-To: <20210519092104.pntanimcjg6s6fca@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa937384-2de8-47f5-33d0-08d91e5f204b
x-ms-traffictypediagnostic: PH0PR11MB5077:
x-microsoft-antispam-prvs: <PH0PR11MB50774E031E1147B9E37CAA2EF1269@PH0PR11MB5077.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X7QsL5ePNQ+q8Uv4uDzTkDfFb4xpBktNRHM38Etga+eenB3j9lNJieKM0SugOftbQCcBzaDxN2H8htwroxHzmvuSCcVaRb71sDp1gn8I6ncXhplHm1bH5zXKBF/kOmEANu2+cOWiZbE9CgKcMP38z9AJar4YSi23aj5E44/1IE8sVQeNMCNv4VmuBVPbOlqd5koo7J4MjQuIIiB97K4d//u8H4IaegRpgkfo9e3lx+EhOBgliTBjYYR2SZG/P/kTzeB2/ISCyHTsq8K/09Fk9LurItlBvCyHeLftibJf06lbaeE6g3audNDMpAOC319X6/ipK50nhZLAhodspGlY0IZt+Gai5bKR7QIekMg2xPfw1BWDG7Q+8++ieuuVKiYzfT25YvTxadf5jvxFGdKEPSINuwobhPhxQnz/iPagBNip/EMpuvFEFXWFYh+YgwAGuiYEHQeSEjWSUhCOTEivd7KcNs7INrINNXi7NL9SiADKw+k0sXoUCHkV4tbhym2/PX/Z1DBKgrbsJw0H/AVPQXxd6guMZqE7GQ22e3XY3Hyf4cpqoRhs/w29TpQjyNiWFo9jjPfp8Uqm5HC8SPaUCDndUoxylB5LTpLe5kYmBFZADZOLT52E7xSRVKiJ4lxGue+4CqcjOXQ1xKRRwXEidvO1mJOWpWC0rLZEfb+CTrjb+twEF7tnpXvyYw6dw/bxWUzty6yRpSa8qUT1XNZp2gqF39t+RBFmQFWkO3NmFRI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39840400004)(396003)(6506007)(38100700002)(6916009)(71200400001)(122000001)(316002)(86362001)(54906003)(478600001)(7696005)(966005)(55016002)(5660300002)(66556008)(64756008)(66946007)(26005)(83380400001)(8936002)(76116006)(66446008)(66476007)(2906002)(186003)(9686003)(52536014)(66574015)(33656002)(4326008)(8676002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?sGvwPnicgjH+rEF8xxjKHKg/6LXo6cd0rgY3WsvMYk4h4rHgscMReJfcoY?=
 =?iso-8859-1?Q?f10rtgfaBUbeoADpNo0rNBwRPxHD7RUxnwx7vRj4QrqjfNoRHZ/KEOhNIo?=
 =?iso-8859-1?Q?2i+NeNQwaI6fPlcPt839kjDJahVfV9n7WhCeu10Qymj2TBOzZzJjBF14pw?=
 =?iso-8859-1?Q?gwajLSNBMFBHuD5yGZLUKO5o7UG2bN8FZWjr7CTvMlRMuW+NbNS6B4cT9x?=
 =?iso-8859-1?Q?3Lcph3ZlzYc6o4WDk3v6VIdMXZaP3vWD15ZN42xGndsStrw7HWuaZ5aX8H?=
 =?iso-8859-1?Q?/8colde6nwF20MWzIhg3JXuzXZ5cZTx4sCieV72sJ9QKEbQ1eBCk9qRCKJ?=
 =?iso-8859-1?Q?5jOk17m/xiI6NjHdKraAzEhQF6UQE8KKQbul63LMPAbFDQ3zAW2P+Qq1lq?=
 =?iso-8859-1?Q?lRp/NsPmiSQN/5BuQR9A7t+q94YIDRrax7PD83gRFbxG3F4g2HhagUKzzM?=
 =?iso-8859-1?Q?sYefc38J9y37dNhh0GOWMaEbLRPPHcv9ZnwWGD18rUrHy0t2QWkQAON4F3?=
 =?iso-8859-1?Q?kNQw/cFQqGSSClXTnjmCFJrvBNs2wQNkqqDAmLeTaRrd4Nf362rYehNK3W?=
 =?iso-8859-1?Q?oXuSEGC8fgyw/4i1w2JYabveqrjTC+GnYL9tl8O+R5KJkDR/cCVgzMICJC?=
 =?iso-8859-1?Q?DF10A2J/DvEn3Ae+OYTS5+kdWt4ED8q1SW4ge5W/0snhIZCKJnkeresi7n?=
 =?iso-8859-1?Q?+1cy35BWCZzJbqwE0hYDJHnlLFYCL1IwmqYUxMXiJobDMwLhRucUUKeFBv?=
 =?iso-8859-1?Q?LV49+D13rGQwfoO8KdkwyrKMZ5YbwGW1/4hEB6M3uUuGh5PknkkZevOS8u?=
 =?iso-8859-1?Q?ivIgoVuMaPzBMQhCWCPY8yfTydF8hpldOVuFVW9yG43B2o2glKCZ1pPWYl?=
 =?iso-8859-1?Q?oX9U8sZCGZD2FI5Hc6NmeL2+wujybb17tpNWTS9LCJBaXhRca45p2Wx7Uq?=
 =?iso-8859-1?Q?s09jbJbomQxvZ1fyiXu57hGPO9KmtAJzkzqC4GkdPmUe9T9ydeAttEP/P+?=
 =?iso-8859-1?Q?vQqkor8Ep9QIZe1aOXC6qIi2cnP6a0JAgjdPtkFatYRHM5gRDQ5VXS50sA?=
 =?iso-8859-1?Q?dllZOIU8fm4YSdHM3aqQOpHgNCR7IASxWoQn2z6Lw3XuFRpMiaCmoOKUgB?=
 =?iso-8859-1?Q?xn9SqNiX8aECFhv55S8eMgkUvMHuY8vEbvKfyVJD3DWF8/ChTJKelZDQbl?=
 =?iso-8859-1?Q?ueyAJnkzuWst3WysfvXZ5e/R+NmWVE65xrPMgYo/Lu8pnLZKmneIF+VN46?=
 =?iso-8859-1?Q?ctkkOPs73lnjVN+TBhip7RkOYdlxnf338giyD0WMv486WjwwSSIEYMemC0?=
 =?iso-8859-1?Q?EPExhWQbxUhbztPBbQTqS3Miap4A4aIPHI88VouehSvDZdqWu4W2lFM9lC?=
 =?iso-8859-1?Q?wDG1Q5pq0X?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa937384-2de8-47f5-33d0-08d91e5f204b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 02:53:36.1126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbaU10q7UxWxlzJ6pTYOWI3dFo0VgOC6R+3iHQtn125dWQLkbVu0aGzR5c1n9cYtxFa86Vps8/kL4xaXzRmIBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-Proofpoint-GUID: N_arIoVxqCY9TmjnUb2At67bpLT12sw3
X-Proofpoint-ORIG-GUID: N_arIoVxqCY9TmjnUb2At67bpLT12sw3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_02:2021-05-20,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240019
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Wednesday, May 19, 2021 5:21 PM
> To: Li, Meng <Meng.Li@windriver.com>
> Cc: lars@metafoo.de; Michael.Hennerich@analog.com; jic23@kernel.org;
> pmeerw@pmeerw.net; linux-kernel@vger.kernel.org; linux-
> iio@vger.kernel.org
> Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading =
the adc
> conversion value
>=20
> On Wed, May 12, 2021 at 12:57:25PM +0800, Meng.Li@windriver.com wrote:
> > From: Meng Li <Meng.Li@windriver.com>
> >
> > When read adc conversion value with below command:
> > cat /sys/.../iio:device0/in_voltage0-voltage1_raw
> > There is an error reported as below:
> > ltc2497 0-0014: i2c transfer failed: -EREMOTEIO This i2c transfer
> > issue is introduced by commit 69548b7c2c4f ("iio:
> > adc: ltc2497: split protocol independent part in a separate module").
> > When extract the common code into ltc2497-core.c, it change the code
> > logic of function ltc2497core_read(). With wrong reading sequence, the
> > action of enable adc channel is sent to chip again during adc channel
> > is in conversion status. In this way, there is no ack from chip, and
> > then cause i2c transfer failed.
> > In order to keep the code logic is the same with original ideal, it is
> > need to return direct after reading the adc conversion value.
> >
> > Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent
> > part in a separate module ")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Meng Li <Meng.Li@windriver.com>
> > ---
> >  drivers/iio/adc/ltc2497.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > index 1adddf5a88a9..fd5a66860a47 100644
> > --- a/drivers/iio/adc/ltc2497.c
> > +++ b/drivers/iio/adc/ltc2497.c
> > @@ -41,6 +41,8 @@ static int ltc2497_result_and_measure(struct
> ltc2497core_driverdata *ddata,
> >  		}
> >
> >  		*val =3D (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> > +
> > +		return ret;
>=20
> This looks wrong for me. The idea of the function
> ltc2497_result_and_measure is that it reads the result and starts a new
> measurement. I guess the problem is that ltc2497_result_and_measure is
> called to early, not that it does too much.
>=20
> But note I don't have such a system handy to actually debug this any more=
.
>=20

Hi Uwe,

Thanks for your comments.
I would like to verify your ideal if you can offer your patch or tell me wh=
ere to change code.

Thanks,
Limeng


> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
