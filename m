Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA78B79A293
	for <lists+linux-iio@lfdr.de>; Mon, 11 Sep 2023 06:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjIKEtF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Sep 2023 00:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIKEtF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Sep 2023 00:49:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF977F3
        for <linux-iio@vger.kernel.org>; Sun, 10 Sep 2023 21:49:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 381B6C433C9;
        Mon, 11 Sep 2023 04:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694407740;
        bh=k/bNi/wtdyxwTWNBDji8wt1vn0oeEotNhCNoMtybfaQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YV/ZXBdXjcjmEC3+xTUZmJVdpi9v3HzazWfeMfa0JuauXfk99Ox0gNDAZFnEZx678
         XyH5HQhZ5ClXhwqhVPgUWdPYgfnfDsQRbg7J27e24Cbql5wx4S27UhjMD5KvTS5b36
         6mvlvWppdOXqwa44EIHaQdMp1+6MgRa9IVcheIlaMTYGN1Tpk7RxUqSzEpGYElwkMd
         A4q3qkTp6rK+xv1vuOU216pMEwTQKbQkpJPYT7n5kXK/F6SJ0fWq+IOHecTORUm1Vg
         +m/ZDpt38pc+H3x+O5EBJIuJCA7TqJa7zbhGBkc5X7q3ZSiy0T0iDSZPVsSvIvJbL6
         mrVWq7r9Q2A9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F080C64459;
        Mon, 11 Sep 2023 04:49:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] iio: cros_ec: Fix the allocation size for cros_ec_command
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169440774012.22573.2546469868468555437.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 04:49:00 +0000
References: <20230630143719.1513906-1-yguoaz@gmail.com>
In-Reply-To: <20230630143719.1513906-1-yguoaz@gmail.com>
To:     yguoaz <yguoaz@gmail.com>
Cc:     tzungbi@kernel.org, jic23@kernel.org, lars@metafoo.de,
        bleung@chromium.org, groeck@google.com, dianders@chromium.org,
        mazziesaccount@gmail.com, gwendal@chromium.org,
        linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Jonathan Cameron <Jonathan.Cameron@huawei.com>:

On Fri, 30 Jun 2023 22:37:19 +0800 you wrote:
> The struct cros_ec_command contains several integer fields and a
> trailing array. An allocation size neglecting the integer fields can
> lead to buffer overrun.
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v3] iio: cros_ec: Fix the allocation size for cros_ec_command
    https://git.kernel.org/chrome-platform/c/8a4629055ef5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


