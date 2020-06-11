Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91781F6880
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jun 2020 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgFKNCL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Jun 2020 09:02:11 -0400
Received: from mail-eopbgr50091.outbound.protection.outlook.com ([40.107.5.91]:50067
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbgFKNCK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 11 Jun 2020 09:02:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVdhFQo0HtlWf/+Qd33TfsWkAI/8nvFuOW/m/OcPe0JRDdngFSgVGmN11+lSJPR69dEAF5rB9XopNOdWf3fDyQfX0WlH5Biyp4/esfmTVlku/2sZ6dOz6aCMnFsP/GlMLBzdrt8JRAfpVkmUf/KLTJFhCWu6XC1yFDUdsK5+8Tgvwgyc55AWLNbBIQXNR5wLK8MLrA2cae7iH5018T0/JwH7ISbq+qjHPxpP/9TM8kWhUh5CitgiPzIs7d3sOKX4Ey2V7O1/9z79E6+n3E6+dZPwTz44vTyah0wV7RSa+OQSdUdyq0FwQSmzW2VGzD7Zq12tGYdZOlq9WsYJsfrzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS/7w1C+TtrG/YkV0K7V2LNy595h6ISqeLoLNWXwQrI=;
 b=EqsUfT8b1UFhqE1FIwNzyJGQ48LXssv1qwXZYbcjWP0L6VzlmqnhiwXOHcp4dXatCNDikR0S8SMbxhj+XG2MlS8HeuuiNEb/39YH2e/5ss6pkJpmwimg7lRZU/1f0semK5XsQy3nEwhBjvqvL/FnPveOiqQ9qGasPik031NB1mX8pKekW8fgXVWZYf0acsSpHenCOe4C7zSzFn8n0lRjaGxwY/+vn3wkYGjIjh5QxpWar/RQ/AwHm6oQc9X4qKRgAYiNk/QqgsMrAFgaAxQXmH44zllNQUwWSu0b+lqGVIAFYQMDiJHvMl0/wsNBEvkZrARodZx6b3Yot/YOsql3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS/7w1C+TtrG/YkV0K7V2LNy595h6ISqeLoLNWXwQrI=;
 b=etOZX0dmpJxCAp2bCUu+yWguW8jIZ/Lx1RvIawWdDh778tcuzUoJEk81uRs1HQZ0H1xeLefBTw/RusDNx32A6Y/lVDmhLdAOLuSAE4PybvAQ8g3ts1w7PF0XKHdIyKyqjJF/04W+BTYdK0fmdHBvJGpvUWdI7HlviIKIwHFu9dI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB4264.eurprd06.prod.outlook.com (2603:10a6:20b:19::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 13:02:07 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::98d7:2b02:1f27:e8e0]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::98d7:2b02:1f27:e8e0%4]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 13:02:06 +0000
References: <5489E47F-47D4-421A-A7EA-E11B0205A842@norphonic.com> <20200519191103.00004489@Huawei.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Eugene Zaikonnikov <ez@norphonic.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development\@norphonic.com" <development@norphonic.com>,
        "linux-iio\@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] Driver for TI HDC20x0 humidity and temperature sensors
In-reply-to: <20200519191103.00004489@Huawei.com>
Date:   Thu, 11 Jun 2020 15:02:05 +0200
Message-ID: <863671oiwi.fsf@norphonic.com>
Content-Type: text/plain
X-ClientProxiedBy: OL1P279CA0004.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:12::9) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sta-eugenez.norphonic.com (62.97.226.122) by OL1P279CA0004.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22 via Frontend Transport; Thu, 11 Jun 2020 13:02:06 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 349d038e-fb78-4c2e-2094-08d80e07a4c0
X-MS-TrafficTypeDiagnostic: AM6PR06MB4264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB4264E10252E6DFDC13884F14CA800@AM6PR06MB4264.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftmBhnNMeqmatkOkKbC8tLLn/I+zvE05f+uEhkfuhsJxmP7/OuDIoNva6w65zEWnf5HPCebdERGlzPIbQMVXEe71cWp6Xgbj9+S9ypAjGhg0uCteZtiW3dehAsuJrUm+9j2hCpetOmZ8MEM1pqfru9W1mm4YdudEQsxL6RI/fMcIppRV3KUg3EJD/MqcdzQhjPMxyAS8M5qnKgqIo92HrNWanCrshXTOWKcrvkG/YYhS0p2NfJ/4KReo/YMR0qHThyYOHqAftEsyPe4jPmSOFgP+b5eevm16n/Md5VfVnqOpEPZAAhF3b3ygJGZtUET+pOYZkokqwmHMLITkhBt/pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(376002)(346002)(39830400003)(36756003)(5660300002)(956004)(316002)(8936002)(66556008)(66946007)(7696005)(66476007)(52116002)(54906003)(2906002)(6486002)(186003)(26005)(86362001)(6916009)(8676002)(508600001)(2616005)(16526019)(4744005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Jls7bPviPYSJe7dydFrJ+ZwNmiCUaaPtNNHoxwhyVabKJxZU4G1mnhYYSybEy1Sck6kwUyMWuzAegQlFtKPhIFIkPKufgbej7JiFgFldWTtoigDxOEZuWntaFt+WYIVNszj3FeaHMNFQeTvOHYGf6+g8D0wqrw3LTJdMcAINnFNYsxmZb7N0VvFXgk9zo8AF+qNXvnfRGqXuqbTQw63Bw7jnYBdZzpg5nhrUqC8I2ES//p1cBdX2WbrDqE0mhyHB8pkT8sJxcRYGR/LnCnd5zdMDfM2QAeCLIB/KLmSY7veFRrXAtgjhPjhIpIKr+w21BlkQkjTraSqhYh3rEgg7aO79Samkkz4Bh2W0RRPCl4RMZUmccDfV9JQF5d4WG3LhzV26qoFPw2ZVDL5xEnpGwKMgI0yn1s8fsgjgelnD3kcJBrLeGkw4wQrl+rLfjgc8kdK/d44BIAD6YrMCeaHxy4ABNjQvZMKVNyLgcSxLW4c=
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349d038e-fb78-4c2e-2094-08d80e07a4c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 13:02:06.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShMzAET8HyJry9ADhfSIfuSn33epQku40f1zWrodMEpZBekPHd3lymxbVMOMUZk9W2CKTff52P2MmVbtzan3Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4264
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Mon, 18 May 2020 19:15:27 +0000
> Eugene Zalkonnikov <ez@norphonic.com> wrote:
>
> Hi Eugene
>
>> HDC2010/2080 driver and sysfs documentation for its heater element.
>> 
>
> Would be nice to have a little more info on the device for anyone reading
> the log after we commit this.
>
Ok I'll expand the description.

> There is a potential double free in the remove path due to mix of
> devm_iio_device_register and iio_device_unregister.
>
Right, overlooked this. Will changine the unregister to the managed
version suffice?

> Also, the error paths in probe don't undo the various bits of setup
> that it feels like they should.  This might not matter in reality
> but the code will be more obviously correct if it is fine to reset
> the amm bit.
>
I'll add that.

-- 
Regards,

  Eugene Zaikonnikov

  Norphonic AS
  Tel: +47 98 23 97 73
