Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF3724032
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jun 2023 12:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjFFK4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jun 2023 06:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjFFKzZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 06:55:25 -0400
Received: from emailsecure.uni-linz.ac.at (emailsecure.uni-linz.ac.at [140.78.3.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFBC1BF7
        for <linux-iio@vger.kernel.org>; Tue,  6 Jun 2023 03:51:53 -0700 (PDT)
Received: from [140.78.146.150] (unknown [140.78.146.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by emailsecure.uni-linz.ac.at (Postfix) with ESMTPSA id 4Qb6jf3v8Lz2PQ2;
        Tue,  6 Jun 2023 12:51:50 +0200 (CEST)
Message-ID: <1204b19a92343a9e3a6ec5df3cef94f6777e08c4.camel@jku.at>
Subject: Re: Questions about ad5933 driver
From:   David Schiller <david.schiller@jku.at>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org
Date:   Tue, 06 Jun 2023 12:51:50 +0200
In-Reply-To: <20230606113013.00000530@Huawei.com>
References: <3e5653d1aec953e8aba8c00d073cd033a9f7a873.camel@jku.at>
         <20230606113013.00000530@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2023-06-06 at 11:30 +0100, Jonathan Cameron wrote:
> Ideally clean up the driver.  If you are willing that would be great,
> if not would you be able to test changes made by someone else?  You
> are first person in years that I know has one! :)  I can't remember
> how far this driver is from being ready to move out of staging, but I
> can probably find some time to do a thorough review of that in next
> few weeks.

Yes, I'm willing to test any patches that are provided to me. :)
I can also try to come up with my own changes, but I'm not that familiar
with the IIO subsystem beyond what I've learned in the past couple days,
so I'd need some assistance.

> That may require extra ABI definitions possibly including the real and
> imag modifiers at which point your patch to libiio would be correct.

Yes, that's what I though too. I wasn't sure how "official" libiio is,
as it's not in the kernel tree. My quick and dirty patch currently looks
like this:


diff --git a/channel.c b/channel.c
index 469d037e..6a57a271 100644
--- a/channel.c
+++ b/channel.c
@@ -114,6 +114,8 @@ static const char * const modifier_names[] = {
        [IIO_MOD_PITCH] = "pitch",
        [IIO_MOD_YAW] = "yaw",
        [IIO_MOD_ROLL] = "roll",
+       [IIO_MOD_REAL] = "real",
+       [IIO_MOD_IMAG] = "imag",
 };
 
 /*
diff --git a/iio.h b/iio.h
index 135e335c..3c803479 100644
--- a/iio.h
+++ b/iio.h
@@ -196,6 +196,8 @@ enum iio_modifier {
        IIO_MOD_PITCH,
        IIO_MOD_YAW,
        IIO_MOD_ROLL,
+       IIO_MOD_REAL,
+       IIO_MOD_IMAG,
 };
 
 /**



