Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40355E8E2B
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiIXPur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiIXPuq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 11:50:46 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5134610560
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 08:50:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3487d84e477so28046287b3.6
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=lNiS9+tMIO2r2VrK2eWKfjtuikvQUySmJSXeNuyVxdu5ATekJnC4RpvegKgRGsY8aw
         NptWzwvaTYJJpw3nxWfYTm3tHFQXeXJeIkAPQGgOov4VKpNDry24jG94QetaL0HBFWKg
         6NlCwz0gLnlOfcmANjGqSXiUyaak2b4NB6A7D8Xp7dDQ8YmJYpK2cjRr/RIs1cmBZw0x
         5EGIJUvlLtrC0R65H+E65AaiYRyzPz2vNtFpnRS3b6cU0WpvoFYJBGf7H00GvJ2w6KQk
         ZwC4HPK2YOhg5as1NCu9KtWBlFIhMzs5O0Vv8GOukykNhgXP04NIOFduO+jrB1lKJNP4
         uVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=s/5oQEh6rHPUeR9nOZBIo9mIURdIgeLT04xQWt71o6NxQilkOs1yMGjcBPIsh7ta6P
         fPtSfPnGVYVyG23vRphD4qDeAgFnS++D0KkIVLjc5N09T1xJtW0AWPE2onAMnwPShLsI
         oqdONZDGjNc+VbdwfdMTVG53GA42YZCy2QzUv8XAsX6JU+f+GE1qt2YezpMTuwJFcpB8
         ipZjqNw9MAk0M268yPOK8e4QG4pZNp3uifY/OLF4CoGmyeIOKa5BLnn7pB7FiumIXP0e
         a7wGLvXsuUrMtrNBco888YHIfqbV6wbRCfjcnlVa5wgKBiL39AyJJkZO/Ouf7NBuGrZJ
         HFqw==
X-Gm-Message-State: ACrzQf0iJLZAv4epwgnYohwGXxmKnDM6JzDkMagif1aBJlE2RgV9aZDe
        enmYkb4tOfA8op6QgnfkKqy1CCVoNlB/Zmjo2bM=
X-Google-Smtp-Source: AMsMyM7llakQxTMCshGmWoQqX1M8LD4CW4JWw/hsONkiCKwdKe1KnijUwBGC2CAf4Xy/I4yJ9f3zvkUENIwKQz4n1o4=
X-Received: by 2002:a81:6bd4:0:b0:345:753c:a8e5 with SMTP id
 g203-20020a816bd4000000b00345753ca8e5mr13368990ywc.349.1664034644318; Sat, 24
 Sep 2022 08:50:44 -0700 (PDT)
MIME-Version: 1.0
Sender: paulbryan24921@gmail.com
Received: by 2002:a05:7010:4e8e:b0:305:f589:3ad7 with HTTP; Sat, 24 Sep 2022
 08:50:44 -0700 (PDT)
From:   Ahil Lia <mrsliaahil070@gmail.com>
Date:   Sat, 24 Sep 2022 15:50:44 +0000
X-Google-Sender-Auth: feVeXZrOG5caVbieO4nQSo5pqRw
Message-ID: <CACVhYX7C5gGtL8F-mhbtFntw8PdLUUU5k+fXKqk89q48j4G6eQ@mail.gmail.com>
Subject: Hello, I need your assistance in this very matter
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


