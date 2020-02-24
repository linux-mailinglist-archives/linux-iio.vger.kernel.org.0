Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9826316B180
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2020 22:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBXVHs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Feb 2020 16:07:48 -0500
Received: from esa3.tennantco.iphmx.com ([68.232.154.86]:25773 "EHLO
        esa3.tennantco.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgBXVHr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2020 16:07:47 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:07:46 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tennantco.com; i=@tennantco.com; q=dns/txt;
  s=selector1; t=1582578466; x=1614114466;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BetPtFLKFPPcLm4kgf3sjS0XT+CuMUCmTy168+lrcC8=;
  b=G+cp/hMCemxR8+vNIw4r6cTKL8e1FqoLjMHA55kETfxRCawXTHbRkw2O
   xkxRfe4qCoslss5hU8oFLzjbGPboBYHlR1jyXzbwhcRUxGW8OQ3UmXCJP
   psQSh7iBmw2mKm30XYQH1b94JHFWWUqCxyb5/Zb2aAbSwx0HRJnQFBBQX
   QU/wFUuSO+n8tTeLlr2SCjEDRmTwir9+Sh8fQPWPGsNWyvl1ozFWi2MP0
   yAX2j1mg7XQF2voziZ5xkA9s4ZiQ985CazA/p6cCvAGjFpfId4CSDKQFO
   BHWpsxyRQY/PaTiKzhy5W3KHgW7GVxgtgFKqMX5PFAvsFX5g8cfmMyLTg
   w==;
IronPort-SDR: X4stS8UmxPabS1AlmaW/7uU52JYODKP214Gtv3OZKEk0k9KT8a72n1LU5dK9zNkwczgTfHjEnY
 9xyg3Xq8tgVkV91bSBjms65weRI+4d1naVl30mN1xJFtsJLvC1tzo2LbzFIUdLT5l8YmuDn8za
 Gs7sc4vfogjwtj9WPwU+JMJgc+dUyZCIQTnSLqorom8IaSY/o3PFZayFQyYDSVlffNM4gcHQKN
 nBh3+XnMX/8VEvZczR6Y9ej+gnXTLbOAK1Bh5zz+40cU6ibLBrCCyEwtMOvsqqc203nbOIOZcT
 tY8=
IronPort-PHdr: =?us-ascii?q?9a23=3Ak36otBVz66GTheWMMuDNcNEiGUDV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSOvKdThVPEFb/W9+hDw7KP9fy5BSpRud3Y7C1KWacPfi?=
 =?us-ascii?q?FGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZFmJ6otxR?=
 =?us-ascii?q?fFv3RFduRLzm50OFyfmArx6ci38JN/6Spbpugv99RHUaX0fqQ4SaJXATE7OG?=
 =?us-ascii?q?0r58PlqAfOQxKX6nQTTmsZnBxIAxPY7B7hRZf+rjH6tutm1yaEO8D9UK05Vi?=
 =?us-ascii?q?6j76dvTx/olTsHOjsk+2zZlsB8kKRWqw+6qhdh34Dbfp2aNPtmfqPcY9waQ3?=
 =?us-ascii?q?ZBXt1MXCBFG4+wcpcDA/YEMetesoLzpUYBrQGmCAeiBO3h1CJGiHz43aImzu?=
 =?us-ascii?q?suEw/J0wMhH98VrHTYsM/4OLsOXe2vzqTFyyjIYfNM2Tf67YjFah4voPGIXb?=
 =?us-ascii?q?1qd8ra1EshFwTLj1qOqY3uIjSY2OoNsmif9eVgU/ijhWwgqwB/vDeuxtwhip?=
 =?us-ascii?q?XXiYITzFDL7yN5wJopKt2/UkJ0fdmkEJ5JuiycKoB4QdsiTnl1tComxbAKo5?=
 =?us-ascii?q?G2cSoQxJkmxhPTcfOKf5WQ7h7+UOucIi10iGx5dL+wnRq//0atxvfiWsWozF?=
 =?us-ascii?q?pHqDdOnMPWuXAXzRPT79CKSv56/ki8xzmCzxvT6uRYIUAskqrbNoIhzqYwlp?=
 =?us-ascii?q?UNtUTDGTf7ll3qgaGRa0ko5PGk5ePnbbn4v5OcMJR7hR/kPqQph8y/Hf83Mg?=
 =?us-ascii?q?8TX2id5OuwzqXj/Vf+QLVWkPI5jrXZsJHdJcQdvKK5BBJV0pon6xa4CDem08?=
 =?us-ascii?q?4UkmUALFJAYB6Hjo7pNE/SIP3gEPuzn1uhnC1kyv3EJLHsA5TAImLMnbv8Zb?=
 =?us-ascii?q?p97lRTyAs3zdBR/ZJUDbQBLer9VE7xsNzXFBk5Pxa2zebgBtRyyIMfVHmTAq?=
 =?us-ascii?q?CHNqPSt0WH5uQzI+aQY48ZoiryK/8g5/L2l382hUcdfbW13ZsQcH24HPVmLF?=
 =?us-ascii?q?mHbXfimdoBEnkFvhA4TOP0jF2OSzlTZ2y9X6gk/DE0FJqmDZvfRoCqmLGB3y?=
 =?us-ascii?q?G7EYdMaW9aCVCAC3foep6LW/cJZyOeONJunSIcX7i7V4AhzQ2utBP9y7d/Ku?=
 =?us-ascii?q?rb4DcYtYn42dhw+eLTiQs99TJzD8SayW2CUn97lHsSRzAqxKB/vVB9ylCb3K?=
 =?us-ascii?q?hghvxXC8Jc5+lHUwohLZ7cyvJ1BM7oWgPPZNuJTkipQsm+CzErUt0x28MOY1?=
 =?us-ascii?q?p6G9i6ihDD3iyqA6IalrCSBZw086Xc0mPvJ8Zy1XnGzrMtj1o4TctVM22pmK?=
 =?us-ascii?q?p/+xLUB47TnEXK35qtIIYb2ifR9G6FhUGHuUxCVwg4BafEVipETkjbt9L04g?=
 =?us-ascii?q?XFVbD4Wpo9NQ4U5d+GI60CStr2gEQOENvyPN3YJUK2hGqhLQqFwLWFapbhfC?=
 =?us-ascii?q?MW2yCLWxtMqBwa4XvTbVt2PSymuW+LSWU2TQi1MUrx7elzrm+6RUYozgaMKl?=
 =?us-ascii?q?dszKex5gVL1a6HU/1G2LUCtW9hsDhyEFunl/PuQ9ub70sEHu1HZM8lplJO1G?=
 =?us-ascii?q?bXrQt4a7CxK6lkwH4ZbAlml1/j0RN+DJlLlo4hq3Z5hAc=3D?=
X-IPAS-Result: =?us-ascii?q?A2F+DQAfOVRe/ylCL2hmhBVQXoELBDUKhAqDRwEBhTqFN?=
 =?us-ascii?q?4JflCeDbYJSA1QJAQEBAQEBAQEBBgItAgQBAQKEPgI1gX04EwIDAQwBAQEFA?=
 =?us-ascii?q?QEBAQEFAgEBAQECaYU3DII7KQFucQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQUCgQw+AQEBAxIRHQEBESYBDwsOCgICBSECAg8FHgsgN?=
 =?us-ascii?q?YVPAy4BoBQBgSg+AiMBPwEBC4EFKYhhAQF0gTKCfwEBBYUDGFeBNQkJAYEEK?=
 =?us-ascii?q?owzgUw/hCQ+h1wygiyYI5d3B4I/fJVdKJsuiwmER5pnAgQCBAUCDgEBBYFpI?=
 =?us-ascii?q?4FYMxojgzxQGA2SEIp0VYEFJIx5AYEPAQE?=
X-IronPort-AV: E=Sophos;i="5.70,481,1574143200"; 
   d="scan'208";a="17465732"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.tennantco.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 15:00:23 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxkLO6khNhTjRZwkgxWM2y+IomIAjL9nycyI/avEiV2f7d3ORlESsEaLjpgfzn0fopOHBpM4eFFXttP/+y/171tJ3Ti9YACMesr9W7qyjGnSP/SYBEsPVjmbVtUexYA9QBr/7xeHKZfDe6ZsKY1g8CJPS+Sr0EFz9S5b3pp5psQYTVaiq5xQGVuHW+Kgr/pIgUozqZOlNlrFC9SKXM1ITj8QFaARziWZseLFFoSJvkCQFELlNac2V5E5FP6nvMvcdGaqYWnxt3dHlpQKsXGGesVy83C6msjDkNHx5CNZ1BN7n0zZMb+tOP+j0XauRQzUr2vd+jsMTL9w6NerWQ3iMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BetPtFLKFPPcLm4kgf3sjS0XT+CuMUCmTy168+lrcC8=;
 b=KWxCq1p12gSIcJ9QcvFGJ56ZZlimcQ7g0Bi1xrwr3whIFOAWvlNTGdKwKb8hN2nVDXtALqIsRHdasH8sDXz0Ycmwacc9DtNLb+Bg+NFEAE7yvZKavNaLejdwllf0snnIRcMN8D511StGp4ty0McoV7slzx5HInacbABoUKtufHl6OviEFU0CVHH4uaOiESc9gTytiNmo5/XgvgUrWDmER1yuVBhG1dy6c9NwT7+SUZn+G8CPb1seopx27xd9rwdqBOR017tUpr+OOcQT8cZYBFkx8G4PoroXge+06Bvpu7jsY+Gbj2sIzqqU8+50SJkLpaOQ6OO49+z9+rvTI9o+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tennantco.com; dmarc=pass action=none
 header.from=tennantco.com; dkim=pass header.d=tennantco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tennantco.onmicrosoft.com; s=selector2-tennantco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BetPtFLKFPPcLm4kgf3sjS0XT+CuMUCmTy168+lrcC8=;
 b=b08zN7ie3TqTwWqHxcnRUzO/4sXzSdKpn8DXgPuodybscRSJFgtEuDa/cbw4sPMpsmGsghuNOg6fR24k+Fpe/6P934KTc3AF+EVCgDaLAaAXtky3xuMHx+fEN+y9fsuTpDnUhmtn0pJUtHBeBx2pV0TRDwJzUVQL3Niu1zKwsmA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Dylan.Howey@tennantco.com; 
Received: from CH2PR20MB3271.namprd20.prod.outlook.com (2603:10b6:610:2::30)
 by CH2PR20MB3128.namprd20.prod.outlook.com (2603:10b6:610:4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 21:00:23 +0000
Received: from CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::b12f:4e2a:2a0:51c1]) by CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::b12f:4e2a:2a0:51c1%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 21:00:23 +0000
Date:   Mon, 24 Feb 2020 15:00:20 -0600
From:   Dylan Howey <Dylan.Howey@tennantco.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: Expose temperature channel
Message-ID: <20200224210018.GA937@tennantco.com>
References: <20200205203240.13550-1-Dylan.Howey@tennantco.com>
 <20200208163154.4d4f6752@archlinux>
 <20200213220407.GA11762@tennantco.com>
 <20200214132400.7133bcf5@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214132400.7133bcf5@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM5PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:3:115::22) To CH2PR20MB3271.namprd20.prod.outlook.com
 (2603:10b6:610:2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tennantco.com (198.204.33.200) by DM5PR11CA0012.namprd11.prod.outlook.com (2603:10b6:3:115::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 21:00:22 +0000
X-Originating-IP: [198.204.33.200]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f6bea74-add3-4626-53e4-08d7b96c906d
X-MS-TrafficTypeDiagnostic: CH2PR20MB3128:
X-Microsoft-Antispam-PRVS: <CH2PR20MB31289B628EE3E8DF4BF8A17BEFEC0@CH2PR20MB3128.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39850400004)(366004)(346002)(199004)(189003)(4326008)(478600001)(66476007)(66556008)(66946007)(33656002)(4744005)(81156014)(1076003)(81166006)(5660300002)(86362001)(956004)(54906003)(8936002)(2616005)(36756003)(2906002)(6916009)(26005)(52116002)(7696005)(186003)(8676002)(316002)(53546011)(8886007)(55016002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR20MB3128;H:CH2PR20MB3271.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: tennantco.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbEh9DAZuOXKDm6Y76G7Iy3arxEHcfsVl83Kt6FNAEcL3a8kcP7t8J7K8cssIDJI63UEqdAS5R22kjDk25JsijNExfNvrFvJg+V2BqtBlrfovMsGApLJTaLCQwXGKPf1Xytp/Eg67Y6Cac+hWJAvWeEMn/immhBAW895lF96Dh4NNzz80VttrcX70RiRKForlM0Bor5KQi0kSEnh0Wc1XqpxYa305uYV/LpjwGOeQeWfmcv5UC5elYlGh/KxCqoSmee0w2r5pQ61GnL3vNxm58toIfh1Z3E/LXTW1KGFP76wE+AJ9td+n4HspMu5dEMUF+Vwy5ZCmAilyqF+PVukAst/pkC+94sqIFdX6xSxCmd85426BGxQ5PbXj509pdm//PmYl52lBZ4ppUvDrbjCxe/PJIdJBdjpJtrdNZAeioMhLp+44gNFaIrJebNlDdtR
X-MS-Exchange-AntiSpam-MessageData: g+fBdf9L/KTW6Tqd3KtnROzAQRwkcCsGW7YOAemjElXu9Nk0bcGko/FayOJ9BMc96/54/Jo6aBz0oR7oBkJEoix+VaOiAuST2+3pE3k402HrPr2b0rvgkrrFVXlGsN5feDLOvYVBXp7Otx86olzv/A==
X-OriginatorOrg: tennantco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6bea74-add3-4626-53e4-08d7b96c906d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 21:00:22.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 854ee4fb-bf50-420c-8a26-5b96d626ac37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/BRhTuASqhCc0aXn7EubIhschZjCWl0EmuetrxnZUJ4mLx73i1JTCANBtZmuU3NZv6kkxXlkhRFS4LkPvFY9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR20MB3128
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/14/2020 13:24, Jonathan Cameron wrote:
> So ideally we'd get someone at Freescale to confirm there is a hardware
> rather than a documentation issue (i.e. maybe we need some other magic).
  
NXP says there's a documentation issue. CTRL_REG6 can only be written
when the device is in standby, similar to the other CTRL_REG* registers.

So I'll need to use mma8452_change_config to set this register. I will
try this out and send a patch.

One other detail - the temperature cannot be buffered by the hwfifo.
If I add hwfifo support, I think the right thing to do would be to
disable hwfifo implicitly if the temperature channel is enabled and
fall back to one interrupt per sample.

-- 
Dylan
