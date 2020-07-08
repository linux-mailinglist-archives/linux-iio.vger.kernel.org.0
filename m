Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43FF2182EE
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jul 2020 10:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGHI5l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jul 2020 04:57:41 -0400
Received: from mail-eopbgr150129.outbound.protection.outlook.com ([40.107.15.129]:41188
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728382AbgGHI5l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Jul 2020 04:57:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BygA0d/nnFTvQL9JtNz7tYICEG+eVRgJ6vpl6m76EYtGs7mAYkNnUD6iCJAv2ARQLsfSc+K4V1POJ9csIx/rAdn2eR0Bgqd24zYr3M3jS8Ig2mndWAvds05iv5Ppec52qUZqcPhQlp9KkfN7Iln0LVBXhOZi3s1OSZs3SFCQoznfV9q3y06mMZfHjMCnELwBv8pvgYhT+q2QW3VROIhICtv2y+2V8jXpN+kH/fLbThcdSmdc0MaQKWXuLnnI0UhN1TgRKgOWmggGwfPZhRcJ4GNmL9563RRf59UsgrhJD669uBPL7uJwGITCAqMfl2t6YdM6+pd57Xk/Kd7AeUM9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=671DwwJuuP05FT7p+A+S3RXswVT0jFi1Aa1eQzYCJrA=;
 b=mnIsrqdgB8oZbfVbNDOEyjJc2aL7gVNWb9QRmOGXAeWspoBXawspmM57a9+4EkHUNXqGj01IO4oLTjo4Pvf2MsxObh/GmjUktRze2gE6wxPo0f8eUtZ48ssg0Q1bDEC9kJlgkFM3EMo7TIMfq+ilTQjEEmDmDJ9dMmF1ZCdEDrXURh0xGEVws1XVPnhu4wtrVOaiFDVU0Y/F0LpODd79ry4ymRsTxAJv0U8L2KRwNTwbgWkmHWt2ejoJ+QVUn6NqyNn6yJ2AoBre3ZcvQbuipPeuI1Y/EzUHIZ1Yst+QzZfxxNyheFbu9xTllVbE20zJkwqpX5muWClf84SfVDNpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=671DwwJuuP05FT7p+A+S3RXswVT0jFi1Aa1eQzYCJrA=;
 b=Po6HAAmB1cCj8exb4nSlHr61bwJB5/Q8jhxs2HcIF1tFK5VX4Rwzklxlooy97BDmviduThezoqhB7lDCAYydq+dR18DBJZ7HBDIr5zXNJW4eE+tiYIQ4pIAC+1rDPjHiLbjQrua8zBT1jF8eBEo+nG8c4O9lZ9zGudKtaLyvJXM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB4786.eurprd06.prod.outlook.com (2603:10a6:20b:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 8 Jul
 2020 08:57:37 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::98d7:2b02:1f27:e8e0]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::98d7:2b02:1f27:e8e0%4]) with mapi id 15.20.3174.022; Wed, 8 Jul 2020
 08:57:37 +0000
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Eugene Zaikonnikov <ez@norphonic.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-iio\@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] Device tree bindings for TI HDC20x0 humidity and temperature sensors
In-reply-to: <3309CDF6-5DED-44E4-972B-6D741ABE541E@norphonic.com>
Date:   Wed, 08 Jul 2020 10:57:34 +0200
Message-ID: <86sge2crk1.fsf@norphonic.com>
Content-Type: text/plain
X-ClientProxiedBy: OL1P279CA0056.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:15::7) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sta-eugenez.norphonic.com (62.97.226.122) by OL1P279CA0056.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 08:57:37 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f069fa9f-b1a0-4c92-6945-08d8231cf66a
X-MS-TrafficTypeDiagnostic: AM6PR06MB4786:
X-Microsoft-Antispam-PRVS: <AM6PR06MB4786377230BCF039A1198DEDCA670@AM6PR06MB4786.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AN/sRTu92bhF3QhRZFNoG9TjVk+tfH0bhvfQiORYv7hXMu9l+mSB8ObSUR0JDeFpld6GgAu3nCjEpIyjaZ3U4Vrop97ej7gPoTFFi93KNZkFhwPlT6nZaRlidasHZQW5xtpM7Y3wyQJwuVf2bwF/eP2WsxMrz/1i3NVQXwYsznJGhNUM5XU5obts3EDjWYNsdZnzM5r0NhEUrSMokIZDF8YvlbPAYc5miDNTpAUyUYOV7RfiOeXQtUllSw2FoB/yzZ9qRStVVV2LXUfwe1GGTlLwsXiqvBq1wisJ/DNDvAOEBe4AztscipyYCeiEw6XG83PI2BV6s/QijeB4RAsZuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(136003)(366004)(396003)(346002)(376002)(8936002)(186003)(52116002)(66946007)(7696005)(66556008)(508600001)(66476007)(4326008)(26005)(86362001)(2616005)(956004)(6486002)(316002)(16526019)(4744005)(54906003)(5660300002)(2906002)(6666004)(8676002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 40goUS8GmLrGgjhxrb8jF5vw5NO9tFVtsko+QS6PrgZQ8snJRXURjj6LjhPclCN11ob9J6UVLO75KSFW+7wYAwNhYUSLGnjWC3s99jXgVZVlYXonu0JfX6QMWZ3+S3wfpJukEY2Eh8dMFZoqRxuYNry6iT4qhLuXzeEsWnnjEmL5zy/mC+5ncU56ftJQWYuZ3o0xax7weurs/vqr53qrVbY/G6R2l3rrPRlB4rS70IJ81gXISum+9KFSqLCpgiAj1PcRC1aJ/S2ncErjiv7K6W1yGhBEZyGqkrGkmG2zDd7fodvMSSjhL0HRyRnCmWZ7WfRl3vDWo2QG3XjTsglJlDRxC9YW4ThbkhRwadAiOTbMOqHUcxsnEWipMVipmlg1TJ0phIP5GG+KAYDFyEx6n+CyJROfgBcDiF/MDN8H4q7AoaIQ1ygu/mMzGPP9NJMof7iAksCBp1nHkwKpCLnbBWMmHwNN/yLJHABr2g8dtBE=
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f069fa9f-b1a0-4c92-6945-08d8231cf66a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB5430.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 08:57:37.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjyOAt1Svth23rBPDFjmr/J6rbsqIfMMVjVwdhKpOJk0Sde9f8PeAYJUMqa6xcfC/dEr+q9ESmWv++2K9Twc3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4786
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> On Tue, 26 May 2020 at 12:35:08 -0600, Rob Herring wrote:

[...]

>
> Run 'git log --oneline <path>' and follow convention for $subject lines. 
> (Hint: dt-bindings: iio: ...)

The driver is outside source control in this tree, hope it's OK.

Fixing the rest.

-- 
Regards,

  Eugene Zaikonnikov

  Norphonic AS
  Tel: +47 98 23 97 73
