Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD423B8B1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHDKYD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 06:24:03 -0400
Received: from mail-am6eur05on2118.outbound.protection.outlook.com ([40.107.22.118]:11136
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbgHDKYC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Aug 2020 06:24:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgciYfxZwynAsDlb5LHUFiJe+spP2PRr7GPCKGWzdsNNHgGz/mg0BqCG89KuY4Vvg8xs1+YBv8sRFn0GH3G+cY5BzdcXEML7OulLA1knH8B5sARN3Puvu8Zvqo2vdM++ouWBFo5Vyp7lkGJAF48tg56Q6znf/UEb26QgjdZE8eXGAe1L/eUDqrNTdLny8JSjV7zyxbIYJjQ2Jw7BYp3MJHIsH+B2mmmklD5H9nap36Y65zUytd6gJs+t6nFEFlcq9YI7IV/TfKuZN3LWgbptzgvWSyCuPdckQXqmB6BaFThswTpNpQyauPbKPZhzYPV1I2nPKVxDqi1Pi3myywWkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fEEi4lA9VECFAOa9BY8c27/4Y9RXDR/VpQWksNp+ic=;
 b=JEKSpUOzM7Obui3arogiTl0kqyZHDDBepU+B8DYEix3HX/sr/bzQVmfLNeDCZnKt7hapfZWOiqkAYTZBTa6bCmMd7M58hIX7VkCTBWKBY6zBtHkm/KLxb7cZjv/2TJTU2L3+3gbvv4b7+Mse8Nvt37e0gaAjOS8CTH3B15YWwM5WtKYpBv1Q6U9DNnaZhvKCNvV0tIuV39MBoBeeN5Kw6tjrKfyyBzEGW0vLvnMNpHh6ZUnVw+/OC7x7eTb60wr85HxpVm5RqDnRkZ4mUE+m+I9KlqqbWS1NlrHSShjQTFRBepHxbuUXfKVtshyF7XSI+MJENMMHpEQmYawLrh5OVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fEEi4lA9VECFAOa9BY8c27/4Y9RXDR/VpQWksNp+ic=;
 b=ayqn6p6oXQdayqtgaC6qHkKHXwrf72SZETQPrJlWLjbxJJ3mY5Ylg3pAMlxeAWtcgORZqkUvU3OOrPAHB9ff/cXSukx40Ebd7INv6i6Gdt1OBWCCm9mtwz5YCj5R1/bqk6AY5tKaSNpYuTibck5DG63uLGPrId3jVocQVVZZBv8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB4787.eurprd06.prod.outlook.com (2603:10a6:20b:5d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 10:23:59 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::3c50:d581:638e:fe8d]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::3c50:d581:638e:fe8d%6]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 10:23:59 +0000
References: <86d053d1re.fsf@norphonic.com> <CAHp75VfgFN9YBHo9T8fgswUCnhdb3L5nGEi3_yONvZp5_vduUw@mail.gmail.com> <20200712115444.49dc18c6@archlinux>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Eugene Zaikonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        development@norphonic.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] iio: humidity: Add TI HDC20x0 support
In-reply-to: <20200712115444.49dc18c6@archlinux>
Date:   Tue, 04 Aug 2020 12:23:56 +0200
Message-ID: <86zh7ak8ub.fsf@norphonic.com>
Content-Type: text/plain
X-ClientProxiedBy: OL1P279CA0070.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:15::21) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sta-eugenez.norphonic.com (62.97.226.122) by OL1P279CA0070.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Tue, 4 Aug 2020 10:23:58 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00a9fb8c-8801-49e4-348c-08d838608047
X-MS-TrafficTypeDiagnostic: AM6PR06MB4787:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB47878EA7EC55B8B88E9036C2CA4A0@AM6PR06MB4787.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxjoHgym/hcAlqPdvyWFPlNsBaTwxtsqmtIYryjBoOAt+Bs8Itrel0oSSAvi6a0hWjC4JxPLmarPDd8gJD5hHmFNNO5y/m8OFFSeYQSM6BVK10ilLgLJwD/jpDkMsmY98DjkhXNWCB4lZ0qGfla9E7TyYAh8qpeBvnz4dSM8zXPPAuMuutjamxlE/D9pPWurOTX9hGTkJySouINvF4kt2M+NRbgDv2HjArY3WnOP0jqBpBuxNH1+t2AY3/6KlCZy3Kj4Prt6kYqK64/exAueSJBLl21E7J9w0itLMwN73flxdYV1FbSqsg41P8ZGGTwT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(39830400003)(366004)(8676002)(6486002)(8936002)(956004)(26005)(4744005)(2616005)(2906002)(186003)(66556008)(16526019)(66476007)(4326008)(66946007)(54906003)(508600001)(5660300002)(6916009)(52116002)(316002)(7696005)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: SmIGjzehkOa4VqJm1hRA9+C5EuYGZqga6KaHJ8Du3vZcbtaiRIr7Gvs/3QaEnLJmr2bykZi2sTKKDZobbI3HcakfOaFwK7M1u/SuoWVpCoVBjl3ddphMWooBuscb7fGyqoubhzuiBPQHdAVVRQNjtWecsxlbsuzzI9zvmIdkDz5PTDwHG79JAP7FV7ZcldQSxOUB5JAMdaPXJM1OnjNKJ327zGipPKJJ8WtcFivWSQJIT2NzibU/jUDTRFMieGiOnqrFkjSkJywiiqW5JgTaDChNqsIsD6G/TmV7s+z0D01fUBAcd66jveo1xNUz20vJDavC9UMguBcM6CBrcUCm/bmH0y1kTLSmEYAZEVV74U2eXUn3eIyfSqR8xKmcONF6I4QfThMDWDz5VETRW7UIzkBb33DKcF8F7VcZ19Wddb7E7jKm6IJYZFoGnnWPqb7BHXbPTPXC1OUc6FdM4qMfQVHsrB8Taq1lkGPQw/QHKtLSqGL2NFoQGL+k6pxlY/MraWIroRjWDR41oYKwe3HOh/ymEg30oMvNtw9Zmp/rGMEoR/CX2JqgK9B9dvES5RYrw3IKGF7O+n2ARh4eIXm0bNFqb71vv+yjk1vP0XlcnWl2WZ4bMoINIPzalK1XNSj3AnwDK+LF7JVLpRIn1FV+Xw==
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a9fb8c-8801-49e4-348c-08d838608047
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB5430.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 10:23:59.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csFBVOuSkJGMwWbtCPG0t31L0YGx8X6S+9HfaShUcYOp2LPX9D497eMuyDv1Awe5vwDuQGze+kPCRwQasnUmIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4787
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Jonathan Cameron <jic23@kernel.org> writes:

> On Sat, 11 Jul 2020 18:27:09 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>

[...]

>> 4. IIO_CONST_ATTR can be one line, but hey don't we have IIO core to
>> take care of it?
>
> For that one, we could indeed use the read_avail callback here
> for the out_current_heater_raw_available. I've not yet started insisting
> on this because of the huge number of drivers that predate introduction of
> that stuff to the core and as a result a lack of good examples.
> Eugene, if you are happy to change this one over to that and hence act
> as an example it would be great!
>
Just looked into that.

We use this driver here with trees as early as 4.9.11, and it does not
appear to have this callback in iio_info yet. Hope it's OK as it is in
this iteration.

--
Regards,

  Eugene Zaikonnikov

  Norphonic AS
  Tel: +47 98 23 97 73
