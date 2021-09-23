Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF85A4157F6
	for <lists+linux-iio@lfdr.de>; Thu, 23 Sep 2021 07:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhIWFuE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Sep 2021 01:50:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43992 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhIWFuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2021 01:50:04 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18N3R5mD028634;
        Thu, 23 Sep 2021 05:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2KzTdWxMW3k0bR7xi2IvlmIGQWYjU+hxKzwd8A0dzfo=;
 b=DzjY0ukF6FeDmC/7Y6isNidDD/sK7qmvFSItC+QOfFL/r4a40LOxyz9cLxekTmrxQWWS
 pwX7PRRRR/c+3rbvE41Y4/kLnwyAqyudvICaNrLkwLupY5EK6R28NjgjPOXzp8hzZKQn
 58pwt5Y1F3IEdFDJS/oCZPMPpm5g773aZa0nmDRrVbKxdtpnNn0djtgLKC9spgvEAUhx
 ix5R7j9smHVDczfoDfkHLeUV827nCemEAfPmb34Y+vclyCA2Ub4PLbrlTxTCavGe5pkd
 VnLvoobipK9HJx4cOuRzR4qZ4XLMc8cRgoF5c2H9qlP1b9hMB9NXpEeQKIrNKfg+0oAU zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4pg044-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 05:48:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18N5iqXu111202;
        Thu, 23 Sep 2021 05:48:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3b7q5bpsue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 05:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUEhO3Y7BAZOH1DW644SByox30rBHJeyLvtiRlz7DoYT7JGeQly1H2nxpPBwGBo3lXQSSuac0uLTgLMzcX0XloFsrH1UIGZ/GPgUIl5VIkrW1+VQkxGX7+JJS0Ku5qq9MY4gTRg2NofU0MuzYEtiNogASFspuwgbp+sWOCeRGjtWaEwgc4proBBbnx+Mi62iHSYMo8T63GYdaGcTP87mq6VE8PJ48Q20MpUdWCY0cJcvqii0b/Xqr3pe3/vi06N/vs87LtuL4kbMb1Ie901TRH1EmoZZY6rzzqIp9Vd4oEAvCfXXdcA9+5GhFUmBo7N970+YB7zwktqD9SvOyzNCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2KzTdWxMW3k0bR7xi2IvlmIGQWYjU+hxKzwd8A0dzfo=;
 b=coTbqW0pxUVA8KuvZMSUGohyf4InjuhOApbVPIZUWLehCA57kIBtKgyv2zAiO6QykOYzjFQN8yorymvie/ySY4FS6W/C7PSA3tUB409OYvXP0zRoYQSiScWY5/sCrnR8iUCPnqSId5cm9kZU2grbV471llGtzcykf0psCPOuhwcKJWe7eKduzV1tSJixCElNNx29UU9Wxsxcnd0vhDRJiDaPiB3RNhqkczTUrh15bhJmG73SRluZPUGlKAktT6Uo6MUycs53ya1H6YJAwtgvP3hYeWD0b6n8bzA6o+8V/bcP8tuOlp4Rjb0XazUsnb2KUUsgV1id0BYK0KJL+cRArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KzTdWxMW3k0bR7xi2IvlmIGQWYjU+hxKzwd8A0dzfo=;
 b=vQVFwOBN9C0JTMq+A7yDr0gLW0UdbGLH8MYoOlq6kT+52TUGHYmtzb2KjHyxWNdvWUrpRFO/nAkPH0mByc73sOCbdndlxg2qqLLSlTf5QF2m2h2SqTU94FADtaID96kGnjmuWTPLZ+5WGbI0zQB8l0auHoAiBkTaqVmYEkXvQzM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4610.namprd10.prod.outlook.com
 (2603:10b6:303:93::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 05:48:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Thu, 23 Sep 2021
 05:48:28 +0000
Date:   Thu, 23 Sep 2021 08:47:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lvb@xiphos.com, linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: adc: ad7949: add vref selection support
Message-ID: <20210923054358.GX2116@kadam>
References: <20210921063509.GA26209@kili>
 <YUq63O3ksdr9R3pE@shaak>
 <20210922060026.GW2116@kadam>
 <YUtCTZ2sV/h6+dZ9@shaak>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUtCTZ2sV/h6+dZ9@shaak>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 05:48:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0444f78e-5fec-447c-3351-08d97e55c442
X-MS-TrafficTypeDiagnostic: CO1PR10MB4610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46107D3655268509ED9DD50E8EA39@CO1PR10MB4610.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrqFIuQ4mzMrH3KQs7CPtIIPEe3t1CVoqvi5rzyqCV6yV7deKwr3EP1f9xxMWnzyCY9ZpEmRpD9qa0MMKRcZzH4hp5vZRajIeHVlXHBTR6SvqgwFRThuW7J2B8D54BVQt3GsO7wkxVd4t8Im/aW8oWiEmfHeqRvdslE3QCw1WVWjef508R/9zC0eJC5bcBqKJB4VdgOUq1+K2XE1hcYO9rwMnS60feF1B8nso2lxl5R2F0h81hyiPbr7iVZoAUIFxkCJk6YQ/p8uq+AYP2XmibatODcdClvmW8Wk7n9nOr3bk0sSBZJaUTeFDHhYICJq5r6dlpJ1u59njNlnK6N+TnpQDnMmJsIImzhAitKue9ocplvzpgiHcspsGM+sT4sarNo0fzM0X80J/qnCLaHzHPS69ewOyVX/t2LRKNpx/g5wP4PSVJLDeMiipmvEORfeuRDgwNASLlQWgut3j+MIru8Kp5h10JsKEzOGMbZz+nfWtGSJqTdMItq/8+PLAV+K9RaLmYyKkDSq3AfHBAb9W+1PXrbTyVsh25xdNJlYifCEKO3nexvt//LQIeJ+zjRgtHzXI1kXDfUiNfn+R31X7nZCZyP30Qmjvv/9Si1ZO6KUsDlOCueOH06yI5W4wxY0iuo24f8Tapud8eeMVDM9OrHMWVb1e46BJau/wB/8FZWtSN+g4BfA8DSSHxjD6Pipn9Z+kU8GuOHqcViS54zhiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(86362001)(33656002)(33716001)(9686003)(6916009)(316002)(66556008)(66946007)(956004)(9576002)(8936002)(4326008)(44832011)(5660300002)(66476007)(55016002)(26005)(52116002)(186003)(8676002)(83380400001)(6496006)(1076003)(2906002)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3e2MDscx7ESrIVjwMRQjWehGK75BkS8zJ7oi/uTN6BgNBKtRFUlO+hzRMNf0?=
 =?us-ascii?Q?RfOhADkU7sI+wujW9biuxBYLSlhwogs9YotkkxCCa5wJnZqudAPrsaBpX14Y?=
 =?us-ascii?Q?l5n2d9ZzAj8ltWLX7v/3x8/eMq6AmvtK6maILNHmmEQSzOvAJNMwQ4gjtgmD?=
 =?us-ascii?Q?oNeadnX3wO3h7aIy0owbc4BFW7dVQUH5HJisK3ktkiYRZtNYhUdrLab4qdl6?=
 =?us-ascii?Q?xnfgW0uPZ6tDA+sirNXBATJMysYxFgB3CZkL1fG1bEp4aFAWkascTKJlmQo4?=
 =?us-ascii?Q?uAiy7TrcH3qztgZe8eJ3lixkWRjBRiBaI3dbr7gc6LGAdlRcGRn12ZkqUuqW?=
 =?us-ascii?Q?v1Vg2vi2ibbq/IS1Sgh5dxgUxI3IjQT7fusbCrtvVaBVRkw8iSpONcs7CLQb?=
 =?us-ascii?Q?YbhIZ60DDdNp4+dOlG1P4gzFe1IZWXuUkUD+a8/oDqFDOXMZawILuoDVuYFF?=
 =?us-ascii?Q?/xAEkgA18NTkb7iG0+iX7AqlooxxPdU1Xd+3JMbOERNQ7u6z1g2UhB53TyKz?=
 =?us-ascii?Q?hp8ooe3Kp9lQMS/eLOIJoRGLPF3UroVYZeMsDnRxt+lx9vegFjii3YnQ8TDh?=
 =?us-ascii?Q?JtIQ3uPlaWkpYDuH0689TYvXj/Z7hC0sXWpX/MZ0+uMLNlr8GOpj8r5qjqSn?=
 =?us-ascii?Q?icBWiQDaWohq3bXtDenm8qA/M6VyougaCvsZNUIh+9vN0Clh1S5B8VNrc0tD?=
 =?us-ascii?Q?+M/ecyxwsbV7JKd+pI01QUWrUOERQGA9lKa79feFtbKSDwZCRLu8DzDi+lZf?=
 =?us-ascii?Q?V9cfNvgOSqAZtHQHM3mitsRBVEI7vhRLD2zDsGLCFBRndJT1KNJwWr7llRTv?=
 =?us-ascii?Q?pGlqPBTjZiIMa3f3GllU2p6sc7DBsSeY8IB++P/hvoFUJt9tUmijtRu5kYRy?=
 =?us-ascii?Q?Scc67AB1LwS08ypNXcDJdsHsFQ400AyI+UBb8pyDcy+tBMW4/BGoegxK4AgA?=
 =?us-ascii?Q?btSjFoXVfgO7jIhrBn4HYNbUxsI4lng8bwlP9svGW4p2GqlsKK2H8eGM2/Zq?=
 =?us-ascii?Q?zSKHp0u7vlQJCmtG0FHEyLE60/NWqrA965yD+vSq4t0pqt5OhGlBB103pAZu?=
 =?us-ascii?Q?SE5jybsj/CWtW0yNejNYBZC6jkzdEMOMFUXWwZRhGa/A16y6VEgzjF3zy5O1?=
 =?us-ascii?Q?3MHyphbKtlPuN7Y81KPHlj4ru6FG0nPYxdY0RlS01CvcMD9c3gPV51VrVL3R?=
 =?us-ascii?Q?X1+tpbBRVs6sNCWwZdzBfrt4/Uteey45JmfqSdw1E/GoDc3gdKODsGm7osJy?=
 =?us-ascii?Q?uXvJJzCW0Z0k0DKU51UwaRO4xpOu/DOZsbPwPZwk6EJ6x2AmqGxz23qQMsSB?=
 =?us-ascii?Q?mMAPSQJhTdAYG38qNJiOkHoa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0444f78e-5fec-447c-3351-08d97e55c442
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 05:48:28.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJc9R6hCm9OxS42ZkKbDPLGSPHmDm/ImVyN7WrRg27/+LLYUBFdMgZ8l4C+wbAhvdcC9/n7Rn2n+PkouMJmd1o/268fvyQgV0Tv59uE4SH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4610
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230035
X-Proofpoint-ORIG-GUID: p5lCfjyo0nSy2TEheAfOo2tQ1qHJz8te
X-Proofpoint-GUID: p5lCfjyo0nSy2TEheAfOo2tQ1qHJz8te
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 22, 2021 at 10:48:45AM -0400, Liam Beguin wrote:
> Hi Dan,
> 
> On Wed, Sep 22, 2021 at 09:00:26AM +0300, Dan Carpenter wrote:
> > On Wed, Sep 22, 2021 at 01:10:52AM -0400, Liam Beguin wrote:
> > > > 
> > > >     369         if (IS_ERR(ad7949_adc->vref)) {
> > > >     370                 ret = PTR_ERR(ad7949_adc->vref);
> > > >     371                 if (ret != -ENODEV)
> > > >     372                         return ret;
> > > >     373                 /* unbuffered? */
> > > >     374                 ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
> > > >     375                 if (IS_ERR(ad7949_adc->vref)) {
> > > >     376                         ret = PTR_ERR(ad7949_adc->vref);
> > > >     377                         if (ret != -ENODEV)
> > > >     378                                 return ret;
> > > > 
> > > > Instead of returning NULL when the regulator is disabled it returns
> > > > -ENODEV.  How do you differentiate from an -ENODEV which is caused by an
> > > > error vs an -ENODEV which is caused because the optional regulator is
> > > > disabled?  You'll just have to hope that the errors are less common and
> > > > assume it means disabled.
> > > 
> > > I see.. So far, I've only used fixed-regulators to provide a constant
> > > voltage reference here, and I guess those are quite unlikely to fail.
> > > 
> > > > You might be doubting that devm_regulator_get_optional() can return
> > > > -ENODEV on error?  Look at the code and prepare your heart for sadness.
> > > 
> > > Thanks for the warning, I see what you meant now.
> > > 
> > > I wasn't able to use smatch to reproduce the error with the following:
> > > 
> > > 	make O=builds/smatch CHECK="~/dev/smatch/smatch -p=kernel" C=1 Image.gz
> > > 
> > > Would you have any pointer for that?
> > 
> > This requires building the cross function Database:
> > 
> > 	~/dev/smatch/smatch_scripts/build_kernel_data.sh
> > 
> > The command takes 5 hours to run so here is a short cut which just
> > builds the minimum two files:
> > 
> > ~/dev/smatch/smatch_scripts/kchecker --info drivers/regulator/core.c | tee out
> > ~/dev/smatch/smatch_data/db/create_db.sh -p=kernel out
> > ~/dev/smatch/smatch_scripts/kchecker --info drivers/regulator/devres.c | tee out
> > ~/dev/smatch/smatch_data/db/reload_partial.sh out
> > ~/dev/smatch/smatch_scripts/kchecker --spammy drivers/iio/adc/ad7949.c
> 
> Thanks, I appreciate the shortcuts! I was able to reproduce the error
> with these steps.
> 
> > > Anyway, I believe the following would address the error you mentioned.
> > > 
> > > -- >8 --
> > > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > > index 44bb5fde83de..3613f4e55e1c 100644
> > > --- a/drivers/iio/adc/ad7949.c
> > > +++ b/drivers/iio/adc/ad7949.c
> > > @@ -368,12 +368,14 @@ static int ad7949_spi_probe(struct spi_device *spi)
> > >  	ad7949_adc->vref = devm_regulator_get_optional(dev, "vrefin");
> > >  	if (IS_ERR(ad7949_adc->vref)) {
> > >  		ret = PTR_ERR(ad7949_adc->vref);
> > > +		ad7949_adc->vref = NULL;
> > 
> > This is not required because it will just be reassigned in a couple
> > lines.
> 
> Right, sorry about that.
> 
> > >  		if (ret != -ENODEV)
> > >  			return ret;
> > >  		/* unbuffered? */
> > >  		ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
> > >  		if (IS_ERR(ad7949_adc->vref)) {
> > >  			ret = PTR_ERR(ad7949_adc->vref);
> > > +			ad7949_adc->vref = NULL;
> > 
> > But this also won't work.  Passing a NULL to regulator_enable() will
> > cause an Oops.  All the reference to ->vref need checks.  :/
> 
> I believe it still work since these conditions around
> devm_regulator_get_optional() also set ad7949_adc->refsel.
> 
> ad7949_adc->refsel is then checked before calling regulator_enable() and
> regulator_get_voltage().
> 
> Even without the patch, I don't think we can call regulor_enable()
> without having it be defined. Am I missing something else?

Actually, you're right.  This warning is a 100% false positive.  Smatch
doesn't handle bit wise tests very well.  I've been meaning to write
that code but I haven't done it yet.  When I do the false positive will
go away.

Sorry for the noise on this.

regards,
dan carpenter

