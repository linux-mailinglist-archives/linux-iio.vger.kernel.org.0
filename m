Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFA26BAAB9
	for <lists+linux-iio@lfdr.de>; Wed, 15 Mar 2023 09:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCOI0Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Mar 2023 04:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCOI0P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2023 04:26:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC32195B
        for <linux-iio@vger.kernel.org>; Wed, 15 Mar 2023 01:26:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f16so18561876ljq.10
        for <linux-iio@vger.kernel.org>; Wed, 15 Mar 2023 01:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678868771;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TC3rldRNm5eO74uJmpE/T/ebrIYv4yHqTDnYGSwXSOM=;
        b=Zx6sw1h3D1LhqigtTfl0QQfrXB43b0GmWvX91tg+rxo838PFiq9K/EACyd0eqk0Zuy
         UJt1QTlE0E+mdke9bopQ8J/tCw4kgDduu8bmdjKiMeodz5UsA75DIAwSGTtcOGnaoIiA
         LTQS3e8JbYhD5Eli1j5ShX+PuzRsbcpc91/ibZEfqqnE3E5MQMcx4MI86wZOe3OpBN45
         ikCAP9iAqodAs239n7te+w5fOyFX68Z+BKrvw8HnK79EtcWh6QHHPgPZ9oNOloEO01w0
         OEzF08eFmcupKgrnIkg+Xj4Td8CB9tgIN5zEdNEG8r+Vy15zUuJVu6ScYCYt7NARPFW3
         YA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678868771;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TC3rldRNm5eO74uJmpE/T/ebrIYv4yHqTDnYGSwXSOM=;
        b=3HHJ33PsNKBRGYPQB8jqaHRYAVWHzs+KH5qO9juosix/ZwxOE+QM/8svqq+AHJVKEi
         IcExO6F7N76Bg7aHVKRvObGctdjxTDf1++YWRlA/vb73WHLMulbgZ+I/WiNgiBFxqq0E
         zbyV/PS6hfhXJyeZjQblgcEA6bugoVBw++jr1271yCawzRMptA2n2IvRxpPauKQwfrLv
         BCTaMaDypcD1sleAfSQdjI0H1o69OAP80fGo3KDnbKPE0Szr5ngg1SeSIMo0mjF9X/bj
         KUVs7eFxb6cNYb9LMIrlLNaPMH0SNNv0cJHOJ0FSTw4oppzBfmlZg/N3nwIj50lk8Ss9
         4dQg==
X-Gm-Message-State: AO0yUKVH/V2ULBXlrB9koezm1n1VcmGYBqJ720Hr1cOXGYAqfk8C/qx3
        p5tdqPY3D4kP893FnGLQFfixLpvbdJx4TfIgfAM=
X-Google-Smtp-Source: AK7set//+Jj2HPnT4roLK80WHBBV0WNqmLCiDjgiyZJ0w+O7LLcyl6mik71pxVmkC+sVzqwQEMIUSYWobuHM1xkxC9A=
X-Received: by 2002:a2e:b521:0:b0:295:945d:b381 with SMTP id
 z1-20020a2eb521000000b00295945db381mr581581ljm.7.1678868771395; Wed, 15 Mar
 2023 01:26:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:50d1:0:b0:194:30fc:eb28 with HTTP; Wed, 15 Mar 2023
 01:26:10 -0700 (PDT)
Reply-To: paulsonjessica399@gmail.com
From:   Jessica Paulson <sarahritterhouse244@gmail.com>
Date:   Wed, 15 Mar 2023 08:26:10 +0000
Message-ID: <CAE4kOAbFbiabArrHnsKnbFF8kkREZfUUPPYmjMUOET1uKCvHtA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:231 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5536]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sarahritterhouse244[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sarahritterhouse244[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [paulsonjessica399[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello, I'm Jessica, from the United States, I what to share ideas.
