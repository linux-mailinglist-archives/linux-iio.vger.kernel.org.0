Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFCA34B00A
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 21:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCZUSI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 16:18:08 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:42782 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhCZUR4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 16:17:56 -0400
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2021 16:17:56 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12QJlU6M024276;
        Fri, 26 Mar 2021 12:52:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=7L9fbxIPOE5ZK2KR/ucXMn+2tFtnvCNQuEbOrKidOCM=;
 b=QBOaon4+PCVk1MNoXhW+O8pDFO8wzXAQlxyZvdS5kYoZAZjB1jV1NQJmvV8PZNfgL4uK
 fkj0k0/2DS/5yL6At4A9i2rR1Oy2Fxpmf09JnUjZmbY3klKtJMBMvdfmxK+LznVOp5kY
 tTa3OV0Mu+jb94zancKzFtr2J1q+bjam6DzYnFz3nWsiXpgTY+kblHf4Gn5wkRxjvvNz
 IgClkKrXZ6VXFDEmaVgft8aszMa5sIz8OGazT/nWNQUoaDTHQWLi0/XWYQsAu4KDRcTA
 UDXZzIXs6VSFETXa4b+BgfTVHXm4hJx/7Ls3ANlq96yOerBMZjHlyLDAyJzD3vFURD0q KA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00328301.pphosted.com with ESMTP id 37h12xgpns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Mar 2021 12:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+69boTudH8dYuLiSDONvQSC3DdBnILlgBgieM0bUkxJlIlXbitmG3bEPUl7e1a+tKHnX40eJiQ2uVppcBivJ78/VTKXgyCQb5ckTQn2997rhz7sFp9sje7gB5iszN+KW3kBa43tF6bNyl0FYzXSsiSpR43zBgpfI6v0mfz83TuqtStKhmqH7ICEla9H+uIXZvvbBUwrKrNnTKGxrE/giAZadz+bSRy1R0swhWfRTtPk9bPnZ0knr4gqGZLFY7wwMwsNMNxwSH9xMkZgz0WMYLfprT+/+dX7T8uXAz1fgXHUMzqucGSzbybsZ4Yx4NsIsjZpNKs3YUT+kY/Me8bA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L9fbxIPOE5ZK2KR/ucXMn+2tFtnvCNQuEbOrKidOCM=;
 b=DsZWGD+Dg7gS3ZjrScuIl3yJ3yfmne+VQd687UlE5mBzS2zzk1u3Bs+Q6kJX374ljt6UcwrVRpuN+KEKV6V8wdaylyz/UsOlLezM4PcTGTBdGuRFnKeuXkaK4QZAX/RH1XU7meUgUnNsJkOkaHUISCMor8Y9IPWBMYm+Qp6v2Br0A9IStFP+LELbxr+gK5Vr6AJfYRmZz4O9WnKquj6fLRHMrlHhvoDWRIjXTQlv1JOPKxitZO7TW3k7D24f89EOx1N5hI4Jcza/6NwiwheyH3gcAaQWs64QpFZmTQLlncAgSXPknHpgvOOQpWg6+li/jK5LCZfosKrlv4Bv4BkVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L9fbxIPOE5ZK2KR/ucXMn+2tFtnvCNQuEbOrKidOCM=;
 b=XVVqfc8UjbIXNuaRKxmPt8zheRpgGscB1Y8e0pKYqUzNwzaR1dBEkd371h58/zWJNbuLBHJ/7Ra6IPpQNVR3HYTSlSVDloCBMUef7diu19db+n4OWhQYGOjX1r5kwaoyRSoYYNLrvNWYHLR/LhurRc8fkUpZ6i4xHwRsyf2xZ/c=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Fri, 26 Mar
 2021 19:52:35 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::a408:8724:ea62:dd38]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::a408:8724:ea62:dd38%4]) with mapi id 15.20.3977.031; Fri, 26 Mar 2021
 19:52:35 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: inv_mpu6050: Make interrupt optional
Thread-Topic: [PATCH 2/2] iio: inv_mpu6050: Make interrupt optional
Thread-Index: AQHXIXhQuBxkU+ItjUiU8hwUevNndqqWGnAAgAAARgCAAJTDmQ==
Date:   Fri, 26 Mar 2021 19:52:35 +0000
Message-ID: <BL0PR12MB501154C9BDEB3C584F26DA29C4619@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210325131046.13383-1-lars@metafoo.de>
 <20210325131046.13383-2-lars@metafoo.de>
 <CAHp75VcHJrJyvdW9qCdCprrROozUuTb6EPP7DDMg3FSoY=Ch=A@mail.gmail.com>,<CAHp75VdK0rbM3ahDjjaQiZzjZ7Pm7wPV2Kkqv1SMo6c44nh46w@mail.gmail.com>
In-Reply-To: <CAHp75VdK0rbM3ahDjjaQiZzjZ7Pm7wPV2Kkqv1SMo6c44nh46w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d99e67bb-52d1-44de-8b86-08d8f090b3ff
x-ms-traffictypediagnostic: MN2PR12MB4272:
x-microsoft-antispam-prvs: <MN2PR12MB4272A96D9810B401903A10F0C4619@MN2PR12MB4272.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0/ncCGlhP6uDfLjruNb6hzuLY6fvp6MvxpUwSDWgBqYiZK4pY/WdewKlsVUaHPVlXHUWx+bk4UtIp3vpKD/R58QycVrD+4AtHMDW9GH0I2NwzAeL2g9nF1IBs4pxcclFKjwWTcy2RbO8WAGLSpVPh3O0BQCDsgvTeDmuo5+sSt1U9GSFfMcSR39T8vls6+RdQi42YmayzvQ0P3lb+apgh4jbZIDzlGRXKSrXvf7fmGs2Nrt7FPVSINJn+/8PjzrnJYBak5axDwgSlp/kRi29tmHwA5107eObEaq91FU2z6TnoRYp0AZ8lwRTENiypOGYUxbHkYumH5TQT1tkCGu76VtBbFIOpXjYV3MHzjtisskR0XXpH3E1/i4vNKypCfzuogjx8GZr/blO+1nHP1YnY5XJjttzvHY6qq9OcM4UrtsGZLb7GXi5nsIwnVowS7qZ7zXRfjdugpFVGu9jenFZS5gx9GDvwS/7141lQ5rIc4vsQ97UzB8uCSkYwUhUKl9ZAa76lkcVbUTd+QySFWr4YKbnAkp6igv8NCe0lbk7oImeTH/ErfPlBDzHnyeBJLeQIo1SJELmB+UYH8Ysnhn7/DZEXSELW/oyBXnlN7xWHPbL1VGf0GlEXjxLrtfo2prdBbIDpZrs7ie63Pi53bXGrr/3ArF/NL6ET+4ZZ8ngEAg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(39850400004)(346002)(7696005)(33656002)(8676002)(478600001)(8936002)(66556008)(66476007)(71200400001)(86362001)(53546011)(66946007)(64756008)(6506007)(66446008)(91956017)(76116006)(186003)(2906002)(26005)(55016002)(9686003)(316002)(38100700001)(52536014)(54906003)(5660300002)(110136005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?cL8S8q5aICtr07RFUoeqyZAzqraU1jOkaZyNoH2uccPL6kHbdMpXzNhAgm?=
 =?iso-8859-1?Q?rdvvZ8nu3RpmmLR8f8jA6uPmJwBQS7Dm5zwP4tFRokoyLBw+FbMzHE26dx?=
 =?iso-8859-1?Q?grRa+GvNOl9vE5dABonHsOlvqw8gPlyiLB3UB+/qb54Dp+9g3Sf/w0IviW?=
 =?iso-8859-1?Q?pyNO8zqfo6o5OD6cCy8JL+l6+18+DVQySfcriU3cmY2bDH6kSDgt9XW277?=
 =?iso-8859-1?Q?FJcrY+7MxMHKXW5mbfl+FDlhxRtU77amGBzz07XwS/L4gYqZrj51sUSiC/?=
 =?iso-8859-1?Q?ViDYTtkC1vVJ5pGCit6Mh9mwhCcr2lsVZ74Y+uxy+2WqGaI7iJBbtna1LC?=
 =?iso-8859-1?Q?TvSvi/qXhToS5qlUcTkL56HtQqeLZI89R+tTM5A/2KE5f/JmGx2G6MgTmE?=
 =?iso-8859-1?Q?sY42lAc1DN0ow/Ov7/6t7/KxI8x418JDvQIIWNTXB9VTLGCaasTjguW1Z2?=
 =?iso-8859-1?Q?mkKUPQn4kh6kzU2mlxh1mwTJP5a+Sh0dayHG/tRDeAMMu7XGcHqA561yCh?=
 =?iso-8859-1?Q?z6O4kNjB4vqBeDra3SdGjfiCnkd1VnOYmWk3DvxgZj7RqZ5LrYAqUh1KNw?=
 =?iso-8859-1?Q?5XpWBDtIlxoJitodRdy63TOES1pI1R6/5m7oV674YvqUBmpVUTAJfCfW/P?=
 =?iso-8859-1?Q?hn9KSdqNjV/vHp7myKCfJnHw0369eDhh8D4eJc0zInvbME8nSdkqX/lc9i?=
 =?iso-8859-1?Q?n8qe+vg3H/AtdedqyVLjGEqlBWsUqBUhABVJpTjEE2swBg73MThkbJ+mpL?=
 =?iso-8859-1?Q?2+15ijEZA/oj9ehiprhKjM68qBlsEjJ1pfcLcahr5WqqIsI3D6eV+RbZXe?=
 =?iso-8859-1?Q?nna3PnwLuCqSdw9cqjjn9DCpXE3FwPd4TMMmaNyetLQ7Fz1golgBKXewGp?=
 =?iso-8859-1?Q?7Drjexx0RKI//uqLyxoo7yzjlrBJBWsppVvlKN5AZ+O5LxqplSVM5yw73r?=
 =?iso-8859-1?Q?QSUVU09bNyZqIB9GgM6RXk14oPvNnWnm3KGjXnx/n9pf+xOITl+9ALP9zf?=
 =?iso-8859-1?Q?DvrUMruwVpnFrHs1Bpemr6SQccZoF+poMXcBZA5VhpdLuiP5wTGsP6dcNI?=
 =?iso-8859-1?Q?ig51icevAXZM943yY3htXP6MJxWYC3m942ekLLmRXL28dK39MhKSykyA0V?=
 =?iso-8859-1?Q?gvCaJMitu/9OtLeW5DzWko/lm8xgYx/uIQN/YhJnEGu+g3Pao9DtqvnZhb?=
 =?iso-8859-1?Q?vzmfhzUvw5t0sG4d5mPEEs84WlU8o+8zeVpsaGRFn8WZFN/yOMKubZHAuS?=
 =?iso-8859-1?Q?K5fi1sbtHelQPj4q1F2Rmqd732wKDvPA4ljArfxuYQfJddrYsuzsSfmCzs?=
 =?iso-8859-1?Q?+cZmTOnFkspQwE6rQSxiVhlp3ATjcwA5ts8Ok1ddlgaEBLA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99e67bb-52d1-44de-8b86-08d8f090b3ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 19:52:35.7546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KxXHGdtZsSqX7p2fEup8jLmIJV6Bd6lusTb+fe6r4XJYNVDheyeT6iGaj9P5vOzRAvG35ayavd8gnGYHKZYwHJ5xMYS7dLQVNTzpJDyq7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
X-Proofpoint-ORIG-GUID: cDt9afqnCEr53ZeG10WPorkbdse3WjA-
X-Proofpoint-GUID: cDt9afqnCEr53ZeG10WPorkbdse3WjA-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_11:2021-03-26,2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 mlxlogscore=993 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260147
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
looks good, thanks for the patch.=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
With this patch, we can only use polling when there is no interrupt. If we =
want to use another trigger (like a timer, it would be interesting), we wou=
ld need to keep the buffer in the device.=0A=
=0A=
But this would be better in a separate patch.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
Sent: Friday, March 26, 2021 11:57=0A=
To: Lars-Peter Clausen <lars@metafoo.de>=0A=
Cc: Jonathan Cameron <jic23@kernel.org>; Jean-Baptiste Maneyrol <JManeyrol@=
invensense.com>; Linus Walleij <linus.walleij@linaro.org>; linux-iio <linux=
-iio@vger.kernel.org>=0A=
Subject: Re: [PATCH 2/2] iio: inv_mpu6050: Make interrupt optional =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Fri, Mar 26, 2021 at 12:56 PM Andy Shevchenko=0A=
<andy.shevchenko@gmail.com> wrote:=0A=
>=0A=
> On Thu, Mar 25, 2021 at 3:12 PM Lars-Peter Clausen <lars@metafoo.de> wrot=
e:=0A=
> >=0A=
> > The inv_mpu6050 driver requires an interrupt for buffered capture. But =
non=0A=
> > buffered reading for measurements works just fine without an interrupt=
=0A=
> > connected.=0A=
> >=0A=
> > Make the interrupt optional to support this case.=0A=
>=0A=
>=0A=
> > -=A0=A0=A0=A0=A0=A0 irq_type =3D irqd_get_trigger_type(desc);=0A=
> > -=A0=A0=A0=A0=A0=A0 if (!irq_type)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 irq_type =3D irqd_get_trigg=
er_type(desc);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!irq_type)=0A=
>=0A=
> A side note: perhaps change this to comparison with IRQ_TYPE_NONE (as=0A=
> a separate change)?=0A=
=0A=
And use actually IRQ_TYPE and not IRQF (the values are the same but=0A=
semantics is different). I have seen that in many drivers :-(=0A=
=0A=
-- =0A=
With Best Regards,=0A=
Andy Shevchenko=
