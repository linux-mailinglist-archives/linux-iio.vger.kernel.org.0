Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDBE3C2820
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 19:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGIRQ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 13:16:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48300 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhGIRQ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 13:16:26 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169HCqpt001768;
        Fri, 9 Jul 2021 17:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=sJk1tMyyC71vl/FdNOi/hIAZ8A6OFeD1SWBnlWGO/dY=;
 b=PY7qfkqnHdhh/EHhOjNhgFywFfOYycZbEvD/5v9Bm/SBZDgmL2NNWn0BMyFYWqaFoorC
 ZbV+x1hfoJVjzibouzAFsmeBDI4QAwhWyHaAmgbCI6QLaUq3SRDUiXM6IR2Nuwyqf8Pt
 Flzl9OXk+ZqS5dg/1Gm4D92vEPoo/BwPDySBlXxS4XaNuOKeeZ3FmuLc/mRDpQ4hEMcy
 EtBkf8tjrxDTJly3sKQ2yOFclf1h2RiIybjULAq8CpWna7mEf0mXSqrCBIW27TWgybjW
 3jBi7JeHEH3lKmWJyULnLocY/wxl7l6+GKCsYuPSWHjCvule9ENZ/HLHqmDFsy2sOvH1 mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39npwbuvja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 17:13:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169HAg04124349;
        Fri, 9 Jul 2021 17:13:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 39k1p5j6sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 17:13:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DukVLBCnyj2Ynpwlk8MfxEnL2GIptMMatujVEA2nCvM3A+QmIIOfcQHvfd1vRESfVt3SQyj4c4b2Ts9alZ5XjF5OrinDNS3+9v77avuVjHx8IAsqRp74y0/QoMXNwH4mTS+dQdOS1czEqkgBfBLLn5AB1UOeb2yqT4dnukm0PwWsG9IxZ56u017ruSgS/LyjYQ5nTf4FYGJQsmsxzP/AgEI2thiAPekGpYyIhnLrpn2o6nFUfucI+rqBUNz0ZYgT9nsLSgqkN3pcedYJ9zQE3cl4EuUrKBLm4xf4jThqczhSNAG2sYKWqY4aQsWWj9NaL7XX3ULywsV1hqMExCkDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJk1tMyyC71vl/FdNOi/hIAZ8A6OFeD1SWBnlWGO/dY=;
 b=oG9nzPUcG028v3StzIQ+XOBxQx3HxzNcs9LhJeQV1qGkTl+SpQoQhrp4Upo/DaDhgrRXvm9+dGv5zYqPpv50YxCrwWwHuiz8LUvXBHciprEOMlArGXw+2szq58WaFj4P+5vy2mCoOlabgPaxOuCdwm0mFZF6UXLvbGfAtcJLUdvFKgcVdO5F8umV5wjsLJIX0eKYDhtkLDKD+5Y/aIodkQrrNuzjXpiO4/0rA98F58Hz7quOiQwBxi1CnWHXdo3poIlTqq2kogk+PIaBtq9rhCUgpV4OE1Z9Qi3HyrLxwYaICwjyyIeenZlaal8elQMc9h/7eOlgUStymeAuucuyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJk1tMyyC71vl/FdNOi/hIAZ8A6OFeD1SWBnlWGO/dY=;
 b=k7S/4ETSsWbpQT693S+8UrRvtaC9Pz/ozxyF+dsN2UOE/mKfjNFRoFfw1iF07HlwaVsyGToIlLTift+364wYjEQPpgn+YMlx0SuH5cJNaCNKThlzpOnNjBjkVEiV3VSfEJiNN8jBFojo9S2f8MBQoeN7P+KtB9K68IWacMLZ5IA=
Authentication-Results: geanix.com; dkim=none (message not signed)
 header.d=none;geanix.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4610.namprd10.prod.outlook.com
 (2603:10b6:303:93::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Fri, 9 Jul
 2021 17:13:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Fri, 9 Jul 2021
 17:13:17 +0000
Date:   Fri, 9 Jul 2021 20:12:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: Initialize return value
Message-ID: <20210709171237.GD2168@kadam>
References: <20210709031526.30746-1-jrdr.linux@gmail.com>
 <CAOMZO5BHDBR5y5q559UexTmYbhPwSp1MV3TJ3k+z4W8ehE-5_Q@mail.gmail.com>
 <CAFqt6zZ3WOv6sv5iVgkbYBhnxvv=t1pE8ZxEiC7=j5qugvy=NA@mail.gmail.com>
 <20210709143505.4xzpols32j7rotpc@skn-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709143505.4xzpols32j7rotpc@skn-laptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 17:13:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ba486a0-6cf2-4fcc-f48a-08d942fcd7c8
X-MS-TrafficTypeDiagnostic: CO1PR10MB4610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4610787654724A48E5E968578E189@CO1PR10MB4610.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Rdo4fUY+939kzM5lqjEPWmrC7Y73g8IEPT1/s2UQucWMdgauYZsggLrc8UkcK++CTkrquTT1kVvoWdczWZWIKVKtoaW/4+KLyO+GLh0bjDq1JsK5jFdrsKYNkJy4LeA0eI66W3Qs5bctTn1gdB1DOFENfAViJ5AGtSbGMWw3c1hGaM0WZ+ZuiKrgefJ/dx6JixpYTmjDR9skQyhNjqVW/soUS1Ra4iJlpuBO/iH0c9RLoc3XCIseFWfuBEt3tPXJ3CzpAPwN3BpnA12L0P+4CEyPg/oDVdw+qavfweAPt88FuFly3aW6lKieaNYKvJWUTEfIMRfRNSAS3s1kUdKjCfLWXLk0CeAMlNoJW4ZEdNeXILIAauIPjXFocJWwy63EVfHAEaSQi6tfQj2M2+VhwZ6/S7bu4PrSw83ZJP8ORWnmhvCMm9wG43Q5ai58/3MHrog/+uZoNgzc9FoM+pYRlZ7/T5oRVrv0nV/4U12cvKNwjXUz/tEf6sMJ+xbYtwfDS8zbYr6gfMhoq8/sbrpzIG2Kdvu9Ruclo69h94m/SmX0Fcu3BZPCbv3EE4KnRS1a20Mid0wwWVtyy/q0dMoVsjIFbuq4+k3JHnJGAzgUj4a2FDa6oQcnUzk8b7hZaZoUGR1e2GCP6tNaWCdJRa+wm9dTUFFi+wbbmgMX6V43tqRzbKeNxfE4ldK3kGVWr47iq5JWt3vYMKH94xY7W8LdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(5660300002)(54906003)(2906002)(44832011)(6916009)(4326008)(83380400001)(478600001)(86362001)(33656002)(33716001)(956004)(8676002)(316002)(6666004)(38100700002)(9686003)(9576002)(52116002)(6496006)(53546011)(55016002)(1076003)(38350700002)(7416002)(66946007)(66476007)(26005)(186003)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lp/wMEaWOWHPp8YPcUT/pMHsXOrl4jEStqF1CvcN+kM5b9+YdRFwCPC2znGJ?=
 =?us-ascii?Q?sjZsq70p+VyUWTg2luq3fluD0/q0LD+YblAk1ysRPz2g7F+gVWklBAuzasHS?=
 =?us-ascii?Q?Gkt0zU1c7HaMn6iSDAyP3/6fD1pnGas6f3zFQlaivKM74b7zCrCRKiVjarxg?=
 =?us-ascii?Q?LF3ctJfQQ2FlIUFqBOpC+Y/57KipdwYf878oMeX3RKNoUf7tle47cTnSI+Sv?=
 =?us-ascii?Q?1H4HZrAlofE0QIZv+gxNqvZif821crQYBCSn5F9v4BJMVwjF0Vf5cKdU/j88?=
 =?us-ascii?Q?Ld5T5TM1geFUYQ6LZOsGgkaO/CCwIa0oxNqCeoZ5UWTwjwmYoe7Ca8anV+gb?=
 =?us-ascii?Q?WPsZNo1jwfPvuFJjcHIYUBiemgwmYOIPyNXwcTF9kcd8JnMC+szrteITfcpo?=
 =?us-ascii?Q?kDXMRr83NPo8BAFBYOmvigQ5wJCywgoyevljB4UIihC4qxBtayiYjso5k2kL?=
 =?us-ascii?Q?YF0zdnt+MChpQAA6c6+710fIRH5hSUbkKeJ7pScrUjgTKRLVsMZAY+ker6rW?=
 =?us-ascii?Q?Nb409CUoDE+2okAUTe7xPW1XSnrPNWO8dKe/a6Kv92/acHF9cr5UQjZ7jeXU?=
 =?us-ascii?Q?mymi8MuoBKpDF8q/Cx/F8jVRIVXlSQ86MQrD3Y8aElbgBVfKc4nO7/AKCJj+?=
 =?us-ascii?Q?ZJsPmA7OV+lFVpM5rxPetJseN2hGxglk86DY0gJnQMFR6l/meIDO1gO2YZ5z?=
 =?us-ascii?Q?lIdlck+pqRs0LqnPc9KM9W0ssmq+T8NkMC2CI01N37eEss35PS4C/agAzAoa?=
 =?us-ascii?Q?z8Qw0emd7mqGMsYPDSxEe6ed9BRRdCbW7KiaToVUYWhwyNo9FDIiqhybmnPW?=
 =?us-ascii?Q?C0QpBKAZ8jz2WiPAeXuZ2b3gBuAScOTvAEjmsLQnzrbTd8EIBZYZ5jLSQ/eO?=
 =?us-ascii?Q?SPKGdc5+bMh18Zkg0sUYHb5q6KcbHutNxS12hdLHfHLBnzgcSHQxBuhonV9b?=
 =?us-ascii?Q?5adzIbsk/Yw5qxTl2PHclCLr6HNYDQtJwbiH02s1wkoVS8vlq/tiWRwdFzL1?=
 =?us-ascii?Q?NbcN/r/U1KlsX5Znlhi66nkBor53roA/87qIRA4g7XBf3xxCBFVqvdE4qKuF?=
 =?us-ascii?Q?0EpXt/le/hcnMP7le6e2a80WZfLgN6BDZbArSXovc1HWF/hWkH29+vjJs9ot?=
 =?us-ascii?Q?TTAj60u3TvW0m+2ZuuQc8/UJ5fsmme3/mfwCGFR0T8yYQbsT9kAo+0ep11zg?=
 =?us-ascii?Q?2tcxzX7zMEaFcoW1TcEgh9ZsfGqDxIy89qLp9ZUyNAlGci9oI4AQS+MguNF4?=
 =?us-ascii?Q?hawUw1O4ntQqskJeLd6TaUH562xwK5X9LrLM5tLE8smQx2aFSlUboER8Zdga?=
 =?us-ascii?Q?McqPTUesfdR0M0x6PI2x+jaR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba486a0-6cf2-4fcc-f48a-08d942fcd7c8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 17:13:17.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcYatsWzGaVvv8NFQ04CSz6y0I3OtL60zSKRaL/jBlJ0A5B+oaobFxfBW0N86KE41IiXj3eZ+aukgiR0xx8LenW206ulqVeJvR71ZrX/9jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4610
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090086
X-Proofpoint-GUID: FaCpvqPNA19RZxAQHMIissjt-0FoHShZ
X-Proofpoint-ORIG-GUID: FaCpvqPNA19RZxAQHMIissjt-0FoHShZ
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 09, 2021 at 04:35:05PM +0200, Sean Nyekjaer wrote:
> On Fri, Jul 09, 2021 at 07:50:48PM +0530, Souptick Joarder wrote:
> > On Fri, 9 Jul, 2021, 9:06 am Fabio Estevam, <festevam@gmail.com> wrote:
> > 
> > > Hi Souptick,
> > >
> > > On Fri, Jul 9, 2021 at 12:17 AM Souptick Joarder <jrdr.linux@gmail.com>
> > > wrote:
> > > >
> > > > kernel test robot throws below warning ->
> > > >
> > > > smatch warnings:
> > > > drivers/iio/accel/fxls8962af-core.c:640
> > > > fxls8962af_i2c_raw_read_errata3() error: uninitialized symbol 'ret'.
> > > >
> > > > Initialize it.
> > > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > ---
> > > >  drivers/iio/accel/fxls8962af-core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/accel/fxls8962af-core.c
> > > b/drivers/iio/accel/fxls8962af-core.c
> > > > index 078d87865fde..8af1c8f58e83 100644
> > > > --- a/drivers/iio/accel/fxls8962af-core.c
> > > > +++ b/drivers/iio/accel/fxls8962af-core.c
> > > > @@ -628,7 +628,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct
> > > fxls8962af_data *data,
> > > >                                            u16 *buffer, int samples,
> > > >                                            int sample_length)
> > > >  {
> > > > -       int i, ret;
> > > > +       int i, ret = -EINVAL;
> > > >
> > > >         for (i = 0; i < samples; i++) {
> > > >                 ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB,
> > >
> > > Would the change below work?
> > >
> > 
> > This function returns -ERRNO when failed. If it is not entering loop,
> > ideally it should return -ERRNO, not 0. No ?
> 
> samples can't be 0, as fxls8962af_fifo_transfer() is never called if
> samples are 0 :)
> 

Yeah, you're right.  Smatch can figure that out if you build the cross
function DB, but it's a little bit trick for kbuild to use the DB when
it runs on so many git trees.  The DB takes hours to build so kbuild
doesn't use it.

regards,
dan carpenter

