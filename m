Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA25782EAE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Aug 2023 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjHUQpW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Aug 2023 12:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjHUQpV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Aug 2023 12:45:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68EACC;
        Mon, 21 Aug 2023 09:45:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf078d5f33so27361845ad.3;
        Mon, 21 Aug 2023 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692636319; x=1693241119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdM56TQugKolVtnM2vEBlZtwTSJbtDlseuSS2vjAiNU=;
        b=XLiBAsc1D8k9fk5Nqbc/co6XUtWiAXl3AFWSCbrw8cwf3OvXMxnqiFslUIvmK8NyXN
         uDVHyghAWy+dO3nPPtBJepy9Wn6MYyPg+bMVSfx5VJkplCoy4NwqeMYWbp8dUzEWBPzA
         O5qQBW/qz6YrELx0gGwB+WtwOwo99A4gxcWjHWqZ7NlASbELgVxS3J1olhCaLuw0/Bms
         lTIqKA5D65JU7b/Ex8INBKUdh0yQOfBtChTTbswgWFsz+nsh6+eFnbhfiXOrX0incVAJ
         7NthDaVEae3jRn0z1+EBRAaLmTr9NcWR4Qi3wJN0z2P6I9RWbIZneknUAfEpb/WLbBEh
         tNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636319; x=1693241119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdM56TQugKolVtnM2vEBlZtwTSJbtDlseuSS2vjAiNU=;
        b=da/6gePj6cHh7Jw3DCjndwG8EiPZnZgSbIW+lvX+cz4+aNY5V5W/vcUH+7v4pvQowX
         5wbLxAvkzEFk8kPOSx9C+JT/gg9XNo6WPgd8ARk13hXg/17bFRuysm7K2qy4+OtoXA5a
         AETuORetNc63paZ7CBx8SpArmSkU3okSHqt5WNhcxdShGMtobhb/Gh7b0a1uAt/XV1bn
         D9Y8kYAidxKR6BntUxOqW5JVp8LpMILNnl8DpZ0CWTgVsD7OkjTj7/DL/xlZWJfK3UGG
         q2f9ycS7AJVHBqpjgrFOox2sf/cYAgtwtc3aHIG2V2eq1yHLRa/MVV5CGdZ9vA/BZoDK
         H24g==
X-Gm-Message-State: AOJu0YxjM5IK4LuLUWFDfO8P1m+A3MDsejzAoAp61JbTeUUntVHOM3Ce
        smrlJzPp1aaFrj2codm9OVV533JDYAnOBA==
X-Google-Smtp-Source: AGHT+IHP+eJce60nwuTZdhY6fkcRYe7A8x1KzzfzpRnwTBKR3XZ0ZVNPt8aKjaosjl07R3zDcS7mQA==
X-Received: by 2002:a17:902:e54f:b0:1bc:61d6:5fcc with SMTP id n15-20020a170902e54f00b001bc61d65fccmr9007318plf.51.1692636319132;
        Mon, 21 Aug 2023 09:45:19 -0700 (PDT)
Received: from localhost.localdomain ([103.14.183.220])
        by smtp.gmail.com with ESMTPSA id m15-20020a170902bb8f00b001b89466a5f4sm3809019pls.105.2023.08.21.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 09:45:18 -0700 (PDT)
From:   Mighty <bavishimithil@gmail.com>
To:     linus.walleij@linaro.org
Cc:     bavishimithil@gmail.com, jic23@kernel.org, lars@metafoo.de,
        liambeguin@gmail.com, linux-iio@vger.kernel.org, peda@axentia.se,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
Date:   Mon, 21 Aug 2023 22:15:09 +0530
Message-Id: <20230821164509.45-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACRpkdah22hgM6VruErJedWM7apAuO7BGdFeSz4Hz0c2Nx3kjg@mail.gmail.com>
References: <CACRpkdah22hgM6VruErJedWM7apAuO7BGdFeSz4Hz0c2Nx3kjg@mail.gmail.com>
MIME-Version: 1.0
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

> How does it break it?
>
> It's a change to the AFE rescaler driver so it can't really "break"
> twl6030-gpadc.

Not necessarily the gpadc, but it breaks my current-sense-shunt which requires an adc channel for it to work, since the iio-rescale driver wont recognise the channel (as it only is IIO_CHAN_INFO_RAW, so the && breaks)

> Isn't the complete picture involving some device tree using the prescaler
> etc?

I'm not sure I understand that, could you explain it, maybe with some example as well?

Mithil
