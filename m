Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9225E776665
	for <lists+linux-iio@lfdr.de>; Wed,  9 Aug 2023 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjHIRXn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Aug 2023 13:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjHIRXg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Aug 2023 13:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66263213D
        for <linux-iio@vger.kernel.org>; Wed,  9 Aug 2023 10:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04C856429A
        for <linux-iio@vger.kernel.org>; Wed,  9 Aug 2023 17:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4AAC433C7
        for <linux-iio@vger.kernel.org>; Wed,  9 Aug 2023 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691601812;
        bh=FMCprB/ojPprCnwZ/DiyG/UMeZscnVkt2wucRuRx6O8=;
        h=Date:From:To:Subject:From;
        b=dV45+jlCfLvPeqw+XybIPqI5DkV7uE56FMrHoBDIYIVmkxcQy6KyoR3c0McEZY29N
         vHHWkjsZ6/lBt48Lg5gQa9EhtYYuGbaG+ctoXNYsNXwbpkjPMNXL5m+mYpf/Oyk4Jr
         Xfxi5oGI5ZrjOw5DmSLDUqhibNmph1aYSzpR3qBd5eBnp09frCsz8nEk2sVMyMQF3f
         6co7XaPGWzGEKn8v2J1kzK5IJ4Ph1ITViwoP+uC8s+QQs7Z8lQ9C4jw/QqKL6rBXeL
         AtgW2mNULs7kd9V+Ter3GmykBTm/g2L1v3tH1vBEYsZCHF4qMJesmyItknE7jY21HJ
         LiVkhQzJiNOnQ==
Date:   Wed, 9 Aug 2023 18:23:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Subject: IIO this cycle.
Message-ID: <20230809182331.18c259c5@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

I'm going to be travelling without a laptop next week so won't be sending
my usual last minute second pull request to pick up the stuff that just
squeaked over the line time wise.

As such I'm sorry to say the IIO tree is effectively closed for the 6.6
merge window a week early as I won't be back online until after rc7.

I might queue up a few things over next few days but, with the exception
of fixes, they will be targeting the 6.7 cycle.

Thanks,

Jonathan
