Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A107797AD
	for <lists+linux-iio@lfdr.de>; Fri, 11 Aug 2023 21:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjHKTYI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Aug 2023 15:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHKTYI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2023 15:24:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DECC30DA
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 12:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3188767948
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 19:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42672C433C7;
        Fri, 11 Aug 2023 19:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691781846;
        bh=Fip9J2WEWJU3yQvO78miWd3Ek2T+Zn32lZN0KTq5A/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNFo1LtpDzuIMCcIVr8Jy5xgcgPjupUyxdrQhm3pHann985r903tvJczxGSSUgb4d
         arYm4zfh148hLfCQXdSrMoMhxQgRLeqBE5iiKU40Xi54sL59+mIjyS90pL5Jygc5bU
         wc3NsP4FJEm/Bk4Rq1J0GNSPS3+ZPhOHQKt/+iGM=
Date:   Fri, 11 Aug 2023 21:23:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of new device support, features and cleanup
 for 6.6
Message-ID: <2023081118-wound-transpose-00de@gregkh>
References: <20230809181935.7cbdb77a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809181935.7cbdb77a@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 09, 2023 at 06:19:35PM +0100, Jonathan Cameron wrote:
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> 
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.6a

Pulled and pushed out, thanks.

greg k-h
