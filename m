Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCBF67E293
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jan 2023 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjA0LEC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Jan 2023 06:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjA0LD7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2023 06:03:59 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B0518DD
        for <linux-iio@vger.kernel.org>; Fri, 27 Jan 2023 03:03:51 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id q10so3627645qvt.10
        for <linux-iio@vger.kernel.org>; Fri, 27 Jan 2023 03:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=DjrW97sWfsU24bRTLJ0mn+uxOOttHTp5ivompp76dIrPC4tl/2Hv9JUQeZDt/lYKB3
         jhEoxWKtqlZC8EA7wscd4to39DE+UbKjRGV7bMNZwDuqIB5jDl77Mk4Cv9kJDm1ELvvi
         UvEszNyW0/qhO4PglJiHKvhCYJL5ZlZ2ZodvovJAgMJFtOFqdbkr86q6hCRP5BS3OKT7
         xQZMPQV1kCx0keLCa2rPl5AG9pfWStz7A8dlKe3AhUk9DuY/Ywayggyphz8VHSBZUTSO
         YtICB1V4daEUykwQYtEiJlaxT4nVafDFiTX03Uo7KIityHa1ZYBGTBR2eMJf3Alr7x6F
         66HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=EoyH4Pzp5OR/kFQrQsJLqOFrRKEzKTBZ1A5DNqAt/uNz8N/z6RBmdLr6ugHBdZqT22
         SriuHW9USnxQzFJ0Cdb6e4gTeYlF7Zs/uQHATYzg6z/yXrw11YzVu76X2//nxM9W1s3e
         mO0OSxIeUdjNc5s+Z2xl4B4877p/JRelNK9rFp9FtMielUnri+SXQ5tN8KpN9zMTe2Tz
         ruJ2sgEoTDM9SQ9MtVH6LXGIm/p1q8fk29wx5sT3UCzMnhJgwG2+XscDS24BKevBWKYO
         sX3FxRWM4yTDjqFLBKJLL9EBGg7mGPH7y2OHRZgmQ3m0QU3dVWx6t0/0lTnRGFCKQ+J4
         yHrg==
X-Gm-Message-State: AO0yUKVEQwMTNmAtkhng7HRSQnxdWd39Rpoxfxqq6CZghbaowqqIfJtY
        LbztafNKU7eFhxCeeXyQNknXQrtdfZOQQKt8cCI=
X-Google-Smtp-Source: AK7set8StkfcLngFlahYU4WApS+4lidRRkH/FVRBrkrmPWvDA2YwUiN8sXg9wGquB7oC5R+pYlYsR9eKAszw7JB/8V4=
X-Received: by 2002:a05:6214:44a0:b0:537:6777:b744 with SMTP id
 on32-20020a05621444a000b005376777b744mr506292qvb.58.1674817430352; Fri, 27
 Jan 2023 03:03:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6200:5986:b0:4b6:e6d3:40f with HTTP; Fri, 27 Jan 2023
 03:03:49 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <mrs.gabriellakennedy09@gmail.com>
Date:   Fri, 27 Jan 2023 12:03:49 +0100
Message-ID: <CAOBm9TbvNirirc8HOp1XSdcaoQZSCVOox-Q9ZxafjBgE1ifROw@mail.gmail.com>
Subject: From Dr Ava Smith in United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava
