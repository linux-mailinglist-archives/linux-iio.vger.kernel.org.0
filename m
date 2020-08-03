Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B660123A8C1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 16:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHCOoD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 10:44:03 -0400
Received: from mail-eopbgr00138.outbound.protection.outlook.com ([40.107.0.138]:25063
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbgHCOoC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Aug 2020 10:44:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfZLezCpJ72rdJ6Q/Lnj/ZBZbYvzSm9L6wETqMFeTpGHs/Y+dquAsidcWDOb68Ze43moH1pIRw6ciljZjLPVt71z24j4VlYnh/wGhoU25G2N0K8+3+HnfTt0QW8t2RfcgaZJcBNkGN5/UtBtzDmEMoZzAfPsFrGrIgC/FKru2HHJo4hWaH6HK3jqHYSgR9w5rW3NSwnBHJ6uoFHJCT9/RL2pBtSSnyODPBYRSrtI75Vcj4kvmh3XMEY8qsQioGCI0x5RZpmDacHb+5hFiF7TYo8Fav4/iR/IoxF/lnDCQygndO/sRze9xPpooVWAhym8rAIbvIecmw7LI3MDLNYP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS1/lXrtraUnzUH4JUka6EI5pZS1P97TiVhXYSm6ksk=;
 b=HXsikR8qCK8P3zIw24vTs9CYwl2DkNdEBEq7pPRsz/02gWetmaka+st8wr+3ht8dPVaop6gcgmkdqipO4yEUyYydspNRfZsWrvaDdI6LZgX2+Ebla4chNPAjiM1xklmkr9vF0RzVYbxZKlEMIW8aEtX9POWzA2CwUHzBxByFtEsIqA+GMgexq6o5y1XpnH1ADY3LFtqjgdU0h1vmvzbEvwptJpVUNa0qpe8Rsg782Of0d4knLRNjCiuxBuSb9kAy9l2ztpiurx5nIL9DUltctJjwcVUwlGYa7Nq8sSG/26Z3UPbJBuRz0diQC+jw3m32+nO7ie8BIAgdvfeAScfmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS1/lXrtraUnzUH4JUka6EI5pZS1P97TiVhXYSm6ksk=;
 b=XOyNBdm5KSebA3MR3KiYsalSTcF87nbR7O5BjH+zX/pZt+Bej0Fy8G0fpVTimteP0Rm+49SaocyLtoZGF3V2ksJKEFVkvLjc3ed0N4rFIxpvxRA5h0yBz/FB33gsHynJMJeQtDcCf2/75ShA3CIaJ/bzTMunslowfl5J+vwJ4pw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR0602MB3397.eurprd06.prod.outlook.com (2603:10a6:209:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 14:43:59 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::3c50:d581:638e:fe8d]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::3c50:d581:638e:fe8d%6]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 14:43:59 +0000
References: <86d053d1re.fsf@norphonic.com> <CAHp75VfgFN9YBHo9T8fgswUCnhdb3L5nGEi3_yONvZp5_vduUw@mail.gmail.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Eugene Zaikonnikov <ez@norphonic.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, development@norphonic.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] iio: humidity: Add TI HDC20x0 support
In-reply-to: <CAHp75VfgFN9YBHo9T8fgswUCnhdb3L5nGEi3_yONvZp5_vduUw@mail.gmail.com>
Date:   Mon, 03 Aug 2020 16:43:57 +0200
Message-ID: <867dufdc2a.fsf@norphonic.com>
Content-Type: text/plain
X-ClientProxiedBy: OL1P279CA0062.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:15::13) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sta-eugenez.norphonic.com (62.97.226.122) by OL1P279CA0062.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Mon, 3 Aug 2020 14:43:58 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3657e1e4-8652-4de3-d668-08d837bba814
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0602MB33971EA8402801ACF3B22FB5CA4D0@AM6PR0602MB3397.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcsyAEOm60bkXE4B+EAsqmjl0dJzNYHm37vvXy8g2uS5E5iC79qjgjbmzZDaL4avEI8RiRUJ+Dc/V8A1nKQPnM3pLCkAnNFHXkMZEotitpA3+0flCw8qNI/90JPXF3x486BtLFuWc2wfW9Z1wTcpm4ALOM7DI+qhhuwcZlZhVLxu8bm7CX4guqo43d1lP4TVva7kYQUxQQKUO2cRmgXHS0N8UI6DbN33uLH671mdnswGMmFu2YLtiZHPBYkD7Zg1iS4Ej37SbsDuKSfSTXYep9EncG8cZA2gb/5Wt0hIUCpub2/VRne7KfJ1586Wd21Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(39830400003)(346002)(366004)(376002)(83380400001)(7696005)(66946007)(66556008)(4326008)(66476007)(316002)(16526019)(186003)(6916009)(26005)(53546011)(6486002)(36756003)(2906002)(52116002)(508600001)(5660300002)(86362001)(8936002)(4744005)(54906003)(2616005)(956004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dzUzKq7lkcSPm9yHFV51Cy6CEfZBWHHoQH9cEwdfs0n81OdkS8Vm/Kqhe0a6JY2QC9fO5JTeCu0Cj9NDqoOROZINqZPlLDPAuf07siFSbpdRNGyav6LUIocCdDPrD1CAPrSWNfCfbTydlYhu8EjhjlE2sN4H4zknfVsq7n4NX6csPyEZhOVGvVbdP5keywlyjara/bcd7zjMJ4E+/a4vDeCKx/PwASjGS2CZaFTEn7KvJndY36AK9OYQH8RULVPORYYMY9ZTkb0Nz5FfvrmzFVOvI9K+DA2frWDcY5sdYs5V5byN9YFSbojU6rP+3nkIyKiSjXBMZCEsJVqEUqxhrhxAZPSEmPAx8ulSS/rQaGZ27+DC7M4NZS5MmlD6GqmZSIOL6Ft4M2z3yfjeSPip6IE2elD4XVF4etv1KZjuAgdEU+Md4F4uaNdYHLwjIid6nxY9H3z4iizrwQfKjEC//aKuCGoPPJ7awzjGR3jZhIOpj8kEZOlQ+4hWo78R2RNVjB4sJuDBd74/YGHiI8h54PznFb41vfG3QaI9AHi6G82RA0UuIgVf7fU58/97FRstPPnBoVnpEM6S1shPWv5WS+cnpgSJC7HI+D6M67tc1rxtJqHTyH6vF6votB0YWvQ70CbEUWeFh9Y49zW9/XzfJQ==
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3657e1e4-8652-4de3-d668-08d837bba814
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB5430.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 14:43:59.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70qeDtzvSw9jEwcf8Ev/NlQNgiTv1IIRzaTYBmnLU+ORE3jHpre5QAnXraRB82Uhcq2CYbO5eSEaXnlPsdX1xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3397
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Andy,

Thanks for the comments, going to fix the style/indentation as
suggested.

Sorry for the attachments, it was an accident.

> On Fri, Jul 10, 2020 at 2:54 PM Eugene Zaikonnikov <ez@norphonic.com> wrote:

[...]

> 8. It's one line
> ret = i2c_smbus_write_byte_data(client,
>     HDC2010_REG_MEASUREMENT_CONF, tmp);
>
> Ditto:
> dev_warn(&client->dev, "Unable to restore default AMM\n");
>
Must be misunderstanding something, as neither of these fits 80 column
fill if made into one line. Found also couple other places I need in
fact to wrap down to 80.

--
Regards,

  Eugene Zaikonnikov

  Norphonic AS
  Tel: +47 98 23 97 73
