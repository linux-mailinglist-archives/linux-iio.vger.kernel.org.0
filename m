Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89CFE15CDE2
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2020 23:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBMWLU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Feb 2020 17:11:20 -0500
Received: from esa4.tennantco.iphmx.com ([68.232.154.87]:65066 "EHLO
        esa4.tennantco.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBMWLU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Feb 2020 17:11:20 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 17:11:19 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tennantco.com; i=@tennantco.com; q=dns/txt;
  s=selector1; t=1581631879; x=1613167879;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pqVksUXZFIO3CYO241ofxw7Twgb97QYczgi2FjRoxHM=;
  b=r+YVUvKfsaf5V1OZuA10LqXxa7hkTfU8eevxrVOk9bRgzT2Dvkjo2H4p
   TeJk9imXL9CiKlnFXT2+aQqtL0n3GV4deSRYGfeLw+9qLOMBFetdi8Shc
   Fwj01HYxuh4s/bgU1kxu08rSnJ3GqNdnox9GD8sKZutD0RFi74Q8UguHR
   vtD4vRMU1iOvX9RT9Fd5Ch6dUjgE78/VJfpGAcvqfxQ7X/TRCKq9X+yCb
   V0uf2PqnJnQ1IIzXm1kN01mh/15AIS4AE/1KCxl8ic6mSr6jEoUkm/lfF
   yT+P1JK1jtX6H4/BAD+eFrLs8vB6tVSP8KDw5LThf0Xp4oEhMGSLwxbw3
   A==;
IronPort-SDR: Rsntv9NddgtuY1MbSqB7HcRNeUOWYp0QEuekx+kdJynTx6wiGMTx5GQTPIuXhUfuL3sk95m4/F
 aaxxrEUabTjliNwA6aK9DjpNenZhJRxKdrOarxzJ3vJgNlRBlrwDDXF2hD5o8B5643REOPBi2M
 /+ud0CIJ1cgvFX+xSoVzXTxkIi+4IY+Lc2PqgG/zL3WQk/DGj88y7TaGF5cxs5rYvOJsY7D6rH
 EmVAA5hRFcAZECH2S7PnAp3kmDw9Jm4IqDwgATrxLbk6EPVtUCdlwHYyIhbsQIJsugDg29ScnX
 bMs=
IronPort-PHdr: =?us-ascii?q?9a23=3Aj22JfB0c2M37kx/ksmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWI/nxwZ3uMQTl6Ol3ixeRBMOHsq4C1bqd6v2/EUU7or+/81k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba59IRmsrAjctcYajZZiJ6sz1x?=
 =?us-ascii?q?DEvmZGd+NKyGxnIl6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaZYEAegcMuZCt4TzqVsAowWjCwevCuPg1iJHiX340qI10u?=
 =?us-ascii?q?QsCh3G0BA6Et4SrHjZttf4OaEPWu611qnIyjDDYutY1zb97IjHaBYhquyOU7?=
 =?us-ascii?q?J3f8ve10kuHB7Cg1ueqY3lOyma1uIXv2aZ6OphW/ygim48pgFtvDevwMEshZ?=
 =?us-ascii?q?PPhoIJ1l/E8j91z5oyJd29UUN2Z8OvHphItyyCKod6XswvT3tntSs40LELuZ?=
 =?us-ascii?q?y2cDIXxJklyBPTc+GLfoyL7x75SuqdPTh1iGhrdb+xnRq+71SsxvH6W8Kpyl?=
 =?us-ascii?q?hFtDBFncPJtn0V0hzT7dWIReVl80e63DaPyxjT6uZZIUAojabbK4Auwro3lp?=
 =?us-ascii?q?cLqUrOAij4lFjrgKOPeEsq/eml5/3gYrr9uJCQLYh0ihziMqs1ncy/HOI4PR?=
 =?us-ascii?q?UUU2iD4+S806Hj8lPlT7VWj/02la/ZvIrdJcQGuq65BwhV0oEg6xqlEzim19?=
 =?us-ascii?q?EYkWEGLFJDZh2Hk5DkN0zSLP33F/uyjFahnC1ryv3EJLHtH5fAI3fbnLfkZ7?=
 =?us-ascii?q?l96kpcyAQpzdBY4pJZEr8PIfL3WkDrstzUFB03Mwu6wun5CNRwzZ8eVnyJAq?=
 =?us-ascii?q?+fKqzSt0OI6f4oI+WWeIAVvzP9J+A/5/HylX85hUMdfa6x0JsVaXC3AupqLk?=
 =?us-ascii?q?uCbHrvnNgBC2EKsRQ6TODwj12CSzFTbW6oX60g/jE7FJ6mDYDbS4CuhryOxj?=
 =?us-ascii?q?20EYFVZmxcClCBCnjod4CLWvsWdS2dPNdrkiYYWri5V48hyRauuRf+y7V9NO?=
 =?us-ascii?q?rU4TYVtZf929hp/eLTmxYy9TtuA8uAzW6HV3t0kX8QRz8qwKB/plRwyk+G0a?=
 =?us-ascii?q?dmnfNYD9JS6uhRUgc/K5HT0fZ6Ct7oVgLHYNiJVE6sQs+6DjEpUtIx39gObl?=
 =?us-ascii?q?55G9WjiBDDwiWrD6YUl7yKA5w56bzc33fvKMZn0XrG17cuj0MgQsRRMW2qnK?=
 =?us-ascii?q?l/9xLcB92Br0LMtaGsfLgc1SiF326GwHCJugkMUg97C/7tXn0FYEbS69Pj6R?=
 =?us-ascii?q?WRYaWpDOELIw9Iz4aiLbRHe5W9oURCTfGlGNPBbnOZh2q2Ax+O2riLKoHtfj?=
 =?us-ascii?q?NOj23mFEEYnlVLrj69Pg8kC3Lk+jqGVmY8HE/zY07q7eh1oW+6SUlx1QyRck?=
 =?us-ascii?q?l9zOTlqAUNi6maTPUelvIftSEtpi88PW713smeSr/i7xFkYL0aZNo85Fld0m?=
 =?us-ascii?q?eMmx15N5rmD6d9i082bwlxuUroyx5wTI5HlJtioQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2HECwDTxkVe/645L2hmhBVQXoEIAwQ1CoQKg0cBAYU6h?=
 =?us-ascii?q?T2XBINsglIDVAkBAQEBAQEBAQEHAS0CBAEBAoQ+AjWCPDgTAgMBDAEBAQUBA?=
 =?us-ascii?q?QEBAQUCAQEBAQJphTcMgjspAXFxAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBBQKBDD4CAQMSER0BAREmAQ8LDgwCBSECAg8FHgsgNYVPA?=
 =?us-ascii?q?y4BoBABgSg+AiMBPwEBC4EFKYhhAQF0gTKCfwEBBYUbGFeBNQkJAYEEKowzg?=
 =?us-ascii?q?Uw/hCQ+h1sygiyYD5drB4I9fJVJKIJIjF6LcYsEmxGEAAIEAgQFAg4BAQWBa?=
 =?us-ascii?q?SOBWDMaI4M8UBgNkhCKciQxgQUkjGgBgQ8BAQ?=
X-IronPort-AV: E=Sophos;i="5.70,438,1574143200"; 
   d="scan'208";a="17199328"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.tennantco.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 16:04:11 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEEv6QSlcjOyUCA4vVL+aFegqRvzg2BWTkDDeUSbdb67W0ZgXOt8KXjZ3F4wnTShKwC142x27DfAGUkW2sodH9LjKCwZhlGOIQA51LWYEmiMSZduao9bjm0EVp7l1qH6zOd0pvQ5fuh0wP6JU+lc51Ev1P1JLBOgwcZfT/VEmjIVgY7rep5fCfCuj7QrpLrzVSgKNWyX41YAtOYgdNvWNL74Ah/us7OUPwPlv5a159hUhUfxyq1zqs2vBUN0aI/s3NgEoQ95tux+XMkCTDdUkxadMqve11Gx9AhW631/2OP1UTV5OIrqLMeT+KAOwayDuq+cfSfNpqryFHi/KfpVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqVksUXZFIO3CYO241ofxw7Twgb97QYczgi2FjRoxHM=;
 b=QUuPU4ujIhk0C0P0dmQkkcAlLDKDWL+eNhJAsitDZXjIBT82dAwGVH4X1tSaJbHjmjJJwNHApucnMEnz+mqVmojmiN1zh4Y0ZZs2IJZrUebUsn/yf1U7fgu7c+Z4AiBlhGLyQvUIisZVL+UpytplszEvFl9U2O7/QwxduUk05x673qQsdbbg0m6rbvHY08NgngA67L5r26BYlw0tULGZrRRc7yKGYlTKR0GAUrEoqauBATpaxZ0562jNfHDeXUx4aUp3dGep4MSd4YVf1O+3gOLP5a4up0JuIIryVLO3WAQjPa/ff6qutja7I0BgNq1pHuWc2zJVYbglWs77wscUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tennantco.com; dmarc=pass action=none
 header.from=tennantco.com; dkim=pass header.d=tennantco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tennantco.onmicrosoft.com; s=selector2-tennantco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqVksUXZFIO3CYO241ofxw7Twgb97QYczgi2FjRoxHM=;
 b=R1HiveHsNfbtT/mFNS6oOvmy09PJN15TRKosWYxAriILvGTrHyITDqIo0Bo7EdwzP3kOSCf0m8Jlh6ws1tU9LKRAWWlQLAlTg07+IKfLIGkldKkadyitvm8MtFI6UyoZRq7AdWQHMNbSucx6Vq82oPmXhxZljF+DWX0WhC94dNg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Dylan.Howey@tennantco.com; 
Received: from CH2PR20MB3271.namprd20.prod.outlook.com (10.255.156.30) by
 CH2PR20MB2934.namprd20.prod.outlook.com (10.255.156.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 22:04:10 +0000
Received: from CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::b12f:4e2a:2a0:51c1]) by CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::b12f:4e2a:2a0:51c1%7]) with mapi id 15.20.2729.025; Thu, 13 Feb 2020
 22:04:10 +0000
Date:   Thu, 13 Feb 2020 16:04:08 -0600
From:   Dylan Howey <Dylan.Howey@tennantco.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: Expose temperature channel
Message-ID: <20200213220407.GA11762@tennantco.com>
References: <20200205203240.13550-1-Dylan.Howey@tennantco.com>
 <20200208163154.4d4f6752@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200208163154.4d4f6752@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CH2PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:610:60::11) To CH2PR20MB3271.namprd20.prod.outlook.com
 (2603:10b6:610:2::30)
MIME-Version: 1.0
Received: from tennantco.com (198.204.33.200) by CH2PR14CA0001.namprd14.prod.outlook.com (2603:10b6:610:60::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 22:04:10 +0000
X-Originating-IP: [198.204.33.200]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fce24397-ff1d-4dbb-5697-08d7b0d0a76a
X-MS-TrafficTypeDiagnostic: CH2PR20MB2934:
X-Microsoft-Antispam-PRVS: <CH2PR20MB293410E03B67C3F31F409D25EF1A0@CH2PR20MB2934.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(39860400002)(346002)(199004)(189003)(956004)(26005)(186003)(2616005)(6916009)(16526019)(4326008)(2906002)(36756003)(1076003)(5660300002)(33656002)(8936002)(86362001)(8676002)(81166006)(81156014)(316002)(54906003)(4744005)(7696005)(52116002)(66556008)(55016002)(66946007)(66476007)(8886007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR20MB2934;H:CH2PR20MB3271.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: tennantco.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZwUJDAE01TeW/ud4QmsGaiDr9i87Q8ZXjaJFeWacSyCYIrv77b/xx46qhW0QD9F+Dx+QDtY5KdEa3YwejR1uzGHO+uyO50cxvSWlPZy/iA+l5eo4sjxPpwMuVEy4mC2/hbI+THc8+xhEhNTG95b3/Cq/jEP2p94R8eUYhfWJdkDk8X32lUBlO/fOmXocEDrJUPVT0ugsiwteMC38qCdpnUxl27Tnvz/RZOL0VVaaRYaW2nDNrgjtclF79aeYo+M5MrsSSmU+do6kAX2FwVPdwwNqjk/co4+ngwno7Sw4wTLS5c0yksqk7NpXH9dPQMZ3Dpg7UGZb2PWgVcyG+qjUfpdi505ZJlpkAGc3B+W7MyqDMD4FHr5bXPtah7iDLJbqm+VVXgUp2TlSzxZIRZK0c4kIIGTEvntuId/wzBAM+OkvoV/rwZeY1trx3oJ5W+9
X-MS-Exchange-AntiSpam-MessageData: 8zJuimio5IrdskA/zpina/3OQr8JkbYL/tPQ8FrjrdVMr+upDPsnBcGhZx9UJ1Jt5Gk8jc+OjRePODmZR6LW528b1HwywbJ6FfRFF+YRFp+bJhJhO6kA5d860dy0cy3y7T0Q0w0iyUjsfIpARfi2nA==
X-OriginatorOrg: tennantco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce24397-ff1d-4dbb-5697-08d7b0d0a76a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 22:04:10.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 854ee4fb-bf50-420c-8a26-5b96d626ac37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmYfqZMc5eCugLRTATj/wgQrAUbzNUEpxz7OVovwYl4F9zLqwx1cxnON+EfAlj6OY4EdlvgV3Fq2qNnSiX1WIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR20MB2934
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I tried disabling the temperature channel after every raw read, but I'm
running into some issues. When the channel is disabled the data ready
bits in ctrl_reg1 won't go high anymore, and I'm doing the dummy read of
33h as the datasheet says. Data ready interrupts also stop working. So
something is not right with this particular hardware. If you leave the
channel enabled everything works good.

What are my options? I could implicitly enable the channel the first
time it is used and leave it on, but it seems bad to leave the channel
enabled. In that case there would be no other way to disable the channel
other than to reload the module.

Maybe an argument passed to the module to enable temperature output or a
compile time flag to do this?

-- 
Dylan
