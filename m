Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F40E1614A1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2020 15:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBQO1n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Feb 2020 09:27:43 -0500
Received: from esa2.tennantco.iphmx.com ([68.232.153.189]:12045 "EHLO
        esa2.tennantco.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgBQO1n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Feb 2020 09:27:43 -0500
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 09:27:42 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tennantco.com; i=@tennantco.com; q=dns/txt;
  s=selector1; t=1581949658; x=1613485658;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MjfGf1kXFgq1esZzEQTczb1Gmy/UrRDxQXfkhZSTlYE=;
  b=lZnMnsv0u3BcGhE1hrszIEEpdzVdGqBceZkHiWQnvlcyxDi7hRfwAiRU
   LttdGqdfIUFhM+IRrZW71/CqP8lcTAaFUzZlu1OhjV2jnbBelHJE788tS
   aGNfuYPdzhUetrxVhGQtFr1k1t+xz2PaHxcmg2NzqpxjMoVa6DM1YS2IV
   MCeBYfGM4pl0v86VkqecJ/Pl1ry4ITihMQn0ln28iYLPXN6ZE6RTPuQkR
   lLWSojsEe85bV12Y76K5n8Jick+y2RMDe8i06A7Nyz24xyCmmXgn4eYxL
   1RIm2Dn5QQr9Ez1ld/YreBZyNjTBN4Sna3j2hGPWVfSi63mShUUfQnd17
   w==;
IronPort-SDR: rAZC/SN6z99ZwrYnFvVBpux7L3gMTQnhxFD16H93xC+5jRevHt16gu9AnOX+PwEgPBRqBuAB56
 nWEUhMocjag2kQ5hNRtTOHq6aMEp8BbiNhUmTU0WtDwhAxK2ILh8ZNnC/f9iZC53BjiQPFbPl0
 N/y2Xx8hNQZzoCc0DmpcdI4VKUx5fAr1tuAEYZy4OcvJs3m7DdoBsPeoBvOeBsWKyw5AxqWM/R
 HaCQSdRHMhY+8wjwARY/4FWnKVls3qBL/P/WPhoMksm0yDUn+HirhwgiQB2P66Z96OMwf3SM15
 Ubw=
IronPort-PHdr: =?us-ascii?q?9a23=3AKOzjpR9x3T0Xf/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+MUIJqq85mqBkHD//Il1AaPAdyHra0awLSM+4nbGkU+or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCeybL9oLhi7rArdu8gIjYB/Nqs/1x?=
 =?us-ascii?q?zFr2dHdOhR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFKH4GyYJYVD+cZM+hWr5fzqUYNoxuwGQajGeHgxTFHiX/3xqA6z/?=
 =?us-ascii?q?gtHBva0AA8Bd8DsnLZp8j1OqcIVuC1ybHFwzvDbvNSwzj97pXDfBImofCCQ7?=
 =?us-ascii?q?1xcdfaxE4hGQLFilWfs4rlMymX2OQKvWmU8ephWPmzi2E5rQFxpCKgxsEwio?=
 =?us-ascii?q?bVgYIZ0EzL9SJ8wIssI9CzVU11Yca8HZdNqy2XOJF6T8wgTm1yuCs3yqcKtY?=
 =?us-ascii?q?OncCUL0Jgr2hrSZv+df4SW/h7uW/ydLDl2iX5/Zr6zmwq+/E69wePmTMa0yk?=
 =?us-ascii?q?xFri9dn9nJsXACygLc59CcSvt44kehwTGP1x3P6u1cIUA7i67bK5k5z7Aoip?=
 =?us-ascii?q?cdtlnPEjPvlEvxjKCaaFwo+u+z5Ov5eLnmoYKcN5NvhQH5L6QunNGwDf4gMg?=
 =?us-ascii?q?gUWGib5fqz26H//U34R7VKiOc6kq7EsJDGIcQboam5AwxP3ok/7Ba/Ci+q0N?=
 =?us-ascii?q?UenXYZMFJIYA+Lg5TmNl3UL/31D+2zjlSsnTtx2vzKIrzsDo3ILnfZkbfheb?=
 =?us-ascii?q?h961RbyAo21d1R6ZJVCrUbL/L1QEP/ttvYDxEnPA202OvnFMty1oUYWW2VBK?=
 =?us-ascii?q?+ZLL/dsViS6u0zJOmMYZcZuCzhJPg9+/7ukXg5lEcffamowZQbdn61E+9lI0?=
 =?us-ascii?q?qHe3rshMkOEWMQsgo5Vuzqh0WIUSRPaHaqQ6I8+jY7BZqlDYfFXI+imqCO3C?=
 =?us-ascii?q?ShEp1WfW1GBVWMEHjye4qZRfgGcDiSLdN5kjwYSbihTJcs1RW0uw/g0LpqNe?=
 =?us-ascii?q?/U9TMEtZ352th14OrTmQsv+jNqF86dyX2CT3lonmMUQD87xLh/oUljxVidy6?=
 =?us-ascii?q?h5jedVFcRW5/xXTAg6L5Ddw/Z8C9/sRgLLZs2JR0q+QtW6HTExSco8w9sPY0?=
 =?us-ascii?q?Z7BtWjgQnP3yurA78SjLGLGpM0/bzG33TrJMZy1WzG1K8/gFkiWMdPMnemhq?=
 =?us-ascii?q?EsvzTUUqzOlUyFl6+sPY8V2SPX82HLmWiPtxsDeA19S6PIWTYYfESA/vrj4U?=
 =?us-ascii?q?aXY66qALJvEgxexN/KfodbbtTvy3VBW/ryEMjTZWS4nXu7AlCDwbbaP9miQH?=
 =?us-ascii?q?kUwCiIUBtMqAsU53vTcFFmXn378WvDEDxjE07uaErw8O547Wm2VVIw0xrUPx?=
 =?us-ascii?q?96z7Tg/BkTiLTcUP4V0r8e8AYZ4zRvVBfYvZrNDsaY4Q9ofaFSe9Q4tXtW0W?=
 =?us-ascii?q?vf8Sx6IZGxB7xvgFgXdRh8uAXl0BAkQog=3D?=
X-IPAS-Result: =?us-ascii?q?A2G/BACNoEpe/2o3L2hmHgELHINPUF6BCAMENQqECoNHA?=
 =?us-ascii?q?QGFOoVAgl+YEYJSA1QJAQEBAQEBAQEBBwEtAgQBAQKEPgI1gXE4EwIDAQwBA?=
 =?us-ascii?q?QEFAQEBAQEFAgEBAQECaYU3DII7KQFxcQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQUCgQw9AQEBAQIBEhEdAQERJgEECwsOCgICBSECA?=
 =?us-ascii?q?g8FHgsgNYVPAw4gAZ4iAYEoPgIjAT8BAQuBBSmIYQEBdIEygn8BAQWFHhhXg?=
 =?us-ascii?q?TUJCQGBBCqMM4FMP4QkPodbMoIsjUSKUJduB4I9fJVLKJsaiwWfFQIEAgQFA?=
 =?us-ascii?q?g4BAQWBaSOBWDMaI4M8UBgNjh2Dc4pyJDGBBSSMZwGBDwEB?=
X-IronPort-AV: E=Sophos;i="5.70,453,1574143200"; 
   d="scan'208";a="17416256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.tennantco.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 08:19:00 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMY/zE3JM5JAijtZvJ0nrH0pMagWDfK2Hpkj60QBEygY8u1F8F8+N/oIIFwW443gWbOscAE0AXjh92Y97JZ6Rp8Eh8siBtJfAz8G1+ubdxLep6V1fmkBj5qUspaNQ7l89PGt1RX0toJusT3yrTJ7U4xoKmXjeXio5SQeUM/aFMIEpBHT1l5Gq6gPnqUnxbiPoqerC6w4lkVFm7vPKKfQAbgQEZQyLB6+tghMXUpvbvUc7Mmj+bmuUUYK6piWjjhX2fDLCeH8aMYgj8z8C6Uk4EsaCtnpIxc/nGNyfIMK72Rp6OYwXRiXK2tZCbTPKhF3ILD6DGp7mcVDIGycWexTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjfGf1kXFgq1esZzEQTczb1Gmy/UrRDxQXfkhZSTlYE=;
 b=mh/9SbWz11UsePsIzyUSgPfcze2EX+BZzj5zh6w6UKIpqoP3uuaxTOBzHz0sXyCROrE15g1g9S620troGhKV7zsTmNqcfa/LCo58OjF0SAI5kx5sB0GQXSuT+CfO9VC3Tr9pxVN7sk1zzQFjVdiYGNOFmV9gimvsM2Pnln22iY6uR8o6Iye0oEEGT0VYMFSF1B422d32edwSlxeC0YmmBK7nBzaGq5tK8aiyHeAlcMHhRfuUwvAYVwbrPbn5MqxESmKNC+4zrGG8HKIDSpfhetORtJJgo14KfAKpX6Q6iN2T/9TiJvqpmysWLdQEOdlKuEy/3fBz47CkhLt7Jzykkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tennantco.com; dmarc=pass action=none
 header.from=tennantco.com; dkim=pass header.d=tennantco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tennantco.onmicrosoft.com; s=selector2-tennantco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjfGf1kXFgq1esZzEQTczb1Gmy/UrRDxQXfkhZSTlYE=;
 b=GmLzi5MkGi2BktHRL3gr3jvFsV566rwaksdCLUfwqCo5Cr3oN9fJKvKGhIUwMheMGQnlOBe7UCxDzU9y32XIJq2zpLACcUAqwG5ynnUDP07lS+eZjdHYubHM+msUmRnG7gFcOh0n584bq93IGBobJJeulgTF47yX3EHCZEnORoU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Dylan.Howey@tennantco.com; 
Received: from CH2PR20MB3271.namprd20.prod.outlook.com (10.255.156.30) by
 CH2PR20MB3126.namprd20.prod.outlook.com (52.132.230.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Mon, 17 Feb 2020 14:19:10 +0000
Received: from CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::b12f:4e2a:2a0:51c1]) by CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::b12f:4e2a:2a0:51c1%7]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 14:19:10 +0000
Date:   Mon, 17 Feb 2020 08:19:08 -0600
From:   Dylan Howey <Dylan.Howey@tennantco.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: Expose temperature channel
Message-ID: <20200217141902.GA31535@tennantco.com>
References: <20200205203240.13550-1-Dylan.Howey@tennantco.com>
 <20200208163154.4d4f6752@archlinux>
 <20200213220407.GA11762@tennantco.com>
 <20200214132400.7133bcf5@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214132400.7133bcf5@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CH2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:59::17) To CH2PR20MB3271.namprd20.prod.outlook.com
 (2603:10b6:610:2::30)
MIME-Version: 1.0
Received: from tennantco.com (198.204.33.200) by CH2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:59::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Mon, 17 Feb 2020 14:19:09 +0000
X-Originating-IP: [198.204.33.200]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44ef8c19-a566-4f09-d0db-08d7b3b45b1d
X-MS-TrafficTypeDiagnostic: CH2PR20MB3126:
X-Microsoft-Antispam-PRVS: <CH2PR20MB31269AA1A1C09712B61E96E7EF160@CH2PR20MB3126.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39850400004)(136003)(199004)(189003)(2616005)(6916009)(956004)(81156014)(86362001)(8676002)(81166006)(8886007)(7696005)(8936002)(52116002)(36756003)(4744005)(4326008)(2906002)(54906003)(66946007)(33656002)(16526019)(186003)(5660300002)(55016002)(66476007)(316002)(66556008)(26005)(478600001)(53546011)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR20MB3126;H:CH2PR20MB3271.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: tennantco.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYLVC1a4rh1JdOVRd3//+KBTH7vZuwW0m9nIndce0uJrn9PR0zQ4JJq91RvGB4Rl29NdhwdUxzwPLlxZa4zEHY12IEKIE6ZV4dj0vwCWPgqqBXu5MgAbhmGBmroDsne5YK9FSUOrFUcG3QnjPrQzEvMVIugd3DiRmMTB+zFaJWGkKdvddZF7dEzQFslRh+vnX4gv5T+iyDOJ69qALXMsdMJqasy+7oS4EI3e6s8Wr3SbyTsQpfxOdKcdh+qwixk68zTb+/9L/Ic+LBQ5aS75w23gBuRNOmHz+aV0PzGrNQXJhXcVUhY4UK1sMsqkrTnosfESbzU/vdbv+qAphLVvZXH3QIlivQGtwrr75p6xGUT7awVZSfBao5wLPJGpAMILhfJi1Jk6e8ZRArwzc8CSEv7Gg4jJPHf4UiACoi92Hhx4OchO80KIqzjU3BjUyiDG
X-MS-Exchange-AntiSpam-MessageData: 2bFrbdY5hCfjTAXqynBD4nFFGd23K69XxcGRpj0i7cSjR+oZ8NvYjG16liTS1LOlFrQsvSqTp5fR1MVIeNiotjNDVmixwkee4w8pD7kKlGsd/auceFGeS167y5/FhBYwi1SWP/2LacAN0xOLlSnWpQ==
X-OriginatorOrg: tennantco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ef8c19-a566-4f09-d0db-08d7b3b45b1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 14:19:10.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 854ee4fb-bf50-420c-8a26-5b96d626ac37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tA+VUEHNLV2i49BOteapr/KV+zaQBEai1TzE7Azxl0J/j/PsjuikJfUrQruzRR3KD4CXAZjm85lSVgg85+3wlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR20MB3126
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/14/2020 13:24, Jonathan Cameron wrote:
> So ideally we'd get someone at Freescale to confirm there is a hardware
> rather than a documentation issue (i.e. maybe we need some other magic).
I'll try that route first. I have an NXP contact.

> If they do we probably need to avoid breaking them so would need a module
> parameter to be 'enable temp' rather than the more natural option
> of 'disable temp' to be set only by people who need the highest
> frequency.
That's what I had in mind.

> The question is whether anyone actually cares about 800Hz?
I have a use case for this. I'm doing some data logging with this hardware
and a higher sample rate is always better.

By the way, this hardware has a fifo that the driver isn't using. I might
add support for that. Currently I'm trying to log and getting hammered with
an 800Hz interrupt and that is causing some issues.

-- 
Dylan
