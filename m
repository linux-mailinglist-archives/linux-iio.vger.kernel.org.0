Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D695D79A275
	for <lists+linux-iio@lfdr.de>; Mon, 11 Sep 2023 06:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjIKEbr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Sep 2023 00:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjIKEbp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Sep 2023 00:31:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FD310D
        for <linux-iio@vger.kernel.org>; Sun, 10 Sep 2023 21:31:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27C7EC433C8;
        Mon, 11 Sep 2023 04:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694406700;
        bh=hCZNy5nnJJEKpjdwvb3ZA53uXt3DRe1CFgiAoexjyDM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nHybS8EDNBwHjDkmigXeTZfu8QY/IR3YRVDPwsR4HxiWQP2pJ+S94qPrYB2RnlFGe
         GFIOddV0VTlAWQ+CCi3X0Sh7m5ckn5AJs813IiMx3gxY+np+AlT9cfw8PM+KHlWtY4
         rZzyevqUfy41q8cGUvIvfRlNppYKhiK1NyxYidhQ3i0c6r3RXu38LnQOSE4kxagWlR
         gS1higVCMfbe2lwIq8lYol62fJX1WObZlvOnl/+i7GDwwoSVNycfRt6HKehi8gMp8V
         d5TEitR2YeFgEeoY4v4oOSnep+nDiqO2fM077tSBgSdw04BbE2LJpZYw8+QI2Y0Oyz
         +Hfb1TgEPtssw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1066EC64459;
        Mon, 11 Sep 2023 04:31:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] iio: cros_ec: Fix the allocation size for cros_ec_command
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169440670006.22573.13274283826527276324.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 04:31:40 +0000
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
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


