Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82FB776193
	for <lists+linux-iio@lfdr.de>; Wed,  9 Aug 2023 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjHINsb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Aug 2023 09:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHINsb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Aug 2023 09:48:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69FD1982;
        Wed,  9 Aug 2023 06:48:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686c06b806cso4657096b3a.2;
        Wed, 09 Aug 2023 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691588910; x=1692193710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvbh4jU+1cEbN3wltBsq4nP/sZCDdeE9099yewO8Uxo=;
        b=Pt0XsrqicbrE3/dUyGuuGfvISLRjCh6DxzUcuL/5QWqsQk4qMOpJ+Q4oEQdPtHpRrT
         wIajdhY3FtBvgsz/o+EkUztjFBKuTE1S0jamB/tagD/ZMjsLdyntEPF7ekERi2HsVTGY
         VX+QLP2dT4RuvZfdDUJBm/6nLCAghGg4x3P+fRX+q5crq9tj3SZzwFNydOOPS1Bn4QzR
         7ZVqunCPl56zphmjJnHCsO06RsxcFIK4K1gZVg74qSCCjQoomgBnTCzFTS0AKhLOTUY9
         3jQmxvOanC6X5qE/S/kKh6BH5+dk9pKhp5jBMT7dG/IQnbBLadWwe7XhqSY9jtOrOXv7
         Y9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691588910; x=1692193710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rvbh4jU+1cEbN3wltBsq4nP/sZCDdeE9099yewO8Uxo=;
        b=hmrZOFf62+FcPRHF7xeZGt6au58I3pC8Aif95zwoMN3c8c4jEvgNSlJXu4ZoC3w2It
         A8WLWjoHYp+rDX+L4+cw19H3Yv7w/zUWwE/hcOZAtqZv0tC6QESHPZ/ysn3tZXQkd/Va
         nMl0U0Ex0TymT600AS7EPvtwiJFgWvE1xPkLXBOPOorIuVAEqZMihsA8+WVz5a7nkVx9
         yy8Mts7VFze7vOMlVahqFW7DIiASxaKCMO/BlryJd4gfv4bYFX5qINpuc3jW0Goos7n2
         mCDAoP4Bm9LZ1IYgReEYaFM2VIP+FSAXQs1dHmVyWJKx5J/7dg6dN09mwOKaO/GPdtxH
         jw4Q==
X-Gm-Message-State: AOJu0Ywvo9+WPawKPnCs64Mk2kGi0MYta4CltMP45FT422p9wAfe4D2h
        jEL0UOlOZ9SXVxqioKFxoEsiiqO6NMR6HA==
X-Google-Smtp-Source: AGHT+IE/AsLrl9c8r6ucjaJHj8/CwCnrQDkP6935GcZelSVkALFgLETBrpSeYYUeBDLSR/vZ5og1Dw==
X-Received: by 2002:a05:6a20:54a1:b0:126:9081:2156 with SMTP id i33-20020a056a2054a100b0012690812156mr2962837pzk.4.1691588910128;
        Wed, 09 Aug 2023 06:48:30 -0700 (PDT)
Received: from localhost.localdomain ([120.88.183.85])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b001bbcf43e120sm11191169plb.95.2023.08.09.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:48:29 -0700 (PDT)
From:   Mighty <bavishimithil@gmail.com>
To:     linus.walleij@linaro.org
Cc:     jic23@kernel.org, lars@metafoo.de, liambeguin@gmail.com,
        linux-iio@vger.kernel.org, peda@axentia.se, stable@vger.kernel.org
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
Date:   Wed,  9 Aug 2023 19:13:37 +0530
Message-Id: <20230809134337.28224-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220524075448.140238-1-linus.walleij@linaro.org>
References: <20220524075448.140238-1-linus.walleij@linaro.org>
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

> The current code "mostly works" because we have not run into
> systems supporting only raw but not scale or only scale but not
> raw, and I doubt there are few using the rescaler on anything
> such, but let's fix the logic.

This does break the logic for twl6030/6032 boards as the seem to only have only raw and processed masks[1]. What would a probable solution for it be, to modify the twl gpadc to include scale+raw or just revert back to the OR?

[1] https://github.com/torvalds/linux/blob/master/drivers/iio/adc/twl6030-gpadc.c#L808-L840

Mithil
