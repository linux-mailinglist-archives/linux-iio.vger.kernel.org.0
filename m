Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC78859B58A
	for <lists+linux-iio@lfdr.de>; Sun, 21 Aug 2022 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiHUQ6H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Aug 2022 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHUQ6H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2022 12:58:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FA41D31C
        for <linux-iio@vger.kernel.org>; Sun, 21 Aug 2022 09:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 145CCB80BED
        for <linux-iio@vger.kernel.org>; Sun, 21 Aug 2022 16:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7057C433C1;
        Sun, 21 Aug 2022 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661101080;
        bh=omr47oubR0fcEFPnH9MHhmIr66VPQN3eizZq03Y1bm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cyh1RYPVua0uUTc+pvcSU1ic1MZp73cCIXPF2P8DG0312VFIS8ZFNxm6OCcZ/i3Cw
         y5ciOHXAu4gwm6x6ld+pOW+/917ZOJLvQ88v+ODITgI3ApkfKCCs0L+GSpe9C34/0Z
         A/AXOan1opv64rAj4YkYxLnwxA6aJms84f6HAkO9wtstNmbABlTnIxappkNpQr+SWU
         0drTOgV8D9G2h6jTMVshNNNcLI4iYKTh8TmnQo8EB5LLmICYeWrbKy7YtKeH8X2GDk
         +Wj8bnlqp68u3VC7i51XGb7PlpiqRZsJPjgbjuzekE+5nQPmuM1SVUCHZ3LO3QQBnb
         B64VcIcBgYJcg==
Date:   Sun, 21 Aug 2022 17:23:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: consumer: Mark struct iio_channel parameter to
 iio_get_channel_type() const
Message-ID: <20220821172331.02a85db1@jic23-huawei>
In-Reply-To: <20220821162017.2207710-1-jic23@kernel.org>
References: <20220821162017.2207710-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Aug 2022 17:20:17 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This accessor is only reading data via this pointer, so make the fact
> it is const explicit.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Finger fumble - please ignore.

Managed to pick up content of a different series in a trivial patch.
