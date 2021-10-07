Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761C8425E63
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 23:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhJGVEN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 17:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhJGVEN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2021 17:04:13 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23090C061755
        for <linux-iio@vger.kernel.org>; Thu,  7 Oct 2021 14:02:19 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s17so3148807ioa.13
        for <linux-iio@vger.kernel.org>; Thu, 07 Oct 2021 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=SrHLVXxHjlqB5jvMju6B0BrhCTRXOvNWTiqE3AKHP3E=;
        b=JG/EDSPAyjr91rMd798uNpuixUs8oPc9JREYMBhO735AaWZ6ldcar9EHG4sDfxzaqx
         vGZEg041lW4TDkBzz1m6z6AiJYkeEHZOAQkWyZKC0rDOQbSRAZMAkEeWmVU+xDp7ydPJ
         V7oNI+5Hq65RDbQip1PXc5pDF45Cg/L4Qg1Oz8Sy70ohbbsN50jp2RJ8Uh64ozZ+BRMS
         7i1mzcM5MAlG20ULzigmL74bvojRHIeR0n0sVye3i9p473mh6fL2ffsxCMNHHRH+Q+ak
         sshodteV7Cu7UlnbDRWOwqARF4KY6eB9bFUDsrZYFdQcAgZvdmFGms4T3EIvCZGvG7g6
         y8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=SrHLVXxHjlqB5jvMju6B0BrhCTRXOvNWTiqE3AKHP3E=;
        b=Q3zjJY0gzAKXwuDLpW9Tu9OjPmVSP0nJa8tlVp1nvAYp0QB9JlJ56yg+KdUddTq1oN
         TLb85LaBwULvKtiLwVOeqgT0I7sHPKxHWyz4TwxoHXqpGriKDxQY2jKaQIddTZnuE/5F
         TmZ6S9Ris6EXIo/r95gEUqo3umj+llr2FVwQ6nMQS4ag9VfQndq7Yf37srg7c8xpiutV
         aFFv3SA01fiKwhSiHsxa0WfivL3S1vBDu8MIsYOHiWVVcdUmarEEhYuQxGo6ZeZVOpC5
         bm1o7pT/R9EQ4wKcmMBOd+PBcSmC95bsSZi7arYZbpyvNaBGB2DeDuTGQ60g1IRTzcnX
         QUBg==
X-Gm-Message-State: AOAM532Zndo6OZlEC3tAoN6xQImCoPELBuB5EwXQNUJDb4SUF/YicxKM
        LnNxYck0melM3xuYNlAAfXwPzIgYuHSpxV81RH4=
X-Google-Smtp-Source: ABdhPJxm+/zOjsDAxnGtMaSXYq8J1IvWFQ1TI5vgm+gqxxLu10K/Vof9bYoLmQuwQwhdmcG38Y/OiHIX1O1JYhK0hzI=
X-Received: by 2002:a6b:5b14:: with SMTP id v20mr4817651ioh.142.1633640538390;
 Thu, 07 Oct 2021 14:02:18 -0700 (PDT)
MIME-Version: 1.0
Sender: wawouraachristine@gmail.com
Received: by 2002:a05:6638:3881:0:0:0:0 with HTTP; Thu, 7 Oct 2021 14:02:17
 -0700 (PDT)
In-Reply-To: <CAMSSK+AbouY6fxu3D7w3RFVzKSStjcc3TgaF0FHJKUaLCRL_TQ@mail.gmail.com>
References: <CAMSSK+Aa+jnoynz1JFeNXPZWfDo_AfOjqKMHiCBU8SJVqXPZfA@mail.gmail.com>
 <CAMSSK+ADTEFwuc-JnY9yVGA8b5wqa6xuFRgrWti+isHd9ghWWg@mail.gmail.com>
 <CAMSSK+CxiH0XGJMoqf-408k5wVLBCoaAon1+HRja9H_pTHdMqw@mail.gmail.com>
 <CAMSSK+ChaykrmMLJ41dRZaPzvZ-3xqW64srx8-S2Yc1MFeJoOQ@mail.gmail.com>
 <CAMSSK+Cj040iXFQAsBqYqatEbNfo6GipkoHbPhGqK3Mw-EfMUQ@mail.gmail.com>
 <CAMSSK+DUFOaxKuzHe5rtEGQEojqaaZiNFODXmMHPkB4bFCSQew@mail.gmail.com>
 <CAMSSK+CThCPSo4b9vRc79fpg9QgLmFtGtNHXgoLuwdMhpWh4SA@mail.gmail.com>
 <CAMSSK+Dy90LqUC0-fGx9p_FtevqmuM2tW-YaWucbDb8nFWwqxQ@mail.gmail.com>
 <CAMSSK+CMPjy1GY=7HgByp1M4y=tYJxmAybFVofafbF6iy1eD3Q@mail.gmail.com>
 <CAMSSK+CSk83QTVyE9OSWFiRhK02x7LyFZsWZyu=CTq3rjTiZ+g@mail.gmail.com> <CAMSSK+AbouY6fxu3D7w3RFVzKSStjcc3TgaF0FHJKUaLCRL_TQ@mail.gmail.com>
From:   "Mrs. Rose Guzman Donna" <wonderclaudet.0@gmail.com>
Date:   Thu, 7 Oct 2021 21:02:17 +0000
X-Google-Sender-Auth: S_rwUpeSn4_eeyXocD8GTbhJfT0
Message-ID: <CAMSSK+B87ZubWtiqHU00yUzqTDUK7+_udva5hzgd=2d4M-d3_w@mail.gmail.com>
Subject: Fwd: Rose G Donna from America
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I'm Mrs. Rose Guzman Donna from America
I am contacting you because I want to open Company & charity
foundation in your country to help the poor, the needy, the less
privilege etc. on your behalf this involve a lot of money contact me
for more details
