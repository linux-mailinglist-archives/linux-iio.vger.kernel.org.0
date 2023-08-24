Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289127868BF
	for <lists+linux-iio@lfdr.de>; Thu, 24 Aug 2023 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjHXHl0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Aug 2023 03:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbjHXHlM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Aug 2023 03:41:12 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4FC19BA;
        Thu, 24 Aug 2023 00:40:45 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1c50438636fso4112023fac.1;
        Thu, 24 Aug 2023 00:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692862784; x=1693467584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n/0lQ9X/JrpEk2281pTL+VBdCVP7hveKwT7KHv5l4g=;
        b=L51BCBkP4bsz7FEAw8rwbVt8CK54nOtF7ZrYhafNdJaBNCCDS8xf/zYLd+o5XxYBib
         YEhyC/EwtGE2l8IbdT5uPQ0KrpwxPMm1gYqfUbqK9SnZtsJwx49IXmIxeHIay2U1HmYC
         kae6tTq++7FlH+mHXhpZoaTkIuYIQonlRlCAXSBmjn19K6EKAKPKM+dzTRzKpVnEq/NS
         70XNPsibaTw7XATwJ/xk3FLb+rDKrbj89tuEvJV6yclqsTvmKnGB4KCjoMsvqTFuWENW
         p6734jhKV9whb5qfh1JxLD9B2HZ1djDZnxqqQQ75QOZW6rWw4m7phcRTGlP+Q+5V5a93
         n+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692862784; x=1693467584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n/0lQ9X/JrpEk2281pTL+VBdCVP7hveKwT7KHv5l4g=;
        b=FbjTr5CjybOvO7WJQN8XBOrN2H9ZDkArGBWwl2D3TWfkqseNmAPH+3BWFFquHsGUdS
         MJm7Nz7LJL7giLHyJMHdXg6TGI1A8dT7NsGxK0hHBfPJnoVU2irbJZY32OqFegtuYrS3
         Ri2X9+wAPb/aXjOYKiYspWzjVaB4GugOZcpF24g8Ppk5lhuSJiKiBsPYiUdy2q/FBc/J
         vYzFEpeAo1ek6CfjuMuWdwaEhPuX/Mv0j2YtuUPJ7ePkKiY9qilBC1vZYuEHQxaM+rEV
         5Mu1Bi3Q07SEjyNnOXgWR2dgB5kfU0e5taJlJQF+ESN+Az1i7OOoF+YOlIKVQXCC178y
         1xjA==
X-Gm-Message-State: AOJu0YyzFPtoPX1ULHQ4lrd3S6iCTdsgbyWa0Swu/0/TBfnl1edccuUP
        1YKXAyps0QeswTNeyEs3qYY=
X-Google-Smtp-Source: AGHT+IGM6e9v42ABX1o0PuElzRCn6NpeKSgre4o6v4s9TY4LpzAmv6PoFEkP+cOWBTRMfNq0f+PRGQ==
X-Received: by 2002:a05:6870:ec8a:b0:1ba:9a49:d967 with SMTP id eo10-20020a056870ec8a00b001ba9a49d967mr17920209oab.23.1692862783844;
        Thu, 24 Aug 2023 00:39:43 -0700 (PDT)
Received: from localhost.localdomain ([103.14.183.69])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78652000000b00666e649ca46sm6967322pfo.101.2023.08.24.00.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 00:39:43 -0700 (PDT)
From:   Mighty <bavishimithil@gmail.com>
To:     linus.walleij@linaro.org
Cc:     bavishimithil@gmail.com, jic23@kernel.org, lars@metafoo.de,
        liambeguin@gmail.com, linux-iio@vger.kernel.org, peda@axentia.se,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
Date:   Thu, 24 Aug 2023 13:09:33 +0530
Message-Id: <20230824073933.80-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACRpkdZn3MePSohFU7AzVtzdaKW=edsw14Y42xbScXNBVZDOjA@mail.gmail.com>
References: <CACRpkdZn3MePSohFU7AzVtzdaKW=edsw14Y42xbScXNBVZDOjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 23, 2023 at 1:51 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> OK so twl6030 is providing some channels with IIO_CHAN_INFO_RAW
> without IIO_CHAN_INFO_SCALE.

Exactly, checking the driver there doesnt seem to be any scaler used. The two functions to read raw[1] and processed[2] are quite simple, with processed using the raw function as well. Since there is no mention of SCALE, could I just patch that in with the RAW, it wouldnt change anything in the driver (the driver has cases for RAW and PROCESSED only) and would fix the issue at hand as well.

> Say the raw value is 100, then 100 what? Microvolts?

I'd assume Volts, I couldnt find a datasheet for TWL6032 hence the assumption based on code https://github.com/torvalds/linux/blob/master/drivers/iio/adc/twl6030-gpadc.c#L504.

> patch the twl6030 driver to convert all IIO_CHAN_INFO_RAW to IIO_CHAN_INFO_PROCESSED.

That would break the case here https://github.com/torvalds/linux/blob/master/drivers/iio/adc/twl6030-gpadc.c#L541 hence I think we just comply to adding scale as well, even though it would be 1:1?
There is this https://github.com/torvalds/linux/blob/master/drivers/iio/adc/twl6030-gpadc.c#L447 but I'm not very sure about how it changes the scale.

[1] https://github.com/torvalds/linux/blob/master/drivers/iio/adc/twl6030-gpadc.c#L462
[2] https://github.com/torvalds/linux/blob/master/drivers/iio/adc/twl6030-gpadc.c#L487

Mithil
