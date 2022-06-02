Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3314D53BF40
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jun 2022 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbiFBUCu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jun 2022 16:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiFBUCn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2022 16:02:43 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 13:02:32 PDT
Received: from smtp687out9.mel.oss-core.net (smtp687out9.mel.oss-core.net [210.50.216.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A43E410A3
        for <linux-iio@vger.kernel.org>; Thu,  2 Jun 2022 13:02:31 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2AWbgDRFZli/7NplnpaGQEBAQEBASsLBgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQIBAQEBAQEBAQEBARUJgUYCgToCAQEBpD6HGRuCJYdngXwLAQEBITAEA?=
 =?us-ascii?q?QGEeAEBhVEmNgcOAQIEAQEBAQMCAwEBAQEBAQMBAQYBAQEBAQEGBIEchS9Gh?=
 =?us-ascii?q?lQgBwGBVgEOAR6FdQEBrG6BMw10hFkUghAECoJzgTsCAQEBAQGJQoVffYEQh?=
 =?us-ascii?q?BABhX2DQIIuBJJGhCMEGzsDIRUYNBKBIUUsAQgGBgcKBTIGAgwYFAQCExJTH?=
 =?us-ascii?q?QISDAocDlQZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAy4CAxgJBwoDHQgKChISE?=
 =?us-ascii?q?BQCBAYNHgsIAxkfLQkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMUDwEGA?=
 =?us-ascii?q?wYCBQUBAyADFAMFJwcDIQcLJg0NBCMdAwMFJgMCAhsHAgIDAgYXBgICcQooD?=
 =?us-ascii?q?QgECAQMEB0lEwUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2G?=
 =?us-ascii?q?QEFDk8GCwkhHAkgEQUGFgMjcwVIDyk1OQZ8D65SkECeMwqDTgUpB4EJB55JM?=
 =?us-ascii?q?YNjAZcSEQEngVeLVJZoqBKBCQOCC3AVggiBHFAonRCBEAIGCwEBAwmPCgEB?=
IronPort-Data: A9a23:SUGX2aJtIdUGzez8FE+RWJclxSXFcZb7ZxGr2PjKsXjdYENS02cCy
 jYWDWiDPvveMTP1KN0naIyy9hlVv5WByN9iSwMd+CA2RRqmi+KbXIjFdi8cHM8zwunrFh8PA
 xA2M4GYRCwMo/u1Si6FatANl1ElvU2zbue6Wbes1hxZH1c+En9/0Ug7wYbVv6Yx6TSHK1LV0
 T/Ni5W31G+Ng1aY5UpNtspvADs21BjDkGtwUm4WPJinj3eC/5UhN6/zEInqR5fOria4KcbhL
 wrL5OnREmo0ZH7BAPv9+lrwWhVirrI/oWFih1IOM5VOjCSuqQQ33P0JGMITN3tIlirQgelh8
 8xIqMavHFJB0q3kwIzxUjFnMgc7H/Jp1pPtCF/i6O77I0/uKiG2hawzVAdvZdBeo7kmaY1N3
 aVwxDQlbxaNgMqzybS3W69ngcFLwMzDbNlH5y8/kWux4fAOXKLME53n4PZhjTIinfBeGNXOO
 PMzQG86BPjHS1gVUrsNM7o6neG1ljz+cjpwtl2Yv+w07nLVwQg316LiWOc5YfTTH58QxxvA4
 zueoiGgXUBcL8CWjyWP6HWliuXGmy+9Xo8OUrSlnhJ3vGCuKqUoIEV+fTOGTTOR0yZSh/o3x
 5QoxxcT
IronPort-HdrOrdr: A9a23:z1f+eaxnYEzXjoIm+kWTKrPwT71zdoMgy1knxilNoHtuHfBw9v
 rDoB11737JYVoqM03I5+rhBEDoexq1yXcS2+cs1NyZNjUO1lHEEL1f
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,272,1647262800"; 
   d="scan'208";a="82056742"
Received: from 122-150-105-179.sta.wbroadband.net.au (HELO WIN-J7GFDBAO51J) ([122.150.105.179])
  by smtp687.mel.oss-core.net with ESMTP; 03 Jun 2022 06:01:26 +1000
From:   "Martin Otamori" <info@mandy.com>
Subject: Acknowledge this message
To:     <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: <okkmart68@gmail.com>
Date:   Thu, 2 Jun 2022 13:01:23 -0700
Message-Id: <0222202206011345801388D5$FE67EACE18@mandy.com>
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_LOW,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?122.150.105.179>]
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [210.50.216.236 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [122.150.105.179 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [okkmart68[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I will give you more details as soon as you acknowledge this message.
Thank you.
Martin Otamori.

