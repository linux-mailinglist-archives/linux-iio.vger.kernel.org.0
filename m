Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BEB1985F4
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 23:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgC3VBd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 17:01:33 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:24098 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728165AbgC3VBd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 17:01:33 -0400
X-Greylist: delayed 2903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Mar 2020 17:01:33 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UK84VV019464;
        Mon, 30 Mar 2020 15:12:47 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00010702.pphosted.com with ESMTP id 3022m1dn8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 15:12:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRwVVwsohTXsODP7kx8fP7yYq6Wmt247VRXKLfOkoOUuE3ovGD8Oozl6tbUz/xj8zorwSIPsK9/rZiGU1s1EzYw632r7Af98l6bbXxe2Ep/U9qoiGS1q75v2sLIHglNvSzJFgoVID5QCeIqm4xAPyqqhF6xMVb7FIUhSljWqfzAKr2AIca+VysT+PFDgcxSS5IWpMhaldGt8sT+V952Oj8RgKzIwtKlr2zriYveLgTXmDV0Jnay/3f+q3SM+5kX7gaBWvnydzg4Izgfd5LHEamtq5ZitskpEK/yjV8IiR2P2mfx1D9Njqq0mfWQ5gOEOkgovJWymGJmis/ThYbDioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUfw/vCyDAf3Te6MwylHE3EgpEc1Rc+AZWC/FpLqct4=;
 b=Umn8rSgy9/4Qk+zJ/DcM1EUin5nehxBm4lLJVIK78Bw03IND9JELDGeKfx9F11+KpLd4s/CrqOE06cXOJ5YVHjBBXbqrNwTy22yuELEV20LQRMcbGL/TLmiIlpcm3QdP7hbVDObbKGiNlhUuuHekW0QIUrCdBY6U3ag+oPgijMMnvc/J87FEN/nKXQCzWuteO14QFfJpjicR7zr8VUNl3yP5LMeJ9J+dQUy+qvi6MkmIJDWY5LIdi/Pmi6xpnIb0fiEdzFMQeXtzCXuDxf2LNcsg4l5kfJkM3HqzzDnUfN0GyxAdnjq4/SBI9CJ/jfnriCbOXuaiq+/6y116zBuTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUfw/vCyDAf3Te6MwylHE3EgpEc1Rc+AZWC/FpLqct4=;
 b=RNQakyY9NR74tg3YU4i1ZImXG4uTVmSOILMvRb4CWIK6T8hdCtay86qbO+AsBP4rldtzz2QN+PqNIFkE51qFR4ySo665h6JYsdfb4cYmlhG10jOcVXR+z1H2bwgRFSiBQT++cyCRWSs92/BRbdRdsn28PJL6XhYxoboe/qpV/J8=
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3645.namprd04.prod.outlook.com
 (2603:10b6:803:45::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 20:12:44 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4%5]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 20:12:44 +0000
Date:   Mon, 30 Mar 2020 15:12:43 -0500
From:   Michael Auchter <michael.auchter@ni.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Message-ID: <20200330201243.GA22106@xaphan>
References: <20200317135649.8876-1-michael.auchter@ni.com>
 <20200317145113.12413-1-michael.auchter@ni.com>
 <CAHp75Veh3QRfqVFOpYbuuxcPqirc1_YrF-iZfRjNsYk7DWqYpQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Veh3QRfqVFOpYbuuxcPqirc1_YrF-iZfRjNsYk7DWqYpQ@mail.gmail.com>
X-ClientProxiedBy: DM6PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::21) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (66.90.216.181) by DM6PR17CA0008.namprd17.prod.outlook.com (2603:10b6:5:1b3::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Mon, 30 Mar 2020 20:12:44 +0000
X-Originating-IP: [66.90.216.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c13d9d8c-3684-4ef0-f62e-08d7d4e6b53e
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3645:
X-Microsoft-Antispam-PRVS: <SN4PR0401MB3645B71943CA665E95115C5287CB0@SN4PR0401MB3645.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(7916004)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(186003)(5660300002)(6486002)(2906002)(1076003)(9686003)(8676002)(52116002)(81166006)(86362001)(54906003)(66476007)(66556008)(956004)(316002)(16526019)(66946007)(478600001)(6916009)(4326008)(81156014)(53546011)(8936002)(6496006)(33656002)(44832011)(7416002)(26005)(33716001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0hKGSbrryno2PpC4j4L5CmiMHcMP/IP+pkgN3CNC+rUhtQfOUP9j4pYMrcgKzwHRAbLxJqZIqmR5EP+Bu+krP6yDMjjTFNbb5x4rUvSyFERAMUTTf2wnRbma1TaZV4mWLOiPRWonpzOUtDx5RBeD2Wf9VuCO0svxjrtIqIjquKzdvT2t/TR9U5yxyQYZYnOVaNGHqgPMbY5ro2KukX6WJSqFMqd8tJvYJJlLxThcIElD7xzd/p9IqikQuM14hhIaLgnQumGPzQz/YylpYNLnHtXMvRk1E2MDCaysMYxUD+CIseqJ2u7rCJWPlC6Gje9i5X4Jb9wH/z0F8nx1k4tjbDPEFnipQrLca3hTwmMBmwqIUd7JwGFYTeRLfoaZ8PDRBCvWhc1h2l9x3O6fGBQRoYfYw3WHqEfcKzdyAUinRGfuxyvo+RR8qb2V+wSniia
X-MS-Exchange-AntiSpam-MessageData: +nztp3rKfXZJqFzWjJCq6abq149HqJopeY3yYC8Ce2odvgHKYN9xE0n38hkDlUDZ/JopQdF1dk0OqKoEN7IvMPlW1jfPNmx2M/ikgwpWciNjwq22uZzGwENDCXoIX7tUPIoSkdGuR6HRaiNQoIrqNw==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13d9d8c-3684-4ef0-f62e-08d7d4e6b53e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 20:12:44.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PAIJ7XlXnpEx/Z7b2NYyUNNcBElSabi6hK4wsF5fefcN7H6p+fuS/pCDXr7vr2fH7PK+mx6Dew/+gkU2PCQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3645
Subject: Re: Re: [PATCH v2 1/2] iio: adc: ad7291: convert to device tree
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 suspectscore=1 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003300171
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Andy,

Thanks for the review!

On Sun, Mar 22, 2020 at 01:46:21AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 17, 2020 at 4:53 PM Michael Auchter <michael.auchter@ni.com> wrote:
> >
> > There are no in-tree users of the platform data for this driver, so
> > remove it and convert the driver to use device tree instead.
> 
> ...
> 
> > +       chip->reg = devm_regulator_get_optional(&client->dev, "vref");
> > +       if (!IS_ERR(chip->reg)) {
> 
> Why not to go with usual positive conditional?

I took this pattern from ad7266.c which Lars pointed me to. I agree that
a positive conditional here would probably be more natural. I'll change
that if you'd prefer.

> > +               ret = regulator_enable(chip->reg);
> > +               if (ret)
> > +                       return ret;
> > +
> >                 chip->command |= AD7291_EXT_REF;
> > +       } else {
> > +               if (PTR_ERR(chip->reg) != -ENODEV)
> > +                       return PTR_ERR(chip->reg);
> > +
> > +               chip->reg = NULL;
> > +       }
> 
> ...
> 
> > +static const struct of_device_id ad7291_of_match[] = {
> > +       { .compatible = "adi,ad7291", },
> 
> > +       {},
> 
> No need for comma.

Indeed, I'll drop it.

> 
> > +};
> 
> ...
> 
> > +               .of_match_table = of_match_ptr(ad7291_of_match),
> 
> No need to use of_match_ptr(). Haven't you got a compiler warning in !OF case?

Hm, no warning as far as I can see with !OF... but agreed that this
doesn't make much sense as-is.

Is dropping of_match_ptr() the preferred route here? The driver doesn't
depend on OF, so it seems like keeping of_match_ptr and instead guarding
the ad7291_of_match table with #ifdef CONFIG_OF would be preferred. Of
course, maybe that's not worth it for saving some bytes from the final
image.

Let me know which route would be preferred.

Thanks again,
 Michael
