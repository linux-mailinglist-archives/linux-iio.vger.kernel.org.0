Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7315BBF2B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIRRll (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 13:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRRlk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 13:41:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5E6120B4
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 10:41:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35D6C60B63
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 17:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6036EC433D6;
        Sun, 18 Sep 2022 17:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663522898;
        bh=rWUsn1xYTASHv/B9P3PyZmAfhXnQIDgTo8nPyqZEhNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=APD6Ln3mDjWg7u8IN+BTKKmJMlqjGzzVhvic8v/00cQ8f9d9JD5QXI8ahjkQhzfQI
         mOndoi8ckg6UBeeaWxvfZyNmYdzbf/Af/caHmKE1OkHnjUrO3MZsQo1dhNTjNyrVsn
         hfsfUUwSo72l43gRT2PgNdwhq/bfUrpVvcznAv28Q5dG/2RM0v7iu2/i10yoLV4Ej4
         XrzDWxGznuMpV+K4OQvBAvLxV+8AgeUfSF5w63MXMc19QOoaFrsRCBDcvYqAVBncNj
         ryXwyJrYp8KUik83v/QAtvEzRRMsRBQeseBAoQjwxyrCL36ZRLxgUit5KwD1+ZqwDB
         x+teDNkiV8epQ==
Date:   Sun, 18 Sep 2022 18:41:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/6] iio: accel: bmi088: Use
 EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS() and pm_ptr()
Message-ID: <20220918184142.4c60edfd@jic23-huawei>
In-Reply-To: <20220807185618.1038812-6-jic23@kernel.org>
References: <20220807185618.1038812-1-jic23@kernel.org>
        <20220807185618.1038812-6-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  7 Aug 2022 19:56:17 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These macros allow the compiler to remove unused pm ops functions without
> needing to mark them maybe unused.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> Cc: Mike Looijmans <mike.looijmans@topic.nl>
>
Applied.
