Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB8014B387
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 12:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgA1Lb5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 06:31:57 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:45780 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbgA1Lb5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jan 2020 06:31:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 12EAA464EF;
        Tue, 28 Jan 2020 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:date:date:from:from:subject:subject
        :message-id:received:received:received; s=mta-01; t=1580211114;
         x=1582025515; bh=kNtMjE3vC+0DYD+Pb2uxNur78VcVYMeHBP9LyJFGWtY=; b=
        GWW/ZSowr85oRGGu5NAd5kJcBGlS7UCxS4qYcqHFenUEpq9vMpDzDbi4ijEwda8H
        +sGUJRiFAy+5aOr8coAfr63B9Tha0kC21LsJmzJN6FBBWfHQZ7qXrjY5hrWNy6RF
        586fnTDLZBoM0Tma8p83yojR3PFXUcxGfCbOfSEAX08=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t4NL9A0vtwcY; Tue, 28 Jan 2020 14:31:54 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id C0B2F464E4;
        Tue, 28 Jan 2020 14:31:53 +0300 (MSK)
Received: from localhost.localdomain (172.17.15.69) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 28 Jan 2020 14:31:53 +0300
Message-ID: <cb21d1285e04a8a7a3817398629431f69aeebf2f.camel@yadro.com>
Subject: vcnl3020 hwmon/proximity driver
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date:   Tue, 28 Jan 2020 14:31:49 +0300
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.17.15.69]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello, I want to make driver for vcnl3020 but not sure where should I put it.
It's similar to vcnl40xx series which is already in iio/light/vcnl4000.c
but it perfectly fits with hwmon intrusion detection concept
(intrusion[0-*]_alarm), so I'm a little bit confused.

vcnl3020 - proximity sensor which mostly using for intrusion detection
vcnl4020 - light and proximity sensor

Doc's links:
https://www.vishay.com/docs/84150/vcnl3020.pdf
https://www.vishay.com/docs/83476/vcnl4020.pdf

That's what I think about possible ways:

1. just iio/proximity/vcnl3020.c
2. extend functionality inside vcnl4000.c with ifdefs and dts stuff and maybe
   rename it with generalization inside
3. hwmon driver for intrusion detection inside drivers/hwmon
4. both iio/proximity/vcnl3020.c and hwmon/vcnl3020.c
   Example: hwmon/wm8350-hwmon.c + mfd/wm8350-core.c
   So, just make proximity driver, do the depend in Kconfig for hwmon driver
   on proximity driver and use proximity driver calls if would be needed.

Maybe there any other good ways to deal with it? I'd be prefer 4.

Thanks.

