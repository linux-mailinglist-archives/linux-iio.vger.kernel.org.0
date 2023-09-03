Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06FF790D2A
	for <lists+linux-iio@lfdr.de>; Sun,  3 Sep 2023 19:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjICRMo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Sep 2023 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbjICRMo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2023 13:12:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D34E6;
        Sun,  3 Sep 2023 10:12:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-271d9823cacso501762a91.1;
        Sun, 03 Sep 2023 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693761066; x=1694365866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX0pKdbFNYmrphq/Y+iw4HhYl8nlpe+5IYFf/BgP23o=;
        b=sebHnCOt8AeqgKYJF0dYR1fKV6jCa43DzW7OIRTIMZK2Q8+uPjbYhI2mwlf4YG4yul
         tubtx66FSj7NU29ulObCMLFMyE/VDM3ng6JRGJFRqQCX4kl8nUNeEvEstBArw2eAwPIR
         odTdxGB9MwZN3pG5Dud+ne2479+5W+g6zhqbfWp1oF4dxNUtGav1hmFCtn5ODahnxM6o
         0PtGzxJSfDu4LfAWEhx0GMAsTdUXto9ZncC84BSXC9Drm1eOpUGb2Ik4SAPlJ7c3He9O
         31p+LLnEEsrDbkpQhNrJXlIPSi/AIJCnvk/cj2aEhgZnIZIy8nMEuKO2bBDjXrSfi6nv
         AASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693761066; x=1694365866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XX0pKdbFNYmrphq/Y+iw4HhYl8nlpe+5IYFf/BgP23o=;
        b=VgF7XZkfhSWS/J/SD0d0GvmIFokxwbR4n7CXVo4FdetL7nPrAkAIXonUT3t1dQWfFd
         8ni82mtBqo5WLC3tzgv1v2bqWNEfIeF/E/eCJFkqhZ/q7f6E7h536uGkFI6ff/6+m0u6
         Ta1sri6E7U0VK0I+ihkNMFn8ambOQKueBjVRYiZD7rNzUeqEpjBXB6X8XoWAV/lFDUe+
         frs3LkMRPWddLUVkTorrxW+O24ZWOdk+6ma4jYcvn7TqtjmlSfN6QHN5+OKz9WKVjhHr
         GQRG8D2bULoYoZCMxQy/qlr4+SvsLxvz9+gl8VkqYzNEQRzqgk5w6bBp3boA9SSrDHnG
         QQhA==
X-Gm-Message-State: AOJu0YwpTCiNHeQGs/MYj2I27xXPoYE3vI9HuKrhr1TNUyWT75ShVpCo
        yB8IT+hWD1wrYe3S97lAnxw=
X-Google-Smtp-Source: AGHT+IFM6jA27tJZk09oV9DngEq0ZF+qktQvLv6yc0sqanWrvukx7JJTil6ebabMYxwo/YiL+sDQ0Q==
X-Received: by 2002:a17:90a:b945:b0:26d:2fe5:ff2a with SMTP id f5-20020a17090ab94500b0026d2fe5ff2amr7083732pjw.29.1693761065520;
        Sun, 03 Sep 2023 10:11:05 -0700 (PDT)
Received: from localhost.localdomain ([45.64.12.149])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a01ce00b00263dfe9b972sm8387926pjd.0.2023.09.03.10.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 10:11:04 -0700 (PDT)
From:   Mighty <bavishimithil@gmail.com>
To:     linus.walleij@linaro.org
Cc:     bavishimithil@gmail.com, jic23@kernel.org, lars@metafoo.de,
        liambeguin@gmail.com, linux-iio@vger.kernel.org, peda@axentia.se,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
Date:   Sun,  3 Sep 2023 22:40:56 +0530
Message-Id: <20230903171056.41-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACRpkdYtXAWDcAMRJxh5YbNKmrYurH=z0pR47bftc+u1Yt4Nig@mail.gmail.com>
References: <CACRpkdYtXAWDcAMRJxh5YbNKmrYurH=z0pR47bftc+u1Yt4Nig@mail.gmail.com>
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

On Thu, Aug 24, 2023 at 1:54 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> Seems reasonable to me!
I'd say I send a patch to the mailing list and see the response, I'm not very experienced with this device. The inputs of other people who worked on this driver would guide me in the right way then i guess.

> That looks like the channel is actually processed, not raw, right?
> i.e. that should only be done on channels marked as processed.

Yeah the raw channel function does call a correction function in some cases, not very sure why. https://github.com/torvalds/linux/blob/master/drivers/iio/adc/twl6030-gpadc.c#L480
In the end the processed function also calls the raw function again dont know why, https://github.com/torvalds/linux/blob/master/drivers/iio/adc/twl6030-gpadc.c#L496. But in any case there is no mention of the scale attribute, so to make it comply with the condition I dont see an issue adding it to the properties

Regards,
Mithil

