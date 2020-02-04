Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA4151E74
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 17:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBDQoN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 11:44:13 -0500
Received: from esa2.tennantco.iphmx.com ([68.232.153.189]:10941 "EHLO
        esa2.tennantco.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgBDQoN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2020 11:44:13 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Feb 2020 11:44:12 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tennantco.com; i=@tennantco.com; q=dns/txt;
  s=selector1; t=1580834635; x=1612370635;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BX8+w4eL+TFjSInINAIQM0OtKJ3dLUJ12CFBuVXBp40=;
  b=UgBv3ksp8gYKR2Th67XquJTRRIzPT0Z0pWBbLLl+EOI7qY7O237Xp6KK
   tQ24JGKgqX/8fm2deN1vwMFDM+qPzZ+XDEx1Xc4EJr1cs0/hOcsJPn9B6
   Nf4W9QsD50PmAj13Aw/JD4aIAb5Y66i9AsjrOHH8SRvnVIDeWwpIGtPHc
   ISY3Rutj31fnlvicft3VtQ6pcWmfJ3NaiEG3s7Sh23sct2DiVIJIma4Nj
   pW0VNxyT6sqsX+Wn/psk9oNr8Q5X4N0TFbg1P3iGDlN7DaDo5fUTyQb53
   D3fns/qfQSeG3FMz+4iu/JvLht97eifiQpjpauTlaL3txedqZZfNNZ7cm
   Q==;
IronPort-SDR: Tqi0DGJ8S36a2uu7+c8tv0uALCdncwvWYoYkKpMs1MlNAgNcypKCQw/V60crCqDmduB+yAhlDi
 LBF4b5xkQOteF4PvKwPAY8MCugxbIxqY0dFuEVsoJCSNXv0Ty8lO8rsgebTwXxjUgGUHczgeAq
 HLN7aQxtAcrkxrfZn3KDmmq4G1vTlVHgzKE8H4qm49s7o2zHbOcviIOz4k4KZQoIFqYiZYZ6YP
 OIsfoffLxO+pu0RXhGLX45z5E8CEIZOlBiOrCRNzXjmdB0fu1C+2FBJr9sw5DgP8AlqjzeV8rh
 U6M=
IronPort-PHdr: =?us-ascii?q?9a23=3AmzV+nxGumSyLJGtLYZ+ML51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yoMqwAkXT6L1XgUPTWs2DsrQY0raQ7/GrCTBIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrw+xx?=
 =?us-ascii?q?bNrXdFeOtbzn5sKV6Pghrw/Mi98INt/ihKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHXm?=
 =?us-ascii?q?dKQNpfWDJdDYO9d4sPDvQOPeBEr4nmulACqQKyCRSwCO/zzzNFgGL9068n3O?=
 =?us-ascii?q?Q7CQzI0gwuEcwTvnrXotX6KLodXuK7w6bHzDXOdO9W1Svn5YTUbhwsu/OBUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02ep43lOzOazOINuHWZ4epnW+OglW4moBx2rzahxsYsjp?=
 =?us-ascii?q?PGhoQPxl7G8iV4zpg6JN2jRU5nf9GkFp1QuDucN4tqXswiRHtktzo9yr0DoJ?=
 =?us-ascii?q?O2ejUBxpc/xxPHdvCLb4eF7gjsWeuTOzt1hm5pdKiiixqu/0Ws0vDwW8233V?=
 =?us-ascii?q?pQsCZJjtbBumoD2hHd8MSLVOdx8lun1D2SzQ7c8PtELloxlafDLp4hxaM/mY?=
 =?us-ascii?q?QLvETYGy/2hF32jKiLdkU44uSo6/roYrHhppKEL4F5lgbwPrkylsCmHOk2Kg?=
 =?us-ascii?q?oDU3Gc+eunyrLv50r5QKhWjvItlanZrZbaKtkBqq6hGQ9V1Zoj5AijADe60d?=
 =?us-ascii?q?QYmn8HIEhCeBKak4jpP1bOIPf7Dfuln1uslzJry+jHPr3nHJrNMmDOnKr9cb?=
 =?us-ascii?q?ty8UJRxwg+wcpd6p5IEL0NPe7/V0HpuNzdFBA5Mgi0w+j9CNV604MTQWyBA6?=
 =?us-ascii?q?+dMKzIt1+E/OAhI+6CZYALuDfwMOQl6ODojX8/g1Ade7Wp0ocQaHyiAvtmJE?=
 =?us-ascii?q?CZbWL2gtgdCWcKohY+TOvyhV2GSzFTfW2yUrk55j4lFIKpF4nDRoeqgLCbwS?=
 =?us-ascii?q?i0AIVcZnpaBVCUDXfoa4KEVu8IaCKTJM9hjzMFWaGgS48g0hGjrxH6y7V5Ie?=
 =?us-ascii?q?rO4CEYtozs1MJz5+LNkRE+7zt0D96S0zLFc2YhumoSXHoO0bxyuwRWzl6eyq?=
 =?us-ascii?q?V+y6hcHMZIz/ZETg40Mpmaw+EsWP7oXQeUUsaNQVDuYtK5DCB5Gv4gx9YIJW?=
 =?us-ascii?q?Z6BNizpgzO2SyjBaMekPqAA5liofGU5GT4O8sokyWO76ImlVRzB5IXbTf81K?=
 =?us-ascii?q?di6wjeAZLImEyFlqGsML4RxzPJ6HzdnTiVpE8NVgl2XO2FRn0ZakbM5fXBrk?=
 =?us-ascii?q?LZB/7La/w8NxdZj8uLK69EcNrs2HlXQP7lfvTZfG+gs3u9AxCBwK+Ha8zhfG?=
 =?us-ascii?q?BOlCg=3D?=
X-IPAS-Result: =?us-ascii?q?A2H1BQAKnTle/2dGL2hlhBVQXoEIAwQ1CoQKg0cBhTuFR?=
 =?us-ascii?q?YJfmA+CUgNUCQEBAQEBAQEBAQcBLQIBAQKEPgI1gic4EwIDAQwBAQEEAQEBA?=
 =?us-ascii?q?QEFAgEBAQECaYU3DII7KQFxcQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQUCgQw+AQEBAxIRHQEBESYBDwsYAgIFIQICDwUeCyA1hU8DL?=
 =?us-ascii?q?gGgez4CIwESLQEBC4EFKYhhAQF0gTKCfwEBBYJEgmEYV4E1CQkBgQQqjDGBT?=
 =?us-ascii?q?D+EJD6BBIZXMoIsmAOXZAeCPnyVOyebCKl7AgQCBAUCDgEBBYFpI4FYMxojg?=
 =?us-ascii?q?zxQGA2ONYNbinIkMYEFJIxUAYEPAQE?=
X-IronPort-AV: E=Sophos;i="5.70,402,1574143200"; 
   d="scan'208";a="17248535"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.tennantco.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 10:35:19 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hi3TG0k5C4bJtQHqOXyxGgn1P10f2H6b35CDV3RzMfKqkNtpLrNzyrGoczcMK+u6Q+3RhLj6/KeVy+uCCg9mpXoShQ43owrTPerFdDSLvtvkyhvwc040QeWxD1rUeXKxn8OdaHHOLuKzd8Y23vsvocOyIygeMvfeClpcYIDPvoP8G54DlYZwp60mmQiBs9cVLpuuVbdJ99rog3kUy7lwnNjBdPuoNZPjWvkpRxe9d1i6aLMTNQIudMMB4dUDOX5j+xdaNQY79sCBeRj8hp0ee4UGonLQwJnuFeORRUA7zw8C0WtJxqcY2gzXRlSD/oVci2OihcLtHC8R6LDnCzrXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX8+w4eL+TFjSInINAIQM0OtKJ3dLUJ12CFBuVXBp40=;
 b=WqFJeuGGHVW2kJp+katB70/NMWnRtzOTFi7toa2UpQqGxTT2idm13iGciP0kn50yyVbtpXTAC5p+2hzbaVQEZTBFTtcq9FsvXFkgRm7YVuviQZ24tc8sB7Z2h+EFmC5MexRRdwaYTpoQC8U8Yx4GtbTT3aa+CBKvsr7JibKDo4eg1Sg3ci6WdcVEXBBiyPxOuJbQOU2sEqLo0a2Egju3qUJu29eP52Kos007k+i0/kgeHgcfEh16nWBP8RfkryXjL/eOqjVlFyNtvloji7Bt/9c5em2k/xd1BkCeRU6d3UWOV7cM2GITP112PAQNIPc+pKR1WxW5A5G0jfxgYIbxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tennantco.com; dmarc=pass action=none
 header.from=tennantco.com; dkim=pass header.d=tennantco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tennantco.onmicrosoft.com; s=selector2-tennantco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX8+w4eL+TFjSInINAIQM0OtKJ3dLUJ12CFBuVXBp40=;
 b=IHPHzxcEioR2waBhM2o0HzZ+nGBx37tywF7blp/471jML2GZ7dw3l0w9hHdLoxmsB9mXhbbagNUQYlTpeokJjcDD3LaWmCNg+1NUqavyRZ8gy487uhQBLoWK1OMyb5NXJnLjVxA6Pvm2NhXcxbKd84iiObEkh2EtDgaPSdKwsLE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Dylan.Howey@tennantco.com; 
Received: from CH2PR20MB3271.namprd20.prod.outlook.com (10.255.156.30) by
 CH2PR20MB2968.namprd20.prod.outlook.com (10.255.156.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 16:35:20 +0000
Received: from CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::5c21:1e0a:4a39:593b]) by CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::5c21:1e0a:4a39:593b%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 16:35:19 +0000
Date:   Tue, 4 Feb 2020 10:35:17 -0600
From:   Dylan Howey <Dylan.Howey@tennantco.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Temperature support for FXLS8471Q accelerometer
Message-ID: <20200204163515.GA25185@tennantco.com>
References: <20200129193237.GA14494@tennantco.com>
 <c19b2b3b-a1b9-352e-9abc-e52597512158@metafoo.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c19b2b3b-a1b9-352e-9abc-e52597512158@metafoo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR01CA0034.prod.exchangelabs.com (2603:10b6:208:10c::47)
 To CH2PR20MB3271.namprd20.prod.outlook.com (2603:10b6:610:2::30)
MIME-Version: 1.0
Received: from tennantco.com (198.204.33.200) by MN2PR01CA0034.prod.exchangelabs.com (2603:10b6:208:10c::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.30 via Frontend Transport; Tue, 4 Feb 2020 16:35:19 +0000
X-Originating-IP: [198.204.33.200]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 273c192e-e1c4-4fbf-77cb-08d7a9903933
X-MS-TrafficTypeDiagnostic: CH2PR20MB2968:
X-Microsoft-Antispam-PRVS: <CH2PR20MB29684896C77E72ABD5566CFFEF030@CH2PR20MB2968.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(396003)(39850400004)(346002)(189003)(199004)(2906002)(86362001)(316002)(66476007)(4326008)(66556008)(1076003)(36756003)(53546011)(2616005)(81166006)(81156014)(8886007)(8676002)(7696005)(33656002)(478600001)(52116002)(16526019)(186003)(5660300002)(66946007)(8936002)(26005)(4744005)(956004)(6916009)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR20MB2968;H:CH2PR20MB3271.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: tennantco.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rzl7GPXIx3tzfJYwmMb4oBkI+YnwzhMpPzNp6zIt5R8BV/lzST7KaHgX+av7W10idEmlUNbco9/i6NSfhIiNygtLDrA8y1vvbqvSFdNh+84xRAsQ2GSvVpubrom4hkfvKebV4y20i5y+P6mhelIZTpZ5ZsXNCbfVfoiHXj+FVDimnmkmGxahN34OR2zj0a8E+2Mi5z1tXl22Vr0OizZ/zjdlyX8cXZQ63om7TygIqd/1rwiS4yMAWI6kK7AnZ74KicqNQ/wjFx0S/5eRLkRuYDezHsL9AVDJRj9w5zwaOTCIp9SH0nwTCwD04bTWCfHxTsjuh2swEgJJb8unm7/1jMtos6HIgB9h+OmTCEREP+/yAcac3CBs5HwZQcWTRSlAhlT/c9kcBCWtELF3pXZGms/IUNmSUYfqmJNTdx8/NgbL7u5eBj3nJKwMRIGu0bHu
X-MS-Exchange-AntiSpam-MessageData: hTr+QHyjxySCkmvXC8LyuEmHvCpoka5/9/p5i0QmNfhhZtQGLWWCCxiIGKFSrgBV7gyYtKigCoVx/OhtQLR5PPRzdMvxA+IC96ndru54bREy2Tj1iV/grms1e24hfbNXHStHISyS7qXQd2YuAml99g==
X-OriginatorOrg: tennantco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273c192e-e1c4-4fbf-77cb-08d7a9903933
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 16:35:19.7373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 854ee4fb-bf50-420c-8a26-5b96d626ac37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DE3T5e4S/TxOHwSI1f+aSHmzSvNT1ytN7iy5jF5Bo+bhV4zmjeQ6s7PRCK65pfu65+Kd0Za/kJs0tONvgY7ijQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR20MB2968
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Any accel tests I should run before submitting changes? E.g. when I sent
changes to RTC I ran rtc-test first.

On 01/30/2020 21:35, Lars-Peter Clausen wrote:
> On 1/29/20 8:32 PM, Dylan Howey wrote:
> > Hi all,
> > 
> > The mma8452 driver supports MMA845x, MMA865x and FXLS8471Q devices.
> > 
> > The FXLS8471Q is unique among these devices in that it has the
> > additional ability to measure temperature.
> > 
> > Currently there is no support in mma8452 to measure temperature when
> > the device is FXLS8471Q. Would anyone be opposed to me adding support?
> > I have hardware and would be able to test my changes.
> 
> Hi,
> 
> Support for new devices is always welcomed :)
> 
> If you have any questions about the IIO framework let us know.
> 
> - Lars
> 

-- 
Dylan
