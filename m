Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9523E7F5
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHGH27 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 03:28:59 -0400
Received: from mail-eopbgr70095.outbound.protection.outlook.com ([40.107.7.95]:38290
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbgHGH26 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Aug 2020 03:28:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7bVLKB5ZHtpkb0PDdvC3sDDE5oFRAcQfDNlKcjYp/qsRKwoZSfsbTC4y/0ZsEjzwe2qB7gq7aFnyFkPQ/tT28CX+bx41VvC7jo0xI+/33E+F0bjOqQIo45NyUMS6ZEhXkVtV8JU3lSkErhy8VMiTXE/H2+DsUzd002tv39yzHavXlgdABp9JygAKcgnkJicuPbYiJBvK7WnFijqFaCwfbE9KKPUh+LXakVAfNIK4JUlij3h4RkbWnDcrAz8kiZfce95y3j+IyXl4G0jPcwIfn3eFs5bbdG8mrnGyZh/yrl6JdPqCQwlpaf/saPMcSul7ONc0ubGBOVVmxeB3yo6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x1KtIfYfQ5fRXzz4pIyn/9U5565+MMJ2G9TZazGB9Q=;
 b=SvWcETb/G9QyVbOZoAGw0EV30BFuKHTInu0a+swoeDKD6rJiU/zrbrGY4prnuo1jkosPvfMR5Q1heoKYIjhBkpcxpjpCbq0u3rqYJvWesi7TmZqDah2GGMNTb0lU/CrvPsu+f4BqyZTwHOTnY/8Q2EquSfmPg6zTkmPZ947CO9MDvahv2jIiYC7RoGNcBqZY6TZy0OdY9zkFlhxjA3R08eCZBkEM2NN0thulSU9KF72qacDXF2h7SjLY0QCT7YN1Q3ewB2Uq2FwCE+1KRz30rfMmbJnz01nH7W+wgSFYSV3Rp+yCepzqKMRnUJpFMPBsG3OQnodKu15ekOG1CXYOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x1KtIfYfQ5fRXzz4pIyn/9U5565+MMJ2G9TZazGB9Q=;
 b=iX+QYr/XKCOIpuJtauqnU9e+GhcdzU24/Pk0g4WP21t6vzeETAuwBuMnFRs3QegLLaa7bIOV3utwuWlDPQN3KC6LWKM/9oepZA3dKqeM+YdlFi7qP9eON9nYiJ8MoUezLKsKeunTj3Eza+IHr7+c3nUGpJ99RjBxt0sTu6F2uTM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM5PR06MB3121.eurprd06.prod.outlook.com (2603:10a6:206:8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 07:28:54 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::3c50:d581:638e:fe8d]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::3c50:d581:638e:fe8d%6]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 07:28:54 +0000
References: <86d053d1re.fsf@norphonic.com> <CAHp75VfgFN9YBHo9T8fgswUCnhdb3L5nGEi3_yONvZp5_vduUw@mail.gmail.com> <20200712115444.49dc18c6@archlinux> <86zh7ak8ub.fsf@norphonic.com> <20200806194626.6e7b2545@archlinux>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Eugene Zaikonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        development@norphonic.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] iio: humidity: Add TI HDC20x0 support
In-reply-to: <20200806194626.6e7b2545@archlinux>
Date:   Fri, 07 Aug 2020 09:28:52 +0200
Message-ID: <86lfiq3oej.fsf@norphonic.com>
Content-Type: text/plain
X-ClientProxiedBy: SV0P279CA0052.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:f10:13::21) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sta-eugenez.norphonic.com (62.97.226.122) by SV0P279CA0052.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Fri, 7 Aug 2020 07:28:54 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48e308cf-6666-4c67-9968-08d83aa38a1e
X-MS-TrafficTypeDiagnostic: AM5PR06MB3121:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR06MB3121BD998645FA1ABDC5E5E9CA490@AM5PR06MB3121.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGPhaFTldw5BLuUQVxNyrJK62yGzZco3Pze7onh/LeFhapksE9TPFOTZIjMnX7+LWQz/El2nyHwX2QGIyBJMemJne/uw9gdpmyA5mRQcriL/fI0piXWKoa7y3Qfwgt6hYdg4rDwMIJ9eRP7r1jza5aGQyX1deVvB7Cq6w+eyZrU5HTKwkjMp77KEHFOHAh5p5ecK1wRa4FyBMiPxYd8It5iD8R4D/BgmYnbt/spTxH/UxDi2df74TzPoFROdfMH9ElhBLv8LCK3Y1iG9YocIcpIFLN4cnMqo3yPDWwmrCLta6vZmRAevJTmHxwtluj/w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39830400003)(346002)(396003)(376002)(2616005)(956004)(54906003)(316002)(6486002)(2906002)(8936002)(52116002)(7696005)(8676002)(6916009)(36756003)(86362001)(26005)(508600001)(5660300002)(4326008)(16526019)(186003)(66476007)(66946007)(66556008)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: eTslkxrK7+MH7oCCj1ugnCvnaF6HSK7l19NX7lbKzzRqi3B3o/KmqFhN6lZMwtzEryfwtp4nyEztzfFwkaJRG0HTbsNI5vvlc81PPWtSSsdQXGXupQNY6fTneSG2rftAwvukPldnWkf1giuLn03GlF6kympHfiOGBrajyPXkvxEPdAD19zaLH1+6EPndbQk+bvfOy8rt7paHzT4KDEVYPQRnmouSWTHUP/puPzIPoRzHk7ZeKfrDTxg3KPuCXUFFMi1qS4XbGo14edEMmJoZ4w8YDMJHY6oz1OklUtan0TGn/22vNEzAuSamS7ttqT/aUbD7j36EJMj4fcyfG48hb5Cscc5agBBkFrApQWk55U54vkIL2p2kL1i3tkH7vjPjw6SXe5JrAbBFqh/TXbcbzoR20TW3y7oc+QdFjh3dClXUhJPSiswmP+W8wZ3OAecqEpxB3lUF5DmFyvHTN0IGchmCcY2tTG4zYvxBEUXJaKXZU0CIOhqEQxO9wm7OcycAS8o5HHDUl1+GqSlYPuqpgghAMRf268h46TnvoXUzQdbqSiRjPghqhBLDEDXWS797jvH3uK1vWEG2afBan5pxCcFch6eFd5jDkLe28JKVJOyDxFl7V4/Qs1wY5NOgtlgi6bI/y+MXef2qY+SFDu832A==
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e308cf-6666-4c67-9968-08d83aa38a1e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB5430.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 07:28:54.6345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmctb9v/X6MlhEmIJFI66CE6bewcEqPWPFNpB6kF0ZJHhv8r9hnqaFxbdihQDyfMjDhoFMKmQPhiNdLUd1GUWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR06MB3121
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Jonathan Cameron <jic23@kernel.org> writes:

> On Tue, 04 Aug 2020 12:23:56 +0200
> Eugene Zaikonnikov <ez@norphonic.com> wrote:

[...]

>> We use this driver here with trees as early as 4.9.11, and it does not
>> appear to have this callback in iio_info yet. Hope it's OK as it is in
>> this iteration.
> OK.   It is more than possible that someone will post patches tidying
> that up though and I'm not going to reject them to make life easier
> for your older trees.  For now, put a note in the commit log though
> so I don't forget it.
>
That's reasonable. We didn't plan to sit on 4.9.x for so long and we'll
eventually move to newer trees on all products here too. I may as well
tidy this part up myself later in the year, along with fuller support
for device features.

--
Regards,

  Eugene Zaikonnikov

  Norphonic AS
  Tel: +47 98 23 97 73
