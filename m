Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D03C20B7
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 10:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhGIIWr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 04:22:47 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:40592 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231361AbhGIIWr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 04:22:47 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1698BdK4007222;
        Fri, 9 Jul 2021 04:19:50 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 39nywamdjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 04:19:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2GDZMhgzelciqvCMrmKAGnkpmUVibtkFj5MIwVIUsBB3plHa5o1gpRcndAz3X+9UkNY5+iQqikunGsPGgNDhE4UU7aRQCmpBe/Rh3JkoawK4gCoQjIWoRdT7jQbxXx+nDwj7tO3fx/saXTQm2FjdIjDEJK7Zw6ppo36uCGAYtVwq0/LWGZykeL4s5DnBqMFrVWg5VuDS5aaVzhY9wBPBMfX77MT+OGBAuoOpmD+XZI87HhSb2DJF9l704LZLDUFrmrC8ajtoidmaLmzEQ5sl9HiRnIKL3XOcbfOkH5t985i/zNvyMClWcikAs/tlMRCcnq0irnqle5fTfUymobcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG6E6/MVwtgan4KF3lcSKVnhxa/SpGycFhStnXxXJM4=;
 b=MWkweW41p/BM2QAW0wQRqneFVGJSiJefoZtDYqEytDqafKk1Wl5qDbgZYiFIjX7I7vRW/Mr0tcQ4k66a3SScfVNeaBy9btzNU+KCTYu/Lgk90Wi4+QiZ4rFwaAgSn8mbt8UTVheptulX0pwEdANpkM0kxGiWuGmC/zboL7uC+Irsd8c8s9I0dFTvExOzj3o6tS9YSNGDuHLdX+uNYaF1HSVdHKEgUAgQZOW/WBqTAQLakO3oZcXS69m1QOrxXqmiMxhyduQ1xkAjj92sM2u3gpm3CsoOlzSpEoBpL1jzMB44CmIKXW6G5Oqf9wzNh1gSVXHEOUL0p88y0wVZ0FdZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG6E6/MVwtgan4KF3lcSKVnhxa/SpGycFhStnXxXJM4=;
 b=2dHC69mY2b3lbeuQG0MhE8lgucp3HuZrXCUEtopWBn7M5OzIgwE9BHK4hHyep//py17hWZwMF+Gc/vfD1AA6xU95gkqiHL0FsKJd38iudqrfzqK746VvOxUUmqxKi5osvJVOoSs/iZDgclqe2Ril5wgYGkNf0mMvdvMJ2xmZVwE=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5815.namprd03.prod.outlook.com (2603:10b6:510:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 9 Jul
 2021 08:19:47 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Fri, 9 Jul 2021
 08:19:47 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v1 2/4] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
Thread-Topic: [PATCH v1 2/4] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
Thread-Index: AQHXdFTvHL08lM5IPE+ISakQqzqQaas6TQwA
Date:   Fri, 9 Jul 2021 08:19:47 +0000
Message-ID: <PH0PR03MB63662890FF4545AAF45E026199189@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
 <20210708235618.1541335-3-liambeguin@gmail.com>
In-Reply-To: <20210708235618.1541335-3-liambeguin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcGRh?=
 =?us-ascii?Q?dGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUz?=
 =?us-ascii?Q?NWJcbXNnc1xtc2ctNmFiYmFkMDItZTA4ZS0xMWViLThiNzEtZmM3Nzc0MjFm?=
 =?us-ascii?Q?Y2FlXGFtZS10ZXN0XDZhYmJhZDA0LWUwOGUtMTFlYi04YjcxLWZjNzc3NDIx?=
 =?us-ascii?Q?ZmNhZWJvZHkudHh0IiBzej0iNTg1NSIgdD0iMTMyNzAyOTIzODU1NTk0Mzcw?=
 =?us-ascii?Q?IiBoPSJFbk5aSWpJZ3E3L3FpZDNocjQyY3BaSUoxL009IiBpZD0iIiBibD0i?=
 =?us-ascii?Q?MCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFJWURBQUNDZ3hF?=
 =?us-ascii?Q?dG0zVFhBUXoxRERZL2JNWnFEUFVNTmo5c3htb0ZBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?UUFCQUFBQUJPWUdjZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFCZkFI?=
 =?us-ascii?Q?TUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhBWmdC?=
 =?us-ascii?Q?aEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdV?=
 =?us-ascii?Q?QVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29B?=
 =?us-ascii?Q?WlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCaEFISUFhUUJo?=
 =?us-ascii?Q?QUY4QVpBQnBBR01BZEFCcEFHOEFiZ0JoQUhJQWVRQmZBSFFBYVFCbEFISUFN?=
 =?us-ascii?Q?UUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBY2dCcEFHRUFYd0JrQUdrQVl3QjBB?=
 =?us-ascii?Q?R2tBYndCdUFHRUFjZ0I1QUY4QWRBQnBBR1VBY2dBeUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e9ea61f-97bc-46e0-caf0-08d942b250a7
x-ms-traffictypediagnostic: PH0PR03MB5815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB58154EE2E0F4977357C99E4A99189@PH0PR03MB5815.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Buhoc8fMIaaHqtfgjkDqcjEfb7dN55bUIosoegQBuV3luZTR8iqRaV47zzi35AzzLdtypDvCtWKqQyvanhWVOj21AT23FcUEoqtJ6Gawf/UxOeZ6wY0CSO7+BJaIpY7O/UJLr5TVj8OUpblKlbceyt+fo2GWo9lrUPc5oZfeYKhbiZV5qvrf3FSLpijSajc+wnS1NG/eSKCpYyDU+WVgkCUwGrH8AML5MaWMZTn7445kuD7CCse3pGce2RAM7pgi2ss9awxcOt/Gm/Iz9prcPrup9pTA/FnLABZ6QgdsOQe3/PPC8N753Ni6+nsw48XBPPCtNUwAGswr19fn3uzC2sTqrLfVMFPJdbxg9VDTIFCuBJnNopp4mQCrA99YeyAbRlb94dwxYyhLyD1rDzIXB31crzNow+MddqlbPtL5qHMuk1aZjIUhxBAhB8ImllECnEzw6B/+TKLgvqZp7GzTSSUjhg+RQfX62ngm3FS0PW9NjuG06ETRPVI2NGOAz+Ebi68Np96uTvXObbzWnQsKp1QJBaO+uvmmPNvvn1zrAEQWG0Qr4UJZpIbn+pLnU42AIpqnq6vtsw31fZLcTtobHT/sriTxzHjN+NumHbDSvEiY0RCIfV7Sru+FBWhezYaXgBRQgWUzSXz3PjOI2LZZ/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(4326008)(316002)(53546011)(52536014)(6506007)(8676002)(110136005)(83380400001)(71200400001)(33656002)(9686003)(186003)(86362001)(122000001)(66476007)(55016002)(54906003)(5660300002)(8936002)(2906002)(7696005)(76116006)(66946007)(15650500001)(66556008)(38100700002)(64756008)(66446008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FuwfMGZnN4CtBvQ7lgNx2v3aSqYyyZIk+UD13L1OgNy4iy08C5dq5sn7A9er?=
 =?us-ascii?Q?omyJfb+l7YBO7Zz9isBl46OshRCIJs4DWNdi1gO78XD3YmzWy9oOWSzsq5g2?=
 =?us-ascii?Q?U6+Xytb5woSIuliMszMS5RIJHnP2ClR3Z/Il4irrbIXUNV852VIAjGG5MmPp?=
 =?us-ascii?Q?E0NlDlUNkftI4J+55gH8+nl8W88e9MeeT9Xh7tfUAHeEY+zhUUV5EnC0jZCo?=
 =?us-ascii?Q?F+vqa6JGbZ63wKitasmslIc9v387ivnky6pTpe4S9c5X62gN3D7j8575WuDX?=
 =?us-ascii?Q?57BMac/ow/G3SRX1SlLqhOVPdqczlGtiEwewXv7kOIN9whp3hoHuGOepNTik?=
 =?us-ascii?Q?ujezi0Yce4iEku4m1H8GTYwisdWsRrVS285Rk6dKacd53PcNjlgydPktXUam?=
 =?us-ascii?Q?ei2xuN7b55fre72EnJxNpjRX7e/wBcfITbnCXUjOTQUQL7DvWLk4s5/JwGG2?=
 =?us-ascii?Q?8/l6AK9mDM0NhRKIaVAEEl27wCQATiixQyAZlUQmNupRwyxQpwM2N7R8/M1j?=
 =?us-ascii?Q?j87rQJdmeGpzG9LLUjXBwVcZvQSuHlmPRqEQygvRwBxOUUWZT36LONnYrIi6?=
 =?us-ascii?Q?+Aq/B4O8ps/ibGLJdouHYHjdaHt6yOKYH+FbKGc5fHNvs25iQiFhD2esrTJ5?=
 =?us-ascii?Q?5MDXeU0Emzh4Qm8jDCNqeUOAe/Y0B9CViaez9WGRwx/V6NY0ttC8XgtG6WUY?=
 =?us-ascii?Q?VlyDV4YxAlPNzOZPVwBoNfr5Y53JpBTY7gL2pgBLPlSg1gxbFtpZIqLSx2hK?=
 =?us-ascii?Q?EBjUl0732u5YJ7Rd2pqAbhjXCj3FlfQ5RoZarrlobVLYTPIt31P1wvE81UFm?=
 =?us-ascii?Q?CtZK7rnkd5jY9GOvxXh2bXhgOxWZ+i5kxnGGJQwKpGU6T/f+ZgP8PSssq+n7?=
 =?us-ascii?Q?4BJxmcKeLwr/UetBRWZKcz6UCvAhNi/R/W5ItHxBMyxOm6zfXqkxkEqetUKS?=
 =?us-ascii?Q?H8WGgC3aJ7P0OSHL72n4X/LOGlWt5BL5k9/mwYP9u5yOO8O0iycmHdAeR6Pe?=
 =?us-ascii?Q?mO5lFIJg6oLv/+BqQUwYUJQGlBMRwAv6VlgVzcOzMao+Ik/qrdZHorM90/Mh?=
 =?us-ascii?Q?3a8jKeCHdQUyH/0aprRrFj4+v7/uE4bPaHcL90WOTYTP6t1TsB4sls4eREov?=
 =?us-ascii?Q?rP5jq6WlIbG0zVmLhRcjmg/hkRpM1Ds8wBW/AvKp0NvlrZNnqW2uRYyqaKcn?=
 =?us-ascii?Q?UJrxOqOExPdPPd1HCcb47WKi9M4//uRn5CqghDRKbBt5B+MGCpg/HuifrgYi?=
 =?us-ascii?Q?I6RTL1NbhC9bOEoK4YwIfczjWiUArtWJuoAOMrh1pg+OFDjg55ZuuW3E9Hzl?=
 =?us-ascii?Q?SROKK8eMYRsrNpfyQUdYG/ytXgIpmULzvlCSI+NYOhM1GXlCsLdj2iro5BFo?=
 =?us-ascii?Q?ZCEy5IQVF1twzpvROIXwKFeVB/oq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9ea61f-97bc-46e0-caf0-08d942b250a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:19:47.3256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Vr1i9ZqO7i6weYsAOsI2D/G33ZNEmqPXnmOVUK6TOVcVYOYBg3L1R7bqD+RP43DT4cwMaM6UM3cTUaEypj7Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5815
X-Proofpoint-ORIG-GUID: sxlMpVb0ls5dz5EAJqfk4C9rNuPJ7plI
X-Proofpoint-GUID: sxlMpVb0ls5dz5EAJqfk4C9rNuPJ7plI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_04:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090041
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Liam Beguin <liambeguin@gmail.com>
> Sent: Friday, July 9, 2021 1:56 AM
> To: liambeguin@gmail.com; lars@metafoo.de; Hennerich, Michael
> <Michael.Hennerich@analog.com>; jic23@kernel.org; charles-
> antoine.couret@essensium.com
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org
> Subject: [PATCH v1 2/4] iio: adc: ad7949: fix spi messages on non 14-bit
> controllers
>=20
> [External]
>=20
> From: Liam Beguin <lvb@xiphos.com>
>=20
> This driver supports devices with 14-bit and 16-bit sample sizes.
> This is not always handled properly by spi controllers and can fail. To
> work around this limitation, pad samples to 16-bit and split the sample
> into two 8-bit messages in the event that only 8-bit messages are
> supported by the controller.
>=20
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/adc/ad7949.c | 67
> ++++++++++++++++++++++++++++++++++------
>  1 file changed, 58 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 93aacf4f680b..bbc6b56330a3 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <linux/bitfield.h>
>=20
>  #define AD7949_MASK_TOTAL		GENMASK(13, 0)
>  #define AD7949_CFG_REG_SIZE_BITS	14
> @@ -57,6 +58,7 @@ static const struct ad7949_adc_spec
> ad7949_adc_spec[] =3D {
>   * @indio_dev: reference to iio structure
>   * @spi: reference to spi structure
>   * @resolution: resolution of the chip
> + * @bits_per_word: number of bits per SPI word
>   * @cfg: copy of the configuration register
>   * @current_channel: current channel in use
>   * @buffer: buffer to send / receive data to / from device
> @@ -67,28 +69,59 @@ struct ad7949_adc_chip {
>  	struct iio_dev *indio_dev;
>  	struct spi_device *spi;
>  	u8 resolution;
> +	u8 bits_per_word;
>  	u16 cfg;
>  	unsigned int current_channel;
> -	u16 buffer ____cacheline_aligned;
> +	union {
> +		__be16 buffer;
> +		u8 buf8[2];
> +	} ____cacheline_aligned;
>  };
>=20
> +static void ad7949_set_bits_per_word(struct ad7949_adc_chip
> *ad7949_adc)
> +{
> +	u32 adc_mask =3D SPI_BPW_MASK(ad7949_adc->resolution);
> +	u32 bpw =3D adc_mask & ad7949_adc->spi->controller-
> >bits_per_word_mask;
> +
> +	if (bpw =3D=3D adc_mask)
> +		ad7949_adc->bits_per_word =3D ad7949_adc-
> >resolution;
> +	else if (bpw =3D=3D SPI_BPW_MASK(16))
> +		ad7949_adc->bits_per_word =3D 16;
> +	else
> +		ad7949_adc->bits_per_word =3D 8;
> +}
> +
>  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc,
> u16 val,
>  				u16 mask)
>  {
>  	int ret;
> -	int bits_per_word =3D ad7949_adc->resolution;
> -	int shift =3D bits_per_word - AD7949_CFG_REG_SIZE_BITS;
>  	struct spi_message msg;
>  	struct spi_transfer tx[] =3D {
>  		{
>  			.tx_buf =3D &ad7949_adc->buffer,
>  			.len =3D 2,
> -			.bits_per_word =3D bits_per_word,
> +			.bits_per_word =3D ad7949_adc->bits_per_word,
>  		},
>  	};
>=20
> +	ad7949_adc->buffer =3D 0;
>  	ad7949_adc->cfg =3D (val & mask) | (ad7949_adc->cfg & ~mask);
> -	ad7949_adc->buffer =3D ad7949_adc->cfg << shift;
> +
> +	switch (ad7949_adc->bits_per_word) {
> +	case 16:
> +		ad7949_adc->buffer =3D ad7949_adc->cfg << 2;
> +		break;
> +	case 14:
> +		ad7949_adc->buffer =3D ad7949_adc->cfg;
> +		break;
> +	case 8:
> +		/* Pack 14-bit value into 2 bytes, MSB first */
> +		ad7949_adc->buf8[0] =3D FIELD_GET(GENMASK(13, 6),
> ad7949_adc->cfg);
> +		ad7949_adc->buf8[1] =3D FIELD_GET(GENMASK(5, 0),
> ad7949_adc->cfg);
> +		ad7949_adc->buf8[1] =3D ad7949_adc->buf8[1] << 2;
> +		break;
> +	}

Honestly I didn't went through the driver but just a question... Are we
sure that 'ad7949_adc->resolution' will have something valid (8, 14, 16)?
A default statement is always a nice to have :).
=20
>  	spi_message_init_with_transfers(&msg, tx, 1);
>  	ret =3D spi_sync(ad7949_adc->spi, &msg);
>=20
> @@ -105,14 +138,12 @@ static int ad7949_spi_read_channel(struct
> ad7949_adc_chip *ad7949_adc, int *val,
>  {
>  	int ret;
>  	int i;
> -	int bits_per_word =3D ad7949_adc->resolution;
> -	int mask =3D GENMASK(ad7949_adc->resolution - 1, 0);
>  	struct spi_message msg;
>  	struct spi_transfer tx[] =3D {
>  		{
>  			.rx_buf =3D &ad7949_adc->buffer,
>  			.len =3D 2,
> -			.bits_per_word =3D bits_per_word,
> +			.bits_per_word =3D ad7949_adc->bits_per_word,
>  		},
>  	};
>=20
> @@ -147,7 +178,24 @@ static int ad7949_spi_read_channel(struct
> ad7949_adc_chip *ad7949_adc, int *val,
>=20
>  	ad7949_adc->current_channel =3D channel;
>=20
> -	*val =3D ad7949_adc->buffer & mask;
> +	switch (ad7949_adc->bits_per_word) {
> +	case 16:
> +		*val =3D ad7949_adc->buffer;
> +		/* Shift-out padding bits */
> +		if (ad7949_adc->resolution =3D=3D 14)
> +			*val =3D *val >> 2;
> +		break;
> +	case 14:
> +		*val =3D ad7949_adc->buffer & GENMASK(13, 0);
> +		break;
> +	case 8:
> +		/* Convert byte array to u16, MSB first */
> +		*val =3D (ad7949_adc->buf8[0] << 8) | ad7949_adc-
> >buf8[1];
> +		/* Shift-out padding bits */
> +		if (ad7949_adc->resolution =3D=3D 14)
> +			*val =3D *val >> 2;
> +		break;
> +	}
>=20
>  	return 0;
>  }
> @@ -280,6 +328,7 @@ static int ad7949_spi_probe(struct spi_device
> *spi)
>  	spec =3D &ad7949_adc_spec[spi_get_device_id(spi)-
> >driver_data];
>  	indio_dev->num_channels =3D spec->num_channels;
>  	ad7949_adc->resolution =3D spec->resolution;
> +	ad7949_set_bits_per_word(ad7949_adc);
>=20
>  	ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
>  	if (IS_ERR(ad7949_adc->vref)) {
> --
> 2.30.1.489.g328c10930387

