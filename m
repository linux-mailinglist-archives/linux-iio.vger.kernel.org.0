Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8147559D9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jul 2023 05:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGQDJQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jul 2023 23:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGQDJP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jul 2023 23:09:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72975E4B
        for <linux-iio@vger.kernel.org>; Sun, 16 Jul 2023 20:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDB1360EF8
        for <linux-iio@vger.kernel.org>; Mon, 17 Jul 2023 03:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECB9C433C8;
        Mon, 17 Jul 2023 03:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689563352;
        bh=DRxqjjbEkd/2HTqyHGAyPCFDb21N1UMH/n+hpkxyWrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1RNPQnupP9IortcyB4NzYXQ76wS8Gx5mLXQFMJjQQrCBKkU7M8H3QL6bciBXVpsr
         S7KlZDXH2dj4zVmIY4WBOpvlogveO8eZxLex7Ypwfhs8yoQIlPwSfUY5ygaIlLUaj0
         2AKNVvG3Aaf63yUm/n0l6OsyqQeecGaBvelnUFqYn/8Di8KEUg6lP2YJBpaRhJMo9H
         zS6ubp9ORpMVoG1XrDW1Q8G7VN+5OKdWe2r2YadNSO2j+Ca6MpqarTiZlFuoNf3eUt
         LjxHGHqhht7o1rFH9e7EAPL8LH0nrgqd5hcmkq11e4nc4Fgf++F9yFXP1aGbTbA4/L
         H83R0mYWWCLxw==
Date:   Mon, 17 Jul 2023 11:09:08 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Yiyuan Guo <yguoaz@gmail.com>, lars@metafoo.de,
        bleung@chromium.org, groeck@google.com, dianders@chromium.org,
        mazziesaccount@gmail.com, gwendal@chromium.org,
        linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3] iio: cros_ec: Fix the allocation size for
 cros_ec_command
Message-ID: <ZLSw1FxccNOqE52C@google.com>
References: <20230630143719.1513906-1-yguoaz@gmail.com>
 <20230716141028.4c57c5c7@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716141028.4c57c5c7@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 16, 2023 at 02:10:28PM +0100, Jonathan Cameron wrote:
[...]
> 2) Various people commented on earlier versions, and I'm waiting for them to confirm
> they are fine with this version.

The version addressed all my comments and LGTM.
