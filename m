Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FDF6477D6
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 22:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLHVQ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 16:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLHVQv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 16:16:51 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA8EA505F
        for <linux-iio@vger.kernel.org>; Thu,  8 Dec 2022 13:16:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v7so2219386wmn.0
        for <linux-iio@vger.kernel.org>; Thu, 08 Dec 2022 13:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=U21vesHJt0J/kIfEgtHtbSIhf4WkTWVTrUlgxyMNj+0gSykFaVJudOP0GckvKCeD5f
         qbSLVmLNNsUJxuXdEe7GGKaL/AdTgZ2lty84hmFD2bwVFn3GQWjEDWLH4chkmRA/WsbB
         N9ZENPFJ1ZTWhzM+IjiiLFSd0XEEoRPb5Eh12jf0YNXvyXOuWRVJcmxoyFQEQNIXuAnQ
         kNeIPnhVi8p+JLNANVhSWWuvqhT5LVBahwRA/9rkbbltU4rjjn31bSyyNf8hXgozxZXr
         51tOKfW/S6w7JGnDvN3omOieuy25/L3Q2ChBncvwfIiNXNkrayNR4wWQ1qnoCc01e77F
         LXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=XBcswt+g1fm4Td5bdfMaHTyij9nh+wyxuUzb8KC6GQqpyGD5wZzJJCvB0WjVIcyBnD
         A+kB2wob5VpMHJTt5+PZhh50P/DMJ4YVOnkFhfEwrxvd18KLmJHSBYOZzjhelNqx7AH4
         igsXE2Z9tgLM6Ay8hv5rrP7umG6N+GN2Tub2stv0nusXvo4gfGBHA6tyfsxBeD6NiC4J
         BlME9IGYqy+xKcVfeC5ik4fVedCN/p7Et6ibPKYZhhk1uhOtUuonEaXIjaJCVEI6IjtY
         DG4O4CDDjqVvZ7egO68AIYacAQ6/NjmsVD9tVIgopvozlbG4uOuMHY+YWyJZIBnNkbWu
         xA9w==
X-Gm-Message-State: ANoB5pmG0NJ+DjPR6BjErnnGzs8HXsiskI8Jkq69z4dk/jTIwMPYSpIm
        llHBTFr6aOxVPqrDkWa32pOYlWGu7SCYOMX4u/8bePSk1JihnA==
X-Google-Smtp-Source: AA0mqf7hVt63fefLpcKM0avDZlsETrM+Isre3xSEaZSNzIZ6eW5CH06N8wzr+3yARvDil/9mZOH48wPLmLhzKMi0Stc=
X-Received: by 2002:a05:600c:43c5:b0:3d1:eea7:e13d with SMTP id
 f5-20020a05600c43c500b003d1eea7e13dmr7094648wmn.74.1670534208890; Thu, 08 Dec
 2022 13:16:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:588e:0:0:0:0:0 with HTTP; Thu, 8 Dec 2022 13:16:48 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.David Keller" <davidbraddy02@gmail.com>
Date:   Thu, 8 Dec 2022 21:16:48 +0000
Message-ID: <CAPS4_a5OZY8bZgHUzh4Ltac0cPUHeo_g2HnHag+1yvnFE1yyMw@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
