Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B9B6442E8
	for <lists+linux-iio@lfdr.de>; Tue,  6 Dec 2022 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiLFMGa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Dec 2022 07:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiLFMGP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2022 07:06:15 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895B420D
        for <linux-iio@vger.kernel.org>; Tue,  6 Dec 2022 04:05:41 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id v81so6675154vkv.5
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2022 04:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=Tr4elLvSIdNe+xVHrH25SZkPWwb03ikKNScikW49iZ421MNP0a4oOUkeLndoG49JOK
         eUaVMU3HDkM/YR5EiJeOvhWhZjpnKLHFYut/nDnMlfqkEsdOjy5dMs0w4vR1ak4rpTju
         AEDV/+u2xmRElRvbhhBBZLQORZD8MnhwxZsItsXyUl7BYEb5GB4vVK0ySy6tZhqcwgX8
         KNnTUXSwRRkBJzro9JH/QIy80yyhuE8rd3g7A0WMLNjwTD7IxWt1i8F8Q4qZ+DfPGdlU
         +6NcXFdrhY7EeYfe2h5OXK6X+Jn+lCFugemnYsOHfUiMJ8iJ785mjxIIjcwTC2IUN3wk
         lvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=bQTKGruwUkhBOoGYOemokdlYA5YfTi1xb8nbwQ12dN7qLcspa51HRdheshiA8CFALq
         Uakwmocj8LHGK3ZSSGfbV0h4z+Uqc+KLj5YlPR10/hAXKee3qsw1megsUwInhQcJlnDk
         ybDDvY/8EVZ/BJjh08ipGt6kJxvHzYUKDv+USrPV0MoIYuJFziGFfDATmfwJttRwgv/T
         PTDj9vjeCq6vgYDRQNfsiwu70tHlmDSxu8IB7VK8ktUU8jjUvfs1CDF+5vb6qtjZGy24
         0nNJOlr6gNwFCNGQM+ZqK3qL4gcZQFZKBobG/hInEkLbHg26TcNysS6VCG3Dh/ph5S6L
         FlKA==
X-Gm-Message-State: ANoB5pmzDmSYOKjxSBRc0b+IcEkOdwPfd3pkeEoqtmtV10hbNNtQGoKb
        m14QcnDHOtoNrZQ/FxBWk/JddV3oOmpzFmDoyMk=
X-Google-Smtp-Source: AA0mqf7wwq+wcpAcIPTYImRpM9gCCSM8h2742+rV2x1L8L8JrahgNoSKNcJWa1cyaeYg5XwI8+7TuT2c/fUfdyT4rPU=
X-Received: by 2002:a1f:3484:0:b0:3bc:d233:5be2 with SMTP id
 b126-20020a1f3484000000b003bcd2335be2mr22561702vka.8.1670328340357; Tue, 06
 Dec 2022 04:05:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:544:0:b0:419:d0d:612e with HTTP; Tue, 6 Dec 2022
 04:05:39 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <reverendmichael00@gmail.com>
Date:   Tue, 6 Dec 2022 12:05:39 +0000
Message-ID: <CA+_+1VL8OyP7WFQZ=SHk4D2c0ESNXFOeKxKeLTb-T_BvjfOJTA@mail.gmail.com>
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
